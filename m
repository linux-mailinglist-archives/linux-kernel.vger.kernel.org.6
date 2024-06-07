Return-Path: <linux-kernel+bounces-205349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074308FFAB8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA821F22736
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970915EFBB;
	Fri,  7 Jun 2024 04:27:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE215AAD7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734454; cv=none; b=AThRDEu8TBc42/ZlQALfLhck5+R5oBYufXrNuY03GhyREfV25T1c/0oXqvTqm6W1aPaUFZq3FjykcHPV70p0I4j+kWyL/l5l9yGZB+FtsAMjpA2EbMrfVRSrNYE0KXLtdsAS0P3pWsDoogTyx22YEhEWfhnwcqE9Buq2I3/NsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734454; c=relaxed/simple;
	bh=xcPTeib9Lx5xOfsFUh1HEcHjsqBeG8T2fBWhDlicY6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCzxOkwfHjCLi128DvIWR0aUKqakxIi26icpB7BXSKKSAcCvd33XbWMrcZlrhvHy3ntjBfkYcrU3k17IJDaqhB+2N+JbR9LCmBQRY2TnBbJ/L179KQ8h4LH+4LyK2pCEt4iEhh4GKgcZ+es+uB4G028nIQ4O9lORpoJwtFbRBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSjQ0khzzmYTR;
	Fri,  7 Jun 2024 12:22:50 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id E7F30180AA6;
	Fri,  7 Jun 2024 12:27:25 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:11 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 061/110] fsck.ubifs: Add node parsing functions
Date: Fri, 7 Jun 2024 12:25:26 +0800
Message-ID: <20240607042615.2069840-62-chengzhihao1@huawei.com>
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

Add parsing functions for each type of nodes, which will be used for
checking the validity of raw node data while reading from TNC or
scanning from UBIFS logical erase block.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am              |   3 +-
 ubifs-utils/fsck.ubifs/extract_files.c | 405 +++++++++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h    | 106 +++++++++
 ubifs-utils/libubifs/debug.h           |   2 +
 4 files changed, 515 insertions(+), 1 deletion(-)
 create mode 100644 ubifs-utils/fsck.ubifs/extract_files.c

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 864271ab..a0676a70 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -81,7 +81,8 @@ fsck_ubifs_SOURCES = \
 	ubifs-utils/fsck.ubifs/fsck.ubifs.h \
 	ubifs-utils/fsck.ubifs/fsck.ubifs.c \
 	ubifs-utils/fsck.ubifs/problem.c \
-	ubifs-utils/fsck.ubifs/load_fs.c
+	ubifs-utils/fsck.ubifs/load_fs.c \
+	ubifs-utils/fsck.ubifs/extract_files.c
 
 fsck_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm -lpthread
 fsck_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
diff --git a/ubifs-utils/fsck.ubifs/extract_files.c b/ubifs-utils/fsck.ubifs/extract_files.c
new file mode 100644
index 00000000..dd52ef84
--- /dev/null
+++ b/ubifs-utils/fsck.ubifs/extract_files.c
@@ -0,0 +1,405 @@
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
+#include <sys/stat.h>
+
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
+#include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
+#include "misc.h"
+#include "fsck.ubifs.h"
+
+static void parse_node_header(int lnum, int offs, int len,
+			      unsigned long long sqnum,
+			      struct scanned_node *header)
+{
+	header->exist = true;
+	header->lnum = lnum;
+	header->offs = offs;
+	header->len = len;
+	header->sqnum = sqnum;
+}
+
+static inline bool inode_can_be_encrypted(struct ubifs_info *c,
+					  struct scanned_ino_node *ino_node)
+{
+	if (!c->encrypted)
+		return false;
+
+	if (ino_node->is_xattr)
+		return false;
+
+	/* Only regular files, directories, and symlinks can be encrypted. */
+	if (S_ISREG(ino_node->mode) || S_ISDIR(ino_node->mode) ||
+	    S_ISLNK(ino_node->mode))
+		return true;
+
+	return false;
+}
+
+/**
+ * parse_ino_node - parse inode node and check it's validity.
+ * @c: UBIFS file-system description object
+ * @lnum: logical eraseblock number
+ * @offs: the offset in LEB of the raw inode node
+ * @node: raw node
+ * @key: key of node scanned (if it has one)
+ * @ino_node: node used to store raw inode information
+ *
+ * This function checks the raw inode information, and stores inode
+ * information into @ino_node. Returns %true if the inode is valid,
+ * otherwise %false is returned.
+ */
+bool parse_ino_node(struct ubifs_info *c, int lnum, int offs, void *node,
+		    union ubifs_key *key, struct scanned_ino_node *ino_node)
+{
+	bool valid = false;
+	int data_len, node_len;
+	unsigned int flags;
+	unsigned long long sqnum;
+	struct ubifs_ch *ch = (struct ubifs_ch *)node;
+	struct ubifs_ino_node *ino = (struct ubifs_ino_node *)node;
+	ino_t inum = key_inum(c, key);
+
+	if (!inum || inum > INUM_WATERMARK) {
+		dbg_fsck("bad inode node(bad inum %lu) at %d:%d, in %s",
+			 inum, lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	if (ch->node_type != key_type(c, key)) {
+		dbg_fsck("bad inode node %lu(inconsistent node type %d vs key_type %d) at %d:%d, in %s",
+			 inum, ch->node_type, key_type(c, key),
+			 lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	node_len = le32_to_cpu(ch->len);
+	sqnum = le64_to_cpu(ch->sqnum);
+	key_copy(c, key, &ino_node->key);
+	flags = le32_to_cpu(ino->flags);
+	data_len = le32_to_cpu(ino->data_len);
+	ino_node->is_xattr = !!(flags & UBIFS_XATTR_FL) ? 1 : 0;
+	ino_node->is_encrypted = !!(flags & UBIFS_CRYPT_FL) ? 1 : 0;
+	ino_node->mode = le32_to_cpu(ino->mode);
+	ino_node->nlink = le32_to_cpu(ino->nlink);
+	ino_node->xcnt = le32_to_cpu(ino->xattr_cnt);
+	ino_node->xsz = le32_to_cpu(ino->xattr_size);
+	ino_node->xnms = le32_to_cpu(ino->xattr_names);
+	ino_node->size = le64_to_cpu(ino->size);
+
+	if (inum == UBIFS_ROOT_INO && !S_ISDIR(ino_node->mode)) {
+		dbg_fsck("bad inode node %lu(root inode is not dir, tyoe %u) at %d:%d, in %s",
+			 inum, ino_node->mode & S_IFMT, lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	if (ino_node->size > c->max_inode_sz) {
+		dbg_fsck("bad inode node %lu(size %llu is too large) at %d:%d, in %s",
+			 inum, ino_node->size, lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	if (le16_to_cpu(ino->compr_type) >= UBIFS_COMPR_TYPES_CNT) {
+		dbg_fsck("bad inode node %lu(unknown compression type %d) at %d:%d, in %s",
+			 inum, le16_to_cpu(ino->compr_type), lnum, offs,
+			 c->dev_name);
+		goto out;
+	}
+
+	if (ino_node->xnms + ino_node->xcnt > XATTR_LIST_MAX) {
+		dbg_fsck("bad inode node %lu(too big xnames %u xcount %u) at %d:%d, in %s",
+			 inum, ino_node->xnms, ino_node->xcnt,
+			 lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	if (data_len < 0 || data_len > UBIFS_MAX_INO_DATA) {
+		dbg_fsck("bad inode node %lu(invalid data len %d) at %d:%d, in %s",
+			 inum, data_len, lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	if (UBIFS_INO_NODE_SZ + data_len != node_len) {
+		dbg_fsck("bad inode node %lu(inconsistent data len %d vs node len %d) at %d:%d, in %s",
+			 inum, data_len, node_len, lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	if (ino_node->is_xattr) {
+		if (!S_ISREG(ino_node->mode)) {
+			dbg_fsck("bad inode node %lu(bad type %u for xattr) at %d:%d, in %s",
+				 inum, ino_node->mode & S_IFMT,
+				 lnum, offs, c->dev_name);
+			goto out;
+		}
+		if (data_len != ino_node->size) {
+			dbg_fsck("bad inode node %lu(inconsistent data_len %d vs size %llu for xattr) at %d:%d, in %s",
+				 inum, data_len, ino_node->size,
+				 lnum, offs, c->dev_name);
+			goto out;
+		}
+		if (ino_node->xcnt || ino_node->xsz || ino_node->xnms) {
+			dbg_fsck("bad inode node %lu(non zero xattr count %u xattr size %u xattr names %u for xattr) at %d:%d, in %s",
+				 inum, ino_node->xcnt, ino_node->xsz,
+				 ino_node->xnms, lnum, offs, c->dev_name);
+			goto out;
+		}
+	}
+
+	switch (ino_node->mode & S_IFMT) {
+	case S_IFREG:
+		if (!ino_node->is_xattr && data_len != 0) {
+			dbg_fsck("bad inode node %lu(bad data len %d for reg file) at %d:%d, in %s",
+				 inum, data_len, lnum, offs, c->dev_name);
+			goto out;
+		}
+		break;
+	case S_IFDIR:
+		if (data_len != 0) {
+			dbg_fsck("bad inode node %lu(bad data len %d for dir file) at %d:%d, in %s",
+				 inum, data_len, lnum, offs, c->dev_name);
+			goto out;
+		}
+		break;
+	case S_IFLNK:
+		if (data_len == 0) {
+			/*
+			 * For encryption enabled or selinux enabled situation,
+			 * uninitialized inode with xattrs could be written
+			 * before ubifs_jnl_update(). If the dent node is
+			 * written successfully but the initialized inode is
+			 * not written, ubifs_iget() will get bad symlink inode
+			 * with 'ui->data_len = 0'. Similar phenomenon can also
+			 * occur for block/char dev creation.
+			 * Just drop the inode node when above class of
+			 * exceptions are found.
+			 */
+			dbg_fsck("bad symlink inode node %lu(bad data len %d) at %d:%d, in %s",
+				 inum, data_len, lnum, offs, c->dev_name);
+			goto out;
+		}
+		break;
+	case S_IFBLK:
+		fallthrough;
+	case S_IFCHR:
+	{
+		union ubifs_dev_desc *dev = (union ubifs_dev_desc *)ino->data;
+		int sz_new = sizeof(dev->new), sz_huge = sizeof(dev->huge);
+
+		if (data_len != sz_new && data_len != sz_huge) {
+			dbg_fsck("bad inode node %lu(bad data len %d for char/block file, expect %d or %d) at %d:%d, in %s",
+				 inum, data_len, sz_new, sz_huge, lnum,
+				 offs, c->dev_name);
+			goto out;
+		}
+		break;
+	}
+	case S_IFSOCK:
+		fallthrough;
+	case S_IFIFO:
+		if (data_len != 0) {
+			dbg_fsck("bad inode node %lu(bad data len %d for fifo/sock file) at %d:%d, in %s",
+				 inum, data_len, lnum, offs, c->dev_name);
+			goto out;
+		}
+		break;
+	default:
+		/* invalid file type. */
+		dbg_fsck("bad inode node %lu(unknown type %u) at %d:%d, in %s",
+			 inum, ino_node->mode & S_IFMT, lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	if (ino_node->is_encrypted && !inode_can_be_encrypted(c, ino_node)) {
+		dbg_fsck("bad inode node %lu(encrypted but cannot be encrypted, type %u, is_xattr %d, fs_encrypted %d) at %d:%d, in %s",
+			 inum, ino_node->mode & S_IFMT, ino_node->is_xattr,
+			 c->encrypted, lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	valid = true;
+	parse_node_header(lnum, offs, node_len, sqnum, &ino_node->header);
+
+out:
+	return valid;
+}
+
+/**
+ * parse_dent_node - parse dentry node and check it's validity.
+ * @c: UBIFS file-system description object
+ * @lnum: logical eraseblock number
+ * @offs: the offset in LEB of the raw inode node
+ * @node: raw node
+ * @key: key of node scanned (if it has one)
+ * @dent_node: node used to store raw dentry information
+ *
+ * This function checks the raw dentry/(xattr entry) information, and
+ * stores dentry/(xattr entry) information into @dent_node. Returns
+ * %true if the entry is valid, otherwise %false is returned.
+ */
+bool parse_dent_node(struct ubifs_info *c, int lnum, int offs, void *node,
+		     union ubifs_key *key, struct scanned_dent_node *dent_node)
+{
+	bool valid = false;
+	int node_len, nlen;
+	unsigned long long sqnum;
+	struct ubifs_ch *ch = (struct ubifs_ch *)node;
+	struct ubifs_dent_node *dent = (struct ubifs_dent_node *)node;
+	int key_type = key_type_flash(c, dent->key);
+	ino_t inum;
+
+	nlen = le16_to_cpu(dent->nlen);
+	node_len = le32_to_cpu(ch->len);
+	sqnum = le64_to_cpu(ch->sqnum);
+	inum = le64_to_cpu(dent->inum);
+
+	if (node_len != nlen + UBIFS_DENT_NODE_SZ + 1 ||
+	    dent->type >= UBIFS_ITYPES_CNT ||
+	    nlen > UBIFS_MAX_NLEN || dent->name[nlen] != 0 ||
+	    (key_type == UBIFS_XENT_KEY &&
+	     strnlen((const char *)dent->name, nlen) != nlen) ||
+	    inum > INUM_WATERMARK || key_type != ch->node_type) {
+		dbg_fsck("bad %s node(len %d nlen %d type %d inum %lu key_type %d node_type %d) at %d:%d, in %s",
+			 ch->node_type == UBIFS_XENT_NODE ? "xattr entry" : "directory entry",
+			 node_len, nlen, dent->type, inum, key_type,
+			 ch->node_type, lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	key_copy(c, key, &dent_node->key);
+	dent_node->can_be_found = false;
+	dent_node->type = dent->type;
+	dent_node->nlen = nlen;
+	memcpy(dent_node->name, dent->name, nlen);
+	dent_node->name[nlen] = '\0';
+	dent_node->inum = inum;
+
+	valid = true;
+	parse_node_header(lnum, offs, node_len, sqnum, &dent_node->header);
+
+out:
+	return valid;
+}
+
+/**
+ * parse_data_node - parse data node and check it's validity.
+ * @c: UBIFS file-system description object
+ * @lnum: logical eraseblock number
+ * @offs: the offset in LEB of the raw data node
+ * @node: raw node
+ * @key: key of node scanned (if it has one)
+ * @ino_node: node used to store raw data information
+ *
+ * This function checks the raw data node information, and stores
+ * data node information into @data_node. Returns %true if the data
+ * node is valid, otherwise %false is returned.
+ */
+bool parse_data_node(struct ubifs_info *c, int lnum, int offs, void *node,
+		     union ubifs_key *key, struct scanned_data_node *data_node)
+{
+	bool valid = false;
+	int node_len;
+	unsigned long long sqnum;
+	struct ubifs_ch *ch = (struct ubifs_ch *)node;
+	struct ubifs_data_node *dn = (struct ubifs_data_node *)node;
+	ino_t inum = key_inum(c, key);
+
+	if (ch->node_type != key_type(c, key)) {
+		dbg_fsck("bad data node(inconsistent node type %d vs key_type %d) at %d:%d, in %s",
+			 ch->node_type, key_type(c, key),
+			 lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	if (!inum || inum > INUM_WATERMARK) {
+		dbg_fsck("bad data node(bad inum %lu) at %d:%d, in %s",
+			 inum, lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	node_len = le32_to_cpu(ch->len);
+	sqnum = le64_to_cpu(ch->sqnum);
+	key_copy(c, key, &data_node->key);
+	data_node->size = le32_to_cpu(dn->size);
+
+	if (!data_node->size || data_node->size > UBIFS_BLOCK_SIZE) {
+		dbg_fsck("bad data node(invalid size %u) at %d:%d, in %s",
+			 data_node->size, lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	if (le16_to_cpu(dn->compr_type) >= UBIFS_COMPR_TYPES_CNT) {
+		dbg_fsck("bad data node(invalid compression type %d) at %d:%d, in %s",
+			 le16_to_cpu(dn->compr_type), lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	valid = true;
+	parse_node_header(lnum, offs, node_len, sqnum, &data_node->header);
+
+out:
+	return valid;
+}
+
+/**
+ * parse_trun_node - parse truncation node and check it's validity.
+ * @c: UBIFS file-system description object
+ * @lnum: logical eraseblock number
+ * @offs: the offset in LEB of the raw truncation node
+ * @node: raw node
+ * @key: key of node scanned (if it has one)
+ * @trun_node: node used to store raw truncation information
+ *
+ * This function checks the raw truncation information, and stores
+ * truncation information into @trun_node. Returns %true if the
+ * truncation is valid, otherwise %false is returned.
+ */
+bool parse_trun_node(struct ubifs_info *c, int lnum, int offs, void *node,
+		     union ubifs_key *key, struct scanned_trun_node *trun_node)
+{
+	bool valid = false;
+	int node_len;
+	unsigned long long sqnum;
+	struct ubifs_ch *ch = (struct ubifs_ch *)node;
+	struct ubifs_trun_node *trun = (struct ubifs_trun_node *)node;
+	loff_t old_size = le64_to_cpu(trun->old_size);
+	loff_t new_size = le64_to_cpu(trun->new_size);
+	ino_t inum = le32_to_cpu(trun->inum);
+
+	if (!inum || inum > INUM_WATERMARK) {
+		dbg_fsck("bad truncation node(bad inum %lu) at %d:%d, in %s",
+			 inum, lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	node_len = le32_to_cpu(ch->len);
+	sqnum = le64_to_cpu(ch->sqnum);
+	trun_node->new_size = new_size;
+
+	if (old_size < 0 || old_size > c->max_inode_sz ||
+	    new_size < 0 || new_size > c->max_inode_sz ||
+	    old_size <= new_size) {
+		dbg_fsck("bad truncation node(new size %ld old size %ld inum %lu) at %d:%d, in %s",
+			 new_size, old_size, inum, lnum, offs, c->dev_name);
+		goto out;
+	}
+
+	trun_key_init(c, key, inum);
+	valid = true;
+	parse_node_header(lnum, offs, node_len, sqnum, &trun_node->header);
+
+out:
+	return valid;
+}
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index eb365b1a..3511d90e 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -40,6 +40,102 @@ enum { NORMAL_MODE = 0, SAFE_MODE, DANGER_MODE0,
 enum { SB_CORRUPTED = 0 };
 
 /**
+ * scanned_node - common header node.
+ * @exist: whether the node is found by scanning
+ * @lnum: LEB number of the scanned node
+ * @offs: scanned node's offset within @lnum
+ * @len: length of scanned node
+ * @sqnum: sequence number
+ */
+struct scanned_node {
+	bool exist;
+	int lnum;
+	int offs;
+	int len;
+	unsigned long long sqnum;
+};
+
+/**
+ * scanned_ino_node - scanned inode node.
+ * @header: common header of scanned node
+ * @key: the key of inode node
+ * @is_xattr: %1 for xattr inode, otherwise %0
+ * @is_encrypted: %1 for encrypted inode, otherwise %0
+ * @mode: file mode
+ * @nlink: number of hard links
+ * @xcnt: count of extended attributes this inode has
+ * @xsz: summarized size of all extended attributes in bytes
+ * @xnms: sum of lengths of all extended attribute names
+ * @size: inode size in bytes
+ * @rb: link in the tree of valid inode nodes or deleted inode nodes
+ */
+struct scanned_ino_node {
+	struct scanned_node header;
+	union ubifs_key key;
+	unsigned int is_xattr:1;
+	unsigned int is_encrypted:1;
+	unsigned int mode;
+	unsigned int nlink;
+	unsigned int xcnt;
+	unsigned int xsz;
+	unsigned int xnms;
+	unsigned long long size;
+	struct rb_node rb;
+};
+
+/**
+ * scanned_dent_node - scanned dentry node.
+ * @header: common header of scanned node
+ * @key: the key of dentry node
+ * @can_be_found: whether this dentry can be found from '/'
+ * @type: file type, reg/dir/symlink/block/char/fifo/sock
+ * @nlen: name length
+ * @name: dentry name
+ * @inum: target inode number
+ * @rb: link in the trees of:
+ *  1) valid dentry nodes or deleted dentry node
+ *  2) all scanned dentry nodes from same file
+ * @list: link in the list dentries for looking up/deleting
+ */
+struct scanned_dent_node {
+	struct scanned_node header;
+	union ubifs_key key;
+	bool can_be_found;
+	unsigned int type;
+	unsigned int nlen;
+	char name[UBIFS_MAX_NLEN + 1];
+	ino_t inum;
+	struct rb_node rb;
+	struct list_head list;
+};
+
+/**
+ * scanned_data_node - scanned data node.
+ * @header: common header of scanned node
+ * @key: the key of data node
+ * @size: uncompressed data size in bytes
+ * @rb: link in the tree of all scanned data nodes from same file
+ * @list: link in the list for deleting
+ */
+struct scanned_data_node {
+	struct scanned_node header;
+	union ubifs_key key;
+	unsigned int size;
+	struct rb_node rb;
+	struct list_head list;
+};
+
+/**
+ * scanned_trun_node - scanned truncation node.
+ * @header: common header of scanned node
+ * @new_size: size after truncation
+ */
+struct scanned_trun_node {
+	struct scanned_node header;
+	unsigned long long new_size;
+};
+
+/**
  * struct ubifs_fsck_info - UBIFS fsck information.
  * @mode: working mode
  * @failure_reason: reasons for failed operations
@@ -103,4 +199,14 @@ bool fix_problem(const struct ubifs_info *c, int problem_type);
 int ubifs_load_filesystem(struct ubifs_info *c);
 void ubifs_destroy_filesystem(struct ubifs_info *c);
 
+/* extract_files.c */
+bool parse_ino_node(struct ubifs_info *c, int lnum, int offs, void *node,
+		    union ubifs_key *key, struct scanned_ino_node *ino_node);
+bool parse_dent_node(struct ubifs_info *c, int lnum, int offs, void *node,
+		     union ubifs_key *key, struct scanned_dent_node *dent_node);
+bool parse_data_node(struct ubifs_info *c, int lnum, int offs, void *node,
+		     union ubifs_key *key, struct scanned_data_node *data_node);
+bool parse_trun_node(struct ubifs_info *c, int lnum, int offs, void *node,
+		     union ubifs_key *key, struct scanned_trun_node *trun_node);
+
 #endif
diff --git a/ubifs-utils/libubifs/debug.h b/ubifs-utils/libubifs/debug.h
index 3a553627..8da79f80 100644
--- a/ubifs-utils/libubifs/debug.h
+++ b/ubifs-utils/libubifs/debug.h
@@ -78,6 +78,8 @@ void ubifs_assert_failed(struct ubifs_info *c, const char *expr,
 #define dbg_scan(fmt, ...)  ubifs_dbg_msg("scan", fmt, ##__VA_ARGS__)
 /* Additional recovery messages */
 #define dbg_rcvry(fmt, ...) ubifs_dbg_msg("rcvry", fmt, ##__VA_ARGS__)
+/* Additional fsck messages */
+#define dbg_fsck(fmt, ...) ubifs_dbg_msg("fsck", fmt, ##__VA_ARGS__)
 
 static inline int dbg_is_chk_index(__unused const struct ubifs_info *c)
 { return 0; }
-- 
2.13.6


