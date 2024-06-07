Return-Path: <linux-kernel+bounces-205335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4328FFAA7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CF81C236DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BDA15B120;
	Fri,  7 Jun 2024 04:27:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4915AAC6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734450; cv=none; b=V9z30Xh6R43fDBgjtvAv5kV2z6KmBRW6v1kz53DcdsUrmfRiRG41xFYLY1Ubm4fxyWAnenUS7r+vV7OvjxgnIYoyWoGDFhw/7wZaxsHuRkvGKAs3AOKrW6t7r52J2IQSkeuhjHIAtTPUgieBrpsSoBsgagBx4p42V7D0KoMCPLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734450; c=relaxed/simple;
	bh=1E4SxR/zEJiSNt+fYgWJ0tixMquI1CWt99bw/e/XtyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=te3pORpzvfm4h4XjFjkFpi7Q9M381EE+RAugMRWMI1qV579GjvtUhbd6t8znKY6HQQdeQQeH5Iqks+D3h0xH02Zmp61iNd3TJtZNGVTzoxCw/qNe3MjKSnj4RSEHoWxzSR05lQaAKaFJMzCTWFyOt8eU3eUVPF2xbo0A9lril9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSk70d9BzsTSD;
	Fri,  7 Jun 2024 12:23:27 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id B8A53180085;
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
Subject: [RFC PATCH mtd-utils 058/110] fsck.ubifs: Add inconsistent problem handling asking function
Date: Fri, 7 Jun 2024 12:25:23 +0800
Message-ID: <20240607042615.2069840-59-chengzhihao1@huawei.com>
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

There are four dimensions to define the type of inconsistent problems:
 1. fixable: Some inconsistent problems can't be fixed, for example
    corrupted superblock. Un-fixable problem will abort program.
 2. must fix: Some inconsistent problems can be ignored(eg. incorrect
    isize), but some are not(eg. corrupted TNC), which will affect the
    subsequent fsck steps.
 3. drop data: Some fixing methods will drop user data, which is
    unacceptable for safe mode. If it happens, fsck will be aborted.
 4. need rebuild: Some inconsistent problems depends on rebuilding
    filesystem to be fixed(eg. corrupted master node, corrupted TNC).
Define an asking function to handle above kinds of inconsistent problems.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am           |   3 +-
 ubifs-utils/fsck.ubifs/fsck.ubifs.h |   3 +
 ubifs-utils/fsck.ubifs/problem.c    | 111 ++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 ubifs-utils/fsck.ubifs/problem.c

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 0ed91dff..faff911f 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -79,7 +79,8 @@ fsck_ubifs_SOURCES = \
 	$(common_SOURCES) \
 	$(libubifs_SOURCES) \
 	ubifs-utils/fsck.ubifs/fsck.ubifs.h \
-	ubifs-utils/fsck.ubifs/fsck.ubifs.c
+	ubifs-utils/fsck.ubifs/fsck.ubifs.c \
+	ubifs-utils/fsck.ubifs/problem.c
 
 fsck_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm -lpthread
 fsck_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index d267dd24..b9783c15 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -88,4 +88,7 @@ static inline const char *mode_name(const struct ubifs_info *c)
 /* Exit code for fsck program. */
 extern int exit_code;
 
+/* problem.c */
+bool fix_problem(const struct ubifs_info *c, int problem_type);
+
 #endif
diff --git a/ubifs-utils/fsck.ubifs/problem.c b/ubifs-utils/fsck.ubifs/problem.c
new file mode 100644
index 00000000..9a8c2e06
--- /dev/null
+++ b/ubifs-utils/fsck.ubifs/problem.c
@@ -0,0 +1,111 @@
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
+
+#include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "fsck.ubifs.h"
+
+/*
+ * problem flags.
+ *
+ * PROBLEM_FIXABLE: problem is fixable, unsolvable problem such as corrupted
+ *		    super block will abort the fsck program
+ * PROBLEM_MUST_FIX: problem must be fixed because it will affect the subsequent
+ *		     fsck process, otherwise aborting the fsck program
+ * PROBLEM_DROP_DATA: user data could be dropped after fixing the problem
+ * PROBLEM_NEED_REBUILD: rebuilding filesystem is needed to fix the problem
+ */
+#define PROBLEM_FIXABLE		(1<<0)
+#define PROBLEM_MUST_FIX	(1<<1)
+#define PROBLEM_DROP_DATA	(1<<2)
+#define PROBLEM_NEED_REBUILD	(1<<3)
+
+struct fsck_problem {
+	unsigned int flags;
+	const char *desc;
+};
+
+static const struct fsck_problem problem_table[] = {};
+
+static void print_problem(const struct ubifs_info *c,
+			  const struct fsck_problem *problem)
+{
+	log_out(c, "problem: %s", problem->desc);
+}
+
+static void fatal_error(const struct ubifs_info *c,
+			const struct fsck_problem *problem)
+{
+	if (!(problem->flags & PROBLEM_FIXABLE))
+		log_out(c, "inconsistent problem cannot be fixed");
+	else
+		log_out(c, "inconsistent problem must be fixed");
+	exit(exit_code);
+}
+
+/**
+ * fix_problem - whether fixing the inconsistent problem
+ * @c: UBIFS file-system description object
+ * @problem_type: the type of inconsistent problem
+ *
+ * This function decides to fix/skip the inconsistent problem or abort the
+ * program according to @problem_type, returns %true if the problem should
+ * be fixed, returns %false if the problem will be skipped.
+ */
+bool fix_problem(const struct ubifs_info *c, int problem_type)
+{
+	bool ans, ask = true, def_y = true;
+	const struct fsck_problem *problem = &problem_table[problem_type];
+	const char *question = (problem->flags & PROBLEM_NEED_REBUILD) ?
+				"Rebuild filesystem?" : "Fix it?";
+
+	ubifs_assert(c, FSCK(c)->mode != REBUILD_MODE);
+
+	if (!(problem->flags & PROBLEM_FIXABLE)) {
+		exit_code |= FSCK_UNCORRECTED;
+		fatal_error(c, problem);
+	}
+
+	if (FSCK(c)->mode == CHECK_MODE ||
+	    ((problem->flags & PROBLEM_DROP_DATA) && FSCK(c)->mode == SAFE_MODE) ||
+	    ((problem->flags & PROBLEM_NEED_REBUILD) &&
+	     (FSCK(c)->mode == SAFE_MODE || FSCK(c)->mode == DANGER_MODE0)))
+		def_y = false;
+
+	if ((problem->flags & PROBLEM_NEED_REBUILD) &&
+	    (FSCK(c)->mode == DANGER_MODE0 || FSCK(c)->mode == DANGER_MODE1))
+		ask = false;
+
+	print_problem(c, problem);
+	ans = def_y;
+	if (FSCK(c)->mode == NORMAL_MODE) {
+		printf("%s[%d] (%s%s)", c->program_name, getpid(),
+		       c->dev_name ? : "-", mode_name(c));
+		if (prompt(question, def_y))
+			ans = true;
+		else
+			ans = false;
+	} else {
+		if (ask)
+			log_out(c, "%s %c\n", question, def_y ? 'y' : 'n');
+	}
+
+	if (!ans) {
+		exit_code |= FSCK_UNCORRECTED;
+		if (problem->flags & PROBLEM_MUST_FIX)
+			fatal_error(c, problem);
+	} else {
+		exit_code |= FSCK_NONDESTRUCT;
+	}
+
+	return ans;
+}
-- 
2.13.6


