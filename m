Return-Path: <linux-kernel+bounces-186708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFC18CC7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354B3282F59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F11146A6F;
	Wed, 22 May 2024 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sr+555z1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B013D61A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411842; cv=none; b=Vhyvly6pBVH4cIvTS8M2mSEFcNzjhEOgv8p1eP9w6pVYfEo9EarPeKQtw+sJEUkZ93vPwNA8VI81p/TSJCs46BToZLl+2VYdy9D+O7YFLECNvIwuYB86yO+e9F+d750duwT7nBHOJWtxT3JjAQiQ8JHncwrsAzqeK9N/88W+mWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411842; c=relaxed/simple;
	bh=tLBgD71UiTZxC+6huT5kb+pDjgDdZYuOpWPLdflh9G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWefEYdf8b6UO4c5NAAm6b3+tPL6azrciC0gc/0Iv4sBm0Ul6mZr4xPx3dGjRCJSHCFXMVA3TdQLLO0Cd0ndQUFjCPT78bb7HmxMTkglh1UQsk+atBm0iR84XYbWTteNIhB9N0quYVEg5OIL4y79sC7XOcD3w/L0GQHRJIxCzAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sr+555z1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716411839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DITBJncVvL2hCWefig3RBM7cSj7OZ/WRaZeUNOkaevI=;
	b=Sr+555z1A23qqRNM2wQ7+vzaVbwPn/A6Ncl3EumejsLNnHWYuFVRaAYN42JRmdFLjS39+u
	+1B2+M31qxqskxx9NJ/FkvGdFrnvCfx/j9fdE8nYGxscOFHJ5jUK/e2zGkKm2etDDJ+rBE
	Fao/v2xt3p3CwliUuaR3q4OdxW5a5i4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-dYd8dj26PQesLwmRv2SXfA-1; Wed, 22 May 2024 17:03:53 -0400
X-MC-Unique: dYd8dj26PQesLwmRv2SXfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3C5780028D;
	Wed, 22 May 2024 21:03:52 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C6A5628E3;
	Wed, 22 May 2024 21:03:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH RFC 3/6] mm/zsmalloc: use a proper page type
Date: Wed, 22 May 2024 23:03:38 +0200
Message-ID: <20240522210341.1030552-4-david@redhat.com>
In-Reply-To: <20240522210341.1030552-1-david@redhat.com>
References: <20240522210341.1030552-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Let's clean it up: use a proper page type and store our data (offset
into a page) in the lower 16 bit as documented.

We'll have to restrict ourselves to <= 64KB base page size (so the offset
fits into 16 bit), which sounds reasonable. Unfortunately, we don't have
any space to store it elsewhere for now.

Based on this, we should do a proper "struct zsdesc" conversion, as
proposed in [1].

This removes the last _mapcount/page_type offender.

[1] https://lore.kernel.org/all/20231130101242.2590384-1-42.hyeyoo@gmail.com/

Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h |  3 +++
 mm/Kconfig                 |  1 +
 mm/zsmalloc.c              | 23 +++++++++++++++++++----
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ed9ac4b5233d..ccaf16656de9 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -959,6 +959,7 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
 #define PG_guard	0x00080000
 #define PG_hugetlb	0x00100800
 #define PG_slab		0x00200000
+#define PG_zsmalloc	0x00400000
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -1073,6 +1074,8 @@ FOLIO_TYPE_OPS(hugetlb, hugetlb)
 FOLIO_TEST_FLAG_FALSE(hugetlb)
 #endif
 
+PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
+
 /**
  * PageHuge - Determine if the page belongs to hugetlbfs
  * @page: The page to test.
diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a54..0371d79b1b75 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -190,6 +190,7 @@ config ZSMALLOC
 	tristate
 	prompt "N:1 compression allocator (zsmalloc)" if ZSWAP
 	depends on MMU
+	depends on PAGE_SIZE_LESS_THAN_256KB # we want <= 64KB
 	help
 	  zsmalloc is a slab-based memory allocator designed to store
 	  pages of various compression levels efficiently. It achieves
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b42d3545ca85..6f0032e06242 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -20,7 +20,8 @@
  *	page->index: links together all component pages of a zspage
  *		For the huge page, this is always 0, so we use this field
  *		to store handle.
- *	page->page_type: first object offset in a subpage of zspage
+ *	page->page_type: PG_zsmalloc, lower 16 bit locate the first object
+ *		offset in a subpage of a zspage
  *
  * Usage of struct page flags:
  *	PG_private: identifies the first component page
@@ -450,14 +451,22 @@ static inline struct page *get_first_page(struct zspage *zspage)
 	return first_page;
 }
 
+static inline void reset_first_obj_offset(struct page *page)
+{
+	page->page_type |= 0xffff;
+}
+
 static inline unsigned int get_first_obj_offset(struct page *page)
 {
-	return page->page_type;
+	return page->page_type & 0xffff;
 }
 
 static inline void set_first_obj_offset(struct page *page, unsigned int offset)
 {
-	page->page_type = offset;
+	BUILD_BUG_ON(PAGE_SIZE & ~0xffff);
+	VM_WARN_ON_ONCE(offset & ~0xffff);
+	page->page_type &= ~0xffff;
+	page->page_type |= offset & 0xffff;
 }
 
 static inline unsigned int get_freeobj(struct zspage *zspage)
@@ -791,8 +800,9 @@ static void reset_page(struct page *page)
 	__ClearPageMovable(page);
 	ClearPagePrivate(page);
 	set_page_private(page, 0);
-	page_mapcount_reset(page);
 	page->index = 0;
+	reset_first_obj_offset(page);
+	__ClearPageZsmalloc(page);
 }
 
 static int trylock_zspage(struct zspage *zspage)
@@ -965,11 +975,13 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		if (!page) {
 			while (--i >= 0) {
 				dec_zone_page_state(pages[i], NR_ZSPAGES);
+				__ClearPageZsmalloc(pages[i]);
 				__free_page(pages[i]);
 			}
 			cache_free_zspage(pool, zspage);
 			return NULL;
 		}
+		__SetPageZsmalloc(page);
 
 		inc_zone_page_state(page, NR_ZSPAGES);
 		pages[i] = page;
@@ -1762,6 +1774,9 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
+	/* We're committed, tell the world that this is a Zsmalloc page. */
+	__SetPageZsmalloc(newpage);
+
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(page);
 	pool = zspage->pool;
-- 
2.45.0


