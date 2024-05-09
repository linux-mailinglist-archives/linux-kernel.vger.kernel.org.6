Return-Path: <linux-kernel+bounces-174106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A240B8C0A43
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DE4284781
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674914830E;
	Thu,  9 May 2024 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v3WirRuP"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097D147C6B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715226154; cv=none; b=kPDB5gCBsA0T7BOK+pqc0/RS1GoiS2OY7EGLUeEA877iKPMemH6seGzRHU/w/63bYJ/oBUBX+xJP1BFp1ZojuUFhdWNfzaaLYhQVQTv9sz1RqqAHrXDvhAKIMwo6OCuTcgtBkKxV4f6mDCJU14C+Bl8zO/hnoIrC/2pvyTJmzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715226154; c=relaxed/simple;
	bh=dulm3n2GQxmlYlGqMZR/sqDMuNyud8Ay8AhzdzlGpFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSBPYShOBbgQM5XQGZrWDfXSTdo638CnHmlARwCBXaOCzg7e88bppP+tCfKVUVodCSanAZJpn/GK0NoPNEq5pSS64UjqeyotBWftdMN2yFos+V+faK774tZexdL/MEiw320dUdezurMKUb3nMKUFufcBjY+qEqJRd+ji0asH91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v3WirRuP; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715226146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+IGewwB/hA9+YLjb6ALMedkw3L1LhLjm9qHeDH2NK8=;
	b=v3WirRuPZx7HirePbOwRVVFlRmAV+7Kqm9Fygr0Fyu/mHOUusNM9d1Yx0CyL77pcjEW8ts
	yGTX8zbOBHHSfUmaGJxX9wXy+GdtMzoWUunKwUsMYZReY/qWviEnhC6mnHc2R3raGj6PXG
	U1kZCFpWMRAfAUegfstelLCrjJD1xaM=
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
Subject: [PATCH rfc 8/9] mm: memcg: put corresponding struct mem_cgroup members under CONFIG_MEMCG_V1
Date: Wed,  8 May 2024 20:41:37 -0700
Message-ID: <20240509034138.2207186-9-roman.gushchin@linux.dev>
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

Put members of struct mem_cgroup which are related to the legacy
cgroup v1 memory controller under the CONFIG_MEMCG_V1 config option.
Also, put the initialization and some trivial access code under the
same option.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 33 ++++++++++++++++++++-------------
 mm/memcontrol.c            | 25 +++++++++++++++++++------
 2 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d2a4145b1909..4347d6889fa0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -182,9 +182,11 @@ struct mem_cgroup {
 		struct page_counter memsw;	/* v1 only */
 	};
 
+#ifdef CONFIG_MEMCG_V1
 	/* Legacy consumer-oriented counters */
 	struct page_counter kmem;		/* v1 only */
 	struct page_counter tcpmem;		/* v1 only */
+#endif
 
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
@@ -198,24 +200,15 @@ struct mem_cgroup {
 	 */
 	bool zswap_writeback;
 #endif
-
-	unsigned long soft_limit;
-
-	/* vmpressure notifications */
-	struct vmpressure vmpressure;
+	int swappiness;
 
 	/*
 	 * Should the OOM killer kill all belonging tasks, had it kill one?
 	 */
 	bool oom_group;
 
-	/* protected by memcg_oom_lock */
-	bool		oom_lock;
-	int		under_oom;
-
-	int	swappiness;
-	/* OOM-Killer disable */
-	int		oom_kill_disable;
+	/* vmpressure notifications */
+	struct vmpressure vmpressure;
 
 	/* memory.events and memory.events.local */
 	struct cgroup_file events_file;
@@ -224,6 +217,16 @@ struct mem_cgroup {
 	/* handle for "memory.swap.events" */
 	struct cgroup_file swap_events_file;
 
+#ifdef CONFIG_MEMCG_V1
+	unsigned long soft_limit;
+
+	/* protected by memcg_oom_lock */
+	bool		oom_lock;
+	int		under_oom;
+
+	/* OOM-Killer disable */
+	int		oom_kill_disable;
+
 	/* protect arrays of thresholds */
 	struct mutex thresholds_lock;
 
@@ -244,6 +247,7 @@ struct mem_cgroup {
 	/* taken only while moving_account > 0 */
 	spinlock_t		move_lock;
 	unsigned long		move_lock_flags;
+#endif
 
 	CACHELINE_PADDING(_pad1_);
 
@@ -279,12 +283,13 @@ struct mem_cgroup {
 #endif
 
 	CACHELINE_PADDING(_pad2_);
-
+#ifdef CONFIG_MEMCG_V1
 	/*
 	 * set > 0 if pages under this cgroup are moving to other cgroup.
 	 */
 	atomic_t		moving_account;
 	struct task_struct	*move_lock_task;
+#endif
 
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 
@@ -294,9 +299,11 @@ struct mem_cgroup {
 	struct memcg_cgwb_frn cgwb_frn[MEMCG_CGWB_FRN_CNT];
 #endif
 
+#ifdef CONFIG_MEMCG_V1
 	/* List of events which userspace want to receive */
 	struct list_head event_list;
 	spinlock_t event_list_lock;
+#endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct deferred_split deferred_split_queue;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d5883f748330..4dcfd1ef5d61 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1537,6 +1537,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 		pr_info("swap: usage %llukB, limit %llukB, failcnt %lu\n",
 			K((u64)page_counter_read(&memcg->swap)),
 			K((u64)READ_ONCE(memcg->swap.max)), memcg->swap.failcnt);
+#ifdef CONFIG_MEMCG_V1
 	else {
 		pr_info("memory+swap: usage %llukB, limit %llukB, failcnt %lu\n",
 			K((u64)page_counter_read(&memcg->memsw)),
@@ -1545,6 +1546,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 			K((u64)page_counter_read(&memcg->kmem)),
 			K((u64)memcg->kmem.max), memcg->kmem.failcnt);
 	}
+#endif
 
 	pr_info("Memory cgroup stats for ");
 	pr_cont_cgroup_path(memcg->css.cgroup);
@@ -2650,12 +2652,14 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 {
 	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
+#ifdef CONFIG_MEMCG_V1
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
 		if (nr_pages > 0)
 			page_counter_charge(&memcg->kmem, nr_pages);
 		else
 			page_counter_uncharge(&memcg->kmem, -nr_pages);
 	}
+#endif
 }
 
 
@@ -3602,12 +3606,14 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 		goto fail;
 
 	INIT_WORK(&memcg->high_work, high_work_func);
+#ifdef CONFIG_MEMCG_V1
 	INIT_LIST_HEAD(&memcg->oom_notify);
 	mutex_init(&memcg->thresholds_lock);
 	spin_lock_init(&memcg->move_lock);
-	vmpressure_init(&memcg->vmpressure);
 	INIT_LIST_HEAD(&memcg->event_list);
 	spin_lock_init(&memcg->event_list_lock);
+#endif
+	vmpressure_init(&memcg->vmpressure);
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
@@ -3654,20 +3660,22 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
-		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
-
 		page_counter_init(&memcg->memory, &parent->memory);
 		page_counter_init(&memcg->swap, &parent->swap);
+#ifdef CONFIG_MEMCG_V1
 		page_counter_init(&memcg->kmem, &parent->kmem);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
+		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
+#endif
 	} else {
 		init_memcg_stats();
 		init_memcg_events();
 		page_counter_init(&memcg->memory, NULL);
 		page_counter_init(&memcg->swap, NULL);
+#ifdef CONFIG_MEMCG_V1
 		page_counter_init(&memcg->kmem, NULL);
 		page_counter_init(&memcg->tcpmem, NULL);
-
+#endif
 		root_mem_cgroup = memcg;
 		return &memcg->css;
 	}
@@ -3802,12 +3810,14 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 
 	page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
+#ifdef CONFIG_MEMCG_V1
 	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
+	mem_cgroup_soft_limit_reset(memcg);
+#endif
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
-	mem_cgroup_soft_limit_reset(memcg);
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	memcg_wb_domain_size_changed(memcg);
 }
@@ -5018,6 +5028,7 @@ void mem_cgroup_sk_free(struct sock *sk)
 bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 			     gfp_t gfp_mask)
 {
+#ifdef CONFIG_MEMCG_V1
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
 		struct page_counter *fail;
 
@@ -5032,6 +5043,7 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 		}
 		return false;
 	}
+#endif
 
 	if (try_charge(memcg, gfp_mask, nr_pages) == 0) {
 		mod_memcg_state(memcg, MEMCG_SOCK, nr_pages);
@@ -5048,11 +5060,12 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
  */
 void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
+#ifdef CONFIG_MEMCG_V1
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
 		page_counter_uncharge(&memcg->tcpmem, nr_pages);
 		return;
 	}
-
+#endif
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
 
 	refill_stock(memcg, nr_pages);
-- 
2.43.2


