Return-Path: <linux-kernel+bounces-205391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263F68FFAEF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9526B28C767
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1443714F9C1;
	Fri,  7 Jun 2024 04:31:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAD14EC7D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734700; cv=none; b=BybtSQE5/IkShIb+uaz7RZu+flVcVySBeKCHAqGBjWpoEH1HwayMsmkdg6Y8ol204SknMMi2gIgzHjCfislwu0KznRkuXlbZqmoWJJY6tRP+OlqFwVqJ5XHyPPwGHXiyXuKiSHkIa60EtuprEr3/BusWSFASQkK42izQNOWRU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734700; c=relaxed/simple;
	bh=Ig5aXA7tPttrb+8QeEwx/vuilocOCeIxIORAqUrzAgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2aKN0VKjyvqopFWu1EMGzaYDIBlyUlfk5nE4rA7m1pIbp9RIf5wOk42d+GESuNAK1ao4ugqCv5a1bD9w1g455yqBLh9pn1duAuMJP4kg2l8dWCQiIo1jvyzsLHnDIWw/YmSqkvCOKKsnTKHgdv64HIpWC8tJgN0WRbhDiu+UMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSss6wBJzdZfp;
	Fri,  7 Jun 2024 12:30:09 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id DB7BD14040F;
	Fri,  7 Jun 2024 12:31:19 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:45 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 107/110] tests: ubifs_tools: fsck_tests: Add bad images fixing test
Date: Fri, 7 Jun 2024 12:26:12 +0800
Message-ID: <20240607042615.2069840-108-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

For kinds of inconsistent UBIFS images(which can simulate corruptions
caused by some potentional UBIFS bug), check the result of fsck.
This testcase mainly checks whether the behavior is in expected after
repairing specific inconsistent UBIFS image.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 .gitignore                                         |   1 +
 configure.ac                                       |   3 +-
 tests/ubifs_tools-tests/Makemodule.am              |   3 +-
 .../fsck_tests/fsck_bad_image.sh.in                | 355 +++++++++++++++++++++
 4 files changed, 360 insertions(+), 2 deletions(-)
 create mode 100755 tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh.in

diff --git a/.gitignore b/.gitignore
index 203f01f0..68fff365 100644
--- a/.gitignore
+++ b/.gitignore
@@ -120,6 +120,7 @@ tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh
 tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh
 tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh
 tests/ubifs_tools-tests/fsck_tests/random_corrupted_fsck.sh
+tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh
 
 #
 # Files generated by autotools
diff --git a/configure.ac b/configure.ac
index 545fcc41..35c99bb6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -296,7 +296,8 @@ AC_CONFIG_FILES([tests/fs-tests/fs_help_all.sh
 	tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh
 	tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh
 	tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh
-	tests/ubifs_tools-tests/fsck_tests/random_corrupted_fsck.sh])
+	tests/ubifs_tools-tests/fsck_tests/random_corrupted_fsck.sh
+	tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh])
 
 AC_OUTPUT([Makefile])
 
diff --git a/tests/ubifs_tools-tests/Makemodule.am b/tests/ubifs_tools-tests/Makemodule.am
index 7ef873ce..1d3d0f29 100644
--- a/tests/ubifs_tools-tests/Makemodule.am
+++ b/tests/ubifs_tools-tests/Makemodule.am
@@ -5,7 +5,8 @@ test_SCRIPTS += \
 	tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh \
 	tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh \
 	tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh \
-	tests/ubifs_tools-tests/fsck_tests/random_corrupted_fsck.sh
+	tests/ubifs_tools-tests/fsck_tests/random_corrupted_fsck.sh \
+	tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh
 
 test_DATA += \
 	tests/ubifs_tools-tests/images/good.gz \
diff --git a/tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh.in b/tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh.in
new file mode 100755
index 00000000..2ba9f789
--- /dev/null
+++ b/tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh.in
@@ -0,0 +1,355 @@
+#!/bin/sh
+# Copyright (c), 2024, Huawei Technologies Co, Ltd.
+# Author: Zhihao Cheng <chengzhihao1@huawei.com>
+#
+# Test Description: Tests whether all inconsistent UBIFS images can be fixed
+# as expected.
+# Origin UBIFS image content:
+# /
+# ├── corrupt_file (xattr - user.corrupt:123, 2K data)
+# ├── dir
+# │   ├── block_dev
+# │   ├── char_dev
+# │   ├── dir
+# │   └── file (content: '123')
+# ├── hardl_corrupt_file => corrupt_file
+# └── softl_corrupt_file -> corrupt_file
+#
+# Running time: 2min
+
+TESTBINDIR=@TESTBINDIR@
+source $TESTBINDIR/common.sh
+
+CORRUPT_FILE=corrupt_file
+CORRUPT_FILE_INUM=INO_65
+XATTR_NAME="user.corrupt"
+XATTR_VAL=123
+CORRUPT_FILE_MD5=7d2f953e91033c743ab6a801d5ee6e15
+SOFT_LINK_FILE=softl_corrupt_file
+HARD_LINK_FILE=hardl_corrupt_file
+DIR=dir
+BLOCK_DEV=block_dev
+CHAR_DEV=char_dev
+FILE=file
+FILE_INUM=INO_72
+FILE_MD5=ba1f2511fc30423bdbb183fe33f3dd0f
+LOST_FOUND="lost+found"
+
+function fsck_image()
+{
+	local img_type=$1;
+	local img=$2;
+	local fsck_mode=$3;
+	local file_exist=$4;
+	local file_nochange=$5
+	local file_xattr_exist=$6;
+	local hard_link_exist=$7;
+	local hard_link_no_change=$8;
+	local hard_link_xattr_exist=$9;
+	local soft_link_exist=${10};
+	local dir_exist=${11};
+	local dir_file_no_change=${12};
+	local lost_found=${13};
+
+	echo "======================================================================"
+	echo "fsck $img_type, success_fsck_mode:$fsck_mode file_exist:$file_exist file_nochange:$file_nochange file_xattr_exist:$file_xattr_exist hard_link_exist:$hard_link_exist hard_link_no_change:$hard_link_no_change:hard_link_xattr_exist $hard_link_xattr_exist:soft_link_exist:$soft_link_exist dir_exist:$dir_exist $lost_found"
+
+	load_mtdram 1 16 || echo "cannot load mtdram"
+	mtdnum="$(find_mtd_device "$mtdram_patt")"
+
+	dmesg -c > /dev/null
+	gzip -f -k -d $TESTBINDIR/${img}.gz || fatal "gzip failed"
+	flash_eraseall /dev/mtd$mtdnum
+	dd if=$TESTBINDIR/$img of=/dev/mtd$mtdnum bs=1M
+	rm -f $TESTBINDIR/$img
+	modprobe ubi mtd="$mtdnum,0" || fatal "modprobe ubi fail"
+	modprobe ubifs || fatal "modprobe ubifs fail"
+
+	fsck.ubifs -a $DEV
+	let "ret=$?&~$FSCK_NONDESTRUCT"
+	if [[ $ret != $FSCK_OK ]]; then
+		if [[ "$fsck_mode" == "safe" ]]; then
+			fatal "The image should be fixed in $fsck_mode mode, but it fails"
+		fi
+
+		fsck.ubifs -y $DEV
+		let "ret=$?&~$FSCK_NONDESTRUCT"
+		if [[ $ret != $FSCK_OK ]]; then
+			if [[ "$fsck_mode" == "danger_default" ]]; then
+				fatal "The image should be fixed in $fsck_mode mode, but it fails"
+			fi
+
+			fsck.ubifs -yb $DEV
+			let "ret=$?&~$FSCK_NONDESTRUCT"
+			if [[ $ret != $FSCK_OK ]]; then
+				if [[ "$fsck_mode" == "danger_rebuild" ]]; then
+					fatal "The image should be fixed in $fsck_mode mode, but it fails"
+				fi
+
+				echo "fsck failed is expected, skip"
+
+				modprobe -r ubifs
+				modprobe -r ubi
+				modprobe -r mtdram
+				echo "----------------------------------------------------------------------"
+
+				return;
+			elif [[ "$fsck_mode" != "danger_rebuild" ]]; then
+				fatal "The image should not be fixed in $fsck_mode mode, but it succeeds"
+			fi
+		elif [[ "$fsck_mode" != "danger_default" ]]; then
+			fatal "The image should not be fixed in $fsck_mode mode, but it succeeds"
+		fi
+	elif [[ "$fsck_mode" != "safe" ]]; then
+		fatal "The image should not be fixed in $fsck_mode mode, but it succeeds"
+	fi
+
+	enable_chkfs
+
+	mount_ubifs $DEV $MNT
+	ret=$?
+	if [[ $ret != 0 ]]; then
+		fatal "mount failed $ret"
+	fi
+
+	du -sh $MNT > /dev/null  # Make sure all files are accessible
+	ret=$?
+	if [[ $ret != 0 ]]; then
+		fatal "cannot access all files $ret"
+	fi
+
+	if [[ $file_exist == 1 ]]; then
+		if ! [ -f $MNT/$CORRUPT_FILE ]; then
+			fatal "$MNT/$CORRUPT_FILE is lost"
+		fi
+	else
+		if [ -f $MNT/$CORRUPT_FILE ]; then
+			fatal "$MNT/$CORRUPT_FILE should not exist"
+		fi
+	fi
+
+	md5_after=`md5sum $MNT/$CORRUPT_FILE 2>/dev/null | awk '{print $1}'`
+	if [[ $file_nochange == 1 ]]; then
+		if [[ $CORRUPT_FILE_MD5 != $md5_after ]]; then
+			fatal "content changed for $MNT/$CORRUPT_FILE"
+		fi
+	else
+		if [[ $CORRUPT_FILE_MD5 == $md5_after ]]; then
+			fatal "content not changed for $MNT/$CORRUPT_FILE"
+		fi
+	fi
+
+	xattr=`getfattr -n $XATTR_NAME $MNT/$CORRUPT_FILE 2>/dev/null | grep $XATTR_NAME | awk -F '=' '{ print $2 }'`
+	if [[ $file_xattr_exist == 1 ]]; then
+		if ! [[ "$xattr" =~ "$XATTR_VAL" ]]; then
+			fatal "wrong xattr $xattr for $MNT/$CORRUPT_DENT_NAME"
+		fi
+	else
+		if [[ "$xattr" =~ "$XATTR_VAL" ]]; then
+			fatal "xattr $xattr for $MNT/$CORRUPT_DENT_NAME should not exist"
+		fi
+	fi
+
+	if [[ $hard_link_exist == 1 ]]; then
+		if ! [ -f $MNT/$HARD_LINK_FILE ]; then
+			fatal "$MNT/$HARD_LINK_FILE should is lost"
+		fi
+	else
+		if [ -f $MNT/$HARD_LINK_FILE ]; then
+			fatal "$MNT/$HARD_LINK_FILE should not exist"
+		fi
+	fi
+
+	md5_after=`md5sum $MNT/$HARD_LINK_FILE 2>/dev/null | awk '{print $1}'`
+	if [[ $hard_link_no_change == 1 ]]; then
+		if [[ $CORRUPT_FILE_MD5 != $md5_after ]]; then
+			fatal "content changed for $MNT/$HARD_LINK_FILE"
+		fi
+	else
+		if [[ $CORRUPT_FILE_MD5 == $md5_after ]]; then
+			fatal "content not changed for $MNT/$HARD_LINK_FILE"
+		fi
+	fi
+
+	xattr=`getfattr -n $XATTR_NAME $MNT/$HARD_LINK_FILE 2>/dev/null | grep $XATTR_NAME | awk -F '=' '{ print $2 }'`
+	if [[ $hard_link_xattr_exist == 1 ]]; then
+		if ! [[ "$xattr" =~ "$XATTR_VAL" ]]; then
+			fatal "wrong xattr $xattr for $MNT/$HARD_LINK_FILE"
+		fi
+	else
+		if [[ "$xattr" =~ "$XATTR_VAL" ]]; then
+			fatal "xattr $xattr for $MNT/$HARD_LINK_FILE should not exist"
+		fi
+	fi
+
+	link=`stat -c %N $MNT/$SOFT_LINK_FILE 2>/dev/null | grep $SOFT_LINK_FILE | grep $CORRUPT_FILE`
+	if [[ $soft_link_exist == 1 ]]; then
+		if [[ "$link" == "" ]]; then
+			fatal "$MNT/$SOFT_LINK_FILE is lost"
+		fi
+	else
+		if [[ "$link" != "" ]]; then
+			fatal "$MNT/$SOFT_LINK_FILE should not exist"
+		fi
+	fi
+
+	if [[ $dir_exist == 1 ]]; then
+		if ! [ -d $MNT/$DIR ]; then
+			fatal "$MNT/$DIR is lost"
+		fi
+		if ! [ -d $MNT/$DIR/$DIR ]; then
+			fatal "$MNT/$DIR/$DIR is lost"
+		fi
+		if ! [ -f $MNT/$DIR/$FILE ]; then
+			fatal "$MNT/$DIR/$FILE is lost"
+		fi
+		f_md5=`md5sum $MNT/$DIR/$FILE 2>/dev/null | awk '{print $1}'`
+		if [[ $dir_file_no_change == 1 ]]; then
+			if [[ $FILE_MD5 != $f_md5 ]]; then
+				fatal "content changed for $MNT/$DIR/$FILE"
+			fi
+		else
+			if [[ $FILE_MD5 == $f_md5 ]]; then
+				fatal "content not changed for $MNT/$DIR/$FILE"
+			fi
+		fi
+		if ! [ -b $MNT/$DIR/$BLOCK_DEV ]; then
+			fatal "$MNT/$DIR/$BLOCK_DEV is lost"
+		fi
+		major=`stat -c %t $MNT/$DIR/$BLOCK_DEV`
+		minor=`stat -c %T $MNT/$DIR/$BLOCK_DEV`
+		if [[ $major != 1 ]] || [[ $minor != 2 ]]; then
+			echo "major/minor changed for $MNT/$DIR/$BLOCK_DEV"
+		fi
+		if ! [ -c $MNT/$DIR/$CHAR_DEV ]; then
+			fatal "$MNT/$DIR/$CHAR_DEV is lost"
+		fi
+		major=`stat -c %t $MNT/$DIR/$CHAR_DEV`
+		minor=`stat -c %T $MNT/$DIR/$CHAR_DEV`
+		if [[ $major != 0 ]] || [[ $minor != 1 ]]; then
+			echo "major/minor changed for $MNT/$DIR/$CHAR_DEV"
+		fi
+	else
+		if [ -d $MNT/$DIR ]; then
+			fatal "$MNT/$DIR should not exist"
+		fi
+	fi
+
+	if [[ "$lost_found" == "no lost+found" ]]; then
+		if [ -d $MNT/$LOST_FOUND ]; then
+			fatal "$MNT/$LOST_FOUND should not exist"
+		fi
+	elif [[ "$lost_found" == "lost+found is regular" ]]; then
+		if ! [ -f $MNT/$LOST_FOUND ]; then
+			fatal "$MNT/$LOST_FOUND is not regular file"
+		fi
+	else
+		if ! [ -d $MNT/$LOST_FOUND ]; then
+			fatal "$MNT/$LOST_FOUND is lost"
+		fi
+
+		if ! [ -f $MNT/$LOST_FOUND/${FILE_INUM}_0 ]; then
+			fatal "$MNT/$LOST_FOUND/${FILE_INUM}_0 is lost"
+		fi
+		if [[ "$lost_found" == "lost+found has one" ]]; then
+			f_md5=`md5sum $MNT/$LOST_FOUND/${FILE_INUM}_0 2>/dev/null | awk '{print $1}'`
+			if [[ $FILE_MD5 != $f_md5 ]]; then
+				fatal "content changed for $MNT/$LOST_FOUND/${FILE_INUM}_0"
+			fi
+		elif [[ "$lost_found" == "lost+found has two" ]]; then
+			f_md5=`md5sum $MNT/$LOST_FOUND/${CORRUPT_FILE_INUM}_0 2>/dev/null | awk '{print $1}'`
+			if [[ $CORRUPT_FILE_MD5 != $f_md5 ]]; then
+				fatal "content changed for $MNT/$LOST_FOUND/${CORRUPT_FILE_INUM}_0"
+			fi
+			f_md5=`md5sum $MNT/$LOST_FOUND/${FILE_INUM}_0 2>/dev/null | awk '{print $1}'`
+			if [[ $FILE_MD5 != $f_md5 ]]; then
+				fatal "content changed for $MNT/$LOST_FOUND/${FILE_INUM}_0"
+			fi
+		else
+			if ! [ -f $MNT/$LOST_FOUND/${FILE_INUM}_1 ]; then
+				fatal "$MNT/$LOST_FOUND/${FILE_INUM}_1 is lost"
+			fi
+			f_md5=`md5sum $MNT/$LOST_FOUND/${FILE_INUM}_1 2>/dev/null | awk '{print $1}'`
+			if [[ $FILE_MD5 != $f_md5 ]]; then
+				fatal "content changed for $MNT/$LOST_FOUND/${FILE_INUM}_1"
+			fi
+		fi
+	fi
+
+	umount $MNT
+	res=$?
+	if [[ $res != 0 ]]
+	then
+		fatal "unmount fail $res"
+	fi
+
+	disable_chkfs
+
+	check_err_msg
+
+	modprobe -r ubifs
+	modprobe -r ubi
+	modprobe -r mtdram
+
+	echo "----------------------------------------------------------------------"
+}
+
+start_t=$(date +%s)
+echo "Do inconsistent UBIFS images fscking test"
+fsck_image "good image" good "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad sb fanout image" sb_fanout "none" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad sb fmt_version image" sb_fmt_version "none" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad sb leb_size image" sb_leb_size "none" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad sb log_lebs image" sb_log_lebs "none" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad sb min_io_size image" sb_min_io_size "none" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad master highest_inum image" master_highest_inum "danger_rebuild" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad master lpt image" master_lpt "danger_rebuild" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad master tnc image" master_tnc "danger_rebuild" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad master total_dead image" master_total_dead "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad master total_dirty image" master_total_dirty "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad master total_free image" master_total_free "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "corrupted journal log area image" journal_log "danger_rebuild" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "corrupted journal bud area image" journal_bud "danger_default" 1 0 1 1 0 1 1 1 0 "no lost+found"
+fsck_image "bad orphan node image" orphan_node "danger_default" 0 0 0 0 0 0 1 1 1 "no lost+found"
+fsck_image "bad lpt dirty image" lpt_dirty "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad lpt lpt_flags image" lpt_flags "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad lpt free image" lpt_free "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad lpt pos image" lpt_pos "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad lprops table dirty image" ltab_dirty "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad lprops table free image" ltab_free "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad index size image" index_size "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad tnc lv0 key image" tnc_lv0_key "danger_rebuild" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad tnc lv0 len image" tnc_lv0_len "danger_rebuild" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad tnc lv0 pos image" tnc_lv0_pos "danger_rebuild" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad tnc non-leaf key image" tnc_noleaf_key "danger_rebuild" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad tnc non-leaf len image" tnc_noleaf_len "danger_rebuild" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad tnc non-leaf pos image" tnc_noleaf_pos "danger_rebuild" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "corrupted leb for file data image" corrupted_data_leb "danger_default" 1 0 1 1 0 1 1 1 1 "no lost+found"
+fsck_image "corrupted leb for TNC image" corrupted_idx_leb "danger_rebuild" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad inode data image" inode_data "danger_default" 1 0 1 1 0 1 1 1 1 "no lost+found"
+fsck_image "bad inode mode image" inode_mode "danger_default" 0 0 0 0 0 0 1 1 1 "no lost+found"
+fsck_image "bad inode nlink image" inode_nlink "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad inode size image" inode_size "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad inode xattr_cnt image" inode_xcnt "safe" 1 1 1 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad softlink inode mode image" soft_link_inode_mode "danger_default" 1 1 1 1 1 1 0 1 1 "no lost+found"
+fsck_image "bad softlink inode data_len image" soft_link_data_len "danger_default" 1 1 1 1 1 1 0 1 1 "no lost+found"
+fsck_image "bad dentry key image" dentry_key "danger_default" 0 0 0 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad dentry nlen image" dentry_nlen "danger_default" 0 0 0 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad dentry type image" dentry_type "danger_default" 0 0 0 1 1 1 1 1 1 "no lost+found"
+fsck_image "bad xattr inode flags image" xinode_flags "danger_default" 1 1 0 1 1 0 1 1 1 "no lost+found"
+fsck_image "bad xattr inode key image" xinode_key "danger_default" 1 1 0 1 1 0 1 1 1 "no lost+found"
+fsck_image "bad xattr inode mode image" xinode_mode "danger_default" 1 1 0 1 1 0 1 1 1 "no lost+found"
+fsck_image "bad xattr dentry key image" xentry_key "danger_default" 1 1 0 1 1 0 1 1 1 "no lost+found"
+fsck_image "bad xattr dentry nlen image" xentry_nlen "danger_default" 1 1 0 1 1 0 1 1 1 "no lost+found"
+fsck_image "bad xattr dentry type image" xentry_type "danger_default" 1 1 0 1 1 0 1 1 1 "no lost+found"
+fsck_image "bad xattr host image" xent_host "danger_default" 0 0 0 0 0 0 1 1 1 "no lost+found"
+fsck_image "dir has too many dentry image" dir_many_dentry "danger_default" 1 1 1 0 0 0 1 1 1 "no lost+found"
+fsck_image "bad dir image" dir_lost "danger_default" 1 1 1 1 1 1 1 0 1 "lost+found has one"
+fsck_image "bad dir and duplicated file name in lost+found image" dir_lost_duplicated "danger_default" 1 1 1 1 1 1 1 0 1 "lost+found has duplicated files"
+fsck_image "bad dir and lost+found image" dir_lost_not_recover "danger_default" 1 1 1 1 1 1 1 0 1 "lost+found is regular"
+fsck_image "bad root dir image" root_dir "danger_default" 0 0 0 0 0 0 0 0 1 "lost+found has two"
+fsck_image "empty TNC image" empty_tnc "danger_rebuild" 0 0 0 0 0 0 0 0 1 "no lost+found"
+end_t=$(date +%s)
+time_cost=$(( end_t - start_t ))
+echo "Success, cost $time_cost seconds"
+exit 0
-- 
2.13.6


