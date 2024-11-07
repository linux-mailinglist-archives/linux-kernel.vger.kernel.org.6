Return-Path: <linux-kernel+bounces-400059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ACB9C0859
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC37D1C229AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1A220EA45;
	Thu,  7 Nov 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="Ve0epk2G"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ACF17BB0D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988193; cv=none; b=s5BsybnxPoX8sttNGxxVY0pM6PIFwAErC+tJdOODvWU94PzkTPB/NpSFPkz4J+MlMwHfRU3+swnIEKGEjuMbRd9u/2L7OtSpH8NLWaJV5uYU35euN+2dDahBJSPLOfM2kvA5tUmY8iFj2v8q8UPeLaykyj3EkBRCUiDXzpmgQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988193; c=relaxed/simple;
	bh=Jl7oPD2Pe6uaTGiXUyxlHQyNIX6Nn9ZmlZRLbL/5RFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EnOj5u1oWMXesy8xlmvR06uVT4VjO92JPdEOUJ6WGb5xV4eh+hH/N9BZ0kiw9wnqXFxva4lBhtzpWGtgLv8xkDObMeelI1KzeHkQujaf8nARdhP26DU15azKA8QinlbpkXWIPdy/CvFn8Cgog9ZqBYaz6TTiCPeuf3uj+0Ln/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=Ve0epk2G; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730988158; x=1731592958; i=efault@gmx.de;
	bh=d9ao1YwTRKm2febZrvhpXWUNE+ABvv07mqqpLjvB3kA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ve0epk2GDTTw2shwdUns8Pl9PpW3umZj7I0b6aBEfXIqXLzo3rCUH1KDtPKzewMS
	 t6roQpJzK+nC5v6phdJqCfKkFIDSx/bg7e6sW86kjeiJJ7BBqR1C4uSdufCV72S1X
	 7/oTD/8Ds3YItzRXlXUiE+wa4ruDx0bV5dnW51kYgLNQzBwaJzVtnSE8n8BqPCzbj
	 EKJa9X0rp+b+aa+KH0l9QcTL4uXiSwx5l5arr94HEWZ6C9csYJO6r/HHcYBnloMZ/
	 SyW5XPmAiKVNPurh5rSQi//pTraWpFC/20F4q3iGkLpEOupvgF1dl4zz2uR4ynC2Y
	 cocVEseSj1BkzWnCHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.61]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1t0HeQ1GOO-00Ghpv; Thu, 07
 Nov 2024 15:02:38 +0100
Message-ID: <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,  youssefesmat@chromium.org, tglx@linutronix.de
Date: Thu, 07 Nov 2024 15:02:36 +0100
In-Reply-To: <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
References: <20241101125659.GY14555@noisy.programming.kicks-ass.net>
	 <20241101133822.GC689589@pauld.westford.csb>
	 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
	 <20241101144225.GD689589@pauld.westford.csb>
	 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
	 <20241101200704.GE689589@pauld.westford.csb>
	 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
	 <20241104130515.GB749675@pauld.westford.csb>
	 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
	 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
	 <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
	 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
	 <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
	 <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aTEMXL6B126cDDnTawJ8gG3Diyhw0YSNS21VkwJPbuVS+6eaSKD
 hW8JVm1IHMF+4KtvJw5TBFiRFDrO7i9BIQzk7OScZ0uoAKijBiIB2qrb82UkaB7PKcQZxzx
 WGoGF/XnTvor6frQdkcqyBSS1RYwB3tRtQ0xVPYpYRAkVjGfmAkJ6QVKCWA+4mLdUljz+Bm
 yvQtn8Rql+JaLcesyulTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pZT3Y43cZQk=;+gGxSuf2i0E71KLC4kn/x4rKC2+
 FLLWA0TjGb3Ma85mw9Rf7/WV9tftkfkSG+b2dNslXPMjKjxAFTFClW+yVe9cFFhARlCLacBfD
 s0RtD2gKVlI+aEsHSlbUwhmVlUHBh+J0W3P40Lhsy8Qzt+JGHIUWAc4m/7UTOlO+9d0uUY1P8
 SesFnJNpxhQRkFUZibI7YMHpbEMhJelF1b2KzxpqAC0TVv+WELg1rOIE0iP75/V4NJokeONII
 wqNv/8ZdaV1QLdPUFaVd6LT6QEvaLfySIEOPFhQLTVm0i3ToxXLyrBC6Cx6zdRJMPJYllVYR/
 MsFA9DEib2QrwnnsSYSHiwqA8vK0k++iFIQ8mn0S2mQZuS2TyNUV7NcJj6dUHPco7qe9gXD7l
 YwerOyT1KrDz2p0Tp7CHcbhr9z6pR+FmXC8NMrvcFecihkU+dMXl0cxtAY8uAE6yiyKUGboMy
 BbKCLhT0HnjfDLAyqvRTn+MRqiuSSTZxQLndGw5PTbJSYE58MpCkDWPFxRcIBWqjTWKAdHY7A
 Be/0gQdt0cY5mLRfw6/7rCIrNehOGK3GJSlyHqfmkiOmiG8JqhR2Pn2At2zyLwp/hR3loxRbZ
 F0sBIftopS2DS1pOBDhvhbrWoAUBwgLzbrOsjafWB0xfVUFPWgJSw5cPJ7yHuhfdgV2PVHev3
 x5i+pzzLz7XEZ8HsxXRx2RUGVmPmyLjuNQL9tTgdnD+2nxMn4rHsHGoh4s0k3+mbYdVL9mgVt
 dku9WsiMxiOD7vwOR5x08Sbu8sI4IKP3ooqkBN/qsRSS+U+2uiEn3kTERyl/mD+0lTFb66sOO
 Cd+80nJoAxQseA6ZrZgffOlA==

On Thu, 2024-11-07 at 10:46 +0100, Mike Galbraith wrote:
> On Thu, 2024-11-07 at 05:03 +0100, Mike Galbraith wrote:
> >
> > I built that patch out of curiosity, and yeah, set_next_task_fair()
> > finding a cfs_rq->curr ends play time pretty quickly.
>
> The below improved uptime, and trace_printk() says it's doing the
> intended, so I suppose I'll add a feature and see what falls out.

=46rom netperf, I got.. number tabulation practice.  Three runs of each
test with and without produced nothing but variance/noise.

	-Mike

