Return-Path: <linux-kernel+bounces-205377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249EE8FFADE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C59289043
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2B513D618;
	Fri,  7 Jun 2024 04:28:38 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71F13CA8C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734517; cv=none; b=OAFUNyXqhKuyEthFteKVylm1yCpNMuloPHqmlfObDcc5XaeZwY9k3hIUQGM2P2b5iZILMHW1NrPrnXbQo9lVILENnI5ceHu5zfUWEDF4R/LGVUKzdUGO10NBMZSeWmS45sNv1DmqBzkWvEjXeMv6M4F9Ct9DYdy5+2cyr2CIFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734517; c=relaxed/simple;
	bh=dfCVSYEFuuvdCftf+NKbYKVFul6nhvVhI7iBUorw3cU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDoSVpdhVgpyYPJlZNLL6iR/CLaiSt8KrgPW5VqtCf1c2z3XsPLxIKD4AFLs0t/CRJgIJvxuuu6RveEulgvzWEKAOGlKxv3qtOFcEKHtJidUKI05C3vAT9BxqeOMM0GoVAwBkXdmIZrHXXXYgeIXRpwNS7CGzSPxZhzzFV5jiC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSlR18X1zwS97;
	Fri,  7 Jun 2024 12:24:35 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 17C22140124;
	Fri,  7 Jun 2024 12:28:19 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:36 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 095/110] fsck.ubifs: Check and create the lost+found
Date: Fri, 7 Jun 2024 12:26:00 +0800
Message-ID: <20240607042615.2069840-96-chengzhihao1@huawei.com>
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

From: Huang Xiaojia <huangxiaojia2@huawei.com>

This is the 16/18 step of fsck. Check whether the lost+found is existed,
create a new one if it is not found. This step makes sure that disconnected
file can be recovered under the lost+found.

Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am                    |  3 +-
 ubifs-utils/fsck.ubifs/fsck.ubifs.c          | 15 ++++-
 ubifs-utils/fsck.ubifs/fsck.ubifs.h          |  5 ++
 ubifs-utils/fsck.ubifs/handle_disconnected.c | 89 ++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 ubifs-utils/fsck.ubifs/handle_disconnected.c

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index f63ca7a2..77a9be1a 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -85,7 +85,8 @@ fsck_ubifs_SOURCES = \
 	ubifs-utils/fsck.ubifs/extract_files.c \
 	ubifs-utils/fsck.ubifs/rebuild_fs.c \
 	ubifs-utils/fsck.ubifs/check_files.c \
-	ubifs-utils/fsck.ubifs/check_space.c
+	ubifs-utils/fsck.ubifs/check_space.c \
+	ubifs-utils/fsck.ubifs/handle_disconnected.c
 
 fsck_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm -lpthread
 fsck_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 584965fc..0910676c 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -526,8 +526,20 @@ static int do_fsck(void)
 
 	log_out(c, "Check and create root dir");
 	err = check_and_create_root(c);
-	if (err)
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto free_disconnected_files_2;
+	}
+
+	if (list_empty(&FSCK(c)->disconnected_files))
+		return err;
+
+	log_out(c, "Check and create lost+found");
+	err = check_and_create_lost_found(c);
+	if (err) {
 		exit_code |= FSCK_ERROR;
+		goto free_disconnected_files_2;
+	}
 
 free_disconnected_files_2:
 	destroy_file_list(c, &FSCK(c)->disconnected_files);
@@ -583,6 +595,7 @@ int main(int argc, char *argv[])
 	 * Step 13: Commit problem fixing modifications
 	 * Step 14: Check and correct the index size
 	 * Step 15: Check and create root dir
+	 * Step 16: Check and create lost+found
 	 */
 	err = do_fsck();
 	if (err && FSCK(c)->try_rebuild) {
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 5c305ba0..dc24e83c 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -277,6 +277,7 @@ struct ubifs_rebuild_info {
  * @lpts: lprops table
  * @try_rebuild: %true means that try to rebuild fs when fsck failed
  * @rebuild: rebuilding-related information
+ * @lost_and_found: inode number of the lost+found directory, %0 means invalid
  */
 struct ubifs_fsck_info {
 	int mode;
@@ -288,6 +289,7 @@ struct ubifs_fsck_info {
 	struct ubifs_lprops *lpts;
 	bool try_rebuild;
 	struct ubifs_rebuild_info *rebuild;
+	ino_t lost_and_found;
 };
 
 #define FSCK(c) ((struct ubifs_fsck_info*)c->private)
@@ -384,4 +386,7 @@ int build_lpt(struct ubifs_info *c, calculate_lp_callback calculate_lp_cb,
 int check_and_correct_space(struct ubifs_info *c);
 int check_and_correct_index_size(struct ubifs_info *c);
 
+/* handle_disconnected.c */
+int check_and_create_lost_found(struct ubifs_info *c);
+
 #endif
diff --git a/ubifs-utils/fsck.ubifs/handle_disconnected.c b/ubifs-utils/fsck.ubifs/handle_disconnected.c
new file mode 100644
index 00000000..b9a380f9
--- /dev/null
+++ b/ubifs-utils/fsck.ubifs/handle_disconnected.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Huawei Technologies Co, Ltd.
+ *
+ * Authors: Huang Xiaojia <huangxiaojia2@huawei.com>
+ *          Zhihao Cheng <chengzhihao1@huawei.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+
+#include "linux_err.h"
+#include "kmem.h"
+#include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
+#include "fsck.ubifs.h"
+
+#define LOST_FOUND_DIR_NAME "lost+found"
+
+/**
+ * check_and_create_lost_found - Check and create the lost+found directory.
+ * @c: UBIFS file-system description object
+ *
+ * This function checks whether the lost+found directory exists and creates a
+ * new one if no valid lost+found existing. If there is a valid lost+found
+ * directory, inode number is stored in @FSCK(c)->lost_and_found. Returns zero
+ * in case of success, a negative error code in case of failure.
+ */
+int check_and_create_lost_found(struct ubifs_info *c)
+{
+	struct ubifs_inode *root_ui, *lost_found_ui;
+	struct fscrypt_name nm;
+	int err = 0;
+
+	root_ui = ubifs_lookup_by_inum(c, UBIFS_ROOT_INO);
+	if (IS_ERR(root_ui)) {
+		err = PTR_ERR(root_ui);
+		/* Previous step ensures that the root dir is valid. */
+		ubifs_assert(c, err != -ENOENT);
+		return err;
+	}
+
+	if (root_ui->flags & UBIFS_CRYPT_FL) {
+		ubifs_msg(c, "The root dir is encrypted, skip checking lost+found");
+		goto free_root;
+	}
+
+	fname_name(&nm) = LOST_FOUND_DIR_NAME;
+	fname_len(&nm) = strlen(LOST_FOUND_DIR_NAME);
+	lost_found_ui = ubifs_lookup(c, root_ui, &nm);
+	if (IS_ERR(lost_found_ui)) {
+		err = PTR_ERR(lost_found_ui);
+		if (err != -ENOENT)
+			goto free_root;
+
+		/* Not found. Create a new lost+found. */
+		err = ubifs_mkdir(c, root_ui, &nm, S_IRUGO | S_IWUSR | S_IXUSR);
+		if (err < 0) {
+			if (err == -ENOSPC) {
+				ubifs_msg(c, "No free space to create lost+found");
+				err = 0;
+			}
+			goto free_root;
+		}
+		lost_found_ui = ubifs_lookup(c, root_ui, &nm);
+		if (IS_ERR(lost_found_ui)) {
+			err = PTR_ERR(lost_found_ui);
+			ubifs_assert(c, err != -ENOENT);
+			goto free_root;
+		}
+		FSCK(c)->lost_and_found = lost_found_ui->vfs_inode.inum;
+		ubifs_msg(c, "Create the lost+found");
+	} else if (!(lost_found_ui->flags & UBIFS_CRYPT_FL) &&
+		   S_ISDIR(lost_found_ui->vfs_inode.mode)) {
+		FSCK(c)->lost_and_found = lost_found_ui->vfs_inode.inum;
+	} else {
+		ubifs_msg(c, "The type of lost+found is %s%s",
+			  ubifs_get_type_name(ubifs_get_dent_type(lost_found_ui->vfs_inode.mode)),
+			  lost_found_ui->flags & UBIFS_CRYPT_FL ? ", encrypted" : "");
+	}
+
+	kfree(lost_found_ui);
+free_root:
+	kfree(root_ui);
+	return err;
+}
-- 
2.13.6


