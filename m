Return-Path: <linux-kernel+bounces-224290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5043D912046
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DFD1C232F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D433F16EC11;
	Fri, 21 Jun 2024 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RS5d0SOZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2574516EC0B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961377; cv=none; b=l8zUGe4tAm/GBKbHq/NTt4c17ggORfxpmEFDhtdnCrV6yoHcWgbm93fx8Szu1tqDKH1B18ZdmuQKjQDQGDEMfockOgJp4aMpyKeW/UiNi+FgL4E+wCme2sYmztvjYHG3f77EJ8BWk1XXm8ajaXWblZbdXI83rIrDnZd8s/OuP+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961377; c=relaxed/simple;
	bh=5XJeijBFwMIAQTzHMcx3zvbS0cEEi69GXEIlzTUup14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaIOL7LCJCJmXnwMswtuiYyjmB1cSgBNqtQZB4AFtkJmpXxyx3a+uoqy+PhVLZXvNWBMccRCg858PYDDGj9G1yvCYuBoH1GAC2pG17b9JYD4QYhgkv0R++dUIoqzT3fudlPg3UWoR3KPe98zA6vhFeWq+CUairZfiun8ZHOt65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RS5d0SOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021D7C32781;
	Fri, 21 Jun 2024 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718961376;
	bh=5XJeijBFwMIAQTzHMcx3zvbS0cEEi69GXEIlzTUup14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RS5d0SOZKDThKmdrWuPx65fT4JYdZp3xrJk3KwhRXbvClNnTCj8H1NboF+wRr9waK
	 KosG5uIJWaPc0q0/OwFWCKMortW5EY+nWOut7S3wMcth4HQnsVMBZiCag8/aYthXwM
	 Pn9JNun3+8Z4nYVwmeBOoHJCiOJZYFB5in2mj3cR66+uwXyUI181BA/ZCWLQHI9rI7
	 21O34WCCRZSRwgQpmgIYJB4jLvmKbGUSG5tE4YPHLJx1qoY3nwlKYGRMSv2yPQ866B
	 469xO1YUEbqrWp7R2kySxRWrIkec/OLi2cmWVHL6+dJE8VrtOOUXoCz826ygLMpWFj
	 X+wg0pVaZzzkQ==
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
Date: Fri, 21 Jun 2024 11:16:00 +0200
Message-ID: <20240621091601.18227-4-frederic@kernel.org>
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

When a task is scheduled out, pending sigtrap deliveries are deferred
to the target task upon resume to userspace via task_work.

However failures while adding an event's callback to the task_work
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
index 8f908f077935..7c3218d31d1d 100644
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
2.45.2


