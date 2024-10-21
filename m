Return-Path: <linux-kernel+bounces-374318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E539E9A6870
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62F31B2883A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E651E7677;
	Mon, 21 Oct 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfUGaWke"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963551D0E15
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513793; cv=none; b=G+VAXHkVYc6n4IPO9q8n9L2YZBaJIzmWIdNKR3csT+G2C8Y3vhUtfcVjhlsg9gm/bTm2Mga1atuSG6gBYEH6qtbRl1cYp0bDR+bwIRpui+vegc1Tnue44gB5R2t2HRvxbL6qbkvBhG/SH7zKQiLqrG8cdFRSkU+IN6YsEy4zsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513793; c=relaxed/simple;
	bh=qLs7Zdovwqzbv9Zrx61mwO6exLzd6+3hYLx3/QgvDGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siyutLSGf7+S6B8Y6ieeh779StO5xwZNcYPq9u8bkIOyOfqazY465jA0vrTw+gyxi9DooYrAyWlX7qFf2IWXP82zmIRCWgWcmJftWR+D+lJjozu/2u91/Q5ijfaKPYukM4IfFWFq8ENWZu1OK7oYf0VL48YQO0AdmbCmdHMYRbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfUGaWke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70AFC4CEC3;
	Mon, 21 Oct 2024 12:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513793;
	bh=qLs7Zdovwqzbv9Zrx61mwO6exLzd6+3hYLx3/QgvDGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfUGaWke77KW8FgrUcwJtmLIF5QhQA9GxT+MNV73EDG5zDjW/i7NYw2tHhX548MY2
	 xSKgmggahvoTQLrzkh29xaS52kJSRQwFuV1gB9nTwL2KBjCAkiE3u3dZevDtuW/+Hu
	 7BDc9RouLa3fAx+6wF/djaMw3tPw8F2yPuJIIj0Y5Z97ct5iZ/H3qfylt6bUhQzpRA
	 1HkdnVcUnB+D9qjJV0PIQvWGkLDguNOooPeg8ZPMum/bSrK/YJHtziRL5FVj70Mm+Y
	 Perd2U1GHn1ovhVyuhLIaTOREhFDIAnnvdjQOQCITlTcnvYHRyJh37/SMsn2T7IPvw
	 TD/mhOEmgfeRQ==
Date: Mon, 21 Oct 2024 14:29:50 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 05/26] posix-timers: Drop signal if timer has been
 deleted or reprogrammed
Message-ID: <ZxZJPnqsQygi6juI@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.553646280@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083835.553646280@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:06AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> No point in delivering a signal from the past. POSIX does not specify the
> behaviour here:
> 
>  - "The effect of disarming or resetting a timer with pending expiration
>     notifications is unspecified."
> 
>  - "The disposition of pending signals for the deleted timer is unspecified."
> 
> In both cases it is reasonable to expect that pending signals are
> discarded. Especially in the reprogramming case it does not make sense to
> account for previous overruns or to deliver a signal for a timer which has
> been disarmed.

The change below indeed checks if the timer has been deleted but not if
it has been reprogrammed/disarmed/reset.

Or am I missing something?

Thanks.

> 
> Drop the signal as that is conistent and understandable behaviour.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/time/posix-timers.c |  9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> ---
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index d7ed7542f803..b5d7e71c10f2 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -250,14 +250,14 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
>  }
>  
>  /*
> - * This function is called from the signal delivery code if
> - * info::si_sys_private is not zero, which indicates that the timer has to
> - * be rearmed. Restart the timer and update info::si_overrun.
> + * This function is called from the signal delivery code. It decides
> + * whether the signal should be dropped and rearms interval timers.
>   */
>  bool posixtimer_deliver_signal(struct kernel_siginfo *info)
>  {
>  	struct k_itimer *timr;
>  	unsigned long flags;
> +	bool ret = false;
>  
>  	/*
>  	 * Release siglock to ensure proper locking order versus
> @@ -279,6 +279,7 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
>  
>  		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
>  	}
> +	ret = true;
>  
>  	unlock_timer(timr, flags);
>  out:
> @@ -286,7 +287,7 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
>  
>  	/* Don't expose the si_sys_private value to userspace */
>  	info->si_sys_private = 0;
> -	return true;
> +	return ret;
>  }
>  
>  int posix_timer_queue_signal(struct k_itimer *timr)
> 

