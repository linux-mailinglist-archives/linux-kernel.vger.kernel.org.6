Return-Path: <linux-kernel+bounces-224291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF8E912047
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5E328DD4F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D9516F0ED;
	Fri, 21 Jun 2024 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ohiki8X8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5A16F0D2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961380; cv=none; b=G99DkSQYTcuHYYyTHfdyn1iEtm8AF332ybvIY7vbIRQyD4by5cVcBu3gQyThiMmaPkTeQk/BtRl35SnIMXHE0JWvNEY54CkSrIzrLMrlKmozmFqN0+pHr8vdqAv3dUaHS83ZHcXnAWPpINoz0YIWFiP6f9a/Bu63uNHHnyWUX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961380; c=relaxed/simple;
	bh=tIr6xsl9f1qlL3ubydb+4cEtOOda2NPwxbdGg11VU2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbOyHU9/1fTozSGNIoW3BDtUutYzm0dHIwb100apG5zLHrmkBE8QOMChD4cdJkYmAxoaDDHHJZV8pTJXAUQaiY7XFRGoeWCRrOf0PCyqb8l1y/kM3d6zNowhMP8UsSKmoSvG0AlSMcglKt1lts7Os0KxRoEWN4gycocQwFFED/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ohiki8X8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054FFC4AF09;
	Fri, 21 Jun 2024 09:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718961379;
	bh=tIr6xsl9f1qlL3ubydb+4cEtOOda2NPwxbdGg11VU2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ohiki8X8ilUGBaJ7gIupFINyIDRIkaniT7gVKr6Iwd9XrNDZKfOuVeufXr3czCW4E
	 igxvoZsMarJ2BDeZZXD/HJXuFFsThKi5Ht/NdM3fTHOzphrJs0/2G6n/9Bfq0fQ5uR
	 SwAzvZyNCFd6EcZQTLtBBK7qP+6y2dNSTAlONmafm8eOQCnHyisHgPk2t/+MPZYzM0
	 SFiV7TWPpaaf6FIA5R3X/XCuCT/ww2qbKzisfr0NWRwbnWWQ/B5gbsVK7VsahRnl1o
	 Dyj3CSxrvdda/NQtta8OUUA6pIV8z71yZo7f1gWBQRwH8awSB4Y8uvDVKWRmgWO94F
	 rFx2bYrgbRR7g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/4] perf: Fix event leak upon exec and file release
Date: Fri, 21 Jun 2024 11:16:01 +0200
Message-ID: <20240621091601.18227-5-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621091601.18227-1-frederic@kernel.org>
References: <20240621091601.18227-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf pending task work is never waited upon the matching event
release. In the case of a child event, released via free_event()
directly, this can potentially result in a leaked event, such as in the
following scenario that doesn't even require a weak IRQ work
implementation to trigger:

schedule()
   prepare_task_switch()
=======> <NMI>
      perf_event_overflow()
         event->pending_sigtrap = ...
         irq_work_queue(&event->pending_irq)
<======= </NMI>
      perf_event_task_sched_out()
          event_sched_out()
              event->pending_sigtrap = 0;
              atomic_long_inc_not_zero(&event->refcount)
              task_work_add(&event->pending_task)
   finish_lock_switch()
=======> <IRQ>
   perf_pending_irq()
      //do nothing, rely on pending task work
<======= </IRQ>

begin_new_exec()
   perf_event_exit_task()
      perf_event_exit_event()
         // If is child event
         free_event()
            WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1)
            // event is leaked

Similar scenarios can also happen with perf_event_remove_on_exec() or
simply against concurrent perf_event_release().

Fix this with synchonizing against the possibly remaining pending task
work while freeing the event, just like is done with remaining pending
IRQ work. This means that the pending task callback neither need nor
should hold a reference to the event, preventing it from ever beeing
freed.

Fixes: 517e6a301f34 ("perf: Fix perf_pending_task() UaF")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 38 ++++++++++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a5304ae8c654..393fb13733b0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -786,6 +786,7 @@ struct perf_event {
 	struct irq_work			pending_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
+	struct rcuwait			pending_work_wait;
 
 	atomic_t			event_limit;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7c3218d31d1d..586d4f367624 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2288,7 +2288,6 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 		if (state != PERF_EVENT_STATE_OFF &&
 		    !event->pending_work &&
 		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
-			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
 			event->pending_work = 1;
 		} else {
 			local_dec(&event->ctx->nr_pending);
@@ -5203,9 +5202,35 @@ static bool exclusive_event_installable(struct perf_event *event,
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
 
+static void perf_pending_task_sync(struct perf_event *event)
+{
+	struct callback_head *head = &event->pending_task;
+
+	if (!event->pending_work)
+		return;
+	/*
+	 * If the task is queued to the current task's queue, we
+	 * obviously can't wait for it to complete. Simply cancel it.
+	 */
+	if (task_work_cancel(current, head)) {
+		event->pending_work = 0;
+		local_dec(&event->ctx->nr_pending);
+		return;
+	}
+
+	/*
+	 * All accesses related to the event are within the same
+	 * non-preemptible section in perf_pending_task(). The RCU
+	 * grace period before the event is freed will make sure all
+	 * those accesses are complete by then.
+	 */
+	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
+}
+
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
+	perf_pending_task_sync(event);
 
 	unaccount_event(event);
 
@@ -6828,24 +6853,28 @@ static void perf_pending_task(struct callback_head *head)
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
 	int rctx;
 
+	/*
+	 * All accesses to the event must belong to the same implicit RCU read-side
+	 * critical section as the ->pending_work reset. See comment in
+	 * perf_pending_task_sync().
+	 */
+	preempt_disable_notrace();
 	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
 	 */
-	preempt_disable_notrace();
 	rctx = perf_swevent_get_recursion_context();
 
 	if (event->pending_work) {
 		event->pending_work = 0;
 		perf_sigtrap(event);
 		local_dec(&event->ctx->nr_pending);
+		rcuwait_wake_up(&event->pending_work_wait);
 	}
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
 	preempt_enable_notrace();
-
-	put_event(event);
 }
 
 #ifdef CONFIG_GUEST_PERF_EVENTS
@@ -11959,6 +11988,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_waitqueue_head(&event->waitq);
 	init_irq_work(&event->pending_irq, perf_pending_irq);
 	init_task_work(&event->pending_task, perf_pending_task);
+	rcuwait_init(&event->pending_work_wait);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
-- 
2.45.2


