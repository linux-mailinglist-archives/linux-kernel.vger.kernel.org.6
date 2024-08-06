Return-Path: <linux-kernel+bounces-275584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D81B94876D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5585DB24264
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141334437C;
	Tue,  6 Aug 2024 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoXry/KR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5796243ABC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910701; cv=none; b=DEGX3hPmf2HQUTPqUCR+bYs/vCn7KoPKvWoULBmNw5R1IAgeFlcnWZCKVjRGv579NkyZp5ibD49NJUzM+lsvqj5FLgxjXAz306RmHcIKhoYneDg7i/djw/ugjgFnsFpL3dL9Ew2a9rBndz7if9rLsVqSTlc8WoAnEBuH5QiX8JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910701; c=relaxed/simple;
	bh=S9lb/ZM2ddFk5ykU4pBIY4i0BSbXkh97cFi/e+1K9AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKaowldX/iLMGROe7ywTnR+aHZY3v2F6E7kfFc4zoyyFO/vooFi6WWIx3iteAIMhkdM8dfg+fNO7/Hz16rhIW5jS65W8F0e5Y+YwxlhSZJAR+RPEBjf48/ZxwWirspOdm/PAPhAmTSJ3tYqrDwUpOLHNQsLQ+OVfabiQKSQ+0tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoXry/KR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EBCC4AF0B;
	Tue,  6 Aug 2024 02:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910700;
	bh=S9lb/ZM2ddFk5ykU4pBIY4i0BSbXkh97cFi/e+1K9AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FoXry/KRy6McNtYGfI2Z6enXmj2PWAy7b9Lk8XnIwOINqaCLUi2tLUaqmmtgbrpG/
	 MxbLCcc0DyuZARER7WhzK6gSVOwnOsHFc6/RIAwicCSRIGdGeoRD1WcpwBuRgSYNlB
	 kH1juNG7IOd1xdgQDziBMjpAYa4BgcHE3F6FXY4SanlKYCBX8Dg00AfglkRQ9Md6O4
	 lxZENUCGEbNYf4+TLt3zOZ2H3MKXoY9KXp+kd38tme2pa0wo3SFHn68t6XoGliUpbi
	 mfFhW6n+LPNt4zSKnSof8Uoueji5zXnGJ0yBZbj3+XJqo46Rfrfv+PmvZHTQMa1OTC
	 4fc970Hz8u/Hg==
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
Subject: [PATCH v5 07/21] mm/zsmalloc: convert obj_allocated() and related helpers to use zpdesc
Date: Tue,  6 Aug 2024 10:22:54 +0800
Message-ID: <20240806022311.3924442-8-alexs@kernel.org>
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

Convert obj_allocated(), and related helpers to take zpdesc. Also make
its callers to cast (struct page *) to (struct zpdesc *) when calling them.
The users will be converted gradually as there are many.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 33a4f7d026e3..3c1755227706 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -825,15 +825,15 @@ static unsigned long handle_to_obj(unsigned long handle)
 	return *(unsigned long *)handle;
 }
 
-static inline bool obj_allocated(struct page *page, void *obj,
+static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 				 unsigned long *phandle)
 {
 	unsigned long handle;
-	struct zspage *zspage = get_zspage(page);
+	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
 
 	if (unlikely(ZsHugePage(zspage))) {
-		VM_BUG_ON_PAGE(!is_first_page(page), page);
-		handle = page->index;
+		VM_BUG_ON_PAGE(!is_first_zpdesc(zpdesc), zpdesc_page(zpdesc));
+		handle = zpdesc->handle;
 	} else
 		handle = *(unsigned long *)obj;
 
@@ -1583,18 +1583,18 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
  * return handle.
  */
 static unsigned long find_alloced_obj(struct size_class *class,
-				      struct page *page, int *obj_idx)
+				      struct zpdesc *zpdesc, int *obj_idx)
 {
 	unsigned int offset;
 	int index = *obj_idx;
 	unsigned long handle = 0;
-	void *addr = kmap_atomic(page);
+	void *addr = zpdesc_kmap_atomic(zpdesc);
 
-	offset = get_first_obj_offset(page);
+	offset = get_first_obj_offset(zpdesc_page(zpdesc));
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
-		if (obj_allocated(page, addr + offset, &handle))
+		if (obj_allocated(zpdesc, addr + offset, &handle))
 			break;
 
 		offset += class->size;
@@ -1618,7 +1618,7 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 	struct size_class *class = pool->size_class[src_zspage->class];
 
 	while (1) {
-		handle = find_alloced_obj(class, s_page, &obj_idx);
+		handle = find_alloced_obj(class, page_zpdesc(s_page), &obj_idx);
 		if (!handle) {
 			s_page = get_next_page(s_page);
 			if (!s_page)
@@ -1851,7 +1851,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
 					addr += class->size) {
-		if (obj_allocated(page, addr, &handle)) {
+		if (obj_allocated(page_zpdesc(page), addr, &handle)) {
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
-- 
2.43.0


