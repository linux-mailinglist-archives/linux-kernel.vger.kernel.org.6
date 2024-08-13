Return-Path: <linux-kernel+bounces-284343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4B8950018
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584931F23690
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0F13BC38;
	Tue, 13 Aug 2024 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJgXG5/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E717B427
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538478; cv=none; b=njEkgzRgWFN1UpNbLk9maTL7378AlKz9X61y4Y27/U/ixiIO7W/xWTHhtr2J8lpMo4LQn54HZrWkoN/9ju5WYrKKWMljvsuWFM/TZHktB+pGm9w6NUG3jPuk69BvkP/5HK7hf4r4wedZH1UHft2uqzpRtnhkoekMIo97K/oyS6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538478; c=relaxed/simple;
	bh=rMm13SX4aLf3oZ/lBmcjJeeV3CGO+2RCAQN5DP+xGmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APwSJUJRdl1+lWivwuFoF7BRXUwL86zLyEY7CEr4le7CcJHXFepuafmUbaIRETLdXuqS0Nq+pZdvtK+nATeg29N59v4SiMp7HsknGvIpAmhRHheQWFzA7ynKcld2UYd1pOLGm4KgT+m9qz02qiBkptDvE5ZO87bbLGGOTHNTYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJgXG5/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74FCC4AF0B;
	Tue, 13 Aug 2024 08:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538478;
	bh=rMm13SX4aLf3oZ/lBmcjJeeV3CGO+2RCAQN5DP+xGmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJgXG5/MU5u93XZsl+G9CJ0mZ5Zsa5hW1D87/ECOlkqHb+Sr7/6G9JpU9JSleiaMM
	 jeO2UHtuI8wPWRVqLVhxb3dyjcW8uiCm+Wre+EoFb8xV3wGDYcMFKa9RWetwLmAfpW
	 7wGshauiHkGZQEFx7I7wSWteKnO22jVG7YHziDbs66qRtrx9x/JGYl0r8S9g0dUrhw
	 pe6jnDZAoZToI0zoFrugdc2rA141iOVEivfjDwK26VKKJn39xFkNkKoNQ5vYFHKL5I
	 V1bo7H8J9Swu0EPIh8U+xtQC+GvyGGiBC1koj5PQ+iVCqihCzllNAuur2U0FggB05u
	 phlueemlWNrtw==
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
Subject: [PATCH v6 03/21] mm/zsmalloc: convert __zs_map_object/__zs_unmap_object to use zpdesc
Date: Tue, 13 Aug 2024 16:45:49 +0800
Message-ID: <20240813084611.4122571-4-alexs@kernel.org>
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

These two functions take pointer to an array of struct page. Introduce
zpdesc_kmap_atomic() and make __zs_{map,unmap}_object() take pointer
to an array of zpdesc instead of page.

Add silly type casting when calling them. Casting will be removed late.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 25c90224f21f..b9b5e2824f2c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -243,6 +243,11 @@ struct zs_pool {
 	atomic_t compaction_in_progress;
 };
 
+static inline void *zpdesc_kmap_atomic(struct zpdesc *zpdesc)
+{
+	return kmap_atomic(zpdesc_page(zpdesc));
+}
+
 struct zspage {
 	struct {
 		unsigned int huge:HUGE_BITS;
@@ -1061,7 +1066,7 @@ static inline void __zs_cpu_down(struct mapping_area *area)
 }
 
 static void *__zs_map_object(struct mapping_area *area,
-			struct page *pages[2], int off, int size)
+			struct zpdesc *zpdescs[2], int off, int size)
 {
 	int sizes[2];
 	void *addr;
@@ -1078,10 +1083,10 @@ static void *__zs_map_object(struct mapping_area *area,
 	sizes[1] = size - sizes[0];
 
 	/* copy object to per-cpu buffer */
-	addr = kmap_atomic(pages[0]);
+	addr = zpdesc_kmap_atomic(zpdescs[0]);
 	memcpy(buf, addr + off, sizes[0]);
 	kunmap_atomic(addr);
-	addr = kmap_atomic(pages[1]);
+	addr = zpdesc_kmap_atomic(zpdescs[1]);
 	memcpy(buf + sizes[0], addr, sizes[1]);
 	kunmap_atomic(addr);
 out:
@@ -1089,7 +1094,7 @@ static void *__zs_map_object(struct mapping_area *area,
 }
 
 static void __zs_unmap_object(struct mapping_area *area,
-			struct page *pages[2], int off, int size)
+			struct zpdesc *zpdescs[2], int off, int size)
 {
 	int sizes[2];
 	void *addr;
@@ -1108,10 +1113,10 @@ static void __zs_unmap_object(struct mapping_area *area,
 	sizes[1] = size - sizes[0];
 
 	/* copy per-cpu buffer to object */
-	addr = kmap_atomic(pages[0]);
+	addr = zpdesc_kmap_atomic(zpdescs[0]);
 	memcpy(addr + off, buf, sizes[0]);
 	kunmap_atomic(addr);
-	addr = kmap_atomic(pages[1]);
+	addr = zpdesc_kmap_atomic(zpdescs[1]);
 	memcpy(addr, buf + sizes[0], sizes[1]);
 	kunmap_atomic(addr);
 
@@ -1252,7 +1257,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	pages[1] = get_next_page(page);
 	BUG_ON(!pages[1]);
 
-	ret = __zs_map_object(area, pages, off, class->size);
+	ret = __zs_map_object(area, (struct zpdesc **)pages, off, class->size);
 out:
 	if (likely(!ZsHugePage(zspage)))
 		ret += ZS_HANDLE_SIZE;
@@ -1287,7 +1292,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 		pages[1] = get_next_page(page);
 		BUG_ON(!pages[1]);
 
-		__zs_unmap_object(area, pages, off, class->size);
+		__zs_unmap_object(area, (struct zpdesc **)pages, off, class->size);
 	}
 	local_unlock(&zs_map_area.lock);
 
-- 
2.43.0


