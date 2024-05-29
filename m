Return-Path: <linux-kernel+bounces-194007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC628D3556
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F222B254B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316417B43A;
	Wed, 29 May 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGvmCHAH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66471802D4
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981560; cv=none; b=H7teIbWYLM46OuqhnFeJyIWjUJAmCowapGNAOXIG/MVpZdcFM4tiZU3K9PM/dLu7ZzTVVUDTzqzv0EgxHkO3YZFzLynU/b5yjSWDoc7lrV3nqoFWiiu3IcJSXgMnkmK/F6+Hvf722k3v2TnGLXcjgTJ3sJ4TNNIoCcw8KyPpTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981560; c=relaxed/simple;
	bh=OrO0nNYJXDpgIo+jNEx/2QPJnhbsGB0t5v5pFQ5BtT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjMIMkhXkEDUbGowzEFEsYmX5FIZX1TZRjxabC4XI0KKyi7A+c4YKyPT+VlOPCc47K6Db7Fa3nkZx+iF9lEENKfx4etFXJO49Wjb+jxJnm3c19btt/7X5QQgZ1klF0ZV+kD0SHdLTdf9xbR7JX1mEHLAqbPkKbYsXQLXo5svaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGvmCHAH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716981557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abET8lrE4AVrejWdoZuoMbV76D72y0iE8NVlu7Sa3/4=;
	b=RGvmCHAHdpO8+VcntLvPUEa/SfOPpEh2qwDzWW3igy7Lip4tK1CSWE+jwIia9GLzDjZ/dx
	dH6489AAUxYiqCp1ZN38pCiBW4f0pyf0/ua0E9SE4pVfaFBpnAok3+5jSPE33gXhceQji9
	wWzxZ7BrqMxWvcYfLaZul5wEdyo7eqo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-4ALCqXkLPimlN9lNjxcdCQ-1; Wed, 29 May 2024 07:19:14 -0400
X-MC-Unique: 4ALCqXkLPimlN9lNjxcdCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABCCD101A52C;
	Wed, 29 May 2024 11:19:13 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.127])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B28EC15BB1;
	Wed, 29 May 2024 11:19:11 +0000 (UTC)
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
Subject: [PATCH v2 3/6] mm/zsmalloc: use a proper page type
Date: Wed, 29 May 2024 13:19:01 +0200
Message-ID: <20240529111904.2069608-4-david@redhat.com>
In-Reply-To: <20240529111904.2069608-1-david@redhat.com>
References: <20240529111904.2069608-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Let's clean it up: use a proper page type and store our data (offset
into a page) in the lower 16 bit as documented.

We won't be able to support 256 KiB base pages, which is acceptable.
Teach Kconfig to handle that cleanly using a new CONFIG_HAVE_ZSMALLOC.

Based on this, we should do a proper "struct zsdesc" conversion, as
proposed in [1].

This removes the last _mapcount/page_type offender.

[1] https://lore.kernel.org/all/20231130101242.2590384-1-42.hyeyoo@gmail.com/

Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/block/zram/Kconfig |  1 +
 include/linux/page-flags.h |  3 +++
 mm/Kconfig                 | 10 ++++++++--
 mm/zsmalloc.c              | 29 +++++++++++++++++++++++++----
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 6aea609b795c2..40e035468de22 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -2,6 +2,7 @@
 config ZRAM
 	tristate "Compressed RAM block device support"
 	depends on BLOCK && SYSFS && MMU
+	depends on HAVE_ZSMALLOC
 	select ZSMALLOC
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f060db808102c..3afcbfbb379ea 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -957,6 +957,7 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
 #define PG_guard	0x08000000
 #define PG_hugetlb	0x04008000
 #define PG_slab		0x02000000
+#define PG_zsmalloc	0x01000000
 #define PAGE_MAPCOUNT_RESERVE	(~0x0000ffff)
 
 #define PageType(page, flag)						\
@@ -1072,6 +1073,8 @@ FOLIO_TYPE_OPS(hugetlb, hugetlb)
 FOLIO_TEST_FLAG_FALSE(hugetlb)
 #endif
 
+PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
+
 /**
  * PageHuge - Determine if the page belongs to hugetlbfs
  * @page: The page to test.
diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a541..67dc18c94448d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -128,7 +128,7 @@ config ZSWAP_COMPRESSOR_DEFAULT
 choice
 	prompt "Default allocator"
 	depends on ZSWAP
-	default ZSWAP_ZPOOL_DEFAULT_ZSMALLOC if MMU
+	default ZSWAP_ZPOOL_DEFAULT_ZSMALLOC if HAVE_ZSMALLOC
 	default ZSWAP_ZPOOL_DEFAULT_ZBUD
 	help
 	  Selects the default allocator for the compressed cache for
@@ -154,6 +154,7 @@ config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
 
 config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
 	bool "zsmalloc"
+	depends on HAVE_ZSMALLOC
 	select ZSMALLOC
 	help
 	  Use the zsmalloc allocator as the default allocator.
@@ -186,10 +187,15 @@ config Z3FOLD
 	  page. It is a ZBUD derivative so the simplicity and determinism are
 	  still there.
 
+config HAVE_ZSMALLOC
+	def_bool y
+	depends on MMU
+	depends on PAGE_SIZE_LESS_THAN_256KB # we want <= 64 KiB
+
 config ZSMALLOC
 	tristate
 	prompt "N:1 compression allocator (zsmalloc)" if ZSWAP
-	depends on MMU
+	depends on HAVE_ZSMALLOC
 	help
 	  zsmalloc is a slab-based memory allocator designed to store
 	  pages of various compression levels efficiently. It achieves
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index a2a5866473bb8..44e0171d60036 100644
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
@@ -450,14 +451,28 @@ static inline struct page *get_first_page(struct zspage *zspage)
 	return first_page;
 }
 
+#define FIRST_OBJ_PAGE_TYPE_MASK	0xffff
+
+static inline void reset_first_obj_offset(struct page *page)
+{
+	VM_WARN_ON_ONCE(!PageZsmalloc(page));
+	page->page_type |= FIRST_OBJ_PAGE_TYPE_MASK;
+}
+
 static inline unsigned int get_first_obj_offset(struct page *page)
 {
-	return page->page_type;
+	VM_WARN_ON_ONCE(!PageZsmalloc(page));
+	return page->page_type & FIRST_OBJ_PAGE_TYPE_MASK;
 }
 
 static inline void set_first_obj_offset(struct page *page, unsigned int offset)
 {
-	page->page_type = offset;
+	/* With 16 bit available, we can support offsets into 64 KiB pages. */
+	BUILD_BUG_ON(PAGE_SIZE > SZ_64K);
+	VM_WARN_ON_ONCE(!PageZsmalloc(page));
+	VM_WARN_ON_ONCE(offset & ~FIRST_OBJ_PAGE_TYPE_MASK);
+	page->page_type &= ~FIRST_OBJ_PAGE_TYPE_MASK;
+	page->page_type |= offset & FIRST_OBJ_PAGE_TYPE_MASK;
 }
 
 static inline unsigned int get_freeobj(struct zspage *zspage)
@@ -791,8 +806,9 @@ static void reset_page(struct page *page)
 	__ClearPageMovable(page);
 	ClearPagePrivate(page);
 	set_page_private(page, 0);
-	page_mapcount_reset(page);
 	page->index = 0;
+	reset_first_obj_offset(page);
+	__ClearPageZsmalloc(page);
 }
 
 static int trylock_zspage(struct zspage *zspage)
@@ -965,11 +981,13 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
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
@@ -1754,6 +1772,9 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
+	/* We're committed, tell the world that this is a Zsmalloc page. */
+	__SetPageZsmalloc(newpage);
+
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(page);
 	pool = zspage->pool;
-- 
2.45.1


