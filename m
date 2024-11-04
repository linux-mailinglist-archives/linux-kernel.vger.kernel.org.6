Return-Path: <linux-kernel+bounces-394770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28BB9BB3AF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7836E1F21FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB181B219A;
	Mon,  4 Nov 2024 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvbkpayy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245281B1D65
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720541; cv=none; b=Wtwr+AuYmE7wRlt7EibWtViYZcYN3yc6MsM+f5l4z8d3KO/GS1Yhwcwb0soP8wG62JN0JRAJiKSIhY5X38BMSiLHlRCKwi4vPqDwXQ4wtI7keSOKpALQGIKX0t9tF96l1CCqz8OW6PmYaCYQey0qng9pA4qGpUrfTLiiTmEkurc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720541; c=relaxed/simple;
	bh=k7s6V58otnDEuhtjSFw6L4603p3fuSbZMj5LDWuXBO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3UExpFtkhi/6wDibUhlJ/PqO50FC7kOQq3NqbkSDp9iBKYkiVl5Wya9DuA3c8jwbXj22J4KNlx7tGjCZyqeZLMXUEGwpODcMakjCUMPS2XxTHc86RUXtP6AI/ItCxsej5N5rKm/b/ZYeDIi3UqnsMFP+23jwKalnx/E9QEZLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvbkpayy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8BDC4CECE;
	Mon,  4 Nov 2024 11:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730720539;
	bh=k7s6V58otnDEuhtjSFw6L4603p3fuSbZMj5LDWuXBO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvbkpayyYq7LU2I//JKbbzr9JZeFkU+cZq8Jul+vPQrZinyCnCg4f4xOV+ZhCSvBZ
	 Nmdvs8FSBJYdGMGubw8Xqi2zMvgyvCDcYzprh+kPui0etnC16jnsFFbXsgExeEdxeN
	 irWj0VfRxsHxsUIVAIDFXIdYdRTmhMd0A7zMdNVk7PZfaCtkUn0dqq6NjrNOLDcgk6
	 8n/plYKofcJIcLdcUwMajDAtoewOhswLfqnaZn89H8fOt1tmdwoqxIqNdttrvpyUw5
	 WmWKC90IQaxXU5kU0vZ9Tjgp3Nso3fPsJIkwhzfCGbu5TlOJy6S8Ox1XHvoNqn81C3
	 yeOw71sWEaoOQ==
Date: Mon, 4 Nov 2024 12:42:16 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v6.1 17/20] signal: Queue ignored posixtimers on ignore
 list
Message-ID: <ZyizGM4-3FmPDtGj@localhost.localdomain>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.624061922@linutronix.de>
 <8734k9qrcr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734k9qrcr.ffs@tglx>

Le Sat, Nov 02, 2024 at 10:05:08PM +0100, Thomas Gleixner a écrit :
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
> V6.1: Handle oneshot timer expiry or transitioning from periodic to
>       oneshot after a rearming correctly. - Frederic
> ---
>  kernel/signal.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 5 deletions(-)
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
> +}
> +
>  /* Remove signals in mask from the pending set and queue. */
>  static void flush_sigqueue_mask(struct task_struct *p, sigset_t *mask, struct sigpending *s)
>  {
> @@ -747,7 +757,7 @@ static void flush_sigqueue_mask(struct t
>  	list_for_each_entry_safe(q, n, &s->list, list) {
>  		if (sigismember(mask, q->info.si_signo)) {
>  			list_del_init(&q->list);
> -			__sigqueue_free(q);
> +			sigqueue_free_ignored(p, q);
>  		}
>  	}
>  }
> @@ -1964,7 +1974,7 @@ int posixtimer_send_sigqueue(struct k_it
>  	int sig = q->info.si_signo;
>  	struct task_struct *t;
>  	unsigned long flags;
> -	int ret, result;
> +	int result;
>  
>  	guard(rcu)();
>  
> @@ -1981,13 +1991,48 @@ int posixtimer_send_sigqueue(struct k_it
>  	 */
>  	tmr->it_sigqueue_seq = tmr->it_signal_seq;
>  
> -	ret = 1; /* the signal is ignored */
>  	if (!prepare_signal(sig, t, false)) {
>  		result = TRACE_SIGNAL_IGNORED;
> +
> +		/* Paranoia check. Try to survive. */
> +		if (WARN_ON_ONCE(!list_empty(&q->list)))
> +			goto out;
> +
> +		/* Periodic timers with SIG_IGN are queued on the ignored list */
> +		if (tmr->it_status == POSIX_TIMER_REQUEUE_PENDING) {
> +			/*
> +			 * Already queued means the timer was rearmed after
> +			 * the previous expiry got it on the ignore list.
> +			 * Nothing to do for that case.
> +			 */
> +			if (hlist_unhashed(&tmr->ignored_list)) {
> +				/*
> +				 * Take a signal reference and queue it on
> +				 * the ignored list.
> +				 */
> +				posixtimer_sigqueue_getref(q);
> +				posixtimer_sig_ignore(t, tmr);
> +			}
> +		} else if (!hlist_unhashed(&tmr->ignored_list)) {
> +			/*
> +			 * Covers the case where a timer was periodic and
> +			 * then signal was ignored. Then it was rearmed as
> +			 * oneshot timer. The previous signal is invalid
> +			 * now, and the oneshot signal has to be dropped.
> +			 * Remove it from the ignored list and drop the
> +			 * reference count as the signal is not longer
> +			 * queued.
> +			 */
> +			hlist_del_init(&tmr->ignored_list);
> +			posixtimer_putref(tmr);
> +		}
>  		goto out;
>  	}
>  
> -	ret = 0;
> +	/* This should never happen and leaks a reference count */
> +	if (WARN_ON_ONCE(!hlist_unhashed(&tmr->ignored_list)))
> +		hlist_del_init(&tmr->ignored_list);
> +
>  	if (unlikely(!list_empty(&q->list))) {
>  		/* This holds a reference count already */
>  		result = TRACE_SIGNAL_ALREADY_PENDING;
> @@ -2000,7 +2045,21 @@ int posixtimer_send_sigqueue(struct k_it
>  out:
>  	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type != PIDTYPE_PID, result);
>  	unlock_task_sighand(t, &flags);
> -	return ret;
> +	return 0;
> +}
> +
> +static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
> +{
> +	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
> +
> +	/*
> +	 * Only enqueue periodic timer signals to the ignored list. For
> +	 * oneshot timers, drop the reference count.
> +	 */
> +	if (tmr->it_status == POSIX_TIMER_REQUEUE_PENDING)

This is read locklessly against timer lock. So it only makes sure that
the last write to POSIX_TIMER_REQUEUE_PENDING will be visible due to the
sighand locking. However it may or may not see the other states written after.
Which looks ok because if the timer is concurrently armed / disarmed / or even
requeue pending again, then either the signal is dropped and it's fine or the
signal is moved to the ignored list and the seq will take care of the validity
upon delivery.

Still this may need a WRITE_ONCE() / READ_ONCE().

But there is something more problematic against the delete() path:
                                   
Thread within                  Signal target             Timer target
signal target group
--------------------           -------------             -------------
                                                         timr->it_status = POSIX_TIMER_REQUEUE_PENDING
                                                         posixtimer_send_sigqueue();
                                                         do_exit();
timer_delete()
    posix_cpu_timer_del()
        // return NULL
        cpu_timer_task_rcu()
        // timer->it_status NOT set
        // to POSIX_TIMER_DISARMED
    hlist_del(&timer->list);
    posix_timer_cleanup_ignored()


                               do_sigaction(SIG_IGN...)
                               flush_sigqueue_mask()
                                  sigqueue_free_ignored()
                                      posixtimer_sig_ignore()
                                          // Observe POSIX_TIMER_REQUEUE_PENDING
                                          hlist_add_head(...ignored_posix_timers)
                               do_exit()
                                   exit_itimers()
                                   if (hlist_empty(&tsk->signal->posix_timers))
                                       return;
                                   // leaked timer queued to migrate list
                                   


> +		hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
> +	else
> +		posixtimer_putref(tmr);
>  }

Thanks.

