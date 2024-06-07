Return-Path: <linux-kernel+bounces-205343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E08FFAAF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328221F2624C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773F215B963;
	Fri,  7 Jun 2024 04:27:35 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD715AD83
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734453; cv=none; b=lRZ5uw9gmp0jDlhJKpX93d6FkL/qSxIDaQYSJS3c+N885sN5z1SLbe4eALSjMGQrng1mV7IsibkOYTlWPquFXMg2d9Ug2BVx114jGkdAMmThTcL9JCi45QJrWlfxtH58M7S3n/TyKE5LUEos/uUolGYnRfrWxOXe5/fGgq6P/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734453; c=relaxed/simple;
	bh=S2S5g5OZb9+C3rfD4VFpTAAEqY1+QRFmAQ/CCydTFo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loMiVS5PeKNGdYyTRU9Kx32t4DhKF7QvoYVUGqnbnhy8eAUr2T9SleYpYEmToxco9ETE5vMYOZxGLtgTvFVbGp9ORffzGBrFLz3gzIHIaFXN6qu2pj9PimAwcy+LpiHMCewgXDHo6DADAw6lacCbQ90YrzozVUGdlB+dsInm1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwSkt5X8hzPpnM;
	Fri,  7 Jun 2024 12:24:06 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 13412180AA6;
	Fri,  7 Jun 2024 12:27:26 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:13 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 063/110] fsck.ubifs: Add rebuilding filesystem support
Date: Fri, 7 Jun 2024 12:25:28 +0800
Message-ID: <20240607042615.2069840-64-chengzhihao1@huawei.com>
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

Add rebuilding filesystem support. This is the 1/12 step of rebuilding.
Collect files, valid inode nodes, deleted inode nodes, valid dentry
nodes and deleted dentry nodes in kinds of trees by scanning nodes from
flash. Corrupted nodes(eg. incorrect crc, bad inode size, bad dentry
name length, etc.) are dropped during scanning. Larger sqnum node is
picked when more than 1 nodes with same index.
In this step, trun node and data nodes are put into corresponding file,
inode/dentry nodes are put into four trees: valid_inos(nlink != 0),
del_inos(nlink is 0), valid_dents(inum != 0), del_dents(inum is 0).
Next step will process above four trees to deal deletion situations.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am           |   3 +-
 ubifs-utils/fsck.ubifs/fsck.ubifs.c |  12 +-
 ubifs-utils/fsck.ubifs/fsck.ubifs.h |  15 ++
 ubifs-utils/fsck.ubifs/rebuild_fs.c | 399 ++++++++++++++++++++++++++++++++++++
 4 files changed, 426 insertions(+), 3 deletions(-)
 create mode 100644 ubifs-utils/fsck.ubifs/rebuild_fs.c

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index a0676a70..b7ee3de4 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -82,7 +82,8 @@ fsck_ubifs_SOURCES = \
 	ubifs-utils/fsck.ubifs/fsck.ubifs.c \
 	ubifs-utils/fsck.ubifs/problem.c \
 	ubifs-utils/fsck.ubifs/load_fs.c \
-	ubifs-utils/fsck.ubifs/extract_files.c
+	ubifs-utils/fsck.ubifs/extract_files.c \
+	ubifs-utils/fsck.ubifs/rebuild_fs.c
 
 fsck_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm -lpthread
 fsck_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 9bc9c259..683d7c27 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -425,12 +425,20 @@ int main(int argc, char *argv[])
 
 	/* Init: Read superblock */
 	err = ubifs_load_filesystem(c);
-	if (err)
+	if (err) {
+		if (FSCK(c)->try_rebuild)
+			ubifs_rebuild_filesystem(c);
 		goto out_close;
+	}
 
 	err = do_fsck();
+	if (err && FSCK(c)->try_rebuild) {
+		ubifs_destroy_filesystem(c);
+		ubifs_rebuild_filesystem(c);
+	} else {
+		ubifs_destroy_filesystem(c);
+	}
 
-	ubifs_destroy_filesystem(c);
 out_close:
 	ubifs_close_volume(c);
 out_destroy_fsck:
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 80d3af84..c6c21e99 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -175,16 +175,28 @@ struct scanned_file {
 };
 
 /**
+ * ubifs_rebuild_info - UBIFS rebuilding information.
+ * @scanned_files: tree of all scanned files
+ */
+struct ubifs_rebuild_info {
+	struct rb_root scanned_files;
+};
+
+/**
  * struct ubifs_fsck_info - UBIFS fsck information.
  * @mode: working mode
  * @failure_reason: reasons for failed operations
  * @lpt_status: the status of lpt, could be: %0(OK), %FR_LPT_CORRUPTED or
  *		%FR_LPT_INCORRECT
+ * @try_rebuild: %true means that try to rebuild fs when fsck failed
+ * @rebuild: rebuilding-related information
  */
 struct ubifs_fsck_info {
 	int mode;
 	unsigned int failure_reason;
 	unsigned int lpt_status;
+	bool try_rebuild;
+	struct ubifs_rebuild_info *rebuild;
 };
 
 #define FSCK(c) ((struct ubifs_fsck_info*)c->private)
@@ -252,4 +264,7 @@ int insert_or_update_file(struct ubifs_info *c, struct rb_root *file_tree,
 void destroy_file_content(struct ubifs_info *c, struct scanned_file *file);
 void destroy_file_tree(struct ubifs_info *c, struct rb_root *file_tree);
 
+/* rebuild_fs.c */
+int ubifs_rebuild_filesystem(struct ubifs_info *c);
+
 #endif
diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
new file mode 100644
index 00000000..3ca94869
--- /dev/null
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -0,0 +1,399 @@
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
+/**
+ * scanned_info - nodes and files information from scanning.
+ * @valid_inos: the tree of scanned inode nodes with 'nlink > 0'
+ * @del_inos: the tree of scanned inode nodes with 'nlink = 0'
+ * @valid_dents: the tree of scanned dentry nodes with 'inum > 0'
+ * @del_dents: the tree of scanned dentry nodes with 'inum = 0'
+ */
+struct scanned_info {
+	struct rb_root valid_inos;
+	struct rb_root del_inos;
+	struct rb_root valid_dents;
+	struct rb_root del_dents;
+};
+
+static int init_rebuild_info(struct ubifs_info *c)
+{
+	int err;
+
+	c->sbuf = vmalloc(c->leb_size);
+	if (!c->sbuf) {
+		log_err(c, errno, "can not allocate sbuf");
+		return -ENOMEM;
+	}
+	FSCK(c)->rebuild = kzalloc(sizeof(struct ubifs_rebuild_info),
+				   GFP_KERNEL);
+	if (!FSCK(c)->rebuild) {
+		err = -ENOMEM;
+		log_err(c, errno, "can not allocate rebuild info");
+		goto out;
+	}
+	FSCK(c)->rebuild->scanned_files = RB_ROOT;
+
+	return 0;
+
+out:
+	vfree(c->sbuf);
+	return err;
+}
+
+static void destroy_rebuild_info(struct ubifs_info *c)
+{
+	kfree(FSCK(c)->rebuild);
+	vfree(c->sbuf);
+}
+
+/**
+ * insert_or_update_ino_node - insert or update inode node.
+ * @c: UBIFS file-system description object
+ * @new_ino: new inode node
+ * @tree: a tree to record valid/deleted inode node info
+ *
+ * This function inserts @new_ino into the @tree, or updates inode node
+ * if it already exists in the tree. Returns zero in case of success, a
+ * negative error code in case of failure.
+ */
+static int insert_or_update_ino_node(struct ubifs_info *c,
+				     struct scanned_ino_node *new_ino,
+				     struct rb_root *tree)
+{
+	int cmp;
+	struct scanned_ino_node *ino_node, *old_ino_node = NULL;
+	struct rb_node **p, *parent = NULL;
+
+	p = &tree->rb_node;
+	while (*p) {
+		parent = *p;
+		ino_node = rb_entry(parent, struct scanned_ino_node, rb);
+		cmp = keys_cmp(c, &new_ino->key, &ino_node->key);
+		if (cmp < 0) {
+			p = &(*p)->rb_left;
+		} else if (cmp > 0) {
+			p = &(*p)->rb_right;
+		} else {
+			old_ino_node = ino_node;
+			break;
+		}
+	}
+	if (old_ino_node) {
+		if (old_ino_node->header.sqnum < new_ino->header.sqnum) {
+			size_t len = offsetof(struct scanned_ino_node, rb);
+
+			memcpy(old_ino_node, new_ino, len);
+		}
+		return 0;
+	}
+
+	ino_node = kmalloc(sizeof(struct scanned_ino_node), GFP_KERNEL);
+	if (!ino_node)
+		return -ENOMEM;
+
+	*ino_node = *new_ino;
+	rb_link_node(&ino_node->rb, parent, p);
+	rb_insert_color(&ino_node->rb, tree);
+
+	return 0;
+}
+
+/**
+ * insert_or_update_dent_node - insert or update dentry node.
+ * @c: UBIFS file-system description object
+ * @new_dent: new dentry node
+ * @tree: a tree to record valid/deleted dentry node info
+ *
+ * This function inserts @new_dent into the @tree, or updates dent node
+ * if it already exists in the tree. Returns zero in case of success, a
+ * negative error code in case of failure.
+ */
+static int insert_or_update_dent_node(struct ubifs_info *c,
+				      struct scanned_dent_node *new_dent,
+				      struct rb_root *tree)
+{
+	int cmp, nlen;
+	struct scanned_dent_node *dent_node, *old_dent_node = NULL;
+	struct rb_node **p, *parent = NULL;
+
+	p = &tree->rb_node;
+	while (*p) {
+		parent = *p;
+		dent_node = rb_entry(parent, struct scanned_dent_node, rb);
+		cmp = keys_cmp(c, &new_dent->key, &dent_node->key);
+		if (cmp < 0) {
+			p = &(*p)->rb_left;
+		} else if (cmp > 0) {
+			p = &(*p)->rb_right;
+		} else {
+			nlen = min(new_dent->nlen, dent_node->nlen);
+			cmp = strncmp(new_dent->name, dent_node->name, nlen) ? :
+				      new_dent->nlen - dent_node->nlen;
+			if (cmp < 0) {
+				p = &(*p)->rb_left;
+			} else if (cmp > 0) {
+				p = &(*p)->rb_right;
+			} else {
+				old_dent_node = dent_node;
+				break;
+			}
+		}
+	}
+	if (old_dent_node) {
+		if (old_dent_node->header.sqnum < new_dent->header.sqnum) {
+			size_t len = offsetof(struct scanned_dent_node, rb);
+
+			memcpy(old_dent_node, new_dent, len);
+		}
+		return 0;
+	}
+
+	dent_node = kmalloc(sizeof(struct scanned_dent_node), GFP_KERNEL);
+	if (!dent_node)
+		return -ENOMEM;
+
+	*dent_node = *new_dent;
+	rb_link_node(&dent_node->rb, parent, p);
+	rb_insert_color(&dent_node->rb, tree);
+
+	return 0;
+}
+
+/**
+ * process_scanned_node - process scanned node.
+ * @c: UBIFS file-system description object
+ * @lnum: logical eraseblock number
+ * @snod: scanned node
+ * @si: records nodes and files information during scanning
+ *
+ * This function parses, checks and records scanned node information.
+ * Returns zero in case of success, 1% if the scanned LEB doesn't hold file
+ * data and should be ignored(eg. index LEB), a negative error code in case
+ * of failure.
+ */
+static int process_scanned_node(struct ubifs_info *c, int lnum,
+				struct ubifs_scan_node *snod,
+				struct scanned_info *si)
+{
+	ino_t inum;
+	int offs = snod->offs;
+	void *node = snod->node;
+	union ubifs_key *key = &snod->key;
+	struct rb_root *tree;
+	struct scanned_node *sn;
+	struct scanned_ino_node ino_node;
+	struct scanned_dent_node dent_node;
+	struct scanned_data_node data_node;
+	struct scanned_trun_node trun_node;
+
+	switch (snod->type) {
+	case UBIFS_INO_NODE:
+	{
+		if (!parse_ino_node(c, lnum, offs, node, key, &ino_node))
+			return 0;
+
+		tree = &si->del_inos;
+		if (ino_node.nlink)
+			tree = &si->valid_inos;
+		return insert_or_update_ino_node(c, &ino_node, tree);
+	}
+	case UBIFS_DENT_NODE:
+	case UBIFS_XENT_NODE:
+	{
+		if (!parse_dent_node(c, lnum, offs, node, key, &dent_node))
+			return 0;
+
+		tree = &si->del_dents;
+		if (dent_node.inum)
+			tree = &si->valid_dents;
+		return insert_or_update_dent_node(c, &dent_node, tree);
+	}
+	case UBIFS_DATA_NODE:
+	{
+		if (!parse_data_node(c, lnum, offs, node, key, &data_node))
+			return 0;
+
+		inum = key_inum(c, key);
+		sn = (struct scanned_node *)&data_node;
+		break;
+	}
+	case UBIFS_TRUN_NODE:
+	{
+		if (!parse_trun_node(c, lnum, offs, node, key, &trun_node))
+			return 0;
+
+		inum = le32_to_cpu(((struct ubifs_trun_node *)node)->inum);
+		sn = (struct scanned_node *)&trun_node;
+		break;
+	}
+	default:
+		dbg_fsck("skip node type %d, at %d:%d, in %s",
+			 snod->type, lnum, offs, c->dev_name);
+		return 1;
+	}
+
+	tree = &FSCK(c)->rebuild->scanned_files;
+	return insert_or_update_file(c, tree, sn, key_type(c, key), inum);
+}
+
+/**
+ * destroy_scanned_info - destroy scanned nodes.
+ * @c: UBIFS file-system description object
+ * @si: records nodes and files information during scanning
+ *
+ * Destroy scanned files and all data/dentry nodes attached to file, destroy
+ * valid/deleted inode/dentry info.
+ */
+static void destroy_scanned_info(struct ubifs_info *c, struct scanned_info *si)
+{
+	struct scanned_ino_node *ino_node;
+	struct scanned_dent_node *dent_node;
+	struct rb_node *this;
+
+	destroy_file_tree(c, &FSCK(c)->rebuild->scanned_files);
+
+	this = rb_first(&si->valid_inos);
+	while (this) {
+		ino_node = rb_entry(this, struct scanned_ino_node, rb);
+		this = rb_next(this);
+
+		rb_erase(&ino_node->rb, &si->valid_inos);
+		kfree(ino_node);
+	}
+
+	this = rb_first(&si->del_inos);
+	while (this) {
+		ino_node = rb_entry(this, struct scanned_ino_node, rb);
+		this = rb_next(this);
+
+		rb_erase(&ino_node->rb, &si->del_inos);
+		kfree(ino_node);
+	}
+
+	this = rb_first(&si->valid_dents);
+	while (this) {
+		dent_node = rb_entry(this, struct scanned_dent_node, rb);
+		this = rb_next(this);
+
+		rb_erase(&dent_node->rb, &si->valid_dents);
+		kfree(dent_node);
+	}
+
+	this = rb_first(&si->del_dents);
+	while (this) {
+		dent_node = rb_entry(this, struct scanned_dent_node, rb);
+		this = rb_next(this);
+
+		rb_erase(&dent_node->rb, &si->del_dents);
+		kfree(dent_node);
+	}
+}
+
+/**
+ * scan_nodes - scan node information from flash.
+ * @c: UBIFS file-system description object
+ * @si: records nodes and files information during scanning
+ *
+ * This function scans nodes from flash, all ino/dent nodes are split
+ * into valid tree and deleted tree, all trun/data nodes are collected
+ * into file, the file is inserted into @FSCK(c)->rebuild->scanned_files.
+ */
+static int scan_nodes(struct ubifs_info *c, struct scanned_info *si)
+{
+	int lnum, err = 0;
+	struct ubifs_scan_leb *sleb;
+	struct ubifs_scan_node *snod;
+
+	for (lnum = c->main_first; lnum < c->leb_cnt; ++lnum) {
+		dbg_fsck("scan nodes at LEB %d, in %s", lnum, c->dev_name);
+
+		sleb = ubifs_scan(c, lnum, 0, c->sbuf, 1);
+		if (IS_ERR(sleb)) {
+			if (PTR_ERR(sleb) != -EUCLEAN)
+				return PTR_ERR(sleb);
+
+			sleb = ubifs_recover_leb(c, lnum, 0, c->sbuf, -1);
+			if (IS_ERR(sleb)) {
+				if (PTR_ERR(sleb) != -EUCLEAN)
+					return PTR_ERR(sleb);
+
+				/* This LEB holds corrupted data, abandon it. */
+				continue;
+			}
+		}
+
+		list_for_each_entry(snod, &sleb->nodes, list) {
+			if (snod->sqnum > c->max_sqnum)
+				c->max_sqnum = snod->sqnum;
+
+			err = process_scanned_node(c, lnum, snod, si);
+			if (err < 0) {
+				log_err(c, 0, "process node failed at LEB %d, err %d",
+					lnum, err);
+				ubifs_scan_destroy(sleb);
+				goto out;
+			} else if (err == 1) {
+				err = 0;
+				break;
+			}
+		}
+
+		ubifs_scan_destroy(sleb);
+	}
+
+out:
+	return err;
+}
+
+/**
+ * ubifs_rebuild_filesystem - Rebuild filesystem.
+ * @c: UBIFS file-system description object
+ *
+ * Scanning nodes from UBI volume and rebuild filesystem. Any inconsistent
+ * problems or corrupted data will be fixed.
+ */
+int ubifs_rebuild_filesystem(struct ubifs_info *c)
+{
+	int err = 0;
+	struct scanned_info si;
+
+	si.valid_inos = si.del_inos = si.valid_dents = si.del_dents = RB_ROOT;
+	log_out(c, "Start rebuilding filesystem (Notice: dropping data/recovering deleted data can't be awared)");
+	FSCK(c)->mode = REBUILD_MODE;
+
+	err = init_rebuild_info(c);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		return err;
+	}
+
+	/* Step 1: Scan valid/deleted nodes from volume. */
+	log_out(c, "Scan nodes");
+	err = scan_nodes(c, &si);
+	if (err)
+		exit_code |= FSCK_ERROR;
+
+	destroy_scanned_info(c, &si);
+	destroy_rebuild_info(c);
+
+	return err;
+}
-- 
2.13.6


