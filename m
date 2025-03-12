Return-Path: <linux-kernel+bounces-557754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AECA5DD46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500C91749DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4067624338F;
	Wed, 12 Mar 2025 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1gWPAEU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD61DB124
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784654; cv=none; b=R0fDlXouVLGQvG9sU8n/2nlYBCZfmrEYxsYdUhmYvj3nSQCzUUxD/waXpmZNzKXgcrDKr635/7sA198fbVQNHhtoPtUNxmx+lXuRTmPD8l9DgjYbgrUYblr9d+yHP2wyuQiHyiKZhV8HWltLCIVMPC9JXKO1/EkX74d63YHTuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784654; c=relaxed/simple;
	bh=3ckZCms7g5uoa4rDgcrmn2/2obc3LRGKHvwWZA01fBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bpsMe75gojtNLmWKsEGa1cndpJYGj68oSmEvdnpT84SIhoZuLt9RpuZ4Exu4/VTNJyyshZusXa2q0WKj1NOKC3lxKFbd1ZS2TH5dOUi3YZs3Orkzlvpe2AaeNAgKIv099XuUyBejCDeajjQJnJSDDjPw2GFg3/2rIzLHNYiG8R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1gWPAEU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741784652; x=1773320652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3ckZCms7g5uoa4rDgcrmn2/2obc3LRGKHvwWZA01fBw=;
  b=B1gWPAEUCHiQYZpb9dOt/7yH4e7xc+mj+9sa8ij918/wm+mwDDXu//uY
   6Yd8pD5eRM2A56bhO946RE8FrtQn9NZ1jZPri42I+KxCMQwI89NFdzZhc
   DCLRUf+QInYtVxCEWHBk7ucL8cAmMzfCP1H4xT0ilmPb6JYb2yoZTdJ9M
   iMrH/qDj4ZlxGeA/IL2s0HYq+5NZBpkFy1lnKpbcQp7p1/2HjS6lDTdxR
   GTnFbvGrwa+scFeHvgATbF1U14lRj9sCa5/jGKJExPVaT7uMqFY0xpFEx
   ePrJSrxuOf32CrWo+lJdu/SW4EyDoS05Rxc4rA6M1vWvurNVH1XCPXvXU
   A==;
X-CSE-ConnectionGUID: 0CoIk7zFTAKnaqNZfMNugw==
X-CSE-MsgGUID: 73Oqnjh2SAyblGdc2/PhhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="43064966"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="43064966"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 06:04:12 -0700
X-CSE-ConnectionGUID: j4fxF2PJR0GoGYkR3k7fYg==
X-CSE-MsgGUID: ekGErb+3SEyIjaGqAuvV3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120650302"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 12 Mar 2025 06:04:12 -0700
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
Subject: [PATCH V7 1/6] perf: Save PMU specific data in task_struct
Date: Wed, 12 Mar 2025 06:04:19 -0700
Message-Id: <20250312130424.3863916-1-kan.liang@linux.intel.com>
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

The Kmem cache of pmu specific data is saved in struct perf_ctx_data.
It's required when child task allocates the space.
The refcount in struct perf_ctx_data is used to track the users of pmu
specific data.

Reviewed-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The whole patch set was posted several years ago. But it's buried in the
LKML without merging. I've received several requests recently to fix the
LBR issue with system-wide events. Rebase and repost it.

- Rebase on top of Peter's perf/core branch.

The V6 can be found here. 
https://lore.kernel.org/lkml/1626788420-121610-1-git-send-email-kan.liang@linux.intel.com/

 include/linux/perf_event.h | 30 ++++++++++++++++++++++++++++++
 include/linux/sched.h      |  2 ++
 kernel/events/core.c       |  1 +
 3 files changed, 33 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index bca1dfd30276..6e856bed98a8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1022,6 +1022,36 @@ struct perf_event_context {
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
+ * The data only be allocated when Intel LBR call stack mode is enabled.
+ * The data will be freed when the mode is disabled. The rcu_head is
+ * used to prevent the race on free the data.
+ * The content of the data will only be accessed in context switch, which
+ * should be protected by rcu_read_lock().
+ *
+ * Careful: Struct perf_ctx_data is added as a pointor in struct task_struct.
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
index 038bb4ce5ccb..ffa5d848890e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13969,6 +13969,7 @@ int perf_event_init_task(struct task_struct *child, u64 clone_flags)
 	child->perf_event_ctxp = NULL;
 	mutex_init(&child->perf_event_mutex);
 	INIT_LIST_HEAD(&child->perf_event_list);
+	child->perf_ctx_data = NULL;
 
 	ret = perf_event_init_context(child, clone_flags);
 	if (ret) {
-- 
2.38.1


