Return-Path: <linux-kernel+bounces-393610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB279BA31A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 00:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF7A2B21C61
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 23:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B716DED2;
	Sat,  2 Nov 2024 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b46XrfJV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D44153814
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 23:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730591174; cv=none; b=XLEFj6WoncdWg5CYJjreYEzUNziFPuGI/rsHhxErXjikdSE2Mc1YFFSVxehRV3hcGRqAqCCMNvdUYkj65vFuOmaZDDSvouGspg3sgcHpz2SKDNMWcIM1YmTIlALdbtjAL3ewizNGDNVyxZLh6Cu/AADA8ExSqh7o69Po1FDQOso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730591174; c=relaxed/simple;
	bh=pXLs0C6ZBsDWoIVpRV1ZMqJJMejdry1c/u4eSs6U0FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeDz0rYjb4o8ZMD6p169CQ8AWvwalPqbQYV1Zuu1Tsa7QxUljkJ3xyxpvBgYq03289zHxJD46sjMjVkUbZ0Brpsqksef0yMdCyK0C/midIqcTjZp3BgC881XeEm1tdJxGaNNoO36UBPaE30uT1UkcY4nMY63oD1P72pFoPS7wJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b46XrfJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83F1C4CEC3;
	Sat,  2 Nov 2024 23:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730591174;
	bh=pXLs0C6ZBsDWoIVpRV1ZMqJJMejdry1c/u4eSs6U0FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b46XrfJVgQsn/LyepWCB8/FbVzIYCY4iOthOCZ1lZ3TaT/NBAIS3NAKg0+W6s1jsG
	 Vw5D3Rv8MuE1lrRJ1yVcyPzseoHj9gtial/QMOaCAVOf9PqwMPc+kEghwSEkK1avIi
	 sCPyn7wOcvKigZZtr+LoGzunKmL+j/2pFTVcCaPxCvU745fl1TtU+0+kjCd5J+IYF9
	 CwMvmLglNtd9hy4d+XTOL8/gH3z/nEXalaY1ZgUpfFxdvDr9tN1NT9gk11lr7XuXVo
	 CO5dKxV75yheIyt5E3mOiX+mkTtYntoRtJHvFxwW6BXXMVyWyzhOiTSW00nZW4giWq
	 BsxmAa1vY9S0g==
Date: Sun, 3 Nov 2024 00:46:11 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 17/20] signal: Queue ignored posixtimers on ignore list
Message-ID: <Zya5wy9UyVo2cRvq@pavilion.home>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.624061922@linutronix.de>
 <ZyTj2W8Jndv0nzga@localhost.localdomain>
 <871pzuvfzg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871pzuvfzg.ffs@tglx>

Le Fri, Nov 01, 2024 at 09:47:15PM +0100, Thomas Gleixner a écrit :
> On Fri, Nov 01 2024 at 15:21, Frederic Weisbecker wrote:
> > Le Thu, Oct 31, 2024 at 04:46:43PM +0100, Thomas Gleixner a écrit :
> >> +static void sigqueue_free_ignored(struct task_struct *tsk, struct sigqueue *q)
> >> +{
> >> +	if (likely(!(q->flags & SIGQUEUE_PREALLOC) || q->info.si_code != SI_TIMER))
> >> +		__sigqueue_free(q);
> >> +	else
> >> +		posixtimer_sig_ignore(tsk, q);
> >
> > So this happens when the signal is ignored and delays it to when it will be
> > unignored. But the comment on do_sigaction() says:
> >
> > 		/*
> > 		 * POSIX 3.3.1.3:
> > 		 *  "Setting a signal action to SIG_IGN for a signal that is
> > 		 *   pending shall cause the pending signal to be discarded,
> > 		 *   whether or not it is blocked."
> > 		 *
> > 		 */
> >
> > Are posix timers an exception to that rule?
> >
> > Also I see flush_sigqueue_mask() called on other occasions, for example
> > when a STOP signal happens to remove pending CONT, not sure if posix
> > timers can set SIGCONT...
> 
> No. The problem with posix timers is that they are magically different
> from regular signals in the case of periodic timers.
> 
> When the signal is ignored at expiry, then the signal is not delivered
> and is 'dropped'. But when SIG_IGN is removed then the following period
> expiry has to deliver the signal.
>
> Right now the kernel ensures that by keeping the timer self rearming and
> rate limiting it for obvious reasons. That's a completely pointless
> exercise up to the point where SIG_IGN is removed.
> 
> The only way to avoid the self rearming is to actually stop the timer
> when the signal is ignored and rearm it when SIG_IGN for the specific
> signal is removed.
> 
> That's what this magic does...


Agreed and that covers the case when the signal is queued while the handler
is SIG_IGN. But I didn't know about the case where the signal is queued and
then the handler is set to SIG_IGN before it get a chance to be delivered.
Which of course is not fundamentally different now that I think about it
twice.

And what about the other callers of flush_sigqueue_mask()? Such as SIGCONT
removed when SIGSTOP arrives? And the reverse as well? This moves the pending
timers signals to the ignore list until the signal is unignored, but in that
case SIGCONT is not ignored? Or perhaps SIGCONT and SIGSTOP can't be set for
posix timers?

Thanks.

> 
> Thanks,
> 
>         tglx
> 

