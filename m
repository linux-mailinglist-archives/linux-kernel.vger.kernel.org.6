Return-Path: <linux-kernel+bounces-561858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D455A61795
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E9688349A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51372045B0;
	Fri, 14 Mar 2025 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RsFzcmZd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D72045B2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973212; cv=none; b=IW2hctauom+qgFdwU90wLsCCTi6KSHL/9a4liCH2SjqWygvpRGOY3diWMZmRCvc8QXw6hv5vx2YQAyW6dUz2wR4ClYVUUFLnXiorahHH+RpHLr1pu9FP05WdvHAYyobN7sxocdJaqy1oWjkcaOQItf2ia9wVgFjV2l9y35fdIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973212; c=relaxed/simple;
	bh=hRcTGU0P7VTHnvw4bqfx4JjCs9CfnK/EXX45gh1Zv3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f3ssOxhtZraz0NiXaomnkCxwxgUDrmAr20/hPY5t0zqc3RIP7bR4sqCL1tcs8k3TgDOMeYaTReBTA6lMBDyb3b+vjFCBTJSvfHfMIZelcmSrNLQ0HmCrwZCc7KQczZ8wVuYTBGPbGlpqx4KL+SnwUbxnxMxUWGovttjsaS4pNRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RsFzcmZd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741973211; x=1773509211;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hRcTGU0P7VTHnvw4bqfx4JjCs9CfnK/EXX45gh1Zv3k=;
  b=RsFzcmZdp1O1r76Bv4XHZVOT13xCj9JZGJKmIcmUpMeZSh54qohRcFgn
   5ORelT4a4ID8nju9ATaQ3EdLECF81sh8bNLiLyIIwxIFmHVVdY5QJIlaq
   0DipGWUmya4jnlgAeiTLHixZfTKkmYmYb8frGg7Hsl7+p0I1a5fAfyJWe
   4M5ShTk1tMf7MkO2RF0q+K4gphzHXYtHvx8FOgNEsb92WxcTUsNu7gT9u
   /6FAeY3MC9mwJvPIGU6fTgVYZ4xb/mQC6Wu1fTS0AU8WGZiYH1yesUNB2
   /lzE+YpTOxyrruUpgoY2TZuDZErc0iVJuJg51IRZKGlh/X8im3bJeie+Z
   g==;
X-CSE-ConnectionGUID: 2koXrg8mQQmlB0K0tqFsuQ==
X-CSE-MsgGUID: 1mjX0S6vTYavRiKoMAI+Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="54516531"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="54516531"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 10:26:49 -0700
X-CSE-ConnectionGUID: MCE6l09SR6mAVQlYokVHoA==
X-CSE-MsgGUID: ywW1dyFKRMmDe+BntdfNew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152231805"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa002.jf.intel.com with ESMTP; 14 Mar 2025 10:26:48 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V10 1/7] perf: Save PMU specific data in task_struct
Date: Fri, 14 Mar 2025 10:26:54 -0700
Message-Id: <20250314172700.438923-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Some PMU specific data has to be saved/restored during context switch,
e.g. LBR call stack data. Currently, the data is saved in event context
structure, but only for per-process event. For system-wide event,
because of missing the LBR call stack data after context switch, LBR
callstacks are always shorter in comparison to per-process mode.

For example,
  Per-process mode:
  $perf record --call-graph lbr -- taskset -c 0 ./tchain_edit

  -   99.90%    99.86%  tchain_edit  tchain_edit       [.] f3
       99.86% _start
          __libc_start_main
          generic_start_main
          main
          f1
        - f2
             f3

  System-wide mode:
  $perf record --call-graph lbr -a -- taskset -c 0 ./tchain_edit

  -   99.88%    99.82%  tchain_edit  tchain_edit        [.] f3
   - 62.02% main
        f1
        f2
        f3
   - 28.83% f1
      - f2
        f3
   - 28.83% f1
      - f2
           f3
   - 8.88% generic_start_main
        main
        f1
        f2
        f3

It isn't practical to simply allocate the data for system-wide event in
CPU context structure for all tasks. We have no idea which CPU a task
will be scheduled to. The duplicated LBR data has to be maintained on
every CPU context structure. That's a huge waste. Otherwise, the LBR
data still lost if the task is scheduled to another CPU.

Save the pmu specific data in task_struct. The size of pmu specific data
is 788 bytes for LBR call stack. Usually, the overall amount of threads
doesn't exceed a few thousands. For 10K threads, keeping LBR data would
consume additional ~8MB. The additional space will only be allocated
during LBR call stack monitoring. It will be released when the
monitoring is finished.

Furthermore, moving task_ctx_data from perf_event_context to task_struct
can reduce complexity and make things clearer. E.g. perf doesn't need to
swap task_ctx_data on optimized context switch path.
This patch set is just the first step. There could be other
optimization/extension on top of this patch set. E.g. for cgroup
profiling, perf just needs to save/store the LBR call stack information
for tasks in specific cgroup. That could reduce the additional space.
Also, the LBR call stack can be available for software events, or allow
even debugging use cases, like LBRs on crash later.

Because of the alignment requirement of Intel Arch LBR, the Kmem cache
is used to allocate the PMU specific data. It's required when child task
allocates the space. Save it in struct perf_ctx_data.
The refcount in struct perf_ctx_data is used to track the users of pmu
specific data.

Reviewed-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V9

 include/linux/perf_event.h | 35 +++++++++++++++++++++++++++++++++++
 include/linux/sched.h      |  2 ++
 kernel/events/core.c       |  1 +
 3 files changed, 38 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3e270822b915..75d9b1e93f39 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1021,6 +1021,41 @@ struct perf_event_context {
 	local_t				nr_no_switch_fast;
 };
 
+/**
+ * struct perf_ctx_data - PMU specific data for a task
+ * @rcu_head:  To avoid the race on free PMU specific data
+ * @refcount:  To track users
+ * @global:    To track system-wide users
+ * @ctx_cache: Kmem cache of PMU specific data
+ * @data:      PMU specific data
+ *
+ * Currently, the struct is only used in Intel LBR call stack mode to
+ * save/restore the call stack of a task on context switches.
+ *
+ * The rcu_head is used to prevent the race on free the data.
+ * The data only be allocated when Intel LBR call stack mode is enabled.
+ * The data will be freed when the mode is disabled.
+ * The content of the data will only be accessed in context switch, which
+ * should be protected by rcu_read_lock().
+ *
+ * Because of the alignment requirement of Intel Arch LBR, the Kmem cache
+ * is used to allocate the PMU specific data. The ctx_cache is to track
+ * the Kmem cache.
+ *
+ * Careful: Struct perf_ctx_data is added as a pointer in struct task_struct.
+ * When system-wide Intel LBR call stack mode is enabled, a buffer with
+ * constant size will be allocated for each task.
+ * Also, system memory consumption can further grow when the size of
+ * struct perf_ctx_data enlarges.
+ */
+struct perf_ctx_data {
+	struct rcu_head			rcu_head;
+	refcount_t			refcount;
+	int				global;
+	struct kmem_cache		*ctx_cache;
+	void				*data;
+};
+
 struct perf_cpu_pmu_context {
 	struct perf_event_pmu_context	epc;
 	struct perf_event_pmu_context	*task_epc;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d..7e183eeb50ec 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -65,6 +65,7 @@ struct mempolicy;
 struct nameidata;
 struct nsproxy;
 struct perf_event_context;
+struct perf_ctx_data;
 struct pid_namespace;
 struct pipe_inode_info;
 struct rcu_node;
@@ -1311,6 +1312,7 @@ struct task_struct {
 	struct perf_event_context	*perf_event_ctxp;
 	struct mutex			perf_event_mutex;
 	struct list_head		perf_event_list;
+	struct perf_ctx_data __rcu	*perf_ctx_data;
 #endif
 #ifdef CONFIG_DEBUG_PREEMPT
 	unsigned long			preempt_disable_ip;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e7d0b055f96c..2e5f0a204484 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14061,6 +14061,7 @@ int perf_event_init_task(struct task_struct *child, u64 clone_flags)
 	child->perf_event_ctxp = NULL;
 	mutex_init(&child->perf_event_mutex);
 	INIT_LIST_HEAD(&child->perf_event_list);
+	child->perf_ctx_data = NULL;
 
 	ret = perf_event_init_context(child, clone_flags);
 	if (ret) {
-- 
2.38.1


