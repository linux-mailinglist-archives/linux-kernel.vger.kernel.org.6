Return-Path: <linux-kernel+bounces-310707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05D968052
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8A5281840
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F75D1865EE;
	Mon,  2 Sep 2024 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAfKDYNX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA6185B7B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261417; cv=none; b=Yo8AKddlPIDQnsS9322aoc+7rCTm4kYkZDKrqYF4NWOIL6hp9JL4VF2YXxs7sHDNs10TP1yidELf7mAxxiIv/N25qLrUwAUHZ0IdPmE2DlYL/sX6LqCvr1Fas+pssJ05CwJzQ4a3HQ4M9XhjDCrZ3yTsnsi11gkHJl9iWQ6iWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261417; c=relaxed/simple;
	bh=Br29/5+PsdLeZ/2tyuIzR5WeYQvl1vCMxw0jQ4y7I0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvlszZXmkdNVymcEQ+nQKcw16H15l3UguM9B2UJZZ6M8f4IXJ1DvLRzMB+90mXuPnJ9y4BQ1nSllclRCOpKgM5EFgI7Xjr4y+sFk0Q0lRkQABr+ECrpRnqxJ8QfVy0qnfjNRbwkLixXyyP+OdcddzTQy/awaszkf12+S8qsKwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAfKDYNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533AAC4CEC8;
	Mon,  2 Sep 2024 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261417;
	bh=Br29/5+PsdLeZ/2tyuIzR5WeYQvl1vCMxw0jQ4y7I0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CAfKDYNXjkGUMjjB3LlqQwolWE5LfDVmqwftcV6wvGJkYybv1hqip4//3RUWCXBE0
	 YopBu9YKpW1ldrbR0e9ShcXXpwmaI6gIc/4ttV2oKrteRG4M1HKS65E20+U+R3o7yM
	 OAltuYv3c4EPwZjcbEtD7NJKJ3LGTe3YNRi3Oa5DHNCXVhHT29BWWzkUcwAuyPHaUG
	 t/uhkkC3MUTgkk3pxWxY+yC6uFQ5ms5l1hG+8G7ElOlF8KBnl1Qga5dNieECRmUhUk
	 4jwlkCj/prBwfMUZYq9Ht59LMc5RBEF9mj17eEC2zhUSdTCdi4syzKXAvjIeSQEr+b
	 d/CkesoRyrHHg==
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
Subject: [PATCH v7 07/21] mm/zsmalloc: convert obj_allocated() and related helpers to use zpdesc
Date: Mon,  2 Sep 2024 15:21:18 +0800
Message-ID: <20240902072136.578720-8-alexs@kernel.org>
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

Convert obj_allocated(), and related helpers to take zpdesc. Also make
its callers to cast (struct page *) to (struct zpdesc *) when calling them.
The users will be converted gradually as there are many.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6afc3e642e02..46d8be5cb4b7 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -833,15 +833,15 @@ static unsigned long handle_to_obj(unsigned long handle)
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
 
@@ -1590,18 +1590,18 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
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
@@ -1625,7 +1625,7 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 	struct size_class *class = pool->size_class[src_zspage->class];
 
 	while (1) {
-		handle = find_alloced_obj(class, s_page, &obj_idx);
+		handle = find_alloced_obj(class, page_zpdesc(s_page), &obj_idx);
 		if (!handle) {
 			s_page = get_next_page(s_page);
 			if (!s_page)
@@ -1858,7 +1858,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
 					addr += class->size) {
-		if (obj_allocated(page, addr, &handle)) {
+		if (obj_allocated(page_zpdesc(page), addr, &handle)) {
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
-- 
2.46.0


