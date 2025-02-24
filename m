Return-Path: <linux-kernel+bounces-528681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3788A41A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA607A43C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EC62566F2;
	Mon, 24 Feb 2025 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h5gMxkCF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vM5YNVS2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C252566C6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392143; cv=none; b=MSP6hTvrkIoPBi8QcdkQObd2Wd4e5vaUsWNMNVf3Qy6nkTag9QrLckeFGqaQ94Sn+42q8wV9mt002ciYbGGSbo/neoa/wukQhS6XB1nXQmpNQ9+z7tfCaObdEv/Dnbc5+bNIMSfKuNDCSOLDIjciAm3dMYzi2xusqQNpf8kVA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392143; c=relaxed/simple;
	bh=tFZKLBufjlSPa2QmZK7wvDYA8mN7BBwRUnjgIaoND3s=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MVoiaZ57iFefxQQHdixV9k34La+K4x32rEfRjc1M5w91hluXBeTGhj7OBTcuYWcZ3U9MOikefy+A4EOeGgvmY+N8M9x9VRK3s3FOcNq7nThcJkeRaCm5De43IP9kaU30WP/FsctJO2qnC4h/e50qghQ5IjoFNfRzV+paEw2JJV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h5gMxkCF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vM5YNVS2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250224101343.607036635@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740392139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qUenPqK6NF1jZZxvjiZu6Tv4No0pSQ/kqqxuaPEsWtQ=;
	b=h5gMxkCFhlbques8r3OdZKD2TqWW0VPXm3/LFHiSjbjk/4DUGSh/OenM2MLkxzPpOiJBKS
	0y98rsfPFou9qzdG001kSGGLpnegM5lPETgcMVz17+KXqU8UgTXBQ3PYOabIKTLidpFAyz
	91Ut7Al+21Px7+AsWi6xYjwjsHReEDvKtfp12hQ0Jq3VF+TdghX3+o+f9Pjujyyqdh5hY3
	/HEOAQJB4Tj2nE5nd3jOCd5HO+skf2vsdTjCTtNRXCkuWW1ziMML0QU3BRNyAO3G3nr1lB
	LIOXhGZsrMXdeL8xwbdH4SPZyc9UxEUbumg2pWVYmEc5OxvBo2v/f7OLEqrLrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740392139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qUenPqK6NF1jZZxvjiZu6Tv4No0pSQ/kqqxuaPEsWtQ=;
	b=vM5YNVS2gwCM++LzMXno1YDAy76bo6DfBD59dfzvfcypxhrXItLwwuThFykOPac1o5rV+R
	KJrLOUrMWa1uk+Dw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 10/11] posix-timers: Provide a mechanism to allocate a given
 timer ID
References: <20250224095736.145530367@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 11:15:39 +0100 (CET)

Checkpoint/Restore in Userspace (CRIU) requires to reconstruct posix timers
with the same timer ID on restore. It uses sys_timer_create() and relies on
the monotonic increasing timer ID provided by this syscall. It creates and
deletes timers until the desired ID is reached. This is can loop for a long
time, when the checkpointed process had a very sparse timer ID range.

It has been debated to implement a new syscall to allow the creation of
timers with a given timer ID, but that's tideous due to the 32/64bit compat
issues of sigevent_t and of dubious value.

The restore mechanism of CRIU creates the timers in a state where all
threads of the restored process are held on a barrier and cannot issue
syscalls. That means the restorer task has exclusive control.

This allows to address this issue with a prctl() so that the restorer
thread can do:

   if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_ON))
      goto linear_mode;
   create_timers_with_explicit_ids();
   prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_OFF);
   
This is backwards compatible because the prctl() fails on older kernels and
CRIU can fall back to the linear timer ID mechanism. CRIU versions which do
not know about the prctl() just work as before.

Implement the prctl() and modify timer_create() so that it copies the
requested timer ID from userspace by utilizing the existing timer_t
pointer, which is used to copy out the allocated timer ID on success.

If the prctl() is disabled, which it is by default, timer_create() works as
before and does not try to read from the userspace pointer.

There is no problem when a broken or rogue user space application enables
the prctl(). If the user space pointer does not contain a valid ID, then
timer_create() fails. If the data is not initialized, but constains a
random valid ID, timer_create() will create that random timer ID or fail if
the ID is already given out. 
 
As CRIU must use the raw syscall to avoid manipulating the internal state
of the restored process, this has no library dependencies and can be
adopted by CRIU right away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    2 +
 include/linux/sched/signal.h |    1 
 include/uapi/linux/prctl.h   |   10 +++++
 kernel/sys.c                 |    5 ++
 kernel/time/posix-timers.c   |   86 ++++++++++++++++++++++++++++++-------------
 5 files changed, 78 insertions(+), 26 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -114,6 +114,7 @@ bool posixtimer_init_sigqueue(struct sig
 void posixtimer_send_sigqueue(struct k_itimer *tmr);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *timer_sigq);
 void posixtimer_free_timer(struct k_itimer *timer);
+long posixtimer_create_prctl(unsigned long ctrl);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -140,6 +141,7 @@ static inline void posixtimer_rearm_itim
 static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info,
 					     struct sigqueue *timer_sigq) { return false; }
 static inline void posixtimer_free_timer(struct k_itimer *timer) { }
+static inline long posixtimer_create_prctl(unsigned long ctrl) { return -EINVAL; }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -136,6 +136,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
+	unsigned int		timer_create_restore_ids:1;
 	atomic_t		next_posix_timer_id;
 	struct hlist_head	posix_timers;
 	struct hlist_head	ignored_posix_timers;
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -353,4 +353,14 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      76
 
+/*
+ * Controls the mode of timer_create() for CRIU restore operations.
+ * Enabling this allows CRIU to restore timers with explicit IDs.
+ *
+ * Don't use for normal operations as the result might be undefined.
+ */
+#define PR_TIMER_CREATE_RESTORE_IDS		77
+# define PR_TIMER_CREATE_RESTORE_IDS_OFF	0
+# define PR_TIMER_CREATE_RESTORE_IDS_ON		1
+
 #endif /* _LINUX_PRCTL_H */
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2811,6 +2811,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 			return -EINVAL;
 		error = arch_lock_shadow_stack_status(me, arg2);
 		break;
+	case PR_TIMER_CREATE_RESTORE_IDS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = posixtimer_create_prctl(arg2);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/posix-clock.h>
 #include <linux/posix-timers.h>
+#include <linux/prctl.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
@@ -57,6 +58,8 @@ static const struct k_clock * const posi
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
 static const struct k_clock clock_realtime, clock_monotonic;
 
+#define TIMER_ANY_ID		INT_MIN
+
 /* SIGEV_THREAD_ID cannot share a bit with the other SIGEV values. */
 #if SIGEV_THREAD_ID != (SIGEV_THREAD_ID & \
 			~(SIGEV_SIGNAL | SIGEV_NONE | SIGEV_THREAD))
@@ -114,38 +117,49 @@ static bool posix_timer_hashed(struct ti
 	return false;
 }
 
-static int posix_timer_add(struct k_itimer *timer)
+static bool posix_timer_add_at(struct k_itimer *timer, struct signal_struct *sig, unsigned int id)
+{
+	struct timer_hash_bucket *bucket = &timer_buckets[hash(sig, id)];
+
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
+			timer->it_id = (timer_t)id;
+			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
+			hlist_add_head_rcu(&timer->t_hash, &bucket->head);
+			return true;
+		}
+	}
+	return false;
+}
+
+static int posix_timer_add(struct k_itimer *timer, int req_id)
 {
 	struct signal_struct *sig = current->signal;
 
+	if (unlikely(req_id != TIMER_ANY_ID))
+		return posix_timer_add_at(timer, sig, req_id) ? req_id : -EBUSY;
+
 	for (unsigned int cnt = 0; cnt <= INT_MAX; cnt++) {
 		/* Get the next timer ID and clamp it to positive space */
 		unsigned int id = (atomic_inc_return(&sig->next_posix_timer_id) - 1) & INT_MAX;
-		struct timer_hash_bucket *bucket = &timer_buckets[hash(sig, id)];
 
-		scoped_guard (spinlock, &bucket->lock) {
-			/*
-			 * Validate under the lock as this could have raced
-			 * against another thread ending up with the same
-			 * ID, which is highly unlikely, but possible.
-			 */
-			if (!posix_timer_hashed(bucket, sig, id)) {
-				/*
-				 * Set the timer ID and the signal pointer to make
-				 * it identifiable in the hash table. The signal
-				 * pointer has bit 0 set to indicate that it is not
-				 * yet fully initialized. posix_timer_hashed()
-				 * masks this bit out, but the syscall lookup fails
-				 * to match due to it being set. This guarantees
-				 * that there can't be duplicate timer IDs handed
-				 * out.
-				 */
-				timer->it_id = (timer_t)id;
-				timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
-				hlist_add_head_rcu(&timer->t_hash, &bucket->head);
-				return id;
-			}
-		}
+		if (posix_timer_add_at(timer, sig, id))
+			return id;
 		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
@@ -351,6 +365,16 @@ static enum hrtimer_restart posix_timer_
 	return HRTIMER_NORESTART;
 }
 
+long posixtimer_create_prctl(unsigned long ctrl)
+{
+	if (ctrl > PR_TIMER_CREATE_RESTORE_IDS_ON)
+		return -EINVAL;
+
+	guard(spinlock_irq)(&current->sighand->siglock);
+	current->signal->timer_create_restore_ids = ctrl == PR_TIMER_CREATE_RESTORE_IDS_ON;
+	return 0;
+}
+
 static struct pid *good_sigevent(sigevent_t * event)
 {
 	struct pid *pid = task_tgid(current);
@@ -419,6 +443,7 @@ static int do_timer_create(clockid_t whi
 			   timer_t __user *created_timer_id)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
+	timer_t req_id = TIMER_ANY_ID;
 	struct k_itimer *new_timer;
 	int error, new_timer_id;
 
@@ -433,11 +458,20 @@ static int do_timer_create(clockid_t whi
 
 	spin_lock_init(&new_timer->it_lock);
 
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
 	 * after insertion, but has a unique ID allocated.
 	 */
-	new_timer_id = posix_timer_add(new_timer);
+	new_timer_id = posix_timer_add(new_timer, req_id);
 	if (new_timer_id < 0) {
 		posixtimer_free_timer(new_timer);
 		return new_timer_id;


