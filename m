Return-Path: <linux-kernel+bounces-223177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0313F910F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD2E2848A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806C1B9AA7;
	Thu, 20 Jun 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSWHo8M4"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53251C0DC0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904787; cv=none; b=N1Ehflowy0hQReHm+ZIWFmBqlJhGHzYdYMX5GC8GKTkEyELkaaO4T2Or8lzpCbcHISE8CoMIl++JIv4wP+e7bsbYUwbmAIrtJuxhLnbaxJnnD2q/i2VF8UpCiHUbQvbLYtCqRQtxUeMENPHPksIBFcLRCwxO4KLmqDrC4tEUk3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904787; c=relaxed/simple;
	bh=AaKb7xH3D6322u5oRmwnJltCEtxp6IvHn7eAt659z8I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=shWU1uduqB87O0oohF+NCax75JjMc91Pf1ccGltk85K8/10Ar0oBZ6GBZR3oQJeEtu+cNMwwrI3dO4SFU3UMfndrFmVvXex7kIA6ufcElAxmrvngoOmh+tXPJku3xdRvrd2hBKZfrWwgfOJXYFAMDUqAbHgdEOzEksE/AJlFH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eSWHo8M4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dff1eb1c1fcso2176466276.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718904785; x=1719509585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FxbUlqEIru4E7gX2WnN1T22F/48gDP0UMTSnaKBJ4Lc=;
        b=eSWHo8M4VOVFdy0hf7i25uBcyd5QD7kYB+vH8Ur6a8X9zrr5Kdy4NI9Bh4fePQhrr/
         KlTYR8dUlD60cPl9pQzGfCTmNyCL8TsJZwRNsfq1qd+vl9WVWrCNAqkox0ex4eZT5XnF
         /ZhHMoEVaqLlWb2mDVAPwrfty4pZbi0aFXWqqpqNSzCYGJ75VL2kyXO8LsuTkwNcISDf
         +Mb6uWxqvUS7hrTqNQNRkwc4mc46Vqt01iIiQsCeiULYI8thGXMsiDs6DLWugL3M7aru
         LG+1aakbRd9nZTw/SVABZQBq47og2C3CJWV2rFNoYCpnJkPWQsEb757WO+Nr5PLzdeSL
         FTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718904785; x=1719509585;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FxbUlqEIru4E7gX2WnN1T22F/48gDP0UMTSnaKBJ4Lc=;
        b=SEGC3so5quk+Ag9AyctW/shXxm4WrtDyLH8woFwwDweFZcLWeA9FJUAQgpmgT6UOsV
         7pL1HJdkEIOela6JZUMnBVh1fsUSiLfDQSgSX8c6XTos8Bm6gxVG4bJwpFBy8gQpBOC/
         YB39z3qOshbW8IbGnRlwiQaoB6JXQymSoH5WZaXsV5r7lcufHCoFnDpIDObohCIFjBcp
         6fMy28nZm+W4o/Nlsf5waCVKRhokkpfUCqq5FB6zj4Sp5c/+QctZAezqtHxfPPS4qgIr
         xeInQ4VKvoY8ihUXhDnMrlu5+XOF7zyTDLIgXtXSoJzNLs/86unszOtvTqa/H9SJcdAs
         v/tQ==
X-Gm-Message-State: AOJu0YwSlqLNdsjfEbd7/rMllA88ud5ZL5x7pYoViZFHJUh1h6z93Odj
	8nestN7MyF6PlzEFR5Qt7pXajzO7lAxPRv5WfQoAgPSzGicjBWsLnsE4En7LS2ncYs3h0p02CQb
	XxIgzplyzLcj2OLorT/UmFIG1MT1TeBybLBXIiEmkt6eBKKofVQ0idAvwT4/0Ho+TR0C8fMtHNP
	ECTLqAdD43Ly24NATHm8e0QrYDm8dyY0NOzpR/806h92t8
X-Google-Smtp-Source: AGHT+IHaP7Rj7bKnYJ7MWtjZwe4lSBiUsB0rCkavybCanBMTCd0BYHyPfenxphR36EJEjDUhH4U78MupPTyf
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:db10:0:b0:e02:c3c2:4b96 with SMTP id
 3f1490d57ef6-e02c3c25615mr754700276.1.1718904784462; Thu, 20 Jun 2024
 10:33:04 -0700 (PDT)
Date: Thu, 20 Jun 2024 10:32:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240620173301.1761679-1-jstultz@google.com>
Subject: [PATCH v2] sched: Move psi_account_irqtime() out of
 update_rq_clock_task() hotpath
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan <surenb@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Qais Yousef <qyousef@layalina.io>, 
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jimmy Shiu <jimmyshiu@google.com>
Content-Type: text/plain; charset="UTF-8"

It was reported that in moving to 6.1, a larger then 10%
regression was seen in the performance of
clock_gettime(CLOCK_THREAD_CPUTIME_ID,...).

Using a simple reproducer, I found:
5.10:
100000000 calls in 24345994193 ns => 243.460 ns per call
100000000 calls in 24288172050 ns => 242.882 ns per call
100000000 calls in 24289135225 ns => 242.891 ns per call

6.1:
100000000 calls in 28248646742 ns => 282.486 ns per call
100000000 calls in 28227055067 ns => 282.271 ns per call
100000000 calls in 28177471287 ns => 281.775 ns per call

The cause of this was finally narrowed down to the addition of
psi_account_irqtime() in update_rq_clock_task(), in commit
52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
pressure").

In my initial attempt to resolve this, I leaned towards moving
all accounting work out of the clock_gettime() call path, but it
wasn't very pretty, so it will have to wait for a later deeper
rework. Instead, Peter shared this approach:

Rework psi_account_irqtime() to use its own psi_irq_time base
for accounting, and move it out of the hotpath, calling it
instead from sched_tick() and __schedule().

In testing this, we found the importance of ensuring
psi_account_irqtime() is run under the rq_lock, which Johannes
Weiner helpfully explained, so also add some lockdep annotations
to make that requirement clear.

With this change the performance is back in-line with 5.10:
6.1+fix:
100000000 calls in 24297324597 ns => 242.973 ns per call
100000000 calls in 24318869234 ns => 243.189 ns per call
100000000 calls in 24291564588 ns => 242.916 ns per call

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: kernel-team@android.com
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Fixes: 52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure")
Originally-by: Peter Zijlstra <peterz@infradead.org>
Reported-by: Jimmy Shiu <jimmyshiu@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Added Fixed tag
* Switched to (delta <= 0) comparision as suggested by
  Chengming Zhou
* Added Reviewed-by tags
---
 kernel/sched/core.c  |  7 +++++--
 kernel/sched/psi.c   | 21 ++++++++++++++++-----
 kernel/sched/sched.h |  1 +
 kernel/sched/stats.h | 11 ++++++++---
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..59ce0841eb1f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -723,7 +723,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->prev_irq_time += irq_delta;
 	delta -= irq_delta;
-	psi_account_irqtime(rq->curr, irq_delta);
 	delayacct_irq(rq->curr, irq_delta);
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
@@ -5665,7 +5664,7 @@ void sched_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr;
 	struct rq_flags rf;
 	unsigned long hw_pressure;
 	u64 resched_latency;
@@ -5677,6 +5676,9 @@ void sched_tick(void)
 
 	rq_lock(rq, &rf);
 
+	curr = rq->curr;
+	psi_account_irqtime(rq, curr, NULL);
+
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
@@ -6737,6 +6739,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		++*switch_count;
 
 		migrate_disable_switch(rq, prev);
+		psi_account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
 		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7b4aa5809c0f..c37ddcb642d5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -773,6 +773,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	enum psi_states s;
 	u32 state_mask;
 
+	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
 	/*
@@ -991,22 +992,32 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-void psi_account_irqtime(struct task_struct *task, u32 delta)
+void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev)
 {
-	int cpu = task_cpu(task);
+	int cpu = task_cpu(curr);
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
-	u64 now;
+	u64 now, irq;
+	s64 delta;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (!task->pid)
+	if (!curr->pid)
+		return;
+
+	lockdep_assert_rq_held(rq);
+	group = task_psi_group(curr);
+	if (prev && task_psi_group(prev) == group)
 		return;
 
 	now = cpu_clock(cpu);
+	irq = irq_time_read(cpu);
+	delta = (s64)(irq - rq->psi_irq_time);
+	if (delta <= 0)
+		return;
+	rq->psi_irq_time = irq;
 
-	group = task_psi_group(task);
 	do {
 		if (!group->enabled)
 			continue;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a831af102070..ef20c61004eb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1126,6 +1126,7 @@ struct rq {
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
+	u64			psi_irq_time;
 #endif
 #ifdef CONFIG_PARAVIRT
 	u64			prev_steal_time;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 38f3698f5e5b..b02dfc322951 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -110,8 +110,12 @@ __schedstats_from_se(struct sched_entity *se)
 void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
-void psi_account_irqtime(struct task_struct *task, u32 delta);
-
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev);
+#else
+static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
+				       struct task_struct *prev) {}
+#endif /*CONFIG_IRQ_TIME_ACCOUNTING */
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
  * memory stalls. As a result, it has to distinguish between sleeps,
@@ -192,7 +196,8 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
-static inline void psi_account_irqtime(struct task_struct *task, u32 delta) {}
+static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
+				       struct task_struct *prev) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
-- 
2.45.2.741.gdbec12cfda-goog


