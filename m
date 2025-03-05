Return-Path: <linux-kernel+bounces-547366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0102A5064D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225A51887E18
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287AB24CEED;
	Wed,  5 Mar 2025 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjaItOsh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4469C1A4F09
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195529; cv=none; b=uQQGNnpPOZL+6zOxYhMrVFRDEsWWxnJRNaKxbCApr1EQRpAU9xUVG6urUaptqzqMfIg33f8IaYI7UHrayKsr4LMhG2JULQm1Mz+te7gvT5EzBdnbCCfuH4ytKH3dwmETp1lZggc8F0JUnrBQYfGf17g4UKdW3OjS/l2lV993Me8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195529; c=relaxed/simple;
	bh=/9lALd+9Zj5t2LHqte/RJr2nlfUVYg/mag+NGFZhrCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwly8siLSshl7WJrdAxjZwXxKo+bT4GJz2WDh4YHMdGkMDZ2xSTiSd6Y9UPf+lqIwGUjAbWahyRYGv67o5e08a3pM2R+Ww/zzCeLE7ZwCyk6By7KzKjlzQk+/7NF5AtyCkkYCuH6IZsJ9Ci9eu2qRgjvHrkKGzsDohO7yVMqdio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjaItOsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E10EC4CEE0;
	Wed,  5 Mar 2025 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741195528;
	bh=/9lALd+9Zj5t2LHqte/RJr2nlfUVYg/mag+NGFZhrCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjaItOshie131gq0GX7DGNyLKv9gv9WWfq/7XshnJ8erde/MyMvCw5X1qAh6sPirA
	 gpChfin5SmEYA57DKQPRGAAPXXyBDnqdp723G6EQdRZMKwABbY/1ZYs6NN98MZZzbr
	 9G9PFAbb3pQ+pMTOEzvcNp+/R+nI/pKyWJ3bQCD0LEIezhJwaVEX9YCvG3uXwOi7aC
	 L/qK6biemsxgGsrfZgztL3xEFG472F/upSWUQV/339l8gFZ9EfAQYoaC75u/SJUNP6
	 GowQ96ir4EN+FT1sXZssCjPplH44m0p34V5I8AoJMUmjliDl8+fyLMrfTvFp6CQ+E+
	 8m2SqRSxpUHpg==
Date: Wed, 5 Mar 2025 18:25:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 01/17] posix-timers: Initialise timer before adding it
 to the hash table
Message-ID: <Z8iJBXFQLUkcndsI@localhost.localdomain>
References: <20250302185753.311903554@linutronix.de>
 <20250302193626.974094734@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302193626.974094734@linutronix.de>

Le Sun, Mar 02, 2025 at 08:36:44PM +0100, Thomas Gleixner a écrit :
> From: Eric Dumazet <edumazet@google.com>
> 
> A timer is only valid in the hashtable when both timer::it_signal and
> timer::it_id are set to their final values, but timers are added without
> those values being set.
> 
> The timer ID is allocated when the timer is added to the hash in invalid
> state. The ID is taken from a monotonically increasing per process counter
> which wraps around after reaching INT_MAX. The hash insertion validates
> that there is no timer with the allocated ID in the hash table which
> belongs to the same process. That opens a mostly theoretical race condition:
> 
> If other threads of the same process manage to create/delete timers in
> rapid succession before the newly created timer is fully initialized and
> wrap around to the timer ID which was handed out, then a duplicate timer ID
> will be inserted into the hash table.
> 
> Prevent this by:
> 
>   1) Setting timer::it_id before inserting the timer into the hashtable.
>  
>   2) Storing the signal pointer in timer::it_signal with bit 0 set before
>      inserting it into the hashtable.
> 
>      Bit 0 acts as a invalid bit, which means that the regular lookup for
>      sys_timer_*() will fail the comparison with the signal pointer.
> 
>      But the lookup on insertion masks out bit 0 and can therefore detect a
>      timer which is not yet valid, but allocated in the hash table.  Bit 0
>      in the pointer is cleared once the initialization of the timer
>      completed.
> 
> [ tglx: Fold ID and signal iniitializaion into one patch and massage change
>   	log and comments. ]
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/all/20250219125522.2535263-3-edumazet@google.com

Looking at this more or less lockless whole thing again, is the
ordering between creation and subsequent operations sufficiently guaranteed?

    T0                                                T1
---------                                             -----------
do_timer_create()
    posix_timer_add()
        spin_lock(hash_lock)
        // A
        timer->it_id = ...
        spin_unlock(hash_lock)
    // Initialize timer fields
    // B
    new_timer->.... = ....
    common_timer_create()
        // C
        hrtimer_init()
    spin_lock(current->sighand)
    // D
    WRITE_ONCE(new_timer->it_signal, current->signal)
    spin_unlock(current->sighand)
                                                      do_timer_settime()
                                                          lock_timer()
                                                              // observes A && D
                                                              posix_timer_by_id()
                                                              spin_lock_irqsave(&timr->it_lock)
                                                              // recheck ok
                                                              if (timr->it_signal == current->signal)
                                                                  return timr
                                                              common_timer_get()
                                                                  // fiddle with timer fields
                                                                  // but doesn't observe B
                                                                  // for example doesn't observe SIGEV_NONE
                                                                  sig_none = timr->it_sigev_notify == SIGEV_NONE;
                                                                  ...
                                                                  // doesn't observe C
                                                                  // hrtimer_init() isn't visible yet
                                                                  // It might mess up after the hrtimer_start()
                                                                  hrtimer_start()

How about the following instead?

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 44ba7db07e90..8769a1ccf69a 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -72,26 +72,29 @@ static int hash(struct signal_struct *sig, unsigned int nr)
 	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
 }
 
-static struct k_itimer *__posix_timers_find(struct hlist_head *head,
-					    struct signal_struct *sig,
-					    timer_t id)
+static struct k_itimer *posix_timer_by_id(timer_t id)
 {
+	struct signal_struct *sig = current->signal;
+	struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
 	struct k_itimer *timer;
 
-	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
-		/* timer->it_signal can be set concurrently */
-		if ((READ_ONCE(timer->it_signal) == sig) && (timer->it_id == id))
+	hlist_for_each_entry_rcu(timer, head, t_hash) {
+		if (timer->it_signal == sig && timer->it_id == id &&
+		    !hlist_unhashed_lockless(&timer->list))
 			return timer;
 	}
 	return NULL;
 }
 
-static struct k_itimer *posix_timer_by_id(timer_t id)
+static bool posix_timer_hashed(struct hlist_head *head, struct signal_struct *sig, timer_t id)
 {
-	struct signal_struct *sig = current->signal;
-	struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
+	struct k_itimer *timer;
 
-	return __posix_timers_find(head, sig, id);
+	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
+		if (timer->it_signal == sig && timer->it_id == id)
+			return true;
+	}
+	return false;
 }
 
 static int posix_timer_add(struct k_itimer *timer)
@@ -112,7 +115,15 @@ static int posix_timer_add(struct k_itimer *timer)
 		sig->next_posix_timer_id = (id + 1) & INT_MAX;
 
 		head = &posix_timers_hashtable[hash(sig, id)];
-		if (!__posix_timers_find(head, sig, id)) {
+		if (!posix_timer_hashed(head, sig, id)) {
+			/*
+			 * Set the timer ID and the signal pointer to make
+			 * it identifiable in the global hash table. Its
+			 * lookup is only valid to lock_timer() once it is
+			 * hashed within the process itself.
+			 */
+			timer->it_id = (timer_t)id;
+			timer->it_signal = sig;
 			hlist_add_head_rcu(&timer->t_hash, head);
 			spin_unlock(&hash_lock);
 			return id;
@@ -406,8 +417,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 
 	/*
 	 * Add the timer to the hash table. The timer is not yet valid
-	 * because new_timer::it_signal is still NULL. The timer id is also
-	 * not yet visible to user space.
+	 * after insertion, but has a unique ID allocated.
 	 */
 	new_timer_id = posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
@@ -415,7 +425,6 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 		return new_timer_id;
 	}
 
-	new_timer->it_id = (timer_t) new_timer_id;
 	new_timer->it_clock = which_clock;
 	new_timer->kclock = kc;
 	new_timer->it_overrun = -1LL;
@@ -453,7 +462,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	}
 	/*
 	 * After succesful copy out, the timer ID is visible to user space
-	 * now but not yet valid because new_timer::signal is still NULL.
+	 * now but not yet valid until it's hashed to the process list.
 	 *
 	 * Complete the initialization with the clock specific create
 	 * callback.
@@ -462,11 +471,15 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	if (error)
 		goto out;
 
-	spin_lock_irq(&current->sighand->siglock);
-	/* This makes the timer valid in the hash table */
-	WRITE_ONCE(new_timer->it_signal, current->signal);
+	spin_lock_irq(&new_timer->it_lock);
+	spin_lock(&current->sighand->siglock);
 	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
-	spin_unlock_irq(&current->sighand->siglock);
+	spin_unlock(&current->sighand->siglock);
+	/*
+	 * Release initialization and ->timer_create() job to subsequent
+	 * lock_timer()
+	 */
+	spin_unlock_irq(&new_timer->it_lock);
 	/*
 	 * After unlocking sighand::siglock @new_timer is subject to
 	 * concurrent removal and cannot be touched anymore
@@ -526,7 +539,7 @@ static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 	 * rest of the initialization succeeded.
 	 *
 	 * Timer destruction happens in steps:
-	 *  1) Set timr::it_signal to NULL with timr::it_lock held
+	 *  1) Delete timr::list under timr::it_lock held
 	 *  2) Release timr::it_lock
 	 *  3) Remove from the hash under hash_lock
 	 *  4) Put the reference count.
@@ -551,10 +564,12 @@ static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 	if (timr) {
 		spin_lock_irqsave(&timr->it_lock, *flags);
 		/*
-		 * Validate under timr::it_lock that timr::it_signal is
-		 * still valid. Pairs with #1 above.
+		 * Validate under timr::it_lock that the timer hasn't been
+		 * deleted. If so, timr::it_signal isn't expected to change
+		 * within the same RCU critical section. Pairs with #1 above.
 		 */
-		if (timr->it_signal == current->signal) {
+		if (hlist_unhashed(&timr->list) ||
+		    WARN_ON_ONCE(timr->it_signal != current->signal)) {
 			rcu_read_unlock();
 			return timr;
 		}
@@ -1009,7 +1024,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 	}
 
 	spin_lock(&current->sighand->siglock);
-	hlist_del(&timer->list);
+	hlist_del_init(&timer->list);
 	posix_timer_cleanup_ignored(timer);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It

