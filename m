Return-Path: <linux-kernel+bounces-174100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7F68C0A3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497642847CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08731487DD;
	Thu,  9 May 2024 03:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WDTnaq1k"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E53147C6B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715226139; cv=none; b=iPHcMOkIfdJZWOJj0IECW9n9mGPyjecDDE7XcHV3R+TBbefptMIfzuqbGCfQqK3sqYKZhGkQ34/Q5ky4XK02N3XNhd+35vJXZu6VfT9pQrem+nw3hdDkZwaJcwhSL72XdL6UcQuWKA9qbyCjcQO1nLE2g4XnqhYU4MfFWT3S4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715226139; c=relaxed/simple;
	bh=8E/Xzd4Tq2/no+X5Tbp/5jyX+UfzRzNfRsjSmjLpBQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeYSCGilwqx7bN0MXo6f97VY2fZf/N2tbqWy8jqeaLGG7CCLIL1bDGVN0aI6IIDesxA24rF7gz/bjMLZqcqMFzkLT+wto9RkGhCDDQ7jUJbICyeKZ4v+yFo9LSn5SHlNGYgWehbAqZONDUM5naBj8d2WHPlhigMNUc9GqZSfKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WDTnaq1k; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715226133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9MReBxUM4VEvzU/vav1V/RtQpJ1aowwXxYjzmHYMh0=;
	b=WDTnaq1kdgCkuZSy14rjCheTHNVg1vEtFEOzD8V2Zzw8/tU/VFs/rvtKjyPeSXEA/K9hHf
	OA1JPWe+ZM7yazqWHhez90tNKHdNutWf3xWat0U6G7k8OdiHqBCezjrq+4MAa8ppa9e/Fl
	bmsIw7CmlhiYKw5YYvuIfHxDPZCyGzU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@getcruise.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 2/9] mm: memcg: move soft limit reclaim code to memcontrol-v1.c
Date: Wed,  8 May 2024 20:41:31 -0700
Message-ID: <20240509034138.2207186-3-roman.gushchin@linux.dev>
In-Reply-To: <20240509034138.2207186-1-roman.gushchin@linux.dev>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Roman Gushchin <roman.gushchin@getcruise.com>

Soft limits are cgroup v1-specific and are not supported
by cgroup v2, so let's move the corresponding code into
memcontrol-v1.c.

Aside from simple moving the code, this commits introduces
a trivial mem_cgroup_soft_limit_reset() function to reset
soft limits and also moves the global soft limit tree initialization
code into a new mem_cgroup_v1_init() function.

It also moves corresponding definitions in include/memcontrol.h
into a separate section at the end of the file. The idea is to group
all memcg v1-specific definitions in one place and provide trivial
alternatives later on to support compiling the kernel without
support of the legacy memory controller.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h |  28 +--
 mm/internal.h              |   5 +
 mm/memcontrol-v1.c         | 347 +++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c            | 336 +----------------------------------
 4 files changed, 372 insertions(+), 344 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 030d34e9d117..f77b6fbf38fd 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1120,10 +1120,6 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 
 void split_page_memcg(struct page *head, int old_order, int new_order);
 
-unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
-						gfp_t gfp_mask,
-						unsigned long *total_scanned);
-
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1575,13 +1571,6 @@ static inline void split_page_memcg(struct page *head, int old_order, int new_or
 {
 }
 
-static inline
-unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
-					    gfp_t gfp_mask,
-					    unsigned long *total_scanned)
-{
-	return 0;
-}
 #endif /* CONFIG_MEMCG */
 
 /*
@@ -1932,4 +1921,21 @@ static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 }
 #endif
 
+/* Cgroup v1-specific definitions */
+
+#ifdef CONFIG_MEMCG
+unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
+						gfp_t gfp_mask,
+						unsigned long *total_scanned);
+#else /* CONFIG_MEMCG */
+
+static inline
+unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
+					    gfp_t gfp_mask,
+					    unsigned long *total_scanned)
+{
+	return 0;
+}
+#endif /* CONFIG_MEMCG */
+
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/internal.h b/mm/internal.h
index b2c75b12014e..19e96d626977 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1521,4 +1521,9 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
 
+/* Memory cgroups v1-specific definitions */
+void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid);
+void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg);
+void mem_cgroup_soft_limit_reset(struct mem_cgroup *memcg);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 4bc66fc244c0..951e1c1189cc 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1,2 +1,349 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <linux/memcontrol.h>
+#include <linux/mm_inline.h>
+
+#include "internal.h"
+
+/*
+ * Cgroups above their limits are maintained in a RB-Tree, independent of
+ * their hierarchy representation
+ */
+
+struct mem_cgroup_tree_per_node {
+	struct rb_root rb_root;
+	struct rb_node *rb_rightmost;
+	spinlock_t lock;
+};
+
+struct mem_cgroup_tree {
+	struct mem_cgroup_tree_per_node *rb_tree_per_node[MAX_NUMNODES];
+};
+
+static struct mem_cgroup_tree soft_limit_tree __read_mostly;
+
+/*
+ * Maximum loops in mem_cgroup_soft_reclaim(), used for soft
+ * limit reclaim to prevent infinite loops, if they ever occur.
+ */
+#define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
+#define	MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS	2
+
+static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
+					 struct mem_cgroup_tree_per_node *mctz,
+					 unsigned long new_usage_in_excess)
+{
+	struct rb_node **p = &mctz->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	struct mem_cgroup_per_node *mz_node;
+	bool rightmost = true;
+
+	if (mz->on_tree)
+		return;
+
+	mz->usage_in_excess = new_usage_in_excess;
+	if (!mz->usage_in_excess)
+		return;
+	while (*p) {
+		parent = *p;
+		mz_node = rb_entry(parent, struct mem_cgroup_per_node,
+					tree_node);
+		if (mz->usage_in_excess < mz_node->usage_in_excess) {
+			p = &(*p)->rb_left;
+			rightmost = false;
+		} else {
+			p = &(*p)->rb_right;
+		}
+	}
+
+	if (rightmost)
+		mctz->rb_rightmost = &mz->tree_node;
+
+	rb_link_node(&mz->tree_node, parent, p);
+	rb_insert_color(&mz->tree_node, &mctz->rb_root);
+	mz->on_tree = true;
+}
+
+static void __mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
+					 struct mem_cgroup_tree_per_node *mctz)
+{
+	if (!mz->on_tree)
+		return;
+
+	if (&mz->tree_node == mctz->rb_rightmost)
+		mctz->rb_rightmost = rb_prev(&mz->tree_node);
+
+	rb_erase(&mz->tree_node, &mctz->rb_root);
+	mz->on_tree = false;
+}
+
+static void mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
+				       struct mem_cgroup_tree_per_node *mctz)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mctz->lock, flags);
+	__mem_cgroup_remove_exceeded(mz, mctz);
+	spin_unlock_irqrestore(&mctz->lock, flags);
+}
+
+static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
+{
+	unsigned long nr_pages = page_counter_read(&memcg->memory);
+	unsigned long soft_limit = READ_ONCE(memcg->soft_limit);
+	unsigned long excess = 0;
+
+	if (nr_pages > soft_limit)
+		excess = nr_pages - soft_limit;
+
+	return excess;
+}
+
+void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
+{
+	unsigned long excess;
+	struct mem_cgroup_per_node *mz;
+	struct mem_cgroup_tree_per_node *mctz;
+
+	if (lru_gen_enabled()) {
+		if (soft_limit_excess(memcg))
+			lru_gen_soft_reclaim(memcg, nid);
+		return;
+	}
+
+	mctz = soft_limit_tree.rb_tree_per_node[nid];
+	if (!mctz)
+		return;
+	/*
+	 * Necessary to update all ancestors when hierarchy is used.
+	 * because their event counter is not touched.
+	 */
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		mz = memcg->nodeinfo[nid];
+		excess = soft_limit_excess(memcg);
+		/*
+		 * We have to update the tree if mz is on RB-tree or
+		 * mem is over its softlimit.
+		 */
+		if (excess || mz->on_tree) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&mctz->lock, flags);
+			/* if on-tree, remove it */
+			if (mz->on_tree)
+				__mem_cgroup_remove_exceeded(mz, mctz);
+			/*
+			 * Insert again. mz->usage_in_excess will be updated.
+			 * If excess is 0, no tree ops.
+			 */
+			__mem_cgroup_insert_exceeded(mz, mctz, excess);
+			spin_unlock_irqrestore(&mctz->lock, flags);
+		}
+	}
+}
+
+void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup_tree_per_node *mctz;
+	struct mem_cgroup_per_node *mz;
+	int nid;
+
+	for_each_node(nid) {
+		mz = memcg->nodeinfo[nid];
+		mctz = soft_limit_tree.rb_tree_per_node[nid];
+		if (mctz)
+			mem_cgroup_remove_exceeded(mz, mctz);
+	}
+}
+
+static struct mem_cgroup_per_node *
+__mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
+{
+	struct mem_cgroup_per_node *mz;
+
+retry:
+	mz = NULL;
+	if (!mctz->rb_rightmost)
+		goto done;		/* Nothing to reclaim from */
+
+	mz = rb_entry(mctz->rb_rightmost,
+		      struct mem_cgroup_per_node, tree_node);
+	/*
+	 * Remove the node now but someone else can add it back,
+	 * we will to add it back at the end of reclaim to its correct
+	 * position in the tree.
+	 */
+	__mem_cgroup_remove_exceeded(mz, mctz);
+	if (!soft_limit_excess(mz->memcg) ||
+	    !css_tryget(&mz->memcg->css))
+		goto retry;
+done:
+	return mz;
+}
+
+static struct mem_cgroup_per_node *
+mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
+{
+	struct mem_cgroup_per_node *mz;
+
+	spin_lock_irq(&mctz->lock);
+	mz = __mem_cgroup_largest_soft_limit_node(mctz);
+	spin_unlock_irq(&mctz->lock);
+	return mz;
+}
+
+static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
+				   pg_data_t *pgdat,
+				   gfp_t gfp_mask,
+				   unsigned long *total_scanned)
+{
+	struct mem_cgroup *victim = NULL;
+	int total = 0;
+	int loop = 0;
+	unsigned long excess;
+	unsigned long nr_scanned;
+	struct mem_cgroup_reclaim_cookie reclaim = {
+		.pgdat = pgdat,
+	};
+
+	excess = soft_limit_excess(root_memcg);
+
+	while (1) {
+		victim = mem_cgroup_iter(root_memcg, victim, &reclaim);
+		if (!victim) {
+			loop++;
+			if (loop >= 2) {
+				/*
+				 * If we have not been able to reclaim
+				 * anything, it might because there are
+				 * no reclaimable pages under this hierarchy
+				 */
+				if (!total)
+					break;
+				/*
+				 * We want to do more targeted reclaim.
+				 * excess >> 2 is not to excessive so as to
+				 * reclaim too much, nor too less that we keep
+				 * coming back to reclaim from this cgroup
+				 */
+				if (total >= (excess >> 2) ||
+					(loop > MEM_CGROUP_MAX_RECLAIM_LOOPS))
+					break;
+			}
+			continue;
+		}
+		total += mem_cgroup_shrink_node(victim, gfp_mask, false,
+					pgdat, &nr_scanned);
+		*total_scanned += nr_scanned;
+		if (!soft_limit_excess(root_memcg))
+			break;
+	}
+	mem_cgroup_iter_break(root_memcg, victim);
+	return total;
+}
+
+unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
+					    gfp_t gfp_mask,
+					    unsigned long *total_scanned)
+{
+	unsigned long nr_reclaimed = 0;
+	struct mem_cgroup_per_node *mz, *next_mz = NULL;
+	unsigned long reclaimed;
+	int loop = 0;
+	struct mem_cgroup_tree_per_node *mctz;
+	unsigned long excess;
+
+	if (lru_gen_enabled())
+		return 0;
+
+	if (order > 0)
+		return 0;
+
+	mctz = soft_limit_tree.rb_tree_per_node[pgdat->node_id];
+
+	/*
+	 * Do not even bother to check the largest node if the root
+	 * is empty. Do it lockless to prevent lock bouncing. Races
+	 * are acceptable as soft limit is best effort anyway.
+	 */
+	if (!mctz || RB_EMPTY_ROOT(&mctz->rb_root))
+		return 0;
+
+	/*
+	 * This loop can run a while, specially if mem_cgroup's continuously
+	 * keep exceeding their soft limit and putting the system under
+	 * pressure
+	 */
+	do {
+		if (next_mz)
+			mz = next_mz;
+		else
+			mz = mem_cgroup_largest_soft_limit_node(mctz);
+		if (!mz)
+			break;
+
+		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
+						    gfp_mask, total_scanned);
+		nr_reclaimed += reclaimed;
+		spin_lock_irq(&mctz->lock);
+
+		/*
+		 * If we failed to reclaim anything from this memory cgroup
+		 * it is time to move on to the next cgroup
+		 */
+		next_mz = NULL;
+		if (!reclaimed)
+			next_mz = __mem_cgroup_largest_soft_limit_node(mctz);
+
+		excess = soft_limit_excess(mz->memcg);
+		/*
+		 * One school of thought says that we should not add
+		 * back the node to the tree if reclaim returns 0.
+		 * But our reclaim could return 0, simply because due
+		 * to priority we are exposing a smaller subset of
+		 * memory to reclaim from. Consider this as a longer
+		 * term TODO.
+		 */
+		/* If excess == 0, no tree ops */
+		__mem_cgroup_insert_exceeded(mz, mctz, excess);
+		spin_unlock_irq(&mctz->lock);
+		css_put(&mz->memcg->css);
+		loop++;
+		/*
+		 * Could not reclaim anything and there are no more
+		 * mem cgroups to try or we seem to be looping without
+		 * reclaiming anything.
+		 */
+		if (!nr_reclaimed &&
+			(next_mz == NULL ||
+			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
+			break;
+	} while (!nr_reclaimed);
+	if (next_mz)
+		css_put(&next_mz->memcg->css);
+	return nr_reclaimed;
+}
+
+void mem_cgroup_soft_limit_reset(struct mem_cgroup *memcg)
+{
+	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
+}
+
+static int __init mem_cgroup_v1_init(void)
+{
+	int node;
+
+	for_each_node(node) {
+		struct mem_cgroup_tree_per_node *rtpn;
+
+		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
+
+		rtpn->rb_root = RB_ROOT;
+		rtpn->rb_rightmost = NULL;
+		spin_lock_init(&rtpn->lock);
+		soft_limit_tree.rb_tree_per_node[node] = rtpn;
+	}
+
+	return 0;
+}
+subsys_initcall(mem_cgroup_v1_init);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5d4da23264fa..0c2196f42631 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -108,23 +108,6 @@ static bool do_memsw_account(void)
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
 
-/*
- * Cgroups above their limits are maintained in a RB-Tree, independent of
- * their hierarchy representation
- */
-
-struct mem_cgroup_tree_per_node {
-	struct rb_root rb_root;
-	struct rb_node *rb_rightmost;
-	spinlock_t lock;
-};
-
-struct mem_cgroup_tree {
-	struct mem_cgroup_tree_per_node *rb_tree_per_node[MAX_NUMNODES];
-};
-
-static struct mem_cgroup_tree soft_limit_tree __read_mostly;
-
 /* for OOM */
 struct mem_cgroup_eventfd_list {
 	struct list_head list;
@@ -199,13 +182,6 @@ static struct move_charge_struct {
 	.waitq = __WAIT_QUEUE_HEAD_INITIALIZER(mc.waitq),
 };
 
-/*
- * Maximum loops in mem_cgroup_soft_reclaim(), used for soft
- * limit reclaim to prevent infinite loops, if they ever occur.
- */
-#define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
-#define	MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS	2
-
 /* for encoding cft->private value on file */
 enum res_type {
 	_MEM,
@@ -413,169 +389,6 @@ ino_t page_cgroup_ino(struct page *page)
 	return ino;
 }
 
-static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
-					 struct mem_cgroup_tree_per_node *mctz,
-					 unsigned long new_usage_in_excess)
-{
-	struct rb_node **p = &mctz->rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct mem_cgroup_per_node *mz_node;
-	bool rightmost = true;
-
-	if (mz->on_tree)
-		return;
-
-	mz->usage_in_excess = new_usage_in_excess;
-	if (!mz->usage_in_excess)
-		return;
-	while (*p) {
-		parent = *p;
-		mz_node = rb_entry(parent, struct mem_cgroup_per_node,
-					tree_node);
-		if (mz->usage_in_excess < mz_node->usage_in_excess) {
-			p = &(*p)->rb_left;
-			rightmost = false;
-		} else {
-			p = &(*p)->rb_right;
-		}
-	}
-
-	if (rightmost)
-		mctz->rb_rightmost = &mz->tree_node;
-
-	rb_link_node(&mz->tree_node, parent, p);
-	rb_insert_color(&mz->tree_node, &mctz->rb_root);
-	mz->on_tree = true;
-}
-
-static void __mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
-					 struct mem_cgroup_tree_per_node *mctz)
-{
-	if (!mz->on_tree)
-		return;
-
-	if (&mz->tree_node == mctz->rb_rightmost)
-		mctz->rb_rightmost = rb_prev(&mz->tree_node);
-
-	rb_erase(&mz->tree_node, &mctz->rb_root);
-	mz->on_tree = false;
-}
-
-static void mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
-				       struct mem_cgroup_tree_per_node *mctz)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&mctz->lock, flags);
-	__mem_cgroup_remove_exceeded(mz, mctz);
-	spin_unlock_irqrestore(&mctz->lock, flags);
-}
-
-static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
-{
-	unsigned long nr_pages = page_counter_read(&memcg->memory);
-	unsigned long soft_limit = READ_ONCE(memcg->soft_limit);
-	unsigned long excess = 0;
-
-	if (nr_pages > soft_limit)
-		excess = nr_pages - soft_limit;
-
-	return excess;
-}
-
-static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
-{
-	unsigned long excess;
-	struct mem_cgroup_per_node *mz;
-	struct mem_cgroup_tree_per_node *mctz;
-
-	if (lru_gen_enabled()) {
-		if (soft_limit_excess(memcg))
-			lru_gen_soft_reclaim(memcg, nid);
-		return;
-	}
-
-	mctz = soft_limit_tree.rb_tree_per_node[nid];
-	if (!mctz)
-		return;
-	/*
-	 * Necessary to update all ancestors when hierarchy is used.
-	 * because their event counter is not touched.
-	 */
-	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		mz = memcg->nodeinfo[nid];
-		excess = soft_limit_excess(memcg);
-		/*
-		 * We have to update the tree if mz is on RB-tree or
-		 * mem is over its softlimit.
-		 */
-		if (excess || mz->on_tree) {
-			unsigned long flags;
-
-			spin_lock_irqsave(&mctz->lock, flags);
-			/* if on-tree, remove it */
-			if (mz->on_tree)
-				__mem_cgroup_remove_exceeded(mz, mctz);
-			/*
-			 * Insert again. mz->usage_in_excess will be updated.
-			 * If excess is 0, no tree ops.
-			 */
-			__mem_cgroup_insert_exceeded(mz, mctz, excess);
-			spin_unlock_irqrestore(&mctz->lock, flags);
-		}
-	}
-}
-
-static void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
-{
-	struct mem_cgroup_tree_per_node *mctz;
-	struct mem_cgroup_per_node *mz;
-	int nid;
-
-	for_each_node(nid) {
-		mz = memcg->nodeinfo[nid];
-		mctz = soft_limit_tree.rb_tree_per_node[nid];
-		if (mctz)
-			mem_cgroup_remove_exceeded(mz, mctz);
-	}
-}
-
-static struct mem_cgroup_per_node *
-__mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
-{
-	struct mem_cgroup_per_node *mz;
-
-retry:
-	mz = NULL;
-	if (!mctz->rb_rightmost)
-		goto done;		/* Nothing to reclaim from */
-
-	mz = rb_entry(mctz->rb_rightmost,
-		      struct mem_cgroup_per_node, tree_node);
-	/*
-	 * Remove the node now but someone else can add it back,
-	 * we will to add it back at the end of reclaim to its correct
-	 * position in the tree.
-	 */
-	__mem_cgroup_remove_exceeded(mz, mctz);
-	if (!soft_limit_excess(mz->memcg) ||
-	    !css_tryget(&mz->memcg->css))
-		goto retry;
-done:
-	return mz;
-}
-
-static struct mem_cgroup_per_node *
-mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
-{
-	struct mem_cgroup_per_node *mz;
-
-	spin_lock_irq(&mctz->lock);
-	mz = __mem_cgroup_largest_soft_limit_node(mctz);
-	spin_unlock_irq(&mctz->lock);
-	return mz;
-}
-
 /* Subset of node_stat_item for memcg stats */
 static const unsigned int memcg_node_stat_items[] = {
 	NR_INACTIVE_ANON,
@@ -1983,56 +1796,6 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return ret;
 }
 
-static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
-				   pg_data_t *pgdat,
-				   gfp_t gfp_mask,
-				   unsigned long *total_scanned)
-{
-	struct mem_cgroup *victim = NULL;
-	int total = 0;
-	int loop = 0;
-	unsigned long excess;
-	unsigned long nr_scanned;
-	struct mem_cgroup_reclaim_cookie reclaim = {
-		.pgdat = pgdat,
-	};
-
-	excess = soft_limit_excess(root_memcg);
-
-	while (1) {
-		victim = mem_cgroup_iter(root_memcg, victim, &reclaim);
-		if (!victim) {
-			loop++;
-			if (loop >= 2) {
-				/*
-				 * If we have not been able to reclaim
-				 * anything, it might because there are
-				 * no reclaimable pages under this hierarchy
-				 */
-				if (!total)
-					break;
-				/*
-				 * We want to do more targeted reclaim.
-				 * excess >> 2 is not to excessive so as to
-				 * reclaim too much, nor too less that we keep
-				 * coming back to reclaim from this cgroup
-				 */
-				if (total >= (excess >> 2) ||
-					(loop > MEM_CGROUP_MAX_RECLAIM_LOOPS))
-					break;
-			}
-			continue;
-		}
-		total += mem_cgroup_shrink_node(victim, gfp_mask, false,
-					pgdat, &nr_scanned);
-		*total_scanned += nr_scanned;
-		if (!soft_limit_excess(root_memcg))
-			break;
-	}
-	mem_cgroup_iter_break(root_memcg, victim);
-	return total;
-}
-
 #ifdef CONFIG_LOCKDEP
 static struct lockdep_map memcg_oom_lock_dep_map = {
 	.name = "memcg_oom_lock",
@@ -3932,88 +3695,6 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 	return ret;
 }
 
-unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
-					    gfp_t gfp_mask,
-					    unsigned long *total_scanned)
-{
-	unsigned long nr_reclaimed = 0;
-	struct mem_cgroup_per_node *mz, *next_mz = NULL;
-	unsigned long reclaimed;
-	int loop = 0;
-	struct mem_cgroup_tree_per_node *mctz;
-	unsigned long excess;
-
-	if (lru_gen_enabled())
-		return 0;
-
-	if (order > 0)
-		return 0;
-
-	mctz = soft_limit_tree.rb_tree_per_node[pgdat->node_id];
-
-	/*
-	 * Do not even bother to check the largest node if the root
-	 * is empty. Do it lockless to prevent lock bouncing. Races
-	 * are acceptable as soft limit is best effort anyway.
-	 */
-	if (!mctz || RB_EMPTY_ROOT(&mctz->rb_root))
-		return 0;
-
-	/*
-	 * This loop can run a while, specially if mem_cgroup's continuously
-	 * keep exceeding their soft limit and putting the system under
-	 * pressure
-	 */
-	do {
-		if (next_mz)
-			mz = next_mz;
-		else
-			mz = mem_cgroup_largest_soft_limit_node(mctz);
-		if (!mz)
-			break;
-
-		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
-						    gfp_mask, total_scanned);
-		nr_reclaimed += reclaimed;
-		spin_lock_irq(&mctz->lock);
-
-		/*
-		 * If we failed to reclaim anything from this memory cgroup
-		 * it is time to move on to the next cgroup
-		 */
-		next_mz = NULL;
-		if (!reclaimed)
-			next_mz = __mem_cgroup_largest_soft_limit_node(mctz);
-
-		excess = soft_limit_excess(mz->memcg);
-		/*
-		 * One school of thought says that we should not add
-		 * back the node to the tree if reclaim returns 0.
-		 * But our reclaim could return 0, simply because due
-		 * to priority we are exposing a smaller subset of
-		 * memory to reclaim from. Consider this as a longer
-		 * term TODO.
-		 */
-		/* If excess == 0, no tree ops */
-		__mem_cgroup_insert_exceeded(mz, mctz, excess);
-		spin_unlock_irq(&mctz->lock);
-		css_put(&mz->memcg->css);
-		loop++;
-		/*
-		 * Could not reclaim anything and there are no more
-		 * mem cgroups to try or we seem to be looping without
-		 * reclaiming anything.
-		 */
-		if (!nr_reclaimed &&
-			(next_mz == NULL ||
-			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
-			break;
-	} while (!nr_reclaimed);
-	if (next_mz)
-		css_put(&next_mz->memcg->css);
-	return nr_reclaimed;
-}
-
 /*
  * Reclaims as many pages from the given memcg as possible.
  *
@@ -5791,7 +5472,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		return ERR_CAST(memcg);
 
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
-	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
+	mem_cgroup_soft_limit_reset(memcg);
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	memcg->zswap_max = PAGE_COUNTER_MAX;
 	WRITE_ONCE(memcg->zswap_writeback,
@@ -5964,7 +5645,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
-	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
+	mem_cgroup_soft_limit_reset(memcg);
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	memcg_wb_domain_size_changed(memcg);
 }
@@ -7992,7 +7673,7 @@ __setup("cgroup.memory=", cgroup_memory);
  */
 static int __init mem_cgroup_init(void)
 {
-	int cpu, node;
+	int cpu;
 
 	/*
 	 * Currently s32 type (can refer to struct batched_lruvec_stat) is
@@ -8009,17 +7690,6 @@ static int __init mem_cgroup_init(void)
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
 			  drain_local_stock);
 
-	for_each_node(node) {
-		struct mem_cgroup_tree_per_node *rtpn;
-
-		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
-
-		rtpn->rb_root = RB_ROOT;
-		rtpn->rb_rightmost = NULL;
-		spin_lock_init(&rtpn->lock);
-		soft_limit_tree.rb_tree_per_node[node] = rtpn;
-	}
-
 	return 0;
 }
 subsys_initcall(mem_cgroup_init);
-- 
2.43.2


