Return-Path: <linux-kernel+bounces-393174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC89B9CCC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 05:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB49282587
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D421448C7;
	Sat,  2 Nov 2024 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="Df84DN0K"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70492E40E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730522021; cv=none; b=s6xl4hvPZgpxLjJ8Tjr0BfML7HTAr4uz/Q+sU7LJznMDIPzdPNDYK9DQqtvHLy6DDt+wkICX/GrfiT8QdjRrJ+UC9fqD57R47FF9+GGX7TSjetFvehiVY2hC1obE9QL58cx7uYZoGsLkSwtXUpHymlo7KJcF1qhAWX0Nxcgenf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730522021; c=relaxed/simple;
	bh=HzUtyEpJr2Du8rSSuaxiLcAsFKQl5WQQvyzYYPY0+XI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMPIV84BE63XRexs/aRQpSL+ZEqntTHuz00w4shE8fzCZbeCTN0Z7z4mPZXqfhxpCWPhZoHOFXWuBZ6ptNCG7s+mk6NG/bZVC73pfEJwsRbQhVIOnuvXSS0Y2b/FOJWJqLLRPjORE8yJAK/muEWxcPJmfLWUr358xZOuDhHn04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=Df84DN0K; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730521939; x=1731126739; i=efault@gmx.de;
	bh=uwdwfvhvs6gu7N3q16Pk1ND4J3wEG7gTq/Tb0GmPXgc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Df84DN0KGMe0xNpuxLK49cqQw81i6EqGk1SPeqEatWzTTbsfSOkSTPBTp7Yu4pAT
	 /3+FOGuJRj1M4U+cmDwkW8KRu/nSkCv4b095e9HcGLYZrN9YoWyMOMog7qzvHO8/W
	 PJEAyFI3kRuQExAHdx0UK2tbHNT/gDhWuqTAX3L5yKeRg9GjPUPnq2BO1ANoWc1Te
	 CzG/X4sNXBxwBEHaNZ3cIYoAY1/jKBIQKG/rAogbTG2zqqRA1Ab+o0yYJS7K5XCTF
	 91zBBVf7f8BuQ//MK+O0VHJGCrXzFzasWqZcXiRoCMpYBQq8emzb9n2Ri9AdA2huf
	 fNlrV9EpRvY8Kkpsqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.212]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1tFvUo3Gc4-00MJsx; Sat, 02
 Nov 2024 05:32:18 +0100
Message-ID: <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, 
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Sat, 02 Nov 2024 05:32:14 +0100
In-Reply-To: <20241101200704.GE689589@pauld.westford.csb>
References: <20240727102732.960974693@infradead.org>
	 <20240727105030.226163742@infradead.org>
	 <20241101124715.GA689589@pauld.westford.csb>
	 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
	 <20241101133822.GC689589@pauld.westford.csb>
	 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
	 <20241101144225.GD689589@pauld.westford.csb>
	 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
	 <20241101200704.GE689589@pauld.westford.csb>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0WFe6sDot8M6EJsSZdAHmAqc0WS5S4KfLEugFEWjhQDfpFwIDtd
 wBFWqeq6SJZ5kg/fMszZbhBShcu9e5P80dMAwGxMCIdqS9aSPD/s27Alf1WsHEBuctfwVBJ
 X8PsEFlLnNyJwzUNCk7CqP1SmcMrHofmwbDTM+wZVi+zdMHDW29RGjJnAp8L4xewfOAk38N
 SYYWxDhGvy0k8idxz91/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3JWeWOSr8xs=;u0YN8flrlteRg5GSwumnuMB1oMe
 XsVneIhZwSXWP7Fw37L0YuT5pPBJUnu5ZQye5p5coyuItFhk9fqxEqUPFL8SBZMstDB3I5KE+
 zvzkYSxxUs1k4m3mrqBsSRC+KuycSR70hc48dn9LakAuBU5AwNnGhfGM3wVYPzVb3dyjM348b
 NH9YDSUDd2baBDfcZ7APsRBVrkNPanMsaffRIju5OWC55xYA8fXa47npnChFCv8TKmt8Ax+I0
 4wXKXfID69vTXZfYidXW2H+TC9R3Dn0LQLg+142lypJ6zPk9sedJkej84g189TVLsR/bl75U9
 CsyrBBqQg5Y+bX4C948MF5k3dH9SYUE1nO5y4qoFfyRazjA36vvUBKlh+k/IFmk1OpbuN6HPo
 qMXrRIowmfYYxwCnB7qzI9ZHAQZ77J9uhW1ccA0gI6wOvgsyXqI7khbzn6jgNoxp7tnvEoV+n
 cCwejfE1SHhjYnvC8FwjoqwtkG0pYUL1KGStTYOdzJncFFZYcsje5VW7Kl9Ili1LVbXk4fP+6
 OTOZOfdv5478FneZY0fnQ7/qsDZwbQr1n6UP9ueW1mKdc/1zyN7HaSmYvoW7PaOeyaaVUuQzr
 FnDRDKPzc6UW8KGIFwDnbYQQspiCD/Q2KjqB4DrET/2VupNZGo2aAr3ryScyzWECdcYJWks/I
 va90cmnUkDLxEfxQH4VeV3glKoMG/NMfFfyVgpJwJjQtoRrDmURDPZZ68XrIXmBD8HKE01Oo5
 jbvqKJw2E7QLGxaeowzw8/8BsuXg8L6U8TA6OKxpFskA2QQDciBlHy1GJSqPy6OIOxfVB1kXh
 GEAo9apNpXdme0zozfmBasHQ==

On Fri, 2024-11-01 at 16:07 -0400, Phil Auld wrote:


> Thanks for jumping in.=C2=A0 My jargon decoder ring seems to be failing =
me
> so I'm not completely sure what you are saying below :)
>
> "buddies" you mean tasks that waking each other up and sleeping.
> And one runs for longer than the other, right?

Yeah, buddies are related waker/wakee 1:1 1:N or M:N, excluding tasks
happening to be sitting on a CPU where, say a timer fires, an IRQ leads
to a wakeup of lord knows what, lock wakeups etc etc etc. I think Peter
coined the term buddy to mean that (less typing), and it stuck.

> > 1 tbench buddy pair scheduled cross core.
> >
> > =C2=A0 PID USER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PR=C2=A0 NI=C2=A0=C2=A0=
=C2=A0 VIRT=C2=A0=C2=A0=C2=A0 RES=C2=A0=C2=A0=C2=A0 SHR S=C2=A0 %CPU=C2=A0=
 %MEM=C2=A0=C2=A0=C2=A0=C2=A0 TIME+ P COMMAND
> > 13770 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0 0=C2=A0=C2=A0 =
21424=C2=A0=C2=A0 1920=C2=A0=C2=A0 1792 S 60.13 0.012=C2=A0=C2=A0 0:33.81 =
3 tbench
> > 13771 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 4720=C2=A0=C2=A0=C2=A0 896=C2=A0=C2=A0=C2=A0 768 S 46.84 0.006=C2=
=A0=C2=A0 0:26.10 2 tbench_srv
> =C2=A0
> > Note 60/47 utilization, now pinned/stacked.
> >
> > 6.1.114-cfs
> > =C2=A0 PID USER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PR=C2=A0 NI=C2=A0=C2=A0=
=C2=A0 VIRT=C2=A0=C2=A0=C2=A0 RES=C2=A0=C2=A0=C2=A0 SHR S=C2=A0 %CPU=C2=A0=
 %MEM=C2=A0=C2=A0=C2=A0=C2=A0 TIME+ P COMMAND
> > =C2=A04407 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0 0=C2=A0=
=C2=A0 21424=C2=A0=C2=A0 1980=C2=A0=C2=A0 1772 R 50.00 0.012=C2=A0=C2=A0 0=
:29.20 3 tbench
> > =C2=A04408 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0 0=C2=A0=
=C2=A0=C2=A0 4720=C2=A0=C2=A0=C2=A0 124=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 R =
50.00 0.001=C2=A0=C2=A0 0:28.76 3 tbench_srv
>
> What is the difference between these first two?=C2=A0 The first is on
> separate cores so they don't interfere with each other? And the second i=
s
> pinned to the same core?

Yeah, see 'P'. Given CPU headroom, a tbench pair can consume ~107%.
They're not fully synchronous.. wouldn't be relevant here/now if they
were :)

> > Note what happens to the lighter tbench_srv. Consuming red hot L2 data=
,
> > it can utilize a full 50%, but it must first preempt wide bottom buddy=
.
> >
>
> We've got "light" and "wide" here which is a bit mixed metaphorically
> :)

Wide, skinny, feather-weight or lard-ball, they all work for me.

> So here CFS is letting the wakee preempt the waker and providing pretty
> equal fairness. And hot l2 caching is masking the assymmetry.

No, it's way simpler: preemption slices through the only thing it can
slice through, the post wakeup concurrent bits.. that otherwise sits
directly in the communication stream as a lump of latency in a latency
bound operation.

>
> With wakeup preemption off it doesn't help in my case. I was thinking
> maybe the preemption was preventing some batching of IO completions
> or
> initiations. But that was wrong it seems.

Dunno.

> Does it also possibly make wakeup migration less likely and thus increas=
e
> stacking?

The buddy being preempted certainly won't be wakeup migrated, because
it won't sleep. Two very sleepy tasks when bw constrained becomes one
100% hog and one 99.99% hog when CPU constrained.

> > Bottom line, box full of 1:1 buddies pairing up and stacking in L2.
> >
> > tbench 8
> > 6.1.114-cfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3674.37 MB/sec
> > 6.1.114-eevdf=C2=A0=C2=A0=C2=A0 3505.25 MB/sec -delay_dequeue
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 3701.66 MB/sec +delay_dequeue
> >
> > For tbench, preemption =3D shorter turnaround =3D higher throughput.
>
> So here you have a benchmark that gets a ~5% boost from
> delayed_dequeue.
>
> But I've got one that get's a 20% penalty so I'm not exactly sure what
> to make of that. Clearly FIO does not have the same pattern as tbench.

There are basically two options in sched-land, shave fastpath cycles,
or some variant of Rob Peter to pay Paul ;-)

	-Mike

