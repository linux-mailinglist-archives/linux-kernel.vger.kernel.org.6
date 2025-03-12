Return-Path: <linux-kernel+bounces-557758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECA8A5DD4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63827A9556
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E112475DD;
	Wed, 12 Mar 2025 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpBaTF40"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A7424293B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784657; cv=none; b=dA1j3fXyjqi0xorz5C8jRZ+4OiYs3o86Tx0XV7qWHCFTxqxW65Y/UxkYqlr5jtYepQV170y0TDmeGa9nZIUchzRqBuXF4LzYIQApBYACnPTnN4Z8dtP7ldzyO92tU8uGqymsofFXgsGdY7tjxug1juVPQ4mM+aVFqdZ3dmB1/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784657; c=relaxed/simple;
	bh=QerLYmY5fda3ml2Ee5yvX/Ow2pwMTsqcHhxbOwfxHYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZHDU714YSVjDrGMDtNvoFva7twW3PYheyq/WVpFNT06QAyqBEtBFFIgnOwMW5colXLWAoqEssjEZw2TWcmRrQYVL3OwmNqytgGI47Ed2vSWN4IPmrR6ML1sbNCffv/Ht/6KNfaL/jL0/wP4bYSwjpHw3nxD3TTa4Ic2MnSTe9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpBaTF40; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741784655; x=1773320655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QerLYmY5fda3ml2Ee5yvX/Ow2pwMTsqcHhxbOwfxHYU=;
  b=kpBaTF40+e5vgs2ieXw6mMM1WCZCGOB5DpsCRaG4mDS0ljr6qB0HFvAv
   TKKeGBR3KQe/fgFRPo0sSKrZnoa8OAm7LsiOgFeEdfdcdDiXXzze6VEJ2
   uL3I119TEzwUNnYH4M0PNW6VjaJ3Pzf+vJ62tA4ScWC5ufnYszRPJH01H
   xTbYxrJmFQHBK0ZjEUhUh7/DuhgipDNVzn2Fql60HUQMLZ8Hi6HAVdQro
   lriflwgp1JM0vh4z1rnMTDrirdcGakfxBYSAC/8fibfDcg6Z5BX31NU31
   vy2E9TuCNDseDsv5B3XOwb/0k7YjVHQAgXvHddBgoCbtNaXM3h5HPD3On
   Q==;
X-CSE-ConnectionGUID: sT/WqVQDTvi9OBo+2Q9ipw==
X-CSE-MsgGUID: wZ4XRivMRkO0P1wult8Rgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="43064988"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="43064988"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 06:04:13 -0700
X-CSE-ConnectionGUID: pvIV/1AJQ/KBnsso8fjAeg==
X-CSE-MsgGUID: 0pmC3RvVSRi94/BDEMQH0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120650307"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 12 Mar 2025 06:04:13 -0700
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
Subject: [PATCH V7 4/6] perf/x86/lbr: Fix shorter LBRs call stacks for the system-wide mode
Date: Wed, 12 Mar 2025 06:04:22 -0700
Message-Id: <20250312130424.3863916-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250312130424.3863916-1-kan.liang@linux.intel.com>
References: <20250312130424.3863916-1-kan.liang@linux.intel.com>
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
index 78cd65bb75d6..49e77e63c11e 100644
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
index 58080995383c..887f7803dcde 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -947,6 +947,7 @@ struct x86_pmu {
 		const int	*lbr_sel_map;	   /* lbr_select mappings */
 		int		*lbr_ctl_map;	   /* LBR_CTL mappings */
 	};
+	u64		lbr_callstack_users;	   /* lbr callstack system wide users */
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
-- 
2.38.1


