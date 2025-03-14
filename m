Return-Path: <linux-kernel+bounces-561861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 403AEA61797
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1420919C6A45
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DD3204F67;
	Fri, 14 Mar 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hu2k3Zx4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8AA204C0A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973214; cv=none; b=ERWq6Xq5y/rFadidK6d5wktO5NVrQrqJsFqU4/c/TDSs7kTDvxOk1wre5hBkLISPXxTEEZxe0obj0+W9zscmWC3hFhj+n/urMKijTEAAOjFRiKpSBOfgiZZIQ3B2TSJuL/QnoZuGSc+z/nErB+6+df8NOzAwLvtLA98eOvQWuu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973214; c=relaxed/simple;
	bh=ka3ZMfgzNN3m7+NtEG/qT5CLgpmCII9Sd9zPzLYf3/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+mp99wlXi1TbGlHF0W3upLsBiqRcg/BFFkFocdLXP4izgyt7ROPQ1MZ8/Uj8sjtG6cepBHIK4cCeZncphCG0xhLMbQCLBlf/yB0XOFlW/a3Uxs/qbcYGr8cIRofY+x75HcgWVk2+cRuq1JT9DRgk8oYGyXZAmUDXQYJ2SD62HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hu2k3Zx4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741973213; x=1773509213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ka3ZMfgzNN3m7+NtEG/qT5CLgpmCII9Sd9zPzLYf3/8=;
  b=Hu2k3Zx4pmEhtknLgfAbyqxohog80zgLhP2ypcpttjfdad3/QNsg0Eih
   1DD5NNTeOuclZbMwOs1FsRIPVmtQTY7LqGmzEIDn7uB+VGQ8nGfMn3PJm
   /27UoeSy2oZL5aa2DV+xSJ9s83Dcjyd44YlLwCh2G/e9dQ0m0ZBx35PaD
   Fkl4jbpAVe7bwGkhg8it2qPjh7zmEjuuUF+wFAuUiL1R0qysp6GQ6q4o6
   9EIAOAcV972wEMedV3C+mneGx0a1d+WVJM0VrU3gMBaIW1K/VSKCi6b3+
   fotIFk8ErY4WKVq8rblD7wXkRcLvNwVUWRfsCEUqYA5iQ5NZ6kP/d7TUX
   Q==;
X-CSE-ConnectionGUID: oPVKKI3/SgachNJ1YjCeTw==
X-CSE-MsgGUID: Cb6bmZd/RTyaRCrNUor2nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="54516568"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="54516568"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 10:26:50 -0700
X-CSE-ConnectionGUID: WLsfiio/RP2uxPQngZuiKw==
X-CSE-MsgGUID: 6Dgmtg2MQq2wfPKmf1zE0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152231813"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa002.jf.intel.com with ESMTP; 14 Mar 2025 10:26:49 -0700
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
Subject: [PATCH V10 6/7] perf/x86: Remove swap_task_ctx()
Date: Fri, 14 Mar 2025 10:26:59 -0700
Message-Id: <20250314172700.438923-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250314172700.438923-1-kan.liang@linux.intel.com>
References: <20250314172700.438923-1-kan.liang@linux.intel.com>
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

No changes since V9

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


