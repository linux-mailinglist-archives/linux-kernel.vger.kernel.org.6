Return-Path: <linux-kernel+bounces-174104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1DB8C0A40
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3E53B223E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12FF148FF4;
	Thu,  9 May 2024 03:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NEPcHmH2"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115181487EB
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715226148; cv=none; b=INCFDV1wNEGLLL3t1TurdAzaFvmv3WE6xJd0NzhDFQrf4m6C7g0w4pHxo+qpVaLy9dUVayJTQTNy5ZyZ3HduEj52mW1miczI3RQkLomG2Rfkta2IA/1D/drRXu8Uz2BMeyimNSyBvaiBG/KKgIu2h68tlCrVm3CW8ehRy+yDCwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715226148; c=relaxed/simple;
	bh=4ulQN+HvNPj275WmEBxyI3azpUdeKNE29LrUt7rnPL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geISg1YSp7FrXI3zLR9J5pl9Ojx2td0yeikPz1u56YaLRv9HYWw4DjNMBAKtgJDdWoHiWJoM76fn1mRM8i8LVvS088e8QcnQUT6pcklcBrTJqRk6pVsh0z9b5/dXxIxVSEmy63pCHcVEI84cX2BI6DY+FQEXX7/7c2B4u1ljYXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NEPcHmH2; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715226144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9lUdssqcdP+CrtmSgsIzouILJvuOsKGGEAvcTP1mqg=;
	b=NEPcHmH2DSzCrY//6NP0Bi4GvSl4OSSVZtie/gEZgChaQTJBZDgCrJCkjX4BVns83i/UBf
	cxeWGIqyE+J7wItvNZt3VjQy9rWQ2AZ6Nmlmnk2Y6jEvt8wYXfVGgyqFHH/Y4ZTMzhKvyY
	noBAfFs68sT8nTfsE5YLtVRvjiqQWik=
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
Subject: [PATCH rfc 7/9] mm: memcg: put cgroup v1-specific code under a config option
Date: Wed,  8 May 2024 20:41:36 -0700
Message-ID: <20240509034138.2207186-8-roman.gushchin@linux.dev>
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

Put legacy cgroup v1 memory controller code under a new
CONFIG_MEMCG_V1 config option. The option is turned on by default
as of now to keep things backward-compatible. But users who have fully
adopted cgroup v2 and don't use cgroup v1 anymore can turn it off
and benefit from a smaller memory footprint and small CPU wins on
some memcg paths.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 13 ++++++++++---
 init/Kconfig               |  7 +++++++
 mm/Makefile                |  3 ++-
 mm/internal.h              | 24 +++++++++++++++++++++++-
 mm/memcontrol.c            | 10 +++++++---
 5 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fc4aaa73aa5e..d2a4145b1909 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -954,7 +954,14 @@ static inline bool task_in_memcg_oom(struct task_struct *p)
 	return p->memcg_in_oom;
 }
 
+#ifdef CONFIG_MEMCG_V1
 bool mem_cgroup_oom_synchronize(bool wait);
+#else
+static inline bool mem_cgroup_oom_synchronize(bool wait)
+{
+	return false;
+}
+#endif
 struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 					    struct mem_cgroup *oom_domain);
 void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
@@ -1872,7 +1879,7 @@ static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 
 /* Cgroup v1-specific definitions */
 
-#ifdef CONFIG_MEMCG
+#ifdef CONFIG_MEMCG_V1
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
 						unsigned long *total_scanned);
@@ -1895,7 +1902,7 @@ static inline void mem_cgroup_unlock_pages(void)
 {
 	rcu_read_unlock();
 }
-#else /* CONFIG_MEMCG */
+#else /* CONFIG_MEMCG_V1 */
 
 static inline
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
@@ -1924,6 +1931,6 @@ static inline void mem_cgroup_unlock_pages(void)
 {
 	rcu_read_unlock();
 }
-#endif /* CONFIG_MEMCG */
+#endif /* CONFIG_MEMCG_V1 */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/init/Kconfig b/init/Kconfig
index 10d4a638d9ae..ce9b78279627 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -969,6 +969,13 @@ config MEMCG
 	help
 	  Provides control over the memory footprint of tasks in a cgroup.
 
+config MEMCG_V1
+	bool "Legacy memory controller"
+	depends on MEMCG
+	default y
+	help
+	  Legacy cgroup v1 memory controller.
+
 config MEMCG_KMEM
 	bool
 	depends on MEMCG
diff --git a/mm/Makefile b/mm/Makefile
index c717a3ee612e..4e2fe5f6637c 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -96,7 +96,8 @@ obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
-obj-$(CONFIG_MEMCG) += memcontrol.o memcontrol-v1.o vmpressure.o
+obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
+obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
diff --git a/mm/internal.h b/mm/internal.h
index 1b94e2169e19..8c5640ef85f8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1559,7 +1559,6 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 }
 
 void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
-void memcg_oom_recover(struct mem_cgroup *memcg);
 void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
 void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
 
@@ -1589,6 +1588,7 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
 void drain_all_stock(struct mem_cgroup *root_memcg);
 
 /* Memory cgroups v1-specific definitions */
+#ifdef CONFIG_MEMCG_V1
 void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid);
 void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg);
 void mem_cgroup_soft_limit_reset(struct mem_cgroup *memcg);
@@ -1618,9 +1618,31 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
 bool mem_cgroup_v1_oom_prepare(struct mem_cgroup *memcg, gfp_t mask, int order,
 			       bool *locked);
 void mem_cgroup_v1_oom_finish(struct mem_cgroup *memcg, bool *locked);
+void memcg_oom_recover(struct mem_cgroup *memcg);
 void mem_cgroup_v1_offline_memcg(struct mem_cgroup *memcg);
 
 extern struct cftype memsw_files[];
 extern struct cftype mem_cgroup_legacy_files[];
 
+#else /* CONFIG_MEMCG_V1 */
+static inline void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg) {}
+static inline void mem_cgroup_soft_limit_reset(struct mem_cgroup *memcg) {}
+
+static inline bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
+{
+	return false;
+}
+
+static inline void memcg_check_events(struct mem_cgroup *memcg, int nid) {}
+static inline void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s) {}
+static inline bool mem_cgroup_v1_oom_prepare(struct mem_cgroup *memcg, gfp_t mask, int order,
+			       bool *locked)
+{
+	return true;
+}
+static inline void mem_cgroup_v1_oom_finish(struct mem_cgroup *memcg, bool *locked) {}
+static inline void memcg_oom_recover(struct mem_cgroup *memcg) {}
+static inline void mem_cgroup_v1_offline_memcg(struct mem_cgroup *memcg) {}
+#endif /* CONFIG_MEMCG_V1 */
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 805efc98ae12..d5883f748330 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4435,18 +4435,20 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.css_free = mem_cgroup_css_free,
 	.css_reset = mem_cgroup_css_reset,
 	.css_rstat_flush = mem_cgroup_css_rstat_flush,
-	.can_attach = mem_cgroup_can_attach,
 #if defined(CONFIG_LRU_GEN) || defined(CONFIG_MEMCG_KMEM)
 	.attach = mem_cgroup_attach,
 #endif
-	.cancel_attach = mem_cgroup_cancel_attach,
-	.post_attach = mem_cgroup_move_task,
 #ifdef CONFIG_MEMCG_KMEM
 	.fork = mem_cgroup_fork,
 	.exit = mem_cgroup_exit,
 #endif
 	.dfl_cftypes = memory_files,
+#ifdef CONFIG_MEMCG_V1
+	.can_attach = mem_cgroup_can_attach,
+	.cancel_attach = mem_cgroup_cancel_attach,
+	.post_attach = mem_cgroup_move_task,
 	.legacy_cftypes = mem_cgroup_legacy_files,
+#endif
 	.early_init = 0,
 };
 
@@ -5618,7 +5620,9 @@ static int __init mem_cgroup_swap_init(void)
 		return 0;
 
 	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
+#ifdef CONFIG_MEMCG_V1
 	WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
+#endif
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, zswap_files));
 #endif
-- 
2.43.2


