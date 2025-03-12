Return-Path: <linux-kernel+bounces-558264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CF1A5E39B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC073BB31C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F10258CCD;
	Wed, 12 Mar 2025 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlAOFzXe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB0257ACA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803919; cv=none; b=JQycqeR3MyKIlUt5AB8iHDCBHocSu2hFKK++f6UByvMCgoh5KLPFDwkKxCH2RBf3+xfjr1eCsXlX5T5D3xijohi9PwsH6FzMjBR4rdjFqLp4Ju5ujqudgpu4XGK3RXzymVJhrESoZU46Gpg8+JD1pCN8fJvyxYg04xpGAzVYDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803919; c=relaxed/simple;
	bh=NCRi29l5smv2jm1vLJgEWwmX+8IEkzTUVoDNYNg6iNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AS0Io6/snhFHAMQIQBa0OdjnB+x2sx2TOOyvCDYnnGsyz/+FBXetjdQNLYFaf9gKrh5+rX+q9g6rKKFSPuRZaxZ60qLPcNfv/6GJqc/AOuP2+89YRZnrUp93ea2zlEHfkaqzqzucPsyGzlWu+mVUd7i12rYMaejH61vk1hifrJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlAOFzXe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741803918; x=1773339918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NCRi29l5smv2jm1vLJgEWwmX+8IEkzTUVoDNYNg6iNc=;
  b=PlAOFzXeaRccTunBbcJlNiZkP8UGbENA7lVSWvrlhgfmIKciQk8fzr7z
   u8w1iaAd7eQOltUJvOmVd7AlwoQSIsWa+Fv37xnC+pKI6chVIu7LVVqwL
   4kwmkg7AbW3C2CFoEZANglP+habQbNIBOke82li1dO3qe6CKmfFE26OM7
   udLMJ+Mea/06Ol/8PJxhHkTDIwEc8xevP8gkZxVH/f2/ghD8vLCMsivSG
   bZcfu4+MFJg2sEMj2/mqKFsOqgvGOYgnRcSTYF6NoEb3fw04aCmw4ng+d
   uNdQJFTcaJZ7XfPQPDDNCVD9nwWoieO6GIXgEzsBTNhDhwc1CHS5Z+hdz
   w==;
X-CSE-ConnectionGUID: rxANsahmSLmwlQXEIjgg4Q==
X-CSE-MsgGUID: +f7ACYdhSG+cRIojYOYrUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42154400"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42154400"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 11:25:13 -0700
X-CSE-ConnectionGUID: 69MCYJHdTW2DBhOaR5XgxA==
X-CSE-MsgGUID: QzCEZaHzTGiP2L5linfNIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125899513"
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
Subject: [PATCH V8 4/6] perf/x86/lbr: Fix shorter LBRs call stacks for the system-wide mode
Date: Wed, 12 Mar 2025 11:25:23 -0700
Message-Id: <20250312182525.4078433-4-kan.liang@linux.intel.com>
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

In the system-wide mode, LBR callstacks are shorter in comparison to
the per-process mode.

LBR MSRs are reset during a context switch in the system-wide mode. For
the LBR call stack, the LBRs should be always saved/restored during a
context switch.

Use the space in task_struct to save/restore the LBR call stack data.

For a system-wide event, it's unnecessagy to update the
lbr_callstack_users for each threads. Add a variable in x86_pmu to
indicate whether the system-wide event is active.

Fixes: 76cb2c617f12 ("perf/x86/intel: Save/restore LBR stack during context switch")
Reported-by: Andi Kleen <ak@linux.intel.com>
Reported-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Debugged-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c  | 47 ++++++++++++++++++++++++++++++------
 arch/x86/events/perf_event.h |  1 +
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index dafeee216f3b..24719adbcd7e 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -422,11 +422,17 @@ static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
 	return !rdlbr_from(((struct x86_perf_task_context *)ctx)->tos, NULL);
 }
 
+static inline bool has_lbr_callstack_users(void *ctx)
+{
+	return task_context_opt(ctx)->lbr_callstack_users ||
+	       x86_pmu.lbr_callstack_users;
+}
+
 static void __intel_pmu_lbr_restore(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (task_context_opt(ctx)->lbr_callstack_users == 0 ||
+	if (!has_lbr_callstack_users(ctx) ||
 	    task_context_opt(ctx)->lbr_stack_state == LBR_NONE) {
 		intel_pmu_lbr_reset();
 		return;
@@ -503,7 +509,7 @@ static void __intel_pmu_lbr_save(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (task_context_opt(ctx)->lbr_callstack_users == 0) {
+	if (!has_lbr_callstack_users(ctx)) {
 		task_context_opt(ctx)->lbr_stack_state = LBR_NONE;
 		return;
 	}
@@ -543,6 +549,7 @@ void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
 			      struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_ctx_data *ctx_data;
 	void *task_ctx;
 
 	if (!cpuc->lbr_users)
@@ -553,14 +560,18 @@ void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
 	 * the task was scheduled out, restore the stack. Otherwise flush
 	 * the LBR stack.
 	 */
-	task_ctx = pmu_ctx ? pmu_ctx->task_ctx_data : NULL;
+	rcu_read_lock();
+	ctx_data = rcu_dereference(task->perf_ctx_data);
+	task_ctx = ctx_data ? ctx_data->data : NULL;
 	if (task_ctx) {
 		if (sched_in)
 			__intel_pmu_lbr_restore(task_ctx);
 		else
 			__intel_pmu_lbr_save(task_ctx);
+		rcu_read_unlock();
 		return;
 	}
+	rcu_read_unlock();
 
 	/*
 	 * Since a context switch can flip the address space and LBR entries
@@ -589,9 +600,19 @@ void intel_pmu_lbr_add(struct perf_event *event)
 
 	cpuc->br_sel = event->hw.branch_reg.reg;
 
-	if (branch_user_callstack(cpuc->br_sel) && event->pmu_ctx->task_ctx_data)
-		task_context_opt(event->pmu_ctx->task_ctx_data)->lbr_callstack_users++;
+	if (branch_user_callstack(cpuc->br_sel)) {
+		if (event->attach_state & PERF_ATTACH_TASK) {
+			struct task_struct *task = event->hw.target;
+			struct perf_ctx_data *ctx_data;
 
+			rcu_read_lock();
+			ctx_data = rcu_dereference(task->perf_ctx_data);
+			if (ctx_data)
+				task_context_opt(ctx_data->data)->lbr_callstack_users++;
+			rcu_read_unlock();
+		} else
+			x86_pmu.lbr_callstack_users++;
+	}
 	/*
 	 * Request pmu::sched_task() callback, which will fire inside the
 	 * regular perf event scheduling, so that call will:
@@ -665,9 +686,19 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	if (!x86_pmu.lbr_nr)
 		return;
 
-	if (branch_user_callstack(cpuc->br_sel) &&
-	    event->pmu_ctx->task_ctx_data)
-		task_context_opt(event->pmu_ctx->task_ctx_data)->lbr_callstack_users--;
+	if (branch_user_callstack(cpuc->br_sel)) {
+		if (event->attach_state & PERF_ATTACH_TASK) {
+			struct task_struct *task = event->hw.target;
+			struct perf_ctx_data *ctx_data;
+
+			rcu_read_lock();
+			ctx_data = rcu_dereference(task->perf_ctx_data);
+			if (ctx_data)
+				task_context_opt(ctx_data->data)->lbr_callstack_users--;
+			rcu_read_unlock();
+		} else
+			x86_pmu.lbr_callstack_users--;
+	}
 
 	if (event->hw.flags & PERF_X86_EVENT_LBR_SELECT)
 		cpuc->lbr_select = 0;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 0d5019fb3ad2..67d2d250248c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -920,6 +920,7 @@ struct x86_pmu {
 		const int	*lbr_sel_map;	   /* lbr_select mappings */
 		int		*lbr_ctl_map;	   /* LBR_CTL mappings */
 	};
+	u64		lbr_callstack_users;	   /* lbr callstack system wide users */
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
-- 
2.38.1


