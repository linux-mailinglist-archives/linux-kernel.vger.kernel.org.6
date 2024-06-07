Return-Path: <linux-kernel+bounces-205372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA118FFAD5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA64C1F22A41
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA360168C2E;
	Fri,  7 Jun 2024 04:27:58 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C215F320
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734472; cv=none; b=uYvySfWh37j3dzEY2AsHDza4rSBJptA6DUjFxsR2BDDtpk3LssNMk4fOKaxzrlYBPwdxKw0t83sL9vice6AWcpf5QQPhrdrLSoL34u7KN/TmmxWd2zSxMeqV0t4hjK1dFPFknCFcq33+npnPipx94SBiDIof4T2NxVuGN+dGD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734472; c=relaxed/simple;
	bh=8rf3hvEumflyT0cw9j4aneiD1Xp4cYnGVZ1s1M/la6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzC7nM+n5EHnU3oU7RBW6y9CCMD4iyJgjU9kCta0Hfsd+kp9iwUMwIxyYYZHaPpdGNoiUGiX5u3cvEDdWul3HDedrB326Xg5D4f3mCqPriAdXSU9I2vdr+QQdYB+aaOdGD/fErfuWM3pX1zla4mUO+bhbMuIQb+JlBVieFsmz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwSlB0lXyzPpnM;
	Fri,  7 Jun 2024 12:24:22 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 62E50180085;
	Fri,  7 Jun 2024 12:27:41 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:32 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 089/110] fsck.ubifs: Move common functions and data structures into check_space.c
Date: Fri, 7 Jun 2024 12:25:54 +0800
Message-ID: <20240607042615.2069840-90-chengzhihao1@huawei.com>
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

This is a preparation for adding LPT checking support. Move some data
structures and functions into check_space.c, also factor out some common
functions in libubifs:
 1. Move 'lpts' from rebuild module, make it resuable for non-rebuild_fs
    modes.
 2. Move function 'get_free_leb' from rebuild_fs.c, it could be reused in
    building LPT.
 3. Move function 'build_lpt' from rebuild_fs.c, it could be reused in
    building LPT.
 4. Factor out lpt nodes freeing into a new function ubifs_free_lpt_nodes.
 5. Factor out nnode dirty marking implementations into a new function
    ubifs_make_nnode_dirty.
 5. Export the function of nnode number calculation, calc_nnode_num is
    renamed as ubifs_calc_nnode_num.
 6. Export the function of making pnode dirty, do_make_pnode_dirty is
    renamed as ubifs_make_pnode_dirty.
 7. Rename next_pnode_to_dirty to ubifs_find_next_pnode and export it.
 8. Export free_buds and expend its parameters.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am            |   3 +-
 ubifs-utils/fsck.ubifs/check_space.c |  94 ++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h  |  11 +++-
 ubifs-utils/fsck.ubifs/rebuild_fs.c  | 124 +++++++++--------------------------
 ubifs-utils/libubifs/lpt.c           |   6 +-
 ubifs-utils/libubifs/lpt_commit.c    |  97 ++++++++++++++-------------
 ubifs-utils/libubifs/super.c         |   9 ++-
 ubifs-utils/libubifs/ubifs.h         |   7 ++
 8 files changed, 204 insertions(+), 147 deletions(-)
 create mode 100644 ubifs-utils/fsck.ubifs/check_space.c

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index e12052ce..f63ca7a2 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -84,7 +84,8 @@ fsck_ubifs_SOURCES = \
 	ubifs-utils/fsck.ubifs/load_fs.c \
 	ubifs-utils/fsck.ubifs/extract_files.c \
 	ubifs-utils/fsck.ubifs/rebuild_fs.c \
-	ubifs-utils/fsck.ubifs/check_files.c
+	ubifs-utils/fsck.ubifs/check_files.c \
+	ubifs-utils/fsck.ubifs/check_space.c
 
 fsck_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm -lpthread
 fsck_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
diff --git a/ubifs-utils/fsck.ubifs/check_space.c b/ubifs-utils/fsck.ubifs/check_space.c
new file mode 100644
index 00000000..f758bf1a
--- /dev/null
+++ b/ubifs-utils/fsck.ubifs/check_space.c
@@ -0,0 +1,94 @@
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
+ * get_free_leb - get a free LEB according to @FSCK(c)->used_lebs.
+ * @c: UBIFS file-system description object
+ *
+ * This function tries to find a free LEB, lnum is returned if found, otherwise
+ * %-ENOSPC is returned.
+ */
+int get_free_leb(struct ubifs_info *c)
+{
+	int lnum;
+
+	lnum = find_next_zero_bit(FSCK(c)->used_lebs, c->main_lebs, 0);
+	if (lnum >= c->main_lebs) {
+		ubifs_err(c, "No space left.");
+		return -ENOSPC;
+	}
+	set_bit(lnum, FSCK(c)->used_lebs);
+	lnum += c->main_first;
+
+	return lnum;
+}
+
+/**
+ * build_lpt - construct LPT and write it into flash.
+ * @c: UBIFS file-system description object
+ * @calculate_lp_cb: callback function to calculate the properties for given LEB
+ *
+ * This function builds LPT according to the calculated results by
+ * @calculate_lp_cb and writes LPT into flash. Returns zero in case of success,
+ * a negative error code in case of failure.
+ */
+int build_lpt(struct ubifs_info *c, calculate_lp_callback calculate_lp_cb)
+{
+	int i, err, lnum, free, dirty;
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
+		err = calculate_lp_cb(c, i, &free, &dirty);
+		if (err)
+			return err;
+
+		FSCK(c)->lpts[i].free = free;
+		FSCK(c)->lpts[i].dirty = dirty;
+		c->lst.total_free += free;
+		c->lst.total_dirty += dirty;
+
+		if (free == c->leb_size)
+			c->lst.empty_lebs++;
+
+		if (FSCK(c)->lpts[i].flags & LPROPS_INDEX) {
+			c->lst.idx_lebs += 1;
+		} else {
+			int spc;
+
+			spc = free + dirty;
+			if (spc < c->dead_wm)
+				c->lst.total_dead += spc;
+			else
+				c->lst.total_dark += ubifs_calc_dark(c, spc);
+			c->lst.total_used += c->leb_size - spc;
+		}
+	}
+
+	/* Write LPT. */
+	return ubifs_create_lpt(c, FSCK(c)->lpts, c->main_lebs, hash_lpt);
+}
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 663d5dcf..011835ff 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -48,6 +48,9 @@ enum { SB_CORRUPTED = 0, MST_CORRUPTED, LOG_CORRUPTED, BUD_CORRUPTED,
 
 enum { HAS_DATA_CORRUPTED = 1, HAS_TNC_CORRUPTED = 2 };
 
+typedef int (*calculate_lp_callback)(struct ubifs_info *c,
+				     int index, int *free, int *dirty);
+
 struct scanned_file;
 
 /**
@@ -199,14 +202,12 @@ struct invalid_file_problem {
 
 /**
  * ubifs_rebuild_info - UBIFS rebuilding information.
- * @lpts: lprops table
  * @write_buf: write buffer for LEB @head_lnum
  * @head_lnum: current writing LEB number
  * @head_offs: current writing position in LEB @head_lnum
  * @need_update_lpt: whether to update lpt while writing index nodes
  */
 struct ubifs_rebuild_info {
-	struct ubifs_lprops *lpts;
 	void *write_buf;
 	int head_lnum;
 	int head_offs;
@@ -222,6 +223,7 @@ struct ubifs_rebuild_info {
  * @scanned_files: tree of all scanned files
  * @used_lebs: a bitmap used for recording used lebs
  * @disconnected_files: regular files without dentries
+ * @lpts: lprops table
  * @try_rebuild: %true means that try to rebuild fs when fsck failed
  * @rebuild: rebuilding-related information
  */
@@ -232,6 +234,7 @@ struct ubifs_fsck_info {
 	struct rb_root scanned_files;
 	unsigned long *used_lebs;
 	struct list_head disconnected_files;
+	struct ubifs_lprops *lpts;
 	bool try_rebuild;
 	struct ubifs_rebuild_info *rebuild;
 };
@@ -322,4 +325,8 @@ int handle_invalid_files(struct ubifs_info *c);
 int handle_dentry_tree(struct ubifs_info *c);
 bool tnc_is_empty(struct ubifs_info *c);
 
+/* check_space.c */
+int get_free_leb(struct ubifs_info *c);
+int build_lpt(struct ubifs_info *c, calculate_lp_callback calculate_lp_cb);
+
 #endif
diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index 8fc78ce3..1161f5af 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -81,9 +81,9 @@ static int init_rebuild_info(struct ubifs_info *c)
 		log_err(c, errno, "can not allocate bitmap of used lebs");
 		goto free_rebuild;
 	}
-	FSCK(c)->rebuild->lpts = kzalloc(sizeof(struct ubifs_lprops) * c->main_lebs,
-					 GFP_KERNEL);
-	if (!FSCK(c)->rebuild->lpts) {
+	FSCK(c)->lpts = kzalloc(sizeof(struct ubifs_lprops) * c->main_lebs,
+				GFP_KERNEL);
+	if (!FSCK(c)->lpts) {
 		err = -ENOMEM;
 		log_err(c, errno, "can not allocate lpts");
 		goto free_used_lebs;
@@ -98,7 +98,7 @@ static int init_rebuild_info(struct ubifs_info *c)
 	return 0;
 
 free_lpts:
-	kfree(FSCK(c)->rebuild->lpts);
+	kfree(FSCK(c)->lpts);
 free_used_lebs:
 	kfree(FSCK(c)->used_lebs);
 free_rebuild:
@@ -111,7 +111,7 @@ free_sbuf:
 static void destroy_rebuild_info(struct ubifs_info *c)
 {
 	vfree(FSCK(c)->rebuild->write_buf);
-	kfree(FSCK(c)->rebuild->lpts);
+	kfree(FSCK(c)->lpts);
 	kfree(FSCK(c)->used_lebs);
 	kfree(FSCK(c)->rebuild);
 	vfree(c->sbuf);
@@ -496,13 +496,12 @@ static void update_lpt(struct ubifs_info *c, struct scanned_node *sn,
 	int pos = sn->offs + ALIGN(sn->len, 8);
 
 	set_bit(index, FSCK(c)->used_lebs);
-	FSCK(c)->rebuild->lpts[index].end = max_t(int,
-					FSCK(c)->rebuild->lpts[index].end, pos);
+	FSCK(c)->lpts[index].end = max_t(int, FSCK(c)->lpts[index].end, pos);
 
 	if (deleted)
 		return;
 
-	FSCK(c)->rebuild->lpts[index].used += ALIGN(sn->len, 8);
+	FSCK(c)->lpts[index].used += ALIGN(sn->len, 8);
 }
 
 /**
@@ -731,28 +730,6 @@ static void init_root_ino(struct ubifs_info *c, struct ubifs_ino_node *ino)
 }
 
 /**
- * get_free_leb - get a free LEB according to @FSCK(c)->used_lebs.
- * @c: UBIFS file-system description object
- *
- * This function tries to find a free LEB, lnum is returned if found, otherwise
- * %-ENOSPC is returned.
- */
-static int get_free_leb(struct ubifs_info *c)
-{
-	int lnum;
-
-	lnum = find_next_zero_bit(FSCK(c)->used_lebs, c->main_lebs, 0);
-	if (lnum >= c->main_lebs) {
-		ubifs_err(c, "No space left.");
-		return -ENOSPC;
-	}
-	set_bit(lnum, FSCK(c)->used_lebs);
-	lnum += c->main_first;
-
-	return lnum;
-}
-
-/**
  * flush_write_buf - flush write buffer.
  * @c: UBIFS file-system description object
  *
@@ -780,9 +757,9 @@ static int flush_write_buf(struct ubifs_info *c)
 	if (FSCK(c)->rebuild->need_update_lpt) {
 		int index = FSCK(c)->rebuild->head_lnum - c->main_first;
 
-		FSCK(c)->rebuild->lpts[index].free = c->leb_size - len;
-		FSCK(c)->rebuild->lpts[index].dirty = pad;
-		FSCK(c)->rebuild->lpts[index].flags = LPROPS_INDEX;
+		FSCK(c)->lpts[index].free = c->leb_size - len;
+		FSCK(c)->lpts[index].dirty = pad;
+		FSCK(c)->lpts[index].flags = LPROPS_INDEX;
 	}
 
 	FSCK(c)->rebuild->head_lnum = -1;
@@ -1220,7 +1197,7 @@ static int traverse_files_and_nodes(struct ubifs_info *c)
 		lnum = i + c->main_first;
 		dbg_fsck("re-write LEB %d, in %s", lnum, c->dev_name);
 
-		end = FSCK(c)->rebuild->lpts[i].end;
+		end = FSCK(c)->lpts[i].end;
 		len = ALIGN(end, c->min_io_size);
 
 		err = ubifs_leb_read(c, lnum, c->sbuf, 0, len, 0);
@@ -1247,69 +1224,28 @@ out_idx_list:
 	return err;
 }
 
-/**
- * build_lpt - construct LPT and write it into flash.
- * @c: UBIFS file-system description object
- *
- * This function builds LPT according to @FSCK(c)->rebuild->lpts and writes
- * LPT into flash.
- */
-static int build_lpt(struct ubifs_info *c)
+static int calculate_lp(struct ubifs_info *c, int index, int *free, int *dirty)
 {
-	int i, len, free, dirty, lnum;
-	u8 hash_lpt[UBIFS_HASH_ARR_SZ];
-
-	memset(&c->lst, 0, sizeof(struct ubifs_lp_stats));
-	/* Set gc lnum. */
-	lnum = get_free_leb(c);
-	if (lnum < 0)
-		return lnum;
-	c->gc_lnum = lnum;
-
-	/* Update LPT. */
-	for (i = 0; i < c->main_lebs; i++) {
-		if (!test_bit(i, FSCK(c)->used_lebs) ||
-		    c->gc_lnum == i + c->main_first) {
-			free = c->leb_size;
-			dirty = 0;
-		} else if (FSCK(c)->rebuild->lpts[i].flags & LPROPS_INDEX) {
-			free = FSCK(c)->rebuild->lpts[i].free;
-			dirty = FSCK(c)->rebuild->lpts[i].dirty;
-		} else {
-			len = ALIGN(FSCK(c)->rebuild->lpts[i].end, c->min_io_size);
-			free = c->leb_size - len;
-			dirty = len - FSCK(c)->rebuild->lpts[i].used;
-
-			if (dirty == c->leb_size) {
-				free = c->leb_size;
-				dirty = 0;
-			}
-		}
-
-		FSCK(c)->rebuild->lpts[i].free = free;
-		FSCK(c)->rebuild->lpts[i].dirty = dirty;
-		c->lst.total_free += free;
-		c->lst.total_dirty += dirty;
-
-		if (free == c->leb_size)
-			c->lst.empty_lebs++;
-
-		if (!(FSCK(c)->rebuild->lpts[i].flags & LPROPS_INDEX)) {
-			int spc;
-
-			spc = free + dirty;
-			if (spc < c->dead_wm)
-				c->lst.total_dead += spc;
-			else
-				c->lst.total_dark += ubifs_calc_dark(c, spc);
-			c->lst.total_used += c->leb_size - spc;
-		} else {
-			c->lst.idx_lebs += 1;
+	if (!test_bit(index, FSCK(c)->used_lebs) ||
+	    c->gc_lnum == index + c->main_first) {
+		*free = c->leb_size;
+		*dirty = 0;
+	} else if (FSCK(c)->lpts[index].flags & LPROPS_INDEX) {
+		*free = FSCK(c)->lpts[index].free;
+		*dirty = FSCK(c)->lpts[index].dirty;
+	} else {
+		int len = ALIGN(FSCK(c)->lpts[index].end, c->min_io_size);
+
+		*free = c->leb_size - len;
+		*dirty = len - FSCK(c)->lpts[index].used;
+
+		if (*dirty == c->leb_size) {
+			*free = c->leb_size;
+			*dirty = 0;
 		}
 	}
 
-	/* Write LPT. */
-	return ubifs_create_lpt(c, FSCK(c)->rebuild->lpts, c->main_lebs, hash_lpt);
+	return 0;
 }
 
 /**
@@ -1485,7 +1421,7 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c)
 
 	/* Step 10. Build LPT. */
 	log_out(c, "Build LPT");
-	err = build_lpt(c);
+	err = build_lpt(c, calculate_lp);
 	if (err) {
 		exit_code |= FSCK_ERROR;
 		goto out;
diff --git a/ubifs-utils/libubifs/lpt.c b/ubifs-utils/libubifs/lpt.c
index b07f1f77..fc70cad5 100644
--- a/ubifs-utils/libubifs/lpt.c
+++ b/ubifs-utils/libubifs/lpt.c
@@ -523,7 +523,7 @@ static void add_pnode_dirt(struct ubifs_info *c, struct ubifs_pnode *pnode)
 }
 
 /**
- * calc_nnode_num - calculate nnode number.
+ * ubifs_calc_nnode_num - calculate nnode number.
  * @row: the row in the tree (root is zero)
  * @col: the column in the row (leftmost is zero)
  *
@@ -533,7 +533,7 @@ static void add_pnode_dirt(struct ubifs_info *c, struct ubifs_pnode *pnode)
  * This function calculates and returns the nnode number for the nnode at @row
  * and @col.
  */
-static int calc_nnode_num(int row, int col)
+int ubifs_calc_nnode_num(int row, int col)
 {
 	int num, bits;
 
@@ -779,7 +779,7 @@ int ubifs_create_lpt(struct ubifs_info *c, struct ubifs_lprops *lps, int lp_cnt,
 					nnode->nbranch[j].offs = 0;
 				}
 			}
-			nnode->num = calc_nnode_num(row, i);
+			nnode->num = ubifs_calc_nnode_num(row, i);
 			ubifs_pack_nnode(c, p, nnode);
 			p += c->nnode_sz;
 			len += c->nnode_sz;
diff --git a/ubifs-utils/libubifs/lpt_commit.c b/ubifs-utils/libubifs/lpt_commit.c
index 43eb7a6a..8a44546d 100644
--- a/ubifs-utils/libubifs/lpt_commit.c
+++ b/ubifs-utils/libubifs/lpt_commit.c
@@ -545,16 +545,15 @@ no_space:
 }
 
 /**
- * next_pnode_to_dirty - find next pnode to dirty.
+ * ubifs_find_next_pnode - find next pnode.
  * @c: UBIFS file-system description object
  * @pnode: pnode
  *
- * This function returns the next pnode to dirty or %NULL if there are no more
- * pnodes.  Note that pnodes that have never been written (lnum == 0) are
- * skipped.
+ * This function returns the next pnode or %NULL if there are no more pnodes.
+ * Note that pnodes that have never been written (lnum == 0) are skipped.
  */
-static struct ubifs_pnode *next_pnode_to_dirty(struct ubifs_info *c,
-					       struct ubifs_pnode *pnode)
+struct ubifs_pnode *ubifs_find_next_pnode(struct ubifs_info *c,
+					  struct ubifs_pnode *pnode)
 {
 	struct ubifs_nnode *nnode;
 	int iip;
@@ -622,28 +621,35 @@ static void add_pnode_dirt(struct ubifs_info *c, struct ubifs_pnode *pnode)
 }
 
 /**
- * do_make_pnode_dirty - mark a pnode dirty.
+ * ubifs_make_nnode_dirty - mark a nnode dirty.
+ * @c: UBIFS file-system description object
+ * @nnode: nnode to mark dirty
+ */
+void ubifs_make_nnode_dirty(struct ubifs_info *c, struct ubifs_nnode *nnode)
+{
+	while (nnode) {
+		if (!test_and_set_bit(DIRTY_CNODE, &nnode->flags)) {
+			c->dirty_nn_cnt += 1;
+			ubifs_add_nnode_dirt(c, nnode);
+			nnode = nnode->parent;
+		} else
+			break;
+	}
+}
+
+/**
+ * ubifs_make_pnode_dirty - mark a pnode dirty.
  * @c: UBIFS file-system description object
  * @pnode: pnode to mark dirty
  */
-static void do_make_pnode_dirty(struct ubifs_info *c, struct ubifs_pnode *pnode)
+void ubifs_make_pnode_dirty(struct ubifs_info *c, struct ubifs_pnode *pnode)
 {
 	/* Assumes cnext list is empty i.e. not called during commit */
 	if (!test_and_set_bit(DIRTY_CNODE, &pnode->flags)) {
-		struct ubifs_nnode *nnode;
-
 		c->dirty_pn_cnt += 1;
 		add_pnode_dirt(c, pnode);
 		/* Mark parent and ancestors dirty too */
-		nnode = pnode->parent;
-		while (nnode) {
-			if (!test_and_set_bit(DIRTY_CNODE, &nnode->flags)) {
-				c->dirty_nn_cnt += 1;
-				ubifs_add_nnode_dirt(c, nnode);
-				nnode = nnode->parent;
-			} else
-				break;
-		}
+		ubifs_make_nnode_dirty(c, pnode->parent);
 	}
 }
 
@@ -667,8 +673,8 @@ static int make_tree_dirty(struct ubifs_info *c)
 		return PTR_ERR(pnode);
 
 	while (pnode) {
-		do_make_pnode_dirty(c, pnode);
-		pnode = next_pnode_to_dirty(c, pnode);
+		ubifs_make_pnode_dirty(c, pnode);
+		pnode = ubifs_find_next_pnode(c, pnode);
 		if (IS_ERR(pnode))
 			return PTR_ERR(pnode);
 	}
@@ -878,20 +884,7 @@ static int make_nnode_dirty(struct ubifs_info *c, int node_num, int lnum,
 	} else if (c->lpt_lnum != lnum || c->lpt_offs != offs)
 			return 0; /* nnode is obsolete */
 	/* Assumes cnext list is empty i.e. not called during commit */
-	if (!test_and_set_bit(DIRTY_CNODE, &nnode->flags)) {
-		c->dirty_nn_cnt += 1;
-		ubifs_add_nnode_dirt(c, nnode);
-		/* Mark parent and ancestors dirty too */
-		nnode = nnode->parent;
-		while (nnode) {
-			if (!test_and_set_bit(DIRTY_CNODE, &nnode->flags)) {
-				c->dirty_nn_cnt += 1;
-				ubifs_add_nnode_dirt(c, nnode);
-				nnode = nnode->parent;
-			} else
-				break;
-		}
-	}
+	ubifs_make_nnode_dirty(c, nnode);
 	return 0;
 }
 
@@ -922,7 +915,7 @@ static int make_pnode_dirty(struct ubifs_info *c, int node_num, int lnum,
 	branch = &pnode->parent->nbranch[pnode->iip];
 	if (branch->lnum != lnum || branch->offs != offs)
 		return 0;
-	do_make_pnode_dirty(c, pnode);
+	ubifs_make_pnode_dirty(c, pnode);
 	return 0;
 }
 
@@ -1414,14 +1407,33 @@ static struct ubifs_nnode *next_nnode(struct ubifs_info *c,
 }
 
 /**
+ * ubifs_free_lpt_nodes - free pnodes/nnodes in LPT.
+ * @c: UBIFS file-system description object
+ */
+void ubifs_free_lpt_nodes(struct ubifs_info *c)
+{
+	int i, hght;
+	struct ubifs_nnode *nnode;
+
+	nnode = first_nnode(c, &hght);
+	while (nnode) {
+		for (i = 0; i < UBIFS_LPT_FANOUT; i++)
+			kfree(nnode->nbranch[i].nnode);
+		nnode = next_nnode(c, nnode, &hght);
+	}
+
+	kfree(c->nroot);
+	c->nroot = NULL;
+}
+
+/**
  * ubifs_lpt_free - free resources owned by the LPT.
  * @c: UBIFS file-system description object
  * @wr_only: free only resources used for writing
  */
 void ubifs_lpt_free(struct ubifs_info *c, int wr_only)
 {
-	struct ubifs_nnode *nnode;
-	int i, hght;
+	int i;
 
 	/* Free write-only things first */
 
@@ -1439,17 +1451,12 @@ void ubifs_lpt_free(struct ubifs_info *c, int wr_only)
 
 	/* Now free the rest */
 
-	nnode = first_nnode(c, &hght);
-	while (nnode) {
-		for (i = 0; i < UBIFS_LPT_FANOUT; i++)
-			kfree(nnode->nbranch[i].nnode);
-		nnode = next_nnode(c, nnode, &hght);
-	}
+	ubifs_free_lpt_nodes(c);
 	for (i = 0; i < LPROPS_HEAP_CNT; i++)
 		kfree(c->lpt_heap[i].arr);
 	kfree(c->dirty_idx.arr);
-	kfree(c->nroot);
 	vfree(c->ltab);
+	c->ltab = NULL;
 	kfree(c->lpt_nod_buf);
 }
 
diff --git a/ubifs-utils/libubifs/super.c b/ubifs-utils/libubifs/super.c
index 155489d9..559623f9 100644
--- a/ubifs-utils/libubifs/super.c
+++ b/ubifs-utils/libubifs/super.c
@@ -654,15 +654,20 @@ void free_orphans(struct ubifs_info *c)
 /**
  * free_buds - free per-bud objects.
  * @c: UBIFS file-system description object
+ * @delete_from_list: whether to delete the bud from list
  */
-static void free_buds(struct ubifs_info *c)
+void free_buds(struct ubifs_info *c, bool delete_from_list)
 {
 	struct ubifs_bud *bud, *n;
 
 	rbtree_postorder_for_each_entry_safe(bud, n, &c->buds, rb) {
+		if (delete_from_list)
+			list_del(&bud->list);
 		kfree(bud->log_hash);
 		kfree(bud);
 	}
+
+	c->buds = RB_ROOT;
 }
 
 /**
@@ -693,5 +698,5 @@ void destroy_journal(struct ubifs_info *c)
 	ubifs_destroy_idx_gc(c);
 	ubifs_destroy_size_tree(c);
 	ubifs_tnc_close(c);
-	free_buds(c);
+	free_buds(c, false);
 }
diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index 72497cd9..45c4105c 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -1778,6 +1778,7 @@ int ubifs_read_nnode(struct ubifs_info *c, struct ubifs_nnode *parent, int iip);
 void ubifs_add_lpt_dirt(struct ubifs_info *c, int lnum, int dirty);
 void ubifs_add_nnode_dirt(struct ubifs_info *c, struct ubifs_nnode *nnode);
 uint32_t ubifs_unpack_bits(const struct ubifs_info *c, uint8_t **addr, int *pos, int nrbits);
+int ubifs_calc_nnode_num(int row, int col);
 struct ubifs_nnode *ubifs_first_nnode(struct ubifs_info *c, int *hght);
 /* Needed only in debugging code in lpt_commit.c */
 int ubifs_unpack_nnode(const struct ubifs_info *c, void *buf,
@@ -1785,9 +1786,14 @@ int ubifs_unpack_nnode(const struct ubifs_info *c, void *buf,
 int ubifs_lpt_calc_hash(struct ubifs_info *c, u8 *hash);
 
 /* lpt_commit.c */
+struct ubifs_pnode *ubifs_find_next_pnode(struct ubifs_info *c,
+					  struct ubifs_pnode *pnode);
+void ubifs_make_nnode_dirty(struct ubifs_info *c, struct ubifs_nnode *nnode);
+void ubifs_make_pnode_dirty(struct ubifs_info *c, struct ubifs_pnode *pnode);
 int ubifs_lpt_start_commit(struct ubifs_info *c);
 int ubifs_lpt_end_commit(struct ubifs_info *c);
 int ubifs_lpt_post_commit(struct ubifs_info *c);
+void ubifs_free_lpt_nodes(struct ubifs_info *c);
 void ubifs_lpt_free(struct ubifs_info *c, int wr_only);
 
 /* lprops.c */
@@ -1830,6 +1836,7 @@ int take_gc_lnum(struct ubifs_info *c);
 int alloc_wbufs(struct ubifs_info *c);
 void free_wbufs(struct ubifs_info *c);
 void free_orphans(struct ubifs_info *c);
+void free_buds(struct ubifs_info *c, bool delete_from_list);
 void destroy_journal(struct ubifs_info *c);
 
 /* recovery.c */
-- 
2.13.6


