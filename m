Return-Path: <linux-kernel+bounces-560541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAF8A6065A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788024601CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1416C15E8B;
	Fri, 14 Mar 2025 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MyCaOkpS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1404746E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910557; cv=none; b=HuvYWKbh+sfTlzvvz1wTkiwCLxpIiLDNRnZlaEWGC5/6ZxjWjx1y0v9Hl5kg4PVMuDYYxnPUbTnkjpq+KrjDF55nOKrrSihQd9g+RaUy6Cz/X07QU3ElOv1kKYDOA4FckrBbyAt5TD2UqlUZcqmCZuaIep6oBmOnxc0cHpuvzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910557; c=relaxed/simple;
	bh=goHNle4+546ZOm9GO81OGyF35zDJl1+XxodkIbKAjxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmAdCuQyJ8aod2rMRNrZhXqdAujG895Di520+pyt4wYzhDClcvCAo8GXGUZyfkHplOeMSBz91WYjxUjPBaXzrX4ESnrkuZNCJVEBty806fF0w7AKkhZlTXDkIq+ZXLjMWtuAuFOTVpHDbuLuMHD7TqTi7fW1FjUnHYyauPOntGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MyCaOkpS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741910556; x=1773446556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=goHNle4+546ZOm9GO81OGyF35zDJl1+XxodkIbKAjxI=;
  b=MyCaOkpSDhEeoN50qUUlC7xQ4k/xSwAi5ohee4Bpj/fmLgOKVAtbbhYJ
   rG5Qz86wCFPk89g0xCApHyLOygcUMnldfekWo4zrgQqZWu9m4NIvopMwC
   oCsiqEQZsZwrMXpB3njuYnCTXmia0ub0liOkjoTjpGVWPsMDz6yU8dJa/
   fK3atEAJ/sZ6eTHWw9PECTsRngqG67kQVtxllJiAddxF63I0R5kUpwqn4
   Dm5qS5rkI4rT2Yom7cFulCuUoFqvlqmhjTBineltyQFVNGCcGiJxefam/
   y1RHzwW20Wtir5L2zne/CiBvJpRJT+W8v7K+PkSjO3v43SzDSQZmE10r+
   Q==;
X-CSE-ConnectionGUID: Wp0sczvJQpWiYrmRCza2Iw==
X-CSE-MsgGUID: 0R7cB70CS4G1vsUBzgRr8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43160676"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43160676"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 17:02:32 -0700
X-CSE-ConnectionGUID: W8KB3E7ORpS0MUMPLFW3mw==
X-CSE-MsgGUID: EC6iguR6QT66S0jz9BZ0Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="125986548"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 13 Mar 2025 17:02:31 -0700
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
Subject: [PATCH V9 5/7] perf/x86/lbr: Fix shorter LBRs call stacks for the system-wide mode
Date: Thu, 13 Mar 2025 17:02:40 -0700
Message-Id: <20250314000242.323199-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250314000242.323199-1-kan.liang@linux.intel.com>
References: <20250314000242.323199-1-kan.liang@linux.intel.com>
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

No changes since v8

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


