Return-Path: <linux-kernel+bounces-392691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 662C59B971F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE7AB216D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F01CDFA7;
	Fri,  1 Nov 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="m/ivxbRX"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873CA1CB321
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484555; cv=none; b=l5DsQLW2xMTSeeHY/TyoHCk4aoxGanDEHVBT2oXq7cSCVhWrNtXf6VE4onytxhAYtWA7rfmZerd339iaddFYxTm40W5V2KzwXtkN9ONLkI3vp4uzwy+AlJ1ixuhUsC1IgfNH57tdYbnLI4Q//UuLXO7BS265pZ7KAJoF5jwHxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484555; c=relaxed/simple;
	bh=GA3DIH8k3j9pYH/Bl6BYIuAJu5F2st1ewT0p2THTlrw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/Iy8hBMDh10qABXiyE4mCNBlIzVsay6CG3EoNF2OFzcqGfbYzWQO6FxCble/eQoAjYSSqM6GFK7HZ0JNDaxMcc5MS7Ck3lpN7Yo4q03u7k07PzTA07aoyo1R+XMt/hYQgUUCBA7E6JJsbyL2Rc208uG2pkFmSu8M282wKFSV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=m/ivxbRX; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730484513; x=1731089313; i=efault@gmx.de;
	bh=7opc3LHSElwOkD8p1sc5OTM05usHzju1dJINWaCETFE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m/ivxbRXNLPIXGdJviio+Bz/w2QIwfQMdma7vYzbvesm2oWbS40G4MSQgtLk5020
	 PLNT6i0DwPRvi3PxV7cWNxkfIAdAzYLrDpGfu8ggE2q2JoMix9z6oHkadubiZPNz4
	 DNVYhbtfrTB26JNTMCGEbXn5CE5aJ9RNjNGiOjUZsooAr4m5872I6+5CQV6syjfLm
	 1gk6MDtrz+JAJfdYS2YITgj6AseeN7ihmlwgX2B7a71akEL11XXg8T+R7NerluG9e
	 hLmrvaEuBUTHM9go32WMpl7tVhllEjCS0Pu5QzqyEVH7BCVuMI0HtvOaPyfR7hClE
	 BAyaGofwfc4tG2hr6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.16]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MoO6M-1te51t08N6-00jCC1; Fri, 01
 Nov 2024 19:08:33 +0100
Message-ID: <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Phil Auld <pauld@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de,  vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com,  wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Fri, 01 Nov 2024 19:08:31 +0100
In-Reply-To: <20241101144225.GD689589@pauld.westford.csb>
References: <20240727102732.960974693@infradead.org>
	 <20240727105030.226163742@infradead.org>
	 <20241101124715.GA689589@pauld.westford.csb>
	 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
	 <20241101133822.GC689589@pauld.westford.csb>
	 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
	 <20241101144225.GD689589@pauld.westford.csb>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AZthKZfWnQLysYJZVMV1PWNPpmERMNwNe5jNBKYeUO+BoiwHhyk
 iYL+8cYTt+6XTDVNT9wxl/DQmbyunw/lNGLM5ZRWQiWzAhB3XgDESU8fdqIofqIMQsJPPmW
 rl3baQwT0GNl4PgNnrSEDZUb7mSKGZWZplFxEHNkM8F+Cq0IgR0dMZ0+5h90RccqPHAI5HA
 zcnaoGh5gg+bB4LdvmzNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u1zNwz075T4=;S1GG8Y1NHR9Nu0ccdGagOe/FaQ3
 pHZDpf5sLwcLF0meKndbPOzID07jRimFcpzhHgpGxXGzF//3UjKX55Xzw78SG7MdhlwWCmzF3
 psp51vjDcHmyrnYX8rA6AT/2VWGY6+EBBG4IoaYEJ5W8ARNK5P/Mjpa2hFTLqXnyKdNictgZ/
 GaCuJg/yP3KTrD7MXk3QhLO8Lw04BKilh+cU63zHcyPxKjUzuzw3Zpj4YtK+jJlb0yP2gD5Rs
 ki44UFPqPFO+u6YKb/IGfnB0RMhL27L1eSrPITzvcPUBii20ZkHJbbvAS/mn2IxZKcoAjanx8
 RcPTr/URPDLWD17OObECpofrkHbfnBvwISvRNiw8K6SVwdCrlJODHKU1vF/P7/AD5l9iWSqOs
 7umCvZqupAlgeD24+uicnf/RWm4F1CgBcxRL+2WU9MD6fuhIJWNRCpo8/ijo7D2jFiP/+r5U2
 V72zy1B0u7++NQpre8qgDxgjwBCeME7UzCMdZ2GMJ4We2ssdK7f2CIGoPYf8p/5ZwTbNS9oV+
 Iux1WlkwVeJFezWHG90Mo8HsKjq/EmAFDrSns688ZQH6zpPeniy8t9wWwHR2ezBXwoIo6J8Ge
 YGVsEUyDnZQCvKCQ/eQhAdbOUCJBG1GK9i1UMQ8gktnMpmV19IImirvA/6UBWKSi/VCVvGr8g
 iMUcN+P/VzrFaEG0KlUoYyy0Xc59KE5+hJfMevZeBezHLQZqJ7e0DbDxv6T5JgB1duXjWkZH6
 qqIoMo5Deo5tC0ArXLtYos2S96zlnWnGWwWHM4Q+m1Pon8cyiif9djYUsfDTb0KiXLe48j5vs
 8sKIyDLqBGA8txSODCQUSMzQ==

On Fri, 2024-11-01 at 10:42 -0400, Phil Auld wrote:
> On Fri, Nov 01, 2024 at 03:26:49PM +0100 Peter Zijlstra wrote:
> > On Fri, Nov 01, 2024 at 09:38:22AM -0400, Phil Auld wrote:
> >
> > > How is delay dequeue causing more preemption?
> >
> > The thing delay dequeue does is it keeps !eligible tasks on the runque=
ue
> > until they're picked again. Them getting picked means they're eligible=
.
> > If at that point they're still not runnable, they're dequeued.
> >
> > By keeping them around like this, they can earn back their lag.
> >
> > The result is that the moment they get woken up again, they're going t=
o
> > be eligible and are considered for preemption.
> >
> >
> > The whole thinking behind this is that while 'lag' measures the
> > mount of service difference from the ideal (positive lag will have les=
s
> > service, while negative lag will have had too much service), this is
> > only true for the (constantly) competing task.
> >
> > The moment a task leaves, will it still have had too much service? And
> > after a few seconds of inactivity?
> >
> > So by keeping the deactivated tasks (artificially) in the competition
> > until they're at least at the equal service point, lets them burn off
> > some of that debt.
> >
> > It is not dissimilar to how CFS had sleeper bonus, except that was
> > walltime based, while this is competition based.
> >
> >
> > Notably, this makes a significant difference for interactive tasks tha=
t
> > only run periodically. If they're not eligible at the point of wakeup,
> > they'll incur undue latency.
> >
> >
> > Now, I imagine FIO to have tasks blocking on IO, and while they're
> > blocked, they'll be earning their eligibility, such that when they're
> > woken they're good to go, preempting whatever.
> >
> > Whatever doesn't seem to enjoy this.
> >
> >
> > Given BATCH makes such a terrible mess of things, I'm thinking FIO as =
a
> > whole does like preemption -- so now it's a question of figuring out
> > what exactly it does and doesn't like. Which is never trivial :/
> >
>
> Thanks for that detailed explanation.
>
> I can confirm that FIO does like the preemption
>
> NO_WAKEUP_P and DELAY=C2=A0=C2=A0=C2=A0 - 427 MB/s
> NO_WAKEUP_P and NO_DELAY - 498 MB/s
> WAKEUP_P and DELAY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 519 MB/s
> WAKEUP_P and NO_DELAY=C2=A0=C2=A0=C2=A0 - 590 MB/s
>
> Something in the delay itself
> (extra tasks in the queue? not migrating the delayed task? ...)

I think it's all about short term fairness and asymmetric buddies.

tbench comparison eevdf vs cfs, 100% apple to apple.

1 tbench buddy pair scheduled cross core.

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COM=
MAND
13770 root      20   0   21424   1920   1792 S 60.13 0.012   0:33.81 3 tbe=
nch
13771 root      20   0    4720    896    768 S 46.84 0.006   0:26.10 2 tbe=
nch_srv

Note 60/47 utilization, now pinned/stacked.

6.1.114-cfs
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COM=
MAND
 4407 root      20   0   21424   1980   1772 R 50.00 0.012   0:29.20 3 tbe=
nch
 4408 root      20   0    4720    124      0 R 50.00 0.001   0:28.76 3 tbe=
nch_srv

Note what happens to the lighter tbench_srv. Consuming red hot L2 data,
it can utilize a full 50%, but it must first preempt wide bottom buddy.

Now eevdf.  (zero source deltas other than eevdf)
6.1.114-eevdf -delay_dequeue
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COM=
MAND
 4988 root      20   0   21424   1948   1736 R 56.44 0.012   0:32.92 3 tbe=
nch
 4989 root      20   0    4720    128      0 R 44.55 0.001   0:25.49 3 tbe=
nch_srv
6.1.114-eevdf +delay_dequeue
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COM=
MAND
 4934 root      20   0   21424   1952   1736 R 52.00 0.012   0:30.09 3 tbe=
nch
 4935 root      20   0    4720    124      0 R 49.00 0.001   0:28.15 3 tbe=
nch_srv

As Peter noted, delay_dequeue levels the sleeper playing field.  Both
of these guys are 1:1 sleepers, but they're asymmetric in width.

Bottom line, box full of 1:1 buddies pairing up and stacking in L2.

tbench 8
6.1.114-cfs      3674.37 MB/sec
6.1.114-eevdf    3505.25 MB/sec -delay_dequeue
                 3701.66 MB/sec +delay_dequeue

For tbench, preemption =3D shorter turnaround =3D higher throughput.

	-Mike

