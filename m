Return-Path: <linux-kernel+bounces-389038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5149B67C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA5C1C20C64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0136217464;
	Wed, 30 Oct 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="az0kkCMZ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3E213EC9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301955; cv=none; b=OIpsYbwyxaAuCRIBY7D/MlKrfY4vZur+obi3p6lsq0ibgtzxdDW8dBjURnRdDk80zRf4CadSc7VmeldZqZXRwnmv+Z/EgIbUzbp8ykfp39+1/jKBum0frqkMyxDTfFy+LaGLfGpTjidSyHDXGG1sdvwOm0utWf0+HcDOiNv8dXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301955; c=relaxed/simple;
	bh=FK1SaYO3rXBz41dSsLxeqMRIFrZ9TU7uqpD8sKXnWC4=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NVDxvmWOrbhTowXom3NqFbBRDEuIfbfDPPqmal6AXqxGgZ/JdXtvvNkwS7ezgLQ2mpnJtVXE1cwANPSilCwhHUH/ruLQzqXkpjTTcmEztDAuZmZxtIj5USBYqFWxcxS7hNsVZexQoiF2FDOnY5buM3edVD2fxumPzg96Pi4IO/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=az0kkCMZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=fQYqPcYm16PSvtjGOJry54IoSuFIkTvJQlTDvE/eJ5k=; b=az0kkCMZtNALWLisF3HAZlwJWO
	4ww1hMI5Kex4ii3C53jCJvHTJpv2LiEEGMmV4hbas/5KXXDS4X7Xb87P5s7v3DZwXrmgb/sB/Nsas
	HngnUPz4UdkEe2VVCQEXT9CwUBHbEnvdACA3H4tOZfK3PcfdeUjD32B5aommIn1fkhoWSZ/w3mUTi
	1b7mP8WTzJ3ScNgnZPtSvmBf0JQwc1erACyNr5ryBp+ODWBmBPCiQQ6nDF3coaZ3XV1krwTU6RSgo
	aGp3aQF6B/U9b6pUU83Wa69lyRcNlvhqHFBh2LO9xe/JZHgPUC6HBlpHF1+taz5ptJd+6vJjfLhos
	bSc1Mihg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AZt-0000000AI2F-3UBa;
	Wed, 30 Oct 2024 15:25:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EF1023021D4; Wed, 30 Oct 2024 16:25:43 +0100 (CET)
Message-Id: <20241030152142.820157837@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 30 Oct 2024 16:13:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 void@manifault.com,
 linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 5/6] sched: Add flags to the switch{ing,ed}_{to,from}() methods
References: <20241030151255.300069509@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

... and remove switched_to_scx(), since all methods are now optional.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |    8 ++++----
 kernel/sched/deadline.c  |    4 ++--
 kernel/sched/ext.c       |    6 ++----
 kernel/sched/fair.c      |    4 ++--
 kernel/sched/idle.c      |    2 +-
 kernel/sched/rt.c        |    4 ++--
 kernel/sched/sched.h     |    8 ++++----
 kernel/sched/stop_task.c |    2 +-
 8 files changed, 18 insertions(+), 20 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10531,7 +10531,7 @@ struct sched_change_ctx sched_change_beg
 	lockdep_assert_rq_held(rq);
 
 	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
-		p->sched_class->switching_from(rq, p);
+		p->sched_class->switching_from(rq, p, flags);
 
 	struct sched_change_ctx ctx = {
 		.p = p,
@@ -10546,7 +10546,7 @@ struct sched_change_ctx sched_change_beg
 		put_prev_task(rq, p);
 
 	if ((flags & DEQUEUE_CLASS) && p->sched_class->switched_from)
-		p->sched_class->switched_from(rq, p);
+		p->sched_class->switched_from(rq, p, flags);
 
 	return ctx;
 }
@@ -10559,7 +10559,7 @@ void sched_change_end(struct sched_chang
 	lockdep_assert_rq_held(rq);
 
 	if ((ctx.flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
-		p->sched_class->switching_to(rq, p);
+		p->sched_class->switching_to(rq, p, ctx.flags);
 
 	if (ctx.queued)
 		enqueue_task(rq, p, ctx.flags | ENQUEUE_NOCLOCK);
@@ -10567,5 +10567,5 @@ void sched_change_end(struct sched_chang
 		set_next_task(rq, p);
 
 	if ((ctx.flags & ENQUEUE_CLASS) && p->sched_class->switched_to)
-		p->sched_class->switched_to(rq, p);
+		p->sched_class->switched_to(rq, p, ctx.flags);
 }
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2968,7 +2968,7 @@ void dl_clear_root_domain(struct root_do
 
 #endif /* CONFIG_SMP */
 
-static void switched_from_dl(struct rq *rq, struct task_struct *p)
+static void switched_from_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	/*
 	 * task_non_contending() can start the "inactive timer" (if the 0-lag
@@ -3022,7 +3022,7 @@ static void switched_from_dl(struct rq *
  * When switching to -deadline, we may overload the rq, then
  * we try to push someone off, if possible.
  */
-static void switched_to_dl(struct rq *rq, struct task_struct *p)
+static void switched_to_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
 		put_task_struct(p);
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3663,7 +3663,7 @@ static void prio_changed_scx(struct rq *
 {
 }
 
-static void switching_to_scx(struct rq *rq, struct task_struct *p)
+static void switching_to_scx(struct rq *rq, struct task_struct *p, int flags)
 {
 	scx_ops_enable_task(p);
 
@@ -3676,13 +3676,12 @@ static void switching_to_scx(struct rq *
 				 (struct cpumask *)p->cpus_ptr);
 }
 
-static void switched_from_scx(struct rq *rq, struct task_struct *p)
+static void switched_from_scx(struct rq *rq, struct task_struct *p, int flags)
 {
 	scx_ops_disable_task(p);
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
-static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
 
 int scx_check_setscheduler(struct task_struct *p, int policy)
 {
@@ -3971,7 +3970,6 @@ DEFINE_SCHED_CLASS(ext) = {
 
 	.switching_to		= switching_to_scx,
 	.switched_from		= switched_from_scx,
-	.switched_to		= switched_to_scx,
 	.reweight_task		= reweight_task_scx,
 	.prio_changed		= prio_changed_scx,
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13175,12 +13175,12 @@ static void attach_task_cfs_rq(struct ta
 	attach_entity_cfs_rq(se);
 }
 
-static void switched_from_fair(struct rq *rq, struct task_struct *p)
+static void switched_from_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	detach_task_cfs_rq(p);
 }
 
-static void switched_to_fair(struct rq *rq, struct task_struct *p)
+static void switched_to_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	SCHED_WARN_ON(p->se.sched_delayed);
 
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -494,7 +494,7 @@ static void task_tick_idle(struct rq *rq
 {
 }
 
-static void switching_to_idle(struct rq *rq, struct task_struct *p)
+static void switching_to_idle(struct rq *rq, struct task_struct *p, int flags)
 {
 	BUG();
 }
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2420,7 +2420,7 @@ static void rq_offline_rt(struct rq *rq)
  * When switch from the rt queue, we bring ourselves to a position
  * that we might want to pull RT tasks from other runqueues.
  */
-static void switched_from_rt(struct rq *rq, struct task_struct *p)
+static void switched_from_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	/*
 	 * If there are other RT tasks then we will reschedule
@@ -2451,7 +2451,7 @@ void __init init_sched_rt_class(void)
  * with RT tasks. In this case we try to push them off to
  * other runqueues.
  */
-static void switched_to_rt(struct rq *rq, struct task_struct *p)
+static void switched_to_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	/*
 	 * If we are running, update the avg_rt tracking, as the running time
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2417,10 +2417,10 @@ struct sched_class {
 	void (*task_fork)(struct task_struct *p);
 	void (*task_dead)(struct task_struct *p);
 
-	void (*switching_from)(struct rq *this_rq, struct task_struct *task);
-	void (*switched_from) (struct rq *this_rq, struct task_struct *task);
-	void (*switching_to)  (struct rq *this_rq, struct task_struct *task);
-	void (*switched_to)   (struct rq *this_rq, struct task_struct *task);
+	void (*switching_from)(struct rq *this_rq, struct task_struct *task, int flags);
+	void (*switched_from) (struct rq *this_rq, struct task_struct *task, int flags);
+	void (*switching_to)  (struct rq *this_rq, struct task_struct *task, int flags);
+	void (*switched_to)   (struct rq *this_rq, struct task_struct *task, int flags);
 
 	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
 			      const struct load_weight *lw);
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -76,7 +76,7 @@ static void task_tick_stop(struct rq *rq
 {
 }
 
-static void switching_to_stop(struct rq *rq, struct task_struct *p)
+static void switching_to_stop(struct rq *rq, struct task_struct *p, int flags)
 {
 	BUG(); /* its impossible to change to this class */
 }



