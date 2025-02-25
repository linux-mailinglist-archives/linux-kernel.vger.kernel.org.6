Return-Path: <linux-kernel+bounces-531751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3689AA4446E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF5517A45B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881A726BDA5;
	Tue, 25 Feb 2025 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1tgJAO4W"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8226E178
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497401; cv=none; b=F7ol9Q5Al9F3YhOaZy1wprVziWoeOr6TRJwB7h3NeAUy6yrE6crjPrmURm6JUPaVYUwDcUta0iOky9H/YdSwJdmmkszP3ZRUDQBS9FEk7U5dQv5tFTF5H8zRPdy58Hmr9w/4l8FPO7TC2tzqCAVsR/2TimoF4sL0HF9RGTMsEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497401; c=relaxed/simple;
	bh=SAtCeGGThvYtyN8fuDzXe+M8ncw+a//ocp2DTg2/S3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RfniiRuaimtIu5wRCUh/xgml4J4b3oMEAxRUgzN1H3nwOR7R6EF72Cbr3lZWoBsjlZpPDlwF3uXikAtNkCAdFrxz4RRNZXvzIdWSN2biTKT0e7HuHNvcpzUO9Y7WS46OmxFv/YtjZxynGZo+20kMt32GbuD1RNH9oiGD5oMv75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1tgJAO4W; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso46034845e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740497397; x=1741102197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nx6t1c8/cloSJvCisk/ifycZ3o4OR3QkzD+SEADwtx8=;
        b=1tgJAO4WGgL+TLxEpeiUqhQvb65N9gBbdwZF6x06YK67LJlTJGAoWsIKA0m1NbtpR7
         cH8LUi5dOw5vleEU98rdD2UFT5t8RMoBPJnMTevkmHBHiKopTX3sfFWWNcrMJxynuOqC
         pN1WmObZCePJENhNfehodIYNQ4AAKrpAwdzeMJRntbFrRFfULJVBxV9H2vQCKgNQILZo
         9xLkfO+sRpeom81O2/UCbEetgaqw0oMsadyHUcbLRQNfAIvfzo0nsQTtCqml0GvnNEnR
         nKEigGOT3XZzkNe4NmXR8zNB/2YzyenRaVGLgH8ZjgkgkauwRk678i7nHa+McmXVtGBT
         qTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497397; x=1741102197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nx6t1c8/cloSJvCisk/ifycZ3o4OR3QkzD+SEADwtx8=;
        b=ljZrCz3kefpPaJYo/gkwKoaqWlylHQ0AJAHG+06y4iRXzzEbNhN1CB10z4Eo+qssgV
         x41WexokNZLvbyZS6mTOOY/cret24gESwgF6R54jw61VmK2OFhSDIUSr0+Fn5wRSfYya
         JDsf7PLEPRpe+zWkBsaGJsDGngBSSTVNu1tt3tdUWY58poOIG8bkpUbpfc/LvmMuf9Od
         /v3HgainF4ZLBsDwsJa+0dl0zOcTZyfvmTq+Qrmq5aZ2leCUWvcY6w4UBtgGcBfTTSxO
         CCigmGaIzr5TBFF9nb2xWHOhsPmND3wizrrMpOvYoBLeSOVCTWwcMRMy1ZKpyLg6D43c
         qgew==
X-Forwarded-Encrypted: i=1; AJvYcCV/qJ/5YsnTRjArDWDhKCmm3JE/TRxTC0K73VICcOoOmC23BOpUalTaa7eVGWNxcooBby9DI75zci3wE7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+/8G9BopsfNe32muXxk2giZ3Xrxc0JvxXmF6BXWTW6YeqIYc
	Kby5UnOkiqsgO9q1N6hBDb/qCuQdgvmhXekiLAqyIebO2+d3mg7B7CtOt5gUWe6VPbN+6tgR92r
	KvrQiFHJj3g==
X-Google-Smtp-Source: AGHT+IGn32bsk1prP4wPiO8UR6qaQxLW4dASvWo6m65ubj1QAEwH4BO/I8DvVEW43uBjNISApDxTFJ0VJ+OChw==
X-Received: from wmsd4.prod.google.com ([2002:a05:600c:3ac4:b0:439:5fab:db0f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e18:b0:439:a1f2:50a3 with SMTP id 5b1f17b1804b1-439af0d503dmr150580675e9.4.1740497397567;
 Tue, 25 Feb 2025 07:29:57 -0800 (PST)
Date: Tue, 25 Feb 2025 15:29:48 +0000
In-Reply-To: <20250225-clarify-steal-v3-0-f2550ead0139@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225-clarify-steal-v3-0-f2550ead0139@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250225-clarify-steal-v3-1-f2550ead0139@google.com>
Subject: [PATCH v3 1/2] mm/page_alloc: Clarify terminology in migratetype
 fallback code
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

This code is rather confusing because:

 1. "Steal" is sometimes used to refer to the general concept of
    allocating from a from a block of a fallback migratetype
    (steal_suitable_fallback()) but sometimes it refers specifically to
    converting a whole block's migratetype (can_steal_fallback()).

 2. can_steal_fallback() sounds as though it's answering the question "am
    I functionally permitted to allocate from that other type" but in
    fact it is encoding a heuristic preference.

 3. The same piece of data has different names in different places:
    can_steal vs whole_block. This reinforces point 2 because it looks
    like the different names reflect a shift in intent from "am I
    allowed to steal" to "do I want to steal", but no such shift exists.

Fix 1. by avoiding the term "steal" in ambiguous contexts. Start using
the term "claim" to refer to the special case of stealing the entire
block.

Fix 2. by using "should" instead of "can", and also rename its
parameters and add some commentary to make it more explicit what they
mean.

Fix 3. by adopting the new "claim" terminology universally for this
set of variables.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/compaction.c |  4 ++--
 mm/internal.h   |  2 +-
 mm/page_alloc.c | 72 ++++++++++++++++++++++++++++-----------------------------
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 0992106d4ea751f7f1f8ebf7c75cd433d676cbe0..550ce50218075509ccb5f9485fd84f5d1f3d23a7 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2333,7 +2333,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 	ret = COMPACT_NO_SUITABLE_PAGE;
 	for (order = cc->order; order < NR_PAGE_ORDERS; order++) {
 		struct free_area *area = &cc->zone->free_area[order];
-		bool can_steal;
+		bool claim_block;
 
 		/* Job done if page is free of the right migratetype */
 		if (!free_area_empty(area, migratetype))
@@ -2350,7 +2350,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 		 * other migratetype buddy lists.
 		 */
 		if (find_suitable_fallback(area, order, migratetype,
-						true, &can_steal) != -1)
+						true, &claim_block) != -1)
 			/*
 			 * Movable pages are OK in any pageblock. If we are
 			 * stealing for a non-movable allocation, make sure
diff --git a/mm/internal.h b/mm/internal.h
index b07550db2bfd1d152fa90f91b3687b0fa1a9f653..aa30282a774ae26349944a75da854ae6a3da2a98 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -863,7 +863,7 @@ static inline void init_cma_pageblock(struct page *page)
 
 
 int find_suitable_fallback(struct free_area *area, unsigned int order,
-			int migratetype, bool only_stealable, bool *can_steal);
+			int migratetype, bool claim_only, bool *claim_block);
 
 static inline bool free_area_empty(struct free_area *area, int migratetype)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5d8e274c8b1d500d263a17ef36fe190f60b88196..5e694046ef92965b34d4831e96d92f02681a8b45 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1942,22 +1942,22 @@ static inline bool boost_watermark(struct zone *zone)
 
 /*
  * When we are falling back to another migratetype during allocation, try to
- * steal extra free pages from the same pageblocks to satisfy further
- * allocations, instead of polluting multiple pageblocks.
+ * claim entire blocks to satisfy further allocations, instead of polluting
+ * multiple pageblocks.
  *
- * If we are stealing a relatively large buddy page, it is likely there will
- * be more free pages in the pageblock, so try to steal them all. For
- * reclaimable and unmovable allocations, we steal regardless of page size,
- * as fragmentation caused by those allocations polluting movable pageblocks
- * is worse than movable allocations stealing from unmovable and reclaimable
- * pageblocks.
+ * If we are stealing a relatively large buddy page, it is likely there will be
+ * more free pages in the pageblock, so try to claim the whole block. For
+ * reclaimable and unmovable allocations, we claim the whole block regardless of
+ * page size, as fragmentation caused by those allocations polluting movable
+ * pageblocks is worse than movable allocations stealing from unmovable and
+ * reclaimable pageblocks.
  */
-static bool can_steal_fallback(unsigned int order, int start_mt)
+static bool should_claim_block(unsigned int order, int start_mt)
 {
 	/*
 	 * Leaving this order check is intended, although there is
 	 * relaxed order check in next check. The reason is that
-	 * we can actually steal whole pageblock if this condition met,
+	 * we can actually claim the whole pageblock if this condition met,
 	 * but, below check doesn't guarantee it and that is just heuristic
 	 * so could be changed anytime.
 	 */
@@ -1970,7 +1970,7 @@ static bool can_steal_fallback(unsigned int order, int start_mt)
 	 * reclaimable pages that are closest to the request size.  After a
 	 * while, memory compaction may occur to form large contiguous pages,
 	 * and the next movable allocation may not need to steal.  Unmovable and
-	 * reclaimable allocations need to actually steal pages.
+	 * reclaimable allocations need to actually claim the whole block.
 	 */
 	if (order >= pageblock_order / 2 ||
 		start_mt == MIGRATE_RECLAIMABLE ||
@@ -1983,12 +1983,14 @@ static bool can_steal_fallback(unsigned int order, int start_mt)
 
 /*
  * Check whether there is a suitable fallback freepage with requested order.
- * If only_stealable is true, this function returns fallback_mt only if
- * we can steal other freepages all together. This would help to reduce
+ * Sets *claim_block to instruct the caller whether it should convert a whole
+ * pageblock to the returned migratetype.
+ * If only_claim is true, this function returns fallback_mt only if
+ * we would do this whole-block claiming. This would help to reduce
  * fragmentation due to mixed migratetype pages in one pageblock.
  */
 int find_suitable_fallback(struct free_area *area, unsigned int order,
-			int migratetype, bool only_stealable, bool *can_steal)
+			int migratetype, bool only_claim, bool *claim_block)
 {
 	int i;
 	int fallback_mt;
@@ -1996,19 +1998,16 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 	if (area->nr_free == 0)
 		return -1;
 
-	*can_steal = false;
+	*claim_block = false;
 	for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
 		fallback_mt = fallbacks[migratetype][i];
 		if (free_area_empty(area, fallback_mt))
 			continue;
 
-		if (can_steal_fallback(order, migratetype))
-			*can_steal = true;
+		if (should_claim_block(order, migratetype))
+			*claim_block = true;
 
-		if (!only_stealable)
-			return fallback_mt;
-
-		if (*can_steal)
+		if (*claim_block || !only_claim)
 			return fallback_mt;
 	}
 
@@ -2016,14 +2015,14 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 }
 
 /*
- * This function implements actual steal behaviour. If order is large enough, we
- * can claim the whole pageblock for the requested migratetype. If not, we check
- * the pageblock for constituent pages; if at least half of the pages are free
- * or compatible, we can still claim the whole block, so pages freed in the
- * future will be put on the correct free list.
+ * This function implements actual block claiming behaviour. If order is large
+ * enough, we can claim the whole pageblock for the requested migratetype. If
+ * not, we check the pageblock for constituent pages; if at least half of the
+ * pages are free or compatible, we can still claim the whole block, so pages
+ * freed in the future will be put on the correct free list.
  */
 static struct page *
-try_to_steal_block(struct zone *zone, struct page *page,
+try_to_claim_block(struct zone *zone, struct page *page,
 		   int current_order, int order, int start_type,
 		   int block_type, unsigned int alloc_flags)
 {
@@ -2091,11 +2090,12 @@ try_to_steal_block(struct zone *zone, struct page *page,
 /*
  * Try finding a free buddy page on the fallback list.
  *
- * This will attempt to steal a whole pageblock for the requested type
+ * This will attempt to claim a whole pageblock for the requested type
  * to ensure grouping of such requests in the future.
  *
- * If a whole block cannot be stolen, regress to __rmqueue_smallest()
- * logic to at least break up as little contiguity as possible.
+ * If a whole block cannot be claimed, steal an individual page, regressing to
+ * __rmqueue_smallest() logic to at least break up as little contiguity as
+ * possible.
  *
  * The use of signed ints for order and current_order is a deliberate
  * deviation from the rest of this file, to make the for loop
@@ -2112,7 +2112,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	int min_order = order;
 	struct page *page;
 	int fallback_mt;
-	bool can_steal;
+	bool claim_block;
 
 	/*
 	 * Do not steal pages from freelists belonging to other pageblocks
@@ -2131,15 +2131,15 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 				--current_order) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
-				start_migratetype, false, &can_steal);
+				start_migratetype, false, &claim_block);
 		if (fallback_mt == -1)
 			continue;
 
-		if (!can_steal)
+		if (!claim_block)
 			break;
 
 		page = get_page_from_free_area(area, fallback_mt);
-		page = try_to_steal_block(zone, page, current_order, order,
+		page = try_to_claim_block(zone, page, current_order, order,
 					  start_migratetype, fallback_mt,
 					  alloc_flags);
 		if (page)
@@ -2149,11 +2149,11 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	if (alloc_flags & ALLOC_NOFRAGMENT)
 		return NULL;
 
-	/* No luck stealing blocks. Find the smallest fallback page */
+	/* No luck claiming pageblock. Find the smallest fallback page */
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
-				start_migratetype, false, &can_steal);
+				start_migratetype, false, &claim_block);
 		if (fallback_mt == -1)
 			continue;
 

-- 
2.48.1.658.g4767266eb4-goog


