Return-Path: <linux-kernel+bounces-195595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B08D4F02
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E105F1F265DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D5855886;
	Thu, 30 May 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkhlH+4o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF9187550
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082704; cv=none; b=NxMi/j2Pp6irnJPkELKHpJlbJeY8mixOBtjPSqa3mmfyVqhmOZtLWRHPSlGXh33m0U5xewRlVBe0yzw3h8f7OYI6W6buXUjbNjGgo5rQk6oR2qUNeKWxH4TzpPtTgoeXQQ8D28URd5OSNa39zE3Sg6YF5zXEdhDkJ4/4Fg7jk6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082704; c=relaxed/simple;
	bh=GfjY+j+xwwUjxuSqsFHiXU1Hy4+hxY4NC7lKe/9UVg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln51xScUAYJCAUmPmLQepYKFHfiyAJT5BJHM4N7sX5niIK9qf28VAh7830T0NnbPl7rO5aVV8MFfannSIim71zvIoPiwJMtYLN5mtos+BBHbQGEvy8ezQb9G+87eJ1gIDlPsG1cFrX9FH/npx2kYGRthuoGP7o1Lo9pDpvKL0Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkhlH+4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A53C2BBFC;
	Thu, 30 May 2024 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717082703;
	bh=GfjY+j+xwwUjxuSqsFHiXU1Hy4+hxY4NC7lKe/9UVg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkhlH+4oWRRSgxkYUkOtqu00sxROceAluQLiG9OVKraqgtx/lKHnglgM7b3rTbCJf
	 g5xwTegI30+cfIdlWMtgxsnjTozmH3LysnKhtuOQgoURl5Z1nrgscqfW8dql/ATIyJ
	 4OnN7nKTA8jSqlnP2agbgT+Sb1+u7kGZOCxG9FTAmAe8S/GZyEbK9VMHh/98stFjfI
	 yT/LxCE9NFMd9M3hDfyjglYoDdW9+1kIe8w+iicrM0TfVuodVVSvoDDKwyF1LQ/k08
	 0c6XQBRg0mKK2jvFdOXcjHVYQW1cgSgJ543mXhci/24F42YD2hoOwxyoMGduUngy4U
	 MJKIb/fOZEL9g==
Date: Thu, 30 May 2024 17:24:56 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick: shift tick_nohz_switch_to_nohz() from
 tick_check_oneshot_change() to hrtimer_run_queues()
Message-ID: <ZliaSISeFxx_FQ6O@localhost.localdomain>
References: <20240530124203.GA26990@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240530124203.GA26990@redhat.com>

Le Thu, May 30, 2024 at 02:42:03PM +0200, Oleg Nesterov a écrit :
> hrtimer_run_queues() calls tick_check_oneshot_change() to check if we
> can switch to highres or nohz mode, but the current code looks very
> confusing to me. In the highres=n or CONFIG_HIGH_RES_TIMERS=n cases
> tick_check_oneshot_change() itself calls tick_nohz_switch_to_nohz()
> and returns zero; that is why it needs the "allow_nohz" argument,
> which imo also adds confusion.
> 
> This patch turns tick_check_oneshot_change() into a "pure" function
> without arguments. hrtimer_run_queues() calls hrtimer_switch_to_hres()
> or tick_nohz_switch_to_nohz() depending on hrtimer_is_hres_enabled().
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/time/hrtimer.c       |  7 +++++--
>  kernel/time/tick-internal.h |  6 ++++--
>  kernel/time/tick-sched.c    | 15 ++++-----------
>  3 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 492c14aac642..806f352b095d 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1891,8 +1891,11 @@ void hrtimer_run_queues(void)
>  	 * there only sets the check bit in the tick_oneshot code,
>  	 * otherwise we might deadlock vs. xtime_lock.
>  	 */
> -	if (tick_check_oneshot_change(!hrtimer_is_hres_enabled())) {
> -		hrtimer_switch_to_hres();
> +	if (tick_check_oneshot_change()) {
> +		if (hrtimer_is_hres_enabled())
> +			hrtimer_switch_to_hres();
> +		else
> +			tick_nohz_switch_to_nohz();

Thanks a lot for clarifying this! I've always found that confusing
(and note how I never did anything about it!)

Just a detail below:

>  		return;
>  	}
>  
> diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
> index 5f2105e637bd..6764fbd18afd 100644
> --- a/kernel/time/tick-internal.h
> +++ b/kernel/time/tick-internal.h
> @@ -111,7 +111,8 @@ extern void tick_resume_oneshot(void);
>  static inline bool tick_oneshot_possible(void) { return true; }
>  extern int tick_oneshot_mode_active(void);
>  extern void tick_clock_notify(void);
> -extern int tick_check_oneshot_change(int allow_nohz);
> +extern int tick_check_oneshot_change(void);
> +extern void tick_nohz_switch_to_nohz(void);

tick_nohz_switch_to_nohz() is only built with CONFIG_NO_HZ_COMMON

You will have a build issue with CONFIG_HIGH_RES_TIMER && !CONFIG_NO_HZ_COMMON

>  extern int tick_init_highres(void);
>  #else /* !CONFIG_TICK_ONESHOT: */
>  static inline
> @@ -124,7 +125,8 @@ static inline void tick_oneshot_notify(void) { }
>  static inline bool tick_oneshot_possible(void) { return false; }
>  static inline int tick_oneshot_mode_active(void) { return 0; }
>  static inline void tick_clock_notify(void) { }
> -static inline int tick_check_oneshot_change(int allow_nohz) { return 0; }
> +static inline int tick_check_oneshot_change(void) { return 0; }
> +static inline void tick_nohz_switch_to_nohz(void) { }
>  #endif /* !CONFIG_TICK_ONESHOT */

