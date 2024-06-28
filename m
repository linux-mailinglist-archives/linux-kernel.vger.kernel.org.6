Return-Path: <linux-kernel+bounces-233294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91FB91B541
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D67281F75
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34797524C4;
	Fri, 28 Jun 2024 03:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsLIVXmX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA0350275
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544035; cv=none; b=K6ZhLr1sfgsHRAORjC+nuPwlCt3jQPo/hwnaoT1qJwkvZdV7Iy/nmL7h4jXKp28wm8Tuzbc/aD1O8ajLZC93ZfAd7LFxg+qoXwqw/L2Ma5Hx6IAhrJpLqEkv34piH0O6L6faAOEkHuW644BjJ2mufaYZ3HE82QQOPDoWfYeFxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544035; c=relaxed/simple;
	bh=6Pm9+ydZIsO5c9qRiniJl+L1KPC6XDYzIyrZkkU9aKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffTp9Htq8n9W8drrmgJCYxmi3AF0354hrYe0+l4Ev3VrnLQx/L7vV3a1MCAeMLXLgquRsDCzUFyf1bowjC0Tug133uxtjgI4UTeOTZhKBjCpVRI36d2uCIZ+Us41XWDTV66UIfjY294FNLzh+8H6xoB74rNQvUG9kxGqMYH+jyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsLIVXmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370D3C2BBFC;
	Fri, 28 Jun 2024 03:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544035;
	bh=6Pm9+ydZIsO5c9qRiniJl+L1KPC6XDYzIyrZkkU9aKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EsLIVXmXFHNSPRxWd3m4+VHHl+VjFRdCHM8BTCvp4ASArnVdJg45eBwEpv1PTcc4+
	 eEJ1NHhHKtGm0C4A8uG2fnOzsLTe/goC7j/F4+vvDSYh3WgGjhkYDVegoswWQD2w4w
	 prk/ypbbDn0J4scwSNmm3arQFeDX6m7bbKum0YUg/hBmQqvW5hthU1GNKPG49VCX5B
	 49mb0ZY9H9gEpbKIwx/47UF2WqV/ndYyAlhSva5OnEzxDIigPsBJWNOxaqEhf5HIGL
	 Lxx2fFFVNA5XFHqBlSh73eJ7YpfzwDn8cAGEfxmnV26rCFrqUT3RiR/gVjKJDXYw9s
	 cStrQQm3EJOJQ==
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
Subject: [PATCH 07/20] mm/zsmalloc: convert obj_allocated() and related helpers to use zpdesc
Date: Fri, 28 Jun 2024 11:11:22 +0800
Message-ID: <20240628031138.429622-8-alexs@kernel.org>
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

Convert obj_allocated(), and related helpers to take zpdesc. Also make
its callers to cast (struct page *) to (struct zpdesc *) when calling them.
The users will be converted gradually as there are many.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index ee890d513f6f..6efaa6279687 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -847,15 +847,15 @@ static unsigned long handle_to_obj(unsigned long handle)
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
 
@@ -1607,18 +1607,18 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
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
@@ -1642,7 +1642,7 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 	struct size_class *class = pool->size_class[src_zspage->class];
 
 	while (1) {
-		handle = find_alloced_obj(class, s_page, &obj_idx);
+		handle = find_alloced_obj(class, page_zpdesc(s_page), &obj_idx);
 		if (!handle) {
 			s_page = get_next_page(s_page);
 			if (!s_page)
@@ -1876,7 +1876,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
 					addr += class->size) {
-		if (obj_allocated(page, addr, &handle)) {
+		if (obj_allocated(page_zpdesc(page), addr, &handle)) {
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
-- 
2.43.0


