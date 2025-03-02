Return-Path: <linux-kernel+bounces-540747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DABEA4B479
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F053B0072
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4EE1EFF82;
	Sun,  2 Mar 2025 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iONGsM6p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vl0eo9wN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4951EF0B0
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944222; cv=none; b=LftZBLCbsm/GW52AbHPOdVMxFgFfSSUl2qWspSGee5GzwoolYnhhIbwZILBbmTnKPyGZ/lKhrI0Jz+EEppHRwggepBtD9NQ8cMYjXEUJnh3jleE+1pCDf68OTr3hzHaIJyPF1zDqD6MSVxjZxk8GZD3g6ErIEKhKgw/N1j3pmjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944222; c=relaxed/simple;
	bh=DAo6tqgpyFyCHP4VV4EihR4zoAKwOImm2nHPrHvXTDQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bPYmFth1XIXa/OhiGuQT8gI5pcmZt3MqFTRIxCGCku5c9bY9sOKfuMT1u4TlZ+vTC+6X15JGE/quTcuodJlQRCBQcb4Vj3l+QuJXhd6Fq9i64jS9j0ZBsWOoqgD8FwVgHZ7lstybUk+pzJStmp5IDhlZELWGXg+quJ15Bu3froc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iONGsM6p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vl0eo9wN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.480949005@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mH3NTv/8aQ+ZDpstJx5O7HCZL1s7rrY1IQNFX3q1COo=;
	b=iONGsM6pLuqi4m50bG+M8yyzyFw82ET+A8wwAAJ1k/A8gWo1oVoYjU4sga1fFU7VurFFJ6
	Ou59AZ5s42UNkwxFycnKw39pdqHZlxzIDP9J6EG8mThXme9zyWOkZLB3fiEHEj52+ReIP8
	72oAWKiHnhu2zG+esbQQR2+Yz0lzaPGX8xOx3C0vXa0w0/1jxCxtrpO+yB+EIUVRx+do9v
	28ItWXr8F63qtWeUnpJl4woi95SJ/gUXScg3spKtY1bzWQwY/sSusKXQZXpEDS4yh4Nnhz
	XRrHzyUFZyejz+ZsKt6tZfmtF056mQknAUCdCJceTGZCJAp02+eHsx7JiyZHJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mH3NTv/8aQ+ZDpstJx5O7HCZL1s7rrY1IQNFX3q1COo=;
	b=Vl0eo9wNRLjrVDXoaXvTd28sZj1N7idbRccoyxkimkFVjsY618+l/6wgYh9JfvNX6IoBi3
	uq68x3AHUaSuHRBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 09/17] posix-timers: Make lock_timer() use guard()
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:36:58 +0100 (CET)

From: Peter Zijlstra <peterz@infradead.org>

The lookup and locking of posix timers requires the same repeating pattern
at all usage sites:

   tmr = lock_timer(tiner_id);
   if (!tmr)
   	return -EINVAL;
   ....
   unlock_timer(tmr);

Solve this with a guard implementation, which works in most places out of
the box except for those, which need to unlock the timer inside the guard
scope.

Though the only places where this matters are timer_delete() and
timer_settime(). In both cases the timer pointer needs to be preserved
across the end of the scope, which is solved by storing the pointer in a
variable outside of the scope.

timer_settime() also has to protect the timer with RCU before unlocking,
which obviously can't use guard(rcu) before leaving the guard scope as that
guard is cleaned up before the unlock. Solve this by providing the RCU
protection open coded.

[ tglx: Made it work and added change log ]

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by-yet: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250224162103.GD11590@noisy.programming.kicks-ass.net
---
V2: New patch
---
 include/linux/cleanup.h    |   22 ++++++----
 kernel/time/posix-timers.c |   91 +++++++++++++++++----------------------------
 2 files changed, 49 insertions(+), 64 deletions(-)

--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -291,11 +291,21 @@ static inline class_##_name##_t class_##
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
 static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
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
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
-	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return (void *)(__force unsigned long)*_T; }
+	DEFINE_CLASS_IS_GUARD(_name)
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
@@ -375,11 +385,7 @@ static inline void class_##_name##_destr
 	if (_T->lock) { _unlock; }					\
 }									\
 									\
-static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
-{									\
-	return (void *)(__force unsigned long)_T->lock;			\
-}
-
+__DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
 
 #define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
 static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -66,6 +66,14 @@ static inline void unlock_timer(struct k
 	spin_unlock_irq(&timr->it_lock);
 }
 
+#define scoped_timer_get_or_fail(_id)					\
+	scoped_cond_guard(lock_timer, return -EINVAL, _id)
+
+#define scoped_timer				(scope)
+
+DEFINE_CLASS(lock_timer, struct k_itimer *, unlock_timer(_T), __lock_timer(id), timer_t id);
+DEFINE_CLASS_IS_COND_GUARD(lock_timer);
+
 static int hash(struct signal_struct *sig, unsigned int nr)
 {
 	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
@@ -675,18 +683,10 @@ void common_timer_get(struct k_itimer *t
 
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
-	struct k_itimer *timr;
-	int ret = 0;
-
-	timr = lock_timer(timer_id);
-	if (!timr)
-		return -EINVAL;
-
 	memset(setting, 0, sizeof(*setting));
-	timr->kclock->timer_get(timr, setting);
-
-	unlock_timer(timr);
-	return ret;
+	scoped_timer_get_or_fail(timer_id)
+		scoped_timer->kclock->timer_get(scoped_timer, setting);
+	return 0;
 }
 
 /* Get the time remaining on a POSIX.1b interval timer. */
@@ -740,17 +740,8 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t
  */
 SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 {
-	struct k_itimer *timr;
-	int overrun;
-
-	timr = lock_timer(timer_id);
-	if (!timr)
-		return -EINVAL;
-
-	overrun = timer_overrun_to_int(timr);
-	unlock_timer(timr);
-
-	return overrun;
+	scoped_timer_get_or_fail(timer_id)
+		return timer_overrun_to_int(scoped_timer);
 }
 
 static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
@@ -868,12 +859,9 @@ int common_timer_set(struct k_itimer *ti
 	return 0;
 }
 
-static int do_timer_settime(timer_t timer_id, int tmr_flags,
-			    struct itimerspec64 *new_spec64,
+static int do_timer_settime(timer_t timer_id, int tmr_flags, struct itimerspec64 *new_spec64,
 			    struct itimerspec64 *old_spec64)
 {
-	int ret;
-
 	if (!timespec64_valid(&new_spec64->it_interval) ||
 	    !timespec64_valid(&new_spec64->it_value))
 		return -EINVAL;
@@ -881,36 +869,28 @@ static int do_timer_settime(timer_t time
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 
-	for (;;) {
-		struct k_itimer *timr = lock_timer(timer_id);
+	for (; ; old_spec64 = NULL) {
+		struct k_itimer *timr;
 
-		if (!timr)
-			return -EINVAL;
+		scoped_timer_get_or_fail(timer_id) {
+			timr = scoped_timer;
 
-		if (old_spec64)
-			old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
+			if (old_spec64)
+				old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
 
-		/* Prevent signal delivery and rearming. */
-		timr->it_signal_seq++;
-
-		ret = timr->kclock->timer_set(timr, tmr_flags, new_spec64, old_spec64);
-		if (ret != TIMER_RETRY) {
-			unlock_timer(timr);
-			break;
-		}
+			/* Prevent signal delivery and rearming. */
+			timr->it_signal_seq++;
 
-		/* Read the old time only once */
-		old_spec64 = NULL;
-		/* Protect the timer from being freed after the lock is dropped */
-		guard(rcu)();
-		unlock_timer(timr);
-		/*
-		 * timer_wait_running() might drop RCU read side protection
-		 * so the timer has to be looked up again!
-		 */
+			int ret = timr->kclock->timer_set(timr, tmr_flags, new_spec64, old_spec64);
+			if (ret != TIMER_RETRY)
+				return ret;
+
+			/* Protect the timer from being freed when leaving the lock scope */
+			rcu_read_lock();
+		}
 		timer_wait_running(timr);
+		rcu_read_unlock();
 	}
-	return ret;
 }
 
 /* Set a POSIX.1b interval timer */
@@ -1021,13 +1001,12 @@ static void posix_timer_delete(struct k_
 /* Delete a POSIX.1b interval timer. */
 SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 {
-	struct k_itimer *timer = lock_timer(timer_id);
-
-	if (!timer)
-		return -EINVAL;
+	struct k_itimer *timer;
 
-	posix_timer_delete(timer);
-	unlock_timer(timer);
+	scoped_timer_get_or_fail(timer_id) {
+		timer = scoped_timer;
+		posix_timer_delete(timer);
+	}
 	/* Remove it from the hash, which frees up the timer ID */
 	posix_timer_unhash_and_free(timer);
 	return 0;


