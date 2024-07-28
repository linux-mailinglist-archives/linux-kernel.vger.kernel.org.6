Return-Path: <linux-kernel+bounces-264886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D254B93E9B4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 23:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB0CB21799
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263185914C;
	Sun, 28 Jul 2024 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AegzNYdP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HIUWeODf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4CA7470
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722202244; cv=none; b=oarG/smreRRjbeO74CBT61mHXmmtBKC8zN1Dlumu5jh56nONF465KfFBbHC4ozzTKyXXC8T3Cce2K70Bcs24T05gKm2KSlJBWyfP2hqOGTYPObqdeIK0JANnU+RG8138zkA0vg3Ca5F9d6iYlQPLi+RwOztCu1Ce3bnXsB/sTG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722202244; c=relaxed/simple;
	bh=WvDLWZXNj7JvefON5oN/oI6hLOY2sERSFpKQzRgTBzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=heETyEG+lFzljh0WAz5IVSK+qVH/by5SOstxPBTG/ySbkl9fjxhYtHU10CAZxLCxNHRt5I6Q7YJsSK2CwlT+1HOMidKeMbzE1FLYvz2gPLkkzxCUG6JQTpqBTn6u1d2AoBzazJPxffoca3Sk4HTc+DVFrIO3Y2muHLC0rpjArzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AegzNYdP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HIUWeODf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722202239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mkxxkg5G+QCKXORXqfQheO8NG7nyryepkIDctyVjL18=;
	b=AegzNYdPO9Dp5Bc+D6MKm89CRgP4G7VK8YM4UOapwi48YT73TQMImAqqNPI+pb/bhW4SiF
	u5gihWQl7/F2P6Aas4XOm9Oc26OSa1zirtRfBFKKxTjXlPPy5YvEQ2XBozDvxu81qaKzAs
	9F5OvEBt1BEHKY3yVLuRzeolv69QTKdroB8whPxJ4F99T2s+2ycxYmF6BVLmp+6PbcYfdI
	pAn2D94xL/Ut83lQAm7EMOWtd9XTeKNAqVh2BQ1/mKF5HYVURWly0taDCZRpixCAqR9ovg
	YQSHbke+10OrsYNiG+8wcIX0mBZE+M8cJh9KXTOW2G3tThALTOujkzEM+Xs/kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722202239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mkxxkg5G+QCKXORXqfQheO8NG7nyryepkIDctyVjL18=;
	b=HIUWeODfButgjkayOEsDjAdS9bXa8TqVjTMQe5l2xrxZ0Y25r7JiWt3jvB0dPIgALGPkt3
	hcIy1oeuSfjmPkDw==
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, efault@gmx.de
Subject: Re: [RFC PATCH 24/24] sched/time: Introduce CLOCK_THREAD_DVFS_ID
In-Reply-To: <20240727105031.053611186@infradead.org>
References: <20240727102732.960974693@infradead.org>
 <20240727105031.053611186@infradead.org>
Date: Sun, 28 Jul 2024 23:30:38 +0200
Message-ID: <874j89tda9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 27 2024 at 12:27, Peter Zijlstra wrote:
> In order to measure thread time in a DVFS world, introduce
> CLOCK_THREAD_DVFS_ID -- a copy of CLOCK_THREAD_CPUTIME_ID that slows
> down with both DVFS scaling and CPU capacity.
>
> The clock does *NOT* support setting timers.

That's not the only limitation. See below.

> Useful for both SCHED_DEADLINE and the newly introduced
> sched_attr::sched_runtime usage for SCHED_NORMAL.

Can this please have an explanation about the usage of the previously
reserved value of 0x7 in the lower 3 bits?

>   *
>   * Bit 2 indicates whether a cpu clock refers to a thread or a process.
>   *
> - * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or FD=3.
> + * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or DVSF=3
>   *
> - * A clockid is invalid if bits 2, 1, and 0 are all set.
> + * (DVFS is PERTHREAD only)

This drops the information about the FD usage. Something like:

/*
 * Bit fields within a clockid:
 *
 * Bit 31:3 hold either a pid or a file descriptor.
 *
 * Bit 2  Bit 1  Bit 0
 *   0      0      0     Per process	CPUCLOCK_PROF
 *   0      0      1     Per process	CPUCLOCK_VIRT
 *   0      1      0     Per process	CPUCLOCK_SCHED
 *   0      1      1     Posixclock FD	CLOCKFD
 *   1      0      0     Per thread	CPUCLOCK_PROF
 *   1      0      1     Per thread	CPUCLOCK_VIRT
 *   1      1      0     Per thread	CPUCLOCK_SCHED
 *   1      1      1     Per thread	CPUCLOCK_DVSF
 *
 * CPUCLOCK_DVSF is per thread only and shares the type code in Bit 1:0
 * with CLOCKFD. CLOCKFD uses a file descriptor to access dynamically
 * registered POSIX clocks (e.g. PTP hardware clocks).
 */

should be clear enough, no?

But, all of this is wishful thinking because the provided implementation
only works for:

      sys_clock_getres(CLOCK_THREAD_DVFS_ID, ...)

which falls back to thread_cpu_clock_getres().

The variant which has the TID encoded in bit 31:3 and the type in bit
2:0 fails the test in pid_for_clock():

        if (CPUCLOCK_WHICH(clock) >= CPUCLOCK_MAX)
		return NULL;

Worse for sys_clock_gettime(). That fails in both cases for the very
same reason.

See the uncompiled delta patch below for a cure of that and the rest of
my comments.

>   #define CPUCLOCK_PROF		0
>   #define CPUCLOCK_VIRT		1
>   #define CPUCLOCK_SCHED		2
>  +#define CPUCLOCK_DVFS		3
>   #define CPUCLOCK_MAX		3
>   #define CLOCKFD			CPUCLOCK_MAX
>   #define CLOCKFD_MASK		(CPUCLOCK_PERTHREAD_MASK|CPUCLOCK_CLOCK_MASK)

With that DVFS addition CPUCLOCK_MAX is misleading at best. See delta
patch.

> +
> +	rq = task_rq_lock(p, &rf);
> +	/*
> +	 * Must be ->curr _and_ ->on_rq.  If dequeued, we would
> +	 * project cycles that may never be accounted to this
> +	 * thread, breaking clock_gettime().

Must be? For what? I assume you want to say:

     Update the runtime if the task is the current task and on the
     runqueue. The latter is important because if current is dequeued,
     ....

> +	 */
> +	if (task_current(rq, p) && task_on_rq_queued(p)) {
> +		prefetch_curr_exec_start(p);
> +		update_rq_clock(rq);
> +		p->sched_class->update_curr(rq);
> +	}
> +	ns = p->se.sum_dvfs_runtime;
> +	task_rq_unlock(rq, p, &rf);
> @@ -1664,6 +1668,11 @@ static int thread_cpu_timer_create(struc
>  	timer->it_clock = THREAD_CLOCK;
>  	return posix_cpu_timer_create(timer);
>  }
> +static int thread_dvfs_cpu_clock_get(const clockid_t which_clock,
> +				struct timespec64 *tp)

Please align the second line properly with the argument in the first line.

Thanks,

        tglx
---

--- a/include/linux/posix-timers_types.h
+++ b/include/linux/posix-timers_types.h
@@ -9,27 +9,42 @@
 /*
  * Bit fields within a clockid:
  *
- * The most significant 29 bits hold either a pid or a file descriptor.
+ * Bit 31:3 hold either a PID/TID or a file descriptor.
  *
- * Bit 2 indicates whether a cpu clock refers to a thread or a process.
+ * Bit 2  Bit 1  Bit 0
+ *   0      0      0     Per process	CPUCLOCK_PROF
+ *   0      0      1     Per process	CPUCLOCK_VIRT
+ *   0      1      0     Per process	CPUCLOCK_SCHED
+ *   0      1      1     Posixclock FD	CLOCKFD
+ *   1      0      0     Per thread	CPUCLOCK_PROF
+ *   1      0      1     Per thread	CPUCLOCK_VIRT
+ *   1      1      0     Per thread	CPUCLOCK_SCHED
+ *   1      1      1     Per thread	CPUCLOCK_DVSF
  *
- * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or DVSF=3
- *
- * (DVFS is PERTHREAD only)
+ * CPUCLOCK_DVSF is per thread only and shares the type code in Bit 1:0
+ * with CLOCKFD. CLOCKFD uses a file descriptor to access dynamically
+ * registered POSIX clocks (e.g. PTP hardware clocks).
  */
+
 #define CPUCLOCK_PID(clock)		((pid_t) ~((clock) >> 3))
-#define CPUCLOCK_PERTHREAD(clock) \
-	(((clock) & (clockid_t) CPUCLOCK_PERTHREAD_MASK) != 0)
+#define CPUCLOCK_PERTHREAD(clock)	(((clock) & (clockid_t) CPUCLOCK_PERTHREAD_MASK) != 0)
 
-#define CPUCLOCK_PERTHREAD_MASK	4
-#define CPUCLOCK_WHICH(clock)	((clock) & (clockid_t) CPUCLOCK_CLOCK_MASK)
-#define CPUCLOCK_CLOCK_MASK	3
 #define CPUCLOCK_PROF		0
 #define CPUCLOCK_VIRT		1
 #define CPUCLOCK_SCHED		2
-#define CPUCLOCK_DVFS		3
-#define CPUCLOCK_MAX		3
-#define CLOCKFD			CPUCLOCK_MAX
+#define CPUCLOCK_SAMPLE_MAX	(CPUCLOCK_SCHED + 1)
+
+#define CPUCLOCK_CLOCK_MASK	3
+#define CPUCLOCK_PERTHREAD_MASK	4
+#define CPUCLOCK_WHICH(clock)	((clock) & (clockid_t) CPUCLOCK_CLOCK_MASK)
+
+/*
+ * CPUCLOCK_DVFS and CLOCKFD share the type code in bit 1:0. CPUCLOCK_DVFS
+ * does not belong to the sampling clocks and does not allow timers to be
+ * armed on it.
+ */
+#define CPUCLOCK_DVFS		CPUCLOCK_SAMPLE_MAX
+#define CLOCKFD			CPUCLOCK_DVFS
 #define CLOCKFD_MASK		(CPUCLOCK_PERTHREAD_MASK|CPUCLOCK_CLOCK_MASK)
 
 #ifdef CONFIG_POSIX_TIMERS
@@ -55,7 +70,7 @@ struct posix_cputimer_base {
  * Used in task_struct and signal_struct
  */
 struct posix_cputimers {
-	struct posix_cputimer_base	bases[CPUCLOCK_MAX];
+	struct posix_cputimer_base	bases[CPUCLOCK_SAMPLE_MAX];
 	unsigned int			timers_active;
 	unsigned int			expiry_active;
 };
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5413,9 +5413,10 @@ unsigned long long task_sched_dvfs_runti
 
 	rq = task_rq_lock(p, &rf);
 	/*
-	 * Must be ->curr _and_ ->on_rq.  If dequeued, we would
-	 * project cycles that may never be accounted to this
-	 * thread, breaking clock_gettime().
+	 * Update the runtime if the task is the current task and on the
+	 * runqueue. The latter is important because if current is
+	 * dequeued, we would project cycles that may never be accounted to
+	 * this thread, breaking clock_gettime().
 	 */
 	if (task_current(rq, p) && task_on_rq_queued(p)) {
 		prefetch_curr_exec_start(p);
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -54,13 +54,13 @@ int update_rlimit_cpu(struct task_struct
 /*
  * Functions for validating access to tasks.
  */
-static struct pid *pid_for_clock(const clockid_t clock, bool gettime)
+static struct pid *__pid_for_clock(const clockid_t clock, const clockid_t maxclock, bool gettime)
 {
 	const bool thread = !!CPUCLOCK_PERTHREAD(clock);
 	const pid_t upid = CPUCLOCK_PID(clock);
 	struct pid *pid;
 
-	if (CPUCLOCK_WHICH(clock) >= CPUCLOCK_MAX)
+	if (CPUCLOCK_WHICH(clock) > maxclock)
 		return NULL;
 
 	/*
@@ -94,12 +94,17 @@ static struct pid *pid_for_clock(const c
 	return pid_has_task(pid, PIDTYPE_TGID) ? pid : NULL;
 }
 
+static inline struct pid *pid_for_clock(const clockid_t clock, bool gettime)
+{
+	return __pid_for_clock(clock, CPUCLOCK_SCHED, gettime);
+}
+
 static inline int validate_clock_permissions(const clockid_t clock)
 {
 	int ret;
 
 	rcu_read_lock();
-	ret = pid_for_clock(clock, false) ? 0 : -EINVAL;
+	ret = __pid_for_clock(clock, CPUCLOCK_DVFS, false) ? 0 : -EINVAL;
 	rcu_read_unlock();
 
 	return ret;
@@ -344,7 +349,7 @@ static u64 cpu_clock_sample_group(const
 {
 	struct thread_group_cputimer *cputimer = &p->signal->cputimer;
 	struct posix_cputimers *pct = &p->signal->posix_cputimers;
-	u64 samples[CPUCLOCK_MAX];
+	u64 samples[CPUCLOCK_SAMPLE_MAX];
 
 	if (!READ_ONCE(pct->timers_active)) {
 		if (start)
@@ -365,7 +370,7 @@ static int posix_cpu_clock_get(const clo
 	u64 t;
 
 	rcu_read_lock();
-	tsk = pid_task(pid_for_clock(clock, true), clock_pid_type(clock));
+	tsk = pid_task(__pid_for_clock(clock, CPUCLOCK_DVFS, true), clock_pid_type(clock));
 	if (!tsk) {
 		rcu_read_unlock();
 		return -EINVAL;
@@ -864,7 +869,7 @@ static void collect_posix_cputimers(stru
 	struct posix_cputimer_base *base = pct->bases;
 	int i;
 
-	for (i = 0; i < CPUCLOCK_MAX; i++, base++) {
+	for (i = 0; i < CPUCLOCK_SAMPLE_MAX; i++, base++) {
 		base->nextevt = collect_timerqueue(&base->tqhead, firing,
 						    samples[i]);
 	}
@@ -901,7 +906,7 @@ static void check_thread_timers(struct t
 				struct list_head *firing)
 {
 	struct posix_cputimers *pct = &tsk->posix_cputimers;
-	u64 samples[CPUCLOCK_MAX];
+	u64 samples[CPUCLOCK_SAMPLE_MAX];
 	unsigned long soft;
 
 	if (dl_task(tsk))
@@ -979,7 +984,7 @@ static void check_process_timers(struct
 {
 	struct signal_struct *const sig = tsk->signal;
 	struct posix_cputimers *pct = &sig->posix_cputimers;
-	u64 samples[CPUCLOCK_MAX];
+	u64 samples[CPUCLOCK_SAMPLE_MAX];
 	unsigned long soft;
 
 	/*
@@ -1098,7 +1103,7 @@ task_cputimers_expired(const u64 *sample
 {
 	int i;
 
-	for (i = 0; i < CPUCLOCK_MAX; i++) {
+	for (i = 0; i < CPUCLOCK_SAMPLE_MAX; i++) {
 		if (samples[i] >= pct->bases[i].nextevt)
 			return true;
 	}
@@ -1121,7 +1126,7 @@ static inline bool fastpath_timer_check(
 	struct signal_struct *sig;
 
 	if (!expiry_cache_is_inactive(pct)) {
-		u64 samples[CPUCLOCK_MAX];
+		u64 samples[CPUCLOCK_SAMPLE_MAX];
 
 		task_sample_cputime(tsk, samples);
 		if (task_cputimers_expired(samples, pct))
@@ -1146,7 +1151,7 @@ static inline bool fastpath_timer_check(
 	 * delays with signals actually getting sent are expected.
 	 */
 	if (READ_ONCE(pct->timers_active) && !READ_ONCE(pct->expiry_active)) {
-		u64 samples[CPUCLOCK_MAX];
+		u64 samples[CPUCLOCK_SAMPLE_MAX];
 
 		proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic,
 					   samples);
@@ -1669,7 +1674,7 @@ static int thread_cpu_timer_create(struc
 	return posix_cpu_timer_create(timer);
 }
 static int thread_dvfs_cpu_clock_get(const clockid_t which_clock,
-				struct timespec64 *tp)
+				     struct timespec64 *tp)
 {
 	return posix_cpu_clock_get(THREAD_DVFS_CLOCK, tp);
 }

