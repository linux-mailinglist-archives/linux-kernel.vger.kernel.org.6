Return-Path: <linux-kernel+bounces-243891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C955929C2F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0288F1F21AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BD5208AD;
	Mon,  8 Jul 2024 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIFBrxAh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BB01DA5F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420133; cv=none; b=LHoTIxxK90Bck9W8wz+tFYKEyiBGT6exUl1InySMAQXXPuFvEV4c5xH9ju4/LuWJvdEN4BtytO92IEt7ohXFsfGTIgr3rJCZ1dWY1cSE8/BL6d9cMPUwxdSra4CuKo0WFKc7sW15z7t/vFblWq9fnl5xuIJDI88QwrpGQVBx11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420133; c=relaxed/simple;
	bh=tmhg+UoGuxLgiU/lnh0EuqzBHj5JgCLnTFMLR6vDXTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N68G53APX9bWuZjwa+s1poUgJg+NA/Xh9owGVM8cEr/H1gdwnQy7EzRZgo1U5tIyT8TU2pPXrbSXV5tM6iwhbajCQyY3S33I/Jhkz4LGAQiA56eLZDeLIpMXpbWU6ZuYQB5qPblmwnNFkKkobTMLcGfOGJjtXnJAnBGSuLqLARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIFBrxAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC9AC116B1;
	Mon,  8 Jul 2024 06:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420132;
	bh=tmhg+UoGuxLgiU/lnh0EuqzBHj5JgCLnTFMLR6vDXTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIFBrxAh+/uE4yv8Zd7MjpS9ccK07cFXKmfpP6Zay+VljtAK9V1ULuV2jXwDkIedx
	 V715o8OO3VX4wzi3m7mMJYZwfQ+fFFf4QqDMjdcW76M781nHLVnMdsWMQb7d9NaqW7
	 63O+xYhqtBjdx76BJ9dY662CFuFOfHPjOZV81/eUEa5g6yuL+st800m6rL/1u+wORn
	 oVGzoxHA5x+orY+sjaOiWnp3opLoh388Qd+uKplMd6+eVHwHHbWp8cPq5+mzY4eK0w
	 5I98WraI3cj1UYwMg59uY3taov4j525VdhWGHymwEupsZOqr1iHiN88zcvjLqBSmoe
	 nEpSVZXJv0MNw==
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
Subject: [PATCH v3 03/20] mm/zsmalloc: convert __zs_map_object/__zs_unmap_object to use zpdesc
Date: Mon,  8 Jul 2024 14:33:24 +0800
Message-ID: <20240708063344.1096626-4-alexs@kernel.org>
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

These two functions take pointer to an array of struct page. Introduce
zpdesc_kmap_atomic() and make __zs_{map,unmap}_object() take pointer
to an array of zpdesc instead of page.

Add silly type casting when calling them. Casting will be removed late.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zsmalloc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 243677a9c6d2..68a39c233d34 100644
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


