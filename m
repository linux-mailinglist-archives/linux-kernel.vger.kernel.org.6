Return-Path: <linux-kernel+bounces-233293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B231E91B540
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB94281C82
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA254D8B3;
	Fri, 28 Jun 2024 03:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSZsq3px"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B324CE04
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544032; cv=none; b=EvoQo+71EghF7CUmIJpF0dx2AlxKsyfXYcm4dmqaBhlDPt79OwZxRH4O0X6on23Y2ATJqOxwhM5Xur5rtMPYP1m9gaiwxEIl36p5KGplg93ygb58U44rZ/evGVvpzN/shStwROF7Ct7gkBz2ZqWRv8fwB+RNyaWjk45H6bpDpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544032; c=relaxed/simple;
	bh=DEgsEkg1N6dj0FWoDYLMEtx39UiAuN8BZowdME7NzSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8DNtuDwTvf5TubkyhBdN9FC1GMnYH0ZaytmebwEt6ZQKVdTFXz2/IzUKzygYa6QA/CkBlPtmLgJ+S/BPRFgJWM+y/3VkNSQgrquy/+bx3nv017u+RzWncxjIFafdX+Mt4so6ss2eQ6ppVuzpVT1xMxjjYo4tKUyIXKfiQ58gR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSZsq3px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79717C2BBFC;
	Fri, 28 Jun 2024 03:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544031;
	bh=DEgsEkg1N6dj0FWoDYLMEtx39UiAuN8BZowdME7NzSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FSZsq3pxtjEamZ0NO6vE08PTTiK4G3H8yUs8rLnV+WbysjiW+mZFZE0UGYeBNYpEP
	 YB0gFO+qwGQWdfZX90SJHf9eCmRkjHRsMqgymWr9cgaXlHreST2W1QzDkqYI/sT1Ix
	 ufqYD566GPxPVQ6LSh6bpClqC6aovilg0E20nW5vrxy2VV7iyWKMTpS658xJMnCVBU
	 evSs3Cj4wdRZqcZsvcvaTUaOjHcXo5GZd3Xknyqg0RItte8+C0tIQnOO5QwFdQr+eP
	 BL9EsN2UzrnTXDT4FkJJAjvPqkcs7l5c9m7jsvXXgyGFckIJes7Tw/OJ1Rm60vIol8
	 +bKRDIY5Blg9A==
From: alexs@kernel.org
To: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	willy@infradead.org,
	senozhatsky@chromium.org,
	david@redhat.com,
	42.hyeyoo@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 06/20] mm/zsmalloc: convert create_page_chain() and its users to use zpdesc
Date: Fri, 28 Jun 2024 11:11:21 +0800
Message-ID: <20240628031138.429622-7-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628031138.429622-1-alexs@kernel.org>
References: <20240628031138.429622-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Introduce a few helper functions for conversion to convert create_page_chain()
to use zpdesc, then use zpdesc in replace_sub_page() too.

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   |   6 +++
 mm/zsmalloc.c | 115 +++++++++++++++++++++++++++++++++-----------------
 2 files changed, 82 insertions(+), 39 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 3c0ebdc78ff8..f998d65c59d6 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -92,4 +92,10 @@ static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
 {
 	return page_zpdesc(pfn_to_page(pfn));
 }
+
+static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
+					const struct movable_operations *mops)
+{
+	__SetPageMovable(zpdesc_page(zpdesc), mops);
+}
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 137b36515acf..ee890d513f6f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -250,6 +250,41 @@ static inline void *zpdesc_kmap_atomic(struct zpdesc *zpdesc)
 	return kmap_atomic(zpdesc_page(zpdesc));
 }
 
+static inline void zpdesc_set_zspage(struct zpdesc *zpdesc,
+				     struct zspage *zspage)
+{
+	zpdesc->zspage = zspage;
+}
+
+static inline void zpdesc_set_first(struct zpdesc *zpdesc)
+{
+	SetPagePrivate(zpdesc_page(zpdesc));
+}
+
+static inline void zpdesc_inc_zone_page_state(struct zpdesc *zpdesc)
+{
+	inc_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
+}
+
+static inline void zpdesc_dec_zone_page_state(struct zpdesc *zpdesc)
+{
+	dec_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
+}
+
+static inline struct zpdesc *alloc_zpdesc(gfp_t gfp)
+{
+	struct page *page = alloc_page(gfp);
+
+	return page_zpdesc(page);
+}
+
+static inline void free_zpdesc(struct zpdesc *zpdesc)
+{
+	struct page *page = zpdesc_page(zpdesc);
+
+	__free_page(page);
+}
+
 struct zspage {
 	struct {
 		unsigned int huge:HUGE_BITS;
@@ -956,35 +991,35 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 }
 
 static void create_page_chain(struct size_class *class, struct zspage *zspage,
-				struct page *pages[])
+				struct zpdesc *zpdescs[])
 {
 	int i;
-	struct page *page;
-	struct page *prev_page = NULL;
-	int nr_pages = class->pages_per_zspage;
+	struct zpdesc *zpdesc;
+	struct zpdesc *prev_zpdesc = NULL;
+	int nr_zpdescs = class->pages_per_zspage;
 
 	/*
 	 * Allocate individual pages and link them together as:
-	 * 1. all pages are linked together using page->index
-	 * 2. each sub-page point to zspage using page->private
+	 * 1. all pages are linked together using zpdesc->next
+	 * 2. each sub-page point to zspage using zpdesc->zspage
 	 *
-	 * we set PG_private to identify the first page (i.e. no other sub-page
+	 * we set PG_private to identify the first zpdesc (i.e. no other zpdesc
 	 * has this flag set).
 	 */
-	for (i = 0; i < nr_pages; i++) {
-		page = pages[i];
-		set_page_private(page, (unsigned long)zspage);
-		page->index = 0;
+	for (i = 0; i < nr_zpdescs; i++) {
+		zpdesc = zpdescs[i];
+		zpdesc_set_zspage(zpdesc, zspage);
+		zpdesc->next = NULL;
 		if (i == 0) {
-			zspage->first_zpdesc = page_zpdesc(page);
-			SetPagePrivate(page);
+			zspage->first_zpdesc = zpdesc;
+			zpdesc_set_first(zpdesc);
 			if (unlikely(class->objs_per_zspage == 1 &&
 					class->pages_per_zspage == 1))
 				SetZsHugePage(zspage);
 		} else {
-			prev_page->index = (unsigned long)page;
+			prev_zpdesc->next = zpdesc;
 		}
-		prev_page = page;
+		prev_zpdesc = zpdesc;
 	}
 }
 
@@ -996,7 +1031,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 					gfp_t gfp)
 {
 	int i;
-	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE];
+	struct zpdesc *zpdescs[ZS_MAX_PAGES_PER_ZSPAGE];
 	struct zspage *zspage = cache_alloc_zspage(pool, gfp);
 
 	if (!zspage)
@@ -1006,25 +1041,25 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	migrate_lock_init(zspage);
 
 	for (i = 0; i < class->pages_per_zspage; i++) {
-		struct page *page;
+		struct zpdesc *zpdesc;
 
-		page = alloc_page(gfp);
-		if (!page) {
+		zpdesc = alloc_zpdesc(gfp);
+		if (!zpdesc) {
 			while (--i >= 0) {
-				dec_zone_page_state(pages[i], NR_ZSPAGES);
-				__ClearPageZsmalloc(pages[i]);
-				__free_page(pages[i]);
+				zpdesc_dec_zone_page_state(zpdescs[i]);
+				__ClearPageZsmalloc(zpdesc_page(zpdescs[i]));
+				free_zpdesc(zpdescs[i]);
 			}
 			cache_free_zspage(pool, zspage);
 			return NULL;
 		}
-		__SetPageZsmalloc(page);
+		__SetPageZsmalloc(zpdesc_page(zpdesc));
 
-		inc_zone_page_state(page, NR_ZSPAGES);
-		pages[i] = page;
+		zpdesc_inc_zone_page_state(zpdesc);
+		zpdescs[i] = zpdesc;
 	}
 
-	create_page_chain(class, zspage, pages);
+	create_page_chain(class, zspage, zpdescs);
 	init_zspage(class, zspage);
 	zspage->pool = pool;
 	zspage->class = class->index;
@@ -1758,26 +1793,28 @@ static void migrate_write_unlock(struct zspage *zspage)
 static const struct movable_operations zsmalloc_mops;
 
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
-				struct page *newpage, struct page *oldpage)
+				struct zpdesc *newzpdesc, struct zpdesc *oldzpdesc)
 {
-	struct page *page;
-	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE] = {NULL, };
+	struct zpdesc *zpdesc;
+	struct zpdesc *zpdescs[ZS_MAX_PAGES_PER_ZSPAGE] = {NULL, };
+	unsigned int first_obj_offset;
 	int idx = 0;
 
-	page = get_first_page(zspage);
+	zpdesc = get_first_zpdesc(zspage);
 	do {
-		if (page == oldpage)
-			pages[idx] = newpage;
+		if (zpdesc == oldzpdesc)
+			zpdescs[idx] = newzpdesc;
 		else
-			pages[idx] = page;
+			zpdescs[idx] = zpdesc;
 		idx++;
-	} while ((page = get_next_page(page)) != NULL);
+	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
 
-	create_page_chain(class, zspage, pages);
-	set_first_obj_offset(newpage, get_first_obj_offset(oldpage));
+	create_page_chain(class, zspage, zpdescs);
+	first_obj_offset = get_first_obj_offset(zpdesc_page(oldzpdesc));
+	set_first_obj_offset(zpdesc_page(newzpdesc), first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
-		newpage->index = oldpage->index;
-	__SetPageMovable(newpage, &zsmalloc_mops);
+		newzpdesc->handle = oldzpdesc->handle;
+	__zpdesc_set_movable(newzpdesc, &zsmalloc_mops);
 }
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
@@ -1850,7 +1887,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	}
 	kunmap_atomic(s_addr);
 
-	replace_sub_page(class, zspage, newpage, page);
+	replace_sub_page(class, zspage, page_zpdesc(newpage), page_zpdesc(page));
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
 	 * it's okay to release migration_lock.
-- 
2.43.0


