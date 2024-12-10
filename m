Return-Path: <linux-kernel+bounces-440344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65A69EBBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF6A168B39
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAAD23A571;
	Tue, 10 Dec 2024 21:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KyA4V8al"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171722397A6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866701; cv=none; b=YeOQvwzTQLhh2CWj4sZW/UWU8mI4mpwCaC4P4op7obgeZsUkuobyMHwTNyUvKEXUE+w7pkYqbWJiYWvK11hqbu8StgQpH3cOvYwaEsFFkbNSq1F3wWrt3W6Sn5OsYR3HjunqSd7sQhroOKf23fCtj4t3AA3aCJPdE4DzmXMZyhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866701; c=relaxed/simple;
	bh=hE9bjV2sBCy6yetf6MGYbjGzkjGv3G8CKtCSWbCTqi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwkxV1Gm+9p+m6J5WKCOARIr5VTJEX3WFgW/JQkS9wxJqXx3IrjgFy4GJbIgqBe1LTztmfv2Td+fBlorkmquKig0xOyodgr3jtCVYDFicAhzNdOgDEXeB7rzxeBYto3BCr24WhIEauQamObi8rK9YwX0Pt8YM2FIkvKcum8k9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KyA4V8al; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46741855f9bso31077241cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733866698; x=1734471498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9y/Pmi/E+qcbGw7qvBfkROEFTzGsGqs1ClRtYT08n0=;
        b=KyA4V8alZaa7RNJr2jA/wGP8j99SA+DrnnwcECWJCKDY5NP9otzUyHHCzviejvWLpc
         wn5UeVGRUZ7Ul8d91a/P0yUbtc1C6E3w4PbyxOtIh7PfJKqHRrDguGgl2qB96tVrsWMG
         6MfL5ZOFtV8VKuUgGS1xpiw8Iu4ZCrmdSD05fnEAmpb0yegf78dcvp8bd5tP256Rn2z/
         sMsbaKlPAad6O3DRoLvo18EfvHE+ztICxmnrabP+oogITnUdCTvLC4bzyLC1uA92W8TZ
         Ll07W7MxupuMEIB05qZ6Pf7Z6snDL+QthuzCcx9WYTVsWPvjNZWAr03+4DBxQjsdUTrU
         K54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866698; x=1734471498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9y/Pmi/E+qcbGw7qvBfkROEFTzGsGqs1ClRtYT08n0=;
        b=XeV/r3BffAkEmSL/RdssPIdSmECDGzZ0XixYWmxijAV6ImhtlrWPc2uoKDOSEPrN0c
         V43h1d18SzWaz3anfP39nUiWgz9LuZd23OU+bTZtOB1zz7vXimCb6hw7ddjDaAp6eEvY
         n1c+GmOw4yOegdtwu+R3wSf2FYu08w8fXf1b/bEuLrZAqBSwh7QsG/By6DQNWOXVa4Dp
         aHeR4pOVR5x1H5coDS8ORhwbma4BwhlZPH0DlMXzJaGR7vGFugT6mxDJzXdV3am3r1Co
         DnPM5+l1odjovDs1Aodz7qMSVo/ocPVTF4My/SefJopqhWpm/737PHMeGkhnXpEr5g0u
         UWug==
X-Gm-Message-State: AOJu0Ywn2R6MZiPcVgW6kbFkSAtllJTwIb7jfPOuuxT802oHG/HrJ7FK
	WctgIb8gedmpsQaW4AMLW87ogWvdQxFAltzvmwPapuY2gU0vMJMpIDosEgI4Sf4=
X-Gm-Gg: ASbGncu+r3wrLzNgRuO0eTu0p5N+UD3m4+oQ3+pvS7VfoRzudX9pt+6keZCeKAjKgOp
	lFnH8R3t8OWcXuvBLYoz1u+nVZRSCU/m9cL4iZoqexZg4dBvOsPPUezfC2hgOB9iI0dNmuwftv/
	BKNmtdtFmYaejBPn95gneLjcI3aIh9m0gKFnOTRGfb22+M5eU5CKkmH0SDACCEkih6tuff7NJNR
	zfL0WBPoEbc3GYmUb/HyYNc3F4z9GRdSDTeRBa2m+Vrt/kxp9JJ9H93xQFlcN9Hj7590ZVz3FAf
	EiKVsEdPRyWMDKESlambnYCiMTB2sRpV1pL/xgw=
X-Google-Smtp-Source: AGHT+IFxNZ06/2veak16EjkYa8clNKlgcdi7wLb2OYdhSxCOFJs32hkfuiKlgIR8eXNwOyd59R311Q==
X-Received: by 2002:a05:622a:1815:b0:467:7208:8eeb with SMTP id d75a77b69052e-467893769a8mr9097551cf.37.1733866697811;
        Tue, 10 Dec 2024 13:38:17 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296f61f6sm65978991cf.43.2024.12.10.13.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:38:17 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	kernel-team@meta.com,
	david@redhat.com,
	nphamcs@gmail.com,
	gourry@gourry.net,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	kbusch@meta.com,
	ying.huang@linux.alibaba.com
Subject: [RFC v2 PATCH 5/5] migrate,sysfs: add pagecache promotion
Date: Tue, 10 Dec 2024 16:37:44 -0500
Message-ID: <20241210213744.2968-6-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210213744.2968-1-gourry@gourry.net>
References: <20241210213744.2968-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adds /sys/kernel/mm/numa/pagecache_promotion_enabled

When page cache lands on lower tiers, there is no way for promotion
to occur unless it becomes memory-mapped and exposed to NUMA hint
faults.  Just adding a mechanism to promote pages unconditionally,
however, opens up significant possibility of performance regressions.

Similar to the `demotion_enabled` sysfs entry, provide a sysfs toggle
to enable and disable page cache promotion.  This option will enable
opportunistic promotion of unmapped page cache during syscall access.

This option is intended for operational conditions where demoted page
cache will eventually contain memory which becomes hot - and where
said memory likely to cause performance issues due to being trapped on
the lower tier of memory.

A Page Cache folio is considered a promotion candidates when:
  0) tiering and pagecache-promotion are enabled
  1) the folio reside on a node not in the top tier
  2) the folio is already marked referenced and active.
  3) Multiple accesses in (referenced & active) state occur quickly.

Since promotion is not safe to execute unconditionally from within
folio_mark_accessed, we defer promotion to a new task_work captured
in the task_struct.  This ensures that the task doing the access has
some hand in promoting pages - even among deduplicated read only files.

We use numa_hint_fault_latency to help identify when a folio is accessed
multiple times in a short period.  Along with folio flag checks, this
helps us minimize promoting pages on the first few accesses.

The promotion node is always the local node of the promoting cpu.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../ABI/testing/sysfs-kernel-mm-numa          | 20 +++++++
 include/linux/memory-tiers.h                  |  2 +
 include/linux/migrate.h                       |  2 +
 include/linux/sched.h                         |  3 +
 include/linux/sched/numa_balancing.h          |  5 ++
 init/init_task.c                              |  1 +
 kernel/sched/fair.c                           | 26 +++++++-
 mm/memory-tiers.c                             | 27 +++++++++
 mm/migrate.c                                  | 59 +++++++++++++++++++
 mm/swap.c                                     |  3 +
 10 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
index 77e559d4ed80..b846e7d80cba 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-numa
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-numa
@@ -22,3 +22,23 @@ Description:	Enable/disable demoting pages during reclaim
 		the guarantees of cpusets.  This should not be enabled
 		on systems which need strict cpuset location
 		guarantees.
+
+What:		/sys/kernel/mm/numa/pagecache_promotion_enabled
+Date:		November 2024
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Enable/disable promoting pages during file access
+
+		Page migration during file access is intended for systems
+		with tiered memory configurations that have significant
+		unmapped file cache usage. By default, file cache memory
+		on slower tiers will not be opportunistically promoted by
+		normal NUMA hint faults, because the system has no way to
+		track them.  This option enables opportunistic promotion
+		of pages that are accessed via syscall (e.g. read/write)
+		if multiple accesses occur in quick succession.
+
+		It may move data to a NUMA node that does not fall into
+		the cpuset of the allocating process which might be
+		construed to violate the guarantees of cpusets.  This
+		should not be enabled on systems which need strict cpuset
+		location guarantees.
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 0dc0cf2863e2..fa96a67b8996 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -37,6 +37,7 @@ struct access_coordinate;
 
 #ifdef CONFIG_NUMA
 extern bool numa_demotion_enabled;
+extern bool numa_pagecache_promotion_enabled;
 extern struct memory_dev_type *default_dram_type;
 extern nodemask_t default_dram_nodes;
 struct memory_dev_type *alloc_memory_type(int adistance);
@@ -76,6 +77,7 @@ static inline bool node_is_toptier(int node)
 #else
 
 #define numa_demotion_enabled	false
+#define numa_pagecache_promotion_enabled	false
 #define default_dram_type	NULL
 #define default_dram_nodes	NODE_MASK_NONE
 /*
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 29919faea2f1..cf58a97d4216 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -145,6 +145,7 @@ const struct movable_operations *page_movable_ops(struct page *page)
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
 int migrate_misplaced_folio(struct folio *folio, int node);
+void promotion_candidate(struct folio *folio);
 #else
 static inline int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node)
@@ -155,6 +156,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
 {
 	return -EAGAIN; /* can't migrate now */
 }
+static inline void promotion_candidate(struct folio *folio) { }
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_MIGRATION
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d380bffee2ef..faa84fb7a756 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1356,6 +1356,9 @@ struct task_struct {
 	unsigned long			numa_faults_locality[3];
 
 	unsigned long			numa_pages_migrated;
+
+	struct callback_head		numa_promo_work;
+	struct list_head		promo_list;
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_RSEQ
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 52b22c5c396d..cc7750d754ff 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -32,6 +32,7 @@ extern void set_numabalancing_state(bool enabled);
 extern void task_numa_free(struct task_struct *p, bool final);
 bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 				int src_nid, int dst_cpu);
+int numa_hint_fault_latency(struct folio *folio);
 #else
 static inline void task_numa_fault(int last_node, int node, int pages,
 				   int flags)
@@ -52,6 +53,10 @@ static inline bool should_numa_migrate_memory(struct task_struct *p,
 {
 	return true;
 }
+static inline int numa_hint_fault_latency(struct folio *folio)
+{
+	return 0;
+}
 #endif
 
 #endif /* _LINUX_SCHED_NUMA_BALANCING_H */
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..f831980748c4 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -187,6 +187,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.numa_preferred_nid = NUMA_NO_NODE,
 	.numa_group	= NULL,
 	.numa_faults	= NULL,
+	.promo_list	= LIST_HEAD_INIT(init_task.promo_list),
 #endif
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	.kasan_depth	= 1,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a59ae2e23daf..047f02091773 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -42,6 +42,7 @@
 #include <linux/interrupt.h>
 #include <linux/memory-tiers.h>
 #include <linux/mempolicy.h>
+#include <linux/migrate.h>
 #include <linux/mutex_api.h>
 #include <linux/profile.h>
 #include <linux/psi.h>
@@ -1842,7 +1843,7 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
  * The smaller the hint page fault latency, the higher the possibility
  * for the page to be hot.
  */
-static int numa_hint_fault_latency(struct folio *folio)
+int numa_hint_fault_latency(struct folio *folio)
 {
 	int last_time, time;
 
@@ -3534,6 +3535,27 @@ static void task_numa_work(struct callback_head *work)
 	}
 }
 
+static void task_numa_promotion_work(struct callback_head *work)
+{
+	struct task_struct *p = current;
+	struct list_head *promo_list = &p->promo_list;
+	struct folio *folio, *tmp;
+	int nid = numa_node_id();
+
+	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_promo_work));
+
+	work->next = work;
+
+	if (list_empty(promo_list))
+		return;
+
+	list_for_each_entry_safe(folio, tmp, promo_list, lru) {
+		list_del_init(&folio->lru);
+		migrate_misplaced_folio(folio, nid);
+	}
+}
+
+
 void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 {
 	int mm_users = 0;
@@ -3558,8 +3580,10 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	RCU_INIT_POINTER(p->numa_group, NULL);
 	p->last_task_numa_placement	= 0;
 	p->last_sum_exec_runtime	= 0;
+	INIT_LIST_HEAD(&p->promo_list);
 
 	init_task_work(&p->numa_work, task_numa_work);
+	init_task_work(&p->numa_promo_work, task_numa_promotion_work);
 
 	/* New address space, reset the preferred nid */
 	if (!(clone_flags & CLONE_VM)) {
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index fc14fe53e9b7..4c44598e485e 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -935,6 +935,7 @@ static int __init memory_tier_init(void)
 subsys_initcall(memory_tier_init);
 
 bool numa_demotion_enabled = false;
+bool numa_pagecache_promotion_enabled;
 
 #ifdef CONFIG_MIGRATION
 #ifdef CONFIG_SYSFS
@@ -957,11 +958,37 @@ static ssize_t demotion_enabled_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t pagecache_promotion_enabled_show(struct kobject *kobj,
+						struct kobj_attribute *attr,
+						char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  numa_pagecache_promotion_enabled ? "true" : "false");
+}
+
+static ssize_t pagecache_promotion_enabled_store(struct kobject *kobj,
+						 struct kobj_attribute *attr,
+						 const char *buf, size_t count)
+{
+	ssize_t ret;
+
+	ret = kstrtobool(buf, &numa_pagecache_promotion_enabled);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+
 static struct kobj_attribute numa_demotion_enabled_attr =
 	__ATTR_RW(demotion_enabled);
 
+static struct kobj_attribute numa_pagecache_promotion_enabled_attr =
+	__ATTR_RW(pagecache_promotion_enabled);
+
 static struct attribute *numa_attrs[] = {
 	&numa_demotion_enabled_attr.attr,
+	&numa_pagecache_promotion_enabled_attr.attr,
 	NULL,
 };
 
diff --git a/mm/migrate.c b/mm/migrate.c
index af07b399060b..320258a1aaba 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -44,6 +44,8 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 #include <linux/pagewalk.h>
+#include <linux/sched/numa_balancing.h>
+#include <linux/task_work.h>
 
 #include <asm/tlbflush.h>
 
@@ -2710,5 +2712,62 @@ int migrate_misplaced_folio(struct folio *folio, int node)
 	BUG_ON(!list_empty(&migratepages));
 	return nr_remaining ? -EAGAIN : 0;
 }
+
+/**
+ * promotion_candidate() - report a promotion candidate folio
+ *
+ * @folio: The folio reported as a candidate
+ *
+ * Records folio access time and places the folio on the task promotion list
+ * if access time is less than the threshold. The folio will be isolated from
+ * LRU if selected, and task_work will putback the folio on promotion failure.
+ *
+ * If selected, takes a folio reference to be released in task work.
+ */
+void promotion_candidate(struct folio *folio)
+{
+	struct task_struct *task = current;
+	struct list_head *promo_list = &task->promo_list;
+	struct callback_head *work = &task->numa_promo_work;
+	struct address_space *mapping = folio_mapping(folio);
+	bool write = mapping ? mapping->gfp_mask & __GFP_WRITE : false;
+	int nid = folio_nid(folio);
+	int flags, last_cpupid;
+
+	/*
+	 * Only do this work if:
+	 *     1) tiering and pagecache promotion are enabled
+	 *     2) the page can actually be promoted
+	 *     3) The hint-fault latency is relatively hot
+	 *     4) the folio is not already isolated
+	 *     5) This is not a kernel thread context
+	 */
+	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
+	    !numa_pagecache_promotion_enabled ||
+	    node_is_toptier(nid) ||
+	    numa_hint_fault_latency(folio) >= PAGE_ACCESS_TIME_MASK ||
+	    folio_test_isolated(folio) ||
+	    (current->flags & PF_KTHREAD)) {
+		return;
+	}
+
+	nid = numa_migrate_check(folio, NULL, 0, &flags, write, &last_cpupid);
+	if (nid == NUMA_NO_NODE)
+		return;
+
+	if (migrate_misplaced_folio_prepare(folio, NULL, nid))
+		return;
+
+	/*
+	 * Ensure task can schedule work, otherwise we'll leak folios.
+	 * If the list is not empty, task work has already been scheduled.
+	 */
+	if (list_empty(promo_list) && task_work_add(task, work, TWA_RESUME)) {
+		folio_putback_lru(folio);
+		return;
+	}
+	list_add(&folio->lru, promo_list);
+}
+EXPORT_SYMBOL(promotion_candidate);
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_NUMA */
diff --git a/mm/swap.c b/mm/swap.c
index 320b959b74c6..57909c349388 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -37,6 +37,7 @@
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/migrate.h>
 
 #include "internal.h"
 
@@ -469,6 +470,8 @@ void folio_mark_accessed(struct folio *folio)
 			__lru_cache_activate_folio(folio);
 		folio_clear_referenced(folio);
 		workingset_activation(folio);
+	} else {
+		promotion_candidate(folio);
 	}
 	if (folio_test_idle(folio))
 		folio_clear_idle(folio);
-- 
2.43.0


