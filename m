Return-Path: <linux-kernel+bounces-243892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 179A0929C30
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F52DB20D66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331417BA6;
	Mon,  8 Jul 2024 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs2Uv9IC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44E171C2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420136; cv=none; b=jPgZoN/MsesVv2WPHvdYE7iJZdGb5EbJDviaru5dr2qXOIfdwiHidBAmRfQhHy+q61swSEJO1xY5Ar/NMJhccieULathHTmKIq94qUyGod2ZUNLsqzV5TG5i5SA0E8pztsLuk+UINMRGxx4g48p0oUTuVsdcFwO1rjMkZhZBMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420136; c=relaxed/simple;
	bh=83jcf8H2ELpZcgLjgz32nYRKXID3GsZDqOi1CXzndR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2AG/7Oie3ca7Pe5gtR7svd8zT7ZreuBeLw5qHxeGGB35vza5ixRMgdv7gnwRvxA6oubJTgQF7HBfWWSfzViwc9ui/I2uhpNfHudP7dL3rqt4vSFZwxjODOB49/cQe9RlwScMja9XWMvNQ8VAKHsjM4h8cLj3smwvrbEfbIQLMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs2Uv9IC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A694C4AF0B;
	Mon,  8 Jul 2024 06:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420136;
	bh=83jcf8H2ELpZcgLjgz32nYRKXID3GsZDqOi1CXzndR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bs2Uv9ICcXS8Sew+dSWNGK1eSMFRpY70r/3FWCgrZS6JN0tiH0+a5nxvKN3Yl+YtJ
	 gE6Yz+5wSlHjGep1v2dYdKBlMunZqqBAcDd/GvG4acDD0vI6Wh6K8moqosV4r+F101
	 swVXn7hn2qMzhAygustSXm0WSTAGmTgHatJjzn5dtzR2Xz8f3cmGuh78nTxuRQAtSR
	 wjFMhlS7jRFJS2gaRYSZEWKnYaraHCvpp+LwayujCyA0Vdiw5RWRlgNOGpBn98TUwj
	 vE+qHsptRfzPeVDJXYFkB94b5EiWwl1ZPQvgc6vnBTsk1dG/FJYPxo+LpP8AkKwCIB
	 guhs8FMg1J+Hw==
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
Subject: [PATCH v3 04/20] mm/zsmalloc: add and use pfn/zpdesc seeking funcs
Date: Mon,  8 Jul 2024 14:33:25 +0800
Message-ID: <20240708063344.1096626-5-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708063344.1096626-1-alexs@kernel.org>
References: <20240708063344.1096626-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Add pfn_zpdesc conversion, convert obj_to_location() to take zpdesc
and also convert its users to use zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zpdesc.h   |  9 +++++++
 mm/zsmalloc.c | 75 ++++++++++++++++++++++++++-------------------------
 2 files changed, 47 insertions(+), 37 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 3b04197cec9d..79ec40b03956 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -93,4 +93,13 @@ static inline void zpdesc_put(struct zpdesc *zpdesc)
 	folio_put(zpdesc_folio(zpdesc));
 }
 
+static inline unsigned long zpdesc_pfn(struct zpdesc *zpdesc)
+{
+	return page_to_pfn(zpdesc_page(zpdesc));
+}
+
+static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
+{
+	return page_zpdesc(pfn_to_page(pfn));
+}
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 68a39c233d34..149fe2b332cb 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -773,15 +773,15 @@ static struct zpdesc *get_next_zpdesc(struct zpdesc *zpdesc)
 }
 
 /**
- * obj_to_location - get (<page>, <obj_idx>) from encoded object value
+ * obj_to_location - get (<zpdesc>, <obj_idx>) from encoded object value
  * @obj: the encoded object value
- * @page: page object resides in zspage
+ * @zpdesc: zpdesc object resides in zspage
  * @obj_idx: object index
  */
-static void obj_to_location(unsigned long obj, struct page **page,
+static void obj_to_location(unsigned long obj, struct zpdesc **zpdesc,
 				unsigned int *obj_idx)
 {
-	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
+	*zpdesc = pfn_zpdesc(obj >> OBJ_INDEX_BITS);
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
@@ -1208,13 +1208,13 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 			enum zs_mapmode mm)
 {
 	struct zspage *zspage;
-	struct page *page;
+	struct zpdesc *zpdesc;
 	unsigned long obj, off;
 	unsigned int obj_idx;
 
 	struct size_class *class;
 	struct mapping_area *area;
-	struct page *pages[2];
+	struct zpdesc *zpdescs[2];
 	void *ret;
 
 	/*
@@ -1227,8 +1227,8 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	/* It guarantees it can get zspage from handle safely */
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
-	obj_to_location(obj, &page, &obj_idx);
-	zspage = get_zspage(page);
+	obj_to_location(obj, &zpdesc, &obj_idx);
+	zspage = get_zspage(zpdesc_page(zpdesc));
 
 	/*
 	 * migration cannot move any zpages in this zspage. Here, class->lock
@@ -1247,17 +1247,17 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
-		area->vm_addr = kmap_atomic(page);
+		area->vm_addr = zpdesc_kmap_atomic(zpdesc);
 		ret = area->vm_addr + off;
 		goto out;
 	}
 
 	/* this object spans two pages */
-	pages[0] = page;
-	pages[1] = get_next_page(page);
-	BUG_ON(!pages[1]);
+	zpdescs[0] = zpdesc;
+	zpdescs[1] = get_next_zpdesc(zpdesc);
+	BUG_ON(!zpdescs[1]);
 
-	ret = __zs_map_object(area, (struct zpdesc **)pages, off, class->size);
+	ret = __zs_map_object(area, zpdescs, off, class->size);
 out:
 	if (likely(!ZsHugePage(zspage)))
 		ret += ZS_HANDLE_SIZE;
@@ -1269,7 +1269,7 @@ EXPORT_SYMBOL_GPL(zs_map_object);
 void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
-	struct page *page;
+	struct zpdesc *zpdesc;
 	unsigned long obj, off;
 	unsigned int obj_idx;
 
@@ -1277,8 +1277,8 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	struct mapping_area *area;
 
 	obj = handle_to_obj(handle);
-	obj_to_location(obj, &page, &obj_idx);
-	zspage = get_zspage(page);
+	obj_to_location(obj, &zpdesc, &obj_idx);
+	zspage = get_zspage(zpdesc_page(zpdesc));
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
@@ -1286,13 +1286,13 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	if (off + class->size <= PAGE_SIZE)
 		kunmap_atomic(area->vm_addr);
 	else {
-		struct page *pages[2];
+		struct zpdesc *zpdescs[2];
 
-		pages[0] = page;
-		pages[1] = get_next_page(page);
-		BUG_ON(!pages[1]);
+		zpdescs[0] = zpdesc;
+		zpdescs[1] = get_next_zpdesc(zpdesc);
+		BUG_ON(!zpdescs[1]);
 
-		__zs_unmap_object(area, (struct zpdesc **)pages, off, class->size);
+		__zs_unmap_object(area, zpdescs, off, class->size);
 	}
 	local_unlock(&zs_map_area.lock);
 
@@ -1434,23 +1434,24 @@ static void obj_free(int class_size, unsigned long obj)
 {
 	struct link_free *link;
 	struct zspage *zspage;
-	struct page *f_page;
+	struct zpdesc *f_zpdesc;
 	unsigned long f_offset;
 	unsigned int f_objidx;
 	void *vaddr;
 
-	obj_to_location(obj, &f_page, &f_objidx);
+
+	obj_to_location(obj, &f_zpdesc, &f_objidx);
 	f_offset = offset_in_page(class_size * f_objidx);
-	zspage = get_zspage(f_page);
+	zspage = get_zspage(zpdesc_page(f_zpdesc));
 
-	vaddr = kmap_atomic(f_page);
+	vaddr = zpdesc_kmap_atomic(f_zpdesc);
 	link = (struct link_free *)(vaddr + f_offset);
 
 	/* Insert this object in containing zspage's freelist */
 	if (likely(!ZsHugePage(zspage)))
 		link->next = get_freeobj(zspage) << OBJ_TAG_BITS;
 	else
-		f_page->index = 0;
+		f_zpdesc->next = NULL;
 	set_freeobj(zspage, f_objidx);
 
 	kunmap_atomic(vaddr);
@@ -1495,7 +1496,7 @@ EXPORT_SYMBOL_GPL(zs_free);
 static void zs_object_copy(struct size_class *class, unsigned long dst,
 				unsigned long src)
 {
-	struct page *s_page, *d_page;
+	struct zpdesc *s_zpdesc, *d_zpdesc;
 	unsigned int s_objidx, d_objidx;
 	unsigned long s_off, d_off;
 	void *s_addr, *d_addr;
@@ -1504,8 +1505,8 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 
 	s_size = d_size = class->size;
 
-	obj_to_location(src, &s_page, &s_objidx);
-	obj_to_location(dst, &d_page, &d_objidx);
+	obj_to_location(src, &s_zpdesc, &s_objidx);
+	obj_to_location(dst, &d_zpdesc, &d_objidx);
 
 	s_off = offset_in_page(class->size * s_objidx);
 	d_off = offset_in_page(class->size * d_objidx);
@@ -1516,8 +1517,8 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 	if (d_off + class->size > PAGE_SIZE)
 		d_size = PAGE_SIZE - d_off;
 
-	s_addr = kmap_atomic(s_page);
-	d_addr = kmap_atomic(d_page);
+	s_addr = zpdesc_kmap_atomic(s_zpdesc);
+	d_addr = zpdesc_kmap_atomic(d_zpdesc);
 
 	while (1) {
 		size = min(s_size, d_size);
@@ -1542,17 +1543,17 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 		if (s_off >= PAGE_SIZE) {
 			kunmap_atomic(d_addr);
 			kunmap_atomic(s_addr);
-			s_page = get_next_page(s_page);
-			s_addr = kmap_atomic(s_page);
-			d_addr = kmap_atomic(d_page);
+			s_zpdesc = get_next_zpdesc(s_zpdesc);
+			s_addr = zpdesc_kmap_atomic(s_zpdesc);
+			d_addr = zpdesc_kmap_atomic(d_zpdesc);
 			s_size = class->size - written;
 			s_off = 0;
 		}
 
 		if (d_off >= PAGE_SIZE) {
 			kunmap_atomic(d_addr);
-			d_page = get_next_page(d_page);
-			d_addr = kmap_atomic(d_page);
+			d_zpdesc = get_next_zpdesc(d_zpdesc);
+			d_addr = zpdesc_kmap_atomic(d_zpdesc);
 			d_size = class->size - written;
 			d_off = 0;
 		}
@@ -1791,7 +1792,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	struct zs_pool *pool;
 	struct size_class *class;
 	struct zspage *zspage;
-	struct page *dummy;
+	struct zpdesc *dummy;
 	void *s_addr, *d_addr, *addr;
 	unsigned int offset;
 	unsigned long handle;
-- 
2.43.0


