Return-Path: <linux-kernel+bounces-387447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC989B5171
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C4E282B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD074200108;
	Tue, 29 Oct 2024 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAkSla6H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0BE2F56
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224562; cv=none; b=SMPlGP8FxvUPuI5tAsGZ7d92wTonflFOmG7esO+bpNZKgUuD2LqkZdyIsge4gkbZ3Kf1tkRsBd78NkLRS/rZEDSuFLkfOWPXAkJ3BX++2wyTZx2feXX0yWCg8qAnJJBrXOhb9x2Y2+UPFeUfex8gidp7ScO93mAS4JwmDvCi+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224562; c=relaxed/simple;
	bh=ieIdqgMIiUKJ0zB5p21X+kZG8OPXNs3tca5xfQRaBq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJxpT/87v2UgcsxAwO84pKzVsns+mx+Ibs5lfw8voV+WKaFaePPzGRrU+tILN0RKVgvIqYLOvdtlenql6PBsyiFP7grVWmfOg8W6XM9xGQ8tdzKSTCS/KcjR41mJriZst6ogk2ws1r6gpUcKKM0W+Hv69R1Y83xTvpPH4/BRh58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAkSla6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5274CC4CECD;
	Tue, 29 Oct 2024 17:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730224561;
	bh=ieIdqgMIiUKJ0zB5p21X+kZG8OPXNs3tca5xfQRaBq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sAkSla6HNYCCJesVOIpLb4abqeGSqYSBK+YIqHi92PfJqb60JwTt/jk1UJNFBQFka
	 iYzkon7wWnwHpKn2dbLWxly9dc3pdTvn24BAIyd5CdSU7umlgxf/+FYxYV2JQ8CTYS
	 vEx3gh/8sr1wKVb7+XGsnIkX56GOKJZ/iRARBaIi2H0LMbAZyb37CyykwDZxcclfJa
	 vK04jQKHDs+pLNT2Q6khp2jHAlYxswla+wfMv/qrH+NeWeZ03BLTKSVgsHMJqmZm/E
	 fO9Q2GmkcVnadDBdzIkeDcLHj93QfQY9+UUdigBrtjy63pn4ojA1YZhwuMd34SoX+P
	 L/VUREsHvNZQQ==
Date: Tue, 29 Oct 2024 18:55:58 +0100
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
Message-ID: <ZyEhrrDhDiQ6LwjV@pavilion.home>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.220867629@linutronix.de>
 <ZyEFyV28jcz85V1q@localhost.localdomain>
 <87ttcu281y.ffs@tglx>
 <ZyEOeqkSYWR2XTp_@localhost.localdomain>
 <87jzdq26id.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzdq26id.ffs@tglx>

Le Tue, Oct 29, 2024 at 05:55:38PM +0100, Thomas Gleixner a écrit :
> On Tue, Oct 29 2024 at 17:34, Frederic Weisbecker wrote:
> 
> > Le Tue, Oct 29, 2024 at 05:22:17PM +0100, Thomas Gleixner a écrit :
> >> On Tue, Oct 29 2024 at 16:56, Frederic Weisbecker wrote:
> >> >> @@ -568,10 +568,10 @@ static void collect_signal(int sig, stru
> >> >>  		list_del_init(&first->list);
> >> >>  		copy_siginfo(info, &first->info);
> >> >>  
> >> >> -		*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
> >> >> -				 (info->si_code == SI_TIMER);
> >> >> -
> >> >> -		__sigqueue_free(first);
> >> >> +		if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code == SI_TIMER)))
> >> >> +			*timer_sigq = first;
> >> >> +		else
> >> >> +			__sigqueue_free(first);
> >> >
> >> > So this isn't calling __sigqueue_free() unconditionally anymore. What if
> >> > the timer has been freed already, what is going to free the sigqueue?
> >> 
> >> __sigqueue_free() does not free timers marked with SIGQUEUE_PREALLOC.
> >> 
> >> sigqueue_free() takes care of that, which is invoked from
> >> posixtimer_free_timer(). It clears SIGQUEUE_PREALLOC and if it is queued
> >> it lets it pending and delivery will free it.
> >
> > But the delivery freeing used to be done with the __sigqueue_free()
> > above, which doesn't happen anymore, right?
> 
> It still happens because SIGQUEUE_PREALLOC is cleared in sigqueue_free()
> 
> __sigqueue_free() has
>        if (q->flags & PREALLOC)
>        	     return;
> 
> So the old code called __sigqueue_free() unconditionally which just
> returned. But now we have a condition to that effect already, so why
> call into __sigqueue_free() for nothing?

1) Signal is queued
2) Timer is deleted, sigqueue() clears SIGQUEUE_PREALLOC but doesn't go
   further because the sigqueue is queued
3) Signal is collected and delivered but it's not calling __sigqueue_free()
   so the sigqueue is not released.

This is "fixed" on the subsequent patch which uses embedded sigqueue and
rcuref but this patch alone breaks.

Or am I missing something that prevents it?

Thanks.

