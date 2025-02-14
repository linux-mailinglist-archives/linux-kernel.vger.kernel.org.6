Return-Path: <linux-kernel+bounces-515495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C99A3658D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7A0188B4A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3112690C0;
	Fri, 14 Feb 2025 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3AdBg9k"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51547268C69
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556855; cv=none; b=f0bBGQw2ZO0G2omKzz5yuZxRpvnlczN9HL/7foO6q8rwiAoFkH3xzFreyJrDErUeqUrgZ1IuqCe+kvvh6lvOmpBH8p9s3aRUSZkpeQgevJOpjGrnxLoMI5QWBhUD28M/x+asUgUaQB5Qp+KcUm2Ih6nOU7qxwUABzhd23Ukajj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556855; c=relaxed/simple;
	bh=wRhbDbrh395UUGXZpTO3l7QDv1uyYWYlG58Otf/Tu2w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ncTXxW+yvLC4wdQ3wrlGZjjcFPOdozUpk0RSVPsJKqFoa2bMn3gnzajVLx9nspTq1NezhUBmm099TEclu0sqQxPGWGWqnBnQOmaMUimuCJXs9C5Xh0dKAhjd9o9t/lx2jK3nlRgQh/9OM0oAi0kg8PrbnW8OesDd9dnFb3q1jjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3AdBg9k; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-439622e9113so16136675e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739556851; x=1740161651; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kM2Ovaxxrgq7wE5ezhQqwh/r8fPzqX2R4YTVCdFxQPY=;
        b=N3AdBg9kSqHeN+QN9h9WFuUYeedF8QaxtgObZSS4wris+O/OLxk6GgLXVEbBqaRnFx
         bkKT6nS4RR6Ix49EJNtADbq55psfaHhp0c9kYYJld0At4OUc/n1i5fc4DQcWg0CQ+pW9
         IKMaTHVqYBmWGmu7IsdYvO1mtpsPMNimxRC6DB/fbJ6IcYlUc4GX3YfaLa9OwcPb1cFl
         fhfCaT95vew4VLDuk9cwT1JlCfoCGsLUittPa3OQJSIPBu3E+wQcZfxnhQyXFnQB2qF3
         B+G10Mop342fbjrDyQkcDm6elpZYmrAL4O1x4ddufCE9FQmo/wWCCt7+YUToJQmxtT7N
         LSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739556851; x=1740161651;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kM2Ovaxxrgq7wE5ezhQqwh/r8fPzqX2R4YTVCdFxQPY=;
        b=LGHF+ldc92GbIEdZP1oT/Pi0LpYcjTHw+1oBI2hS3NJrXGUTEeGHTdxFoTjrr1Xdrj
         Cu223tw3wwzIt8F3MqHjyJE3P+XAuArPBPLGsmZv0fb1qflmj/NlwGn4jACcoXVgEnNg
         aH7yy602SytE4lNY2eBrlpEATXYI710p9setv4NLxxI37obPI3x/rJl7/An7hGDas6Lo
         P2MHmzO+XyQQ0O+eu5CxpozNaoQSinvR8f/TKlBOaMEIWN16dbyrp4YbSfdiFpNNwd7a
         yaSlDP8zO1yfkY5gFpnCvHSC6RespGib9gFzK9F4+3sUPiKKzsMufyHDkirCOSir28Hc
         3cfw==
X-Forwarded-Encrypted: i=1; AJvYcCVj0kUHpjCkBl3SRnCrKYZaaHrYxYjYGxFhVly2hZ/HTbwly5SOSZK9MXoyG7Ycy9mQHlVZsr/gfUdMxt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxddCJKrSL0wqwTcKv3B36pchzvdm78UOPHwsKrbDJgTusJzf
	pV7jxMGvN9hTTdH/D1n4xST99dYa8zVW1BwuAUXH8GMO5cCbr719OKQa7DfKECQ0QZvcOD4M/tq
	luEpfsCQNig==
X-Google-Smtp-Source: AGHT+IG48U3jLPPy8jsbIodS96OA4IQYGYtRES+t7y5quifE8e/WTqGxWQRdp+LiC0BV3+kDmbunyWp60rKipA==
X-Received: from wmgg17.prod.google.com ([2002:a05:600d:11:b0:439:5fab:db0f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3546:b0:439:419d:ae01 with SMTP id 5b1f17b1804b1-4396e6eda19mr3229325e9.10.1739556851656;
 Fri, 14 Feb 2025 10:14:11 -0800 (PST)
Date: Fri, 14 Feb 2025 18:14:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOiHr2cC/x3MQQqAIBBA0avIrBNUJpCuEi3ExhoQC40oxLsnL
 d/i/wqFMlOBSVTIdHPhI3XoQYDfXdpI8toNRplRGY3SR5c5vLJc5KIMBtFahai9ht6cmQI//29 eWvsAgAjIYl8AAAA=
X-Change-Id: 20250214-clarify-steal-f244880441c1
X-Mailer: b4 0.15-dev
Message-ID: <20250214-clarify-steal-v1-1-79dc5adf1b79@google.com>
Subject: [PATCH] mm/page_alloc: Clarify some migratetype fallback code
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, 
	Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Brendan Jackman <jackmanb@google.com>
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

Fix 1. by avoiding the term "steal" in ambiguous contexts. This fixes
3. automatically since the natural name for can_steal is whole_block.

Fix 2. by using "should" instead of "can", and also rename its
parameters and add some commentary to make it more explicit what they
mean.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/compaction.c |  4 ++--
 mm/internal.h   |  2 +-
 mm/page_alloc.c | 42 ++++++++++++++++++++++--------------------
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 12ed8425fa175c5dec50bac3dddb13499abaaa11..8dccb2e388f128dd134ec6f24c924c118c9c93bb 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2332,7 +2332,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 	ret = COMPACT_NO_SUITABLE_PAGE;
 	for (order = cc->order; order < NR_PAGE_ORDERS; order++) {
 		struct free_area *area = &cc->zone->free_area[order];
-		bool can_steal;
+		bool whole_block;
 
 		/* Job done if page is free of the right migratetype */
 		if (!free_area_empty(area, migratetype))
@@ -2349,7 +2349,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 		 * other migratetype buddy lists.
 		 */
 		if (find_suitable_fallback(area, order, migratetype,
-						true, &can_steal) != -1)
+						true, &whole_block) != -1)
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
index 579789600a3c7bfb7b0d847d51af702a9d4b139a..75900f9b538eb0a241401af888643df850840436 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1832,12 +1832,12 @@ static void change_pageblock_range(struct page *pageblock_page,
  *
  * If we are stealing a relatively large buddy page, it is likely there will
  * be more free pages in the pageblock, so try to steal them all. For
- * reclaimable and unmovable allocations, we steal regardless of page size,
- * as fragmentation caused by those allocations polluting movable pageblocks
- * is worse than movable allocations stealing from unmovable and reclaimable
- * pageblocks.
+ * reclaimable and unmovable allocations, we steal the whole block regardless of
+ * page size, as fragmentation caused by those allocations polluting movable
+ * pageblocks is worse than movable allocations stealing from unmovable and
+ * reclaimable pageblocks.
  */
-static bool can_steal_fallback(unsigned int order, int start_mt)
+static bool should_steal_whole_block(unsigned int order, int start_mt)
 {
 	/*
 	 * Leaving this order check is intended, although there is
@@ -1855,7 +1855,7 @@ static bool can_steal_fallback(unsigned int order, int start_mt)
 	 * reclaimable pages that are closest to the request size.  After a
 	 * while, memory compaction may occur to form large contiguous pages,
 	 * and the next movable allocation may not need to steal.  Unmovable and
-	 * reclaimable allocations need to actually steal pages.
+	 * reclaimable allocations need to actually steal the whole block.
 	 */
 	if (order >= pageblock_order / 2 ||
 		start_mt == MIGRATE_RECLAIMABLE ||
@@ -1948,7 +1948,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	if (boost_watermark(zone) && (alloc_flags & ALLOC_KSWAPD))
 		set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 
-	/* We are not allowed to try stealing from the whole block */
+	/* No point in stealing from the whole block */
 	if (!whole_block)
 		goto single_page;
 
@@ -1995,12 +1995,14 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 
 /*
  * Check whether there is a suitable fallback freepage with requested order.
- * If only_stealable is true, this function returns fallback_mt only if
- * we can steal other freepages all together. This would help to reduce
+ * Sets *whole_block to instruct the caller whether it should convert a whole
+ * pageblock to the returned migratetype.
+ * If need_whole_block is true, this function returns fallback_mt only if
+ * we would do this whole-block stealing. This would help to reduce
  * fragmentation due to mixed migratetype pages in one pageblock.
  */
 int find_suitable_fallback(struct free_area *area, unsigned int order,
-			int migratetype, bool only_stealable, bool *can_steal)
+			int migratetype, bool need_whole_block, bool *whole_block)
 {
 	int i;
 	int fallback_mt;
@@ -2008,19 +2010,19 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 	if (area->nr_free == 0)
 		return -1;
 
-	*can_steal = false;
+	*whole_block = false;
 	for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
 		fallback_mt = fallbacks[migratetype][i];
 		if (free_area_empty(area, fallback_mt))
 			continue;
 
-		if (can_steal_fallback(order, migratetype))
-			*can_steal = true;
+		if (should_steal_whole_block(order, migratetype))
+			*whole_block = true;
 
-		if (!only_stealable)
+		if (!need_whole_block)
 			return fallback_mt;
 
-		if (*can_steal)
+		if (*whole_block)
 			return fallback_mt;
 	}
 
@@ -2190,7 +2192,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	int min_order = order;
 	struct page *page;
 	int fallback_mt;
-	bool can_steal;
+	bool whole_block;
 
 	/*
 	 * Do not steal pages from freelists belonging to other pageblocks
@@ -2209,7 +2211,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 				--current_order) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
-				start_migratetype, false, &can_steal);
+				start_migratetype, false, &whole_block);
 		if (fallback_mt == -1)
 			continue;
 
@@ -2221,7 +2223,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 		 * allocation falls back into a different pageblock than this
 		 * one, it won't cause permanent fragmentation.
 		 */
-		if (!can_steal && start_migratetype == MIGRATE_MOVABLE
+		if (!whole_block && start_migratetype == MIGRATE_MOVABLE
 					&& current_order > order)
 			goto find_smallest;
 
@@ -2234,7 +2236,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
-				start_migratetype, false, &can_steal);
+				start_migratetype, false, &whole_block);
 		if (fallback_mt != -1)
 			break;
 	}
@@ -2250,7 +2252,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 
 	/* take off list, maybe claim block, expand remainder */
 	page = steal_suitable_fallback(zone, page, current_order, order,
-				       start_migratetype, alloc_flags, can_steal);
+				       start_migratetype, alloc_flags, whole_block);
 
 	trace_mm_page_alloc_extfrag(page, order, current_order,
 		start_migratetype, fallback_mt);

---
base-commit: 128c8f96eb8638c060cd3532dc394d046ce64fe1
change-id: 20250214-clarify-steal-f244880441c1

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


