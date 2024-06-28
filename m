Return-Path: <linux-kernel+bounces-233304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA291B54B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3978281CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25DB6F315;
	Fri, 28 Jun 2024 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn8GoGgZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92B4436B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544072; cv=none; b=MWWMwTg9Y46NX9HPAJ8JbDR2uuPMZ9NhNZc3X15T2T8Tpv2gkFdIqVzDHarZJxNEBKfrFNDE7/+bnJT+Ro5HAvc2UeSNF5MpuNBB2y7/UMgZhTp52SVKsNSdiUWVlLHD1F6Kl1BmfIAXz4tB7SbIICW5ci/5vceunO7Cm/RAa3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544072; c=relaxed/simple;
	bh=BULUfQtc3EjNlGEEdYDtph/07BaO7bkwBtlyH1/5iBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNKW02bl5r4NmwajdZokq1llqdSOOph3X1G+kSVzkaP06YTtukssBBxJJBTlve/h6FGICw6yccSC6+NPC9cUiBy238QWv4sRab1xPgKbFF+hGPYm5suPyWzJFuR5hFvjF3GlpLOtUffba+iXDJU7NjWM9SgN1RKtlDQYMGAHYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn8GoGgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7603C116B1;
	Fri, 28 Jun 2024 03:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544071;
	bh=BULUfQtc3EjNlGEEdYDtph/07BaO7bkwBtlyH1/5iBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kn8GoGgZJ1gvzJR2ncaJOTr4cft0ptFYqqqvbtAwTpCfjfvz4TvWV5uAi2Eez6HFe
	 fKUWmp/Ts+D6L4Djx91kxmxRNiKIpJnkx8+z1/ZcZdL8U1zcxymua+7Gi4mAGVdSPM
	 JORUVVR6FgEOCUCxesPq43knn7yJph28Reeb3A8CaTzJ0LJYlKmw1JaZJKOtO85Pce
	 R/zlvqlS7vVfrxk14GzwY82GipQfBVN9n7LaPjttYrKJmpNLAq4aXSGvIaD6Gh5t+u
	 QRlJ7PvfPSXp5TlA6TInbxbPPsrHJyyGJD7s2T5vpgnRSaqu8yy/uWEXSp7AbPLic2
	 7bibTnUJh3iLA==
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
Subject: [PATCH 17/20] mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
Date: Fri, 28 Jun 2024 11:11:32 +0800
Message-ID: <20240628031138.429622-18-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Now that all users of get/set_first_obj_offset() are converted
to use zpdesc, convert them to take zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   |  3 +++
 mm/zsmalloc.c | 32 ++++++++++++++++----------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 186ff9711ffb..17941774c46e 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -14,6 +14,7 @@
  * @next:		Next zpdesc in a zspage in zsmalloc zpool
  * @handle:		For huge zspage in zsmalloc zpool
  * @zspage:		Pointer to zspage in zsmalloc
+ * @first_obj_offset:	First object offset in zsmalloc zpool
  *
  * This struct overlays struct page for now. Do not modify without a good
  * understanding of the issues.
@@ -29,6 +30,7 @@ struct zpdesc {
 		unsigned long handle;
 	};
 	struct zspage *zspage;
+	unsigned int first_obj_offset;
 };
 #define ZPDESC_MATCH(pg, zp) \
 	static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
@@ -38,6 +40,7 @@ ZPDESC_MATCH(lru, lru);
 ZPDESC_MATCH(index, next);
 ZPDESC_MATCH(index, handle);
 ZPDESC_MATCH(private, zspage);
+ZPDESC_MATCH(page_type, first_obj_offset);
 #undef ZPDESC_MATCH
 static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 951292dbcae4..3ce49f0372cc 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -496,26 +496,26 @@ static struct zpdesc *get_first_zpdesc(struct zspage *zspage)
 
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
@@ -852,7 +852,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-	reset_first_obj_offset(page);
+	reset_first_obj_offset(zpdesc);
 	__ClearPageZsmalloc(page);
 }
 
@@ -936,7 +936,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		struct link_free *link;
 		void *vaddr;
 
-		set_first_obj_offset(zpdesc_page(zpdesc), off);
+		set_first_obj_offset(zpdesc, off);
 
 		vaddr = zpdesc_kmap_atomic(zpdesc);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
@@ -1593,7 +1593,7 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	unsigned long handle = 0;
 	void *addr = zpdesc_kmap_atomic(zpdesc);
 
-	offset = get_first_obj_offset(zpdesc_page(zpdesc));
+	offset = get_first_obj_offset(zpdesc);
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
@@ -1789,8 +1789,8 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
 
 	create_page_chain(class, zspage, zpdescs);
-	first_obj_offset = get_first_obj_offset(zpdesc_page(oldzpdesc));
-	set_first_obj_offset(zpdesc_page(newzpdesc), first_obj_offset);
+	first_obj_offset = get_first_obj_offset(oldzpdesc);
+	set_first_obj_offset(newzpdesc, first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
 		newzpdesc->handle = oldzpdesc->handle;
 	__zpdesc_set_movable(newzpdesc, &zsmalloc_mops);
@@ -1845,7 +1845,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
 
-	offset = get_first_obj_offset(zpdesc_page(zpdesc));
+	offset = get_first_obj_offset(zpdesc);
 	s_addr = zpdesc_kmap_atomic(zpdesc);
 
 	/*
-- 
2.43.0


