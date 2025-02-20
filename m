Return-Path: <linux-kernel+bounces-522992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0FAA3D0E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE42A3A47EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B90F1EB185;
	Thu, 20 Feb 2025 05:36:09 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2BB1E411C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029767; cv=none; b=e3Lg35TSzWnVEAYEmFhzqy8KI/sbkiNxfmUKQXWSfdLu1fDbBacnUWTsh/2KKHvsW+DSDrT2Uqd6eS3UbhsVEsXOtGPMbSYKzZ5zOcLk/+ZprtGcA2MM9HM/taEMaU9opQZb8/8jcjRnRIy3BcT8UhwJzdiYFhr5ii6lLczVb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029767; c=relaxed/simple;
	bh=xsHN83I7sYhT0LId4D+/9zqGo2XyB2ZkUuHcLOADkN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BT2vXQfralWyjwvaopuNDPHt3p1IFJe8AM9uuGAoBYVv2OGwcNGNmfotld8XDIBwygXR5xldcfJ6vXx7IqAPqP0P07AS86IbymqCg758K8BrwV3YZF/b7d5lX1P+5E4Fz93LqoduNLL+lq9T11szf935xTNz6ObxcYyBW9K12jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-e5-67b6bba63df4
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
Subject: [RFC PATCH v12 11/26] mm: deliver luf_key to pcp or buddy on free after unmapping
Date: Thu, 20 Feb 2025 14:20:12 +0900
Message-Id: <20250220052027.58847-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnoe6y3dvSDe5tMbCYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	vd82shUsb2esmNrdwtbAuDS3i5GTQ0LARGLi79NMMPaKpmuMIDabgLrEjRs/mUFsEQEziYOt
	f9hBbGaBu0wSB/rZQGxhgSiJZ18/sYDYLAKqElN+tQDVcHDwAtX3rMuAGCkvsXrDAbAxnEDh
	HzN6wVqFBEwl3i24BLSWC6jmM5vElo19zBANkhIHV9xgmcDIu4CRYRWjUGZeWW5iZo6JXkZl
	XmaFXnJ+7iZGYOgvq/0TvYPx04XgQ4wCHIxKPLwzWrelC7EmlhVX5h5ilOBgVhLhbavfki7E
	m5JYWZValB9fVJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qBMXnmpRM6aZlm
	j5xl2bZV/gtaMClEdGbDi4ePT3x6/qDtoNzhgzuvvNXVrvvxTCm6XbRea3LlrR8iQjc3/Fmb
	UOr/bM3aiXUr8nJvz0+cuG/V/jOMz7Zs61nxbGvHlV0Lkp9L3LTOaXDNk7l06rqcW/7FXFPv
	Z/v5VZc+y5i2WqS+ivdV2MHZdYpKLMUZiYZazEXFiQCY1sPSeQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g8ZLqhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgyuj9tpGtYHk7Y8XU7ha2BsaluV2MnBwSAiYSK5quMYLYbALqEjdu/GQGsUUE
	zCQOtv5hB7GZBe4ySRzoZwOxhQWiJJ59/cQCYrMIqEpM+dUCVMPBwQtU37MuA2KkvMTqDQfA
	xnAChX/M6AVrFRIwlXi34BLTBEauBYwMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQIDeVnt
	n4k7GL9cdj/EKMDBqMTD++Dx1nQh1sSy4srcQ4wSHMxKIrxt9VvShXhTEiurUovy44tKc1KL
	DzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhjdRPmd/t9OuqkS7a9ccOAc09F/Hy4E
	HvtpzrVyvfKdBJddIp63Qg/MnHJNm/H00bun4lduuX4yMu+7SkXb1v11M0o26tfc/3Jmj8e7
	2uYsr6AD257sXsne+XR3SvfvsHf9Lh63eTaln1jzdf46CeuNjnK1KlUXfsSrtWRMj/ok2XaX
	Me/aFq1SJZbijERDLeai4kQAPKqb5WACAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
needs to pass luf_key to pcp or buddy allocator on free after unmapping
e.g. during page reclaim or page migration.

The luf_key will be used to track need of tlb shootdown and which cpus
need to perform tlb flush, per page residing in pcp or buddy, and should
be handed over properly when pages travel between pcp and buddy.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/internal.h       |   4 +-
 mm/page_alloc.c     | 120 ++++++++++++++++++++++++++++++++------------
 mm/page_isolation.c |   6 +++
 mm/page_reporting.c |   6 +++
 mm/swap.c           |   4 +-
 mm/vmscan.c         |   8 +--
 6 files changed, 109 insertions(+), 39 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 55bc8ca0d6118..2bb54bc04260b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -741,8 +741,8 @@ extern bool free_pages_prepare(struct page *page, unsigned int order);
 
 extern int user_min_free_kbytes;
 
-void free_unref_page(struct page *page, unsigned int order);
-void free_unref_folios(struct folio_batch *fbatch);
+void free_unref_page(struct page *page, unsigned int order, unsigned short luf_key);
+void free_unref_folios(struct folio_batch *fbatch, unsigned short luf_key);
 
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cac2c95ca2430..05a1098f8c61f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -212,7 +212,7 @@ unsigned int pageblock_order __read_mostly;
 #endif
 
 static void __free_pages_ok(struct page *page, unsigned int order,
-			    fpi_t fpi_flags);
+			    fpi_t fpi_flags, unsigned short luf_key);
 
 /*
  * results with 256, 32 in the lowmem_reserve sysctl:
@@ -850,8 +850,13 @@ static inline void __del_page_from_free_list(struct page *page, struct zone *zon
 
 	list_del(&page->buddy_list);
 	__ClearPageBuddy(page);
-	set_page_private(page, 0);
 	zone->free_area[order].nr_free--;
+
+	/*
+	 * Keep head page's private until post_alloc_hook().
+	 *
+	 * XXX: Tail pages' private doesn't get cleared.
+	 */
 }
 
 static inline void del_page_from_free_list(struct page *page, struct zone *zone,
@@ -920,7 +925,7 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
 static inline void __free_one_page(struct page *page,
 		unsigned long pfn,
 		struct zone *zone, unsigned int order,
-		int migratetype, fpi_t fpi_flags)
+		int migratetype, fpi_t fpi_flags, unsigned short luf_key)
 {
 	struct capture_control *capc = task_capc(zone);
 	unsigned long buddy_pfn = 0;
@@ -937,10 +942,21 @@ static inline void __free_one_page(struct page *page,
 
 	account_freepages(zone, 1 << order, migratetype);
 
+	/*
+	 * Use the page's luf_key unchanged if luf_key == 0.  Worth
+	 * noting that page_luf_key() will be 0 in most cases since it's
+	 * initialized at free_pages_prepare().
+	 */
+	if (luf_key)
+		set_page_luf_key(page, luf_key);
+	else
+		luf_key = page_luf_key(page);
+
 	while (order < MAX_PAGE_ORDER) {
 		int buddy_mt = migratetype;
+		unsigned short buddy_luf_key;
 
-		if (compaction_capture(capc, page, order, migratetype)) {
+		if (!luf_key && compaction_capture(capc, page, order, migratetype)) {
 			account_freepages(zone, -(1 << order), migratetype);
 			return;
 		}
@@ -973,6 +989,18 @@ static inline void __free_one_page(struct page *page,
 		else
 			__del_page_from_free_list(buddy, zone, order, buddy_mt);
 
+		/*
+		 * !buddy_luf_key && !luf_key : do nothing
+		 *  buddy_luf_key && !luf_key : luf_key = buddy_luf_key
+		 * !buddy_luf_key &&  luf_key : do nothing
+		 *  buddy_luf_key &&  luf_key : merge two into luf_key
+		 */
+		buddy_luf_key = page_luf_key(buddy);
+		if (buddy_luf_key && !luf_key)
+			luf_key = buddy_luf_key;
+		else if (buddy_luf_key && luf_key)
+			fold_luf_batch(&luf_batch[luf_key], &luf_batch[buddy_luf_key]);
+
 		if (unlikely(buddy_mt != migratetype)) {
 			/*
 			 * Match buddy type. This ensures that an
@@ -984,6 +1012,7 @@ static inline void __free_one_page(struct page *page,
 
 		combined_pfn = buddy_pfn & pfn;
 		page = page + (combined_pfn - pfn);
+		set_page_luf_key(page, luf_key);
 		pfn = combined_pfn;
 		order++;
 	}
@@ -1164,6 +1193,11 @@ __always_inline bool free_pages_prepare(struct page *page,
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
+	/*
+	 * Ensure private is zero before using it inside allocator.
+	 */
+	set_page_private(page, 0);
+
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
 
@@ -1329,7 +1363,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
-			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
+			__free_one_page(page, pfn, zone, order, mt, FPI_NONE, 0);
+
 			trace_mm_page_pcpu_drain(page, order, mt);
 		} while (count > 0 && !list_empty(list));
 	}
@@ -1353,7 +1388,7 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	while (pfn != end) {
 		int mt = get_pfnblock_migratetype(page, pfn);
 
-		__free_one_page(page, pfn, zone, order, mt, fpi);
+		__free_one_page(page, pfn, zone, order, mt, fpi, 0);
 		pfn += 1 << order;
 		page = pfn_to_page(pfn);
 	}
@@ -1361,11 +1396,18 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 
 static void free_one_page(struct zone *zone, struct page *page,
 			  unsigned long pfn, unsigned int order,
-			  fpi_t fpi_flags)
+			  fpi_t fpi_flags, unsigned short luf_key)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&zone->lock, flags);
+
+	/*
+	 * valid luf_key can be passed only if order == 0.
+	 */
+	VM_WARN_ON(luf_key && order);
+	set_page_luf_key(page, luf_key);
+
 	split_large_buddy(zone, page, pfn, order, fpi_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
@@ -1373,13 +1415,13 @@ static void free_one_page(struct zone *zone, struct page *page,
 }
 
 static void __free_pages_ok(struct page *page, unsigned int order,
-			    fpi_t fpi_flags)
+			    fpi_t fpi_flags, unsigned short luf_key)
 {
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
 	if (free_pages_prepare(page, order))
-		free_one_page(zone, page, pfn, order, fpi_flags);
+		free_one_page(zone, page, pfn, order, fpi_flags, luf_key);
 }
 
 void __meminit __free_pages_core(struct page *page, unsigned int order,
@@ -1433,7 +1475,7 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
 	 * Bypass PCP and place fresh pages right to the tail, primarily
 	 * relevant for memory onlining.
 	 */
-	__free_pages_ok(page, order, FPI_TO_TAIL);
+	__free_pages_ok(page, order, FPI_TO_TAIL, 0);
 }
 
 /*
@@ -2459,6 +2501,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		if (unlikely(page == NULL))
 			break;
 
+		/*
+		 * Keep the page's luf_key.
+		 */
+
 		/*
 		 * Split buddy pages returned by expand() are received here in
 		 * physical page order. The page is added to the tail of
@@ -2740,12 +2786,14 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 
 static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 				   struct page *page, int migratetype,
-				   unsigned int order)
+				   unsigned int order, unsigned short luf_key)
 {
 	int high, batch;
 	int pindex;
 	bool free_high = false;
 
+	set_page_luf_key(page, luf_key);
+
 	/*
 	 * On freeing, reduce the number of pages that are batch allocated.
 	 * See nr_pcp_alloc() where alloc_factor is increased for subsequent
@@ -2754,7 +2802,16 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	pcp->alloc_factor >>= 1;
 	__count_vm_events(PGFREE, 1 << order);
 	pindex = order_to_pindex(migratetype, order);
-	list_add(&page->pcp_list, &pcp->lists[pindex]);
+
+	/*
+	 * Defer tlb shootdown as much as possible by putting luf'd
+	 * pages to the tail.
+	 */
+	if (luf_key)
+		list_add_tail(&page->pcp_list, &pcp->lists[pindex]);
+	else
+		list_add(&page->pcp_list, &pcp->lists[pindex]);
+
 	pcp->count += 1 << order;
 
 	batch = READ_ONCE(pcp->batch);
@@ -2789,7 +2846,8 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 /*
  * Free a pcp page
  */
-void free_unref_page(struct page *page, unsigned int order)
+void free_unref_page(struct page *page, unsigned int order,
+		     unsigned short luf_key)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
@@ -2798,7 +2856,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	int migratetype;
 
 	if (!pcp_allowed_order(order)) {
-		__free_pages_ok(page, order, FPI_NONE);
+		__free_pages_ok(page, order, FPI_NONE, luf_key);
 		return;
 	}
 
@@ -2815,7 +2873,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	migratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(page_zone(page), page, pfn, order, FPI_NONE);
+			free_one_page(page_zone(page), page, pfn, order, FPI_NONE, luf_key);
 			return;
 		}
 		migratetype = MIGRATE_MOVABLE;
@@ -2825,10 +2883,10 @@ void free_unref_page(struct page *page, unsigned int order)
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_unref_page_commit(zone, pcp, page, migratetype, order);
+		free_unref_page_commit(zone, pcp, page, migratetype, order, luf_key);
 		pcp_spin_unlock(pcp);
 	} else {
-		free_one_page(zone, page, pfn, order, FPI_NONE);
+		free_one_page(zone, page, pfn, order, FPI_NONE, luf_key);
 	}
 	pcp_trylock_finish(UP_flags);
 }
@@ -2836,7 +2894,7 @@ void free_unref_page(struct page *page, unsigned int order)
 /*
  * Free a batch of folios
  */
-void free_unref_folios(struct folio_batch *folios)
+void free_unref_folios(struct folio_batch *folios, unsigned short luf_key)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp = NULL;
@@ -2857,7 +2915,7 @@ void free_unref_folios(struct folio_batch *folios)
 		 */
 		if (!pcp_allowed_order(order)) {
 			free_one_page(folio_zone(folio), &folio->page,
-				      pfn, order, FPI_NONE);
+				      pfn, order, FPI_NONE, luf_key);
 			continue;
 		}
 		folio->private = (void *)(unsigned long)order;
@@ -2893,7 +2951,7 @@ void free_unref_folios(struct folio_batch *folios)
 			 */
 			if (is_migrate_isolate(migratetype)) {
 				free_one_page(zone, &folio->page, pfn,
-					      order, FPI_NONE);
+					      order, FPI_NONE, luf_key);
 				continue;
 			}
 
@@ -2906,7 +2964,7 @@ void free_unref_folios(struct folio_batch *folios)
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, &folio->page, pfn,
-					      order, FPI_NONE);
+					      order, FPI_NONE, luf_key);
 				continue;
 			}
 			locked_zone = zone;
@@ -2921,7 +2979,7 @@ void free_unref_folios(struct folio_batch *folios)
 
 		trace_mm_page_free_batched(&folio->page);
 		free_unref_page_commit(zone, pcp, &folio->page, migratetype,
-				order);
+				order, luf_key);
 	}
 
 	if (pcp) {
@@ -3013,7 +3071,7 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
 
 	/* Return isolated page to tail of freelist. */
 	__free_one_page(page, page_to_pfn(page), zone, order, mt,
-			FPI_SKIP_REPORT_NOTIFY | FPI_TO_TAIL);
+			FPI_SKIP_REPORT_NOTIFY | FPI_TO_TAIL, 0);
 }
 
 /*
@@ -4983,11 +5041,11 @@ void __free_pages(struct page *page, unsigned int order)
 	struct alloc_tag *tag = pgalloc_tag_get(page);
 
 	if (put_page_testzero(page))
-		free_unref_page(page, order);
+		free_unref_page(page, order, 0);
 	else if (!head) {
 		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
 		while (order-- > 0)
-			free_unref_page(page + (1 << order), order);
+			free_unref_page(page + (1 << order), order, 0);
 	}
 }
 EXPORT_SYMBOL(__free_pages);
@@ -5049,7 +5107,7 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
 
 	if (page_ref_sub_and_test(page, count))
-		free_unref_page(page, compound_order(page));
+		free_unref_page(page, compound_order(page), 0);
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
@@ -5090,7 +5148,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			goto refill;
 
 		if (unlikely(nc->pfmemalloc)) {
-			free_unref_page(page, compound_order(page));
+			free_unref_page(page, compound_order(page), 0);
 			goto refill;
 		}
 
@@ -5134,7 +5192,7 @@ void page_frag_free(void *addr)
 	struct page *page = virt_to_head_page(addr);
 
 	if (unlikely(put_page_testzero(page)))
-		free_unref_page(page, compound_order(page));
+		free_unref_page(page, compound_order(page), 0);
 }
 EXPORT_SYMBOL(page_frag_free);
 
@@ -5154,7 +5212,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 
 		last = page + (1UL << order);
 		for (page += nr; page < last; page++)
-			__free_pages_ok(page, 0, FPI_TO_TAIL);
+			__free_pages_ok(page, 0, FPI_TO_TAIL, 0);
 	}
 	return (void *)addr;
 }
@@ -7124,7 +7182,7 @@ bool put_page_back_buddy(struct page *page)
 		int migratetype = get_pfnblock_migratetype(page, pfn);
 
 		ClearPageHWPoisonTakenOff(page);
-		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
+		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE, 0);
 		if (TestClearPageHWPoison(page)) {
 			ret = true;
 		}
@@ -7193,7 +7251,7 @@ static void __accept_page(struct zone *zone, unsigned long *flags,
 
 	accept_memory(page_to_phys(page), PAGE_SIZE << MAX_PAGE_ORDER);
 
-	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
+	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL, 0);
 
 	if (last)
 		static_branch_dec(&zones_with_unaccepted_pages);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 7e04047977cfe..8467838d4dbc8 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -258,6 +258,12 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype));
 	} else {
 		set_pageblock_migratetype(page, migratetype);
+
+		/*
+		 * Do not clear the page's private to keep its luf_key
+		 * unchanged.
+		 */
+
 		__putback_isolated_page(page, order, migratetype);
 	}
 	zone->nr_isolate_pageblock--;
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e4c428e61d8c1..c05afb7a395f1 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -116,6 +116,12 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 		int mt = get_pageblock_migratetype(page);
 		unsigned int order = get_order(sg->length);
 
+		/*
+		 * Ensure private is zero before putting into the
+		 * allocator.
+		 */
+		set_page_private(page, 0);
+
 		__putback_isolated_page(page, order, mt);
 
 		/* If the pages were not reported due to error skip flagging */
diff --git a/mm/swap.c b/mm/swap.c
index 10decd9dffa17..54b0ba10dbb86 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -109,7 +109,7 @@ void __folio_put(struct folio *folio)
 	page_cache_release(folio);
 	folio_unqueue_deferred_split(folio);
 	mem_cgroup_uncharge(folio);
-	free_unref_page(&folio->page, folio_order(folio));
+	free_unref_page(&folio->page, folio_order(folio), 0);
 }
 EXPORT_SYMBOL(__folio_put);
 
@@ -959,7 +959,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 
 	folios->nr = j;
 	mem_cgroup_uncharge_folios(folios);
-	free_unref_folios(folios);
+	free_unref_folios(folios, 0);
 }
 EXPORT_SYMBOL(folios_put_refs);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76378bc257e38..2970a8f35d3d3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1480,7 +1480,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (folio_batch_add(&free_folios, folio) == 0) {
 			mem_cgroup_uncharge_folios(&free_folios);
 			try_to_unmap_flush();
-			free_unref_folios(&free_folios);
+			free_unref_folios(&free_folios, 0);
 		}
 		continue;
 
@@ -1548,7 +1548,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 	mem_cgroup_uncharge_folios(&free_folios);
 	try_to_unmap_flush();
-	free_unref_folios(&free_folios);
+	free_unref_folios(&free_folios, 0);
 
 	list_splice(&ret_folios, folio_list);
 	count_vm_events(PGACTIVATE, pgactivate);
@@ -1868,7 +1868,7 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 			if (folio_batch_add(&free_folios, folio) == 0) {
 				spin_unlock_irq(&lruvec->lru_lock);
 				mem_cgroup_uncharge_folios(&free_folios);
-				free_unref_folios(&free_folios);
+				free_unref_folios(&free_folios, 0);
 				spin_lock_irq(&lruvec->lru_lock);
 			}
 
@@ -1890,7 +1890,7 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 	if (free_folios.nr) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		mem_cgroup_uncharge_folios(&free_folios);
-		free_unref_folios(&free_folios);
+		free_unref_folios(&free_folios, 0);
 		spin_lock_irq(&lruvec->lru_lock);
 	}
 
-- 
2.17.1


