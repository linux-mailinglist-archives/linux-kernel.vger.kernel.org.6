Return-Path: <linux-kernel+bounces-393781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8C49BA523
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 11:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD4B1C21165
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7000717B425;
	Sun,  3 Nov 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bd0d+isF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v4Jvru+r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC92170854
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730629872; cv=none; b=ZKy5O4YDV9IYqFhP0haYI9fyfA/zERmccPg31xllNDxThfTY7SxUK1UrTUlINAiXbkcPk0v1qo0Kl0ifLzEo0JJDs2Bd218uLxxsRVZx5ry6XNTg300NY9l/PDuKxE7beyMYq8Fkl6SdMYTL0tOli/7UU+EdVKzBtce4Ew3HzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730629872; c=relaxed/simple;
	bh=pSnFkl5HOUSP2bmovn5TdsHI7GLRFFNfXltoyMx9DP8=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=nXgPzCFx+CfVWCM7x9AJKEpmSt4wVxHkngiTM4P3tptixvmd0J96f2eOFYdr3sqA4ze6kWFjReCRj9e3ig6euL6fxOeUo3S3mpnyn4fnvnItCgJp5ypJNiu320Qe+ILfLfHrHPuOVDHPyKvSTGPbo50dJkA6JcZKnPs8La6QHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bd0d+isF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v4Jvru+r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730629862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=+CMQk6GdJ/gigWgymGursNyHHQSizquZv2WqnRWk1YE=;
	b=bd0d+isFjdJ4xAnMQ7Wd/5+xyjvaCwSl97I7LJnN4kZKMZxvN1YvIfWJiz4QrDPuiu9q8h
	/xATZEbfcYpWk9REVOMTAvy7MPz9izP8S+DtzedZMpQp6EKnery654b+CYIDdDzU2hst80
	0IgQhw7MboECwH9KO9j3fL7MCYWfUFp5ctSUjn8w7nDWUA28tATFQAddKobtuOSeExh37Y
	DVgoZ8fBenxRTtRedpPACWjeWkLpOJZYvA+QSOMvVJe4a4dh6HR8Wf5Mlo4QioHB8C+j7J
	ZoLWDX4ppaB4/VUdYkXh75g8jzbr7p5SOxfWg9cpbyzFfOcYJMuwYhIBhyH5dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730629862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=+CMQk6GdJ/gigWgymGursNyHHQSizquZv2WqnRWk1YE=;
	b=v4Jvru+r1ZzhC5erAXhWOGqkzKIKDMaWdxxqDSU0XZzRPcl0cxPJmhE2UgmPebE9MLxST7
	+3lP4vLNUdGUYbAA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v6.12-rc6
References: <173062982864.1467946.2540622433845043721.tglx@xen13>
Message-ID: <173062983173.1467946.7303190211154698526.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  3 Nov 2024 11:31:02 +0100 (CET)

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-202=
4-11-03

up to:  69d5e722be94: sched/ext: Fix scx vs sched_delayed


A few scheduler fixes:

 - Plug a race between pick_next_task_fair() and try_to_wake_up() where
   both try to write to the same task, even though both paths hold a
   runqueue lock, but obviously from different runqueues.

   The problem is that the store to task::on_rq in __block_task() is
   visible to try_to_wake_up() which assumes that the task is not queued.
   Both sides then operate on the same task.

   Cure it by rearranging __block_task() so the the store to task::on_rq is
   the last operation on the task.

 - Prevent a potential NULL pointer dereference in task_numa_work()

   task_numa_work() iterates the VMAs of a process. A concurrent unmap of
   the address space can result in a NULL pointer return from vma_next()
   which is unchecked.

   Add the missing NULL pointer check to prevent this.

 - Operate on the correct scheduler policy in task_should_scx()

   task_should_scx() returns true when a task should be handled by sched
   EXT. It checks the tasks scheduling policy.

   This fails when the check is done before a policy has been set.

   Cure it by handing the policy into task_should_scx() so it operates
   on the requested value.

 - Add the missing handling of sched EXT in the delayed dequeue
   mechanism. This was simply forgotten.



Thanks,

	tglx

------------------>
Aboorva Devarajan (1):
      sched: Pass correct scheduling policy to __setscheduler_class

Peter Zijlstra (2):
      sched: Fix pick_next_task_fair() vs try_to_wake_up() race
      sched/ext: Fix scx vs sched_delayed

Shawn Wang (1):
      sched/numa: Fix the potential null pointer dereference in task_numa_wor=
k()


 kernel/sched/core.c     |  8 ++++----
 kernel/sched/ext.c      | 18 ++++++++++++++----
 kernel/sched/ext.h      |  2 +-
 kernel/sched/fair.c     | 25 ++++++++++++++++---------
 kernel/sched/sched.h    | 36 +++++++++++++++++++++++++++++++++---
 kernel/sched/syscalls.c |  2 +-
 6 files changed, 69 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dbfb5717d6af..719e0ed1e976 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4711,7 +4711,7 @@ int sched_fork(unsigned long clone_flags, struct task_s=
truct *p)
 	if (rt_prio(p->prio)) {
 		p->sched_class =3D &rt_sched_class;
 #ifdef CONFIG_SCHED_CLASS_EXT
-	} else if (task_should_scx(p)) {
+	} else if (task_should_scx(p->policy)) {
 		p->sched_class =3D &ext_sched_class;
 #endif
 	} else {
@@ -7025,7 +7025,7 @@ int default_wake_function(wait_queue_entry_t *curr, uns=
igned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
=20
-const struct sched_class *__setscheduler_class(struct task_struct *p, int pr=
io)
+const struct sched_class *__setscheduler_class(int policy, int prio)
 {
 	if (dl_prio(prio))
 		return &dl_sched_class;
@@ -7034,7 +7034,7 @@ const struct sched_class *__setscheduler_class(struct t=
ask_struct *p, int prio)
 		return &rt_sched_class;
=20
 #ifdef CONFIG_SCHED_CLASS_EXT
-	if (task_should_scx(p))
+	if (task_should_scx(policy))
 		return &ext_sched_class;
 #endif
=20
@@ -7142,7 +7142,7 @@ void rt_mutex_setprio(struct task_struct *p, struct tas=
k_struct *pi_task)
 		queue_flag &=3D ~DEQUEUE_MOVE;
=20
 	prev_class =3D p->sched_class;
-	next_class =3D __setscheduler_class(p, prio);
+	next_class =3D __setscheduler_class(p->policy, prio);
=20
 	if (prev_class !=3D next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5900b06fd036..721a75489ff5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4256,14 +4256,14 @@ static const struct kset_uevent_ops scx_uevent_ops =
=3D {
  * Used by sched_fork() and __setscheduler_prio() to pick the matching
  * sched_class. dl/rt are already handled.
  */
-bool task_should_scx(struct task_struct *p)
+bool task_should_scx(int policy)
 {
 	if (!scx_enabled() ||
 	    unlikely(scx_ops_enable_state() =3D=3D SCX_OPS_DISABLING))
 		return false;
 	if (READ_ONCE(scx_switching_all))
 		return true;
-	return p->policy =3D=3D SCHED_EXT;
+	return policy =3D=3D SCHED_EXT;
 }
=20
 /**
@@ -4489,11 +4489,16 @@ static void scx_ops_disable_workfn(struct kthread_wor=
k *work)
 	scx_task_iter_start(&sti);
 	while ((p =3D scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class =3D p->sched_class;
+		const struct sched_class *new_class =3D
+			__setscheduler_class(p->policy, p->prio);
 		struct sched_enq_and_set_ctx ctx;
=20
+		if (old_class !=3D new_class && p->se.sched_delayed)
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
=20
-		p->sched_class =3D __setscheduler_class(p, p->prio);
+		p->sched_class =3D new_class;
 		check_class_changing(task_rq(p), p, old_class);
=20
 		sched_enq_and_set_task(&ctx);
@@ -5199,12 +5204,17 @@ static int scx_ops_enable(struct sched_ext_ops *ops, =
struct bpf_link *link)
 	scx_task_iter_start(&sti);
 	while ((p =3D scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class =3D p->sched_class;
+		const struct sched_class *new_class =3D
+			__setscheduler_class(p->policy, p->prio);
 		struct sched_enq_and_set_ctx ctx;
=20
+		if (old_class !=3D new_class && p->se.sched_delayed)
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
=20
 		p->scx.slice =3D SCX_SLICE_DFL;
-		p->sched_class =3D __setscheduler_class(p, p->prio);
+		p->sched_class =3D new_class;
 		check_class_changing(task_rq(p), p, old_class);
=20
 		sched_enq_and_set_task(&ctx);
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 246019519231..b1675bb59fc4 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -18,7 +18,7 @@ bool scx_can_stop_tick(struct rq *rq);
 void scx_rq_activate(struct rq *rq);
 void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
-bool task_should_scx(struct task_struct *p);
+bool task_should_scx(int policy);
 void init_sched_ext_class(void);
=20
 static inline u32 scx_cpuperf_target(s32 cpu)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c157d4860a3b..2d16c8545c71 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3369,7 +3369,7 @@ static void task_numa_work(struct callback_head *work)
 		vma =3D vma_next(&vmi);
 	}
=20
-	do {
+	for (; vma; vma =3D vma_next(&vmi)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
@@ -3491,7 +3491,7 @@ static void task_numa_work(struct callback_head *work)
 		 */
 		if (vma_pids_forced)
 			break;
-	} for_each_vma(vmi, vma);
+	}
=20
 	/*
 	 * If no VMAs are remaining and VMAs were skipped due to the PID
@@ -5625,8 +5625,9 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	struct sched_entity *se =3D pick_eevdf(cfs_rq);
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
-		SCHED_WARN_ON(se->sched_delayed);
-		SCHED_WARN_ON(se->on_rq);
+		/*
+		 * Must not reference @se again, see __block_task().
+		 */
 		return NULL;
 	}
 	return se;
@@ -7176,7 +7177,11 @@ static int dequeue_entities(struct rq *rq, struct sche=
d_entity *se, int flags)
 		/* Fix-up what dequeue_task_fair() skipped */
 		hrtick_update(rq);
=20
-		/* Fix-up what block_task() skipped. */
+		/*
+		 * Fix-up what block_task() skipped.
+		 *
+		 * Must be last, @p might not be valid after this.
+		 */
 		__block_task(rq, p);
 	}
=20
@@ -7193,12 +7198,14 @@ static bool dequeue_task_fair(struct rq *rq, struct t=
ask_struct *p, int flags)
 	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_S=
AVE))))
 		util_est_dequeue(&rq->cfs, p);
=20
-	if (dequeue_entities(rq, &p->se, flags) < 0) {
-		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
+	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
+	if (dequeue_entities(rq, &p->se, flags) < 0)
 		return false;
-	}
=20
-	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
+	/*
+	 * Must not reference @p after dequeue_entities(DEQUEUE_DELAYED).
+	 */
+
 	hrtick_update(rq);
 	return true;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 081519ffab46..6c54a57275cc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2769,8 +2769,6 @@ static inline void sub_nr_running(struct rq *rq, unsign=
ed count)
=20
 static inline void __block_task(struct rq *rq, struct task_struct *p)
 {
-	WRITE_ONCE(p->on_rq, 0);
-	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible++;
=20
@@ -2778,6 +2776,38 @@ static inline void __block_task(struct rq *rq, struct =
task_struct *p)
 		atomic_inc(&rq->nr_iowait);
 		delayacct_blkio_start();
 	}
+
+	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
+
+	/*
+	 * The moment this write goes through, ttwu() can swoop in and migrate
+	 * this task, rendering our rq->__lock ineffective.
+	 *
+	 * __schedule()				try_to_wake_up()
+	 *   LOCK rq->__lock			  LOCK p->pi_lock
+	 *   pick_next_task()
+	 *     pick_next_task_fair()
+	 *       pick_next_entity()
+	 *         dequeue_entities()
+	 *           __block_task()
+	 *             RELEASE p->on_rq =3D 0	  if (p->on_rq && ...)
+	 *					    break;
+	 *
+	 *					  ACQUIRE (after ctrl-dep)
+	 *
+	 *					  cpu =3D select_task_rq();
+	 *					  set_task_cpu(p, cpu);
+	 *					  ttwu_queue()
+	 *					    ttwu_do_activate()
+	 *					      LOCK rq->__lock
+	 *					      activate_task()
+	 *					        STORE p->on_rq =3D 1
+	 *   UNLOCK rq->__lock
+	 *
+	 * Callers must ensure to not reference @p after this -- we no longer
+	 * own it.
+	 */
+	smp_store_release(&p->on_rq, 0);
 }
=20
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
@@ -3800,7 +3830,7 @@ static inline int rt_effective_prio(struct task_struct =
*p, int prio)
=20
 extern int __sched_setscheduler(struct task_struct *p, const struct sched_at=
tr *attr, bool user, bool pi);
 extern int __sched_setaffinity(struct task_struct *p, struct affinity_contex=
t *ctx);
-extern const struct sched_class *__setscheduler_class(struct task_struct *p,=
 int prio);
+extern const struct sched_class *__setscheduler_class(int policy, int prio);
 extern void set_load_weight(struct task_struct *p, bool update_load);
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
 extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 0470bcc3d204..24f9f90b6574 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -707,7 +707,7 @@ int __sched_setscheduler(struct task_struct *p,
 	}
=20
 	prev_class =3D p->sched_class;
-	next_class =3D __setscheduler_class(p, newprio);
+	next_class =3D __setscheduler_class(policy, newprio);
=20
 	if (prev_class !=3D next_class && p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);


