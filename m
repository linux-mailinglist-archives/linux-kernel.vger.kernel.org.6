Return-Path: <linux-kernel+bounces-375197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBE99A9260
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2FD2838BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78AA1E32A2;
	Mon, 21 Oct 2024 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gbgue5UC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F81990C8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547675; cv=none; b=t7tystUm52jB0gI3tMa0pFE3Ohm2QJ+UNhjcrKHRTTVZE3W8tE1DLPRMM2qB4KQ9JH/peSyXsjBwRWhi9uNcQLzJR1id3zptAaJVwy/WlcKq8TZqnyDzTAmDokjeIZT88CqtSoUHY5EEcsVXDx0q2WsWZL5v2pYYjmbXMadtrSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547675; c=relaxed/simple;
	bh=sw+dBGfFbqpKv9a1ctQHwNLTPSK8mhahzDAhyz5qpAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT158C9u7MotA0E+lGqjPd8RUYOI0bGdpuAxHkhnie60YMPzlaYffnywPkyOBYmUDMm0xXyBO2QwI5bovyfsKxZ31Qlpgiyy5giiwh0f3E2eSFlO21k+anP8OAgs3vKcKizNY0EDH5mxQ9e4qAiQpzf84h+FWgpc0kr7V0jktnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gbgue5UC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A69FC4CEC3;
	Mon, 21 Oct 2024 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729547674;
	bh=sw+dBGfFbqpKv9a1ctQHwNLTPSK8mhahzDAhyz5qpAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gbgue5UCC6NSGITKZC7v2QFwc6i10sDz/wKroW9aomETPeuwARU1RDkEPCQLxPtg5
	 WupsDYNa/+MUivH8Qgk0MpS8JFdfdtKG5zymRC4pAtqnFn34btdhpWICZLWI6knQwY
	 6tisn4KISrm5mCknSBNAtTC/FpiEl9aRY+zMnjV7Exl2dER15/BwKHyAVQB6BUoz5c
	 Nj42Oj6qbw+dXbCNE6csmBn2PYPoQTfiu+DocuuCbcY9t2kmU0z9fvbp5Ya9NIbO/u
	 IEaZi5/eJNeBINGy7CCZmFWTBBudR/+q6c/HHyX0dpts9Z2H55tv9i4LT4RNOU1Ol5
	 IV7w3tn65vBqg==
Date: Mon, 21 Oct 2024 23:54:31 +0200
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
Message-ID: <ZxbNlw4F5tUI1a5D@pavilion.home>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.790542522@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083835.790542522@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:12AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The handling of the timer overrun in the signal code is inconsistent as it
> takes previous overruns into account. This is just wrong as after the
> reprogramming of a timer the overrun count starts over from a clean state,
> i.e. 0.
> 
> Make the accounting in send_sigqueue() consistent with that.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/signal.c |   34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> ---
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1961,6 +1961,34 @@ int send_sigqueue(struct sigqueue *q, st
>  	 */
>  	q->info.si_sys_private = si_private;
>  
> +	/*
> +	 * Set the overrun count to zero unconditionally. The posix timer
> +	 * code does not self rearm periodic timers. They are rearmed from
> +	 * dequeue_signal().
> +	 *
> +	 * But there is a situation where @q is already enqueued:
> +	 *
> +	 * 1) timer_settime()
> +	 *      arm_timer()
> +	 * 2) timer_expires()
> +	 *      send_sigqueue(@q)
> +	 *        enqueue(@q)
> +	 * 3) timer_settime()
> +	 *      arm_timer()
> +	 * 4) timer_expires()
> +	 *      send_sigqueue(@q) <- Observes @q already queued
> +	 *
> +	 * In this case incrementing si_overrun does not make sense because
> +	 * there is no relationship between timer_settime() #1 and #2.
> +	 *
> +	 * The POSIX specification is useful as always: "The effect of
> +	 * disarming or resetting a timer with pending expiration
> +	 * notifications is unspecified."
> +	 *
> +	 * Just do the sensible thing and reset the overrun.
> +	 */
> +	q->info.si_overrun = 0;

So this means that in the above example case, no signal at all is going to be
delivered (because the seq will be impaired on the previously queued
signal) and no overrun count will be incremented either?

> +
>  	ret = 1; /* the signal is ignored */
>  	result = TRACE_SIGNAL_IGNORED;
>  	if (!prepare_signal(sig, t, false))
> @@ -1968,15 +1996,9 @@ int send_sigqueue(struct sigqueue *q, st
>  
>  	ret = 0;
>  	if (unlikely(!list_empty(&q->list))) {
> -		/*
> -		 * If an SI_TIMER entry is already queue just increment
> -		 * the overrun count.
> -		 */
> -		q->info.si_overrun++;

Who is ever incrementing this after that? I'm a bit confused between the
timer overrun and the sigqueue overrun. Those seem to be two different
things without any link...

Thanks.

>  		result = TRACE_SIGNAL_ALREADY_PENDING;
>  		goto out;
>  	}
> -	q->info.si_overrun = 0;
>  
>  	signalfd_notify(t, sig);
>  	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
> 

