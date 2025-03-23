Return-Path: <linux-kernel+bounces-572920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5A2A6D06F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C4616E7E7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108E719CCF4;
	Sun, 23 Mar 2025 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OXErBfz9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OFQ8JkgI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F3198850
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752308; cv=none; b=pUSHeSfABECzVpmb3NS8kgR0JKdOv750CLxvPxTfN2uFdb1PUfCFH+cYXMDVUAsP5PEZCaCKicRMRQtcCwwfBgspqBjny2p3HmtDIWFos70uIaSmZAZGbZ7vgidPZyyTmNFeOfXbeD3oKdB80FzcB48a5x0t1CP26Yyv9Y+KS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752308; c=relaxed/simple;
	bh=FMHZXBgFTevo75mNgfS8ltcq4a+YErZCJ2PRTeDNdWE=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=gqsfmdYsSlU3VBS24VNfH4wAtnjlod4ltUmVBCbD4BowzfGVFSMN6UDdINKf+XgMf6T8YGK/o2Uoh1OHOTNPAaeKRZF/hWcmNhz7yI2moJRQIF8OyPnXaeqMjrJnCq5GlKVaSnOxLJHF7W1TTtlVXGzhtNR0w13atsFuU+EOj4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OXErBfz9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OFQ8JkgI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742752302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=fxLtMOlsZ3PL2wDTjb5bt/QPNrUJp0vAibe1+sa+CRU=;
	b=OXErBfz95E1QtEMRYOQrcRGIHZE3oA+WF9Z5lGnTfdpy+nw1rMQ4Y7UeoM17ju89QSyAWI
	r0tlW0IkI0Y0srme3gZ/RYcLhB90RRGhKZ2pBgzj4BhVOE9E1+Gv1DwZfersNV1pMUYctd
	QhaSrE2YvRqStxrvqCbPHOrDxxjdjzVfXlKpPIP5YRj2WZeZSIfKt0i5Z+UedFpYYSgoPX
	Oz+DQI82RdC1B/ZFABMEdISCZG8t8oq/nB8YsO3qeJnL9TUhVOL27phNfMQiQ/eQ1qYRK6
	6H45WvwXTVQ7DTIPKHNCpTnIjkB532qeyZKlTcmPhlN1i+7yqao6n2B5s3PnkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742752302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=fxLtMOlsZ3PL2wDTjb5bt/QPNrUJp0vAibe1+sa+CRU=;
	b=OFQ8JkgI9R/PBQUVw/mUVM6Vv53zAtKc80KPd3t6qW2/M6LnOlB9BeBY5OsJXpTgvDkNq2
	DW/1jLCIvC8qPwDA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.15-rc1
References: <174275225552.1561082.4969731002775597670.tglx@xen13>
Message-ID: <174275226396.1561082.10349819324827548938.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Mar 2025 18:51:42 +0100 (CET)

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2025=
-03-23

up to:  e40d3709c022: selftests/timers: Improve skew_consistency by testing w=
ith other clockids


Updates for the core time/timer subsystem:

  - Fix a memory ordering issue in posix-timers

    Posix-timer lookup is lockless and reevaluates the timer validity under
    the timer lock, but the update which validates the timer is not
    protected by the timer lock. That allows the store to be reordered
    against the initialization stores, so that the lookup side can observe
    a partially initialized timer. That's mostly a theoretical problem, but
    incorrect nevertheless.

  - Fix a long standing inconsistency of the coarse time getters

    The coarse time getters read the base time of the current update cycle
    without reading the actual hardware clock. NTP frequency adjustment can
    set the base time backwards. The fine grained interfaces compensate
    this by reading the clock and applying the new conversion factor, but
    the coarse grained time getters use the base time directly. That allows
    the user to observe time going backwards.

    Cure it by always forwarding base time, when NTP changes the frequency
    with an immediate step.

  - Rework of posix-timer hashing

    The posix-timer hash is not scalable and due to the CRIU timer restore
    mechanism prone to massive contention on the global hash bucket lock.

    Replace the global hash lock with a fine grained per bucket locking
    scheme to address that.

  - Rework the proc/$PID/timers interface.

    /proc/$PID/timers is provided for CRIU to be able to restore a
    timer. The printout happens with sighand lock held and interrupts
    disabled. That's not required as this can be done with RCU protection
    as well.

  - Provide a sane mechanism for CRIU to restore a timer ID

    CRIU restores timers by creating and deleting them until the kernel
    internal per process ID counter reached the requested ID. That's
    horribly slow for sparse timer IDs.

    Provide a prctl() which allows CRIU to restore a timer with a given
    ID. When enabled the ID pointer is used as input pointer to read the
    requested ID from user space. When disabled, the normal allocation
    scheme (next ID) is active as before. This is backwards compatible for
    both kernel and user space.

  - Make hrtimer_update_function() less expensive.

    The sanity checks are valuable, but expensive for high frequency usage
    in io/uring. Make the debug checks conditional and enable them only
    when lockdep is enabled.

  - Small updates, cleanups and improvements

Thanks,

	tglx

------------------>
Andy Shevchenko (1):
      hrtimers: Replace hrtimer_clock_to_base_table with switch-case

Benjamin Segall (1):
      posix-timers: Invoke cond_resched() during exit_itimers()

Cyrill Gorcunov (1):
      posix-timers: Drop redundant memset() invocation

Eric Dumazet (3):
      posix-timers: Initialise timer before adding it to the hash table
      posix-timers: Add cond_resched() to posix_timer_add() search loop
      posix-timers: Make signal_struct:: Next_posix_timer_id an atomic_t

John Stultz (2):
      timekeeping: Fix possible inconsistencies in _COARSE clockids
      selftests/timers: Improve skew_consistency by testing with other clocki=
ds

Peter Zijlstra (1):
      posix-timers: Make lock_timer() use guard()

Thomas Gleixner (15):
      hrtimers: Make hrtimer_update_function() less expensive
      posix-timers: Ensure that timer initialization is fully visible
      posix-timers: Cleanup includes
      posix-timers: Remove a few paranoid warnings
      posix-timers: Remove SLAB_PANIC from kmem cache
      posix-timers: Use guards in a few places
      posix-timers: Simplify lock/unlock_timer()
      posix-timers: Rework timer removal
      posix-timers: Improve hash table performance
      posix-timers: Switch to jhash32()
      posix-timers: Avoid false cacheline sharing
      posix-timers: Make per process list RCU safe
      posix-timers: Dont iterate /proc/$PID/timers with sighand:: Siglock held
      posix-timers: Provide a mechanism to allocate a given timer ID
      selftests/timers/posix-timers: Add a test for exact allocation mode

Thomas Wei=C3=9Fschuh (2):
      posix-clock: Remove duplicate compat ioctl() handler
      timer_list: Don't use %pK through printk()

Thorsten Blum (1):
      clocksource: Remove unnecessary strscpy() size argument


 fs/proc/base.c                                    |  48 +-
 include/linux/cleanup.h                           |  22 +-
 include/linux/hrtimer.h                           |   3 +-
 include/linux/posix-timers.h                      |  30 +-
 include/linux/sched/signal.h                      |   3 +-
 include/uapi/linux/prctl.h                        |  11 +
 kernel/signal.c                                   |   2 +-
 kernel/sys.c                                      |   5 +
 kernel/time/clocksource.c                         |   2 +-
 kernel/time/hrtimer.c                             |  29 +-
 kernel/time/posix-clock.c                         |  24 +-
 kernel/time/posix-timers.c                        | 551 ++++++++++++--------=
--
 kernel/time/timekeeping.c                         |  94 +++-
 kernel/time/timer_list.c                          |   4 +-
 tools/testing/selftests/timers/posix_timers.c     |  73 ++-
 tools/testing/selftests/timers/skew_consistency.c |   2 +-
 16 files changed, 524 insertions(+), 379 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index cd89e956c322..5a1d6825c416 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2497,11 +2497,9 @@ static const struct file_operations proc_map_files_ope=
rations =3D {
=20
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
=20
 static void *timers_start(struct seq_file *m, loff_t *pos)
@@ -2512,54 +2510,48 @@ static void *timers_start(struct seq_file *m, loff_t =
*pos)
 	if (!tp->task)
 		return ERR_PTR(-ESRCH);
=20
-	tp->sighand =3D lock_task_sighand(tp->task, &tp->flags);
-	if (!tp->sighand)
-		return ERR_PTR(-ESRCH);
-
-	return seq_hlist_start(&tp->task->signal->posix_timers, *pos);
+	rcu_read_lock();
+	return seq_hlist_start_rcu(&tp->task->signal->posix_timers, *pos);
 }
=20
 static void *timers_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct timers_private *tp =3D m->private;
-	return seq_hlist_next(v, &tp->task->signal->posix_timers, pos);
+
+	return seq_hlist_next_rcu(v, &tp->task->signal->posix_timers, pos);
 }
=20
 static void timers_stop(struct seq_file *m, void *v)
 {
 	struct timers_private *tp =3D m->private;
=20
-	if (tp->sighand) {
-		unlock_task_sighand(tp->task, &tp->flags);
-		tp->sighand =3D NULL;
-	}
-
 	if (tp->task) {
 		put_task_struct(tp->task);
 		tp->task =3D NULL;
+		rcu_read_unlock();
 	}
 }
=20
 static int show_timer(struct seq_file *m, void *v)
 {
-	struct k_itimer *timer;
-	struct timers_private *tp =3D m->private;
-	int notify;
 	static const char * const nstr[] =3D {
-		[SIGEV_SIGNAL] =3D "signal",
-		[SIGEV_NONE] =3D "none",
-		[SIGEV_THREAD] =3D "thread",
+		[SIGEV_SIGNAL]	=3D "signal",
+		[SIGEV_NONE]	=3D "none",
+		[SIGEV_THREAD]	=3D "thread",
 	};
=20
-	timer =3D hlist_entry((struct hlist_node *)v, struct k_itimer, list);
-	notify =3D timer->it_sigev_notify;
+	struct k_itimer *timer =3D hlist_entry((struct hlist_node *)v, struct k_iti=
mer, list);
+	struct timers_private *tp =3D m->private;
+	int notify =3D timer->it_sigev_notify;
+
+	guard(spinlock_irq)(&timer->it_lock);
+	if (!posixtimer_valid(timer))
+		return 0;
=20
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
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index ec00e3f7af2b..a176abfccba8 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -291,11 +291,21 @@ static inline class_##_name##_t class_##_name##ext##_co=
nstructor(_init_args) \
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
 static __maybe_unused const bool class_##_name##_is_conditional =3D _is_cond
=20
-#define DEFINE_GUARD(_name, _type, _lock, _unlock) \
+#define __DEFINE_GUARD_LOCK_PTR(_name, _exp) \
+	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
+	{ return (void *)(__force unsigned long)*(_exp); }
+
+#define DEFINE_CLASS_IS_GUARD(_name) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
+	__DEFINE_GUARD_LOCK_PTR(_name, _T)
+
+#define DEFINE_CLASS_IS_COND_GUARD(_name) \
+	__DEFINE_CLASS_IS_CONDITIONAL(_name, true); \
+	__DEFINE_GUARD_LOCK_PTR(_name, _T)
+
+#define DEFINE_GUARD(_name, _type, _lock, _unlock) \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T=
); \
-	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return (void *)(__force unsigned long)*_T; }
+	DEFINE_CLASS_IS_GUARD(_name)
=20
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
@@ -375,11 +385,7 @@ static inline void class_##_name##_destructor(class_##_n=
ame##_t *_T)	\
 	if (_T->lock) { _unlock; }					\
 }									\
 									\
-static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
-{									\
-	return (void *)(__force unsigned long)_T->lock;			\
-}
-
+__DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
=20
 #define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
 static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index f7bfdcf0dda3..bdd55c1f0d73 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -333,6 +333,7 @@ static inline int hrtimer_callback_running(struct hrtimer=
 *timer)
 static inline void hrtimer_update_function(struct hrtimer *timer,
 					   enum hrtimer_restart (*function)(struct hrtimer *))
 {
+#ifdef CONFIG_PROVE_LOCKING
 	guard(raw_spinlock_irqsave)(&timer->base->cpu_base->lock);
=20
 	if (WARN_ON_ONCE(hrtimer_is_queued(timer)))
@@ -340,7 +341,7 @@ static inline void hrtimer_update_function(struct hrtimer=
 *timer,
=20
 	if (WARN_ON_ONCE(!function))
 		return;
-
+#endif
 	timer->function =3D function;
 }
=20
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index f11f10c97bd9..dd48c64b605e 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -114,6 +114,7 @@ bool posixtimer_init_sigqueue(struct sigqueue *q);
 void posixtimer_send_sigqueue(struct k_itimer *tmr);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue =
*timer_sigq);
 void posixtimer_free_timer(struct k_itimer *timer);
+long posixtimer_create_prctl(unsigned long ctrl);
=20
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -140,6 +141,7 @@ static inline void posixtimer_rearm_itimer(struct task_st=
ruct *p) { }
 static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info,
 					     struct sigqueue *timer_sigq) { return false; }
 static inline void posixtimer_free_timer(struct k_itimer *timer) { }
+static inline long posixtimer_create_prctl(unsigned long ctrl) { return -EIN=
VAL; }
 #endif
=20
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
@@ -177,23 +179,26 @@ static inline void posix_cputimers_init_work(void) { }
  * @rcu:		RCU head for freeing the timer.
  */
 struct k_itimer {
-	struct hlist_node	list;
-	struct hlist_node	ignored_list;
+	/* 1st cacheline contains read-mostly fields */
 	struct hlist_node	t_hash;
-	spinlock_t		it_lock;
-	const struct k_clock	*kclock;
-	clockid_t		it_clock;
+	struct hlist_node	list;
 	timer_t			it_id;
+	clockid_t		it_clock;
+	int			it_sigev_notify;
+	enum pid_type		it_pid_type;
+	struct signal_struct	*it_signal;
+	const struct k_clock	*kclock;
+
+	/* 2nd cacheline and above contain fields which are modified regularly */
+	spinlock_t		it_lock;
 	int			it_status;
 	bool			it_sig_periodic;
 	s64			it_overrun;
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
 	unsigned int		it_sigqueue_seq;
-	int			it_sigev_notify;
-	enum pid_type		it_pid_type;
 	ktime_t			it_interval;
-	struct signal_struct	*it_signal;
+	struct hlist_node	ignored_list;
 	union {
 		struct pid		*it_pid;
 		struct task_struct	*it_process;
@@ -210,7 +215,7 @@ struct k_itimer {
 		} alarm;
 	} it;
 	struct rcu_head		rcu;
-};
+} ____cacheline_aligned_in_smp;
=20
 void run_posix_cpu_timers(void);
 void posix_cpu_timers_exit(struct task_struct *task);
@@ -240,6 +245,13 @@ static inline void posixtimer_sigqueue_putref(struct sig=
queue *q)
=20
 	posixtimer_putref(tmr);
 }
+
+static inline bool posixtimer_valid(const struct k_itimer *timer)
+{
+	unsigned long val =3D (unsigned long)timer->it_signal;
+
+	return !(val & 0x1UL);
+}
 #else  /* CONFIG_POSIX_TIMERS */
 static inline void posixtimer_sigqueue_getref(struct sigqueue *q) { }
 static inline void posixtimer_sigqueue_putref(struct sigqueue *q) { }
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index d5d03d919df8..1ef1edbaaf79 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -136,7 +136,8 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
=20
 	/* POSIX.1b Interval Timers */
-	unsigned int		next_posix_timer_id;
+	unsigned int		timer_create_restore_ids:1;
+	atomic_t		next_posix_timer_id;
 	struct hlist_head	posix_timers;
 	struct hlist_head	ignored_posix_timers;
=20
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 5c6080680cb2..15c18ef4eb11 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -353,4 +353,15 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      76
=20
+/*
+ * Controls the mode of timer_create() for CRIU restore operations.
+ * Enabling this allows CRIU to restore timers with explicit IDs.
+ *
+ * Don't use for normal operations as the result might be undefined.
+ */
+#define PR_TIMER_CREATE_RESTORE_IDS		77
+# define PR_TIMER_CREATE_RESTORE_IDS_OFF	0
+# define PR_TIMER_CREATE_RESTORE_IDS_ON		1
+# define PR_TIMER_CREATE_RESTORE_IDS_GET	2
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/signal.c b/kernel/signal.c
index 875e97f6205a..bb62104fa0a2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2092,7 +2092,7 @@ static inline void posixtimer_sig_ignore(struct task_st=
ruct *tsk, struct sigqueu
 	 * from a non-periodic timer, then just drop the reference
 	 * count. Otherwise queue it on the ignored list.
 	 */
-	if (tmr->it_signal && tmr->it_sig_periodic)
+	if (posixtimer_valid(tmr) && tmr->it_sig_periodic)
 		hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
 	else
 		posixtimer_putref(tmr);
diff --git a/kernel/sys.c b/kernel/sys.c
index cb366ff8703a..982e1c465f50 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2811,6 +2811,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg=
2, unsigned long, arg3,
 			return -EINVAL;
 		error =3D arch_lock_shadow_stack_status(me, arg2);
 		break;
+	case PR_TIMER_CREATE_RESTORE_IDS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error =3D posixtimer_create_prctl(arg2);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error =3D -EINVAL;
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 2a7802ec480c..e0eeacbe2521 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1510,7 +1510,7 @@ static int __init boot_override_clocksource(char* str)
 {
 	mutex_lock(&clocksource_mutex);
 	if (str)
-		strscpy(override_name, str, sizeof(override_name));
+		strscpy(override_name, str);
 	mutex_unlock(&clocksource_mutex);
 	return 1;
 }
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index deb1aa32814e..453dc76c9348 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -117,16 +117,6 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
=3D
 	.csd =3D CSD_INIT(retrigger_next_event, NULL)
 };
=20
-static const int hrtimer_clock_to_base_table[MAX_CLOCKS] =3D {
-	/* Make sure we catch unsupported clockids */
-	[0 ... MAX_CLOCKS - 1]	=3D HRTIMER_MAX_CLOCK_BASES,
-
-	[CLOCK_REALTIME]	=3D HRTIMER_BASE_REALTIME,
-	[CLOCK_MONOTONIC]	=3D HRTIMER_BASE_MONOTONIC,
-	[CLOCK_BOOTTIME]	=3D HRTIMER_BASE_BOOTTIME,
-	[CLOCK_TAI]		=3D HRTIMER_BASE_TAI,
-};
-
 static inline bool hrtimer_base_is_online(struct hrtimer_cpu_base *base)
 {
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
@@ -1587,14 +1577,19 @@ u64 hrtimer_next_event_without(const struct hrtimer *=
exclude)
=20
 static inline int hrtimer_clockid_to_base(clockid_t clock_id)
 {
-	if (likely(clock_id < MAX_CLOCKS)) {
-		int base =3D hrtimer_clock_to_base_table[clock_id];
-
-		if (likely(base !=3D HRTIMER_MAX_CLOCK_BASES))
-			return base;
+	switch (clock_id) {
+	case CLOCK_REALTIME:
+		return HRTIMER_BASE_REALTIME;
+	case CLOCK_MONOTONIC:
+		return HRTIMER_BASE_MONOTONIC;
+	case CLOCK_BOOTTIME:
+		return HRTIMER_BASE_BOOTTIME;
+	case CLOCK_TAI:
+		return HRTIMER_BASE_TAI;
+	default:
+		WARN(1, "Invalid clockid %d. Using MONOTONIC\n", clock_id);
+		return HRTIMER_BASE_MONOTONIC;
 	}
-	WARN(1, "Invalid clockid %d. Using MONOTONIC\n", clock_id);
-	return HRTIMER_BASE_MONOTONIC;
 }
=20
 static enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 1af0bb2cc45c..7f4e4fb7381e 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -90,26 +90,6 @@ static long posix_clock_ioctl(struct file *fp,
 	return err;
 }
=20
-#ifdef CONFIG_COMPAT
-static long posix_clock_compat_ioctl(struct file *fp,
-				     unsigned int cmd, unsigned long arg)
-{
-	struct posix_clock_context *pccontext =3D fp->private_data;
-	struct posix_clock *clk =3D get_posix_clock(fp);
-	int err =3D -ENOTTY;
-
-	if (!clk)
-		return -ENODEV;
-
-	if (clk->ops.ioctl)
-		err =3D clk->ops.ioctl(pccontext, cmd, arg);
-
-	put_posix_clock(clk);
-
-	return err;
-}
-#endif
-
 static int posix_clock_open(struct inode *inode, struct file *fp)
 {
 	int err;
@@ -171,11 +151,9 @@ static const struct file_operations posix_clock_file_ope=
rations =3D {
 	.read		=3D posix_clock_read,
 	.poll		=3D posix_clock_poll,
 	.unlocked_ioctl	=3D posix_clock_ioctl,
+	.compat_ioctl	=3D posix_clock_ioctl,
 	.open		=3D posix_clock_open,
 	.release	=3D posix_clock_release,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	=3D posix_clock_compat_ioctl,
-#endif
 };
=20
 int posix_clock_register(struct posix_clock *clk, struct device *dev)
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1b675aee99a9..bc0bdf40eb50 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -9,28 +9,23 @@
  *
  * These are all the functions necessary to implement POSIX clocks & timers
  */
-#include <linux/mm.h>
+#include <linux/compat.h>
+#include <linux/compiler.h>
+#include <linux/init.h>
+#include <linux/jhash.h>
 #include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/time.h>
-#include <linux/mutex.h>
-#include <linux/sched/task.h>
-
-#include <linux/uaccess.h>
 #include <linux/list.h>
-#include <linux/init.h>
-#include <linux/compiler.h>
-#include <linux/hash.h>
+#include <linux/memblock.h>
+#include <linux/nospec.h>
 #include <linux/posix-clock.h>
 #include <linux/posix-timers.h>
+#include <linux/prctl.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
 #include <linux/syscalls.h>
-#include <linux/wait.h>
-#include <linux/workqueue.h>
-#include <linux/export.h>
-#include <linux/hashtable.h>
-#include <linux/compat.h>
-#include <linux/nospec.h>
+#include <linux/time.h>
 #include <linux/time_namespace.h>
+#include <linux/uaccess.h>
=20
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -46,39 +41,65 @@ static struct kmem_cache *posix_timers_cache;
  * This allows checkpoint/restore to reconstruct the exact timer IDs for
  * a process.
  */
-static DEFINE_HASHTABLE(posix_timers_hashtable, 9);
-static DEFINE_SPINLOCK(hash_lock);
+struct timer_hash_bucket {
+	spinlock_t		lock;
+	struct hlist_head	head;
+};
+
+static struct {
+	struct timer_hash_bucket	*buckets;
+	unsigned long			mask;
+} __timer_data __ro_after_init __aligned(2*sizeof(long));
+
+#define timer_buckets	(__timer_data.buckets)
+#define timer_hashmask	(__timer_data.mask)
=20
 static const struct k_clock * const posix_clocks[];
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
 static const struct k_clock clock_realtime, clock_monotonic;
=20
+#define TIMER_ANY_ID		INT_MIN
+
 /* SIGEV_THREAD_ID cannot share a bit with the other SIGEV values. */
 #if SIGEV_THREAD_ID !=3D (SIGEV_THREAD_ID & \
 			~(SIGEV_SIGNAL | SIGEV_NONE | SIGEV_THREAD))
 #error "SIGEV_THREAD_ID must not share bit with other SIGEV values!"
 #endif
=20
-static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags);
+static struct k_itimer *__lock_timer(timer_t timer_id);
=20
-#define lock_timer(tid, flags)						   \
-({	struct k_itimer *__timr;					   \
-	__cond_lock(&__timr->it_lock, __timr =3D __lock_timer(tid, flags));  \
-	__timr;								   \
+#define lock_timer(tid)							\
+({	struct k_itimer *__timr;					\
+	__cond_lock(&__timr->it_lock, __timr =3D __lock_timer(tid));	\
+	__timr;								\
 })
=20
-static int hash(struct signal_struct *sig, unsigned int nr)
+static inline void unlock_timer(struct k_itimer *timr)
 {
-	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
+	if (likely((timr)))
+		spin_unlock_irq(&timr->it_lock);
 }
=20
-static struct k_itimer *__posix_timers_find(struct hlist_head *head,
-					    struct signal_struct *sig,
-					    timer_t id)
+#define scoped_timer_get_or_fail(_id)					\
+	scoped_cond_guard(lock_timer, return -EINVAL, _id)
+
+#define scoped_timer				(scope)
+
+DEFINE_CLASS(lock_timer, struct k_itimer *, unlock_timer(_T), __lock_timer(i=
d), timer_t id);
+DEFINE_CLASS_IS_COND_GUARD(lock_timer);
+
+static struct timer_hash_bucket *hash_bucket(struct signal_struct *sig, unsi=
gned int nr)
 {
+	return &timer_buckets[jhash2((u32 *)&sig, sizeof(sig) / sizeof(u32), nr) & =
timer_hashmask];
+}
+
+static struct k_itimer *posix_timer_by_id(timer_t id)
+{
+	struct signal_struct *sig =3D current->signal;
+	struct timer_hash_bucket *bucket =3D hash_bucket(sig, id);
 	struct k_itimer *timer;
=20
-	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
+	hlist_for_each_entry_rcu(timer, &bucket->head, t_hash) {
 		/* timer->it_signal can be set concurrently */
 		if ((READ_ONCE(timer->it_signal) =3D=3D sig) && (timer->it_id =3D=3D id))
 			return timer;
@@ -86,46 +107,88 @@ static struct k_itimer *__posix_timers_find(struct hlist=
_head *head,
 	return NULL;
 }
=20
-static struct k_itimer *posix_timer_by_id(timer_t id)
+static inline struct signal_struct *posix_sig_owner(const struct k_itimer *t=
imer)
 {
-	struct signal_struct *sig =3D current->signal;
-	struct hlist_head *head =3D &posix_timers_hashtable[hash(sig, id)];
+	unsigned long val =3D (unsigned long)timer->it_signal;
=20
-	return __posix_timers_find(head, sig, id);
+	/*
+	 * Mask out bit 0, which acts as invalid marker to prevent
+	 * posix_timer_by_id() detecting it as valid.
+	 */
+	return (struct signal_struct *)(val & ~1UL);
 }
=20
-static int posix_timer_add(struct k_itimer *timer)
+static bool posix_timer_hashed(struct timer_hash_bucket *bucket, struct sign=
al_struct *sig,
+			       timer_t id)
 {
-	struct signal_struct *sig =3D current->signal;
-	struct hlist_head *head;
-	unsigned int cnt, id;
+	struct hlist_head *head =3D &bucket->head;
+	struct k_itimer *timer;
=20
-	/*
-	 * FIXME: Replace this by a per signal struct xarray once there is
-	 * a plan to handle the resulting CRIU regression gracefully.
-	 */
-	for (cnt =3D 0; cnt <=3D INT_MAX; cnt++) {
-		spin_lock(&hash_lock);
-		id =3D sig->next_posix_timer_id;
+	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&bucket->lock=
)) {
+		if ((posix_sig_owner(timer) =3D=3D sig) && (timer->it_id =3D=3D id))
+			return true;
+	}
+	return false;
+}
=20
-		/* Write the next ID back. Clamp it to the positive space */
-		sig->next_posix_timer_id =3D (id + 1) & INT_MAX;
+static bool posix_timer_add_at(struct k_itimer *timer, struct signal_struct =
*sig, unsigned int id)
+{
+	struct timer_hash_bucket *bucket =3D hash_bucket(sig, id);
=20
-		head =3D &posix_timers_hashtable[hash(sig, id)];
-		if (!__posix_timers_find(head, sig, id)) {
-			hlist_add_head_rcu(&timer->t_hash, head);
-			spin_unlock(&hash_lock);
-			return id;
+	scoped_guard (spinlock, &bucket->lock) {
+		/*
+		 * Validate under the lock as this could have raced against
+		 * another thread ending up with the same ID, which is
+		 * highly unlikely, but possible.
+		 */
+		if (!posix_timer_hashed(bucket, sig, id)) {
+			/*
+			 * Set the timer ID and the signal pointer to make
+			 * it identifiable in the hash table. The signal
+			 * pointer has bit 0 set to indicate that it is not
+			 * yet fully initialized. posix_timer_hashed()
+			 * masks this bit out, but the syscall lookup fails
+			 * to match due to it being set. This guarantees
+			 * that there can't be duplicate timer IDs handed
+			 * out.
+			 */
+			timer->it_id =3D (timer_t)id;
+			timer->it_signal =3D (struct signal_struct *)((unsigned long)sig | 1UL);
+			hlist_add_head_rcu(&timer->t_hash, &bucket->head);
+			return true;
 		}
-		spin_unlock(&hash_lock);
 	}
-	/* POSIX return code when no timer ID could be allocated */
-	return -EAGAIN;
+	return false;
 }
=20
-static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
+static int posix_timer_add(struct k_itimer *timer, int req_id)
 {
-	spin_unlock_irqrestore(&timr->it_lock, flags);
+	struct signal_struct *sig =3D current->signal;
+
+	if (unlikely(req_id !=3D TIMER_ANY_ID)) {
+		if (!posix_timer_add_at(timer, sig, req_id))
+			return -EBUSY;
+
+		/*
+		 * Move the ID counter past the requested ID, so that after
+		 * switching back to normal mode the IDs are outside of the
+		 * exact allocated region. That avoids ID collisions on the
+		 * next regular timer_create() invocations.
+		 */
+		atomic_set(&sig->next_posix_timer_id, req_id + 1);
+		return req_id;
+	}
+
+	for (unsigned int cnt =3D 0; cnt <=3D INT_MAX; cnt++) {
+		/* Get the next timer ID and clamp it to positive space */
+		unsigned int id =3D atomic_fetch_inc(&sig->next_posix_timer_id) & INT_MAX;
+
+		if (posix_timer_add_at(timer, sig, id))
+			return id;
+		cond_resched();
+	}
+	/* POSIX return code when no timer ID could be allocated */
+	return -EAGAIN;
 }
=20
 static int posix_get_realtime_timespec(clockid_t which_clock, struct timespe=
c64 *tp)
@@ -222,9 +285,8 @@ static int posix_get_hrtimer_res(clockid_t which_clock, s=
truct timespec64 *tp)
=20
 static __init int init_posix_timers(void)
 {
-	posix_timers_cache =3D kmem_cache_create("posix_timers_cache",
-					sizeof(struct k_itimer), 0,
-					SLAB_PANIC | SLAB_ACCOUNT, NULL);
+	posix_timers_cache =3D kmem_cache_create("posix_timers_cache", sizeof(struc=
t k_itimer),
+					       __alignof__(struct k_itimer), SLAB_ACCOUNT, NULL);
 	return 0;
 }
 __initcall(init_posix_timers);
@@ -259,7 +321,7 @@ static bool __posixtimer_deliver_signal(struct kernel_sig=
info *info, struct k_it
 	 * since the signal was queued. In either case, don't rearm and
 	 * drop the signal.
 	 */
-	if (timr->it_signal_seq !=3D timr->it_sigqueue_seq || WARN_ON_ONCE(!timr->i=
t_signal))
+	if (timr->it_signal_seq !=3D timr->it_sigqueue_seq || WARN_ON_ONCE(!posixti=
mer_valid(timr)))
 		return false;
=20
 	if (!timr->it_interval || WARN_ON_ONCE(timr->it_status !=3D POSIX_TIMER_REQ=
UEUE_PENDING))
@@ -304,6 +366,9 @@ void posix_timer_queue_signal(struct k_itimer *timr)
 {
 	lockdep_assert_held(&timr->it_lock);
=20
+	if (!posixtimer_valid(timr))
+		return;
+
 	timr->it_status =3D timr->it_interval ? POSIX_TIMER_REQUEUE_PENDING : POSIX=
_TIMER_DISARMED;
 	posixtimer_send_sigqueue(timr);
 }
@@ -324,6 +389,21 @@ static enum hrtimer_restart posix_timer_fn(struct hrtime=
r *timer)
 	return HRTIMER_NORESTART;
 }
=20
+long posixtimer_create_prctl(unsigned long ctrl)
+{
+	switch (ctrl) {
+	case PR_TIMER_CREATE_RESTORE_IDS_OFF:
+		current->signal->timer_create_restore_ids =3D 0;
+		return 0;
+	case PR_TIMER_CREATE_RESTORE_IDS_ON:
+		current->signal->timer_create_restore_ids =3D 1;
+		return 0;
+	case PR_TIMER_CREATE_RESTORE_IDS_GET:
+		return current->signal->timer_create_restore_ids;
+	}
+	return -EINVAL;
+}
+
 static struct pid *good_sigevent(sigevent_t * event)
 {
 	struct pid *pid =3D task_tgid(current);
@@ -350,8 +430,12 @@ static struct pid *good_sigevent(sigevent_t * event)
=20
 static struct k_itimer *alloc_posix_timer(void)
 {
-	struct k_itimer *tmr =3D kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
+	struct k_itimer *tmr;
=20
+	if (unlikely(!posix_timers_cache))
+		return NULL;
+
+	tmr =3D kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
 	if (!tmr)
 		return tmr;
=20
@@ -373,9 +457,10 @@ void posixtimer_free_timer(struct k_itimer *tmr)
=20
 static void posix_timer_unhash_and_free(struct k_itimer *tmr)
 {
-	spin_lock(&hash_lock);
-	hlist_del_rcu(&tmr->t_hash);
-	spin_unlock(&hash_lock);
+	struct timer_hash_bucket *bucket =3D hash_bucket(posix_sig_owner(tmr), tmr-=
>it_id);
+
+	scoped_guard (spinlock, &bucket->lock)
+		hlist_del_rcu(&tmr->t_hash);
 	posixtimer_putref(tmr);
 }
=20
@@ -390,6 +475,7 @@ static int do_timer_create(clockid_t which_clock, struct =
sigevent *event,
 			   timer_t __user *created_timer_id)
 {
 	const struct k_clock *kc =3D clockid_to_kclock(which_clock);
+	timer_t req_id =3D TIMER_ANY_ID;
 	struct k_itimer *new_timer;
 	int error, new_timer_id;
=20
@@ -404,26 +490,32 @@ static int do_timer_create(clockid_t which_clock, struc=
t sigevent *event,
=20
 	spin_lock_init(&new_timer->it_lock);
=20
+	/* Special case for CRIU to restore timers with a given timer ID. */
+	if (unlikely(current->signal->timer_create_restore_ids)) {
+		if (copy_from_user(&req_id, created_timer_id, sizeof(req_id)))
+			return -EFAULT;
+		/* Valid IDs are 0..INT_MAX */
+		if ((unsigned int)req_id > INT_MAX)
+			return -EINVAL;
+	}
+
 	/*
 	 * Add the timer to the hash table. The timer is not yet valid
-	 * because new_timer::it_signal is still NULL. The timer id is also
-	 * not yet visible to user space.
+	 * after insertion, but has a unique ID allocated.
 	 */
-	new_timer_id =3D posix_timer_add(new_timer);
+	new_timer_id =3D posix_timer_add(new_timer, req_id);
 	if (new_timer_id < 0) {
 		posixtimer_free_timer(new_timer);
 		return new_timer_id;
 	}
=20
-	new_timer->it_id =3D (timer_t) new_timer_id;
 	new_timer->it_clock =3D which_clock;
 	new_timer->kclock =3D kc;
 	new_timer->it_overrun =3D -1LL;
=20
 	if (event) {
-		rcu_read_lock();
-		new_timer->it_pid =3D get_pid(good_sigevent(event));
-		rcu_read_unlock();
+		scoped_guard (rcu)
+			new_timer->it_pid =3D get_pid(good_sigevent(event));
 		if (!new_timer->it_pid) {
 			error =3D -EINVAL;
 			goto out;
@@ -434,7 +526,6 @@ static int do_timer_create(clockid_t which_clock, struct =
sigevent *event,
 	} else {
 		new_timer->it_sigev_notify     =3D SIGEV_SIGNAL;
 		new_timer->sigq.info.si_signo =3D SIGALRM;
-		memset(&new_timer->sigq.info.si_value, 0, sizeof(sigval_t));
 		new_timer->sigq.info.si_value.sival_int =3D new_timer->it_id;
 		new_timer->it_pid =3D get_pid(task_tgid(current));
 	}
@@ -453,7 +544,7 @@ static int do_timer_create(clockid_t which_clock, struct =
sigevent *event,
 	}
 	/*
 	 * After succesful copy out, the timer ID is visible to user space
-	 * now but not yet valid because new_timer::signal is still NULL.
+	 * now but not yet valid because new_timer::signal low order bit is 1.
 	 *
 	 * Complete the initialization with the clock specific create
 	 * callback.
@@ -462,14 +553,25 @@ static int do_timer_create(clockid_t which_clock, struc=
t sigevent *event,
 	if (error)
 		goto out;
=20
-	spin_lock_irq(&current->sighand->siglock);
-	/* This makes the timer valid in the hash table */
-	WRITE_ONCE(new_timer->it_signal, current->signal);
-	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
-	spin_unlock_irq(&current->sighand->siglock);
 	/*
-	 * After unlocking sighand::siglock @new_timer is subject to
-	 * concurrent removal and cannot be touched anymore
+	 * timer::it_lock ensures that __lock_timer() observes a fully
+	 * initialized timer when it observes a valid timer::it_signal.
+	 *
+	 * sighand::siglock is required to protect signal::posix_timers.
+	 */
+	scoped_guard (spinlock_irq, &new_timer->it_lock) {
+		guard(spinlock)(&current->sighand->siglock);
+		/*
+		 * new_timer::it_signal contains the signal pointer with
+		 * bit 0 set, which makes it invalid for syscall operations.
+		 * Store the unmodified signal pointer to make it valid.
+		 */
+		WRITE_ONCE(new_timer->it_signal, current->signal);
+		hlist_add_head_rcu(&new_timer->list, &current->signal->posix_timers);
+	}
+	/*
+	 * After unlocking @new_timer is subject to concurrent removal and
+	 * cannot be touched anymore
 	 */
 	return 0;
 out:
@@ -507,7 +609,7 @@ COMPAT_SYSCALL_DEFINE3(timer_create, clockid_t, which_clo=
ck,
 }
 #endif
=20
-static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
+static struct k_itimer *__lock_timer(timer_t timer_id)
 {
 	struct k_itimer *timr;
=20
@@ -522,11 +624,11 @@ static struct k_itimer *__lock_timer(timer_t timer_id, =
unsigned long *flags)
 	 * The hash lookup and the timers are RCU protected.
 	 *
 	 * Timers are added to the hash in invalid state where
-	 * timr::it_signal =3D=3D NULL. timer::it_signal is only set after the
-	 * rest of the initialization succeeded.
+	 * timr::it_signal is marked invalid. timer::it_signal is only set
+	 * after the rest of the initialization succeeded.
 	 *
 	 * Timer destruction happens in steps:
-	 *  1) Set timr::it_signal to NULL with timr::it_lock held
+	 *  1) Set timr::it_signal marked invalid with timr::it_lock held
 	 *  2) Release timr::it_lock
 	 *  3) Remove from the hash under hash_lock
 	 *  4) Put the reference count.
@@ -543,25 +645,21 @@ static struct k_itimer *__lock_timer(timer_t timer_id, =
unsigned long *flags)
 	 *
 	 * The lookup validates locklessly that timr::it_signal =3D=3D
 	 * current::it_signal and timr::it_id =3D=3D @timer_id. timr::it_id
-	 * can't change, but timr::it_signal becomes NULL during
-	 * destruction.
+	 * can't change, but timr::it_signal can become invalid during
+	 * destruction, which makes the locked check fail.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
 	timr =3D posix_timer_by_id(timer_id);
 	if (timr) {
-		spin_lock_irqsave(&timr->it_lock, *flags);
+		spin_lock_irq(&timr->it_lock);
 		/*
 		 * Validate under timr::it_lock that timr::it_signal is
 		 * still valid. Pairs with #1 above.
 		 */
-		if (timr->it_signal =3D=3D current->signal) {
-			rcu_read_unlock();
+		if (timr->it_signal =3D=3D current->signal)
 			return timr;
-		}
-		spin_unlock_irqrestore(&timr->it_lock, *flags);
+		spin_unlock_irq(&timr->it_lock);
 	}
-	rcu_read_unlock();
-
 	return NULL;
 }
=20
@@ -652,24 +750,10 @@ void common_timer_get(struct k_itimer *timr, struct iti=
merspec64 *cur_setting)
=20
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
-	const struct k_clock *kc;
-	struct k_itimer *timr;
-	unsigned long flags;
-	int ret =3D 0;
-
-	timr =3D lock_timer(timer_id, &flags);
-	if (!timr)
-		return -EINVAL;
-
 	memset(setting, 0, sizeof(*setting));
-	kc =3D timr->kclock;
-	if (WARN_ON_ONCE(!kc || !kc->timer_get))
-		ret =3D -EINVAL;
-	else
-		kc->timer_get(timr, setting);
-
-	unlock_timer(timr, flags);
-	return ret;
+	scoped_timer_get_or_fail(timer_id)
+		scoped_timer->kclock->timer_get(scoped_timer, setting);
+	return 0;
 }
=20
 /* Get the time remaining on a POSIX.1b interval timer. */
@@ -723,18 +807,8 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t, timer_id,
  */
 SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 {
-	struct k_itimer *timr;
-	unsigned long flags;
-	int overrun;
-
-	timr =3D lock_timer(timer_id, &flags);
-	if (!timr)
-		return -EINVAL;
-
-	overrun =3D timer_overrun_to_int(timr);
-	unlock_timer(timr, flags);
-
-	return overrun;
+	scoped_timer_get_or_fail(timer_id)
+		return timer_overrun_to_int(scoped_timer);
 }
=20
 static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
@@ -791,26 +865,13 @@ static void common_timer_wait_running(struct k_itimer *=
timer)
  * when the task which tries to delete or disarm the timer has preempted
  * the task which runs the expiry in task work context.
  */
-static struct k_itimer *timer_wait_running(struct k_itimer *timer,
-					   unsigned long *flags)
+static void timer_wait_running(struct k_itimer *timer)
 {
-	const struct k_clock *kc =3D READ_ONCE(timer->kclock);
-	timer_t timer_id =3D READ_ONCE(timer->it_id);
-
-	/* Prevent kfree(timer) after dropping the lock */
-	rcu_read_lock();
-	unlock_timer(timer, *flags);
-
 	/*
 	 * kc->timer_wait_running() might drop RCU lock. So @timer
 	 * cannot be touched anymore after the function returns!
 	 */
-	if (!WARN_ON_ONCE(!kc->timer_wait_running))
-		kc->timer_wait_running(timer);
-
-	rcu_read_unlock();
-	/* Relock the timer. It might be not longer hashed. */
-	return lock_timer(timer_id, flags);
+	timer->kclock->timer_wait_running(timer);
 }
=20
 /*
@@ -865,15 +926,9 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	return 0;
 }
=20
-static int do_timer_settime(timer_t timer_id, int tmr_flags,
-			    struct itimerspec64 *new_spec64,
+static int do_timer_settime(timer_t timer_id, int tmr_flags, struct itimersp=
ec64 *new_spec64,
 			    struct itimerspec64 *old_spec64)
 {
-	const struct k_clock *kc;
-	struct k_itimer *timr;
-	unsigned long flags;
-	int error;
-
 	if (!timespec64_valid(&new_spec64->it_interval) ||
 	    !timespec64_valid(&new_spec64->it_value))
 		return -EINVAL;
@@ -881,33 +936,28 @@ static int do_timer_settime(timer_t timer_id, int tmr_f=
lags,
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
=20
-	timr =3D lock_timer(timer_id, &flags);
-retry:
-	if (!timr)
-		return -EINVAL;
+	for (; ; old_spec64 =3D NULL) {
+		struct k_itimer *timr;
=20
-	if (old_spec64)
-		old_spec64->it_interval =3D ktime_to_timespec64(timr->it_interval);
+		scoped_timer_get_or_fail(timer_id) {
+			timr =3D scoped_timer;
=20
-	/* Prevent signal delivery and rearming. */
-	timr->it_signal_seq++;
+			if (old_spec64)
+				old_spec64->it_interval =3D ktime_to_timespec64(timr->it_interval);
=20
-	kc =3D timr->kclock;
-	if (WARN_ON_ONCE(!kc || !kc->timer_set))
-		error =3D -EINVAL;
-	else
-		error =3D kc->timer_set(timr, tmr_flags, new_spec64, old_spec64);
-
-	if (error =3D=3D TIMER_RETRY) {
-		// We already got the old time...
-		old_spec64 =3D NULL;
-		/* Unlocks and relocks the timer if it still exists */
-		timr =3D timer_wait_running(timr, &flags);
-		goto retry;
-	}
-	unlock_timer(timr, flags);
+			/* Prevent signal delivery and rearming. */
+			timr->it_signal_seq++;
=20
-	return error;
+			int ret =3D timr->kclock->timer_set(timr, tmr_flags, new_spec64, old_spec=
64);
+			if (ret !=3D TIMER_RETRY)
+				return ret;
+
+			/* Protect the timer from being freed when leaving the lock scope */
+			rcu_read_lock();
+		}
+		timer_wait_running(timr);
+		rcu_read_unlock();
+	}
 }
=20
 /* Set a POSIX.1b interval timer */
@@ -978,109 +1028,57 @@ static inline void posix_timer_cleanup_ignored(struct=
 k_itimer *tmr)
 	}
 }
=20
-static inline int timer_delete_hook(struct k_itimer *timer)
+static void posix_timer_delete(struct k_itimer *timer)
 {
-	const struct k_clock *kc =3D timer->kclock;
-
-	/* Prevent signal delivery and rearming. */
+	/*
+	 * Invalidate the timer, remove it from the linked list and remove
+	 * it from the ignored list if pending.
+	 *
+	 * The invalidation must be written with siglock held so that the
+	 * signal code observes the invalidated timer::it_signal in
+	 * do_sigaction(), which prevents it from moving a pending signal
+	 * of a deleted timer to the ignore list.
+	 *
+	 * The invalidation also prevents signal queueing, signal delivery
+	 * and therefore rearming from the signal delivery path.
+	 *
+	 * A concurrent lookup can still find the timer in the hash, but it
+	 * will check timer::it_signal with timer::it_lock held and observe
+	 * bit 0 set, which invalidates it. That also prevents the timer ID
+	 * from being handed out before this timer is completely gone.
+	 */
 	timer->it_signal_seq++;
=20
-	if (WARN_ON_ONCE(!kc || !kc->timer_del))
-		return -EINVAL;
-	return kc->timer_del(timer);
+	scoped_guard (spinlock, &current->sighand->siglock) {
+		unsigned long sig =3D (unsigned long)timer->it_signal | 1UL;
+
+		WRITE_ONCE(timer->it_signal, (struct signal_struct *)sig);
+		hlist_del_rcu(&timer->list);
+		posix_timer_cleanup_ignored(timer);
+	}
+
+	while (timer->kclock->timer_del(timer) =3D=3D TIMER_RETRY) {
+		guard(rcu)();
+		spin_unlock_irq(&timer->it_lock);
+		timer_wait_running(timer);
+		spin_lock_irq(&timer->it_lock);
+	}
 }
=20
 /* Delete a POSIX.1b interval timer. */
 SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 {
 	struct k_itimer *timer;
-	unsigned long flags;
=20
-	timer =3D lock_timer(timer_id, &flags);
-
-retry_delete:
-	if (!timer)
-		return -EINVAL;
-
-	if (unlikely(timer_delete_hook(timer) =3D=3D TIMER_RETRY)) {
-		/* Unlocks and relocks the timer if it still exists */
-		timer =3D timer_wait_running(timer, &flags);
-		goto retry_delete;
+	scoped_timer_get_or_fail(timer_id) {
+		timer =3D scoped_timer;
+		posix_timer_delete(timer);
 	}
-
-	spin_lock(&current->sighand->siglock);
-	hlist_del(&timer->list);
-	posix_timer_cleanup_ignored(timer);
-	/*
-	 * A concurrent lookup could check timer::it_signal lockless. It
-	 * will reevaluate with timer::it_lock held and observe the NULL.
-	 *
-	 * It must be written with siglock held so that the signal code
-	 * observes timer->it_signal =3D=3D NULL in do_sigaction(SIG_IGN),
-	 * which prevents it from moving a pending signal of a deleted
-	 * timer to the ignore list.
-	 */
-	WRITE_ONCE(timer->it_signal, NULL);
-	spin_unlock(&current->sighand->siglock);
-
-	unlock_timer(timer, flags);
+	/* Remove it from the hash, which frees up the timer ID */
 	posix_timer_unhash_and_free(timer);
 	return 0;
 }
=20
-/*
- * Delete a timer if it is armed, remove it from the hash and schedule it
- * for RCU freeing.
- */
-static void itimer_delete(struct k_itimer *timer)
-{
-	unsigned long flags;
-
-	/*
-	 * irqsave is required to make timer_wait_running() work.
-	 */
-	spin_lock_irqsave(&timer->it_lock, flags);
-
-retry_delete:
-	/*
-	 * Even if the timer is not longer accessible from other tasks
-	 * it still might be armed and queued in the underlying timer
-	 * mechanism. Worse, that timer mechanism might run the expiry
-	 * function concurrently.
-	 */
-	if (timer_delete_hook(timer) =3D=3D TIMER_RETRY) {
-		/*
-		 * Timer is expired concurrently, prevent livelocks
-		 * and pointless spinning on RT.
-		 *
-		 * timer_wait_running() drops timer::it_lock, which opens
-		 * the possibility for another task to delete the timer.
-		 *
-		 * That's not possible here because this is invoked from
-		 * do_exit() only for the last thread of the thread group.
-		 * So no other task can access and delete that timer.
-		 */
-		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) !=3D timer))
-			return;
-
-		goto retry_delete;
-	}
-	hlist_del(&timer->list);
-
-	posix_timer_cleanup_ignored(timer);
-
-	/*
-	 * Setting timer::it_signal to NULL is technically not required
-	 * here as nothing can access the timer anymore legitimately via
-	 * the hash table. Set it to NULL nevertheless so that all deletion
-	 * paths are consistent.
-	 */
-	WRITE_ONCE(timer->it_signal, NULL);
-
-	spin_unlock_irqrestore(&timer->it_lock, flags);
-	posix_timer_unhash_and_free(timer);
-}
-
 /*
  * Invoked from do_exit() when the last thread of a thread group exits.
  * At that point no other task can access the timers of the dying
@@ -1089,18 +1087,26 @@ static void itimer_delete(struct k_itimer *timer)
 void exit_itimers(struct task_struct *tsk)
 {
 	struct hlist_head timers;
+	struct hlist_node *next;
+	struct k_itimer *timer;
+
+	/* Clear restore mode for exec() */
+	tsk->signal->timer_create_restore_ids =3D 0;
=20
 	if (hlist_empty(&tsk->signal->posix_timers))
 		return;
=20
 	/* Protect against concurrent read via /proc/$PID/timers */
-	spin_lock_irq(&tsk->sighand->siglock);
-	hlist_move_list(&tsk->signal->posix_timers, &timers);
-	spin_unlock_irq(&tsk->sighand->siglock);
+	scoped_guard (spinlock_irq, &tsk->sighand->siglock)
+		hlist_move_list(&tsk->signal->posix_timers, &timers);
=20
 	/* The timers are not longer accessible via tsk::signal */
-	while (!hlist_empty(&timers))
-		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+	hlist_for_each_entry_safe(timer, next, &timers, list) {
+		scoped_guard (spinlock_irq, &timer->it_lock)
+			posix_timer_delete(timer);
+		posix_timer_unhash_and_free(timer);
+		cond_resched();
+	}
=20
 	/*
 	 * There should be no timers on the ignored list. itimer_delete() has
@@ -1545,3 +1551,26 @@ static const struct k_clock *clockid_to_kclock(const c=
lockid_t id)
=20
 	return posix_clocks[array_index_nospec(idx, ARRAY_SIZE(posix_clocks))];
 }
+
+static int __init posixtimer_init(void)
+{
+	unsigned long i, size;
+	unsigned int shift;
+
+	if (IS_ENABLED(CONFIG_BASE_SMALL))
+		size =3D 512;
+	else
+		size =3D roundup_pow_of_two(512 * num_possible_cpus());
+
+	timer_buckets =3D alloc_large_system_hash("posixtimers", sizeof(*timer_buck=
ets),
+						size, 0, 0, &shift, NULL, size, size);
+	size =3D 1UL << shift;
+	timer_hashmask =3D size - 1;
+
+	for (i =3D 0; i < size; i++) {
+		spin_lock_init(&timer_buckets[i].lock);
+		INIT_HLIST_HEAD(&timer_buckets[i].head);
+	}
+	return 0;
+}
+core_initcall(posixtimer_init);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1e67d076f195..929846b8b45a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -682,20 +682,19 @@ static void timekeeping_update_from_shadow(struct tk_da=
ta *tkd, unsigned int act
 }
=20
 /**
- * timekeeping_forward_now - update clock to the current time
+ * timekeeping_forward - update clock to given cycle now value
  * @tk:		Pointer to the timekeeper to update
+ * @cycle_now:  Current clocksource read value
  *
  * Forward the current clock to update its state since the last call to
  * update_wall_time(). This is useful before significant clock changes,
  * as it avoids having to deal with this time offset explicitly.
  */
-static void timekeeping_forward_now(struct timekeeper *tk)
+static void timekeeping_forward(struct timekeeper *tk, u64 cycle_now)
 {
-	u64 cycle_now, delta;
+	u64 delta =3D clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr=
_mono.mask,
+				      tk->tkr_mono.clock->max_raw_delta);
=20
-	cycle_now =3D tk_clock_read(&tk->tkr_mono);
-	delta =3D clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mon=
o.mask,
-				  tk->tkr_mono.clock->max_raw_delta);
 	tk->tkr_mono.cycle_last =3D cycle_now;
 	tk->tkr_raw.cycle_last  =3D cycle_now;
=20
@@ -710,6 +709,21 @@ static void timekeeping_forward_now(struct timekeeper *t=
k)
 	}
 }
=20
+/**
+ * timekeeping_forward_now - update clock to the current time
+ * @tk:		Pointer to the timekeeper to update
+ *
+ * Forward the current clock to update its state since the last call to
+ * update_wall_time(). This is useful before significant clock changes,
+ * as it avoids having to deal with this time offset explicitly.
+ */
+static void timekeeping_forward_now(struct timekeeper *tk)
+{
+	u64 cycle_now =3D tk_clock_read(&tk->tkr_mono);
+
+	timekeeping_forward(tk, cycle_now);
+}
+
 /**
  * ktime_get_real_ts64 - Returns the time of day in a timespec64.
  * @ts:		pointer to the timespec to be set
@@ -2151,6 +2165,54 @@ static u64 logarithmic_accumulation(struct timekeeper =
*tk, u64 offset,
 	return offset;
 }
=20
+static u64 timekeeping_accumulate(struct timekeeper *tk, u64 offset,
+				  enum timekeeping_adv_mode mode,
+				  unsigned int *clock_set)
+{
+	int shift =3D 0, maxshift;
+
+	/*
+	 * TK_ADV_FREQ indicates that adjtimex(2) directly set the
+	 * frequency or the tick length.
+	 *
+	 * Accumulate the offset, so that the new multiplier starts from
+	 * now. This is required as otherwise for offsets, which are
+	 * smaller than tk::cycle_interval, timekeeping_adjust() could set
+	 * xtime_nsec backwards, which subsequently causes time going
+	 * backwards in the coarse time getters. But even for the case
+	 * where offset is greater than tk::cycle_interval the periodic
+	 * accumulation does not have much value.
+	 *
+	 * Also reset tk::ntp_error as it does not make sense to keep the
+	 * old accumulated error around in this case.
+	 */
+	if (mode =3D=3D TK_ADV_FREQ) {
+		timekeeping_forward(tk, tk->tkr_mono.cycle_last + offset);
+		tk->ntp_error =3D 0;
+		return 0;
+	}
+
+	/*
+	 * With NO_HZ we may have to accumulate many cycle_intervals
+	 * (think "ticks") worth of time at once. To do this efficiently,
+	 * we calculate the largest doubling multiple of cycle_intervals
+	 * that is smaller than the offset.  We then accumulate that
+	 * chunk in one go, and then try to consume the next smaller
+	 * doubled multiple.
+	 */
+	shift =3D ilog2(offset) - ilog2(tk->cycle_interval);
+	shift =3D max(0, shift);
+	/* Bound shift to one less than what overflows tick_length */
+	maxshift =3D (64 - (ilog2(ntp_tick_length()) + 1)) - 1;
+	shift =3D min(shift, maxshift);
+	while (offset >=3D tk->cycle_interval) {
+		offset =3D logarithmic_accumulation(tk, offset, shift, clock_set);
+		if (offset < tk->cycle_interval << shift)
+			shift--;
+	}
+	return offset;
+}
+
 /*
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
@@ -2160,7 +2222,6 @@ static bool timekeeping_advance(enum timekeeping_adv_mo=
de mode)
 	struct timekeeper *tk =3D &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk =3D &tk_core.timekeeper;
 	unsigned int clock_set =3D 0;
-	int shift =3D 0, maxshift;
 	u64 offset;
=20
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
@@ -2177,24 +2238,7 @@ static bool timekeeping_advance(enum timekeeping_adv_m=
ode mode)
 	if (offset < real_tk->cycle_interval && mode =3D=3D TK_ADV_TICK)
 		return false;
=20
-	/*
-	 * With NO_HZ we may have to accumulate many cycle_intervals
-	 * (think "ticks") worth of time at once. To do this efficiently,
-	 * we calculate the largest doubling multiple of cycle_intervals
-	 * that is smaller than the offset.  We then accumulate that
-	 * chunk in one go, and then try to consume the next smaller
-	 * doubled multiple.
-	 */
-	shift =3D ilog2(offset) - ilog2(tk->cycle_interval);
-	shift =3D max(0, shift);
-	/* Bound shift to one less than what overflows tick_length */
-	maxshift =3D (64 - (ilog2(ntp_tick_length())+1)) - 1;
-	shift =3D min(shift, maxshift);
-	while (offset >=3D tk->cycle_interval) {
-		offset =3D logarithmic_accumulation(tk, offset, shift, &clock_set);
-		if (offset < tk->cycle_interval<<shift)
-			shift--;
-	}
+	offset =3D timekeeping_accumulate(tk, offset, mode, &clock_set);
=20
 	/* Adjust the multiplier to correct NTP error */
 	timekeeping_adjust(tk, offset);
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 1c311c46da50..cfbb46cc4e76 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -46,7 +46,7 @@ static void
 print_timer(struct seq_file *m, struct hrtimer *taddr, struct hrtimer *timer,
 	    int idx, u64 now)
 {
-	SEQ_printf(m, " #%d: <%pK>, %ps", idx, taddr, timer->function);
+	SEQ_printf(m, " #%d: <%p>, %ps", idx, taddr, timer->function);
 	SEQ_printf(m, ", S:%02x", timer->state);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " # expires at %Lu-%Lu nsecs [in %Ld to %Ld nsecs]\n",
@@ -98,7 +98,7 @@ print_active_timers(struct seq_file *m, struct hrtimer_cloc=
k_base *base,
 static void
 print_base(struct seq_file *m, struct hrtimer_clock_base *base, u64 now)
 {
-	SEQ_printf(m, "  .base:       %pK\n", base);
+	SEQ_printf(m, "  .base:       %p\n", base);
 	SEQ_printf(m, "  .index:      %d\n", base->index);
=20
 	SEQ_printf(m, "  .resolution: %u nsecs\n", hrtimer_resolution);
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/se=
lftests/timers/posix_timers.c
index 9814b3a1c77d..f0eceb0faf34 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -7,6 +7,7 @@
  * Kernel loop code stolen from Steven Rostedt <srostedt@redhat.com>
  */
 #define _GNU_SOURCE
+#include <sys/prctl.h>
 #include <sys/time.h>
 #include <sys/types.h>
 #include <stdio.h>
@@ -599,14 +600,84 @@ static void check_overrun(int which, const char *name)
 			 "check_overrun %s\n", name);
 }
=20
+#include <sys/syscall.h>
+
+static int do_timer_create(int *id)
+{
+	return syscall(__NR_timer_create, CLOCK_MONOTONIC, NULL, id);
+}
+
+static int do_timer_delete(int id)
+{
+	return syscall(__NR_timer_delete, id);
+}
+
+#ifndef PR_TIMER_CREATE_RESTORE_IDS
+# define PR_TIMER_CREATE_RESTORE_IDS		77
+# define PR_TIMER_CREATE_RESTORE_IDS_OFF	 0
+# define PR_TIMER_CREATE_RESTORE_IDS_ON		 1
+# define PR_TIMER_CREATE_RESTORE_IDS_GET	 2
+#endif
+
+static void check_timer_create_exact(void)
+{
+	int id;
+
+	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_ON, 0, 0=
, 0)) {
+		switch (errno) {
+		case EINVAL:
+			ksft_test_result_skip("check timer create exact, not supported\n");
+			return;
+		default:
+			ksft_test_result_skip("check timer create exact, errno =3D %d\n", errno);
+			return;
+		}
+	}
+
+	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_GET, 0, =
0, 0) !=3D 1)
+		fatal_error(NULL, "prctl(GET) failed\n");
+
+	id =3D 8;
+	if (do_timer_create(&id) < 0)
+		fatal_error(NULL, "timer_create()");
+
+	if (do_timer_delete(id))
+		fatal_error(NULL, "timer_delete()");
+
+	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_OFF, 0, =
0, 0))
+		fatal_error(NULL, "prctl(OFF)");
+
+	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_GET, 0, =
0, 0) !=3D 0)
+		fatal_error(NULL, "prctl(GET) failed\n");
+
+	if (id !=3D 8) {
+		ksft_test_result_fail("check timer create exact %d !=3D 8\n", id);
+		return;
+	}
+
+	/* Validate that it went back to normal mode and allocates ID 9 */
+	if (do_timer_create(&id) < 0)
+		fatal_error(NULL, "timer_create()");
+
+	if (do_timer_delete(id))
+		fatal_error(NULL, "timer_delete()");
+
+	if (id =3D=3D 9)
+		ksft_test_result_pass("check timer create exact\n");
+	else
+		ksft_test_result_fail("check timer create exact. Disabling failed.\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(18);
+	ksft_set_plan(19);
=20
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU exec=
ution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
=20
+	check_timer_create_exact();
+
 	check_itimer(ITIMER_VIRTUAL, "ITIMER_VIRTUAL");
 	check_itimer(ITIMER_PROF, "ITIMER_PROF");
 	check_itimer(ITIMER_REAL, "ITIMER_REAL");
diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testin=
g/selftests/timers/skew_consistency.c
index 83450145fe65..46c391d7f45d 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -47,7 +47,7 @@ int main(int argc, char **argv)
=20
 	pid =3D fork();
 	if (!pid)
-		return system("./inconsistency-check -c 1 -t 600");
+		return system("./inconsistency-check -t 60");
=20
 	ppm =3D 500;
 	ret =3D 0;


