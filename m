Return-Path: <linux-kernel+bounces-205359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AE38FFAC7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2931E1F25D99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0435916728D;
	Fri,  7 Jun 2024 04:27:51 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07415F322
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734467; cv=none; b=mL5oWkHvFt+SlxqX/8vVAPsdQRKqRr+EV83J78XpRoFbGrjm2RAXO2LOn+ZYQSRfXC9Qd0//qFncmdstyr67Inyo0G3V9B4aS/wFOnJL9FLapsLhzwhM2XMc0ksMGqvTz9Y93dlss4w54tgz5cAXFP02uaZ0FwKhd191ydmlpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734467; c=relaxed/simple;
	bh=ZQ0u4Io6I8//KROhGRGw6aK8KSsLxEhx9/olFQLOKSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QW5SKli/KfQD1h6ZJKnX2sjoykyIetr27q3JsPsqgaaYU8Aef9e1koAd6T9Ky2eg/zkI2lePWpqGZyzNf51Z7qdqMWW/WbepSX6118ZAWkNiPfiiWt5JfMcFZP1yI4RyXgVMpILmMBjyrCoVcgOi/5s87NMdSq9Mjlf1mxOZJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSkP6pGRzwRv6;
	Fri,  7 Jun 2024 12:23:41 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D532A180085;
	Fri,  7 Jun 2024 12:27:40 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:26 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 081/110] fsck.ubifs: Move common functions and data structures into fsck.ubifs.c
Date: Fri, 7 Jun 2024 12:25:46 +0800
Message-ID: <20240607042615.2069840-82-chengzhihao1@huawei.com>
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

This is a preparation for adding TNC checking support. Following data
structures and functions are moved into fsck.ubifs.c:
 1. Move 'scanned_files' and 'used_lebs' from rebuild module, make them
    resuable for non-rebuild_fs modes.
 2. Move function 'handle_error' from load_fs.c, it could be reused in
    other steps.
 3. Add new function ubifs_tnc_remove_node in libubifs, which could
    remove index entry for a node by given position.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/extract_files.c |  2 +-
 ubifs-utils/fsck.ubifs/fsck.ubifs.c    | 25 +++++++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h    | 13 ++++---
 ubifs-utils/fsck.ubifs/load_fs.c       | 27 --------------
 ubifs-utils/fsck.ubifs/rebuild_fs.c    | 42 +++++++++++-----------
 ubifs-utils/libubifs/tnc.c             | 64 ++++++++++++++++++++++++++++++++++
 ubifs-utils/libubifs/ubifs.h           |  2 ++
 7 files changed, 122 insertions(+), 53 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/extract_files.c b/ubifs-utils/fsck.ubifs/extract_files.c
index b8777f6c..c3ab2b76 100644
--- a/ubifs-utils/fsck.ubifs/extract_files.c
+++ b/ubifs-utils/fsck.ubifs/extract_files.c
@@ -1234,7 +1234,7 @@ int check_and_correct_files(struct ubifs_info *c)
 	int err;
 	struct rb_node *node;
 	struct scanned_file *file;
-	struct rb_root *tree = &FSCK(c)->rebuild->scanned_files;
+	struct rb_root *tree = &FSCK(c)->scanned_files;
 
 	for (node = rb_first(tree); node; node = rb_next(node)) {
 		file = rb_entry(node, struct scanned_file, rb);
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 77013851..471c2cd9 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -404,6 +404,31 @@ static void destroy_fsck_info(struct ubifs_info *c)
 	c->dev_name = NULL;
 }
 
+void handle_error(const struct ubifs_info *c, int reason_set)
+{
+	bool handled = false;
+	unsigned int reason = get_failure_reason_callback(c);
+
+	clear_failure_reason_callback(c);
+	if ((reason_set & HAS_DATA_CORRUPTED) && (reason & FR_DATA_CORRUPTED)) {
+		handled = true;
+		reason &= ~FR_DATA_CORRUPTED;
+		if (fix_problem(c, LOG_CORRUPTED, NULL))
+			FSCK(c)->try_rebuild = true;
+	}
+	if ((reason_set & HAS_TNC_CORRUPTED) && (reason & FR_TNC_CORRUPTED)) {
+		ubifs_assert(c, !handled);
+		handled = true;
+		reason &= ~FR_TNC_CORRUPTED;
+		if (fix_problem(c, TNC_CORRUPTED, NULL))
+			FSCK(c)->try_rebuild = true;
+	}
+
+	ubifs_assert(c, reason == 0);
+	if (!handled)
+		exit_code |= FSCK_ERROR;
+}
+
 /*
  * do_fsck - Check & repair the filesystem.
  */
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index b98c3f7d..109c3924 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -40,6 +40,8 @@ enum { NORMAL_MODE = 0, SAFE_MODE, DANGER_MODE0,
 enum { SB_CORRUPTED = 0, MST_CORRUPTED, LOG_CORRUPTED, BUD_CORRUPTED,
        TNC_CORRUPTED, TNC_DATA_CORRUPTED, ORPHAN_CORRUPTED };
 
+enum { HAS_DATA_CORRUPTED = 1, HAS_TNC_CORRUPTED = 2 };
+
 struct scanned_file;
 
 /**
@@ -181,18 +183,14 @@ struct scanned_file {
 
 /**
  * ubifs_rebuild_info - UBIFS rebuilding information.
- * @used_lebs: a bitmap used for recording used lebs
  * @lpts: lprops table
- * @scanned_files: tree of all scanned files
  * @write_buf: write buffer for LEB @head_lnum
  * @head_lnum: current writing LEB number
  * @head_offs: current writing position in LEB @head_lnum
  * @need_update_lpt: whether to update lpt while writing index nodes
  */
 struct ubifs_rebuild_info {
-	unsigned long *used_lebs;
 	struct ubifs_lprops *lpts;
-	struct rb_root scanned_files;
 	void *write_buf;
 	int head_lnum;
 	int head_offs;
@@ -205,6 +203,8 @@ struct ubifs_rebuild_info {
  * @failure_reason: reasons for failed operations
  * @lpt_status: the status of lpt, could be: %0(OK), %FR_LPT_CORRUPTED or
  *		%FR_LPT_INCORRECT
+ * @scanned_files: tree of all scanned files
+ * @used_lebs: a bitmap used for recording used lebs
  * @try_rebuild: %true means that try to rebuild fs when fsck failed
  * @rebuild: rebuilding-related information
  */
@@ -212,6 +212,8 @@ struct ubifs_fsck_info {
 	int mode;
 	unsigned int failure_reason;
 	unsigned int lpt_status;
+	struct rb_root scanned_files;
+	unsigned long *used_lebs;
 	bool try_rebuild;
 	struct ubifs_rebuild_info *rebuild;
 };
@@ -260,6 +262,9 @@ static inline const char *mode_name(const struct ubifs_info *c)
 /* Exit code for fsck program. */
 extern int exit_code;
 
+/* fsck.ubifs.c */
+void handle_error(const struct ubifs_info *c, int reason_set);
+
 /* problem.c */
 bool fix_problem(const struct ubifs_info *c, int problem_type, const void *priv);
 
diff --git a/ubifs-utils/fsck.ubifs/load_fs.c b/ubifs-utils/fsck.ubifs/load_fs.c
index 58540543..04208a14 100644
--- a/ubifs-utils/fsck.ubifs/load_fs.c
+++ b/ubifs-utils/fsck.ubifs/load_fs.c
@@ -17,33 +17,6 @@
 #include "misc.h"
 #include "fsck.ubifs.h"
 
-enum { HAS_DATA_CORRUPTED = 1, HAS_TNC_CORRUPTED = 2 };
-
-static void handle_error(const struct ubifs_info *c, int reason_set)
-{
-	bool handled = false;
-	unsigned int reason = get_failure_reason_callback(c);
-
-	clear_failure_reason_callback(c);
-	if ((reason_set & HAS_DATA_CORRUPTED) && (reason & FR_DATA_CORRUPTED)) {
-		handled = true;
-		reason &= ~FR_DATA_CORRUPTED;
-		if (fix_problem(c, LOG_CORRUPTED, NULL))
-			FSCK(c)->try_rebuild = true;
-	}
-	if ((reason_set & HAS_TNC_CORRUPTED) && (reason & FR_TNC_CORRUPTED)) {
-		ubifs_assert(c, !handled);
-		handled = true;
-		reason &= ~FR_TNC_CORRUPTED;
-		if (fix_problem(c, TNC_CORRUPTED, NULL))
-			FSCK(c)->try_rebuild = true;
-	}
-
-	ubifs_assert(c, reason == 0);
-	if (!handled)
-		exit_code |= FSCK_ERROR;
-}
-
 int ubifs_load_filesystem(struct ubifs_info *c)
 {
 	int err;
diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index 382687b3..f190517c 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -73,10 +73,10 @@ static int init_rebuild_info(struct ubifs_info *c)
 		log_err(c, errno, "can not allocate rebuild info");
 		goto free_sbuf;
 	}
-	FSCK(c)->rebuild->scanned_files = RB_ROOT;
-	FSCK(c)->rebuild->used_lebs = kcalloc(BITS_TO_LONGS(c->main_lebs),
-					      sizeof(unsigned long), GFP_KERNEL);
-	if (!FSCK(c)->rebuild->used_lebs) {
+	FSCK(c)->scanned_files = RB_ROOT;
+	FSCK(c)->used_lebs = kcalloc(BITS_TO_LONGS(c->main_lebs),
+				     sizeof(unsigned long), GFP_KERNEL);
+	if (!FSCK(c)->used_lebs) {
 		err = -ENOMEM;
 		log_err(c, errno, "can not allocate bitmap of used lebs");
 		goto free_rebuild;
@@ -100,7 +100,7 @@ static int init_rebuild_info(struct ubifs_info *c)
 free_lpts:
 	kfree(FSCK(c)->rebuild->lpts);
 free_used_lebs:
-	kfree(FSCK(c)->rebuild->used_lebs);
+	kfree(FSCK(c)->used_lebs);
 free_rebuild:
 	kfree(FSCK(c)->rebuild);
 free_sbuf:
@@ -112,7 +112,7 @@ static void destroy_rebuild_info(struct ubifs_info *c)
 {
 	vfree(FSCK(c)->rebuild->write_buf);
 	kfree(FSCK(c)->rebuild->lpts);
-	kfree(FSCK(c)->rebuild->used_lebs);
+	kfree(FSCK(c)->used_lebs);
 	kfree(FSCK(c)->rebuild);
 	vfree(c->sbuf);
 }
@@ -313,7 +313,7 @@ static int process_scanned_node(struct ubifs_info *c, int lnum,
 		return 1;
 	}
 
-	tree = &FSCK(c)->rebuild->scanned_files;
+	tree = &FSCK(c)->scanned_files;
 	return insert_or_update_file(c, tree, sn, key_type(c, key), inum);
 }
 
@@ -331,7 +331,7 @@ static void destroy_scanned_info(struct ubifs_info *c, struct scanned_info *si)
 	struct scanned_dent_node *dent_node;
 	struct rb_node *this;
 
-	destroy_file_tree(c, &FSCK(c)->rebuild->scanned_files);
+	destroy_file_tree(c, &FSCK(c)->scanned_files);
 
 	this = rb_first(&si->valid_inos);
 	while (this) {
@@ -377,7 +377,7 @@ static void destroy_scanned_info(struct ubifs_info *c, struct scanned_info *si)
  *
  * This function scans nodes from flash, all ino/dent nodes are split
  * into valid tree and deleted tree, all trun/data nodes are collected
- * into file, the file is inserted into @FSCK(c)->rebuild->scanned_files.
+ * into file, the file is inserted into @FSCK(c)->scanned_files.
  */
 static int scan_nodes(struct ubifs_info *c, struct scanned_info *si)
 {
@@ -495,7 +495,7 @@ static void update_lpt(struct ubifs_info *c, struct scanned_node *sn,
 	int index = sn->lnum - c->main_first;
 	int pos = sn->offs + ALIGN(sn->len, 8);
 
-	set_bit(index, FSCK(c)->rebuild->used_lebs);
+	set_bit(index, FSCK(c)->used_lebs);
 	FSCK(c)->rebuild->lpts[index].end = max_t(int,
 					FSCK(c)->rebuild->lpts[index].end, pos);
 
@@ -572,7 +572,7 @@ static int add_valid_nodes_into_file(struct ubifs_info *c,
 	struct scanned_ino_node *ino_node;
 	struct scanned_dent_node *dent_node;
 	struct rb_node *this;
-	struct rb_root *tree = &FSCK(c)->rebuild->scanned_files;
+	struct rb_root *tree = &FSCK(c)->scanned_files;
 
 	this = rb_first(&si->valid_inos);
 	while (this) {
@@ -621,7 +621,7 @@ static void filter_invalid_files(struct ubifs_info *c)
 {
 	struct rb_node *node;
 	struct scanned_file *file;
-	struct rb_root *tree = &FSCK(c)->rebuild->scanned_files;
+	struct rb_root *tree = &FSCK(c)->scanned_files;
 	LIST_HEAD(tmp_list);
 
 	/* Add all xattr files into a list. */
@@ -678,7 +678,7 @@ static void extract_dentry_tree(struct ubifs_info *c)
 {
 	struct rb_node *node;
 	struct scanned_file *file;
-	struct rb_root *tree = &FSCK(c)->rebuild->scanned_files;
+	struct rb_root *tree = &FSCK(c)->scanned_files;
 	LIST_HEAD(unreachable);
 
 	for (node = rb_first(tree); node; node = rb_next(node)) {
@@ -731,7 +731,7 @@ static void init_root_ino(struct ubifs_info *c, struct ubifs_ino_node *ino)
 }
 
 /**
- * get_free_leb - get a free LEB according to @FSCK(c)->rebuild->used_lebs.
+ * get_free_leb - get a free LEB according to @FSCK(c)->used_lebs.
  * @c: UBIFS file-system description object
  *
  * This function tries to find a free LEB, lnum is returned if found, otherwise
@@ -741,12 +741,12 @@ static int get_free_leb(struct ubifs_info *c)
 {
 	int lnum;
 
-	lnum = find_next_zero_bit(FSCK(c)->rebuild->used_lebs, c->main_lebs, 0);
+	lnum = find_next_zero_bit(FSCK(c)->used_lebs, c->main_lebs, 0);
 	if (lnum >= c->main_lebs) {
 		ubifs_err(c, "No space left.");
 		return -ENOSPC;
 	}
-	set_bit(lnum, FSCK(c)->rebuild->used_lebs);
+	set_bit(lnum, FSCK(c)->used_lebs);
 	lnum += c->main_first;
 
 	return lnum;
@@ -897,8 +897,8 @@ static int create_root(struct ubifs_info *c)
 	file->calc_xnms = file->ino.xnms = le32_to_cpu(ino->xattr_names);
 	file->calc_size = file->ino.size = le64_to_cpu(ino->size);
 
-	rb_link_node(&file->rb, NULL, &FSCK(c)->rebuild->scanned_files.rb_node);
-	rb_insert_color(&file->rb, &FSCK(c)->rebuild->scanned_files);
+	rb_link_node(&file->rb, NULL, &FSCK(c)->scanned_files.rb_node);
+	rb_insert_color(&file->rb, &FSCK(c)->scanned_files);
 
 out:
 	kfree(ino);
@@ -1188,7 +1188,7 @@ static int traverse_files_and_nodes(struct ubifs_info *c)
 	int i, err = 0, idx_cnt = 0;
 	struct rb_node *node;
 	struct scanned_file *file;
-	struct rb_root *tree = &FSCK(c)->rebuild->scanned_files;
+	struct rb_root *tree = &FSCK(c)->scanned_files;
 	struct idx_entry *ie, *tmp_ie;
 	LIST_HEAD(idx_list);
 
@@ -1214,7 +1214,7 @@ static int traverse_files_and_nodes(struct ubifs_info *c)
 	for (i = 0; i < c->main_lebs; ++i) {
 		int lnum, len, end;
 
-		if (!test_bit(i, FSCK(c)->rebuild->used_lebs))
+		if (!test_bit(i, FSCK(c)->used_lebs))
 			continue;
 
 		lnum = i + c->main_first;
@@ -1268,7 +1268,7 @@ static int build_lpt(struct ubifs_info *c)
 
 	/* Update LPT. */
 	for (i = 0; i < c->main_lebs; i++) {
-		if (!test_bit(i, FSCK(c)->rebuild->used_lebs) ||
+		if (!test_bit(i, FSCK(c)->used_lebs) ||
 		    c->gc_lnum == i + c->main_first) {
 			free = c->leb_size;
 			dirty = 0;
diff --git a/ubifs-utils/libubifs/tnc.c b/ubifs-utils/libubifs/tnc.c
index cd1013d5..92770623 100644
--- a/ubifs-utils/libubifs/tnc.c
+++ b/ubifs-utils/libubifs/tnc.c
@@ -2457,6 +2457,70 @@ int ubifs_tnc_remove_ino(struct ubifs_info *c, ino_t inum)
 }
 
 /**
+ * ubifs_tnc_remove_node - remove an index entry of a node by given position.
+ * @c: UBIFS file-system description object
+ * @key: key of node
+ * @lnum: LEB number of node
+ * @offs: node offset
+ *
+ * Returns %0 on success or negative error code on failure.
+ */
+int ubifs_tnc_remove_node(struct ubifs_info *c, const union ubifs_key *key,
+			  int lnum, int offs)
+{
+	int found, n, err = 0;
+	struct ubifs_znode *znode;
+
+	mutex_lock(&c->tnc_mutex);
+	dbg_tnck(key, "pos %d:%d, key ", lnum, offs);
+	found = lookup_level0_dirty(c, key, &znode, &n);
+	if (found < 0) {
+		err = found;
+		goto out_unlock;
+	}
+	if (found == 1) {
+		struct ubifs_zbranch *zbr = &znode->zbranch[n];
+
+		if (zbr->lnum == lnum && zbr->offs == offs) {
+			err = tnc_delete(c, znode, n);
+		} else if (is_hash_key(c, key)) {
+			found = resolve_collision_directly(c, key, &znode, &n,
+							   lnum, offs);
+			if (found < 0) {
+				err = found;
+				goto out_unlock;
+			}
+
+			if (found) {
+				/* Ensure the znode is dirtied */
+				if (znode->cnext || !ubifs_zn_dirty(znode)) {
+					znode = dirty_cow_bottom_up(c, znode);
+					if (IS_ERR(znode)) {
+						err = PTR_ERR(znode);
+						goto out_unlock;
+					}
+				}
+				err = tnc_delete(c, znode, n);
+			} else {
+				goto not_found;
+			}
+		} else {
+			goto not_found;
+		}
+	} else {
+not_found:
+		/* Impossible, the node has been found before being deleted. */
+		ubifs_assert(c, 0);
+	}
+	if (!err)
+		err = dbg_check_tnc(c, 0);
+
+out_unlock:
+	mutex_unlock(&c->tnc_mutex);
+	return err;
+}
+
+/**
  * ubifs_tnc_next_ent - walk directory or extended attribute entries.
  * @c: UBIFS file-system description object
  * @key: key of last entry
diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index 8a506a8b..03150cdb 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -1661,6 +1661,8 @@ int ubifs_tnc_remove_nm(struct ubifs_info *c, const union ubifs_key *key,
 int ubifs_tnc_remove_range(struct ubifs_info *c, union ubifs_key *from_key,
 			   union ubifs_key *to_key);
 int ubifs_tnc_remove_ino(struct ubifs_info *c, ino_t inum);
+int ubifs_tnc_remove_node(struct ubifs_info *c, const union ubifs_key *key,
+			  int lnum, int offs);
 struct ubifs_dent_node *ubifs_tnc_next_ent(struct ubifs_info *c,
 					   union ubifs_key *key,
 					   const struct fscrypt_name *nm);
-- 
2.13.6


