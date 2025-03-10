Return-Path: <linux-kernel+bounces-553904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE1AA59071
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31EF188EC86
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C412227BBB;
	Mon, 10 Mar 2025 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SEJ27EFI"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED10225A40
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600525; cv=none; b=Hquxokteff91d7XlhcrFRBWQbDqny/lPtrYSVgzBIoUn4MvBqfUFcmHoBLMZJJKooY5eSBi+RLyU6Uys1wi1LXXZC5mB0Du+2BWjbIL1v6zaUCDfGnJBDGLTRSeGnQCiG0MiCG+ph/BRBSQbnuBsdQyqaxm8jFlO2OsDIYaGReo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600525; c=relaxed/simple;
	bh=ww55T+hoX36OF565Dg/tA+6CIzmhFxu/2/WLLc2sscI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3H5GyLsesRYWlWLE5zBNZOcy/NatW7ubwA2ZR6og8zEjbAly8H2p7M57H6tOm0O/lSf0Bv3obhCdVVFi+c6fXpKarxWV+nym4KSghko2FrG7yK9WM+HOhcJrYc9m+heGKs+HPucnNUUWBDQXp1mFyFRoIcqov5NUVymIUuBb9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SEJ27EFI; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600513; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fTu+r29pJ2St4N5TdLAuOppyVCL2SeeAabz9j0fnfo8=;
	b=SEJ27EFIC1krInlV/hMnG/MTpAn+kF4UcVk5Qr8DkN4oRUkDXdW0VK1IFngyn32JPDyxX0xw7CAex85wJBHWAId8xi3fls5DJpPr0sPxR8d1PMnRXkhgfmDxITUG3VBYoTGfOPuGOGbDJOE3FQfbQDNeRKCZTZYKirOLMQNHz3o=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F4.H_1741600511 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 09/10] erofs: support unaligned encoded data
Date: Mon, 10 Mar 2025 17:54:59 +0800
Message-ID: <20250310095459.2620647-10-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're almost there.  It's straight-forward to adapt the current
decompression subsystem to support unaligned encoded (compressed) data.

Note that unaligned data is not encouraged because of worse I/O and
caching efficiency unless the corresponding compressor doesn't support
fixed-sized output compression natively like Zstd.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c |  2 +-
 fs/erofs/zdata.c        | 92 ++++++++++++++++++++---------------------
 2 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 50e350b10f89..bf62e2836b60 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -313,7 +313,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 		rq->outputsize -= cur;
 	}
 
-	for (; rq->outputsize; rq->pageofs_in = 0, cur += PAGE_SIZE, ni++) {
+	for (; rq->outputsize; rq->pageofs_in = 0, cur += insz, ni++) {
 		insz = min(PAGE_SIZE - rq->pageofs_in, rq->outputsize);
 		rq->outputsize -= insz;
 		if (!rq->in[ni])
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bc6d6842c5c2..0671184d9cf1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -44,8 +44,8 @@ struct z_erofs_pcluster {
 	/* A: point to next chained pcluster or TAILs */
 	struct z_erofs_pcluster *next;
 
-	/* I: start block address of this pcluster */
-	erofs_off_t index;
+	/* I: start physical position of this pcluster */
+	erofs_off_t pos;
 
 	/* L: the maximum decompression size of this round */
 	unsigned int length;
@@ -73,6 +73,9 @@ struct z_erofs_pcluster {
 	/* I: compression algorithm format */
 	unsigned char algorithmformat;
 
+	/* I: whether compressed data is in-lined or not */
+	bool from_meta;
+
 	/* L: whether partial decompression or not */
 	bool partial;
 
@@ -102,14 +105,9 @@ struct z_erofs_decompressqueue {
 	bool eio, sync;
 };
 
-static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
-{
-	return !pcl->index;
-}
-
 static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
 {
-	return PAGE_ALIGN(pcl->pclustersize) >> PAGE_SHIFT;
+	return PAGE_ALIGN(pcl->pageofs_in + pcl->pclustersize) >> PAGE_SHIFT;
 }
 
 static bool erofs_folio_is_managed(struct erofs_sb_info *sbi, struct folio *fo)
@@ -133,7 +131,7 @@ struct z_erofs_pcluster_slab {
 
 static struct z_erofs_pcluster_slab pcluster_pool[] __read_mostly = {
 	_PCLP(1), _PCLP(4), _PCLP(16), _PCLP(64), _PCLP(128),
-	_PCLP(Z_EROFS_PCLUSTER_MAX_PAGES)
+	_PCLP(Z_EROFS_PCLUSTER_MAX_PAGES + 1)
 };
 
 struct z_erofs_bvec_iter {
@@ -267,7 +265,6 @@ static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int size)
 		pcl = kmem_cache_zalloc(pcs->slab, GFP_KERNEL);
 		if (!pcl)
 			return ERR_PTR(-ENOMEM);
-		pcl->pclustersize = size;
 		return pcl;
 	}
 	return ERR_PTR(-EINVAL);
@@ -516,6 +513,7 @@ static void z_erofs_bind_cache(struct z_erofs_frontend *fe)
 	struct z_erofs_pcluster *pcl = fe->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	bool shouldalloc = z_erofs_should_alloc_cache(fe);
+	pgoff_t poff = pcl->pos >> PAGE_SHIFT;
 	bool may_bypass = true;
 	/* Optimistic allocation, as in-place I/O can be used as a fallback */
 	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
@@ -532,7 +530,7 @@ static void z_erofs_bind_cache(struct z_erofs_frontend *fe)
 		if (READ_ONCE(pcl->compressed_bvecs[i].page))
 			continue;
 
-		folio = filemap_get_folio(mc, pcl->index + i);
+		folio = filemap_get_folio(mc, poff + i);
 		if (IS_ERR(folio)) {
 			may_bypass = false;
 			if (!shouldalloc)
@@ -575,7 +573,7 @@ static int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 	struct folio *folio;
 	int i;
 
-	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
+	DBG_BUGON(pcl->from_meta);
 	/* Each cached folio contains one page unless bs > ps is supported */
 	for (i = 0; i < pclusterpages; ++i) {
 		if (pcl->compressed_bvecs[i].page) {
@@ -607,7 +605,7 @@ static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 	ret = false;
 	spin_lock(&pcl->lockref.lock);
 	if (pcl->lockref.count <= 0) {
-		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
+		DBG_BUGON(pcl->from_meta);
 		for (; bvec < end; ++bvec) {
 			if (bvec->page && page_folio(bvec->page) == folio) {
 				bvec->page = NULL;
@@ -667,16 +665,20 @@ static int z_erofs_attach_page(struct z_erofs_frontend *fe,
 	int ret;
 
 	if (exclusive) {
-		/* give priority for inplaceio to use file pages first */
-		spin_lock(&pcl->lockref.lock);
-		while (fe->icur > 0) {
-			if (pcl->compressed_bvecs[--fe->icur].page)
-				continue;
-			pcl->compressed_bvecs[fe->icur] = *bvec;
+		/* Inplace I/O is limited to one page for uncompressed data */
+		if (pcl->algorithmformat < Z_EROFS_COMPRESSION_MAX ||
+		    fe->icur <= 1) {
+			/* Try to prioritize inplace I/O here */
+			spin_lock(&pcl->lockref.lock);
+			while (fe->icur > 0) {
+				if (pcl->compressed_bvecs[--fe->icur].page)
+					continue;
+				pcl->compressed_bvecs[fe->icur] = *bvec;
+				spin_unlock(&pcl->lockref.lock);
+				return 0;
+			}
 			spin_unlock(&pcl->lockref.lock);
-			return 0;
 		}
-		spin_unlock(&pcl->lockref.lock);
 
 		/* otherwise, check if it can be used as a bvpage */
 		if (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED &&
@@ -711,27 +713,26 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 	struct erofs_map_blocks *map = &fe->map;
 	struct super_block *sb = fe->inode->i_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	bool ztailpacking = map->m_flags & EROFS_MAP_META;
 	struct z_erofs_pcluster *pcl, *pre;
+	unsigned int pageofs_in;
 	int err;
 
-	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
-	    (!ztailpacking && !erofs_blknr(sb, map->m_pa))) {
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
-
-	/* no available pcluster, let's allocate one */
-	pcl = z_erofs_alloc_pcluster(map->m_plen);
+	pageofs_in = erofs_blkoff(sb, map->m_pa);
+	pcl = z_erofs_alloc_pcluster(pageofs_in + map->m_plen);
 	if (IS_ERR(pcl))
 		return PTR_ERR(pcl);
 
 	lockref_init(&pcl->lockref); /* one ref for this request */
 	pcl->algorithmformat = map->m_algorithmformat;
+	pcl->pclustersize = map->m_plen;
+	pcl->pageofs_in = pageofs_in;
 	pcl->length = 0;
 	pcl->partial = true;
 	pcl->next = fe->head;
+	pcl->pos = map->m_pa;
+	pcl->pageofs_in = pageofs_in;
 	pcl->pageofs_out = map->m_la & ~PAGE_MASK;
+	pcl->from_meta = map->m_flags & EROFS_MAP_META;
 	fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 
 	/*
@@ -741,13 +742,10 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 	mutex_init(&pcl->lock);
 	DBG_BUGON(!mutex_trylock(&pcl->lock));
 
-	if (ztailpacking) {
-		pcl->index = 0;		/* which indicates ztailpacking */
-	} else {
-		pcl->index = erofs_blknr(sb, map->m_pa);
+	if (!pcl->from_meta) {
 		while (1) {
 			xa_lock(&sbi->managed_pslots);
-			pre = __xa_cmpxchg(&sbi->managed_pslots, pcl->index,
+			pre = __xa_cmpxchg(&sbi->managed_pslots, pcl->pos,
 					   NULL, pcl, GFP_KERNEL);
 			if (!pre || xa_is_err(pre) || z_erofs_get_pcluster(pre)) {
 				xa_unlock(&sbi->managed_pslots);
@@ -779,7 +777,6 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
 	struct super_block *sb = fe->inode->i_sb;
-	erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
 	struct z_erofs_pcluster *pcl = NULL;
 	int ret;
 
@@ -790,9 +787,9 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 	if (!(map->m_flags & EROFS_MAP_META)) {
 		while (1) {
 			rcu_read_lock();
-			pcl = xa_load(&EROFS_SB(sb)->managed_pslots, blknr);
+			pcl = xa_load(&EROFS_SB(sb)->managed_pslots, map->m_pa);
 			if (!pcl || z_erofs_get_pcluster(pcl)) {
-				DBG_BUGON(pcl && blknr != pcl->index);
+				DBG_BUGON(pcl && map->m_pa != pcl->pos);
 				rcu_read_unlock();
 				break;
 			}
@@ -826,7 +823,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 
 	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
 				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
-	if (!z_erofs_is_inline_pcluster(fe->pcl)) {
+	if (!fe->pcl->from_meta) {
 		/* bind cache first when cached decompression is preferred */
 		z_erofs_bind_cache(fe);
 	} else {
@@ -871,7 +868,7 @@ static bool __erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	 * It's impossible to fail after the pcluster is freezed, but in order
 	 * to avoid some race conditions, add a DBG_BUGON to observe this.
 	 */
-	DBG_BUGON(__xa_erase(&sbi->managed_pslots, pcl->index) != pcl);
+	DBG_BUGON(__xa_erase(&sbi->managed_pslots, pcl->pos) != pcl);
 
 	lockref_mark_dead(&pcl->lockref);
 	return true;
@@ -1221,7 +1218,7 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_backend *be, bool *overlapped)
 		}
 		be->compressed_pages[i] = page;
 
-		if (z_erofs_is_inline_pcluster(pcl) ||
+		if (pcl->from_meta ||
 		    erofs_folio_is_managed(EROFS_SB(be->sb), page_folio(page))) {
 			if (!PageUptodate(page))
 				err = -EIO;
@@ -1299,7 +1296,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 				 }, be->pagepool);
 
 	/* must handle all compressed pages before actual file pages */
-	if (z_erofs_is_inline_pcluster(pcl)) {
+	if (pcl->from_meta) {
 		page = pcl->compressed_bvecs[0].page;
 		WRITE_ONCE(pcl->compressed_bvecs[0].page, NULL);
 		put_page(page);
@@ -1359,7 +1356,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 	WRITE_ONCE(pcl->next, NULL);
 	mutex_unlock(&pcl->lock);
 
-	if (z_erofs_is_inline_pcluster(pcl))
+	if (pcl->from_meta)
 		z_erofs_free_pcluster(pcl);
 	else
 		z_erofs_put_pcluster(sbi, pcl, try_free);
@@ -1540,7 +1537,7 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	folio = page_folio(page);
 out_tocache:
 	if (!tocache || bs != PAGE_SIZE ||
-	    filemap_add_folio(mc, folio, pcl->index + nr, gfp)) {
+	    filemap_add_folio(mc, folio, (pcl->pos >> PAGE_SHIFT) + nr, gfp)) {
 		/* turn into a temporary shortlived folio (1 ref) */
 		folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
 		return;
@@ -1657,19 +1654,20 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 
 		pcl = next;
 		next = READ_ONCE(pcl->next);
-		if (z_erofs_is_inline_pcluster(pcl)) {
+		if (pcl->from_meta) {
 			z_erofs_move_to_bypass_queue(pcl, next, qtail);
 			continue;
 		}
 
 		/* no device id here, thus it will always succeed */
 		mdev = (struct erofs_map_dev) {
-			.m_pa = erofs_pos(sb, pcl->index),
+			.m_pa = round_down(pcl->pos, sb->s_blocksize),
 		};
 		(void)erofs_map_dev(sb, &mdev);
 
 		cur = mdev.m_pa;
-		end = cur + pcl->pclustersize;
+		end = round_up(cur + pcl->pageofs_in + pcl->pclustersize,
+			       sb->s_blocksize);
 		do {
 			bvec.bv_page = NULL;
 			if (bio && (cur != last_pa ||
-- 
2.43.5


