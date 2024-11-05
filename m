Return-Path: <linux-kernel+bounces-396531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 594589BCE8C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5F81C21AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE061D86D2;
	Tue,  5 Nov 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5sGL1cv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253711D6DB9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815360; cv=none; b=WPdE5ysSpbHU+w8Em6HivyX3uOeoQZfcB72amvzReSSnyWDJvyUx/d7+oL5Hb7xfJYnh3wz+oGVPh9jDwVYRbxGVvjsQTUwlOGU8rzr7m/QlmBdpvgchmXBh8dZJNWc2H7FQhoHvnUs36tyxW3Y0HMBt3H+t7e3XpT3xa+8zCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815360; c=relaxed/simple;
	bh=0OZ7H2tLfnSUWSnhubxMCj0lCzR56IbwW/WhCr1PKx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U903dc17ZrH0qo+Rm7rj2r7hiFdOHwCiiKb0nvnYT0PGM2T4f1ZU1KL+ku0aGkNM0nJTsL0wszsiPZ4TvRK/X2HA5bKjKVbbXURTijcgm6RzWykCSGbX3AokpQnE7EwV/cZx9IhPrN29qujV39hm+9gfntr2GBjVlEm9p/8i+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5sGL1cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE5AC4CECF;
	Tue,  5 Nov 2024 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730815359;
	bh=0OZ7H2tLfnSUWSnhubxMCj0lCzR56IbwW/WhCr1PKx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5sGL1cvRxUD6zB9Ypg6VxHvmGs/hVtXgri0woIExFuStACIHRH2lhh7WlSNLnKjv
	 1MVYD9bXbBLbvh4SGI062qxMpZOJYxs2P5qxRzUDo7r5EikqaRADrikXQIsq/tCv8U
	 EW3SzLd9kwY5NbzwwxgxEUCriejfw9Nm9J/eaWaoLI4vLf3F+L2j0qL0YiRrfe0m/w
	 nmO61f7PoYBOxRLHZYNrkZ+Pb1tkdVNge5Y4TIlguwW8Q3zrs5shxodtluQHmHD6P3
	 Xr0NWh/wWKBubHkpVCHMqv16tMshMjK9/B/WqorLtvjKIlCFLNZjinsY+4aeXmiwAy
	 6R8+agH4VGwZQ==
Date: Tue, 5 Nov 2024 15:02:34 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V7 18/21] signal: Queue ignored posixtimers on ignore list
Message-ID: <ZyoleilcEIVlr7dE@2a01cb09803abb1ce3ad97aed0fef98f.ipv6.abo.wanadoo.fr>
References: <20241105063544.565410398@linutronix.de>
 <20241105064214.120756416@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105064214.120756416@linutronix.de>

Le Tue, Nov 05, 2024 at 09:14:54AM +0100, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Queue posixtimers which have their signal ignored on the ignored list:
> 
>    1) When the timer fires and the signal has SIG_IGN set
> 
>    2) When SIG_IGN is installed via sigaction() and a timer signal
>       is already queued
> 
> This only happens when the signal is for a valid timer, which delivered the
> signal in periodic mode. One-shot timer signals are correctly dropped.
> 
> Due to the lock order constraints (sighand::siglock nests inside
> timer::lock) the signal code cannot access any of the timer fields which
> are relevant to make this decision, e.g. timer::it_status.
> 
> This is addressed by establishing a protection scheme which requires to
> lock both locks on the timer side for modifying decision fields in the
> timer struct and therefore makes it possible for the signal delivery to
> evaluate with only sighand:siglock being held:
> 
>   1) Move the NULLification of timer->it_signal into the sighand::siglock
>      protected section of timer_delete() and check timer::it_signal in the
>      code path which determines whether the signal is dropped or queued on
>      the ignore list.
> 
>      This ensures that a deleted timer cannot be moved onto the ignore
>      list, which would prevent it from being freed on exit() as it is not
>      longer in the process' posix timer list.
> 
>      If the timer got moved to the ignored list before deletion then it is
>      removed from the ignored list under sighand lock in timer_delete().
> 
>   2) Provide a new timer::it_sig_periodic flag, which gets set in the
>      signal queue path with both timer and sighand locks held if the timer
>      is actually in periodic mode at expiry time.
> 
>      The ignore list code checks this flag under sighand::siglock and drops
>      the signal when it is not set.
> 
>      If it is set, then the signal is moved to the ignored list independent
>      of the actual state of the timer.
> 
>      When the signal is un-ignored later then the signal is moved back to
>      the signal queue. On signal delivery the posix timer side decides
>      about dropping the signal if the timer was re-armed, dis-armed or
>      deleted based on the signal sequence counter check.
> 
>      If the thread/process exits then not yet delivered signals are
>      discarded which means the reference of the timer containing the
>      sigqueue is dropped and frees the timer.
> 
>      This is way cheaper than requiring all code paths to lock
>      sighand::siglock of the target thread/process on any modification of
>      timer::it_status or going all the way and removing pending signals
>      from the signal queues on every rearm, disarm or delete operation.
> 
> So the protection scheme here is that on the timer side both timer::lock
> and sighand::siglock have to be held for modifying
> 
>    timer::it_signal
>    timer::it_sig_periodic
> 
> which means that on the signal side holding sighand::siglock is enough to
> evaluate these fields.
>                                                                                                                                                                                                                                                                                                                              
> In posixtimer_deliver_signal() holding timer::lock is sufficient to do the
> sequence validation against timer::it_signal_seq because a concurrent
> expiry is waiting on timer::lock to be released.
> 
> This completes the SIG_IGN handling and such timers are not longer self
> rearmed which avoids pointless wakeups.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> V7: Fix exit/delete race conditions and use a protected field for the
>     periodic detection - Frederic
>    
> ---
>  include/linux/posix-timers.h |    2 +
>  kernel/signal.c              |   80 ++++++++++++++++++++++++++++++++++++++++---
>  kernel/time/posix-timers.c   |    7 +++
>  3 files changed, 83 insertions(+), 6 deletions(-)
> ---
> 
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -160,6 +160,7 @@ static inline void posix_cputimers_init_
>   * @it_clock:		The posix timer clock id
>   * @it_id:		The posix timer id for identifying the timer
>   * @it_status:		The status of the timer
> + * @it_sig_periodic:	The periodic status at signal delivery
>   * @it_overrun:		The overrun counter for pending signals
>   * @it_overrun_last:	The overrun at the time of the last delivered signal
>   * @it_signal_seq:	Sequence count to control signal delivery
> @@ -184,6 +185,7 @@ struct k_itimer {
>  	clockid_t		it_clock;
>  	timer_t			it_id;
>  	int			it_status;
> +	bool			it_sig_periodic;
>  	s64			it_overrun;
>  	s64			it_overrun_last;
>  	unsigned int		it_signal_seq;
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -59,6 +59,8 @@
>  #include <asm/cacheflush.h>
>  #include <asm/syscall.h>	/* for syscall_get_* */
>  
> +#include "time/posix-timers.h"
> +
>  /*
>   * SLAB caches for signal bits.
>   */
> @@ -731,6 +733,16 @@ void signal_wake_up_state(struct task_st
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
> +}
> +
>  /* Remove signals in mask from the pending set and queue. */
>  static void flush_sigqueue_mask(struct task_struct *p, sigset_t *mask, struct sigpending *s)
>  {
> @@ -747,7 +759,7 @@ static void flush_sigqueue_mask(struct t
>  	list_for_each_entry_safe(q, n, &s->list, list) {
>  		if (sigismember(mask, q->info.si_signo)) {
>  			list_del_init(&q->list);
> -			__sigqueue_free(q);
> +			sigqueue_free_ignored(p, q);
>  		}
>  	}
>  }
> @@ -1964,7 +1976,7 @@ int posixtimer_send_sigqueue(struct k_it
>  	int sig = q->info.si_signo;
>  	struct task_struct *t;
>  	unsigned long flags;
> -	int ret, result;
> +	int result;
>  
>  	guard(rcu)();
>  
> @@ -1981,13 +1993,55 @@ int posixtimer_send_sigqueue(struct k_it
>  	 */
>  	tmr->it_sigqueue_seq = tmr->it_signal_seq;
>  
> -	ret = 1; /* the signal is ignored */
> +	/*
> +	 * Set the signal delivery status under sighand lock, so that the
> +	 * ignored signal handling can distinguish between a periodic and a
> +	 * non-periodic timer.
> +	 */
> +	tmr->it_sig_periodic = tmr->it_status == POSIX_TIMER_REQUEUE_PENDING;

It much clearer with this, thanks!

I'm not yet completely confident with the SIGCONT/SIGSTOP part but since
the previous behaviour wasn't too self-confident either:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

