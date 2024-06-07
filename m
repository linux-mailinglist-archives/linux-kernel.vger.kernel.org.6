Return-Path: <linux-kernel+bounces-205348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8CD8FFAB5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD69F1C2475B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4868E15ECD1;
	Fri,  7 Jun 2024 04:27:40 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA815AD95
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734454; cv=none; b=HG2fghPQirOM4JeSecRq18PV3c9eJqgIa9jh0EhV1PchI2tQk5ZSHOFPX+eqLvJmIdg5q/GRc8epBImlWbJkFafbSgEXehsJ+PxIJIvDRXDoGN7/BSrXWyvwh9mx6uci6UPQbvKh8cL4/iLol81dmwtulFbtTr/qblU+yD+BFyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734454; c=relaxed/simple;
	bh=vQg6vqG23qn/66GWDSa2qHszZ+PeqyxXAVfQfGWVbIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOJ8oFPqK/4fpJ7PVi3RnYkNwMRyQfNP65yrTz6fiZb/C37G05xSfbOvWgpD7+VNkX0zDuVS5CujwtSs2Z6Hxiy+1M8yv7U31ESXVzEvZVcpEsUSSRRrxIVk1sBb+SHaSHK5ZuQAdlR0CX+pWPUckj4QzT06QAPQcT7840lxkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSk74CfJz1SB59;
	Fri,  7 Jun 2024 12:23:27 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 52BDA180AA6;
	Fri,  7 Jun 2024 12:27:26 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:16 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 067/110] fsck.ubifs: rebuild_fs: Extract reachable directory entries tree
Date: Fri, 7 Jun 2024 12:25:32 +0800
Message-ID: <20240607042615.2069840-68-chengzhihao1@huawei.com>
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

This is the 5/12 step of rebuilding. Extract reachable directory entries
tree. Make sure that all files can be searched from '/', unreachable
file is deleted. So, all files can be accessible in userspace after
reparing.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/extract_files.c | 94 ++++++++++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h    |  6 +++
 ubifs-utils/fsck.ubifs/rebuild_fs.c    | 44 ++++++++++++++++
 3 files changed, 144 insertions(+)

diff --git a/ubifs-utils/fsck.ubifs/extract_files.c b/ubifs-utils/fsck.ubifs/extract_files.c
index 772e3003..dd5cb310 100644
--- a/ubifs-utils/fsck.ubifs/extract_files.c
+++ b/ubifs-utils/fsck.ubifs/extract_files.c
@@ -525,6 +525,7 @@ static int update_file(struct ubifs_info *c, struct scanned_file *file,
 	{
 		struct scanned_dent_node *dent = (struct scanned_dent_node *)sn;
 
+		dent->file = file;
 		err = insert_file_dentry(file, dent);
 		break;
 	}
@@ -888,3 +889,96 @@ check_dent_node:
 
 	return true;
 }
+
+static bool dentry_is_reachable(struct ubifs_info *c,
+				struct scanned_dent_node *dent_node,
+				struct list_head *path_list,
+				struct rb_root *file_tree)
+{
+	struct scanned_file *parent_file = NULL;
+	struct scanned_dent_node *dn, *parent_dent;
+	struct rb_node *p;
+
+	/* Check whether the path is cyclical. */
+	list_for_each_entry(dn, path_list, list) {
+		if (dn == dent_node)
+			return false;
+	}
+
+	/* Quick path, dentry has already been checked as reachable. */
+	if (dent_node->can_be_found)
+		return true;
+
+	dent_node->can_be_found = true;
+	list_add(&dent_node->list, path_list);
+
+	parent_file = lookup_file(file_tree, key_inum(c, &dent_node->key));
+	/* Parent dentry is not found, unreachable. */
+	if (!parent_file)
+		return false;
+
+	/* Parent dentry is '/', reachable. */
+	if (parent_file->inum == UBIFS_ROOT_INO)
+		return true;
+
+	p = rb_first(&parent_file->dent_nodes);
+	if (!p)
+		return false;
+	parent_dent = rb_entry(p, struct scanned_dent_node, rb);
+
+	return dentry_is_reachable(c, parent_dent, path_list, file_tree);
+}
+
+/**
+ * file_is_reachable - whether the file can be found from '/'.
+ * @c: UBIFS file-system description object
+ * @file: file object
+ * @file_tree: tree of all scanned files
+ *
+ * This function iterates all directory entries in given @file and checks
+ * whether each dentry is reachable. All unreachable directory entries will
+ * be removed.
+ */
+bool file_is_reachable(struct ubifs_info *c, struct scanned_file *file,
+		       struct rb_root *file_tree)
+{
+	struct rb_node *node;
+	struct scanned_dent_node *dent_node;
+
+	if (file->inum == UBIFS_ROOT_INO)
+		goto reachable;
+
+retry:
+	for (node = rb_first(&file->dent_nodes); node; node = rb_next(node)) {
+		LIST_HEAD(path_list);
+
+		dent_node = rb_entry(node, struct scanned_dent_node, rb);
+
+		if (dentry_is_reachable(c, dent_node, &path_list, file_tree))
+			continue;
+
+		while (!list_empty(&path_list)) {
+			dent_node = list_entry(path_list.next,
+					       struct scanned_dent_node, list);
+
+			dbg_fsck("remove unreachable dentry %s, in %s",
+				 c->encrypted && !file->ino.is_xattr ?
+				 "<encrypted>" : dent_node->name, c->dev_name);
+			list_del(&dent_node->list);
+			rb_erase(&dent_node->rb, &dent_node->file->dent_nodes);
+			kfree(dent_node);
+		}
+
+		/* Since dentry node is removed from rb-tree, rescan rb-tree. */
+		goto retry;
+	}
+
+	if (!rb_first(&file->dent_nodes)) {
+		dbg_fsck("file %lu is unreachable, in %s", file->inum, c->dev_name);
+		return false;
+	}
+
+reachable:
+	dbg_fsck("file %lu is reachable, in %s", file->inum, c->dev_name);
+	return true;
+}
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 3885d138..d378a06c 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -39,6 +39,8 @@ enum { NORMAL_MODE = 0, SAFE_MODE, DANGER_MODE0,
 /* Types of inconsistent problems */
 enum { SB_CORRUPTED = 0 };
 
+struct scanned_file;
+
 /**
  * scanned_node - common header node.
  * @exist: whether the node is found by scanning
@@ -92,6 +94,7 @@ struct scanned_ino_node {
  * @nlen: name length
  * @name: dentry name
  * @inum: target inode number
+ * @file: corresponding file
  * @rb: link in the trees of:
  *  1) valid dentry nodes or deleted dentry node
  *  2) all scanned dentry nodes from same file
@@ -105,6 +108,7 @@ struct scanned_dent_node {
 	unsigned int nlen;
 	char name[UBIFS_MAX_NLEN + 1];
 	ino_t inum;
+	struct scanned_file *file;
 	struct rb_node rb;
 	struct list_head list;
 };
@@ -266,6 +270,8 @@ void destroy_file_tree(struct ubifs_info *c, struct rb_root *file_tree);
 struct scanned_file *lookup_file(struct rb_root *file_tree, ino_t inum);
 bool file_is_valid(struct ubifs_info *c, struct scanned_file *file,
 		   struct rb_root *file_tree);
+bool file_is_reachable(struct ubifs_info *c, struct scanned_file *file,
+		       struct rb_root *file_tree);
 
 /* rebuild_fs.c */
 int ubifs_rebuild_filesystem(struct ubifs_info *c);
diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index 31f1b3ba..669b61d1 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -588,6 +588,46 @@ static void filter_invalid_files(struct ubifs_info *c)
 }
 
 /**
+ * extract_dentry_tree - extract reachable directory entries.
+ * @c: UBIFS file-system description object
+ *
+ * This function iterates all directory entries and remove those
+ * unreachable ones. 'Unreachable' means that a directory entry can
+ * not be searched from '/'.
+ */
+static void extract_dentry_tree(struct ubifs_info *c)
+{
+	struct rb_node *node;
+	struct scanned_file *file;
+	struct rb_root *tree = &FSCK(c)->rebuild->scanned_files;
+	LIST_HEAD(unreachable);
+
+	for (node = rb_first(tree); node; node = rb_next(node)) {
+		file = rb_entry(node, struct scanned_file, rb);
+
+		/*
+		 * Since all xattr files are already attached to corresponding
+		 * host file, there are only non-xattr files in the file tree.
+		 */
+		ubifs_assert(c, !file->ino.is_xattr);
+		if (!file_is_reachable(c, file, tree))
+			list_add(&file->list, &unreachable);
+	}
+
+	/* Remove unreachable files. */
+	while (!list_empty(&unreachable)) {
+		file = list_entry(unreachable.next, struct scanned_file, list);
+
+		dbg_fsck("remove unreachable file %lu, in %s",
+			 file->inum, c->dev_name);
+		list_del(&file->list);
+		destroy_file_content(c, file);
+		rb_erase(&file->rb, tree);
+		kfree(file);
+	}
+}
+
+/**
  * ubifs_rebuild_filesystem - Rebuild filesystem.
  * @c: UBIFS file-system description object
  *
@@ -633,6 +673,10 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c)
 	log_out(c, "Filter invalid files");
 	filter_invalid_files(c);
 
+	/* Step 5: Extract reachable directory entries. */
+	log_out(c, "Extract reachable files");
+	extract_dentry_tree(c);
+
 out:
 	destroy_scanned_info(c, &si);
 	destroy_rebuild_info(c);
-- 
2.13.6


