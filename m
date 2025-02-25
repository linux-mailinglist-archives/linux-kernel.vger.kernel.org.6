Return-Path: <linux-kernel+bounces-530298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C485A431BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DFB1743BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463C1FDD;
	Tue, 25 Feb 2025 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="bBMqLMA6"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3917F7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442237; cv=none; b=OwV3tJ9xr6sNMcex8aXDj578lcPylonwYhF/O+fYbZmVtKCsdIpV72Jo3QcJxZhW4FoS1VDN2LVMAjAKN616mnLC1eUzjbRBaGj05J5bNfbpl6w2vg+OLLCuIxHG6/575cLx0AV8r+W51hSz6p6jlX1U6/5MElH9h9nZcDTL/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442237; c=relaxed/simple;
	bh=vW6/f9HmG6tIbyx0iIEK4VXIjaqoMfGskZQtTPAvwdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTuJMf6DZwEB4g+t4kIkQKw2OX123t70oEG6pSeufDbVQhUf6jFYY1/JkupxzHEcIh3r3mWs9A2aHYENGad+DawhnwIdPmiji5U+Y6BDlqQrABJ5OsTpBoY/YspW/x7YIellwyS+HY+I7LSbwBxF3mfk1oSvHVnUjIhUL8bCuWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=bBMqLMA6; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ddcff5a823so40602256d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740442233; x=1741047033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jfbz8GKSHpu/xyC6cCph+07KnkaKzui+briDAaa0nnU=;
        b=bBMqLMA6k26Yh7fvf+n5C0NkpxW8G1qvzE2lnvVw4+PgN8lRKIckzKI615W/7Bc2ZP
         bJYRblCiB/217+R0oOCoYtI2TugSJzFC+nLsPWoUUIplGrSe6erUrqQJg6N/AjpVDY/7
         lsKMcappEloKmfPhl8oySbbhDnNB+NlqVF4zLwNm1ozLYSQk8ziwKcAa3N2X2mA2ZXs3
         Dye1YR0/N1F5gCLcV56r4Jg1mqO8bEZNPHVJkdUKy7PscTP210UqzPP81WUAgUSf8ZAA
         VKRcAd7aHAqskqLqvPRsP9/MzgAwrVGWxQl5GYY4i70RCqKADSmjIqU677G1E5IRcFhe
         UyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740442233; x=1741047033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jfbz8GKSHpu/xyC6cCph+07KnkaKzui+briDAaa0nnU=;
        b=BZVrYR8DtjFUg6UQ4fDG2XhuZ2FGpfUy1YEPA7eMcVbsBinzKFZk69FSc3xZJ7fome
         QZS7hDW0MSqENSP97hAOuAOUUhEQXQi7s46FITrvn2UIwF2sgdFRaTekk9IsBcLa9D2w
         WpPmtcYtSLsVl7eoIbrGARXqR3sYUb3FtIkDG+QPdrvtUk0a4NHVHHBEtEYVxCCEbgfJ
         Dz8Z6e1HBmSvl+zW4/JMsEagJeXhPcCvvjhH3IXK7iFq4BGAoYKcW7762K5OituKiBlX
         aTH6vDgoL1oJ8eEilV3mCT7rWB9Uco06/5G7QX5S/9GnPt7LR0kY3Zvm/i+oiai+HOxv
         YpPg==
X-Forwarded-Encrypted: i=1; AJvYcCWm8apDT3HedCnlHKkaVLyM5s7fSJqb6T3kRESU/P82dnPZmIV0BGl77syfdiT/AboquEEu+rPejQyOXgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxfuREnI6vRbDL/2z6rp/ZIrwTVH+IeUvDXk7quPzvVITCTN5H
	hmzEvZWBJSgIwNxvpcFsSmS9nEmo70yG8FMheQitLUPVNJhSz9dQL8f9LSJ7PDc=
X-Gm-Gg: ASbGncu9gq9lQUJifa8YtVeIdFcNcQlr3UBZv0zlw9M/Pl9yod0zHstpBlsuVDrw8bR
	25fVtfiZwPlKUY8wzjXJ5WhRYRBBuCnJjqlOGlQNM9RLT+zvrYe5EzYMo3iq5Klco0uyd6IEohc
	vcyO/QjXl0zZZD9b43eWQ0k4cNOJvVgI2FmkK5RPpoJyUJ6pTUHP7ssA7i8O05ZVvbiwWDFJ0zp
	1+rPaOzFcRuefjWhNWhnmyRKg97W/NXz7izNoYxRqely12B5f24IDEHAnJRlWE0XYbAa0zL9Ggs
	gb4qShhWiziJTg1i5snlKBQP
X-Google-Smtp-Source: AGHT+IGM3VVUjbDeCXvrKFFPK7jbq7t2UH3GiR9glB2p9o0jhpvV1lYU60G0oFU/Ke/PG5Pti/cUBg==
X-Received: by 2002:a05:6214:1bcb:b0:6e6:5a8a:aba with SMTP id 6a1803df08f44-6e6ae829f34mr221625886d6.21.1740442232965;
        Mon, 24 Feb 2025 16:10:32 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e87b1564easm3076106d6.72.2025.02.24.16.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 16:10:32 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm: page_alloc: don't steal single pages from biggest buddy
Date: Mon, 24 Feb 2025 19:08:24 -0500
Message-ID: <20250225001023.1494422-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225001023.1494422-1-hannes@cmpxchg.org>
References: <20250225001023.1494422-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fallback code searches for the biggest buddy first in an attempt
to steal the whole block and encourage type grouping down the line.

The approach used to be this:

- Non-movable requests will split the largest buddy and steal the
  remainder. This splits up contiguity, but it allows subsequent
  requests of this type to fall back into adjacent space.

- Movable requests go and look for the smallest buddy instead. The
  thinking is that movable requests can be compacted, so grouping is
  less important than retaining contiguity.

c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block
conversion") enforces freelist type hygiene, which restricts stealing
to either claiming the whole block or just taking the requested chunk;
no additional pages or buddy remainders can be stolen any more.

The patch mishandled when to switch to finding the smallest buddy in
that new reality. As a result, it may steal the exact request size,
but from the biggest buddy. This causes fracturing for no good reason.

Fix this by committing to the new behavior: either steal the whole
block, or fall back to the smallest buddy.

Remove single-page stealing from steal_suitable_fallback(). Rename it
to try_to_steal_block() to make the intentions clear. If this fails,
always fall back to the smallest buddy.

The following is from 4 runs of mmtest's thpchallenge. "Pollute" is
single page fallback, "steal" is conversion of a partially used block.
The numbers for free block conversions (omitted) are comparable.

				     vanilla	      patched

@pollute[unmovable from reclaimable]:	  27		  106
@pollute[unmovable from movable]:	  82		   46
@pollute[reclaimable from unmovable]:	 256		   83
@pollute[reclaimable from movable]:	  46		    8
@pollute[movable from unmovable]:	4841		  868
@pollute[movable from reclaimable]:	5278		12568

@steal[unmovable from reclaimable]:	  11		   12
@steal[unmovable from movable]:		 113		   49
@steal[reclaimable from unmovable]:	  19		   34
@steal[reclaimable from movable]:	  47		   21
@steal[movable from unmovable]:		 250		  183
@steal[movable from reclaimable]:	  81		   93

The allocator appears to do a better job at keeping stealing and
polluting to the first fallback preference. As a result, the numbers
for "from movable" - the least preferred fallback option, and most
detrimental to compactability - are down across the board.

Fixes: c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block conversion")
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 80 +++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 46 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 16dfcf7ade74..9ea14ec52449 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1986,13 +1986,12 @@ static inline bool boost_watermark(struct zone *zone)
  * can claim the whole pageblock for the requested migratetype. If not, we check
  * the pageblock for constituent pages; if at least half of the pages are free
  * or compatible, we can still claim the whole block, so pages freed in the
- * future will be put on the correct free list. Otherwise, we isolate exactly
- * the order we need from the fallback block and leave its migratetype alone.
+ * future will be put on the correct free list.
  */
 static struct page *
-steal_suitable_fallback(struct zone *zone, struct page *page,
-			int current_order, int order, int start_type,
-			unsigned int alloc_flags, bool whole_block)
+try_to_steal_block(struct zone *zone, struct page *page,
+		   int current_order, int order, int start_type,
+		   unsigned int alloc_flags)
 {
 	int free_pages, movable_pages, alike_pages;
 	unsigned long start_pfn;
@@ -2005,7 +2004,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	 * highatomic accounting.
 	 */
 	if (is_migrate_highatomic(block_type))
-		goto single_page;
+		return NULL;
 
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
@@ -2026,14 +2025,10 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	if (boost_watermark(zone) && (alloc_flags & ALLOC_KSWAPD))
 		set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 
-	/* We are not allowed to try stealing from the whole block */
-	if (!whole_block)
-		goto single_page;
-
 	/* moving whole block can fail due to zone boundary conditions */
 	if (!prep_move_freepages_block(zone, page, &start_pfn, &free_pages,
 				       &movable_pages))
-		goto single_page;
+		return NULL;
 
 	/*
 	 * Determine how many pages are compatible with our allocation.
@@ -2066,9 +2061,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 		return __rmqueue_smallest(zone, order, start_type);
 	}
 
-single_page:
-	page_del_and_expand(zone, page, order, current_order, block_type);
-	return page;
+	return NULL;
 }
 
 /*
@@ -2250,14 +2243,19 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 }
 
 /*
- * Try finding a free buddy page on the fallback list and put it on the free
- * list of requested migratetype, possibly along with other pages from the same
- * block, depending on fragmentation avoidance heuristics. Returns true if
- * fallback was found so that __rmqueue_smallest() can grab it.
+ * Try finding a free buddy page on the fallback list.
+ *
+ * This will attempt to steal a whole pageblock for the requested type
+ * to ensure grouping of such requests in the future.
+ *
+ * If a whole block cannot be stolen, regress to __rmqueue_smallest()
+ * logic to at least break up as little contiguity as possible.
  *
  * The use of signed ints for order and current_order is a deliberate
  * deviation from the rest of this file, to make the for loop
  * condition simpler.
+ *
+ * Return the stolen page, or NULL if none can be found.
  */
 static __always_inline struct page *
 __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
@@ -2291,45 +2289,35 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 		if (fallback_mt == -1)
 			continue;
 
-		/*
-		 * We cannot steal all free pages from the pageblock and the
-		 * requested migratetype is movable. In that case it's better to
-		 * steal and split the smallest available page instead of the
-		 * largest available page, because even if the next movable
-		 * allocation falls back into a different pageblock than this
-		 * one, it won't cause permanent fragmentation.
-		 */
-		if (!can_steal && start_migratetype == MIGRATE_MOVABLE
-					&& current_order > order)
-			goto find_smallest;
+		if (!can_steal)
+			break;
 
-		goto do_steal;
+		page = get_page_from_free_area(area, fallback_mt);
+		page = try_to_steal_block(zone, page, current_order, order,
+					  start_migratetype, alloc_flags);
+		if (page)
+			goto got_one;
 	}
 
-	return NULL;
+	if (alloc_flags & ALLOC_NOFRAGMENT)
+		return NULL;
 
-find_smallest:
+	/* No luck stealing blocks. Find the smallest fallback page */
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
 				start_migratetype, false, &can_steal);
-		if (fallback_mt != -1)
-			break;
-	}
-
-	/*
-	 * This should not happen - we already found a suitable fallback
-	 * when looking for the largest page.
-	 */
-	VM_BUG_ON(current_order > MAX_PAGE_ORDER);
+		if (fallback_mt == -1)
+			continue;
 
-do_steal:
-	page = get_page_from_free_area(area, fallback_mt);
+		page = get_page_from_free_area(area, fallback_mt);
+		page_del_and_expand(zone, page, order, current_order, fallback_mt);
+		goto got_one;
+	}
 
-	/* take off list, maybe claim block, expand remainder */
-	page = steal_suitable_fallback(zone, page, current_order, order,
-				       start_migratetype, alloc_flags, can_steal);
+	return NULL;
 
+got_one:
 	trace_mm_page_alloc_extfrag(page, order, current_order,
 		start_migratetype, fallback_mt);
 
-- 
2.48.1


