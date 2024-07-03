Return-Path: <linux-kernel+bounces-238826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6253392510A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866B51C20DAE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E59C176ABB;
	Wed,  3 Jul 2024 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUNlomcQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B7174EDE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979334; cv=none; b=EZXzF4phwGXbhgQRjRUPmtRP4Bix299INMDOeirrfUr++FDuOl04NcwovXiJ8AUfWC0qQ7EIiX3pB9/y1miFCN8UpF5XxjoG1EGWv8rvhLzzjtnpbEw/C90iX08BOJc716mcMYC2+JmCD/XvIqHBN/jxYwB0/DI6Ga+MdFXDCb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979334; c=relaxed/simple;
	bh=vsXuVfMJsSuMD7UFdk0WVE3RDVFvIl+YscGm1B7bHVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxxhtNqYKjqFUWgnZpO4ucqxNAuLBziZh36QobJyx3nlBlajixVffRLe9WTILGR0zZW4yBEDEwOgYf5oBFil4beuZS6dBsVplRdYSU1I7q5j5bob3Dlale3L88behm2jl4cp1WusQ1rbsLml6n/HC4xsi+wKLaOzD0o+ZzbNyVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUNlomcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2527FC4AF0C;
	Wed,  3 Jul 2024 04:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979334;
	bh=vsXuVfMJsSuMD7UFdk0WVE3RDVFvIl+YscGm1B7bHVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TUNlomcQNEckWzE3pkdaNY/jWZemVDlbi9bxsdknLLDnG7+ZhTC6n5f1YKOBHPscF
	 BhxNJlC+MBOjvNvdjcvvweVfGrQI08RQxthpm10H45a59hqsrL4GTJMugS9+1KtZdn
	 4M+riFrBTzpbHYxAIryEuoUqrDZckEejZCNBzptjOWLMeGv1EBzgq2ScxBviaaWrQ6
	 QWZDoYbgUQhGonitWAa/cUrUYW0++s9TjxH7obnaIBdamvY460PdXvBVLA6X1x6nkS
	 B4DRFGqaiG9bq5kwyikisFoKGiRznLujqLzzynay9P0uddufucPKK3vVj2EgfV4as3
	 vtHSH2B65Q+mg==
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
Subject: [PATCH v2 17/20] mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
Date: Wed,  3 Jul 2024 12:06:07 +0800
Message-ID: <20240703040613.681396-18-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703040613.681396-1-alexs@kernel.org>
References: <20240703040613.681396-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Now that all users of get/set_first_obj_offset() are converted
to use zpdesc, convert them to take zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   |  6 +++++-
 mm/zsmalloc.c | 32 ++++++++++++++++----------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 6de3c5d095bd..296cb1ff944b 100644
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
 #ifdef CONFIG_SLAB_OBJ_EXT
 	unsigned long memcg_data;
 #endif
@@ -45,6 +48,7 @@ ZPDESC_MATCH(mapping, mops);
 ZPDESC_MATCH(index, next);
 ZPDESC_MATCH(index, handle);
 ZPDESC_MATCH(private, zspage);
+ZPDESC_MATCH(page_type, first_obj_offset);
 ZPDESC_MATCH(memcg_data, memcg_data);
 #undef ZPDESC_MATCH
 static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 8b713ac03902..0493f953fcb5 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
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


