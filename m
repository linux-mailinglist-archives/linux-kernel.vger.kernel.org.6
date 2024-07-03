Return-Path: <linux-kernel+bounces-238812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB949250D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28F3286917
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8737513DDB8;
	Wed,  3 Jul 2024 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE3Mp3iK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5D13DBBD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979295; cv=none; b=c8rvm4IsKUEJHEy1AzGtRBLrKtx09ucmqBzuQnv09MAIrafVEWP+P4RuEfRFMPkGCLiq5ewh2HM4w118XqfFgnlFGimCLnBAqBqfc6IdlJF/RNBwXaAdpLRbOmc2VYy6ixQSWk4/rWmFCDSk3sb92lZPv1nS7XZqgTHSqUygmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979295; c=relaxed/simple;
	bh=82zz9HxUIo/V08TGVJ1E1ZkMfjqggCMIVYH80TRsdU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gj4NoGx3ZxOQFAi7xU6SW1H27Ql+Rzz1jcZ81UrJwhXYWzzXNc4N96p3ZIDOgEi8buofL6cUczjfJarNAjr6PeEjED/WpSLLF27w+2LAY9cacEGQd3K8NPg91u6WrRWetK9ZHb5ZWWGPflbd4nc4B9geeZFSul05LSH8PmK5lNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE3Mp3iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D144C32781;
	Wed,  3 Jul 2024 04:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979295;
	bh=82zz9HxUIo/V08TGVJ1E1ZkMfjqggCMIVYH80TRsdU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PE3Mp3iKrGg+MQDziwiQtLqamfGDcd2BwzU0p66UpdNRzzHqrtP5zJJ9n9wogEL/9
	 P7K8fhmXl4L80J6DnfajNfBWAagd+7MGFej4mxZtsPMEvifMWkC8+EZmgbWyOy0Cwr
	 LLmeNC4OLQaUHi4I0If9evvI/v/cZiITs3kNJWrM8rqSVbiAYS+paY30MeeHGZieo1
	 teIsVLI7MRzFlZhYW9wQutQkrZ+zhLQHFHUYWEcVOqBnkcAUUmd+yvFVqr51dTSUZD
	 bsX/vwbYMqctqwgH4SyV5nxPb1Mib2Lyir1b/Wxfm+yvAeRhSx1GO1BEpiQtU0UJDc
	 oF+pN+0ejOKJg==
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
Subject: [PATCH v2 07/20] mm/zsmalloc: convert obj_allocated() and related helpers to use zpdesc
Date: Wed,  3 Jul 2024 12:05:57 +0800
Message-ID: <20240703040613.681396-8-alexs@kernel.org>
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

Convert obj_allocated(), and related helpers to take zpdesc. Also make
its callers to cast (struct page *) to (struct zpdesc *) when calling them.
The users will be converted gradually as there are many.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index a8f390beeab8..29b9fa5baa46 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -845,15 +845,15 @@ static unsigned long handle_to_obj(unsigned long handle)
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
 
@@ -1603,18 +1603,18 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
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
@@ -1638,7 +1638,7 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 	struct size_class *class = pool->size_class[src_zspage->class];
 
 	while (1) {
-		handle = find_alloced_obj(class, s_page, &obj_idx);
+		handle = find_alloced_obj(class, page_zpdesc(s_page), &obj_idx);
 		if (!handle) {
 			s_page = get_next_page(s_page);
 			if (!s_page)
@@ -1871,7 +1871,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
 					addr += class->size) {
-		if (obj_allocated(page, addr, &handle)) {
+		if (obj_allocated(page_zpdesc(page), addr, &handle)) {
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
-- 
2.43.0


