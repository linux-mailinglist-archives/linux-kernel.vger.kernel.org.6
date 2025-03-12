Return-Path: <linux-kernel+bounces-557757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105B3A5DD49
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E0A188C4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402CF2459E1;
	Wed, 12 Mar 2025 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jof1aFQ7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B77243969
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784657; cv=none; b=S6gxfgpFvQjckjSNpZs1WTpUshkO1q2m+iafcdQf1S3ru6FGfpBNfXfhGYgwfPH1TlKd2H9chS3w3F6tT0SKOqbj6oypMYB7alaAyyB2yyN2ajcuJwOITMr2DsSJHL9CTN2Su+GIPst3dadu7h6LzyOWIWX5nkuHLD8tg/mpD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784657; c=relaxed/simple;
	bh=A98vC2GVnKn907YCmx0G6rhjg7TOTYPIbxXarANHRQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJzrCE1hzcgIFKX6PnUD2CP+hFrhKSLGTz6NK/is76MMGTZRgaghCTs1kig6QYExvwcw7lxFeCDgDIceSHCMVTc8lugD31+P8nhbL2I1/ocOFzXMjW3c4SqEuUqoKxjgYF7LL73kQFXr16k4YwJBR45x2IZ2JZCiWdY7tlzk9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jof1aFQ7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741784656; x=1773320656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A98vC2GVnKn907YCmx0G6rhjg7TOTYPIbxXarANHRQ8=;
  b=jof1aFQ7XDoLUt1Zg5WuDmtM4kl3xWjh1Sw4ezG9eCM7zGXC0S4AGSSZ
   PUuO3RhmdipcGpqpAgUpIJJ4nWLRm0UtOjiS2QkxVfuLLFhGmzQCeL22+
   GfEGpSxLpFoymDXM4Kw4BSAgeXRAFW1rovWfyQXww8bULGdZCchJZQGkY
   qdLmo4nCYfZumTDs+mLRaMy5NgKafc5od06aD5KCNkkZvb+QVbvsYXOPN
   8YKa9dlFLQHIDl3DwtCZ4jDhu6sI4E6xrBlhBOo3D74IhtAaxI25NLr7R
   GESVgrgpgmH+LchHoAPRxNbqNS2MpSu0GfkwTGWiSrJwhGO2K/JN5KjAt
   w==;
X-CSE-ConnectionGUID: Js3GKg0+Q1ehgQMKuFy2yA==
X-CSE-MsgGUID: xEbVFfHhRySYeJEHaejVNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="43064995"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="43064995"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 06:04:13 -0700
X-CSE-ConnectionGUID: 21KkRDLTTFaxbh2rjXacmg==
X-CSE-MsgGUID: 6j53t8szQ4Wg/veRvldeDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120650309"
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
Subject: [PATCH V7 5/6] perf/x86: Remove swap_task_ctx()
Date: Wed, 12 Mar 2025 06:04:23 -0700
Message-Id: <20250312130424.3863916-5-kan.liang@linux.intel.com>
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
index 6405df2ee5bf..b0ef07d14c83 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -87,7 +87,6 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_commit_scheduling, *x86_pmu.commit_scheduling);
 DEFINE_STATIC_CALL_NULL(x86_pmu_stop_scheduling,   *x86_pmu.stop_scheduling);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_sched_task,    *x86_pmu.sched_task);
-DEFINE_STATIC_CALL_NULL(x86_pmu_swap_task_ctx, *x86_pmu.swap_task_ctx);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
 DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
@@ -2040,7 +2039,6 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_stop_scheduling, x86_pmu.stop_scheduling);
 
 	static_call_update(x86_pmu_sched_task, x86_pmu.sched_task);
-	static_call_update(x86_pmu_swap_task_ctx, x86_pmu.swap_task_ctx);
 
 	static_call_update(x86_pmu_drain_pebs, x86_pmu.drain_pebs);
 	static_call_update(x86_pmu_pebs_aliases, x86_pmu.pebs_aliases);
@@ -2645,12 +2643,6 @@ static void x86_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
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
@@ -2715,7 +2707,6 @@ static struct pmu pmu = {
 
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
-	.swap_task_ctx		= x86_pmu_swap_task_ctx,
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1aed9a7679d4..c4e0a5cfebbd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5516,12 +5516,6 @@ static void intel_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
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
@@ -5690,7 +5684,6 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
-	.swap_task_ctx		= intel_pmu_swap_task_ctx,
 
 	.check_period		= intel_pmu_check_period,
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 49e77e63c11e..05acd6449ceb 100644
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
index 887f7803dcde..902bc42a6cfe 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -985,14 +985,6 @@ struct x86_pmu {
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
@@ -1704,9 +1696,6 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
 				struct perf_event *event);
 
-void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
-				 struct perf_event_pmu_context *next_epc);
-
 void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
 			      struct task_struct *task, bool sched_in);
 
-- 
2.38.1


