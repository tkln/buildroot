################################################################################
#
# tradfrid
#
################################################################################

TRADFRID_VERSION = v0.0
TRADFRID_SITE = $(call github,tkln,tradfrid,$(TRADFRID_VERSION))
TRADFRID_LICENSE = MIT

TRADFRID_BUILD_TARGETS = cmd/tradfrid cmd/tradfri

TRADFIRD_INSTALL_BINS = tradfrid tradfri

define TRADFRID_INSTALL_INIT_SYSV
	$(INSTALL) -m 755 -D package/tradfrid/S51tradfrid \
		$(TARGET_DIR)/etc/init.d/S51tradfrid
endef

TRADFRID_TAGS = cgo static_build

# Set GO111MODULE=on because I'm not going to spend time trying to package every
# go module in the dependency graph.
HOST_GO_TARGET_ENV = \
    GO111MODULE=on \
    GOARCH=$(GO_GOARCH) \
    GOCACHE="$(HOST_GO_TARGET_CACHE)" \
    GOROOT="$(HOST_GO_ROOT)" \
    CC="$(TARGET_CC)" \
    CXX="$(TARGET_CXX)" \
    GOTOOLDIR="$(HOST_GO_TOOLDIR)"

$(eval $(golang-package))
