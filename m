Return-Path: <linux-kernel+bounces-265636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA7593F3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D7CB21EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B97F154C0D;
	Mon, 29 Jul 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKtVL170"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E393153598
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252073; cv=none; b=MQi1C2NIo0yS4oE0pu51g/8ajtWPRlF0aG5T9+6tsVWdCDEYoVOVe8tfLQJaq2sDqm0MyWGJqjgg0BLfjWOnpsogb+SA+LZB6mld4leY1nrAf1NvMByFZUTEgg2Pe8cpBSu5j16Lkd/WPLOW5CQahMpFXKkfQuXQJhJwr15WGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252073; c=relaxed/simple;
	bh=Itfg7R6iNeKIMJsSCXaa7VK0PRdQ2psxEdNvilX7MGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRTFBgbKpAa64+MLGPA3EcBvI404/hwZWHu6toQ03uIGnuKWcFDt+CSG5D6nFa3nL1VHy9e7uqhehNdWo57C92NQg/K3k2nY4dNXRQZvZmRRLCpTaqyAwVV20SaZPqZ/c0xv9RdeBZ8asmO7GjLVJnRfI6IjQPH+XyaLnlmHPvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKtVL170; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693D1C4AF11;
	Mon, 29 Jul 2024 11:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252073;
	bh=Itfg7R6iNeKIMJsSCXaa7VK0PRdQ2psxEdNvilX7MGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKtVL170fOP1O4XLSDWo1F250iq5RJ80EenjRyd7ZFOT2WvuJuInoIyx92SwRS7Cc
	 pbrGzXYKmIIAT4QtnvMB8ThaarUUedL3E5+TlS+UtYM+YJsxN2p5XSlso+e1SHSb5M
	 xTUP2ijw2w7jJF69q2NiOoesk4j1NPgHOtJ1w0TS2tjj2RqoWf5SEtWI/DS+hgTA/t
	 jwIzd+zFQpYJUj4XC3xJkx35hp9rlt9Ju0MpE+vnq/J8BM6koz0K0BkDwwpac68UpE
	 0W/f4fyzHaM9zCNTqtvtVyYatxW07+UpA2zA8fi8x/CPXDjyEwZFw9NR4VBwQLbWRv
	 TGyKYh/tyozJw==
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
Subject: [PATCH v4 17/22] mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
Date: Mon, 29 Jul 2024 19:25:29 +0800
Message-ID: <20240729112534.3416707-18-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729112534.3416707-1-alexs@kernel.org>
References: <20240729112534.3416707-1-alexs@kernel.org>
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
 mm/zpdesc.h   |  7 ++++++-
 mm/zsmalloc.c | 36 ++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 72c8c072b4c8..f64e813f4847 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -15,6 +15,8 @@
  * @next:		Next zpdesc in a zspage in zsmalloc zpool
  * @handle:		For huge zspage in zsmalloc zpool
  * @zspage:		Pointer to zspage in zsmalloc
+ * @first_obj_offset:	First object offset in zsmalloc zpool
+ * @_refcount:		Indirectly use by page migration
  * @memcg_data:		Memory Control Group data.
  *
  * This struct overlays struct page for now. Do not modify without a good
@@ -31,7 +33,8 @@ struct zpdesc {
 		unsigned long handle;
 	};
 	struct zspage *zspage;
-	unsigned long _zp_pad_1;
+	unsigned int first_obj_offset;
+	atomic_t _refcount;
 #ifdef CONFIG_MEMCG
 	unsigned long memcg_data;
 #endif
@@ -45,6 +48,8 @@ ZPDESC_MATCH(mapping, mops);
 ZPDESC_MATCH(index, next);
 ZPDESC_MATCH(index, handle);
 ZPDESC_MATCH(private, zspage);
+ZPDESC_MATCH(page_type, first_obj_offset);
+ZPDESC_MATCH(_refcount, _refcount);
 #ifdef CONFIG_MEMCG
 ZPDESC_MATCH(memcg_data, memcg_data);
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 8b713ac03902..bb8b5f13a966 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -20,8 +20,8 @@
  *	zpdesc->next: links together all component pages of a zspage
  *		For the huge page, this is always 0, so we use this field
  *		to store handle.
- *	page->page_type: PG_zsmalloc, lower 16 bit locate the first object
- *		offset in a subpage of a zspage
+ *	zpdesc->first_obj_offset: PG_zsmalloc, lower 16 bit locate the first
+ *		object offset in a subpage of a zspage
  *
  * Usage of struct zpdesc(page) flags:
  *	PG_private: identifies the first component page
@@ -494,26 +494,26 @@ static struct zpdesc *get_first_zpdesc(struct zspage *zspage)
 
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
@@ -850,7 +850,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-	reset_first_obj_offset(page);
+	reset_first_obj_offset(zpdesc);
 	__ClearPageZsmalloc(page);
 }
 
@@ -934,7 +934,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		struct link_free *link;
 		void *vaddr;
 
-		set_first_obj_offset(zpdesc_page(zpdesc), off);
+		set_first_obj_offset(zpdesc, off);
 
 		vaddr = zpdesc_kmap_atomic(zpdesc);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
@@ -1589,7 +1589,7 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	unsigned long handle = 0;
 	void *addr = zpdesc_kmap_atomic(zpdesc);
 
-	offset = get_first_obj_offset(zpdesc_page(zpdesc));
+	offset = get_first_obj_offset(zpdesc);
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
@@ -1784,8 +1784,8 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
 
 	create_page_chain(class, zspage, zpdescs);
-	first_obj_offset = get_first_obj_offset(zpdesc_page(oldzpdesc));
-	set_first_obj_offset(zpdesc_page(newzpdesc), first_obj_offset);
+	first_obj_offset = get_first_obj_offset(oldzpdesc);
+	set_first_obj_offset(newzpdesc, first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
 		newzpdesc->handle = oldzpdesc->handle;
 	__zpdesc_set_movable(newzpdesc, &zsmalloc_mops);
@@ -1840,7 +1840,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
 
-	offset = get_first_obj_offset(zpdesc_page(zpdesc));
+	offset = get_first_obj_offset(zpdesc);
 	s_addr = zpdesc_kmap_atomic(zpdesc);
 
 	/*
-- 
2.43.0


