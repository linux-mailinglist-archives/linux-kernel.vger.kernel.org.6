Return-Path: <linux-kernel+bounces-558263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CEDA5E39A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2AC17B1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F276D2580D1;
	Wed, 12 Mar 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6M611H9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32146256C99
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803918; cv=none; b=uYgaKTvPbMJOG+91BAQMx6MA/Mey2mJ2efMnOLyLGMSBX20CsnAaY1eZZVlS9iaO3e/oT1f2sFgT+IVTMY8f+dSxwleJKQGyDeQA+93dzzN8xSAVC6Wq2XJ2/feWm3cZjWb50c+5IGIwBW7pNn6vmv7Z54zWiU+M7w+ZI2xasQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803918; c=relaxed/simple;
	bh=kL3Ai5qr/WOSLAz9OpKkkbWd1gyAASkFyTeNpCbUHkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6zslsH+qHMCTppHALEAn1/tEv21nwJ5bMewBv6uLMjoXKh7bOxBHA1XgpqDoF43CXZ4ad+OVUsRlWWTKyr0YvKWff6vHWystQIixFUy5lfdYokF00F1A74q2XGGXgTyOFdBpEWRrS4v7ASNO6agg8lUG0OpGMAXMxWMFKDJce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6M611H9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741803916; x=1773339916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kL3Ai5qr/WOSLAz9OpKkkbWd1gyAASkFyTeNpCbUHkk=;
  b=S6M611H9aHUCGVA/twTm/+215fv4nGgyvwUzlsoFUjLyQBrhMWFYlO3y
   sCCII8iGpNQTu/zYSq6Rad7KJrQHvoUiq39oaxYGCAZiMv4U/Dj3FxZfv
   WznD6Cva+yt3KIj+MzUhR/GeILd21oEASTgN6JGo1el2AUR+IFz2oLVMb
   Asb6MC+XcS56IfKHMtjMZKI2YCZxuaMaexL7heuvkG4XF2JYDkfQFr6mT
   dch1E2xgTkSI8DfAlR8SrHmAwqEHqD/dUAynVlDKM6/A72NmG+9Y4U5yu
   E9thLYbMlxgWaHol3+SRrCaE1UhKc0V6g8ViCyVHbxDN8YTgrOdVAw3fW
   g==;
X-CSE-ConnectionGUID: Zmzh8ggpQ8WQoDTzJ3HSHg==
X-CSE-MsgGUID: c26F4INYRCGlKcH3ztlEfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42154394"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42154394"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 11:25:13 -0700
X-CSE-ConnectionGUID: 9wwilqjUQzyJPNn5rFyD5w==
X-CSE-MsgGUID: lc9X/Gm7ThqlgwGNwutY0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125899511"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa005.jf.intel.com with ESMTP; 12 Mar 2025 11:25:13 -0700
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
Subject: [PATCH V8 3/6] perf: Supply task information to sched_task()
Date: Wed, 12 Mar 2025 11:25:22 -0700
Message-Id: <20250312182525.4078433-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250312182525.4078433-1-kan.liang@linux.intel.com>
References: <20250312182525.4078433-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

To save/restore LBR call stack data in system-wide mode, the task_struct
information is required.

Extend the parameters of sched_task() to supply task_struct information.

When schedule in, the LBR call stack data for new task will be restored.
When schedule out, the LBR call stack data for old task will be saved.
Only need to pass the required task_struct information.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/powerpc/perf/core-book3s.c |  8 ++++++--
 arch/x86/events/amd/brs.c       |  3 ++-
 arch/x86/events/amd/lbr.c       |  3 ++-
 arch/x86/events/core.c          |  5 +++--
 arch/x86/events/intel/core.c    |  4 ++--
 arch/x86/events/intel/lbr.c     |  3 ++-
 arch/x86/events/perf_event.h    | 14 +++++++++-----
 include/linux/perf_event.h      |  2 +-
 kernel/events/core.c            | 20 +++++++++++---------
 9 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 2b79171ee185..f4e03aaabb4c 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -132,7 +132,10 @@ static unsigned long ebb_switch_in(bool ebb, struct cpu_hw_events *cpuhw)
 
 static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
 static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
-static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in) {}
+static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+				 struct task_struct *task, bool sched_in)
+{
+}
 static inline void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
 #endif /* CONFIG_PPC32 */
@@ -444,7 +447,8 @@ static void power_pmu_bhrb_disable(struct perf_event *event)
 /* Called from ctxsw to prevent one process's branch entries to
  * mingle with the other process's entries during context switch.
  */
-static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+				 struct task_struct *task, bool sched_in)
 {
 	if (!ppmu->bhrb_nr)
 		return;
diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 780acd3dff22..ec3427463382 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -381,7 +381,8 @@ static void amd_brs_poison_buffer(void)
  * On ctxswin, sched_in = true, called after the PMU has started
  * On ctxswout, sched_in = false, called before the PMU is stopped
  */
-void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			    struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 19c7b76e21bc..c06ccca96851 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -371,7 +371,8 @@ void amd_pmu_lbr_del(struct perf_event *event)
 	perf_sched_cb_dec(event->pmu);
 }
 
-void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			    struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 20ad5cca6ad2..ae8c90adca0f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2638,9 +2638,10 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 	NULL,
 };
 
-static void x86_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static void x86_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			       struct task_struct *task, bool sched_in)
 {
-	static_call_cond(x86_pmu_sched_task)(pmu_ctx, sched_in);
+	static_call_cond(x86_pmu_sched_task)(pmu_ctx, task, sched_in);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5a8d6e1a9334..3efbb03fd77e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5294,10 +5294,10 @@ static void intel_pmu_cpu_dead(int cpu)
 }
 
 static void intel_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
-				 bool sched_in)
+				 struct task_struct *task, bool sched_in)
 {
 	intel_pmu_pebs_sched_task(pmu_ctx, sched_in);
-	intel_pmu_lbr_sched_task(pmu_ctx, sched_in);
+	intel_pmu_lbr_sched_task(pmu_ctx, task, sched_in);
 }
 
 static void intel_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index dc641b50814e..dafeee216f3b 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -539,7 +539,8 @@ void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
 	     task_context_opt(next_ctx_data)->lbr_callstack_users);
 }
 
-void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			      struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	void *task_ctx;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a698e6484b3b..0d5019fb3ad2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -875,7 +875,7 @@ struct x86_pmu {
 
 	void		(*check_microcode)(void);
 	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx,
-				      bool sched_in);
+				      struct task_struct *task, bool sched_in);
 
 	/*
 	 * Intel Arch Perfmon v2+
@@ -1408,7 +1408,8 @@ void amd_pmu_lbr_reset(void);
 void amd_pmu_lbr_read(void);
 void amd_pmu_lbr_add(struct perf_event *event);
 void amd_pmu_lbr_del(struct perf_event *event);
-void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
+void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			    struct task_struct *task, bool sched_in);
 void amd_pmu_lbr_enable_all(void);
 void amd_pmu_lbr_disable_all(void);
 int amd_pmu_lbr_hw_config(struct perf_event *event);
@@ -1462,7 +1463,8 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 	perf_sched_cb_dec(event->pmu);
 }
 
-void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
+void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			    struct task_struct *task, bool sched_in);
 #else
 static inline int amd_brs_init(void)
 {
@@ -1487,7 +1489,8 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 {
 }
 
-static inline void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+static inline void amd_pmu_brs_sched_task(struct perf_event_pmu_context *pmu_ctx,
+					  struct task_struct *task, bool sched_in)
 {
 }
 
@@ -1670,7 +1673,8 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
 				 struct perf_event_pmu_context *next_epc);
 
-void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
+void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			      struct task_struct *task, bool sched_in);
 
 u64 lbr_from_signext_quirk_wr(u64 val);
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index b8442047a2b6..beb6799d80d0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -494,7 +494,7 @@ struct pmu {
 	 * context-switches callback
 	 */
 	void (*sched_task)		(struct perf_event_pmu_context *pmu_ctx,
-					bool sched_in);
+					 struct task_struct *task, bool sched_in);
 
 	/*
 	 * Kmem cache of PMU specific data
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4336cf26fe35..7b31ae194a08 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3613,7 +3613,8 @@ static void perf_event_swap_task_ctx_data(struct perf_event_context *prev_ctx,
 	}
 }
 
-static void perf_ctx_sched_task_cb(struct perf_event_context *ctx, bool sched_in)
+static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
+				   struct task_struct *task, bool sched_in)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 	struct perf_cpu_pmu_context *cpc;
@@ -3622,7 +3623,7 @@ static void perf_ctx_sched_task_cb(struct perf_event_context *ctx, bool sched_in
 		cpc = this_cpc(pmu_ctx->pmu);
 
 		if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
-			pmu_ctx->pmu->sched_task(pmu_ctx, sched_in);
+			pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in);
 	}
 }
 
@@ -3685,7 +3686,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 			WRITE_ONCE(ctx->task, next);
 			WRITE_ONCE(next_ctx->task, task);
 
-			perf_ctx_sched_task_cb(ctx, false);
+			perf_ctx_sched_task_cb(ctx, task, false);
 			perf_event_swap_task_ctx_data(ctx, next_ctx);
 
 			perf_ctx_enable(ctx, false);
@@ -3715,7 +3716,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 		perf_ctx_disable(ctx, false);
 
 inside_switch:
-		perf_ctx_sched_task_cb(ctx, false);
+		perf_ctx_sched_task_cb(ctx, task, false);
 		task_ctx_sched_out(ctx, NULL, EVENT_ALL);
 
 		perf_ctx_enable(ctx, false);
@@ -3757,7 +3758,8 @@ void perf_sched_cb_inc(struct pmu *pmu)
  * PEBS requires this to provide PID/TID information. This requires we flush
  * all queued PEBS records before we context switch to a new task.
  */
-static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc, bool sched_in)
+static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc,
+				  struct task_struct *task, bool sched_in)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct pmu *pmu;
@@ -3771,7 +3773,7 @@ static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc, bool sched_i
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_pmu_disable(pmu);
 
-	pmu->sched_task(cpc->task_epc, sched_in);
+	pmu->sched_task(cpc->task_epc, task, sched_in);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -3789,7 +3791,7 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 		return;
 
 	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
-		__perf_pmu_sched_task(cpc, sched_in);
+		__perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_in);
 }
 
 static void perf_event_switch(struct task_struct *task,
@@ -4083,7 +4085,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 		perf_ctx_lock(cpuctx, ctx);
 		perf_ctx_disable(ctx, false);
 
-		perf_ctx_sched_task_cb(ctx, true);
+		perf_ctx_sched_task_cb(ctx, task, true);
 
 		perf_ctx_enable(ctx, false);
 		perf_ctx_unlock(cpuctx, ctx);
@@ -4114,7 +4116,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 
 	perf_event_sched_in(cpuctx, ctx, NULL);
 
-	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
+	perf_ctx_sched_task_cb(cpuctx->task_ctx, task, true);
 
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
 		perf_ctx_enable(&cpuctx->ctx, false);
-- 
2.38.1


