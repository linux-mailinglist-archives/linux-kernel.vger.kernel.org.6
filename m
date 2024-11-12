Return-Path: <linux-kernel+bounces-406039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89619C5C11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF4DB27B65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0911FF03F;
	Tue, 12 Nov 2024 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="QbaZwGO8"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928581FCC54
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421457; cv=none; b=eug8PqMEtP4YIAYLnFwFzKLNgShKlBtHLzzOXQ51w3tmkdf9lnueTnA0BToKg846tWUpA1hZQg8CYGhHsQlfe4xvUZbfIYwWoQnTGKTHikbmWwC0gEnPqNpaN99z+6DA7P1HA+E/lPbQ46Qvr5BgXM+XXYKtlXjO+RS1NaD9AV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421457; c=relaxed/simple;
	bh=QzCG/6Rt2G4J2/8MNNsK+LpwjMfdMe/9IaATfuKAJ1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smGi0V4HFGB5SrMpvt4uLVNZUUX9HlWlb8QgEgOIVY7IHcHqkeTTmQ7LDHk8xiXHSH6AX0CQGzfNHhR9VIzJAzVdGkxPa16r2WxVl79oUXMi9OUfnq/YfDirc7GwfSJO7i8GvCMnYsgYMjpi/KTQGJ+1TdC58V4XNH942QLHj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=QbaZwGO8; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731421420; x=1732026220; i=efault@gmx.de;
	bh=BdVz1kuzi+g58QOGLN5fWtAO1YSGz6hw9+NooswMTss=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QbaZwGO8xMsXa/p/iBP3ESCahqz3uhRxV46nYpAcjMj34KrCu0kbcm+GSEBWHxxK
	 4qWHonbBokOUUQhl2AYSHILVGRqqPy8V7M23S1XwnZZe1WMTXvv7wrVL85Ik4UK49
	 s1uwnUEkdH3VYKBbUWQrr0JZ2wrhCEY/QYzmlIh5jkB2cHqpy0BWWEgYTQbMYG8Rj
	 M/Ivg1TtsxiMynDSPanbzozVOPJftTvqu/h1jwnrVhrrMoWFG05BrVMJ5ISNAgV34
	 +PLsJWXgmbHN4xwQ174o9lAM8kGTQPhqhIvjOK1F4TReWuCh75KnDr21PngmJCojq
	 R+wn6eBsxIs4CPkScw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.232]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1t226F3tUO-00GhmB; Tue, 12
 Nov 2024 15:23:40 +0100
Message-ID: <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: Dequeue sched_delayed tasks when waking to
 a busy CPU
From: Mike Galbraith <efault@gmx.de>
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, 
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Tue, 12 Nov 2024 15:23:38 +0100
In-Reply-To: <20241112124117.GA336451@pauld.westford.csb>
References: <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
	 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
	 <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
	 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
	 <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
	 <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
	 <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
	 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
	 <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
	 <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
	 <20241112124117.GA336451@pauld.westford.csb>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vLyVbvikXdFW7tVT0lBPEYWTrrca9DEtWzGPAY5jm5yG5MZVVl1
 jvhqfqVDeVanb/1N/4d81zMVeSphJHVhXdJmcU4DBRPQKvHFN5IFBv7DQ8+O7QVDYhZkKOf
 OQlMlm0Il9JrrhYLYkY4HU/O2SOwAhZQnU8ir9oP7fAKUVhm94EXN/BTvEx1+cUi6P3bVU1
 MyhZM0ThAIQ2MpzioqzUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nYeXepgqF8s=;ekpmLDz7a07hOHm/fBvi8NcTPxF
 OtmhepFbttINn2ArgZHE9KhEn5z9gGdQ06ac08tVSHwbXrtYevTcmnNAL745rkARybJ03a0Fo
 PAVo5gQnmMUZ1a0YBPIcVp+11ghzCMThtSnJ22vpkoWSaQ12ygCdvxjU1IIUVeigIautkqXqA
 3YU2kUS9CHb+uBlfpVaUXa/fo4wSUAHgLgfHmz/NTBmf/a4B5OiZn+2CZGnqH0PWDDnjhk93A
 hreAYz+agSzOBZFnVllqAUszFA0X8bXg+kugn1oAeE8UKZVMKnCO1iNnKpuR4URoCGqDyC1Jc
 AL/uNahDJQzTPGG85zxwEPr4PbB9ISrotmyXJTFqp/mmy/ZIVhKkKX4Vy8KCb+evZom1RxD+g
 R/KaCTJ6FDaIyxP+iiiim1CfDMdi2npVEn8O8s+GCrq4wxYQ4ylHbeMxCsnPHe1lcTKvlQiGd
 DgW+iAYjE7huQKS/FSSt9eNYo16D0oQs1sTAvIQckdU6xCiK989qoAwl+2sKxtqfEVJgcSa8b
 54epUoLnUYkXdIPi4wL8xJQG3/yiGIaZCir37SovMYORt/FZx6r7pQLIzRo8OVTOHup2PmGCJ
 QFz2nPgZQj818KS7fJbG80ji4wfHXyxfWTV3c3PuOmDkPrCANPNB0Hk6SNSHIsm4oPEGtBBOA
 CbKHlDGb3MgmIGzFrV7eIMJOOxdpLFL0/p0DszPxW1K54oQLhdnoGsXc0bQ5X3WCURQsCIOL3
 t8LUOMtAxw5YRcXu6SbbnVvqReu95bAr5YPMbJN/5GyLjlJyxbAAoOxVePqZZ0D4Gof4wH3y/
 S+2uOxk4L3O4DmQgJ5tdBz+w==

On Tue, 2024-11-12 at 07:41 -0500, Phil Auld wrote:
> On Tue, Nov 12, 2024 at 08:05:04AM +0100 Mike Galbraith wrote:
> >
> > Unfortunate change log place holder below aside, I think this patch ma=
y
> > need to be yanked as trading one not readily repeatable regression for
> > at least one that definitely is, and likely multiple others.
> >
> > (adds knob)
> >
>
> Yes, I ws just coming here to reply. I have the results from the first
> version of the patch (I don't think the later one fundemtally changed
> enough that it will matter but those results are still pending).
>
> Not entirely surprisingly we've traded a ~10% rand write regression for
> 5-10% rand read regression. This makes sense to me since the reads are
> more likely to be synchronous and thus be more buddy-like and benefit
> from flipping back and forth on the same cpu.=C2=A0

Ok, that would seem to second "shoot it".

> I'd probably have to take the reads over the writes in such a trade off =
:)
>
> > tbench 8
> >
> > NO_MIGRATE_DELAYED=C2=A0=C2=A0=C2=A0 3613.49 MB/sec
> > MIGRATE_DELAYED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3145.59 MB/sec
> > NO_DELAY_DEQUEUE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3355.42 MB/sec
> >
> > First line is DELAY_DEQUEUE restoring pre-EEVDF tbench throughput as
> > I've mentioned it doing, but $subject promptly did away with that and
> > then some.
> >
>
> Yep, that's not pretty.

Yeah, not to mention annoying.

I get the "adds bounce cache pain" aspect, but not why pre-EEVDF
wouldn't be just as heavily affected, it having nothing blocking high
frequency migration (the eternal scheduler boogieman:).

Bottom line would appear to be that these survivors should be left
where they ended up, either due to LB or more likely bog standard
prev_cpu locality, for they are part and parcel of a progression.

> > I thought I might be able to do away with the reservation like side
> > effect of DELAY_DEQUEUE by borrowing h_nr_delayed from...
> >
> > =C2=A0=C2=A0=C2=A0=C2=A0 sched/eevdf: More PELT vs DELAYED_DEQUEUE
> >
> > ...for cgroups free test config, but Q/D poke at idle_cpu() helped not
> > at all.

We don't however have to let sched_delayed block SIS though.  Rendering
them transparent in idle_cpu() did NOT wreck the progression, so
maaaybe could help your regression.

> I wonder if the last_wakee stuff could be leveraged here (an idle though=
t,
> so to speak). Haven't looked closely enough.

If you mean heuristics, the less of those we have, the better off we
are.. they _always_ find a way to embed their teeth in your backside.

	-Mike

