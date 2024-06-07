Return-Path: <linux-kernel+bounces-205390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3767B8FFAED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C060A28C5E6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC9314F129;
	Fri,  7 Jun 2024 04:31:41 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6C914F10D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734700; cv=none; b=QtdLTSL+DQ1MT75BBFr9VcHONm7B1l9SRl1ODEGmCs7DLw88ZjUWHmIiSR72/H3P+92giPuOuI4+hGvGB0cBWAwrTlsQ0fgBUHTQHUmzsyaAHWHol+HBb9z8W/in0Vj0efUaO2O2vdYCZCu2c2WzQu7hlCPimQvmY4Y3MsjAgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734700; c=relaxed/simple;
	bh=0Q0Z87Wu9s9cH6gd9RQ+h5gJBz5weOKm2sKYg98nCk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OW2/bhytaK75R2yQ2Oek3VmLQQyIPK4f92QBd9I0xT+bUTxOu4GLo0podLBg1zndpLECStfO3mkHAJUZNhxlwm/3pa2VjgRQ15d9NezANKBVtQrasqUxFEraadMVWYLOFvAkHi3wb3Rv5u4t18bREMlDOePifQKZR2b2sLG4JvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSpw2XJBz1SB2c;
	Fri,  7 Jun 2024 12:27:36 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AD0418007E;
	Fri,  7 Jun 2024 12:31:35 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:46 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 108/110] tests: ubifs_tools: mkfs_tests: Add fs content check test
Date: Fri, 7 Jun 2024 12:26:13 +0800
Message-ID: <20240607042615.2069840-109-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Initialize UBIFS image from a given directory, then check whether the
fs content in mounted UBIFS is consistent with the original directory.
Both UBI volume and file are chosen as storage mediums to test.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 .gitignore                                         |   1 +
 configure.ac                                       |   3 +-
 tests/ubifs_tools-tests/Makemodule.am              |   3 +-
 tests/ubifs_tools-tests/lib/common.sh.in           |   8 +
 .../mkfs_tests/build_fs_from_dir.sh.in             | 174 +++++++++++++++++++++
 5 files changed, 187 insertions(+), 2 deletions(-)
 create mode 100755 tests/ubifs_tools-tests/mkfs_tests/build_fs_from_dir.sh.in

diff --git a/.gitignore b/.gitignore
index 68fff365..ffbde6e5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -121,6 +121,7 @@ tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh
 tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh
 tests/ubifs_tools-tests/fsck_tests/random_corrupted_fsck.sh
 tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh
+tests/ubifs_tools-tests/mkfs_tests/build_fs_from_dir.sh
 
 #
 # Files generated by autotools
diff --git a/configure.ac b/configure.ac
index 35c99bb6..13974090 100644
--- a/configure.ac
+++ b/configure.ac
@@ -297,7 +297,8 @@ AC_CONFIG_FILES([tests/fs-tests/fs_help_all.sh
 	tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh
 	tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh
 	tests/ubifs_tools-tests/fsck_tests/random_corrupted_fsck.sh
-	tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh])
+	tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh
+	tests/ubifs_tools-tests/mkfs_tests/build_fs_from_dir.sh])
 
 AC_OUTPUT([Makefile])
 
diff --git a/tests/ubifs_tools-tests/Makemodule.am b/tests/ubifs_tools-tests/Makemodule.am
index 1d3d0f29..f4d8a073 100644
--- a/tests/ubifs_tools-tests/Makemodule.am
+++ b/tests/ubifs_tools-tests/Makemodule.am
@@ -6,7 +6,8 @@ test_SCRIPTS += \
 	tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh \
 	tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh \
 	tests/ubifs_tools-tests/fsck_tests/random_corrupted_fsck.sh \
-	tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh
+	tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh \
+	tests/ubifs_tools-tests/mkfs_tests/build_fs_from_dir.sh
 
 test_DATA += \
 	tests/ubifs_tools-tests/images/good.gz \
diff --git a/tests/ubifs_tools-tests/lib/common.sh.in b/tests/ubifs_tools-tests/lib/common.sh.in
index a27fe108..8d1b3c03 100755
--- a/tests/ubifs_tools-tests/lib/common.sh.in
+++ b/tests/ubifs_tools-tests/lib/common.sh.in
@@ -8,8 +8,10 @@ UBI_NUM=0
 DEV=/dev/ubi0_0
 MNT=/mnt/test_file_system
 TMP_FILE=/tmp/ubifs_test_file
+TMP_MNT=/tmp/ubifs_tmp_mnt
 LOG_FILE=/tmp/ubifs_log
 KEY_FILE=/tmp/key
+IMG_FILE=ubifs.img
 nandsim_patt="NAND simulator"
 mtdram_patt="mtdram test device"
 
@@ -35,6 +37,8 @@ function cleanup_handler()
 {
 	local ret="$1"
 
+	umount $TMP_MNT >/dev/null 2>&1 ||:
+	rm -rf $TMP_MNT >/dev/null 2>&1 ||:
 	if [ "$ret" == "0" ]; then
 		umount $MNT >/dev/null 2>&1 ||:
 		modprobe -r ubifs >/dev/null 2>&1 ||:
@@ -45,6 +49,7 @@ function cleanup_handler()
 		rm -f $TMP_FILE >/dev/null 2>&1 ||:
 		rm -f $KEY_FILE >/dev/null 2>&1 ||:
 		rm -f $LOG_FILE >/dev/null 2>&1 ||:
+		rm -f $IMG_FILE >/dev/null 2>&1 ||:
 		exit 0
 	else
 		exit 1
@@ -344,6 +349,9 @@ function cancel_io_err()
 if ! [ -d $MNT ]; then
 	mkdir -p $MNT
 fi
+if ! [ -d $TMP_MNT ]; then
+	mkdir -p $TMP_MNT
+fi
 
 modprobe ubi || fatal "common.sh: cannot load ubi"
 modprobe ubifs || fatal "common.sh: cannot load ubifs"
diff --git a/tests/ubifs_tools-tests/mkfs_tests/build_fs_from_dir.sh.in b/tests/ubifs_tools-tests/mkfs_tests/build_fs_from_dir.sh.in
new file mode 100755
index 00000000..0b228562
--- /dev/null
+++ b/tests/ubifs_tools-tests/mkfs_tests/build_fs_from_dir.sh.in
@@ -0,0 +1,174 @@
+#!/bin/sh
+# Copyright (c), 2024, Huawei Technologies Co, Ltd.
+# Author: Zhihao Cheng <chengzhihao1@huawei.com>
+#
+# Test Description:
+# Initialize UBIFS image from a given directory, then check whether the
+# fs content in mounted UBIFS is consistent with the original directory.
+# Both UBI volume and file are chosen as storage mediums to test.
+# Running time: 10min
+
+TESTBINDIR=@TESTBINDIR@
+source $TESTBINDIR/common.sh
+
+function run_test()
+{
+	local simulator="$1";
+	local size="$2";
+	local peb_size="$3";
+	local page_size="$4";
+	local vid_offs=$page_size;
+	local encryption=$5;
+	local test_medium=$6;
+	local space_fix=$7;
+	local need_fsck=$8;
+	local double_mkfs=$9;
+	local leb_size=$(($(($peb_size*1024))-$page_size));
+	VIDHDR_SZ=64;
+
+	option=""
+	if [[ "$space_fix" == "fix_space" ]]; then
+		option="-F"
+	fi
+	echo "======================================================================"
+	printf "%s" "$simulator: ${size}MiB PEB size ${peb_size}KiB"
+	if [ "$simulator" = "mtdram" ]; then
+		page_size=8
+		leb_size=$(($leb_size-$VIDHDR_SZ))
+	else
+		leb_size=$(($leb_size-$page_size))
+	fi
+	printf " %s" "page size ${page_size}Bytes"
+	printf " $encryption $test_medium $space_fix $need_fsck $double_mkfs\n"
+
+	if [ "$simulator" = "nandsim" ]; then
+		$TESTBINDIR/load_nandsim.sh "$size" "$peb_size" "$page_size" || echo "cannot load nandsim";
+		mtdnum="$(find_mtd_device "$nandsim_patt")"
+	elif [ "$simulator" = "mtdram" ]; then
+		load_mtdram "$size" "$peb_size" || echo "cannot load mtdram"
+		mtdnum="$(find_mtd_device "$mtdram_patt")"
+	else
+		fatal "$simulator is not supported"
+	fi
+
+	dmesg -c > /dev/null
+	flash_eraseall /dev/mtd$mtdnum
+	modprobe ubi mtd="$mtdnum,$vid_offs" || fatal "modprobe ubi fail"
+	ubimkvol -N vol_test -m -n 0 /dev/ubi$UBI_NUM || fatal "mkvol fail"
+	modprobe ubifs || fatal "modprobe ubifs fail"
+	if [[ "$encryption" == "encrypted" ]]; then
+		encryption_gen_key
+		option="$option --cipher AES-256-XTS --key $KEY_FILE"
+	fi
+
+	if [[ "$test_medium" == "volume" ]]; then
+		mkfs.ubifs $option -m${page_size} -c 1024 -e $leb_size -f 4 -r $TMP_MNT $DEV
+		if [[ $? != 0 ]]; then
+			fatal "mkfs failed"
+		fi
+		if [[ "$double_mkfs" == "double_format" ]]; then
+			mkfs.ubifs -y $option -m${page_size} -c 1024 -e $leb_size -f 4 -r $TMP_MNT $DEV
+			if [[ $? != 0 ]]; then
+				fatal "mkfs failed"
+			fi
+		fi
+	else
+		mkfs.ubifs $option -m${page_size} -c 1024 -e $leb_size -f 4 -r $TMP_MNT -o $IMG_FILE
+		if [[ $? != 0 ]]; then
+			fatal "mkfs failed"
+		fi
+		ubiupdatevol $DEV $IMG_FILE
+		if [[ $? != 0 ]]; then
+			fatal "ubiupdatevol failed"
+		fi
+	fi
+
+	if [[ "$need_fsck" == "do_fsck" ]]; then
+		fsck.ubifs -a $DEV # 'fsck.ubifs $DEV' is fine too.
+		res=$?
+		if [[ $res != $FSCK_OK ]]
+		then
+			fatal "fsck expects result $FSCK_OK, but $res is returned"
+		fi
+	fi
+
+	enable_chkfs
+
+	mount_ubifs $DEV $MNT "noauthentication" "noatime"
+	res=$?
+	if [[ $res != 0 ]]
+	then
+		fatal "mount fail $res"
+	fi
+
+	if [[ "$encryption" != "encrypted" ]]; then
+		# Check filesystem information, skip encrypted image.
+		# fscryptctl is not compatible with fscryptctl in mtd-utils.
+		# See https://github.com/google/fscryptctl/issues/33
+		du -sh $MNT > /dev/null  # Make sure all files are accessible
+		ret=$?
+		if [[ $ret != 0 ]]; then
+			fatal "Cannot access all files"
+		fi
+
+		parse_dir "md5sum"
+	fi
+
+	check_err_msg
+
+	umount $MNT
+	res=$?
+	if [[ $res != 0 ]]
+	then
+		fatal "unmount fail $res"
+	fi
+
+	check_err_msg
+	disable_chkfs
+
+	if [[ "$test_medium" != "volume" ]]; then
+		rm -f $IMG_FILE
+	fi
+	modprobe -r ubifs
+	modprobe -r ubi
+	modprobe -r $simulator
+
+	echo "----------------------------------------------------------------------"
+}
+
+check_fsstress
+start_t=$(date +%s)
+echo "Do mkfs+fsck+mount test in kinds of flashes"
+mount -t tmpfs -osize=50m  none $TMP_MNT || fatal "cannot mount tmpfs"
+echo 123 > $TMP_MNT/file
+setfattr -n user.xyz -v 123abc $TMP_MNT/file
+fsstress -d $TMP_MNT -l30 -n10 -p4
+# Record filesystem information
+rm -f $TMP_FILE 2>/dev/null
+read_dir $TMP_MNT "md5sum"
+
+# No authentication tests, which needs a specific key from certs directory corresponding to linux source code..
+# See https://patchwork.ozlabs.org/project/linux-mtd/cover/20190806104928.1224-1-s.hauer@pengutronix.de/
+for simulator in "mtdram" "nandsim"; do
+	for encryption in "encrypted" "noencrypted"; do
+		for test_medium in "volume" "file"; do
+			for space_fix in "fix_space" "nofix_space"; do
+				for need_fsck in "do_fsck" "no_fsck"; do
+					for double_mkfs in "double_format" "format_once"; do
+						run_test "$simulator" "64" "64" "2048" $encryption $test_medium $space_fix $need_fsck $double_mkfs
+						run_test "$simulator" "128" "128" "2048" $encryption $test_medium $space_fix $need_fsck $double_mkfs
+						run_test "$simulator" "512" "512" "2048" $encryption $test_medium $space_fix $need_fsck $double_mkfs
+						run_test "$simulator" "1024" "512" "2048" $encryption $test_medium $space_fix $need_fsck $double_mkfs
+					done
+				done
+			done
+		done
+	done
+done
+
+umount $TMP_MNT
+rm -f $TMP_FILE 2>/dev/null
+end_t=$(date +%s)
+time_cost=$(( end_t - start_t ))
+echo "Success, cost $time_cost seconds"
+exit 0
-- 
2.13.6


