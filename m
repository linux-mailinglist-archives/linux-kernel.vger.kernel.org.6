Return-Path: <linux-kernel+bounces-310704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC5296804F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0839281157
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02C818594D;
	Mon,  2 Sep 2024 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTSddoPE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9781714CC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261407; cv=none; b=ZXjbpOJdWzozwUijAqaZE1icqjsUuQvJfuUn9jozpZzLHMP/bXnKV9A6ncwzroc3RHe2wRPC4GyMctvJadmFJEHTeH6tzFPo2Mu/U3dWGqvrWP6OSIkXNH7p9egTt0IG5y5cgzE/Q0D/RvAXfcP/ubV1eW5k1kN2nrPAxbEa/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261407; c=relaxed/simple;
	bh=XsUVOcBfW2JeyjUAJrM1VbT2++Hcy1Zh8J3Xk4CJ6fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT3YdWe9SqFJqloEbogK4IFSTjUlvHtQNEunnsx8rk2/67qeZOmGbkRU/HjaSO+srxubExp0zUe1QuwsoNjG84hsPJy6isS59UsBMjVKhZ0Q23Fjg/iNVuDFVc0ORrOidPLXGkMLDJ2Q86pDC92+CZ+PIrsX/uJipAkmNyovF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTSddoPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA11C4CEC2;
	Mon,  2 Sep 2024 07:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261406;
	bh=XsUVOcBfW2JeyjUAJrM1VbT2++Hcy1Zh8J3Xk4CJ6fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WTSddoPEbD5kSFh8DW5pYD4ONuFe79WI4ETo4U7BQjI1bST4rPU5bcbMIuyNXKMZN
	 bNkFla+us9idV8Q6bk/xzhSxvRVyFkHC1XBCvLLJiz2CDIof7H2AaHdKdiAlLaEokN
	 FBf1IH1mbZtOu4IsLPkCiWx8lU8624B4xKqIwEZ4Rq2nEwz9qzoAjwwHyk+OQ9GX0Q
	 w1KoJNH5pGaKuNymf+b1bHL7jZPtsXyOW1IZ95yYbVEvJW2K0fsiiB4sYRoL8ZKJkN
	 Dluez4d3GOKyB9AfxW54urTAXehe81vQgiYWrnQ+gUOcMQx3OxbTm7WAbQH498x/4V
	 QUbQiC8L55T9w==
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
Subject: [PATCH v7 04/21] mm/zsmalloc: add and use pfn/zpdesc seeking funcs
Date: Mon,  2 Sep 2024 15:21:15 +0800
Message-ID: <20240902072136.578720-5-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Add pfn_zpdesc conversion, convert obj_to_location() to take zpdesc
and also convert its users to use zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   |  9 +++++++
 mm/zsmalloc.c | 75 ++++++++++++++++++++++++++-------------------------
 2 files changed, 47 insertions(+), 37 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 782b5ad67cda..11083a1c2464 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -99,4 +99,13 @@ static inline void zpdesc_put(struct zpdesc *zpdesc)
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
index 1b49f74fd728..a7e73c0de039 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -767,15 +767,15 @@ static struct zpdesc *get_next_zpdesc(struct zpdesc *zpdesc)
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
 
@@ -1201,13 +1201,13 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
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
@@ -1220,8 +1220,8 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	/* It guarantees it can get zspage from handle safely */
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
-	obj_to_location(obj, &page, &obj_idx);
-	zspage = get_zspage(page);
+	obj_to_location(obj, &zpdesc, &obj_idx);
+	zspage = get_zspage(zpdesc_page(zpdesc));
 
 	/*
 	 * migration cannot move any zpages in this zspage. Here, class->lock
@@ -1240,17 +1240,17 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
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
@@ -1262,7 +1262,7 @@ EXPORT_SYMBOL_GPL(zs_map_object);
 void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
-	struct page *page;
+	struct zpdesc *zpdesc;
 	unsigned long obj, off;
 	unsigned int obj_idx;
 
@@ -1270,8 +1270,8 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	struct mapping_area *area;
 
 	obj = handle_to_obj(handle);
-	obj_to_location(obj, &page, &obj_idx);
-	zspage = get_zspage(page);
+	obj_to_location(obj, &zpdesc, &obj_idx);
+	zspage = get_zspage(zpdesc_page(zpdesc));
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
@@ -1279,13 +1279,13 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
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
 
@@ -1427,23 +1427,24 @@ static void obj_free(int class_size, unsigned long obj)
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
@@ -1488,7 +1489,7 @@ EXPORT_SYMBOL_GPL(zs_free);
 static void zs_object_copy(struct size_class *class, unsigned long dst,
 				unsigned long src)
 {
-	struct page *s_page, *d_page;
+	struct zpdesc *s_zpdesc, *d_zpdesc;
 	unsigned int s_objidx, d_objidx;
 	unsigned long s_off, d_off;
 	void *s_addr, *d_addr;
@@ -1497,8 +1498,8 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 
 	s_size = d_size = class->size;
 
-	obj_to_location(src, &s_page, &s_objidx);
-	obj_to_location(dst, &d_page, &d_objidx);
+	obj_to_location(src, &s_zpdesc, &s_objidx);
+	obj_to_location(dst, &d_zpdesc, &d_objidx);
 
 	s_off = offset_in_page(class->size * s_objidx);
 	d_off = offset_in_page(class->size * d_objidx);
@@ -1509,8 +1510,8 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 	if (d_off + class->size > PAGE_SIZE)
 		d_size = PAGE_SIZE - d_off;
 
-	s_addr = kmap_atomic(s_page);
-	d_addr = kmap_atomic(d_page);
+	s_addr = zpdesc_kmap_atomic(s_zpdesc);
+	d_addr = zpdesc_kmap_atomic(d_zpdesc);
 
 	while (1) {
 		size = min(s_size, d_size);
@@ -1535,17 +1536,17 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
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
@@ -1784,7 +1785,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	struct zs_pool *pool;
 	struct size_class *class;
 	struct zspage *zspage;
-	struct page *dummy;
+	struct zpdesc *dummy;
 	void *s_addr, *d_addr, *addr;
 	unsigned int offset;
 	unsigned long handle;
-- 
2.46.0


