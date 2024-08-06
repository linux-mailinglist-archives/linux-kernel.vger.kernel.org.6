Return-Path: <linux-kernel+bounces-275580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACAA948769
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658C22861A9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D1C2C6A3;
	Tue,  6 Aug 2024 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9bMfZD/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281CC2B9C6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910686; cv=none; b=EH3RJ5lgHLMP7nMoRs8I6Vv7/k04yiLosAhZqwCLYI8bB96u5pjFkRgv6MK0ji2HLP6qaTOZZKOb1NQzV8vWIQU6CkHnPmXgKNq2B4qXNQaiO1IXZjw7d/wxSSWldW+ydOUmCSx8vWY1JrVJV0BMMqsuIGYcdhhQWm7sGdYVR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910686; c=relaxed/simple;
	bh=rMm13SX4aLf3oZ/lBmcjJeeV3CGO+2RCAQN5DP+xGmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZZD9GUG4U9WPtZh48jcRz7exOzz8Mc0jOjgDpF4IjTAo89a+kiGeaeBB/PED19PIWMntKlhjM1I2sdQmwknBKnExc2tYSgpSBuxydE+D5LdBpPy3bLivRqorccd2D95nIqRUHaey0Jrfbp0nr5lpOhGlKbL4+UmTZ8H8SWkWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9bMfZD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD578C32782;
	Tue,  6 Aug 2024 02:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910686;
	bh=rMm13SX4aLf3oZ/lBmcjJeeV3CGO+2RCAQN5DP+xGmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9bMfZD/5HIEGcjAndQ/lypfE4f+loM6ikbINUx7e4ZVxqmabtcM3IJIvPbKyohqh
	 R0lCElOP1IqSvv4eN2T5KrP+x7QIi/l/v+tKP2fas0PoG5toYLpB4I8hyrj3HHzO4l
	 i3LfF0/shOAC/fAypNubA8AmCHtevJ6wxFiamGL7VuIWUQzJUzakpEWwkMwS6V270S
	 6YI85bUWbzpkTNsuW+b7q0KKgWs4xbBRXMUf/5dTRjxYEjlzTdU1434myFq2/48qy8
	 9UhQf2lLEHTOM1xIgk/f1Tgn8WKUcPUokYFcZtIK4WiIPOvpjGiU92Bq4SJtbV7Sl1
	 uNm1Wpab5IGyw==
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
Subject: [PATCH v5 03/21] mm/zsmalloc: convert __zs_map_object/__zs_unmap_object to use zpdesc
Date: Tue,  6 Aug 2024 10:22:50 +0800
Message-ID: <20240806022311.3924442-4-alexs@kernel.org>
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


