Return-Path: <linux-kernel+bounces-533748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54142A45E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658BE3B32B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA622173F;
	Wed, 26 Feb 2025 12:03:55 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFDE21C18D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571434; cv=none; b=GFxxOl/rmYlC1hx85eFF0jgteIH4BYUbxkiM5pXSE7+9dIDVAH+UdNtmWu9zzxriinZM+w/mk/jYRLTcvvMYpGxCyY/sDR8esZ1XDi4IjX3VZPOLBzlRutslE5GSF1troYAKqmOn832IpmMcvzbI8rN7txaLr7QopiXcCcBpVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571434; c=relaxed/simple;
	bh=DBYq9BC8Nw8U5PCz3KZ5A/OfIug8fUdgtxHEiMt27lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=O19RlbA1s53mAZSi3C1ztzxNvvHZWEZVIicIQM/b63EV4LtZNhU1q1uHx0wAT3RXtuZFzFshmxjR5o5jkoxt0FfqN8qxj3kmdE8zWDPGfRiiMfCjPXeWyTaThpPW128y/bCogolAGgtMa3drnndyY5Kf9I56K12N8YI2bvam/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-28-67bf0322c4b0
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
Subject: [RFC PATCH v12 based on v6.14-rc4 11/25] mm: deliver luf_key to pcp or buddy on free after unmapping
Date: Wed, 26 Feb 2025 21:03:22 +0900
Message-Id: <20250226120336.29565-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnka4S8/50g5YTJhZz1q9hs/i84R+b
	xdf1v5gtnn7qY7G4vGsOm8W9Nf9ZLc7vWstqsWPpPiaLSwcWMFkc7z3AZDH/3mc2i82bpjJb
	HJ8yldHi9485bA58Ht9b+1g8ds66y+6xYFOpx+YVWh6bVnWyeWz6NInd4925c+weJ2b8ZvF4
	v+8qm8fWX3YejVOvsXl83iQXwBPFZZOSmpNZllqkb5fAlbF13nKWgq39jBVnz3xibWCcXtLF
	yMkhIWAicWvGQVYY+96WBcwgNpuAusSNGz/BbBEBM4mDrX/Yuxi5OJgFljFJ7D3RwAaSEBbI
	lZh1bgaYzSKgKvF4z3V2EJsXqOF+y3cmiKHyEqs3HAAbxAkU/zTtGFi9kECyxM7ff6BqbrNJ
	rHpWB2FLShxccYNlAiPvAkaGVYxCmXlluYmZOSZ6GZV5mRV6yfm5mxiBYb2s9k/0DsZPF4IP
	MQpwMCrx8D44szddiDWxrLgy9xCjBAezkggvZ+aedCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
	Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2MvMbTNy+Udvp1zvxPxbQwDdPkpSZn3QJDznf1su2S
	ZGDZrha79HEx04Wflzd+Oqyde/zJlvDsDU6MwuYtErEeuhOFl9sHFxx4/G6VULpQQcxb1oeN
	7T++Hpet7WS4HdAmUfbWKmlmliij9L7a2Rcto/bOs574O/T9l0q7g8ePNIfWiP7pZDikxFKc
	kWioxVxUnAgA1FsgaGcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/d4NFXLYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgyts5bzlKwtZ+x
	4uyZT6wNjNNLuhg5OSQETCTubVnADGKzCahL3LjxE8wWETCTONj6h72LkYuDWWAZk8TeEw1s
	IAlhgVyJWedmgNksAqoSj/dcZwexeYEa7rd8Z4IYKi+xesMBsEGcQPFP046B1QsJJEvs/P2H
	aQIj1wJGhlWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBYbqs9s/EHYxfLrsfYhTgYFTi4X1w
	Zm+6EGtiWXFl7iFGCQ5mJRFezsw96UK8KYmVValF+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNL
	UrNTUwtSi2CyTBycUg2MM/YvqE/+/ZPVTEvALM/7kpmFk8fsC0V7Nxq+uclpet38q4Q595/P
	PbtOMX7S0r7S4n2T//R3V5MPB4yf7onxd7GaKl6Q+07u802WmxU3ruTJ+khqr3TT3/JmdTfv
	DpnVM35f4/PyKl9psFvwoNp3P55Sj7dCviKP31RXrP3z/APnK9EUuxu+SizFGYmGWsxFxYkA
	a0pgxE8CAAA=
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
 mm/internal.h        |   4 +-
 mm/page_alloc.c      | 116 ++++++++++++++++++++++++++++++++-----------
 mm/page_frag_cache.c |   6 +--
 mm/page_isolation.c  |   6 +++
 mm/page_reporting.c  |   6 +++
 mm/slub.c            |   2 +-
 mm/swap.c            |   4 +-
 mm/vmscan.c          |   8 +--
 8 files changed, 111 insertions(+), 41 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 5e67f009d23c6..47d3291278e81 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -746,8 +746,8 @@ struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, int nid,
 		nodemask_t *);
 #define __alloc_frozen_pages(...) \
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
-void free_frozen_pages(struct page *page, unsigned int order);
-void free_unref_folios(struct folio_batch *fbatch);
+void free_frozen_pages(struct page *page, unsigned int order, unsigned short luf_key);
+void free_unref_folios(struct folio_batch *fbatch, unsigned short luf_key);
 
 #ifdef CONFIG_NUMA
 struct page *alloc_frozen_pages_noprof(gfp_t, unsigned int order);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a964a98fbad51..d2d23bbd60467 100644
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
 	do {
 		int mt = get_pfnblock_migratetype(page, pfn);
 
-		__free_one_page(page, pfn, zone, order, mt, fpi);
+		__free_one_page(page, pfn, zone, order, mt, fpi, 0);
 		pfn += 1 << order;
 		if (pfn == end)
 			break;
@@ -1363,11 +1398,18 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 
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
 
@@ -1375,13 +1417,13 @@ static void free_one_page(struct zone *zone, struct page *page,
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
@@ -1429,7 +1471,7 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
 	 * Bypass PCP and place fresh pages right to the tail, primarily
 	 * relevant for memory onlining.
 	 */
-	__free_pages_ok(page, order, FPI_TO_TAIL);
+	__free_pages_ok(page, order, FPI_TO_TAIL, 0);
 }
 
 /*
@@ -2426,6 +2468,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		if (unlikely(page == NULL))
 			break;
 
+		/*
+		 * Keep the page's luf_key.
+		 */
+
 		/*
 		 * Split buddy pages returned by expand() are received here in
 		 * physical page order. The page is added to the tail of
@@ -2707,12 +2753,14 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 
 static void free_frozen_page_commit(struct zone *zone,
 		struct per_cpu_pages *pcp, struct page *page, int migratetype,
-		unsigned int order)
+		unsigned int order, unsigned short luf_key)
 {
 	int high, batch;
 	int pindex;
 	bool free_high = false;
 
+	set_page_luf_key(page, luf_key);
+
 	/*
 	 * On freeing, reduce the number of pages that are batch allocated.
 	 * See nr_pcp_alloc() where alloc_factor is increased for subsequent
@@ -2721,7 +2769,16 @@ static void free_frozen_page_commit(struct zone *zone,
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
@@ -2756,7 +2813,8 @@ static void free_frozen_page_commit(struct zone *zone,
 /*
  * Free a pcp page
  */
-void free_frozen_pages(struct page *page, unsigned int order)
+void free_frozen_pages(struct page *page, unsigned int order,
+		     unsigned short luf_key)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
@@ -2765,7 +2823,7 @@ void free_frozen_pages(struct page *page, unsigned int order)
 	int migratetype;
 
 	if (!pcp_allowed_order(order)) {
-		__free_pages_ok(page, order, FPI_NONE);
+		__free_pages_ok(page, order, FPI_NONE, luf_key);
 		return;
 	}
 
@@ -2783,7 +2841,7 @@ void free_frozen_pages(struct page *page, unsigned int order)
 	migratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(zone, page, pfn, order, FPI_NONE);
+			free_one_page(zone, page, pfn, order, FPI_NONE, luf_key);
 			return;
 		}
 		migratetype = MIGRATE_MOVABLE;
@@ -2792,10 +2850,10 @@ void free_frozen_pages(struct page *page, unsigned int order)
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_frozen_page_commit(zone, pcp, page, migratetype, order);
+		free_frozen_page_commit(zone, pcp, page, migratetype, order, luf_key);
 		pcp_spin_unlock(pcp);
 	} else {
-		free_one_page(zone, page, pfn, order, FPI_NONE);
+		free_one_page(zone, page, pfn, order, FPI_NONE, luf_key);
 	}
 	pcp_trylock_finish(UP_flags);
 }
@@ -2803,7 +2861,7 @@ void free_frozen_pages(struct page *page, unsigned int order)
 /*
  * Free a batch of folios
  */
-void free_unref_folios(struct folio_batch *folios)
+void free_unref_folios(struct folio_batch *folios, unsigned short luf_key)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp = NULL;
@@ -2824,7 +2882,7 @@ void free_unref_folios(struct folio_batch *folios)
 		 */
 		if (!pcp_allowed_order(order)) {
 			free_one_page(folio_zone(folio), &folio->page,
-				      pfn, order, FPI_NONE);
+				      pfn, order, FPI_NONE, luf_key);
 			continue;
 		}
 		folio->private = (void *)(unsigned long)order;
@@ -2860,7 +2918,7 @@ void free_unref_folios(struct folio_batch *folios)
 			 */
 			if (is_migrate_isolate(migratetype)) {
 				free_one_page(zone, &folio->page, pfn,
-					      order, FPI_NONE);
+					      order, FPI_NONE, luf_key);
 				continue;
 			}
 
@@ -2873,7 +2931,7 @@ void free_unref_folios(struct folio_batch *folios)
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, &folio->page, pfn,
-					      order, FPI_NONE);
+					      order, FPI_NONE, luf_key);
 				continue;
 			}
 			locked_zone = zone;
@@ -2888,7 +2946,7 @@ void free_unref_folios(struct folio_batch *folios)
 
 		trace_mm_page_free_batched(&folio->page);
 		free_frozen_page_commit(zone, pcp, &folio->page, migratetype,
-				order);
+				order, luf_key);
 	}
 
 	if (pcp) {
@@ -2980,7 +3038,7 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
 
 	/* Return isolated page to tail of freelist. */
 	__free_one_page(page, page_to_pfn(page), zone, order, mt,
-			FPI_SKIP_REPORT_NOTIFY | FPI_TO_TAIL);
+			FPI_SKIP_REPORT_NOTIFY | FPI_TO_TAIL, 0);
 }
 
 /*
@@ -4866,7 +4924,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 out:
 	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
 	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
-		free_frozen_pages(page, order);
+		free_frozen_pages(page, order, 0);
 		page = NULL;
 	}
 
@@ -4947,11 +5005,11 @@ void __free_pages(struct page *page, unsigned int order)
 	struct alloc_tag *tag = pgalloc_tag_get(page);
 
 	if (put_page_testzero(page))
-		free_frozen_pages(page, order);
+		free_frozen_pages(page, order, 0);
 	else if (!head) {
 		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
 		while (order-- > 0)
-			free_frozen_pages(page + (1 << order), order);
+			free_frozen_pages(page + (1 << order), order, 0);
 	}
 }
 EXPORT_SYMBOL(__free_pages);
@@ -4982,7 +5040,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 
 		last = page + (1UL << order);
 		for (page += nr; page < last; page++)
-			__free_pages_ok(page, 0, FPI_TO_TAIL);
+			__free_pages_ok(page, 0, FPI_TO_TAIL, 0);
 	}
 	return (void *)addr;
 }
@@ -7000,7 +7058,7 @@ bool put_page_back_buddy(struct page *page)
 		int migratetype = get_pfnblock_migratetype(page, pfn);
 
 		ClearPageHWPoisonTakenOff(page);
-		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
+		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE, 0);
 		if (TestClearPageHWPoison(page)) {
 			ret = true;
 		}
@@ -7069,7 +7127,7 @@ static void __accept_page(struct zone *zone, unsigned long *flags,
 
 	accept_memory(page_to_phys(page), PAGE_SIZE << MAX_PAGE_ORDER);
 
-	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
+	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL, 0);
 
 	if (last)
 		static_branch_dec(&zones_with_unaccepted_pages);
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index d2423f30577e4..558622f15a81e 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -86,7 +86,7 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
 
 	if (page_ref_sub_and_test(page, count))
-		free_frozen_pages(page, compound_order(page));
+		free_frozen_pages(page, compound_order(page), 0);
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
@@ -139,7 +139,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 
 		if (unlikely(encoded_page_decode_pfmemalloc(encoded_page))) {
 			free_frozen_pages(page,
-					encoded_page_decode_order(encoded_page));
+					encoded_page_decode_order(encoded_page), 0);
 			goto refill;
 		}
 
@@ -166,6 +166,6 @@ void page_frag_free(void *addr)
 	struct page *page = virt_to_head_page(addr);
 
 	if (unlikely(put_page_testzero(page)))
-		free_frozen_pages(page, compound_order(page));
+		free_frozen_pages(page, compound_order(page), 0);
 }
 EXPORT_SYMBOL(page_frag_free);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c608e9d728655..04dcea88a0dda 100644
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
diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3c..2cc3bf0f58bce 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2652,7 +2652,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	__folio_clear_slab(folio);
 	mm_account_reclaimed_pages(pages);
 	unaccount_slab(slab, order, s);
-	free_frozen_pages(&folio->page, order);
+	free_frozen_pages(&folio->page, order, 0);
 }
 
 static void rcu_free_slab(struct rcu_head *h)
diff --git a/mm/swap.c b/mm/swap.c
index fc8281ef42415..0c6198e4a8ee4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -109,7 +109,7 @@ void __folio_put(struct folio *folio)
 	page_cache_release(folio);
 	folio_unqueue_deferred_split(folio);
 	mem_cgroup_uncharge(folio);
-	free_frozen_pages(&folio->page, folio_order(folio));
+	free_frozen_pages(&folio->page, folio_order(folio), 0);
 }
 EXPORT_SYMBOL(__folio_put);
 
@@ -991,7 +991,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 
 	folios->nr = j;
 	mem_cgroup_uncharge_folios(folios);
-	free_unref_folios(folios);
+	free_unref_folios(folios, 0);
 }
 EXPORT_SYMBOL(folios_put_refs);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c767d71c43d7d..ff1c53e769398 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1515,7 +1515,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (folio_batch_add(&free_folios, folio) == 0) {
 			mem_cgroup_uncharge_folios(&free_folios);
 			try_to_unmap_flush();
-			free_unref_folios(&free_folios);
+			free_unref_folios(&free_folios, 0);
 		}
 		continue;
 
@@ -1584,7 +1584,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 	mem_cgroup_uncharge_folios(&free_folios);
 	try_to_unmap_flush();
-	free_unref_folios(&free_folios);
+	free_unref_folios(&free_folios, 0);
 
 	list_splice(&ret_folios, folio_list);
 	count_vm_events(PGACTIVATE, pgactivate);
@@ -1908,7 +1908,7 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 			if (folio_batch_add(&free_folios, folio) == 0) {
 				spin_unlock_irq(&lruvec->lru_lock);
 				mem_cgroup_uncharge_folios(&free_folios);
-				free_unref_folios(&free_folios);
+				free_unref_folios(&free_folios, 0);
 				spin_lock_irq(&lruvec->lru_lock);
 			}
 
@@ -1930,7 +1930,7 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 	if (free_folios.nr) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		mem_cgroup_uncharge_folios(&free_folios);
-		free_unref_folios(&free_folios);
+		free_unref_folios(&free_folios, 0);
 		spin_lock_irq(&lruvec->lru_lock);
 	}
 
-- 
2.17.1


