Return-Path: <linux-kernel+bounces-533725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25651A45E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850303AD965
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3E221738;
	Wed, 26 Feb 2025 12:01:54 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F521ABDF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571313; cv=none; b=GJh2oVg5MBgIJr444HKZPdqxeLW3GNc6gUlWEL0fucz7FDvC7NtkglAfrrIo8KM9vp9UKWX+jAyc1QQNLQUy/YKmSK/eZlpu4d4LMYdStF2+Vk/CR225WVZ56fW6V2DY4165EgX15DHr8iwEBoQx66jqX+p4fzIK/hgcZfKcTPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571313; c=relaxed/simple;
	bh=NUbuF0DqjtPbNaP0Crunij2FMhY9sRWmKOWkpVEphqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WEyVYFEbMmE6ZZhddlcw1b2W6BFo3YP1ca+8RlGCVRZ2y3s8g4PRnZ0ScA8uhhOSgUI377lvxdDXAICnRtg0QD4VzjCRB8d62Fm5M2tkg8J4/wsPXvSwVFiN6/ypQh1Y9RqQcK07q/KGqaZ8cE0UrH9QSVFFBD29KEFj7YEL7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-fe-67bf02a6a7b1
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 12/25] mm: delimit critical sections to take off pages from pcp or buddy alloctor
Date: Wed, 26 Feb 2025 21:01:19 +0900
Message-Id: <20250226120132.28469-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsXC9ZZnke5ypv3pBof3MFrMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8a0L19YC3Y2M1as3/6arYFxclYX
	IyeHhICJxPKtaxhh7LV/drCA2GwC6hI3bvxkBrFFBMwkDrb+Ye9i5OJgFljGJLH3RAMbiCMs
	MJFRYlPDcVaQKhYBVYld36eD2bxAHT1fX7NATJWXWL3hANgkTqD4v92/2UFsIYFkiZb1v1lA
	BkkI3GeTONy6ngmiQVLi4IobLBMYeRcwMqxiFMrMK8tNzMwx0cuozMus0EvOz93ECAztZbV/
	oncwfroQfIhRgINRiYf3wZm96UKsiWXFlbmHGCU4mJVEeDkz96QL8aYkVlalFuXHF5XmpBYf
	YpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYIwRsgj+cXZ7hk/HvMeW57m+nrsud130
	2knWx2ytr033zJ3rOE9iziz+R01tbXue/NkZnb2qfnLxbEEpj0Msc5ZtO+ARcfqj7rS7IetX
	3lfaq7Z3v4dK+794laydzOtu3D8Yzfl9mw1LkLbea73dYonVD0Vn/FLnSizxPDDdIKtUliEm
	pzcu31+JpTgj0VCLuag4EQDQc5zvaQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6wa2bJhZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlTPvyhbVgZzNj
	xfrtr9kaGCdndTFyckgImEis/bODBcRmE1CXuHHjJzOILSJgJnGw9Q97FyMXB7PAMiaJvSca
	2EAcYYGJjBKbGo6zglSxCKhK7Po+HczmBero+fqaBWKqvMTqDQfAJnECxf/t/s0OYgsJJEu0
	rP/NMoGRawEjwypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAQF1W+2fiDsYvl90PMQpwMCrx
	8D44szddiDWxrLgy9xCjBAezkggvZ+aedCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8XuGpCUIC
	6YklqdmpqQWpRTBZJg5OqQZGthU7JuW+263ezSC7VepZuusspjjpnDdzFr3cImjDEl1urHPM
	b2f+rEfGr2PEUtUWBi3ZwzLRvoTjudS1B4VF95lUXGJV6nx3HDwp1FMpHd9/yu/yj5klp9bU
	fT8lP6su3H5J+Y9lpiV87LJOpo4H/M+WL+vy0zyXsPuYX3DF4sjrP0NnSU9RYinOSDTUYi4q
	TgQAYk0z41ACAAA=
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
index e5744f354edea..bf5ded83b9dd1 100644
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
@@ -2373,7 +2392,14 @@ static enum compact_result compact_finished(struct compact_control *cc)
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
index fe1c879b41487..77b7e6d0bcc29 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -666,7 +666,7 @@ static inline void clear_zone_contiguous(struct zone *zone)
 	zone->contiguous = false;
 }
 
-extern int __isolate_free_page(struct page *page, unsigned int order);
+extern int __isolate_free_page(struct page *page, unsigned int order, bool willputback);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 986fdd57e8e3a..a0182421da13e 100644
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
@@ -1653,6 +1658,8 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 	int nr_pages = 1 << high;
 
 	__del_page_from_free_list(page, zone, high, migratetype);
+	if (unlikely(!luf_takeoff_check_and_fold(page)))
+		VM_WARN_ON(1);
 	nr_pages -= expand(zone, page, low, high, migratetype);
 	account_freepages(zone, -nr_pages, migratetype);
 }
@@ -2023,6 +2030,13 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
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
@@ -2034,6 +2048,13 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
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
@@ -2166,6 +2187,8 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 		unsigned int nr_added;
 
 		del_page_from_free_list(page, zone, current_order, block_type);
+		if (unlikely(!luf_takeoff_check_and_fold(page)))
+			VM_WARN_ON(1);
 		change_pageblock_range(page, current_order, start_type);
 		nr_added = expand(zone, page, order, current_order, start_type);
 		account_freepages(zone, nr_added, start_type);
@@ -2246,6 +2269,9 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 		if (free_area_empty(area, fallback_mt))
 			continue;
 
+		if (luf_takeoff_no_shootdown())
+			continue;
+
 		if (can_steal_fallback(order, migratetype))
 			*can_steal = true;
 
@@ -2337,6 +2363,11 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
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
@@ -2394,10 +2425,12 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
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
@@ -2539,6 +2572,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	unsigned long flags;
 	int i;
 
+	luf_takeoff_start();
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
@@ -2563,6 +2597,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		list_add_tail(&page->pcp_list, list);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
+	/*
+	 * Check and flush before using the pages taken off.
+	 */
+	luf_takeoff_end();
 
 	return i;
 }
@@ -3057,7 +3095,7 @@ void split_page(struct page *page, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(split_page);
 
-int __isolate_free_page(struct page *page, unsigned int order)
+int __isolate_free_page(struct page *page, unsigned int order, bool willputback)
 {
 	struct zone *zone = page_zone(page);
 	int mt = get_pageblock_migratetype(page);
@@ -3076,6 +3114,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
 	}
 
 	del_page_from_free_list(page, zone, order, mt);
+	if (unlikely(!willputback && !luf_takeoff_check_and_fold(page)))
+		VM_WARN_ON(1);
 
 	/*
 	 * Set the pageblock if the isolated page is at least half of a
@@ -3155,6 +3195,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 	do {
 		page = NULL;
+		luf_takeoff_start();
 		spin_lock_irqsave(&zone->lock, flags);
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
@@ -3172,10 +3213,15 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
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
@@ -3259,6 +3305,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		}
 
 		page = list_first_entry(list, struct page, pcp_list);
+		if (!luf_takeoff_check_and_fold(page))
+			return NULL;
 		list_del(&page->pcp_list);
 		pcp->count -= 1 << order;
 	} while (check_new_pages(page, order));
@@ -3276,11 +3324,13 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
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
 
@@ -3294,6 +3344,10 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
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
@@ -4892,6 +4946,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
+	luf_takeoff_start();
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
@@ -4927,6 +4982,10 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 
 	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
+	/*
+	 * Check and flush before using the pages taken off.
+	 */
+	luf_takeoff_end();
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
@@ -4936,6 +4995,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 
 failed_irq:
 	pcp_trylock_finish(UP_flags);
+	luf_takeoff_end();
 
 failed:
 	page = __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask);
@@ -6989,6 +7049,7 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
 
 	offline_mem_sections(pfn, end_pfn);
 	zone = page_zone(pfn_to_page(pfn));
+	luf_takeoff_start();
 	spin_lock_irqsave(&zone->lock, flags);
 	while (pfn < end_pfn) {
 		page = pfn_to_page(pfn);
@@ -7017,9 +7078,15 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
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
@@ -7095,6 +7162,7 @@ bool take_page_off_buddy(struct page *page)
 	unsigned int order;
 	bool ret = false;
 
+	luf_takeoff_start();
 	spin_lock_irqsave(&zone->lock, flags);
 	for (order = 0; order < NR_PAGE_ORDERS; order++) {
 		struct page *page_head = page - (pfn & ((1 << order) - 1));
@@ -7107,6 +7175,8 @@ bool take_page_off_buddy(struct page *page)
 
 			del_page_from_free_list(page_head, zone, page_order,
 						migratetype);
+			if (unlikely(!luf_takeoff_check_and_fold(page_head)))
+				VM_WARN_ON(1);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
 			SetPageHWPoisonTakenOff(page);
@@ -7117,6 +7187,11 @@ bool take_page_off_buddy(struct page *page)
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
index ac45a5f4e7b9f..521ed32bdbf67 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -218,6 +218,7 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 	struct page *buddy;
 
 	zone = page_zone(page);
+	luf_takeoff_start();
 	spin_lock_irqsave(&zone->lock, flags);
 	if (!is_migrate_isolate_page(page))
 		goto out;
@@ -236,7 +237,7 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 			buddy = find_buddy_page_pfn(page, page_to_pfn(page),
 						    order, NULL);
 			if (buddy && !is_migrate_isolate_page(buddy)) {
-				isolated_page = !!__isolate_free_page(page, order);
+				isolated_page = !!__isolate_free_page(page, order, true);
 				/*
 				 * Isolating a free page in an isolated pageblock
 				 * is expected to always work as watermarks don't
@@ -276,6 +277,7 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
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


