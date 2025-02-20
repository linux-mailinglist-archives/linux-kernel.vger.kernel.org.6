Return-Path: <linux-kernel+bounces-523001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A6FA3D0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C94B17C09B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7721E04AE;
	Thu, 20 Feb 2025 05:36:14 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CD31EA7C9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029772; cv=none; b=Ixv5R4C9sONh8wwz6vM3j/0QmNN8baL17Lq2Kv/wVieiaoMNAyPHmPJ/fWEn3kD6Fs3LZE5CHzi+MkgmCkMgtZQI2BLJgL73k6GuqerVfNnhlforGkw8axQNhYVquySNZBhykc4xkP2RT3ndzOz5HN2siIQa0C9R+LH90rwizD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029772; c=relaxed/simple;
	bh=kJUOmAXIN+Be88pGq5nqP4G6HpOEuI3dn+5Ika8a0VA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OwAiVf12CzMpGt+TWqFSJjGKK/8uK+hrgE9uzA9ZvK8tcGe9AOcC83eUI64UGUHUfzmGqf8czG6G/u0vDdZHsb9UsrT7KCBjnf7F3LrfO+3ZIQvFp1G/f5n0D3WVyYrWGFXwfev0UeF4zSuHLoV7Fs0LA5DBm8+Qdbx7NK5psRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-1c-67b6bba7c1f0
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
Subject: [RFC PATCH v12 22/26] mm/page_alloc: not allow to tlb shootdown if !preemptable() && non_luf_pages_ok()
Date: Thu, 20 Feb 2025 14:20:23 +0900
Message-Id: <20250220052027.58847-23-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnoe7y3dvSDTafkbKYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	/z8LFXyxqnjyaxJrA+M7gy5GDg4JAROJCQ/9uhg5wcwZvfeYQWw2AXWJGzd+gtkiAmYSB1v/
	sIPYzAJ3mSQO9LOB2MICBRLbfpwFi7MIqEosODeZBcTmBao/umcyO8RMeYnVGw6AzeEEiv+Y
	0QvWKyRgKvFuwSWmLkYuoJr3bBKXmjczQjRIShxccYNlAiPvAkaGVYxCmXlluYmZOSZ6GZV5
	mRV6yfm5mxiBYb+s9k/0DsZPF4IPMQpwMCrx8M5o3ZYuxJpYVlyZe4hRgoNZSYS3rX5LuhBv
	SmJlVWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQZGqb/ib325lm7U
	UV2V5PjJkflWyEXbJsZVFQpHXhycpc0a+Ez9Za3bt5odtx9MjLlzaOLt92pim7WZll2Ynb/n
	3ku9U171OvN72DZe7z0zWdR9wp13LoYLvTp3f5Pe5JAcflVFz3phb424T6oqo7X2gcK3bk+O
	vQ5bpfx/tkRe0jEzKa/dR5aoKrEUZyQaajEXFScCAB6fEFp3AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrLt897Z0g62/BSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlfH/s1DBF6uKJ78msTYwvjPoYuTkkBAwkZjRe48ZxGYTUJe4ceMnmC0iYCZx
	sPUPO4jNLHCXSeJAPxuILSxQILHtx1mwOIuAqsSCc5NZQGxeoPqjeyazQ8yUl1i94QDYHE6g
	+I8ZvWC9QgKmEu8WXGKawMi1gJFhFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmAYL6v9M3EH
	45fL7ocYBTgYlXh4Hzzemi7EmlhWXJl7iFGCg1lJhLetfku6EG9KYmVValF+fFFpTmrxIUZp
	DhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA+OKor7yNV8CgneJvYxO6zj1tKOtUPXc/jam
	j+aXcvfd6DU3lN+3e6l/9NHNlZvmJNb5vzhx6ejWwB3Pt8ZKLfJgWybJU14fNH3tmbVV4u8U
	Mja+5f4TKl01qfT16oUn9vQ9Ulq/4EzE9YeL576ocf+UXO2/JrAy97ZTx4rvh8IULnfrfJu+
	76qREktxRqKhFnNRcSIAHburZl8CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Do not perform tlb shootdown if the context is in preempt disable and
there are already enough non luf pages, not to hurt preemptibility.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/compaction.c     |  6 +++---
 mm/internal.h       |  5 +++--
 mm/page_alloc.c     | 27 +++++++++++++++------------
 mm/page_isolation.c |  2 +-
 mm/page_reporting.c |  4 ++--
 5 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a7f17867decae..8fa9de6db2441 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -605,7 +605,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 	page = pfn_to_page(blockpfn);
 
-	luf_takeoff_start();
+	luf_takeoff_start(cc->zone);
 	/* Isolate free pages. */
 	for (; blockpfn < end_pfn; blockpfn += stride, page += stride) {
 		int isolated;
@@ -1601,7 +1601,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 		if (!area->nr_free)
 			continue;
 
-		can_shootdown = luf_takeoff_start();
+		can_shootdown = luf_takeoff_start(cc->zone);
 		spin_lock_irqsave(&cc->zone->lock, flags);
 		freelist = &area->free_list[MIGRATE_MOVABLE];
 retry:
@@ -2413,7 +2413,7 @@ static enum compact_result compact_finished(struct compact_control *cc)
 	 * luf_takeoff_{start,end}() is required to identify whether
 	 * this compaction context is tlb shootdownable for luf'd pages.
 	 */
-	luf_takeoff_start();
+	luf_takeoff_start(cc->zone);
 	ret = __compact_finished(cc);
 	luf_takeoff_end(cc->zone);
 
diff --git a/mm/internal.h b/mm/internal.h
index e634eaf220f00..fba19c283ac48 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1594,7 +1594,7 @@ static inline void accept_page(struct page *page)
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 #if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
 extern struct luf_batch luf_batch[];
-bool luf_takeoff_start(void);
+bool luf_takeoff_start(struct zone *zone);
 void luf_takeoff_end(struct zone *zone);
 bool luf_takeoff_no_shootdown(void);
 bool luf_takeoff_check(struct zone *zone, struct page *page);
@@ -1608,6 +1608,7 @@ static inline bool non_luf_pages_ok(struct zone *zone)
 
 	return nr_free - nr_luf_pages > min_wm;
 }
+
 unsigned short fold_unmap_luf(void);
 
 /*
@@ -1694,7 +1695,7 @@ static inline bool can_luf_vma(struct vm_area_struct *vma)
 	return true;
 }
 #else /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
-static inline bool luf_takeoff_start(void) { return false; }
+static inline bool luf_takeoff_start(struct zone *zone) { return false; }
 static inline void luf_takeoff_end(struct zone *zone) {}
 static inline bool luf_takeoff_no_shootdown(void) { return true; }
 static inline bool luf_takeoff_check(struct zone *zone, struct page *page) { return true; }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b81931c6f2cfd..ccbe49b78190a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -623,22 +623,25 @@ compaction_capture(struct capture_control *capc, struct page *page,
 #endif /* CONFIG_COMPACTION */
 
 #if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
-static bool no_shootdown_context(void)
+static bool no_shootdown_context(struct zone *zone)
 {
 	/*
-	 * If it performs with irq disabled, that might cause a deadlock.
-	 * Avoid tlb shootdown in this case.
+	 * Tries to avoid tlb shootdown if !preemptible().  However, it
+	 * should be allowed under heavy memory pressure.
 	 */
+	if (zone && non_luf_pages_ok(zone))
+		return !(preemptible() && in_task());
+
 	return !(!irqs_disabled() && in_task());
 }
 
 /*
  * Can be called with zone lock released and irq enabled.
  */
-bool luf_takeoff_start(void)
+bool luf_takeoff_start(struct zone *zone)
 {
 	unsigned long flags;
-	bool no_shootdown = no_shootdown_context();
+	bool no_shootdown = no_shootdown_context(zone);
 
 	local_irq_save(flags);
 
@@ -2588,7 +2591,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 		 * luf_takeoff_{start,end}() is required for
 		 * get_page_from_free_area() to use luf_takeoff_check().
 		 */
-		luf_takeoff_start();
+		luf_takeoff_start(zone);
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < NR_PAGE_ORDERS; order++) {
 			struct free_area *area = &(zone->free_area[order]);
@@ -2829,7 +2832,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	unsigned long flags;
 	int i;
 
-	luf_takeoff_start();
+	luf_takeoff_start(zone);
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
@@ -3455,7 +3458,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 	do {
 		page = NULL;
-		luf_takeoff_start();
+		luf_takeoff_start(zone);
 		spin_lock_irqsave(&zone->lock, flags);
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
@@ -3600,7 +3603,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct page *page;
 	unsigned long __maybe_unused UP_flags;
 
-	luf_takeoff_start();
+	luf_takeoff_start(NULL);
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
@@ -5229,7 +5232,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
-	luf_takeoff_start();
+	luf_takeoff_start(NULL);
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
@@ -7418,7 +7421,7 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
 
 	offline_mem_sections(pfn, end_pfn);
 	zone = page_zone(pfn_to_page(pfn));
-	luf_takeoff_start();
+	luf_takeoff_start(zone);
 	spin_lock_irqsave(&zone->lock, flags);
 	while (pfn < end_pfn) {
 		page = pfn_to_page(pfn);
@@ -7536,7 +7539,7 @@ bool take_page_off_buddy(struct page *page)
 	unsigned int order;
 	bool ret = false;
 
-	luf_takeoff_start();
+	luf_takeoff_start(zone);
 	spin_lock_irqsave(&zone->lock, flags);
 	for (order = 0; order < NR_PAGE_ORDERS; order++) {
 		struct page *page_head = page - (pfn & ((1 << order) - 1));
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index eae33d188762b..ccd36838f9cff 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -211,7 +211,7 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 	struct page *buddy;
 
 	zone = page_zone(page);
-	luf_takeoff_start();
+	luf_takeoff_start(zone);
 	spin_lock_irqsave(&zone->lock, flags);
 	if (!is_migrate_isolate_page(page))
 		goto out;
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index b23d3ed34ec07..83b66e7f0d257 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -170,7 +170,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	if (free_area_empty(area, mt))
 		return err;
 
-	can_shootdown = luf_takeoff_start();
+	can_shootdown = luf_takeoff_start(zone);
 	spin_lock_irq(&zone->lock);
 
 	/*
@@ -250,7 +250,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		/* update budget to reflect call to report function */
 		budget--;
 
-		luf_takeoff_start();
+		luf_takeoff_start(zone);
 
 		/* reacquire zone lock and resume processing */
 		spin_lock_irq(&zone->lock);
-- 
2.17.1


