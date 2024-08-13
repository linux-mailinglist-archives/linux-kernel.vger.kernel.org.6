Return-Path: <linux-kernel+bounces-284357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C05695002A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBBA2855E0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360D819B589;
	Tue, 13 Aug 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgfTSlvZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5E19B3EE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538529; cv=none; b=B1PLHoL6szQMOxYqwCUScSxKA9pLZlDsSufrRYCcRr23U3+W7uOh5T0OmQLlWmygzzSzKq9lffZl+hfFULqVajcjMnH8nIznVB5/l1odNkY4K1pMGIdnRQRVfPWcueM8i/S0/Tgj9phwTGMkACrvFBw7GuYfQ2IXrmMDnud/wCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538529; c=relaxed/simple;
	bh=gQaMHcDtxoBXgRT3p7vOtyKNFbzrfkZ7CKreedzRtjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2keYA+cl8hnZc7165NXF8a97scIXEtATMBtD4DBhoVMtfnPC13Sh3wNZQhuj3wMm7DviNRfumd3jIBiBblW4nCbJl1ievUlW0ArYmdyLcOmxmc7Xmq20QCvZTVrUEuSFuHq8K1HgJnM1qP7vQmMwFf2JGG9hu7PtunbYTEc7jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgfTSlvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE86FC4AF13;
	Tue, 13 Aug 2024 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538529;
	bh=gQaMHcDtxoBXgRT3p7vOtyKNFbzrfkZ7CKreedzRtjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgfTSlvZRX5rj4F+je0IgQVoumPPB1HFUsceRotVPVhoikowdDEW0P2qObUTYI398
	 gR1/EIMADa8MqSXujMKyHg/EExmLFsocPWJg6SoEbAOwiulDmKDAQOclW/XRzGG0uC
	 KpWTOdWx2HgFPAywG6qxV7VN5PH3agkB+nina86PjV5/5qTIA7ebSafJN3QNkipVW5
	 AUs2ctwy+2+ZBzAftUKxISXseq9T18Wg5QL6U8S+DU1CjGcZJJOMb1wab8R8Mn1GEb
	 IzCYbHJRKIqxQVx1HPqmCnGxr5TG8ZZr16pysTaSatTJE36v7R6CxlKYcdWuIyKVIE
	 HNnVoo5DzUppA==
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
Subject: [PATCH v6 16/21] mm/zsmalloc: convert SetZsPageMovable and remove unused funcs
Date: Tue, 13 Aug 2024 16:46:02 +0800
Message-ID: <20240813084611.4122571-17-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813084611.4122571-1-alexs@kernel.org>
References: <20240813084611.4122571-1-alexs@kernel.org>
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
index 5e96ff2ee0d4..e2b203db192a 100644
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
@@ -781,16 +768,6 @@ static struct zspage *get_zspage(struct zpdesc *zpdesc)
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
@@ -1964,13 +1941,13 @@ static void init_deferred_free(struct zs_pool *pool)
 
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


