Return-Path: <linux-kernel+bounces-444798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7875C9F0CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A872282FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CB51DF736;
	Fri, 13 Dec 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B+ft+Ry+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE281DFE04
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093984; cv=none; b=WtQKBNuET4sfg3ovAoV54PCJlsWdvb9sX5JQ/pJisU9iy/ifE1MpQwqIV/PhsQKUpSJIiaoBxinmMZv4424wWzJOx8Hc1+9q1yzuwC6K7SEKI8ovtxVhq9OIBp3NwyEaUmUuX+EBhK3SI/Rv1n8IAJxypiM06I68Yh0exEyPIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093984; c=relaxed/simple;
	bh=thlok1CfL06wcvQX+28Qnz6C04TjoNd5+5nx+qUM5xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNs6mALxTVBUt8xKMNLipGJeeClsGPD6LQUT2wgMsgWBkJzHaQuJm7XRsBd3GL6lJlvrFHFFR2PDmM/noGmNdIe1qLSx/Kx4FeeCO+nU7Qavgh2fn/SbVF59a9DnyiomfXCwekMfzWGDVHCedvSr19Vrcl/45Y8wSLsNSfkdgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B+ft+Ry+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kKnnXGxBgrXo8pBr3PlNv3tQuU4P1ia/Phvtxts7lNQ=; b=B+ft+Ry+cYpNY6UkYRhn/+nAiL
	MOxUohUCE2Cvg2qxxUq+wpGGPyZV8xjfxsV953cAjrPBuooBa3sc3CbvW8MjqBA2wJAGfJ7WXBsl3
	kQD5qFLZO0vjXEq0qZ0kHegCO+BPn3sk7oMpCkdiDnj6dAB0IZC8/CpeBCLYAsStzwvGl1Dc9Qv5E
	jQT5zE7KVPDCgH9gwpwr0zD6u5pwGC9H0UqNXb9vb4jqGGMa8iRn6t3LCXzSdS/cXfqXz32BJP5CR
	AAin50pK/uMyi9jHUI6megLvLdnzPOFDCWpiLHwYgTChbYg+8/Ruk8DFOVcpFvz1+2btLg4tVr9+I
	Bvtpu9XA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM53f-0000000Cwi0-2sdD;
	Fri, 13 Dec 2024 12:46:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 125CE30049D; Fri, 13 Dec 2024 13:46:15 +0100 (CET)
Date: Fri, 13 Dec 2024 13:46:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bert Karwatzki <spasswolf@web.de>, kernel-team@android.com
Subject: Re: [RFC][PATCH] locking/rtmutex: Make sure we wake anything on the
 wake_q when we release the lock->wait_lock
Message-ID: <20241213124614.GA12338@noisy.programming.kicks-ass.net>
References: <20241212222138.2400498-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212222138.2400498-1-jstultz@google.com>

On Thu, Dec 12, 2024 at 02:21:33PM -0800, John Stultz wrote:
> Bert reported seeing occasional boot hangs when running with
> PREEPT_RT and bisected it down to commit 894d1b3db41c
> ("locking/mutex: Remove wakeups from under mutex::wait_lock").
> 
> It looks like I missed a few spots where we drop the wait_lock and
> potentially call into schedule without waking up the tasks on the
> wake_q structure. Since the tasks being woken are ww_mutex tasks
> they need to be able to run to release the mutex and unblock the
> task that currently is planning to wake them. Thus we can deadlock.
> 
> So make sure we wake the wake_q tasks when we unlock the wait_lock.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bert Karwatzki <spasswolf@web.de>
> Cc: kernel-team@android.com
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Closes: https://lore.kernel.org/lkml/20241211182502.2915-1-spasswolf@web.de
> Fixes: 894d1b3db41c ("locking/mutex: Remove wakeups from under mutex::wait_lock")
> Signed-off-by: John Stultz <jstultz@google.com>
> ---

I don't suppose this actually makes things much better -- but I had to
try.


--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1192,6 +1192,17 @@ try_to_take_rt_mutex(struct rt_mutex_bas
 	return 1;
 }
 
+#define WRAP_WAKE(_stmt, _q) \
+do { \
+	struct wake_q_head *_Q = (_q); \
+	guard(preempt)(); \
+	_stmt; \
+	if (_Q && !wake_q_empty(_Q)) { \
+		wake_up_q(_Q); \
+		wake_q_init(_Q); \
+	} \
+} while (0)
+
 /*
  * Task blocks on lock.
  *
@@ -1248,10 +1259,7 @@ static int __sched task_blocks_on_rt_mut
 
 		/* Check whether the waiter should back out immediately */
 		rtm = container_of(lock, struct rt_mutex, rtmutex);
-		preempt_disable();
-		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx, wake_q);
-		wake_up_q(wake_q);
-		preempt_enable();
+		WRAP_WAKE(res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx, wake_q), wake_q);
 		if (res) {
 			raw_spin_lock(&task->pi_lock);
 			rt_mutex_dequeue(lock, waiter);
@@ -1295,13 +1303,7 @@ static int __sched task_blocks_on_rt_mut
 	 */
 	get_task_struct(owner);
 
-	preempt_disable();
-	raw_spin_unlock_irq(&lock->wait_lock);
-	/* wake up any tasks on the wake_q before calling rt_mutex_adjust_prio_chain */
-	wake_up_q(wake_q);
-	wake_q_init(wake_q);
-	preempt_enable();
-
+	WRAP_WAKE(raw_spin_unlock_irq(&lock->wait_lock), wake_q);
 
 	res = rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
@@ -1645,13 +1647,8 @@ static int __sched rt_mutex_slowlock_blo
 			owner = rt_mutex_owner(lock);
 		else
 			owner = NULL;
-		preempt_disable();
-		raw_spin_unlock_irq(&lock->wait_lock);
-		if (wake_q) {
-			wake_up_q(wake_q);
-			wake_q_init(wake_q);
-		}
-		preempt_enable();
+
+		WRAP_WAKE(raw_spin_unlock_irq(&lock->wait_lock), wake_q);
 
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
 			rt_mutex_schedule();
@@ -1802,10 +1799,7 @@ static int __sched rt_mutex_slowlock(str
 	 */
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q);
-	preempt_disable();
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	WRAP_WAKE(raw_spin_unlock_irqrestore(&lock->wait_lock, flags), &wake_q);
 	rt_mutex_post_schedule();
 
 	return ret;
@@ -1863,11 +1857,8 @@ static void __sched rtlock_slowlock_lock
 			owner = rt_mutex_owner(lock);
 		else
 			owner = NULL;
-		preempt_disable();
-		raw_spin_unlock_irq(&lock->wait_lock);
-		wake_up_q(wake_q);
-		wake_q_init(wake_q);
-		preempt_enable();
+
+		WRAP_WAKE(raw_spin_unlock_irq(&lock->wait_lock), wake_q);
 
 		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
 			schedule_rtlock();
@@ -1896,10 +1887,8 @@ static __always_inline void __sched rtlo
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	rtlock_slowlock_locked(lock, &wake_q);
-	preempt_disable();
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
+
+	WRAP_WAKE(raw_spin_unlock_irqrestore(&lock->wait_lock, flags), &wake_q);
 }
 
 #endif /* RT_MUTEX_BUILD_SPINLOCKS */

