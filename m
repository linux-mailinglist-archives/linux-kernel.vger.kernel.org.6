Return-Path: <linux-kernel+bounces-552850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5527EA57F68
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 23:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D641884982
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 22:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D981E834F;
	Sat,  8 Mar 2025 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi1jmIE8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7161AA1C8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741474117; cv=none; b=UrqjpyJNwQcjpUEBze9Sis+fbAblYnC+1j5lndS8dNoscHU9ZXeF1yDZG5UHti0kfhj+rNwVZXNf3+wmrWZTIi4FGbrLvW+06iZTBEuMMySt/PjWOHN5HOmPxY5fxzJM3OPVHVVkOXOxEMIINnv5lDIN7Tz0OnhdXCqwP69J/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741474117; c=relaxed/simple;
	bh=HsTzUSlwUghBGudHn1GbbnYvhPej4GoUjLOnJW1/ZYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvKrJiq5t7+3qqxOmI4uG//wdEut9RtTlCFlKO+Is5JeOkPXKGoD1VmnWUDsFc4PU6vmW4wb+gWiFufK221s3BT9tgMxSFLq8qGUXcW97WXqNzyPrh2KIGryRg0wgXoI6r+JpKlL6NsISTIrXMjBWSlswOn7rZW0W5oloCu1BlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi1jmIE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DFFC4CEE0;
	Sat,  8 Mar 2025 22:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741474116;
	bh=HsTzUSlwUghBGudHn1GbbnYvhPej4GoUjLOnJW1/ZYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xi1jmIE8a0pOzU+Z0hCpUnl7IQ5p/eL6kDZ7fGhlBJdxP9BJfB/kn5Tx1H07zqv9R
	 52FTZbS/od8zfKgmEDE+fRd6c5GKjZerITmjR+VFFxCm5G3APwHQBNZSKCjP4Cv5CD
	 Us66P45vEibXrXAXCy6LU3lDGqd6A+k/RZAjXrWrZ81gcMQj5scXFuZUbYN6/cYt0L
	 qpCct0O0edwcoTImydWSL2TMrpScMRpHP314h2Zgrrl+qW0cJVtDYlnjN59QrLQEl4
	 47CrgTlytOA14F3K7wVIi3k+H4oj2I7YR4JcTFnd+hrjISL9sfldICiOBQig2xKG7m
	 xvYo/B6fBZyNw==
Date: Sat, 8 Mar 2025 23:48:34 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/17] posix-timers: Rework timer removal
Message-ID: <Z8zJQtzLIliTNe2e@pavilion.home>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.416552300@linutronix.de>
 <Z8t7UJUd9SLT0Ytj@pavilion.home>
 <8734fn53b5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734fn53b5.ffs@tglx>

Le Sat, Mar 08, 2025 at 09:34:06AM +0100, Thomas Gleixner a écrit :
> On Sat, Mar 08 2025 at 00:03, Frederic Weisbecker wrote:
> > Le Sun, Mar 02, 2025 at 08:36:56PM +0100, Thomas Gleixner a écrit :
> >> --- a/include/linux/posix-timers.h
> >> +++ b/include/linux/posix-timers.h
> >> @@ -240,6 +240,13 @@ static inline void posixtimer_sigqueue_p
> >>  
> >>  	posixtimer_putref(tmr);
> >>  }
> >> +
> >> +static inline bool posixtimer_valid(const struct k_itimer *timer)
> >> +{
> >> +	unsigned long val = (unsigned long)timer->it_signal;
> >> +
> >> +	return !(val & 0x1UL);
> >> +}
> >>  #else  /* CONFIG_POSIX_TIMERS */
> >>  static inline void posixtimer_sigqueue_getref(struct sigqueue *q) { }
> >>  static inline void posixtimer_sigqueue_putref(struct sigqueue *q) { }
> >> --- a/kernel/signal.c
> >> +++ b/kernel/signal.c
> >> @@ -2092,7 +2092,7 @@ static inline void posixtimer_sig_ignore
> >>  	 * from a non-periodic timer, then just drop the reference
> >>  	 * count. Otherwise queue it on the ignored list.
> >>  	 */
> >> -	if (tmr->it_signal && tmr->it_sig_periodic)
> >> +	if (posixtimer_valid(tmr) && tmr->it_sig_periodic)
> >>  		hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
> >>  	else
> >>  		posixtimer_putref(tmr);
> >> --- a/kernel/time/posix-timers.c
> >> +++ b/kernel/time/posix-timers.c
> >> @@ -279,7 +279,7 @@ static bool __posixtimer_deliver_signal(
> >>  	 * since the signal was queued. In either case, don't rearm and
> >>  	 * drop the signal.
> >>  	 */
> >> -	if (timr->it_signal_seq != timr->it_sigqueue_seq || WARN_ON_ONCE(!timr->it_signal))
> >> +	if (timr->it_signal_seq != timr->it_sigqueue_seq || !posixtimer_valid(timr))
> >
> > Hmm, should it still warn here? ie: WARN_ON_ONCE(!posixtimer_valid(timr)) ?
> 
> No, because the timer is invalidated early now.

But the signal can only be queued before posix_timer_delete(). So
if the bit 0 of it_signal has been reset, it_signal_seq must have been
incremented along, right?

And if so then timr->it_signal_seq == timr->it_sigqueue_seq must imply
posixtimer_valid(). And if not we should warn. Or am I missing something?

Thanks.


> 
> Thanks,
> 
>         tglx

