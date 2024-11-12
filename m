Return-Path: <linux-kernel+bounces-406298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B559C5CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09093283A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79C02038B0;
	Tue, 12 Nov 2024 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="OkZ5DOSK"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D84200C82
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428219; cv=none; b=SePSf+NLDDyGiU1HVY08LNYwhlrR9qz2XDVu4esdKGsTmWKgeeC5XgHWdPvgM9Rw5JzqrpNfJU+fAnhINwhLrjuZPIjRTQRa/c4b1/PqwQvpQIJyUEQyFdb0WtpkkHo25nHMhNgC68Hs5ixNU5G4vykNGgq71758v6WIYyGbO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428219; c=relaxed/simple;
	bh=BYW072B3wDpvrg96Mn1tM70ALM8waeDaFtOv8qmdLh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Obtv6rYbfI+5BgVvl1V92+j8CPWGf2Lq7XbqqdxAbJJQT4So5ezN+Q1B6ZEDk1aORG0oKENnbxwB0PZ6SZYUBkNFohdJEjSn0oxTPo/PlQgeg1xc1W52rRriVGli3zpm4bjdgfhGwnPjaMwaye1uNoCoSAYZZZXileWfzTlvVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=OkZ5DOSK; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731428154; x=1732032954; i=efault@gmx.de;
	bh=Zll++XL44uGRh19iorKkkF7dCWt41He2IOpRSD07ArY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OkZ5DOSKTo6KwX5Xj7Zt2Kcx2sPnRNcPp6HnL0n15Urs3dY0ku0aWlaXzTJ4FWDv
	 qyf4k3OYrxkamoPtwzk73CbEHSGJIlLHl1lZBVbRQv5Xl9dBBOGMhooWKlVwxp4RS
	 T8l2rAQzJ7VgCMZ95anVC/tMTn0S81YJy3xt1t2uFMB/QCETtFD9BeU3hXOfpVeMa
	 O8V5QJH1hgPbHYgREJPNXkEeU6TIEMEcR6SAHRiJ0hSrXlw3q7dP85wrrZHtzzker
	 lbNfH6PQXdvAZpIP8u/Xh/o+C07YLVsCTeVBRsvIzWryGPGVAmKC11sj2qp7dQYfc
	 HojSpoO/h49mKHa4Rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.232]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ3n-1tFzhP0ka5-00T1oT; Tue, 12
 Nov 2024 17:15:54 +0100
Message-ID: <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
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
Date: Tue, 12 Nov 2024 17:15:51 +0100
In-Reply-To: <20241112154140.GC336451@pauld.westford.csb>
References: <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
	 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
	 <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
	 <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
	 <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
	 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
	 <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
	 <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
	 <20241112124117.GA336451@pauld.westford.csb>
	 <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
	 <20241112154140.GC336451@pauld.westford.csb>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yZYhq2+kGB4wn3Xt0LA8n1sN9GAU/bWrvJEehX37U6osEddnL+b
 d72/q7jXnjf+YWyLMB4+VxCwC9OBhUZv1SPiE7lhDbp5PtQtIJFL+MDSJluy4UYxFUQ/1OR
 2LGqOPAnLLraLz5wrdG+baKBEZXnwwo6fNiq8QjfTMoNpcaC7wknssStHMqFJRU62VcyxOY
 BsuQ4Mw/SEyLvozMz1E6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JkpH1JrOrPM=;BBEmlezRAiy6PPLPMG4N+f2kw0q
 k2RCG0EVF7yQV1YmEPs0FNB2blkbxx9kL7lPVhfVYYXi/xny1j/s0D+DuAo/uz4ArzAeWgMRQ
 YOssgYwNR6kg4US4gBly/GKKLgzc06uxuE8tEFY42RXGhnSzZeKbN2v8v70vV3sGXnSsPBcZH
 0TDffDzvmnL32XvCEG4Her/JdwnLe9CXuMUOaxI86k9xYrFG4S+LkowAhE2Ckhjp4Rjid88Am
 uO+cA6wqk5yIEor1ljwIWy9D9ZQucuiLhgmM8TGf4Wt4LQ+QMLg+Rb/n2DIjGpuco9plWdA7T
 pIymUGkKvcY4rk0u3jOlIQLPR/25/Ui+2jY41sL60MNj2YLyUEDMNfAYq4V8mIO460aZSyAPQ
 Aipim/eWVj5gQrhCvdoXeZcXqJm2ezWFAYf7Lr9giMlnbP+zMNshNIECkDiMpW6KB6DxTYkpK
 0GgDodH4ORiY4mY0kNvO3rPDrZJ0tCSRuwEam6+xSh4GxJf/HaTfc0yDaAJXmRUoOAlk5/MUZ
 Zd9c11f3EGBhdUmgnPvGUgPlDrf/YexXp66uUSSRyTgKMKPf2bmzCcN9REg9lieCMEOXyLbBR
 tKPBcAxrX8TefTYeDXlmj5MNRkpcE60QTQXeGt+lghXAnNi09LbxRiamEza4bizTbw2T/trnF
 EeO1M04G99i1VDtx0yldEGYnmIPQv6Q36+12jcZxvY7arxjo4Y6pGtD+GIqXtunwRDfn0qu5Z
 NM6Pr5YuYhyljIHikjz6x5qBGvrW1rxLQVj/UkzZvEFJNLn8z+6h7G+F5yLlDXsJCS2OwCdgO
 rOssRNVPGiA/T/Y1in5dsTZQ==

On Tue, 2024-11-12 at 10:41 -0500, Phil Auld wrote:
> On Tue, Nov 12, 2024 at 03:23:38PM +0100 Mike Galbraith wrote:
>
> >
> > We don't however have to let sched_delayed block SIS though.=C2=A0 Ren=
dering
> > them transparent in idle_cpu() did NOT wreck the progression, so
> > maaaybe could help your regression.
> >
>
> You mean something like:
>
> if (rq->nr_running > rq->h_nr_delayed)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>
> in idle_cpu() instead of the straight rq->nr_running check?

Yeah, close enough.


	-Mike

