Return-Path: <linux-kernel+bounces-551855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B04A57225
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49031881162
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA4D2561CD;
	Fri,  7 Mar 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="khASgWTJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE81183CB0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376301; cv=none; b=ltOYT7M12ukSZHnoFrhFs6TDg1Tf/a3S4W6PaMyvT6bWGvBONTwtTsKjsfFO06KQ/wq4p/tDpUAom9zPwYBQvmj4jxlGy3yLT7Z4ilU4EEOTLDa0KCJFCYa2ShjdUcrGKK2eMZF57xsa1iD5ndnSR64X6jI6KnmMNRurtXs08j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376301; c=relaxed/simple;
	bh=lsgvCLPhKx3wqpaGv5bL+h/ym4bF5M8XOSzqFs7GOgg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HNc9jPTtSThbamofFkjfarp7XRVGX2/eUqT1D7gsGJl9B9Wd4vusLgrMm2ezBrI+T62c7n5X7eTIMvMFONImdebFAVb5mRf1L7wYOmUihf5dAMtLAYO2EhAhjo6MT7CxFDWl3D8t87NjB8vIR1+wzzulzjvX46RMvIZlOMePhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=khASgWTJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Gx3DrT3i4RY+wSttB1b6LIWTxgvuxu14FZqcRmFdk9U=; b=khASgWTJeigzTU9xGlaD+IwFjB
	FuEOHBLbL8WUNPQMHPG19cQ6mk7Eb2Xym7SMigadVXYSu4y/lcNfxllnyvdLzvaUG4jlTowqflwdB
	69BPCmui5wzvpGxiTOiFo+PCIIbbDNueD3qn+tHIQheY5fTOaYLWF8RVGiWvfK21tqbBaaWWyNPoJ
	O3bWAYa4HrkeNsDp/90ldU4xK/feeDHRbUg8r5FpaFUpiitIg7UlI2dBqx5WHAHYVAXvYUqD/Wf5I
	yD5Ic4nhSUtFvL6TjtCI+cWKXyvkdAYGqooDpAAC8KdKKS4Ahu836VzRZV4ycLtlaShYHfohr9U4F
	gHyR5+ow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tqdWQ-00000001PmO-18XV;
	Fri, 07 Mar 2025 19:38:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 1CD6230114C; Fri,  7 Mar 2025 20:38:13 +0100 (CET)
Message-ID: <20250307193723.417881572@infradead.org>
User-Agent: quilt/0.66
Date: Fri, 07 Mar 2025 20:33:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 ravi.bangoria@amd.com,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH v3 6/7] perf: Rename perf_event_exit_task(.child)
References: <20250307193305.486326750@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The task passed to perf_event_exit_task() is not a child, it is
current. Fix this confusing naming, since much of the rest of the code
also relies on it being current.

Specifically, both exec() and exit() callers use it with current as
the argument.

Notably, task_ctx_sched_out() doesn't make much sense outside of
current.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   60 ++++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13488,15 +13488,15 @@ perf_event_exit_event(struct perf_event
 	perf_event_wakeup(event);
 }
 
-static void perf_event_exit_task_context(struct task_struct *child, bool exit)
+static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 {
-	struct perf_event_context *child_ctx, *clone_ctx = NULL;
+	struct perf_event_context *ctx, *clone_ctx = NULL;
 	struct perf_event *child_event, *next;
 
-	WARN_ON_ONCE(child != current);
+	WARN_ON_ONCE(task != current);
 
-	child_ctx = perf_pin_task_context(child);
-	if (!child_ctx)
+	ctx = perf_pin_task_context(task);
+	if (!ctx)
 		return;
 
 	/*
@@ -13509,27 +13509,27 @@ static void perf_event_exit_task_context
 	 * without ctx::mutex (it cannot because of the move_group double mutex
 	 * lock thing). See the comments in perf_install_in_context().
 	 */
-	mutex_lock(&child_ctx->mutex);
+	mutex_lock(&ctx->mutex);
 
 	/*
 	 * In a single ctx::lock section, de-schedule the events and detach the
 	 * context from the task such that we cannot ever get it scheduled back
 	 * in.
 	 */
-	raw_spin_lock_irq(&child_ctx->lock);
-	task_ctx_sched_out(child_ctx, NULL, EVENT_ALL);
+	raw_spin_lock_irq(&ctx->lock);
+	task_ctx_sched_out(ctx, NULL, EVENT_ALL);
 
 	/*
 	 * Now that the context is inactive, destroy the task <-> ctx relation
 	 * and mark the context dead.
 	 */
-	RCU_INIT_POINTER(child->perf_event_ctxp, NULL);
-	put_ctx(child_ctx); /* cannot be last */
-	WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
+	RCU_INIT_POINTER(task->perf_event_ctxp, NULL);
+	put_ctx(ctx); /* cannot be last */
+	WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
 	put_task_struct(current); /* cannot be last */
 
-	clone_ctx = unclone_ctx(child_ctx);
-	raw_spin_unlock_irq(&child_ctx->lock);
+	clone_ctx = unclone_ctx(ctx);
+	raw_spin_unlock_irq(&ctx->lock);
 
 	if (clone_ctx)
 		put_ctx(clone_ctx);
@@ -13540,12 +13540,12 @@ static void perf_event_exit_task_context
 	 * get a few PERF_RECORD_READ events.
 	 */
 	if (exit)
-		perf_event_task(child, child_ctx, 0);
+		perf_event_task(task, ctx, 0);
 
-	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, child_ctx);
+	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
+		perf_event_exit_event(child_event, ctx);
 
-	mutex_unlock(&child_ctx->mutex);
+	mutex_unlock(&ctx->mutex);
 
 	if (!exit) {
 		/*
@@ -13561,24 +13561,26 @@ static void perf_event_exit_task_context
 		 *
 		 * Wait for all events to drop their context reference.
 		 */
-		wait_var_event(&child_ctx->refcount,
-			       refcount_read(&child_ctx->refcount) == 1);
+		wait_var_event(&ctx->refcount,
+			       refcount_read(&ctx->refcount) == 1);
 	}
-	put_ctx(child_ctx);
+	put_ctx(ctx);
 }
 
 /*
- * When a child task exits, feed back event values to parent events.
+ * When a task exits, feed back event values to parent events.
  *
  * Can be called with exec_update_lock held when called from
  * setup_new_exec().
  */
-void perf_event_exit_task(struct task_struct *child)
+void perf_event_exit_task(struct task_struct *task)
 {
 	struct perf_event *event, *tmp;
 
-	mutex_lock(&child->perf_event_mutex);
-	list_for_each_entry_safe(event, tmp, &child->perf_event_list,
+	WARN_ON_ONCE(task != current);
+
+	mutex_lock(&task->perf_event_mutex);
+	list_for_each_entry_safe(event, tmp, &task->perf_event_list,
 				 owner_entry) {
 		list_del_init(&event->owner_entry);
 
@@ -13589,17 +13591,17 @@ void perf_event_exit_task(struct task_st
 		 */
 		smp_store_release(&event->owner, NULL);
 	}
-	mutex_unlock(&child->perf_event_mutex);
+	mutex_unlock(&task->perf_event_mutex);
 
-	perf_event_exit_task_context(child, true);
+	perf_event_exit_task_context(task, true);
 
 	/*
 	 * The perf_event_exit_task_context calls perf_event_task
-	 * with child's task_ctx, which generates EXIT events for
-	 * child contexts and sets child->perf_event_ctxp[] to NULL.
+	 * with task's task_ctx, which generates EXIT events for
+	 * task contexts and sets task->perf_event_ctxp[] to NULL.
 	 * At this point we need to send EXIT events to cpu contexts.
 	 */
-	perf_event_task(child, NULL, 0);
+	perf_event_task(task, NULL, 0);
 }
 
 /*



