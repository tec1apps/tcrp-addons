#!/bin/sh
#
# install redpill tcrp modules
#

function getvars() {
TARGET_PLATFORM="$(uname -u | cut -d '_' -f2)"
LINUX_VER="$(uname -r | cut -d '+' -f1)"
}

function prepare_eudev() {
echo "Copying kmod,tar to /bin/"
/bin/cp -v kmod  /bin/       ; chmod 700 /bin/kmod
#/bin/cp -v tar  /bin/        ; chmod 700 /bin/tar
echo "link depmod to kmod"
ln -s /bin/kmod /usr/sbin/depmod
echo "Extracting modules"
tar xfz /exts/all-modules/${TARGET_PLATFORM}-${LINUX_VER}.tgz -C /lib/modules/
mkdir /lib/firmware
echo "Extracting firmware"
tar xfz /exts/all-modules/firmware.tgz -C /lib/firmware/
/usr/sbin/depmod -a
}

getvars
prepare_eudev
