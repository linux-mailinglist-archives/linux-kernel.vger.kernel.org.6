Return-Path: <linux-kernel+bounces-533758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF59A45E47
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA713B4C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275A622D78A;
	Wed, 26 Feb 2025 12:04:02 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BFB21B1BE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571441; cv=none; b=jfBKzUzm6nTRF9q+JBlSUY7nNzVdMtXUDRTvutC5rDsLIrjwk4xoNrHBdS+6Ijf8PothLDe7i8ulG9jlS9RVH9ypfin7X4z7zKkKRvmJcUS1CddQDEfjkcHrQvp+ObspZk4GD4BpCmjrC5x/HbPzEuTdw5vEj1rJNRHH/nF0QKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571441; c=relaxed/simple;
	bh=7YLNeKHDvmuOBy5Wz7/M6to2RGYZFbDuanYqnoejK+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=i8/YAqL7fjSmCuEb4cq+66tDyXv2l3FEBbvpcKbjW4imFHs/+JKfP3XYDoWGtb+tCWj5Nu7XmIJD7RQVhLvCXO0m5F1/0LbmOBgEN4JXy3wZgKlDPYTytktqKhTo3Eke5zTxeBiZzf9JrdwQCFBj5EDCQOF0JZIh8Vzzab+o5B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-61-67bf03238ab2
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
Subject: [RFC PATCH v12 based on v6.14-rc4 22/25] mm/page_alloc: not allow to tlb shootdown if !preemptable() && non_luf_pages_ok()
Date: Wed, 26 Feb 2025 21:03:33 +0900
Message-Id: <20250226120336.29565-22-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC9ZZnka4y8/50gxnnJS3mrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK+PM3WNMBV+sKiYvOcfWwPjOoIuR
	k0NCwETifPcONhi78fN3RhCbTUBd4saNn8wgtoiAmcTB1j/sXYxcHMwCy5gk9p5oYANxhAWa
	GSUe7GxmB6liEVCV2LDqE1gHL1BHe+t3Foip8hKrNxwAi3MCxT9NOwa2TUggWWLn7z9MIIMk
	BO6zSVyY2ckI0SApcXDFDZYJjLwLGBlWMQpl5pXlJmbmmOhlVOZlVugl5+duYgQG9rLaP9E7
	GD9dCD7EKMDBqMTD++DM3nQh1sSy4srcQ4wSHMxKIrycmXvShXhTEiurUovy44tKc1KLDzFK
	c7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTA6Jh2L+5d5aPMdMcF3RnlvfOfcqFK83Ndj
	cfbTv3ceX/5Mutws2Hld6PGHjS4nb7Myer4O47Es1olXrJp7aNJD/+67aw5qL/8m+oqzIu7d
	8tlRabV6kVvOBwqdV1nIx37oo9/+xXq/Zx26cLmgXDSB7aeOU5/TdzXzC7INuxkCJm+6e6f5
	4RYHJZbijERDLeai4kQAPohn22gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsXC5WfdrKvMvD/d4Pk6AYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgyztw9xlTwxapi
	8pJzbA2M7wy6GDk5JARMJBo/f2cEsdkE1CVu3PjJDGKLCJhJHGz9w97FyMXBLLCMSWLviQY2
	EEdYoJlR4sHOZnaQKhYBVYkNqz6BdfACdbS3fmeBmCovsXrDAbA4J1D807RjbCC2kECyxM7f
	f5gmMHItYGRYxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERimy2r/TNzB+OWy+yFGAQ5GJR7e
	B2f2pguxJpYVV+YeYpTgYFYS4eXM3JMuxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9
	sSQ1OzW1ILUIJsvEwSnVwBjbXBu5Qjt+3xPnwxxTyiYmnclbbXXK2dL8bGdChIijrjiXXSGD
	4u6HrSl3c51eTWvqkVLUl4uaVJUoOnfV7SspE/ZdmtP7+KqbzqW33x6zvHRLcvNcm/ZvoVj9
	TZuPJV+qw4KXfxQ5bfen8Oh6Y/djH54HKUgxCfv++5CbuqZmxR3T338XSCuxFGckGmoxFxUn
	AgA5z9K+TwIAAA==
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
index b7a7a6feb9eac..aab400ec6a734 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -606,7 +606,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 	page = pfn_to_page(blockpfn);
 
-	luf_takeoff_start();
+	luf_takeoff_start(cc->zone);
 	/* Isolate free pages. */
 	for (; blockpfn < end_pfn; blockpfn += stride, page += stride) {
 		int isolated;
@@ -1603,7 +1603,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 		if (!area->nr_free)
 			continue;
 
-		can_shootdown = luf_takeoff_start();
+		can_shootdown = luf_takeoff_start(cc->zone);
 		spin_lock_irqsave(&cc->zone->lock, flags);
 		freelist = &area->free_list[MIGRATE_MOVABLE];
 retry:
@@ -2416,7 +2416,7 @@ static enum compact_result compact_finished(struct compact_control *cc)
 	 * luf_takeoff_{start,end}() is required to identify whether
 	 * this compaction context is tlb shootdownable for luf'd pages.
 	 */
-	luf_takeoff_start();
+	luf_takeoff_start(cc->zone);
 	ret = __compact_finished(cc);
 	luf_takeoff_end(cc->zone);
 
diff --git a/mm/internal.h b/mm/internal.h
index 6d7b3b389810e..b5f1928732498 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1591,7 +1591,7 @@ static inline void accept_page(struct page *page)
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 #if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
 extern struct luf_batch luf_batch[];
-bool luf_takeoff_start(void);
+bool luf_takeoff_start(struct zone *zone);
 void luf_takeoff_end(struct zone *zone);
 bool luf_takeoff_no_shootdown(void);
 bool luf_takeoff_check(struct zone *zone, struct page *page);
@@ -1605,6 +1605,7 @@ static inline bool non_luf_pages_ok(struct zone *zone)
 
 	return nr_free - nr_luf_pages > min_wm;
 }
+
 unsigned short fold_unmap_luf(void);
 
 /*
@@ -1691,7 +1692,7 @@ static inline bool can_luf_vma(struct vm_area_struct *vma)
 	return true;
 }
 #else /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
-static inline bool luf_takeoff_start(void) { return false; }
+static inline bool luf_takeoff_start(struct zone *zone) { return false; }
 static inline void luf_takeoff_end(struct zone *zone) {}
 static inline bool luf_takeoff_no_shootdown(void) { return true; }
 static inline bool luf_takeoff_check(struct zone *zone, struct page *page) { return true; }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 917a257ea5706..2a2103df2d88e 100644
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
 
@@ -2591,7 +2594,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 		 * luf_takeoff_{start,end}() is required for
 		 * get_page_from_free_area() to use luf_takeoff_check().
 		 */
-		luf_takeoff_start();
+		luf_takeoff_start(zone);
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < NR_PAGE_ORDERS; order++) {
 			struct free_area *area = &(zone->free_area[order]);
@@ -2796,7 +2799,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	unsigned long flags;
 	int i;
 
-	luf_takeoff_start();
+	luf_takeoff_start(zone);
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
@@ -3422,7 +3425,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 	do {
 		page = NULL;
-		luf_takeoff_start();
+		luf_takeoff_start(zone);
 		spin_lock_irqsave(&zone->lock, flags);
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
@@ -3567,7 +3570,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct page *page;
 	unsigned long __maybe_unused UP_flags;
 
-	luf_takeoff_start();
+	luf_takeoff_start(NULL);
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
@@ -5190,7 +5193,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
-	luf_takeoff_start();
+	luf_takeoff_start(NULL);
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
@@ -7294,7 +7297,7 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
 
 	offline_mem_sections(pfn, end_pfn);
 	zone = page_zone(pfn_to_page(pfn));
-	luf_takeoff_start();
+	luf_takeoff_start(zone);
 	spin_lock_irqsave(&zone->lock, flags);
 	while (pfn < end_pfn) {
 		page = pfn_to_page(pfn);
@@ -7412,7 +7415,7 @@ bool take_page_off_buddy(struct page *page)
 	unsigned int order;
 	bool ret = false;
 
-	luf_takeoff_start();
+	luf_takeoff_start(zone);
 	spin_lock_irqsave(&zone->lock, flags);
 	for (order = 0; order < NR_PAGE_ORDERS; order++) {
 		struct page *page_head = page - (pfn & ((1 << order) - 1));
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c34659b58ca6c..f4055c0a2ea89 100644
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


