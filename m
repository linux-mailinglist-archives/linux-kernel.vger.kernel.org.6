Return-Path: <linux-kernel+bounces-238808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365CA9250E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80256B286C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB7E13D2BE;
	Wed,  3 Jul 2024 04:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwygWuGt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4E13D282
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979280; cv=none; b=o2Mn2maVp2ud6DUaiEOPlIk6IM7sGKLGMN7zWwXdMT/ZZK5//GnCqdPhJhjhWEWledkyfNmlop7ONlqfVh42usJIh8VH/26yc1uuWsxanY7/OnVnZMMGhBmntHoouVXHx07v2SSoMWrLdA/c121syzDE1cpnCDX7N9QJx/VlwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979280; c=relaxed/simple;
	bh=ezRZsoVNxvO9p/Es1oKbiCO8zRXU9uaLAm4pSSvGkg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltkKrivr8V9aDIM8I3kquJTolYgclSSbgKQSu6DJYSl82W0bCaJkDZqjULPJTZtQu1IvrmGj967d4WddlzhYm88Y4EbkKz6LFPBVvpjnMpKIqe6L0Q1Uvu/UwVP/YAgK+5LZlgGEoWSQKVrHtWQROSGn1lYOxdmR5bL3o161bJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwygWuGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3EBC4AF0B;
	Wed,  3 Jul 2024 04:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979279;
	bh=ezRZsoVNxvO9p/Es1oKbiCO8zRXU9uaLAm4pSSvGkg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwygWuGtgKvxgwB10GWVsnz/3isUS/MQMC9Xy3wCXH3LbpIlnFGgsLTVo3vhpbFji
	 FiO84usSj+i0Ez8oI8g3tH5PlCJBj++GLnlkjKGdY3AV/8Dp+4wCx9PohogcDNjlzP
	 b4ybo55igdo98aSZFekjv6ZYFaH4LyyZwRORJ+/EQx+nW04btD9BvbObiSkwN2RLn0
	 3YT1WOS/2mpQWRedGerzZOzYsLU5SXoRzJkQZ3Oqj52OdO3t8zXCsVNdp2h+YlWxZk
	 NZvdf+VxMWPVrpM043z+zyIpla47SpmiLILg43uwi2uQvkL9w9ZffuwQu96pQye/yF
	 uOlDeyIXvkq3Q==
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
Subject: [PATCH v2 03/20] mm/zsmalloc: convert __zs_map_object/__zs_unmap_object to use zpdesc
Date: Wed,  3 Jul 2024 12:05:53 +0800
Message-ID: <20240703040613.681396-4-alexs@kernel.org>
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


