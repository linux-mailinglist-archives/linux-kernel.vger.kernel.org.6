Return-Path: <linux-kernel+bounces-196569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DAA8D5E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220B81C2518B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55351422CD;
	Fri, 31 May 2024 09:20:30 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C8712E1C1
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147229; cv=none; b=DcbWpKYeAUWH/dLx4WHkFlnsYxcd2h8EilzaP5xH908qmbH0TWgS36Or5M9Vj2eVHgDwru5d9qu3zJGY077j03xYhhi4zOvaj1mFg0+R0VQj5E2jhSzX36AFu3d3Yzay4mXRrvcqnTFuSv5sqfoO7k4g7wKNufTwqkaSawBnq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147229; c=relaxed/simple;
	bh=iV5K6/tGDI2v/79Xswlov0Ay0bi7eO/B8jBLVnbOoTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fKUL0H8w4eL66dXA2dh3oRPQdACt3RqhQNV+g6nEPQQ66LXftx2iZV/sliM8ygXpuWHIG2BpfbKsBwowz/UoZLLAygjJN6iOQTwlHZKC+AuKAxCMsaMqWXjguIMVF/6wYJl7VLS+RZANd95sUOKEjbtAXV2DKcjsWby8afJrims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-5c-6659964cd640
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
Subject: [PATCH v11 06/12] mm: add folio_put_ugen() to deliver unmap generation number to pcp or buddy
Date: Fri, 31 May 2024 18:19:55 +0900
Message-Id: <20240531092001.30428-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240531092001.30428-1-byungchul@sk.com>
References: <20240531092001.30428-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnka7PtMg0g5ffBCzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	pSVdzAV3djFWbH5/jLWB8c9Uxi5GTg4JAROJNR+3MMPY8ycvBLPZBNQlbtz4CWaLCJhJHGz9
	ww5iMwvcZZI40M8GYgsLpElseLgBrIZFQFWideI2sJm8AqYSVy+0skPMlJdYveEAWA0n0JwD
	f++A1QgB1Sz63wtkcwHVvGeT2L1hClSDpMTBFTdYJjDyLmBkWMUolJlXlpuYmWOil1GZl1mh
	l5yfu4kRGP7Lav9E72D8dCH4EKMAB6MSD29ARUSaEGtiWXFl7iFGCQ5mJRHeX+lAId6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYyiU+u+dJs81q66mnip
	VM/WceK/3ysvHs2712q+q3T/6/7AB99fO/q0Op/QMu6uNi8RS7m2c/bUfMeZAj+uidcs8p7Y
	9Fyg4WTjmpOM25q4orzZb1/ddSYs5dWTL1LPueyjbuqbljy6uPNji4+QWdy6vLNRiyX1Ph46
	fmmOxRapmK7AY017ba8rsRRnJBpqMRcVJwIAoUFZvHsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsXC5WfdrOszLTLNoG09q8Wc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4Mi4t6WIuuLOLsWLz+2OsDYx/pjJ2MXJySAiYSMyfvJAZxGYTUJe4ceMnmC0i
	YCZxsPUPO4jNLHCXSeJAPxuILSyQJrHh4QawGhYBVYnWidvA5vAKmEpcvdDKDjFTXmL1hgNg
	NZxAcw78vQNWIwRUs+h/L+MERq4FjAyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAoN5We2f
	iTsYv1x2P8QowMGoxMMbUBGRJsSaWFZcmXuIUYKDWUmE91c6UIg3JbGyKrUoP76oNCe1+BCj
	NAeLkjivV3hqgpBAemJJanZqakFqEUyWiYNTqoGR1+f4t395D/LnnVQ7Yda6Ym2UnnhziXyd
	5sOJ6s/2cf1bKxw5K++L+px/q+615WmxZ7z8s3Hfy9BjzB3sSgXLl396nGoaeeLW82XVtbuq
	1doFRJfOk5gzXWza6vePZtwt6XuscjI0/86NK5KKqv8Dn7Te38t9W2j/E0WdxZKH7D5IvGK6
	z/zooxJLcUaioRZzUXEiAMkMLzpiAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Introduced a new API, folio_put_ugen(), to deliver unmap generation
number to pcp or buddy that will be used by luf mechanism to track need
of tlb flush for each page residing in pcp or buddy.

For now, the delivery should work for the following call path that is of
releasing source folios during migration:

	folio_put_ugen()
	   __folio_put_ugen()
	      free_unref_page()
	         free_unref_page_commit()
	         free_one_page()
	            __free_one_page()

The generation number should be handed over properly when pages travel
between pcp and buddy, and must do necessary handling on exit from pcp
or buddy.  This patch doesn't include actual body for tlb flush on the
exit, which will be filled by the main patch of luf mechanism.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm.h    |  22 +++++++
 include/linux/sched.h |   1 +
 mm/compaction.c       |  10 +++
 mm/internal.h         |  71 ++++++++++++++++++++-
 mm/page_alloc.c       | 144 ++++++++++++++++++++++++++++++++++--------
 mm/page_isolation.c   |   6 ++
 mm/page_reporting.c   |  10 +++
 mm/swap.c             |  12 +++-
 8 files changed, 248 insertions(+), 28 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3aa1b6889bcc..54cb6316a76d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1316,6 +1316,7 @@ static inline struct folio *virt_to_folio(const void *x)
 }
 
 void __folio_put(struct folio *folio);
+void __folio_put_ugen(struct folio *folio, unsigned short int ugen);
 
 void put_pages_list(struct list_head *pages);
 
@@ -1508,6 +1509,27 @@ static inline void folio_put(struct folio *folio)
 		__folio_put(folio);
 }
 
+/**
+ * folio_put_ugen - Decrement the last reference count on a folio.
+ * @folio: The folio.
+ * @ugen: The unmap generation # of TLB flush that the folio requires.
+ *
+ * The folio's reference count should be one since the only user, folio
+ * migration code, calls folio_put_ugen() only when the folio has no
+ * reference else.  The memory will be released back to the page
+ * allocator and may be used by another allocation immediately.  Do not
+ * access the memory or the struct folio after calling folio_put_ugen().
+ *
+ * Context: May be called in process or interrupt context, but not in NMI
+ * context.  May be called while holding a spinlock.
+ */
+static inline void folio_put_ugen(struct folio *folio, unsigned short int ugen)
+{
+	if (WARN_ON(!folio_put_testzero(folio)))
+		return;
+	__folio_put_ugen(folio, ugen);
+}
+
 /**
  * folio_put_refs - Reduce the reference count on a folio.
  * @folio: The folio.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..ab5a2ed79b88 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1340,6 +1340,7 @@ struct task_struct {
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
+	unsigned short int		ugen;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/compaction.c b/mm/compaction.c
index e731d45befc7..13799fbb2a9a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -701,6 +701,11 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	if (locked)
 		spin_unlock_irqrestore(&cc->zone->lock, flags);
 
+	/*
+	 * Check and flush before using the isolated pages.
+	 */
+	check_flush_task_ugen();
+
 	/*
 	 * Be careful to not go outside of the pageblock.
 	 */
@@ -1673,6 +1678,11 @@ static void fast_isolate_freepages(struct compact_control *cc)
 
 		spin_unlock_irqrestore(&cc->zone->lock, flags);
 
+		/*
+		 * Check and flush before using the isolated pages.
+		 */
+		check_flush_task_ugen();
+
 		/* Skip fast search if enough freepages isolated */
 		if (cc->nr_freepages >= cc->nr_migratepages)
 			break;
diff --git a/mm/internal.h b/mm/internal.h
index 552e1061d36d..380ae980e4f9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -661,7 +661,7 @@ extern bool free_pages_prepare(struct page *page, unsigned int order);
 
 extern int user_min_free_kbytes;
 
-void free_unref_page(struct page *page, unsigned int order);
+void free_unref_page(struct page *page, unsigned int order, unsigned short int ugen);
 void free_unref_folios(struct folio_batch *fbatch);
 
 extern void zone_pcp_reset(struct zone *zone);
@@ -1536,6 +1536,75 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
 
+#if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+static inline unsigned short int ugen_latest(unsigned short int a, unsigned short int b)
+{
+	if (!a || !b)
+		return a + b;
+
+	/*
+	 * The ugen is wrapped around so let's use this trick.
+	 */
+	if ((short int)(a - b) < 0)
+		return b;
+	else
+		return a;
+}
+
+static inline void update_task_ugen(unsigned short int ugen)
+{
+	current->ugen = ugen_latest(current->ugen, ugen);
+}
+
+static inline unsigned short int hand_over_task_ugen(void)
+{
+	unsigned short int ret = current->ugen;
+
+	current->ugen = 0;
+	return ret;
+}
+
+static inline void check_flush_task_ugen(void)
+{
+	/*
+	 * XXX: luf mechanism will handle this. For now, do nothing but
+	 * reset current's ugen to finalize this turn.
+	 */
+	current->ugen = 0;
+}
+
+/*
+ * Check the constratints of what luf currently supports.
+ */
+static inline bool can_luf_folio(struct folio *f)
+{
+	bool can_luf = true;
+
+	/*
+	 * XXX: Remove the constraint once luf handles zone device folio.
+	 */
+	can_luf = can_luf && likely(!folio_is_zone_device(f));
+
+	/*
+	 * XXX: Remove the constraint once luf handles hugetlb folio.
+	 */
+	can_luf = can_luf && likely(!folio_test_hugetlb(f));
+
+	/*
+	 * XXX: Remove the constraint once luf handles large folio.
+	 */
+	can_luf = can_luf && likely(!folio_test_large(f));
+
+	return can_luf;
+}
+#else /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
+static inline unsigned short int ugen_latest(unsigned short int a, unsigned short int b) { return 0; }
+static inline void update_task_ugen(unsigned short int ugen) {}
+static inline unsigned short int hand_over_task_ugen(void) { return 0; }
+static inline void check_flush_task_ugen(void) {}
+static inline bool can_luf_folio(struct folio *f) { return false; }
+#endif
+
 struct unlink_vma_file_batch {
 	int count;
 	struct vm_area_struct *vmas[8];
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ae57dd8718fe..6fbbe45be5ae 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -688,6 +688,7 @@ static inline void __del_page_from_free_list(struct page *page, struct zone *zon
 	if (page_reported(page))
 		__ClearPageReported(page);
 
+	update_task_ugen(page_buddy_ugen(page));
 	list_del(&page->buddy_list);
 	__ClearPageBuddy(page);
 	set_page_private(page, 0);
@@ -760,7 +761,7 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
 static inline void __free_one_page(struct page *page,
 		unsigned long pfn,
 		struct zone *zone, unsigned int order,
-		int migratetype, fpi_t fpi_flags)
+		int migratetype, fpi_t fpi_flags, unsigned short int ugen)
 {
 	struct capture_control *capc = task_capc(zone);
 	unsigned long buddy_pfn = 0;
@@ -775,12 +776,22 @@ static inline void __free_one_page(struct page *page,
 	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
 	VM_BUG_ON_PAGE(bad_range(zone, page), page);
 
+	/*
+	 * Ensure private is zero before using it inside buddy.
+	 */
+	set_page_private(page, 0);
+
 	account_freepages(zone, 1 << order, migratetype);
 
 	while (order < MAX_PAGE_ORDER) {
 		int buddy_mt = migratetype;
 
 		if (compaction_capture(capc, page, order, migratetype)) {
+			/*
+			 * Capturer will check_flush_task_ugen() through
+			 * prep_new_page().
+			 */
+			update_task_ugen(ugen);
 			account_freepages(zone, -(1 << order), migratetype);
 			return;
 		}
@@ -811,6 +822,11 @@ static inline void __free_one_page(struct page *page,
 		if (page_is_guard(buddy))
 			clear_page_guard(zone, buddy, order);
 		else
+			/*
+			 * __del_page_from_free_list() updates current's
+			 * ugen that pairs with hand_over_task_ugen() below
+			 * in this funtion.
+			 */
 			__del_page_from_free_list(buddy, zone, order, buddy_mt);
 
 		if (unlikely(buddy_mt != migratetype)) {
@@ -829,7 +845,8 @@ static inline void __free_one_page(struct page *page,
 	}
 
 done_merging:
-	set_buddy_order_ugen(page, order, 0);
+	ugen = ugen_latest(ugen, hand_over_task_ugen());
+	set_buddy_order_ugen(page, order, ugen);
 
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
@@ -1040,6 +1057,11 @@ __always_inline bool free_pages_prepare(struct page *page,
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
+	/*
+	 * Ensure private is zero before using it inside pcp.
+	 */
+	set_page_private(page, 0);
+
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
 
@@ -1171,17 +1193,23 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		do {
 			unsigned long pfn;
 			int mt;
+			unsigned short int ugen;
 
 			page = list_last_entry(list, struct page, pcp_list);
 			pfn = page_to_pfn(page);
 			mt = get_pfnblock_migratetype(page, pfn);
 
+			/*
+			 * pcp uses private to store ugen.
+			 */
+			ugen = page_private(page);
+
 			/* must delete to avoid corrupting pcp list */
 			list_del(&page->pcp_list);
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
-			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
+			__free_one_page(page, pfn, zone, order, mt, FPI_NONE, ugen);
 			trace_mm_page_pcpu_drain(page, order, mt);
 		} while (count > 0 && !list_empty(list));
 	}
@@ -1191,14 +1219,14 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 
 static void free_one_page(struct zone *zone, struct page *page,
 			  unsigned long pfn, unsigned int order,
-			  fpi_t fpi_flags)
+			  fpi_t fpi_flags, unsigned short int ugen)
 {
 	unsigned long flags;
 	int migratetype;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	migratetype = get_pfnblock_migratetype(page, pfn);
-	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
+	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags, ugen);
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
@@ -1211,7 +1239,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	if (!free_pages_prepare(page, order))
 		return;
 
-	free_one_page(zone, page, pfn, order, fpi_flags);
+	free_one_page(zone, page, pfn, order, fpi_flags, 0);
 
 	__count_vm_events(PGFREE, 1 << order);
 }
@@ -1476,6 +1504,10 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
 							unsigned int alloc_flags)
 {
+	/*
+	 * Check and flush before using the pages.
+	 */
+	check_flush_task_ugen();
 	post_alloc_hook(page, order, gfp_flags);
 
 	if (order && (gfp_flags & __GFP_COMP))
@@ -1511,6 +1543,10 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 		page = get_page_from_free_area(area, migratetype);
 		if (!page)
 			continue;
+		/*
+		 * del_page_from_free_list() updates current's ugen that
+		 * pairs with check_flush_task_ugen() in prep_new_page().
+		 */
 		del_page_from_free_list(page, zone, current_order, migratetype);
 		expand(zone, page, order, current_order, migratetype);
 		trace_mm_page_alloc_zone_locked(page, order, migratetype,
@@ -1673,7 +1709,8 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
 
 /* Split a multi-block free page into its individual pageblocks */
 static void split_large_buddy(struct zone *zone, struct page *page,
-			      unsigned long pfn, int order)
+			      unsigned long pfn, int order,
+			      unsigned short int ugen)
 {
 	unsigned long end_pfn = pfn + (1 << order);
 
@@ -1686,7 +1723,7 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	while (pfn != end_pfn) {
 		int mt = get_pfnblock_migratetype(page, pfn);
 
-		__free_one_page(page, pfn, zone, pageblock_order, mt, FPI_NONE);
+		__free_one_page(page, pfn, zone, pageblock_order, mt, FPI_NONE, ugen);
 		pfn += pageblock_nr_pages;
 		page = pfn_to_page(pfn);
 	}
@@ -1728,22 +1765,34 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 	if (pfn != start_pfn) {
 		struct page *buddy = pfn_to_page(pfn);
 		int order = buddy_order(buddy);
+		unsigned short int ugen;
 
+		/*
+		 * del_page_from_free_list() updates current's ugen that
+		 * pairs with the following hand_over_task_ugen().
+		 */
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, pfn));
+		ugen = hand_over_task_ugen();
 		set_pageblock_migratetype(page, migratetype);
-		split_large_buddy(zone, buddy, pfn, order);
+		split_large_buddy(zone, buddy, pfn, order, ugen);
 		return true;
 	}
 
 	/* We're the starting block of a larger buddy */
 	if (PageBuddy(page) && buddy_order(page) > pageblock_order) {
 		int order = buddy_order(page);
+		unsigned short int ugen;
 
+		/*
+		 * del_page_from_free_list() updates current's ugen that
+		 * pairs with the following hand_over_task_ugen().
+		 */
 		del_page_from_free_list(page, zone, order,
 					get_pfnblock_migratetype(page, pfn));
+		ugen = hand_over_task_ugen();
 		set_pageblock_migratetype(page, migratetype);
-		split_large_buddy(zone, page, pfn, order);
+		split_large_buddy(zone, page, pfn, order, ugen);
 		return true;
 	}
 move:
@@ -1863,6 +1912,10 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
+		/*
+		 * del_page_from_free_list() updates current's ugen that
+		 * pairs with check_flush_task_ugen() in prep_new_page().
+		 */
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
 		expand(zone, page, order, current_order, start_type);
@@ -1918,6 +1971,10 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	}
 
 single_page:
+	/*
+	 * del_page_from_free_list() updates current's ugen that pairs
+	 * with check_flush_task_ugen() in prep_new_page().
+	 */
 	del_page_from_free_list(page, zone, current_order, block_type);
 	expand(zone, page, order, current_order, block_type);
 	return page;
@@ -2539,7 +2596,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 
 static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 				   struct page *page, int migratetype,
-				   unsigned int order)
+				   unsigned int order, unsigned short int ugen)
 {
 	int high, batch;
 	int pindex;
@@ -2553,6 +2610,11 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	pcp->alloc_factor >>= 1;
 	__count_vm_events(PGFREE, 1 << order);
 	pindex = order_to_pindex(migratetype, order);
+
+	/*
+	 * pcp uses private to store ugen.
+	 */
+	set_page_private(page, ugen);
 	list_add(&page->pcp_list, &pcp->lists[pindex]);
 	pcp->count += 1 << order;
 
@@ -2588,7 +2650,8 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 /*
  * Free a pcp page
  */
-void free_unref_page(struct page *page, unsigned int order)
+void free_unref_page(struct page *page, unsigned int order,
+		     unsigned short int ugen)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
@@ -2614,7 +2677,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	migratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(page_zone(page), page, pfn, order, FPI_NONE);
+			free_one_page(page_zone(page), page, pfn, order, FPI_NONE, ugen);
 			return;
 		}
 		migratetype = MIGRATE_MOVABLE;
@@ -2624,10 +2687,10 @@ void free_unref_page(struct page *page, unsigned int order)
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_unref_page_commit(zone, pcp, page, migratetype, order);
+		free_unref_page_commit(zone, pcp, page, migratetype, order, ugen);
 		pcp_spin_unlock(pcp);
 	} else {
-		free_one_page(zone, page, pfn, order, FPI_NONE);
+		free_one_page(zone, page, pfn, order, FPI_NONE, ugen);
 	}
 	pcp_trylock_finish(UP_flags);
 }
@@ -2657,7 +2720,7 @@ void free_unref_folios(struct folio_batch *folios)
 		 */
 		if (!pcp_allowed_order(order)) {
 			free_one_page(folio_zone(folio), &folio->page,
-				      pfn, order, FPI_NONE);
+				      pfn, order, FPI_NONE, 0);
 			continue;
 		}
 		folio->private = (void *)(unsigned long)order;
@@ -2693,7 +2756,7 @@ void free_unref_folios(struct folio_batch *folios)
 			 */
 			if (is_migrate_isolate(migratetype)) {
 				free_one_page(zone, &folio->page, pfn,
-					      order, FPI_NONE);
+					      order, FPI_NONE, 0);
 				continue;
 			}
 
@@ -2706,7 +2769,7 @@ void free_unref_folios(struct folio_batch *folios)
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, &folio->page, pfn,
-					      order, FPI_NONE);
+					      order, FPI_NONE, 0);
 				continue;
 			}
 			locked_zone = zone;
@@ -2721,7 +2784,7 @@ void free_unref_folios(struct folio_batch *folios)
 
 		trace_mm_page_free_batched(&folio->page);
 		free_unref_page_commit(zone, pcp, &folio->page, migratetype,
-				order);
+				order, 0);
 	}
 
 	if (pcp) {
@@ -2772,6 +2835,11 @@ int __isolate_free_page(struct page *page, unsigned int order)
 			return 0;
 	}
 
+	/*
+	 * del_page_from_free_list() updates current's ugen. The user of
+	 * the isolated page should check_flush_task_ugen() before using
+	 * it.
+	 */
 	del_page_from_free_list(page, zone, order, mt);
 
 	/*
@@ -2813,7 +2881,7 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
 
 	/* Return isolated page to tail of freelist. */
 	__free_one_page(page, page_to_pfn(page), zone, order, mt,
-			FPI_SKIP_REPORT_NOTIFY | FPI_TO_TAIL);
+			FPI_SKIP_REPORT_NOTIFY | FPI_TO_TAIL, 0);
 }
 
 /*
@@ -2956,6 +3024,11 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		}
 
 		page = list_first_entry(list, struct page, pcp_list);
+
+		/*
+		 * Pairs with check_flush_task_ugen() in prep_new_page().
+		 */
+		update_task_ugen(page_private(page));
 		list_del(&page->pcp_list);
 		pcp->count -= 1 << order;
 	} while (check_new_pages(page, order));
@@ -4782,11 +4855,11 @@ void __free_pages(struct page *page, unsigned int order)
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
@@ -4848,7 +4921,7 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
 
 	if (page_ref_sub_and_test(page, count))
-		free_unref_page(page, compound_order(page));
+		free_unref_page(page, compound_order(page), 0);
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
@@ -4889,7 +4962,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			goto refill;
 
 		if (unlikely(nc->pfmemalloc)) {
-			free_unref_page(page, compound_order(page));
+			free_unref_page(page, compound_order(page), 0);
 			goto refill;
 		}
 
@@ -4933,7 +5006,7 @@ void page_frag_free(void *addr)
 	struct page *page = virt_to_head_page(addr);
 
 	if (unlikely(put_page_testzero(page)))
-		free_unref_page(page, compound_order(page));
+		free_unref_page(page, compound_order(page), 0);
 }
 EXPORT_SYMBOL(page_frag_free);
 
@@ -6742,10 +6815,19 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		BUG_ON(!PageBuddy(page));
 		VM_WARN_ON(get_pageblock_migratetype(page) != MIGRATE_ISOLATE);
 		order = buddy_order(page);
+		/*
+		 * del_page_from_free_list() updates current's ugen that
+		 * pairs with check_flush_task_ugen() below in this function.
+		 */
 		del_page_from_free_list(page, zone, order, MIGRATE_ISOLATE);
 		pfn += (1 << order);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	/*
+	 * Check and flush before using it.
+	 */
+	check_flush_task_ugen();
 }
 #endif
 
@@ -6829,6 +6911,11 @@ bool take_page_off_buddy(struct page *page)
 			int migratetype = get_pfnblock_migratetype(page_head,
 								   pfn_head);
 
+			/*
+			 * del_page_from_free_list() updates current's
+			 * ugen that pairs with check_flush_task_ugen() below
+			 * in this function.
+			 */
 			del_page_from_free_list(page_head, zone, page_order,
 						migratetype);
 			break_down_buddy_pages(zone, page_head, page, 0,
@@ -6841,6 +6928,11 @@ bool take_page_off_buddy(struct page *page)
 			break;
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	/*
+	 * Check and flush before using it.
+	 */
+	check_flush_task_ugen();
 	return ret;
 }
 
@@ -6859,7 +6951,7 @@ bool put_page_back_buddy(struct page *page)
 		int migratetype = get_pfnblock_migratetype(page, pfn);
 
 		ClearPageHWPoisonTakenOff(page);
-		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
+		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE, 0);
 		if (TestClearPageHWPoison(page)) {
 			ret = true;
 		}
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 042937d5abe4..5823da60a621 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -260,6 +260,12 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 	zone->nr_isolate_pageblock--;
 out:
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	/*
+	 * Check and flush for the pages that have been isolated.
+	 */
+	if (isolated_page)
+		check_flush_task_ugen();
 }
 
 static inline struct page *
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e4c428e61d8c..4f94a3ea1b22 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -221,6 +221,11 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		/* release lock before waiting on report processing */
 		spin_unlock_irq(&zone->lock);
 
+		/*
+		 * Check and flush before using the isolated pages.
+		 */
+		check_flush_task_ugen();
+
 		/* begin processing pages in local list */
 		err = prdev->report(prdev, sgl, PAGE_REPORTING_CAPACITY);
 
@@ -253,6 +258,11 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 
 	spin_unlock_irq(&zone->lock);
 
+	/*
+	 * Check and flush before using the isolated pages.
+	 */
+	check_flush_task_ugen();
+
 	return err;
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index dc205bdfbbd4..dae169b19ab9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -125,10 +125,20 @@ void __folio_put(struct folio *folio)
 	page_cache_release(folio);
 	folio_undo_large_rmappable(folio);
 	mem_cgroup_uncharge(folio);
-	free_unref_page(&folio->page, folio_order(folio));
+	free_unref_page(&folio->page, folio_order(folio), 0);
 }
 EXPORT_SYMBOL(__folio_put);
 
+void __folio_put_ugen(struct folio *folio, unsigned short int ugen)
+{
+	if (WARN_ON(!can_luf_folio(folio)))
+		return;
+
+	page_cache_release(folio);
+	mem_cgroup_uncharge(folio);
+	free_unref_page(&folio->page, 0, ugen);
+}
+
 /**
  * put_pages_list() - release a list of pages
  * @pages: list of pages threaded on page->lru
-- 
2.17.1


