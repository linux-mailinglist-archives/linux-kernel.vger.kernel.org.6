Return-Path: <linux-kernel+bounces-379989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A579AE6CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A270B25703
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FA21DF980;
	Thu, 24 Oct 2024 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN1u/MYZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0F1B3937
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776852; cv=none; b=OFXez6YvKpfT97CxClqVUifsjaH/z3Ycxrabc+/ByiJ1b0Zke/5YHDsiZjdrull8S+Hvxh9BbmMEK2+frMBNhgJnzWCM8f+8QAMuARWhYVkbMqEMS+dJ4O6Sltyg5/gBy+OxY/RjQmSDAzwZuXLG5fAgTqOFV913W/DnKIquOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776852; c=relaxed/simple;
	bh=1GS9CsTtXdYQuGet7fNSiGg/6v6vyLjdziGmJGwc3V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZQvCXLR8qQaFq/JyrNyNxABDjEIR999bei5VhtQBkuDjY8GDgsFk7Oiv27TzeW7Xs1rDfHCQUfkNfUeG4Y9V09jGw+dg66fuGz2CnhhksmWvW+sLRDspv9A8Zq2AIipX86U2A3W+Cy7XWXG/KUeGMt32zr2WcWBbLvzKj0r9BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN1u/MYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C081C4CEC7;
	Thu, 24 Oct 2024 13:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729776851;
	bh=1GS9CsTtXdYQuGet7fNSiGg/6v6vyLjdziGmJGwc3V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oN1u/MYZXBkHTlivJrfDeviWyv3fRZU3w5PUhaGIFRAXd+14usy+MajQCKYQ01F1A
	 Oz0f7LGk9EVKGqmejrVa4wFRT1qmX0uIyo8hWdRWxRTdEbNkxEv2MdePmezAchXtWm
	 ff497dPw910Hhphoko4tSr3WhLP2GB57Y64kkPrSN6oaC5vSA2tE+YdctXEk6r8uDR
	 zTeVCVS9stB9ULFjU+L0dosJJQkeDwVrCVyt0XzbutRHz/CV5/1sFRLIzo0SoY4iKM
	 wVYnKEmRrQpTN4WaMscVuAotOt0+nHBxs2m8NzDtYGo24bwo4du7viK6AVTe2QTOIZ
	 52SIILTzAXlaA==
Date: Thu, 24 Oct 2024 15:34:08 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 09/26] posix-timers: Make signal overrun accounting
 sensible
Message-ID: <ZxpM0NLZc_MAGoNc@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.790542522@linutronix.de>
 <ZxbNlw4F5tUI1a5D@pavilion.home>
 <87ldyd6fq8.ffs@tglx>
 <87ed456f4e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ed456f4e.ffs@tglx>

Le Thu, Oct 24, 2024 at 11:10:09AM +0200, Thomas Gleixner a écrit :
> On Thu, Oct 24 2024 at 10:57, Thomas Gleixner wrote:
> > On Mon, Oct 21 2024 at 23:54, Frederic Weisbecker wrote:
> >> Le Tue, Oct 01, 2024 at 10:42:12AM +0200, Thomas Gleixner a écrit :
> >>> +	/*
> >>> +	 * Set the overrun count to zero unconditionally. The posix timer
> >>> +	 * code does not self rearm periodic timers. They are rearmed from
> >>> +	 * dequeue_signal().
> >>> +	 *
> >>> +	 * But there is a situation where @q is already enqueued:
> >>> +	 *
> >>> +	 * 1) timer_settime()
> >>> +	 *      arm_timer()
> >>> +	 * 2) timer_expires()
> >>> +	 *      send_sigqueue(@q)
> >>> +	 *        enqueue(@q)
> >>> +	 * 3) timer_settime()
> >>> +	 *      arm_timer()
> >>> +	 * 4) timer_expires()
> >>> +	 *      send_sigqueue(@q) <- Observes @q already queued
> >>> +	 *
> >>> +	 * In this case incrementing si_overrun does not make sense because
> >>> +	 * there is no relationship between timer_settime() #1 and #2.
> >>> +	 *
> >>> +	 * The POSIX specification is useful as always: "The effect of
> >>> +	 * disarming or resetting a timer with pending expiration
> >>> +	 * notifications is unspecified."
> >>> +	 *
> >>> +	 * Just do the sensible thing and reset the overrun.
> >>> +	 */
> >>> +	q->info.si_overrun = 0;
> >>
> >> So this means that in the above example case, no signal at all is going to be
> >> delivered (because the seq will be impaired on the previously queued
> >> signal) and no overrun count will be incremented either?
> >
> > So #2 queues the signal, but before delivery the timer is rearmed, which
> > invalidates the signal via the sequence count. So #4 has to set the
> > overrun counter which might be set already.
> 
> The signal will be delivered. It's either already marked as pending, but
> not yet delivered or it is masked and will be marked pending on unmask.

Oh I see now, si_sys_private is still overwritten with the new seq value
even if the signal is already queued. So yes the old queued signal will
remain valid and apply for the latest event. Phew!

> 
> >>> +
> >>>  	ret = 1; /* the signal is ignored */
> >>>  	result = TRACE_SIGNAL_IGNORED;
> >>>  	if (!prepare_signal(sig, t, false))
> >>> @@ -1968,15 +1996,9 @@ int send_sigqueue(struct sigqueue *q, st
> >>>  
> >>>  	ret = 0;
> >>>  	if (unlikely(!list_empty(&q->list))) {
> >>> -		/*
> >>> -		 * If an SI_TIMER entry is already queue just increment
> >>> -		 * the overrun count.
> >>> -		 */
> >>> -		q->info.si_overrun++;
> >>
> >> Who is ever incrementing this after that? I'm a bit confused between the
> >> timer overrun and the sigqueue overrun. Those seem to be two different
> >> things without any link...
> >
> > Hmm. You're right. This should now never happen. Let me stare at it some
> > moar.
> 
> Of course it can happen that the signal is queued. See above scenario :)
> 
> But q->info.si_overrun should never be anything else than 0. The timer code
> increments the overrun counter and updates si_overrun on signal
> delivery, but that's done on the siginfo which is a copy of q->info.

Bah right of course. But then, there is an undocumented side effect
to this patch in that it also resets the value when a queued signal
is ignored.

> 
> This seems to be a leftover from early posix-timer days... So that
> change can be reduced to removing the increment.

Ok. One thing you can add to this patch is the following, since now si_overrun
is expected to be 0 upon delivery (nothing can change it between the
enqueue and the delivery)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index ff7970030b17..0d44e3d87cd3 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -233,11 +233,12 @@ __initcall(init_posix_timers);
  * The siginfo si_overrun field and the return value of timer_getoverrun(2)
  * are of type int. Clamp the overrun value to INT_MAX
  */
-static inline int timer_overrun_to_int(struct k_itimer *timr, int baseval)
+static inline int timer_overrun_to_int(struct k_itimer *timr)
 {
-	s64 sum = timr->it_overrun_last + (s64)baseval;
+	if (timr->it_overrun_last > (s64)INT_MAX)
+		return INT_MAX;
 
-	return sum > (s64)INT_MAX ? INT_MAX : (int)sum;
+	return (int)timr->it_overrun_last;
 }
 
 static void common_hrtimer_rearm(struct k_itimer *timr)
@@ -280,7 +281,7 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 		timr->it_overrun = -1LL;
 		++timr->it_signal_seq;
 
-		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
+		info->si_overrun = timer_overrun_to_int(timr);
 	}
 	ret = true;
 
@@ -783,7 +784,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 	if (!timr)
 		return -EINVAL;
 
-	overrun = timer_overrun_to_int(timr, 0);
+	overrun = timer_overrun_to_int(timr);
 	unlock_timer(timr, flags);
 
 	return overrun;

