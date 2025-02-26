Return-Path: <linux-kernel+bounces-533727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8C4A45E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB0D1787F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF078221F1F;
	Wed, 26 Feb 2025 12:01:55 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9619921D3D1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571314; cv=none; b=cq3Slnka17J5kOQE1KcyoxtLKBIlGIcLgXrv30Q7tA6NdPcRorzR5SVnMTNjPcKx4JJhBFJegIr2QJvrW8vQVV0dqW4/X3bRYaMSe5ohEDnKZrPM167oxXuPoWTKSpFkywPMFRe3hVqAYjarg18xGsXOhrB31JCgMHM8iv9owZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571314; c=relaxed/simple;
	bh=YsLYZiBGTqtrt3a4pYYZevFKPFB5CPMwsaWnczL6SXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BZmhypcUIX0Mho0D0lG5gSFh/i3G9ko92gJTZ3F891Y0zijWYOmQ9ncuXqvLN6cy/t+bzD4tG/E86dMNoBwzz1eI9uScgLqE23W2nRXd110QWZ0kgXNRVPAf2WqQt3GywAW9zhRDHa5QI/fGoGSbVF04ai40d2fSsUqrQcw6UxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-03-67bf02a63501
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 13/25] mm: introduce pend_list in struct free_area to track luf'd pages
Date: Wed, 26 Feb 2025 21:01:20 +0900
Message-Id: <20250226120132.28469-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC9ZZnke5ypv3pBg0nWC3mrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK2PX9j7Wgp+TGStu3n7O3sC4p6yL
	kZNDQsBEou/yC0YYu7PpNxOIzSagLnHjxk9mEFtEwEziYOsf9i5GLg5mgWVMEntPNLCBOMIC
	7YwSu24uBOtgEVCV+PmuD6iKg4MXqOP0aWaIofISqzccALM5gcL/dv9mB7GFBJIlWtb/ZgGZ
	IyFwn01i0oopbBANkhIHV9xgmcDIu4CRYRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYGAvq/0T
	vYPx04XgQ4wCHIxKPLwPzuxNF2JNLCuuzD3EKMHBrCTCy5m5J12INyWxsiq1KD++qDQntfgQ
	ozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDY0PNlS3abHmOf3L/CKxPFpmz7e2/xb+S
	Wi4q5jz/7nzisMn5j+EiViqFN/31l+jeYA/0td+WknVctLNa6+BC6do5ufNNYjOVt76dp3dk
	Sv7NOBnx66eWcez+ajr94MONicfsb8xOSRK/FC1/+atK+9vLlr1fltdat+7nSv+Q5hBlf3X9
	PHOLw0osxRmJhlrMRcWJAJQ/EGpoAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6Qdsdc4s569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgydm3vYy34OZmx
	4ubt5+wNjHvKuhg5OSQETCQ6m34zgdhsAuoSN278ZAaxRQTMJA62/mHvYuTiYBZYxiSx90QD
	G4gjLNDOKLHr5kKwDhYBVYmf7/qAqjg4eIE6Tp9mhhgqL7F6wwEwmxMo/G/3b3YQW0ggWaJl
	/W+WCYxcCxgZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgSG6bLaPxN3MH657H6IUYCDUYmH
	98GZvelCrIllxZW5hxglOJiVRHg5M/ekC/GmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJI
	TyxJzU5NLUgtgskycXBKNTCaMf0L1js+P7rvQ+EZp237pbc3tarcr7sktfh5zFXR+o75b3Zc
	3Pu3yTPl1MbfW5wiMr+uilKsbPM3uhJhdUJHKKbm3Y6FZjN2eyYy3u/ZfzlowlG91vdLM+7+
	W/wgb2/Lpu7FV5edX8e81UKwQ3E2xwfWagbHuqvyelZhfxcy/9Azqv/7wvmqEktxRqKhFnNR
	cSIA4pPk1E8CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

luf'd pages requires tlb shootdown on exiting from page allocator. For
some page allocation request, it's okay to return luf'd page followed by
tlb shootdown but it's not okay for e.g. irq context.

This patch splitted the list in free_area into two, 'free_list' for
non-luf'd pages and 'pend_list' for luf'd pages so that the buddy
allocator can work better with various conditions of context.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mmzone.h  |   3 ++
 kernel/power/snapshot.c |  14 ++++++
 kernel/vmcore_info.c    |   2 +
 mm/compaction.c         |  33 ++++++++++---
 mm/internal.h           |  17 ++++++-
 mm/mm_init.c            |   2 +
 mm/page_alloc.c         | 105 ++++++++++++++++++++++++++++++++++------
 mm/page_reporting.c     |  22 ++++++---
 mm/vmstat.c             |  15 ++++++
 9 files changed, 184 insertions(+), 29 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 550dbba92521a..9294cbbe698fc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -116,6 +116,7 @@ extern int page_group_by_mobility_disabled;
 			MIGRATETYPE_MASK)
 struct free_area {
 	struct list_head	free_list[MIGRATE_TYPES];
+	struct list_head	pend_list[MIGRATE_TYPES];
 	unsigned long		nr_free;
 };
 
@@ -1014,6 +1015,8 @@ struct zone {
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
+	/* Count pages that need tlb shootdown on allocation */
+	atomic_long_t		nr_luf_pages;
 } ____cacheline_internodealigned_in_smp;
 
 enum pgdat_flags {
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c9fb559a63993..ca10796855aba 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1285,6 +1285,20 @@ static void mark_free_pages(struct zone *zone)
 				swsusp_set_page_free(pfn_to_page(pfn + i));
 			}
 		}
+
+		list_for_each_entry(page,
+				&zone->free_area[order].pend_list[t], buddy_list) {
+			unsigned long i;
+
+			pfn = page_to_pfn(page);
+			for (i = 0; i < (1UL << order); i++) {
+				if (!--page_count) {
+					touch_nmi_watchdog();
+					page_count = WD_PAGE_COUNT;
+				}
+				swsusp_set_page_free(pfn_to_page(pfn + i));
+			}
+		}
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index 1fec61603ef32..638deb57f9ddd 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -188,11 +188,13 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_OFFSET(zone, vm_stat);
 	VMCOREINFO_OFFSET(zone, spanned_pages);
 	VMCOREINFO_OFFSET(free_area, free_list);
+	VMCOREINFO_OFFSET(free_area, pend_list);
 	VMCOREINFO_OFFSET(list_head, next);
 	VMCOREINFO_OFFSET(list_head, prev);
 	VMCOREINFO_LENGTH(zone.free_area, NR_PAGE_ORDERS);
 	log_buf_vmcoreinfo_setup();
 	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
+	VMCOREINFO_LENGTH(free_area.pend_list, MIGRATE_TYPES);
 	VMCOREINFO_NUMBER(NR_FREE_PAGES);
 	VMCOREINFO_NUMBER(PG_lru);
 	VMCOREINFO_NUMBER(PG_private);
diff --git a/mm/compaction.c b/mm/compaction.c
index bf5ded83b9dd1..5dfa53252d75b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1592,24 +1592,28 @@ static void fast_isolate_freepages(struct compact_control *cc)
 	     order = next_search_order(cc, order)) {
 		struct free_area *area = &cc->zone->free_area[order];
 		struct list_head *freelist;
+		struct list_head *high_pfn_list;
 		struct page *freepage;
 		unsigned long flags;
 		unsigned int order_scanned = 0;
 		unsigned long high_pfn = 0;
+		bool consider_pend = false;
+		bool can_shootdown;
 
 		if (!area->nr_free)
 			continue;
 
-		luf_takeoff_start();
+		can_shootdown = luf_takeoff_start();
 		spin_lock_irqsave(&cc->zone->lock, flags);
 		freelist = &area->free_list[MIGRATE_MOVABLE];
+retry:
 		list_for_each_entry_reverse(freepage, freelist, buddy_list) {
 			unsigned long pfn;
 
 			order_scanned++;
 			nr_scanned++;
 
-			if (!luf_takeoff_check(freepage))
+			if (unlikely(consider_pend && !luf_takeoff_check(freepage)))
 				goto scan_next;
 
 			pfn = page_to_pfn(freepage);
@@ -1622,26 +1626,34 @@ static void fast_isolate_freepages(struct compact_control *cc)
 				cc->fast_search_fail = 0;
 				cc->search_order = order;
 				page = freepage;
-				break;
+				goto done;
 			}
 
 			if (pfn >= min_pfn && pfn > high_pfn) {
 				high_pfn = pfn;
+				high_pfn_list = freelist;
 
 				/* Shorten the scan if a candidate is found */
 				limit >>= 1;
 			}
 scan_next:
 			if (order_scanned >= limit)
-				break;
+				goto done;
 		}
 
+		if (!consider_pend && can_shootdown) {
+			consider_pend = true;
+			freelist = &area->pend_list[MIGRATE_MOVABLE];
+			goto retry;
+		}
+done:
 		/* Use a maximum candidate pfn if a preferred one was not found */
 		if (!page && high_pfn) {
 			page = pfn_to_page(high_pfn);
 
 			/* Update freepage for the list reorder below */
 			freepage = page;
+			freelist = high_pfn_list;
 		}
 
 		/* Reorder to so a future search skips recent pages */
@@ -2040,18 +2052,20 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
 		struct list_head *freelist;
 		unsigned long flags;
 		struct page *freepage;
+		bool consider_pend = false;
 
 		if (!area->nr_free)
 			continue;
 
 		spin_lock_irqsave(&cc->zone->lock, flags);
 		freelist = &area->free_list[MIGRATE_MOVABLE];
+retry:
 		list_for_each_entry(freepage, freelist, buddy_list) {
 			unsigned long free_pfn;
 
 			if (nr_scanned++ >= limit) {
 				move_freelist_tail(freelist, freepage);
-				break;
+				goto done;
 			}
 
 			free_pfn = page_to_pfn(freepage);
@@ -2074,9 +2088,16 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
 					pfn = cc->zone->zone_start_pfn;
 				cc->fast_search_fail = 0;
 				found_block = true;
-				break;
+				goto done;
 			}
 		}
+
+		if (!consider_pend) {
+			consider_pend = true;
+			freelist = &area->pend_list[MIGRATE_MOVABLE];
+			goto retry;
+		}
+done:
 		spin_unlock_irqrestore(&cc->zone->lock, flags);
 	}
 
diff --git a/mm/internal.h b/mm/internal.h
index 77b7e6d0bcc29..d34fd43086d89 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -865,11 +865,16 @@ static inline void init_cma_pageblock(struct page *page)
 int find_suitable_fallback(struct free_area *area, unsigned int order,
 			int migratetype, bool only_stealable, bool *can_steal);
 
-static inline bool free_area_empty(struct free_area *area, int migratetype)
+static inline bool free_list_empty(struct free_area *area, int migratetype)
 {
 	return list_empty(&area->free_list[migratetype]);
 }
 
+static inline bool free_area_empty(struct free_area *area, int migratetype)
+{
+	return list_empty(&area->free_list[migratetype]) &&
+	       list_empty(&area->pend_list[migratetype]);
+}
 /* mm/util.c */
 struct anon_vma *folio_anon_vma(const struct folio *folio);
 
@@ -1605,12 +1610,22 @@ void luf_takeoff_end(void);
 bool luf_takeoff_no_shootdown(void);
 bool luf_takeoff_check(struct page *page);
 bool luf_takeoff_check_and_fold(struct page *page);
+
+static inline bool non_luf_pages_ok(struct zone *zone)
+{
+	unsigned long nr_free = zone_page_state(zone, NR_FREE_PAGES);
+	unsigned long min_wm = min_wmark_pages(zone);
+	unsigned long nr_luf_pages = atomic_long_read(&zone->nr_luf_pages);
+
+	return nr_free - nr_luf_pages > min_wm;
+}
 #else
 static inline bool luf_takeoff_start(void) { return false; }
 static inline void luf_takeoff_end(void) {}
 static inline bool luf_takeoff_no_shootdown(void) { return true; }
 static inline bool luf_takeoff_check(struct page *page) { return true; }
 static inline bool luf_takeoff_check_and_fold(struct page *page) { return true; }
+static inline bool non_luf_pages_ok(struct zone *zone) { return true; }
 #endif
 
 /* pagewalk.c */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 133640a93d1da..81c5060496112 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1421,12 +1421,14 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 	unsigned int order, t;
 	for_each_migratetype_order(order, t) {
 		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
+		INIT_LIST_HEAD(&zone->free_area[order].pend_list[t]);
 		zone->free_area[order].nr_free = 0;
 	}
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	INIT_LIST_HEAD(&zone->unaccepted_pages);
 #endif
+	atomic_long_set(&zone->nr_luf_pages, 0);
 }
 
 void __meminit init_currently_empty_zone(struct zone *zone,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a0182421da13e..530c5c16ab323 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -804,15 +804,28 @@ static inline void __add_to_free_list(struct page *page, struct zone *zone,
 				      bool tail)
 {
 	struct free_area *area = &zone->free_area[order];
+	struct list_head *list;
 
 	VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
 		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
 		     get_pageblock_migratetype(page), migratetype, 1 << order);
 
+	/*
+	 * When identifying whether a page requires tlb shootdown, false
+	 * positive is okay because it will cause just additional tlb
+	 * shootdown.
+	 */
+	if (page_luf_key(page)) {
+		list = &area->pend_list[migratetype];
+		atomic_long_add(1 << order, &zone->nr_luf_pages);
+	} else
+		list = &area->free_list[migratetype];
+
 	if (tail)
-		list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
+		list_add_tail(&page->buddy_list, list);
 	else
-		list_add(&page->buddy_list, &area->free_list[migratetype]);
+		list_add(&page->buddy_list, list);
+
 	area->nr_free++;
 }
 
@@ -831,7 +844,20 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
 		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
 		     get_pageblock_migratetype(page), old_mt, 1 << order);
 
-	list_move_tail(&page->buddy_list, &area->free_list[new_mt]);
+	/*
+	 * The page might have been taken from a pfn where it's not
+	 * clear which list was used.  Therefore, conservatively
+	 * consider it as pend_list, not to miss any true ones that
+	 * require tlb shootdown.
+	 *
+	 * When identifying whether a page requires tlb shootdown, false
+	 * positive is okay because it will cause just additional tlb
+	 * shootdown.
+	 */
+	if (page_luf_key(page))
+		list_move_tail(&page->buddy_list, &area->pend_list[new_mt]);
+	else
+		list_move_tail(&page->buddy_list, &area->free_list[new_mt]);
 
 	account_freepages(zone, -(1 << order), old_mt);
 	account_freepages(zone, 1 << order, new_mt);
@@ -848,6 +874,9 @@ static inline void __del_page_from_free_list(struct page *page, struct zone *zon
 	if (page_reported(page))
 		__ClearPageReported(page);
 
+	if (page_luf_key(page))
+		atomic_long_sub(1 << order, &zone->nr_luf_pages);
+
 	list_del(&page->buddy_list);
 	__ClearPageBuddy(page);
 	zone->free_area[order].nr_free--;
@@ -866,15 +895,48 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
 	account_freepages(zone, -(1 << order), migratetype);
 }
 
-static inline struct page *get_page_from_free_area(struct free_area *area,
-					    int migratetype)
+static inline struct page *get_page_from_free_area(struct zone *zone,
+		struct free_area *area, int migratetype)
 {
-	struct page *page = list_first_entry_or_null(&area->free_list[migratetype],
-					struct page, buddy_list);
+	struct page *page;
+	bool pend_first;
 
-	if (page && luf_takeoff_check(page))
-		return page;
+	/*
+	 * XXX: Make the decision preciser if needed e.g. using
+	 * zone_watermark_ok() or its family, but for now, don't want to
+	 * make it heavier.
+	 *
+	 * Try free_list, holding non-luf pages, first if there are
+	 * enough non-luf pages to aggressively defer tlb flush, but
+	 * should try pend_list first instead if not.
+	 */
+	pend_first = !non_luf_pages_ok(zone);
+
+	if (pend_first) {
+		page = list_first_entry_or_null(&area->pend_list[migratetype],
+				struct page, buddy_list);
+
+		if (page && luf_takeoff_check(page))
+			return page;
+
+		page = list_first_entry_or_null(&area->free_list[migratetype],
+				struct page, buddy_list);
+
+		if (page)
+			return page;
+	} else {
+		page = list_first_entry_or_null(&area->free_list[migratetype],
+				struct page, buddy_list);
+
+		if (page)
+			return page;
 
+		page = list_first_entry_or_null(&area->pend_list[migratetype],
+				struct page, buddy_list);
+
+		if (page && luf_takeoff_check(page))
+			return page;
+	}
 	return NULL;
 }
 
@@ -1027,6 +1089,8 @@ static inline void __free_one_page(struct page *page,
 
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
+	else if (page_luf_key(page))
+		to_tail = true;
 	else if (is_shuffle_order(order))
 		to_tail = shuffle_pick_tail();
 	else
@@ -1630,6 +1694,8 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 	unsigned int nr_added = 0;
 
 	while (high > low) {
+		bool tail = false;
+
 		high--;
 		size >>= 1;
 		VM_BUG_ON_PAGE(bad_range(zone, &page[size]), &page[size]);
@@ -1643,7 +1709,10 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		if (set_page_guard(zone, &page[size], high))
 			continue;
 
-		__add_to_free_list(&page[size], zone, high, migratetype, false);
+		if (page_luf_key(&page[size]))
+			tail = true;
+
+		__add_to_free_list(&page[size], zone, high, migratetype, tail);
 		set_buddy_order(&page[size], high);
 		nr_added += size;
 	}
@@ -1827,7 +1896,7 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 	/* Find a page of the appropriate size in the preferred list */
 	for (current_order = order; current_order < NR_PAGE_ORDERS; ++current_order) {
 		area = &(zone->free_area[current_order]);
-		page = get_page_from_free_area(area, migratetype);
+		page = get_page_from_free_area(zone, area, migratetype);
 		if (!page)
 			continue;
 
@@ -2269,7 +2338,8 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 		if (free_area_empty(area, fallback_mt))
 			continue;
 
-		if (luf_takeoff_no_shootdown())
+		if (free_list_empty(area, fallback_mt) &&
+		    luf_takeoff_no_shootdown())
 			continue;
 
 		if (can_steal_fallback(order, migratetype))
@@ -2373,7 +2443,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			struct free_area *area = &(zone->free_area[order]);
 			int mt;
 
-			page = get_page_from_free_area(area, MIGRATE_HIGHATOMIC);
+			page = get_page_from_free_area(zone, area, MIGRATE_HIGHATOMIC);
 			if (!page)
 				continue;
 
@@ -2511,7 +2581,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	VM_BUG_ON(current_order > MAX_PAGE_ORDER);
 
 do_steal:
-	page = get_page_from_free_area(area, fallback_mt);
+	page = get_page_from_free_area(zone, area, fallback_mt);
 
 	/* take off list, maybe claim block, expand remainder */
 	page = steal_suitable_fallback(zone, page, current_order, order,
@@ -7133,6 +7203,8 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 	struct page *current_buddy;
 
 	while (high > low) {
+		bool tail = false;
+
 		high--;
 		size >>= 1;
 
@@ -7146,7 +7218,10 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 		if (set_page_guard(zone, current_buddy, high))
 			continue;
 
-		add_to_free_list(current_buddy, zone, high, migratetype, false);
+		if (page_luf_key(current_buddy))
+			tail = true;
+
+		add_to_free_list(current_buddy, zone, high, migratetype, tail);
 		set_buddy_order(current_buddy, high);
 	}
 }
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 03a7f5f6dc073..e152b22fbba8a 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -159,15 +159,17 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	struct page *page, *next;
 	long budget;
 	int err = 0;
+	bool consider_pend = false;
+	bool can_shootdown;
 
 	/*
 	 * Perform early check, if free area is empty there is
 	 * nothing to process so we can skip this free_list.
 	 */
-	if (list_empty(list))
+	if (free_area_empty(area, mt))
 		return err;
 
-	luf_takeoff_start();
+	can_shootdown = luf_takeoff_start();
 	spin_lock_irq(&zone->lock);
 
 	/*
@@ -185,14 +187,14 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	 * should always be a power of 2.
 	 */
 	budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);
-
+retry:
 	/* loop through free list adding unreported pages to sg list */
 	list_for_each_entry_safe(page, next, list, lru) {
 		/* We are going to skip over the reported pages. */
 		if (PageReported(page))
 			continue;
 
-		if (!luf_takeoff_check(page)) {
+		if (unlikely(consider_pend && !luf_takeoff_check(page))) {
 			VM_WARN_ON(1);
 			continue;
 		}
@@ -205,14 +207,14 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		if (budget < 0) {
 			atomic_set(&prdev->state, PAGE_REPORTING_REQUESTED);
 			next = page;
-			break;
+			goto done;
 		}
 
 		/* Attempt to pull page from list and place in scatterlist */
 		if (*offset) {
 			if (!__isolate_free_page(page, order, false)) {
 				next = page;
-				break;
+				goto done;
 			}
 
 			/* Add page to scatter list */
@@ -263,9 +265,15 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 
 		/* exit on error */
 		if (err)
-			break;
+			goto done;
 	}
 
+	if (!consider_pend && can_shootdown) {
+		consider_pend = true;
+		list = &area->pend_list[mt];
+		goto retry;
+	}
+done:
 	/* Rotate any leftover pages to the head of the freelist */
 	if (!list_entry_is_head(next, list, lru) && !list_is_first(&next->lru, list))
 		list_rotate_to_front(&next->lru, list);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 16bfe1c694dd4..5ae5ac9f0a4a9 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1581,6 +1581,21 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 					break;
 				}
 			}
+			list_for_each(curr, &area->pend_list[mtype]) {
+				/*
+				 * Cap the pend_list iteration because it might
+				 * be really large and we are under a spinlock
+				 * so a long time spent here could trigger a
+				 * hard lockup detector. Anyway this is a
+				 * debugging tool so knowing there is a handful
+				 * of pages of this order should be more than
+				 * sufficient.
+				 */
+				if (++freecount >= 100000) {
+					overflow = true;
+					break;
+				}
+			}
 			seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
 			spin_unlock_irq(&zone->lock);
 			cond_resched();
-- 
2.17.1


