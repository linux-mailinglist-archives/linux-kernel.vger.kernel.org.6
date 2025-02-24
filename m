Return-Path: <linux-kernel+bounces-529854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA61A42BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8552317ABB7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCD42661BE;
	Mon, 24 Feb 2025 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NjTbjPFD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XuQMzgLX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25EB11185
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422610; cv=none; b=XjzCnzUexhpYpg3a/B/yh9LRrCsLD22boJ5sJGYDbulW24bHC8YQY5k9VAJWfA0rbuc24jCs+pfE1Xi5UUZsfCjsxfgA9QTbvRoIpMC7dSBwDEBgMbMpkCc9Im0IMcsPZM4U7roE1OceKQbQ60V/cSwvzbHqO3BEgxwXBeYiIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422610; c=relaxed/simple;
	bh=hWWRkKrW0NjOq5okGUAg0QJwfP81JEeOp/KOElZboho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I8G91fbSZcWj4+0vXJcLqsJlE4RjBDU9e67+i71sJGVffkan/zCjQ1BQVuDSlw/WauWQ7mqpyRRoodhQyiWTHPmC71YOBoD8LH6C+V3e1WcnIi7J51jIyS/pMBUf9MLNft0JUlLNus5TrHnCEm8pL82p4DEk9ee+tdBbd+/iwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NjTbjPFD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XuQMzgLX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740422607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4zRxXei+NhZ3ug/zntxrTaw539SASSuoyiD1iAV0r/Y=;
	b=NjTbjPFDWu4r5/rS7jMESQ1f1tQdTv1OtFyK47aT+jTBlOSosc52NmDMnHxK97qKGofUff
	/TGSW/v1iD48M3oA37gQFhOhjozHREdQyiC0Q6lH0h8rHrwT0RVrNnafw/o45j3bWBvUHg
	amb1DOcG0WcoB1rlMYugOMiTFYAKO/5RAbefDDXWXD2qAywIm4yaJVVsFWdyUnr2xGixxS
	66K7rnZPjfqPdlG1zug8I4eLMaB2Cjxn3tFE49Tmnrh6k3sy6oZNG5BskWIB41Y7yO9H3i
	AVV5dqiuwm9VPai4HPwb0p+3ji3W1UqQVZ6jvejhhcZe3LjbQoWFR3/EtTmHKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740422607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4zRxXei+NhZ3ug/zntxrTaw539SASSuoyiD1iAV0r/Y=;
	b=XuQMzgLXfkldZI5gxy15DMws/W35w2wtM7P3m6fiTJd827+52MDWDh6Qmdd1zauNn8AGgE
	vRIdH1HycLpoeHDA==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>
Subject: Re: [patch 04/11] posix-timers: Remove pointless unlock_timer()
 wrapper
In-Reply-To: <20250224162103.GD11590@noisy.programming.kicks-ass.net>
References: <20250224095736.145530367@linutronix.de>
 <20250224101343.211872476@linutronix.de>
 <20250224162103.GD11590@noisy.programming.kicks-ass.net>
Date: Mon, 24 Feb 2025 19:43:26 +0100
Message-ID: <87seo3fak1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 24 2025 at 17:21, Peter Zijlstra wrote:
> On Mon, Feb 24, 2025 at 11:15:28AM +0100, Thomas Gleixner wrote:
>> It's just a wrapper around spin_unlock_irqrestore() with zero value.
>
> Well, I disagree... the value is that is matches lock_timer(). Both in
> naming and in argument types.

Sure, but it's not used consistently as we have places where
lock_timer() is not involved.

> @@ -327,14 +350,13 @@ bool posixtimer_deliver_signal(struct ke
>  	 * Release siglock to ensure proper locking order versus
>  	 * timr::it_lock. Keep interrupts disabled.
>  	 */
> -	spin_unlock(&current->sighand->siglock);
> +	guard(spinlock)(&current->sighand->siglock);

How is that equivalent?

This is a unlock/lock pair because __posix_timer_deliver_signal() takes
timr->it_lock and now you introduced the ABBA which the sighand::siglock
unlock carefully avoids :)

>  
>  	ret = __posixtimer_deliver_signal(info, timr);
> 
>  	/* Drop the reference which was acquired when the signal was queued */
>  	posixtimer_putref(timr);
>  
> -	spin_lock(&current->sighand->siglock);
>  	return ret;
>  }
>  
> @@ -717,24 +739,20 @@ void common_timer_get(struct k_itimer *t
>  
>  static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
>  {
> -	const struct k_clock *kc;
> -	struct k_itimer *timr;
> -	unsigned long flags;
> -	int ret = 0;
> -
> -	timr = lock_timer(timer_id, &flags);
> -	if (!timr)
> -		return -EINVAL;
> +	scoped_guard (lock_timer, timer_id) {
> +		struct k_itimer *timr = __guard_ptr(lock_timer)(&scope);
> +		const struct k_clock *kc;
> +
> +		memset(setting, 0, sizeof(*setting));
> +		kc = timr->kclock;
> +		if (WARN_ON_ONCE(!kc || !kc->timer_get))
> +			return -EINVAL;
>  
> -	memset(setting, 0, sizeof(*setting));
> -	kc = timr->kclock;
> -	if (WARN_ON_ONCE(!kc || !kc->timer_get))
> -		ret = -EINVAL;
> -	else
>  		kc->timer_get(timr, setting);
> +		return 0;
> +	}
>  
> -	spin_unlock_irqrestore(&timr->it_lock, flags);
> -	return ret;
> +	return -EINVAL;

So the resulting code is:

	scoped_guard (lock_timer, timer_id) {
		struct k_itimer *timr = __guard_ptr(lock_timer)(&scope);
		const struct k_clock *kc;

		memset(setting, 0, sizeof(*setting));
		kc = timr->kclock;
		if (WARN_ON_ONCE(!kc || !kc->timer_get))
			return -EINVAL;
 
		return 0;
	}
	return -EINVAL;

I had to go and stare at the guard/class muck 10 times to convince
myself, that this actually works. This really wants to be express the
condition of the scoped_guard() somehow, e.g. scoped_cond_guard() or
such.

>  /* Delete a POSIX.1b interval timer. */
>  SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
>  {
> -	return posix_timer_delete(NULL, timer_id);
> +	scoped_guard (lock_timer, timer_id) {
> +		posix_timer_invalidate(scope.lock, scope.flags);
> +		scoped_guard_end(lock_timer);
> +		posix_timer_unhash_and_free(scope.lock);

Not sure whether it's a good idea to free the scope.lock and not
scope.timer :)

Thanks,

        tglx

