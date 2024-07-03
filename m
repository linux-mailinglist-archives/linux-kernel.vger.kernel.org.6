Return-Path: <linux-kernel+bounces-238823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF597925108
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05101B2B8B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD59173355;
	Wed,  3 Jul 2024 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPsY0Brd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C38383B1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979330; cv=none; b=itzv8LVVLYIcE6M/Avv4TtKNWxrH9PHIroTq1qN30xMARW6U1iuGY+/d1wRd2Wb3hfGd4Mhn7362T6P2O/BG+NMPUEF+RqE+L+1rcHkljYHLzsDJGBS2m/JijSdPjJTJxPDkdj+1wCKyPc/saBOjIfMhW7Mv6l7UonA3mTo5Myg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979330; c=relaxed/simple;
	bh=uH0rZNnpHFMljEmSyKQuSSlLph2dNP0xTWvseJvNDaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnS+4vlF/RwNK7DhdeNVgCB8KPKwpC+Z1lDIXstI8Rg5ggxDnpLaraxyrLRsqp/E1I6TsOa+n3m7WeTqAcgdSvI0Pe0+fZ3rMBE+ZJ+CyyRtlK0SoLfWJGaS3Yevx14lH5hhfqNs7Nnh/RFEkwfON6p0KriH8gK2tUkXOP8OF84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPsY0Brd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E17BC4AF0A;
	Wed,  3 Jul 2024 04:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979330;
	bh=uH0rZNnpHFMljEmSyKQuSSlLph2dNP0xTWvseJvNDaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPsY0Brd5KWtyIOk5fV/0otAMuF46d4KG5B5pddwxSDNlJ1E0cbaAnUHd208Zws0d
	 9GHVhVF88u6OFKosO7B9jELp3CHwrLGdn4h4C4xb34PtLyYwVbQV+IsjoAXADnV9j9
	 ZffY97ScQAwMreWa3NmKgcpzng+WKLp1IgAjr1hdxnh4yioFj0tdWX3klI0o5/wT3s
	 XSD0p939k4/5df5GCsmd/HriGXYfyFLk0zojxelaHRW2zZ1egLtRTBjYri2bNAjJLG
	 3ywNEDpuwtzOPd+oo+1gxRI63Ppyldz7y+1CeuJAmASlFlF6pBtMSPY1r+x5RnQZg2
	 zkf3T4L1vs6PA==
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
Subject: [PATCH v2 16/20] mm/zsmalloc: convert SetZsPageMovable and remove unused funcs
Date: Wed,  3 Jul 2024 12:06:06 +0800
Message-ID: <20240703040613.681396-17-alexs@kernel.org>
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

From: Alex Shi <alexs@kernel.org>

Convert SetZsPageMovable() to use zpdesc, and then remove unused
funcs:get_next_page/get_first_page/is_first_page.

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
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


