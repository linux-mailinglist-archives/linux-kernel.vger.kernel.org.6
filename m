Return-Path: <linux-kernel+bounces-205384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9A08FFAE8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EAE28B4C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C130A14B06C;
	Fri,  7 Jun 2024 04:30:23 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508912E84A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734623; cv=none; b=dMb7Oxr2ni5wjtK3hLePAQYLJqPWJHs5ZyKjfRi4B7DQrlIdkq3mVGWgcs9xmNnwjlA44n+q0qJlrS2yl9Jv4X8ir/3QIkLgyyrq3FmBMstK5Bt22Cq8A9l/4LUYiW0bIKu/dRhaq8PdBrfMOBZcWa1mBlOKRbDpqoKz8dco3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734623; c=relaxed/simple;
	bh=Q2J08//P8VzIgSha757V/BSJSpTuLxnmN9yGoRI1S7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tShcF0iGZqIuJI5sZJnk77hAsS181diAH8MYNH2GrrtYN/05DlZox4LQ0R5X1G268Zhn/OtRzx7x0jj4Ib9BCa0W6Zvl76LqA9t2YylFwi9J5Tu0GG4NknOtNxnyXa0Mz5r6BYK/plgYw98DTVQQHY8pjO/nHaGyC933872Q98c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSrQ3wdzzdZfp;
	Fri,  7 Jun 2024 12:28:54 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 75CF714040F;
	Fri,  7 Jun 2024 12:30:04 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:42 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 102/110] tests: ubifs_tools: fsck_tests: Add powercut+fsck+mount test
Date: Fri, 7 Jun 2024 12:26:07 +0800
Message-ID: <20240607042615.2069840-103-chengzhihao1@huawei.com>
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

Inject powercut while doing fsstress on mounted UBIFS for kinds of
flashes (eg. nand, nor).
This testcase mainly makes sure that fsck.ubifs can make UBIFS image
be consistent on different flashes (eg. nand, nor). Because the
min_io_size of nor flash is 1, the UBIFS image on nor flash will be
different from nand flash after doing powercut, so we need make sure
fsck.ubifs can handle these two types of flash.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 .gitignore                                         |   1 +
 configure.ac                                       |   3 +-
 tests/ubifs_tools-tests/Makemodule.am              |   3 +-
 .../fsck_tests/powercut_fsck_mount.sh.in           | 144 +++++++++++++++++++++
 4 files changed, 149 insertions(+), 2 deletions(-)
 create mode 100755 tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh.in

diff --git a/.gitignore b/.gitignore
index 7de38e86..b63b9868 100644
--- a/.gitignore
+++ b/.gitignore
@@ -116,6 +116,7 @@ tests/ubi-tests/ubi-stress-test.sh
 tests/ubifs_tools-tests/lib/common.sh
 tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh
 tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh
+tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh
 
 #
 # Files generated by autotools
diff --git a/configure.ac b/configure.ac
index 9d17b9ab..99ce86c8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -292,7 +292,8 @@ AC_CONFIG_FILES([tests/fs-tests/fs_help_all.sh
 	tests/ubi-tests/ubi-stress-test.sh
 	tests/ubifs_tools-tests/lib/common.sh
 	tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh
-	tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh])
+	tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh
+	tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh])
 
 AC_OUTPUT([Makefile])
 
diff --git a/tests/ubifs_tools-tests/Makemodule.am b/tests/ubifs_tools-tests/Makemodule.am
index 68c77a62..d54514da 100644
--- a/tests/ubifs_tools-tests/Makemodule.am
+++ b/tests/ubifs_tools-tests/Makemodule.am
@@ -1,4 +1,5 @@
 test_SCRIPTS += \
 	tests/ubifs_tools-tests/lib/common.sh \
 	tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh \
-	tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh
+	tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh \
+	tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh
diff --git a/tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh.in b/tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh.in
new file mode 100755
index 00000000..3c7ff2dc
--- /dev/null
+++ b/tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh.in
@@ -0,0 +1,144 @@
+#!/bin/sh
+# Copyright (c), 2024, Huawei Technologies Co, Ltd.
+# Author: Zhihao Cheng <chengzhihao1@huawei.com>
+#
+# Test Description:
+# For many kinds of flash, do following things
+#  1. mount UBIFS
+#  2. fsstress & powercut & unmount
+#  3. fsck UBIFS
+#  4. check UBIFS mounting result
+# Running time: 1h
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
+	local encryption=$5;
+
+	echo "======================================================================"
+	printf "%s" "$simulator: ${size}MiB PEB size ${peb_size}KiB"
+	if [ "$simulator" = "nandsim" ]; then
+		printf " %s" "page size ${page_size}Bytes"
+	fi
+	printf " $encryption\n"
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
+	flash_eraseall /dev/mtd$mtdnum
+	modprobe ubi mtd="$mtdnum,$page_size" || fatal "modprobe ubi fail"
+	ubimkvol -N vol_test -m -n 0 /dev/ubi$UBI_NUM || fatal "mkvol fail"
+	modprobe ubifs || fatal "modprobe ubifs fail"
+	mount_ubifs $DEV $MNT || fatal "mount ubifs fail"
+	if [[ "$encryption" == "encrypted" ]]; then
+		encryption_gen_key
+		encryption_set_key $MNT
+	fi
+
+	fsstress -d $MNT -l0 -p4 -n10000 &
+	sleep $((RANDOM % 120))
+	powercut
+
+	ps -e | grep -w fsstress > /dev/null 2>&1
+	while [ $? -eq 0 ]
+	do
+		killall -9 fsstress > /dev/null 2>&1
+		sleep 1
+		ps -e | grep -w fsstress > /dev/null 2>&1
+	done
+
+	while true
+	do
+		res=`mount | grep "$MNT"`
+		if [[ "$res" == "" ]]
+		then
+			break;
+		fi
+		umount $MNT
+		sleep 0.1
+	done
+
+	fsck.ubifs -a $DEV 2>&1 > $LOG_FILE
+	res=$?
+	cat $LOG_FILE
+	if [[ $res != $FSCK_OK ]]
+	then
+		# Powercut during layout_leb_in_gaps may change index LEBs
+		# without updating LPT.
+		log=`cat $LOG_FILE | grep "Inconsistent properties" | grep "is_idx 1"`
+		if [[ "$log" == "" ]]; then
+			fatal "fsck fail $res"
+		fi
+		if [[ $res != $FSCK_NONDESTRUCT ]]; then
+			fatal "fsck fail $res"
+		fi
+	fi
+
+	dmesg -c > /dev/null # powercut could reproduce error messages
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
+	if [[ "$encryption" == "encrypted" ]]; then
+		encryption_set_key $MNT
+	fi
+
+	du -sh $MNT > /dev/null  # Make sure all files are accessible
+	ret=$?
+	if [[ $ret != 0 ]]; then
+		fatal "Cannot access all files"
+	fi
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
+
+	modprobe -r ubifs
+	modprobe -r ubi
+	modprobe -r $simulator
+
+	echo "----------------------------------------------------------------------"
+}
+
+check_fsstress
+start_t=$(date +%s)
+echo "Do powercut+fsck+mount test in kinds of flashes"
+for simulator in "mtdram" "nandsim"; do
+	for encryption in "encrypted" "noencrypted"; do
+		run_test "$simulator" "16" "16" "512" $encryption
+		run_test "$simulator" "64" "16" "512" $encryption
+		run_test "$simulator" "128" "64" "2048" $encryption
+		run_test "$simulator" "256" "128" "2048" $encryption
+		run_test "$simulator" "512" "128" "2048" $encryption
+		run_test "$simulator" "1024" "512" "2048" $encryption
+	done
+done
+end_t=$(date +%s)
+time_cost=$(( end_t - start_t ))
+echo "Success, cost $time_cost seconds"
+exit 0
-- 
2.13.6


