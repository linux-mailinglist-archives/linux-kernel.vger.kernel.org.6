Return-Path: <linux-kernel+bounces-180024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C08C68F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B031C21865
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113015687C;
	Wed, 15 May 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz/rJBP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3259A156863
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784210; cv=none; b=Xe4GeE8JhxmHD4i9rW72Ix/wHUabi3OB6RRXacNRPxSN1yb/B0FCRp8Z0+xgRTRZpJgEZjfVOYI1rSiVCvnU31jR8Djpj9QBjiWSwtLEEqtHhNuyP6+5BiAhDnpcxvyv/YUjamPOKIrJoOkc4NSLCIG6jBC7sE4Dd8jckm9qjjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784210; c=relaxed/simple;
	bh=YIpdZPuAVi82sw2OhssMCCjVe0LTsltlw8xy5VnUaKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0J1ezA/FxbLgpsSLyqOluWDUSAnuQY1oZXnrrkkBNcQsxFa2nk9MbgX4pwABRavInVyBBICTwBHiI1vswzrsCbi15giiS4XPVZ1MaK09Rq0cXgbdU+kYeVEv56as5eNJhX2BTlY3vmlbKpeuuY7o3wTQZ+rfh5FDPmBfLs+D+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz/rJBP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD1CC4AF08;
	Wed, 15 May 2024 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715784209;
	bh=YIpdZPuAVi82sw2OhssMCCjVe0LTsltlw8xy5VnUaKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tz/rJBP3s/7bbOM2B/sPEEwOa1V/4uXNaRg8Gh3rf9Twam3sIEutwMevNSEBNv6je
	 aovT7TqdgOZ+V4Oi2Re8IRJeP8iBzO+Kt8R8vA3shzR7Lle5EVRiqkgRDO0onjg7iZ
	 6pjcqcJoYDrq1Gf6NCswe2/2gxHS3/LQE17metju85AASvrrm0iRX09a7Jxy1bPh1V
	 8yoDUU7hrAylT4z4d8fmvsIOgUnJfzNdErr3en1W5l+ZbYEp+zNVFC0ZshXCRDVeYT
	 p403PEvWScsCqMNF6cHroptxK2ZLV96ZMQctWMyN4u9ektvH8KrCbmUxH2JlyPAcjP
	 Z5ysislwZaitw==
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
Date: Wed, 15 May 2024 16:43:11 +0200
Message-ID: <20240515144311.16038-5-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240515144311.16038-1-frederic@kernel.org>
References: <20240515144311.16038-1-frederic@kernel.org>
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
index d2a15c0c6f8a..89ae41bb5f70 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -786,6 +786,7 @@ struct perf_event {
 	struct irq_work			pending_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
+	struct rcuwait			pending_work_wait;
 
 	atomic_t			event_limit;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c1632e69c69d..4b99ab7024a4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2290,7 +2290,6 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 		if (state != PERF_EVENT_STATE_OFF &&
 		    !event->pending_work) {
 			if (task_work_add(current, &event->pending_task, TWA_RESUME) >= 0) {
-				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
 				dec = false;
 				event->pending_work = 1;
 			}
@@ -5188,9 +5187,35 @@ static bool exclusive_event_installable(struct perf_event *event,
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
 
@@ -6808,24 +6833,28 @@ static void perf_pending_task(struct callback_head *head)
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
@@ -11933,6 +11962,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_waitqueue_head(&event->waitq);
 	init_irq_work(&event->pending_irq, perf_pending_irq);
 	init_task_work(&event->pending_task, perf_pending_task);
+	rcuwait_init(&event->pending_work_wait);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
-- 
2.44.0


