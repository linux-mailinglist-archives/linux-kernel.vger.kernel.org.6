Return-Path: <linux-kernel+bounces-193133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451BA8D273E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A41B27BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281658AB4;
	Tue, 28 May 2024 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z43bJfGX"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05D917165C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932705; cv=none; b=VUMtYkr3ZNpxaoBSuuyzzjBJS49J+pdvlLgivBX+eG7v4K3zKO5TclHsV6GQmqour4j8Nyqx4v2Dwj7+D4JJpXSvQ/HpKt30opPiY72G/jhDr25CRA7gOXC3Sx2ZqWJ2nwoo7qB7uFbo0maUgoY+BuQ4BSth7iaX53KBhANJm48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932705; c=relaxed/simple;
	bh=jzbz5CMAqbjHONlmDaQSGjbS6xOp6mKYDXih1pYtLBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slVY1ceiBL5y//bJahgsaoheFKfvDpMxIYbqchmWZ33pK1zd8dc8pF0wrBzqt6flOaMw1SzblKNLBRoU6Po/H8MsKUAhWGaQcqN5eT9319o42I1oXJBwIKbPEGLrwZKi2mBaBiXTTTadWd1z1eQxH2BYDr5X9iM/eCcOENFbOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z43bJfGX; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716932700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWiY2lI1QItCOH2GFi55k4QyY7Ks3qNYQGCerCKa1hI=;
	b=Z43bJfGX9tj4fp4sLBslNA7ukMkHICWqSxxE6paIJtPF/8oH76Oc1PGvo4XZ2ate4kJX2B
	ZiroGJsEm1BHip9HQ7ftUU0XHpvfRhnJPH0IRyQ9cD+U6ljjkRlB7/1caoMkQomqBkTHNt
	JF3gmM/jp/vL8hiwr9ukamXz8JWnl1k=
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 12/14] mm: memcg: group cgroup v1 memcg related declarations
Date: Tue, 28 May 2024 14:44:33 -0700
Message-ID: <20240528214435.3125304-3-roman.gushchin@linux.dev>
In-Reply-To: <20240528214435.3125304-1-roman.gushchin@linux.dev>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528214435.3125304-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Group all cgroup v1-related declarations at the end of memcontrol.h
and mm/memcontrol-v1.h with an intention to put them all together
under a config option later on. It should make things easier to
follow and maintain too.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 144 +++++++++++++++++++------------------
 mm/memcontrol-v1.h         |  89 ++++++++++++-----------
 2 files changed, 123 insertions(+), 110 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 394b92b620d9c..7474b20a5d3f5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -944,39 +944,13 @@ static inline void mem_cgroup_exit_user_fault(void)
 	current->in_user_fault = 0;
 }
 
-static inline bool task_in_memcg_oom(struct task_struct *p)
-{
-	return p->memcg_in_oom;
-}
-
-bool mem_cgroup_oom_synchronize(bool wait);
 struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 					    struct mem_cgroup *oom_domain);
 void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 
-void folio_memcg_lock(struct folio *folio);
-void folio_memcg_unlock(struct folio *folio);
-
 void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 		       int val);
 
-/* try to stablize folio_memcg() for all the pages in a memcg */
-static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
-{
-	rcu_read_lock();
-
-	if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_account))
-		return true;
-
-	rcu_read_unlock();
-	return false;
-}
-
-static inline void mem_cgroup_unlock_pages(void)
-{
-	rcu_read_unlock();
-}
-
 /* idx can be of type enum memcg_stat_item or node_stat_item */
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
 				   enum memcg_stat_item idx, int val)
@@ -1103,10 +1077,6 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 
 void split_page_memcg(struct page *head, int old_order, int new_order);
 
-unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
-					gfp_t gfp_mask,
-					unsigned long *total_scanned);
-
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1417,26 +1387,6 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
-static inline void folio_memcg_lock(struct folio *folio)
-{
-}
-
-static inline void folio_memcg_unlock(struct folio *folio)
-{
-}
-
-static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
-{
-	/* to match folio_memcg_rcu() */
-	rcu_read_lock();
-	return true;
-}
-
-static inline void mem_cgroup_unlock_pages(void)
-{
-	rcu_read_unlock();
-}
-
 static inline void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
 }
@@ -1449,16 +1399,6 @@ static inline void mem_cgroup_exit_user_fault(void)
 {
 }
 
-static inline bool task_in_memcg_oom(struct task_struct *p)
-{
-	return false;
-}
-
-static inline bool mem_cgroup_oom_synchronize(bool wait)
-{
-	return false;
-}
-
 static inline struct mem_cgroup *mem_cgroup_get_oom_group(
 	struct task_struct *victim, struct mem_cgroup *oom_domain)
 {
@@ -1552,14 +1492,6 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 static inline void split_page_memcg(struct page *head, int old_order, int new_order)
 {
 }
-
-static inline
-unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
-					gfp_t gfp_mask,
-					unsigned long *total_scanned)
-{
-	return 0;
-}
 #endif /* CONFIG_MEMCG */
 
 /*
@@ -1910,4 +1842,80 @@ static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 }
 #endif
 
+
+/* Cgroup v1-related declarations */
+
+#ifdef CONFIG_MEMCG
+unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
+					gfp_t gfp_mask,
+					unsigned long *total_scanned);
+
+bool mem_cgroup_oom_synchronize(bool wait);
+
+static inline bool task_in_memcg_oom(struct task_struct *p)
+{
+	return p->memcg_in_oom;
+}
+
+void folio_memcg_lock(struct folio *folio);
+void folio_memcg_unlock(struct folio *folio);
+
+/* try to stablize folio_memcg() for all the pages in a memcg */
+static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
+{
+	rcu_read_lock();
+
+	if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_account))
+		return true;
+
+	rcu_read_unlock();
+	return false;
+}
+
+static inline void mem_cgroup_unlock_pages(void)
+{
+	rcu_read_unlock();
+}
+
+#else /* CONFIG_MEMCG */
+static inline
+unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
+					gfp_t gfp_mask,
+					unsigned long *total_scanned)
+{
+	return 0;
+}
+
+static inline void folio_memcg_lock(struct folio *folio)
+{
+}
+
+static inline void folio_memcg_unlock(struct folio *folio)
+{
+}
+
+static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
+{
+	/* to match folio_memcg_rcu() */
+	rcu_read_lock();
+	return true;
+}
+
+static inline void mem_cgroup_unlock_pages(void)
+{
+	rcu_read_unlock();
+}
+
+static inline bool task_in_memcg_oom(struct task_struct *p)
+{
+	return false;
+}
+
+static inline bool mem_cgroup_oom_synchronize(bool wait)
+{
+	return false;
+}
+
+#endif /* CONFIG_MEMCG */
+
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 7d6ac4a4fb36d..89d4207930481 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -5,15 +5,9 @@
 
 #include <linux/cgroup-defs.h>
 
-void memcg1_remove_from_trees(struct mem_cgroup *memcg);
-
-static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
-{
-	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
-}
+/* Cgroup v1 and v2 common declarations */
 
 void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
-void memcg1_check_events(struct mem_cgroup *memcg, int nid);
 int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		     unsigned int nr_pages);
 
@@ -29,30 +23,6 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
 void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
 
-bool memcg1_wait_acct_move(struct mem_cgroup *memcg);
-struct cgroup_taskset;
-int memcg1_can_attach(struct cgroup_taskset *tset);
-void memcg1_cancel_attach(struct cgroup_taskset *tset);
-void memcg1_move_task(void);
-
-/*
- * Per memcg event counter is incremented at every pagein/pageout. With THP,
- * it will be incremented by the number of pages. This counter is used
- * to trigger some periodic events. This is straightforward and better
- * than using jiffies etc. to handle periodic memcg event.
- */
-enum mem_cgroup_events_target {
-	MEM_CGROUP_TARGET_THRESH,
-	MEM_CGROUP_TARGET_SOFTLIMIT,
-	MEM_CGROUP_NTARGETS,
-};
-
-/* Whether legacy memory+swap accounting is active */
-static bool do_memsw_account(void)
-{
-	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
-}
-
 /*
  * Iteration constructs for visiting all cgroups (under a tree).  If
  * loops are exited prematurely (break), mem_cgroup_iter_break() must
@@ -68,24 +38,28 @@ static bool do_memsw_account(void)
 	     iter != NULL;				\
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
-void memcg1_css_offline(struct mem_cgroup *memcg);
+/* Whether legacy memory+swap accounting is active */
+static bool do_memsw_account(void)
+{
+	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
+}
 
-/* for encoding cft->private value on file */
-enum res_type {
-	_MEM,
-	_MEMSWAP,
-	_KMEM,
-	_TCP,
+/*
+ * Per memcg event counter is incremented at every pagein/pageout. With THP,
+ * it will be incremented by the number of pages. This counter is used
+ * to trigger some periodic events. This is straightforward and better
+ * than using jiffies etc. to handle periodic memcg event.
+ */
+enum mem_cgroup_events_target {
+	MEM_CGROUP_TARGET_THRESH,
+	MEM_CGROUP_TARGET_SOFTLIMIT,
+	MEM_CGROUP_NTARGETS,
 };
 
 bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				enum mem_cgroup_events_target target);
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 
-bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
-void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
-void memcg1_oom_recover(struct mem_cgroup *memcg);
-
 void drain_all_stock(struct mem_cgroup *root_memcg);
 unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
 				      unsigned int lru_mask, bool tree);
@@ -100,6 +74,37 @@ unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
 int memory_stat_show(struct seq_file *m, void *v);
 
+/* Cgroup v1-specific declarations */
+
+void memcg1_remove_from_trees(struct mem_cgroup *memcg);
+
+static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
+{
+	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
+}
+
+bool memcg1_wait_acct_move(struct mem_cgroup *memcg);
+
+struct cgroup_taskset;
+int memcg1_can_attach(struct cgroup_taskset *tset);
+void memcg1_cancel_attach(struct cgroup_taskset *tset);
+void memcg1_move_task(void);
+void memcg1_css_offline(struct mem_cgroup *memcg);
+
+/* for encoding cft->private value on file */
+enum res_type {
+	_MEM,
+	_MEMSWAP,
+	_KMEM,
+	_TCP,
+};
+
+bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
+void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
+void memcg1_oom_recover(struct mem_cgroup *memcg);
+
+void memcg1_check_events(struct mem_cgroup *memcg, int nid);
+
 void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
 
 extern struct cftype memsw_files[];
-- 
2.45.1


