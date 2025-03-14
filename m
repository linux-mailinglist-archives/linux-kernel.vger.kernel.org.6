Return-Path: <linux-kernel+bounces-560542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E663FA6065B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AC04601FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3256E17555;
	Fri, 14 Mar 2025 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GL72xWLC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5A2E3376
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910557; cv=none; b=ez3RrS86UokNcedkMoKtZMnFMYqK5JuQk1FR0WuEU2oyFgaTvU8uzOs9NdU7T6YRfJQhX2V+m5BrXimpu/Fub82jxKqceoulP93bd6uw6MtrMheqEGRx7vDgVp9r7cL3YA4NPWP05L79BAXAV3fMR/Uk3EyH+o8acN9zIYHEMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910557; c=relaxed/simple;
	bh=l9HIJioIITiva4mQx+eFbIFiRqb73tmzq9czW9lQNm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G+hAYteLsB1ZlGfY/35qXkUeve2dlJ6IhWY5zxzzFxEave8qgPOnmTOtQ8wECEKE9avB95dpysUlgsaG9Z/4NtAVk8qG5fyRlS5+FK9bw/dfnIExFZ7pYhu5dhe3kIla9N90uN5iw9ObrPZbscD6v5R6rGyRA32zPt8aoNPKM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GL72xWLC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741910556; x=1773446556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l9HIJioIITiva4mQx+eFbIFiRqb73tmzq9czW9lQNm0=;
  b=GL72xWLC8ymwlW0UzmdWORf2+U6Q/ha/FOXWDFFun2donJHFuUYt4n5S
   SGGYIRSAV2PBQ7LgoeFgnWCDTEqeyZdzKQuqkHBgeEeIBznmpvaYppaWd
   KXgGlOU+8p2UKlKP4f+88uAN8CVSs0ipKDDRuXWRJBRQWuP3Brd4u3r+p
   NxDW2MnGKBwYr4SW4X/RphaSzNw6FIw7fMoTQAlY0dqRQhps2uRsXl2YN
   HfC9fi/oVudE/1yCkYW8fsXx3p7nU3d3dCzBcdOCpQr8oLgewln2Y3p39
   y/8YNk+WXaaIK4p2FIh0I/3o5K/ftxWCZh9GubemO0xi7VRgCp+aAogPf
   w==;
X-CSE-ConnectionGUID: arBsF+G9TLOslDi4UNiYyg==
X-CSE-MsgGUID: N43GMZ7JRQGv4ieCfQfQ/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43160682"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43160682"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 17:02:32 -0700
X-CSE-ConnectionGUID: BA9j+0KDSe6iA1TWjKr6iw==
X-CSE-MsgGUID: 8KbLIrsYQVu6hNggcFTw/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="125986549"
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
Subject: [PATCH V9 6/7] perf/x86: Remove swap_task_ctx()
Date: Thu, 13 Mar 2025 17:02:41 -0700
Message-Id: <20250314000242.323199-6-kan.liang@linux.intel.com>
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

The pmu specific data is saved in task_struct now. It doesn't need to
swap between context.

Remove swap_task_ctx() support.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V8

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


