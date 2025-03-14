Return-Path: <linux-kernel+bounces-561864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590D6A6179A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69EF8846C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C60020550E;
	Fri, 14 Mar 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xrt+ej9y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A36204F72
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973217; cv=none; b=iPQhZptP9awSUhGV3Z8AUlNjB+ACIOAEIziO4rGpOwVk0Mp1Zuok1dGcS8RPFSizW3A2gAiVl4Fy/GFtgO82sL7/ipI6AvakPMSpm4t7okV8CUbI34lF1HJIsqIxIJ1d0R9UCtiBIYI868qNa+7G+gjgbI9emJtcxov1gLDAT2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973217; c=relaxed/simple;
	bh=bGogLz3N653maS3jZp3WJ6CASqFwglP+GLUbaNFpvAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CoKx9uSEhdx61M1jGyuAzd40uStX6yNuKu68sjeUUXc6ezT5zM4jR6OVglqv3WbTv2IA6B2lwjK13l1x2dNmjfR+Ww+ZkGcM7k2OP1wTskV26cn49fIw4TmrvMjcPHzqHEKwcf/n9Aq5L77d9eXwHR3gmQHirGNICT7FTIHgrMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xrt+ej9y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741973216; x=1773509216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bGogLz3N653maS3jZp3WJ6CASqFwglP+GLUbaNFpvAA=;
  b=Xrt+ej9yyqk5qFUfYZwlCYAsYxaMG7nk+9dOn3LuWZPQlstDxqHREh9K
   XgGB0i0X+kswsoY6Xiok0kAdmu8HL83s9BHa1XO2lIPo2WV4dBG2Rdjde
   9P42viBphR87ySrL2v7GJRV/C96tJ44sSF5aKA74mc5KHAkqskB0lwMI4
   spvdoS2xFhXRubcIF6ZinQI2xDKRKQ1a6qZTzoqcu/E7CXx8RysmSIZXP
   kVMw0aDDj4BrT2epIpOd30sO5JZ+PY2+gmtdJgbZd3tHglShO5+o19ybL
   qaQ7leecD2ce2fkxI3Ir6KnLmwfKKpgIzCOthnO8JjW7E6YSBCWHc7Uij
   Q==;
X-CSE-ConnectionGUID: 1kxr7oHXQj2pjspaA8JNcQ==
X-CSE-MsgGUID: Yo4Z4uvaSn2tPtG9lSuhRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="54516575"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="54516575"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 10:26:50 -0700
X-CSE-ConnectionGUID: tq9Y4l1fQT6Z9yFBuWgI+w==
X-CSE-MsgGUID: 57XbPHdWQ/W9To5dn0GmAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152231815"
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
Subject: [PATCH V10 7/7] perf: Clean up pmu specific data
Date: Fri, 14 Mar 2025 10:27:00 -0700
Message-Id: <20250314172700.438923-7-kan.liang@linux.intel.com>
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

The pmu specific data is saved in task_struct now. Remove it from event
context structure.

Remove swap_task_ctx() as well.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V9

 include/linux/perf_event.h | 12 ------
 kernel/events/core.c       | 76 ++------------------------------------
 2 files changed, 3 insertions(+), 85 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2625e370c334..e694c6f5642f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -501,16 +501,6 @@ struct pmu {
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
@@ -932,7 +922,6 @@ struct perf_event_pmu_context {
 	atomic_t			refcount; /* event <-> epc */
 	struct rcu_head			rcu_head;
 
-	void				*task_ctx_data; /* pmu specific data */
 	/*
 	 * Set when one or more (plausibly active) event can't be scheduled
 	 * due to pmu overcommit or pmu constraints, except tolerant to
@@ -980,7 +969,6 @@ struct perf_event_context {
 	int				nr_user;
 	int				is_active;
 
-	int				nr_task_data;
 	int				nr_stat;
 	int				nr_freq;
 	int				rotate_disable;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index cbaf5420c902..8cf346faae6a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1254,20 +1254,6 @@ static void get_ctx(struct perf_event_context *ctx)
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
@@ -3577,42 +3563,6 @@ static void perf_event_sync_stat(struct perf_event_context *ctx,
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
@@ -3687,16 +3637,15 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
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
@@ -5000,7 +4949,6 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 		     struct perf_event *event)
 {
 	struct perf_event_pmu_context *new = NULL, *pos = NULL, *epc;
-	void *task_ctx_data = NULL;
 
 	if (!ctx->task) {
 		/*
@@ -5033,14 +4981,6 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
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
@@ -5075,14 +5015,7 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
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
@@ -5098,7 +5031,6 @@ static void free_cpc_rcu(struct rcu_head *head)
 	struct perf_cpu_pmu_context *cpc =
 		container_of(head, typeof(*cpc), epc.rcu_head);
 
-	kfree(cpc->epc.task_ctx_data);
 	kfree(cpc);
 }
 
@@ -5106,7 +5038,6 @@ static void free_epc_rcu(struct rcu_head *head)
 {
 	struct perf_event_pmu_context *epc = container_of(head, typeof(*epc), rcu_head);
 
-	kfree(epc->task_ctx_data);
 	kfree(epc);
 }
 
@@ -14088,7 +14019,6 @@ inherit_event(struct perf_event *parent_event,
 	if (is_orphaned_event(parent_event) ||
 	    !atomic_long_inc_not_zero(&parent_event->refcount)) {
 		mutex_unlock(&parent_event->child_mutex);
-		/* task_ctx_data is freed with child_ctx */
 		free_event(child_event);
 		return NULL;
 	}
-- 
2.38.1


