Return-Path: <linux-kernel+bounces-533749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A380BA45E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93B837A50D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969CC228CBA;
	Wed, 26 Feb 2025 12:03:56 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBB621D3F0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571435; cv=none; b=lXF+f3YCUX3wMHJhrmE4aQl4TzruVOoq+SuHW7/z9wHvP+QkmZZc33qQ7oubV+ranOehrqyZYLZtnH4h00WsV3qq0ltiStFmKkWtXLErRmkm4J9k4dHcYpIffoikeB4thbxx6CDcOYanePnjq0n55HkWsxnUdoh4Kxg6E/IHO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571435; c=relaxed/simple;
	bh=Z3YStWF8jjuQ+sqfLarapFKK1bZZVdYAcO8uh6ynmGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pQmTAa2E9AvWfMo7pBTKRTzxtyYeLJhf5H4yV0OxYdqYbs2tyVIfVxJyXXAnZsjbuTc+AGdE7r3sbgWZwQJxwcKpyngOzjI4wAQSQEHrZdX92Nk7OWMvQePCOT8Oa5tgJsdl07nJRHiMQ1SIBq6Hj1FMpy3pej/GxD3yFZioIj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-2d-67bf032295b6
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 based on v6.14-rc4 12/25] mm: delimit critical sections to take off pages from pcp or buddy alloctor
Date: Wed, 26 Feb 2025 21:03:23 +0900
Message-Id: <20250226120336.29565-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnoa4S8/50gxWvzSzmrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK+PN5A7mgp3NjBUrZl1jbWCcnNXF
	yMkhIWAiMXPbZyYYu/XJdEYQm01AXeLGjZ/MILaIgJnEwdY/7F2MXBzMAsuYJPaeaGADSQgL
	1Ei8etMJ1swioCrR1dHACmLzAjU83vaRGWKovMTqDQfAbE6g+Kdpx8B6hQSSJXb+/gO1+Dab
	xPcpqRC2pMTBFTdYJjDyLmBkWMUolJlXlpuYmWOil1GZl1mhl5yfu4kRGNbLav9E72D8dCH4
	EKMAB6MSD++DM3vThVgTy4orcw8xSnAwK4nwcmbuSRfiTUmsrEotyo8vKs1JLT7EKM3BoiTO
	a/StPEVIID2xJDU7NbUgtQgmy8TBKdXAmHjDau27tis7Zt53/xU+/ZOlgfcn88qwnESWvedu
	BKi9mC2T7pvXGTTTtcLRwTHCW/7WIUvfYrerO/osMlw62dpCr35N7/tTzljes6zs8t0Fxnbi
	xZsO36oKTm6KquzvzlhYsyWMd/eMqfNOpB7omWPYl1WR+eLFrRNXvcr05ypZGHDciZ6pxFKc
	kWioxVxUnAgAp/uZVmcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/dYPs+XYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgy3kzuYC7Y2cxY
	sWLWNdYGxslZXYycHBICJhKtT6YzgthsAuoSN278ZAaxRQTMJA62/mHvYuTiYBZYxiSx90QD
	G0hCWKBG4tWbTiYQm0VAVaKro4EVxOYFani87SMzxFB5idUbDoDZnEDxT9OOgfUKCSRL7Pz9
	h2kCI9cCRoZVjCKZeWW5iZk5pnrF2RmVeZkVesn5uZsYgWG6rPbPxB2MXy67H2IU4GBU4uF9
	cGZvuhBrYllxZe4hRgkOZiURXs7MPelCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOEBNIT
	S1KzU1MLUotgskwcnFINjBGPLlnPvnn6ee7VLCGheJv6hTdNF/59XuqXJOFn/tNj4wq9v6/K
	mwzX2X/vX/Ncgtk3pWT3TYGA4rO/Ju9LXeWforZdmPPCs1PefS7H17Svf9uq9LC5d9m9EC2T
	qyrLFLKuH/6osuqIpa5DhNqi9xyXP0YZ8q2pbCmq+jf/oKdC+LFZ8m7VAUosxRmJhlrMRcWJ
	AGlnhTtPAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Now that luf mechanism has been introduced, tlb shootdown might be
necessary when luf'd pages exit from pcp or buddy allocator.  Check if
it's okay to take off pages and can perform for luf'd pages before use.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/compaction.c     | 32 ++++++++++++++++--
 mm/internal.h       |  2 +-
 mm/page_alloc.c     | 79 +++++++++++++++++++++++++++++++++++++++++++--
 mm/page_isolation.c |  4 ++-
 mm/page_reporting.c | 20 +++++++++++-
 5 files changed, 129 insertions(+), 8 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 12ed8425fa175..e26736d5b7b9c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -606,6 +606,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 	page = pfn_to_page(blockpfn);
 
+	luf_takeoff_start();
 	/* Isolate free pages. */
 	for (; blockpfn < end_pfn; blockpfn += stride, page += stride) {
 		int isolated;
@@ -654,9 +655,12 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 				goto isolate_fail;
 		}
 
+		if (!luf_takeoff_check(page))
+			goto isolate_fail;
+
 		/* Found a free page, will break it into order-0 pages */
 		order = buddy_order(page);
-		isolated = __isolate_free_page(page, order);
+		isolated = __isolate_free_page(page, order, false);
 		if (!isolated)
 			break;
 		set_page_private(page, order);
@@ -684,6 +688,11 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	if (locked)
 		spin_unlock_irqrestore(&cc->zone->lock, flags);
 
+	/*
+	 * Check and flush before using the pages taken off.
+	 */
+	luf_takeoff_end();
+
 	/*
 	 * Be careful to not go outside of the pageblock.
 	 */
@@ -1591,6 +1600,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 		if (!area->nr_free)
 			continue;
 
+		luf_takeoff_start();
 		spin_lock_irqsave(&cc->zone->lock, flags);
 		freelist = &area->free_list[MIGRATE_MOVABLE];
 		list_for_each_entry_reverse(freepage, freelist, buddy_list) {
@@ -1598,6 +1608,10 @@ static void fast_isolate_freepages(struct compact_control *cc)
 
 			order_scanned++;
 			nr_scanned++;
+
+			if (!luf_takeoff_check(freepage))
+				goto scan_next;
+
 			pfn = page_to_pfn(freepage);
 
 			if (pfn >= highest)
@@ -1617,7 +1631,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 				/* Shorten the scan if a candidate is found */
 				limit >>= 1;
 			}
-
+scan_next:
 			if (order_scanned >= limit)
 				break;
 		}
@@ -1635,7 +1649,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 
 		/* Isolate the page if available */
 		if (page) {
-			if (__isolate_free_page(page, order)) {
+			if (__isolate_free_page(page, order, false)) {
 				set_page_private(page, order);
 				nr_isolated = 1 << order;
 				nr_scanned += nr_isolated - 1;
@@ -1652,6 +1666,11 @@ static void fast_isolate_freepages(struct compact_control *cc)
 
 		spin_unlock_irqrestore(&cc->zone->lock, flags);
 
+		/*
+		 * Check and flush before using the pages taken off.
+		 */
+		luf_takeoff_end();
+
 		/* Skip fast search if enough freepages isolated */
 		if (cc->nr_freepages >= cc->nr_migratepages)
 			break;
@@ -2372,7 +2391,14 @@ static enum compact_result compact_finished(struct compact_control *cc)
 {
 	int ret;
 
+	/*
+	 * luf_takeoff_{start,end}() is required to identify whether
+	 * this compaction context is tlb shootdownable for luf'd pages.
+	 */
+	luf_takeoff_start();
 	ret = __compact_finished(cc);
+	luf_takeoff_end();
+
 	trace_mm_compaction_finished(cc->zone, cc->order, ret);
 	if (ret == COMPACT_NO_SUITABLE_PAGE)
 		ret = COMPACT_CONTINUE;
diff --git a/mm/internal.h b/mm/internal.h
index 47d3291278e81..9426ff6346d44 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -664,7 +664,7 @@ static inline void clear_zone_contiguous(struct zone *zone)
 	zone->contiguous = false;
 }
 
-extern int __isolate_free_page(struct page *page, unsigned int order);
+extern int __isolate_free_page(struct page *page, unsigned int order, bool willputback);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d2d23bbd60467..325f07c34cfdc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -869,8 +869,13 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
 static inline struct page *get_page_from_free_area(struct free_area *area,
 					    int migratetype)
 {
-	return list_first_entry_or_null(&area->free_list[migratetype],
+	struct page *page = list_first_entry_or_null(&area->free_list[migratetype],
 					struct page, buddy_list);
+
+	if (page && luf_takeoff_check(page))
+		return page;
+
+	return NULL;
 }
 
 /*
@@ -1575,6 +1580,8 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 	int nr_pages = 1 << high;
 
 	__del_page_from_free_list(page, zone, high, migratetype);
+	if (unlikely(!luf_takeoff_check_and_fold(page)))
+		VM_WARN_ON(1);
 	nr_pages -= expand(zone, page, low, high, migratetype);
 	account_freepages(zone, -nr_pages, migratetype);
 }
@@ -1945,6 +1952,13 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, pfn));
+
+		/*
+		 * No need to luf_takeoff_check_and_fold() since it's
+		 * going back to buddy. luf_key will be handed over in
+		 * split_large_buddy().
+		 */
+
 		set_pageblock_migratetype(page, migratetype);
 		split_large_buddy(zone, buddy, pfn, order, FPI_NONE);
 		return true;
@@ -1956,6 +1970,13 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(page, zone, order,
 					get_pfnblock_migratetype(page, pfn));
+
+		/*
+		 * No need to luf_takeoff_check_and_fold() since it's
+		 * going back to buddy. luf_key will be handed over in
+		 * split_large_buddy().
+		 */
+
 		set_pageblock_migratetype(page, migratetype);
 		split_large_buddy(zone, page, pfn, order, FPI_NONE);
 		return true;
@@ -2088,6 +2109,8 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 		unsigned int nr_added;
 
 		del_page_from_free_list(page, zone, current_order, block_type);
+		if (unlikely(!luf_takeoff_check_and_fold(page)))
+			VM_WARN_ON(1);
 		change_pageblock_range(page, current_order, start_type);
 		nr_added = expand(zone, page, order, current_order, start_type);
 		account_freepages(zone, nr_added, start_type);
@@ -2168,6 +2191,9 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 		if (free_area_empty(area, fallback_mt))
 			continue;
 
+		if (luf_takeoff_no_shootdown())
+			continue;
+
 		if (can_steal_fallback(order, migratetype))
 			*can_steal = true;
 
@@ -2259,6 +2285,11 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 					pageblock_nr_pages)
 			continue;
 
+		/*
+		 * luf_takeoff_{start,end}() is required for
+		 * get_page_from_free_area() to use luf_takeoff_check().
+		 */
+		luf_takeoff_start();
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < NR_PAGE_ORDERS; order++) {
 			struct free_area *area = &(zone->free_area[order]);
@@ -2316,10 +2347,12 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			WARN_ON_ONCE(ret == -1);
 			if (ret > 0) {
 				spin_unlock_irqrestore(&zone->lock, flags);
+				luf_takeoff_end();
 				return ret;
 			}
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
+		luf_takeoff_end();
 	}
 
 	return false;
@@ -2461,6 +2494,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	unsigned long flags;
 	int i;
 
+	luf_takeoff_start();
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
@@ -2485,6 +2519,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		list_add_tail(&page->pcp_list, list);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
+	/*
+	 * Check and flush before using the pages taken off.
+	 */
+	luf_takeoff_end();
 
 	return i;
 }
@@ -2979,7 +3017,7 @@ void split_page(struct page *page, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(split_page);
 
-int __isolate_free_page(struct page *page, unsigned int order)
+int __isolate_free_page(struct page *page, unsigned int order, bool willputback)
 {
 	struct zone *zone = page_zone(page);
 	int mt = get_pageblock_migratetype(page);
@@ -2998,6 +3036,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
 	}
 
 	del_page_from_free_list(page, zone, order, mt);
+	if (unlikely(!willputback && !luf_takeoff_check_and_fold(page)))
+		VM_WARN_ON(1);
 
 	/*
 	 * Set the pageblock if the isolated page is at least half of a
@@ -3077,6 +3117,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 	do {
 		page = NULL;
+		luf_takeoff_start();
 		spin_lock_irqsave(&zone->lock, flags);
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
@@ -3094,10 +3135,15 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 			if (!page) {
 				spin_unlock_irqrestore(&zone->lock, flags);
+				luf_takeoff_end();
 				return NULL;
 			}
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
+		/*
+		 * Check and flush before using the pages taken off.
+		 */
+		luf_takeoff_end();
 	} while (check_new_pages(page, order));
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
@@ -3181,6 +3227,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		}
 
 		page = list_first_entry(list, struct page, pcp_list);
+		if (!luf_takeoff_check_and_fold(page))
+			return NULL;
 		list_del(&page->pcp_list);
 		pcp->count -= 1 << order;
 	} while (check_new_pages(page, order));
@@ -3198,11 +3246,13 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct page *page;
 	unsigned long __maybe_unused UP_flags;
 
+	luf_takeoff_start();
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (!pcp) {
 		pcp_trylock_finish(UP_flags);
+		luf_takeoff_end();
 		return NULL;
 	}
 
@@ -3216,6 +3266,10 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
 	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
+	/*
+	 * Check and flush before using the pages taken off.
+	 */
+	luf_takeoff_end();
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
 		zone_statistics(preferred_zone, zone, 1);
@@ -4814,6 +4868,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
+	luf_takeoff_start();
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
@@ -4849,6 +4904,10 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 
 	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
+	/*
+	 * Check and flush before using the pages taken off.
+	 */
+	luf_takeoff_end();
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
@@ -4858,6 +4917,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 
 failed_irq:
 	pcp_trylock_finish(UP_flags);
+	luf_takeoff_end();
 
 failed:
 	page = __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask);
@@ -6912,6 +6972,7 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
 
 	offline_mem_sections(pfn, end_pfn);
 	zone = page_zone(pfn_to_page(pfn));
+	luf_takeoff_start();
 	spin_lock_irqsave(&zone->lock, flags);
 	while (pfn < end_pfn) {
 		page = pfn_to_page(pfn);
@@ -6940,9 +7001,15 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
 		VM_WARN_ON(get_pageblock_migratetype(page) != MIGRATE_ISOLATE);
 		order = buddy_order(page);
 		del_page_from_free_list(page, zone, order, MIGRATE_ISOLATE);
+		if (unlikely(!luf_takeoff_check_and_fold(page)))
+			VM_WARN_ON(1);
 		pfn += (1 << order);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
+	/*
+	 * Check and flush before using the pages taken off.
+	 */
+	luf_takeoff_end();
 
 	return end_pfn - start_pfn - already_offline;
 }
@@ -7018,6 +7085,7 @@ bool take_page_off_buddy(struct page *page)
 	unsigned int order;
 	bool ret = false;
 
+	luf_takeoff_start();
 	spin_lock_irqsave(&zone->lock, flags);
 	for (order = 0; order < NR_PAGE_ORDERS; order++) {
 		struct page *page_head = page - (pfn & ((1 << order) - 1));
@@ -7030,6 +7098,8 @@ bool take_page_off_buddy(struct page *page)
 
 			del_page_from_free_list(page_head, zone, page_order,
 						migratetype);
+			if (unlikely(!luf_takeoff_check_and_fold(page_head)))
+				VM_WARN_ON(1);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
 			SetPageHWPoisonTakenOff(page);
@@ -7040,6 +7110,11 @@ bool take_page_off_buddy(struct page *page)
 			break;
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	/*
+	 * Check and flush before using the pages taken off.
+	 */
+	luf_takeoff_end();
 	return ret;
 }
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 04dcea88a0dda..c34659b58ca6c 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -211,6 +211,7 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 	struct page *buddy;
 
 	zone = page_zone(page);
+	luf_takeoff_start();
 	spin_lock_irqsave(&zone->lock, flags);
 	if (!is_migrate_isolate_page(page))
 		goto out;
@@ -229,7 +230,7 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 			buddy = find_buddy_page_pfn(page, page_to_pfn(page),
 						    order, NULL);
 			if (buddy && !is_migrate_isolate_page(buddy)) {
-				isolated_page = !!__isolate_free_page(page, order);
+				isolated_page = !!__isolate_free_page(page, order, true);
 				/*
 				 * Isolating a free page in an isolated pageblock
 				 * is expected to always work as watermarks don't
@@ -269,6 +270,7 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 	zone->nr_isolate_pageblock--;
 out:
 	spin_unlock_irqrestore(&zone->lock, flags);
+	luf_takeoff_end(zone);
 }
 
 static inline struct page *
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index c05afb7a395f1..03a7f5f6dc073 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -167,6 +167,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	if (list_empty(list))
 		return err;
 
+	luf_takeoff_start();
 	spin_lock_irq(&zone->lock);
 
 	/*
@@ -191,6 +192,11 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		if (PageReported(page))
 			continue;
 
+		if (!luf_takeoff_check(page)) {
+			VM_WARN_ON(1);
+			continue;
+		}
+
 		/*
 		 * If we fully consumed our budget then update our
 		 * state to indicate that we are requesting additional
@@ -204,7 +210,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 
 		/* Attempt to pull page from list and place in scatterlist */
 		if (*offset) {
-			if (!__isolate_free_page(page, order)) {
+			if (!__isolate_free_page(page, order, false)) {
 				next = page;
 				break;
 			}
@@ -227,6 +233,11 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		/* release lock before waiting on report processing */
 		spin_unlock_irq(&zone->lock);
 
+		/*
+		 * Check and flush before using the pages taken off.
+		 */
+		luf_takeoff_end();
+
 		/* begin processing pages in local list */
 		err = prdev->report(prdev, sgl, PAGE_REPORTING_CAPACITY);
 
@@ -236,6 +247,8 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		/* update budget to reflect call to report function */
 		budget--;
 
+		luf_takeoff_start();
+
 		/* reacquire zone lock and resume processing */
 		spin_lock_irq(&zone->lock);
 
@@ -259,6 +272,11 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 
 	spin_unlock_irq(&zone->lock);
 
+	/*
+	 * Check and flush before using the pages taken off.
+	 */
+	luf_takeoff_end();
+
 	return err;
 }
 
-- 
2.17.1


