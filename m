Return-Path: <linux-kernel+bounces-180023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC4C8C68F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C841C21BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0A315665D;
	Wed, 15 May 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbtTKF6Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2A156641
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784207; cv=none; b=BVi6bXA6ouVcuXh6rglH0jGDZiu518IXT0cXGuUGf4LzrNcXuM6SY6qi6B5FCtWX5cLjVK6iGeBenfEo+M8q7FcikA0VegrGcOjhyyFcEEUC3rkG67HzUn3CYMnjZ6I+CTU6+CnehmHDvPX3jcAjXuLJzesuysF4Vy6bypv81Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784207; c=relaxed/simple;
	bh=jdiXquXAPPtPajTSj3ryNiWP4Z6gOwf8+7VBRKa5ETE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7SfzGMwWfoFcvyUx90mfqzEqdyGY/Gai5AboUoYMDmx7RGsUX3XAc3XzBNcDctLqkbhTqLt238I8hIrBUT6nb2v2AIbVoG73Emf2lo0mj6vxWjx9049tYjsUHxx3zbCaQUNMlOFGzUll3rbcwqJ46xoqWuuLi8pMRygob2GzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbtTKF6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BB4C4AF08;
	Wed, 15 May 2024 14:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715784207;
	bh=jdiXquXAPPtPajTSj3ryNiWP4Z6gOwf8+7VBRKa5ETE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EbtTKF6ZV0X7RbH+v9/aKJzpPhBbxhP8uPYX1PxxhdU3i46mHXH7VJVO9rRO1D+BX
	 /OsB+zeGrtsd3TlqXWSYjlSzHC+QEVViuRZL9XYTdndfZfIdGzm9TbbgHyiCnboYuq
	 wiykjpgVd3RzXudnv9IlaqMNT+oDwN7i9f9S0Vx9sgKC2fQBgpVFXZzHH/abtrxWkq
	 AAvAhwGDj6qYPfDw65Lhr1tCRR5TCPXk5S2l62XlM+fAO59hBdiU0kbsnfmuSKRSuP
	 F06kVmLsM+x8/iliNtOZECtsLwRbHEoYHI1NbVRxYB2WFjryM+LZd2WWPQghvoCB/G
	 5244qLLb76msg==
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
Subject: [PATCH 3/4] perf: Fix event leak upon exit
Date: Wed, 15 May 2024 16:43:10 +0200
Message-ID: <20240515144311.16038-4-frederic@kernel.org>
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

When a task is scheduled out, pending sigtrap deliveries are deferred
to the target task upon resume to userspace via task_work.

However failures while adding en event's callback to the task_work
engine are ignored. And since the last call for events exit happen
after task work is eventually closed, there is a small window during
which pending sigtrap can be queued though ignored, leaking the event
refcount addition such as in the following scenario:

    TASK A
    -----

    do_exit()
       exit_task_work(tsk);

       <IRQ>
       perf_event_overflow()
          event->pending_sigtrap = pending_id;
          irq_work_queue(&event->pending_irq);
       </IRQ>
    =========> PREEMPTION: TASK A -> TASK B
       event_sched_out()
          event->pending_sigtrap = 0;
          atomic_long_inc_not_zero(&event->refcount)
          // FAILS: task work has exited
          task_work_add(&event->pending_task)
       [...]
       <IRQ WORK>
       perf_pending_irq()
          // early return: event->oncpu = -1
       </IRQ WORK>
       [...]
    =========> TASK B -> TASK A
       perf_event_exit_task(tsk)
          perf_event_exit_event()
             free_event()
                WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1)
                // leak event due to unexpected refcount == 2

As a result the event is never released while the task exits.

Fix this with appropriate task_work_add()'s error handling.

Fixes: 517e6a301f34 ("perf: Fix perf_pending_task() UaF")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/events/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..c1632e69c69d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2289,10 +2289,11 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 		event->pending_sigtrap = 0;
 		if (state != PERF_EVENT_STATE_OFF &&
 		    !event->pending_work) {
-			event->pending_work = 1;
-			dec = false;
-			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-			task_work_add(current, &event->pending_task, TWA_RESUME);
+			if (task_work_add(current, &event->pending_task, TWA_RESUME) >= 0) {
+				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
+				dec = false;
+				event->pending_work = 1;
+			}
 		}
 		if (dec)
 			local_dec(&event->ctx->nr_pending);
-- 
2.44.0


