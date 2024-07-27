Return-Path: <linux-kernel+bounces-264101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FEF93DF00
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2D81C21648
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD3E8062E;
	Sat, 27 Jul 2024 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="izh7o+SR"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841DF53373
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078147; cv=none; b=h/zYuxaltwdJo1WjdqEf+OSLIgUca9CWuts3Xv2NZKKKJ378rTtLhpmoPU24L5XxIvQL3xIRLNjxThoUmcZl+V61HMiuDux/F9eE6Xjkakimgz+TI34oML/wF3fyAQdLGWgGznrJE4ZU6/P0cjFnJt2bhbhz043goWV2igL24z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078147; c=relaxed/simple;
	bh=oQpf4g/SySD6xJ/0w+UWEVV5+reLGOg1YKvu+Lqt664=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=p0Ztv1regamJ/U2nAL2m03xNj9zkcggtCX2bblIm5CNYzYYIuhkm8bg8Q+pq2XXPo6utAoz8WL7BBbzyn72ldjZs1O+8ec41Axxdt1zObJc4U0nVyxUBWvJ9jG9JwdXiQZwNGGAl7MVeWAlsDH7+SZ6BKjscq7XLPRJUuQ8A/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=izh7o+SR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=FAkwvs/DyGvaLJA1zsiw9ImjvNqvGv3MsoxpjJVRuYw=; b=izh7o+SRwUt0X1MlRXI9Z8ZmYD
	7/U4kEQCHtjRo+UtdCJJx45Np3FfB6xj1bOsZ6hSXQkH9x0s5n+7wePFyTlqprwtOmSyrba/pf/Y6
	REn3NLSNcygym8nzkX0dom1YVLRJtwdvIqYLJ8HRhJQWgRu6Ke/Ejqb/ZQYVtWJBrqU0wCtCbxMfo
	/eKAQIKYshH/ZJboLstFddQ7RtA8UTP7skRLleRi5tbYW57YlnqzCex5/ugMyeIT+YTlgqtT0k5ZP
	hj4UcDFiQxVzQkXJghax7VUmf3zDZdiWyhIjq1gvmAgWNBeGb04r0Qk8qVIZoSITjlNMRV3zV/m2S
	gA7bWuDQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBh-00000004QN2-3hcN;
	Sat, 27 Jul 2024 11:02:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id F411F308024; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105030.842834421@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:54 +0200
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
Subject: [PATCH 22/24] sched/eevdf: Use sched_attr::sched_runtime to set request/slice suggestion
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Allow applications to directly set a suggested request/slice length using
sched_attr::sched_runtime.

The implementation clamps the value to: 0.1[ms] <= slice <= 100[ms]
which is 1/10 the size of HZ=1000 and 10 times the size of HZ=100.

Applications should strive to use their periodic runtime at a high
confidence interval (95%+) as the target slice. Using a smaller slice
will introduce undue preemptions, while using a larger value will
increase latency.

For all the following examples assume a scheduling quantum of 8, and for
consistency all examples have W=4:

  {A,B,C,D}(w=1,r=8):

  ABCD...
  +---+---+---+---

  t=0, V=1.5				t=1, V=3.5
  A  |------<				A          |------<
  B   |------<				B   |------<
  C    |------<				C    |------<
  D     |------<			D     |------<
  ---+*------+-------+---		---+--*----+-------+---

  t=2, V=5.5				t=3, V=7.5
  A          |------<			A          |------<
  B           |------<			B           |------<
  C    |------<				C            |------<
  D     |------<			D     |------<
  ---+----*--+-------+---		---+------*+-------+---

Note: 4 identical tasks in FIFO order

~~~

  {A,B}(w=1,r=16) C(w=2,r=16)

  AACCBBCC...
  +---+---+---+---

  t=0, V=1.25				t=2, V=5.25
  A  |--------------<                   A                  |--------------<
  B   |--------------<                  B   |--------------<
  C    |------<                         C    |------<
  ---+*------+-------+---               ---+----*--+-------+---

  t=4, V=8.25				t=6, V=12.25
  A                  |--------------<   A                  |--------------<
  B   |--------------<                  B                   |--------------<
  C            |------<                 C            |------<
  ---+-------*-------+---               ---+-------+---*---+---

Note: 1 heavy task -- because q=8, double r such that the deadline of the w=2
      task doesn't go below q.

Note: observe the full schedule becomes: W*max(r_i/w_i) = 4*2q = 8q in length.

Note: the period of the heavy task is half the full period at:
      W*(r_i/w_i) = 4*(2q/2) = 4q

~~~

  {A,C,D}(w=1,r=16) B(w=1,r=8):

  BAACCBDD...
  +---+---+---+---

  t=0, V=1.5				t=1, V=3.5
  A  |--------------<			A  |---------------<
  B   |------<				B           |------<
  C    |--------------<			C    |--------------<
  D     |--------------<		D     |--------------<
  ---+*------+-------+---		---+--*----+-------+---

  t=3, V=7.5				t=5, V=11.5
  A                  |---------------<  A                  |---------------<
  B           |------<                  B           |------<
  C    |--------------<                 C                    |--------------<
  D     |--------------<                D     |--------------<
  ---+------*+-------+---               ---+-------+--*----+---

  t=6, V=13.5
  A                  |---------------<
  B                   |------<
  C                    |--------------<
  D     |--------------<
  ---+-------+----*--+---

Note: 1 short task -- again double r so that the deadline of the short task
      won't be below q. Made B short because its not the leftmost task, but is
      eligible with the 0,1,2,3 spread.

Note: like with the heavy task, the period of the short task observes:
      W*(r_i/w_i) = 4*(1q/1) = 4q

~~~

  A(w=1,r=16) B(w=1,r=8) C(w=2,r=16)

  BCCAABCC...
  +---+---+---+---

  t=0, V=1.25				t=1, V=3.25
  A  |--------------<                   A  |--------------<
  B   |------<                          B           |------<
  C    |------<                         C    |------<
  ---+*------+-------+---               ---+--*----+-------+---

  t=3, V=7.25				t=5, V=11.25
  A  |--------------<                   A                  |--------------<
  B           |------<                  B           |------<
  C            |------<                 C            |------<
  ---+------*+-------+---               ---+-------+--*----+---

  t=6, V=13.25
  A                  |--------------<
  B                   |------<
  C            |------<
  ---+-------+----*--+---

Note: 1 heavy and 1 short task -- combine them all.

Note: both the short and heavy task end up with a period of 4q

~~~

  A(w=1,r=16) B(w=2,r=16) C(w=1,r=8)

  BBCAABBC...
  +---+---+---+---

  t=0, V=1				t=2, V=5
  A  |--------------<                   A  |--------------<
  B   |------<                          B           |------<
  C    |------<                         C    |------<
  ---+*------+-------+---               ---+----*--+-------+---

  t=3, V=7				t=5, V=11
  A  |--------------<                   A                  |--------------<
  B           |------<                  B           |------<
  C            |------<                 C            |------<
  ---+------*+-------+---               ---+-------+--*----+---

  t=7, V=15
  A                  |--------------<
  B                   |------<
  C            |------<
  ---+-------+------*+---

Note: as before but permuted

~~~

>From all this it can be deduced that, for the steady state:

 - the total period (P) of a schedule is:	W*max(r_i/w_i)
 - the average period of a task is:		W*(r_i/w_i)
 - each task obtains the fair share:		w_i/W of each full period P

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |    1 +
 kernel/sched/core.c     |    4 +++-
 kernel/sched/debug.c    |    3 ++-
 kernel/sched/fair.c     |    6 ++++--
 kernel/sched/syscalls.c |   29 +++++++++++++++++++++++------
 5 files changed, 33 insertions(+), 10 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -544,6 +544,7 @@ struct sched_entity {
 	unsigned char			on_rq;
 	unsigned char			sched_delayed;
 	unsigned char			rel_deadline;
+	unsigned char			custom_slice;
 					/* hole */
 
 	u64				exec_start;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4347,7 +4347,6 @@ static void __sched_fork(unsigned long c
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	p->se.vlag			= 0;
-	p->se.slice			= sysctl_sched_base_slice;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 	/* A delayed task cannot be in clone(). */
@@ -4600,6 +4599,8 @@ int sched_fork(unsigned long clone_flags
 
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
+		p->se.custom_slice = 0;
+		p->se.slice = sysctl_sched_base_slice;
 
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
@@ -8328,6 +8329,7 @@ void __init sched_init(void)
 	}
 
 	set_load_weight(&init_task, false);
+	init_task.se.slice = sysctl_sched_base_slice,
 
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -580,11 +580,12 @@ print_task(struct seq_file *m, struct rq
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
 		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
 		SPLIT_NS(p->se.deadline),
+		p->se.custom_slice ? 'S' : ' ',
 		SPLIT_NS(p->se.slice),
 		SPLIT_NS(p->se.sum_exec_runtime),
 		(long long)(p->nvcsw + p->nivcsw),
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -995,7 +995,8 @@ static void update_deadline(struct cfs_r
 	 * nice) while the request time r_i is determined by
 	 * sysctl_sched_base_slice.
 	 */
-	se->slice = sysctl_sched_base_slice;
+	if (!se->custom_slice)
+		se->slice = sysctl_sched_base_slice;
 
 	/*
 	 * EEVDF: vd_i = ve_i + r_i / w_i
@@ -5190,7 +5191,8 @@ place_entity(struct cfs_rq *cfs_rq, stru
 	u64 vslice, vruntime = avg_vruntime(cfs_rq);
 	s64 lag = 0;
 
-	se->slice = sysctl_sched_base_slice;
+	if (!se->custom_slice)
+		se->slice = sysctl_sched_base_slice;
 	vslice = calc_delta_fair(se->slice, se);
 
 	/*
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -401,10 +401,20 @@ static void __setscheduler_params(struct
 
 	p->policy = policy;
 
-	if (dl_policy(policy))
+	if (dl_policy(policy)) {
 		__setparam_dl(p, attr);
-	else if (fair_policy(policy))
+	} else if (fair_policy(policy)) {
 		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
+		if (attr->sched_runtime) {
+			p->se.custom_slice = 1;
+			p->se.slice = clamp_t(u64, attr->sched_runtime,
+					      NSEC_PER_MSEC/10,   /* HZ=1000 * 10 */
+					      NSEC_PER_MSEC*100); /* HZ=100  / 10 */
+		} else {
+			p->se.custom_slice = 0;
+			p->se.slice = sysctl_sched_base_slice;
+		}
+	}
 
 	/*
 	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
@@ -700,7 +710,9 @@ int __sched_setscheduler(struct task_str
 	 * but store a possible modification of reset_on_fork.
 	 */
 	if (unlikely(policy == p->policy)) {
-		if (fair_policy(policy) && attr->sched_nice != task_nice(p))
+		if (fair_policy(policy) &&
+		    (attr->sched_nice != task_nice(p) ||
+		     (attr->sched_runtime != p->se.slice)))
 			goto change;
 		if (rt_policy(policy) && attr->sched_priority != p->rt_priority)
 			goto change;
@@ -846,6 +858,9 @@ static int _sched_setscheduler(struct ta
 		.sched_nice	= PRIO_TO_NICE(p->static_prio),
 	};
 
+	if (p->se.custom_slice)
+		attr.sched_runtime = p->se.slice;
+
 	/* Fixup the legacy SCHED_RESET_ON_FORK hack. */
 	if ((policy != SETPARAM_POLICY) && (policy & SCHED_RESET_ON_FORK)) {
 		attr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
@@ -1012,12 +1027,14 @@ static int sched_copy_attr(struct sched_
 
 static void get_params(struct task_struct *p, struct sched_attr *attr)
 {
-	if (task_has_dl_policy(p))
+	if (task_has_dl_policy(p)) {
 		__getparam_dl(p, attr);
-	else if (task_has_rt_policy(p))
+	} else if (task_has_rt_policy(p)) {
 		attr->sched_priority = p->rt_priority;
-	else
+	} else {
 		attr->sched_nice = task_nice(p);
+		attr->sched_runtime = p->se.slice;
+	}
 }
 
 /**



