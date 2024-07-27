Return-Path: <linux-kernel+bounces-264114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46BA93DF10
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25971C20DCF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF9913C3CA;
	Sat, 27 Jul 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IycGFN9A"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88CB77113
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078150; cv=none; b=nQang4pZgNW3Y+VyPMMy/8RT9er4DNyRhgesnhXWQkG12V1XUnETZ/8Y9IEoV/ETzGtxhjl0a8e3boeQy1kj+uDafhACIEHev7LtbVQh+1qDR3MiaNLwLjEvMAVy4/7IVwFITYwWZYAEpnCa4ZCAr7G8robCN67GMFue/rWUBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078150; c=relaxed/simple;
	bh=nhL59T6elYdLuyB0RjGQo0N9qwu/eI7fAleBo/HW70I=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OChTs/aLVTFwaKYjDc3+8emYRy+2QLiPJrqvMhTUwdKLR5k6LVi3cPrUsLJ9LSmd9x245zWEJ7ubqbcrpNUjxbJx1UNKXuyp5wupI+EXVBbrdi2Ucb9zOvxss4e4qgoDzOSKu5lzW0E3upIzglBqzml/BrMqObRIHtT+LGDBhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IycGFN9A; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=FRzZ9IuL6b8fEH7RF9UvkS800H6XvcRuToO64xLZ6Jc=; b=IycGFN9AEvXI5Nmvm/QbZAi7wN
	0JRgGNbbT8RilcTR0njK3Iq2TK96dxfNBjyRnM9eghJ8SiaGkbvZpjecLEjl9TT7hPgWfi6RXENIS
	hXiYkN4BqBLMwXpz8j1uS8mPbzuZNr2jQkSJrfcW9XHZc4irKl75VBvK4E/CHScLxOnl4FfKyGGE/
	a0WF5PxlhjakrtX2oI3KPSJu7D/OfIN9tlb1ZPKY/lle9ocytCQMt861cCjlXWE+PO4q6tcAL3khu
	rvo1P1xFUauTGRdwwcuQWHkKnQFCM9A8+FYLXdLKoBP5wMeju8dOKGtx5mwgomx77Iorsph0RbTZV
	PkfXJfuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-00000004QMe-0fE9;
	Sat, 27 Jul 2024 11:02:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A4EB53018AA; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105028.864630153@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [PATCH 06/24] sched: Allow sched_class::dequeue_task() to fail
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Change the function signature of sched_class::dequeue_task() to return
a boolean, allowing future patches to 'fail' dequeue.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |    7 +++++--
 kernel/sched/deadline.c  |    4 +++-
 kernel/sched/fair.c      |    4 +++-
 kernel/sched/idle.c      |    3 ++-
 kernel/sched/rt.c        |    4 +++-
 kernel/sched/sched.h     |    4 ++--
 kernel/sched/stop_task.c |    3 ++-
 7 files changed, 20 insertions(+), 9 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2001,7 +2001,10 @@ void enqueue_task(struct rq *rq, struct
 		sched_core_enqueue(rq, p);
 }
 
-void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
+/*
+ * Must only return false when DEQUEUE_SLEEP.
+ */
+inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (sched_core_enabled(rq))
 		sched_core_dequeue(rq, p, flags);
@@ -2015,7 +2018,7 @@ void dequeue_task(struct rq *rq, struct
 	}
 
 	uclamp_rq_dec(rq, p);
-	p->sched_class->dequeue_task(rq, p, flags);
+	return p->sched_class->dequeue_task(rq, p, flags);
 }
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2162,7 +2162,7 @@ static void enqueue_task_dl(struct rq *r
 		enqueue_pushable_dl_task(rq, p);
 }
 
-static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
+static bool dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_curr_dl(rq);
 
@@ -2172,6 +2172,8 @@ static void dequeue_task_dl(struct rq *r
 	dequeue_dl_entity(&p->dl, flags);
 	if (!p->dl.dl_throttled && !dl_server(&p->dl))
 		dequeue_pushable_dl_task(rq, p);
+
+	return true;
 }
 
 /*
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6865,7 +6865,7 @@ static void set_next_buddy(struct sched_
  * decreased. We remove the task from the rbtree and
  * update the fair scheduling stats:
  */
-static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
@@ -6937,6 +6937,8 @@ static void dequeue_task_fair(struct rq
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
+
+	return true;
 }
 
 #ifdef CONFIG_SMP
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -482,13 +482,14 @@ struct task_struct *pick_next_task_idle(
  * It is not legal to sleep in the idle task - print a warning
  * message if some code attempts to do it:
  */
-static void
+static bool
 dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 {
 	raw_spin_rq_unlock_irq(rq);
 	printk(KERN_ERR "bad: scheduling from the idle thread!\n");
 	dump_stack();
 	raw_spin_rq_lock_irq(rq);
+	return true;
 }
 
 /*
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1483,7 +1483,7 @@ enqueue_task_rt(struct rq *rq, struct ta
 		enqueue_pushable_task(rq, p);
 }
 
-static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
+static bool dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 
@@ -1491,6 +1491,8 @@ static void dequeue_task_rt(struct rq *r
 	dequeue_rt_entity(rt_se, flags);
 
 	dequeue_pushable_task(rq, p);
+
+	return true;
 }
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2285,7 +2285,7 @@ struct sched_class {
 #endif
 
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
-	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
+	bool (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task)   (struct rq *rq);
 	bool (*yield_to_task)(struct rq *rq, struct task_struct *p);
 
@@ -3606,7 +3606,7 @@ extern int __sched_setaffinity(struct ta
 extern void __setscheduler_prio(struct task_struct *p, int prio);
 extern void set_load_weight(struct task_struct *p, bool update_load);
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
-extern void dequeue_task(struct rq *rq, struct task_struct *p, int flags);
+extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
 
 extern void check_class_changed(struct rq *rq, struct task_struct *p,
 				const struct sched_class *prev_class,
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -57,10 +57,11 @@ enqueue_task_stop(struct rq *rq, struct
 	add_nr_running(rq, 1);
 }
 
-static void
+static bool
 dequeue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
 	sub_nr_running(rq, 1);
+	return true;
 }
 
 static void yield_task_stop(struct rq *rq)



