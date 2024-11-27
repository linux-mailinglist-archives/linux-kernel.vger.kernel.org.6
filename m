Return-Path: <linux-kernel+bounces-423563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6109DA9BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E6C281427
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABADC1FE45C;
	Wed, 27 Nov 2024 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="edo29WYP"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E941FE454
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716846; cv=none; b=EZkqzgm6tA/NRaGyMI2lZdA6dgT59CPreBpc7r8abi017l9snOKqwD2Jz7cDTphJgTs89Tjzu7mIPY1vG+CzJJrndfAWA2srYISxOolRvg8JmBUkbz+6OWtUDD20/wvxNcCkPX809RJDQlKuq4Wzl0+A0nN/2LXM2zHpXT6ws98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716846; c=relaxed/simple;
	bh=Vq7QT4QsAvwJxmY55eFnZnURaPOuS9+tv5E+Yd1/KYA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNASw0CNq8PRzkHz8U5QX460IfFGGP82Buua+KirzKQLMXgq4acEbBV5f+lNTA7uHU5t+yQpOsz9QaIONNp8pLB7JzjD04wXFAjVUTHOiiTHqVqAKMc/SaubwW4JcXWBCFU5Leq4HQs1hq2DJHGa0v0kS/M7ijW6J9+9Tf6q0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=edo29WYP; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732716805; x=1733321605; i=efault@gmx.de;
	bh=dG0OGVq6BznzDuky65ViZEvI3WCYLTbLRcimsAZ/wGw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=edo29WYPgC/snsnVMp7ZAd37PprwlmnxqxIMgxU/YpIrUTTVplpb5fVo4lf5dPnM
	 pzKHy3VQztGZ/5h2dM/d6D8+2AccMqBYshdL0ipeMhoMuK66GFAB3SPq4vGZjUNmb
	 AnccsmrNAVvsjz82w37r7gnp1cYp7VVk/20O+hjv4RBWkEcEJoQ270FoSNGF6+0nB
	 3PFW56OVrfDINvDYxo/krIp8aRk+HQXnNkVBdoWYjG8Tr5ijYd5mpmWWEKioZ9ayV
	 LGbjqTe19vhejtpNziA+qTdIsGmipq0i5aLtgRgrZrh8i6ATP9UV9w/gR5gpDZVkQ
	 KtTMh22MvqybaUifug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.163]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatVh-1tr0OM2kOJ-00mGOG; Wed, 27
 Nov 2024 15:13:25 +0100
Message-ID: <ce23f09226a7240d4f15b378959c9db9bc5e466f.camel@gmx.de>
Subject: Re: [PATCH V2] sched/fair: Dequeue sched_delayed tasks when waking
 to a busy CPU
From: Mike Galbraith <efault@gmx.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com,  youssefesmat@chromium.org, tglx@linutronix.de
Date: Wed, 27 Nov 2024 15:13:22 +0100
In-Reply-To: <924b853c01a5466c0bebe3bd324c46e9980dba1c.camel@gmx.de>
References: <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
	 <20241112124117.GA336451@pauld.westford.csb>
	 <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
	 <20241112154140.GC336451@pauld.westford.csb>
	 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
	 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
	 <20241114112854.GA471026@pauld.westford.csb>
	 <20241119113016.GB66918@pauld.westford.csb>
	 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
	 <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
	 <20241121115628.GB394828@pauld.westford.csb>
	 <bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de>
	 <8df808ca-186d-41f8-845c-c42fd2fd4d45@amd.com>
	 <924b853c01a5466c0bebe3bd324c46e9980dba1c.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gEaubDJZTjYj7nH+N+p+PG0I9zk9P5rznaBu8XGaU3Q7oHk+xIQ
 fyKC+mdXhrpjqc5e4WGHqix0W2bFZb8CMeaV6Ctdv/C5hhS3FWQlsWxuAZYBe38o4w51juY
 yfJur3w99eqAWPH7pe3TcNRdw66PTfSqQ1CLJnPPJF/q4xbFu8DCh6Nz3bFOz4d8zsj+9TS
 JIabNik8vf2iKQWo58lPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LN/GC7rd3FI=;gqAvbo2Tc2Z9eO9H6NcECBqJp0Q
 6iITHxSvIE2ly2GmwbcIIzCM3wbwhW7xcDbXLD8JwimrSibTWK49TwLpcHhbp26RN1i4yV7Aj
 XB9FTGy5IaBdCmdvE9+w5D+HmVh5l+CKzRpeDYgalETW994cln5A8SKfJHBxLq9qkbDLD0E6F
 p4XfSgHnGK7VhllFfIwoJfaUWp1tbAk37a4W24Ljcu7WckynrYtAJ+295v+2utIip6mVWN2ol
 H+fNszF3yoX5eoOk2VfymyzSPUH7HAn+ARzvUkRYxonccB8CVcOnd1qcv8IHLgW3T2a/tRL31
 vCOZW2EDL1SskTdY8ylBrnRKb34AsSj0cG8+4YBsjz4H5G7rUV1zFNJogk/Pi4rPK08Bh2FPb
 V/B7XybbFsZ7FgVhW2gvAxvq1gy/WM3nr/R27q9ADkQ+e7bQG1lM8kkwgp+o+OBK5+OZeJBUe
 ggrZgqC8+5EWw8Iecxz34p72r11fCRVkl1GumFrCzuohoalzeJcPnGgAqVY2xtWOR+IeayH+Y
 4PegcHqRT5zQsjoOQePfqUM+nQpTE4XLRl8ixwa7TGvPmZt/vO+3i5OtJ5AFTQRxqEZirTISD
 0p6pdMjqRm9gy/O7HnC7BsdjCy70Ll/6cgkLYN1XARc8rsFbb8MmcF4ouMCA6+RIJIf//XUW+
 qUG7Mc5QUi6UgX8Zo2s0CBrnz1WWmokG51cPbn9j4csJBdQ4NEycuzPa9pufRL0SYBqd8b81k
 U3Ek2jdvonzz9jQQGwDVeOn3Kno2E3Kqt1zQC9SWEZO7mpD5+3jSDexyog2MRAf1ZzJRZKdUR
 W4A80cbxpzsrWS4ZmbpyoxB/o5IycRedDplVGKzjKKOmX9KmSwAJzuiBcTYfVpgNRGa2CmHBK
 KihbruhW1oOyRAkws9Ikjg1D7t8EyeedGv50wV+VJbHcDhaxXJZLZ1fO+EcomK3jHxkBlB6Mi
 pwXljBE1gp4oCArZcEcIoaD9ERtJEbycXAuiRNVzbloaz2dHFyrvt11GFp7IJ4GaK31l5rRZa
 cIU3uPXd3PqCN/luo2Kzd753VHbda+5xtnjV2eheMZO2y044sRHuHUeAi9LZLlPt3Np/doHf2
 GvN56TH7KQwWC94maWbYfzCYVCumif

On Tue, 2024-11-26 at 07:30 +0100, Mike Galbraith wrote:
>
> The intent is to blunt the instrument a bit. Paul should have a highly
> active interrupt source, which will give wakeup credit to whatever is
> sitting on that CPU, breaking 1:1 connections.. a little bit.=C2=A0=C2=
=A0 That's
> why it still migrates tbench buddies, but NOT at a rate that turns a
> tbench progression into a new low regression.

BTW, the reason for the tbench wreckage being so bad is that when the
box is near saturation, not only are a portion of the surviving
sched_delayed tasks affine wakeups (always the optimal configuration
for this fast mover cliebt/server pair in an L3 equipped box), they are
exclusively affine wakeups.  That is most definitely gonna hurt.

When saturating that becomes the best option for a lot of client/server
pairs, even those with a lot of concurrency.  Turning them loose to
migrate at that time is far more likely than not to hurt a LOT, so V1
was doomed.

> The hope is that the
> load shift caused by that active interrupt source is enough to give
> Paul's regression some of the help it demonstrated wanting, without the
> collateral damage.=C2=A0 It might now be so weak as to not meet the
> "meaningful" in my question, in which case it lands on the ginormous
> pile of meh, sorta works, but why would anyone care.

In my IO challenged box, patch is useless to fio, nothing can help a
load where all of the IO action, and wimpy action at that, is nailed to
one CPU.  I can see it helping other latency sensitive stuff, like say
1:N mother of all work and/or control threads (and ilk), but if Phil's
problematic box looks anything like this box.. nah, it's a long reach.

	-Mike

