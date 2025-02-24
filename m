Return-Path: <linux-kernel+bounces-530141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E69FDA42F96
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5D217895E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909A01E3DFD;
	Mon, 24 Feb 2025 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zc6g/bV2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09A71C84B5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434162; cv=none; b=uHeZ7NIERjcauoBPUnJaIhhVtlSp/drGv6pnwPfD2AC4hI4kESlzIxHGuWNEDkobvTf4wl1yezZHFuEXQbgQWEOJzEUGLtPJ/GJQw+NK3iGDttPZhxfWNXAzLnammgaja0/ygeiNNY1qFttmjNpd9OOVIQ+6nQh/X105fM87dnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434162; c=relaxed/simple;
	bh=mWIZJqET3HJgUis/SSyKlHa7ZqHf/PaXaTw5+7spRfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1OKiCwSt5lFnmq1L2OpD4545p3kLZBx4SiZs67SROYSZlN8/aHZKOOyzO4I0WeVdqTlhpT0/hZRe/JcGXoDGVpRQLUE6bBLaE4l+DV0VV6UfqJwTp82XU4IDRDQJhj1l8691nmdHCRcD6G+5hgZoLyivnNNfXaOxiYq1Hf09CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zc6g/bV2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X9l9Eo2ieuMHgoJ2/nm/UhtapZblbAjkWOIP6/3VAvE=; b=Zc6g/bV2F/c8RfKdMd71ftodhQ
	PrhuPiYVhbv0SpVpm6Gllu1h0UoVD2wY1FSu6o6t1pRuferb/3qREQuQyQ5FRORA+DKFLEfIHt8Zn
	auQaVfHPcUkpCtq9wi5PCY3DhmA3hC29W6oUodkVoizrrBbFrY38E04ePh6JetBJVnNCJtOJ4kwqm
	DCGDeQFz60Nc2c7Xhpbt0oBhZ/b87A8jc8vxc5ZwfDuLx2PBGP6KVbxRBZy2fqy+BvVm12Zbldib1
	fR6/KdWxu7L8NCsH95IY+9LOqpBEhIc7Y/6Uy1rGeMGClBvOhSLlhSNfYCZSab0yTARbwMdpUGfqc
	4jCppn2g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgQe-00000008mIj-2kua;
	Mon, 24 Feb 2025 21:55:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E4181300192; Mon, 24 Feb 2025 22:55:55 +0100 (CET)
Date: Mon, 24 Feb 2025 22:55:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [patch 04/11] posix-timers: Remove pointless unlock_timer()
 wrapper
Message-ID: <20250224215555.GF11590@noisy.programming.kicks-ass.net>
References: <20250224095736.145530367@linutronix.de>
 <20250224101343.211872476@linutronix.de>
 <20250224162103.GD11590@noisy.programming.kicks-ass.net>
 <87seo3fak1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87seo3fak1.ffs@tglx>

On Mon, Feb 24, 2025 at 07:43:26PM +0100, Thomas Gleixner wrote:
> On Mon, Feb 24 2025 at 17:21, Peter Zijlstra wrote:
> > On Mon, Feb 24, 2025 at 11:15:28AM +0100, Thomas Gleixner wrote:
> >> It's just a wrapper around spin_unlock_irqrestore() with zero value.
> >
> > Well, I disagree... the value is that is matches lock_timer(). Both in
> > naming and in argument types.
> 
> Sure, but it's not used consistently as we have places where
> lock_timer() is not involved.
> 
> > @@ -327,14 +350,13 @@ bool posixtimer_deliver_signal(struct ke
> >  	 * Release siglock to ensure proper locking order versus
> >  	 * timr::it_lock. Keep interrupts disabled.
> >  	 */
> > -	spin_unlock(&current->sighand->siglock);
> > +	guard(spinlock)(&current->sighand->siglock);
> 
> How is that equivalent?

I R idiot :-)

> So the resulting code is:
> 
> 	scoped_guard (lock_timer, timer_id) {
> 		struct k_itimer *timr = __guard_ptr(lock_timer)(&scope);
> 		const struct k_clock *kc;
> 
> 		memset(setting, 0, sizeof(*setting));
> 		kc = timr->kclock;
> 		if (WARN_ON_ONCE(!kc || !kc->timer_get))
> 			return -EINVAL;
>  
> 		return 0;
> 	}
> 	return -EINVAL;
> 
> I had to go and stare at the guard/class muck 10 times to convince
> myself, that this actually works. This really wants to be express the
> condition of the scoped_guard() somehow, e.g. scoped_cond_guard() or
> such.

Right, so the alternative form is something like:

	scoped_cond_guard (lock_timer, return -EINVAL, timer_id) {
		struct k_itimer *timr = __guard_ptr(lock_timer)(&scope);
		const struct k_clock *kc;

		memset(setting, 0, sizeof(*setting));
		kc = timr->kclock;
		if (WARN_ON_ONCE(!kc || !kc->timer_get))
			return -EINVAL;
	}
	return 0;

Is that really so much better?

> >  /* Delete a POSIX.1b interval timer. */
> >  SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
> >  {
> > -	return posix_timer_delete(NULL, timer_id);
> > +	scoped_guard (lock_timer, timer_id) {
> > +		posix_timer_invalidate(scope.lock, scope.flags);
> > +		scoped_guard_end(lock_timer);
> > +		posix_timer_unhash_and_free(scope.lock);
> 
> Not sure whether it's a good idea to free the scope.lock and not
> scope.timer :)

There is no scope.timer, the way this work is that the main pointer is
.lock, per the __DEFINE_UNLOCK_GUARD() helper.

I said there were rough edges :-/

Anyway, should I continue poking at this to see if I can clean it up /
extract more useful helpers.

Or shall I just let it be.

