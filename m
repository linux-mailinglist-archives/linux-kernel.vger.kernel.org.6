Return-Path: <linux-kernel+bounces-205340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE028FFAAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E950B246D4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0DE15B15D;
	Fri,  7 Jun 2024 04:27:34 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3B15ADA6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734452; cv=none; b=pjNbLKQx2Je0weJNxuv0nPWwOMIY0e2c38uxkNQ3Ik7IvK638Gfr3UMlzPfvGaP3dJS+E200+uOS6Wd80+BkeWRkuhf05w8GB48jnboFcd+N1yg2vAhCkK2lHI0qB3hco2rZR0BwmVDn8WI31KnP1WO6lkYN9XP4wQkTiu/IRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734452; c=relaxed/simple;
	bh=1QfgybIRnIPUiYo+tXrq6vVZmXp45mvHwkbNQq/BX6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9iPPvhnLcoeS3mcHHUcBIuE+yxdviCxh2VOhR6moMtKhLnPWe+/+NqLxOwUTmOI6TGdA/GdnhLIgMTgBOM25PbNed3fqPcz85ML5i7U/9stX1mVnj7N2yWXkeV/v9SjsI9KynsiWl6/n0PZ7yaSd0haoWSBmNQ9Ji+6cI1JGE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwSkv1hdfzPpnW;
	Fri,  7 Jun 2024 12:24:07 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 84686180085;
	Fri,  7 Jun 2024 12:27:26 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:18 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 070/110] fsck.ubifs: rebuild_fs: Re-write data
Date: Fri, 7 Jun 2024 12:25:35 +0800
Message-ID: <20240607042615.2069840-71-chengzhihao1@huawei.com>
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

This is the 8/12 step of rebuilding. Re-write data. Read data from
LEB and write back data, make sure that all LEB is ended with empty
data(0xFF). It will prevent failed gc scanning in next mounting.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.h |   2 +
 ubifs-utils/fsck.ubifs/rebuild_fs.c | 107 ++++++++++++++++++++++++++++--------
 ubifs-utils/libubifs/ubifs.h        |   2 +
 3 files changed, 89 insertions(+), 22 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 0b065935..f027ec3f 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -181,10 +181,12 @@ struct scanned_file {
 /**
  * ubifs_rebuild_info - UBIFS rebuilding information.
  * @used_lebs: a bitmap used for recording used lebs
+ * @lpts: lprops table
  * @scanned_files: tree of all scanned files
  */
 struct ubifs_rebuild_info {
 	unsigned long *used_lebs;
+	struct ubifs_lprops *lpts;
 	struct rb_root scanned_files;
 };
 
diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index f5412f08..1b03d6c0 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -58,9 +58,18 @@ static int init_rebuild_info(struct ubifs_info *c)
 		log_err(c, errno, "can not allocate bitmap of used lebs");
 		goto free_rebuild;
 	}
+	FSCK(c)->rebuild->lpts = kzalloc(sizeof(struct ubifs_lprops) * c->main_lebs,
+					 GFP_KERNEL);
+	if (!FSCK(c)->rebuild->lpts) {
+		err = -ENOMEM;
+		log_err(c, errno, "can not allocate lpts");
+		goto free_used_lebs;
+	}
 
 	return 0;
 
+free_used_lebs:
+	kfree(FSCK(c)->rebuild->used_lebs);
 free_rebuild:
 	kfree(FSCK(c)->rebuild);
 free_sbuf:
@@ -70,6 +79,7 @@ free_sbuf:
 
 static void destroy_rebuild_info(struct ubifs_info *c)
 {
+	kfree(FSCK(c)->rebuild->lpts);
 	kfree(FSCK(c)->rebuild->used_lebs);
 	kfree(FSCK(c)->rebuild);
 	vfree(c->sbuf);
@@ -461,9 +471,13 @@ static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
 
 		valid_ino_node = lookup_valid_ino_node(c, si, del_ino_node);
 		if (valid_ino_node) {
-			int lnum = del_ino_node->header.lnum;
+			int lnum = del_ino_node->header.lnum - c->main_first;
+			int pos = del_ino_node->header.offs +
+				  ALIGN(del_ino_node->header.len, 8);
 
-			set_bit(lnum - c->main_first, FSCK(c)->rebuild->used_lebs);
+			set_bit(lnum, FSCK(c)->rebuild->used_lebs);
+			FSCK(c)->rebuild->lpts[lnum].end =
+				max_t(int, FSCK(c)->rebuild->lpts[lnum].end, pos);
 			rb_erase(&valid_ino_node->rb, &si->valid_inos);
 			kfree(valid_ino_node);
 		}
@@ -479,9 +493,13 @@ static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
 
 		valid_dent_node = lookup_valid_dent_node(c, si, del_dent_node);
 		if (valid_dent_node) {
-			int lnum = del_dent_node->header.lnum;
+			int lnum = del_dent_node->header.lnum - c->main_first;
+			int pos = del_dent_node->header.offs +
+				  ALIGN(del_dent_node->header.len, 8);
 
-			set_bit(lnum - c->main_first, FSCK(c)->rebuild->used_lebs);
+			set_bit(lnum, FSCK(c)->rebuild->used_lebs);
+			FSCK(c)->rebuild->lpts[lnum].end =
+				max_t(int, FSCK(c)->rebuild->lpts[lnum].end, pos);
 			rb_erase(&valid_dent_node->rb, &si->valid_dents);
 			kfree(valid_dent_node);
 		}
@@ -667,10 +685,21 @@ static const char *get_file_name(struct ubifs_info *c, struct scanned_file *file
 	return name;
 }
 
+static void parse_node_location(struct ubifs_info *c, struct scanned_node *sn)
+{
+	int lnum, pos;
+
+	lnum = sn->lnum - c->main_first;
+	pos = sn->offs + ALIGN(sn->len, 8);
+
+	set_bit(lnum, FSCK(c)->rebuild->used_lebs);
+	FSCK(c)->rebuild->lpts[lnum].end = max_t(int,
+					FSCK(c)->rebuild->lpts[lnum].end, pos);
+}
+
 static void record_file_used_lebs(struct ubifs_info *c,
 				  struct scanned_file *file)
 {
-	int lnum;
 	struct rb_node *node;
 	struct scanned_file *xattr_file;
 	struct scanned_dent_node *dent_node;
@@ -682,26 +711,21 @@ static void record_file_used_lebs(struct ubifs_info *c,
 		 ubifs_get_type_name(ubifs_get_dent_type(file->ino.mode)),
 		 c->dev_name);
 
-	lnum = file->ino.header.lnum;
-	set_bit(lnum - c->main_first, FSCK(c)->rebuild->used_lebs);
+	parse_node_location(c, &file->ino.header);
 
-	if (file->trun.header.exist) {
-		lnum = file->trun.header.lnum;
-		set_bit(lnum - c->main_first, FSCK(c)->rebuild->used_lebs);
-	}
+	if (file->trun.header.exist)
+		parse_node_location(c, &file->trun.header);
 
 	for (node = rb_first(&file->data_nodes); node; node = rb_next(node)) {
 		data_node = rb_entry(node, struct scanned_data_node, rb);
 
-		lnum = data_node->header.lnum;
-		set_bit(lnum - c->main_first, FSCK(c)->rebuild->used_lebs);
+		parse_node_location(c, &data_node->header);
 	}
 
 	for (node = rb_first(&file->dent_nodes); node; node = rb_next(node)) {
 		dent_node = rb_entry(node, struct scanned_dent_node, rb);
 
-		lnum = dent_node->header.lnum;
-		set_bit(lnum - c->main_first, FSCK(c)->rebuild->used_lebs);
+		parse_node_location(c, &dent_node->header);
 	}
 
 	for (node = rb_first(&file->xattr_files); node; node = rb_next(node)) {
@@ -712,22 +736,57 @@ static void record_file_used_lebs(struct ubifs_info *c,
 }
 
 /**
- * record_used_lebs - record used LEBs.
+ * traverse_files_and_nodes - traverse all nodes from valid files.
  * @c: UBIFS file-system description object
  *
- * This function records all used LEBs which may hold useful nodes, then left
- * unused LEBs could be taken for storing new index tree.
+ * This function traverses all nodes from valid files and does following
+ * things:
+ * 1. Record all used LEBs which may hold useful nodes, then left unused
+ *    LEBs could be taken for storing new index tree.
+ * 2. Re-write data to prevent failed gc scanning in the subsequent mounting
+ *    process caused by corrupted data.
  */
-static void record_used_lebs(struct ubifs_info *c)
+static int traverse_files_and_nodes(struct ubifs_info *c)
 {
+	int i, err = 0;
+	struct rb_node *node;
 	struct scanned_file *file;
 	struct rb_root *tree = &FSCK(c)->rebuild->scanned_files;
 
+	log_out(c, "Record used LEBs");
 	for (node = rb_first(tree); node; node = rb_next(node)) {
 		file = rb_entry(node, struct scanned_file, rb);
 
 		record_file_used_lebs(c, file);
 	}
+
+	/* Re-write data. */
+	log_out(c, "Re-write data");
+	for (i = 0; i < c->main_lebs; ++i) {
+		int lnum, len, end;
+
+		if (!test_bit(i, FSCK(c)->rebuild->used_lebs))
+			continue;
+
+		lnum = i + c->main_first;
+		dbg_fsck("re-write LEB %d, in %s", lnum, c->dev_name);
+
+		end = FSCK(c)->rebuild->lpts[i].end;
+		len = ALIGN(end, c->min_io_size);
+
+		err = ubifs_leb_read(c, lnum, c->sbuf, 0, len, 0);
+		if (err && err != -EBADMSG)
+			return err;
+
+		if (len > end)
+			ubifs_pad(c, c->sbuf + end, len - end);
+
+		err = ubifs_leb_change(c, lnum, c->sbuf, len);
+		if (err)
+			return err;
+	}
+
+	return err;
 }
 
 /**
@@ -788,9 +847,13 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c)
 		goto out;
 	}
 
-	/* Step 7: Record used LEBs. */
-	log_out(c, "Record used LEBs");
-	record_used_lebs(c);
+	/*
+	 * Step 7: Record used LEBs.
+	 * Step 8: Re-write data to clean corrupted data.
+	 */
+	err = traverse_files_and_nodes(c);
+	if (err)
+		exit_code |= FSCK_ERROR;
 
 out:
 	destroy_scanned_info(c, &si);
diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index e6de7cea..c9d582da 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -337,6 +337,7 @@ enum {
  * @dirty: amount of dirty space in bytes
  * @flags: LEB properties flags (see above)
  * @lnum: LEB number
+ * @end: the end postition of LEB calculated by the last node
  * @list: list of same-category lprops (for LPROPS_EMPTY and LPROPS_FREEABLE)
  * @hpos: heap position in heap of same-category lprops (other categories)
  */
@@ -345,6 +346,7 @@ struct ubifs_lprops {
 	int dirty;
 	int flags;
 	int lnum;
+	int end;
 	union {
 		struct list_head list;
 		int hpos;
-- 
2.13.6


