Return-Path: <linux-kernel+bounces-547852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50D0A50E5F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01837A4182
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DD4266561;
	Wed,  5 Mar 2025 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbpiy0qo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06882661B5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741212682; cv=none; b=HaQEP2pmpl2yIx/w6hS/XbByg0+cUTD26z/VKj1dka/67BfnUfRaSrsfsBG/sNKo+72VEZ9FnWFxC9V+xOaXQRIlcXQHzVmmYbHi5RuP9tAZYWu3wxhCbS/afjVzVo8/o69GHUwQcOeyaCMPc07bN97GU3fZxRXIR1ObIFr6Z14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741212682; c=relaxed/simple;
	bh=HhfwtPSlU9u0PsfrQPWq/R8s3A7TZRH4BqVLFtDE67I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lcli8K3E2oB7T4/Phuyq8M8J6BuqxaXTpH0NeHVYtVZ2of96MoQ4mgWbdfYiAm+vTASxy384XIHjAvP/lM48UkyEItvLHKumtMRyda7Xe0mWE6v60+I7rxe8LkNUJK4C8Ct+pIueWFu/e/zgSJkVH5hPwkDiNAIwdFqikefDI5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbpiy0qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D518C4CED1;
	Wed,  5 Mar 2025 22:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741212681;
	bh=HhfwtPSlU9u0PsfrQPWq/R8s3A7TZRH4BqVLFtDE67I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jbpiy0qoR5jGETWGF4DB0SiGVt1fMneGMKD/GeqBc3/W1bXqG63OMVTYJBsefbhOi
	 GOAz6Abd8VELNDcCa04iVVw3rIyjaHgvaQEeav08K3bECqg7elr07i4Fk791CGfpRk
	 EkqBhwgb+nSlbYX+5AgqcIkMhrCSqEVLR0L75EjYZ970owEynEWfRS7d8icrs+iMNv
	 3yco3nComQy3EliPLUSi5h0oeAIGeQuHVBXoa7O8Xn6dQnyfwpHtLc7nBw7KEMR3pd
	 ywKYGKz1Ba+7OwIoSjB8FI2UtNOatC/ubNBbFRpcu3VfTXUIhkLrHrgZACatvQBCrS
	 XosEswfDjVULw==
Date: Wed, 5 Mar 2025 23:11:18 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 04/17] posix-timers: Remove a few paranoid warnings
Message-ID: <Z8jMBqI0tuQBou4I@pavilion.home>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.167378648@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302193627.167378648@linutronix.de>

Le Sun, Mar 02, 2025 at 08:36:49PM +0100, Thomas Gleixner a écrit :
> Warnings about a non-initialized timer or non-existing callbacks are just
> useful for implementing new posix clocks, but there a NULL pointer
> dereference is expected anyway. :)
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  kernel/time/posix-timers.c |   37 ++++++++-----------------------------
>  1 file changed, 8 insertions(+), 29 deletions(-)
> 
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -675,7 +675,6 @@ void common_timer_get(struct k_itimer *t
>  
>  static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
>  {
> -	const struct k_clock *kc;
>  	struct k_itimer *timr;
>  	unsigned long flags;
>  	int ret = 0;
> @@ -685,11 +684,7 @@ static int do_timer_gettime(timer_t time
>  		return -EINVAL;
>  
>  	memset(setting, 0, sizeof(*setting));
> -	kc = timr->kclock;
> -	if (WARN_ON_ONCE(!kc || !kc->timer_get))
> -		ret = -EINVAL;
> -	else
> -		kc->timer_get(timr, setting);
> +	timr->kclock->timer_get(timr, setting);
>  
>  	unlock_timer(timr, flags);
>  	return ret;
> @@ -817,7 +812,6 @@ static void common_timer_wait_running(st
>  static struct k_itimer *timer_wait_running(struct k_itimer *timer,
>  					   unsigned long *flags)
>  {
> -	const struct k_clock *kc = READ_ONCE(timer->kclock);
>  	timer_t timer_id = READ_ONCE(timer->it_id);
>  
>  	/* Prevent kfree(timer) after dropping the lock */
> @@ -828,8 +822,7 @@ static struct k_itimer *timer_wait_runni
>  	 * kc->timer_wait_running() might drop RCU lock. So @timer
>  	 * cannot be touched anymore after the function returns!
>  	 */
> -	if (!WARN_ON_ONCE(!kc->timer_wait_running))
> -		kc->timer_wait_running(timer);
> +	timer->kclock->timer_wait_running(timer);
>  
>  	rcu_read_unlock();
>  	/* Relock the timer. It might be not longer hashed. */
> @@ -892,7 +885,6 @@ static int do_timer_settime(timer_t time
>  			    struct itimerspec64 *new_spec64,
>  			    struct itimerspec64 *old_spec64)
>  {
> -	const struct k_clock *kc;
>  	struct k_itimer *timr;
>  	unsigned long flags;
>  	int error;
> @@ -915,11 +907,7 @@ static int do_timer_settime(timer_t time
>  	/* Prevent signal delivery and rearming. */
>  	timr->it_signal_seq++;
>  
> -	kc = timr->kclock;
> -	if (WARN_ON_ONCE(!kc || !kc->timer_set))
> -		error = -EINVAL;
> -	else
> -		error = kc->timer_set(timr, tmr_flags, new_spec64, old_spec64);
> +	error = timr->kclock->timer_set(timr, tmr_flags, new_spec64, old_spec64);
>  
>  	if (error == TIMER_RETRY) {
>  		// We already got the old time...
> @@ -1001,18 +989,6 @@ static inline void posix_timer_cleanup_i
>  	}
>  }
>  
> -static inline int timer_delete_hook(struct k_itimer *timer)
> -{
> -	const struct k_clock *kc = timer->kclock;
> -
> -	/* Prevent signal delivery and rearming. */
> -	timer->it_signal_seq++;
> -
> -	if (WARN_ON_ONCE(!kc || !kc->timer_del))
> -		return -EINVAL;
> -	return kc->timer_del(timer);
> -}
> -
>  /* Delete a POSIX.1b interval timer. */
>  SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
>  {
> @@ -1025,7 +1001,10 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
>  	if (!timer)
>  		return -EINVAL;
>  
> -	if (unlikely(timer_delete_hook(timer) == TIMER_RETRY)) {
> +	/* Prevent signal delivery and rearming. */
> +	timer->it_signal_seq++;
> +
> +	if (unlikely(timer->kclock->timer_del(timer) == TIMER_RETRY)) {
>  		/* Unlocks and relocks the timer if it still exists */
>  		timer = timer_wait_running(timer, &flags);
>  		goto retry_delete;
> @@ -1071,7 +1050,7 @@ static void itimer_delete(struct k_itime
>  	 * mechanism. Worse, that timer mechanism might run the expiry
>  	 * function concurrently.
>  	 */
> -	if (timer_delete_hook(timer) == TIMER_RETRY) {
> +	if (timer->kclock->timer_del(timer) == TIMER_RETRY) {

And itimer_delete() doesn't need ->it_signal_seq++ since the task is exiting
and signals are going to be flushed anyway, right...

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


>  		/*
>  		 * Timer is expired concurrently, prevent livelocks
>  		 * and pointless spinning on RT.
> 

