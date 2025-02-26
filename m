Return-Path: <linux-kernel+bounces-533733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74004A45E23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D83178F26
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B214A221DB2;
	Wed, 26 Feb 2025 12:01:58 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA4221DA5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571317; cv=none; b=kLZSEgWaSFa1r/qRLuyIfXSfJ/wlJC3GyRQHbd2CG7HVr/8OtY/G2nSzn7QhhxFzCi+GHK7VgkAitUfKvm+Evz2dUdHe9dScdU75tB111dts/QQ6gSNyRsViiVFUb2RXNAWx4ls2f6b70obUnpbDnDj7H1GOwjgh6MKiLFhR0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571317; c=relaxed/simple;
	bh=fQF55MlodRofCtKpM/2iYYKXMGxXZ+PpVYpvP/083Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=P3wnZmKDLcXV+vXmOEwMGlCBHaggBhyKKgfbtNNN7L4o5mbJGnVWZ1M89r2klaI3gTjKXDGOKc+xBkKpoiVUv0pJigetS7GJTFHCsWUWdr6BYsIo4keNvOpW4ldLGt5jwHXxeBp0LpRPdXP8bVPb7U5lRonOYVBZ9XQ+nwO4L8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-31-67bf02a743c9
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 22/25]  mm/page_alloc: not allow to tlb shootdown if !preemptable() && non_luf_pages_ok()
Date: Wed, 26 Feb 2025 21:01:29 +0900
Message-Id: <20250226120132.28469-22-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC9ZZnke5ypv3pBj0TtS3mrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK+P19GUsBV+sKj5ff83WwPjOoIuR
	k0NCwERi48knjDD2rP6vzCA2m4C6xI0bP8FsEQEziYOtf9i7GLk4mAWWMUnsPdHABuIIC8xk
	lHjx/w4rSBWLgKrEiU0TmUBsXqCOG/Oa2CCmykus3nAAbBInUPzf7t/sILaQQLJEy/rfLCCD
	JATus0k0/fkAdYakxMEVN1gmMPIuYGRYxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREY2Mtq/0Tv
	YPx0IfgQowAHoxIP74Mze9OFWBPLiitzDzFKcDArifByZu5JF+JNSaysSi3Kjy8qzUktPsQo
	zcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cBYO7Hbtv1PTnnl1/QjFxe3TSxfW2WhO43r
	1I+i/wf3C6WJz9t2cMqP5UKlaVU2C6aZC/43SPCsv7fpwoa/dssC3rx/ai6k4P97s6VRj1bc
	gq0TjFa8fG67RGjyaSZdV+4XZcpq1W03Xbec+79sP8+Z5u0yni/jH3R9zXtjf7/aWLNn+yEv
	t+1nlFiKMxINtZiLihMBFJdnCmgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsXC5WfdrLucaX+6Qf9jRYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgyXk9fxlLwxari
	8/XXbA2M7wy6GDk5JARMJGb1f2UGsdkE1CVu3PgJZosImEkcbP3D3sXIxcEssIxJYu+JBjYQ
	R1hgJqPEi/93WEGqWARUJU5smsgEYvMCddyY18QGMVVeYvWGA2CTOIHi/3b/ZgexhQSSJVrW
	/2aZwMi1gJFhFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmCYLqv9M3EH45fL7ocYBTgYlXh4
	H5zZmy7EmlhWXJl7iFGCg1lJhJczc0+6EG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0
	xJLU7NTUgtQimCwTB6dUA6Pi/8N/DF4/6VNO22JuWHxJQMp62mxfzyTWiXVzMvdemGr8WY7x
	W06zx4ubobOnCS+9+uOao6eg2p78a0f+O8/dWVdwRk+n9POX77qpzxiTb5vkrftso+UbnWLq
	7qi3UDR2XrmweYRRMmfjnJeuPPOPOp0/JZMX1z9r+6zNvq9jCsNfuDPXLFJiKc5INNRiLipO
	BACYa2oITwIAAA==
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
index c87a1803b10e2..9098ddb04bbf5 100644
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
@@ -2417,7 +2417,7 @@ static enum compact_result compact_finished(struct compact_control *cc)
 	 * luf_takeoff_{start,end}() is required to identify whether
 	 * this compaction context is tlb shootdownable for luf'd pages.
 	 */
-	luf_takeoff_start();
+	luf_takeoff_start(cc->zone);
 	ret = __compact_finished(cc);
 	luf_takeoff_end(cc->zone);
 
diff --git a/mm/internal.h b/mm/internal.h
index 53056ad7dade9..7c4198f5e22c3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1609,7 +1609,7 @@ static inline void accept_page(struct page *page)
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 #if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
 extern struct luf_batch luf_batch[];
-bool luf_takeoff_start(void);
+bool luf_takeoff_start(struct zone *zone);
 void luf_takeoff_end(struct zone *zone);
 bool luf_takeoff_no_shootdown(void);
 bool luf_takeoff_check(struct zone *zone, struct page *page);
@@ -1623,6 +1623,7 @@ static inline bool non_luf_pages_ok(struct zone *zone)
 
 	return nr_free - nr_luf_pages > min_wm;
 }
+
 unsigned short fold_unmap_luf(void);
 
 /*
@@ -1709,7 +1710,7 @@ static inline bool can_luf_vma(struct vm_area_struct *vma)
 	return true;
 }
 #else /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
-static inline bool luf_takeoff_start(void) { return false; }
+static inline bool luf_takeoff_start(struct zone *zone) { return false; }
 static inline void luf_takeoff_end(struct zone *zone) {}
 static inline bool luf_takeoff_no_shootdown(void) { return true; }
 static inline bool luf_takeoff_check(struct zone *zone, struct page *page) { return true; }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0f986cfa4fe39..9a58d6f7a9609 100644
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
 
@@ -2669,7 +2672,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 		 * luf_takeoff_{start,end}() is required for
 		 * get_page_from_free_area() to use luf_takeoff_check().
 		 */
-		luf_takeoff_start();
+		luf_takeoff_start(zone);
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < NR_PAGE_ORDERS; order++) {
 			struct free_area *area = &(zone->free_area[order]);
@@ -2874,7 +2877,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	unsigned long flags;
 	int i;
 
-	luf_takeoff_start();
+	luf_takeoff_start(zone);
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
@@ -3500,7 +3503,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 	do {
 		page = NULL;
-		luf_takeoff_start();
+		luf_takeoff_start(zone);
 		spin_lock_irqsave(&zone->lock, flags);
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
@@ -3645,7 +3648,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct page *page;
 	unsigned long __maybe_unused UP_flags;
 
-	luf_takeoff_start();
+	luf_takeoff_start(NULL);
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
@@ -5268,7 +5271,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
-	luf_takeoff_start();
+	luf_takeoff_start(NULL);
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
@@ -7371,7 +7374,7 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
 
 	offline_mem_sections(pfn, end_pfn);
 	zone = page_zone(pfn_to_page(pfn));
-	luf_takeoff_start();
+	luf_takeoff_start(zone);
 	spin_lock_irqsave(&zone->lock, flags);
 	while (pfn < end_pfn) {
 		page = pfn_to_page(pfn);
@@ -7489,7 +7492,7 @@ bool take_page_off_buddy(struct page *page)
 	unsigned int order;
 	bool ret = false;
 
-	luf_takeoff_start();
+	luf_takeoff_start(zone);
 	spin_lock_irqsave(&zone->lock, flags);
 	for (order = 0; order < NR_PAGE_ORDERS; order++) {
 		struct page *page_head = page - (pfn & ((1 << order) - 1));
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 521ed32bdbf67..70f938c0921ae 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -218,7 +218,7 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
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


