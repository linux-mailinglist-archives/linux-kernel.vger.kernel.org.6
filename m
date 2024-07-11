Return-Path: <linux-kernel+bounces-248607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2CC92DFA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364E7283733
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B07776034;
	Thu, 11 Jul 2024 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r1ttDodo"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3C6BB33
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676236; cv=none; b=UzWvQJFjxqu3fNoID0097h0x+LvvHY6la1Lxx/cfj9Yg2DntuNFRUZ81fBMITLKjpiitYLOqL+kE0X5M+177K6EFcJzuj6rtjtX6wPzcXkPKxmMF/Ki97BNpDHJ/Fb+61mmxcAVbwd3noQNVmBtfJCksAvThN+sb+YytycFDLP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676236; c=relaxed/simple;
	bh=zqHnD+xJblVZ0J/HFY4b8P3hu56+hD3DNlLxOaOk6co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WIbIFCoPIScEkNMywKsI3/L/TbGU7Gqsir5irtTfxkOMfA66um0tGXDrS3b9SJwvSlkvOjQ1n2dhuSX+N/P0XsrssypJjr4gGangFHVSVqsjCweCtm3tJUu9gK/gJjvPIvWBJdWESvAGdXnhWLCkldzyVo5fXd01TlJsz7M3eBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r1ttDodo; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720676224; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cYoC/QRYRRwbVegGtKBjZ29Tb3iJi7EnOc+Fcjt/RH0=;
	b=r1ttDodo2zJEhbzmkEqkC2Rn2JsAsIqiy+/fTMVrD767bOwPFJUEggS5oYGtAayVE6LJA7GCvY/OG/BvKqfwHQJpWQZQp6gZ2H0Pizys5iNyuRs2rJORyrcT4ei7Se8JoO9TYZGikFZDebhC3sbjtbRe8XMcA+XrTOc5GYMaUO8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WAIfNAJ_1720676220;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAIfNAJ_1720676220)
          by smtp.aliyun-inc.com;
          Thu, 11 Jul 2024 13:37:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: avoid refcounting short-lived pages
Date: Thu, 11 Jul 2024 13:36:59 +0800
Message-ID: <20240711053659.1364989-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LZ4 always reuses the decompressed buffer as its LZ77 sliding window
(dynamic dictionary) for optimal performance.  However, in specific
cases, the output buffer may not fully contain valid page cache pages,
resulting in the use of short-lived pages for temporary purposes.

Due to the limited sliding window size, LZ4 shortlived bounce pages can
also be reused in a sliding manner, so each bounce page can be vmapped
multiple times in different relative positions by design.  In order to
avoiding double frees, currently, reuse counts are recorded via page
refcount, but it will be no longer used as is in the future world of
Memdescs.

Just maintain a lookup table to check if a shortlived page is reused.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h     | 22 ++++++----------------
 fs/erofs/decompressor.c |  1 -
 fs/erofs/zdata.c        | 27 ++++++++++++++++++---------
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 526edc0a7d2d..7bfe251680ec 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -54,17 +54,14 @@ struct z_erofs_decompressor {
  */
 
 /*
- * short-lived pages are pages directly from buddy system with specific
- * page->private (no need to set PagePrivate since these are non-LRU /
- * non-movable pages and bypass reclaim / migration code).
+ * Currently, short-lived pages are pages directly from buddy system
+ * with specific page->private (Z_EROFS_SHORTLIVED_PAGE).
+ * In the future world of Memdescs, it should be type 0 (Misc) memory
+ * which type can be checked with a new helper.
  */
 static inline bool z_erofs_is_shortlived_page(struct page *page)
 {
-	if (page->private != Z_EROFS_SHORTLIVED_PAGE)
-		return false;
-
-	DBG_BUGON(page->mapping);
-	return true;
+	return page->private == Z_EROFS_SHORTLIVED_PAGE;
 }
 
 static inline bool z_erofs_put_shortlivedpage(struct page **pagepool,
@@ -72,14 +69,7 @@ static inline bool z_erofs_put_shortlivedpage(struct page **pagepool,
 {
 	if (!z_erofs_is_shortlived_page(page))
 		return false;
-
-	/* short-lived pages should not be used by others at the same time */
-	if (page_ref_count(page) > 1) {
-		put_page(page);
-	} else {
-		/* follow the pcluster rule above. */
-		erofs_pagepool_add(pagepool, page);
-	}
+	erofs_pagepool_add(pagepool, page);
 	return true;
 }
 
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index eac9e415194b..c2253b6a5416 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -110,7 +110,6 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 
 		if (top) {
 			victim = availables[--top];
-			get_page(victim);
 		} else {
 			victim = __erofs_allocpage(pagepool, rq->gfp, true);
 			if (!victim)
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index aff3cdf114ad..544fa0f922b4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1221,7 +1221,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	const struct z_erofs_decompressor *decomp =
 				z_erofs_decomp[pcl->algorithmformat];
-	int i, err2;
+	int i, j, jtop, err2;
 	struct page *page;
 	bool overlapped;
 
@@ -1279,10 +1279,9 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		WRITE_ONCE(pcl->compressed_bvecs[0].page, NULL);
 		put_page(page);
 	} else {
+		/* managed folios are still left in compressed_bvecs[] */
 		for (i = 0; i < pclusterpages; ++i) {
-			/* consider shortlived pages added when decompressing */
 			page = be->compressed_pages[i];
-
 			if (!page ||
 			    erofs_folio_is_managed(sbi, page_folio(page)))
 				continue;
@@ -1293,21 +1292,31 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	if (be->compressed_pages < be->onstack_pages ||
 	    be->compressed_pages >= be->onstack_pages + Z_EROFS_ONSTACK_PAGES)
 		kvfree(be->compressed_pages);
-	z_erofs_fill_other_copies(be, err);
 
+	jtop = 0;
+	z_erofs_fill_other_copies(be, err);
 	for (i = 0; i < be->nr_pages; ++i) {
 		page = be->decompressed_pages[i];
 		if (!page)
 			continue;
 
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
-
-		/* recycle all individual short-lived pages */
-		if (z_erofs_put_shortlivedpage(be->pagepool, page))
+		if (!z_erofs_is_shortlived_page(page)) {
+			z_erofs_onlinefolio_end(page_folio(page), err);
 			continue;
-		z_erofs_onlinefolio_end(page_folio(page), err);
+		}
+		if (pcl->algorithmformat != Z_EROFS_COMPRESSION_LZ4) {
+			erofs_pagepool_add(be->pagepool, page);
+			continue;
+		}
+		for (j = 0; j < jtop && be->decompressed_pages[j] != page; ++j)
+			;
+		if (j >= jtop)	/* this bounce page is newly detected */
+			be->decompressed_pages[jtop++] = page;
 	}
-
+	while (jtop)
+		erofs_pagepool_add(be->pagepool,
+				   be->decompressed_pages[--jtop]);
 	if (be->decompressed_pages != be->onstack_pages)
 		kvfree(be->decompressed_pages);
 
-- 
2.43.5


