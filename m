Return-Path: <linux-kernel+bounces-554575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146ECA59A17
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451C4167B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F46522D7BE;
	Mon, 10 Mar 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V99+h1ms"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888222B5AB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620969; cv=none; b=UBQA6tCky5a8A+ktlwk78TMde28CTpmfJHbfZtyUVT7P8f2CAKNwe6PUlU3dCZPfCLo24tvS+4FBBJnTw7133yzlGrKrDTha74Q/oChM5/Qx3h4st/W5UdGBEAEO0Faya5Nau38DVFDURQrGsp1Qx+XRcUii3eAWYDnr9GwHGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620969; c=relaxed/simple;
	bh=2zIct7nGU4LDpG+b0rzInwpF3Q1u4ClrFDj4hjAo1aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVBMhvI3lN5DLBTNhrLLN1bnfb5aDb+siR10JIomT3A45OB7Dl7BrZkIcGI+T8wby319SQI3+C4Yo4v18iYZRtjWgLIxK+xW8UN0G/kHqKGTCYOFdt1aogxlsgW3S075bnP6IgqLf4dCvVcCiiZxTD+f2E/s1cxlkQyCGaF6IbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V99+h1ms; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O7YzTmnjzMTJtVsFR5/1NkXeM+yNG7azeI82ZnpvY10=; b=V99+h1msR9H8t9cKDJddhoasO9
	E98xgm2hTZZ/PjR7trFK1MqDlD1GQqX5UUTfFhR2IfT/cv2FrpFgoj/3TdhrwG5TJE5vyXPtBn2SC
	1XadmoyxNEfoxtxO/NAe0ZKuU+ib8riVVBBVIxIObJ06DX3nsOdwMot9FDFW0SwGlrIJ/90M1CeFg
	NuL1uGt5Wr7pYYGKxFD9eGGPA/4BkAvi0e5MNpN7xc33kbgDDb1lwbGExeMvzEmjUrmCpJgYYM0oU
	JM+hoFE37AcbIMDCly/zmx5wB+wURFdUAR/5m7AjKjmpThjF46jfrOWXncSwGZD7f2gixQTwVdkPo
	OummNXgQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trfAe-00000001tAX-0Y1W;
	Mon, 10 Mar 2025 15:36:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 817BE300599; Mon, 10 Mar 2025 16:35:59 +0100 (CET)
Date: Mon, 10 Mar 2025 16:35:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, ravi.bangoria@amd.com, lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: [PATCH v3a 5/7] perf: Unify perf_event_free_task() /
 perf_event_exit_task_context()
Message-ID: <20250310153559.GD19344@noisy.programming.kicks-ass.net>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.274039710@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307193723.274039710@infradead.org>


Both perf_event_free_task() and perf_event_exit_task_context() are
very similar, except perf_event_exit_task_context() is a little more
generic / makes less assumptions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   90 ++++++++++++---------------------------------------
 1 file changed, 22 insertions(+), 68 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13546,13 +13546,11 @@ perf_event_exit_event(struct perf_event
 	perf_event_wakeup(event);
 }
 
-static void perf_event_exit_task_context(struct task_struct *child)
+static void perf_event_exit_task_context(struct task_struct *child, bool exit)
 {
 	struct perf_event_context *child_ctx, *clone_ctx = NULL;
 	struct perf_event *child_event, *next;
 
-	WARN_ON_ONCE(child != current);
-
 	child_ctx = perf_pin_task_context(child);
 	if (!child_ctx)
 		return;
@@ -13597,13 +13595,31 @@ static void perf_event_exit_task_context
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
 
@@ -13631,7 +13647,7 @@ void perf_event_exit_task(struct task_st
 	}
 	mutex_unlock(&child->perf_event_mutex);
 
-	perf_event_exit_task_context(child);
+	perf_event_exit_task_context(child, true);
 
 	/*
 	 * The perf_event_exit_task_context calls perf_event_task
@@ -13642,27 +13658,6 @@ void perf_event_exit_task(struct task_st
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
@@ -13672,48 +13667,7 @@ static void perf_free_event(struct perf_
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

