Return-Path: <linux-kernel+bounces-243904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B46929C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A0E1C21461
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0014A8F;
	Mon,  8 Jul 2024 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLZIVCAc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA1E3BBE9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420181; cv=none; b=rhXxZstmKQRKgeaYT3Q5y7uAv2DJV86TlUBDVv6E+PQVFUMo7kA+c9iIo/KyJl2iruakuzTegZfdKJtXY4upfBxVntsZb9WtGVDehmfEjNqxDpr/DESz8u8Yn28cQJ89Wwc/d/f3aO69YIwleUH4ivDkMJ+VzM0hmSJyyB3U9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420181; c=relaxed/simple;
	bh=TaGzviLe6NGcMCDjFOvP7sDnEJpuSU1XTpwZAcepYDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhUdRb9Qnhz07oDYH1eh0NU1juT38P6ff53mp0ac3yJvWFJy9H+mUy2/iuzQC1pLPbWBu2al3bCUWO839hqt6DpIe5jChne2zCSk4dscwo9dMtOOlMkA4avShHhqumhXER+jvPGqHj/xC9i1oyCZW1KPqP/BykMCYHYdsSQFpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLZIVCAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E712BC4AF0C;
	Mon,  8 Jul 2024 06:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420181;
	bh=TaGzviLe6NGcMCDjFOvP7sDnEJpuSU1XTpwZAcepYDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLZIVCAcwi0LP6n9+0RZBSXSigP2dfRTuOADXKXuWbgBCN0En57eYC5RSgs/1KtfS
	 DVIzAun5YHyUuQoBUGzwuDYGBBdNZwNvpM+rRFJ6VWSjPUG5CpnTMp5A1yDpyc7vD2
	 WP+uhvZep47BARC5c9jpTlVqf0y7Kz7D+Yq3L4MDQ86P1RuxQXIXTqAIQcgXDvnzwg
	 UtAPWYZA9ek8HVwniRE5UU8dKYGfnTrePnKl8DCQDiV1Udgp7vk+n46IaoL/PkmIeF
	 Z5YaezCR7ig33vTKcfrPcYHW37YL2UrMeTFdY3VPVBc3XwPwXe7fFLu9rM4tcZy960
	 NbRxZc64HmFyA==
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
Subject: [PATCH v3 16/20] mm/zsmalloc: convert SetZsPageMovable and remove unused funcs
Date: Mon,  8 Jul 2024 14:33:37 +0800
Message-ID: <20240708063344.1096626-17-alexs@kernel.org>
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

From: Alex Shi (Tencent) <alexs@kernel.org>

Convert SetZsPageMovable() to use zpdesc, and then remove unused
funcs:get_next_page/get_first_page/is_first_page.

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zsmalloc.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 458ad696b473..8b713ac03902 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -468,11 +468,6 @@ static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
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
@@ -489,14 +484,6 @@ static inline void mod_zspage_inuse(struct zspage *zspage, int val)
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
@@ -787,16 +774,6 @@ static struct zspage *get_zspage(struct zpdesc *zpdesc)
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
@@ -1970,13 +1947,13 @@ static void init_deferred_free(struct zs_pool *pool)
 
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


