Return-Path: <linux-kernel+bounces-529055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453B6A41F72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A923AC8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE3B23BCE5;
	Mon, 24 Feb 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EI814i0w"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE2221F06
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400660; cv=none; b=AK3KWQ/VSjjgbhdbgknDL8KKdoq+fbOzn0h9VZZY5ybp88MTrXA8DFqj6e0cP5BALC9zhuOxZPXHYpynMr522633YY+YTE6FsT2Di27LRrxFJD7IhjcBTeqahaymOFAiiglv9CJAh6dK0AqpgsKpQJqtrjBMqLqGequ9bQN40Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400660; c=relaxed/simple;
	bh=+rZmu7x3Cx7i3RpSr4/PgAadEmTcP4SikvhDp7CKUFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ofk+JN4x2C50D7ITyCLDi8Cmrsa6oR5DFIMTuHPJa7nI9lPeqtS+h5M2iecqLsgJHsJ0FwVZBKXjBAQn/zPYDTsI2F2crXq6CnCvxzJyIAiD4IBzlUinROnvOOuQipkEueAWJtUFDdHkxC0KJdfrbiJojQQd6Sb+J1mWmj0RySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EI814i0w; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43947979ce8so18413945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740400657; x=1741005457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfVd/sVmXFUURgb0dTMvXDyQ4mvzorXL6Kpx2xKlZtA=;
        b=EI814i0w/kEgqxun49P9cDK6T2kjJ4vHtZfl4VRvMKk1rjL7inGUbBUidb0XF5nAnW
         2CeS06Et8xmAUm4hGP0G9NCh9jsRgf8vEJp0lTnT9GVKKB6qp0fBVX5gwylxFbQCJ0vO
         Q1mbRrddgB/xallOAB6j9Uq0zuhyyt9UY2+HEw7n+yznaTPVlVc5CWGxXeCL2mzaHXmK
         eMoB//5m77GHuWTVT0L66IyhKrClwzi3mmz5awi2dPC1Wb5ILfd8vF4CKf4gwC012V53
         d+GICr0GzMp3cFiVthZWaRjmVs8rTet7vjBaF+8M1A4u7i5M3k+YEyVBEQ8eHExMcQrn
         4qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740400657; x=1741005457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfVd/sVmXFUURgb0dTMvXDyQ4mvzorXL6Kpx2xKlZtA=;
        b=i8s7fSkN+R+42dRSBLv2Dj670JPSWk1jomDkM06jcvJ+1qwCuM/sew7nfXDGOwAr7h
         yopXhysmjYO5A1mDc8dgipZDMrftJKEtX4SX12dMKjdWjU8cvscJkbXlD6YCl0Yfoe0d
         B9bqr+KBQPqtuIFqEHGk+Vul7jaf0w2Nj4b8OO0Jfqm7NeOivymJNn/9EQ3t8iBhtm7h
         sG8PqL//hWVQJtWOMKV9tdF3qW7T4ca966TAOBHmscCy/D/0bhtOnACBnohlcP8RzXQD
         FjH5dfzwSMXFuVGiX4NthTiLbpAteYVJuW5m1elbbqI7Bin6CH7YKR0kvcY3DeRdKk/N
         QtTA==
X-Forwarded-Encrypted: i=1; AJvYcCWZvMhYHdJm1FlUrs+kdxfrqrrHo4aqDwJbWBV1LRTj+TxGhyoPdaaUUh/yen6a7/Ss7vYDaGFy032xXJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHS36ye8SikHLm1KuQeNVXzznyLE3jH/XwWKGR6D8kPYDJTtl
	ccV7zQ1G6IFX3+Cu4Efy58sS+8RptcCynbFk2nsBg7udT+3ETGX4QJey1pFzP7duRvueJSBAqdI
	LtwIH7bUHyw==
X-Google-Smtp-Source: AGHT+IEmuZ/CUd1iF302SQAJwhHvbZAtuGJmnDBQXhzOwEPDmSMyo4gXMQuCeG/fpatV+2gFoFl5y7wAHBiClQ==
X-Received: from wmbfl27.prod.google.com ([2002:a05:600c:b9b:b0:439:67c6:5642])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3c86:b0:439:9d75:9e7d with SMTP id 5b1f17b1804b1-439ae21d1d0mr93253705e9.22.1740400656922;
 Mon, 24 Feb 2025 04:37:36 -0800 (PST)
Date: Mon, 24 Feb 2025 12:37:28 +0000
In-Reply-To: <20250224-clarify-steal-v2-0-be24da656764@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224-clarify-steal-v2-0-be24da656764@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250224-clarify-steal-v2-1-be24da656764@google.com>
Subject: [PATCH v2 1/2] mm/page_alloc: Clarify terminology in migratetype
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
 mm/page_alloc.c | 65 ++++++++++++++++++++++++++++-----------------------------
 3 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 12ed8425fa175c5dec50bac3dddb13499abaaa11..4609df1f6fb3feb274ef451a0dabcb5c4a11ac76 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2332,7 +2332,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 	ret = COMPACT_NO_SUITABLE_PAGE;
 	for (order = cc->order; order < NR_PAGE_ORDERS; order++) {
 		struct free_area *area = &cc->zone->free_area[order];
-		bool can_steal;
+		bool claim_block;
 
 		/* Job done if page is free of the right migratetype */
 		if (!free_area_empty(area, migratetype))
@@ -2349,7 +2349,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 		 * other migratetype buddy lists.
 		 */
 		if (find_suitable_fallback(area, order, migratetype,
-						true, &can_steal) != -1)
+						true, &claim_block) != -1)
 			/*
 			 * Movable pages are OK in any pageblock. If we are
 			 * stealing for a non-movable allocation, make sure
diff --git a/mm/internal.h b/mm/internal.h
index 109ef30fee11f8b399f6bac42eab078cd51e01a5..c22d2826fd8d8681c89bb783ed269cc9346b5d92 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -847,7 +847,7 @@ void init_cma_reserved_pageblock(struct page *page);
 #endif /* CONFIG_COMPACTION || CONFIG_CMA */
 
 int find_suitable_fallback(struct free_area *area, unsigned int order,
-			int migratetype, bool only_stealable, bool *can_steal);
+			int migratetype, bool need_whole_block, bool *whole_block);
 
 static inline bool free_area_empty(struct free_area *area, int migratetype)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 579789600a3c7bfb7b0d847d51af702a9d4b139a..50d6c503474fa4c1d21b5bf5dbfd3eb0eef2c415 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1827,22 +1827,22 @@ static void change_pageblock_range(struct page *pageblock_page,
 
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
@@ -1855,7 +1855,7 @@ static bool can_steal_fallback(unsigned int order, int start_mt)
 	 * reclaimable pages that are closest to the request size.  After a
 	 * while, memory compaction may occur to form large contiguous pages,
 	 * and the next movable allocation may not need to steal.  Unmovable and
-	 * reclaimable allocations need to actually steal pages.
+	 * reclaimable allocations need to actually claim the whole block.
 	 */
 	if (order >= pageblock_order / 2 ||
 		start_mt == MIGRATE_RECLAIMABLE ||
@@ -1948,7 +1948,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	if (boost_watermark(zone) && (alloc_flags & ALLOC_KSWAPD))
 		set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 
-	/* We are not allowed to try stealing from the whole block */
+	/* No point in claiming the whole block */
 	if (!whole_block)
 		goto single_page;
 
@@ -1995,12 +1995,14 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 
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
@@ -2008,19 +2010,16 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
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
 
@@ -2190,7 +2189,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	int min_order = order;
 	struct page *page;
 	int fallback_mt;
-	bool can_steal;
+	bool claim_block;
 
 	/*
 	 * Do not steal pages from freelists belonging to other pageblocks
@@ -2209,19 +2208,19 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 				--current_order) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
-				start_migratetype, false, &can_steal);
+				start_migratetype, false, &claim_block);
 		if (fallback_mt == -1)
 			continue;
 
 		/*
-		 * We cannot steal all free pages from the pageblock and the
-		 * requested migratetype is movable. In that case it's better to
-		 * steal and split the smallest available page instead of the
-		 * largest available page, because even if the next movable
-		 * allocation falls back into a different pageblock than this
-		 * one, it won't cause permanent fragmentation.
+		 * We are not gonna claim the pageblock and the requested
+		 * migratetype is movable. In that case it's better to steal and
+		 * split the smallest available page instead of the largest
+		 * available page, because even if the next movable allocation
+		 * falls back into a different pageblock than this one, it won't
+		 * cause permanent fragmentation.
 		 */
-		if (!can_steal && start_migratetype == MIGRATE_MOVABLE
+		if (!claim_block && start_migratetype == MIGRATE_MOVABLE
 					&& current_order > order)
 			goto find_smallest;
 
@@ -2234,7 +2233,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
-				start_migratetype, false, &can_steal);
+				start_migratetype, false, &claim_block);
 		if (fallback_mt != -1)
 			break;
 	}
@@ -2250,7 +2249,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 
 	/* take off list, maybe claim block, expand remainder */
 	page = steal_suitable_fallback(zone, page, current_order, order,
-				       start_migratetype, alloc_flags, can_steal);
+				       start_migratetype, alloc_flags, claim_block);
 
 	trace_mm_page_alloc_extfrag(page, order, current_order,
 		start_migratetype, fallback_mt);

-- 
2.48.1.601.g30ceb7b040-goog


