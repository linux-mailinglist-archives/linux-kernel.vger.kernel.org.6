Return-Path: <linux-kernel+bounces-233303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336C91B54A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CC2280FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AB63C08A;
	Fri, 28 Jun 2024 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnRaB13D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2206F06D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544068; cv=none; b=ZrtmnQZGr7uS9XogIdKAKT1ZIQzepDjb/jb0I9fKOqsGe1zuxzDK+Y8H1qk4a56V7++u/R3L+tI06EMtdvOu3mXJphpvTwLXJii1uFLxPXpHC/7qYw5L9drWZzghvmjDt/zQv/OCtcfthVN1nRNs0tBBNvlyICuiMkxC+D+GAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544068; c=relaxed/simple;
	bh=kldqwAh9cZgKWc/qnQGuGYAkpd0utSr37gCIdaPuGYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSbNL+wAoxKOhUS7yIoD6OqSkQlIN2LwKf/zdeYYFzUXe80yPLs/4AXEvffh7zGl9FCZRvlYBr2d7MgGJ4eeHHesAcw5F8GSsH1TY/XUStqgaEC/gYOlfBwakJyKHxZqAxmOIEY5eIHjif+Ek9t30QK8NowotKjdZ8MU4lI/lvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnRaB13D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41863C116B1;
	Fri, 28 Jun 2024 03:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544068;
	bh=kldqwAh9cZgKWc/qnQGuGYAkpd0utSr37gCIdaPuGYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnRaB13DEdjhJTai8RSwypjifYR0A/D24GZqzbB/taIZOGJfx5ukrATQw9p8OyWzM
	 iAAxQfNiplB4VzN0rtbVW16IMBdZ/RsWZzSYGoCNXE7P0FcRAh0awod5grcab4giG/
	 H9STRRKZnmZoXd6hwu7YPDdhTGj85zNkM/x+g2gmKq3nr/+1Yqa5SxXdBusHA0/gHA
	 gavi3MwMdlDst2QYjmWdcNLkXxzrNsfj+AkN1SOSbDG0fQAH2wr8szA84Zub72pyP6
	 UeXApiZ2X+rmvh2mr8QAuT5tuyHFj2yDnC3+V4z8vxOPqUv+lI8tAvJlryj3mSk/gL
	 rH841R6zzOW+w==
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
Subject: [PATCH 16/20] mm/zsmalloc: convert SetZsPageMovable and remove unused funcs
Date: Fri, 28 Jun 2024 11:11:31 +0800
Message-ID: <20240628031138.429622-17-alexs@kernel.org>
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

From: Alex Shi <alexs@kernel.org>

Convert SetZsPageMovable() to use zpdesc, and then remove unused
funcs:get_next_page/get_first_page/is_first_page.

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c136124adb10..951292dbcae4 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -470,11 +470,6 @@ static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
 	.lock	= INIT_LOCAL_LOCK(lock),
 };
 
-static __maybe_unused int is_first_page(struct page *page)
-{
-	return PagePrivate(page);
-}
-
 static int is_first_zpdesc(struct zpdesc *zpdesc)
 {
 	return PagePrivate(zpdesc_page(zpdesc));
@@ -491,14 +486,6 @@ static inline void mod_zspage_inuse(struct zspage *zspage, int val)
 	zspage->inuse += val;
 }
 
-static inline struct page *get_first_page(struct zspage *zspage)
-{
-	struct page *first_page = zpdesc_page(zspage->first_zpdesc);
-
-	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
-	return first_page;
-}
-
 static struct zpdesc *get_first_zpdesc(struct zspage *zspage)
 {
 	struct zpdesc *first_zpdesc = zspage->first_zpdesc;
@@ -789,16 +776,6 @@ static struct zspage *get_zspage(struct zpdesc *zpdesc)
 	return zspage;
 }
 
-static struct page *get_next_page(struct page *page)
-{
-	struct zspage *zspage = get_zspage(page_zpdesc(page));
-
-	if (unlikely(ZsHugePage(zspage)))
-		return NULL;
-
-	return (struct page *)page->index;
-}
-
 static struct zpdesc *get_next_zpdesc(struct zpdesc *zpdesc)
 {
 	struct zspage *zspage = get_zspage(zpdesc);
@@ -1974,13 +1951,13 @@ static void init_deferred_free(struct zs_pool *pool)
 
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage)
 {
-	struct page *page = get_first_page(zspage);
+	struct zpdesc *zpdesc = get_first_zpdesc(zspage);
 
 	do {
-		WARN_ON(!trylock_page(page));
-		__SetPageMovable(page, &zsmalloc_mops);
-		unlock_page(page);
-	} while ((page = get_next_page(page)) != NULL);
+		WARN_ON(!zpdesc_trylock(zpdesc));
+		__zpdesc_set_movable(zpdesc, &zsmalloc_mops);
+		zpdesc_unlock(zpdesc);
+	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
 }
 #else
 static inline void zs_flush_migration(struct zs_pool *pool) { }
-- 
2.43.0


