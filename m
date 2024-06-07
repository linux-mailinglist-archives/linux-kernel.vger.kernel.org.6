Return-Path: <linux-kernel+bounces-205368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A088FFAD0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705D2285DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA364169AFB;
	Fri,  7 Jun 2024 04:27:55 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92815AAD8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734469; cv=none; b=p37UfvASB9ARwS0OwBI3iA2lRuWlbfULUb1w0/ufcf/sZAXfVYzSKBxGB8xAfMrm0wSzLOR2ioMOsxywQaP82Bmzf0XB9awG7SBFVlFYVcWeWRiqXszB3H7cXoK4hSVX9OF77jL/uImKZ7FPJqWLGPEina6dMd/iR0j3Lm3Gq+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734469; c=relaxed/simple;
	bh=8pUdAZyMMhETHZyMICNddLagjqwCTdME5D7GQrDqGr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iADiO9EQYFAlN1d5rFWW6lBaplIlTFwLIGu9kVIb6Ei6epMfcZ/sKBqgs3+ytwheH3bpyQNg/A8lKh3XrZ0VBf8RCiAvlYq8JkY+fTaUFZB7jYr+g0wDBrnJwuagggnKBkIllXIqHb4cILkYGiCe6+LMS+d7fpkQOk8R8ed/92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSkQ1PXBz1SB3b;
	Fri,  7 Jun 2024 12:23:42 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id E5C01180AA6;
	Fri,  7 Jun 2024 12:27:40 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:27 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 082/110] fsck.ubifs: Traverse TNC and construct files
Date: Fri, 7 Jun 2024 12:25:47 +0800
Message-ID: <20240607042615.2069840-83-chengzhihao1@huawei.com>
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

This is the 6/18 step of fsck. Traverse TNC and construct files. There
could be following steps and possible errors:
 Step 1. Traverse TNC, check whether the leaf node is valid, remove invalid
 nodes, construct file for valid node and insert file into file tree.
  a. corrupted node searched from TNC: remove corresponding TNC branch for
     danger mode and normal mode with 'yes' answer, other modes will exit.
  b. corrupted index node read from TNC: danger mode with rebuild_fs and
     normal mode with 'yes' answer will turn to rebuild filesystem, other
     modes will exit.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am              |   3 +-
 ubifs-utils/fsck.ubifs/check_files.c   | 201 ++++++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/extract_files.c | 216 ++++++++++++++++++++++++---------
 ubifs-utils/fsck.ubifs/fsck.ubifs.c    |  15 ++-
 ubifs-utils/fsck.ubifs/fsck.ubifs.h    |   6 +-
 ubifs-utils/fsck.ubifs/problem.c       |   6 +
 ubifs-utils/libubifs/debug.c           |  12 +-
 ubifs-utils/libubifs/debug.h           |   1 +
 8 files changed, 395 insertions(+), 65 deletions(-)
 create mode 100644 ubifs-utils/fsck.ubifs/check_files.c

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index b7ee3de4..e12052ce 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -83,7 +83,8 @@ fsck_ubifs_SOURCES = \
 	ubifs-utils/fsck.ubifs/problem.c \
 	ubifs-utils/fsck.ubifs/load_fs.c \
 	ubifs-utils/fsck.ubifs/extract_files.c \
-	ubifs-utils/fsck.ubifs/rebuild_fs.c
+	ubifs-utils/fsck.ubifs/rebuild_fs.c \
+	ubifs-utils/fsck.ubifs/check_files.c
 
 fsck_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm -lpthread
 fsck_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
diff --git a/ubifs-utils/fsck.ubifs/check_files.c b/ubifs-utils/fsck.ubifs/check_files.c
new file mode 100644
index 00000000..982c05b7
--- /dev/null
+++ b/ubifs-utils/fsck.ubifs/check_files.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Huawei Technologies Co, Ltd.
+ *
+ * Authors: Zhihao Cheng <chengzhihao1@huawei.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "bitops.h"
+#include "kmem.h"
+#include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
+#include "fsck.ubifs.h"
+
+struct invalid_node {
+	union ubifs_key key;
+	int lnum;
+	int offs;
+	struct list_head list;
+};
+
+struct iteration_info {
+	struct list_head invalid_nodes;
+};
+
+static int add_invalid_node(struct ubifs_info *c, union ubifs_key *key,
+			    int lnum, int offs, struct iteration_info *iter)
+{
+	struct invalid_node *in;
+
+	in = kmalloc(sizeof(struct invalid_node), GFP_KERNEL);
+	if (!in) {
+		log_err(c, errno, "can not allocate invalid node");
+		return -ENOMEM;
+	}
+
+	key_copy(c, key, &in->key);
+	in->lnum = lnum;
+	in->offs = offs;
+	list_add(&in->list, &iter->invalid_nodes);
+
+	return 0;
+}
+
+static int construct_file(struct ubifs_info *c, union ubifs_key *key,
+			  int lnum, int offs, void *node,
+			  struct iteration_info *iter)
+{
+	ino_t inum = 0;
+	struct rb_root *tree = &FSCK(c)->scanned_files;
+	struct scanned_node *sn = NULL;
+	struct ubifs_ch *ch = (struct ubifs_ch *)node;
+
+	switch (ch->node_type) {
+	case UBIFS_INO_NODE:
+	{
+		struct scanned_ino_node ino_node;
+
+		if (!parse_ino_node(c, lnum, offs, node, key, &ino_node)) {
+			if (fix_problem(c, INVALID_INO_NODE, NULL))
+				return add_invalid_node(c, key, lnum, offs, iter);
+		}
+		inum = key_inum(c, key);
+		sn = (struct scanned_node *)&ino_node;
+		break;
+	}
+	case UBIFS_DENT_NODE:
+	case UBIFS_XENT_NODE:
+	{
+		struct scanned_dent_node dent_node;
+
+		if (!parse_dent_node(c, lnum, offs, node, key, &dent_node)) {
+			if (fix_problem(c, INVALID_DENT_NODE, NULL))
+				return add_invalid_node(c, key, lnum, offs, iter);
+		}
+		inum = dent_node.inum;
+		sn = (struct scanned_node *)&dent_node;
+		break;
+	}
+	case UBIFS_DATA_NODE:
+	{
+		struct scanned_data_node data_node;
+
+		if (!parse_data_node(c, lnum, offs, node, key, &data_node)) {
+			if (fix_problem(c, INVALID_DATA_NODE, NULL))
+				return add_invalid_node(c, key, lnum, offs, iter);
+		}
+		inum = key_inum(c, key);
+		sn = (struct scanned_node *)&data_node;
+		break;
+	}
+	default:
+		ubifs_assert(c, 0);
+	}
+
+	dbg_fsck("construct file(%lu) for %s node, TNC location %d:%d, in %s",
+		 inum, ubifs_get_key_name(key_type(c, key)), sn->lnum, sn->offs,
+		 c->dev_name);
+	return insert_or_update_file(c, tree, sn, key_type(c, key), inum);
+}
+
+static int check_leaf(struct ubifs_info *c, struct ubifs_zbranch *zbr,
+		      void *priv)
+{
+	void *node;
+	struct iteration_info *iter = (struct iteration_info *)priv;
+	union ubifs_key *key = &zbr->key;
+	int lnum = zbr->lnum, offs = zbr->offs, len = zbr->len, err = 0;
+
+	if (len < UBIFS_CH_SZ) {
+		ubifs_err(c, "bad leaf length %d (LEB %d:%d)",
+			  len, lnum, offs);
+		set_failure_reason_callback(c, FR_TNC_CORRUPTED);
+		return -EINVAL;
+	}
+	if (key_type(c, key) != UBIFS_INO_KEY &&
+	    key_type(c, key) != UBIFS_DATA_KEY &&
+	    key_type(c, key) != UBIFS_DENT_KEY &&
+	    key_type(c, key) != UBIFS_XENT_KEY) {
+		ubifs_err(c, "bad key type %d (LEB %d:%d)",
+			  key_type(c, key), lnum, offs);
+		set_failure_reason_callback(c, FR_TNC_CORRUPTED);
+		return -EINVAL;
+	}
+
+	node = kmalloc(len, GFP_NOFS);
+	if (!node)
+		return -ENOMEM;
+
+	err = ubifs_tnc_read_node(c, zbr, node);
+	if (err) {
+		if (test_and_clear_failure_reason_callback(c, FR_DATA_CORRUPTED)) {
+			if (fix_problem(c, TNC_DATA_CORRUPTED, NULL))
+				err = add_invalid_node(c, key, lnum, offs, iter);
+		}
+		goto out;
+	}
+
+	err = construct_file(c, key, lnum, offs, node, iter);
+
+out:
+	kfree(node);
+	return err;
+}
+
+static int remove_invalid_nodes(struct ubifs_info *c,
+				struct list_head *invalid_nodes, int error)
+{
+	int ret = 0;;
+	struct invalid_node *in;
+
+	while (!list_empty(invalid_nodes)) {
+		in = list_entry(invalid_nodes->next, struct invalid_node, list);
+
+		if (!error) {
+			error = ubifs_tnc_remove_node(c, &in->key, in->lnum, in->offs);
+			if (error) {
+				/* TNC traversing is finished, any TNC path is accessible */
+				ubifs_assert(c, !get_failure_reason_callback(c));
+				ret = error;
+			}
+		}
+
+		list_del(&in->list);
+		kfree(in);
+	}
+
+	return ret;
+}
+
+/**
+ * traverse_tnc_and_construct_files - traverse TNC and construct all files.
+ * @c: UBIFS file-system description object
+ *
+ * This function checks all index nodes and non-index nodes by traversing TNC,
+ * then construct file according to scanned non-index nodes and insert file
+ * into file tree. Returns zero in case of success, a negative error code in
+ * case of failure.
+ */
+int traverse_tnc_and_construct_files(struct ubifs_info *c)
+{
+	int err, ret;
+	struct iteration_info iter;
+
+	FSCK(c)->scanned_files = RB_ROOT;
+	INIT_LIST_HEAD(&iter.invalid_nodes);
+
+	err = dbg_walk_index(c, check_leaf, NULL, &iter);
+
+	ret = remove_invalid_nodes(c, &iter.invalid_nodes, err);
+	if (!err)
+		err = ret;
+
+	if (err)
+		destroy_file_tree(c, &FSCK(c)->scanned_files);
+	return err;
+}
diff --git a/ubifs-utils/fsck.ubifs/extract_files.c b/ubifs-utils/fsck.ubifs/extract_files.c
index c3ab2b76..e9c71a3c 100644
--- a/ubifs-utils/fsck.ubifs/extract_files.c
+++ b/ubifs-utils/fsck.ubifs/extract_files.c
@@ -74,15 +74,24 @@ bool parse_ino_node(struct ubifs_info *c, int lnum, int offs, void *node,
 	ino_t inum = key_inum(c, key);
 
 	if (!inum || inum > INUM_WATERMARK) {
-		dbg_fsck("bad inode node(bad inum %lu) at %d:%d, in %s",
-			 inum, lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad inode node(bad inum %lu) at %d:%d, in %s",
+				 inum, lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad inode node(bad inum %lu) at %d:%d",
+				inum, lnum, offs);
 		goto out;
 	}
 
 	if (ch->node_type != key_type(c, key)) {
-		dbg_fsck("bad inode node %lu(inconsistent node type %d vs key_type %d) at %d:%d, in %s",
-			 inum, ch->node_type, key_type(c, key),
-			 lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad inode node %lu(inconsistent node type %d vs key_type %d) at %d:%d, in %s",
+				 inum, ch->node_type, key_type(c, key),
+				 lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad inode node %lu(inconsistent node type %d vs key_type %d) at %d:%d",
+				inum, ch->node_type, key_type(c, key),
+				lnum, offs);
 		goto out;
 	}
 
@@ -101,60 +110,101 @@ bool parse_ino_node(struct ubifs_info *c, int lnum, int offs, void *node,
 	ino_node->size = le64_to_cpu(ino->size);
 
 	if (inum == UBIFS_ROOT_INO && !S_ISDIR(ino_node->mode)) {
-		dbg_fsck("bad inode node %lu(root inode is not dir, tyoe %u) at %d:%d, in %s",
-			 inum, ino_node->mode & S_IFMT, lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad inode node %lu(root inode is not dir, tyoe %u) at %d:%d, in %s",
+				 inum, ino_node->mode & S_IFMT, lnum, offs,
+				 c->dev_name);
+		else
+			log_out(c, "bad inode node %lu(root inode is not dir, tyoe %u) at %d:%d",
+				inum, ino_node->mode & S_IFMT, lnum, offs);
 		goto out;
 	}
 
 	if (ino_node->size > c->max_inode_sz) {
-		dbg_fsck("bad inode node %lu(size %llu is too large) at %d:%d, in %s",
-			 inum, ino_node->size, lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad inode node %lu(size %llu is too large) at %d:%d, in %s",
+				 inum, ino_node->size, lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad inode node %lu(size %llu is too large) at %d:%d",
+				inum, ino_node->size, lnum, offs);
 		goto out;
 	}
 
 	if (le16_to_cpu(ino->compr_type) >= UBIFS_COMPR_TYPES_CNT) {
-		dbg_fsck("bad inode node %lu(unknown compression type %d) at %d:%d, in %s",
-			 inum, le16_to_cpu(ino->compr_type), lnum, offs,
-			 c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad inode node %lu(unknown compression type %d) at %d:%d, in %s",
+				 inum, le16_to_cpu(ino->compr_type), lnum, offs,
+				 c->dev_name);
+		else
+			log_out(c, "bad inode node %lu(unknown compression type %d) at %d:%d",
+				inum, le16_to_cpu(ino->compr_type), lnum, offs);
 		goto out;
 	}
 
 	if (ino_node->xnms + ino_node->xcnt > XATTR_LIST_MAX) {
-		dbg_fsck("bad inode node %lu(too big xnames %u xcount %u) at %d:%d, in %s",
-			 inum, ino_node->xnms, ino_node->xcnt,
-			 lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad inode node %lu(too big xnames %u xcount %u) at %d:%d, in %s",
+				 inum, ino_node->xnms, ino_node->xcnt,
+				 lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad inode node %lu(too big xnames %u xcount %u) at %d:%d",
+				inum, ino_node->xnms, ino_node->xcnt,
+				lnum, offs);
 		goto out;
 	}
 
 	if (data_len < 0 || data_len > UBIFS_MAX_INO_DATA) {
-		dbg_fsck("bad inode node %lu(invalid data len %d) at %d:%d, in %s",
-			 inum, data_len, lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad inode node %lu(invalid data len %d) at %d:%d, in %s",
+				 inum, data_len, lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad inode node %lu(invalid data len %d) at %d:%d",
+				inum, data_len, lnum, offs);
 		goto out;
 	}
 
 	if (UBIFS_INO_NODE_SZ + data_len != node_len) {
-		dbg_fsck("bad inode node %lu(inconsistent data len %d vs node len %d) at %d:%d, in %s",
-			 inum, data_len, node_len, lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad inode node %lu(inconsistent data len %d vs node len %d) at %d:%d, in %s",
+				 inum, data_len, node_len, lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad inode node %lu(inconsistent data len %d vs node len %d) at %d:%d",
+				inum, data_len, node_len, lnum, offs);
 		goto out;
 	}
 
 	if (ino_node->is_xattr) {
 		if (!S_ISREG(ino_node->mode)) {
-			dbg_fsck("bad inode node %lu(bad type %u for xattr) at %d:%d, in %s",
-				 inum, ino_node->mode & S_IFMT,
-				 lnum, offs, c->dev_name);
+			if (FSCK(c)->mode == REBUILD_MODE)
+				dbg_fsck("bad inode node %lu(bad type %u for xattr) at %d:%d, in %s",
+					 inum, ino_node->mode & S_IFMT,
+					 lnum, offs, c->dev_name);
+			else
+				log_out(c, "bad inode node %lu(bad type %u for xattr) at %d:%d",
+					inum, ino_node->mode & S_IFMT,
+					lnum, offs);
 			goto out;
 		}
 		if (data_len != ino_node->size) {
-			dbg_fsck("bad inode node %lu(inconsistent data_len %d vs size %llu for xattr) at %d:%d, in %s",
-				 inum, data_len, ino_node->size,
-				 lnum, offs, c->dev_name);
+			if (FSCK(c)->mode == REBUILD_MODE)
+				dbg_fsck("bad inode node %lu(inconsistent data_len %d vs size %llu for xattr) at %d:%d, in %s",
+					 inum, data_len, ino_node->size,
+					 lnum, offs, c->dev_name);
+			else
+				log_out(c, "bad inode node %lu(inconsistent data_len %d vs size %llu for xattr) at %d:%d",
+					inum, data_len, ino_node->size,
+					lnum, offs);
 			goto out;
 		}
 		if (ino_node->xcnt || ino_node->xsz || ino_node->xnms) {
-			dbg_fsck("bad inode node %lu(non zero xattr count %u xattr size %u xattr names %u for xattr) at %d:%d, in %s",
-				 inum, ino_node->xcnt, ino_node->xsz,
-				 ino_node->xnms, lnum, offs, c->dev_name);
+			if (FSCK(c)->mode == REBUILD_MODE)
+				dbg_fsck("bad inode node %lu(non zero xattr count %u xattr size %u xattr names %u for xattr) at %d:%d, in %s",
+					 inum, ino_node->xcnt, ino_node->xsz,
+					 ino_node->xnms, lnum, offs, c->dev_name);
+			else
+				log_out(c, "bad inode node %lu(non zero xattr count %u xattr size %u xattr names %u for xattr) at %d:%d",
+					inum, ino_node->xcnt, ino_node->xsz,
+					ino_node->xnms, lnum, offs);
 			goto out;
 		}
 	}
@@ -162,15 +212,23 @@ bool parse_ino_node(struct ubifs_info *c, int lnum, int offs, void *node,
 	switch (ino_node->mode & S_IFMT) {
 	case S_IFREG:
 		if (!ino_node->is_xattr && data_len != 0) {
-			dbg_fsck("bad inode node %lu(bad data len %d for reg file) at %d:%d, in %s",
-				 inum, data_len, lnum, offs, c->dev_name);
+			if (FSCK(c)->mode == REBUILD_MODE)
+				dbg_fsck("bad inode node %lu(bad data len %d for reg file) at %d:%d, in %s",
+					 inum, data_len, lnum, offs, c->dev_name);
+			else
+				log_out(c, "bad inode node %lu(bad data len %d for reg file) at %d:%d",
+					inum, data_len, lnum, offs);
 			goto out;
 		}
 		break;
 	case S_IFDIR:
 		if (data_len != 0) {
-			dbg_fsck("bad inode node %lu(bad data len %d for dir file) at %d:%d, in %s",
-				 inum, data_len, lnum, offs, c->dev_name);
+			if (FSCK(c)->mode == REBUILD_MODE)
+				dbg_fsck("bad inode node %lu(bad data len %d for dir file) at %d:%d, in %s",
+					 inum, data_len, lnum, offs, c->dev_name);
+			else
+				log_out(c, "bad inode node %lu(bad data len %d for dir file) at %d:%d",
+					inum, data_len, lnum, offs);
 			goto out;
 		}
 		break;
@@ -187,8 +245,12 @@ bool parse_ino_node(struct ubifs_info *c, int lnum, int offs, void *node,
 			 * Just drop the inode node when above class of
 			 * exceptions are found.
 			 */
-			dbg_fsck("bad symlink inode node %lu(bad data len %d) at %d:%d, in %s",
-				 inum, data_len, lnum, offs, c->dev_name);
+			if (FSCK(c)->mode == REBUILD_MODE)
+				dbg_fsck("bad symlink inode node %lu(bad data len %d) at %d:%d, in %s",
+					 inum, data_len, lnum, offs, c->dev_name);
+			else
+				log_out(c, "bad symlink inode node %lu(bad data len %d) at %d:%d",
+					inum, data_len, lnum, offs);
 			goto out;
 		}
 		break;
@@ -200,9 +262,14 @@ bool parse_ino_node(struct ubifs_info *c, int lnum, int offs, void *node,
 		int sz_new = sizeof(dev->new), sz_huge = sizeof(dev->huge);
 
 		if (data_len != sz_new && data_len != sz_huge) {
-			dbg_fsck("bad inode node %lu(bad data len %d for char/block file, expect %d or %d) at %d:%d, in %s",
-				 inum, data_len, sz_new, sz_huge, lnum,
-				 offs, c->dev_name);
+			if (FSCK(c)->mode == REBUILD_MODE)
+				dbg_fsck("bad inode node %lu(bad data len %d for char/block file, expect %d or %d) at %d:%d, in %s",
+					 inum, data_len, sz_new, sz_huge, lnum,
+					 offs, c->dev_name);
+			else
+				log_out(c, "bad inode node %lu(bad data len %d for char/block file, expect %d or %d) at %d:%d",
+					inum, data_len, sz_new, sz_huge, lnum,
+					offs);
 			goto out;
 		}
 		break;
@@ -211,22 +278,35 @@ bool parse_ino_node(struct ubifs_info *c, int lnum, int offs, void *node,
 		fallthrough;
 	case S_IFIFO:
 		if (data_len != 0) {
-			dbg_fsck("bad inode node %lu(bad data len %d for fifo/sock file) at %d:%d, in %s",
-				 inum, data_len, lnum, offs, c->dev_name);
+			if (FSCK(c)->mode == REBUILD_MODE)
+				dbg_fsck("bad inode node %lu(bad data len %d for fifo/sock file) at %d:%d, in %s",
+					 inum, data_len, lnum, offs, c->dev_name);
+			else
+				log_out(c, "bad inode node %lu(bad data len %d for fifo/sock file) at %d:%d",
+					inum, data_len, lnum, offs);
 			goto out;
 		}
 		break;
 	default:
 		/* invalid file type. */
-		dbg_fsck("bad inode node %lu(unknown type %u) at %d:%d, in %s",
-			 inum, ino_node->mode & S_IFMT, lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad inode node %lu(unknown type %u) at %d:%d, in %s",
+				 inum, ino_node->mode & S_IFMT, lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad inode node %lu(unknown type %u) at %d:%d",
+				inum, ino_node->mode & S_IFMT, lnum, offs);
 		goto out;
 	}
 
 	if (ino_node->is_encrypted && !inode_can_be_encrypted(c, ino_node)) {
-		dbg_fsck("bad inode node %lu(encrypted but cannot be encrypted, type %u, is_xattr %d, fs_encrypted %d) at %d:%d, in %s",
-			 inum, ino_node->mode & S_IFMT, ino_node->is_xattr,
-			 c->encrypted, lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad inode node %lu(encrypted but cannot be encrypted, type %u, is_xattr %d, fs_encrypted %d) at %d:%d, in %s",
+				 inum, ino_node->mode & S_IFMT, ino_node->is_xattr,
+				 c->encrypted, lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad inode node %lu(encrypted but cannot be encrypted, type %u, is_xattr %d, fs_encrypted %d) at %d:%d",
+				inum, ino_node->mode & S_IFMT, ino_node->is_xattr,
+				c->encrypted, lnum, offs);
 		goto out;
 	}
 
@@ -272,10 +352,16 @@ bool parse_dent_node(struct ubifs_info *c, int lnum, int offs, void *node,
 	    (key_type == UBIFS_XENT_KEY &&
 	     strnlen((const char *)dent->name, nlen) != nlen) ||
 	    inum > INUM_WATERMARK || key_type != ch->node_type) {
-		dbg_fsck("bad %s node(len %d nlen %d type %d inum %lu key_type %d node_type %d) at %d:%d, in %s",
-			 ch->node_type == UBIFS_XENT_NODE ? "xattr entry" : "directory entry",
-			 node_len, nlen, dent->type, inum, key_type,
-			 ch->node_type, lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad %s node(len %d nlen %d type %d inum %lu key_type %d node_type %d) at %d:%d, in %s",
+				 ch->node_type == UBIFS_XENT_NODE ? "xattr entry" : "directory entry",
+				 node_len, nlen, dent->type, inum, key_type,
+				 ch->node_type, lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad %s node(len %d nlen %d type %d inum %lu key_type %d node_type %d) at %d:%d",
+				ch->node_type == UBIFS_XENT_NODE ? "xattr entry" : "directory entry",
+				node_len, nlen, dent->type, inum, key_type,
+				ch->node_type, lnum, offs);
 		goto out;
 	}
 
@@ -318,15 +404,23 @@ bool parse_data_node(struct ubifs_info *c, int lnum, int offs, void *node,
 	ino_t inum = key_inum(c, key);
 
 	if (ch->node_type != key_type(c, key)) {
-		dbg_fsck("bad data node(inconsistent node type %d vs key_type %d) at %d:%d, in %s",
-			 ch->node_type, key_type(c, key),
-			 lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad data node(inconsistent node type %d vs key_type %d) at %d:%d, in %s",
+				 ch->node_type, key_type(c, key),
+				 lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad data node(inconsistent node type %d vs key_type %d) at %d:%d",
+				ch->node_type, key_type(c, key), lnum, offs);
 		goto out;
 	}
 
 	if (!inum || inum > INUM_WATERMARK) {
-		dbg_fsck("bad data node(bad inum %lu) at %d:%d, in %s",
-			 inum, lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad data node(bad inum %lu) at %d:%d, in %s",
+				 inum, lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad data node(bad inum %lu) at %d:%d",
+				inum, lnum, offs);
 		goto out;
 	}
 
@@ -336,14 +430,22 @@ bool parse_data_node(struct ubifs_info *c, int lnum, int offs, void *node,
 	data_node->size = le32_to_cpu(dn->size);
 
 	if (!data_node->size || data_node->size > UBIFS_BLOCK_SIZE) {
-		dbg_fsck("bad data node(invalid size %u) at %d:%d, in %s",
-			 data_node->size, lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad data node(invalid size %u) at %d:%d, in %s",
+				 data_node->size, lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad data node(invalid size %u) at %d:%d",
+				data_node->size, lnum, offs);
 		goto out;
 	}
 
 	if (le16_to_cpu(dn->compr_type) >= UBIFS_COMPR_TYPES_CNT) {
-		dbg_fsck("bad data node(invalid compression type %d) at %d:%d, in %s",
-			 le16_to_cpu(dn->compr_type), lnum, offs, c->dev_name);
+		if (FSCK(c)->mode == REBUILD_MODE)
+			dbg_fsck("bad data node(invalid compression type %d) at %d:%d, in %s",
+				 le16_to_cpu(dn->compr_type), lnum, offs, c->dev_name);
+		else
+			log_out(c, "bad data node(invalid compression type %d) at %d:%d",
+				le16_to_cpu(dn->compr_type), lnum, offs);
 		goto out;
 	}
 
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 471c2cd9..c85e9147 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -434,7 +434,17 @@ void handle_error(const struct ubifs_info *c, int reason_set)
  */
 static int do_fsck(void)
 {
-	return 0;
+	int err;
+
+	log_out(c, "Traverse TNC and construct files");
+	err = traverse_tnc_and_construct_files(c);
+	if (err) {
+		handle_error(c, HAS_TNC_CORRUPTED);
+		return err;
+	}
+
+	destroy_file_tree(c, &FSCK(c)->scanned_files);
+	return err;
 }
 
 int main(int argc, char *argv[])
@@ -468,6 +478,9 @@ int main(int argc, char *argv[])
 		goto out_close;
 	}
 
+	/*
+	 * Step 6: Traverse tnc and construct files
+	 */
 	err = do_fsck();
 	if (err && FSCK(c)->try_rebuild) {
 		ubifs_destroy_filesystem(c);
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 109c3924..fe6070ac 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -38,7 +38,8 @@ enum { NORMAL_MODE = 0, SAFE_MODE, DANGER_MODE0,
 
 /* Types of inconsistent problems */
 enum { SB_CORRUPTED = 0, MST_CORRUPTED, LOG_CORRUPTED, BUD_CORRUPTED,
-       TNC_CORRUPTED, TNC_DATA_CORRUPTED, ORPHAN_CORRUPTED };
+       TNC_CORRUPTED, TNC_DATA_CORRUPTED, ORPHAN_CORRUPTED, INVALID_INO_NODE,
+       INVALID_DENT_NODE, INVALID_DATA_NODE };
 
 enum { HAS_DATA_CORRUPTED = 1, HAS_TNC_CORRUPTED = 2 };
 
@@ -295,4 +296,7 @@ int check_and_correct_files(struct ubifs_info *c);
 /* rebuild_fs.c */
 int ubifs_rebuild_filesystem(struct ubifs_info *c);
 
+/* check_files.c */
+int traverse_tnc_and_construct_files(struct ubifs_info *c);
+
 #endif
diff --git a/ubifs-utils/fsck.ubifs/problem.c b/ubifs-utils/fsck.ubifs/problem.c
index 9c8730a5..f99fd90e 100644
--- a/ubifs-utils/fsck.ubifs/problem.c
+++ b/ubifs-utils/fsck.ubifs/problem.c
@@ -42,6 +42,9 @@ static const struct fsck_problem problem_table[] = {
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA | PROBLEM_NEED_REBUILD, "Corrupted index node"},	// TNC_CORRUPTED
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Corrupted data searched from TNC"},	// TNC_DATA_CORRUPTED
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Corrupted orphan LEB"},	// ORPHAN_CORRUPTED
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Invalid inode node"},	// INVALID_INO_NODE
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Invalid dentry node"},	// INVALID_DENT_NODE
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Invalid data node"},	// INVALID_DATA_NODE
 };
 
 static const char *get_question(const struct fsck_problem *problem,
@@ -54,6 +57,9 @@ static const char *get_question(const struct fsck_problem *problem,
 	case BUD_CORRUPTED:
 		return "Drop bud?";
 	case TNC_DATA_CORRUPTED:
+	case INVALID_INO_NODE:
+	case INVALID_DENT_NODE:
+	case INVALID_DATA_NODE:
 		return "Drop it?";
 	case ORPHAN_CORRUPTED:
 		return "Drop orphans on the LEB?";
diff --git a/ubifs-utils/libubifs/debug.c b/ubifs-utils/libubifs/debug.c
index eaf403f9..836cbc74 100644
--- a/ubifs-utils/libubifs/debug.c
+++ b/ubifs-utils/libubifs/debug.c
@@ -51,7 +51,7 @@ static const char *get_key_hash(int hash)
 	}
 }
 
-static const char *get_key_type(int type)
+const char *ubifs_get_key_name(int type)
 {
 	switch (type) {
 	case UBIFS_INO_KEY:
@@ -102,23 +102,25 @@ const char *dbg_snprintf_key(const struct ubifs_info *c,
 		case UBIFS_INO_KEY:
 			len -= snprintf(p, len, "(%lu, %s)",
 					(unsigned long)key_inum(c, key),
-					get_key_type(type));
+					ubifs_get_key_name(type));
 			break;
 		case UBIFS_DENT_KEY:
 		case UBIFS_XENT_KEY:
 			len -= snprintf(p, len, "(%lu, %s, %#08x)",
 					(unsigned long)key_inum(c, key),
-					get_key_type(type), key_hash(c, key));
+					ubifs_get_key_name(type),
+					key_hash(c, key));
 			break;
 		case UBIFS_DATA_KEY:
 			len -= snprintf(p, len, "(%lu, %s, %u)",
 					(unsigned long)key_inum(c, key),
-					get_key_type(type), key_block(c, key));
+					ubifs_get_key_name(type),
+					key_block(c, key));
 			break;
 		case UBIFS_TRUN_KEY:
 			len -= snprintf(p, len, "(%lu, %s)",
 					(unsigned long)key_inum(c, key),
-					get_key_type(type));
+					ubifs_get_key_name(type));
 			break;
 		default:
 			len -= snprintf(p, len, "(bad key type: %#08x, %#08x)",
diff --git a/ubifs-utils/libubifs/debug.h b/ubifs-utils/libubifs/debug.h
index 400b4759..d015e62f 100644
--- a/ubifs-utils/libubifs/debug.h
+++ b/ubifs-utils/libubifs/debug.h
@@ -85,6 +85,7 @@ static inline int dbg_is_chk_index(__unused const struct ubifs_info *c)
 { return 0; }
 
 /* Dump functions */
+const char *ubifs_get_key_name(int type);
 const char *ubifs_get_type_name(int type);
 const char *dbg_ntype(int type);
 const char *dbg_cstate(int cmt_state);
-- 
2.13.6


