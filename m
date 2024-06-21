Return-Path: <linux-kernel+bounces-224886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F2C912828
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882B9B21598
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324F9286A6;
	Fri, 21 Jun 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="mhYEVR/Q"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3AFBED
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980911; cv=none; b=N7ptUSzoumywsMYlJPCz6Q0G0p7lT2zWZPxKMKK+un8m0d/KrxF5+yovauwy9tPmNva754qpqUcsuoZwMSzEHHgcbpi4RYUJ/q0KNTxdm4TebXG3pEp+GHwgx73fmKAy5k99xn435kOEjyVXM4REPBs8spN5MdYnBw4uIGm+5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980911; c=relaxed/simple;
	bh=Ykl2dCB/hhOlapSqo5OzDM3wuxFjIV/EQ2XusZeIcKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZUr03cX+/OZLPqDBfXjrvUlnU7UKAmzGmLOjg1T2yLxh1TMBYlt7+KeAp4cw18fgZKGBjuplqtDpZtuMYvhMpMnUAGsrWQ2151WNZ87SU56uNw1eCZ5l45JlrzaSwjDWX43GOJxaEtREJI5tjwDXpacZoP3OnRcR3e55VLWAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=mhYEVR/Q; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-632843cff4fso20221907b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1718980908; x=1719585708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FEdw/H5SB+DdINFYLIYabv3Y7bT1rN6e6AOaUViWrLc=;
        b=mhYEVR/Q15GKUzcrg2TYaWnb8aqYQPiK4Ro3qxRW1zM4CKNFiH0H9Cv0Z2/ikJsSZG
         HshnWDFUwOarPwTMmnqaI/bcI3Za64F2efBNVuEPLEAa6PS8SHammfxeKjzgRnfR/wEb
         +aY94lEFvKGZ3r52Gro8owJ5Fhnoi19xOArNLL4vLxvXFuR3/0M1l77NIgR775Yfu/sC
         GZR74yioj2nhztoI9q/hG5cI55oS/mE4kjs6Iu0l9aBjyshLs6SHFRUUFKw3VV8igJ5e
         0muFdVV9JFcjk32L9rX/eMDnC9/b5nQw0ZwFmkGmwlP0gbSueTOgt6LyPrPzYXeGNeEL
         wEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980908; x=1719585708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEdw/H5SB+DdINFYLIYabv3Y7bT1rN6e6AOaUViWrLc=;
        b=Qehf5WfsDv9a/jBRoFijk0LSqefHO2yX6qZXuE3JLzhI1YklSuzxFnSy1tCDuTpS1T
         9bkYdHZ5gVmj+RQhiLp8mCoAYSEn5OAsD5w9BG2w2kYUo3w7xZZwOYFxW8HaNu0TIpgh
         tvUuHhvSrFMu8s02mtje0u0FvZSQ8X+AlgZ4XFzAe0GiT6KCqoJQKRbG9gTYp2HgC595
         ZUZ/YMj9m46Jj4rDOFzewNpZMirbPIsd7j1Y112JdlBFTPRAEBzhQkDo5Cl2Y9fkbVwy
         NnHb6jw4lyJT5ZuLAMxUtuzsC2M8IA53LjTK+nLaFmEhQwgSNnTzOHYBC9fMR9GE3wIX
         2ztQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH0+JgrmjILHJ3zC1k7+d9Bwd3KkdNJeEwe1AxKZYle7qhZiRfxso/V/JaWltwwf139gQ55t/P4kVb7XZM9jU8ge1lwUAr12UPSaG9
X-Gm-Message-State: AOJu0Yw8UuGMR/FQySPxiwRBA349XQtp2lWDwup5phAQgLy9P+6HhFV+
	ebI0qEDXpxwK6io+cnVddlwtFOtTofc/paV14NXdUmER+Hcj5dmbt8chP8HllpSFwAr8OgTyiZ+
	XOUMeq/uFRPrRG18nWd1z79eLHsl3O5Pw3v3sjA==
X-Google-Smtp-Source: AGHT+IED5qaEY52/k9STLaXqzwjw2PxEk6JDE4ijlEjYc8iQP2O5XnIEVaLG3biKXY4iNtBwuZPi5ADPEm3fTz/nmmc=
X-Received: by 2002:a0d:de83:0:b0:631:3c7c:f766 with SMTP id
 00721157ae682-63a8f9f681fmr83861007b3.34.1718980907226; Fri, 21 Jun 2024
 07:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716811043.git.bristot@kernel.org>
In-Reply-To: <cover.1716811043.git.bristot@kernel.org>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Fri, 21 Jun 2024 10:41:35 -0400
Message-ID: <CAO7JXPhWvLaaGqCGUZ_YCuja2T1ciWZoUnsUDnNPQ2b4yDB2Jw@mail.gmail.com>
Subject: Re: [PATCH V7 0/9] SCHED_DEADLINE server infrastructure
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Luca Abeni <luca.abeni@santannapisa.it>, 
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, Thomas Gleixner <tglx@linutronix.de>, 
	Joel Fernandes <joel@joelfernandes.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Phil Auld <pauld@redhat.com>, Suleiman Souhlal <suleiman@google.com>, 
	Youssef Esmat <youssefesmat@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,


>
> This is v7 of Peter's SCHED_DEADLINE server infrastructure
> implementation [1].
>
Thanks for the v7 :-)

Sorry that I could not get to reviewing and testing this revision. In
v6 we had experienced a minor bug where suspend/resume had issues with
dlserver. Since suspend does not do dequeue, dlserver is not stopped
and this causes the premature wakeups. I haven't looked at v7 in
detail, but I think the issue might still be present. We have a
workaround patch for this in our 5.15 kernel based on v5 which I am
attaching for reference. This might not apply cleanly on v7 and
possibly not be the best solution, but thought of sharing it to give
an insight about the issue.

Thanks,
Vineeth

Attached patch
-----------------------

Subject: [PATCH] sched/dlserver: Freeze dlserver on system suspend.

dlserver is stopped only if a dequeue or cfs rq throttle results in no
runnable cfs tasks. But this doesn't happen during a system suspend and
can cause the dl server to stay active and break suspend/resume.

Freeze the dlserver on system suspend. Freezing is stopping the
dlserver, but maintaining the dl_server_active state so as to not
confuse the enqueue/dequeue path.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Reviewed-on: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/5528103
Reviewed-by: Suleiman Souhlal <suleiman@google.com>
Tested-by: Vineeth Pillai <vineethrp@google.com>
Commit-Queue: Vineeth Pillai <vineethrp@google.com>
---
 include/linux/sched.h   | 27 +++++++++++++
 kernel/power/suspend.c  |  3 ++
 kernel/sched/deadline.c | 87 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 110 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 123ef7804d95..23beff5e48a2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -650,6 +650,15 @@ struct sched_dl_entity {
        unsigned int                    dl_defer          : 1;
        unsigned int                    dl_defer_armed    : 1;
        unsigned int                    dl_server_active  : 1;
+       /*
+        * dl_server is marked as frozen when the system suspends. Frozen
+        * means that dl_server is stopped, but the dl_server_active state
+        * is maintained so that the enqueue/dequeue path is not confused.
+        * We need this separate state other than dl_server_active because
+        * suspend doesn't dequeue the tasks and hence does not stop the
+        * dl_server during suspend. And this may lead to spurious resumes.
+        */
+       unsigned int                    dl_server_frozen  : 1;

        /*
         * Bandwidth enforcement timer. Each -deadline task has its
@@ -690,6 +699,24 @@ struct sched_dl_entity {
 #endif
 };

+/*
+ * Power management related actions for dl_server
+ */
+enum dl_server_pm_action {
+       dl_server_pm_freeze = 0,
+       dl_server_pm_thaw = 1
+};
+extern void freeze_thaw_dl_server(enum dl_server_pm_action action);
+static inline void freeze_dl_server(void)
+{
+       freeze_thaw_dl_server(dl_server_pm_freeze);
+}
+static inline void thaw_dl_server(void)
+{
+       freeze_thaw_dl_server(dl_server_pm_thaw);
+}
+
+
 #ifdef CONFIG_UCLAMP_TASK
 /* Number of utilization clamp buckets (shorter alias) */
 #define UCLAMP_BUCKETS CONFIG_UCLAMP_BUCKETS_COUNT
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 55235bf52c7e..a6d5f8f3072e 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -592,6 +592,8 @@ static int enter_state(suspend_state_t state)
        if (error)
                goto Unlock;

+       freeze_dl_server();
+
        if (suspend_test(TEST_FREEZER))
                goto Finish;

@@ -602,6 +604,7 @@ static int enter_state(suspend_state_t state)
        pm_restore_gfp_mask();

  Finish:
+       thaw_dl_server();
        events_check_enabled = false;
        pm_pr_dbg("Finishing wakeup.\n");
        suspend_finish();
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5fc40caf20d7..f95a375af329 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1478,10 +1478,11 @@ static void update_curr_dl_se(struct rq *rq,
struct sched_dl_entity *dl_se, s64

 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-       update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+       if (!dl_se->dl_server_frozen)
+               update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }

-void dl_server_start(struct sched_dl_entity *dl_se)
+static inline void __dl_server_start(struct sched_dl_entity *dl_se)
 {
        /*
         * XXX: the apply do not work fine at the init phase for the
@@ -1500,25 +1501,97 @@ void dl_server_start(struct sched_dl_entity *dl_se)
                setup_new_dl_entity(dl_se);
        }

+       enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
+}
+
+void dl_server_start(struct sched_dl_entity *dl_se)
+{
+       if (dl_se->dl_server_frozen)
+               goto set_active;
+
        if (WARN_ON_ONCE(dl_se->dl_server_active))
                return;

-       enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
+       __dl_server_start(dl_se);
+
+set_active:
        dl_se->dl_server_active = 1;
 }

-void dl_server_stop(struct sched_dl_entity *dl_se)
+static inline void __dl_server_stop(struct sched_dl_entity *dl_se)
 {
-       if (WARN_ON_ONCE(!dl_se->dl_server_active))
-               return;
-
        dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
        hrtimer_try_to_cancel(&dl_se->dl_timer);
        dl_se->dl_defer_armed = 0;
        dl_se->dl_throttled = 0;
+}
+
+void dl_server_stop(struct sched_dl_entity *dl_se)
+{
+       if (dl_se->dl_server_frozen)
+               goto reset_active;
+
+       if (WARN_ON_ONCE(!dl_se->dl_server_active))
+               return;
+
+       __dl_server_stop(dl_se);
+
+reset_active:
        dl_se->dl_server_active = 0;
 }

+void dl_server_freeze(struct sched_dl_entity *dl_se)
+{
+       if (dl_se->dl_server_active) {
+               update_rq_clock(dl_se->rq);
+               __dl_server_stop(dl_se);
+       }
+       dl_se->dl_server_frozen = 1;
+}
+
+void dl_server_thaw(struct sched_dl_entity *dl_se)
+{
+       if (dl_se->dl_server_active) {
+               update_rq_clock(dl_se->rq);
+               __dl_server_start(dl_se);
+       }
+       dl_se->dl_server_frozen = 0;
+}
+
+void freeze_thaw_dl_server(enum dl_server_pm_action action)
+{
+       int cpu;
+
+       cpus_read_lock();
+       for_each_online_cpu(cpu) {
+               struct rq_flags rf;
+               struct rq *rq = cpu_rq(cpu);
+               struct sched_dl_entity *dl_se;
+
+               sched_clock_tick();
+               rq_lock_irqsave(rq, &rf);
+               dl_se = &rq->fair_server;
+               switch (action) {
+               case dl_server_pm_freeze:
+                       if (WARN_ON_ONCE(dl_se->dl_server_frozen))
+                               break;
+
+                       dl_server_freeze(dl_se);
+                       break;
+               case dl_server_pm_thaw:
+                       if (WARN_ON_ONCE(!dl_se->dl_server_frozen))
+                               break;
+
+
+                       dl_server_thaw(dl_se);
+                       break;
+               default:
+                       WARN_ON_ONCE(1);
+               }
+               rq_unlock_irqrestore(rq, &rf);
+       }
+       cpus_read_unlock();
+}
+
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
                    dl_server_has_tasks_f has_tasks,
                    dl_server_pick_f pick_next,
-- 
2.45.2.741.gdbec12cfda-goog

