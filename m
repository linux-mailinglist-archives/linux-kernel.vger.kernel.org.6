Return-Path: <linux-kernel+bounces-372541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E079A4A10
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC111F2305B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD0E1917DB;
	Fri, 18 Oct 2024 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULc7aPOU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862D190676
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293861; cv=none; b=N4abFg1D7ufvVjwdl9eohS43nG0LCiKGEEq8k9v3bE8sKclxWktfTt/mMHKG/Mbwe5T8iuI0/9J3pgZiTz3JZGi7er0sCc3bKuC/HrMSQtv5VSVXDniDzK5Xjz1WaffMact+9S6QrFdaJS0lKlSYcIp83rnMmaIn8GbhWlink0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293861; c=relaxed/simple;
	bh=WIVWZ//bBgNGYCY0dCsy0HWRYhRi6t5eU2CNcU4C7j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwVsl1h6YrZC1o7sE5snr0arXn5UnrFO906InXF1rx5hPu3BmKzywSLtij8YppDF0tUIpiypSL8EI+r4gwJuZmJomGBEuyDjL6BeAMouqDQWbpNSS74ZFm+pv6YEqE6svaBOhk7gaA852/ShZJBeFswQSi1AI39TXKeGfeKBziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULc7aPOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82950C4CEC3;
	Fri, 18 Oct 2024 23:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729293859;
	bh=WIVWZ//bBgNGYCY0dCsy0HWRYhRi6t5eU2CNcU4C7j8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ULc7aPOU3Sd95QuL1q4MOQiasFP9dIIIRK54QHpSGD5rLwGsiTm0f77vw4qqDmFgl
	 snb+USBZQ7N7+AJASke5vJP/OGMe3x9r20REo3C3pNtxjc8xbSQIUmXaK/K2MlFnKp
	 WY4fEqzI96RI+LNd3kTkVcn0h/MCaIL0mrn6outRdjjFSbQq66B5ryZTuSCotlm8YQ
	 jG2q1aVpfX5F5mhlqMtcQr46SpWeWTS0od6Cyc9WFO+yeiyK2tKaUelOZL24yGpr/I
	 CuGgiJr+9aiVMUPd8wmhzt/A8ktjlkoGDKE43oONKhyp611JVjX5lnAF7W3GIAPob7
	 C8tSeynJMHx3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 11FB7CE0995; Fri, 18 Oct 2024 16:24:19 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:24:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <c886bdf4-23d0-4c12-ae44-454226e92265@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
 <87ed4hrp45.fsf@oracle.com>
 <20241017080439.9od9eoBO@linutronix.de>
 <871q0emji1.fsf@oracle.com>
 <0c04a986-91d0-4f6d-bd4e-ca00d1cd710a@paulmck-laptop>
 <87zfn1jk43.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfn1jk43.fsf@oracle.com>

On Fri, Oct 18, 2024 at 12:18:04PM -0700, Ankur Arora wrote:
> 
> Paul E. McKenney <paulmck@kernel.org> writes:
> 
> > On Thu, Oct 17, 2024 at 03:50:46PM -0700, Ankur Arora wrote:
> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> >> > On 2024-10-15 15:13:46 [-0700], Ankur Arora wrote:
> >> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> >> >>
> [ ... ]
> >> Sure. But, that's just begging the question.
> >>
> >> We want _NONE and _VOLUNTARY to go away because keeping cond_resched()
> >> around incurs a cost.
> >
> > When you say "go away", do you mean for your use cases?  Or globally?
> 
> When I say "want _ to go away" I mean: cond_resched() is deleterious
> to performance since you are forced to have code which can do the
> rescheduling check synchronously -- when this could easily be done
> asynchronously (as the non voluntary models do).
> 
> And this either means poor performance (ex. in the page zeroing code
> where it would be more optimal to work on continguous ranges) or
> gyrations like the ones that xen_pv_evtchn_do_upcall() and the
> Xen hypervisor have to go through.
> 
> And, as we've discussed before, the cond_resched() interface, while it
> works, is not ideal.

I would expect that many instances of cond_resched() could go away given
lazy preemption, but I would not be surprised if there were some that
needed to stay around.

Your thought being that if *all* instance of cond_resched() go away,
then PREEMPT_NONE also goes away?  Given how long PREEMPT_NONE has been
around, this would need to be done (and communicated) quite carefully.

> Also, a man can dream!

Fair enough, just be very careful to distinguish dreams from reality.  ;-)

							Thanx, Paul

