Return-Path: <linux-kernel+bounces-387256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253109B4EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B539DB2367B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD56E195FEF;
	Tue, 29 Oct 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDWASUFG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F90802
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217420; cv=none; b=GcMzUhbZV9zwaZh9y+2aQul3XtUqvICQj+gISNNHGnMLAfxmmF/YGsKaRurA9Gr1Lt7iApp3nHv2oTGj1IioT4t8eTFKA9C5MLhSFOV9dtkRGW/INIfufMcURVFLXqFQCYvQBcYtAsqFDWHYreo5y9T8EhcEGIS9X2U7cir8U1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217420; c=relaxed/simple;
	bh=vhgaz2PAVUi0alzDjQhgGOXKUiIvQYk78MYDRCr0Xqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1I3gfl9ks//+JlmyoKJX1F5aQ9vyMNmKRQx51mYvI8SWeDIyUVq0kXyjZ7wKBIhjyhxqgzEmfO4fOJ5VqoLwii8B6hf9vOEbCX3xH5ewQzP+sZ2+tLpgm4oJGfsZQbS0LGDKOXHwZ4XhRyS90nsImJcen36kPeRcz4VnewDKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDWASUFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992E6C4CECD;
	Tue, 29 Oct 2024 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730217419;
	bh=vhgaz2PAVUi0alzDjQhgGOXKUiIvQYk78MYDRCr0Xqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDWASUFG+W9sqL+0NW77EGHgdpm7xq+XoLHr1aPGqoBc+LEL3tTZn85JSBkQuNHeK
	 D4eKKiOhPEGvQ42fJvSsjzHSvQnG6iHVerCthP4txjgEtc8KWzydOA3z9oZDuavdg2
	 zwSM0lZFmquA1dX7i3vxqQM1D58gGzYRxqZumeHo6RSrHYRQwCKanpvONCWhFN4CHt
	 d8ZssLCJ/2YudeMCxOcpdw/i0tBDyLPBDbY5EgSShSNLqzHnFrvsnqTeV8s04w7MQE
	 pGv0M9IvxZvmWQ4Hj9zVbkhjEO63bsqnru36EyRHMjf9RCeKFySGYm39W9FDIAny6U
	 k3MZ5xJVcDH6A==
Date: Tue, 29 Oct 2024 16:56:57 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 16/26] signal: Replace resched_timer logic
Message-ID: <ZyEFyV28jcz85V1q@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.220867629@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083836.220867629@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:21AM +0200, Thomas Gleixner a écrit :
> In preparation for handling ignored posix timer signals correctly and
> embedding the sigqueue struct into struct k_itimer, hand down a pointer to
> the sigqueue struct into posix_timer_deliver_signal() instead of just
> having a boolean flag.
> 
> No functional change.
> 
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

On second thoughts, a little concern:

> ---
> V5: New patch
> ---
>  include/linux/posix-timers.h |    5 +++--
>  kernel/signal.c              |   24 ++++++++++++------------
>  kernel/time/posix-timers.c   |    2 +-
>  3 files changed, 16 insertions(+), 15 deletions(-)
> 
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -110,7 +110,7 @@ static inline void posix_cputimers_rt_wa
>  void posixtimer_rearm_itimer(struct task_struct *p);
>  bool posixtimer_init_sigqueue(struct sigqueue *q);
>  int posixtimer_send_sigqueue(struct k_itimer *tmr);
> -bool posixtimer_deliver_signal(struct kernel_siginfo *info);
> +bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *timer_sigq);
>  void posixtimer_free_timer(struct k_itimer *timer);
>  
>  /* Init task static initializer */
> @@ -135,7 +135,8 @@ static inline void posix_cputimers_init(
>  static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
>  					      u64 cpu_limit) { }
>  static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
> -static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
> +static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info,
> +					     struct sigqueue *timer_sigq) { return false; }
>  static inline void posixtimer_free_timer(struct k_itimer *timer) { }
>  #endif
>  
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -545,7 +545,7 @@ bool unhandled_signal(struct task_struct
>  }
>  
>  static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info,
> -			   bool *resched_timer)
> +			   struct sigqueue **timer_sigq)
>  {
>  	struct sigqueue *q, *first = NULL;
>  
> @@ -568,10 +568,10 @@ static void collect_signal(int sig, stru
>  		list_del_init(&first->list);
>  		copy_siginfo(info, &first->info);
>  
> -		*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
> -				 (info->si_code == SI_TIMER);
> -
> -		__sigqueue_free(first);
> +		if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code == SI_TIMER)))
> +			*timer_sigq = first;
> +		else
> +			__sigqueue_free(first);

So this isn't calling __sigqueue_free() unconditionally anymore. What if
the timer has been freed already, what is going to free the sigqueue?

Thanks.

