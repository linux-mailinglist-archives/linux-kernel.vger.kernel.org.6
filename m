Return-Path: <linux-kernel+bounces-533760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C31A45E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F287A6E72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320022F178;
	Wed, 26 Feb 2025 12:04:03 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08794229B1E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571441; cv=none; b=FxAomnQa70WjdtoChoRxtTvUFwf2KEjKaI3fst09ZvE6FLQbU2xyt5C5oWhkBBfcx0YBfvknyNM6xsuqNibH8M+OXK7nl9ThzOV8YviDIpoREFJgZrj59XlfIjK54LW0R4wW8a7njqzlXfYSdkb+gWnzZbeztWccbzMGkgGDfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571441; c=relaxed/simple;
	bh=V7jgHj61joZXMv3nFFlbWWZO+gOGQuLHBAY/jNG4LPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gSw/rpSKoCq6pxD2cYailm6VBRAreR9PnTIXaJZnANCcBCyfCl4cCfr0wgvdslx3ySAmIteE8It0DwUAfdRqYvn9XHuOWgNVIYGWIZFlAubPbVSIiN1OVYAyhk+o3OrFDUB/sEtfFcHCfDRBp8e8ttNgRo1CDjFBznqgXoK9CIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-5c-67bf03236738
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
Subject: [RFC PATCH v12 based on v6.14-rc4 21/25] mm: perform luf tlb shootdown per zone in batched manner
Date: Wed, 26 Feb 2025 21:03:32 +0900
Message-Id: <20250226120336.29565-21-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsXC9ZZnoa4y8/50g7XXJCzmrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK2PXhDeMBd97mSq+TNvH2MDYfZOx
	i5GTQ0LARGLGq/8sMPbC7VOYQGw2AXWJGzd+MoPYIgJmEgdb/7B3MXJxMAssY5LYe6KBDSQh
	LJAlcXnSBbAGFgFViaXTboIN4gVquPFxJhPEUHmJ1RsOgA3iBIp/mnYMrFdIIFli5+8/TCBD
	JQTus0k0XNgPdYWkxMEVN1gmMPIuYGRYxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREY2stq/0Tv
	YPx0IfgQowAHoxIP74Mze9OFWBPLiitzDzFKcDArifByZu5JF+JNSaysSi3Kjy8qzUktPsQo
	zcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cDY5iZ4cL3md4EvZyT0XhcXaa9vuuny883H
	4Ddbu3WlH3w7q/HjbWi/oU213buIb092TX4ir58tn7vjvvvKDx3fLy9fc6DfJKyer1X7tpxe
	3qcMkcPFguE6IctWsLj7rpzOW3D7c6crv+f/lY1rxQ6qte28e/cB649jG6e9uXkuJkMmUPEk
	7yp9JZbijERDLeai4kQA5f+XyWkCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsXC5WfdrKvMvD/dYMFWPos569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgydk14w1jwvZep
	4su0fYwNjN03GbsYOTkkBEwkFm6fwgRiswmoS9y48ZMZxBYRMJM42PqHvYuRi4NZYBmTxN4T
	DWwgCWGBLInLky6ANbAIqEosnXaTBcTmBWq48XEmE8RQeYnVGw6ADeIEin+adgysV0ggWWLn
	7z9MExi5FjAyrGIUycwry03MzDHVK87OqMzLrNBLzs/dxAgM1GW1fybuYPxy2f0QowAHoxIP
	74Mze9OFWBPLiitzDzFKcDArifByZu5JF+JNSaysSi3Kjy8qzUktPsQozcGiJM7rFZ6aICSQ
	nliSmp2aWpBaBJNl4uCUamD03r2/9tvz7cUfWdVFan/UHHpVy/ez5+q5d9OWX6yc8uTX1tnH
	KqWFFaYv+jXli/DC3XY+s0wmiOvketwvObvkqOqKDykvluewvtqg0vLyzv4dlaah/PELCldn
	/M7vrF7Y08513Er91+qTM2KtL8/axtu/jMUtRzBAi09AJ7n8vUzoU+tzN96YK7EUZyQaajEX
	FScCACGvDGlQAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Each luf page in buddy has its pending tlb shootdown information and
performs the corresponding tlb shootdown on exit from buddy.  However,
every exit from buddy causes small but frequent IPIs.  Even though total
IPIs get reduced, unnecessary waits on conflict CPUs in IPI handler have
been observed via perf profiling.

Thus, made it perfrom luf tlb shootdown per zone in batched manner when
pages exit from buddy so as to avoid frequent IPIs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm.h       |  44 ++++-
 include/linux/mm_types.h |  19 +-
 include/linux/mmzone.h   |   9 +
 include/linux/sched.h    |   2 +
 mm/compaction.c          |  10 +-
 mm/internal.h            |  13 +-
 mm/mm_init.c             |   5 +
 mm/page_alloc.c          | 363 +++++++++++++++++++++++++++++++--------
 mm/page_reporting.c      |   9 +-
 mm/rmap.c                |   6 +-
 10 files changed, 383 insertions(+), 97 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8c3481402d8cb..e8e6562abc77d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4155,12 +4155,16 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 
-#if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
 /*
  * luf_ugen will start with 2 so that 1 can be regarded as a passed one.
  */
 #define LUF_UGEN_INIT 2
+/*
+ * zone_ugen will start with 2 so that 1 can be regarded as done.
+ */
+#define ZONE_UGEN_INIT 2
 
+#if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
 static inline bool ugen_before(unsigned long a, unsigned long b)
 {
 	/*
@@ -4171,7 +4175,11 @@ static inline bool ugen_before(unsigned long a, unsigned long b)
 
 static inline unsigned long next_ugen(unsigned long ugen)
 {
-	if (ugen + 1)
+	/*
+	 * Avoid zero even in unsigned short range so as to treat
+	 * '(unsigned short)ugen == 0' as invalid.
+	 */
+	if ((unsigned short)(ugen + 1))
 		return ugen + 1;
 	/*
 	 * Avoid invalid ugen, zero.
@@ -4181,7 +4189,11 @@ static inline unsigned long next_ugen(unsigned long ugen)
 
 static inline unsigned long prev_ugen(unsigned long ugen)
 {
-	if (ugen - 1)
+	/*
+	 * Avoid zero even in unsigned short range so as to treat
+	 * '(unsigned short)ugen == 0' as invalid.
+	 */
+	if ((unsigned short)(ugen - 1))
 		return ugen - 1;
 	/*
 	 * Avoid invalid ugen, zero.
@@ -4189,4 +4201,30 @@ static inline unsigned long prev_ugen(unsigned long ugen)
 	return ugen - 2;
 }
 #endif
+
+/*
+ * return the biggest ugen but it should be before the real zone_ugen.
+ */
+static inline unsigned long page_zone_ugen(struct zone *zone, struct page *page)
+{
+	unsigned long zone_ugen = zone->zone_ugen;
+	unsigned short short_zone_ugen = page->zone_ugen;
+	unsigned long cand1, cand2;
+
+	if (!short_zone_ugen)
+		return 0;
+
+	cand1 = (zone_ugen & ~(unsigned long)USHRT_MAX) | short_zone_ugen;
+	cand2 = cand1 - USHRT_MAX - 1;
+
+	if (!ugen_before(zone_ugen, cand1))
+		return cand1;
+
+	return cand2;
+}
+
+static inline void set_page_zone_ugen(struct page *page, unsigned short zone_ugen)
+{
+	page->zone_ugen = zone_ugen;
+}
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 96015fc68e4f5..c5f44b5c9758f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -132,11 +132,20 @@ struct page {
 					 */
 					unsigned short order;
 
-					/*
-					 * For tracking need of tlb flush,
-					 * by luf(lazy unmap flush).
-					 */
-					unsigned short luf_key;
+					union {
+						/*
+						 * For tracking need of
+						 * tlb flush, by
+						 * luf(lazy unmap flush).
+						 */
+						unsigned short luf_key;
+
+						/*
+						 * Casted zone_ugen with
+						 * unsigned short.
+						 */
+						unsigned short zone_ugen;
+					};
 				};
 			};
 		};
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e2c8d7147e361..df5bacd48a2a2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -117,6 +117,7 @@ extern int page_group_by_mobility_disabled;
 struct free_area {
 	struct list_head	free_list[MIGRATE_TYPES];
 	struct list_head	pend_list[MIGRATE_TYPES];
+	unsigned long		pend_zone_ugen[MIGRATE_TYPES];
 	unsigned long		nr_free;
 };
 
@@ -1017,6 +1018,14 @@ struct zone {
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
 	/* Count pages that need tlb shootdown on allocation */
 	atomic_long_t		nr_luf_pages;
+	/* Generation number for that tlb shootdown has been done */
+	unsigned long		zone_ugen_done;
+	/* Generation number to control zone batched tlb shootdown */
+	unsigned long		zone_ugen;
+	/* Approximate latest luf_ugen that have ever entered */
+	unsigned long		luf_ugen;
+	/* Accumulated tlb batch for this zone */
+	struct tlbflush_unmap_batch zone_batch;
 } ____cacheline_internodealigned_in_smp;
 
 enum pgdat_flags {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 31efc88ce911a..96375274d0335 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1404,6 +1404,8 @@ struct task_struct {
 	int luf_no_shootdown;
 	int luf_takeoff_started;
 	unsigned long luf_ugen;
+	unsigned long zone_ugen;
+	unsigned long wait_zone_ugen;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
diff --git a/mm/compaction.c b/mm/compaction.c
index aa594a85d8aee..b7a7a6feb9eac 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -655,7 +655,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 				goto isolate_fail;
 		}
 
-		if (!luf_takeoff_check(page))
+		if (!luf_takeoff_check(cc->zone, page))
 			goto isolate_fail;
 
 		/* Found a free page, will break it into order-0 pages */
@@ -691,7 +691,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	/*
 	 * Check and flush before using the pages taken off.
 	 */
-	luf_takeoff_end();
+	luf_takeoff_end(cc->zone);
 
 	/*
 	 * Be careful to not go outside of the pageblock.
@@ -1613,7 +1613,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 			order_scanned++;
 			nr_scanned++;
 
-			if (unlikely(consider_pend && !luf_takeoff_check(freepage)))
+			if (unlikely(consider_pend && !luf_takeoff_check(cc->zone, freepage)))
 				goto scan_next;
 
 			pfn = page_to_pfn(freepage);
@@ -1681,7 +1681,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 		/*
 		 * Check and flush before using the pages taken off.
 		 */
-		luf_takeoff_end();
+		luf_takeoff_end(cc->zone);
 
 		/* Skip fast search if enough freepages isolated */
 		if (cc->nr_freepages >= cc->nr_migratepages)
@@ -2418,7 +2418,7 @@ static enum compact_result compact_finished(struct compact_control *cc)
 	 */
 	luf_takeoff_start();
 	ret = __compact_finished(cc);
-	luf_takeoff_end();
+	luf_takeoff_end(cc->zone);
 
 	trace_mm_compaction_finished(cc->zone, cc->order, ret);
 	if (ret == COMPACT_NO_SUITABLE_PAGE)
diff --git a/mm/internal.h b/mm/internal.h
index a95c46355e93d..6d7b3b389810e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1592,10 +1592,10 @@ static inline void accept_page(struct page *page)
 #if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
 extern struct luf_batch luf_batch[];
 bool luf_takeoff_start(void);
-void luf_takeoff_end(void);
+void luf_takeoff_end(struct zone *zone);
 bool luf_takeoff_no_shootdown(void);
-bool luf_takeoff_check(struct page *page);
-bool luf_takeoff_check_and_fold(struct page *page);
+bool luf_takeoff_check(struct zone *zone, struct page *page);
+bool luf_takeoff_check_and_fold(struct zone *zone, struct page *page);
 
 static inline bool non_luf_pages_ok(struct zone *zone)
 {
@@ -1605,7 +1605,6 @@ static inline bool non_luf_pages_ok(struct zone *zone)
 
 	return nr_free - nr_luf_pages > min_wm;
 }
-
 unsigned short fold_unmap_luf(void);
 
 /*
@@ -1693,10 +1692,10 @@ static inline bool can_luf_vma(struct vm_area_struct *vma)
 }
 #else /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 static inline bool luf_takeoff_start(void) { return false; }
-static inline void luf_takeoff_end(void) {}
+static inline void luf_takeoff_end(struct zone *zone) {}
 static inline bool luf_takeoff_no_shootdown(void) { return true; }
-static inline bool luf_takeoff_check(struct page *page) { return true; }
-static inline bool luf_takeoff_check_and_fold(struct page *page) { return true; }
+static inline bool luf_takeoff_check(struct zone *zone, struct page *page) { return true; }
+static inline bool luf_takeoff_check_and_fold(struct zone *zone, struct page *page) { return true; }
 static inline bool non_luf_pages_ok(struct zone *zone) { return true; }
 static inline unsigned short fold_unmap_luf(void) { return 0; }
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 41c38fbb58a30..69643c3564a47 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1400,6 +1400,7 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 	for_each_migratetype_order(order, t) {
 		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
 		INIT_LIST_HEAD(&zone->free_area[order].pend_list[t]);
+		zone->free_area[order].pend_zone_ugen[t] = ZONE_UGEN_INIT;
 		zone->free_area[order].nr_free = 0;
 	}
 
@@ -1407,6 +1408,10 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 	INIT_LIST_HEAD(&zone->unaccepted_pages);
 #endif
 	atomic_long_set(&zone->nr_luf_pages, 0);
+	zone->zone_ugen_done = ZONE_UGEN_INIT - 1;
+	zone->zone_ugen = ZONE_UGEN_INIT;
+	zone->luf_ugen = LUF_UGEN_INIT - 1;
+	reset_batch(&zone->zone_batch);
 }
 
 void __meminit init_currently_empty_zone(struct zone *zone,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 811e7c4bd2d19..917a257ea5706 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -663,16 +663,29 @@ bool luf_takeoff_start(void)
 	return !no_shootdown;
 }
 
+static void wait_zone_ugen_done(struct zone *zone, unsigned long zone_ugen)
+{
+	while (ugen_before(READ_ONCE(zone->zone_ugen_done), zone_ugen))
+		cond_resched();
+}
+
+static void set_zone_ugen_done(struct zone *zone, unsigned long zone_ugen)
+{
+	WRITE_ONCE(zone->zone_ugen_done, zone_ugen);
+}
+
 /*
  * Should be called within the same context of luf_takeoff_start().
  */
-void luf_takeoff_end(void)
+void luf_takeoff_end(struct zone *zone)
 {
 	struct tlbflush_unmap_batch *tlb_ubc_takeoff = &current->tlb_ubc_takeoff;
 	unsigned long flags;
 	bool no_shootdown;
 	bool outmost = false;
 	unsigned long cur_luf_ugen;
+	unsigned long cur_zone_ugen;
+	unsigned long cur_wait_zone_ugen;
 
 	local_irq_save(flags);
 	VM_WARN_ON(!current->luf_takeoff_started);
@@ -700,6 +713,8 @@ void luf_takeoff_end(void)
 		goto out;
 
 	cur_luf_ugen = current->luf_ugen;
+	cur_zone_ugen = current->zone_ugen;
+	cur_wait_zone_ugen = current->wait_zone_ugen;
 
 	current->luf_ugen = 0;
 
@@ -707,10 +722,38 @@ void luf_takeoff_end(void)
 		reset_batch(tlb_ubc_takeoff);
 
 	try_to_unmap_flush_takeoff();
+
+	if (cur_wait_zone_ugen || cur_zone_ugen) {
+		/*
+		 * pcp(zone == NULL) doesn't work with zone batch.
+		 */
+		if (zone) {
+			current->zone_ugen = 0;
+			current->wait_zone_ugen = 0;
+
+			/*
+			 * Guarantee that tlb shootdown required for the
+			 * zone_ugen has been completed once observing
+			 * 'zone_ugen_done'.
+			 */
+			smp_mb();
+
+			/*
+			 * zone->zone_ugen_done should be updated
+			 * sequentially.
+			 */
+			if (cur_wait_zone_ugen)
+				wait_zone_ugen_done(zone, cur_wait_zone_ugen);
+			if (cur_zone_ugen)
+				set_zone_ugen_done(zone, cur_zone_ugen);
+		}
+	}
 out:
 	if (outmost) {
 		VM_WARN_ON(current->luf_no_shootdown);
 		VM_WARN_ON(current->luf_ugen);
+		VM_WARN_ON(current->zone_ugen);
+		VM_WARN_ON(current->wait_zone_ugen);
 	}
 }
 
@@ -741,9 +784,9 @@ bool luf_takeoff_no_shootdown(void)
  * Should be called with either zone lock held and irq disabled or pcp
  * lock held.
  */
-bool luf_takeoff_check(struct page *page)
+bool luf_takeoff_check(struct zone *zone, struct page *page)
 {
-	unsigned short luf_key = page_luf_key(page);
+	unsigned long zone_ugen;
 
 	/*
 	 * No way.  Delimit using luf_takeoff_{start,end}().
@@ -753,7 +796,29 @@ bool luf_takeoff_check(struct page *page)
 		return false;
 	}
 
-	if (!luf_key)
+	if (!zone) {
+		unsigned short luf_key = page_luf_key(page);
+
+		if (!luf_key)
+			return true;
+
+		if (current->luf_no_shootdown)
+			return false;
+
+		return true;
+	}
+
+	zone_ugen = page_zone_ugen(zone, page);
+	if (!zone_ugen)
+		return true;
+
+	/*
+	 * Should not be zero since zone-zone_ugen has been updated in
+	 * __free_one_page() -> update_zone_batch().
+	 */
+	VM_WARN_ON(!zone->zone_ugen);
+
+	if (!ugen_before(READ_ONCE(zone->zone_ugen_done), zone_ugen))
 		return true;
 
 	return !current->luf_no_shootdown;
@@ -763,13 +828,11 @@ bool luf_takeoff_check(struct page *page)
  * Should be called with either zone lock held and irq disabled or pcp
  * lock held.
  */
-bool luf_takeoff_check_and_fold(struct page *page)
+bool luf_takeoff_check_and_fold(struct zone *zone, struct page *page)
 {
 	struct tlbflush_unmap_batch *tlb_ubc_takeoff = &current->tlb_ubc_takeoff;
-	unsigned short luf_key = page_luf_key(page);
-	struct luf_batch *lb;
-	unsigned long lb_ugen;
 	unsigned long flags;
+	unsigned long zone_ugen;
 
 	/*
 	 * No way.  Delimit using luf_takeoff_{start,end}().
@@ -779,28 +842,94 @@ bool luf_takeoff_check_and_fold(struct page *page)
 		return false;
 	}
 
-	if (!luf_key)
-		return true;
+	/*
+	 * pcp case
+	 */
+	if (!zone) {
+		unsigned short luf_key = page_luf_key(page);
+		struct luf_batch *lb;
+		unsigned long lb_ugen;
 
-	lb = &luf_batch[luf_key];
-	read_lock_irqsave(&lb->lock, flags);
-	lb_ugen = lb->ugen;
+		if (!luf_key)
+			return true;
+
+		lb = &luf_batch[luf_key];
+		read_lock_irqsave(&lb->lock, flags);
+		lb_ugen = lb->ugen;
+
+		if (arch_tlbbatch_check_done(&lb->batch.arch, lb_ugen)) {
+			read_unlock_irqrestore(&lb->lock, flags);
+			return true;
+		}
+
+		if (current->luf_no_shootdown) {
+			read_unlock_irqrestore(&lb->lock, flags);
+			return false;
+		}
 
-	if (arch_tlbbatch_check_done(&lb->batch.arch, lb_ugen)) {
+		fold_batch(tlb_ubc_takeoff, &lb->batch, false);
 		read_unlock_irqrestore(&lb->lock, flags);
+
+		if (!current->luf_ugen || ugen_before(current->luf_ugen, lb_ugen))
+			current->luf_ugen = lb_ugen;
 		return true;
 	}
 
-	if (current->luf_no_shootdown) {
-		read_unlock_irqrestore(&lb->lock, flags);
+	zone_ugen = page_zone_ugen(zone, page);
+	if (!zone_ugen)
+		return true;
+
+	/*
+	 * Should not be zero since zone-zone_ugen has been updated in
+	 * __free_one_page() -> update_zone_batch().
+	 */
+	VM_WARN_ON(!zone->zone_ugen);
+
+	if (!ugen_before(READ_ONCE(zone->zone_ugen_done), zone_ugen))
+		return true;
+
+	if (current->luf_no_shootdown)
 		return false;
-	}
 
-	fold_batch(tlb_ubc_takeoff, &lb->batch, false);
-	read_unlock_irqrestore(&lb->lock, flags);
+	/*
+	 * zone batched flush has been already set.
+	 */
+	if (current->zone_ugen)
+		return true;
+
+	/*
+	 * Others are already performing tlb shootdown for us.  All we
+	 * need is to wait for those to complete.
+	 */
+	if (zone_ugen != zone->zone_ugen) {
+		if (!current->wait_zone_ugen ||
+		    ugen_before(current->wait_zone_ugen, zone_ugen))
+			current->wait_zone_ugen = zone_ugen;
+	/*
+	 * It's the first time that zone->zone_ugen has been set to
+	 * current->zone_ugen.  current->luf_ugen also get set.
+	 */
+	} else {
+		current->wait_zone_ugen = prev_ugen(zone->zone_ugen);
+		current->zone_ugen = zone->zone_ugen;
+		current->luf_ugen = zone->luf_ugen;
+
+		/*
+		 * Now that tlb shootdown for the zone_ugen will be
+		 * performed at luf_takeoff_end(), advance it so that
+		 * the next zone->lock holder can efficiently avoid
+		 * unnecessary tlb shootdown.
+		 */
+		zone->zone_ugen = next_ugen(zone->zone_ugen);
 
-	if (!current->luf_ugen || ugen_before(current->luf_ugen, lb_ugen))
-		current->luf_ugen = lb_ugen;
+		/*
+		 * All the luf pages will eventually become non-luf
+		 * pages by tlb flushing at luf_takeoff_end() and,
+		 * flush_pend_list_if_done() will empty pend_list.
+		 */
+		atomic_long_set(&zone->nr_luf_pages, 0);
+		fold_batch(tlb_ubc_takeoff, &zone->zone_batch, true);
+	}
 	return true;
 }
 #endif
@@ -822,6 +951,42 @@ static inline void account_freepages(struct zone *zone, int nr_pages,
 			   zone->nr_free_highatomic + nr_pages);
 }
 
+static void flush_pend_list_if_done(struct zone *zone,
+		struct free_area *area, int migratetype)
+{
+	unsigned long zone_ugen_done = READ_ONCE(zone->zone_ugen_done);
+
+	/*
+	 * tlb shootdown required for the zone_ugen already has been
+	 * done.  Thus, let's move pages in pend_list to free_list to
+	 * secure more non-luf pages.
+	 */
+	if (!ugen_before(zone_ugen_done, area->pend_zone_ugen[migratetype]))
+		list_splice_init(&area->pend_list[migratetype],
+				 &area->free_list[migratetype]);
+}
+
+#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+/*
+ * Should be called with zone->lock held and irq disabled.
+ */
+static void update_zone_batch(struct zone *zone, unsigned short luf_key)
+{
+	unsigned long lb_ugen;
+	struct luf_batch *lb = &luf_batch[luf_key];
+
+	read_lock(&lb->lock);
+	fold_batch(&zone->zone_batch, &lb->batch, false);
+	lb_ugen = lb->ugen;
+	read_unlock(&lb->lock);
+
+	if (ugen_before(zone->luf_ugen, lb_ugen))
+		zone->luf_ugen = lb_ugen;
+}
+#else
+static void update_zone_batch(struct zone *zone, unsigned short luf_key) {}
+#endif
+
 /* Used for pages not on another list */
 static inline void __add_to_free_list(struct page *page, struct zone *zone,
 				      unsigned int order, int migratetype,
@@ -830,6 +995,12 @@ static inline void __add_to_free_list(struct page *page, struct zone *zone,
 	struct free_area *area = &zone->free_area[order];
 	struct list_head *list;
 
+	/*
+	 * Good chance to flush pend_list just before updating the
+	 * {free,pend}_list.
+	 */
+	flush_pend_list_if_done(zone, area, migratetype);
+
 	VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
 		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
 		     get_pageblock_migratetype(page), migratetype, 1 << order);
@@ -839,8 +1010,9 @@ static inline void __add_to_free_list(struct page *page, struct zone *zone,
 	 * positive is okay because it will cause just additional tlb
 	 * shootdown.
 	 */
-	if (page_luf_key(page)) {
+	if (page_zone_ugen(zone, page)) {
 		list = &area->pend_list[migratetype];
+		area->pend_zone_ugen[migratetype] = zone->zone_ugen;
 		atomic_long_add(1 << order, &zone->nr_luf_pages);
 	} else
 		list = &area->free_list[migratetype];
@@ -862,6 +1034,7 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
 				     unsigned int order, int old_mt, int new_mt)
 {
 	struct free_area *area = &zone->free_area[order];
+	unsigned long zone_ugen = page_zone_ugen(zone, page);
 
 	/* Free page moving can fail, so it happens before the type update */
 	VM_WARN_ONCE(get_pageblock_migratetype(page) != old_mt,
@@ -878,9 +1051,12 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
 	 * positive is okay because it will cause just additional tlb
 	 * shootdown.
 	 */
-	if (page_luf_key(page))
+	if (zone_ugen) {
 		list_move_tail(&page->buddy_list, &area->pend_list[new_mt]);
-	else
+		if (!area->pend_zone_ugen[new_mt] ||
+		    ugen_before(area->pend_zone_ugen[new_mt], zone_ugen))
+			area->pend_zone_ugen[new_mt] = zone_ugen;
+	} else
 		list_move_tail(&page->buddy_list, &area->free_list[new_mt]);
 
 	account_freepages(zone, -(1 << order), old_mt);
@@ -898,7 +1074,7 @@ static inline void __del_page_from_free_list(struct page *page, struct zone *zon
 	if (page_reported(page))
 		__ClearPageReported(page);
 
-	if (page_luf_key(page))
+	if (page_zone_ugen(zone, page))
 		atomic_long_sub(1 << order, &zone->nr_luf_pages);
 
 	list_del(&page->buddy_list);
@@ -936,29 +1112,39 @@ static inline struct page *get_page_from_free_area(struct zone *zone,
 	 */
 	pend_first = !non_luf_pages_ok(zone);
 
+	/*
+	 * Good chance to flush pend_list just before updating the
+	 * {free,pend}_list.
+	 */
+	flush_pend_list_if_done(zone, area, migratetype);
+
 	if (pend_first) {
 		page = list_first_entry_or_null(&area->pend_list[migratetype],
 				struct page, buddy_list);
 
-		if (page && luf_takeoff_check(page))
+		if (page && luf_takeoff_check(zone, page))
 			return page;
 
 		page = list_first_entry_or_null(&area->free_list[migratetype],
 				struct page, buddy_list);
 
-		if (page)
+		if (page) {
+			set_page_zone_ugen(page, 0);
 			return page;
+		}
 	} else {
 		page = list_first_entry_or_null(&area->free_list[migratetype],
 				struct page, buddy_list);
 
-		if (page)
+		if (page) {
+			set_page_zone_ugen(page, 0);
 			return page;
+		}
 
 		page = list_first_entry_or_null(&area->pend_list[migratetype],
 				struct page, buddy_list);
 
-		if (page && luf_takeoff_check(page))
+		if (page && luf_takeoff_check(zone, page))
 			return page;
 	}
 	return NULL;
@@ -1023,6 +1209,7 @@ static inline void __free_one_page(struct page *page,
 	unsigned long combined_pfn;
 	struct page *buddy;
 	bool to_tail;
+	unsigned long zone_ugen;
 
 	VM_BUG_ON(!zone_is_initialized(zone));
 	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
@@ -1034,20 +1221,25 @@ static inline void __free_one_page(struct page *page,
 	account_freepages(zone, 1 << order, migratetype);
 
 	/*
-	 * Use the page's luf_key unchanged if luf_key == 0.  Worth
-	 * noting that page_luf_key() will be 0 in most cases since it's
-	 * initialized at free_pages_prepare().
+	 * Use the page's zone_ugen unchanged if luf_key == 0.  Worth
+	 * noting that page_zone_ugen() will be 0 in most cases since
+	 * it's initialized at free_pages_prepare().
+	 *
+	 * Update page's zone_ugen and zone's batch only if a valid
+	 * luf_key was passed.
 	 */
-	if (luf_key)
-		set_page_luf_key(page, luf_key);
-	else
-		luf_key = page_luf_key(page);
+	if (luf_key) {
+		zone_ugen = zone->zone_ugen;
+		set_page_zone_ugen(page, (unsigned short)zone_ugen);
+		update_zone_batch(zone, luf_key);
+	} else
+		zone_ugen = page_zone_ugen(zone, page);
 
 	while (order < MAX_PAGE_ORDER) {
 		int buddy_mt = migratetype;
-		unsigned short buddy_luf_key;
+		unsigned long buddy_zone_ugen;
 
-		if (!luf_key && compaction_capture(capc, page, order, migratetype)) {
+		if (!zone_ugen && compaction_capture(capc, page, order, migratetype)) {
 			account_freepages(zone, -(1 << order), migratetype);
 			return;
 		}
@@ -1080,17 +1272,15 @@ static inline void __free_one_page(struct page *page,
 		else
 			__del_page_from_free_list(buddy, zone, order, buddy_mt);
 
+		buddy_zone_ugen = page_zone_ugen(zone, buddy);
+
 		/*
-		 * !buddy_luf_key && !luf_key : do nothing
-		 *  buddy_luf_key && !luf_key : luf_key = buddy_luf_key
-		 * !buddy_luf_key &&  luf_key : do nothing
-		 *  buddy_luf_key &&  luf_key : merge two into luf_key
+		 * if (!zone_ugen && !buddy_zone_ugen) : nothing to do
+		 * if ( zone_ugen && !buddy_zone_ugen) : nothing to do
 		 */
-		buddy_luf_key = page_luf_key(buddy);
-		if (buddy_luf_key && !luf_key)
-			luf_key = buddy_luf_key;
-		else if (buddy_luf_key && luf_key)
-			fold_luf_batch(&luf_batch[luf_key], &luf_batch[buddy_luf_key]);
+		if ((!zone_ugen && buddy_zone_ugen) ||
+		    ( zone_ugen && buddy_zone_ugen && ugen_before(zone_ugen, buddy_zone_ugen)))
+			zone_ugen = buddy_zone_ugen;
 
 		if (unlikely(buddy_mt != migratetype)) {
 			/*
@@ -1103,7 +1293,7 @@ static inline void __free_one_page(struct page *page,
 
 		combined_pfn = buddy_pfn & pfn;
 		page = page + (combined_pfn - pfn);
-		set_page_luf_key(page, luf_key);
+		set_page_zone_ugen(page, zone_ugen);
 		pfn = combined_pfn;
 		order++;
 	}
@@ -1446,6 +1636,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		do {
 			unsigned long pfn;
 			int mt;
+			unsigned short luf_key;
 
 			page = list_last_entry(list, struct page, pcp_list);
 			pfn = page_to_pfn(page);
@@ -1456,7 +1647,16 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
-			__free_one_page(page, pfn, zone, order, mt, FPI_NONE, 0);
+			/*
+			 * page private in pcp stores luf_key while it
+			 * stores zone_ugen in buddy.  Thus, the private
+			 * needs to be cleared and the luf_key needs to
+			 * be passed to buddy.
+			 */
+			luf_key = page_luf_key(page);
+			set_page_private(page, 0);
+
+			__free_one_page(page, pfn, zone, order, mt, FPI_NONE, luf_key);
 
 			trace_mm_page_pcpu_drain(page, order, mt);
 		} while (count > 0 && !list_empty(list));
@@ -1501,7 +1701,15 @@ static void free_one_page(struct zone *zone, struct page *page,
 	 * valid luf_key can be passed only if order == 0.
 	 */
 	VM_WARN_ON(luf_key && order);
-	set_page_luf_key(page, luf_key);
+
+	/*
+	 * Update page's zone_ugen and zone's batch only if a valid
+	 * luf_key was passed.
+	 */
+	if (luf_key) {
+		set_page_zone_ugen(page, (unsigned short)zone->zone_ugen);
+		update_zone_batch(zone, luf_key);
+	}
 
 	split_large_buddy(zone, page, pfn, order, fpi_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
@@ -1655,7 +1863,7 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		if (set_page_guard(zone, &page[size], high))
 			continue;
 
-		if (page_luf_key(&page[size]))
+		if (page_zone_ugen(zone, &page[size]))
 			tail = true;
 
 		__add_to_free_list(&page[size], zone, high, migratetype, tail);
@@ -1673,7 +1881,7 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 	int nr_pages = 1 << high;
 
 	__del_page_from_free_list(page, zone, high, migratetype);
-	if (unlikely(!luf_takeoff_check_and_fold(page)))
+	if (unlikely(!luf_takeoff_check_and_fold(zone, page)))
 		VM_WARN_ON(1);
 	nr_pages -= expand(zone, page, low, high, migratetype);
 	account_freepages(zone, -nr_pages, migratetype);
@@ -2202,7 +2410,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 		unsigned int nr_added;
 
 		del_page_from_free_list(page, zone, current_order, block_type);
-		if (unlikely(!luf_takeoff_check_and_fold(page)))
+		if (unlikely(!luf_takeoff_check_and_fold(zone, page)))
 			VM_WARN_ON(1);
 		change_pageblock_range(page, current_order, start_type);
 		nr_added = expand(zone, page, order, current_order, start_type);
@@ -2441,12 +2649,12 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			WARN_ON_ONCE(ret == -1);
 			if (ret > 0) {
 				spin_unlock_irqrestore(&zone->lock, flags);
-				luf_takeoff_end();
+				luf_takeoff_end(zone);
 				return ret;
 			}
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
-		luf_takeoff_end();
+		luf_takeoff_end(zone);
 	}
 
 	return false;
@@ -2611,12 +2819,15 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 * pages are ordered properly.
 		 */
 		list_add_tail(&page->pcp_list, list);
+
+		/*
+		 * Reset all the luf fields.  tlb shootdown will be
+		 * performed at luf_takeoff_end() below if needed.
+		 */
+		set_page_private(page, 0);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
-	/*
-	 * Check and flush before using the pages taken off.
-	 */
-	luf_takeoff_end();
+	luf_takeoff_end(zone);
 
 	return i;
 }
@@ -3130,7 +3341,7 @@ int __isolate_free_page(struct page *page, unsigned int order, bool willputback)
 	}
 
 	del_page_from_free_list(page, zone, order, mt);
-	if (unlikely(!willputback && !luf_takeoff_check_and_fold(page)))
+	if (unlikely(!willputback && !luf_takeoff_check_and_fold(zone, page)))
 		VM_WARN_ON(1);
 
 	/*
@@ -3229,7 +3440,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 			if (!page) {
 				spin_unlock_irqrestore(&zone->lock, flags);
-				luf_takeoff_end();
+				luf_takeoff_end(zone);
 				return NULL;
 			}
 		}
@@ -3237,7 +3448,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 		/*
 		 * Check and flush before using the pages taken off.
 		 */
-		luf_takeoff_end();
+		luf_takeoff_end(zone);
 	} while (check_new_pages(page, order));
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
@@ -3327,7 +3538,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		}
 
 		list_for_each_entry(page, list, pcp_list) {
-			if (luf_takeoff_check_and_fold(page)) {
+			if (luf_takeoff_check_and_fold(NULL, page)) {
 				list_del(&page->pcp_list);
 				pcp->count -= 1 << order;
 				break;
@@ -3362,7 +3573,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (!pcp) {
 		pcp_trylock_finish(UP_flags);
-		luf_takeoff_end();
+		luf_takeoff_end(NULL);
 		return NULL;
 	}
 
@@ -3379,7 +3590,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	/*
 	 * Check and flush before using the pages taken off.
 	 */
-	luf_takeoff_end();
+	luf_takeoff_end(NULL);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
 		zone_statistics(preferred_zone, zone, 1);
@@ -3418,6 +3629,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 							migratetype);
 
 out:
+
 	/* Separate test+clear to avoid unnecessary atomics */
 	if ((alloc_flags & ALLOC_KSWAPD) &&
 	    unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
@@ -5017,7 +5229,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	/*
 	 * Check and flush before using the pages taken off.
 	 */
-	luf_takeoff_end();
+	luf_takeoff_end(NULL);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
@@ -5027,7 +5239,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 
 failed_irq:
 	pcp_trylock_finish(UP_flags);
-	luf_takeoff_end();
+	luf_takeoff_end(NULL);
 
 failed:
 	page = __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask);
@@ -7111,7 +7323,7 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
 		VM_WARN_ON(get_pageblock_migratetype(page) != MIGRATE_ISOLATE);
 		order = buddy_order(page);
 		del_page_from_free_list(page, zone, order, MIGRATE_ISOLATE);
-		if (unlikely(!luf_takeoff_check_and_fold(page)))
+		if (unlikely(!luf_takeoff_check_and_fold(zone, page)))
 			VM_WARN_ON(1);
 		pfn += (1 << order);
 	}
@@ -7119,7 +7331,7 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
 	/*
 	 * Check and flush before using the pages taken off.
 	 */
-	luf_takeoff_end();
+	luf_takeoff_end(zone);
 
 	return end_pfn - start_pfn - already_offline;
 }
@@ -7181,7 +7393,7 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 		if (set_page_guard(zone, current_buddy, high))
 			continue;
 
-		if (page_luf_key(current_buddy))
+		if (page_zone_ugen(zone, current_buddy))
 			tail = true;
 
 		add_to_free_list(current_buddy, zone, high, migratetype, tail);
@@ -7213,7 +7425,7 @@ bool take_page_off_buddy(struct page *page)
 
 			del_page_from_free_list(page_head, zone, page_order,
 						migratetype);
-			if (unlikely(!luf_takeoff_check_and_fold(page_head)))
+			if (unlikely(!luf_takeoff_check_and_fold(zone, page_head)))
 				VM_WARN_ON(1);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
@@ -7229,7 +7441,7 @@ bool take_page_off_buddy(struct page *page)
 	/*
 	 * Check and flush before using the pages taken off.
 	 */
-	luf_takeoff_end();
+	luf_takeoff_end(zone);
 	return ret;
 }
 
@@ -7248,6 +7460,13 @@ bool put_page_back_buddy(struct page *page)
 		int migratetype = get_pfnblock_migratetype(page, pfn);
 
 		ClearPageHWPoisonTakenOff(page);
+
+		/*
+		 * Reset all the luf fields.  tlb shootdown has already
+		 * been performed by take_page_off_buddy().
+		 */
+		set_page_private(page, 0);
+
 		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE, 0);
 		if (TestClearPageHWPoison(page)) {
 			ret = true;
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e152b22fbba8a..b23d3ed34ec07 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -118,7 +118,8 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 
 		/*
 		 * Ensure private is zero before putting into the
-		 * allocator.
+		 * allocator.  tlb shootdown has already been performed
+		 * at isolation.
 		 */
 		set_page_private(page, 0);
 
@@ -194,7 +195,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		if (PageReported(page))
 			continue;
 
-		if (unlikely(consider_pend && !luf_takeoff_check(page))) {
+		if (unlikely(consider_pend && !luf_takeoff_check(zone, page))) {
 			VM_WARN_ON(1);
 			continue;
 		}
@@ -238,7 +239,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		/*
 		 * Check and flush before using the pages taken off.
 		 */
-		luf_takeoff_end();
+		luf_takeoff_end(zone);
 
 		/* begin processing pages in local list */
 		err = prdev->report(prdev, sgl, PAGE_REPORTING_CAPACITY);
@@ -283,7 +284,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	/*
 	 * Check and flush before using the pages taken off.
 	 */
-	luf_takeoff_end();
+	luf_takeoff_end(zone);
 
 	return err;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 58dfc9889b1ee..b6613b48669ac 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -650,7 +650,11 @@ static unsigned long new_luf_ugen(void)
 {
 	unsigned long ugen = atomic_long_inc_return(&luf_ugen);
 
-	if (!ugen)
+	/*
+	 * Avoid zero even in unsigned short range so as to treat
+	 * '(unsigned short)ugen == 0' as invalid.
+	 */
+	if (!(unsigned short)ugen)
 		ugen = atomic_long_inc_return(&luf_ugen);
 
 	return ugen;
-- 
2.17.1


