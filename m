Return-Path: <linux-kernel+bounces-205366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3A8FFACE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153B21F242F0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAEC169363;
	Fri,  7 Jun 2024 04:27:54 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2337F15F41B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734469; cv=none; b=nPmo/UvBJ2a+wArWDGgV8ydZ8LeBcB+R0bE/7TCfLd/ag9dbIFGdzIjgXA9O2JKDpJqmkVuhWHypcZ/11y7XwdnYMcN9yglk/wpoWd0HVZ6qGmoyt4SARvaMo0/ut9TAxv54w4UPPxl2A0wkcYhtC8Yxb5I4lXlF2Zl9QIqdzJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734469; c=relaxed/simple;
	bh=rKbmJJIGN+p25wgYmniePhRXrRNiwLTEUUgaX4OZy+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSXAjUFDtM8j4MttENarHs2KXErsUgP9F5UkRJnk38b8G6mOki4jZ2YH8uiTMc1ew/vmIichOhX+0rxvU4O1FeCziL6XmGlQlia98on2W0bEuAvz8/X2O8JhQF+7y65Gs2AkWRLKGcUFj74xdo0Isk5dGLn9QIgOzVqf+dV9sxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSnN1csKzdZc2;
	Fri,  7 Jun 2024 12:26:16 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 21F45180085;
	Fri,  7 Jun 2024 12:27:41 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:29 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 085/110] fsck.ubifs: Check and handle invalid files
Date: Fri, 7 Jun 2024 12:25:50 +0800
Message-ID: <20240607042615.2069840-86-chengzhihao1@huawei.com>
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

This is the 8/18 step of fsck. Check and handle invalid files, the
checking rule is same as rebuild mode which has been implemented in
file_is_valid, but the methods of handling are different:
 1. Move unattached(file has no dentries) regular file into disconnected
    list, let subsequent steps to handle them with lost+found.
 2. Make file type be consistent between inode, detries and data nodes by
    deleting dentries or data blocks.
 3. Delete file for other invalid cases(eg. file has no inode).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/check_files.c   |  88 ++++++++++++
 ubifs-utils/fsck.ubifs/extract_files.c | 239 +++++++++++++++++++++++++++++----
 ubifs-utils/fsck.ubifs/fsck.ubifs.c    |  11 ++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h    |  25 +++-
 ubifs-utils/fsck.ubifs/problem.c       | 100 ++++++++++++++
 ubifs-utils/fsck.ubifs/rebuild_fs.c    |   4 +-
 6 files changed, 434 insertions(+), 33 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/check_files.c b/ubifs-utils/fsck.ubifs/check_files.c
index 0fd6b32a..c5c606e1 100644
--- a/ubifs-utils/fsck.ubifs/check_files.c
+++ b/ubifs-utils/fsck.ubifs/check_files.c
@@ -354,3 +354,91 @@ void update_files_size(struct ubifs_info *c)
 		kfree(e);
 	}
 }
+
+/**
+ * handle_invalid_files - Handle invalid files.
+ * @c: UBIFS file-system description object
+ *
+ * This function checks and handles invalid files, there are three situations:
+ * 1. Move unattached(file has no dentries, or file's parent file has invalid
+ *    type) regular file into disconnected list, let subsequent steps to handle
+ *    them with lost+found.
+ * 2. Make file type be consistent between inode, detries and data nodes by
+ *    deleting dentries or data blocks.
+ * 3. Delete file for other invalid cases(eg. file has no inode).
+ *
+ * Returns zero in case of success, a negative error code in case of failure.
+ */
+int handle_invalid_files(struct ubifs_info *c)
+{
+	int err;
+	struct rb_node *node;
+	struct scanned_file *file;
+	struct rb_root *tree = &FSCK(c)->scanned_files;
+	LIST_HEAD(tmp_list);
+
+	/* Add all xattr files into a list. */
+	for (node = rb_first(tree); node; node = rb_next(node)) {
+		file = rb_entry(node, struct scanned_file, rb);
+
+		if (file->ino.is_xattr)
+			list_add(&file->list, &tmp_list);
+	}
+
+	/*
+	 * Round 1: Traverse xattr files, check whether the xattr file is
+	 * valid, move valid xattr file into corresponding host file's subtree.
+	 */
+	while (!list_empty(&tmp_list)) {
+		file = list_entry(tmp_list.next, struct scanned_file, list);
+
+		list_del(&file->list);
+		rb_erase(&file->rb, tree);
+		err = file_is_valid(c, file, tree, NULL);
+		if (err < 0) {
+			destroy_file_content(c, file);
+			kfree(file);
+			return err;
+		} else if (!err) {
+			err = delete_file(c, file);
+			kfree(file);
+			if (err)
+				return err;
+		}
+	}
+
+	/* Round 2: Traverse non-xattr files. */
+	for (node = rb_first(tree); node; node = rb_next(node)) {
+		int is_diconnected = 0;
+
+		file = rb_entry(node, struct scanned_file, rb);
+		err = file_is_valid(c, file, tree, &is_diconnected);
+		if (err < 0) {
+			return err;
+		} else if (!err) {
+			if (is_diconnected)
+				list_add(&file->list, &FSCK(c)->disconnected_files);
+			else
+				list_add(&file->list, &tmp_list);
+		}
+	}
+
+	/* Delete & remove invalid files. */
+	while (!list_empty(&tmp_list)) {
+		file = list_entry(tmp_list.next, struct scanned_file, list);
+
+		list_del(&file->list);
+		err = delete_file(c, file);
+		if (err)
+			return err;
+		rb_erase(&file->rb, tree);
+		kfree(file);
+	}
+
+	/* Remove disconnected file from the file tree. */
+	list_for_each_entry(file, &FSCK(c)->disconnected_files, list) {
+		rb_erase(&file->rb, tree);
+	}
+
+	return 0;
+}
diff --git a/ubifs-utils/fsck.ubifs/extract_files.c b/ubifs-utils/fsck.ubifs/extract_files.c
index e9c71a3c..51b83b82 100644
--- a/ubifs-utils/fsck.ubifs/extract_files.c
+++ b/ubifs-utils/fsck.ubifs/extract_files.c
@@ -784,6 +784,26 @@ void destroy_file_tree(struct ubifs_info *c, struct rb_root *file_tree)
 }
 
 /**
+ * destroy_file_list - destroy files from a given list head.
+ * @c: UBIFS file-system description object
+ * @file_list: list of the scanned files
+ *
+ * Destroy scanned files from a given list.
+ */
+void destroy_file_list(struct ubifs_info *c, struct list_head *file_list)
+{
+	struct scanned_file *file;
+
+	while (!list_empty(file_list)) {
+		file = list_entry(file_list->next, struct scanned_file, list);
+
+		destroy_file_content(c, file);
+		list_del(&file->list);
+		kfree(file);
+	}
+}
+
+/**
  * lookup_file - lookup file according to inode number.
  * @file_tree: tree of all scanned files
  * @inum: inode number
@@ -810,6 +830,109 @@ struct scanned_file *lookup_file(struct rb_root *file_tree, ino_t inum)
 	return NULL;
 }
 
+static void handle_invalid_file(struct ubifs_info *c, int problem_type,
+				struct scanned_file *file, void *priv)
+{
+	struct invalid_file_problem ifp = {
+		.file = file,
+		.priv = priv,
+	};
+
+	if (FSCK(c)->mode == REBUILD_MODE)
+		return;
+
+	fix_problem(c, problem_type, &ifp);
+}
+
+static int delete_node(struct ubifs_info *c, const union ubifs_key *key,
+		       int lnum, int offs)
+{
+	int err;
+
+	err = ubifs_tnc_remove_node(c, key, lnum, offs);
+	if (err) {
+		/* TNC traversing is finished, any TNC path is accessible */
+		ubifs_assert(c, !get_failure_reason_callback(c));
+	}
+
+	return err;
+}
+
+static int delete_dent_nodes(struct ubifs_info *c, struct scanned_file *file,
+			     int err)
+{
+	int ret = 0;
+	struct rb_node *this = rb_first(&file->dent_nodes);
+	struct scanned_dent_node *dent_node;
+
+	while (this) {
+		dent_node = rb_entry(this, struct scanned_dent_node, rb);
+		this = rb_next(this);
+
+		if (!err) {
+			err = delete_node(c, &dent_node->key,
+				dent_node->header.lnum, dent_node->header.offs);
+			if (err)
+				ret = ret ? ret : err;
+		}
+
+		rb_erase(&dent_node->rb, &file->dent_nodes);
+		kfree(dent_node);
+	}
+
+	return ret;
+}
+
+int delete_file(struct ubifs_info *c, struct scanned_file *file)
+{
+	int err = 0, ret = 0;
+	struct rb_node *this;
+	struct scanned_file *xattr_file;
+	struct scanned_data_node *data_node;
+
+	if (file->ino.header.exist) {
+		err = delete_node(c, &file->ino.key, file->ino.header.lnum,
+				  file->ino.header.offs);
+		if (err)
+			ret = ret ? ret : err;
+	}
+
+	this = rb_first(&file->data_nodes);
+	while (this) {
+		data_node = rb_entry(this, struct scanned_data_node, rb);
+		this = rb_next(this);
+
+		if (!err) {
+			err = delete_node(c, &data_node->key,
+				data_node->header.lnum, data_node->header.offs);
+			if (err)
+				ret = ret ? ret : err;
+		}
+
+		rb_erase(&data_node->rb, &file->data_nodes);
+		kfree(data_node);
+	}
+
+	err = delete_dent_nodes(c, file, err);
+	if (err)
+		ret = ret ? : err;
+
+	this = rb_first(&file->xattr_files);
+	while (this) {
+		xattr_file = rb_entry(this, struct scanned_file, rb);
+		this = rb_next(this);
+
+		ubifs_assert(c, !rb_first(&xattr_file->xattr_files));
+		err = delete_file(c, xattr_file);
+		if (err)
+			ret = ret ? ret : err;
+		rb_erase(&xattr_file->rb, &file->xattr_files);
+		kfree(xattr_file);
+	}
+
+	return ret;
+}
+
 /**
  * insert_xattr_file - insert xattr file into file's subtree.
  * @c: UBIFS file-system description object
@@ -848,6 +971,7 @@ static void insert_xattr_file(struct ubifs_info *c,
  * @c: UBIFS file-system description object
  * @file: file object
  * @file_tree: tree of all scanned files
+ * @is_diconnected: reason of invalid file, whether the @file is disconnected
  *
  * This function checks whether given @file is valid, following checks will
  * be performed:
@@ -866,12 +990,13 @@ static void insert_xattr_file(struct ubifs_info *c,
  *    invalid.
  * Xattr file will be inserted into corresponding host file's subtree.
  *
- * Returns %true is @file is valid, otherwise %false is returned.
+ * Returns %1 is @file is valid, %0 if @file is invalid, otherwise a negative
+ * error code in case of failure.
  * Notice: All xattr files should be traversed before non-xattr files, because
  *         checking item 7 depends on it.
  */
-bool file_is_valid(struct ubifs_info *c, struct scanned_file *file,
-		   struct rb_root *file_tree)
+int file_is_valid(struct ubifs_info *c, struct scanned_file *file,
+		  struct rb_root *file_tree, int *is_diconnected)
 {
 	int type;
 	struct rb_node *node;
@@ -880,8 +1005,17 @@ bool file_is_valid(struct ubifs_info *c, struct scanned_file *file,
 	struct scanned_data_node *data_node;
 	LIST_HEAD(drop_list);
 
-	if (!file->ino.header.exist || !file->ino.nlink)
-		return false;
+	dbg_fsck("check validation of file %lu, in %s", file->inum, c->dev_name);
+
+	if (!file->ino.header.exist) {
+		handle_invalid_file(c, FILE_HAS_NO_INODE, file, NULL);
+		return 0;
+	}
+
+	if (!file->ino.nlink) {
+		handle_invalid_file(c, FILE_HAS_0_NLINK_INODE, file, NULL);
+		return 0;
+	}
 
 	type = ubifs_get_dent_type(file->ino.mode);
 
@@ -901,6 +1035,14 @@ bool file_is_valid(struct ubifs_info *c, struct scanned_file *file,
 		dent_node = list_entry(drop_list.next, struct scanned_dent_node,
 				       list);
 
+		handle_invalid_file(c, FILE_HAS_INCONSIST_TYPE, file, dent_node);
+		if (FSCK(c)->mode != REBUILD_MODE) {
+			int err = delete_node(c, &dent_node->key,
+				dent_node->header.lnum, dent_node->header.offs);
+			if (err)
+				return err;
+		}
+
 		list_del(&dent_node->list);
 		rb_erase(&dent_node->rb, &file->dent_nodes);
 		kfree(dent_node);
@@ -909,11 +1051,7 @@ bool file_is_valid(struct ubifs_info *c, struct scanned_file *file,
 	if (type != UBIFS_ITYPE_DIR && !file->ino.is_xattr)
 		goto check_data_nodes;
 
-	/*
-	 * Make sure that directory/xattr type files only have one dentry.
-	 * This work should be done in step 3, but file type could be unknown
-	 * for lacking inode information at that time, so do it here.
-	 */
+	/* Make sure that directory/xattr type files only have one dentry. */
 	node = rb_first(&file->dent_nodes);
 	while (node) {
 		dent_node = rb_entry(node, struct scanned_dent_node, rb);
@@ -921,6 +1059,14 @@ bool file_is_valid(struct ubifs_info *c, struct scanned_file *file,
 		if (!node)
 			break;
 
+		handle_invalid_file(c, FILE_HAS_TOO_MANY_DENT, file, dent_node);
+		if (FSCK(c)->mode != REBUILD_MODE) {
+			int err = delete_node(c, &dent_node->key,
+				dent_node->header.lnum, dent_node->header.offs);
+			if (err)
+				return err;
+		}
+
 		rb_erase(&dent_node->rb, &file->dent_nodes);
 		kfree(dent_node);
 	}
@@ -929,43 +1075,65 @@ check_data_nodes:
 	if (type == UBIFS_ITYPE_REG && !file->ino.is_xattr)
 		goto check_dent_node;
 
-	/*
-	 * Make sure that non regular type files not have data/trun nodes.
-	 * This work should be done in step 3, but file type could be unknown
-	 * for lacking inode information at that time, so do it here.
-	 */
+	/* Make sure that non regular type files not have data/trun nodes. */
 	file->trun.header.exist = 0;
 	node = rb_first(&file->data_nodes);
 	while (node) {
 		data_node = rb_entry(node, struct scanned_data_node, rb);
 		node = rb_next(node);
 
+		handle_invalid_file(c, FILE_SHOULDNT_HAVE_DATA, file, data_node);
+		if (FSCK(c)->mode != REBUILD_MODE) {
+			int err = delete_node(c, &data_node->key,
+				data_node->header.lnum, data_node->header.offs);
+			if (err)
+				return err;
+		}
+
 		rb_erase(&data_node->rb, &file->data_nodes);
 		kfree(data_node);
 	}
 
 check_dent_node:
 	if (rb_first(&file->dent_nodes)) {
-		if (file->inum == UBIFS_ROOT_INO)
+		if (file->inum == UBIFS_ROOT_INO) {
 			/* '/' has no dentries. */
-			return false;
+			handle_invalid_file(c, FILE_ROOT_HAS_DENT, file,
+					    rb_entry(rb_first(&file->dent_nodes),
+						struct scanned_dent_node, rb));
+			return 0;
+		}
 
 		node = rb_first(&file->dent_nodes);
 		dent_node = rb_entry(node, struct scanned_dent_node, rb);
 		parent_file = lookup_file(file_tree, key_inum(c, &dent_node->key));
 	} else {
 		/* Non-root files must have dentries. */
-		if (file->inum != UBIFS_ROOT_INO)
-			return false;
+		if (file->inum != UBIFS_ROOT_INO) {
+			if (type == UBIFS_ITYPE_REG && !file->ino.is_xattr) {
+				handle_invalid_file(c, FILE_IS_DISCONNECTED,
+						    file, NULL);
+				if (is_diconnected)
+					*is_diconnected = 1;
+			} else {
+				handle_invalid_file(c, FILE_HAS_NO_DENT,
+						    file, NULL);
+			}
+			return 0;
+		}
 	}
 
 	if (file->ino.is_xattr) {
-		if (!parent_file)
+		if (!parent_file) {
 			/* Host inode is not found. */
-			return false;
-		if (parent_file->ino.is_xattr)
+			handle_invalid_file(c, XATTR_HAS_NO_HOST, file, NULL);
+			return 0;
+		}
+		if (parent_file->ino.is_xattr) {
 			/* Host cannot be a xattr file. */
-			return false;
+			handle_invalid_file(c, XATTR_HAS_WRONG_HOST, file, parent_file);
+			return 0;
+		}
 
 		insert_xattr_file(c, file, parent_file);
 		if (parent_file->ino.is_encrypted) {
@@ -977,20 +1145,35 @@ check_dent_node:
 				parent_file->has_encrypted_info = true;
 		}
 	} else {
-		if (parent_file && !S_ISDIR(parent_file->ino.mode))
+		if (parent_file && !S_ISDIR(parent_file->ino.mode)) {
 			/* Parent file should be directory. */
-			return false;
+			if (type == UBIFS_ITYPE_REG) {
+				handle_invalid_file(c, FILE_IS_DISCONNECTED,
+						    file, NULL);
+				if (FSCK(c)->mode != REBUILD_MODE) {
+					/* Delete dentries for the disconnected file. */
+					int err = delete_dent_nodes(c, file, 0);
+					if (err)
+						return err;
+				}
+				if (is_diconnected)
+					*is_diconnected = 1;
+			}
+			return 0;
+		}
 
 		/*
 		 * Since xattr files are checked in first round, so all
 		 * non-xattr files's @has_encrypted_info fields have been
 		 * initialized.
 		 */
-		if (file->ino.is_encrypted && !file->has_encrypted_info)
-			return false;
+		if (file->ino.is_encrypted && !file->has_encrypted_info) {
+			handle_invalid_file(c, FILE_HAS_NO_ENCRYPT, file, NULL);
+			return 0;
+		}
 	}
 
-	return true;
+	return 1;
 }
 
 static bool dentry_is_reachable(struct ubifs_info *c,
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 79b0babc..4b1b35b0 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -369,6 +369,7 @@ static int init_fsck_info(struct ubifs_info *c, int argc, char *argv[])
 
 	c->private = fsck;
 	FSCK(c)->mode = mode;
+	INIT_LIST_HEAD(&FSCK(c)->disconnected_files);
 	c->assert_failed_cb = fsck_assert_failed;
 	c->set_failure_reason_cb = fsck_set_failure_reason;
 	c->get_failure_reason_cb = fsck_get_failure_reason;
@@ -445,6 +446,15 @@ static int do_fsck(void)
 
 	update_files_size(c);
 
+	log_out(c, "Check and handle invalid files");
+	err = handle_invalid_files(c);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto free_used_lebs;
+	}
+
+	destroy_file_list(c, &FSCK(c)->disconnected_files);
+free_used_lebs:
 	kfree(FSCK(c)->used_lebs);
 	destroy_file_tree(c, &FSCK(c)->scanned_files);
 	return err;
@@ -484,6 +494,7 @@ int main(int argc, char *argv[])
 	/*
 	 * Step 6: Traverse tnc and construct files
 	 * Step 7: Update files' size
+	 * Step 8: Check and handle invalid files
 	 */
 	err = do_fsck();
 	if (err && FSCK(c)->try_rebuild) {
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 6c93eb6b..34d300b2 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -39,7 +39,11 @@ enum { NORMAL_MODE = 0, SAFE_MODE, DANGER_MODE0,
 /* Types of inconsistent problems */
 enum { SB_CORRUPTED = 0, MST_CORRUPTED, LOG_CORRUPTED, BUD_CORRUPTED,
        TNC_CORRUPTED, TNC_DATA_CORRUPTED, ORPHAN_CORRUPTED, INVALID_INO_NODE,
-       INVALID_DENT_NODE, INVALID_DATA_NODE, SCAN_CORRUPTED };
+       INVALID_DENT_NODE, INVALID_DATA_NODE, SCAN_CORRUPTED, FILE_HAS_NO_INODE,
+       FILE_HAS_0_NLINK_INODE, FILE_HAS_INCONSIST_TYPE, FILE_HAS_TOO_MANY_DENT,
+       FILE_SHOULDNT_HAVE_DATA, FILE_HAS_NO_DENT, XATTR_HAS_NO_HOST,
+       XATTR_HAS_WRONG_HOST, FILE_HAS_NO_ENCRYPT, FILE_IS_DISCONNECTED,
+       FILE_ROOT_HAS_DENT };
 
 enum { HAS_DATA_CORRUPTED = 1, HAS_TNC_CORRUPTED = 2 };
 
@@ -183,6 +187,16 @@ struct scanned_file {
 };
 
 /**
+ * invalid_file_problem - problem instance for invalid file.
+ * @file: invalid file instance
+ * @priv: invalid instance in @file, could be a dent_node or data_node
+ */
+struct invalid_file_problem {
+	struct scanned_file *file;
+	void *priv;
+};
+
+/**
  * ubifs_rebuild_info - UBIFS rebuilding information.
  * @lpts: lprops table
  * @write_buf: write buffer for LEB @head_lnum
@@ -206,6 +220,7 @@ struct ubifs_rebuild_info {
  *		%FR_LPT_INCORRECT
  * @scanned_files: tree of all scanned files
  * @used_lebs: a bitmap used for recording used lebs
+ * @disconnected_files: regular files without dentries
  * @try_rebuild: %true means that try to rebuild fs when fsck failed
  * @rebuild: rebuilding-related information
  */
@@ -215,6 +230,7 @@ struct ubifs_fsck_info {
 	unsigned int lpt_status;
 	struct rb_root scanned_files;
 	unsigned long *used_lebs;
+	struct list_head disconnected_files;
 	bool try_rebuild;
 	struct ubifs_rebuild_info *rebuild;
 };
@@ -286,9 +302,11 @@ int insert_or_update_file(struct ubifs_info *c, struct rb_root *file_tree,
 			  struct scanned_node *sn, int key_type, ino_t inum);
 void destroy_file_content(struct ubifs_info *c, struct scanned_file *file);
 void destroy_file_tree(struct ubifs_info *c, struct rb_root *file_tree);
+void destroy_file_list(struct ubifs_info *c, struct list_head *file_list);
 struct scanned_file *lookup_file(struct rb_root *file_tree, ino_t inum);
-bool file_is_valid(struct ubifs_info *c, struct scanned_file *file,
-		   struct rb_root *file_tree);
+int delete_file(struct ubifs_info *c, struct scanned_file *file);
+int file_is_valid(struct ubifs_info *c, struct scanned_file *file,
+		  struct rb_root *file_tree, int *is_diconnected);
 bool file_is_reachable(struct ubifs_info *c, struct scanned_file *file,
 		       struct rb_root *file_tree);
 int check_and_correct_files(struct ubifs_info *c);
@@ -299,5 +317,6 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c);
 /* check_files.c */
 int traverse_tnc_and_construct_files(struct ubifs_info *c);
 void update_files_size(struct ubifs_info *c);
+int handle_invalid_files(struct ubifs_info *c);
 
 #endif
diff --git a/ubifs-utils/fsck.ubifs/problem.c b/ubifs-utils/fsck.ubifs/problem.c
index c5ecd109..9222cba4 100644
--- a/ubifs-utils/fsck.ubifs/problem.c
+++ b/ubifs-utils/fsck.ubifs/problem.c
@@ -12,6 +12,7 @@
 #include "ubifs.h"
 #include "defs.h"
 #include "debug.h"
+#include "key.h"
 #include "fsck.ubifs.h"
 
 /*
@@ -46,6 +47,17 @@ static const struct fsck_problem problem_table[] = {
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Invalid dentry node"},	// INVALID_DENT_NODE
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Invalid data node"},	// INVALID_DATA_NODE
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Corrupted data is scanned"},	// SCAN_CORRUPTED
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "File has no inode"},	// FILE_HAS_NO_INODE
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "File has zero-nlink inode"},	// FILE_HAS_0_NLINK_INODE
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "File has inconsistent type"},	// FILE_HAS_INCONSIST_TYPE
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "File has too many dentries"},	// FILE_HAS_TOO_MANY_DENT
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "File should not have data"},	// FILE_SHOULDNT_HAVE_DATA
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "File has no dentries"},	// FILE_HAS_NO_DENT
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Xattr file has no host"},	// XATTR_HAS_NO_HOST
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Xattr file has wrong host"},	// XATTR_HAS_WRONG_HOST
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Encrypted file has no encryption information"},	// FILE_HAS_NO_ENCRYPT
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "File is disconnected(regular file without dentries)"},	// FILE_IS_DISCONNECTED
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Root dir should not have a dentry"},	// FILE_ROOT_HAS_DENT
 };
 
 static const char *get_question(const struct fsck_problem *problem,
@@ -65,6 +77,21 @@ static const char *get_question(const struct fsck_problem *problem,
 		return "Drop it?";
 	case ORPHAN_CORRUPTED:
 		return "Drop orphans on the LEB?";
+	case FILE_HAS_NO_INODE:
+	case FILE_HAS_0_NLINK_INODE:
+	case FILE_HAS_NO_DENT:
+	case XATTR_HAS_NO_HOST:
+	case XATTR_HAS_WRONG_HOST:
+	case FILE_HAS_NO_ENCRYPT:
+	case FILE_ROOT_HAS_DENT:
+		return "Delete it?";
+	case FILE_HAS_INCONSIST_TYPE:
+	case FILE_HAS_TOO_MANY_DENT:
+		return "Remove dentry?";
+	case FILE_SHOULDNT_HAVE_DATA:
+		return "Remove data block?";
+	case FILE_IS_DISCONNECTED:
+		return "Put it into disconnected list?";
 	}
 
 	return "Fix it?";
@@ -98,6 +125,79 @@ static void print_problem(const struct ubifs_info *c,
 			problem->desc, zbr->lnum, zbr->lnum, zbr->offs);
 		break;
 	}
+	case FILE_HAS_NO_INODE:
+	{
+		const struct invalid_file_problem *ifp = (const struct invalid_file_problem *)priv;
+
+		log_out(c, "problem: %s, ino %lu", problem->desc, ifp->file->inum);
+		break;
+	}
+	case FILE_HAS_INCONSIST_TYPE:
+	{
+		const struct invalid_file_problem *ifp = (const struct invalid_file_problem *)priv;
+		const struct scanned_dent_node *dent_node = (const struct scanned_dent_node *)ifp->priv;
+
+		log_out(c, "problem: %s, ino %lu, inode type %s%s, dentry %s has type %s%s",
+			problem->desc, ifp->file->inum,
+			ubifs_get_type_name(ubifs_get_dent_type(ifp->file->ino.mode)),
+			ifp->file->ino.is_xattr ? "(xattr)" : "",
+			c->encrypted && !ifp->file->ino.is_xattr ? "<encrypted>" : dent_node->name,
+			ubifs_get_type_name(dent_node->type),
+			key_type(c, &dent_node->key) == UBIFS_XENT_KEY ? "(xattr)" : "");
+		break;
+	}
+	case FILE_HAS_TOO_MANY_DENT:
+	case FILE_ROOT_HAS_DENT:
+	{
+		const struct invalid_file_problem *ifp = (const struct invalid_file_problem *)priv;
+		const struct scanned_dent_node *dent_node = (const struct scanned_dent_node *)ifp->priv;
+
+		log_out(c, "problem: %s, ino %lu, type %s%s, dentry %s",
+			problem->desc, ifp->file->inum,
+			ubifs_get_type_name(ubifs_get_dent_type(ifp->file->ino.mode)),
+			ifp->file->ino.is_xattr ? "(xattr)" : "",
+			c->encrypted && !ifp->file->ino.is_xattr ? "<encrypted>" : dent_node->name);
+		break;
+	}
+	case FILE_SHOULDNT_HAVE_DATA:
+	{
+		const struct invalid_file_problem *ifp = (const struct invalid_file_problem *)priv;
+		const struct scanned_data_node *data_node = (const struct scanned_data_node *)ifp->priv;
+
+		log_out(c, "problem: %s, ino %lu, type %s%s, data block %u",
+			problem->desc, ifp->file->inum,
+			ubifs_get_type_name(ubifs_get_dent_type(ifp->file->ino.mode)),
+			ifp->file->ino.is_xattr ? "(xattr)" : "",
+			key_block(c, &data_node->key));
+		break;
+	}
+	case FILE_HAS_0_NLINK_INODE:
+	case FILE_HAS_NO_DENT:
+	case XATTR_HAS_NO_HOST:
+	case FILE_HAS_NO_ENCRYPT:
+	case FILE_IS_DISCONNECTED:
+	{
+		const struct invalid_file_problem *ifp = (const struct invalid_file_problem *)priv;
+
+		log_out(c, "problem: %s, ino %lu type %s%s", problem->desc,
+			ifp->file->inum,
+			ubifs_get_type_name(ubifs_get_dent_type(ifp->file->ino.mode)),
+			ifp->file->ino.is_xattr ? "(xattr)" : "");
+		break;
+	}
+	case XATTR_HAS_WRONG_HOST:
+	{
+		const struct invalid_file_problem *ifp = (const struct invalid_file_problem *)priv;
+		const struct scanned_file *host = (const struct scanned_file *)ifp->priv;
+
+		log_out(c, "problem: %s, ino %lu type %s%s, host ino %lu type %s%s",
+			problem->desc, ifp->file->inum,
+			ubifs_get_type_name(ubifs_get_dent_type(ifp->file->ino.mode)),
+			ifp->file->ino.is_xattr ? "(xattr)" : "", host->inum,
+			ubifs_get_type_name(ubifs_get_dent_type(host->ino.mode)),
+			host->ino.is_xattr ? "(xattr)" : "");
+		break;
+	}
 	default:
 		log_out(c, "problem: %s", problem->desc);
 		break;
diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index f190517c..8fc78ce3 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -641,7 +641,7 @@ static void filter_invalid_files(struct ubifs_info *c)
 
 		list_del(&file->list);
 		rb_erase(&file->rb, tree);
-		if (!file_is_valid(c, file, tree)) {
+		if (!file_is_valid(c, file, tree, NULL)) {
 			destroy_file_content(c, file);
 			kfree(file);
 		}
@@ -651,7 +651,7 @@ static void filter_invalid_files(struct ubifs_info *c)
 	for (node = rb_first(tree); node; node = rb_next(node)) {
 		file = rb_entry(node, struct scanned_file, rb);
 
-		if (!file_is_valid(c, file, tree))
+		if (!file_is_valid(c, file, tree, NULL))
 			list_add(&file->list, &tmp_list);
 	}
 
-- 
2.13.6


