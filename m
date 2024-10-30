Return-Path: <linux-kernel+bounces-389255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB58F9B6AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E96A1F21A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273872178F2;
	Wed, 30 Oct 2024 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5bDGg72"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C68E21503C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307975; cv=none; b=AR7pen8wBf4hnood+4CNIc4BOwujQhc8a0pOZR1++qPYFmrPv8hYc0+n2bgYFmgIC98ge7CeAQA+MKKKajZsV1m/DjjGVOciHrznHCVk7v68tejYxPnC+ydbBZl50FTgpEnQvx2A54FCfB1dlGrxRuWbrOOvNcdrMmQ2uVcCTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307975; c=relaxed/simple;
	bh=fi1CN2Em012OBWMWm3Pp+0sSMC4kSe/r/f7lFOlLS3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOfCwGEEHck9uOu3vKdgVIJ0AloZYrGmx7mnFHRbcFz7leFJ7BanoGZLh0nr8ofeSVO/FQbh2VVIP1tYSdsljakCj5d6rewPOcVCrmzgsMjnAZWhfgd7766eo4FYivHVPnIkTL4zTzotuaJ+LIXIy5x1O9X0+29XZ8gSPxw/FAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5bDGg72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD2DC4CECE;
	Wed, 30 Oct 2024 17:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730307975;
	bh=fi1CN2Em012OBWMWm3Pp+0sSMC4kSe/r/f7lFOlLS3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5bDGg72faajp85+E9hG6UH6DiqINP4EtMCcX+eLWuDEJsTDLAKuef27kjg9UbOba
	 ZQv1R7qx5Kwm3VeDJQxTy3PYmUeTgCZWGRe7SIyGcArS/i1sQAkqvJyR7fGzC/JzPF
	 NZoZmBeekIcpjwK36nfbPElNYwseT3Uo4YvXn11qGDow5ahd+sc2jHEUzCkgTr7I3c
	 cmWr2oykkTVfSm++Ig9WpKKSxArafQT4vlMY0kyLRnb1LxBHEZQdFrRIJjhfdcg3Fx
	 zA9J9FaTY7V8LtfHvSy0sg8mwNTlHT7JBRrJ3NIEROAP8hHQ32k+Yz6A8B+BEAFP1T
	 nrFEqAIDbNsxQ==
Date: Wed, 30 Oct 2024 18:06:11 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 21/26] posix-timers: Handle ignored list on delete and
 exit
Message-ID: <ZyJng49tJutCM62d@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.514196709@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083836.514196709@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:29AM +0200, Thomas Gleixner a écrit :
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
>  include/linux/posix-timers.h |    4 +++-
>  kernel/time/posix-timers.c   |   20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> ---
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
> @@ -1031,6 +1031,18 @@ int common_timer_del(struct k_itimer *ti
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
> @@ -1063,6 +1075,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
>  
>  	spin_lock(&current->sighand->siglock);
>  	hlist_del(&timer->list);
> +	posix_timer_cleanup_ignored(timer);
>  	spin_unlock(&current->sighand->siglock);
>  	/*
>  	 * A concurrent lookup could check timer::it_signal lockless. It
> @@ -1114,6 +1127,8 @@ static void itimer_delete(struct k_itime
>  	}
>  	hlist_del(&timer->list);
>  
> +	posix_timer_cleanup_ignored(timer);
> +
>  	/*
>  	 * Setting timer::it_signal to NULL is technically not required
>  	 * here as nothing can access the timer anymore legitimately via
> @@ -1146,6 +1161,11 @@ void exit_itimers(struct task_struct *ts
>  	/* The timers are not longer accessible via tsk::signal */
>  	while (!hlist_empty(&timers))
>  		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
> +
> +	/* Mop up timers which are on the ignored list */
> +	hlist_move_list(&tsk->signal->ignored_posix_timers, &timers);
> +	while (!hlist_empty(&timers))
> +		posix_timer_cleanup_ignored(hlist_entry(timers.first, struct k_itimer, list));

The ignored timers should have all been removed on timer_delete() and
itimer_delete(), right?

So should it be instead:

   WARN_ON_ONCE(!hlist_empty(&tsk->signal->ignored_posix_timers))

?

Thanks.

>  }
>  
>  SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
> 

