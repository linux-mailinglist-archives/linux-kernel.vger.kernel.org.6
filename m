Return-Path: <linux-kernel+bounces-387270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3DA9B4ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775A91F234CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7971119750B;
	Tue, 29 Oct 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWROtlgS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA46195F22
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217859; cv=none; b=tdJcSf0YdMj28s2zvhupS3R7Xk1qn30ll+fEfuyDLunQE+kFiZ1eLy4+UIFXDU1MoHG9mdq9fnUMR4mSslTwkGmOl00TxZNw668aP4KhvYtYF2oeU6BVgiJniyWr0NbypTjZYY13hg1cImnmR5NqkUjTyvH2FBfRS+CxCnOs5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217859; c=relaxed/simple;
	bh=HaOqdxmFHRB1ChNzWAyWgqKeRXG/71jxbCuqPSrWAZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3MHSMuI2Md2Zv6Qy6pp0ctO/KHo9kxxNOe1FuSDMNmRasGTTLjGQs9WBWZklbWJoojkSEBJ4h+W8M4I1qypMFo9dpGAqmApJZgqvfcKCfdepgRw/Lkv+BqaaUvOnPsdi3OOZK+GSEkHo0tbJBdY/dtQFRxH2BBj39k/CGkfk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWROtlgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0537BC4CECD;
	Tue, 29 Oct 2024 16:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730217859;
	bh=HaOqdxmFHRB1ChNzWAyWgqKeRXG/71jxbCuqPSrWAZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWROtlgSBRQXkmL20vNOiZTfPXa6DyLhySqk46Z+GnfDIgK21SjLg1MhDMOhYf6gi
	 FZbflcqQk0fH5F3PeFC0vdeOJ4SAwtKOLNFsJZsoa3rGwszVvpe7S1cZtRrj8Pf63U
	 EKYVG3k2G8oshinr4REK7HyKimZ6FD0bfg2FJAzCg8UD20HsWQLRlbOagun59hyPIG
	 UJSZZgTgDmzueBuPp/U5w6/QKarDLH8AU36xruCpJ2Juu8wN68bXyigqbTbnf0HOtO
	 Ou3LIbGYgHMYPbLa/hDzfHHkwQS3q+zh0X8VKvpntynQ4ZLkB4OVK4uHZjI85gE8SK
	 GQtCZvAWm2cKw==
Date: Tue, 29 Oct 2024 17:04:17 +0100
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
Message-ID: <ZyEHgU73mo4ekJ9R@localhost.localdomain>
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
> @@ -604,19 +604,19 @@ static int __dequeue_signal(struct sigpe
>   */
>  int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
>  {
> +	struct sigqueue *timer_sigq = NULL;
>  	struct task_struct *tsk = current;
> -	bool resched_timer = false;
>  	int signr;
>  
>  	lockdep_assert_held(&tsk->sighand->siglock);
>  
>  again:
>  	*type = PIDTYPE_PID;
> -	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
> +	signr = __dequeue_signal(&tsk->pending, mask, info, &timer_sigq);
>  	if (!signr) {
>  		*type = PIDTYPE_TGID;
>  		signr = __dequeue_signal(&tsk->signal->shared_pending,
> -					 mask, info, &resched_timer);
> +					 mask, info, &timer_sigq);
>  
>  		if (unlikely(signr == SIGALRM))
>  			posixtimer_rearm_itimer(tsk);
> @@ -642,8 +642,8 @@ int dequeue_signal(sigset_t *mask, kerne
>  		current->jobctl |= JOBCTL_STOP_DEQUEUED;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_POSIX_TIMERS) && unlikely(resched_timer)) {
> -		if (!posixtimer_deliver_signal(info))
> +	if (IS_ENABLED(CONFIG_POSIX_TIMERS) && unlikely(timer_sigq)) {
> +		if (!posixtimer_deliver_signal(info, timer_sigq))
>  			goto again;

If the signal has been refused, it goes goto again without clearing timer_sigq.
With the upcoming patch it becomes bad because if there is another signal
dequeued on the next iteration, posixtimer_deliver_signal() is called again with
two side effects:

_ The reference is put twice
_ The other dequeued signal is now ignored.

Thanks.

