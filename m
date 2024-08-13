Return-Path: <linux-kernel+bounces-285575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27599950FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669AEB23349
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37BD1AC431;
	Tue, 13 Aug 2024 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KJjRKkXx"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53236B11
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589440; cv=none; b=OZift0rqJqN1/lVqrmtGb8UaD1uWION6IPTu0CMCh2hDDVEtyUcp+hOcZB8f+MSR0aQETK76hUjdlbTFxLF70oG8BPCSWtOFxw2Cp4MDfWucTjDF3LgkhiXLSQlpPISyKlF5iJmllBv99DP9LSoySobISYqaUULOYfMUTDRD8aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589440; c=relaxed/simple;
	bh=d8GrdyfSbKrHISgF/oZceKT2zieCpn6boTgGMTZdomw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=u2rcb/e4yhbSE5jkajooN9aNshipFN512TyuhjuoLgK6bHPlkbfnnY52cBrSdOOiIruba3VkLC72FX80PkrQqWtmM4tvmCgsrEhEWxoa1RB5Gc/6+SvfQPSaM73t+NgAoOpjpWDfGBg9XLPC/IQLD428NK2k4D2z/1VE+Uwml5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KJjRKkXx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=+MmaUoREfWUZek2lYGzLDHTOR/aEFKfS9H3PDIashAs=; b=KJjRKkXx+ue9TCa7ifRvrwpLSW
	amegoihVqXqx1boyYik+zVw2fT0N1DfOJl7qm82TfUCaL9hXPF3Q2oGC7ASxViysR9XHmJkcE0u5Y
	8ecKTLwRqwnk6rGOFOBNTv2qPTNezqWnCaGCuBxqG4i0YJD12vmH4oiF6BPL/+9VJ2n/EroTnxymZ
	/9NfWwdMBiGAX3/fnhpoqHInVDTlJUO5JMQZDyh14JysXgz079usq6LCJw8VvArV0eBZX1aUkI7Mh
	Ph5OrRwQfjnmQ9utjOJ5XNIpkYcAfuBt7ccc2xsPcLQZ78oFFpjXdCkyOuC/ilcB4i+Ca70Ub0rJM
	LVobT0qg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se0LW-00000007s19-3TWm;
	Tue, 13 Aug 2024 22:50:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 42918302D54; Wed, 14 Aug 2024 00:50:29 +0200 (CEST)
Message-Id: <20240813224016.051225657@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 14 Aug 2024 00:25:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 tj@kernel.org,
 void@manifault.com
Cc: peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 joelaf@google.com
Subject: [PATCH 5/9] sched: Rework pick_next_task()
References: <20240813222548.049744955@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The current rule is that:

  pick_next_task() := pick_task() + set_next_task(.first = true)

And many classes implement it directly as such. Change things around
to make pick_next_task() optional while also changing the definition to:

  pick_next_task(prev) := pick_task() + put_prev_task() + set_next_task(.first = true)

The reason is that sched_ext would like to have a 'final' call that
knows the next task. By placing put_prev_task() right next to
set_next_task() (as it already is for sched_core) this becomes
trivial.

As a bonus, this is a nice cleanup on its own.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |   21 +++++++++++++++------
 kernel/sched/deadline.c  |   21 +--------------------
 kernel/sched/fair.c      |   11 +++++------
 kernel/sched/idle.c      |   16 ++--------------
 kernel/sched/rt.c        |   13 +------------
 kernel/sched/sched.h     |   16 ++++++++++++----
 kernel/sched/stop_task.c |   13 +------------
 7 files changed, 37 insertions(+), 74 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5893,8 +5893,9 @@ __pick_next_task(struct rq *rq, struct t
 
 		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
+			p = pick_task_idle(rq);
 			put_prev_task(rq, prev);
-			p = pick_next_task_idle(rq);
+			set_next_task_first(rq, p);
 		}
 
 		/*
@@ -5916,12 +5917,20 @@ __pick_next_task(struct rq *rq, struct t
 
 restart:
 	prev_balance(rq, prev, rf);
-	put_prev_task(rq, prev);
 
 	for_each_class(class) {
-		p = class->pick_next_task(rq);
-		if (p)
-			return p;
+		if (class->pick_next_task) {
+			p = class->pick_next_task(rq, prev);
+			if (p)
+				return p;
+		} else {
+			p = class->pick_task(rq);
+			if (p) {
+				put_prev_task(rq, prev);
+				set_next_task_first(rq, p);
+				return p;
+			}
+		}
 	}
 
 	BUG(); /* The idle class should always have a runnable task. */
@@ -6017,7 +6026,6 @@ pick_next_task(struct rq *rq, struct tas
 	}
 
 	prev_balance(rq, prev, rf);
-	put_prev_task(rq, prev);
 
 	smt_mask = cpu_smt_mask(cpu);
 	need_sync = !!rq->core->core_cookie;
@@ -6184,6 +6192,7 @@ pick_next_task(struct rq *rq, struct tas
 	}
 
 out_set_next:
+	put_prev_task(rq, prev);
 	set_next_task_first(rq, next);
 out:
 	if (rq->core->core_forceidle_count && next == rq->idle)
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2437,28 +2437,10 @@ static struct task_struct *__pick_task_d
 	return p;
 }
 
-#ifdef CONFIG_SMP
 static struct task_struct *pick_task_dl(struct rq *rq)
 {
 	return __pick_task_dl(rq);
 }
-#endif
-
-static struct task_struct *pick_next_task_dl(struct rq *rq)
-{
-	struct task_struct *p;
-
-	p = __pick_task_dl(rq);
-	if (!p)
-		return p;
-
-	if (p->dl_server)
-		p->sched_class->set_next_task(rq, p, true);
-	else
-		set_next_task_dl(rq, p, true);
-
-	return p;
-}
 
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
@@ -3152,13 +3134,12 @@ DEFINE_SCHED_CLASS(dl) = {
 
 	.wakeup_preempt		= wakeup_preempt_dl,
 
-	.pick_next_task		= pick_next_task_dl,
+	.pick_task		= pick_task_dl,
 	.put_prev_task		= put_prev_task_dl,
 	.set_next_task		= set_next_task_dl,
 
 #ifdef CONFIG_SMP
 	.balance		= balance_dl,
-	.pick_task		= pick_task_dl,
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8775,7 +8775,7 @@ pick_next_task_fair(struct rq *rq, struc
 	se = &p->se;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (!prev || prev->sched_class != &fair_sched_class)
+	if (prev->sched_class != &fair_sched_class)
 		goto simple;
 
 	/*
@@ -8817,8 +8817,7 @@ pick_next_task_fair(struct rq *rq, struc
 
 simple:
 #endif
-	if (prev)
-		put_prev_task(rq, prev);
+	put_prev_task(rq, prev);
 	set_next_task_fair(rq, p, true);
 	return p;
 
@@ -8848,9 +8847,9 @@ pick_next_task_fair(struct rq *rq, struc
 	return NULL;
 }
 
-static struct task_struct *__pick_next_task_fair(struct rq *rq)
+static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_struct *prev)
 {
-	return pick_next_task_fair(rq, NULL, NULL);
+	return pick_next_task_fair(rq, prev, NULL);
 }
 
 static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
@@ -13487,13 +13486,13 @@ DEFINE_SCHED_CLASS(fair) = {
 
 	.wakeup_preempt		= check_preempt_wakeup_fair,
 
+	.pick_task		= pick_task_fair,
 	.pick_next_task		= __pick_next_task_fair,
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,
 
 #ifdef CONFIG_SMP
 	.balance		= balance_fair,
-	.pick_task		= pick_task_fair,
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -462,21 +462,10 @@ static void set_next_task_idle(struct rq
 	next->se.exec_start = rq_clock_task(rq);
 }
 
-#ifdef CONFIG_SMP
-static struct task_struct *pick_task_idle(struct rq *rq)
+struct task_struct *pick_task_idle(struct rq *rq)
 {
 	return rq->idle;
 }
-#endif
-
-struct task_struct *pick_next_task_idle(struct rq *rq)
-{
-	struct task_struct *next = rq->idle;
-
-	set_next_task_idle(rq, next, true);
-
-	return next;
-}
 
 /*
  * It is not legal to sleep in the idle task - print a warning
@@ -531,13 +520,12 @@ DEFINE_SCHED_CLASS(idle) = {
 
 	.wakeup_preempt		= wakeup_preempt_idle,
 
-	.pick_next_task		= pick_next_task_idle,
+	.pick_task		= pick_task_idle,
 	.put_prev_task		= put_prev_task_idle,
 	.set_next_task          = set_next_task_idle,
 
 #ifdef CONFIG_SMP
 	.balance		= balance_idle,
-	.pick_task		= pick_task_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1748,16 +1748,6 @@ static struct task_struct *pick_task_rt(
 	return p;
 }
 
-static struct task_struct *pick_next_task_rt(struct rq *rq)
-{
-	struct task_struct *p = pick_task_rt(rq);
-
-	if (p)
-		set_next_task_rt(rq, p, true);
-
-	return p;
-}
-
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
@@ -2645,13 +2635,12 @@ DEFINE_SCHED_CLASS(rt) = {
 
 	.wakeup_preempt		= wakeup_preempt_rt,
 
-	.pick_next_task		= pick_next_task_rt,
+	.pick_task		= pick_task_rt,
 	.put_prev_task		= put_prev_task_rt,
 	.set_next_task          = set_next_task_rt,
 
 #ifdef CONFIG_SMP
 	.balance		= balance_rt,
-	.pick_task		= pick_task_rt,
 	.select_task_rq		= select_task_rq_rt,
 	.set_cpus_allowed       = set_cpus_allowed_common,
 	.rq_online              = rq_online_rt,
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2300,7 +2300,17 @@ struct sched_class {
 
 	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
 
-	struct task_struct *(*pick_next_task)(struct rq *rq);
+	struct task_struct *(*pick_task)(struct rq *rq);
+	/*
+	 * Optional! When implemented pick_next_task() should be equivalent to:
+	 *
+	 *   next = pick_task();
+	 *   if (next) {
+	 *       put_prev_task(prev);
+	 *       set_next_task_first(next);
+	 *   }
+	 */
+	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev);
 
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
@@ -2309,8 +2319,6 @@ struct sched_class {
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
 
-	struct task_struct * (*pick_task)(struct rq *rq);
-
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
@@ -2421,7 +2429,7 @@ static inline bool sched_fair_runnable(s
 }
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-extern struct task_struct *pick_next_task_idle(struct rq *rq);
+extern struct task_struct *pick_task_idle(struct rq *rq);
 
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -41,16 +41,6 @@ static struct task_struct *pick_task_sto
 	return rq->stop;
 }
 
-static struct task_struct *pick_next_task_stop(struct rq *rq)
-{
-	struct task_struct *p = pick_task_stop(rq);
-
-	if (p)
-		set_next_task_stop(rq, p, true);
-
-	return p;
-}
-
 static void
 enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
@@ -112,13 +102,12 @@ DEFINE_SCHED_CLASS(stop) = {
 
 	.wakeup_preempt		= wakeup_preempt_stop,
 
-	.pick_next_task		= pick_next_task_stop,
+	.pick_task		= pick_task_stop,
 	.put_prev_task		= put_prev_task_stop,
 	.set_next_task          = set_next_task_stop,
 
 #ifdef CONFIG_SMP
 	.balance		= balance_stop,
-	.pick_task		= pick_task_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif



