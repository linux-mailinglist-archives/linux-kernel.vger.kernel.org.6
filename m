Return-Path: <linux-kernel+bounces-205341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4578B8FFAB0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71DABB2395F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEE615B96E;
	Fri,  7 Jun 2024 04:27:35 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6589115A87E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734452; cv=none; b=aQuY07SANzM+cT7Ifr2i5FaqJxFLt+Sd4TXgQ1bqk8LL7OLgI0QG+ZK1zmtSAVGgd0dxd8dCiO+BNMPoE1R9sOkaQD5MD4p4GVMyjdu4SVeI46i5Vsg5Lsywg6hrpccVcJPRnrIuiCdsbnMUZEuUGDrQDv6qm2Emu+iHqCm9dh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734452; c=relaxed/simple;
	bh=0+47fqbP5v/L3CIOwPhohlUJBNnLw8iXtLxDf5M6r1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6oeZGqXGBt3o8jQ6pJGLWp26hh2epkvExE6BfTY41cF4RPLjEdMj4xOMp9514oU9PIfkndgGXcWnqTRorT7DEKH7g6/BwQ8RylreniaR233+1VvpCTdcyTDurzBzR61nTAPun3/sNsqYUv46NAyZ3pTK8cRLRmTNFGF2i55+hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSk66h4jz1S9pR;
	Fri,  7 Jun 2024 12:23:26 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id A7C42180AA6;
	Fri,  7 Jun 2024 12:27:25 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:09 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 057/110] fsck.ubifs: Add fsck support
Date: Fri, 7 Jun 2024 12:25:22 +0800
Message-ID: <20240607042615.2069840-58-chengzhihao1@huawei.com>
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

Add basic process code for fsck.ubifs. There are following modes for fsck:
 1. normal mode: Check the filesystem, ask user whether or not to fix
    the problem as long as inconsistent data is found during fs checking.
 2. safe mode: Check and safely repair the filesystem, if there are any
    data dropping operations needed by fixing, fsck will fail.
 3. danger mode: Answer 'yes' to all questions. There two sub modes:
    a) Check and repair the filesystem according to TNC, data dropping
       will be reported. If TNC/master/log is corrupted, fsck will fail.
    b) Check and forcedly repair the filesystem according to TNC, turns
       to rebuild filesystem if TNC/master/log is corrupted. Always make
       fsck succeed.
 4. check mode: Make no changes to the filesystem, only check the
    filesystem.
 5. rebuild mode: Scan entire UBI volume to find all nodes, and rebuild
    filesystem, always make fsck success.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 .gitignore                          |   1 +
 ubifs-utils/Makemodule.am           |  12 ++
 ubifs-utils/common/defs.h           |   3 +-
 ubifs-utils/fsck.ubifs/.gitignore   |   1 +
 ubifs-utils/fsck.ubifs/fsck.ubifs.c | 259 ++++++++++++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h |  91 +++++++++++++
 ubifs-utils/libubifs/debug.c        |   8 +-
 ubifs-utils/libubifs/super.c        |  52 ++++++++
 ubifs-utils/libubifs/ubifs.h        |   8 ++
 9 files changed, 432 insertions(+), 3 deletions(-)
 create mode 100644 ubifs-utils/fsck.ubifs/.gitignore
 create mode 100644 ubifs-utils/fsck.ubifs/fsck.ubifs.c
 create mode 100644 ubifs-utils/fsck.ubifs/fsck.ubifs.h

diff --git a/.gitignore b/.gitignore
index 8c51ee5f..3eb66c14 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,6 +30,7 @@ flash_otp_lock
 flash_otp_write
 flash_unlock
 flashcp
+fsck.ubifs
 ftl_check
 ftl_format
 jffs2dump
diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 936b49fc..0ed91dff 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -75,8 +75,20 @@ mkfs_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUI
 mkfs_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
 	-I$(top_srcdir)/ubi-utils/include -I$(top_srcdir)/ubifs-utils/common -I $(top_srcdir)/ubifs-utils/libubifs -rdynamic
 
+fsck_ubifs_SOURCES = \
+	$(common_SOURCES) \
+	$(libubifs_SOURCES) \
+	ubifs-utils/fsck.ubifs/fsck.ubifs.h \
+	ubifs-utils/fsck.ubifs/fsck.ubifs.c
+
+fsck_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm -lpthread
+fsck_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
+	-I$(top_srcdir)/ubi-utils/include -I$(top_srcdir)/ubifs-utils/common -I $(top_srcdir)/ubifs-utils/libubifs \
+	-I$(top_srcdir)/ubifs-utils/fsck.ubifs -rdynamic
+
 EXTRA_DIST += ubifs-utils/common/README ubifs-utils/libubifs/README
 
 dist_sbin_SCRIPTS = ubifs-utils/mount.ubifs
 
 sbin_PROGRAMS += mkfs.ubifs
+sbin_PROGRAMS += fsck.ubifs
diff --git a/ubifs-utils/common/defs.h b/ubifs-utils/common/defs.h
index 79451c40..8c8347a9 100644
--- a/ubifs-utils/common/defs.h
+++ b/ubifs-utils/common/defs.h
@@ -23,8 +23,9 @@ extern struct ubifs_info info_;
 #include "common.h"
 
 #define MKFS_PROGRAM_NAME "mkfs.ubifs"
+#define FSCK_PROGRAM_NAME "fsck.ubifs"
 
-enum { MKFS_PROGRAM_TYPE = 0 };
+enum { MKFS_PROGRAM_TYPE = 0, FSCK_PROGRAM_TYPE };
 
 enum {
 	DUMP_PREFIX_NONE,
diff --git a/ubifs-utils/fsck.ubifs/.gitignore b/ubifs-utils/fsck.ubifs/.gitignore
new file mode 100644
index 00000000..09d664aa
--- /dev/null
+++ b/ubifs-utils/fsck.ubifs/.gitignore
@@ -0,0 +1 @@
+/fsck.ubifs
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
new file mode 100644
index 00000000..b1286150
--- /dev/null
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Huawei Technologies Co, Ltd.
+ *
+ * Authors: Zhihao Cheng <chengzhihao1@huawei.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <getopt.h>
+#include <signal.h>
+
+#include "bitops.h"
+#include "kmem.h"
+#include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
+#include "misc.h"
+#include "fsck.ubifs.h"
+
+/*
+ * Because we copy functions from the kernel, we use a subset of the UBIFS
+ * file-system description object struct ubifs_info.
+ */
+struct ubifs_info info_;
+static struct ubifs_info *c = &info_;
+
+int exit_code = FSCK_OK;
+
+static const char *optstring = "Vrg:abyn";
+
+static const struct option longopts[] = {
+	{"version",            0, NULL, 'V'},
+	{"reserve",            1, NULL, 'r'},
+	{"debug",              1, NULL, 'g'},
+	{"auto",               1, NULL, 'a'},
+	{"rebuild",            1, NULL, 'b'},
+	{"yes",                1, NULL, 'y'},
+	{"nochange",           1, NULL, 'n'},
+	{NULL, 0, NULL, 0}
+};
+
+static const char *helptext =
+"Usage: fsck.ubifs [OPTIONS] ubi_volume\n"
+"Check & repair UBIFS filesystem on a given UBI volume\n\n"
+"Options:\n"
+"-V, --version            Display version information\n"
+"-g, --debug=LEVEL        Display debug information (0 - none, 1 - error message,\n"
+"                         2 - warning message[default], 3 - notice message, 4 - debug message)\n"
+"-a, --auto               Automatic safely repair without droping data (No questions).\n"
+"                         Can not be specified at the same time as the -y or -n options\n"
+"-y, --yes                Assume \"yes\" to all questions. Automatic repair and report dropping data (No questions).\n"
+"                         There are two submodes for this working mode:\n"
+"                           a. default - Fail if TNC/master/log is corrupted. Only -y option is specified\n"
+"                           b. rebuild fs - Turn to rebuild fs if TNC/master/log is corrupted. Specify -b option to make effect\n"
+"                         Can not be specified at the same time as the -a or -n options\n"
+"-b, --rebuild            Forcedly repair the filesystem even by rebuilding filesystem.\n"
+"                         Depends on -y option\n"
+"-n, --nochange           Make no changes to the filesystem, only check filesystem.\n"
+"                         Can not be specified at the same time as the -a or -y options\n"
+"Examples:\n"
+"\t1. Check and repair filesystem from UBI volume /dev/ubi0_0\n"
+"\t   fsck.ubifs /dev/ubi0_0\n"
+"\t2. Only check without modifying filesystem from UBI volume /dev/ubi0_0\n"
+"\t   fsck.ubifs -n /dev/ubi0_0\n"
+"\t3. Check and safely repair filesystem from UBI volume /dev/ubi0_0\n"
+"\t   fsck.ubifs -a /dev/ubi0_0\n"
+"\t4. Check and forcedly repair filesystem from UBI volume /dev/ubi0_0\n"
+"\t   fsck.ubifs -y -b /dev/ubi0_0\n\n";
+
+static inline void usage(void)
+{
+	printf("%s", helptext);
+	exit_code |= FSCK_USAGE;
+	exit(exit_code);
+}
+
+static void get_options(int argc, char* argv[], int *mode)
+{
+	int opt, i, submode = 0;
+	char *endp;
+
+	while (1) {
+		opt = getopt_long(argc, argv, optstring, longopts, &i);
+		if (opt == -1)
+			break;
+		switch (opt) {
+		case 'V':
+			common_print_version();
+			exit(FSCK_OK);
+		case 'g':
+			c->debug_level = strtol(optarg, &endp, 0);
+			if (*endp != '\0' || endp == optarg ||
+			    c->debug_level < 0 || c->debug_level > DEBUG_LEVEL) {
+				log_err(c, 0, "bad debugging level '%s'", optarg);
+				usage();
+			}
+			break;
+		case 'a':
+			if (*mode != NORMAL_MODE) {
+			conflict_opt:
+				log_err(c, 0, "Only one of the options -a, -n or -y may be specified");
+				usage();
+			}
+			*mode = SAFE_MODE;
+			break;
+		case 'y':
+			if (*mode != NORMAL_MODE)
+				goto conflict_opt;
+			*mode = DANGER_MODE0;
+			break;
+		case 'b':
+			submode = 1;
+			break;
+		case 'n':
+			if (*mode != NORMAL_MODE)
+				goto conflict_opt;
+			*mode = CHECK_MODE;
+			c->ro_mount = 1;
+			break;
+		case 'r':
+			/* Compatible with FSCK(8). */
+			break;
+		default:
+			usage();
+		}
+	}
+
+	if (submode) {
+		if (*mode != DANGER_MODE0) {
+			log_err(c, 0, "Option -y is not specified when -b is used");
+			usage();
+		} else
+			*mode = DANGER_MODE1;
+	}
+
+	if (optind != argc) {
+		c->dev_name = strdup(argv[optind]);
+		if (!c->dev_name) {
+			log_err(c, errno, "can not allocate dev_name");
+			exit_code |= FSCK_ERROR;
+			exit(exit_code);
+		}
+	}
+
+	if (!c->dev_name) {
+		log_err(c, 0, "no ubi_volume specified");
+		usage();
+	}
+}
+
+static void exit_callback(void)
+{
+	if (exit_code & FSCK_NONDESTRUCT)
+		log_out(c, "********** Filesystem was modified **********");
+	if (exit_code & FSCK_UNCORRECTED)
+		log_out(c, "********** WARNING: Filesystem still has errors **********");
+	if (exit_code & ~(FSCK_OK|FSCK_NONDESTRUCT))
+		log_out(c, "FSCK failed, exit code %d", exit_code);
+	else
+		log_out(c, "FSCK success!");
+}
+
+static void fsck_assert_failed(__unused const struct ubifs_info *c)
+{
+	exit_code |= FSCK_ERROR;
+	exit(exit_code);
+}
+
+static void signal_cancel(int sig)
+{
+	ubifs_warn(c, "killed by signo %d", sig);
+	exit_code |= FSCK_CANCELED;
+	exit(exit_code);
+}
+
+static int init_fsck_info(struct ubifs_info *c, int argc, char *argv[])
+{
+	int err = 0, mode = NORMAL_MODE;
+	struct sigaction sa;
+	struct ubifs_fsck_info *fsck = NULL;
+
+	if (atexit(exit_callback)) {
+		log_err(c, errno, "can not set exit callback");
+		return -errno;
+	}
+
+	init_ubifs_info(c, FSCK_PROGRAM_TYPE);
+	get_options(argc, argv, &mode);
+
+	fsck = calloc(1, sizeof(struct ubifs_fsck_info));
+	if (!fsck) {
+		err = -errno;
+		log_err(c, errno, "can not allocate fsck info");
+		goto out_err;
+	}
+
+	c->private = fsck;
+	FSCK(c)->mode = mode;
+	c->assert_failed_cb = fsck_assert_failed;
+
+	memset(&sa, 0, sizeof(struct sigaction));
+	sa.sa_handler = signal_cancel;
+	if (sigaction(SIGINT, &sa, NULL) || sigaction(SIGTERM, &sa, NULL)) {
+		err = -errno;
+		log_err(c, errno, "can not set signal handler");
+		goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	free(fsck);
+	free(c->dev_name);
+	c->dev_name = NULL;
+	return err;
+}
+
+static void destroy_fsck_info(struct ubifs_info *c)
+{
+	free(c->private);
+	c->private = NULL;
+	free(c->dev_name);
+	c->dev_name = NULL;
+}
+
+/*
+ * do_fsck - Check & repair the filesystem.
+ */
+static int do_fsck(void)
+{
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int err;
+
+	err = init_fsck_info(c, argc, argv);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto out_exit;
+	}
+
+	err = ubifs_open_volume(c, c->dev_name);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto out_destroy_fsck;
+	}
+
+	err = do_fsck();
+
+	ubifs_close_volume(c);
+out_destroy_fsck:
+	destroy_fsck_info(c);
+out_exit:
+	return exit_code;
+}
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
new file mode 100644
index 00000000..d267dd24
--- /dev/null
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Huawei Technologies Co, Ltd.
+ *
+ * Authors: Zhihao Cheng <chengzhihao1@huawei.com>
+ */
+
+#ifndef __FSCK_UBIFS_H__
+#define __FSCK_UBIFS_H__
+
+/* Exit codes used by fsck-type programs */
+#define FSCK_OK			0	/* No errors */
+#define FSCK_NONDESTRUCT	1	/* File system errors corrected */
+#define FSCK_REBOOT		2	/* System should be rebooted */
+#define FSCK_UNCORRECTED	4	/* File system errors left uncorrected */
+#define FSCK_ERROR		8	/* Operational error */
+#define FSCK_USAGE		16	/* Usage or syntax error */
+#define FSCK_CANCELED		32	/* Aborted with a signal or ^C */
+#define FSCK_LIBRARY		128	/* Shared library error */
+
+/*
+ * There are 6 working modes for fsck:
+ * NORMAL_MODE:	Check the filesystem, ask user whether or not to fix the
+ *		problem as long as inconsistent data is found during checking.
+ * SAFE_MODE:	Check and safely repair the filesystem, if there are any
+ *		data dropping operations needed by fixing, fsck will fail.
+ * DANGER_MODE0:Check and repair the filesystem according to TNC, data dropping
+ *              will be reported. If TNC/master/log is corrupted, fsck will fail.
+ * DANGER_MODE1:Check and forcedly repair the filesystem according to TNC,
+ *		turns to @REBUILD_MODE mode automatically if TNC/master/log is
+ *		corrupted.
+ * REBUILD_MODE:Scan entire UBI volume to find all nodes, and rebuild the
+ *		filesystem, always make fsck success.
+ * CHECK_MODE:	Make no changes to the filesystem, only check the filesystem.
+ */
+enum { NORMAL_MODE = 0, SAFE_MODE, DANGER_MODE0,
+       DANGER_MODE1, REBUILD_MODE, CHECK_MODE };
+
+/**
+ * struct ubifs_fsck_info - UBIFS fsck information.
+ * @mode: working mode
+ */
+struct ubifs_fsck_info {
+	int mode;
+};
+
+#define FSCK(c) ((struct ubifs_fsck_info*)c->private)
+
+static inline const char *mode_name(const struct ubifs_info *c)
+{
+	if (!c->private)
+		return "";
+
+	switch (FSCK(c)->mode) {
+	case NORMAL_MODE:
+		return ",normal mode";
+	case SAFE_MODE:
+		return ",safe mode";
+	case DANGER_MODE0:
+		return ",danger mode";
+	case DANGER_MODE1:
+		return ",danger + rebuild mode";
+	case REBUILD_MODE:
+		return ",rebuild mode";
+	case CHECK_MODE:
+		return ",check mode";
+	default:
+		return "";
+	}
+}
+
+#define log_out(c, fmt, ...) do {					\
+	printf("%s[%d] (%s%s): " fmt "\n", c->program_name ? : "noprog",\
+	       getpid(), c->dev_name ? : "-", mode_name(c),		\
+	       ##__VA_ARGS__);						\
+} while (0)
+
+#define log_err(c, err, fmt, ...) do {					\
+	printf("%s[%d][ERROR] (%s%s): %s: " fmt,			\
+	       c->program_name ? : "noprog", getpid(),			\
+	       c->dev_name ? : "-", mode_name(c),			\
+	       __FUNCTION__, ##__VA_ARGS__);				\
+	if (err)							\
+		printf(" - %s", strerror(err));				\
+	printf("\n");							\
+} while (0)
+
+/* Exit code for fsck program. */
+extern int exit_code;
+
+#endif
diff --git a/ubifs-utils/libubifs/debug.c b/ubifs-utils/libubifs/debug.c
index a2109906..94928da3 100644
--- a/ubifs-utils/libubifs/debug.c
+++ b/ubifs-utils/libubifs/debug.c
@@ -1021,7 +1021,11 @@ void ubifs_assert_failed(struct ubifs_info *c, const char *expr,
 
 	/*
 	 * Different from linux kernel.
-	 * There is only one action(readonly) when assertion is failed.
+	 * Invoke callback function if there is one, otherwise make filesystem
+	 * readonly when assertion is failed.
 	 */
-	ubifs_ro_mode(c, -EINVAL);
+	if (c->assert_failed_cb)
+		c->assert_failed_cb(c);
+	else
+		ubifs_ro_mode(c, -EINVAL);
 }
diff --git a/ubifs-utils/libubifs/super.c b/ubifs-utils/libubifs/super.c
index 9fa366f3..155489d9 100644
--- a/ubifs-utils/libubifs/super.c
+++ b/ubifs-utils/libubifs/super.c
@@ -138,6 +138,53 @@ int close_target(struct ubifs_info *c)
 }
 
 /**
+ * ubifs_open_volume - open UBI volume.
+ * @c: the UBIFS file-system description object
+ * @volume_name: the UBI volume name
+ *
+ * Open ubi volume. This function is implemented by open_ubi + open_target.
+ *
+ * Returns %0 in case of success and a negative error code in case of failure.
+ */
+int ubifs_open_volume(struct ubifs_info *c, const char *volume_name)
+{
+	int err;
+
+	err = open_ubi(c, volume_name);
+	if (err) {
+		ubifs_err(c, "cannot open libubi. %s", strerror(errno));
+		return err;
+	}
+
+	err = open_target(c);
+	if (err)
+		close_ubi(c);
+
+	return err;
+}
+
+/**
+ * ubifs_close_volume - close UBI volume.
+ * @c: the UBIFS file-system description object
+ *
+ * Close ubi volume. This function is implemented by close_target + close_ubi.
+ *
+ * Returns %0 in case of success and a negative error code in case of failure.
+ */
+int ubifs_close_volume(struct ubifs_info *c)
+{
+	int err;
+
+	err = close_target(c);
+	if (err)
+		return err;
+
+	close_ubi(c);
+
+	return 0;
+}
+
+/**
  * check_volume_empty - check if the UBI volume is empty.
  * @c: the UBIFS file-system description object
  *
@@ -197,6 +244,11 @@ void init_ubifs_info(struct ubifs_info *c, int program_type)
 	case MKFS_PROGRAM_TYPE:
 		c->program_name = MKFS_PROGRAM_NAME;
 		break;
+	case FSCK_PROGRAM_TYPE:
+		c->program_name = FSCK_PROGRAM_NAME;
+		/* Always check crc for data node. */
+		c->no_chk_data_crc = 0;
+		break;
 	default:
 		assert(0);
 		break;
diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index 2af9d87b..babaae8f 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -1026,6 +1026,9 @@ struct ubifs_budg_info {
  *
  * @new_ihead_lnum: used by debugging to check @c->ihead_lnum
  * @new_ihead_offs: used by debugging to check @c->ihead_offs
+ *
+ * @private: private information related to specific situation, eg. fsck.
+ * @assert_failed_cb: callback function to handle assertion failure
  */
 struct ubifs_info {
 	struct ubifs_sb_node *sup_node;
@@ -1248,6 +1251,9 @@ struct ubifs_info {
 
 	int new_ihead_lnum;
 	int new_ihead_offs;
+
+	void *private;
+	void (*assert_failed_cb)(const struct ubifs_info *c);
 };
 
 extern atomic_long_t ubifs_clean_zn_cnt;
@@ -1684,6 +1690,8 @@ int open_ubi(struct ubifs_info *c, const char *node);
 void close_ubi(struct ubifs_info *c);
 int open_target(struct ubifs_info *c);
 int close_target(struct ubifs_info *c);
+int ubifs_open_volume(struct ubifs_info *c, const char *volume_name);
+int ubifs_close_volume(struct ubifs_info *c);
 int check_volume_empty(struct ubifs_info *c);
 void init_ubifs_info(struct ubifs_info *c, int program_type);
 int init_constants_early(struct ubifs_info *c);
-- 
2.13.6


