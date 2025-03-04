Return-Path: <linux-kernel+bounces-544355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CA1A4E054
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0AA1793A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2E9206F1B;
	Tue,  4 Mar 2025 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WiSY7ixg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l4QxbnnT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72317206F14
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097297; cv=none; b=tjrI1wDUupvrHZtZpVeN8i7Ge67wq5MIAqfE//POSsLEKhSnz0QNpth+J19jj1oahE/gGE5/BauCAQdu6zwLpJe9HD1bv/0FFNj8Yoa91Bf4GM3geoDw6ezPsr15fa22syD2aNVjOvWbhZ83FkPpsMqwkuLWD/SLymJc+EQldHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097297; c=relaxed/simple;
	bh=E+xWwTR1Aqli+zBLMjHkAMyWovGIKrBuamaEmQ6Uun8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yonho8RRi7bezoZXCQkxUAxJ/ka5yOF2NdbPgpGhSZuZLMFtr4dyr1pjxomhrcDv7jFEhbIN+Fo2RMA4LwG5NuB5tkPECGXAV1nKMs094PD6cGzauxNLVoJBt+9KEPJBy4TEppK/wQahTGtagBCLceLBCU760h4LbLh2a51WPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WiSY7ixg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l4QxbnnT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741097293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auTU3+uFQNm0dQ1wwFy4iWqBlKhStGiG/cF56W5BvSg=;
	b=WiSY7ixgd7qFmx0CNimT82B2gnUyIlI27nBQnQ1wo+gIJDzZovxMeKungdpkSqkSp8PEwG
	sLe/0q1iS1xihz1s38VQ/0Jct2UnMNvl5uUFlSidCGgPZkmECcyankeXf97z89Vd/Yf4k0
	b10jp4hdWP6tZLXwfPewX54/eO8lsnHbL71FI1Ke3NiBQZ5u0cHdubmxTwLdMmdkQCu3ef
	Y2xuWcwuvx0UXAUo0W/htA+dLDQy4EAWWZK74EPCwGMoodC9lW2/mlrU2VzDXHojrCZKFy
	bHaBpDJXeaOwbS6Qq3G69gcXw0TZDs0l1rQV3vKfF8q6lK3gT73jkzq41/446Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741097293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auTU3+uFQNm0dQ1wwFy4iWqBlKhStGiG/cF56W5BvSg=;
	b=l4QxbnnT1zNyWdk+9uM4v+kXI3Zp8oSsU9u8A97gmJ/Ji8YpxeDnoQauzvFahBv8KXHM/c
	ZwU11hr0nbKwAgCg==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Benjamin Segall <bsegall@google.com>, Eric Dumazet
 <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2a 09/17] posix-timers: Make lock_timer() use guard()
In-Reply-To: <20250302193627.480949005@linutronix.de>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.480949005@linutronix.de>
Date: Tue, 04 Mar 2025 15:08:13 +0100
Message-ID: <875xko7usy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


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
V2a: Make unlock conditional - 0day
V2: New patch
---
 include/linux/cleanup.h    |   22 ++++++----
 kernel/time/posix-timers.c |   94 +++++++++++++++++----------------------------
 2 files changed, 51 insertions(+), 65 deletions(-)

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
@@ -63,9 +63,18 @@ static struct k_itimer *__lock_timer(tim
 
 static inline void unlock_timer(struct k_itimer *timr)
 {
-	spin_unlock_irq(&timr->it_lock);
+	if (likely((timr)))
+		spin_unlock_irq(&timr->it_lock);
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
@@ -675,18 +684,10 @@ void common_timer_get(struct k_itimer *t
 
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
@@ -740,17 +741,8 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t
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
@@ -868,12 +860,9 @@ int common_timer_set(struct k_itimer *ti
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
@@ -881,36 +870,28 @@ static int do_timer_settime(timer_t time
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
@@ -1021,13 +1002,12 @@ static void posix_timer_delete(struct k_
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

