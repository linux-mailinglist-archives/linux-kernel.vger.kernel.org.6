Return-Path: <linux-kernel+bounces-205325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA598FFA9D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34E41F261E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85164158D6C;
	Fri,  7 Jun 2024 04:27:22 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E37155724
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734438; cv=none; b=cLbtKf+mWOhEVXs9lj7+yqmDR28OF9GtYIh79ZZTnbzgAy2Pn5WgSwdHxrazek++hnk1c9HtMjn9BdawD/+CB2hlJM3UeYFspwBM9x2JCECxSTXQNSZSoZIZsQPiNzYhJUVXC3XKEr0kYx1TQt7kfmUuGPsVlD6W2ZrM+EeQW9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734438; c=relaxed/simple;
	bh=wchf+pKMvt+Zd5XD41E3OE2Eni5M59ToTbX87wXTIO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzMdwkz5Y4WxoUWIc6rnu/cJUwK3+/w+HM4Xtt94ZXGanr8zEkkzAd65RsyHsNkWnXAEdqUn7yylytbMFwx2+oGszM24S6agWPnrm1KSJU5CfrqG6rHruvsANl9yYOAwAI4abCXm0m/6qbektVDsuHuCxxlg4bOU7F9zgPKy3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSjr37tyz1S9y9;
	Fri,  7 Jun 2024 12:23:12 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CB4818007E;
	Fri,  7 Jun 2024 12:27:11 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:57 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 041/110] ubifs-utils: Adapt sb.c in libubifs
Date: Fri, 7 Jun 2024 12:25:06 +0800
Message-ID: <20240607042615.2069840-42-chengzhihao1@huawei.com>
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

Adapt sb.c in libubifs, compared with linux kernel implementations:
 1. Remove authentication related implementations
    (eg. authenticate_sb_node), authentication is not supported in fsck
    for now.
 2. Remove some functions(eg. create_default_filesystem) which won't be
    used in fsck/mkfs.
 3. Modify ubifs_read_superblock(), remove some assignments which won't
    be used in mkfs/fsck.
 4. Apapt fixup_leb to ignore %-EBADMSG, subsequent steps will check
    all areas carefully.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/sb.c | 482 ++--------------------------------------------
 1 file changed, 18 insertions(+), 464 deletions(-)

diff --git a/ubifs-utils/libubifs/sb.c b/ubifs-utils/libubifs/sb.c
index e7693b94..312661d6 100644
--- a/ubifs-utils/libubifs/sb.c
+++ b/ubifs-utils/libubifs/sb.c
@@ -14,358 +14,18 @@
  * change it. The superblock node mostly contains geometry information.
  */
 
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
 #include "ubifs.h"
-#include <linux/slab.h>
-#include <linux/math64.h>
-#include <linux/uuid.h>
-
-/*
- * Default journal size in logical eraseblocks as a percent of total
- * flash size.
- */
-#define DEFAULT_JNL_PERCENT 5
-
-/* Default maximum journal size in bytes */
-#define DEFAULT_MAX_JNL (32*1024*1024)
-
-/* Default indexing tree fanout */
-#define DEFAULT_FANOUT 8
-
-/* Default number of data journal heads */
-#define DEFAULT_JHEADS_CNT 1
-
-/* Default positions of different LEBs in the main area */
-#define DEFAULT_IDX_LEB  0
-#define DEFAULT_DATA_LEB 1
-#define DEFAULT_GC_LEB   2
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
+#include "misc.h"
 
 /* Default number of LEB numbers in LPT's save table */
 #define DEFAULT_LSAVE_CNT 256
 
-/* Default reserved pool size as a percent of maximum free space */
-#define DEFAULT_RP_PERCENT 5
-
-/* The default maximum size of reserved pool in bytes */
-#define DEFAULT_MAX_RP_SIZE (5*1024*1024)
-
-/* Default time granularity in nanoseconds */
-#define DEFAULT_TIME_GRAN 1000000000
-
-static int get_default_compressor(struct ubifs_info *c)
-{
-	if (ubifs_compr_present(c, UBIFS_COMPR_ZSTD))
-		return UBIFS_COMPR_ZSTD;
-
-	if (ubifs_compr_present(c, UBIFS_COMPR_LZO))
-		return UBIFS_COMPR_LZO;
-
-	if (ubifs_compr_present(c, UBIFS_COMPR_ZLIB))
-		return UBIFS_COMPR_ZLIB;
-
-	return UBIFS_COMPR_NONE;
-}
-
-/**
- * create_default_filesystem - format empty UBI volume.
- * @c: UBIFS file-system description object
- *
- * This function creates default empty file-system. Returns zero in case of
- * success and a negative error code in case of failure.
- */
-static int create_default_filesystem(struct ubifs_info *c)
-{
-	struct ubifs_sb_node *sup;
-	struct ubifs_mst_node *mst;
-	struct ubifs_idx_node *idx;
-	struct ubifs_branch *br;
-	struct ubifs_ino_node *ino;
-	struct ubifs_cs_node *cs;
-	union ubifs_key key;
-	int err, tmp, jnl_lebs, log_lebs, max_buds, main_lebs, main_first;
-	int lpt_lebs, lpt_first, orph_lebs, big_lpt, ino_waste, sup_flags = 0;
-	int min_leb_cnt = UBIFS_MIN_LEB_CNT;
-	int idx_node_size;
-	long long tmp64, main_bytes;
-	__le64 tmp_le64;
-	struct timespec64 ts;
-	u8 hash[UBIFS_HASH_ARR_SZ];
-	u8 hash_lpt[UBIFS_HASH_ARR_SZ];
-
-	/* Some functions called from here depend on the @c->key_len filed */
-	c->key_len = UBIFS_SK_LEN;
-
-	/*
-	 * First of all, we have to calculate default file-system geometry -
-	 * log size, journal size, etc.
-	 */
-	if (c->leb_cnt < 0x7FFFFFFF / DEFAULT_JNL_PERCENT)
-		/* We can first multiply then divide and have no overflow */
-		jnl_lebs = c->leb_cnt * DEFAULT_JNL_PERCENT / 100;
-	else
-		jnl_lebs = (c->leb_cnt / 100) * DEFAULT_JNL_PERCENT;
-
-	if (jnl_lebs < UBIFS_MIN_JNL_LEBS)
-		jnl_lebs = UBIFS_MIN_JNL_LEBS;
-	if (jnl_lebs * c->leb_size > DEFAULT_MAX_JNL)
-		jnl_lebs = DEFAULT_MAX_JNL / c->leb_size;
-
-	/*
-	 * The log should be large enough to fit reference nodes for all bud
-	 * LEBs. Because buds do not have to start from the beginning of LEBs
-	 * (half of the LEB may contain committed data), the log should
-	 * generally be larger, make it twice as large.
-	 */
-	tmp = 2 * (c->ref_node_alsz * jnl_lebs) + c->leb_size - 1;
-	log_lebs = tmp / c->leb_size;
-	/* Plus one LEB reserved for commit */
-	log_lebs += 1;
-	if (c->leb_cnt - min_leb_cnt > 8) {
-		/* And some extra space to allow writes while committing */
-		log_lebs += 1;
-		min_leb_cnt += 1;
-	}
-
-	max_buds = jnl_lebs - log_lebs;
-	if (max_buds < UBIFS_MIN_BUD_LEBS)
-		max_buds = UBIFS_MIN_BUD_LEBS;
-
-	/*
-	 * Orphan nodes are stored in a separate area. One node can store a lot
-	 * of orphan inode numbers, but when new orphan comes we just add a new
-	 * orphan node. At some point the nodes are consolidated into one
-	 * orphan node.
-	 */
-	orph_lebs = UBIFS_MIN_ORPH_LEBS;
-	if (c->leb_cnt - min_leb_cnt > 1)
-		/*
-		 * For debugging purposes it is better to have at least 2
-		 * orphan LEBs, because the orphan subsystem would need to do
-		 * consolidations and would be stressed more.
-		 */
-		orph_lebs += 1;
-
-	main_lebs = c->leb_cnt - UBIFS_SB_LEBS - UBIFS_MST_LEBS - log_lebs;
-	main_lebs -= orph_lebs;
-
-	lpt_first = UBIFS_LOG_LNUM + log_lebs;
-	c->lsave_cnt = DEFAULT_LSAVE_CNT;
-	c->max_leb_cnt = c->leb_cnt;
-	err = ubifs_create_dflt_lpt(c, &main_lebs, lpt_first, &lpt_lebs,
-				    &big_lpt, hash_lpt);
-	if (err)
-		return err;
-
-	dbg_gen("LEB Properties Tree created (LEBs %d-%d)", lpt_first,
-		lpt_first + lpt_lebs - 1);
-
-	main_first = c->leb_cnt - main_lebs;
-
-	sup = kzalloc(ALIGN(UBIFS_SB_NODE_SZ, c->min_io_size), GFP_KERNEL);
-	mst = kzalloc(c->mst_node_alsz, GFP_KERNEL);
-	idx_node_size = ubifs_idx_node_sz(c, 1);
-	idx = kzalloc(ALIGN(idx_node_size, c->min_io_size), GFP_KERNEL);
-	ino = kzalloc(ALIGN(UBIFS_INO_NODE_SZ, c->min_io_size), GFP_KERNEL);
-	cs = kzalloc(ALIGN(UBIFS_CS_NODE_SZ, c->min_io_size), GFP_KERNEL);
-
-	if (!sup || !mst || !idx || !ino || !cs) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	/* Create default superblock */
-
-	tmp64 = (long long)max_buds * c->leb_size;
-	if (big_lpt)
-		sup_flags |= UBIFS_FLG_BIGLPT;
-	if (ubifs_default_version > 4)
-		sup_flags |= UBIFS_FLG_DOUBLE_HASH;
-
-	if (ubifs_authenticated(c)) {
-		sup_flags |= UBIFS_FLG_AUTHENTICATION;
-		sup->hash_algo = cpu_to_le16(c->auth_hash_algo);
-		err = ubifs_hmac_wkm(c, sup->hmac_wkm);
-		if (err)
-			goto out;
-	} else {
-		sup->hash_algo = cpu_to_le16(0xffff);
-	}
-
-	sup->ch.node_type  = UBIFS_SB_NODE;
-	sup->key_hash      = UBIFS_KEY_HASH_R5;
-	sup->flags         = cpu_to_le32(sup_flags);
-	sup->min_io_size   = cpu_to_le32(c->min_io_size);
-	sup->leb_size      = cpu_to_le32(c->leb_size);
-	sup->leb_cnt       = cpu_to_le32(c->leb_cnt);
-	sup->max_leb_cnt   = cpu_to_le32(c->max_leb_cnt);
-	sup->max_bud_bytes = cpu_to_le64(tmp64);
-	sup->log_lebs      = cpu_to_le32(log_lebs);
-	sup->lpt_lebs      = cpu_to_le32(lpt_lebs);
-	sup->orph_lebs     = cpu_to_le32(orph_lebs);
-	sup->jhead_cnt     = cpu_to_le32(DEFAULT_JHEADS_CNT);
-	sup->fanout        = cpu_to_le32(DEFAULT_FANOUT);
-	sup->lsave_cnt     = cpu_to_le32(c->lsave_cnt);
-	sup->fmt_version   = cpu_to_le32(ubifs_default_version);
-	sup->time_gran     = cpu_to_le32(DEFAULT_TIME_GRAN);
-	if (c->mount_opts.override_compr)
-		sup->default_compr = cpu_to_le16(c->mount_opts.compr_type);
-	else
-		sup->default_compr = cpu_to_le16(get_default_compressor(c));
-
-	generate_random_uuid(sup->uuid);
-
-	main_bytes = (long long)main_lebs * c->leb_size;
-	tmp64 = div_u64(main_bytes * DEFAULT_RP_PERCENT, 100);
-	if (tmp64 > DEFAULT_MAX_RP_SIZE)
-		tmp64 = DEFAULT_MAX_RP_SIZE;
-	sup->rp_size = cpu_to_le64(tmp64);
-	sup->ro_compat_version = cpu_to_le32(UBIFS_RO_COMPAT_VERSION);
-
-	dbg_gen("default superblock created at LEB 0:0");
-
-	/* Create default master node */
-
-	mst->ch.node_type = UBIFS_MST_NODE;
-	mst->log_lnum     = cpu_to_le32(UBIFS_LOG_LNUM);
-	mst->highest_inum = cpu_to_le64(UBIFS_FIRST_INO);
-	mst->cmt_no       = 0;
-	mst->root_lnum    = cpu_to_le32(main_first + DEFAULT_IDX_LEB);
-	mst->root_offs    = 0;
-	tmp = ubifs_idx_node_sz(c, 1);
-	mst->root_len     = cpu_to_le32(tmp);
-	mst->gc_lnum      = cpu_to_le32(main_first + DEFAULT_GC_LEB);
-	mst->ihead_lnum   = cpu_to_le32(main_first + DEFAULT_IDX_LEB);
-	mst->ihead_offs   = cpu_to_le32(ALIGN(tmp, c->min_io_size));
-	mst->index_size   = cpu_to_le64(ALIGN(tmp, 8));
-	mst->lpt_lnum     = cpu_to_le32(c->lpt_lnum);
-	mst->lpt_offs     = cpu_to_le32(c->lpt_offs);
-	mst->nhead_lnum   = cpu_to_le32(c->nhead_lnum);
-	mst->nhead_offs   = cpu_to_le32(c->nhead_offs);
-	mst->ltab_lnum    = cpu_to_le32(c->ltab_lnum);
-	mst->ltab_offs    = cpu_to_le32(c->ltab_offs);
-	mst->lsave_lnum   = cpu_to_le32(c->lsave_lnum);
-	mst->lsave_offs   = cpu_to_le32(c->lsave_offs);
-	mst->lscan_lnum   = cpu_to_le32(main_first);
-	mst->empty_lebs   = cpu_to_le32(main_lebs - 2);
-	mst->idx_lebs     = cpu_to_le32(1);
-	mst->leb_cnt      = cpu_to_le32(c->leb_cnt);
-	ubifs_copy_hash(c, hash_lpt, mst->hash_lpt);
-
-	/* Calculate lprops statistics */
-	tmp64 = main_bytes;
-	tmp64 -= ALIGN(ubifs_idx_node_sz(c, 1), c->min_io_size);
-	tmp64 -= ALIGN(UBIFS_INO_NODE_SZ, c->min_io_size);
-	mst->total_free = cpu_to_le64(tmp64);
-
-	tmp64 = ALIGN(ubifs_idx_node_sz(c, 1), c->min_io_size);
-	ino_waste = ALIGN(UBIFS_INO_NODE_SZ, c->min_io_size) -
-			  UBIFS_INO_NODE_SZ;
-	tmp64 += ino_waste;
-	tmp64 -= ALIGN(ubifs_idx_node_sz(c, 1), 8);
-	mst->total_dirty = cpu_to_le64(tmp64);
-
-	/*  The indexing LEB does not contribute to dark space */
-	tmp64 = ((long long)(c->main_lebs - 1) * c->dark_wm);
-	mst->total_dark = cpu_to_le64(tmp64);
-
-	mst->total_used = cpu_to_le64(UBIFS_INO_NODE_SZ);
-
-	dbg_gen("default master node created at LEB %d:0", UBIFS_MST_LNUM);
-
-	/* Create the root indexing node */
-
-	c->key_fmt = UBIFS_SIMPLE_KEY_FMT;
-	c->key_hash = key_r5_hash;
-
-	idx->ch.node_type = UBIFS_IDX_NODE;
-	idx->child_cnt = cpu_to_le16(1);
-	ino_key_init(c, &key, UBIFS_ROOT_INO);
-	br = ubifs_idx_branch(c, idx, 0);
-	key_write_idx(c, &key, &br->key);
-	br->lnum = cpu_to_le32(main_first + DEFAULT_DATA_LEB);
-	br->len  = cpu_to_le32(UBIFS_INO_NODE_SZ);
-
-	dbg_gen("default root indexing node created LEB %d:0",
-		main_first + DEFAULT_IDX_LEB);
-
-	/* Create default root inode */
-
-	ino_key_init_flash(c, &ino->key, UBIFS_ROOT_INO);
-	ino->ch.node_type = UBIFS_INO_NODE;
-	ino->creat_sqnum = cpu_to_le64(++c->max_sqnum);
-	ino->nlink = cpu_to_le32(2);
-
-	ktime_get_coarse_real_ts64(&ts);
-	tmp_le64 = cpu_to_le64(ts.tv_sec);
-	ino->atime_sec   = tmp_le64;
-	ino->ctime_sec   = tmp_le64;
-	ino->mtime_sec   = tmp_le64;
-	ino->atime_nsec  = 0;
-	ino->ctime_nsec  = 0;
-	ino->mtime_nsec  = 0;
-	ino->mode = cpu_to_le32(S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO);
-	ino->size = cpu_to_le64(UBIFS_INO_NODE_SZ);
-
-	/* Set compression enabled by default */
-	ino->flags = cpu_to_le32(UBIFS_COMPR_FL);
-
-	dbg_gen("root inode created at LEB %d:0",
-		main_first + DEFAULT_DATA_LEB);
-
-	/*
-	 * The first node in the log has to be the commit start node. This is
-	 * always the case during normal file-system operation. Write a fake
-	 * commit start node to the log.
-	 */
-
-	cs->ch.node_type = UBIFS_CS_NODE;
-
-	err = ubifs_write_node_hmac(c, sup, UBIFS_SB_NODE_SZ, 0, 0,
-				    offsetof(struct ubifs_sb_node, hmac));
-	if (err)
-		goto out;
-
-	err = ubifs_write_node(c, ino, UBIFS_INO_NODE_SZ,
-			       main_first + DEFAULT_DATA_LEB, 0);
-	if (err)
-		goto out;
-
-	ubifs_node_calc_hash(c, ino, hash);
-	ubifs_copy_hash(c, hash, ubifs_branch_hash(c, br));
-
-	err = ubifs_write_node(c, idx, idx_node_size, main_first + DEFAULT_IDX_LEB, 0);
-	if (err)
-		goto out;
-
-	ubifs_node_calc_hash(c, idx, hash);
-	ubifs_copy_hash(c, hash, mst->hash_root_idx);
-
-	err = ubifs_write_node_hmac(c, mst, UBIFS_MST_NODE_SZ, UBIFS_MST_LNUM, 0,
-		offsetof(struct ubifs_mst_node, hmac));
-	if (err)
-		goto out;
-
-	err = ubifs_write_node_hmac(c, mst, UBIFS_MST_NODE_SZ, UBIFS_MST_LNUM + 1,
-			       0, offsetof(struct ubifs_mst_node, hmac));
-	if (err)
-		goto out;
-
-	err = ubifs_write_node(c, cs, UBIFS_CS_NODE_SZ, UBIFS_LOG_LNUM, 0);
-	if (err)
-		goto out;
-
-	ubifs_msg(c, "default file-system created");
-
-	err = 0;
-out:
-	kfree(sup);
-	kfree(mst);
-	kfree(idx);
-	kfree(ino);
-	kfree(cs);
-
-	return err;
-}
-
 /**
  * validate_sb - validate superblock node.
  * @c: UBIFS file-system description object
@@ -419,9 +79,9 @@ static int validate_sb(struct ubifs_info *c, struct ubifs_sb_node *sup)
 	min_leb_cnt = UBIFS_SB_LEBS + UBIFS_MST_LEBS + c->log_lebs;
 	min_leb_cnt += c->lpt_lebs + c->orph_lebs + c->jhead_cnt + 6;
 
-	if (c->leb_cnt < min_leb_cnt || c->leb_cnt > c->vi.size) {
+	if (c->leb_cnt < min_leb_cnt || c->leb_cnt > c->vi.rsvd_lebs) {
 		ubifs_err(c, "bad LEB count: %d in superblock, %d on UBI volume, %d minimum required",
-			  c->leb_cnt, c->vi.size, min_leb_cnt);
+			  c->leb_cnt, c->vi.rsvd_lebs, min_leb_cnt);
 		goto failed;
 	}
 
@@ -537,72 +197,19 @@ static struct ubifs_sb_node *ubifs_read_sb_node(struct ubifs_info *c)
 	return sup;
 }
 
-static int authenticate_sb_node(struct ubifs_info *c,
+static int authenticate_sb_node(__unused struct ubifs_info *c,
 				const struct ubifs_sb_node *sup)
 {
 	unsigned int sup_flags = le32_to_cpu(sup->flags);
-	u8 hmac_wkm[UBIFS_HMAC_ARR_SZ];
 	int authenticated = !!(sup_flags & UBIFS_FLG_AUTHENTICATION);
-	int hash_algo;
-	int err;
-
-	if (c->authenticated && !authenticated) {
-		ubifs_err(c, "authenticated FS forced, but found FS without authentication");
-		return -EINVAL;
-	}
-
-	if (!c->authenticated && authenticated) {
-		ubifs_err(c, "authenticated FS found, but no key given");
-		return -EINVAL;
-	}
-
-	ubifs_msg(c, "Mounting in %sauthenticated mode",
-		  c->authenticated ? "" : "un");
-
-	if (!c->authenticated)
-		return 0;
 
-	if (!IS_ENABLED(CONFIG_UBIFS_FS_AUTHENTICATION))
+	if (authenticated) {
+		// To be implemented
+		ubifs_err(c, "not support authentication");
 		return -EOPNOTSUPP;
-
-	hash_algo = le16_to_cpu(sup->hash_algo);
-	if (hash_algo >= HASH_ALGO__LAST) {
-		ubifs_err(c, "superblock uses unknown hash algo %d",
-			  hash_algo);
-		return -EINVAL;
-	}
-
-	if (strcmp(hash_algo_name[hash_algo], c->auth_hash_name)) {
-		ubifs_err(c, "This filesystem uses %s for hashing,"
-			     " but %s is specified", hash_algo_name[hash_algo],
-			     c->auth_hash_name);
-		return -EINVAL;
 	}
 
-	/*
-	 * The super block node can either be authenticated by a HMAC or
-	 * by a signature in a ubifs_sig_node directly following the
-	 * super block node to support offline image creation.
-	 */
-	if (ubifs_hmac_zero(c, sup->hmac)) {
-		err = ubifs_sb_verify_signature(c, sup);
-	} else {
-		err = ubifs_hmac_wkm(c, hmac_wkm);
-		if (err)
-			return err;
-		if (ubifs_check_hmac(c, hmac_wkm, sup->hmac_wkm)) {
-			ubifs_err(c, "provided key does not fit");
-			return -ENOKEY;
-		}
-		err = ubifs_node_verify_hmac(c, sup, sizeof(*sup),
-					     offsetof(struct ubifs_sb_node,
-						      hmac));
-	}
-
-	if (err)
-		ubifs_err(c, "Failed to authenticate superblock: %d", err);
-
-	return err;
+	return 0;
 }
 
 /**
@@ -638,12 +245,6 @@ int ubifs_read_superblock(struct ubifs_info *c)
 	int err, sup_flags;
 	struct ubifs_sb_node *sup;
 
-	if (c->empty) {
-		err = create_default_filesystem(c);
-		if (err)
-			return err;
-	}
-
 	sup = ubifs_read_sb_node(c);
 	if (IS_ERR(sup))
 		return PTR_ERR(sup);
@@ -672,13 +273,6 @@ int ubifs_read_superblock(struct ubifs_info *c)
 				err = -EINVAL;
 			goto out;
 		}
-
-		/*
-		 * The FS is mounted R/O, and the media format is
-		 * R/O-compatible with the UBIFS implementation, so we can
-		 * mount.
-		 */
-		c->rw_incompat = 1;
 	}
 
 	if (c->fmt_version < 3) {
@@ -722,14 +316,9 @@ int ubifs_read_superblock(struct ubifs_info *c)
 	c->fanout        = le32_to_cpu(sup->fanout);
 	c->lsave_cnt     = le32_to_cpu(sup->lsave_cnt);
 	c->rp_size       = le64_to_cpu(sup->rp_size);
-	c->rp_uid        = make_kuid(&init_user_ns, le32_to_cpu(sup->rp_uid));
-	c->rp_gid        = make_kgid(&init_user_ns, le32_to_cpu(sup->rp_gid));
 	sup_flags        = le32_to_cpu(sup->flags);
-	if (!c->mount_opts.override_compr)
-		c->default_compr = le16_to_cpu(sup->default_compr);
+	c->default_compr = le16_to_cpu(sup->default_compr);
 
-	c->vfs_sb->s_time_gran = le32_to_cpu(sup->time_gran);
-	memcpy(&c->uuid, &sup->uuid, 16);
 	c->big_lpt = !!(sup_flags & UBIFS_FLG_BIGLPT);
 	c->space_fixup = !!(sup_flags & UBIFS_FLG_SPACE_FIXUP);
 	c->double_hash = !!(sup_flags & UBIFS_FLG_DOUBLE_HASH);
@@ -746,18 +335,11 @@ int ubifs_read_superblock(struct ubifs_info *c)
 		goto out;
 	}
 
-	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION) && c->encrypted) {
-		ubifs_err(c, "file system contains encrypted files but UBIFS"
-			     " was built without crypto support.");
-		err = -EINVAL;
-		goto out;
-	}
-
 	/* Automatically increase file system size to the maximum size */
-	if (c->leb_cnt < c->vi.size && c->leb_cnt < c->max_leb_cnt) {
+	if (c->leb_cnt < c->vi.rsvd_lebs && c->leb_cnt < c->max_leb_cnt) {
 		int old_leb_cnt = c->leb_cnt;
 
-		c->leb_cnt = min_t(int, c->max_leb_cnt, c->vi.size);
+		c->leb_cnt = min_t(int, c->max_leb_cnt, c->vi.rsvd_lebs);
 		sup->leb_cnt = cpu_to_le32(c->leb_cnt);
 
 		c->superblock_need_write = 1;
@@ -807,7 +389,7 @@ static int fixup_leb(struct ubifs_info *c, int lnum, int len)
 
 	dbg_mnt("fixup LEB %d, data len %d", lnum, len);
 	err = ubifs_leb_read(c, lnum, c->sbuf, 0, len, 1);
-	if (err)
+	if (err && err != -EBADMSG)
 		return err;
 
 	return ubifs_leb_change(c, lnum, c->sbuf, len);
@@ -926,31 +508,3 @@ int ubifs_fixup_free_space(struct ubifs_info *c)
 	ubifs_msg(c, "free space fixup complete");
 	return err;
 }
-
-int ubifs_enable_encryption(struct ubifs_info *c)
-{
-	int err;
-	struct ubifs_sb_node *sup = c->sup_node;
-
-	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
-		return -EOPNOTSUPP;
-
-	if (c->encrypted)
-		return 0;
-
-	if (c->ro_mount || c->ro_media)
-		return -EROFS;
-
-	if (c->fmt_version < 5) {
-		ubifs_err(c, "on-flash format version 5 is needed for encryption");
-		return -EINVAL;
-	}
-
-	sup->flags |= cpu_to_le32(UBIFS_FLG_ENCRYPTION);
-
-	err = ubifs_write_sb_node(c, sup);
-	if (!err)
-		c->encrypted = 1;
-
-	return err;
-}
-- 
2.13.6


