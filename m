Return-Path: <linux-kernel+bounces-310703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2358996804E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBEE1F249B4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA5F1714AF;
	Mon,  2 Sep 2024 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwc3Rqz3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A202317F505
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261403; cv=none; b=qXGR7t9AQmZW0VdCtDE8z+4du82MaJdDtLdW+s8wCkG368lUQerSuxu6rIKSdxG+CUKJvpPH/bskyYHsdas/xglIKyY9CiUa6AQ17WknoZFREUzh3+AvqXoZvLSPIBSethr1Yk0EacrnNkSCGj3034thKUeXUm3wwv//IwobI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261403; c=relaxed/simple;
	bh=WINuZGeFx9tI8KdY19QN4OBBU7X+cSgJrgZBdb4m5I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpXI/kJmZrkOZmOsxaXYRc4IHL8HscKoNld2nA1QLUQQGkhNixaIXP6O30P0fvhN4SA7/etYl7WmUKHi8b8LUztLczDnufYbSx8hoBLSDAKhvcjXLYwSGj1pBqj3HfLjLIqWmHGORbUrOMjIXpICkg/MJ+UWoQ//xEH6n+Kvj6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hwc3Rqz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72301C4CEC9;
	Mon,  2 Sep 2024 07:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261403;
	bh=WINuZGeFx9tI8KdY19QN4OBBU7X+cSgJrgZBdb4m5I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hwc3Rqz3ixvX3jviF7KczOLII9qkX8ppPQNRek7rHhU8uwwExWu9TBfPEG0Z+d9b5
	 d1gtCEaQNeEsMRzGfr7gUwCFA1q0jlki4TeEvvDrJaXFnyrwiK2qkSTY3NscwUMmFL
	 V8YeGKG+79ICG94273EdMqDP7cIBali7OEv5KU2y8SpOdC0m5Pv93IVlaBBvAg8goK
	 VDA0Cp+KGinMewjf5gDY3forURqjs1gT8nJ/EqzDzoFaz7AGVA7wePPX69MVBXyFVf
	 2/az9VA4ty2O5MCtt+zhpVcXthqY6Zq0BoyOOC85PHRjAG4EtRmvCtTYtqX4D5aW+P
	 HNBJVQlZhwv/Q==
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
Subject: [PATCH v7 03/21] mm/zsmalloc: convert __zs_map_object/__zs_unmap_object to use zpdesc
Date: Mon,  2 Sep 2024 15:21:14 +0800
Message-ID: <20240902072136.578720-4-alexs@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902072136.578720-1-alexs@kernel.org>
References: <20240902072136.578720-1-alexs@kernel.org>
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
index 9806b1629880..1b49f74fd728 100644
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
@@ -1054,7 +1059,7 @@ static inline void __zs_cpu_down(struct mapping_area *area)
 }
 
 static void *__zs_map_object(struct mapping_area *area,
-			struct page *pages[2], int off, int size)
+			struct zpdesc *zpdescs[2], int off, int size)
 {
 	int sizes[2];
 	void *addr;
@@ -1071,10 +1076,10 @@ static void *__zs_map_object(struct mapping_area *area,
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
@@ -1082,7 +1087,7 @@ static void *__zs_map_object(struct mapping_area *area,
 }
 
 static void __zs_unmap_object(struct mapping_area *area,
-			struct page *pages[2], int off, int size)
+			struct zpdesc *zpdescs[2], int off, int size)
 {
 	int sizes[2];
 	void *addr;
@@ -1101,10 +1106,10 @@ static void __zs_unmap_object(struct mapping_area *area,
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
 
@@ -1245,7 +1250,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	pages[1] = get_next_page(page);
 	BUG_ON(!pages[1]);
 
-	ret = __zs_map_object(area, pages, off, class->size);
+	ret = __zs_map_object(area, (struct zpdesc **)pages, off, class->size);
 out:
 	if (likely(!ZsHugePage(zspage)))
 		ret += ZS_HANDLE_SIZE;
@@ -1280,7 +1285,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 		pages[1] = get_next_page(page);
 		BUG_ON(!pages[1]);
 
-		__zs_unmap_object(area, pages, off, class->size);
+		__zs_unmap_object(area, (struct zpdesc **)pages, off, class->size);
 	}
 	local_unlock(&zs_map_area.lock);
 
-- 
2.46.0


