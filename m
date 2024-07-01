Return-Path: <linux-kernel+bounces-235688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5653291D864
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78F9B211AD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A16F076;
	Mon,  1 Jul 2024 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="M45OcH+T"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F460BBE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817069; cv=none; b=m6Jz1fNiiUolqOZCDFHnxPdUIoVkS1LqdU8ndKJ+rwAnGu7LvWhqN1MjE3IDpU9CNCtGDQ7KwqyoEvzoinglSiaBwT9Bhwah6dCcWhB+nQjDTapF/Mboy4G/9NnWVLdcAuopKOQvahTifE9RqyHV0BkLexk3doHxi/64BbkPGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817069; c=relaxed/simple;
	bh=Zc7HA+BQowWq5Oaa95fc6fBaYWxRXcEecHyUImcmiFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VeIUfL5om0lp7njej+RyGr66feGnBrYVvu8oJVHEh31W2DOpf6Ol2FH/+hLm0dGZScX1gthyqSEVzEOhrK/vR7jMKnO+t7Z8mi6oH5ouFtMoo/tIJ0XEJIcotV7Lf8clkL+jSmQ+3u2G6s2M4WSAF/1MTKivobe6pEUrpeR7LCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=M45OcH+T; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719817046; x=1720421846; i=efault@gmx.de;
	bh=5wPewIEuF6TbLHl/Kj1QXPvantQneRP01pEe6xIVb7k=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M45OcH+T/ZUj+jfNw7jrWxwQLzHzP/4Vayb8iqX0gcSlb/fJ4UNv2DJiZpOpaRGF
	 dL5V5QuTHUTQRR3s+Qp+plrffr6aJk2NLofkGP8nHXMhIJYw9sQv1wcN2LJSiSmyi
	 ms5PBSuwurHl2Bk//PIagg0U7rkGMJR+Aa+GTpc7GEa/sFurJSqvPbF+cJ1YbKLDr
	 mXWklWCth5HjJ3/XQ9079ldkLFropJgCEq9w/sTf/7NPIy40xZ1f3ambxVaT2oD5A
	 UyH2lRgeT063X6PAT8196dxEjd3I9d11rvkfEg1HbTPSsBxjB6lVBd7ARZVvMJhIg
	 wF3dPN8C+f0/us1KhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.216.19]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1srZfd2Bx9-00T42L; Mon, 01
 Jul 2024 08:57:26 +0200
Message-ID: <db81ba7fba622e2a1b7186e66471cfb9ad8490fd.camel@gmx.de>
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
From: Mike Galbraith <efault@gmx.de>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Tim Chen <tim.c.chen@intel.com>, Yujie Liu
 <yujie.liu@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R
 . Shenoy" <gautham.shenoy@amd.com>,  Chen Yu <yu.chen.surf@gmail.com>,
 linux-kernel@vger.kernel.org
Date: Mon, 01 Jul 2024 08:57:25 +0200
In-Reply-To: <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
References: <cover.1719295669.git.yu.c.chen@intel.com>
	 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
	 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
	 <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+aQCZbKsF8EVAytOQhP20MIfuHhKmi4JIncM4tSynN0UW/8KO5+
 d0/U+MYfVQQquZS2Qty2snf+vXq9ZdJskzrwsCEzDckihZ1d1nxTq0cvcaifQ74J34VQSIO
 lw4iasYEN4edPOagOKBTXwFFitIh1Ir3HMuAyeMk6XYzm9uXY35JkAG4Uryf+3raGSCoPMZ
 hHd+ZkhgqxPiHWWXXjMrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e+bbNlmh9ig=;2IFEq5urH5lMd0JIcQ4dfwF02MB
 WWAnXHA/vlDp2QhUQgYMni415oayeqZ6lAUd1WeSQeKNVT6+vpsTK1tFVIEPYn0f1A/TrCX01
 WC3Rx0+YOZrgglm25W5gWIWrlypfmN8g1TvraCxL/VA5iWhqTgqi62A1cQQhF+sRxWCLZoROP
 Vka5r/TJcm50a/gYLSKP92qIKwWHeScB57Ank36kXM6irNPfpF1FBlQcJm6N3CajRr6Lpfiz9
 eaUh/+v+ZoGImg1MMBn+Smv1VJVT7uP01CWs+P50ltsPOkDZ5QsrAHdgCJWeYBtApjsYjxkql
 O/cRG5THQS3v1BegAvz3E3Ql1Evz7aPgeRvmqbf0m3xqykGnylJoLswAknEyejkwejxYYSyqU
 3SzwoN2UGsFqc8cmnDxEdc0vsot1sfN9Nd6XZGiHwDg6w4EjpaxJOIgO7tWVGA9FRQZ2yvbOP
 5saztbNQEtnWFd2gd3qOO2kecctDGwUd6/nktCGnCEvG2se/l/0wFkLz7QP5ZhSSUUHjBKpi5
 TInQDpwPVVaYk2gOxG3lK7kna6mj71JRURBN0FqwjTqZRInkcwiyB0FoS6t+3p3YXcdp3lczq
 oHQpEIBhWloNrUusOh55P9hCA0gTzxDzA5H7QdUELfTnkhG+TKcHWdoY0IB3y4kJkpWxC6qKJ
 YgqK/2ixMs3bhSvNlJmWVnjfF3cdLU76bUOnGk9GGrAKsvMsHF+Xt/OvEmRmYVtXxaYG2fDNC
 kYFVdennz3fPwSExfehk2YD3JDk69gm73lVyWGDmCL8271vDhvex4ePsKBJ7xjyDez6jXh9hc
 E+1PFxF/QGE3we0c9Q3aSSz4C8f8933d4q3bxi1CUKOKU=

On Sun, 2024-06-30 at 21:09 +0800, Chen Yu wrote:
> Hi Mike,
>
> Thanks for your time and giving the insights.
>
> On 2024-06-26 at 06:21:43 +0200, Mike Galbraith wrote:
> > On Tue, 2024-06-25 at 15:22 +0800, Chen Yu wrote:
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 0935f9d4bb7b..7399c4143528 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -4359,6 +4359,8 @@ static void __sched_fork(unsigned long clone_f=
lags, struct task_struct *p)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p->migration_pending=
 =3D NULL;
> > > =C2=A0#endif
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_sched_mm_cid(p)=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p->prev_sleep_sum_runtime=
 =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p->duration_avg =3D 0;
> > > =C2=A0}
> >
> > Beginning life biased toward stacking?
> >
>
> OK, so I should change the short_task() to skip the 0 duration_avg, to a=
void
> task stacking in the beginning.

Or something, definitely.
=C2=A0 =C2=A0
> > > =C2=A0DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 41b58387023d..445877069fbf 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > >
> > > @@ -6905,6 +6914,9 @@ static void dequeue_task_fair(struct rq *rq, s=
truct task_struct *p, int flags)
> > > =C2=A0
> > > =C2=A0dequeue_throttle:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0util_est_update(&rq-=
>cfs, p, task_sleep);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (task_sleep)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dur_avg_update(p);
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hrtick_update(rq);
> > > =C2=A0}
> > >
> >
> > That qualifier looks a bit dangerous.=C2=A0 Microbench components tend=
 to
> > have only one behavior, but the real world goes through all kinds of
> > nutty gyrations, intentional and otherwise.
> >
>
> Understand. Unfortunately I don't have access to production environment
> so I have to rely on microbenchmarks and a OLTP to check the result. I
> get feedback from Abel that the former version of this patch brought
> benefit to some short tasks like Redis in the production environment[1].
> https://lore.kernel.org/lkml/36ba3b68-5b73-9db0-2247-061627b0d95a@byteda=
nce.com/

Here's hoping you get a lot more.

> I can launch a combination of microbenchmarks in parallel to check the i=
mpact.
>
> > The heuristics in the next patch seem to exhibit a healthy level of
> > paranoia, but these bits could perhaps use a tad more.=C2=A0 Bad exper=
iences
> > springs to mind when I stare at that - sleepers going hog, hogs meet
> > sleeping lock contention, preemption, sync hint not meaning much...
> >
>
> I see. If I understand correctly, the scenario mentioned above
> could bring a false positive of 'short task', which causes
> task stacking.

Yeah.

> If the sleeper task:
> 1. is preempted frequently. This should not be a problem, because
> =C2=A0=C2=A0 the task duration is unlikely to be shorten by preemption, =
and
> =C2=A0=C2=A0 the short_task() is unlikely to return true.

Ah, but it not being a problem would beg the question why bother?
There are consequences either way, the dark side is just scarier.

> 2. meets sleeping lock contention. This would be a false positive 'short=
 task',
> =C2=A0=C2=A0 which bring unexpected task stacking.

Yeah.

> So consider 1 and 2, I'm thinking of moving the calculating of task dura=
tion from
> dequeue_task_fair() to wait_woken(). The reason to update the task's dur=
ation in
> wait_woken() rather than dequeue_task_fair() is that, the former is awar=
e of the
> scenario that the task is waiting for the real resource, rather than blo=
cking
> on a random sleeping lock. And the wait_woken() is widely used by the dr=
iver to
> indicate that task is waiting for the resource. For example, the netperf=
 calltrace:
>
> =C2=A0=C2=A0=C2=A0 schedule_timeout+222
> =C2=A0=C2=A0=C2=A0 wait_woken+84
> =C2=A0=C2=A0=C2=A0 sk_wait_data+378
> =C2=A0=C2=A0=C2=A0 tcp_recvmsg_locked+507
> =C2=A0=C2=A0=C2=A0 tcp_recvmsg+115
> =C2=A0=C2=A0=C2=A0 inet_recvmsg+90
> =C2=A0=C2=A0=C2=A0 sock_recvmsg+150
>
> In the future, if there is requirement other scenario could also invoke =
the newly
> introduced update_cur_duration() when needed. For example, the pipe_read=
() could
> use it if the task is going to sleep due to the empty pipe buffer. I cha=
nge the
> code as below, may I have your suggestion on this?

I don't have any suggestions that will help plug the holes, heck, I
squabbled in this arena quite a bit some years ago, and did not win.
Frankly I don't think the scheduler has the information necessary to do
so, it'll always be a case of this will likely do less harm than good,
but will certainly leave at least an occasional mark.

Just take a look at the high speed ping-pong thing (not a benchmark,
that's a box full of tape measures, rather silly, but..).  TCP_RR IS
1:1, has as short a duration as network stack plus scheduler can
possibly make it, and is nearly synchronous to boot, two halves of a
whole, the ONLY thing you can certainly safely stack.. but a shared L2
box still takes a wee hit when you do so.  1:N or M:N tasks can
approach its wakeup frequency range, and there's nothing you can do
about the very same cache to cache latency you're trying to duck, it
just is what it is, and is considered perfectly fine as it is.  That's
a bit of a red flag, but worse is the lack of knowledge wrt what tasks
are actually up to at any given time.  We rashly presume that tasks
waking one another implies a 1:1 relationship, we routinely call them
buddies and generally get away with it.. but during any overlap they
can be doing anything including N way data share, and regardless of
what that is and section size, needless stacking flushes concurrency,
injecting service latency in its place, cost unknown.

Intentional stacking can be jokingly equated to injecting just a wee
bit of SMP kryptonite.. it'll be fine.. at least until it's not ;-)

	-Mike

