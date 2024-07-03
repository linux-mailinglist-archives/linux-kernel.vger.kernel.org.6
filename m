Return-Path: <linux-kernel+bounces-239422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2919925F8D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19BD28BA12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B35178CEA;
	Wed,  3 Jul 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CJ//tgM/"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9C3174EF3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008071; cv=none; b=OK3zFVYh1R5WNS/OV2fuliukA4iOvBCJuITOxhTSC44eVzLXOSkj2NYqOsWkQwpQVgxyFcZTrnggh1xijLWoQmsiJtdw0ZTacME/888/Fs1cvTsyMCrTATtq0RY9O6aQTn4WZiPbyDv7gg5rZkJfGL+j34c++gURDkY1sSmg7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008071; c=relaxed/simple;
	bh=tXCExCtQTYhS5WoDbfhG1iAw0C6aFxicwOVUudxFZAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImZN4hCVoFMXvedSKB8g/AeJtXDmXRwuu/BMacQVpo0cd76gnHlgE6L4dnLP47oFk6l/kuK4iQVP6RHuWa3AVbgSslHiaIsnVHaqebDPw2tqc6+N04NcwZjO8rMyApTIOvq9P7qn12nht00vgKCt3hXWUPe31CkujB1cOwYsTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CJ//tgM/; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720008061; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=f3NfSFOztXDR1P17ftTq4m6tI075p02Cmv9kVZVzihc=;
	b=CJ//tgM/dfVB52T/mR9OkamKoal9J10XUhBI6aJvJttnS/Fdze8Ln6t2u2ZsADnTN6oUsu5sK9cX+GlfaiUYVnS4GVY8uPwkVXLjuApmb2jxjYDllZi/Yqe2qjHdx1vpUwwe4FSHvKo9pzLpRXlGERftVcICY/2FUgfAOMokDBM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W9mSOMt_1720008059;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9mSOMt_1720008059)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 20:01:00 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/4] erofs: tidy up `struct z_erofs_bvec`
Date: Wed,  3 Jul 2024 20:00:51 +0800
Message-ID: <20240703120051.3653452-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240703120051.3653452-1-hsiangkao@linux.alibaba.com>
References: <20240703120051.3653452-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After revisiting the design, I believe `struct z_erofs_bvec` should
be page-based instead of folio-based due to the reasons below:

 - The minimized memory mapping block is a page;

 - Under the certain circumstances, only temporary pages needs to be
   used instead of folios since refcount, mapcount for such pages are
   unnecessary;

 - Decompressors handle all types of pages including temporary pages,
   not only folios.

When handling `struct z_erofs_bvec`, all folio-related information
is now accessed using the page_folio() helper.

The final goal of this round adaptation is to eliminate direct
accesses to `struct page` in the EROFS codebase, except for some
exceptions like `z_erofs_is_shortlived_page()` and
`z_erofs_page_is_invalidated()`, which require a new helper to
determine the memdesc type of an arbitrary page.

Actually large folios of compressed files seems to work now, yet I tend
to conduct more tests before officially enabling this for all scenarios.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 101 +++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 52 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cb017ca2c7e3..988f67cc0145 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -19,10 +19,7 @@
 typedef void *z_erofs_next_pcluster_t;
 
 struct z_erofs_bvec {
-	union {
-		struct page *page;
-		struct folio *folio;
-	};
+	struct page *page;
 	int offset;
 	unsigned int end;
 };
@@ -617,32 +614,31 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 }
 
-/* called by erofs_shrinker to get rid of all cached compressed bvecs */
+/* (erofs_shrinker) disconnect cached encoded data with pclusters */
 int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 					struct erofs_workgroup *grp)
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
+	struct folio *folio;
 	int i;
 
 	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
-	/* There is no actice user since the pcluster is now freezed */
+	/* Each cached folio contains one page unless bs > ps is supported */
 	for (i = 0; i < pclusterpages; ++i) {
-		struct folio *folio = pcl->compressed_bvecs[i].folio;
+		if (pcl->compressed_bvecs[i].page) {
+			folio = page_folio(pcl->compressed_bvecs[i].page);
+			/* Avoid reclaiming or migrating this folio */
+			if (!folio_trylock(folio))
+				return -EBUSY;
 
-		if (!folio)
-			continue;
-
-		/* Avoid reclaiming or migrating this folio */
-		if (!folio_trylock(folio))
-			return -EBUSY;
-
-		if (!erofs_folio_is_managed(sbi, folio))
-			continue;
-		pcl->compressed_bvecs[i].folio = NULL;
-		folio_detach_private(folio);
-		folio_unlock(folio);
+			if (!erofs_folio_is_managed(sbi, folio))
+				continue;
+			pcl->compressed_bvecs[i].page = NULL;
+			folio_detach_private(folio);
+			folio_unlock(folio);
+		}
 	}
 	return 0;
 }
@@ -650,9 +646,9 @@ int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 {
 	struct z_erofs_pcluster *pcl = folio_get_private(folio);
-	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
+	struct z_erofs_bvec *bvec = pcl->compressed_bvecs;
+	struct z_erofs_bvec *end = bvec + z_erofs_pclusterpages(pcl);
 	bool ret;
-	int i;
 
 	if (!folio_test_private(folio))
 		return true;
@@ -661,9 +657,9 @@ static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 	spin_lock(&pcl->obj.lockref.lock);
 	if (pcl->obj.lockref.count <= 0) {
 		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
-		for (i = 0; i < pclusterpages; ++i) {
-			if (pcl->compressed_bvecs[i].folio == folio) {
-				pcl->compressed_bvecs[i].folio = NULL;
+		for (; bvec < end; ++bvec) {
+			if (bvec->page && page_folio(bvec->page) == folio) {
+				bvec->page = NULL;
 				folio_detach_private(folio);
 				ret = true;
 				break;
@@ -1062,7 +1058,7 @@ static bool z_erofs_is_sync_decompress(struct erofs_sb_info *sbi,
 
 static bool z_erofs_page_is_invalidated(struct page *page)
 {
-	return !page->mapping && !z_erofs_is_shortlived_page(page);
+	return !page_folio(page)->mapping && !z_erofs_is_shortlived_page(page);
 }
 
 struct z_erofs_decompress_backend {
@@ -1415,7 +1411,7 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	bool tocache = false;
 	struct z_erofs_bvec zbv;
 	struct address_space *mapping;
-	struct page *page;
+	struct folio *folio;
 	int bs = i_blocksize(f->inode);
 
 	/* Except for inplace folios, the entire folio can be used for I/Os */
@@ -1425,23 +1421,25 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	spin_lock(&pcl->obj.lockref.lock);
 	zbv = pcl->compressed_bvecs[nr];
 	spin_unlock(&pcl->obj.lockref.lock);
-	if (!zbv.folio)
+	if (!zbv.page)
 		goto out_allocfolio;
 
-	bvec->bv_page = &zbv.folio->page;
+	bvec->bv_page = zbv.page;
 	DBG_BUGON(z_erofs_is_shortlived_page(bvec->bv_page));
+
+	folio = page_folio(zbv.page);
 	/*
 	 * Handle preallocated cached folios.  We tried to allocate such folios
 	 * without triggering direct reclaim.  If allocation failed, inplace
 	 * file-backed folios will be used instead.
 	 */
-	if (zbv.folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
-		zbv.folio->private = 0;
+	if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
+		folio->private = 0;
 		tocache = true;
 		goto out_tocache;
 	}
 
-	mapping = READ_ONCE(zbv.folio->mapping);
+	mapping = READ_ONCE(folio->mapping);
 	/*
 	 * File-backed folios for inplace I/Os are all locked steady,
 	 * therefore it is impossible for `mapping` to be NULL.
@@ -1453,21 +1451,21 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 		return;
 	}
 
-	folio_lock(zbv.folio);
-	if (zbv.folio->mapping == mc) {
+	folio_lock(folio);
+	if (folio->mapping == mc) {
 		/*
 		 * The cached folio is still in managed cache but without
 		 * a valid `->private` pcluster hint.  Let's reconnect them.
 		 */
-		if (!folio_test_private(zbv.folio)) {
-			folio_attach_private(zbv.folio, pcl);
+		if (!folio_test_private(folio)) {
+			folio_attach_private(folio, pcl);
 			/* compressed_bvecs[] already takes a ref before */
-			folio_put(zbv.folio);
+			folio_put(folio);
 		}
 
 		/* no need to submit if it is already up-to-date */
-		if (folio_test_uptodate(zbv.folio)) {
-			folio_unlock(zbv.folio);
+		if (folio_test_uptodate(folio)) {
+			folio_unlock(folio);
 			bvec->bv_page = NULL;
 		}
 		return;
@@ -1477,32 +1475,31 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	 * It has been truncated, so it's unsafe to reuse this one. Let's
 	 * allocate a new page for compressed data.
 	 */
-	DBG_BUGON(zbv.folio->mapping);
+	DBG_BUGON(folio->mapping);
 	tocache = true;
-	folio_unlock(zbv.folio);
-	folio_put(zbv.folio);
+	folio_unlock(folio);
+	folio_put(folio);
 out_allocfolio:
-	page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
+	zbv.page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
 	spin_lock(&pcl->obj.lockref.lock);
-	if (pcl->compressed_bvecs[nr].folio) {
-		erofs_pagepool_add(&f->pagepool, page);
+	if (pcl->compressed_bvecs[nr].page) {
+		erofs_pagepool_add(&f->pagepool, zbv.page);
 		spin_unlock(&pcl->obj.lockref.lock);
 		cond_resched();
 		goto repeat;
 	}
-	pcl->compressed_bvecs[nr].folio = zbv.folio = page_folio(page);
+	bvec->bv_page = pcl->compressed_bvecs[nr].page = zbv.page;
+	folio = page_folio(zbv.page);
+	/* first mark it as a temporary shortlived folio (now 1 ref) */
+	folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
 	spin_unlock(&pcl->obj.lockref.lock);
-	bvec->bv_page = page;
 out_tocache:
 	if (!tocache || bs != PAGE_SIZE ||
-	    filemap_add_folio(mc, zbv.folio, pcl->obj.index + nr, gfp)) {
-		/* turn into a temporary shortlived folio (1 ref) */
-		zbv.folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
+	    filemap_add_folio(mc, folio, pcl->obj.index + nr, gfp))
 		return;
-	}
-	folio_attach_private(zbv.folio, pcl);
+	folio_attach_private(folio, pcl);
 	/* drop a refcount added by allocpage (then 2 refs in total here) */
-	folio_put(zbv.folio);
+	folio_put(folio);
 }
 
 static struct z_erofs_decompressqueue *jobqueue_init(struct super_block *sb,
-- 
2.43.5


