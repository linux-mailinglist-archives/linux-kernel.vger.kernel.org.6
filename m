Return-Path: <linux-kernel+bounces-372627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ACC9A4B2F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 06:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A8A1C214FE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 04:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62AB19341F;
	Sat, 19 Oct 2024 04:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFKgaWMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810F20334
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 04:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729312249; cv=none; b=p7XFoCF57YwnG0SINo1rwhOxrmg0Y6hx0VRiyAq4mdo4unODRpM7745h8R5b01YuN+aCtjyDM3oJ/DwedHkFaBCD73lzBCl3/O/WMZmtv9Bx+sQv8C7y4xGuymkkFnejoesYu2Bhx7Sbfi6P/vE/P1BNLjhYSG62G2F/yZgD0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729312249; c=relaxed/simple;
	bh=xGZYzUZaNhbgIIphtXmixmECPAq8Xmc2kT4MtBKGUVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN/nFChWpz84aJxFHbhKYSdy4uPnYPWmWpFP0KUpVNJL86/KqWbuDk1GjJ6NCs9Aldbstiy+kfHazaOv+KZLWWlCFaLwenIycH4B7xhKMzQjy2oXWeDZgg7ulNbA8oQUUSIPOu3PclU729FemTwov0uAlfnWOMeUm2HhHCgmoAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFKgaWMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DDEC4CEC7;
	Sat, 19 Oct 2024 04:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729312248;
	bh=xGZYzUZaNhbgIIphtXmixmECPAq8Xmc2kT4MtBKGUVw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dFKgaWMF+D37efttGTa1Cf7UIluq5A/piPYukiq5KvTWiU35c2rXYqENj8fB5T1Cc
	 nozsO3xD/EIiuWvaxozbos9zfd5L/1jLc7zFGmPu24NRE8uzWNRpnFtiK6quNaCf00
	 IPvfWpGVYLY13j/NmSTxHWXPiPGRj9f/1WFJTGbJkIt6MTInJIXtjqXYmjv7GAYuYQ
	 5+MDNmTotQsDx768Lys6+1cP0L15FXEm54dn6XVaZH9r0RFouMY0LJ6n/WENyRIUdM
	 AqvPS/XvCPQAx7AeudGeORu48DJgOxAWzGYvyyTHnunQWb6GvOMPADn0Q+DJsd2SaC
	 4uT0P75j2MidA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ECD74CE0995; Fri, 18 Oct 2024 21:30:47 -0700 (PDT)
Date: Fri, 18 Oct 2024 21:30:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <b4c64bb3-5f2f-476d-bb67-8b45efb5aad1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
 <87ed4hrp45.fsf@oracle.com>
 <20241017080439.9od9eoBO@linutronix.de>
 <871q0emji1.fsf@oracle.com>
 <0c04a986-91d0-4f6d-bd4e-ca00d1cd710a@paulmck-laptop>
 <87zfn1jk43.fsf@oracle.com>
 <c886bdf4-23d0-4c12-ae44-454226e92265@paulmck-laptop>
 <87iktokihj.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iktokihj.fsf@oracle.com>

On Fri, Oct 18, 2024 at 06:07:52PM -0700, Ankur Arora wrote:
> 
> Paul E. McKenney <paulmck@kernel.org> writes:
> 
> > On Fri, Oct 18, 2024 at 12:18:04PM -0700, Ankur Arora wrote:
> >>
> >> Paul E. McKenney <paulmck@kernel.org> writes:
> >>
> >> > On Thu, Oct 17, 2024 at 03:50:46PM -0700, Ankur Arora wrote:
> >> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> >> >> > On 2024-10-15 15:13:46 [-0700], Ankur Arora wrote:
> >> >> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> >> >> >>
> >> [ ... ]
> >> >> Sure. But, that's just begging the question.
> >> >>
> >> >> We want _NONE and _VOLUNTARY to go away because keeping cond_resched()
> >> >> around incurs a cost.
> >> >
> >> > When you say "go away", do you mean for your use cases?  Or globally?
> >>
> >> When I say "want _ to go away" I mean: cond_resched() is deleterious
> >> to performance since you are forced to have code which can do the
> >> rescheduling check synchronously -- when this could easily be done
> >> asynchronously (as the non voluntary models do).
> >>
> >> And this either means poor performance (ex. in the page zeroing code
> >> where it would be more optimal to work on continguous ranges) or
> >> gyrations like the ones that xen_pv_evtchn_do_upcall() and the
> >> Xen hypervisor have to go through.
> >>
> >> And, as we've discussed before, the cond_resched() interface, while it
> >> works, is not ideal.
> >
> > I would expect that many instances of cond_resched() could go away given
> > lazy preemption, but I would not be surprised if there were some that
> > needed to stay around.
> >
> > Your thought being that if *all* instance of cond_resched() go away,
> > then PREEMPT_NONE also goes away?
> 
> If *all* instances of cond_resched() go away, is there anything left of
> PREEMPT_NONE?

Yes, namely its relationship to PREEMPT_RCU.  Which, yes, can be adjusted,
perhaps even as Sebastian suggested.  But such an adjustment cannot be
applied suddenly without warning.

> > Given how long PREEMPT_NONE has been
> > around, this would need to be done (and communicated) quite carefully.
> 
> I don't think there's any question about that.

Whew!!!

> >> Also, a man can dream!
> >
> > Fair enough, just be very careful to distinguish dreams from reality.  ;-)
> 
> I've generally not found that to be a problem, but thanks for the warning.

"It is a service that I provide."  ;-)

							Thanx, Paul

