Return-Path: <linux-kernel+bounces-205326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059118FFA9E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13EC1C23F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC854481DB;
	Fri,  7 Jun 2024 04:27:23 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15295249EB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734438; cv=none; b=SHPf1rnGlm7gZTb8ckUN0uwloV0igQM+QVPasbDKqNViwTQZQ00O5Se3Pf/NMb6kJAlJO4/lvx5CcuYjE58Tsh3JyV4V/zAM9hCK/fcIvUyVYCxA5bvRJh9Iw4n8raqfmoFBOUNa0AGTqaq7Dhv1ynCfBRvTDCQHtYtE0aaqiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734438; c=relaxed/simple;
	bh=TGMuAjRvyi3YZyVNnvdRhTSdRzZ4jwA4rrb5ytNGWHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBB05aioXWwvRICFWxY+/C4sRYkcsypefgk/O5Xc8iCz7x4vDtXmWqjU7MPwKHsUMw6aU3yfNp6r/b9P9eMHkxEAFJxgyHGOzeMXWQ9pAv5DAT2/Lr55IbF5Rz+oTOVux5orii7FFKG/atbeh30gnIFlBI86CJcwnXXXWubd7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwSkb4Lq2zPpnC;
	Fri,  7 Jun 2024 12:23:51 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D8B5618007E;
	Fri,  7 Jun 2024 12:27:10 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:54 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 037/110] ubifs-utils: Adapt lpt subsystem in libubifs
Date: Fri, 7 Jun 2024 12:25:02 +0800
Message-ID: <20240607042615.2069840-38-chengzhihao1@huawei.com>
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

Adapt lpt subsystem(lpt.c,lprops.c,lpt_commit.c) in libubifs, compared
with linux kernel implementations:
 1. Remove debug related functions(eg. dbg_chk_lpt_sz, dbg_chk_pnode),
    some of debug functions are not needed by fsck, because fsck will
    check fs in another way.
 2. Remove some functions(eg. ubifs_create_dflt_lpt) which won't be used
    in fsck/mkfs.
 3. Adapt do_calc_lpt_geom() to mkfs/fsck situations.
 4. Adapt calc_dflt_lpt_geom to support the mkfs tool, and export it.
 5. Adapt ubifs_create_lpt() according to create_lpt(mkfs), make sure that
    the height of created lpt is right.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/lprops.c     | 484 +-------------------------------------
 ubifs-utils/libubifs/lpt.c        | 381 +++++++++---------------------
 ubifs-utils/libubifs/lpt_commit.c | 235 ++----------------
 3 files changed, 136 insertions(+), 964 deletions(-)

diff --git a/ubifs-utils/libubifs/lprops.c b/ubifs-utils/libubifs/lprops.c
index 6d6cd85c..84cdb353 100644
--- a/ubifs-utils/libubifs/lprops.c
+++ b/ubifs-utils/libubifs/lprops.c
@@ -16,7 +16,13 @@
  * an empty LEB for the journal, or a very dirty LEB for garbage collection.
  */
 
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "misc.h"
 
 /**
  * get_heap_comp_val - get the LEB properties value for heap comparisons.
@@ -47,7 +53,8 @@ static int get_heap_comp_val(struct ubifs_lprops *lprops, int cat)
  * is either the amount of free space or the amount of dirty space, depending
  * on the category.
  */
-static void move_up_lpt_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap,
+static void move_up_lpt_heap(__unused struct ubifs_info *c,
+			     struct ubifs_lpt_heap *heap,
 			     struct ubifs_lprops *lprops, int cat)
 {
 	int val1, val2, hpos;
@@ -84,7 +91,8 @@ static void move_up_lpt_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap,
  * greater.  In the case of LPT's category heaps, the value is either the amount
  * of free space or the amount of dirty space, depending on the category.
  */
-static void adjust_lpt_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap,
+static void adjust_lpt_heap(__unused struct ubifs_info *c,
+			    struct ubifs_lpt_heap *heap,
 			    struct ubifs_lprops *lprops, int hpos, int cat)
 {
 	int val1, val2, val3, cpos;
@@ -191,16 +199,13 @@ static int add_to_lpt_heap(struct ubifs_info *c, struct ubifs_lprops *lprops,
 			lprops->hpos = cpos;
 			heap->arr[cpos] = lprops;
 			move_up_lpt_heap(c, heap, lprops, cat);
-			dbg_check_heap(c, heap, cat, lprops->hpos);
 			return 1; /* Added to heap */
 		}
-		dbg_check_heap(c, heap, cat, -1);
 		return 0; /* Not added to heap */
 	} else {
 		lprops->hpos = heap->cnt++;
 		heap->arr[lprops->hpos] = lprops;
 		move_up_lpt_heap(c, heap, lprops, cat);
-		dbg_check_heap(c, heap, cat, lprops->hpos);
 		return 1; /* Added to heap */
 	}
 }
@@ -226,7 +231,6 @@ static void remove_from_lpt_heap(struct ubifs_info *c,
 		heap->arr[hpos]->hpos = hpos;
 		adjust_lpt_heap(c, heap, heap->arr[hpos], hpos, cat);
 	}
-	dbg_check_heap(c, heap, cat, -1);
 }
 
 /**
@@ -837,471 +841,3 @@ const struct ubifs_lprops *ubifs_fast_find_frdi_idx(struct ubifs_info *c)
 	ubifs_assert(c, lprops->free + lprops->dirty == c->leb_size);
 	return lprops;
 }
-
-/*
- * Everything below is related to debugging.
- */
-
-/**
- * dbg_check_cats - check category heaps and lists.
- * @c: UBIFS file-system description object
- *
- * This function returns %0 on success and a negative error code on failure.
- */
-int dbg_check_cats(struct ubifs_info *c)
-{
-	struct ubifs_lprops *lprops;
-	struct list_head *pos;
-	int i, cat;
-
-	if (!dbg_is_chk_gen(c) && !dbg_is_chk_lprops(c))
-		return 0;
-
-	list_for_each_entry(lprops, &c->empty_list, list) {
-		if (lprops->free != c->leb_size) {
-			ubifs_err(c, "non-empty LEB %d on empty list (free %d dirty %d flags %d)",
-				  lprops->lnum, lprops->free, lprops->dirty,
-				  lprops->flags);
-			return -EINVAL;
-		}
-		if (lprops->flags & LPROPS_TAKEN) {
-			ubifs_err(c, "taken LEB %d on empty list (free %d dirty %d flags %d)",
-				  lprops->lnum, lprops->free, lprops->dirty,
-				  lprops->flags);
-			return -EINVAL;
-		}
-	}
-
-	i = 0;
-	list_for_each_entry(lprops, &c->freeable_list, list) {
-		if (lprops->free + lprops->dirty != c->leb_size) {
-			ubifs_err(c, "non-freeable LEB %d on freeable list (free %d dirty %d flags %d)",
-				  lprops->lnum, lprops->free, lprops->dirty,
-				  lprops->flags);
-			return -EINVAL;
-		}
-		if (lprops->flags & LPROPS_TAKEN) {
-			ubifs_err(c, "taken LEB %d on freeable list (free %d dirty %d flags %d)",
-				  lprops->lnum, lprops->free, lprops->dirty,
-				  lprops->flags);
-			return -EINVAL;
-		}
-		i += 1;
-	}
-	if (i != c->freeable_cnt) {
-		ubifs_err(c, "freeable list count %d expected %d", i,
-			  c->freeable_cnt);
-		return -EINVAL;
-	}
-
-	i = 0;
-	list_for_each(pos, &c->idx_gc)
-		i += 1;
-	if (i != c->idx_gc_cnt) {
-		ubifs_err(c, "idx_gc list count %d expected %d", i,
-			  c->idx_gc_cnt);
-		return -EINVAL;
-	}
-
-	list_for_each_entry(lprops, &c->frdi_idx_list, list) {
-		if (lprops->free + lprops->dirty != c->leb_size) {
-			ubifs_err(c, "non-freeable LEB %d on frdi_idx list (free %d dirty %d flags %d)",
-				  lprops->lnum, lprops->free, lprops->dirty,
-				  lprops->flags);
-			return -EINVAL;
-		}
-		if (lprops->flags & LPROPS_TAKEN) {
-			ubifs_err(c, "taken LEB %d on frdi_idx list (free %d dirty %d flags %d)",
-				  lprops->lnum, lprops->free, lprops->dirty,
-				  lprops->flags);
-			return -EINVAL;
-		}
-		if (!(lprops->flags & LPROPS_INDEX)) {
-			ubifs_err(c, "non-index LEB %d on frdi_idx list (free %d dirty %d flags %d)",
-				  lprops->lnum, lprops->free, lprops->dirty,
-				  lprops->flags);
-			return -EINVAL;
-		}
-	}
-
-	for (cat = 1; cat <= LPROPS_HEAP_CNT; cat++) {
-		struct ubifs_lpt_heap *heap = &c->lpt_heap[cat - 1];
-
-		for (i = 0; i < heap->cnt; i++) {
-			lprops = heap->arr[i];
-			if (!lprops) {
-				ubifs_err(c, "null ptr in LPT heap cat %d", cat);
-				return -EINVAL;
-			}
-			if (lprops->hpos != i) {
-				ubifs_err(c, "bad ptr in LPT heap cat %d", cat);
-				return -EINVAL;
-			}
-			if (lprops->flags & LPROPS_TAKEN) {
-				ubifs_err(c, "taken LEB in LPT heap cat %d", cat);
-				return -EINVAL;
-			}
-		}
-	}
-
-	return 0;
-}
-
-void dbg_check_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap, int cat,
-		    int add_pos)
-{
-	int i = 0, j, err = 0;
-
-	if (!dbg_is_chk_gen(c) && !dbg_is_chk_lprops(c))
-		return;
-
-	for (i = 0; i < heap->cnt; i++) {
-		struct ubifs_lprops *lprops = heap->arr[i];
-		struct ubifs_lprops *lp;
-
-		if (i != add_pos)
-			if ((lprops->flags & LPROPS_CAT_MASK) != cat) {
-				err = 1;
-				goto out;
-			}
-		if (lprops->hpos != i) {
-			err = 2;
-			goto out;
-		}
-		lp = ubifs_lpt_lookup(c, lprops->lnum);
-		if (IS_ERR(lp)) {
-			err = 3;
-			goto out;
-		}
-		if (lprops != lp) {
-			ubifs_err(c, "lprops %zx lp %zx lprops->lnum %d lp->lnum %d",
-				  (size_t)lprops, (size_t)lp, lprops->lnum,
-				  lp->lnum);
-			err = 4;
-			goto out;
-		}
-		for (j = 0; j < i; j++) {
-			lp = heap->arr[j];
-			if (lp == lprops) {
-				err = 5;
-				goto out;
-			}
-			if (lp->lnum == lprops->lnum) {
-				err = 6;
-				goto out;
-			}
-		}
-	}
-out:
-	if (err) {
-		ubifs_err(c, "failed cat %d hpos %d err %d", cat, i, err);
-		dump_stack();
-		ubifs_dump_heap(c, heap, cat);
-	}
-}
-
-/**
- * scan_check_cb - scan callback.
- * @c: the UBIFS file-system description object
- * @lp: LEB properties to scan
- * @in_tree: whether the LEB properties are in main memory
- * @lst: lprops statistics to update
- *
- * This function returns a code that indicates whether the scan should continue
- * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
- * in main memory (%LPT_SCAN_ADD), or whether the scan should stop
- * (%LPT_SCAN_STOP).
- */
-static int scan_check_cb(struct ubifs_info *c,
-			 const struct ubifs_lprops *lp, int in_tree,
-			 struct ubifs_lp_stats *lst)
-{
-	struct ubifs_scan_leb *sleb;
-	struct ubifs_scan_node *snod;
-	int cat, lnum = lp->lnum, is_idx = 0, used = 0, free, dirty, ret;
-	void *buf = NULL;
-
-	cat = lp->flags & LPROPS_CAT_MASK;
-	if (cat != LPROPS_UNCAT) {
-		cat = ubifs_categorize_lprops(c, lp);
-		if (cat != (lp->flags & LPROPS_CAT_MASK)) {
-			ubifs_err(c, "bad LEB category %d expected %d",
-				  (lp->flags & LPROPS_CAT_MASK), cat);
-			return -EINVAL;
-		}
-	}
-
-	/* Check lp is on its category list (if it has one) */
-	if (in_tree) {
-		struct list_head *list = NULL;
-
-		switch (cat) {
-		case LPROPS_EMPTY:
-			list = &c->empty_list;
-			break;
-		case LPROPS_FREEABLE:
-			list = &c->freeable_list;
-			break;
-		case LPROPS_FRDI_IDX:
-			list = &c->frdi_idx_list;
-			break;
-		case LPROPS_UNCAT:
-			list = &c->uncat_list;
-			break;
-		}
-		if (list) {
-			struct ubifs_lprops *lprops;
-			int found = 0;
-
-			list_for_each_entry(lprops, list, list) {
-				if (lprops == lp) {
-					found = 1;
-					break;
-				}
-			}
-			if (!found) {
-				ubifs_err(c, "bad LPT list (category %d)", cat);
-				return -EINVAL;
-			}
-		}
-	}
-
-	/* Check lp is on its category heap (if it has one) */
-	if (in_tree && cat > 0 && cat <= LPROPS_HEAP_CNT) {
-		struct ubifs_lpt_heap *heap = &c->lpt_heap[cat - 1];
-
-		if ((lp->hpos != -1 && heap->arr[lp->hpos]->lnum != lnum) ||
-		    lp != heap->arr[lp->hpos]) {
-			ubifs_err(c, "bad LPT heap (category %d)", cat);
-			return -EINVAL;
-		}
-	}
-
-	/*
-	 * After an unclean unmount, empty and freeable LEBs
-	 * may contain garbage - do not scan them.
-	 */
-	if (lp->free == c->leb_size) {
-		lst->empty_lebs += 1;
-		lst->total_free += c->leb_size;
-		lst->total_dark += ubifs_calc_dark(c, c->leb_size);
-		return LPT_SCAN_CONTINUE;
-	}
-	if (lp->free + lp->dirty == c->leb_size &&
-	    !(lp->flags & LPROPS_INDEX)) {
-		lst->total_free  += lp->free;
-		lst->total_dirty += lp->dirty;
-		lst->total_dark  +=  ubifs_calc_dark(c, c->leb_size);
-		return LPT_SCAN_CONTINUE;
-	}
-
-	buf = __vmalloc(c->leb_size, GFP_NOFS);
-	if (!buf)
-		return -ENOMEM;
-
-	sleb = ubifs_scan(c, lnum, 0, buf, 0);
-	if (IS_ERR(sleb)) {
-		ret = PTR_ERR(sleb);
-		if (ret == -EUCLEAN) {
-			ubifs_dump_lprops(c);
-			ubifs_dump_budg(c, &c->bi);
-		}
-		goto out;
-	}
-
-	is_idx = -1;
-	list_for_each_entry(snod, &sleb->nodes, list) {
-		int found, level = 0;
-
-		cond_resched();
-
-		if (is_idx == -1)
-			is_idx = (snod->type == UBIFS_IDX_NODE) ? 1 : 0;
-
-		if (is_idx && snod->type != UBIFS_IDX_NODE) {
-			ubifs_err(c, "indexing node in data LEB %d:%d",
-				  lnum, snod->offs);
-			goto out_destroy;
-		}
-
-		if (snod->type == UBIFS_IDX_NODE) {
-			struct ubifs_idx_node *idx = snod->node;
-
-			key_read(c, ubifs_idx_key(c, idx), &snod->key);
-			level = le16_to_cpu(idx->level);
-		}
-
-		found = ubifs_tnc_has_node(c, &snod->key, level, lnum,
-					   snod->offs, is_idx);
-		if (found) {
-			if (found < 0)
-				goto out_destroy;
-			used += ALIGN(snod->len, 8);
-		}
-	}
-
-	free = c->leb_size - sleb->endpt;
-	dirty = sleb->endpt - used;
-
-	if (free > c->leb_size || free < 0 || dirty > c->leb_size ||
-	    dirty < 0) {
-		ubifs_err(c, "bad calculated accounting for LEB %d: free %d, dirty %d",
-			  lnum, free, dirty);
-		goto out_destroy;
-	}
-
-	if (lp->free + lp->dirty == c->leb_size &&
-	    free + dirty == c->leb_size)
-		if ((is_idx && !(lp->flags & LPROPS_INDEX)) ||
-		    (!is_idx && free == c->leb_size) ||
-		    lp->free == c->leb_size) {
-			/*
-			 * Empty or freeable LEBs could contain index
-			 * nodes from an uncompleted commit due to an
-			 * unclean unmount. Or they could be empty for
-			 * the same reason. Or it may simply not have been
-			 * unmapped.
-			 */
-			free = lp->free;
-			dirty = lp->dirty;
-			is_idx = 0;
-		    }
-
-	if (is_idx && lp->free + lp->dirty == free + dirty &&
-	    lnum != c->ihead_lnum) {
-		/*
-		 * After an unclean unmount, an index LEB could have a different
-		 * amount of free space than the value recorded by lprops. That
-		 * is because the in-the-gaps method may use free space or
-		 * create free space (as a side-effect of using ubi_leb_change
-		 * and not writing the whole LEB). The incorrect free space
-		 * value is not a problem because the index is only ever
-		 * allocated empty LEBs, so there will never be an attempt to
-		 * write to the free space at the end of an index LEB - except
-		 * by the in-the-gaps method for which it is not a problem.
-		 */
-		free = lp->free;
-		dirty = lp->dirty;
-	}
-
-	if (lp->free != free || lp->dirty != dirty)
-		goto out_print;
-
-	if (is_idx && !(lp->flags & LPROPS_INDEX)) {
-		if (free == c->leb_size)
-			/* Free but not unmapped LEB, it's fine */
-			is_idx = 0;
-		else {
-			ubifs_err(c, "indexing node without indexing flag");
-			goto out_print;
-		}
-	}
-
-	if (!is_idx && (lp->flags & LPROPS_INDEX)) {
-		ubifs_err(c, "data node with indexing flag");
-		goto out_print;
-	}
-
-	if (free == c->leb_size)
-		lst->empty_lebs += 1;
-
-	if (is_idx)
-		lst->idx_lebs += 1;
-
-	if (!(lp->flags & LPROPS_INDEX))
-		lst->total_used += c->leb_size - free - dirty;
-	lst->total_free += free;
-	lst->total_dirty += dirty;
-
-	if (!(lp->flags & LPROPS_INDEX)) {
-		int spc = free + dirty;
-
-		if (spc < c->dead_wm)
-			lst->total_dead += spc;
-		else
-			lst->total_dark += ubifs_calc_dark(c, spc);
-	}
-
-	ubifs_scan_destroy(sleb);
-	vfree(buf);
-	return LPT_SCAN_CONTINUE;
-
-out_print:
-	ubifs_err(c, "bad accounting of LEB %d: free %d, dirty %d flags %#x, should be free %d, dirty %d",
-		  lnum, lp->free, lp->dirty, lp->flags, free, dirty);
-	ubifs_dump_leb(c, lnum);
-out_destroy:
-	ubifs_scan_destroy(sleb);
-	ret = -EINVAL;
-out:
-	vfree(buf);
-	return ret;
-}
-
-/**
- * dbg_check_lprops - check all LEB properties.
- * @c: UBIFS file-system description object
- *
- * This function checks all LEB properties and makes sure they are all correct.
- * It returns zero if everything is fine, %-EINVAL if there is an inconsistency
- * and other negative error codes in case of other errors. This function is
- * called while the file system is locked (because of commit start), so no
- * additional locking is required. Note that locking the LPT mutex would cause
- * a circular lock dependency with the TNC mutex.
- */
-int dbg_check_lprops(struct ubifs_info *c)
-{
-	int i, err;
-	struct ubifs_lp_stats lst;
-
-	if (!dbg_is_chk_lprops(c))
-		return 0;
-
-	/*
-	 * As we are going to scan the media, the write buffers have to be
-	 * synchronized.
-	 */
-	for (i = 0; i < c->jhead_cnt; i++) {
-		err = ubifs_wbuf_sync(&c->jheads[i].wbuf);
-		if (err)
-			return err;
-	}
-
-	memset(&lst, 0, sizeof(struct ubifs_lp_stats));
-	err = ubifs_lpt_scan_nolock(c, c->main_first, c->leb_cnt - 1,
-				    (ubifs_lpt_scan_callback)scan_check_cb,
-				    &lst);
-	if (err && err != -ENOSPC)
-		goto out;
-
-	if (lst.empty_lebs != c->lst.empty_lebs ||
-	    lst.idx_lebs != c->lst.idx_lebs ||
-	    lst.total_free != c->lst.total_free ||
-	    lst.total_dirty != c->lst.total_dirty ||
-	    lst.total_used != c->lst.total_used) {
-		ubifs_err(c, "bad overall accounting");
-		ubifs_err(c, "calculated: empty_lebs %d, idx_lebs %d, total_free %lld, total_dirty %lld, total_used %lld",
-			  lst.empty_lebs, lst.idx_lebs, lst.total_free,
-			  lst.total_dirty, lst.total_used);
-		ubifs_err(c, "read from lprops: empty_lebs %d, idx_lebs %d, total_free %lld, total_dirty %lld, total_used %lld",
-			  c->lst.empty_lebs, c->lst.idx_lebs, c->lst.total_free,
-			  c->lst.total_dirty, c->lst.total_used);
-		err = -EINVAL;
-		goto out;
-	}
-
-	if (lst.total_dead != c->lst.total_dead ||
-	    lst.total_dark != c->lst.total_dark) {
-		ubifs_err(c, "bad dead/dark space accounting");
-		ubifs_err(c, "calculated: total_dead %lld, total_dark %lld",
-			  lst.total_dead, lst.total_dark);
-		ubifs_err(c, "read from lprops: total_dead %lld, total_dark %lld",
-			  c->lst.total_dead, c->lst.total_dark);
-		err = -EINVAL;
-		goto out;
-	}
-
-	err = dbg_check_cats(c);
-out:
-	return err;
-}
diff --git a/ubifs-utils/libubifs/lpt.c b/ubifs-utils/libubifs/lpt.c
index 1889170b..92b3fec8 100644
--- a/ubifs-utils/libubifs/lpt.c
+++ b/ubifs-utils/libubifs/lpt.c
@@ -31,10 +31,13 @@
  * mounted.
  */
 
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
+#include "crc16.h"
 #include "ubifs.h"
-#include <linux/crc16.h>
-#include <linux/math64.h>
-#include <linux/slab.h>
+#include "defs.h"
+#include "debug.h"
 
 /**
  * do_calc_lpt_geom - calculate sizes for the LPT area.
@@ -48,8 +51,20 @@ static void do_calc_lpt_geom(struct ubifs_info *c)
 	int i, n, bits, per_leb_wastage, max_pnode_cnt;
 	long long sz, tot_wastage;
 
-	n = c->main_lebs + c->max_leb_cnt - c->leb_cnt;
-	max_pnode_cnt = DIV_ROUND_UP(n, UBIFS_LPT_FANOUT);
+	if (c->program_type != MKFS_PROGRAM_TYPE) {
+		n = c->main_lebs + c->max_leb_cnt - c->leb_cnt;
+		max_pnode_cnt = DIV_ROUND_UP(n, UBIFS_LPT_FANOUT);
+	} else {
+		/*
+		 * Different from linux kernel.
+		 *
+		 * We change it, because 'c->leb_cnt' is not initialized in
+		 * mkfs.ubifs when do_calc_lpt_geom() is invoked, 'c->main_lebs'
+		 * is calculated by 'c->max_leb_cnt', so the 'c->lpt_hght'
+		 * should be calculated by 'c->main_lebs'.
+		 */
+		max_pnode_cnt = DIV_ROUND_UP(c->main_lebs, UBIFS_LPT_FANOUT);
+	}
 
 	c->lpt_hght = 1;
 	n = UBIFS_LPT_FANOUT;
@@ -148,7 +163,7 @@ int ubifs_calc_lpt_geom(struct ubifs_info *c)
 }
 
 /**
- * calc_dflt_lpt_geom - calculate default LPT geometry.
+ * ubifs_calc_dflt_lpt_geom - calculate default LPT geometry.
  * @c: the UBIFS file-system description object
  * @main_lebs: number of main area LEBs is passed and returned here
  * @big_lpt: whether the LPT area is "big" is returned here
@@ -159,8 +174,7 @@ int ubifs_calc_lpt_geom(struct ubifs_info *c)
  *
  * This function returns %0 on success and a negative error code on failure.
  */
-static int calc_dflt_lpt_geom(struct ubifs_info *c, int *main_lebs,
-			      int *big_lpt)
+int ubifs_calc_dflt_lpt_geom(struct ubifs_info *c, int *main_lebs, int *big_lpt)
 {
 	int i, lebs_needed;
 	long long sz;
@@ -275,7 +289,7 @@ uint32_t ubifs_unpack_bits(const struct ubifs_info *c, uint8_t **addr, int *pos,
 	const int k = 32 - nrbits;
 	uint8_t *p = *addr;
 	int b = *pos;
-	uint32_t val;
+	uint32_t val = 0;
 	const int bytes = (nrbits + b + 7) >> 3;
 
 	ubifs_assert(c, nrbits > 0);
@@ -638,8 +652,13 @@ int ubifs_create_lpt(struct ubifs_info *c, struct ubifs_lprops *lps, int lp_cnt,
 	lnum = c->lpt_first;
 	p = buf;
 	len = 0;
-	/* Number of leaf nodes (pnodes) */
-	cnt = c->pnode_cnt;
+	/*
+	 * Different from linux kernel. The number of leaf nodes (pnodes) should
+	 * be calculated by the number of current main LEBs. The 'c->pnode_cnt'
+	 * may not be equal to 'DIV_ROUND_UP(c->main_lebs, UBIFS_LPT_FANOUT)' in
+	 * mkfs when 'c->leb_cnt != c->max_leb_cnt' is true.
+	 */
+	cnt = DIV_ROUND_UP(c->main_lebs, UBIFS_LPT_FANOUT);
 
 	/*
 	 * To calculate the internal node branches, we keep information about
@@ -655,8 +674,19 @@ int ubifs_create_lpt(struct ubifs_info *c, struct ubifs_lprops *lps, int lp_cnt,
 		if (len + c->pnode_sz > c->leb_size) {
 			alen = ALIGN(len, c->min_io_size);
 			set_ltab(c, lnum, c->leb_size - alen, alen - len);
-			memset(p, 0xff, alen - len);
-			err = ubifs_leb_change(c, lnum++, buf, alen);
+			/*
+			 * Different from linux kernel.
+			 * The mkfs may partially write data into a certain LEB
+			 * of file image, the left unwritten area in the LEB
+			 * should be filled with '0xFF'.
+			 */
+			if (c->libubi) {
+				memset(p, 0xff, alen - len);
+				err = ubifs_leb_change(c, lnum++, buf, alen);
+			} else {
+				memset(p, 0xff, c->leb_size - len);
+				err = ubifs_leb_change(c, lnum++, buf, c->leb_size);
+			}
 			if (err)
 				goto out;
 			p = buf;
@@ -691,27 +721,45 @@ int ubifs_create_lpt(struct ubifs_info *c, struct ubifs_lprops *lps, int lp_cnt,
 		pnode->num += 1;
 	}
 
-	row = 0;
-	for (i = UBIFS_LPT_FANOUT; cnt > i; i <<= UBIFS_LPT_FANOUT_SHIFT)
-		row += 1;
+	/*
+	 * Different from linux kernel. The 'c->lpt_hght' is calculated by the
+	 * 'c->max_leb_cnt', according to the implementation of function
+	 * ubifs_pnode_lookup(), there are at least 'c->lpt_hght' cnodes should
+	 * be created, otherwise the LPT looking up could be failed after
+	 * mouting.
+	 */
+	row = c->lpt_hght - 1;
 	/* Add all nnodes, one level at a time */
 	while (1) {
 		/* Number of internal nodes (nnodes) at next level */
 		cnt = DIV_ROUND_UP(cnt, UBIFS_LPT_FANOUT);
+		if (cnt == 0)
+			cnt = 1;
 		for (i = 0; i < cnt; i++) {
 			if (len + c->nnode_sz > c->leb_size) {
 				alen = ALIGN(len, c->min_io_size);
 				set_ltab(c, lnum, c->leb_size - alen,
 					    alen - len);
-				memset(p, 0xff, alen - len);
-				err = ubifs_leb_change(c, lnum++, buf, alen);
+				/*
+				 * Different from linux kernel.
+				 * The mkfs may partially write data into a certain LEB
+				 * of file image, the left unwritten area in the LEB
+				 * should be filled with '0xFF'.
+				 */
+				if (c->libubi) {
+					memset(p, 0xff, alen - len);
+					err = ubifs_leb_change(c, lnum++, buf, alen);
+				} else {
+					memset(p, 0xff, c->leb_size - len);
+					err = ubifs_leb_change(c, lnum++, buf, c->leb_size);
+				}
 				if (err)
 					goto out;
 				p = buf;
 				len = 0;
 			}
 			/* Only 1 nnode at this level, so it is the root */
-			if (cnt == 1) {
+			if (row == 0) {
 				c->lpt_lnum = lnum;
 				c->lpt_offs = len;
 			}
@@ -736,8 +784,8 @@ int ubifs_create_lpt(struct ubifs_info *c, struct ubifs_lprops *lps, int lp_cnt,
 			p += c->nnode_sz;
 			len += c->nnode_sz;
 		}
-		/* Only 1 nnode at this level, so it is the root */
-		if (cnt == 1)
+		/* Row zero  is the top row */
+		if (row == 0)
 			break;
 		/* Update the information about the level below */
 		bcnt = cnt;
@@ -750,8 +798,19 @@ int ubifs_create_lpt(struct ubifs_info *c, struct ubifs_lprops *lps, int lp_cnt,
 		if (len + c->lsave_sz > c->leb_size) {
 			alen = ALIGN(len, c->min_io_size);
 			set_ltab(c, lnum, c->leb_size - alen, alen - len);
-			memset(p, 0xff, alen - len);
-			err = ubifs_leb_change(c, lnum++, buf, alen);
+			/*
+			 * Different from linux kernel.
+			 * The mkfs may partially write data into a certain LEB
+			 * of file image, the left unwritten area in the LEB
+			 * should be filled with '0xFF'.
+			 */
+			if (c->libubi) {
+				memset(p, 0xff, alen - len);
+				err = ubifs_leb_change(c, lnum++, buf, alen);
+			} else {
+				memset(p, 0xff, c->leb_size - len);
+				err = ubifs_leb_change(c, lnum++, buf, c->leb_size);
+			}
 			if (err)
 				goto out;
 			p = buf;
@@ -775,8 +834,19 @@ int ubifs_create_lpt(struct ubifs_info *c, struct ubifs_lprops *lps, int lp_cnt,
 	if (len + c->ltab_sz > c->leb_size) {
 		alen = ALIGN(len, c->min_io_size);
 		set_ltab(c, lnum, c->leb_size - alen, alen - len);
-		memset(p, 0xff, alen - len);
-		err = ubifs_leb_change(c, lnum++, buf, alen);
+		/*
+		 * Different from linux kernel.
+		 * The mkfs may partially write data into a certain LEB
+		 * of file image, the left unwritten area in the LEB
+		 * should be filled with '0xFF'.
+		 */
+		if (c->libubi) {
+			memset(p, 0xff, alen - len);
+			err = ubifs_leb_change(c, lnum++, buf, alen);
+		} else {
+			memset(p, 0xff, c->leb_size - len);
+			err = ubifs_leb_change(c, lnum++, buf, c->leb_size);
+		}
 		if (err)
 			goto out;
 		p = buf;
@@ -795,11 +865,25 @@ int ubifs_create_lpt(struct ubifs_info *c, struct ubifs_lprops *lps, int lp_cnt,
 	p += c->ltab_sz;
 
 	/* Write remaining buffer */
-	memset(p, 0xff, alen - len);
-	err = ubifs_leb_change(c, lnum, buf, alen);
+	/*
+	 * Different from linux kernel.
+	 * The mkfs may partially write data into a certain LEB
+	 * of file image, the left unwritten area in the LEB
+	 * should be filled with '0xFF'.
+	 */
+	if (c->libubi) {
+		memset(p, 0xff, alen - len);
+		err = ubifs_leb_change(c, lnum, buf, alen);
+	} else {
+		memset(p, 0xff, c->leb_size - len);
+		err = ubifs_leb_change(c, lnum, buf, c->leb_size);
+	}
 	if (err)
 		goto out;
 
+	if (c->big_lpt && c->lsave)
+		memcpy(c->lsave, lsave, c->lsave_cnt * sizeof(int));
+
 	err = ubifs_shash_final(c, desc, hash);
 	if (err)
 		goto out;
@@ -837,54 +921,6 @@ out:
 }
 
 /**
- * ubifs_create_dflt_lpt - create default LPT.
- * @c: UBIFS file-system description object
- * @main_lebs: number of main area LEBs is passed and returned here
- * @lpt_first: LEB number of first LPT LEB
- * @lpt_lebs: number of LEBs for LPT is passed and returned here
- * @big_lpt: use big LPT model is passed and returned here
- * @hash: hash of the LPT is returned here
- *
- * This function returns %0 on success and a negative error code on failure.
- */
-int ubifs_create_dflt_lpt(struct ubifs_info *c, int *main_lebs, int lpt_first,
-			  int *lpt_lebs, int *big_lpt, u8 *hash)
-{
-	int node_sz, iopos, err = 0;
-	struct ubifs_lprops lps[2];
-
-	err = calc_dflt_lpt_geom(c, main_lebs, big_lpt);
-	if (err)
-		return err;
-	*lpt_lebs = c->lpt_lebs;
-
-	/* Needed by 'ubifs_pack_nnode()' and 'set_ltab()' */
-	c->lpt_first = lpt_first;
-	/* Needed by 'set_ltab()' */
-	c->lpt_last = lpt_first + c->lpt_lebs - 1;
-	/* Needed by 'ubifs_pack_lsave()' */
-	c->main_first = c->leb_cnt - *main_lebs;
-
-	/*
-	 * The first pnode contains the LEB properties for the LEBs that contain
-	 * the root inode node and the root index node of the index tree.
-	 */
-	node_sz = ALIGN(ubifs_idx_node_sz(c, 1), 8);
-	iopos = ALIGN(node_sz, c->min_io_size);
-	lps[0].free = c->leb_size - iopos;
-	lps[0].dirty = iopos - node_sz;
-	lps[0].flags = LPROPS_INDEX;
-
-	node_sz = UBIFS_INO_NODE_SZ;
-	iopos = ALIGN(node_sz, c->min_io_size);
-	lps[1].free = c->leb_size - iopos;
-	lps[1].dirty = iopos - node_sz;
-	lps[1].flags = 0;
-
-	return ubifs_create_lpt(c, lps, 2, hash);
-}
-
-/**
  * update_cats - add LEB properties of a pnode to LEB category lists and heaps.
  * @c: UBIFS file-system description object
  * @pnode: pnode
@@ -2254,198 +2290,3 @@ out:
 	kfree(path);
 	return err;
 }
-
-/**
- * dbg_chk_pnode - check a pnode.
- * @c: the UBIFS file-system description object
- * @pnode: pnode to check
- * @col: pnode column
- *
- * This function returns %0 on success and a negative error code on failure.
- */
-static int dbg_chk_pnode(struct ubifs_info *c, struct ubifs_pnode *pnode,
-			 int col)
-{
-	int i;
-
-	if (pnode->num != col) {
-		ubifs_err(c, "pnode num %d expected %d parent num %d iip %d",
-			  pnode->num, col, pnode->parent->num, pnode->iip);
-		return -EINVAL;
-	}
-	for (i = 0; i < UBIFS_LPT_FANOUT; i++) {
-		struct ubifs_lprops *lp, *lprops = &pnode->lprops[i];
-		int lnum = (pnode->num << UBIFS_LPT_FANOUT_SHIFT) + i +
-			   c->main_first;
-		int found, cat = lprops->flags & LPROPS_CAT_MASK;
-		struct ubifs_lpt_heap *heap;
-		struct list_head *list = NULL;
-
-		if (lnum >= c->leb_cnt)
-			continue;
-		if (lprops->lnum != lnum) {
-			ubifs_err(c, "bad LEB number %d expected %d",
-				  lprops->lnum, lnum);
-			return -EINVAL;
-		}
-		if (lprops->flags & LPROPS_TAKEN) {
-			if (cat != LPROPS_UNCAT) {
-				ubifs_err(c, "LEB %d taken but not uncat %d",
-					  lprops->lnum, cat);
-				return -EINVAL;
-			}
-			continue;
-		}
-		if (lprops->flags & LPROPS_INDEX) {
-			switch (cat) {
-			case LPROPS_UNCAT:
-			case LPROPS_DIRTY_IDX:
-			case LPROPS_FRDI_IDX:
-				break;
-			default:
-				ubifs_err(c, "LEB %d index but cat %d",
-					  lprops->lnum, cat);
-				return -EINVAL;
-			}
-		} else {
-			switch (cat) {
-			case LPROPS_UNCAT:
-			case LPROPS_DIRTY:
-			case LPROPS_FREE:
-			case LPROPS_EMPTY:
-			case LPROPS_FREEABLE:
-				break;
-			default:
-				ubifs_err(c, "LEB %d not index but cat %d",
-					  lprops->lnum, cat);
-				return -EINVAL;
-			}
-		}
-		switch (cat) {
-		case LPROPS_UNCAT:
-			list = &c->uncat_list;
-			break;
-		case LPROPS_EMPTY:
-			list = &c->empty_list;
-			break;
-		case LPROPS_FREEABLE:
-			list = &c->freeable_list;
-			break;
-		case LPROPS_FRDI_IDX:
-			list = &c->frdi_idx_list;
-			break;
-		}
-		found = 0;
-		switch (cat) {
-		case LPROPS_DIRTY:
-		case LPROPS_DIRTY_IDX:
-		case LPROPS_FREE:
-			heap = &c->lpt_heap[cat - 1];
-			if (lprops->hpos < heap->cnt &&
-			    heap->arr[lprops->hpos] == lprops)
-				found = 1;
-			break;
-		case LPROPS_UNCAT:
-		case LPROPS_EMPTY:
-		case LPROPS_FREEABLE:
-		case LPROPS_FRDI_IDX:
-			list_for_each_entry(lp, list, list)
-				if (lprops == lp) {
-					found = 1;
-					break;
-				}
-			break;
-		}
-		if (!found) {
-			ubifs_err(c, "LEB %d cat %d not found in cat heap/list",
-				  lprops->lnum, cat);
-			return -EINVAL;
-		}
-		switch (cat) {
-		case LPROPS_EMPTY:
-			if (lprops->free != c->leb_size) {
-				ubifs_err(c, "LEB %d cat %d free %d dirty %d",
-					  lprops->lnum, cat, lprops->free,
-					  lprops->dirty);
-				return -EINVAL;
-			}
-			break;
-		case LPROPS_FREEABLE:
-		case LPROPS_FRDI_IDX:
-			if (lprops->free + lprops->dirty != c->leb_size) {
-				ubifs_err(c, "LEB %d cat %d free %d dirty %d",
-					  lprops->lnum, cat, lprops->free,
-					  lprops->dirty);
-				return -EINVAL;
-			}
-			break;
-		}
-	}
-	return 0;
-}
-
-/**
- * dbg_check_lpt_nodes - check nnodes and pnodes.
- * @c: the UBIFS file-system description object
- * @cnode: next cnode (nnode or pnode) to check
- * @row: row of cnode (root is zero)
- * @col: column of cnode (leftmost is zero)
- *
- * This function returns %0 on success and a negative error code on failure.
- */
-int dbg_check_lpt_nodes(struct ubifs_info *c, struct ubifs_cnode *cnode,
-			int row, int col)
-{
-	struct ubifs_nnode *nnode, *nn;
-	struct ubifs_cnode *cn;
-	int num, iip = 0, err;
-
-	if (!dbg_is_chk_lprops(c))
-		return 0;
-
-	while (cnode) {
-		ubifs_assert(c, row >= 0);
-		nnode = cnode->parent;
-		if (cnode->level) {
-			/* cnode is a nnode */
-			num = calc_nnode_num(row, col);
-			if (cnode->num != num) {
-				ubifs_err(c, "nnode num %d expected %d parent num %d iip %d",
-					  cnode->num, num,
-					  (nnode ? nnode->num : 0), cnode->iip);
-				return -EINVAL;
-			}
-			nn = (struct ubifs_nnode *)cnode;
-			while (iip < UBIFS_LPT_FANOUT) {
-				cn = nn->nbranch[iip].cnode;
-				if (cn) {
-					/* Go down */
-					row += 1;
-					col <<= UBIFS_LPT_FANOUT_SHIFT;
-					col += iip;
-					iip = 0;
-					cnode = cn;
-					break;
-				}
-				/* Go right */
-				iip += 1;
-			}
-			if (iip < UBIFS_LPT_FANOUT)
-				continue;
-		} else {
-			struct ubifs_pnode *pnode;
-
-			/* cnode is a pnode */
-			pnode = (struct ubifs_pnode *)cnode;
-			err = dbg_chk_pnode(c, pnode, col);
-			if (err)
-				return err;
-		}
-		/* Go up and to the right */
-		row -= 1;
-		col >>= UBIFS_LPT_FANOUT_SHIFT;
-		iip = cnode->iip + 1;
-		cnode = (struct ubifs_cnode *)nnode;
-	}
-	return 0;
-}
diff --git a/ubifs-utils/libubifs/lpt_commit.c b/ubifs-utils/libubifs/lpt_commit.c
index c4d07932..b00f75f0 100644
--- a/ubifs-utils/libubifs/lpt_commit.c
+++ b/ubifs-utils/libubifs/lpt_commit.c
@@ -13,10 +13,14 @@
  * subsystem.
  */
 
-#include <linux/crc16.h>
-#include <linux/slab.h>
-#include <linux/random.h>
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
+#include "crc16.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "misc.h"
 
 static int dbg_populate_lsave(struct ubifs_info *c);
 
@@ -1030,7 +1034,8 @@ static int get_lpt_node_len(const struct ubifs_info *c, int node_type)
  * @buf: buffer
  * @len: length of buffer
  */
-static int get_pad_len(const struct ubifs_info *c, uint8_t *buf, int len)
+static int get_pad_len(const struct ubifs_info *c, __unused uint8_t *buf,
+		       int len)
 {
 	int offs, pad_len;
 
@@ -1593,9 +1598,6 @@ static int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
 	int ret;
 	void *buf, *p;
 
-	if (!dbg_is_chk_lprops(c))
-		return 0;
-
 	buf = p = __vmalloc(c->leb_size, GFP_NOFS);
 	if (!buf) {
 		ubifs_err(c, "cannot allocate memory for ltab checking");
@@ -1646,190 +1648,12 @@ static int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
 		len -= node_len;
 	}
 
-	err = 0;
 out:
 	vfree(buf);
 	return err;
 }
 
 /**
- * dbg_check_ltab - check the free and dirty space in the ltab.
- * @c: the UBIFS file-system description object
- *
- * This function returns %0 on success and a negative error code on failure.
- */
-int dbg_check_ltab(struct ubifs_info *c)
-{
-	int lnum, err, i, cnt;
-
-	if (!dbg_is_chk_lprops(c))
-		return 0;
-
-	/* Bring the entire tree into memory */
-	cnt = DIV_ROUND_UP(c->main_lebs, UBIFS_LPT_FANOUT);
-	for (i = 0; i < cnt; i++) {
-		struct ubifs_pnode *pnode;
-
-		pnode = ubifs_pnode_lookup(c, i);
-		if (IS_ERR(pnode))
-			return PTR_ERR(pnode);
-		cond_resched();
-	}
-
-	/* Check nodes */
-	err = dbg_check_lpt_nodes(c, (struct ubifs_cnode *)c->nroot, 0, 0);
-	if (err)
-		return err;
-
-	/* Check each LEB */
-	for (lnum = c->lpt_first; lnum <= c->lpt_last; lnum++) {
-		err = dbg_check_ltab_lnum(c, lnum);
-		if (err) {
-			ubifs_err(c, "failed at LEB %d", lnum);
-			return err;
-		}
-	}
-
-	dbg_lp("succeeded");
-	return 0;
-}
-
-/**
- * dbg_chk_lpt_free_spc - check LPT free space is enough to write entire LPT.
- * @c: the UBIFS file-system description object
- *
- * This function returns %0 on success and a negative error code on failure.
- */
-int dbg_chk_lpt_free_spc(struct ubifs_info *c)
-{
-	long long free = 0;
-	int i;
-
-	if (!dbg_is_chk_lprops(c))
-		return 0;
-
-	for (i = 0; i < c->lpt_lebs; i++) {
-		if (c->ltab[i].tgc || c->ltab[i].cmt)
-			continue;
-		if (i + c->lpt_first == c->nhead_lnum)
-			free += c->leb_size - c->nhead_offs;
-		else if (c->ltab[i].free == c->leb_size)
-			free += c->leb_size;
-	}
-	if (free < c->lpt_sz) {
-		ubifs_err(c, "LPT space error: free %lld lpt_sz %lld",
-			  free, c->lpt_sz);
-		ubifs_dump_lpt_info(c);
-		ubifs_dump_lpt_lebs(c);
-		dump_stack();
-		return -EINVAL;
-	}
-	return 0;
-}
-
-/**
- * dbg_chk_lpt_sz - check LPT does not write more than LPT size.
- * @c: the UBIFS file-system description object
- * @action: what to do
- * @len: length written
- *
- * This function returns %0 on success and a negative error code on failure.
- * The @action argument may be one of:
- *   o %0 - LPT debugging checking starts, initialize debugging variables;
- *   o %1 - wrote an LPT node, increase LPT size by @len bytes;
- *   o %2 - switched to a different LEB and wasted @len bytes;
- *   o %3 - check that we've written the right number of bytes.
- *   o %4 - wasted @len bytes;
- */
-int dbg_chk_lpt_sz(struct ubifs_info *c, int action, int len)
-{
-	struct ubifs_debug_info *d = c->dbg;
-	long long chk_lpt_sz, lpt_sz;
-	int err = 0;
-
-	if (!dbg_is_chk_lprops(c))
-		return 0;
-
-	switch (action) {
-	case 0:
-		d->chk_lpt_sz = 0;
-		d->chk_lpt_sz2 = 0;
-		d->chk_lpt_lebs = 0;
-		d->chk_lpt_wastage = 0;
-		if (c->dirty_pn_cnt > c->pnode_cnt) {
-			ubifs_err(c, "dirty pnodes %d exceed max %d",
-				  c->dirty_pn_cnt, c->pnode_cnt);
-			err = -EINVAL;
-		}
-		if (c->dirty_nn_cnt > c->nnode_cnt) {
-			ubifs_err(c, "dirty nnodes %d exceed max %d",
-				  c->dirty_nn_cnt, c->nnode_cnt);
-			err = -EINVAL;
-		}
-		return err;
-	case 1:
-		d->chk_lpt_sz += len;
-		return 0;
-	case 2:
-		d->chk_lpt_sz += len;
-		d->chk_lpt_wastage += len;
-		d->chk_lpt_lebs += 1;
-		return 0;
-	case 3:
-		chk_lpt_sz = c->leb_size;
-		chk_lpt_sz *= d->chk_lpt_lebs;
-		chk_lpt_sz += len - c->nhead_offs;
-		if (d->chk_lpt_sz != chk_lpt_sz) {
-			ubifs_err(c, "LPT wrote %lld but space used was %lld",
-				  d->chk_lpt_sz, chk_lpt_sz);
-			err = -EINVAL;
-		}
-		if (d->chk_lpt_sz > c->lpt_sz) {
-			ubifs_err(c, "LPT wrote %lld but lpt_sz is %lld",
-				  d->chk_lpt_sz, c->lpt_sz);
-			err = -EINVAL;
-		}
-		if (d->chk_lpt_sz2 && d->chk_lpt_sz != d->chk_lpt_sz2) {
-			ubifs_err(c, "LPT layout size %lld but wrote %lld",
-				  d->chk_lpt_sz, d->chk_lpt_sz2);
-			err = -EINVAL;
-		}
-		if (d->chk_lpt_sz2 && d->new_nhead_offs != len) {
-			ubifs_err(c, "LPT new nhead offs: expected %d was %d",
-				  d->new_nhead_offs, len);
-			err = -EINVAL;
-		}
-		lpt_sz = (long long)c->pnode_cnt * c->pnode_sz;
-		lpt_sz += (long long)c->nnode_cnt * c->nnode_sz;
-		lpt_sz += c->ltab_sz;
-		if (c->big_lpt)
-			lpt_sz += c->lsave_sz;
-		if (d->chk_lpt_sz - d->chk_lpt_wastage > lpt_sz) {
-			ubifs_err(c, "LPT chk_lpt_sz %lld + waste %lld exceeds %lld",
-				  d->chk_lpt_sz, d->chk_lpt_wastage, lpt_sz);
-			err = -EINVAL;
-		}
-		if (err) {
-			ubifs_dump_lpt_info(c);
-			ubifs_dump_lpt_lebs(c);
-			dump_stack();
-		}
-		d->chk_lpt_sz2 = d->chk_lpt_sz;
-		d->chk_lpt_sz = 0;
-		d->chk_lpt_wastage = 0;
-		d->chk_lpt_lebs = 0;
-		d->new_nhead_offs = len;
-		return err;
-	case 4:
-		d->chk_lpt_sz += len;
-		d->chk_lpt_wastage += len;
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
-/**
  * dump_lpt_leb - dump an LPT LEB.
  * @c: UBIFS file-system description object
  * @lnum: LEB number to dump
@@ -1844,7 +1668,7 @@ static void dump_lpt_leb(const struct ubifs_info *c, int lnum)
 	int err, len = c->leb_size, node_type, node_num, node_len, offs;
 	void *buf, *p;
 
-	pr_err("(pid %d) start dumping LEB %d\n", current->pid, lnum);
+	pr_err("(pid %d) start dumping LEB %d\n", getpid(), lnum);
 	buf = p = __vmalloc(c->leb_size, GFP_NOFS);
 	if (!buf) {
 		ubifs_err(c, "cannot allocate memory to dump LPT");
@@ -1930,7 +1754,7 @@ static void dump_lpt_leb(const struct ubifs_info *c, int lnum)
 		len -= node_len;
 	}
 
-	pr_err("(pid %d) finish dumping LEB %d\n", current->pid, lnum);
+	pr_err("(pid %d) finish dumping LEB %d\n", getpid(), lnum);
 out:
 	vfree(buf);
 	return;
@@ -1947,10 +1771,10 @@ void ubifs_dump_lpt_lebs(const struct ubifs_info *c)
 {
 	int i;
 
-	pr_err("(pid %d) start dumping all LPT LEBs\n", current->pid);
+	pr_err("(pid %d) start dumping all LPT LEBs\n", getpid());
 	for (i = 0; i < c->lpt_lebs; i++)
 		dump_lpt_leb(c, i + c->lpt_first);
-	pr_err("(pid %d) finish dumping all LPT LEBs\n", current->pid);
+	pr_err("(pid %d) finish dumping all LPT LEBs\n", getpid());
 }
 
 /**
@@ -1962,36 +1786,7 @@ void ubifs_dump_lpt_lebs(const struct ubifs_info *c)
  * Returns zero if lsave has not been populated (this debugging feature is
  * disabled) an non-zero if lsave has been populated.
  */
-static int dbg_populate_lsave(struct ubifs_info *c)
+static int dbg_populate_lsave(__unused struct ubifs_info *c)
 {
-	struct ubifs_lprops *lprops;
-	struct ubifs_lpt_heap *heap;
-	int i;
-
-	if (!dbg_is_chk_gen(c))
-		return 0;
-	if (get_random_u32_below(4))
-		return 0;
-
-	for (i = 0; i < c->lsave_cnt; i++)
-		c->lsave[i] = c->main_first;
-
-	list_for_each_entry(lprops, &c->empty_list, list)
-		c->lsave[get_random_u32_below(c->lsave_cnt)] = lprops->lnum;
-	list_for_each_entry(lprops, &c->freeable_list, list)
-		c->lsave[get_random_u32_below(c->lsave_cnt)] = lprops->lnum;
-	list_for_each_entry(lprops, &c->frdi_idx_list, list)
-		c->lsave[get_random_u32_below(c->lsave_cnt)] = lprops->lnum;
-
-	heap = &c->lpt_heap[LPROPS_DIRTY_IDX - 1];
-	for (i = 0; i < heap->cnt; i++)
-		c->lsave[get_random_u32_below(c->lsave_cnt)] = heap->arr[i]->lnum;
-	heap = &c->lpt_heap[LPROPS_DIRTY - 1];
-	for (i = 0; i < heap->cnt; i++)
-		c->lsave[get_random_u32_below(c->lsave_cnt)] = heap->arr[i]->lnum;
-	heap = &c->lpt_heap[LPROPS_FREE - 1];
-	for (i = 0; i < heap->cnt; i++)
-		c->lsave[get_random_u32_below(c->lsave_cnt)] = heap->arr[i]->lnum;
-
-	return 1;
+	return 0;
 }
-- 
2.13.6


