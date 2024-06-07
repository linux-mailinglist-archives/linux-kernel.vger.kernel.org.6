Return-Path: <linux-kernel+bounces-205383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E88FFAE6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2CC28B0B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23BE1482FA;
	Fri,  7 Jun 2024 04:30:08 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E09E2E84A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734608; cv=none; b=hkEvETX2i8jur2/8KzBoHQ2bBDr9gXCAlbg/uI7wuZ5Ac5lX7ByCpaTnPniTX2fsKPv2KgyBoA61WrZrAAGve96eqIpQerPmlwlYG1H2F8A0nnwPQmB7iD9nlzSOTReDekYM2U7nw6pK+WctLScMjdnzlBtQEN/2/2r6yt3+ALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734608; c=relaxed/simple;
	bh=4VxNE5MCU/8AX49PEAbBzuMSYM/hr4CytFhK6Q/w9gg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gclLEG7zpoSkiVrT/Sbz/bRgR69wckw/zodpT9XtAIxl905Th63k9NNTKEYtuv/HtGu89NLi4qLksHWQjhajAAUmBcQlQ6QwoDQP/FzJnvFUPZiZRkoPJLR4YGKffPVtHUvJydoDURSHKmppPfweV5/r7EFyTRVuf3EjjtlW5m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSmS45qGzmYJM;
	Fri,  7 Jun 2024 12:25:28 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 68CDE140336;
	Fri,  7 Jun 2024 12:29:49 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:41 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 101/110] tests: ubifs_tools: fsck_tests: Add cycle mount+fsck test
Date: Fri, 7 Jun 2024 12:26:06 +0800
Message-ID: <20240607042615.2069840-102-chengzhihao1@huawei.com>
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

Do fsstress and fsck, check whether there are any files(and their data)
are lost after fsck. This testcase mainly checks whether fsck.ubifs could
corrupt the filesystem content in common case.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 .gitignore                                         |   1 +
 configure.ac                                       |   3 +-
 tests/ubifs_tools-tests/Makemodule.am              |   3 +-
 .../fsck_tests/cycle_mount_fsck_check.sh.in        | 144 +++++++++++++++++++++
 4 files changed, 149 insertions(+), 2 deletions(-)
 create mode 100755 tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh.in

diff --git a/.gitignore b/.gitignore
index 799290a4..7de38e86 100644
--- a/.gitignore
+++ b/.gitignore
@@ -115,6 +115,7 @@ tests/ubi-tests/runubitests.sh
 tests/ubi-tests/ubi-stress-test.sh
 tests/ubifs_tools-tests/lib/common.sh
 tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh
+tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh
 
 #
 # Files generated by autotools
diff --git a/configure.ac b/configure.ac
index 160fa812..9d17b9ab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -291,7 +291,8 @@ AC_CONFIG_FILES([tests/fs-tests/fs_help_all.sh
 	tests/ubi-tests/runubitests.sh
 	tests/ubi-tests/ubi-stress-test.sh
 	tests/ubifs_tools-tests/lib/common.sh
-	tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh])
+	tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh
+	tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh])
 
 AC_OUTPUT([Makefile])
 
diff --git a/tests/ubifs_tools-tests/Makemodule.am b/tests/ubifs_tools-tests/Makemodule.am
index 6b533982..68c77a62 100644
--- a/tests/ubifs_tools-tests/Makemodule.am
+++ b/tests/ubifs_tools-tests/Makemodule.am
@@ -1,3 +1,4 @@
 test_SCRIPTS += \
 	tests/ubifs_tools-tests/lib/common.sh \
-	tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh
+	tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh \
+	tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh
diff --git a/tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh.in b/tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh.in
new file mode 100755
index 00000000..06e480b8
--- /dev/null
+++ b/tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh.in
@@ -0,0 +1,144 @@
+#!/bin/sh
+# Copyright (c), 2024, Huawei Technologies Co, Ltd.
+# Author: Zhihao Cheng <chengzhihao1@huawei.com>
+#
+# Test Description:
+# Do many cycles of mount/fsstress/umount/fsck/mount, check whether the
+# filesystem content before fsck and after fsck are consistent.
+# Running time: 10h
+
+TESTBINDIR=@TESTBINDIR@
+source $TESTBINDIR/common.sh
+
+ID="0xec,0xa1,0x00,0x15" # 128M 128KB 2KB 512-sub-page
+
+function run_test()
+{
+	encryption=$1
+	modprobe nandsim id_bytes=$ID
+	mtdnum="$(find_mtd_device "$nandsim_patt")"
+	flash_eraseall /dev/mtd$mtdnum
+
+	dmesg -c > /dev/null
+
+	modprobe ubi mtd="$mtdnum,2048" || fatal "modprobe ubi fail"
+	ubimkvol -N vol_test -m -n 0 /dev/ubi$UBI_NUM || fatal "mkvol fail"
+	modprobe ubifs || fatal "modprobe ubifs fail"
+
+	echo "Do cycle mount+umount+fsck+check_fs_content test ($encryption)"
+
+	if [[ "$encryption" == "encrypted" ]]; then
+		encryption_gen_key
+	fi
+
+	round=0
+	while [[ $round -lt 20 ]]
+	do
+		echo "---------------------- ROUND $round ----------------------"
+		let round=$round+1
+
+		mount_ubifs $DEV $MNT "noauthentication" "noatime" || fatal "mount ubifs fail"
+		if [[ "$encryption" == "encrypted" ]]; then
+			encryption_set_key $MNT
+		fi
+
+		per=`df -Th | grep ubifs | awk '{print $6}'`;
+		if [[ ${per%?} -gt 95 ]]; then
+			# Used > 95%
+			echo "Clean files"
+			rm -rf $MNT/*
+			check_err_msg
+		fi
+
+		fsstress -d $MNT -l0 -p4 -n10000 &
+
+		sleep $((RANDOM % 30))
+
+		ps -e | grep -w fsstress > /dev/null 2>&1
+		while [ $? -eq 0 ]
+		do
+			killall -9 fsstress > /dev/null 2>&1
+			sleep 1
+			ps -e | grep -w fsstress > /dev/null 2>&1
+		done
+
+		per=`df -Th | grep ubifs | awk '{print $6}'`;
+		if [[ ${per%?} -gt 95 ]]; then
+			dmesg -c > /dev/null # The ENOSPC error messages may exist
+		else
+			check_err_msg # Make sure new operations are okay after fsck
+		fi
+		sync
+
+		# Record filesystem information
+		rm -f $TMP_FILE 2>/dev/null
+		read_dir $MNT "md5sum"
+
+		while true
+		do
+			res=`mount | grep "$MNT"`
+			if [[ "$res" == "" ]]
+			then
+				break;
+			fi
+			umount $MNT
+			sleep 0.1
+		done
+
+		fsck.ubifs -a $DEV # 'fsck.ubifs $DEV' is fine too.
+		res=$?
+		if [[ $res != $FSCK_OK ]]
+		then
+			fatal "fsck expects result $FSCK_OK, but $res is returned"
+		fi
+
+		enable_chkfs
+
+		mount_ubifs $DEV $MNT "noauthentication" "noatime"
+		res=$?
+		if [[ $res != 0 ]]
+		then
+			fatal "mount fail $res"
+		fi
+
+		if [[ "$encryption" == "encrypted" ]]; then
+			encryption_set_key $MNT
+		fi
+
+		du -sh $MNT > /dev/null  # Ensure that all files are accessible
+		ret=$?
+		if [[ $ret != 0 ]]; then
+			fatal "Cannot access all files"
+		fi
+		check_err_msg
+
+		# Check filesystem information
+		parse_dir "md5sum"
+		rm -f $TMP_FILE 2>/dev/null
+
+		umount $MNT
+		res=$?
+		if [[ $res != 0 ]]
+		then
+			fatal "unmount fail $res"
+		fi
+
+		check_err_msg
+
+		disable_chkfs
+	done
+
+	modprobe -r ubifs
+	modprobe -r ubi
+	modprobe -r nandsim
+}
+
+check_fsstress
+start_t=$(date +%s)
+for encryption in "encrypted" "noencrypted"; do
+	run_test $encryption
+done
+end_t=$(date +%s)
+time_cost=$(( end_t - start_t ))
+echo "Success, cost $time_cost seconds"
+exit 0
-- 
2.13.6


