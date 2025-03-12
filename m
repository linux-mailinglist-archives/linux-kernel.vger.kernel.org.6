Return-Path: <linux-kernel+bounces-557759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D5A5DD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB577ABB72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4FA24A051;
	Wed, 12 Mar 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejPSvb35"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E27245027
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784658; cv=none; b=Ei1VByHp5M2yOPl4I+VWsI6CMxQQeAwEpGd+SUSCX0kDY5NO1Xy+Iv4PLduPiPZ6BlkL1DPk8FXQZNdV4rTEHJBZOub0TGqpy8ebVSQZ/wlzx/Km93P6XIfYyVR28NcAEBukjjLwFI25g2Jsq/to7KElicI4387NABNVEdSeJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784658; c=relaxed/simple;
	bh=14xbXGEOiPFBABKnbfo7Lm+i8nGwnBx7gjtsirmkcXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+z+jvUVBB0dBpDK0SAI8lgBU0jJ1ukhzJgTp6MmCKVHZ4smc9JRGh+PsyNI7z/Z09OoYYzOMBv2KurgHhpL1GeE3kBNi3uCxeyXuOnMc44SsxRLi3GNtTE2fJX2Gjhw8/+rqV4V9lEG7vbWXJB1O4gf5aKJRoIdl61qbGBeMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejPSvb35; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741784657; x=1773320657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=14xbXGEOiPFBABKnbfo7Lm+i8nGwnBx7gjtsirmkcXU=;
  b=ejPSvb35/5kRhbCLisQepPqVhCRmHHVHmtui5qJVtlkwtrh1nKY54kd4
   4PASEuOWrbfs/Cu1EPEuvaO+MABB85ERFazWrZ8D9Uimuvm02mKdlgL/a
   rm/ISbliAOSayAy33xrWKK+Vqf4DC6an2SjF+yFJ9whxcUPe1VJCjuXDj
   2uORLVmu1R7SXWBr0ADS1H26k9gaBhsiMxwBUc9JJw1e5K462RUD30PEp
   R79cGmqBjAX3vD29XBzrzcpE/V+HamzXuSLVzvVp/+f1qrVkF3Qm5/YAA
   ccwXISywsfvLfeSNmUeVdEtMEL6uHe6AKl4veVN/chkDBUUvQ03H9MsSt
   w==;
X-CSE-ConnectionGUID: p3h0MMZZTki4ipobXg1sBQ==
X-CSE-MsgGUID: aKdjG7wmQNGTN3d804MGOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="43065002"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="43065002"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 06:04:13 -0700
X-CSE-ConnectionGUID: qN5fY4kTSwuuu2IbfVA4Tw==
X-CSE-MsgGUID: R07d/A6ORau4T8HIj0R+PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120650311"
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
Subject: [PATCH V7 6/6] perf: Clean up pmu specific data
Date: Wed, 12 Mar 2025 06:04:24 -0700
Message-Id: <20250312130424.3863916-6-kan.liang@linux.intel.com>
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

The pmu specific data is saved in task_struct now. Remove it from event
context structure.

Remove swap_task_ctx() as well.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h | 12 ------
 kernel/events/core.c       | 75 ++------------------------------------
 2 files changed, 3 insertions(+), 84 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1bf563df6a2c..5471f23705d5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -504,16 +504,6 @@ struct pmu {
 	 */
 	struct kmem_cache		*task_ctx_cache;
 
-	/*
-	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
-	 * can be synchronized using this function. See Intel LBR callstack support
-	 * implementation and Perf core context switch handling callbacks for usage
-	 * examples.
-	 */
-	void (*swap_task_ctx)		(struct perf_event_pmu_context *prev_epc,
-					 struct perf_event_pmu_context *next_epc);
-					/* optional */
-
 	/*
 	 * Set up pmu-private data structures for an AUX area
 	 */
@@ -933,7 +923,6 @@ struct perf_event_pmu_context {
 	atomic_t			refcount; /* event <-> epc */
 	struct rcu_head			rcu_head;
 
-	void				*task_ctx_data; /* pmu specific data */
 	/*
 	 * Set when one or more (plausibly active) event can't be scheduled
 	 * due to pmu overcommit or pmu constraints, except tolerant to
@@ -981,7 +970,6 @@ struct perf_event_context {
 	int				nr_user;
 	int				is_active;
 
-	int				nr_task_data;
 	int				nr_stat;
 	int				nr_freq;
 	int				rotate_disable;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 60fafc0e1b3a..ce771e4e367e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1203,20 +1203,6 @@ static void get_ctx(struct perf_event_context *ctx)
 	refcount_inc(&ctx->refcount);
 }
 
-static void *alloc_task_ctx_data(struct pmu *pmu)
-{
-	if (pmu->task_ctx_cache)
-		return kmem_cache_zalloc(pmu->task_ctx_cache, GFP_KERNEL);
-
-	return NULL;
-}
-
-static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
-{
-	if (pmu->task_ctx_cache && task_ctx_data)
-		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
-}
-
 static void free_ctx(struct rcu_head *head)
 {
 	struct perf_event_context *ctx;
@@ -3528,42 +3514,6 @@ static void perf_event_sync_stat(struct perf_event_context *ctx,
 	}
 }
 
-#define double_list_for_each_entry(pos1, pos2, head1, head2, member)	\
-	for (pos1 = list_first_entry(head1, typeof(*pos1), member),	\
-	     pos2 = list_first_entry(head2, typeof(*pos2), member);	\
-	     !list_entry_is_head(pos1, head1, member) &&		\
-	     !list_entry_is_head(pos2, head2, member);			\
-	     pos1 = list_next_entry(pos1, member),			\
-	     pos2 = list_next_entry(pos2, member))
-
-static void perf_event_swap_task_ctx_data(struct perf_event_context *prev_ctx,
-					  struct perf_event_context *next_ctx)
-{
-	struct perf_event_pmu_context *prev_epc, *next_epc;
-
-	if (!prev_ctx->nr_task_data)
-		return;
-
-	double_list_for_each_entry(prev_epc, next_epc,
-				   &prev_ctx->pmu_ctx_list, &next_ctx->pmu_ctx_list,
-				   pmu_ctx_entry) {
-
-		if (WARN_ON_ONCE(prev_epc->pmu != next_epc->pmu))
-			continue;
-
-		/*
-		 * PMU specific parts of task perf context can require
-		 * additional synchronization. As an example of such
-		 * synchronization see implementation details of Intel
-		 * LBR call stack data profiling;
-		 */
-		if (prev_epc->pmu->swap_task_ctx)
-			prev_epc->pmu->swap_task_ctx(prev_epc, next_epc);
-		else
-			swap(prev_epc->task_ctx_data, next_epc->task_ctx_data);
-	}
-}
-
 static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
 				   struct task_struct *task, bool sched_in)
 {
@@ -3638,16 +3588,15 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 			WRITE_ONCE(next_ctx->task, task);
 
 			perf_ctx_sched_task_cb(ctx, task, false);
-			perf_event_swap_task_ctx_data(ctx, next_ctx);
 
 			perf_ctx_enable(ctx, false);
 
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
 			 * modified the ctx and the above modification of
-			 * ctx->task and ctx->task_ctx_data are immaterial
-			 * since those values are always verified under
-			 * ctx->lock which we're now holding.
+			 * ctx->task is immaterial since this value is
+			 * always verified under ctx->lock which we're now
+			 * holding.
 			 */
 			RCU_INIT_POINTER(task->perf_event_ctxp, next_ctx);
 			RCU_INIT_POINTER(next->perf_event_ctxp, ctx);
@@ -4952,7 +4901,6 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 		     struct perf_event *event)
 {
 	struct perf_event_pmu_context *new = NULL, *epc;
-	void *task_ctx_data = NULL;
 
 	if (!ctx->task) {
 		/*
@@ -4982,14 +4930,6 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 	if (!new)
 		return ERR_PTR(-ENOMEM);
 
-	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
-		task_ctx_data = alloc_task_ctx_data(pmu);
-		if (!task_ctx_data) {
-			kfree(new);
-			return ERR_PTR(-ENOMEM);
-		}
-	}
-
 	__perf_init_event_pmu_context(new, pmu);
 
 	/*
@@ -5017,14 +4957,7 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 	epc->ctx = ctx;
 
 found_epc:
-	if (task_ctx_data && !epc->task_ctx_data) {
-		epc->task_ctx_data = task_ctx_data;
-		task_ctx_data = NULL;
-		ctx->nr_task_data++;
-	}
 	raw_spin_unlock_irq(&ctx->lock);
-
-	free_task_ctx_data(pmu, task_ctx_data);
 	kfree(new);
 
 	return epc;
@@ -5039,7 +4972,6 @@ static void free_epc_rcu(struct rcu_head *head)
 {
 	struct perf_event_pmu_context *epc = container_of(head, typeof(*epc), rcu_head);
 
-	kfree(epc->task_ctx_data);
 	kfree(epc);
 }
 
@@ -13997,7 +13929,6 @@ inherit_event(struct perf_event *parent_event,
 	if (is_orphaned_event(parent_event) ||
 	    !atomic_long_inc_not_zero(&parent_event->refcount)) {
 		mutex_unlock(&parent_event->child_mutex);
-		/* task_ctx_data is freed with child_ctx */
 		free_event(child_event);
 		return NULL;
 	}
-- 
2.38.1


