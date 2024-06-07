Return-Path: <linux-kernel+bounces-205358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4AA8FFAC4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8130D1F230E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2C215ADA5;
	Fri,  7 Jun 2024 04:27:50 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4D15D5B1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734466; cv=none; b=T4VnfqbjCvQjmfWlXEIZCE0rWBC/G2o801FOHNfPcrb6vSSMdQDOmL5w2kkwdS0TEwSUIFYISZzFq6n+ki1M48p5Gpns4G9MFWCxlQJXR13tzlc+eqFoBMsaN0CqAraT2PjGTVPIe8jEPFXh2Wigum2A7/WnWh7uk5CLgAO7auQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734466; c=relaxed/simple;
	bh=hZHpZFluddY6kdPzk6TxS512JZRBWrWvmKAJ5/E3SIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmcIMq4T9hpIdFGO55VpUvidRYA+vh3POA9fGVO+UK7s7EAiLCui7pekfhQkbP+BzVDLt0QXwW1ohMXyhTos9BJHFXwiVwTy+p5wpi5T0JwCO168z13rOxsr+qvzRPuIdCwxs7dfzFuqmfGxzwilgbpcFWs50Izs3zab8RbUmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSnM2zMszdZMD;
	Fri,  7 Jun 2024 12:26:15 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 52590180085;
	Fri,  7 Jun 2024 12:27:40 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:20 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 073/110] fsck.ubifs: rebuild_fs: Build LPT
Date: Fri, 7 Jun 2024 12:25:38 +0800
Message-ID: <20240607042615.2069840-74-chengzhihao1@huawei.com>
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

This is the 10/12 step of rebuilding. All LEBs' properties can be
calculated in previous steps according to all nodes' position, then
construct LPT just like mkfs does, and write LPT on flash.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.h |   2 +
 ubifs-utils/fsck.ubifs/rebuild_fs.c | 149 ++++++++++++++++++++++++++++--------
 ubifs-utils/libubifs/ubifs.h        |   2 +
 3 files changed, 119 insertions(+), 34 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index bc1d7503..1d97aed3 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -186,6 +186,7 @@ struct scanned_file {
  * @write_buf: write buffer for LEB @head_lnum
  * @head_lnum: current writing LEB number
  * @head_offs: current writing position in LEB @head_lnum
+ * @need_update_lpt: whether to update lpt while writing index nodes
  */
 struct ubifs_rebuild_info {
 	unsigned long *used_lebs;
@@ -194,6 +195,7 @@ struct ubifs_rebuild_info {
 	void *write_buf;
 	int head_lnum;
 	int head_offs;
+	bool need_update_lpt;
 };
 
 /**
diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index e1d1957f..085df2b9 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -489,6 +489,22 @@ lookup_valid_dent_node(struct ubifs_info *c, struct scanned_info *si,
 	return NULL;
 }
 
+static void update_lpt(struct ubifs_info *c, struct scanned_node *sn,
+		       bool deleted)
+{
+	int index = sn->lnum - c->main_first;
+	int pos = sn->offs + ALIGN(sn->len, 8);
+
+	set_bit(index, FSCK(c)->rebuild->used_lebs);
+	FSCK(c)->rebuild->lpts[index].end = max_t(int,
+					FSCK(c)->rebuild->lpts[index].end, pos);
+
+	if (deleted)
+		return;
+
+	FSCK(c)->rebuild->lpts[index].used += ALIGN(sn->len, 8);
+}
+
 /**
  * remove_del_nodes - remove deleted nodes from valid node tree.
  * @c: UBIFS file-system description object
@@ -512,13 +528,7 @@ static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
 
 		valid_ino_node = lookup_valid_ino_node(c, si, del_ino_node);
 		if (valid_ino_node) {
-			int lnum = del_ino_node->header.lnum - c->main_first;
-			int pos = del_ino_node->header.offs +
-				  ALIGN(del_ino_node->header.len, 8);
-
-			set_bit(lnum, FSCK(c)->rebuild->used_lebs);
-			FSCK(c)->rebuild->lpts[lnum].end =
-				max_t(int, FSCK(c)->rebuild->lpts[lnum].end, pos);
+			update_lpt(c, &del_ino_node->header, true);
 			rb_erase(&valid_ino_node->rb, &si->valid_inos);
 			kfree(valid_ino_node);
 		}
@@ -534,13 +544,7 @@ static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
 
 		valid_dent_node = lookup_valid_dent_node(c, si, del_dent_node);
 		if (valid_dent_node) {
-			int lnum = del_dent_node->header.lnum - c->main_first;
-			int pos = del_dent_node->header.offs +
-				  ALIGN(del_dent_node->header.len, 8);
-
-			set_bit(lnum, FSCK(c)->rebuild->used_lebs);
-			FSCK(c)->rebuild->lpts[lnum].end =
-				max_t(int, FSCK(c)->rebuild->lpts[lnum].end, pos);
+			update_lpt(c, &del_dent_node->header, true);
 			rb_erase(&valid_dent_node->rb, &si->valid_dents);
 			kfree(valid_dent_node);
 		}
@@ -730,12 +734,12 @@ static void init_root_ino(struct ubifs_info *c, struct ubifs_ino_node *ino)
  * get_free_leb - get a free LEB according to @FSCK(c)->rebuild->used_lebs.
  * @c: UBIFS file-system description object
  *
- * This function tries to find a free LEB, %0 is returned if found, otherwise
- * %ENOSPC is returned.
+ * This function tries to find a free LEB, lnum is returned if found, otherwise
+ * %-ENOSPC is returned.
  */
 static int get_free_leb(struct ubifs_info *c)
 {
-	int lnum, err;
+	int lnum;
 
 	lnum = find_next_zero_bit(FSCK(c)->rebuild->used_lebs, c->main_lebs, 0);
 	if (lnum >= c->main_lebs) {
@@ -745,14 +749,7 @@ static int get_free_leb(struct ubifs_info *c)
 	set_bit(lnum, FSCK(c)->rebuild->used_lebs);
 	lnum += c->main_first;
 
-	err = ubifs_leb_unmap(c, lnum);
-	if (err)
-		return err;
-
-	FSCK(c)->rebuild->head_lnum = lnum;
-	FSCK(c)->rebuild->head_offs = 0;
-
-	return 0;
+	return lnum;
 }
 
 /**
@@ -780,6 +777,14 @@ static int flush_write_buf(struct ubifs_info *c)
 	if (err)
 		return err;
 
+	if (FSCK(c)->rebuild->need_update_lpt) {
+		int index = FSCK(c)->rebuild->head_lnum - c->main_first;
+
+		FSCK(c)->rebuild->lpts[index].free = c->leb_size - len;
+		FSCK(c)->rebuild->lpts[index].dirty = pad;
+		FSCK(c)->rebuild->lpts[index].flags = LPROPS_INDEX;
+	}
+
 	FSCK(c)->rebuild->head_lnum = -1;
 
 	return 0;
@@ -797,13 +802,20 @@ static int flush_write_buf(struct ubifs_info *c)
  */
 static int reserve_space(struct ubifs_info *c, int len, int *lnum, int *offs)
 {
-	int err;
+	int err, new_lnum;
 
 	if (FSCK(c)->rebuild->head_lnum == -1) {
 get_new:
-		err = get_free_leb(c);
+		new_lnum = get_free_leb(c);
+		if (new_lnum < 0)
+			return new_lnum;
+
+		err = ubifs_leb_unmap(c, new_lnum);
 		if (err)
 			return err;
+
+		FSCK(c)->rebuild->head_lnum = new_lnum;
+		FSCK(c)->rebuild->head_offs = 0;
 	}
 
 	if (len > c->leb_size - FSCK(c)->rebuild->head_offs) {
@@ -921,15 +933,9 @@ static int parse_node_info(struct ubifs_info *c, struct scanned_node *sn,
 			   union ubifs_key *key, char *name, int name_len,
 			   struct list_head *idx_list, int *idx_cnt)
 {
-	int lnum, pos;
 	struct idx_entry *e;
 
-	lnum = sn->lnum - c->main_first;
-	pos = sn->offs + ALIGN(sn->len, 8);
-
-	set_bit(lnum, FSCK(c)->rebuild->used_lebs);
-	FSCK(c)->rebuild->lpts[lnum].end = max_t(int,
-					FSCK(c)->rebuild->lpts[lnum].end, pos);
+	update_lpt(c, sn, idx_cnt == NULL);
 
 	if (idx_cnt == NULL)
 		/* Skip truncation node. */
@@ -1026,6 +1032,7 @@ static int build_tnc(struct ubifs_info *c, struct list_head *lower_idxs,
 		return -ENOMEM;
 
 	list_sort(c, lower_idxs, cmp_idx);
+	FSCK(c)->rebuild->need_update_lpt = true;
 
 	ubifs_assert(c, lower_cnt != 0);
 
@@ -1089,6 +1096,7 @@ static int build_tnc(struct ubifs_info *c, struct list_head *lower_idxs,
 
 	/* Flush the last index LEB */
 	err = flush_write_buf(c);
+	FSCK(c)->rebuild->need_update_lpt = false;
 
 out:
 	list_for_each_entry_safe(e, tmp_e, lower_idxs, list) {
@@ -1239,6 +1247,71 @@ out_idx_list:
 }
 
 /**
+ * build_lpt - construct LPT and write it into flash.
+ * @c: UBIFS file-system description object
+ *
+ * This function builds LPT according to @FSCK(c)->rebuild->lpts and writes
+ * LPT into flash.
+ */
+static int build_lpt(struct ubifs_info *c)
+{
+	int i, len, free, dirty, lnum;
+	u8 hash_lpt[UBIFS_HASH_ARR_SZ];
+
+	memset(&c->lst, 0, sizeof(struct ubifs_lp_stats));
+	/* Set gc lnum. */
+	lnum = get_free_leb(c);
+	if (lnum < 0)
+		return lnum;
+	c->gc_lnum = lnum;
+
+	/* Update LPT. */
+	for (i = 0; i < c->main_lebs; i++) {
+		if (!test_bit(i, FSCK(c)->rebuild->used_lebs) ||
+		    c->gc_lnum == i + c->main_first) {
+			free = c->leb_size;
+			dirty = 0;
+		} else if (FSCK(c)->rebuild->lpts[i].flags & LPROPS_INDEX) {
+			free = FSCK(c)->rebuild->lpts[i].free;
+			dirty = FSCK(c)->rebuild->lpts[i].dirty;
+		} else {
+			len = ALIGN(FSCK(c)->rebuild->lpts[i].end, c->min_io_size);
+			free = c->leb_size - len;
+			dirty = len - FSCK(c)->rebuild->lpts[i].used;
+
+			if (dirty == c->leb_size) {
+				free = c->leb_size;
+				dirty = 0;
+			}
+		}
+
+		FSCK(c)->rebuild->lpts[i].free = free;
+		FSCK(c)->rebuild->lpts[i].dirty = dirty;
+		c->lst.total_free += free;
+		c->lst.total_dirty += dirty;
+
+		if (free == c->leb_size)
+			c->lst.empty_lebs++;
+
+		if (!(FSCK(c)->rebuild->lpts[i].flags & LPROPS_INDEX)) {
+			int spc;
+
+			spc = free + dirty;
+			if (spc < c->dead_wm)
+				c->lst.total_dead += spc;
+			else
+				c->lst.total_dark += ubifs_calc_dark(c, spc);
+			c->lst.total_used += c->leb_size - spc;
+		} else {
+			c->lst.idx_lebs += 1;
+		}
+	}
+
+	/* Write LPT. */
+	return ubifs_create_lpt(c, FSCK(c)->rebuild->lpts, c->main_lebs, hash_lpt);
+}
+
+/**
  * ubifs_rebuild_filesystem - Rebuild filesystem.
  * @c: UBIFS file-system description object
  *
@@ -1302,6 +1375,14 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c)
 	 * Step 9: Build TNC.
 	 */
 	err = traverse_files_and_nodes(c);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto out;
+	}
+
+	/* Step 10. Build LPT. */
+	log_out(c, "Build LPT");
+	err = build_lpt(c);
 	if (err)
 		exit_code |= FSCK_ERROR;
 
diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index c9d582da..6f965555 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -338,6 +338,7 @@ enum {
  * @flags: LEB properties flags (see above)
  * @lnum: LEB number
  * @end: the end postition of LEB calculated by the last node
+ * @used: amount of used space in bytes
  * @list: list of same-category lprops (for LPROPS_EMPTY and LPROPS_FREEABLE)
  * @hpos: heap position in heap of same-category lprops (other categories)
  */
@@ -347,6 +348,7 @@ struct ubifs_lprops {
 	int flags;
 	int lnum;
 	int end;
+	int used;
 	union {
 		struct list_head list;
 		int hpos;
-- 
2.13.6


