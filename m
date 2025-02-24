Return-Path: <linux-kernel+bounces-528680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E452A41A95
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD847188AB80
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEBD2566D7;
	Mon, 24 Feb 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SWAD0CZy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zfJJGlTN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF18255E52
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392141; cv=none; b=BYLxwwUY3kpUVu9ziPBh+YJfLsiQybulI+/n7pGs04zkcTJmIe9Lv3KY1NiV70r9eEvXMLAFu/7w86yFdgOrU/E3WlL8YJ6Q6xTbAA+b3djuGvDiksJfzdt3EkjVYan+t0R1lWPdfjvb4+yzgpNCqoU8nJKao9NIe04BLI+qkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392141; c=relaxed/simple;
	bh=b6vqBPM7oLI2qCBwGwNXQIwjFm8LdkYmoY7Tiawwdms=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FoPw1DDLGT9GdJkQzKJv7fmiEi9GUATmZuUAmtWZ0tVF6KQHRuklkILGXUmgoHB54XxgtbjUQ8r3cThIVwM3KtL+Vts+baa5T15vsfkAiSFhRNQjFIv0BsxHTVDJHw3nWYGg1UpEuaJBqxoVI7wkMWU6lGai9Dlm1UmBM4NUsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SWAD0CZy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zfJJGlTN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250224101343.541884406@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740392138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4tV1GUgLnAdVEwIWzNrAxUrIbNAIQLE9mDU8jfmrq7Y=;
	b=SWAD0CZyKv9UieAnP6IEcWpU294e9IV3rUnj8VoZdOu+p8tvKh9yipOv1Lgi+J8Pn1gjtJ
	BVoWVCrg0xpRmQoxcm/geEGoRWOZVyW2X+o4BEdmDbOVOF5YGxzRVrQ/I0WyTp7NAnGPKg
	snApigB7Z9lwOqg2jmJRvDHM/Vu9Y+tWutFiJSUP7yyTnm/pralOzOxmgwfqi0Qs+ONhQo
	IrXk3gMnW4o74C6L1g2CBYHl1RbK8Ip0tzQlKq0wptwKDL33MuAo9rpTs7BmXesW8g8jyX
	oDDGxzMl5e0zXIh9NGTl/xCOEPU1wOqmpuDyvQCYMayn5BMok58pRi5q+oJwCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740392138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4tV1GUgLnAdVEwIWzNrAxUrIbNAIQLE9mDU8jfmrq7Y=;
	b=zfJJGlTNsjEs5u2Bl5mHyff7rHizl58DkkzUt/VOfW/72BD34Hcw+4FqZwJvbK0dEQqq9K
	MxzeQAUQyG5RHCBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 09/11] posix-timers: Dont iterate /proc/$PID/timers with
 sighand::siglock held
References: <20250224095736.145530367@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 11:15:37 +0100 (CET)

The readout of /proc/$PID/timers holds sighand::siglock with interrupts
disabled. That is required to protect against concurrent modifications of
the task::signal::posix_timers list because the list is not RCU safe.

With the conversion of the timer storage to RCU protected hlist, this is
not longer required.

The only requirement is to protect the returned entry against a concurrent
free, which is trivial as the timers are RCU protected.

Removing the trylock of sighand::siglock is benign because the life time of
task_struct::signal is bound to the life time of the task_struct itself.

There are two scenarios where this matters:

  1) The process is life and not about to be checkpointed

  2) The process is stopped via ptrace for checkpointing

#1 is a racy snapshot of the armed timers and nothing can rely on it. It's
   not more than debug information and it has been that way before because
   sighand lock is dropped when the buffer is full and the restart of
   the iteration might find a completely different set of timers.

   The task and therefore task::signal cannot be freed as timers_start()
   acquired a reference count via get_pid_task().

#2 the process is stopped for checkpointing so nothing can delete or create
   timers at this point. Neither can the process exit during the traversal.

   If CRIU fails to observe an exit in progress prior to the dissimination
   of the timers, then there are more severe problems to solve in the CRIU
   mechanics as they can't rely on posix timers being enabled in the first
   place.

Therefore replace the lock acquisition with rcu_read_lock() and switch the
timer storage traversal over to seq_hlist_*_rcu().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/proc/base.c |   48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2497,11 +2497,9 @@ static const struct file_operations proc
 
 #if defined(CONFIG_CHECKPOINT_RESTORE) && defined(CONFIG_POSIX_TIMERS)
 struct timers_private {
-	struct pid *pid;
-	struct task_struct *task;
-	struct sighand_struct *sighand;
-	struct pid_namespace *ns;
-	unsigned long flags;
+	struct pid		*pid;
+	struct task_struct	*task;
+	struct pid_namespace	*ns;
 };
 
 static void *timers_start(struct seq_file *m, loff_t *pos)
@@ -2512,54 +2510,48 @@ static void *timers_start(struct seq_fil
 	if (!tp->task)
 		return ERR_PTR(-ESRCH);
 
-	tp->sighand = lock_task_sighand(tp->task, &tp->flags);
-	if (!tp->sighand)
-		return ERR_PTR(-ESRCH);
-
-	return seq_hlist_start(&tp->task->signal->posix_timers, *pos);
+	rcu_read_lock();
+	return seq_hlist_start_rcu(&tp->task->signal->posix_timers, *pos);
 }
 
 static void *timers_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct timers_private *tp = m->private;
-	return seq_hlist_next(v, &tp->task->signal->posix_timers, pos);
+
+	return seq_hlist_next_rcu(v, &tp->task->signal->posix_timers, pos);
 }
 
 static void timers_stop(struct seq_file *m, void *v)
 {
 	struct timers_private *tp = m->private;
 
-	if (tp->sighand) {
-		unlock_task_sighand(tp->task, &tp->flags);
-		tp->sighand = NULL;
-	}
-
 	if (tp->task) {
 		put_task_struct(tp->task);
 		tp->task = NULL;
+		rcu_read_unlock();
 	}
 }
 
 static int show_timer(struct seq_file *m, void *v)
 {
-	struct k_itimer *timer;
-	struct timers_private *tp = m->private;
-	int notify;
 	static const char * const nstr[] = {
-		[SIGEV_SIGNAL] = "signal",
-		[SIGEV_NONE] = "none",
-		[SIGEV_THREAD] = "thread",
+		[SIGEV_SIGNAL]	= "signal",
+		[SIGEV_NONE]	= "none",
+		[SIGEV_THREAD]	= "thread",
 	};
 
-	timer = hlist_entry((struct hlist_node *)v, struct k_itimer, list);
-	notify = timer->it_sigev_notify;
+	struct k_itimer *timer = hlist_entry((struct hlist_node *)v, struct k_itimer, list);
+	struct timers_private *tp = m->private;
+	int notify = timer->it_sigev_notify;
+
+	guard(spinlock_irq)(&timer->it_lock);
+	if (!posixtimer_valid(timer))
+		return 0;
 
 	seq_printf(m, "ID: %d\n", timer->it_id);
-	seq_printf(m, "signal: %d/%px\n",
-		   timer->sigq.info.si_signo,
+	seq_printf(m, "signal: %d/%px\n", timer->sigq.info.si_signo,
 		   timer->sigq.info.si_value.sival_ptr);
-	seq_printf(m, "notify: %s/%s.%d\n",
-		   nstr[notify & ~SIGEV_THREAD_ID],
+	seq_printf(m, "notify: %s/%s.%d\n", nstr[notify & ~SIGEV_THREAD_ID],
 		   (notify & SIGEV_THREAD_ID) ? "tid" : "pid",
 		   pid_nr_ns(timer->it_pid, tp->ns));
 	seq_printf(m, "ClockID: %d\n", timer->it_clock);


