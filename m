Return-Path: <linux-kernel+bounces-284482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D695017B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B0C1F23363
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02668170A23;
	Tue, 13 Aug 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A5O06AQq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DE/mDdRD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55261AACC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542323; cv=none; b=TYBPyg5v67HJBW43KxBoiMW2RPsbThLOCuDGiN2DBkL0ScdVO81WCI3q5cGYSKYvMlzxcJRLXEuP8hNK2fHiEvYfo9Ocfh1uS/ujjqkUQiFr2K9kILOdxBl4hyEc/6uyT+3c1+D9LwKT2i2vKwb4fzoVctaihGKszjqezLTGujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542323; c=relaxed/simple;
	bh=JVyPSheHUAEcpgaxF05paJ+TS0rMFm6vhatbCjsQLSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iw9exwiekH+R7MBOWFQ6xG9E4W/0xtv+1oga5lQ3qEq96unFdNTl7cttE4wS+ETb5OuTsADJ6kj9Ru58UVFNdAfGWGmXxisCudHdkWIn71ZiSgxR0fR3Jp0CwX1fSbwlTzoSdF/nBHFCWuOz2tCExTMZL9LU7LBWxKfJxnEEAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A5O06AQq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DE/mDdRD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723542320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eitc1yGvAu2XVOt8W1EaGMOFNjza3NrKpTTe5GpqR34=;
	b=A5O06AQqtI38iW1KAwdW3S7yoU2TQ7Vs3YnbnWHyK43JT3cG8rS5qmzYrr0DWzYyTfvfZD
	dMykCOWo27DJGw1YdzijugiVpJomNtR7FRi0xYcWzErIzptOQZ14WUN/mcopdXwiG3us6J
	0WFcNXEI3yMfLXZy/930c73YK5zb3W3CA7CePlBqe2Aic3paiIOUIIim/F/u08/RqblWzq
	Dq7GA6kctk6TMVW74YWuu1/hymN8v8MTt1IffVsS6mT5c6kV/jZ+4+D/bNGG3QeXhh2vmD
	PE62NmqVyX9fKq7awP9Apwh02TImmxkC6vTLWkgDiId2tBdJgcgTl88wZBg4zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723542320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eitc1yGvAu2XVOt8W1EaGMOFNjza3NrKpTTe5GpqR34=;
	b=DE/mDdRDOJ//XxFXeAOloMjx7x2hZc0YYa0ydURMDmkK3HT/x5eAiPUm19375VX10jAKmk
	Byr84+M5ArR4fYDQ==
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, jan.kiszka@siemens.com, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, qyousef@layalina.io, Felix Moessbauer
 <felix.moessbauer@siemens.com>
Subject: Re: [PATCH v3 1/1] hrtimer: use and report correct timerslack
 values for realtime tasks
In-Reply-To: <20240813072953.209119-2-felix.moessbauer@siemens.com>
References: <20240813072953.209119-1-felix.moessbauer@siemens.com>
 <20240813072953.209119-2-felix.moessbauer@siemens.com>
Date: Tue, 13 Aug 2024 11:45:19 +0200
Message-ID: <87ed6src28.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 13 2024 at 09:29, Felix Moessbauer wrote:
> @@ -2569,10 +2569,11 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
>  	}
>  
>  	task_lock(p);
> -	if (slack_ns == 0)
> -		p->timer_slack_ns = p->default_timer_slack_ns;
> -	else
> -		p->timer_slack_ns = slack_ns;
> +	if (task_is_realtime(p))
> +		slack_ns = 0;

This should respect the user supplied value, i.e.

    if (!task_is_realtime(p) && !slack_ns)
	    slack_ns = p->default_timer_slack_ns;

> +	else if (slack_ns == 0)
> +		slack_ns = p->default_timer_slack_ns;
> +	p->timer_slack_ns = slack_ns;
>  	task_unlock(p);
>  
>  out:
> diff --git a/fs/select.c b/fs/select.c
> index 9515c3fa1a03..153124ed50fd 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -77,19 +77,13 @@ u64 select_estimate_accuracy(struct timespec64 *tv)
>  {
>  	u64 ret;
>  	struct timespec64 now;
> -
> -	/*
> -	 * Realtime tasks get a slack of 0 for obvious reasons.
> -	 */
> -
> -	if (rt_task(current))
> -		return 0;
> +	u64 slack = current->timer_slack_ns;
>  
>  	ktime_get_ts64(&now);
>  	now = timespec64_sub(*tv, now);
>  	ret = __estimate_accuracy(&now);
> -	if (ret < current->timer_slack_ns)
> -		return current->timer_slack_ns;
> +	if (ret < slack || slack == 0)
> +		return slack;

Seriously? Do all the calculations first and then discard them when
slack is 0?

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index ae1b42775ef9..195d2f2834a9 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -406,6 +406,14 @@ static void __setscheduler_params(struct task_struct *p,
>  	else if (fair_policy(policy))
>  		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
>  
> +	/* rt-policy tasks do not have a timerslack */
> +	if (task_is_realtime(p)) {
> +		p->timer_slack_ns = 0;
> +	} else if (p->timer_slack_ns == 0) {
> +		/* when switching back to non-rt policy, restore timerslack */
> +		p->timer_slack_ns = p->default_timer_slack_ns;
> +	}
> +
>  	/*
>  	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
>  	 * !rt_policy. Always setting this ensures that things like
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 3a2df1bd9f64..e3c4cffb520c 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2557,6 +2557,8 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			error = current->timer_slack_ns;
>  		break;
>  	case PR_SET_TIMERSLACK:
> +		if (task_is_realtime(current))
> +			break;

Why are you declaring that a RT task has to have 0 slack if we are
lifting the hard coded slack zeroing in the hrtimer functions?

Thanks,

        tglx

