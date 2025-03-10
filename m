Return-Path: <linux-kernel+bounces-554578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64612A59A22
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9501D1685E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6481922D4DE;
	Mon, 10 Mar 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RL0sY4DH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39151B3927
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621071; cv=none; b=DF92TtJaz6JnQgTqYAvGfi9fIi/Tiw/m44JtO267cr8FQS+oa3L3L54w13bKJj0OA+wUIkgvSV4zDRm4jqLScC1fBV/lfJp/x58MBJbgsFvm2aUIwWfbDqSHcfiaPsXu4lLbyWuTIE92F/mBHomj2rCHXELR9A76sm7rHedof7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621071; c=relaxed/simple;
	bh=fDwV4ZPGhmkyRRDl6cDKwUVLWH53b3ugYWrFhZxMXAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOe6hQR4AoAtCKwN44b0g0R2Us2c5Q3CtBL5GDC4/x7ucz7h+o87ls4Se7zjv2DrSPD1C8a4XA9hwCl8p1F+Wd1ECfg6wPpFcOEcid+X9KaIn/cKd3psz1mLTIf38yhWIu4Q2cO6zgdfPvHNVoYBAzhBSBeW3ZOPBNFMg+8KxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RL0sY4DH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bkJxZnnND72sRNT7oiph3MaWoImtOx3OWME65e6OxSI=; b=RL0sY4DHQxo3KMnbeeWi5ImgRU
	c3njBuTCUmCLN7apWQ49DH9qcRbmZTAyFF+ax6vGA8MxLlND/W8tFXLqN5eJr7NgRSPbLmnRKjSHF
	YK2AuW1cAjfH1Td1JlmUs8rMfFhz0xfuyz3D9uu2D6mvGZokWQ5XkqZXJj+FGUBL+3tud65qNb/MZ
	EZ2/qy69nmkioKT6H2GP6/bzFuH51iVdEA9HaV5c3ae/VrZXI9gtxUyJHDL8ukzmBZFF88UlTOYGo
	xe9VrAyYGV5it8d8BHSllim4U72WXrfBhYgxKhWPIA1rzVvUAsYl/4xN797UoOinRlXFkIMjYQFGj
	6Uxf8AJQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trfCJ-00000006SES-3ezK;
	Mon, 10 Mar 2025 15:37:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E4CE4300599; Mon, 10 Mar 2025 16:37:42 +0100 (CET)
Date: Mon, 10 Mar 2025 16:37:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, ravi.bangoria@amd.com, lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: [PATCH v3a 6/7] perf: Rename perf_event_exit_task(.child)
Message-ID: <20250310153742.GE19344@noisy.programming.kicks-ass.net>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.417881572@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307193723.417881572@infradead.org>


The task passed to perf_event_exit_task() is not a child, it is
current. Fix this confusing naming, since much of the rest of the code
also relies on it being current.

Specifically, both exec() and exit() callers use it with current as
the argument.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   54 ++++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13551,8 +13551,8 @@ static void perf_event_exit_task_context
 	struct perf_event_context *child_ctx, *clone_ctx = NULL;
 	struct perf_event *child_event, *next;
 
-	child_ctx = perf_pin_task_context(child);
-	if (!child_ctx)
+	ctx = perf_pin_task_context(task);
+	if (!ctx)
 		return;
 
 	/*
@@ -13565,27 +13565,27 @@ static void perf_event_exit_task_context
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
@@ -13596,12 +13596,12 @@ static void perf_event_exit_task_context
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
@@ -13617,24 +13617,26 @@ static void perf_event_exit_task_context
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
 
@@ -13645,17 +13647,17 @@ void perf_event_exit_task(struct task_st
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

