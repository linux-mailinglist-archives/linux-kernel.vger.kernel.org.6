Return-Path: <linux-kernel+bounces-416215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F439D421D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89DC1F22CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8B91A0BDC;
	Wed, 20 Nov 2024 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="eDumvWdq"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818A215747D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127911; cv=none; b=aIOhiSNTwlXtXAkZnVR5wqKzrqkPdMYVUo/gDQE+Lzv+Mg/NwX23UV8DzfavHQyWZqxllv+CsHtOqRjVwd7CDcYdVH/m31q1W/rlF9qnEzttNUrbT3YZQWKwL43JbK2Tx3Cxs7fJhCe7KAkR2MG5KZN231IcrdvtlBqJWFZG3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127911; c=relaxed/simple;
	bh=T6d8sk8kGrQZjM1qvOIwDX39pdFYkEJhoVEdDrTs/pY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lq5as/jSdKjX/mzUUvAGDRPjab+BCA6jpfZ1aOoatZs+PCkPnAoMLK0gbyPOe+Y4e6vfZnaY01gFTBTwrxskr1iJFuHMuYExuLasqd/dB5BgIUj1tkt1UM1hA5YaHpjeFZfspesiIFpTB+ci/qZK7v1kCz54vzNsj3XMWzj5ZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=eDumvWdq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732127861; x=1732732661; i=efault@gmx.de;
	bh=NdExGZIL9ViZ59F1sDXr6yus2i3N675v6+zYamhAKE8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eDumvWdq3OnMkTr8XTTOTL42n0Nnut93l79Ad+3YRP7SB5prAqVYdbHuLNKS6pTN
	 MVecsCOeXTfj/6qveaSOdQoUDsDDPvycJv4lS9owxPsMRcoQg0zyQRBHzqSKcYJEf
	 /VA0mPgi18UVZl6TUH+7EpkFUb3hAQw/bhC4jvo3p5k8IEpl5cMSV964pv8VOnKHp
	 O9qFX56kfVIC+2bGjmscJSLXJed0MAFiSsinDJl7hiK2tA2jnfFEmGZtS/r/8q7US
	 KUmJm2f0egABFUOuRn/NO9EOFjH4iB865aIm9YdwlpeiFwSJAVov3qtwTBAHgfZIk
	 /a0Ct1o9SZ+NoGcYnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.176]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1twrow36OF-0142zo; Wed, 20
 Nov 2024 19:37:41 +0100
Message-ID: <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
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
Date: Wed, 20 Nov 2024 19:37:39 +0100
In-Reply-To: <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
References: <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
	 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
	 <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
	 <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
	 <20241112124117.GA336451@pauld.westford.csb>
	 <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
	 <20241112154140.GC336451@pauld.westford.csb>
	 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
	 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
	 <20241114112854.GA471026@pauld.westford.csb>
	 <20241119113016.GB66918@pauld.westford.csb>
	 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r5nLWB7bPE3DG/ABZlDMdrSXguakyOT/OecTPTvAopAFaaDhhq4
 Ld6XG9H6AFqiEQ6tKuSRVxYy9hTSN5SN02fCM/qbHok9vsvCSmV7NluvM+NPNwYbu6QS7YX
 IMFclqdXhzCxNGES0yIWUg3wOOsCKNLSChDdOlAbrcuPg7mV4q3sm9cybXyhZ5J5+ozBiBb
 FSTGcErhKISKTLOqmqqpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D6RtyeS2LGg=;WgMVuPtFjnSgYheJ5nzEpFLqxir
 SZJatDFiHsAGjsIaU/qR6kVo86PHO0fpfcLtJ9OegnVX/Off7RCOuUtRJuALSN7cWmf0pzmFE
 Ofnt96zdZpEhVp7x5f5aGnJ4gkBXL4K9XSpNn7lJzORZvRtwnvh1vNtULWwcZE91lwTf+oXsT
 vSnIaHwUn8Hc8Wi3zgGVKy1+khZ0PmVdUtp6afXCpNQvjCJZz7GRRKiOCVjXz/5/OLQGRRxsy
 tnyXfyQ3i9Nf8/a7uBwbPJ3Tk/LWwgwIFcDnXGi23lUWCvZ+760+pq6yts+1I7g4bzcdYwERJ
 VGacShuL0Q8XC8fsEtn/V0YhrHrZv+9uw0biQ1O6F+0k1T9iUNoiyqponstNURueIne7YYHIy
 ypl6dhsNrwKaBVIghBxjZbDPO4EqdfEXLU+MVa7VAb9vjaT1IP0Blg0IfnrhNg0GsVzLJowrV
 KC38CLWXbqx3srWVhi5vibpB4QqigHVNm0P3246mMfBGblnXkip0nAhDwKlwjB4x6469nb3c1
 H+aXs7YCijAyN8K9RGhRj9g4/5Dtf16apaSfoS/JOHq4iOYoRFQqTCILe2kSdY/KcjPyXVXvh
 OI2Qjvfw7cAi4gBFxpgTmbVuFMKzZpFkdnVjy7o5fQ5SN+cuPyWJ3Chdkhqlhi4dSd0lWH2Z0
 bhXHa1PnPLKDn8SxEMMeuIV+ZWz5fQ9HbwEXf2Bl5EpRJK3ntR3QtH/SnPMeaujNudGguWcQ1
 S8l9/G4q1pmq+P+YSkDy4CG1PRVqQmPsKuOGe6ksK8R6uQNtF0VdtZ15waJz5rGhDn+jBzb3e
 JJiMZ2alSdyvSmPGOtim0SdoKOsAFKawt8dbhC3QU0KX63NP5qpALheRSk9lXFu6vdBKl86X1
 k2oCRCu6t7FTszsqZZoFdJuKhajoPB7J+F7x+W4aQ49Q75i6Gh78fpHjn

On Tue, 2024-11-19 at 12:51 +0100, Mike Galbraith wrote:
> On Tue, 2024-11-19 at 06:30 -0500, Phil Auld wrote:
> >
> > This, below, by itself, did not do help and caused a small slowdown on=
 some
> > other tests.=C2=A0 Did this need to be on top of the wakeup change?
>
> No, that made a mess.

Rashly speculating that turning mobile kthread component loose is what
helped your write regression...

You could try adding (p->flags & PF_KTHREAD) to the wakeup patch to
only turn hard working kthreads loose to try to dodge service latency.
Seems unlikely wakeup frequency * instances would combine to shred fio
the way turning tbench loose did.

	-Mike

