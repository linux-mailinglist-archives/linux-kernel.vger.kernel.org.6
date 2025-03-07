Return-Path: <linux-kernel+bounces-551857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031A4A5722A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD63E3B6764
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904972566FC;
	Fri,  7 Mar 2025 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NQVIx2Zd"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F00250BFB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376301; cv=none; b=JoafmT1ejVw+KwQmETIyqAXl1xyyO/MWiwBhilXGNKNf1bUphfsyWwSsXsoGW/juUJIsNVBAgMsMw6HLZB8Z2ZSWVRe/vZQWMfwBcV98sRH4tsURd24920xupDZU18geKJtmczK/dcUAPgFiqPst0Tf4vgRMWIHmKX+ShiJkce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376301; c=relaxed/simple;
	bh=hbyD5rRgXV/cMl6XH8Ew53TqYXbGwic7abLzIsRroX8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Re3/PEryJLaJWfSc/8WrSbqLh04yoHd2EASBPsQcF17iudBDfj8Mq/cFQMhdEGGFH6wbV0o2kTZtmxNNLG69mQg3W7CrBVaMUbPFPmlW+FPjghFVuQLrtn9rMGja1YsRW1cZM/nYL/YHOYNecD+4ZeKggwJMQILYBiSt2U23W/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NQVIx2Zd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=thzfnb0ghCtJVaioL2il6H50r6cCIYQARyaxQotwpvs=; b=NQVIx2ZdoqlBJRxHfOWb7oHD+D
	SN0cm2nV674k/DBDN5pqI65aRT9DmVriVPSNFvdqnJmoTHUUsz2vCPDGo+9iHXDlEVRteppUBXJ07
	e4H03xkXJ3QmMf1LMALkQ+XaMMWL4hhexpz79Z+xw7jzqtsRcypnpg1nE+RbntcVyj21GXtdbG0l8
	MZD4uk1sTk76DbGWasGDB8BUPYZkMO8480KyTY7a0qf1qLINKYMq1XipeOBTQtDtRNJY92LbBD/n7
	/QDt5H2gEIR/zAW6vgLXXDEwPVyQbNYfqM7WzMD4s2Y6xElNLPSb5I2WDSIsH22OYP2G30bxsgdaU
	Tjn4uorA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tqdWQ-00000001PmP-1A2P;
	Fri, 07 Mar 2025 19:38:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 19062300F1D; Fri,  7 Mar 2025 20:38:13 +0100 (CET)
Message-ID: <20250307193723.274039710@infradead.org>
User-Agent: quilt/0.66
Date: Fri, 07 Mar 2025 20:33:10 +0100
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
Subject: [PATCH v3 5/7] perf: Unify perf_event_free_task() / perf_event_exit_task_context()
References: <20250307193305.486326750@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Both perf_event_free_task() and perf_event_exit_task_context() are
very similar, except perf_event_exit_task_context() is a little more
generic / makes less assumptions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   88 ++++++++++++---------------------------------------
 1 file changed, 22 insertions(+), 66 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13488,7 +13488,7 @@ perf_event_exit_event(struct perf_event
 	perf_event_wakeup(event);
 }
 
-static void perf_event_exit_task_context(struct task_struct *child)
+static void perf_event_exit_task_context(struct task_struct *child, bool exit)
 {
 	struct perf_event_context *child_ctx, *clone_ctx = NULL;
 	struct perf_event *child_event, *next;
@@ -13539,13 +13539,31 @@ static void perf_event_exit_task_context
 	 * won't get any samples after PERF_RECORD_EXIT. We can however still
 	 * get a few PERF_RECORD_READ events.
 	 */
-	perf_event_task(child, child_ctx, 0);
+	if (exit)
+		perf_event_task(child, child_ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
 		perf_event_exit_event(child_event, child_ctx);
 
 	mutex_unlock(&child_ctx->mutex);
 
+	if (!exit) {
+		/*
+		 * perf_event_release_kernel() could still have a reference on
+		 * this context. In that case we must wait for these events to
+		 * have been freed (in particular all their references to this
+		 * task must've been dropped).
+		 *
+		 * Without this copy_process() will unconditionally free this
+		 * task (irrespective of its reference count) and
+		 * _free_event()'s put_task_struct(event->hw.target) will be a
+		 * use-after-free.
+		 *
+		 * Wait for all events to drop their context reference.
+		 */
+		wait_var_event(&child_ctx->refcount,
+			       refcount_read(&child_ctx->refcount) == 1);
+	}
 	put_ctx(child_ctx);
 }
 
@@ -13573,7 +13591,7 @@ void perf_event_exit_task(struct task_st
 	}
 	mutex_unlock(&child->perf_event_mutex);
 
-	perf_event_exit_task_context(child);
+	perf_event_exit_task_context(child, true);
 
 	/*
 	 * The perf_event_exit_task_context calls perf_event_task
@@ -13584,27 +13602,6 @@ void perf_event_exit_task(struct task_st
 	perf_event_task(child, NULL, 0);
 }
 
-static void perf_free_event(struct perf_event *event,
-			    struct perf_event_context *ctx)
-{
-	struct perf_event *parent = event->parent;
-
-	if (WARN_ON_ONCE(!parent))
-		return;
-
-	mutex_lock(&parent->child_mutex);
-	list_del_init(&event->child_list);
-	mutex_unlock(&parent->child_mutex);
-
-	put_event(parent);
-
-	raw_spin_lock_irq(&ctx->lock);
-	perf_group_detach(event);
-	list_del_event(event, ctx);
-	raw_spin_unlock_irq(&ctx->lock);
-	free_event(event);
-}
-
 /*
  * Free a context as created by inheritance by perf_event_init_task() below,
  * used by fork() in case of fail.
@@ -13614,48 +13611,7 @@ static void perf_free_event(struct perf_
  */
 void perf_event_free_task(struct task_struct *task)
 {
-	struct perf_event_context *ctx;
-	struct perf_event *event, *tmp;
-
-	ctx = rcu_access_pointer(task->perf_event_ctxp);
-	if (!ctx)
-		return;
-
-	mutex_lock(&ctx->mutex);
-	raw_spin_lock_irq(&ctx->lock);
-	/*
-	 * Destroy the task <-> ctx relation and mark the context dead.
-	 *
-	 * This is important because even though the task hasn't been
-	 * exposed yet the context has been (through child_list).
-	 */
-	RCU_INIT_POINTER(task->perf_event_ctxp, NULL);
-	WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
-	put_task_struct(task); /* cannot be last */
-	raw_spin_unlock_irq(&ctx->lock);
-
-
-	list_for_each_entry_safe(event, tmp, &ctx->event_list, event_entry)
-		perf_free_event(event, ctx);
-
-	mutex_unlock(&ctx->mutex);
-
-	/*
-	 * perf_event_release_kernel() could've stolen some of our
-	 * child events and still have them on its free_list. In that
-	 * case we must wait for these events to have been freed (in
-	 * particular all their references to this task must've been
-	 * dropped).
-	 *
-	 * Without this copy_process() will unconditionally free this
-	 * task (irrespective of its reference count) and
-	 * _free_event()'s put_task_struct(event->hw.target) will be a
-	 * use-after-free.
-	 *
-	 * Wait for all events to drop their context reference.
-	 */
-	wait_var_event(&ctx->refcount, refcount_read(&ctx->refcount) == 1);
-	put_ctx(ctx); /* must be last */
+	perf_event_exit_task_context(task, false);
 }
 
 void perf_event_delayed_put(struct task_struct *task)



