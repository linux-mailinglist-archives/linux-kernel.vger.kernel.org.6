Return-Path: <linux-kernel+bounces-392353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D8E9B92FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C752F282ED3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6B81A0708;
	Fri,  1 Nov 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIE7ANHl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C83BBE5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730470877; cv=none; b=ZCSrVqcKdynv/ce3oWd47CVY10KT5BTID5GaIX1Lsa+50JZPBBUv92sisj6PrYd3ZPPIiYxUtr1rpCRSQMUKvbGFyNVqvISN27GbjnknLYjyYs7/Jh9QODHDHxZlpj44V59mbodBZPlocE5BDtEQNXeqkM5JD/xdI+QZ7wu5dl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730470877; c=relaxed/simple;
	bh=21rfnrBEs+ee2o/IHfTEvBY72a5VhwQ4a4/jRehC3Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpO2GH0yA5LpO/Sg7jm7y/Pmsric+4N86J3VCfKqIjgDwJBnqxg5uNNYjzlFFSCANocWKNtDK0rIkIPjFYV48nD8lSsWFdxs/qxcbBvRdl71UAbdqDuO/fGLd8xc5+DmjkNhbBTg8z/Fe6TMIoqhjcLB7tIHs4Ttbkf3JuoEOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIE7ANHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E12C4CED1;
	Fri,  1 Nov 2024 14:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730470876;
	bh=21rfnrBEs+ee2o/IHfTEvBY72a5VhwQ4a4/jRehC3Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIE7ANHlCP0C/sghkwEolcfR2iBYACaXdhw3WY4/j3MTl+kanbFJSCyJWzE/W8q9V
	 XIt3+JqiH+WbHzwzOdVnVy5lAUQd5KLERyMSS4pJoWnM6p29sayfus5q7b/LXYLgpT
	 VHhGY++j1YyjWgXZT8M3VZbpztXnHzfpZNnrTTkZnfVdOvGHWj+L23ic33fCW9Yp3p
	 SqXJs/gNzARWVPS7b0DwSqYnlXwn5cfxOINXlbsa7WuuQxtP7CZE0hTjzU1sVa4KBZ
	 HHCSsG/IvoAjKlnM8UoplqMtzJkUJDiJ87dE2lqxZeCQxZm+btcMrp9zJ/k90ocXNY
	 UPc6foRz9GNJA==
Date: Fri, 1 Nov 2024 15:21:13 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 17/20] signal: Queue ignored posixtimers on ignore list
Message-ID: <ZyTj2W8Jndv0nzga@localhost.localdomain>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.624061922@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031154425.624061922@linutronix.de>

Le Thu, Oct 31, 2024 at 04:46:43PM +0100, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Queue posixtimers which have their signal ignored on the ignored list:
> 
>    1) When the timer fires and the signal has SIG_IGN set
> 
>    2) When SIG_IGN is installed via sigaction() and a timer signal
>       is already queued
> 
> This completes the SIG_IGN handling and such timers are not longer self
> rearmed which avoids pointless wakeups.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/signal.c |   39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> ---
> 
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -731,6 +731,16 @@ void signal_wake_up_state(struct task_st
>  		kick_process(t);
>  }
>  
> +static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q);
> +
> +static void sigqueue_free_ignored(struct task_struct *tsk, struct sigqueue *q)
> +{
> +	if (likely(!(q->flags & SIGQUEUE_PREALLOC) || q->info.si_code != SI_TIMER))
> +		__sigqueue_free(q);
> +	else
> +		posixtimer_sig_ignore(tsk, q);

So this happens when the signal is ignored and delays it to when it will be
unignored. But the comment on do_sigaction() says:

		/*
		 * POSIX 3.3.1.3:
		 *  "Setting a signal action to SIG_IGN for a signal that is
		 *   pending shall cause the pending signal to be discarded,
		 *   whether or not it is blocked."
		 *
		 */

Are posix timers an exception to that rule?

Also I see flush_sigqueue_mask() called on other occasions, for example
when a STOP signal happens to remove pending CONT, not sure if posix
timers can set SIGCONT...

Thanks.

