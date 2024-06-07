Return-Path: <linux-kernel+bounces-205371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1594C8FFAD4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B38D287260
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6EC15D5B1;
	Fri,  7 Jun 2024 04:27:58 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7394161322
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734472; cv=none; b=MsD2IN96XOYo5fWUrpq98ImuvwBd0XuBp22SA93hgl4VfIJl7ftz1MGefi1fWDfi4fpUzs1mHV2M3LDVU5+gNj7ZNJCynB5KfthuWcnHUWg9/nZXRdIfqVskf1nkeSzNaxhB9rSGM8sw+3jKH4cUIt65qhufjVZsDInbnJwF8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734472; c=relaxed/simple;
	bh=2Carb4VoHY/81wMhrObI9PByVYrOPn/VXzdHePGXC2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHAY30RG/E1soMrgc+rDRTSgGLyG4/FhnA8FUjj6ue0j9dTCJ79hbe473S+mp+pxA1E2iJ7tV/VQaLG5jDWLlnBxGSN+zztumcANCtxHJjKOoLsHrsXxsZDN0MqqvdeX0yLIJgAFWqJpTabaeWqBMzlSUUyRyp2GQBROgkgcwcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSkQ3zwXzwSGb;
	Fri,  7 Jun 2024 12:23:42 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 73FBC180AA6;
	Fri,  7 Jun 2024 12:27:41 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:33 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 090/110] fsck.ubifs: check and correct the space statistics
Date: Fri, 7 Jun 2024 12:25:55 +0800
Message-ID: <20240607042615.2069840-91-chengzhihao1@huawei.com>
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

This is the 12/18 step of fsck. Check and correct the space statistics.
There could be following steps and possible errors:
 Step 1. Exit for check mode, if %FR_LPT_CORRUPTED or %FR_LPT_INCORRECT
 is set in lpt status, the exit code should have %FSCK_UNCORRECTED.
 Step 2. Check lpt status, if %FR_LPT_CORRUPTED is set in lpt status,
 normal mode with 'no' answer will exit, other modes will rebuild lpt.
 Step 3. Traverse LPT nodes, check the correctness of nnode and pnode,
 compare LEB scanning result with LEB properties.
  a. LPT node is corrupted, normal mode with 'no' answer will exit,
     rebuild lpt for other modes.
  b. Incorrect nnode/pnode, normal mode with 'no' answer will exit,
     other other modes will correct the nnode/pnode.
  c. Inconsistent comparing result, normal mode with 'no' answer
     will exit, other modes will correct the space statistics.
 Step 4. Check and correct the lprops table information.
 Step 5. Set gc lnum(ubifs_rcvry_gc_commit / take_gc_lnum).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/check_space.c | 572 ++++++++++++++++++++++++++++++++++-
 ubifs-utils/fsck.ubifs/fsck.ubifs.c  |  13 +
 ubifs-utils/fsck.ubifs/fsck.ubifs.h  |  58 +++-
 ubifs-utils/fsck.ubifs/problem.c     |  51 ++++
 ubifs-utils/fsck.ubifs/rebuild_fs.c  |   5 +-
 ubifs-utils/libubifs/lpt.c           |   9 +-
 ubifs-utils/libubifs/lpt_commit.c    |  18 +-
 ubifs-utils/libubifs/replay.c        |   2 +-
 ubifs-utils/libubifs/ubifs.h         |   5 +-
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c  |   2 +-
 10 files changed, 716 insertions(+), 19 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/check_space.c b/ubifs-utils/fsck.ubifs/check_space.c
index f758bf1a..cf4b8d3f 100644
--- a/ubifs-utils/fsck.ubifs/check_space.c
+++ b/ubifs-utils/fsck.ubifs/check_space.c
@@ -44,18 +44,20 @@ int get_free_leb(struct ubifs_info *c)
  * build_lpt - construct LPT and write it into flash.
  * @c: UBIFS file-system description object
  * @calculate_lp_cb: callback function to calculate the properties for given LEB
+ * @free_ltab: %true means to release c->ltab after creating lpt
  *
  * This function builds LPT according to the calculated results by
  * @calculate_lp_cb and writes LPT into flash. Returns zero in case of success,
  * a negative error code in case of failure.
  */
-int build_lpt(struct ubifs_info *c, calculate_lp_callback calculate_lp_cb)
+int build_lpt(struct ubifs_info *c, calculate_lp_callback calculate_lp_cb,
+	      bool free_ltab)
 {
 	int i, err, lnum, free, dirty;
 	u8 hash_lpt[UBIFS_HASH_ARR_SZ];
 
 	memset(&c->lst, 0, sizeof(struct ubifs_lp_stats));
-	/* Set gc lnum. */
+	/* Set gc lnum, equivalent to ubifs_rcvry_gc_commit/take_gc_lnum. */
 	lnum = get_free_leb(c);
 	if (lnum < 0)
 		return lnum;
@@ -63,7 +65,7 @@ int build_lpt(struct ubifs_info *c, calculate_lp_callback calculate_lp_cb)
 
 	/* Update LPT. */
 	for (i = 0; i < c->main_lebs; i++) {
-		err = calculate_lp_cb(c, i, &free, &dirty);
+		err = calculate_lp_cb(c, i, &free, &dirty, NULL);
 		if (err)
 			return err;
 
@@ -87,8 +89,570 @@ int build_lpt(struct ubifs_info *c, calculate_lp_callback calculate_lp_cb)
 				c->lst.total_dark += ubifs_calc_dark(c, spc);
 			c->lst.total_used += c->leb_size - spc;
 		}
+
+		dbg_fsck("build properties for LEB %d, free %d dirty %d is_idx %d, in %s",
+			 i + c->main_first, free, dirty,
+			 FSCK(c)->lpts[i].flags & LPROPS_INDEX ? 1 : 0,
+			 c->dev_name);
 	}
 
 	/* Write LPT. */
-	return ubifs_create_lpt(c, FSCK(c)->lpts, c->main_lebs, hash_lpt);
+	return ubifs_create_lpt(c, FSCK(c)->lpts, c->main_lebs, hash_lpt, free_ltab);
+}
+
+static int scan_get_lp(struct ubifs_info *c, int index, int *free, int *dirty,
+		       int *is_idx)
+{
+	struct ubifs_scan_leb *sleb;
+	struct ubifs_scan_node *snod;
+	int used, idx_leb, lnum = index + c->main_first, err = 0;
+	bool is_build_lpt = FSCK(c)->lpt_status & FR_LPT_CORRUPTED;
+
+	if (is_build_lpt) {
+		if (!test_bit(index, FSCK(c)->used_lebs) || c->gc_lnum == lnum) {
+			*free = c->leb_size;
+			*dirty = 0;
+			return 0;
+		}
+	} else {
+		if (!test_bit(index, FSCK(c)->used_lebs)) {
+			*free = c->leb_size;
+			*dirty = 0;
+			return 0;
+		}
+	}
+
+	sleb = ubifs_scan(c, lnum, 0, c->sbuf, 0);
+	if (IS_ERR(sleb)) {
+		/* All TNC LEBs have passed ubifs_scan in previous steps. */
+		ubifs_assert(c, !get_failure_reason_callback(c));
+		return PTR_ERR(sleb);
+	}
+
+	idx_leb = -1;
+	used = 0;
+	list_for_each_entry(snod, &sleb->nodes, list) {
+		int found, level = 0;
+
+		if (idx_leb == -1)
+			idx_leb = (snod->type == UBIFS_IDX_NODE) ? 1 : 0;
+
+		if (idx_leb)
+			/*
+			 * Previous steps have ensured that every TNC LEB
+			 * contains only index nodes or non-index nodes.
+			 */
+			ubifs_assert(c, snod->type == UBIFS_IDX_NODE);
+
+		if (snod->type == UBIFS_IDX_NODE) {
+			struct ubifs_idx_node *idx = snod->node;
+
+			key_read(c, ubifs_idx_key(c, idx), &snod->key);
+			level = le16_to_cpu(idx->level);
+		}
+
+		found = ubifs_tnc_has_node(c, &snod->key, level, lnum,
+					   snod->offs, idx_leb);
+		if (found) {
+			if (found < 0) {
+				err = found;
+				/*
+				 * TNC traversing is finished in previous steps,
+				 * any TNC path is accessible.
+				 */
+				ubifs_assert(c, !get_failure_reason_callback(c));
+				goto out;
+			}
+			used += ALIGN(snod->len, 8);
+		}
+	}
+
+	if (is_build_lpt && !used) {
+		*free = c->leb_size;
+		*dirty = 0;
+	} else {
+		*free = c->leb_size - sleb->endpt;
+		*dirty = sleb->endpt - used;
+		if (idx_leb == 1) {
+			if (is_build_lpt)
+				FSCK(c)->lpts[index].flags = LPROPS_INDEX;
+			else
+				*is_idx = 1;
+		}
+	}
+
+out:
+	ubifs_scan_destroy(sleb);
+	return err;
+}
+
+static void clear_buds(struct ubifs_info *c)
+{
+	int i;
+
+	/*
+	 * Since lpt is invalid, space statistics cannot be trusted, the buds
+	 * were used to trace taken LEBs(LPT related), and fsck makes sure that
+	 * there will be no new journal writings(no space allocations) before
+	 * committing, so we should clear buds to prevent wrong lpt updating in
+	 * committing stage(eg. ubifs_return_leb operation for @c->old_buds).
+	 */
+	free_buds(c, true);
+	for (i = 0; i < c->jhead_cnt; i++) {
+		c->jheads[i].wbuf.lnum = -1;
+		c->jheads[i].wbuf.offs = -1;
+	}
+}
+
+static void claer_lp_lists_and_heaps(struct ubifs_info *c)
+{
+	int i;
+
+	/*
+	 * Since lpt is invalid, clear in-memory fast accessing paths (lp
+	 * lists & heaps).
+	 */
+	c->freeable_cnt = 0;
+	c->in_a_category_cnt = 0;
+	for (i = 0; i < LPROPS_HEAP_CNT; i++) {
+		memset(c->lpt_heap[i].arr, 0, LPT_HEAP_SZ * sizeof(void *));
+		c->lpt_heap[i].cnt = 0;
+		c->lpt_heap[i].max_cnt = LPT_HEAP_SZ;
+	}
+	memset(c->dirty_idx.arr, 0, LPT_HEAP_SZ * sizeof(void *));
+	c->dirty_idx.cnt = 0;
+	c->dirty_idx.max_cnt = LPT_HEAP_SZ;
+	INIT_LIST_HEAD(&c->uncat_list);
+	INIT_LIST_HEAD(&c->empty_list);
+	INIT_LIST_HEAD(&c->freeable_list);
+	INIT_LIST_HEAD(&c->frdi_idx_list);
+}
+
+static int retake_ihead(struct ubifs_info *c)
+{
+	int err = take_ihead(c);
+
+	if (err < 0) {
+		/* All LPT nodes must be accessible. */
+		ubifs_assert(c, !get_failure_reason_callback(c));
+		ubifs_assert(c, FSCK(c)->lpt_status == 0);
+	} else
+		err = 0;
+
+	return err;
+}
+
+static int rebuild_lpt(struct ubifs_info *c)
+{
+	int err;
+
+	/* Clear buds. */
+	clear_buds(c);
+	/* Clear stale in-memory lpt data. */
+	c->lpt_drty_flgs = 0;
+	c->dirty_nn_cnt = 0;
+	c->dirty_pn_cnt = 0;
+	claer_lp_lists_and_heaps(c);
+	ubifs_free_lpt_nodes(c);
+	kfree(c->ltab);
+	c->ltab = NULL;
+
+	FSCK(c)->lpts = kzalloc(sizeof(struct ubifs_lprops) * c->main_lebs,
+				GFP_KERNEL);
+	if (!FSCK(c)->lpts) {
+		log_err(c, errno, "can not allocate lpts");
+		return -ENOMEM;
+	}
+
+	err = build_lpt(c, scan_get_lp, false);
+	if (err)
+		goto out;
+
+	err = retake_ihead(c);
+	if (err)
+		goto out;
+
+	FSCK(c)->lpt_status = 0;
+
+out:
+	kfree(FSCK(c)->lpts);
+	return err;
+}
+
+static void check_and_correct_nnode(struct ubifs_info *c,
+				    struct ubifs_nnode *nnode,
+				    struct ubifs_nnode *parent_nnode,
+				    int row, int col, int *corrected)
+{
+	int num = ubifs_calc_nnode_num(row, col);
+
+	if (nnode->num != num) {
+		struct nnode_problem nnp = {
+			.nnode = nnode,
+			.parent_nnode = parent_nnode,
+			.num = num,
+		};
+
+		/*
+		 * The nnode number is read from disk in big lpt mode, which
+		 * could lead to the wrong nnode number, otherwise, ther nnode
+		 * number cannot be wrong.
+		 */
+		ubifs_assert(c, c->big_lpt);
+		FSCK(c)->lpt_status |= FR_LPT_INCORRECT;
+		if (fix_problem(c, NNODE_INCORRECT, &nnp)) {
+			nnode->num = num;
+			*corrected = 1;
+		}
+	}
+}
+
+static int check_and_correct_pnode(struct ubifs_info *c,
+				   struct ubifs_pnode *pnode, int col,
+				   struct ubifs_lp_stats *lst,
+				   int *freeable_cnt, int *corrected)
+{
+	int i, index, lnum;
+	const int lp_cnt = UBIFS_LPT_FANOUT;
+
+	if (pnode->num != col) {
+		struct pnode_problem pnp = {
+			.pnode = pnode,
+			.num = col,
+		};
+
+		/*
+		 * The pnode number is read from disk in big lpt mode, which
+		 * could lead to the wrong pnode number, otherwise, ther pnode
+		 * number cannot be wrong.
+		 */
+		ubifs_assert(c, c->big_lpt);
+		FSCK(c)->lpt_status |= FR_LPT_INCORRECT;
+		if (fix_problem(c, PNODE_INCORRECT, &pnp)) {
+			pnode->num = col;
+			*corrected = 1;
+		}
+	}
+
+	index = pnode->num << UBIFS_LPT_FANOUT_SHIFT;
+	lnum = index + c->main_first;
+	for (i = 0; i < lp_cnt && lnum < c->leb_cnt; i++, index++, lnum++) {
+		int err, cat, free, dirty, is_idx = 0;
+		struct ubifs_lprops *lp = &pnode->lprops[i];
+
+		err = scan_get_lp(c, index, &free, &dirty, &is_idx);
+		if (err)
+			return err;
+
+		dbg_fsck("calculate properties for LEB %d, free %d dirty %d is_idx %d, in %s",
+			 lnum, free, dirty, is_idx, c->dev_name);
+
+		if (!FSCK(c)->lpt_status && lp->free + lp->dirty == c->leb_size
+		    && !test_bit(index, FSCK(c)->used_lebs)) {
+			/*
+			 * Some LEBs may become freeable in the following cases:
+			 *  a. LEBs become freeable after replaying the journal.
+			 *  b. Unclean reboot while doing gc for a freeable
+			 *     non-index LEB
+			 *  c. Freeable index LEBs in an uncompleted commit due
+			 *     to an unclean unmount.
+			 * , which makes that these LEBs won't be accounted into
+			 * the FSCK(c)->used_lebs, but they actually have
+			 * free/dirty space statistics. So we should skip
+			 * checking space for these LEBs.
+			 */
+			free = lp->free;
+			dirty = lp->dirty;
+			is_idx = (lp->flags & LPROPS_INDEX) ? 1 : 0;
+		}
+		if (lnum != lp->lnum ||
+		    free != lp->free || dirty != lp->dirty ||
+		    (is_idx && !(lp->flags & LPROPS_INDEX)) ||
+		    (!is_idx && (lp->flags & LPROPS_INDEX))) {
+			struct lp_problem lpp = {
+				.lnum = lnum,
+				.lp = lp,
+				.free = free,
+				.dirty = dirty,
+				.is_idx = is_idx,
+			};
+
+			FSCK(c)->lpt_status |= FR_LPT_INCORRECT;
+			if (fix_problem(c, LP_INCORRECT, &lpp)) {
+				lp->lnum = lnum;
+				lp->free = free;
+				lp->dirty = dirty;
+				lp->flags = is_idx ? LPROPS_INDEX : 0;
+				*corrected = 1;
+			}
+		}
+
+		cat = ubifs_categorize_lprops(c, lp);
+		if (cat != (lp->flags & LPROPS_CAT_MASK)) {
+			if (FSCK(c)->lpt_status & FR_LPT_INCORRECT) {
+				lp->flags |= cat;
+			} else {
+				/* lp could be in the heap or un-categorized(add heap failed). */
+				ubifs_assert(c, (lp->flags & LPROPS_CAT_MASK) == LPROPS_UNCAT);
+			}
+		}
+		if (cat == LPROPS_FREEABLE)
+			*freeable_cnt = *freeable_cnt + 1;
+		if ((lp->flags & LPROPS_TAKEN) && free == c->leb_size)
+			lst->taken_empty_lebs += 1;
+
+		lst->total_free += free;
+		lst->total_dirty += dirty;
+
+		if (free == c->leb_size)
+			lst->empty_lebs++;
+
+		if (is_idx) {
+			lst->idx_lebs += 1;
+		} else {
+			int spc;
+
+			spc = free + dirty;
+			if (spc < c->dead_wm)
+				lst->total_dead += spc;
+			else
+				lst->total_dark += ubifs_calc_dark(c, spc);
+			lst->total_used += c->leb_size - spc;
+		}
+	}
+
+	return 0;
+}
+
+static int check_and_correct_lpt(struct ubifs_info *c, int *lpt_corrected)
+{
+	int err, i, cnt, iip, row, col, corrected, lnum, max_num, freeable_cnt;
+	struct ubifs_cnode *cn, *cnode;
+	struct ubifs_nnode *nnode, *nn;
+	struct ubifs_pnode *pnode;
+	struct ubifs_lp_stats lst;
+
+	max_num = 0;
+	freeable_cnt = 0;
+	memset(&lst, 0, sizeof(struct ubifs_lp_stats));
+
+	/* Load the entire LPT tree, check whether there are corrupted nodes. */
+	cnt = DIV_ROUND_UP(c->main_lebs, UBIFS_LPT_FANOUT);
+	for (i = 0; i < cnt; i++) {
+		pnode = ubifs_pnode_lookup(c, i);
+		if (IS_ERR(pnode))
+			return PTR_ERR(pnode);
+		if (pnode->num > max_num)
+			max_num = pnode->num;
+	}
+
+	/* Check whether there are pnodes exceeding the 'c->main_lebs'. */
+	pnode = ubifs_pnode_lookup(c, 0);
+	if (IS_ERR(pnode))
+		return PTR_ERR(pnode);
+	while (pnode) {
+		if (pnode->num > max_num) {
+			ubifs_err(c, "pnode(%d) exceeds max number(%d)",
+				  pnode->num, max_num);
+			set_failure_reason_callback(c, FR_LPT_CORRUPTED);
+			return -EINVAL;
+		}
+		pnode = ubifs_find_next_pnode(c, pnode);
+		if (IS_ERR(pnode))
+			return PTR_ERR(pnode);
+	}
+
+	/* Check & correct nnodes and pnodes(including LEB properties). */
+	row = col = iip = 0;
+	cnode = (struct ubifs_cnode *)c->nroot;
+	while (cnode) {
+		ubifs_assert(c, row >= 0);
+		nnode = cnode->parent;
+		if (cnode->level) {
+			corrected = 0;
+			/* cnode is a nnode */
+			nn = (struct ubifs_nnode *)cnode;
+			check_and_correct_nnode(c, nn, nnode, row, col,
+						&corrected);
+			if (corrected)
+				ubifs_make_nnode_dirty(c, nn);
+			while (iip < UBIFS_LPT_FANOUT) {
+				cn = nn->nbranch[iip].cnode;
+				if (cn) {
+					/* Go down */
+					row += 1;
+					col <<= UBIFS_LPT_FANOUT_SHIFT;
+					col += iip;
+					iip = 0;
+					cnode = cn;
+					break;
+				}
+				/* Go right */
+				iip += 1;
+			}
+			if (iip < UBIFS_LPT_FANOUT)
+				continue;
+		} else {
+			corrected = 0;
+			/* cnode is a pnode */
+			pnode = (struct ubifs_pnode *)cnode;
+			err = check_and_correct_pnode(c, pnode, col, &lst,
+						      &freeable_cnt, &corrected);
+			if (err)
+				return err;
+			if (corrected)
+				ubifs_make_pnode_dirty(c, pnode);
+		}
+		/* Go up and to the right */
+		row -= 1;
+		col >>= UBIFS_LPT_FANOUT_SHIFT;
+		iip = cnode->iip + 1;
+		cnode = (struct ubifs_cnode *)nnode;
+	}
+
+	dbg_fsck("empty_lebs %d, idx_lebs %d, total_free %lld, total_dirty %lld,"
+		 " total_used %lld, total_dead %lld, total_dark %lld,"
+		 " taken_empty_lebs %d, freeable_cnt %d, in %s",
+		 lst.empty_lebs, lst.idx_lebs, lst.total_free, lst.total_dirty,
+		 lst.total_used, lst.total_dead, lst.total_dark,
+		 lst.taken_empty_lebs, freeable_cnt, c->dev_name);
+
+	/* Check & correct the global space statistics. */
+	if (lst.empty_lebs != c->lst.empty_lebs ||
+	    lst.idx_lebs != c->lst.idx_lebs ||
+	    lst.total_free != c->lst.total_free ||
+	    lst.total_dirty != c->lst.total_dirty ||
+	    lst.total_used != c->lst.total_used ||
+	    lst.total_dead != c->lst.total_dead ||
+	    lst.total_dark != c->lst.total_dark) {
+		struct space_stat_problem ssp = {
+			.lst = &c->lst,
+			.calc_lst = &lst,
+		};
+
+		FSCK(c)->lpt_status |= FR_LPT_INCORRECT;
+		if (fix_problem(c, SPACE_STAT_INCORRECT, &ssp)) {
+			c->lst.empty_lebs = lst.empty_lebs;
+			c->lst.idx_lebs = lst.idx_lebs;
+			c->lst.total_free = lst.total_free;
+			c->lst.total_dirty = lst.total_dirty;
+			c->lst.total_used = lst.total_used;
+			c->lst.total_dead = lst.total_dead;
+			c->lst.total_dark = lst.total_dark;
+		}
+	}
+
+	/* Check & correct the lprops table information. */
+	for (lnum = c->lpt_first; lnum <= c->lpt_last; lnum++) {
+		err = dbg_check_ltab_lnum(c, lnum);
+		if (err)
+			return err;
+	}
+
+	if (FSCK(c)->lpt_status & FR_LPT_INCORRECT) {
+		c->lst.taken_empty_lebs = 0;
+		/* Clear buds. */
+		clear_buds(c);
+		/* Clear lp lists & heaps. */
+		claer_lp_lists_and_heaps(c);
+		/*
+		 * Build lp lists & heaps, subsequent steps could recover
+		 * disconnected files by allocating free space.
+		 */
+		for (lnum = c->main_first; lnum < c->leb_cnt; lnum++) {
+			int cat;
+			struct ubifs_lprops *lp = ubifs_lpt_lookup(c, lnum);
+			if (IS_ERR(lp))
+				return PTR_ERR(lp);
+
+			cat = lp->flags & LPROPS_CAT_MASK;
+			ubifs_add_to_cat(c, lp, cat);
+		}
+		/*
+		 * The %LPROPS_TAKEN flag is cleared in LEB properties, just
+		 * remark it.
+		 */
+		err = retake_ihead(c);
+		if (err)
+			return err;
+
+		*lpt_corrected = 1;
+		FSCK(c)->lpt_status &= ~FR_LPT_INCORRECT;
+	} else {
+		ubifs_assert(c, c->freeable_cnt == freeable_cnt);
+		ubifs_assert(c, c->lst.taken_empty_lebs == lst.taken_empty_lebs);
+		ubifs_assert(c, c->in_a_category_cnt == c->main_lebs);
+	}
+
+	return 0;
+}
+
+/**
+ * check_and_correct_space - check & correct the space statistics.
+ * @c: UBIFS file-system description object
+ *
+ * This function does following things:
+ * 1. Check fsck mode, exit program if current mode is check mode.
+ * 2. Check space statistics by comparing lpt records with scanning results
+ *    for all main LEBs. There could be following problems:
+ *    a) comparison result is inconsistent: correct the lpt records by LEB
+ *       scanning results.
+ *    b) lpt is corrupted: rebuild lpt.
+ * 3. Set the gc lnum.
+ * Returns zero in case of success, a negative error code in case of failure.
+ */
+int check_and_correct_space(struct ubifs_info *c)
+{
+	int err, lpt_corrected = 0;
+
+	if (FSCK(c)->mode == CHECK_MODE) {
+		/*
+		 * The check mode will exit, because unclean LEBs are not
+		 * rewritten for readonly mode in previous steps.
+		 */
+		if (FSCK(c)->lpt_status)
+			exit_code |= FSCK_UNCORRECTED;
+		dbg_fsck("skip checking & correcting space%s, in %s",
+			 mode_name(c), c->dev_name);
+		exit(exit_code);
+	}
+
+	log_out(c, "Check and correct the space statistics");
+
+	if (FSCK(c)->lpt_status & FR_LPT_CORRUPTED) {
+rebuild:
+		if (fix_problem(c, LPT_CORRUPTED, NULL))
+			return rebuild_lpt(c);
+	}
+
+	err = check_and_correct_lpt(c, &lpt_corrected);
+	if (err) {
+		if (test_and_clear_failure_reason_callback(c, FR_LPT_CORRUPTED))
+			goto rebuild;
+		return err;
+	}
+
+	/* Set gc lnum. */
+	if (c->need_recovery || lpt_corrected) {
+		err = ubifs_rcvry_gc_commit(c);
+		if (err) {
+			/* All LPT nodes must be accessible. */
+			ubifs_assert(c, !get_failure_reason_callback(c));
+			ubifs_assert(c, FSCK(c)->lpt_status == 0);
+			return err;
+		}
+	} else {
+		err = take_gc_lnum(c);
+		if (err) {
+			/* All LPT nodes must be accessible. */
+			ubifs_assert(c, !get_failure_reason_callback(c));
+			ubifs_assert(c, FSCK(c)->lpt_status == 0);
+			return err;
+		}
+		err = ubifs_leb_unmap(c, c->gc_lnum);
+		if (err)
+			return err;
+	}
+
+	return err;
 }
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 14f77fc2..436831cb 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -58,6 +58,7 @@ static const char *helptext =
 "-b, --rebuild            Forcedly repair the filesystem even by rebuilding filesystem.\n"
 "                         Depends on -y option\n"
 "-n, --nochange           Make no changes to the filesystem, only check filesystem.\n"
+"                         This mode don't check space, because unclean LEBs are not rewritten in readonly mode.\n"
 "                         Can not be specified at the same time as the -a or -y options\n"
 "Examples:\n"
 "\t1. Check and repair filesystem from UBI volume /dev/ubi0_0\n"
@@ -329,6 +330,7 @@ static const unsigned int reason_mapping_table[] = {
 	BUD_CORRUPTED,		/* FR_H_BUD_CORRUPTED */
 	TNC_DATA_CORRUPTED,	/* FR_H_TNC_DATA_CORRUPTED */
 	ORPHAN_CORRUPTED,	/* FR_H_ORPHAN_CORRUPTED */
+	LTAB_INCORRECT,		/* FR_H_LTAB_INCORRECT */
 };
 
 static bool fsck_handle_failure(const struct ubifs_info *c, unsigned int reason,
@@ -471,8 +473,18 @@ static int do_fsck(void)
 	if (tnc_is_empty(c) && fix_problem(c, EMPTY_TNC, NULL)) {
 		err = -EINVAL;
 		FSCK(c)->try_rebuild = true;
+		goto free_disconnected_files;
 	}
 
+	err = check_and_correct_space(c);
+	kfree(FSCK(c)->used_lebs);
+	destroy_file_tree(c, &FSCK(c)->scanned_files);
+	if (err)
+		exit_code |= FSCK_ERROR;
+
+	destroy_file_list(c, &FSCK(c)->disconnected_files);
+	return err;
+
 free_disconnected_files:
 	destroy_file_list(c, &FSCK(c)->disconnected_files);
 free_used_lebs:
@@ -519,6 +531,7 @@ int main(int argc, char *argv[])
 	 * Step 9: Check and handle unreachable files
 	 * Step 10: Check and correct files
 	 * Step 11: Check whether the TNC is empty
+	 * Step 12: Check and correct the space statistics
 	 */
 	err = do_fsck();
 	if (err && FSCK(c)->try_rebuild) {
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 011835ff..cc8b71f5 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -44,12 +44,14 @@ enum { SB_CORRUPTED = 0, MST_CORRUPTED, LOG_CORRUPTED, BUD_CORRUPTED,
        FILE_SHOULDNT_HAVE_DATA, FILE_HAS_NO_DENT, XATTR_HAS_NO_HOST,
        XATTR_HAS_WRONG_HOST, FILE_HAS_NO_ENCRYPT, FILE_IS_DISCONNECTED,
        FILE_ROOT_HAS_DENT, DENTRY_IS_UNREACHABLE, FILE_IS_INCONSISTENT,
-       EMPTY_TNC };
+       EMPTY_TNC, LPT_CORRUPTED, NNODE_INCORRECT, PNODE_INCORRECT,
+       LP_INCORRECT, SPACE_STAT_INCORRECT, LTAB_INCORRECT };
 
 enum { HAS_DATA_CORRUPTED = 1, HAS_TNC_CORRUPTED = 2 };
 
 typedef int (*calculate_lp_callback)(struct ubifs_info *c,
-				     int index, int *free, int *dirty);
+				     int index, int *free, int *dirty,
+				     int *is_idx);
 
 struct scanned_file;
 
@@ -201,6 +203,54 @@ struct invalid_file_problem {
 };
 
 /**
+ * nnode_problem - problem instance for incorrect nnode
+ * @nnode: incorrect nnode
+ * @parent_nnode: the parent nnode of @nnode, could be NULL if @nnode is root
+ * @num: calculated num
+ */
+struct nnode_problem {
+	struct ubifs_nnode *nnode;
+	struct ubifs_nnode *parent_nnode;
+	int num;
+};
+
+/**
+ * pnode_problem - problem instance for incorrect pnode
+ * @pnode: incorrect pnode
+ * @num: calculated num
+ */
+struct pnode_problem {
+	struct ubifs_pnode *pnode;
+	int num;
+};
+
+/**
+ * lp_problem - problem instance for incorrect LEB proerties
+ * @lp: incorrect LEB properties
+ * @lnum: LEB number
+ * @free: calculated free space in LEB
+ * @dirty: calculated dirty bytes in LEB
+ * @is_idx: %true means that the LEB is an index LEB
+ */
+struct lp_problem {
+	struct ubifs_lprops *lp;
+	int lnum;
+	int free;
+	int dirty;
+	int is_idx;
+};
+
+/**
+ * space_stat_problem - problem instance for incorrect space statistics
+ * @lst: current space statistics
+ * @calc_lst: calculated space statistics
+ */
+struct space_stat_problem {
+	struct ubifs_lp_stats *lst;
+	struct ubifs_lp_stats *calc_lst;
+};
+
+/**
  * ubifs_rebuild_info - UBIFS rebuilding information.
  * @write_buf: write buffer for LEB @head_lnum
  * @head_lnum: current writing LEB number
@@ -327,6 +377,8 @@ bool tnc_is_empty(struct ubifs_info *c);
 
 /* check_space.c */
 int get_free_leb(struct ubifs_info *c);
-int build_lpt(struct ubifs_info *c, calculate_lp_callback calculate_lp_cb);
+int build_lpt(struct ubifs_info *c, calculate_lp_callback calculate_lp_cb,
+	      bool free_ltab);
+int check_and_correct_space(struct ubifs_info *c);
 
 #endif
diff --git a/ubifs-utils/fsck.ubifs/problem.c b/ubifs-utils/fsck.ubifs/problem.c
index 795f05fa..f987e480 100644
--- a/ubifs-utils/fsck.ubifs/problem.c
+++ b/ubifs-utils/fsck.ubifs/problem.c
@@ -61,6 +61,12 @@ static const struct fsck_problem problem_table[] = {
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Dentry is unreachable"},	// DENTRY_IS_UNREACHABLE
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "File is inconsistent"},	// FILE_IS_INCONSISTENT
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA | PROBLEM_NEED_REBUILD, "TNC is empty"},	// EMPTY_TNC
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Corrupted pnode/nnode"},	// LPT_CORRUPTED
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Inconsistent properties for nnode"},	// NNODE_INCORRECT
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Inconsistent properties for pnode"},	// PNODE_INCORRECT
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Inconsistent properties for LEB"},	// LP_INCORRECT
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Incorrect space statistics"},	// SPACE_STAT_INCORRECT
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Inconsistent properties for lprops table"},	// LTAB_INCORRECT
 };
 
 static const char *get_question(const struct fsck_problem *problem,
@@ -96,6 +102,8 @@ static const char *get_question(const struct fsck_problem *problem,
 		return "Remove data block?";
 	case FILE_IS_DISCONNECTED:
 		return "Put it into disconnected list?";
+	case LPT_CORRUPTED:
+		return "Rebuild LPT?";
 	}
 
 	return "Fix it?";
@@ -229,6 +237,49 @@ static void print_problem(const struct ubifs_info *c,
 			file->calc_xnms, file->calc_size);
 		break;
 	}
+	case NNODE_INCORRECT:
+	{
+		const struct nnode_problem *nnp = (const struct nnode_problem *)priv;
+
+		log_out(c, "problem: %s, nnode num %d expected %d parent num %d iip %d",
+			problem->desc, nnp->nnode->num, nnp->num,
+			nnp->parent_nnode ? nnp->parent_nnode->num : 0,
+			nnp->nnode->iip);
+		break;
+	}
+	case PNODE_INCORRECT:
+	{
+		const struct pnode_problem *pnp = (const struct pnode_problem *)priv;
+
+		log_out(c, "problem: %s, pnode num %d expected %d parent num %d iip %d",
+			problem->desc, pnp->pnode->num, pnp->num,
+			pnp->pnode->parent->num, pnp->pnode->iip);
+		break;
+	}
+	case LP_INCORRECT:
+	{
+		const struct lp_problem *lpp = (const struct lp_problem *)priv;
+
+		log_out(c, "problem: %s %d, free %d dirty %d is_idx %d, should be lnum %d free %d dirty %d is_idx %d",
+			problem->desc, lpp->lp->lnum, lpp->lp->free,
+			lpp->lp->dirty, lpp->lp->flags & LPROPS_INDEX ? 1 : 0,
+			lpp->lnum, lpp->free, lpp->dirty, lpp->is_idx);
+		break;
+	}
+	case SPACE_STAT_INCORRECT:
+	{
+		const struct space_stat_problem *ssp = (const struct space_stat_problem *)priv;
+
+		log_out(c, "problem: %s, empty_lebs %d idx_lebs %d total_free %lld total_dirty %lld total_used %lld total_dead %lld total_dark %lld, should be empty_lebs %d idx_lebs %d total_free %lld total_dirty %lld total_used %lld total_dead %lld total_dark %lld",
+			problem->desc, ssp->lst->empty_lebs, ssp->lst->idx_lebs,
+			ssp->lst->total_free, ssp->lst->total_dirty,
+			ssp->lst->total_used, ssp->lst->total_dead,
+			ssp->lst->total_dark, ssp->calc_lst->empty_lebs,
+			ssp->calc_lst->idx_lebs, ssp->calc_lst->total_free,
+			ssp->calc_lst->total_dirty, ssp->calc_lst->total_used,
+			ssp->calc_lst->total_dead, ssp->calc_lst->total_dark);
+		break;
+	}
 	default:
 		log_out(c, "problem: %s", problem->desc);
 		break;
diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index 1161f5af..e65d655d 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -1224,7 +1224,8 @@ out_idx_list:
 	return err;
 }
 
-static int calculate_lp(struct ubifs_info *c, int index, int *free, int *dirty)
+static int calculate_lp(struct ubifs_info *c, int index, int *free, int *dirty,
+			__unused int *is_idx)
 {
 	if (!test_bit(index, FSCK(c)->used_lebs) ||
 	    c->gc_lnum == index + c->main_first) {
@@ -1421,7 +1422,7 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c)
 
 	/* Step 10. Build LPT. */
 	log_out(c, "Build LPT");
-	err = build_lpt(c, calculate_lp);
+	err = build_lpt(c, calculate_lp, true);
 	if (err) {
 		exit_code |= FSCK_ERROR;
 		goto out;
diff --git a/ubifs-utils/libubifs/lpt.c b/ubifs-utils/libubifs/lpt.c
index fc70cad5..8e20a173 100644
--- a/ubifs-utils/libubifs/lpt.c
+++ b/ubifs-utils/libubifs/lpt.c
@@ -605,6 +605,7 @@ static int calc_pnode_num_from_parent(const struct ubifs_info *c,
  * @lps: array of logical eraseblock properties
  * @lp_cnt: the length of @lps
  * @hash: hash of the LPT is returned here
+ * @free_ltab: %true means to release c->ltab after creating lpt
  *
  * This function creates lpt, the pnode will be initialized based on
  * corresponding elements in @lps. If there are no corresponding lprops
@@ -612,7 +613,7 @@ static int calc_pnode_num_from_parent(const struct ubifs_info *c,
  * as free state.
  */
 int ubifs_create_lpt(struct ubifs_info *c, struct ubifs_lprops *lps, int lp_cnt,
-		     u8 *hash)
+		     u8 *hash, bool free_ltab)
 {
 	int lnum, err = 0, i, j, cnt, len, alen, row;
 	int blnum, boffs, bsz, bcnt;
@@ -910,10 +911,12 @@ int ubifs_create_lpt(struct ubifs_info *c, struct ubifs_lprops *lps, int lp_cnt,
 	if (c->big_lpt)
 		dbg_lp("LPT lsave is at %d:%d", c->lsave_lnum, c->lsave_offs);
 out:
-	c->ltab = NULL;
+	if (free_ltab || err) {
+		c->ltab = NULL;
+		vfree(ltab);
+	}
 	kfree(desc);
 	kfree(lsave);
-	vfree(ltab);
 	vfree(buf);
 	kfree(nnode);
 	kfree(pnode);
diff --git a/ubifs-utils/libubifs/lpt_commit.c b/ubifs-utils/libubifs/lpt_commit.c
index 8a44546d..ee84f801 100644
--- a/ubifs-utils/libubifs/lpt_commit.c
+++ b/ubifs-utils/libubifs/lpt_commit.c
@@ -1599,7 +1599,7 @@ static int dbg_is_node_dirty(struct ubifs_info *c, int node_type, int lnum,
  *
  * This function returns %0 on success and a negative error code on failure.
  */
-static int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
+int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
 {
 	int err, len = c->leb_size, dirty = 0, node_type, node_num, node_len;
 	int ret;
@@ -1608,7 +1608,7 @@ static int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
 	buf = p = __vmalloc(c->leb_size, GFP_NOFS);
 	if (!buf) {
 		ubifs_err(c, "cannot allocate memory for ltab checking");
-		return 0;
+		return -ENOMEM;
 	}
 
 	dbg_lp("LEB %d", lnum);
@@ -1632,20 +1632,30 @@ static int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
 				continue;
 			}
 			if (!dbg_is_all_ff(p, len)) {
+				set_failure_reason_callback(c, FR_LPT_CORRUPTED);
 				ubifs_err(c, "invalid empty space in LEB %d at %d",
 					  lnum, c->leb_size - len);
 				err = -EINVAL;
+				goto out;
 			}
 			i = lnum - c->lpt_first;
 			if (len != c->ltab[i].free) {
 				ubifs_err(c, "invalid free space in LEB %d (free %d, expected %d)",
-					  lnum, len, c->ltab[i].free);
+					  lnum, c->ltab[i].free, len);
 				err = -EINVAL;
+				if (handle_failure_callback(c, FR_H_LTAB_INCORRECT, NULL)) {
+					c->ltab[i].free = len;
+					err = 0;
+				}
 			}
 			if (dirty != c->ltab[i].dirty) {
 				ubifs_err(c, "invalid dirty space in LEB %d (dirty %d, expected %d)",
-					  lnum, dirty, c->ltab[i].dirty);
+					  lnum, c->ltab[i].dirty, dirty);
 				err = -EINVAL;
+				if (handle_failure_callback(c, FR_H_LTAB_INCORRECT, NULL)) {
+					c->ltab[i].dirty = dirty;
+					err = 0;
+				}
 			}
 			goto out;
 		}
diff --git a/ubifs-utils/libubifs/replay.c b/ubifs-utils/libubifs/replay.c
index 0895f069..7991d974 100644
--- a/ubifs-utils/libubifs/replay.c
+++ b/ubifs-utils/libubifs/replay.c
@@ -1099,7 +1099,7 @@ out_dump:
  * This function returns the amount of free space in the index head LEB or a
  * negative error code.
  */
-static int take_ihead(struct ubifs_info *c)
+int take_ihead(struct ubifs_info *c)
 {
 	const struct ubifs_lprops *lp;
 	int err, free;
diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index 45c4105c..a4b05a66 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -1563,6 +1563,7 @@ enum {
 	FR_H_BUD_CORRUPTED = 0,		/* Bud LEB is corrupted */
 	FR_H_TNC_DATA_CORRUPTED,	/* Data searched from TNC is corrupted */
 	FR_H_ORPHAN_CORRUPTED,		/* Orphan LEB is corrupted */
+	FR_H_LTAB_INCORRECT,		/* Lprops table is incorrect */
 };
 /* Callback functions for failure(which can be handled by fsck) happens. */
 static inline void set_failure_reason_callback(const struct ubifs_info *c,
@@ -1734,6 +1735,7 @@ int ubifs_fixup_free_space(struct ubifs_info *c);
 /* replay.c */
 int ubifs_validate_entry(struct ubifs_info *c,
 			 const struct ubifs_dent_node *dent);
+int take_ihead(struct ubifs_info *c);
 int ubifs_replay_journal(struct ubifs_info *c);
 
 /* gc.c */
@@ -1754,7 +1756,7 @@ int ubifs_clear_orphans(struct ubifs_info *c);
 int ubifs_calc_dflt_lpt_geom(struct ubifs_info *c, int *main_lebs, int *big_lpt);
 int ubifs_calc_lpt_geom(struct ubifs_info *c);
 int ubifs_create_lpt(struct ubifs_info *c, struct ubifs_lprops *lps, int lp_cnt,
-		     u8 *hash);
+		     u8 *hash, bool free_ltab);
 int ubifs_lpt_init(struct ubifs_info *c, int rd, int wr);
 struct ubifs_lprops *ubifs_lpt_lookup(struct ubifs_info *c, int lnum);
 struct ubifs_lprops *ubifs_lpt_lookup_dirty(struct ubifs_info *c, int lnum);
@@ -1795,6 +1797,7 @@ int ubifs_lpt_end_commit(struct ubifs_info *c);
 int ubifs_lpt_post_commit(struct ubifs_info *c);
 void ubifs_free_lpt_nodes(struct ubifs_info *c);
 void ubifs_lpt_free(struct ubifs_info *c, int wr_only);
+int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum);
 
 /* lprops.c */
 const struct ubifs_lprops *ubifs_change_lp(struct ubifs_info *c,
diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index 2817b6ce..b5f38929 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -2675,7 +2675,7 @@ static int write_lpt(void)
 	int err, lnum;
 
 	c->lscan_lnum = c->main_first;
-	err = ubifs_create_lpt(c, c->lpt, c->main_lebs, c->lpt_hash);
+	err = ubifs_create_lpt(c, c->lpt, c->main_lebs, c->lpt_hash, true);
 	if (err)
 		return err;
 
-- 
2.13.6


