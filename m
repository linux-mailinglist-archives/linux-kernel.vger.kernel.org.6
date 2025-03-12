Return-Path: <linux-kernel+bounces-558266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CDCA5E39D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A13BB2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B60258CD9;
	Wed, 12 Mar 2025 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bITHzdxH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709CA257AFA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803920; cv=none; b=HtVaJKwKsfYpAuA5NA2h9BjxSAkYffHRuK59tOg5OsaOmaSbaIhrDSdTKn9VHtf/rnh6iAO7RaZRzfZGDqKORmPWcsASxs856npcM11CyrkK+u5VQZ1xdpzu4OJP5D0xIWk9ZsINg3fMoMjztYu5c449FKUB+dxN2H0H9b8F3BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803920; c=relaxed/simple;
	bh=K8b9jiKOOxsACEIskPQFmzB7NKdnnxdLI84jUrinUe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gwT10pcKZYZIK7xnUhN6zs7WgdsgtXivJ/9jfoNovmlScbF+aDFmF0/IJUiwE3TPYBW1VOAfjHJiFL3v0Iukba4mfCHlLa50SadN1+XM9zp3XUKU3w/z003nItGFO5po8DSypgLh3jedVd2Q0qss+WAf6vuC9M4VdZy+G+WQRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bITHzdxH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741803918; x=1773339918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K8b9jiKOOxsACEIskPQFmzB7NKdnnxdLI84jUrinUe4=;
  b=bITHzdxHgVvdA7MevEe0S74Yx3PXgAn6khrFt3aQIfO8ssc+y02+oWwQ
   QIrtfu7tMiwA3/47IfPi9WlkJZF5IA+f7yRVvGEpTZgNu3OGw4aXOaAQe
   wQPXxsZ6EwNq0EEY59Cblo8zdTj6XctMq87blJESdRvB7uXjZKYxbjJT0
   YLKF5weTs9NF9BOgpvX9ymB7qcvoqK/DE2Kql63O21YYCF+kIRWWHM5Jy
   veRxYXc+CYlch4aW27FbgagyDyzccve3Uu3pqSmmyut/TSg3Sfnfxe5dZ
   ptKPts/7y8kB6v/gOeNtYqZyrdG9qveCiXGZH4oHEFUDiejnkdszYmxqC
   g==;
X-CSE-ConnectionGUID: s8hMf+qpTZy8Y2Az8zz6Yg==
X-CSE-MsgGUID: uStwZJJ5Q2a64JLNy0T7QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42154405"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42154405"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 11:25:13 -0700
X-CSE-ConnectionGUID: j274ONknSKi/Yq7ML1bMFA==
X-CSE-MsgGUID: NNhmdNO0S3a0j+QFE6MCjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125899514"
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
Subject: [PATCH V8 5/6] perf/x86: Remove swap_task_ctx()
Date: Wed, 12 Mar 2025 11:25:24 -0700
Message-Id: <20250312182525.4078433-5-kan.liang@linux.intel.com>
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

The pmu specific data is saved in task_struct now. It doesn't need to
swap between context.

Remove swap_task_ctx() support.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |  9 ---------
 arch/x86/events/intel/core.c |  7 -------
 arch/x86/events/intel/lbr.c  | 23 -----------------------
 arch/x86/events/perf_event.h | 11 -----------
 4 files changed, 50 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ae8c90adca0f..833478ffbbf5 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -87,7 +87,6 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_commit_scheduling, *x86_pmu.commit_scheduling);
 DEFINE_STATIC_CALL_NULL(x86_pmu_stop_scheduling,   *x86_pmu.stop_scheduling);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_sched_task,    *x86_pmu.sched_task);
-DEFINE_STATIC_CALL_NULL(x86_pmu_swap_task_ctx, *x86_pmu.swap_task_ctx);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
 DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
@@ -2039,7 +2038,6 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_stop_scheduling, x86_pmu.stop_scheduling);
 
 	static_call_update(x86_pmu_sched_task, x86_pmu.sched_task);
-	static_call_update(x86_pmu_swap_task_ctx, x86_pmu.swap_task_ctx);
 
 	static_call_update(x86_pmu_drain_pebs, x86_pmu.drain_pebs);
 	static_call_update(x86_pmu_pebs_aliases, x86_pmu.pebs_aliases);
@@ -2644,12 +2642,6 @@ static void x86_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
 	static_call_cond(x86_pmu_sched_task)(pmu_ctx, task, sched_in);
 }
 
-static void x86_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
-				  struct perf_event_pmu_context *next_epc)
-{
-	static_call_cond(x86_pmu_swap_task_ctx)(prev_epc, next_epc);
-}
-
 void perf_check_microcode(void)
 {
 	if (x86_pmu.check_microcode)
@@ -2714,7 +2706,6 @@ static struct pmu pmu = {
 
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
-	.swap_task_ctx		= x86_pmu_swap_task_ctx,
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3efbb03fd77e..dc38dec244c1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5300,12 +5300,6 @@ static void intel_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
 	intel_pmu_lbr_sched_task(pmu_ctx, task, sched_in);
 }
 
-static void intel_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
-				    struct perf_event_pmu_context *next_epc)
-{
-	intel_pmu_lbr_swap_task_ctx(prev_epc, next_epc);
-}
-
 static int intel_pmu_check_period(struct perf_event *event, u64 value)
 {
 	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
@@ -5474,7 +5468,6 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
-	.swap_task_ctx		= intel_pmu_swap_task_ctx,
 
 	.check_period		= intel_pmu_check_period,
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 24719adbcd7e..f44c3d866f24 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -522,29 +522,6 @@ static void __intel_pmu_lbr_save(void *ctx)
 	cpuc->last_log_id = ++task_context_opt(ctx)->log_id;
 }
 
-void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
-				 struct perf_event_pmu_context *next_epc)
-{
-	void *prev_ctx_data, *next_ctx_data;
-
-	swap(prev_epc->task_ctx_data, next_epc->task_ctx_data);
-
-	/*
-	 * Architecture specific synchronization makes sense in case
-	 * both prev_epc->task_ctx_data and next_epc->task_ctx_data
-	 * pointers are allocated.
-	 */
-
-	prev_ctx_data = next_epc->task_ctx_data;
-	next_ctx_data = prev_epc->task_ctx_data;
-
-	if (!prev_ctx_data || !next_ctx_data)
-		return;
-
-	swap(task_context_opt(prev_ctx_data)->lbr_callstack_users,
-	     task_context_opt(next_ctx_data)->lbr_callstack_users);
-}
-
 void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
 			      struct task_struct *task, bool sched_in)
 {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 67d2d250248c..8e5a4c3c5b95 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -958,14 +958,6 @@ struct x86_pmu {
 	 */
 	int		num_topdown_events;
 
-	/*
-	 * perf task context (i.e. struct perf_event_pmu_context::task_ctx_data)
-	 * switch helper to bridge calls from perf/core to perf/x86.
-	 * See struct pmu::swap_task_ctx() usage for examples;
-	 */
-	void		(*swap_task_ctx)(struct perf_event_pmu_context *prev_epc,
-					 struct perf_event_pmu_context *next_epc);
-
 	/*
 	 * AMD bits
 	 */
@@ -1671,9 +1663,6 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
 				struct perf_event *event);
 
-void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
-				 struct perf_event_pmu_context *next_epc);
-
 void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
 			      struct task_struct *task, bool sched_in);
 
-- 
2.38.1


