Return-Path: <linux-kernel+bounces-405990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0A29C59AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0753284E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F61D1FC7CC;
	Tue, 12 Nov 2024 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc24ecNC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13751FBC9B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419772; cv=none; b=Ddm/s52ASGwE4D5QvqNW9fxlYjRhmAgnAwNi/rqQJIhhr1FuJZby3koeGSBHkLlldAwZIYsa6jdp91T6dr2eKPql/F27EbtPra25tfSlFbcT8sa3u2XJa6jcddlbE8mMO+GWg5J0AiIvEThukfipHODEJ5Q/QeFNj/sujwMmze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419772; c=relaxed/simple;
	bh=T6YQnYADiOc+eB2ZCcn4o+pCA4TyC4vZ8TSHZ5+kOMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duiKLblZANNUfrwFcg/hvzYn6moThGJzkzcwH3wMgh6V2bZ8hm4X+yuXhf1c6/Oc+ISRlci6PIzyoYluHPD/kCtuWSq0c0TXlfjD8xLWE9NrUxBLqF9AhtHQhL00SFiVQgLUUXKJ3GskMd7WIIYMfqrsdiMCDU75nyi+xnFeKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc24ecNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDD3C4CECD;
	Tue, 12 Nov 2024 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731419771;
	bh=T6YQnYADiOc+eB2ZCcn4o+pCA4TyC4vZ8TSHZ5+kOMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hc24ecNCVjkhpfrV8ycxiIWZhdPjJrw4TacSlWMX6JYcVnUXCfIfAGDEVyqVQ1Y0R
	 GewWL+5dsT9Es6z5WK3wa070E3ixHzqnYYKEjACP4XL3ljYsfaZF9rJ33UMOs2WbGr
	 aWAFwEyKQ52ScJcI9k+ybt6QeQ6UB1tckZomd6l3RJYShsHQbWRHMyJ/j5uBUbgFsh
	 WM/7AH8ERdOv7XykYciWcu3PAL9dyIY4WI4bLjSLZydvaDN4Ilw++FsD+wlKp4Q3+F
	 c7jwA+4d9HVor1nxvNgt0W1G8PQnb86JLID44Rdf4U//Oh3mfjmscW0cxsDz3cxSTp
	 JlT+Q5Mpq8sig==
Date: Tue, 12 Nov 2024 14:56:08 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC 1/3] tick-sched: Remove last_tick and calculate next tick
 from now
Message-ID: <ZzNeeCvSFL7OzHKF@localhost.localdomain>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-2-joel@joelfernandes.org>
 <ZzKWvislBnjV9kpf@pavilion.home>
 <874j4co98w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874j4co98w.ffs@tglx>

Le Tue, Nov 12, 2024 at 02:46:23PM +0100, Thomas Gleixner a écrit :
> On Tue, Nov 12 2024 at 00:43, Frederic Weisbecker wrote:
> > Le Fri, Nov 08, 2024 at 05:48:34PM +0000, Joel Fernandes (Google) a écrit :
> 
> >> During tick restart, we use last_tick and forward it past now.
> >>
> >> Since we are forwarding past now, we can simply use now as a reference
> >> instead of last_tick. This patch removes last_tick and does so.
> >>
> >> This patch potentially does more mul/imul than the existing code,
> >> as sometimes forwarding past now need not be done if last_tick > now.
> >> However, the patch is a cleanup which reduces LOC and reduces the size
> >> of struct tick_sched.
> 
> May I politely ask you to read and follow the Documentation
> vs. changelogs?
> 
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
> 
> Also
> 
> git grep 'This patch' Documentation/process
> 
> might give you a hint.
> 
> >> -	/* Forward the time to expire in the future */
> >> -	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> >> +	hrtimer_set_expires(&ts->sched_timer, DIV_ROUND_UP_ULL(now, TICK_NSEC) * TICK_NSEC);
> 
> How is a division and multiplication in this hotpath helpful? That's
> awfully slow on 32-bit machines and pointless on 64-bit too.
> 
> Using now is also wrong as it breaks the sched_skew_tick distribution by
> aligning the tick on all CPUs again.
> 
> IOW, this "cleanup" is making things worse.
> 
> > We don't want to rewrite hrtimer_forward() but, after all, the current expiry is
> > enough a relevant information.
> >
> > How about just this? It's worth it as it now forwards after the real last programmed
> > tick, which should be close enough from @now with a delta below TICK_NSEC, or even
> > better @now is below the expiry. Therefore it should resume as just a no-op
> > or at worst an addition within hrtimer_forward():
> >
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 753a184c7090..ffd0c026a248 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -838,7 +838,6 @@ EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
> >  static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
> >  {
> >  	hrtimer_cancel(&ts->sched_timer);
> > -	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
> >  
> >  	/* Forward the time to expire in the future */
> >  	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> 
> That's just wrong. ts->sched_timer.expires contains a tick in the
> future. If tick_nohz_stop_tick() set it to 10 ticks in the future and
> the CPU goes out of idle due to a device interrupt before the timer
> expires, then hrtimer_forward() will do nothing because expires is ahead
> of now.
> 
> Which means the CPU is not idle and has no tick until the delayed tick
> which was set by tick_nohz_stop_tick() expires. Not really correct.

Bah! Yes of course...

> 
> Thanks,
> 
>         tglx

