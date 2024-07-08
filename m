Return-Path: <linux-kernel+bounces-243905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8E2929C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC161C212EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DB56F067;
	Mon,  8 Jul 2024 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3TVIOi8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3017577
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420185; cv=none; b=OTFcr5BWI0xuQ7Nlpbn5EbbZG3pevipT+IEB4fqNd0T8XH/9+/pn3qEXoAtJbDqNWMKI0swX/6FF0mEjR96iWMRQee+wo3Gha6HbVuNBgQq/AH7el1278ne1/r+rs23cx+ylsRXHjjtDacQeMQ9654KAdsokJbe2gJbxrhbqfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420185; c=relaxed/simple;
	bh=Y64RHT8UUVO7Yuad89btOx9mw5qKYY1Q7Nr/pGMgLzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sa/2mVoAkYRMfvw6WJrTVJfr0SPQ1K3y8SpZnvsPvhyWcxsewAEFs8jeyvuaF2WpCc0Au7UWfsnTshOj0/ZN3mIYrzK0AtvVus8iWtPNgwDKYkJbNSaSKlYJLk/HExQ8zvBO1KimqGUuBDq6Yd9jaQW0Zf+0yVoJ0PeGMKtRLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3TVIOi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7497C116B1;
	Mon,  8 Jul 2024 06:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420184;
	bh=Y64RHT8UUVO7Yuad89btOx9mw5qKYY1Q7Nr/pGMgLzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3TVIOi8tn+/Jpf1JSx2+yuyzZOtImlkUm5t0LnzYklpni4kdSFiNHrqpQOXZqOL6
	 eKTBzQL6JVvFtsElAu7G5prq398JdgHze+6UeKvCmxHlMaC6BpNtTzo0tlkPZi5e6u
	 DXlNgwNKMHm0UQBzrcZX6BPaN3TTk5eMyjGw7qRf9HJC8/bqtDsza7aNuxJB5E98Kh
	 cVBOvKC38kiKD4gMr4YS7nAAFe17otobJQn5FNGbjOzVh8XnFWdWFnTy2QLvYSiqu7
	 +b4+8NbWTwh9n/uuXoC10fhHNQkguOvxg8q07JSihLZaF7N3nVxyDqDLJTP6G62bBx
	 ROe9sU1M31ITQ==
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
Subject: [PATCH v3 17/20] mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
Date: Mon,  8 Jul 2024 14:33:38 +0800
Message-ID: <20240708063344.1096626-18-alexs@kernel.org>
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

From: Alex Shi (Tencent) <alexs@kernel.org>

Now that all users of get/set_first_obj_offset() are converted
to use zpdesc, convert them to take zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
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


