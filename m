Return-Path: <linux-kernel+bounces-261496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E51EE93B7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A891F21DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C789F16F293;
	Wed, 24 Jul 2024 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CocBXPi6"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055EF16E876
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852484; cv=none; b=EIAr/xGlSvUVJoCQHeuq2w/6cm2DqwDhgSrKWYYy3kDjOTobJ9T3luzm8APBJdRwPoZV4nvel2P0DcAviISi8m013VagI4l7e8wdhQCg97950eE0tnSIZwH+TTfq4/y3WvgMCIk79/VOMdWMULuFyD+8mOgJiveGd1X1mQpJu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852484; c=relaxed/simple;
	bh=B1syPCOmdrdltun4zAsGsEnvqUqqjhsBsqJa4ffnQ70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehT+6tnKEXzqJlnV7yexXbYJNTV5FLzH70C5wFEtxIvuy/Dp4oPvYuPORiwsOJMDxCCJyeooc5hGH/YLYzK644isldOhl/Kk4rKUKlt8fefbBntHpNYECl8b8xofCGg6pcW0syKqGRRfUOrfRiLas5KrHZj2RNIVoCKSoOdgDf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CocBXPi6; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721852478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49uM8VZTHdXJBFARU7grw5ZcrAGZPQkUi16eCtktDdI=;
	b=CocBXPi66+vdP1QWWqKOh0AcXR/j3sZd+zEPbGZyY0WR9m0rvPpeAggQEvBbEjZtmgobn1
	EllUmCPDEqplXRsAZbyDWZPzIWP4FL/u+PZREO/QZ9P0ftV4RXeB/Fv9p0xQYoTo7eCgPS
	wGtzKPGZHr1LL/PH7nUWlB86UgZpC1A=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 3/5] mm: memcg: merge multiple page_counters into a single structure
Date: Wed, 24 Jul 2024 20:21:01 +0000
Message-ID: <20240724202103.1210065-4-roman.gushchin@linux.dev>
In-Reply-To: <20240724202103.1210065-1-roman.gushchin@linux.dev>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Struct page_counter is used by memory and hugetlb cgroups to track
the resource usage. Memory cgroups are using up to four different
counters (on cgroup v1). Hugetlb cgroups are using 2 * HUGE_MAX_HSTATE
counters.

Every page_counter structure (except the one belonging to the root
cgroup) contains a pointer to the corresponding parent structure.
It's obviously wasteful because for each cgroup there are several
similar chains of page_counter structures. It's not particularly
cache-effective too.

Also every page_counter structure contains fields required for
tracking the usage of the memory protection, while it's used only
for the main ("memory") counter and only by memory cgroups.

To address these issues let's make page_counter structures to support
N counters and use a single page_counter structure for a memory cgroup
and 2 page_counter structures for a hugetlb cgroup (to track the
actual usage and reservations).

N is determined at the compile time depending on the configuration and
HUGE_MAX_HSTATE value. HUGE_MAX_HSTATE is relatively small on all
existing platforms (max is 5 on sparc), so it's not too far from 4
memcg memory types.

Memory min/low functionality is supported only for the first counter.

Memory savings (on x86_64):

|-----------------------------+----------------------------+----------------------------|
|                             | memcg                      | hugetlb                    |
|-----------------------------+----------------------------+----------------------------|
| original, CONFIG_MEMCG_V1=n | size: 1600, cachelines: 25 | size: 1280, cachelines: 20 |
| patched, CONFIG_MEMCG_V1=n  | size: 1472, cachelines: 23 | size: 1024, cachelines: 16 |
|-----------------------------+----------------------------+----------------------------|
| original, CONFIG_MEMCG_V1=y | size: 2176, cachelines: 34 | size: 1280, cachelines: 20 |
| patched, CONFIG_MEMCG_V1=y  | size: 1664, cachelines: 26 | size: 1152, cachelines: 18 |
|-----------------------------+----------------------------+----------------------------|

So it's 10-35% reduction in the number of cache lines depending on
the kernel configuration.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/hugetlb.h        |   4 +-
 include/linux/hugetlb_cgroup.h |   8 +-
 include/linux/memcontrol.h     |  19 +--
 include/linux/page_counter.h   | 114 ++++++++++++++----
 mm/hugetlb.c                   |  14 +--
 mm/hugetlb_cgroup.c            | 150 +++++++++---------------
 mm/memcontrol-v1.c             |  88 +++++---------
 mm/memcontrol-v1.h             |   2 +-
 mm/memcontrol.c                | 207 ++++++++++++++++-----------------
 mm/page_counter.c              |  86 ++++++++------
 10 files changed, 345 insertions(+), 347 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c9bf68c239a0..ac27331dcae6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -61,7 +61,7 @@ struct resv_map {
 	 * here. If these fields are 0, then either the mapping is shared, or
 	 * cgroup accounting is disabled for this resv_map.
 	 */
-	struct page_counter *reservation_counter;
+	unsigned long reservation_idx;
 	unsigned long pages_per_hpage;
 	struct cgroup_subsys_state *css;
 #endif
@@ -96,7 +96,7 @@ struct file_region {
 	 * file_region in resv_map. These fields hold the info needed to
 	 * uncharge each reservation.
 	 */
-	struct page_counter *reservation_counter;
+	unsigned long reservation_idx;
 	struct cgroup_subsys_state *css;
 #endif
 };
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index e5d64b8b59c2..1cc89a50be7d 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -36,14 +36,14 @@ struct hugetlb_cgroup {
 	struct cgroup_subsys_state css;
 
 	/*
-	 * the counter to account for hugepages from hugetlb.
+	 * counters to account for hugepages from hugetlb.
 	 */
-	struct page_counter hugepage[HUGE_MAX_HSTATE];
+	struct page_counter usage;
 
 	/*
-	 * the counter to account for hugepage reservations from hugetlb.
+	 * counters to account for hugepage reservations from hugetlb.
 	 */
-	struct page_counter rsvd_hugepage[HUGE_MAX_HSTATE];
+	struct page_counter rsvd;
 
 	atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
 	atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1b79760af685..90eda0b577fa 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -186,12 +186,7 @@ struct mem_cgroup {
 	struct mem_cgroup_id id;
 
 	/* Accounted resources */
-	struct page_counter memory;		/* Both v1 & v2 */
-
-	union {
-		struct page_counter swap;	/* v2 only */
-		struct page_counter memsw;	/* v1 only */
-	};
+	struct page_counter memory;
 
 	/* registered local peak watchers */
 	struct list_head memory_peaks;
@@ -271,10 +266,6 @@ struct mem_cgroup {
 #endif
 
 #ifdef CONFIG_MEMCG_V1
-	/* Legacy consumer-oriented counters */
-	struct page_counter kmem;		/* v1 only */
-	struct page_counter tcpmem;		/* v1 only */
-
 	unsigned long soft_limit;
 
 	/* protected by memcg_oom_lock */
@@ -638,7 +629,7 @@ static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
 		return false;
 
 	return READ_ONCE(memcg->memory.elow) >=
-		page_counter_read(&memcg->memory);
+		page_counter_read(&memcg->memory, MCT_MEM);
 }
 
 static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
@@ -648,7 +639,7 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 		return false;
 
 	return READ_ONCE(memcg->memory.emin) >=
-		page_counter_read(&memcg->memory);
+		page_counter_read(&memcg->memory, MCT_MEM);
 }
 
 void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
@@ -824,8 +815,8 @@ static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 		css_put(&memcg->css);
 }
 
-#define mem_cgroup_from_counter(counter, member)	\
-	container_of(counter, struct mem_cgroup, member)
+#define mem_cgroup_from_counter(counter)	\
+	container_of(counter, struct mem_cgroup, memory)
 
 struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
 				   struct mem_cgroup *,
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index d85fc7df3280..701e1255c456 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -5,14 +5,71 @@
 #include <linux/atomic.h>
 #include <linux/cache.h>
 #include <linux/limits.h>
+#include <linux/mm_types.h>
 #include <asm/page.h>
 
+/*
+ * Page counters are used by memory and hugetlb cgroups.
+ * Memory cgroups are using up to 4 separate counters:
+ * memory, swap (memory + swap on cgroup v1), kmem and tcpmem.
+ * Hugetlb cgroups are using 2 arrays of counters with HUGE_MAX_HSTATE
+ * in each to track the usage and reservations of each supported
+ * hugepage size.
+ *
+ * Protection (min/low) is supported only for the first counter
+ * with idx 0 and only if the counter was initialized with the protection
+ * support.
+ */
+
+enum mem_counter_type {
+#ifdef CONFIG_MEMCG
+	/* Unified memory counter */
+	MCT_MEM,
+
+	/* Swap */
+	MCT_SWAP,
+
+	/* Memory + swap */
+	MCT_MEMSW = MCT_SWAP,
+
+#ifdef CONFIG_MEMCG_V1
+	/* Kernel memory */
+	MCT_KMEM,
+
+	/* Tcp memory */
+	MCT_TCPMEM,
+#endif /* CONFIG_MEMCG_V1 */
+#endif /* CONFIG_MEMCG */
+
+	/* Maximum number of memcg counters */
+	MCT_NR_MEMCG_ITEMS,
+};
+
+#ifdef CONFIG_CGROUP_HUGETLB
+#ifdef HUGE_MAX_HSTATE
+#define MCT_NR_HUGETLB_ITEMS HUGE_MAX_HSTATE
+#else
+#define MCT_NR_HUGETLB_ITEMS 1
+#endif
+
+/*
+ * max() can't be used here: even though __builtin_choose_expr() evaluates
+ * to true, the false clause generates a compiler error:
+ * error: braced-group within expression allowed only inside a function .
+ */
+#define MCT_NR_ITEMS (__builtin_choose_expr(MCT_NR_MEMCG_ITEMS > MCT_NR_HUGETLB_ITEMS, \
+					    MCT_NR_MEMCG_ITEMS, MCT_NR_HUGETLB_ITEMS))
+
+#else /* CONFIG_CGROUP_HUGETLB */
+#define MCT_NR_ITEMS MCT_NR_MEMCG_ITEMS
+#endif /* CONFIG_CGROUP_HUGETLB */
+
 struct page_counter {
 	/*
 	 * Make sure 'usage' does not share cacheline with any other field. The
 	 * memcg->memory.usage is a hot member of struct mem_cgroup.
 	 */
-	atomic_long_t usage;
+	atomic_long_t usage[MCT_NR_ITEMS];
 	CACHELINE_PADDING(_pad1_);
 
 	/* effective memory.min and memory.min usage tracking */
@@ -25,9 +82,9 @@ struct page_counter {
 	atomic_long_t low_usage;
 	atomic_long_t children_low_usage;
 
-	unsigned long watermark;
-	unsigned long local_watermark; /* track min of fd-local resets */
-	unsigned long failcnt;
+	unsigned long watermark[MCT_NR_ITEMS];
+	unsigned long local_watermark[MCT_NR_ITEMS]; /* track min of fd-local resets */
+	unsigned long failcnt[MCT_NR_ITEMS];
 
 	/* Keep all the read most fields in a separete cacheline. */
 	CACHELINE_PADDING(_pad2_);
@@ -35,8 +92,9 @@ struct page_counter {
 	bool protection_support;
 	unsigned long min;
 	unsigned long low;
-	unsigned long high;
-	unsigned long max;
+	unsigned long high[MCT_NR_ITEMS];
+	unsigned long max[MCT_NR_ITEMS];
+
 	struct page_counter *parent;
 } ____cacheline_internodealigned_in_smp;
 
@@ -53,42 +111,56 @@ static inline void page_counter_init(struct page_counter *counter,
 				     struct page_counter *parent,
 				     bool protection_support)
 {
-	atomic_long_set(&counter->usage, 0);
-	counter->max = PAGE_COUNTER_MAX;
+	unsigned long i;
+
+	for (i = 0; i < MCT_NR_ITEMS; i++) {
+		atomic_long_set(&counter->usage[i], 0);
+		counter->max[i] = PAGE_COUNTER_MAX;
+	}
 	counter->parent = parent;
 	counter->protection_support = protection_support;
 }
 
-static inline unsigned long page_counter_read(struct page_counter *counter)
+static inline unsigned long page_counter_read(struct page_counter *counter,
+					      unsigned long idx)
 {
-	return atomic_long_read(&counter->usage);
+	return atomic_long_read(&counter->usage[idx]);
 }
 
-void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages);
-void page_counter_charge(struct page_counter *counter, unsigned long nr_pages);
+void page_counter_cancel(struct page_counter *counter, unsigned long idx,
+			 unsigned long nr_pages);
+void page_counter_charge(struct page_counter *counter, unsigned long idx,
+			 unsigned long nr_pages);
 bool page_counter_try_charge(struct page_counter *counter,
+			     unsigned long idx,
 			     unsigned long nr_pages,
 			     struct page_counter **fail);
-void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages);
-void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages);
-void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages);
+void page_counter_uncharge(struct page_counter *counter, unsigned long idx,
+			   unsigned long nr_pages);
+void page_counter_set_min(struct page_counter *counter, unsigned long idx,
+			  unsigned long nr_pages);
+void page_counter_set_low(struct page_counter *counter, unsigned long idx,
+			  unsigned long nr_pages);
 
 static inline void page_counter_set_high(struct page_counter *counter,
+					 unsigned long idx,
 					 unsigned long nr_pages)
 {
-	WRITE_ONCE(counter->high, nr_pages);
+	WRITE_ONCE(counter->high[idx], nr_pages);
 }
 
-int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages);
+int page_counter_set_max(struct page_counter *counter, unsigned long idx,
+			 unsigned long nr_pages);
 int page_counter_memparse(const char *buf, const char *max,
 			  unsigned long *nr_pages);
 
-static inline void page_counter_reset_watermark(struct page_counter *counter)
+static inline void page_counter_reset_watermark(struct page_counter *counter,
+						unsigned long idx)
 {
-	unsigned long usage = page_counter_read(counter);
+	unsigned long usage = page_counter_read(counter, idx);
 
-	counter->watermark = usage;
-	counter->local_watermark = usage;
+	counter->watermark[idx] = usage;
+	counter->local_watermark[idx] = usage;
 }
 
 #ifdef CONFIG_MEMCG
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0858a1827207..9ada48757bd8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -455,7 +455,7 @@ static void copy_hugetlb_cgroup_uncharge_info(struct file_region *nrg,
 					      struct file_region *rg)
 {
 #ifdef CONFIG_CGROUP_HUGETLB
-	nrg->reservation_counter = rg->reservation_counter;
+	nrg->reservation_idx = rg->reservation_idx;
 	nrg->css = rg->css;
 	if (rg->css)
 		css_get(rg->css);
@@ -470,8 +470,7 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
 {
 #ifdef CONFIG_CGROUP_HUGETLB
 	if (h_cg) {
-		nrg->reservation_counter =
-			&h_cg->rsvd_hugepage[hstate_index(h)];
+		nrg->reservation_idx = hstate_index(h);
 		nrg->css = &h_cg->css;
 		/*
 		 * The caller will hold exactly one h_cg->css reference for the
@@ -491,7 +490,7 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
 		 */
 		VM_BUG_ON(resv->pages_per_hpage != pages_per_huge_page(h));
 	} else {
-		nrg->reservation_counter = NULL;
+		nrg->reservation_idx = 0;
 		nrg->css = NULL;
 	}
 #endif
@@ -509,7 +508,7 @@ static bool has_same_uncharge_info(struct file_region *rg,
 				   struct file_region *org)
 {
 #ifdef CONFIG_CGROUP_HUGETLB
-	return rg->reservation_counter == org->reservation_counter &&
+	return rg->reservation_idx == org->reservation_idx &&
 	       rg->css == org->css;
 
 #else
@@ -1068,12 +1067,11 @@ resv_map_set_hugetlb_cgroup_uncharge_info(struct resv_map *resv_map,
 {
 #ifdef CONFIG_CGROUP_HUGETLB
 	if (!h_cg || !h) {
-		resv_map->reservation_counter = NULL;
+		resv_map->reservation_idx = 0;
 		resv_map->pages_per_hpage = 0;
 		resv_map->css = NULL;
 	} else {
-		resv_map->reservation_counter =
-			&h_cg->rsvd_hugepage[hstate_index(h)];
+		resv_map->reservation_idx = hstate_index(h);
 		resv_map->pages_per_hpage = pages_per_huge_page(h);
 		resv_map->css = &h_cg->css;
 	}
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index d8d0e665caed..3085c8549056 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -40,24 +40,9 @@ static struct cftype *dfl_files;
 static struct cftype *legacy_files;
 
 static inline struct page_counter *
-__hugetlb_cgroup_counter_from_cgroup(struct hugetlb_cgroup *h_cg, int idx,
-				     bool rsvd)
+__hugetlb_cgroup_counter_from_cgroup(struct hugetlb_cgroup *h_cg, bool rsvd)
 {
-	if (rsvd)
-		return &h_cg->rsvd_hugepage[idx];
-	return &h_cg->hugepage[idx];
-}
-
-static inline struct page_counter *
-hugetlb_cgroup_counter_from_cgroup(struct hugetlb_cgroup *h_cg, int idx)
-{
-	return __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, false);
-}
-
-static inline struct page_counter *
-hugetlb_cgroup_counter_from_cgroup_rsvd(struct hugetlb_cgroup *h_cg, int idx)
-{
-	return __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, true);
+	return rsvd ? &h_cg->rsvd : &h_cg->usage;
 }
 
 static inline
@@ -87,11 +72,10 @@ static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
 {
 	struct hstate *h;
 
-	for_each_hstate(h) {
-		if (page_counter_read(
-		    hugetlb_cgroup_counter_from_cgroup(h_cg, hstate_index(h))))
+	for_each_hstate(h)
+		if (page_counter_read(&h_cg->usage, hstate_index(h)))
 			return true;
-	}
+
 	return false;
 }
 
@@ -100,35 +84,24 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 {
 	int idx;
 
+	if (parent_h_cgroup) {
+		page_counter_init(&h_cgroup->usage, &parent_h_cgroup->usage, false);
+		page_counter_init(&h_cgroup->rsvd, &parent_h_cgroup->rsvd, false);
+	} else {
+		page_counter_init(&h_cgroup->usage, NULL, false);
+		page_counter_init(&h_cgroup->rsvd, NULL, false);
+	}
+
 	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
-		struct page_counter *fault_parent = NULL;
-		struct page_counter *rsvd_parent = NULL;
 		unsigned long limit;
 		int ret;
 
-		if (parent_h_cgroup) {
-			fault_parent = hugetlb_cgroup_counter_from_cgroup(
-				parent_h_cgroup, idx);
-			rsvd_parent = hugetlb_cgroup_counter_from_cgroup_rsvd(
-				parent_h_cgroup, idx);
-		}
-		page_counter_init(hugetlb_cgroup_counter_from_cgroup(h_cgroup,
-								     idx),
-				  fault_parent, false);
-		page_counter_init(
-			hugetlb_cgroup_counter_from_cgroup_rsvd(h_cgroup, idx),
-			rsvd_parent, false);
-
 		limit = round_down(PAGE_COUNTER_MAX,
 				   pages_per_huge_page(&hstates[idx]));
 
-		ret = page_counter_set_max(
-			hugetlb_cgroup_counter_from_cgroup(h_cgroup, idx),
-			limit);
+		ret = page_counter_set_max(&h_cgroup->usage, idx, limit);
 		VM_BUG_ON(ret);
-		ret = page_counter_set_max(
-			hugetlb_cgroup_counter_from_cgroup_rsvd(h_cgroup, idx),
-			limit);
+		ret = page_counter_set_max(&h_cgroup->rsvd, idx, limit);
 		VM_BUG_ON(ret);
 	}
 }
@@ -198,7 +171,6 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 				       struct page *page)
 {
 	unsigned int nr_pages;
-	struct page_counter *counter;
 	struct hugetlb_cgroup *page_hcg;
 	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
 	struct folio *folio = page_folio(page);
@@ -216,11 +188,11 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	if (!parent) {
 		parent = root_h_cgroup;
 		/* root has no limit */
-		page_counter_charge(&parent->hugepage[idx], nr_pages);
+		page_counter_charge(&parent->usage, idx, nr_pages);
 	}
-	counter = &h_cg->hugepage[idx];
+
 	/* Take the pages off the local counter */
-	page_counter_cancel(counter, nr_pages);
+	page_counter_cancel(&h_cg->usage, idx, nr_pages);
 
 	set_hugetlb_cgroup(folio, parent);
 out:
@@ -282,7 +254,7 @@ static int __hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 	rcu_read_unlock();
 
 	if (!page_counter_try_charge(
-		    __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
+		    __hugetlb_cgroup_counter_from_cgroup(h_cg, rsvd), idx,
 		    nr_pages, &counter)) {
 		ret = -ENOMEM;
 		hugetlb_event(h_cg, idx, HUGETLB_MAX);
@@ -363,9 +335,8 @@ static void __hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
 		return;
 	__set_hugetlb_cgroup(folio, NULL, rsvd);
 
-	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, idx,
-								   rsvd),
-			      nr_pages);
+	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, rsvd),
+			      idx, nr_pages);
 
 	if (rsvd)
 		css_put(&h_cg->css);
@@ -401,9 +372,8 @@ static void __hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
 
-	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, idx,
-								   rsvd),
-			      nr_pages);
+	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, rsvd),
+			      idx, nr_pages);
 
 	if (rsvd)
 		css_put(&h_cg->css);
@@ -424,11 +394,13 @@ void hugetlb_cgroup_uncharge_cgroup_rsvd(int idx, unsigned long nr_pages,
 void hugetlb_cgroup_uncharge_counter(struct resv_map *resv, unsigned long start,
 				     unsigned long end)
 {
-	if (hugetlb_cgroup_disabled() || !resv || !resv->reservation_counter ||
-	    !resv->css)
+	struct hugetlb_cgroup *h_cg;
+
+	if (hugetlb_cgroup_disabled() || !resv || !resv->css)
 		return;
 
-	page_counter_uncharge(resv->reservation_counter,
+	h_cg = hugetlb_cgroup_from_css(resv->css);
+	page_counter_uncharge(&h_cg->rsvd, resv->reservation_idx,
 			      (end - start) * resv->pages_per_hpage);
 	css_put(resv->css);
 }
@@ -441,9 +413,9 @@ void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 	if (hugetlb_cgroup_disabled() || !resv || !rg || !nr_pages)
 		return;
 
-	if (rg->reservation_counter && resv->pages_per_hpage &&
-	    !resv->reservation_counter) {
-		page_counter_uncharge(rg->reservation_counter,
+	if (rg->css && resv->pages_per_hpage && !resv->css) {
+		page_counter_uncharge(&hugetlb_cgroup_from_css(rg->css)->rsvd,
+				      rg->reservation_idx,
 				      nr_pages * resv->pages_per_hpage);
 		/*
 		 * Only do css_put(rg->css) when we delete the entire region
@@ -495,7 +467,7 @@ static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy)
 	 * counter, so use that.
 	 */
 	seq_printf(seq, "%stotal=%lu", legacy ? "hierarchical_" : "",
-		   page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZE);
+		   page_counter_read(&h_cg->usage, idx) * PAGE_SIZE);
 
 	/*
 	 * For each node, transverse the css tree to obtain the hierarchical
@@ -521,30 +493,26 @@ static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy)
 static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
 				   struct cftype *cft)
 {
-	struct page_counter *counter;
-	struct page_counter *rsvd_counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(css);
-
-	counter = &h_cg->hugepage[MEMFILE_IDX(cft->private)];
-	rsvd_counter = &h_cg->rsvd_hugepage[MEMFILE_IDX(cft->private)];
+	unsigned long idx = MEMFILE_IDX(cft->private);
 
 	switch (MEMFILE_ATTR(cft->private)) {
 	case RES_USAGE:
-		return (u64)page_counter_read(counter) * PAGE_SIZE;
+		return (u64)page_counter_read(&h_cg->usage, idx) * PAGE_SIZE;
 	case RES_RSVD_USAGE:
-		return (u64)page_counter_read(rsvd_counter) * PAGE_SIZE;
+		return (u64)page_counter_read(&h_cg->rsvd, idx) * PAGE_SIZE;
 	case RES_LIMIT:
-		return (u64)counter->max * PAGE_SIZE;
+		return (u64)h_cg->usage.max[idx] * PAGE_SIZE;
 	case RES_RSVD_LIMIT:
-		return (u64)rsvd_counter->max * PAGE_SIZE;
+		return (u64)h_cg->rsvd.max[idx] * PAGE_SIZE;
 	case RES_MAX_USAGE:
-		return (u64)counter->watermark * PAGE_SIZE;
+		return (u64)h_cg->usage.watermark[idx] * PAGE_SIZE;
 	case RES_RSVD_MAX_USAGE:
-		return (u64)rsvd_counter->watermark * PAGE_SIZE;
+		return (u64)h_cg->rsvd.watermark[idx] * PAGE_SIZE;
 	case RES_FAILCNT:
-		return counter->failcnt;
+		return h_cg->usage.failcnt[idx];
 	case RES_RSVD_FAILCNT:
-		return rsvd_counter->failcnt;
+		return h_cg->rsvd.failcnt[idx];
 	default:
 		BUG();
 	}
@@ -552,42 +520,39 @@ static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
 
 static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
 {
-	int idx;
 	u64 val;
 	struct cftype *cft = seq_cft(seq);
 	unsigned long limit;
-	struct page_counter *counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(seq_css(seq));
-
-	idx = MEMFILE_IDX(cft->private);
-	counter = &h_cg->hugepage[idx];
+	struct page_counter *counter = &h_cg->usage;
+	unsigned long idx = MEMFILE_IDX(cft->private);
 
 	limit = round_down(PAGE_COUNTER_MAX,
 			   pages_per_huge_page(&hstates[idx]));
 
 	switch (MEMFILE_ATTR(cft->private)) {
 	case RES_RSVD_USAGE:
-		counter = &h_cg->rsvd_hugepage[idx];
+		counter = &h_cg->rsvd;
 		fallthrough;
 	case RES_USAGE:
-		val = (u64)page_counter_read(counter);
+		val = (u64)page_counter_read(counter, idx);
 		seq_printf(seq, "%llu\n", val * PAGE_SIZE);
 		break;
 	case RES_RSVD_LIMIT:
-		counter = &h_cg->rsvd_hugepage[idx];
+		counter = &h_cg->rsvd;
 		fallthrough;
 	case RES_LIMIT:
-		val = (u64)counter->max;
+		val = (u64)counter->max[idx];
 		if (val == limit)
 			seq_puts(seq, "max\n");
 		else
 			seq_printf(seq, "%llu\n", val * PAGE_SIZE);
 		break;
 	case RES_RSVD_MAX_USAGE:
-		counter = &h_cg->rsvd_hugepage[idx];
+		counter = &h_cg->rsvd;
 		fallthrough;
 	case RES_MAX_USAGE:
-		val = (u64)counter->watermark;
+		val = (u64)counter->watermark[idx];
 		seq_printf(seq, "%llu\n", val * PAGE_SIZE);
 		break;
 	default:
@@ -626,8 +591,8 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	case RES_LIMIT:
 		mutex_lock(&hugetlb_limit_mutex);
 		ret = page_counter_set_max(
-			__hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
-			nr_pages);
+			__hugetlb_cgroup_counter_from_cgroup(h_cg, rsvd),
+			idx, nr_pages);
 		mutex_unlock(&hugetlb_limit_mutex);
 		break;
 	default:
@@ -653,24 +618,21 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
 	int ret = 0;
-	struct page_counter *counter, *rsvd_counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
-
-	counter = &h_cg->hugepage[MEMFILE_IDX(of_cft(of)->private)];
-	rsvd_counter = &h_cg->rsvd_hugepage[MEMFILE_IDX(of_cft(of)->private)];
+	unsigned long idx = MEMFILE_IDX(of_cft(of)->private);
 
 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
 	case RES_MAX_USAGE:
-		page_counter_reset_watermark(counter);
+		page_counter_reset_watermark(&h_cg->usage, idx);
 		break;
 	case RES_RSVD_MAX_USAGE:
-		page_counter_reset_watermark(rsvd_counter);
+		page_counter_reset_watermark(&h_cg->rsvd, idx);
 		break;
 	case RES_FAILCNT:
-		counter->failcnt = 0;
+		h_cg->usage.failcnt[idx] = 0;
 		break;
 	case RES_RSVD_FAILCNT:
-		rsvd_counter->failcnt = 0;
+		h_cg->rsvd.failcnt[idx] = 0;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 2aeea4d8bf8e..d8bf89c76cc5 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -191,7 +191,7 @@ static void mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
 
 static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
 {
-	unsigned long nr_pages = page_counter_read(&memcg->memory);
+	unsigned long nr_pages = page_counter_read(&memcg->memory, MCT_MEM);
 	unsigned long soft_limit = READ_ONCE(memcg->soft_limit);
 	unsigned long excess = 0;
 
@@ -1090,7 +1090,7 @@ static void __mem_cgroup_clear_mc(void)
 	if (mc.moved_swap) {
 		/* uncharge swap account from the old cgroup */
 		if (!mem_cgroup_is_root(mc.from))
-			page_counter_uncharge(&mc.from->memsw, mc.moved_swap);
+			page_counter_uncharge(&mc.from->memory, MCT_MEMSW, mc.moved_swap);
 
 		mem_cgroup_id_put_many(mc.from, mc.moved_swap);
 
@@ -1099,7 +1099,7 @@ static void __mem_cgroup_clear_mc(void)
 		 * should uncharge to->memory.
 		 */
 		if (!mem_cgroup_is_root(mc.to))
-			page_counter_uncharge(&mc.to->memory, mc.moved_swap);
+			page_counter_uncharge(&mc.to->memory, MCT_MEM, mc.moved_swap);
 
 		mc.moved_swap = 0;
 	}
@@ -2215,7 +2215,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 	bool drained = false;
 	int ret;
 	bool limits_invariant;
-	struct page_counter *counter = memsw ? &memcg->memsw : &memcg->memory;
+	unsigned long idx = memsw ? MCT_MEMSW : MCT_MEM;
 
 	do {
 		if (signal_pending(current)) {
@@ -2228,16 +2228,16 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		 * Make sure that the new limit (memsw or memory limit) doesn't
 		 * break our basic invariant rule memory.max <= memsw.max.
 		 */
-		limits_invariant = memsw ? max >= READ_ONCE(memcg->memory.max) :
-					   max <= memcg->memsw.max;
+		limits_invariant = memsw ? max >= READ_ONCE(memcg->memory.max[MCT_MEM]) :
+					   max <= memcg->memory.max[MCT_MEMSW];
 		if (!limits_invariant) {
 			mutex_unlock(&memcg_max_mutex);
 			ret = -EINVAL;
 			break;
 		}
-		if (max > counter->max)
+		if (max > memcg->memory.max[idx])
 			enlarge = true;
-		ret = page_counter_set_max(counter, max);
+		ret = page_counter_set_max(&memcg->memory, idx, max);
 		mutex_unlock(&memcg_max_mutex);
 
 		if (!ret)
@@ -2277,7 +2277,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 	drain_all_stock(memcg);
 
 	/* try to free all pages in this cgroup */
-	while (nr_retries && page_counter_read(&memcg->memory)) {
+	while (nr_retries && page_counter_read(&memcg->memory, MCT_MEM)) {
 		if (signal_pending(current))
 			return -EINTR;
 
@@ -2323,38 +2323,22 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
-	struct page_counter *counter;
-
-	switch (MEMFILE_TYPE(cft->private)) {
-	case _MEM:
-		counter = &memcg->memory;
-		break;
-	case _MEMSWAP:
-		counter = &memcg->memsw;
-		break;
-	case _KMEM:
-		counter = &memcg->kmem;
-		break;
-	case _TCP:
-		counter = &memcg->tcpmem;
-		break;
-	default:
-		BUG();
-	}
+	struct page_counter *counter = &memcg->memory;
+	unsigned long idx = MEMFILE_TYPE(cft->private);
 
 	switch (MEMFILE_ATTR(cft->private)) {
 	case RES_USAGE:
-		if (counter == &memcg->memory)
+		if (idx == MCT_MEM)
 			return (u64)mem_cgroup_usage(memcg, false) * PAGE_SIZE;
-		if (counter == &memcg->memsw)
+		if (idx == MCT_MEMSW)
 			return (u64)mem_cgroup_usage(memcg, true) * PAGE_SIZE;
-		return (u64)page_counter_read(counter) * PAGE_SIZE;
+		return (u64)page_counter_read(counter, idx) * PAGE_SIZE;
 	case RES_LIMIT:
-		return (u64)counter->max * PAGE_SIZE;
+		return (u64)counter->max[idx] * PAGE_SIZE;
 	case RES_MAX_USAGE:
-		return (u64)counter->watermark * PAGE_SIZE;
+		return (u64)counter->watermark[idx] * PAGE_SIZE;
 	case RES_FAILCNT:
-		return counter->failcnt;
+		return counter->failcnt[idx];
 	case RES_SOFT_LIMIT:
 		return (u64)READ_ONCE(memcg->soft_limit) * PAGE_SIZE;
 	default:
@@ -2378,7 +2362,7 @@ static int memcg_update_tcp_max(struct mem_cgroup *memcg, unsigned long max)
 
 	mutex_lock(&memcg_max_mutex);
 
-	ret = page_counter_set_max(&memcg->tcpmem, max);
+	ret = page_counter_set_max(&memcg->memory, MCT_TCPMEM, max);
 	if (ret)
 		goto out;
 
@@ -2464,31 +2448,15 @@ static ssize_t mem_cgroup_reset(struct kernfs_open_file *of, char *buf,
 				size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-	struct page_counter *counter;
-
-	switch (MEMFILE_TYPE(of_cft(of)->private)) {
-	case _MEM:
-		counter = &memcg->memory;
-		break;
-	case _MEMSWAP:
-		counter = &memcg->memsw;
-		break;
-	case _KMEM:
-		counter = &memcg->kmem;
-		break;
-	case _TCP:
-		counter = &memcg->tcpmem;
-		break;
-	default:
-		BUG();
-	}
+	struct page_counter *counter = &memcg->memory;
+	unsigned long idx = MEMFILE_TYPE(of_cft(of)->private);
 
 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
 	case RES_MAX_USAGE:
-		page_counter_reset_watermark(counter);
+		page_counter_reset_watermark(counter, idx);
 		break;
 	case RES_FAILCNT:
-		counter->failcnt = 0;
+		counter->failcnt[idx] = 0;
 		break;
 	default:
 		BUG();
@@ -2660,8 +2628,8 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	/* Hierarchical information */
 	memory = memsw = PAGE_COUNTER_MAX;
 	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
-		memory = min(memory, READ_ONCE(mi->memory.max));
-		memsw = min(memsw, READ_ONCE(mi->memsw.max));
+		memory = min(memory, READ_ONCE(mi->memory.max[MCT_MEM]));
+		memsw = min(memsw, READ_ONCE(mi->memory.max[MCT_MEMSW]));
 	}
 	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
 		       (u64)memory * PAGE_SIZE);
@@ -2926,9 +2894,9 @@ void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 {
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
 		if (nr_pages > 0)
-			page_counter_charge(&memcg->kmem, nr_pages);
+			page_counter_charge(&memcg->memory, MCT_KMEM, nr_pages);
 		else
-			page_counter_uncharge(&memcg->kmem, -nr_pages);
+			page_counter_uncharge(&memcg->memory, MCT_KMEM, -nr_pages);
 	}
 }
 
@@ -2937,13 +2905,13 @@ bool memcg1_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 {
 	struct page_counter *fail;
 
-	if (page_counter_try_charge(&memcg->tcpmem, nr_pages, &fail)) {
+	if (page_counter_try_charge(&memcg->memory, MCT_TCPMEM, nr_pages, &fail)) {
 		memcg->tcpmem_pressure = 0;
 		return true;
 	}
 	memcg->tcpmem_pressure = 1;
 	if (gfp_mask & __GFP_NOFAIL) {
-		page_counter_charge(&memcg->tcpmem, nr_pages);
+		page_counter_charge(&memcg->memory, MCT_TCPMEM, nr_pages);
 		return true;
 	}
 	return false;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 56d7eaa98274..9a4d8205aed5 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -112,7 +112,7 @@ bool memcg1_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 			 gfp_t gfp_mask);
 static inline void memcg1_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	page_counter_uncharge(&memcg->tcpmem, nr_pages);
+	page_counter_uncharge(&memcg->memory, MCT_TCPMEM, nr_pages);
 }
 
 extern struct cftype memsw_files[];
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 45c0f816a974..63b8c7d5e031 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1313,14 +1313,14 @@ static unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
 	unsigned long count;
 	unsigned long limit;
 
-	count = page_counter_read(&memcg->memory);
-	limit = READ_ONCE(memcg->memory.max);
+	count = page_counter_read(&memcg->memory, MCT_MEM);
+	limit = READ_ONCE(memcg->memory.max[MCT_MEM]);
 	if (count < limit)
 		margin = limit - count;
 
 	if (do_memsw_account()) {
-		count = page_counter_read(&memcg->memsw);
-		limit = READ_ONCE(memcg->memsw.max);
+		count = page_counter_read(&memcg->memory, MCT_MEMSW);
+		limit = READ_ONCE(memcg->memory.max[MCT_MEMSW]);
 		if (count < limit)
 			margin = min(margin, limit - count);
 		else
@@ -1527,20 +1527,25 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 	lockdep_assert_held(&oom_lock);
 
 	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
-		K((u64)page_counter_read(&memcg->memory)),
-		K((u64)READ_ONCE(memcg->memory.max)), memcg->memory.failcnt);
+		K((u64)page_counter_read(&memcg->memory, MCT_MEM)),
+		K((u64)READ_ONCE(memcg->memory.max[MCT_MEM])),
+		memcg->memory.failcnt[MCT_MEM]);
+
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		pr_info("swap: usage %llukB, limit %llukB, failcnt %lu\n",
-			K((u64)page_counter_read(&memcg->swap)),
-			K((u64)READ_ONCE(memcg->swap.max)), memcg->swap.failcnt);
+			K((u64)page_counter_read(&memcg->memory, MCT_SWAP)),
+			K((u64)READ_ONCE(memcg->memory.max[MCT_SWAP])),
+			memcg->memory.failcnt[MCT_SWAP]);
 #ifdef CONFIG_MEMCG_V1
 	else {
 		pr_info("memory+swap: usage %llukB, limit %llukB, failcnt %lu\n",
-			K((u64)page_counter_read(&memcg->memsw)),
-			K((u64)memcg->memsw.max), memcg->memsw.failcnt);
+			K((u64)page_counter_read(&memcg->memory, MCT_MEMSW)),
+			K((u64)memcg->memory.max[MCT_MEMSW]),
+			memcg->memory.failcnt[MCT_MEMSW]);
 		pr_info("kmem: usage %llukB, limit %llukB, failcnt %lu\n",
-			K((u64)page_counter_read(&memcg->kmem)),
-			K((u64)memcg->kmem.max), memcg->kmem.failcnt);
+			K((u64)page_counter_read(&memcg->memory, MCT_KMEM)),
+			K((u64)memcg->memory.max[MCT_KMEM]),
+			memcg->memory.failcnt[MCT_KMEM]);
 	}
 #endif
 
@@ -1557,18 +1562,18 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
  */
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 {
-	unsigned long max = READ_ONCE(memcg->memory.max);
+	unsigned long max = READ_ONCE(memcg->memory.max[MCT_MEM]);
 
 	if (do_memsw_account()) {
 		if (mem_cgroup_swappiness(memcg)) {
 			/* Calculate swap excess capacity from memsw limit */
-			unsigned long swap = READ_ONCE(memcg->memsw.max) - max;
+			unsigned long swap = READ_ONCE(memcg->memory.max[MCT_MEMSW]) - max;
 
 			max += min(swap, (unsigned long)total_swap_pages);
 		}
 	} else {
 		if (mem_cgroup_swappiness(memcg))
-			max += min(READ_ONCE(memcg->swap.max),
+			max += min(READ_ONCE(memcg->memory.max[MCT_SWAP]),
 				   (unsigned long)total_swap_pages);
 	}
 	return max;
@@ -1576,7 +1581,7 @@ unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 
 unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
 {
-	return page_counter_read(&memcg->memory);
+	return page_counter_read(&memcg->memory, MCT_MEM);
 }
 
 static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
@@ -1766,9 +1771,9 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		return;
 
 	if (stock_pages) {
-		page_counter_uncharge(&old->memory, stock_pages);
+		page_counter_uncharge(&old->memory, MCT_MEM, stock_pages);
 		if (do_memsw_account())
-			page_counter_uncharge(&old->memsw, stock_pages);
+			page_counter_uncharge(&old->memory, MCT_MEMSW, stock_pages);
 
 		WRITE_ONCE(stock->nr_pages, 0);
 	}
@@ -1894,8 +1899,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 	do {
 		unsigned long pflags;
 
-		if (page_counter_read(&memcg->memory) <=
-		    READ_ONCE(memcg->memory.high))
+		if (page_counter_read(&memcg->memory, MCT_MEM) <=
+		    READ_ONCE(memcg->memory.high[MCT_MEM]))
 			continue;
 
 		memcg_memory_event(memcg, MEMCG_HIGH);
@@ -1996,8 +2001,8 @@ static u64 mem_find_max_overage(struct mem_cgroup *memcg)
 	u64 overage, max_overage = 0;
 
 	do {
-		overage = calculate_overage(page_counter_read(&memcg->memory),
-					    READ_ONCE(memcg->memory.high));
+		overage = calculate_overage(page_counter_read(&memcg->memory, MCT_MEM),
+					    READ_ONCE(memcg->memory.high[MCT_MEM]));
 		max_overage = max(overage, max_overage);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2010,8 +2015,8 @@ static u64 swap_find_max_overage(struct mem_cgroup *memcg)
 	u64 overage, max_overage = 0;
 
 	do {
-		overage = calculate_overage(page_counter_read(&memcg->swap),
-					    READ_ONCE(memcg->swap.high));
+		overage = calculate_overage(page_counter_read(&memcg->memory, MCT_SWAP),
+					    READ_ONCE(memcg->memory.high[MCT_SWAP]));
 		if (overage)
 			memcg_memory_event(memcg, MEMCG_SWAP_HIGH);
 		max_overage = max(overage, max_overage);
@@ -2174,17 +2179,17 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		return 0;
 
 	if (!do_memsw_account() ||
-	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
-		if (page_counter_try_charge(&memcg->memory, batch, &counter))
+	    page_counter_try_charge(&memcg->memory, MCT_MEMSW, batch, &counter)) {
+		if (page_counter_try_charge(&memcg->memory, MCT_MEM, batch, &counter))
 			goto done_restock;
 		if (do_memsw_account())
-			page_counter_uncharge(&memcg->memsw, batch);
-		mem_over_limit = mem_cgroup_from_counter(counter, memory);
+			page_counter_uncharge(&memcg->memory, MCT_MEMSW, batch);
 	} else {
-		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
 		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
 	}
 
+	mem_over_limit = mem_cgroup_from_counter(counter);
+
 	if (batch > nr_pages) {
 		batch = nr_pages;
 		goto retry;
@@ -2285,9 +2290,9 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * being freed very soon.  Allow memory usage go over the limit
 	 * temporarily by force charging it.
 	 */
-	page_counter_charge(&memcg->memory, nr_pages);
+	page_counter_charge(&memcg->memory, MCT_MEM, nr_pages);
 	if (do_memsw_account())
-		page_counter_charge(&memcg->memsw, nr_pages);
+		page_counter_charge(&memcg->memory, MCT_MEMSW, nr_pages);
 
 	return 0;
 
@@ -2307,10 +2312,10 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	do {
 		bool mem_high, swap_high;
 
-		mem_high = page_counter_read(&memcg->memory) >
-			READ_ONCE(memcg->memory.high);
-		swap_high = page_counter_read(&memcg->swap) >
-			READ_ONCE(memcg->swap.high);
+		mem_high = page_counter_read(&memcg->memory, MCT_MEM) >
+			READ_ONCE(memcg->memory.high[MCT_MEM]);
+		swap_high = page_counter_read(&memcg->memory, MCT_SWAP) >
+			READ_ONCE(memcg->memory.high[MCT_SWAP]);
 
 		/* Don't bother a random interrupted task */
 		if (!in_task()) {
@@ -2361,9 +2366,9 @@ void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (mem_cgroup_is_root(memcg))
 		return;
 
-	page_counter_uncharge(&memcg->memory, nr_pages);
+	page_counter_uncharge(&memcg->memory, MCT_MEM, nr_pages);
 	if (do_memsw_account())
-		page_counter_uncharge(&memcg->memsw, nr_pages);
+		page_counter_uncharge(&memcg->memory, MCT_MEMSW, nr_pages);
 }
 
 static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
@@ -3061,9 +3066,9 @@ unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 			val += total_swap_pages - get_nr_swap_pages();
 	} else {
 		if (!swap)
-			val = page_counter_read(&memcg->memory);
+			val = page_counter_read(&memcg->memory, MCT_MEM);
 		else
-			val = page_counter_read(&memcg->memsw);
+			val = page_counter_read(&memcg->memory, MCT_MEMSW);
 	}
 	return val;
 }
@@ -3182,9 +3187,9 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 
 	*pheadroom = PAGE_COUNTER_MAX;
 	while ((parent = parent_mem_cgroup(memcg))) {
-		unsigned long ceiling = min(READ_ONCE(memcg->memory.max),
-					    READ_ONCE(memcg->memory.high));
-		unsigned long used = page_counter_read(&memcg->memory);
+		unsigned long ceiling = min(READ_ONCE(memcg->memory.max[MCT_MEM]),
+					    READ_ONCE(memcg->memory.high[MCT_MEM]));
+		unsigned long used = page_counter_read(&memcg->memory, MCT_MEM);
 
 		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
 		memcg = parent;
@@ -3568,33 +3573,25 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (IS_ERR(memcg))
 		return ERR_CAST(memcg);
 
-	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
+	page_counter_set_high(&memcg->memory, MCT_MEM, PAGE_COUNTER_MAX);
 	memcg1_soft_limit_reset(memcg);
 #ifdef CONFIG_ZSWAP
 	memcg->zswap_max = PAGE_COUNTER_MAX;
 	WRITE_ONCE(memcg->zswap_writeback,
 		!parent || READ_ONCE(parent->zswap_writeback));
 #endif
-	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
+	page_counter_set_high(&memcg->memory, MCT_SWAP, PAGE_COUNTER_MAX);
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
 
 		page_counter_init(&memcg->memory, &parent->memory, true);
-		page_counter_init(&memcg->swap, &parent->swap, false);
 #ifdef CONFIG_MEMCG_V1
 		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
-		page_counter_init(&memcg->kmem, &parent->kmem, false);
-		page_counter_init(&memcg->tcpmem, &parent->tcpmem, false);
 #endif
 	} else {
 		init_memcg_stats();
 		init_memcg_events();
 		page_counter_init(&memcg->memory, NULL, true);
-		page_counter_init(&memcg->swap, NULL, false);
-#ifdef CONFIG_MEMCG_V1
-		page_counter_init(&memcg->kmem, NULL, false);
-		page_counter_init(&memcg->tcpmem, NULL, false);
-#endif
 		root_mem_cgroup = memcg;
 		return &memcg->css;
 	}
@@ -3658,8 +3655,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 
 	memcg1_css_offline(memcg);
 
-	page_counter_set_min(&memcg->memory, 0);
-	page_counter_set_low(&memcg->memory, 0);
+	page_counter_set_min(&memcg->memory, MCT_MEM, 0);
+	page_counter_set_low(&memcg->memory, MCT_MEM, 0);
 
 	zswap_memcg_offline_cleanup(memcg);
 
@@ -3723,17 +3720,17 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
-	page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
+	page_counter_set_max(&memcg->memory, MCT_MEM, PAGE_COUNTER_MAX);
+	page_counter_set_max(&memcg->memory, MCT_SWAP, PAGE_COUNTER_MAX);
 #ifdef CONFIG_MEMCG_V1
-	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
-	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
+	page_counter_set_max(&memcg->memory, MCT_KMEM, PAGE_COUNTER_MAX);
+	page_counter_set_max(&memcg->memory, MCT_TCPMEM, PAGE_COUNTER_MAX);
 #endif
-	page_counter_set_min(&memcg->memory, 0);
-	page_counter_set_low(&memcg->memory, 0);
-	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
+	page_counter_set_min(&memcg->memory, MCT_MEM, 0);
+	page_counter_set_low(&memcg->memory, MCT_MEM, 0);
+	page_counter_set_high(&memcg->memory, MCT_MEM, PAGE_COUNTER_MAX);
 	memcg1_soft_limit_reset(memcg);
-	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
+	page_counter_set_high(&memcg->memory, MCT_SWAP, PAGE_COUNTER_MAX);
 	memcg_wb_domain_size_changed(memcg);
 }
 
@@ -3922,19 +3919,20 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
+	return (u64)page_counter_read(&memcg->memory, MCT_MEM) * PAGE_SIZE;
 }
 
-static int peak_show(struct seq_file *sf, void *v, struct page_counter *pc)
+static int peak_show(struct seq_file *sf, unsigned long idx)
 {
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(sf));
 	struct cgroup_of_peak *ofp = of_peak(sf->private);
 	s64 fd_peak = ofp->value, peak;
 
 	/* User wants global or local peak? */
 	if (fd_peak == -1)
-		peak = pc->watermark;
+		peak = memcg->memory.watermark[idx];
 	else
-		peak = max(fd_peak, (s64)pc->local_watermark);
+		peak = max(fd_peak, (s64)memcg->memory.local_watermark[idx]);
 
 	seq_printf(sf, "%lld\n", peak * PAGE_SIZE);
 	return 0;
@@ -3942,9 +3940,7 @@ static int peak_show(struct seq_file *sf, void *v, struct page_counter *pc)
 
 static int memory_peak_show(struct seq_file *sf, void *v)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(sf));
-
-	return peak_show(sf, v, &memcg->memory);
+	return peak_show(sf, MCT_MEM);
 }
 
 static int peak_open(struct kernfs_open_file *of)
@@ -3970,7 +3966,7 @@ static void peak_release(struct kernfs_open_file *of)
 }
 
 static ssize_t peak_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
-			  loff_t off, struct page_counter *pc,
+			  loff_t off, unsigned long idx,
 			  struct list_head *watchers)
 {
 	unsigned long usage;
@@ -3985,8 +3981,9 @@ static ssize_t peak_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
 
 	spin_lock(&memcg->peaks_lock);
 
-	pc->local_watermark = page_counter_read(pc);
-	usage = pc->local_watermark;
+	memcg->memory.local_watermark[idx] = page_counter_read(&memcg->memory,
+							       idx);
+	usage = memcg->memory.local_watermark[idx];
 
 	list_for_each_entry(peer_ctx, watchers, list)
 		if (usage > peer_ctx->value)
@@ -4007,8 +4004,7 @@ static ssize_t memory_peak_write(struct kernfs_open_file *of, char *buf,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 
-	return peak_write(of, buf, nbytes, off, &memcg->memory,
-			  &memcg->memory_peaks);
+	return peak_write(of, buf, nbytes, off, MCT_MEM, &memcg->memory_peaks);
 }
 
 static int memory_min_show(struct seq_file *m, void *v)
@@ -4029,7 +4025,7 @@ static ssize_t memory_min_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	page_counter_set_min(&memcg->memory, min);
+	page_counter_set_min(&memcg->memory, MCT_MEM, min);
 
 	return nbytes;
 }
@@ -4052,7 +4048,7 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	page_counter_set_low(&memcg->memory, low);
+	page_counter_set_low(&memcg->memory, MCT_MEM, low);
 
 	return nbytes;
 }
@@ -4060,7 +4056,7 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 static int memory_high_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
-		READ_ONCE(mem_cgroup_from_seq(m)->memory.high));
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.high[MCT_MEM]));
 }
 
 static ssize_t memory_high_write(struct kernfs_open_file *of,
@@ -4077,10 +4073,10 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	page_counter_set_high(&memcg->memory, high);
+	page_counter_set_high(&memcg->memory, MCT_MEM, high);
 
 	for (;;) {
-		unsigned long nr_pages = page_counter_read(&memcg->memory);
+		unsigned long nr_pages = page_counter_read(&memcg->memory, MCT_MEM);
 		unsigned long reclaimed;
 
 		if (nr_pages <= high)
@@ -4109,7 +4105,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 static int memory_max_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
-		READ_ONCE(mem_cgroup_from_seq(m)->memory.max));
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.max[MCT_MEM]));
 }
 
 static ssize_t memory_max_write(struct kernfs_open_file *of,
@@ -4126,10 +4122,10 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	xchg(&memcg->memory.max, max);
+	xchg(&memcg->memory.max[MCT_MEM], max);
 
 	for (;;) {
-		unsigned long nr_pages = page_counter_read(&memcg->memory);
+		unsigned long nr_pages = page_counter_read(&memcg->memory, MCT_MEM);
 
 		if (nr_pages <= max)
 			break;
@@ -4616,9 +4612,9 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	unsigned long flags;
 
 	if (ug->nr_memory) {
-		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
+		page_counter_uncharge(&ug->memcg->memory, MCT_MEM, ug->nr_memory);
 		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
+			page_counter_uncharge(&ug->memcg->memory, MCT_MEMSW, ug->nr_memory);
 		if (ug->nr_kmem) {
 			mod_memcg_state(ug->memcg, MEMCG_KMEM, -ug->nr_kmem);
 			memcg1_account_kmem(ug->memcg, -ug->nr_kmem);
@@ -4758,9 +4754,9 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 
 	/* Force-charge the new page. The old one will be freed soon */
 	if (!mem_cgroup_is_root(memcg)) {
-		page_counter_charge(&memcg->memory, nr_pages);
+		page_counter_charge(&memcg->memory, MCT_MEM, nr_pages);
 		if (do_memsw_account())
-			page_counter_charge(&memcg->memsw, nr_pages);
+			page_counter_charge(&memcg->memory, MCT_MEMSW, nr_pages);
 	}
 
 	css_get(&memcg->css);
@@ -4997,12 +4993,12 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	folio->memcg_data = 0;
 
 	if (!mem_cgroup_is_root(memcg))
-		page_counter_uncharge(&memcg->memory, nr_entries);
+		page_counter_uncharge(&memcg->memory, MCT_MEM, nr_entries);
 
 	if (memcg != swap_memcg) {
 		if (!mem_cgroup_is_root(swap_memcg))
-			page_counter_charge(&swap_memcg->memsw, nr_entries);
-		page_counter_uncharge(&memcg->memsw, nr_entries);
+			page_counter_charge(&swap_memcg->memory, MCT_MEMSW, nr_entries);
+		page_counter_uncharge(&memcg->memory, MCT_MEMSW, nr_entries);
 	}
 
 	/*
@@ -5052,7 +5048,7 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 	memcg = mem_cgroup_id_get_online(memcg);
 
 	if (!mem_cgroup_is_root(memcg) &&
-	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
+	    !page_counter_try_charge(&memcg->memory, MCT_SWAP, nr_pages, &counter)) {
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
 		mem_cgroup_id_put(memcg);
@@ -5085,9 +5081,9 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	if (memcg) {
 		if (!mem_cgroup_is_root(memcg)) {
 			if (do_memsw_account())
-				page_counter_uncharge(&memcg->memsw, nr_pages);
+				page_counter_uncharge(&memcg->memory, MCT_MEMSW, nr_pages);
 			else
-				page_counter_uncharge(&memcg->swap, nr_pages);
+				page_counter_uncharge(&memcg->memory, MCT_SWAP, nr_pages);
 		}
 		mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
 		mem_cgroup_id_put_many(memcg, nr_pages);
@@ -5103,8 +5099,8 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 		return nr_swap_pages;
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
 		nr_swap_pages = min_t(long, nr_swap_pages,
-				      READ_ONCE(memcg->swap.max) -
-				      page_counter_read(&memcg->swap));
+				      READ_ONCE(memcg->memory.max[MCT_SWAP]) -
+				      page_counter_read(&memcg->memory, MCT_SWAP));
 	return nr_swap_pages;
 }
 
@@ -5124,10 +5120,10 @@ bool mem_cgroup_swap_full(struct folio *folio)
 		return false;
 
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
-		unsigned long usage = page_counter_read(&memcg->swap);
+		unsigned long usage = page_counter_read(&memcg->memory, MCT_SWAP);
 
-		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
-		    usage * 2 >= READ_ONCE(memcg->swap.max))
+		if (usage * 2 >= READ_ONCE(memcg->memory.high[MCT_SWAP]) ||
+		    usage * 2 >= READ_ONCE(memcg->memory.max[MCT_SWAP]))
 			return true;
 	}
 
@@ -5152,14 +5148,12 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	return (u64)page_counter_read(&memcg->swap) * PAGE_SIZE;
+	return (u64)page_counter_read(&memcg->memory, MCT_SWAP) * PAGE_SIZE;
 }
 
 static int swap_peak_show(struct seq_file *sf, void *v)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(sf));
-
-	return peak_show(sf, v, &memcg->swap);
+	return peak_show(sf, MCT_SWAP);
 }
 
 static ssize_t swap_peak_write(struct kernfs_open_file *of, char *buf,
@@ -5167,14 +5161,13 @@ static ssize_t swap_peak_write(struct kernfs_open_file *of, char *buf,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 
-	return peak_write(of, buf, nbytes, off, &memcg->swap,
-			  &memcg->swap_peaks);
+	return peak_write(of, buf, nbytes, off, MCT_SWAP, &memcg->swap_peaks);
 }
 
 static int swap_high_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
-		READ_ONCE(mem_cgroup_from_seq(m)->swap.high));
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.high[MCT_SWAP]));
 }
 
 static ssize_t swap_high_write(struct kernfs_open_file *of,
@@ -5189,7 +5182,7 @@ static ssize_t swap_high_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	page_counter_set_high(&memcg->swap, high);
+	page_counter_set_high(&memcg->memory, MCT_SWAP, high);
 
 	return nbytes;
 }
@@ -5197,7 +5190,7 @@ static ssize_t swap_high_write(struct kernfs_open_file *of,
 static int swap_max_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
-		READ_ONCE(mem_cgroup_from_seq(m)->swap.max));
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.max[MCT_SWAP]));
 }
 
 static ssize_t swap_max_write(struct kernfs_open_file *of,
@@ -5212,7 +5205,7 @@ static ssize_t swap_max_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	xchg(&memcg->swap.max, max);
+	xchg(&memcg->memory.max[MCT_SWAP], max);
 
 	return nbytes;
 }
diff --git a/mm/page_counter.c b/mm/page_counter.c
index b249d15af9dd..8283e1ac1206 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -13,9 +13,9 @@
 #include <linux/bug.h>
 #include <asm/page.h>
 
-static bool track_protection(struct page_counter *c)
+static bool track_protection(struct page_counter *c, unsigned long idx)
 {
-	return c->protection_support;
+	return (idx == 0) && c->protection_support;
 }
 
 static void propagate_protected_usage(struct page_counter *c,
@@ -49,39 +49,43 @@ static void propagate_protected_usage(struct page_counter *c,
 /**
  * page_counter_cancel - take pages out of the local counter
  * @counter: counter
+ * @idx: page counter id
  * @nr_pages: number of pages to cancel
  */
-void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
+void page_counter_cancel(struct page_counter *counter, unsigned long idx,
+			 unsigned long nr_pages)
 {
 	long new;
 
-	new = atomic_long_sub_return(nr_pages, &counter->usage);
+	new = atomic_long_sub_return(nr_pages, &counter->usage[idx]);
 	/* More uncharges than charges? */
 	if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
 		      new, nr_pages)) {
 		new = 0;
-		atomic_long_set(&counter->usage, new);
+		atomic_long_set(&counter->usage[idx], new);
 	}
-	if (track_protection(counter))
+	if (track_protection(counter, idx))
 		propagate_protected_usage(counter, new);
 }
 
 /**
  * page_counter_charge - hierarchically charge pages
  * @counter: counter
+ * @idx: page counter id
  * @nr_pages: number of pages to charge
  *
  * NOTE: This does not consider any configured counter limits.
  */
-void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
+void page_counter_charge(struct page_counter *counter, unsigned long idx,
+			 unsigned long nr_pages)
 {
 	struct page_counter *c;
-	bool protection = track_protection(counter);
+	bool protection = track_protection(counter, idx);
 
 	for (c = counter; c; c = c->parent) {
 		long new;
 
-		new = atomic_long_add_return(nr_pages, &c->usage);
+		new = atomic_long_add_return(nr_pages, &c->usage[idx]);
 		if (protection)
 			propagate_protected_usage(c, new);
 		/*
@@ -98,10 +102,10 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 		 * On systems with branch predictors, the inner condition should
 		 * be almost free.
 		 */
-		if (new > READ_ONCE(c->local_watermark)) {
-			WRITE_ONCE(c->local_watermark, new);
-			if (new > READ_ONCE(c->watermark))
-				WRITE_ONCE(c->watermark, new);
+		if (new > READ_ONCE(c->local_watermark[idx])) {
+			WRITE_ONCE(c->local_watermark[idx], new);
+			if (new > READ_ONCE(c->watermark[idx]))
+				WRITE_ONCE(c->watermark[idx], new);
 		}
 	}
 }
@@ -109,6 +113,7 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 /**
  * page_counter_try_charge - try to hierarchically charge pages
  * @counter: counter
+ * @idx: page counter id
  * @nr_pages: number of pages to charge
  * @fail: points first counter to hit its limit, if any
  *
@@ -116,11 +121,12 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
  * of its ancestors has hit its configured limit.
  */
 bool page_counter_try_charge(struct page_counter *counter,
+			     unsigned long idx,
 			     unsigned long nr_pages,
 			     struct page_counter **fail)
 {
 	struct page_counter *c;
-	bool protection = track_protection(counter);
+	bool protection = track_protection(counter, idx);
 
 	for (c = counter; c; c = c->parent) {
 		long new;
@@ -138,15 +144,15 @@ bool page_counter_try_charge(struct page_counter *counter,
 		 * we either see the new limit or the setter sees the
 		 * counter has changed and retries.
 		 */
-		new = atomic_long_add_return(nr_pages, &c->usage);
-		if (new > c->max) {
-			atomic_long_sub(nr_pages, &c->usage);
+		new = atomic_long_add_return(nr_pages, &c->usage[idx]);
+		if (new > c->max[idx]) {
+			atomic_long_sub(nr_pages, &c->usage[idx]);
 			/*
 			 * This is racy, but we can live with some
 			 * inaccuracy in the failcnt which is only used
 			 * to report stats.
 			 */
-			data_race(c->failcnt++);
+			data_race(c->failcnt[idx]++);
 			*fail = c;
 			goto failed;
 		}
@@ -154,17 +160,17 @@ bool page_counter_try_charge(struct page_counter *counter,
 			propagate_protected_usage(c, new);
 
 		/* see comment on page_counter_charge */
-		if (new > READ_ONCE(c->local_watermark)) {
-			WRITE_ONCE(c->local_watermark, new);
-			if (new > READ_ONCE(c->watermark))
-				WRITE_ONCE(c->watermark, new);
+		if (new > READ_ONCE(c->local_watermark[idx])) {
+			WRITE_ONCE(c->local_watermark[idx], new);
+			if (new > READ_ONCE(c->watermark[idx]))
+				WRITE_ONCE(c->watermark[idx], new);
 		}
 	}
 	return true;
 
 failed:
 	for (c = counter; c != *fail; c = c->parent)
-		page_counter_cancel(c, nr_pages);
+		page_counter_cancel(c, idx, nr_pages);
 
 	return false;
 }
@@ -172,19 +178,22 @@ bool page_counter_try_charge(struct page_counter *counter,
 /**
  * page_counter_uncharge - hierarchically uncharge pages
  * @counter: counter
+ * @idx: page counter id
  * @nr_pages: number of pages to uncharge
  */
-void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages)
+void page_counter_uncharge(struct page_counter *counter, unsigned long idx,
+			   unsigned long nr_pages)
 {
 	struct page_counter *c;
 
 	for (c = counter; c; c = c->parent)
-		page_counter_cancel(c, nr_pages);
+		page_counter_cancel(c, idx, nr_pages);
 }
 
 /**
  * page_counter_set_max - set the maximum number of pages allowed
  * @counter: counter
+ * @idx: page counter id
  * @nr_pages: limit to set
  *
  * Returns 0 on success, -EBUSY if the current number of pages on the
@@ -192,7 +201,8 @@ void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages)
  *
  * The caller must serialize invocations on the same counter.
  */
-int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
+int page_counter_set_max(struct page_counter *counter, unsigned long idx,
+			 unsigned long nr_pages)
 {
 	for (;;) {
 		unsigned long old;
@@ -209,17 +219,17 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
 		 * the limit, so if it sees the old limit, we see the
 		 * modified counter and retry.
 		 */
-		usage = page_counter_read(counter);
+		usage = page_counter_read(counter, idx);
 
 		if (usage > nr_pages)
 			return -EBUSY;
 
-		old = xchg(&counter->max, nr_pages);
+		old = xchg(&counter->max[idx], nr_pages);
 
-		if (page_counter_read(counter) <= usage || nr_pages >= old)
+		if (page_counter_read(counter, idx) <= usage || nr_pages >= old)
 			return 0;
 
-		counter->max = old;
+		counter->max[idx] = old;
 		cond_resched();
 	}
 }
@@ -227,35 +237,39 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
 /**
  * page_counter_set_min - set the amount of protected memory
  * @counter: counter
+ * @idx: page counter id
  * @nr_pages: value to set
  *
  * The caller must serialize invocations on the same counter.
  */
-void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
+void page_counter_set_min(struct page_counter *counter, unsigned long idx,
+			  unsigned long nr_pages)
 {
 	struct page_counter *c;
 
 	WRITE_ONCE(counter->min, nr_pages);
 
 	for (c = counter; c; c = c->parent)
-		propagate_protected_usage(c, atomic_long_read(&c->usage));
+		propagate_protected_usage(c, atomic_long_read(&c->usage[idx]));
 }
 
 /**
  * page_counter_set_low - set the amount of protected memory
  * @counter: counter
+ * @idx: page counter id
  * @nr_pages: value to set
  *
  * The caller must serialize invocations on the same counter.
  */
-void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
+void page_counter_set_low(struct page_counter *counter, unsigned long idx,
+			  unsigned long nr_pages)
 {
 	struct page_counter *c;
 
 	WRITE_ONCE(counter->low, nr_pages);
 
 	for (c = counter; c; c = c->parent)
-		propagate_protected_usage(c, atomic_long_read(&c->usage));
+		propagate_protected_usage(c, atomic_long_read(&c->usage[idx]));
 }
 
 /**
@@ -436,7 +450,7 @@ void page_counter_calculate_protection(struct page_counter *root,
 	if (root == counter)
 		return;
 
-	usage = page_counter_read(counter);
+	usage = page_counter_read(counter, MCT_MEM);
 	if (!usage)
 		return;
 
@@ -446,7 +460,7 @@ void page_counter_calculate_protection(struct page_counter *root,
 		return;
 	}
 
-	parent_usage = page_counter_read(parent);
+	parent_usage = page_counter_read(parent, MCT_MEM);
 
 	WRITE_ONCE(counter->emin, effective_protection(usage, parent_usage,
 			READ_ONCE(counter->min),
-- 
2.46.0.rc1.232.g9752f9e123-goog


