Return-Path: <linux-kernel+bounces-275594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E614948777
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EAE1F25EBF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBEE39ACC;
	Tue,  6 Aug 2024 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaWMFlpO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66538DC7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910738; cv=none; b=Mfd9DVY66lzIaiCstOIDWp4z2br3zynaqEAjiZjfapIifNku1FPqniHMsWYR2yO5ztIdOIWcwuNJBDIQFgRNlHX6iusNRXZCnh5KQr+zoP7Fs6e2blB8GzE2IBi/SaQecigXjfDJfqaPRUyziQo6OkV4RXn7ydMTxybA6WIPxbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910738; c=relaxed/simple;
	bh=xBRbiPI9Fj5vFVKbb/yDx6Gk1e8RF8irjBVrIsL9n4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lq+5bsSEpiu/BferpQRmstCztoEWDTNsDRqvWqxnMpUwwIO2M7wOkKIDU3/Zc6wZEc8SwmzuV29oPecwRyBm6KZWtGmQQ+AocrMl8wiqt420vZP0HhjliXXtnMnasfLJbP4GNIk6lm0fer2mWTQYvjxm52cKGbJGse3p2woHRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaWMFlpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6A3C4AF0C;
	Tue,  6 Aug 2024 02:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910738;
	bh=xBRbiPI9Fj5vFVKbb/yDx6Gk1e8RF8irjBVrIsL9n4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaWMFlpOOvQxiuUrEdt0K4kqxnxvptrUSrrBTxZQhjnf0InUS+rHp/YA9L18z0U/j
	 o5GFJeiz6YFu/eejUX1D3OwapL+PjeF8zf/2vZEs8ccrA84UfOySV0QI9jatpp15Az
	 xz8nX1jKA+eAf3fiP9Br2fwstLZFEXiPeFHtLhgnOBmcy9ACATYNVDLet8rtdgtY2p
	 fwnDQi+SpyOlv71NA4smr8Y+8jIBLZ8Pa3+WRph3nNejjXqF9EnM9X3i52KFE/XAX7
	 PJ0RCylZSMz2WHISlIgceqb5JLJl4q0/+QKv7mFavS/oXXL4FUDFILThvNu7v/30Tu
	 xYIIdvUjvEPvQ==
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
Subject: [PATCH v5 17/21] mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
Date: Tue,  6 Aug 2024 10:23:04 +0800
Message-ID: <20240806022311.3924442-18-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806022311.3924442-1-alexs@kernel.org>
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Now that all users of get/set_first_obj_offset() are converted
to use zpdesc, convert them to take zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1c53a58e6473..e2cfee57a39a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -474,26 +474,26 @@ static struct zpdesc *get_first_zpdesc(struct zspage *zspage)
 
 #define FIRST_OBJ_PAGE_TYPE_MASK	0xffff
 
-static inline void reset_first_obj_offset(struct page *page)
+static inline void reset_first_obj_offset(struct zpdesc *zpdesc)
 {
-	VM_WARN_ON_ONCE(!PageZsmalloc(page));
-	page->page_type |= FIRST_OBJ_PAGE_TYPE_MASK;
+	VM_WARN_ON_ONCE(!PageZsmalloc(zpdesc_page(zpdesc)));
+	zpdesc->first_obj_offset |= FIRST_OBJ_PAGE_TYPE_MASK;
 }
 
-static inline unsigned int get_first_obj_offset(struct page *page)
+static inline unsigned int get_first_obj_offset(struct zpdesc *zpdesc)
 {
-	VM_WARN_ON_ONCE(!PageZsmalloc(page));
-	return page->page_type & FIRST_OBJ_PAGE_TYPE_MASK;
+	VM_WARN_ON_ONCE(!PageZsmalloc(zpdesc_page(zpdesc)));
+	return zpdesc->first_obj_offset & FIRST_OBJ_PAGE_TYPE_MASK;
 }
 
-static inline void set_first_obj_offset(struct page *page, unsigned int offset)
+static inline void set_first_obj_offset(struct zpdesc *zpdesc, unsigned int offset)
 {
 	/* With 16 bit available, we can support offsets into 64 KiB pages. */
 	BUILD_BUG_ON(PAGE_SIZE > SZ_64K);
-	VM_WARN_ON_ONCE(!PageZsmalloc(page));
+	VM_WARN_ON_ONCE(!PageZsmalloc(zpdesc_page(zpdesc)));
 	VM_WARN_ON_ONCE(offset & ~FIRST_OBJ_PAGE_TYPE_MASK);
-	page->page_type &= ~FIRST_OBJ_PAGE_TYPE_MASK;
-	page->page_type |= offset & FIRST_OBJ_PAGE_TYPE_MASK;
+	zpdesc->first_obj_offset &= ~FIRST_OBJ_PAGE_TYPE_MASK;
+	zpdesc->first_obj_offset |= offset & FIRST_OBJ_PAGE_TYPE_MASK;
 }
 
 static inline unsigned int get_freeobj(struct zspage *zspage)
@@ -830,7 +830,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-	reset_first_obj_offset(page);
+	reset_first_obj_offset(zpdesc);
 	__ClearPageZsmalloc(page);
 }
 
@@ -914,7 +914,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		struct link_free *link;
 		void *vaddr;
 
-		set_first_obj_offset(zpdesc_page(zpdesc), off);
+		set_first_obj_offset(zpdesc, off);
 
 		vaddr = zpdesc_kmap_atomic(zpdesc);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
@@ -1569,7 +1569,7 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	unsigned long handle = 0;
 	void *addr = zpdesc_kmap_atomic(zpdesc);
 
-	offset = get_first_obj_offset(zpdesc_page(zpdesc));
+	offset = get_first_obj_offset(zpdesc);
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
@@ -1764,8 +1764,8 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
 
 	create_page_chain(class, zspage, zpdescs);
-	first_obj_offset = get_first_obj_offset(zpdesc_page(oldzpdesc));
-	set_first_obj_offset(zpdesc_page(newzpdesc), first_obj_offset);
+	first_obj_offset = get_first_obj_offset(oldzpdesc);
+	set_first_obj_offset(newzpdesc, first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
 		newzpdesc->handle = oldzpdesc->handle;
 	__zpdesc_set_movable(newzpdesc, &zsmalloc_mops);
@@ -1820,7 +1820,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
 
-	offset = get_first_obj_offset(zpdesc_page(zpdesc));
+	offset = get_first_obj_offset(zpdesc);
 	s_addr = zpdesc_kmap_atomic(zpdesc);
 
 	/*
-- 
2.43.0


