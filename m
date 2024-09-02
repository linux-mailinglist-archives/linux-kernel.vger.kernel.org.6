Return-Path: <linux-kernel+bounces-310716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D40996805D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9151C21F30
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B301836D5;
	Mon,  2 Sep 2024 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERPokKEV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF02715FA92
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261449; cv=none; b=n+hWSlsobLG5V+k/giI4NTa1MOwwEOUvU+RDDRfLgi315/THfRxb8jMU9c0+4IN/E5vfsnKoX2nO2QPkl9J1oOh3xjpZv+MNIHLABEISzCnU6bCwzbS089b0BcbeTUFX2aXZv60EbpWkWGPsR/5rekovfF7YkXy9/iqglC+C5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261449; c=relaxed/simple;
	bh=JuDze2waT5auO9Z7Ml30M0i2Ht/5hJoDWbD0pOFWjSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwjYlKiRU35iYNDO/mAbY5FYa6aGIz+V+MzMcVBKq+L6RI5cg8PD2f/vtDsBfscMjEa1Re+X8lnL6qsqco9cTz2PUHVvJuABqTF66NUp7yTjQntAlhkz+OSecQyihkP1l4m+BlbpmDBsZWc63OooGVwkAiQKr/8dV40jmRCtwoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERPokKEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99803C4CEC4;
	Mon,  2 Sep 2024 07:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261448;
	bh=JuDze2waT5auO9Z7Ml30M0i2Ht/5hJoDWbD0pOFWjSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERPokKEVB7btxb1uvOqV12Md3j6Hiln/4Oe6BMGQ0KkLLvi6CvWIloMINQAnte7U7
	 elqpjG8Xnkla09nh2xTF0/JOW/ym6N4MKk36KVw3BiAIRpJZ9pcJMC3UsMGtOdlnqI
	 if720f3F4KWiQWy84ic+ZksiAvMwBi1dSI/sAKv7FheYygvZZ+iDYNfsHbex8/h9qJ
	 y/OXCEYiHNDN6tbacLZFXUhsNGNqvdN/w6Y82L/yLEqJP6G69cqslsWgZsIh1UUNOB
	 a8U1Xqnj4M60MqOk0doSkUH2avB5I+3G/EckGtiFPlz4Bh+ZpGMsQK7m4iw2GeKdmj
	 6MeoSLhIzMHxA==
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
Subject: [PATCH v7 16/21] mm/zsmalloc: convert SetZsPageMovable and remove unused funcs
Date: Mon,  2 Sep 2024 15:21:27 +0800
Message-ID: <20240902072136.578720-17-alexs@kernel.org>
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

From: Alex Shi <alexs@kernel.org>

Convert SetZsPageMovable() to use zpdesc, and then remove unused
funcs: get_next_page()/get_first_page()/is_first_page().

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d9251450ec60..3b98daa63ece 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -462,11 +462,6 @@ static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
 	.lock	= INIT_LOCAL_LOCK(lock),
 };
 
-static __maybe_unused int is_first_page(struct page *page)
-{
-	return PagePrivate(page);
-}
-
 static inline bool is_first_zpdesc(struct zpdesc *zpdesc)
 {
 	return PagePrivate(zpdesc_page(zpdesc));
@@ -483,14 +478,6 @@ static inline void mod_zspage_inuse(struct zspage *zspage, int val)
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
@@ -775,16 +762,6 @@ static struct zspage *get_zspage(struct zpdesc *zpdesc)
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
@@ -1957,13 +1934,13 @@ static void init_deferred_free(struct zs_pool *pool)
 
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
2.46.0


