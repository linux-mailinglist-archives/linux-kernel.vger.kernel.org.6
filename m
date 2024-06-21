Return-Path: <linux-kernel+bounces-223927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F17911A86
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBAD281462
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666D16D300;
	Fri, 21 Jun 2024 05:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4G9h9IY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C816C863
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948561; cv=none; b=eE9wWnDGZerlUQ6dTmr8fO6LKG2d8iBhYN2j4c28HOWO4SStDqjTbKWLQYri2blcYsWltWMMvYQv3mtm6FNs1xVZGd2H++Md0TPdilkDbJWrYYtEwBcjnxdZ1Jf8jYzYKsvDYN+rCCO/T5AvMoXPaQLK9r3JIwqz5jz8RSi2xcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948561; c=relaxed/simple;
	bh=iUFkTemSK3oMLsI1l/U6UgPholZKLkeww8XRyVLS3YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKo+RfKIE31JxlcNbQrcPygh6WXMFt87sROSRtjkOLOLILEUMH9UlBBxSyhdmUwnLOYiWSdqAFC2c6R3CthmdOwljJoVzcYcLh7a3XRpPPRBldhwTsIYS2NQSAepaZCnJzu52YRe4S3W2j+HNVFOKjtq3zURO54Dzuy1uI5Wpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4G9h9IY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E36C4AF0C;
	Fri, 21 Jun 2024 05:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948561;
	bh=iUFkTemSK3oMLsI1l/U6UgPholZKLkeww8XRyVLS3YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4G9h9IYgL6A+XLLiKLsHlkZMWM8Y9URN+Jrim9l0215wGO1ZYme7D9n+vqXl9EN6
	 oqO7g8axPVPUtW3TSyt5NGMoL4B1OKHE39rXL55GNZTTKfMDZe26DCFXp5qUtogvY7
	 CsT1ieKYR27q6/Z/PjoIv3EestKY3vwZ/8GhzGH39WuwZWauB+SRJHD5KjaojXIJhQ
	 NDJcDxv31lxeL3ysuF6lseIq9ogCnBRYKidgBPlU68L2BTbks1c/rgFD/76b+4Z6Lo
	 eCK4vIu6+ZRcfwnjRu4feZIpSAn1jppqehkqwRuQ0iHMq5t23ZDdAlitNKAMGTgTCF
	 iiOkZLvINvdoA==
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
Subject: [PATCH 12/15] mm/z3fold: use zpdesc in free_z3fold_page and z3fold_free
Date: Fri, 21 Jun 2024 13:46:52 +0800
Message-ID: <20240621054658.1220796-13-alexs@kernel.org>
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

Convert page to zpdesc in free_z3fold_page and its caller z3fold_free,
it could save 430bytes.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index e780143982c6..6283f90d1c22 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -347,11 +347,9 @@ static struct z3fold_header *init_z3fold_page(struct zpdesc *zpdesc, bool headle
 	return zhdr;
 }
 
-/* Resets the struct page fields and frees the page */
-static void free_z3fold_page(struct page *page, bool headless)
+/* Resets the struct zpdesc fields and frees the page */
+static void free_z3fold_page(struct zpdesc *zpdesc, bool headless)
 {
-	struct zpdesc *zpdesc = page_zpdesc(page);
-
 	if (!headless) {
 		zpdesc_lock(zpdesc);
 		__ClearPageMovable(zpdesc_page(zpdesc));
@@ -507,7 +505,7 @@ static void free_pages_work(struct work_struct *w)
 			continue;
 		spin_unlock(&pool->stale_lock);
 		cancel_work_sync(&zhdr->work);
-		free_z3fold_page(zpdesc_page(zpdesc), false);
+		free_z3fold_page(zpdesc, false);
 		cond_resched();
 		spin_lock(&pool->stale_lock);
 	}
@@ -1095,15 +1093,15 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 {
 	struct z3fold_header *zhdr;
-	struct page *page;
+	struct zpdesc *zpdesc;
 	enum buddy bud;
 	bool page_claimed;
 
 	zhdr = get_z3fold_header(handle);
-	page = virt_to_page(zhdr);
-	page_claimed = test_and_set_bit(PAGE_CLAIMED, &page->private);
+	zpdesc = page_zpdesc(virt_to_page(zhdr));
+	page_claimed = test_and_set_bit(PAGE_CLAIMED, &zpdesc->zppage_flag);
 
-	if (test_bit(PAGE_HEADLESS, &page->private)) {
+	if (test_bit(PAGE_HEADLESS, &zpdesc->zppage_flag)) {
 		/* if a headless page is under reclaim, just leave.
 		 * NB: we use test_and_set_bit for a reason: if the bit
 		 * has not been set before, we release this page
@@ -1111,7 +1109,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		 */
 		if (!page_claimed) {
 			put_z3fold_header(zhdr);
-			free_z3fold_page(page, true);
+			free_z3fold_page(zpdesc, true);
 			atomic64_dec(&pool->pages_nr);
 		}
 		return;
@@ -1146,20 +1144,20 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		put_z3fold_header(zhdr);
 		return;
 	}
-	if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
-		clear_bit(PAGE_CLAIMED, &page->private);
+	if (test_and_set_bit(NEEDS_COMPACTING, &zpdesc->zppage_flag)) {
+		clear_bit(PAGE_CLAIMED, &zpdesc->zppage_flag);
 		put_z3fold_header(zhdr);
 		return;
 	}
 	if (zhdr->cpu < 0 || !cpu_online(zhdr->cpu)) {
 		zhdr->cpu = -1;
 		kref_get(&zhdr->refcount);
-		clear_bit(PAGE_CLAIMED, &page->private);
+		clear_bit(PAGE_CLAIMED, &zpdesc->zppage_flag);
 		do_compact_page(zhdr, true);
 		return;
 	}
 	kref_get(&zhdr->refcount);
-	clear_bit(PAGE_CLAIMED, &page->private);
+	clear_bit(PAGE_CLAIMED, &zpdesc->zppage_flag);
 	queue_work_on(zhdr->cpu, pool->compact_wq, &zhdr->work);
 	put_z3fold_header(zhdr);
 }
-- 
2.43.0


