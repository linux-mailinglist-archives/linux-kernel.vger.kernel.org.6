Return-Path: <linux-kernel+bounces-522995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88398A3D0E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1082817C2B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6651E2613;
	Thu, 20 Feb 2025 05:36:10 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB571E47A9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029768; cv=none; b=NFKC/iYTacEKZ150jhWX8xKPL45Dtk2Oww/twYoxfpE5pmwP0r5Pl2IIgLB0c2b6FugwQKKM53DEj/ptci4Nhwiq9Fl9bUlUYt24Bodz/v/aGqIycNoXhNtKv+SlH4vUdiS6JnyRowmog6cRUVue3Da1QVIA7E1WRMu9OHQDJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029768; c=relaxed/simple;
	bh=KdT8AtGK+qYpDffSacrYcymV9M+2Gfbhm4h0ypoJVUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KipQiXNiVObNvKKld8daUQuL28ytufRxzg4MzcEOK/snn9i6R2fdq6ro42FolO3VRNVH1vAr7f/4tgkK89u+SPTVY2xgvj5hZK3+RbDc45Qm5p+w6GdzHqUeYeupmNUT9KbFshk+eK2cpxbYfx+lVBaDhYz+ZB8EUSE6RqIY4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-ea-67b6bba63180
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
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
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 12/26] mm: delimit critical sections to take off pages from pcp or buddy alloctor
Date: Thu, 20 Feb 2025 14:20:13 +0900
Message-Id: <20250220052027.58847-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnoe6y3dvSDR4sMrKYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	x5f/YyrY2cxYsXzPO5YGxslZXYycHBICJhJ/eu+wwthfzixhB7HZBNQlbtz4yQxiiwiYSRxs
	/QMWZxa4yyRxoJ8NxBYWyJTYtriHEcRmEVCVaD3xEqyeF6j+SEcHG8RMeYnVGw6AxTmB4j9m
	9ILFhQRMJd4tuMQEUfOeTWLbzlAIW1Li4IobLBMYeRcwMqxiFMrMK8tNzMwx0cuozMus0EvO
	z93ECAz9ZbV/oncwfroQfIhRgINRiYd3Ruu2dCHWxLLiytxDjBIczEoivG31W9KFeFMSK6tS
	i/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MDrdv2l+UXvJvPWyoksb
	XniXPWXyC4rILqhYlH+G0+P/2vIp4txqi74X+f2yNWKdkN30+mzZ9y9HGvKaZp4zEOvuOV8Z
	JL8vcFUX8/ZpTR8mW5648e+9ZCtH6YN/B613FbJHKn1lM/r+TF7vpPLUP0+NazZ2ddmy+tc1
	GfgZsgevYltUJBD9R4mlOCPRUIu5qDgRABKViE55AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g4NbNSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlXF8+T+mgp3NjBXL97xjaWCcnNXFyMkhIWAi8eXMEnYQm01AXeLGjZ/MILaI
	gJnEwdY/YHFmgbtMEgf62UBsYYFMiW2LexhBbBYBVYnWEy/B6nmB6o90dLBBzJSXWL3hAFic
	Eyj+Y0YvWFxIwFTi3YJLTBMYuRYwMqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIDOVltX8m
	7mD8ctn9EKMAB6MSD++Dx1vThVgTy4orcw8xSnAwK4nwttVvSRfiTUmsrEotyo8vKs1JLT7E
	KM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpgnHt7wvJP0y7922u/c6misKL3zsNL+HUC
	PuXz19zbxBT/7IlNSuW05S33xPas1/n3Vj7QX65Qg2UhM+epsqDD7Eud3mjEqarOWTrrWLGZ
	/zqR7UlqAoL9sw2aUkLUs3qkWdPqkt23/Pl6/8mkE8e/GCpcWvFj+kTLCzvn2S1R2P1E9xzb
	HoGH0kosxRmJhlrMRcWJAIisZQVhAgAA
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
index 6009f5d1021a6..90f5c34f333db 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -605,6 +605,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 	page = pfn_to_page(blockpfn);
 
+	luf_takeoff_start();
 	/* Isolate free pages. */
 	for (; blockpfn < end_pfn; blockpfn += stride, page += stride) {
 		int isolated;
@@ -652,9 +653,12 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
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
@@ -682,6 +686,11 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
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
@@ -1589,6 +1598,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 		if (!area->nr_free)
 			continue;
 
+		luf_takeoff_start();
 		spin_lock_irqsave(&cc->zone->lock, flags);
 		freelist = &area->free_list[MIGRATE_MOVABLE];
 		list_for_each_entry_reverse(freepage, freelist, buddy_list) {
@@ -1596,6 +1606,10 @@ static void fast_isolate_freepages(struct compact_control *cc)
 
 			order_scanned++;
 			nr_scanned++;
+
+			if (!luf_takeoff_check(freepage))
+				goto scan_next;
+
 			pfn = page_to_pfn(freepage);
 
 			if (pfn >= highest)
@@ -1615,7 +1629,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 				/* Shorten the scan if a candidate is found */
 				limit >>= 1;
 			}
-
+scan_next:
 			if (order_scanned >= limit)
 				break;
 		}
@@ -1633,7 +1647,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 
 		/* Isolate the page if available */
 		if (page) {
-			if (__isolate_free_page(page, order)) {
+			if (__isolate_free_page(page, order, false)) {
 				set_page_private(page, order);
 				nr_isolated = 1 << order;
 				nr_scanned += nr_isolated - 1;
@@ -1650,6 +1664,11 @@ static void fast_isolate_freepages(struct compact_control *cc)
 
 		spin_unlock_irqrestore(&cc->zone->lock, flags);
 
+		/*
+		 * Check and flush before using the pages taken off.
+		 */
+		luf_takeoff_end();
+
 		/* Skip fast search if enough freepages isolated */
 		if (cc->nr_freepages >= cc->nr_migratepages)
 			break;
@@ -2369,7 +2388,14 @@ static enum compact_result compact_finished(struct compact_control *cc)
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
index 2bb54bc04260b..3a6da77d04ed3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -662,7 +662,7 @@ static inline void clear_zone_contiguous(struct zone *zone)
 	zone->contiguous = false;
 }
 
-extern int __isolate_free_page(struct page *page, unsigned int order);
+extern int __isolate_free_page(struct page *page, unsigned int order, bool willputback);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 05a1098f8c61f..f2ea69596ff15 100644
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
@@ -1579,6 +1584,8 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 	int nr_pages = 1 << high;
 
 	__del_page_from_free_list(page, zone, high, migratetype);
+	if (unlikely(!luf_takeoff_check_and_fold(page)))
+		VM_WARN_ON(1);
 	nr_pages -= expand(zone, page, low, high, migratetype);
 	account_freepages(zone, -nr_pages, migratetype);
 }
@@ -1950,6 +1957,13 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
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
@@ -1961,6 +1975,13 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
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
@@ -2085,6 +2106,8 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 		unsigned int nr_added;
 
 		del_page_from_free_list(page, zone, current_order, block_type);
+		if (unlikely(!luf_takeoff_check_and_fold(page)))
+			VM_WARN_ON(1);
 		change_pageblock_range(page, current_order, start_type);
 		nr_added = expand(zone, page, order, current_order, start_type);
 		account_freepages(zone, nr_added, start_type);
@@ -2165,6 +2188,9 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 		if (free_area_empty(area, fallback_mt))
 			continue;
 
+		if (luf_takeoff_no_shootdown())
+			continue;
+
 		if (can_steal_fallback(order, migratetype))
 			*can_steal = true;
 
@@ -2256,6 +2282,11 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
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
@@ -2313,10 +2344,12 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
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
@@ -2494,6 +2527,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	unsigned long flags;
 	int i;
 
+	luf_takeoff_start();
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
@@ -2518,6 +2552,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		list_add_tail(&page->pcp_list, list);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
+	/*
+	 * Check and flush before using the pages taken off.
+	 */
+	luf_takeoff_end();
 
 	return i;
 }
@@ -3012,7 +3050,7 @@ void split_page(struct page *page, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(split_page);
 
-int __isolate_free_page(struct page *page, unsigned int order)
+int __isolate_free_page(struct page *page, unsigned int order, bool willputback)
 {
 	struct zone *zone = page_zone(page);
 	int mt = get_pageblock_migratetype(page);
@@ -3031,6 +3069,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
 	}
 
 	del_page_from_free_list(page, zone, order, mt);
+	if (unlikely(!willputback && !luf_takeoff_check_and_fold(page)))
+		VM_WARN_ON(1);
 
 	/*
 	 * Set the pageblock if the isolated page is at least half of a
@@ -3110,6 +3150,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 	do {
 		page = NULL;
+		luf_takeoff_start();
 		spin_lock_irqsave(&zone->lock, flags);
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
@@ -3127,10 +3168,15 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
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
@@ -3214,6 +3260,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		}
 
 		page = list_first_entry(list, struct page, pcp_list);
+		if (!luf_takeoff_check_and_fold(page))
+			return NULL;
 		list_del(&page->pcp_list);
 		pcp->count -= 1 << order;
 	} while (check_new_pages(page, order));
@@ -3231,11 +3279,13 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
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
 
@@ -3249,6 +3299,10 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
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
@@ -4853,6 +4907,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
+	luf_takeoff_start();
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
@@ -4891,6 +4946,10 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 
 	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
+	/*
+	 * Check and flush before using the pages taken off.
+	 */
+	luf_takeoff_end();
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
@@ -4900,6 +4959,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 
 failed_irq:
 	pcp_trylock_finish(UP_flags);
+	luf_takeoff_end();
 
 failed:
 	page = __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask);
@@ -7036,6 +7096,7 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
 
 	offline_mem_sections(pfn, end_pfn);
 	zone = page_zone(pfn_to_page(pfn));
+	luf_takeoff_start();
 	spin_lock_irqsave(&zone->lock, flags);
 	while (pfn < end_pfn) {
 		page = pfn_to_page(pfn);
@@ -7064,9 +7125,15 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
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
@@ -7142,6 +7209,7 @@ bool take_page_off_buddy(struct page *page)
 	unsigned int order;
 	bool ret = false;
 
+	luf_takeoff_start();
 	spin_lock_irqsave(&zone->lock, flags);
 	for (order = 0; order < NR_PAGE_ORDERS; order++) {
 		struct page *page_head = page - (pfn & ((1 << order) - 1));
@@ -7154,6 +7222,8 @@ bool take_page_off_buddy(struct page *page)
 
 			del_page_from_free_list(page_head, zone, page_order,
 						migratetype);
+			if (unlikely(!luf_takeoff_check_and_fold(page_head)))
+				VM_WARN_ON(1);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
 			SetPageHWPoisonTakenOff(page);
@@ -7164,6 +7234,11 @@ bool take_page_off_buddy(struct page *page)
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
index 8467838d4dbc8..eae33d188762b 100644
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


