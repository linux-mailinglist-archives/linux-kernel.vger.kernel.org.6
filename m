Return-Path: <linux-kernel+bounces-374581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA359A6C65
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC122827C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC71F9AB2;
	Mon, 21 Oct 2024 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO3yHrE6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855561EABA9
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521657; cv=none; b=gi0FkaZc3SFqHRL+PZ5m6PQZ2bAaWSENlxosb7h88nNtbWTmzlG1TMcenCeS6msHzx+GZfyOOUW/6pAi94f8752gOg2RFkvNBL73IHppe1QQGUg12is6IhLDoLjzMVBsRVkaHBmwASw4zPF8UXhEXON+BvPsAhkVJA7CDnzWTaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521657; c=relaxed/simple;
	bh=SY0QU0S/YEb+CgOL7A43I19aUv+YqaDgGKxwtTIbOKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJviQXWq4EpVoacysYCsX8O5Ik9XxgGV3w1iCKlZF4aomsn9TvT3etYjhH6WPqAJEl0KBWAd8mc9fRHFkB6hu2LY6DriCHD3osv1Kk7sk3tH3VKMs7EpnQ9o3oLYtCsXKYMfD6Mlc0oI7ZjG8YVFzWChBg52XSw6syW8jse3j1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO3yHrE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6833C4CEC3;
	Mon, 21 Oct 2024 14:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729521657;
	bh=SY0QU0S/YEb+CgOL7A43I19aUv+YqaDgGKxwtTIbOKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gO3yHrE62NA/dqvUlrYxk2/3iyNecJfwhQ0kDYggARDYiF8Y25d2Fg/wf8gSs2/aG
	 UbhBf/Np2b98/JZIZbGsAeDUHEEvhQ2MhXszB2Wm0p10bmCadIqh0Qkbupj8mR+yeO
	 ggPB+2rw+Cvp6hSZHmb4ddoDvn/Wfvy0I/fyPFKq0f0GAWDH+ON4gp9fwWmslsJ11z
	 Ohiv2i6Kvjget3/bLpcJDl3p943NTXeAl8HXjtvyC6XfowoLIcr+0gNHWyC4s1OlAH
	 ZSn5XMsZKu+dEnSWGGV4u5m4JcBjkLNSWElziYSNFY23X9b7VYakLlBUxUpvtFBEEn
	 J4duoU61KcNgA==
Date: Mon, 21 Oct 2024 16:40:54 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 08/26] posix-timers: Make signal delivery consistent
Message-ID: <ZxZn9gwnk4Vr5L6k@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.730528613@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083835.730528613@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:10AM +0200, Thomas Gleixner a écrit :
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -269,7 +269,10 @@ bool posixtimer_deliver_signal(struct ke
>  	if (!timr)
>  		goto out;
>  
> -	if (timr->it_interval && timr->it_signal_seq == info->si_sys_private) {
> +	if (timr->it_signal_seq != info->si_sys_private)
> +		goto out_unlock;
> +
> +	if (timr->it_interval && timr->it_status == POSIX_TIMER_REQUEUE_PENDING) {

Can it be something else than POSIX_TIMER_REQUEUE_PENDING actually?
And if not, should it be a WARN_ON() ?

>  		timr->kclock->timer_rearm(timr);
>  
>  		timr->it_status = POSIX_TIMER_ARMED;
> @@ -281,6 +284,7 @@ bool posixtimer_deliver_signal(struct ke
>  	}
>  	ret = true;
>  
> +out_unlock:
>  	unlock_timer(timr, flags);
>  out:
>  	spin_lock(&current->sighand->siglock);
> @@ -293,19 +297,19 @@ bool posixtimer_deliver_signal(struct ke
>  int posix_timer_queue_signal(struct k_itimer *timr)
>  {
>  	enum posix_timer_state state = POSIX_TIMER_DISARMED;
> -	int ret, si_private = 0;
>  	enum pid_type type;
> +	int ret;
>  
>  	lockdep_assert_held(&timr->it_lock);
>  
>  	if (timr->it_interval) {
> +		timr->it_signal_seq++;

Is the increment here is still needed then, since it's done
from del and set?

Thanks.

>  		state = POSIX_TIMER_REQUEUE_PENDING;
> -		si_private = ++timr->it_signal_seq;
>  	}
>  	timr->it_status = state;
>  
>  	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
> -	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
> +	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
>  	/* If we failed to send the signal the timer stops. */
>  	return ret > 0;
>  }

