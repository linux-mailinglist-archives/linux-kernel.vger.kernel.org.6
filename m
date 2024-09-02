Return-Path: <linux-kernel+bounces-310715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E635B96805C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839A0B227EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3837187FEF;
	Mon,  2 Sep 2024 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXjsatA/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C0B15FA92
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261445; cv=none; b=b+7IzR09VyGJfzUNO+tJveLijJkLxc/0NB19S58G5roxiiLO1MEoYM5BJDKaieh3q0kmNxO/vYGYAWSBIykm2Nz3YvJp0MXiZrC/PFLqedM5HjGDCWT/Hw0TeiFGyOD6S5U80kU9xoZpk9XN9v5CjQIKRcO2C72naLYPyhQTbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261445; c=relaxed/simple;
	bh=5d5O3WmlEwe4HKiK+a7YzCdtF3HLgTzqKDcXKeTJtNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvbURFQuvZtb6Y+6fmgIqe9tkO/0f6Gb5kYscuViq0/IUkvtt8U/SKFJAXZSQj4ZJtIgBeubLioqjvbfl1hpGRPY8TfIR2QNu+p7irEyzq3c5GUzYZFc/dlNsQLXiNQiSOJ9rYDJ0GvCJEgE8sRVIZHKo7dpllVS0r8xCFcDLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXjsatA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC57C4CEC9;
	Mon,  2 Sep 2024 07:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261445;
	bh=5d5O3WmlEwe4HKiK+a7YzCdtF3HLgTzqKDcXKeTJtNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXjsatA/b+bhLB5tHwCAiwV9pwnZATA6bAxMquy1hdL0LTxEf+G8D8b14lHW4PpbA
	 YCLIrtwj9QXxUugNM0EKIeD4C5K/78gOBane3bfpBjUBmWXw40jJbTHEZGGyShhWtE
	 a+OLLpl14bHKuvWxt+6wkxNlOTZg0oeM/kzbgkP2bXfa5YfwkdT0bHCLWPzBBXBTYM
	 bY9oCR7Z8pWjz7hOpbswP+6qh7eAVoHu9J7os3pkqWqR8j2vllzd0uD0RFTmr6iLW6
	 3TAImOXHbZFvxvvi0yyL8lHiQSwH7gMFC9Nx50eEFSXu2sFl51dpXJ+o5Ba5b5mgh4
	 PRgEY1VF82sGQ==
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
Subject: [PATCH v7 15/21] mm/zsmalloc: convert get_zspage() to take zpdesc
Date: Mon,  2 Sep 2024 15:21:26 +0800
Message-ID: <20240902072136.578720-16-alexs@kernel.org>
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

Now that all users except get_next_page() (which will be removed in
later patch) use zpdesc, convert get_zspage() to take zpdesc instead
of page.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index aeb8cab5767b..d9251450ec60 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -767,9 +767,9 @@ static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 	return newfg;
 }
 
-static struct zspage *get_zspage(struct page *page)
+static struct zspage *get_zspage(struct zpdesc *zpdesc)
 {
-	struct zspage *zspage = (struct zspage *)page_private(page);
+	struct zspage *zspage = zpdesc->zspage;
 
 	BUG_ON(zspage->magic != ZSPAGE_MAGIC);
 	return zspage;
@@ -777,7 +777,7 @@ static struct zspage *get_zspage(struct page *page)
 
 static struct page *get_next_page(struct page *page)
 {
-	struct zspage *zspage = get_zspage(page);
+	struct zspage *zspage = get_zspage(page_zpdesc(page));
 
 	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
@@ -787,7 +787,7 @@ static struct page *get_next_page(struct page *page)
 
 static struct zpdesc *get_next_zpdesc(struct zpdesc *zpdesc)
 {
-	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
+	struct zspage *zspage = get_zspage(zpdesc);
 
 	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
@@ -837,7 +837,7 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 				 unsigned long *phandle)
 {
 	unsigned long handle;
-	struct zspage *zspage = get_zspage(zpdesc_page(zpdesc));
+	struct zspage *zspage = get_zspage(zpdesc);
 
 	if (unlikely(ZsHugePage(zspage))) {
 		VM_BUG_ON_PAGE(!is_first_zpdesc(zpdesc), zpdesc_page(zpdesc));
@@ -1252,7 +1252,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 
 	/*
 	 * migration cannot move any zpages in this zspage. Here, class->lock
@@ -1302,7 +1302,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
@@ -1466,7 +1466,7 @@ static void obj_free(int class_size, unsigned long obj)
 
 	obj_to_location(obj, &f_zpdesc, &f_objidx);
 	f_offset = offset_in_page(class_size * f_objidx);
-	zspage = get_zspage(zpdesc_page(f_zpdesc));
+	zspage = get_zspage(f_zpdesc);
 
 	vaddr = zpdesc_kmap_atomic(f_zpdesc);
 	link = (struct link_free *)(vaddr + f_offset);
@@ -1500,7 +1500,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_zpdesc(obj, &f_zpdesc);
-	zspage = get_zspage(zpdesc_page(f_zpdesc));
+	zspage = get_zspage(f_zpdesc);
 	class = zspage_class(pool, zspage);
 	spin_lock(&class->lock);
 	read_unlock(&pool->migrate_lock);
@@ -1833,7 +1833,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	__SetPageZsmalloc(zpdesc_page(newzpdesc));
 
 	/* The page is locked, so this pointer must remain valid */
-	zspage = get_zspage(zpdesc_page(zpdesc));
+	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
 
 	/*
-- 
2.46.0


