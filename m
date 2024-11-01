Return-Path: <linux-kernel+bounces-392320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EE09B926C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360B41C2138E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736361AC882;
	Fri,  1 Nov 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpUcoav2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8031AC44D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468861; cv=none; b=oJsukDzoSzGNqyUaiFcTNRCD8NMqyfm73yurkfrairYc3llyxjRQszofUCz8FLv2MBsxG58748ixljKT90CL0XAJuiSHJYgpjW9CSf5+MFdsbDfxxZjziXPINcRjyxrJ5MKqfczjddn+BWkwLxD6XfArIfpn4vs+UkX12iA3wLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468861; c=relaxed/simple;
	bh=47uTeQgoJLNZjdbSAh3U3MwKZLtfUnSxH0iHFozGPyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR4AdHLZntvN3637dEM9Y216IvIOBYuHb7XXgU1+2Hzp5k4H0BA3fAnHbwIOdipkctMsA7kDAAN0v04TU05icCstKN2yXoovImmCyiGpndwRfpehs03NfT09lyTuJjCTmAPmO873XounR5Y0fZpX5l978cYf4ljUbeElsZVJNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpUcoav2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B12C4CECD;
	Fri,  1 Nov 2024 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730468861;
	bh=47uTeQgoJLNZjdbSAh3U3MwKZLtfUnSxH0iHFozGPyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpUcoav2WIsJDPm9I3YgFd6H9M18PhiPUmyWT8fZwievZE4oM8RcYdnuZwRPoCKt9
	 BHwAwgIudj6yQJLOqNJjlACB5ON5xH1b9TLcNyT2WUCSOh9u35jZCD7Ye2Xy9r1hPo
	 FaIuAIBhRYWQwEiVNlr9zIGPpxalEE1GmVt5BRUYqaZNmBuf7JHAFI8fKRJ71njQKe
	 n8KGiU70nbiIb9sehsbAcZs1eqHXwMGCQGMGzlrd1oGJXBM991Z9KjFoL6XAtL64BT
	 xqlbgdQd5ru+DQbSX77DleblGbjhM7ytaqdmh9UUanlZ7WX7My9enb3InuMTeIBjzV
	 oAruI7HwvHOHA==
Date: Fri, 1 Nov 2024 14:47:38 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 15/20] posix-timers: Handle ignored list on delete and
 exit
Message-ID: <ZyTb-oMrREz006d5@localhost.localdomain>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.498474639@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031154425.498474639@linutronix.de>

Le Thu, Oct 31, 2024 at 04:46:41PM +0100, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To handle posix timer signals on sigaction(SIG_IGN) properly, the timers
> will be queued on a separate ignored list.
> 
> Add the necessary cleanup code for timer_delete() and exit_itimers().
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> V6: Warn when the ignored list is not empty after deleting all timers in
>     exit_itimers()
> ---
>  include/linux/posix-timers.h |    4 +++-
>  kernel/time/posix-timers.c   |   26 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> ---
> 
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -152,7 +152,8 @@ static inline void posix_cputimers_init_
>  
>  /**
>   * struct k_itimer - POSIX.1b interval timer structure.
> - * @list:		List head for binding the timer to signals->posix_timers
> + * @list:		List node for binding the timer to tsk::signal::posix_timers
> + * @ignored_list:	List node for tracking ignored timers in tsk::signal::ignored_posix_timers
>   * @t_hash:		Entry in the posix timer hash table
>   * @it_lock:		Lock protecting the timer
>   * @kclock:		Pointer to the k_clock struct handling this timer
> @@ -176,6 +177,7 @@ static inline void posix_cputimers_init_
>   */
>  struct k_itimer {
>  	struct hlist_node	list;
> +	struct hlist_node	ignored_list;
>  	struct hlist_node	t_hash;
>  	spinlock_t		it_lock;
>  	const struct k_clock	*kclock;
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -1027,6 +1027,18 @@ int common_timer_del(struct k_itimer *ti
>  	return 0;
>  }
>  
> +/*
> + * If the deleted timer is on the ignored list, remove it and
> + * drop the associated reference.
> + */
> +static inline void posix_timer_cleanup_ignored(struct k_itimer *tmr)
> +{
> +	if (!hlist_unhashed(&tmr->ignored_list)) {
> +		hlist_del_init(&tmr->ignored_list);
> +		posixtimer_putref(tmr);
> +	}
> +}
> +
>  static inline int timer_delete_hook(struct k_itimer *timer)
>  {
>  	const struct k_clock *kc = timer->kclock;
> @@ -1059,6 +1071,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
>  
>  	spin_lock(&current->sighand->siglock);
>  	hlist_del(&timer->list);
> +	posix_timer_cleanup_ignored(timer);
>  	spin_unlock(&current->sighand->siglock);
>  	/*
>  	 * A concurrent lookup could check timer::it_signal lockless. It
> @@ -1110,6 +1123,8 @@ static void itimer_delete(struct k_itime
>  	}
>  	hlist_del(&timer->list);
>  
> +	posix_timer_cleanup_ignored(timer);
> +
>  	/*
>  	 * Setting timer::it_signal to NULL is technically not required
>  	 * here as nothing can access the timer anymore legitimately via
> @@ -1142,6 +1157,17 @@ void exit_itimers(struct task_struct *ts
>  	/* The timers are not longer accessible via tsk::signal */
>  	while (!hlist_empty(&timers))
>  		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
> +
> +	/*
> +	 * There should be no timers on the ignored list. itimer_delete() has
> +	 * mopped them up.
> +	 */
> +	if (!WARN_ON_ONCE(!hlist_empty(&tsk->signal->ignored_posix_timers)))
> +		return;
> +
> +	hlist_move_list(&tsk->signal->ignored_posix_timers, &timers);
> +	while (!hlist_empty(&timers))
> +		posix_timer_cleanup_ignored(hlist_entry(timers.first, struct k_itimer, list));

s/list/ignored_list ?

Other than that:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


>  }
>  
>  SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
> 
> 

