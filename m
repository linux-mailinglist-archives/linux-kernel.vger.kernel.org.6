Return-Path: <linux-kernel+bounces-310706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91F968051
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE641C21A16
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF19B185B7F;
	Mon,  2 Sep 2024 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeTHe/G/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32537176ADF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261414; cv=none; b=dicz4E7/ixiz9dotQRLKGqIZScd08+5781DHdxBTK2bedGexTbFRPoZUeMYzFWVbwYs2CggBpRsLreYtnDaSB/zun2OTkY7vxe0HOaNKtzlyDljmYbPNwOSL8Wr1DUuimr1dNBUVi2O9xowZRNziBbYyp2eAbFIVNMPB1vzHtCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261414; c=relaxed/simple;
	bh=LtPxxmWpxhvwgd6evBIlBSmgc0+AxTDG0ppcncG0AUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwNiMKRiNlF40LuuupLRqHuYnC7Pau9bFqw15hbAMitxO//ahmrFo9bjR4N3MEPjA2NRqVvVBjWFhy7XTNHm3zF2UgMGq0Gvidt6087b2tNixkk0xMmY1qc4yIWP5+PYvcGTNtmZ1flDxFM3SXo4iHQSMwYtn66x0kMbnUx9fYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeTHe/G/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D43C4CECA;
	Mon,  2 Sep 2024 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261413;
	bh=LtPxxmWpxhvwgd6evBIlBSmgc0+AxTDG0ppcncG0AUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oeTHe/G/ry/99t6lVEMFyFRpCzzGHE4tmMQdoPie6y3EhRhkY0ZQ9axzBbdD0XDjP
	 DusqDDUtP11Vi9AmxWicp9ESzmFmMArZFk5ta8D+vj+PcVoHoTOvclom6F9CNE2Q7x
	 NqwNMZzRt9JsUw5dEEDcysjJhNRyxXPTvBFenOH81yRxmGnvRGU2LF/3KPmDe3Wtte
	 Bep//k78yEXeZGCB12dLrYyMyvMsmeuk3xdkjYyg60AhADg1syXKU9jHxJGRmkA+Ko
	 TLgnEDcV+YakWCfs/M4A6tOi/arCYKTRpuW890jGwlxCqTnDoM78WCg/un3uzb//Yk
	 W3QSnOsWnKmcA==
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
	42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v7 06/21] mm/zsmalloc: convert create_page_chain() and its users to use zpdesc
Date: Mon,  2 Sep 2024 15:21:17 +0800
Message-ID: <20240902072136.578720-7-alexs@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902072136.578720-1-alexs@kernel.org>
References: <20240902072136.578720-1-alexs@kernel.org>
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
 mm/zsmalloc.c | 109 ++++++++++++++++++++++++++++++++------------------
 2 files changed, 76 insertions(+), 39 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 11083a1c2464..3a65a7d494b7 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -108,4 +108,10 @@ static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
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
index 664fff88a7f0..6afc3e642e02 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -248,6 +248,35 @@ static inline void *zpdesc_kmap_atomic(struct zpdesc *zpdesc)
 	return kmap_atomic(zpdesc_page(zpdesc));
 }
 
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
@@ -947,35 +976,35 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
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
+		zpdesc->zspage = zspage;
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
 
@@ -987,7 +1016,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 					gfp_t gfp)
 {
 	int i;
-	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE];
+	struct zpdesc *zpdescs[ZS_MAX_PAGES_PER_ZSPAGE];
 	struct zspage *zspage = cache_alloc_zspage(pool, gfp);
 
 	if (!zspage)
@@ -997,25 +1026,25 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
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
@@ -1746,26 +1775,28 @@ static void migrate_write_unlock(struct zspage *zspage)
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
@@ -1838,7 +1869,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	}
 	kunmap_atomic(s_addr);
 
-	replace_sub_page(class, zspage, newpage, page);
+	replace_sub_page(class, zspage, page_zpdesc(newpage), page_zpdesc(page));
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
 	 * it's okay to release migration_lock.
-- 
2.46.0


