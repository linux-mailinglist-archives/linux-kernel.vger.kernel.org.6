Return-Path: <linux-kernel+bounces-223926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92504911A85
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D865281D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081AA16C859;
	Fri, 21 Jun 2024 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dhhurl3c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9616C841
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948558; cv=none; b=d3gqd2x+/KGde7nDrq3gn2F4VduD7As/miHATwYze8hMip44c616fcIyMNyOAXD3ZVCx3C+9/iPJJijtOinuKUdog1X0O6ZhrshuXiCqoeQXLLUZ+oNWS+2zSGMbFY1aoaIBM9Dt/UrLoI0bSd/XP0neoYBeYMpQUpKPPZR+ves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948558; c=relaxed/simple;
	bh=dBoIzS7885VeKezN+gY+kbZ+dCan8vwvmHD8Z0kpVt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hB+eiyQJtLFFCTNzPgsK0uOMck8uRoI/+Aq4Qi5XRsPBl/XfgVhDUxzyFGXMybiConfZUJTg68FHv1JoTTCuKV1Ul33dFmFJbWBGGP49vKzD6VPcZnmXFEpWfZ5lOQCFWSh0NJXg5MDGhcFm5sVKSZ2XXI7J1SrS4MRVeAGLPBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dhhurl3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD57CC4AF07;
	Fri, 21 Jun 2024 05:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948558;
	bh=dBoIzS7885VeKezN+gY+kbZ+dCan8vwvmHD8Z0kpVt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dhhurl3cF4nteYiqCwSt1qwbQI2OTdrwgXN3j6ATVB1DNAHIvWS+c7hY4e16dlN6l
	 SxH+V4eiObBiqu3OQvjRDh3meSyWpVloR2DvITcgYW+xDaMzNhg4rPpvk8Z2qbUtb4
	 vq49YEJnL3gz6HL0yp/KvMpG+g0VlAPTdP7HpqIZQ0OD8X2JBdQtTe/NNaH7aI1jwx
	 GJ6nWcnMBWe+rPxVnrWnC14CZ2CwSkeieja++9ODBJyzCVkpw1/9l3W8N0Y8nViDHj
	 yMR1NaxKkFHtVdXydX5qGU06OsQZdVfO/0FgcSjo+HzwyZVOdr5jm050B9WkbdxTCy
	 Sq5KFiKIWilwA==
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
Subject: [PATCH 11/15] mm/z3fold: use zpdesc in z3fold_alloc
Date: Fri, 21 Jun 2024 13:46:51 +0800
Message-ID: <20240621054658.1220796-12-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621054658.1220796-1-alexs@kernel.org>
References: <20240621054658.1220796-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Convert page to zpdesc in z3fold_alloc func. Since both func use zpdesc
now, we can pass zpdesc to init_z3fold_page().
And introduce zpdesc_trylock helper. This patch could save about 12KB
object file size.

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 29 ++++++++++++++---------------
 mm/zpdesc.h |  5 +++++
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index f164eb4e1139..e780143982c6 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -317,10 +317,9 @@ static inline void free_handle(unsigned long handle, struct z3fold_header *zhdr)
 }
 
 /* Initializes the z3fold header of a newly allocated z3fold page */
-static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
+static struct z3fold_header *init_z3fold_page(struct zpdesc *zpdesc, bool headless,
 					struct z3fold_pool *pool, gfp_t gfp)
 {
-	struct zpdesc *zpdesc = page_zpdesc(page);
 	struct z3fold_header *zhdr = zpdesc_address(zpdesc);
 	struct z3fold_buddy_slots *slots;
 
@@ -1006,7 +1005,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 {
 	int chunks = size_to_chunks(size);
 	struct z3fold_header *zhdr = NULL;
-	struct page *page = NULL;
+	struct zpdesc *zpdesc = NULL;
 	enum buddy bud;
 	bool can_sleep = gfpflags_allow_blocking(gfp);
 
@@ -1030,35 +1029,35 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 				WARN_ON(1);
 				goto retry;
 			}
-			page = virt_to_page(zhdr);
+			zpdesc = page_zpdesc(virt_to_page(zhdr));
 			goto found;
 		}
 		bud = FIRST;
 	}
 
-	page = alloc_page(gfp);
-	if (!page)
+	zpdesc = page_zpdesc(alloc_page(gfp));
+	if (!zpdesc)
 		return -ENOMEM;
 
-	zhdr = init_z3fold_page(page, bud == HEADLESS, pool, gfp);
+	zhdr = init_z3fold_page(zpdesc, bud == HEADLESS, pool, gfp);
 	if (!zhdr) {
-		__free_page(page);
+		__free_page(zpdesc_page(zpdesc));
 		return -ENOMEM;
 	}
 	atomic64_inc(&pool->pages_nr);
 
 	if (bud == HEADLESS) {
-		set_bit(PAGE_HEADLESS, &page->private);
+		set_bit(PAGE_HEADLESS, &zpdesc->zppage_flag);
 		goto headless;
 	}
 	if (can_sleep) {
-		lock_page(page);
-		__SetPageMovable(page, &z3fold_mops);
-		unlock_page(page);
+		zpdesc_lock(zpdesc);
+		__SetPageMovable(zpdesc_page(zpdesc), &z3fold_mops);
+		zpdesc_unlock(zpdesc);
 	} else {
-		WARN_ON(!trylock_page(page));
-		__SetPageMovable(page, &z3fold_mops);
-		unlock_page(page);
+		WARN_ON(!zpdesc_trylock(zpdesc));
+		__SetPageMovable(zpdesc_page(zpdesc), &z3fold_mops);
+		zpdesc_unlock(zpdesc);
 	}
 	z3fold_page_lock(zhdr);
 
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 06cfd33de330..9ead7a452f2a 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -63,6 +63,11 @@ static inline void zpdesc_lock(struct zpdesc *zpdesc)
 	folio_lock(zpdesc_folio(zpdesc));
 }
 
+static inline bool zpdesc_trylock(struct zpdesc *zpdesc)
+{
+	return folio_trylock(zpdesc_folio(zpdesc));
+}
+
 static inline void zpdesc_unlock(struct zpdesc *zpdesc)
 {
 	folio_unlock(zpdesc_folio(zpdesc));
-- 
2.43.0


