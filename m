Return-Path: <linux-kernel+bounces-357915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2BA9977B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02C21C22343
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700661E5705;
	Wed,  9 Oct 2024 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwIif6jt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21441E490B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510260; cv=none; b=uAt1pQKy7kKysrE6NlSTMSheNkbGTrS4EDYrWIwJyY8Pc+iDRpEnWZLmJxzEHgj2BnREssE9Arpf1FsN45mihA46CvGt7JSXx8xixlVuAZI0WF/XBRneLQDQUMQakZNZymZHKNR+MiWWlcPduFdCKyy13aZv+zdP3+ugyV9rtks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510260; c=relaxed/simple;
	bh=AgKP+8abQJv46PIY1RuXb+MmpzSJtVJ7dpaRlvSmcPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ga7qYcMKMBsF6XY3seGbmqIPBTEppYbEsVq1jfegUfKOKB8xL+hR39BVBFPlGgF3AbKXUvz/1l9HshE5Chs0sU5ZbwyxdzoWJ8svPpUIT3E0M2EWdKZkf2uaXwm+C32U5TeAM92cmHaUcEX8BbrvXCocPKPwrNTu3aIPk1r8cX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwIif6jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D15C4CED0;
	Wed,  9 Oct 2024 21:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728510259;
	bh=AgKP+8abQJv46PIY1RuXb+MmpzSJtVJ7dpaRlvSmcPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kwIif6jtnUrVJIZb8btP/FCzXHNp9cq3Szv+fEspuFn092jyuyDVCROn0UtLozfnt
	 45K5ye3N3mJMx9jhEZ0B4PMIvT3ZmEZs41C9TlUzCk0eOho5Ta2bobm+12A3l/GnEr
	 KNW2IY1Ec+0NrxGnSjC36y2kcwuokAtL7sdUecFFk0oFwam0wiHRuAYT4kAvSvf+Yb
	 hrA9pm9BjxksJUqJRU4fAc6Cm9mSmGbGdZDhEiQGshOV5O6I88rYO6E0d94UOR146V
	 jjDiTdu9kvfme7upktLPY02bDLI0MxlBzy4B8xonD1uO6eYgA7hrD9URgFjXYdHuEw
	 ZKr1N0bl+GCRw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] sched_ext: Move scx_tasks_lock handling into scx_task_iter helpers
Date: Wed,  9 Oct 2024 11:41:01 -1000
Message-ID: <20241009214411.681233-6-tj@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009214411.681233-1-tj@kernel.org>
References: <20241009214411.681233-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterating with scx_task_iter involves scx_tasks_lock and optionally the rq
lock of the task being iterated. Both locks can be released during iteration
and the iteration can be continued after re-grabbing scx_tasks_lock.
Currently, all lock handling is pushed to the caller which is a bit
cumbersome and makes it difficult to add lock-aware behaviors. Make the
scx_task_iter helpers handle scx_tasks_lock.

- scx_task_iter_init/scx_taks_iter_exit() now grabs and releases
  scx_task_lock, respectively. Renamed to
  scx_task_iter_start/scx_task_iter_stop() to more clearly indicate that
  there are non-trivial side-effects.

- Add __ prefix to scx_task_iter_rq_unlock() to indicate that the function
  is internal.

- Add scx_task_iter_unlock/relock(). The former drops both rq lock (if held)
  and scx_tasks_lock and the latter re-locks only scx_tasks_lock.

This doesn't cause behavior changes and will be used to implement stall
avoidance.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 110 +++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 54 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c5cda7368de5..d53c7a365fec 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1276,76 +1276,86 @@ struct scx_task_iter {
 };
 
 /**
- * scx_task_iter_init - Initialize a task iterator
+ * scx_task_iter_start - Lock scx_tasks_lock and start a task iteration
  * @iter: iterator to init
  *
- * Initialize @iter. Must be called with scx_tasks_lock held. Once initialized,
- * @iter must eventually be exited with scx_task_iter_exit().
+ * Initialize @iter and return with scx_tasks_lock held. Once initialized, @iter
+ * must eventually be stopped with scx_task_iter_stop().
  *
- * scx_tasks_lock may be released between this and the first next() call or
- * between any two next() calls. If scx_tasks_lock is released between two
- * next() calls, the caller is responsible for ensuring that the task being
- * iterated remains accessible either through RCU read lock or obtaining a
- * reference count.
+ * scx_tasks_lock and the rq lock may be released using scx_task_iter_unlock()
+ * between this and the first next() call or between any two next() calls. If
+ * the locks are released between two next() calls, the caller is responsible
+ * for ensuring that the task being iterated remains accessible either through
+ * RCU read lock or obtaining a reference count.
  *
  * All tasks which existed when the iteration started are guaranteed to be
  * visited as long as they still exist.
  */
-static void scx_task_iter_init(struct scx_task_iter *iter)
+static void scx_task_iter_start(struct scx_task_iter *iter)
 {
-	lockdep_assert_held(&scx_tasks_lock);
-
 	BUILD_BUG_ON(__SCX_DSQ_ITER_ALL_FLAGS &
 		     ((1U << __SCX_DSQ_LNODE_PRIV_SHIFT) - 1));
 
+	spin_lock_irq(&scx_tasks_lock);
+
 	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
 	list_add(&iter->cursor.tasks_node, &scx_tasks);
 	iter->locked = NULL;
 }
 
+static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
+{
+	if (iter->locked) {
+		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
+		iter->locked = NULL;
+	}
+}
+
 /**
- * scx_task_iter_rq_unlock - Unlock rq locked by a task iterator
- * @iter: iterator to unlock rq for
+ * scx_task_iter_unlock - Unlock rq and scx_tasks_lock held by a task iterator
+ * @iter: iterator to unlock
  *
  * If @iter is in the middle of a locked iteration, it may be locking the rq of
- * the task currently being visited. Unlock the rq if so. This function can be
- * safely called anytime during an iteration.
+ * the task currently being visited in addition to scx_tasks_lock. Unlock both.
+ * This function can be safely called anytime during an iteration.
+ */
+static void scx_task_iter_unlock(struct scx_task_iter *iter)
+{
+	__scx_task_iter_rq_unlock(iter);
+	spin_unlock_irq(&scx_tasks_lock);
+}
+
+/**
+ * scx_task_iter_relock - Lock scx_tasks_lock released by scx_task_iter_unlock()
+ * @iter: iterator to re-lock
  *
- * Returns %true if the rq @iter was locking is unlocked. %false if @iter was
- * not locking an rq.
+ * Re-lock scx_tasks_lock unlocked by scx_task_iter_unlock(). Note that it
+ * doesn't re-lock the rq lock. Must be called before other iterator operations.
  */
-static bool scx_task_iter_rq_unlock(struct scx_task_iter *iter)
+static void scx_task_iter_relock(struct scx_task_iter *iter)
 {
-	if (iter->locked) {
-		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
-		iter->locked = NULL;
-		return true;
-	} else {
-		return false;
-	}
+	spin_lock_irq(&scx_tasks_lock);
 }
 
 /**
- * scx_task_iter_exit - Exit a task iterator
+ * scx_task_iter_stop - Stop a task iteration and unlock scx_tasks_lock
  * @iter: iterator to exit
  *
- * Exit a previously initialized @iter. Must be called with scx_tasks_lock held.
- * If the iterator holds a task's rq lock, that rq lock is released. See
- * scx_task_iter_init() for details.
+ * Exit a previously initialized @iter. Must be called with scx_tasks_lock held
+ * which is released on return. If the iterator holds a task's rq lock, that rq
+ * lock is also released. See scx_task_iter_start() for details.
  */
-static void scx_task_iter_exit(struct scx_task_iter *iter)
+static void scx_task_iter_stop(struct scx_task_iter *iter)
 {
-	lockdep_assert_held(&scx_tasks_lock);
-
-	scx_task_iter_rq_unlock(iter);
 	list_del_init(&iter->cursor.tasks_node);
+	scx_task_iter_unlock(iter);
 }
 
 /**
  * scx_task_iter_next - Next task
  * @iter: iterator to walk
  *
- * Visit the next task. See scx_task_iter_init() for details.
+ * Visit the next task. See scx_task_iter_start() for details.
  */
 static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
 {
@@ -1373,14 +1383,14 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
  * @include_dead: Whether we should include dead tasks in the iteration
  *
  * Visit the non-idle task with its rq lock held. Allows callers to specify
- * whether they would like to filter out dead tasks. See scx_task_iter_init()
+ * whether they would like to filter out dead tasks. See scx_task_iter_start()
  * for details.
  */
 static struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
 {
 	struct task_struct *p;
 
-	scx_task_iter_rq_unlock(iter);
+	__scx_task_iter_rq_unlock(iter);
 
 	while ((p = scx_task_iter_next(iter))) {
 		/*
@@ -4462,8 +4472,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 
 	scx_ops_init_task_enabled = false;
 
-	spin_lock_irq(&scx_tasks_lock);
-	scx_task_iter_init(&sti);
+	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
 		struct sched_enq_and_set_ctx ctx;
@@ -4478,8 +4487,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 		check_class_changed(task_rq(p), p, old_class, p->prio);
 		scx_ops_exit_task(p);
 	}
-	scx_task_iter_exit(&sti);
-	spin_unlock_irq(&scx_tasks_lock);
+	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
 
 	/* no task is on scx, turn off all the switches and flush in-progress calls */
@@ -5130,8 +5138,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (ret)
 		goto err_disable_unlock_all;
 
-	spin_lock_irq(&scx_tasks_lock);
-	scx_task_iter_init(&sti);
+	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		/*
 		 * @p may already be dead, have lost all its usages counts and
@@ -5141,15 +5148,13 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		if (!tryget_task_struct(p))
 			continue;
 
-		scx_task_iter_rq_unlock(&sti);
-		spin_unlock_irq(&scx_tasks_lock);
+		scx_task_iter_unlock(&sti);
 
 		ret = scx_ops_init_task(p, task_group(p), false);
 		if (ret) {
 			put_task_struct(p);
-			spin_lock_irq(&scx_tasks_lock);
-			scx_task_iter_exit(&sti);
-			spin_unlock_irq(&scx_tasks_lock);
+			scx_task_iter_relock(&sti);
+			scx_task_iter_stop(&sti);
 			scx_ops_error("ops.init_task() failed (%d) for %s[%d]",
 				      ret, p->comm, p->pid);
 			goto err_disable_unlock_all;
@@ -5158,10 +5163,9 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		scx_set_task_state(p, SCX_TASK_READY);
 
 		put_task_struct(p);
-		spin_lock_irq(&scx_tasks_lock);
+		scx_task_iter_relock(&sti);
 	}
-	scx_task_iter_exit(&sti);
-	spin_unlock_irq(&scx_tasks_lock);
+	scx_task_iter_stop(&sti);
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
@@ -5178,8 +5182,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * scx_tasks_lock.
 	 */
 	percpu_down_write(&scx_fork_rwsem);
-	spin_lock_irq(&scx_tasks_lock);
-	scx_task_iter_init(&sti);
+	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
 		struct sched_enq_and_set_ctx ctx;
@@ -5194,8 +5197,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 		check_class_changed(task_rq(p), p, old_class, p->prio);
 	}
-	scx_task_iter_exit(&sti);
-	spin_unlock_irq(&scx_tasks_lock);
+	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
 
 	scx_ops_bypass(false);
-- 
2.46.2


