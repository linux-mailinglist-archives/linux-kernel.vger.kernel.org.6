Return-Path: <linux-kernel+bounces-181153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9A98C7846
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC19DB2137F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC9E14D2BF;
	Thu, 16 May 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/S2yQ2T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D614D2A6
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868590; cv=none; b=TaRskOWVHukCOJ73XE/FGuw3+egJDEJn7c62ktf3iO5NLbF9kTKKdzMfxy42e43/mOAM+VMY+87FjRA4yJ49aMesXGlo1BHsbTeM/kDaA4vw3DmYocNydIrvCliLBxcBZs12lkFf7PSD89+lRSuvDRIGMBPURL9gVppNO40Ro7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868590; c=relaxed/simple;
	bh=h3hTYa+QVLo1ar17Qiq7dfJ3JmqF/A7sdI3WXMpbxes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HH9HfctUyyM7T/FRHbFvTYbOVhIuUfz/eLuwmCWNZycI7MwbZEwVq0DzxzmLwrddqMkXJbAp+uUObyGvanf9Cc/s5KNAUgKgOMv2GL5QaUusZthpRK3mOLXNlonPdxC6Xi3ORpjAmTji8WOj0pxheX/6EKmb3BGwjBuCy16xg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/S2yQ2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D73C4AF07;
	Thu, 16 May 2024 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715868589;
	bh=h3hTYa+QVLo1ar17Qiq7dfJ3JmqF/A7sdI3WXMpbxes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/S2yQ2TQwsMe1LqJ5T4I+ryqon6kdFShMOPc9B2wiZhNTm/sikbCrRtQ4HO2r1W5
	 46hjavwQwclVUy8HH1bKQq/a44ILMp2dvt0QZHTKf+TZnt5k+6UQLQEg0jzK8QjVBL
	 we1xSfYTc4bCSiyo1QprKI7PkqikQc82zwEwt4PIlFjHDuRR7jnJxvjxXWu5Zs6jio
	 JXn96gQUUsNQjdd3vu0zTszYLB/uXrLq+ukNiVvLGmc/u/tl6S1pALtxxfRYRnYFn2
	 8h3TZcNv1/LXwDWuaMi3Gfz9WQzBeY8MC06SSauRbLGTWNE+F+YfegK8RMACeugxhW
	 X8gsBKhWdKWSA==
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
Date: Thu, 16 May 2024 16:09:35 +0200
Message-Id: <20240516140936.13694-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516140936.13694-1-frederic@kernel.org>
References: <20240516140936.13694-1-frederic@kernel.org>
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
 kernel/events/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..f2a366e736a4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2284,18 +2284,15 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 	}
 
 	if (event->pending_sigtrap) {
-		bool dec = true;
-
 		event->pending_sigtrap = 0;
 		if (state != PERF_EVENT_STATE_OFF &&
-		    !event->pending_work) {
-			event->pending_work = 1;
-			dec = false;
+		    !event->pending_work &&
+		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
 			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-			task_work_add(current, &event->pending_task, TWA_RESUME);
-		}
-		if (dec)
+			event->pending_work = 1;
+		} else {
 			local_dec(&event->ctx->nr_pending);
+		}
 	}
 
 	perf_event_set_state(event, state);
-- 
2.34.1


