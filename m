Return-Path: <linux-kernel+bounces-284356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D7F950029
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA06228415D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2114219AD91;
	Tue, 13 Aug 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0tJ5d2Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922819AD89
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538525; cv=none; b=g8g4lrzesyAp2iNJxojhxKI51Jls5RjJ+hn9876AiMx2iML35QiVPP0u1gVzQUg/htxRIcMuN8qd1o9gEdjji8tTwCM9vF02+LRoAfV482csZucyDZ4bCaYttVdRP1U3xy2optpMXPHJZwGbGrBFme7G0EyuCsjZdaaFG83tgHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538525; c=relaxed/simple;
	bh=tL/aSxtJHYmt2JA8n2u9RLnt0i9TICyqYsVXNrqh3nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN4N3g/qmbCM2ymQhH0fcR9OalCRYCKVWJT6cyDFt3VMb3YVTzz8sxmTSkFyHlkUIfGPjAdZQWxyfKazx/lf041IvjkFX6gzJrxlflGiy/NVkJBu0Y8HaDwddS9RL9pJ/AYU7HAAKXQEwgwPRZas07w2dPuf74waFqHf6rv89jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0tJ5d2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40DCC4AF16;
	Tue, 13 Aug 2024 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538525;
	bh=tL/aSxtJHYmt2JA8n2u9RLnt0i9TICyqYsVXNrqh3nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0tJ5d2Ykx0EcLRUEijuPnSiFdQLUU+KiE+TEkgtbafVTWnhrhpjOOGIrKgUD+c1P
	 nWObHJs0C3iwN/7tMgmGpNy89peRAfNOizZEYiOy6KG0gDzXJFn7hm3uhifphw5MqJ
	 HpLxzjmtjt1nX7g1JiLabCtATwm1VUdkHHigB9bxgc3mDSZU1X8Iiwhm3iJOp0U3Og
	 TZQDncbP6fbBm1G+6g3EGSdeyhoHL166jXO92b579SmM0/4viqqMgA4EXFUSis7uEd
	 LUaTOvfVj/9xJVb+GTjsTyke/3ZEeF3t2nH4qXnAK6+sVBkbQnTxhYSP8Vmjcu3O4I
	 Dyl83gBdiNbSQ==
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
Subject: [PATCH v6 15/21] mm/zsmalloc: convert get_zspage() to take zpdesc
Date: Tue, 13 Aug 2024 16:46:01 +0800
Message-ID: <20240813084611.4122571-16-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813084611.4122571-1-alexs@kernel.org>
References: <20240813084611.4122571-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Now that all users except get_next_page() (which will be removed in
later patch) use zpdesc, convert get_zspage() to take zpdesc instead
of page.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index f93af6e10c3a..5e96ff2ee0d4 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -773,9 +773,9 @@ static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 	return newfg;
 }
 
-static struct zspage *get_zspage(struct page *page)
+static struct zspage *get_zspage(struct zpdesc *zpdesc)
 {
-	struct zspage *zspage = (struct zspage *)page_private(page);
+	struct zspage *zspage = zpdesc->zspage;
 
 	BUG_ON(zspage->magic != ZSPAGE_MAGIC);
 	return zspage;
@@ -783,7 +783,7 @@ static struct zspage *get_zspage(struct page *page)
 
 static struct page *get_next_page(struct page *page)
 {
-	struct zspage *zspage = get_zspage(page);
+	struct zspage *zspage = get_zspage(page_zpdesc(page));
 
 	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
@@ -793,7 +793,7 @@ static struct page *get_next_page(struct page *page)
 
 static struct zpdesc *get_next_zpdesc(struct zpdesc *zpdesc)
 {
-	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
+	struct zspage *zspage = get_zspage(zpdesc);
 
 	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
@@ -843,7 +843,7 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 				 unsigned long *phandle)
 {
 	unsigned long handle;
-	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
+	struct zspage *zspage = get_zspage(zpdesc);
 
 	if (unlikely(ZsHugePage(zspage))) {
 		VM_BUG_ON_PAGE(!is_first_zpdesc(zpdesc), zpdesc_page(zpdesc));
@@ -1259,7 +1259,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 
 	/*
 	 * migration cannot move any zpages in this zspage. Here, class->lock
@@ -1309,7 +1309,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
@@ -1473,7 +1473,7 @@ static void obj_free(int class_size, unsigned long obj)
 
 	obj_to_location(obj, &f_zpdesc, &f_objidx);
 	f_offset = offset_in_page(class_size * f_objidx);
-	zspage = get_zspage(zpdesc_page(f_zpdesc));
+	zspage = get_zspage(f_zpdesc);
 
 	vaddr = zpdesc_kmap_atomic(f_zpdesc);
 	link = (struct link_free *)(vaddr + f_offset);
@@ -1507,7 +1507,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_zpdesc(obj, &f_zpdesc);
-	zspage = get_zspage(zpdesc_page(f_zpdesc));
+	zspage = get_zspage(f_zpdesc);
 	class = zspage_class(pool, zspage);
 	spin_lock(&class->lock);
 	read_unlock(&pool->migrate_lock);
@@ -1840,7 +1840,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	__SetPageZsmalloc(zpdesc_page(newzpdesc));
 
 	/* The page is locked, so this pointer must remain valid */
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
 
 	/*
-- 
2.43.0


