Return-Path: <linux-kernel+bounces-181182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D139A8C7896
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D531282398
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4855F14B969;
	Thu, 16 May 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HUIO5xnN"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46314B953
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715870712; cv=none; b=pLbKqtycosJMdumTzqjoeQ6yAv12vCyv965qn6fJPi+EWFt83B1Gw3l07LHcDVsE6RSlnfNnmP8D9hB+NE5/33YaEe17WrOf8k2AyYA+yvRlPVPnlwU69sewT1zQRBaR1dSr2yATZp0mJpwFtNR+D/wsbrkYehbniy+vioQUdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715870712; c=relaxed/simple;
	bh=JQZdtMNm8O4ILInqWhUVJgfAfhOlp1l0sDkc1aodMQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKQGXASU42kfw55iaQeHHA23qIFv9hOmo8LroV3biJAbokLovc/aEUVfkBoxAUrNIcAiU+RHvDCupst/kkIa6WBN/DOQdf6MBoBnvhlJyRmRBekRSn3TYNGJMN3UH0AoJy6Z0LrwmxjYZeC6WALMe/ucVqO4dNExm1ZMZmTdqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HUIO5xnN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y3RqHI+RkENCx1PTZybupuoC5xt7sc03nLZSDWaMySk=; b=HUIO5xnNedUlC5ZfwtX8UuiiWg
	SjmIEf47OEsaV5G4Ryq5zBILXcx7NXRPhsQKyPLy00oDu7Kd9nd7klmOFW9C5FFxR6j4v/0rI/J1C
	l4IxlJrZHKKAnKckkAbURbGSnVXB/+/MBDa3CiqREqvWogt152aTTStJkbiu+HjUAasv79fCVNa7h
	u0O9aczSNzRcquajOo6uAhARV7VANYY9g+orD1oUf8qEcMPUT8Us8FOberDnrIYwRUl7RZ2/sI7I/
	zLYy1IHIBMWOkX88TW7s2T/k1O6ftXytrui6VmeoNpiI3eDQ5wkOUOz1Y9+u+36u2Z61T/APZuhTk
	8g0YfPeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7cLw-0000000BtXY-26pC;
	Thu, 16 May 2024 14:45:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2692F30068B; Thu, 16 May 2024 16:45:04 +0200 (CEST)
Date: Thu, 16 May 2024 16:45:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Yun Levi <ppbuk5246@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
Message-ID: <20240516144504.GL22557@noisy.programming.kicks-ass.net>
References: <20240508172621.30069-1-ppbuk5246@gmail.com>
 <20240509092931.35209-2-ppbuk5246@gmail.com>
 <ZkU8lm2tjm_r9FpZ@pavilion.home>
 <20240516075628.GC22557@noisy.programming.kicks-ass.net>
 <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>
 <20240516084911.GF22557@noisy.programming.kicks-ass.net>
 <ZkXtHv+fHUD2+lFJ@lothringen>
 <CAM7-yPTSq0CSmRsTpeXwzhFk77gfwUK_LZKnbgo4NPk5zPCaAg@mail.gmail.com>
 <20240516140003.GJ22557@noisy.programming.kicks-ass.net>
 <ZkYW48dTX2FH5NaD@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkYW48dTX2FH5NaD@lothringen>

On Thu, May 16, 2024 at 04:23:31PM +0200, Frederic Weisbecker wrote:
> On Thu, May 16, 2024 at 04:00:03PM +0200, Peter Zijlstra wrote:
> > > If I make you annoyed I'm sorry in advance but let me clarify please.
> > > 
> > > 1. In case of none-HK-TICK-housekeeping cpu (a.k.a nohz_full cpu),
> > >     It should be on the null_domain. right?
> > > 
> > > 2. If (1) is true, when none-HK-TICK is set, should it set none-HK-DOMAIN
> > >     to prevent on any sched_domain (cpusets filter out none-HK-DOMAIN cpu)?
> > > 
> > > 3. If (1) is true, Is HK_SCHED still necessary? There seems to be no use case
> > >     and the check for this can be replaced by on_null_domain().
> > 
> > I've no idea about all those HK knobs, it's all insane if you ask me.
> > 
> > Frederic, afaict all the HK_ goo in kernel/sched/fair.c is total
> > nonsense, can you please explain?
> 
> Yes. Lemme unearth this patch:
> https://lore.kernel.org/all/20230203232409.163847-2-frederic@kernel.org/

AFAICT we need more cleanups.

> Because all we need now is:
> 
> _ HK_TYPE_KERNEL_NOISE: nohz_full= or isolcpus=nohz
> _ HK_TYPE_DOMAIN: isolcpus=domain (or classic isolcpus= alone)

What does this do?

> _ HK_TYPE_MANAGED_IRQ: isolcpus=managed_irq
> 
> And that's it. Then let's remove HK_TYPE_SCHED that is unused. And then
> lemme comment the HK_TYPE_* uses within sched/* within the same
> patchset.

Please, I find this MISC and DOMAIN stuff confusing, wth does it do? It
can't possibly be right.

> Just a question, correct me if I'm wrong, we don't want nohz_full= to ever
> take the idle load balancer duty (this is what HK_TYPE_MISC prevents in
> find_new_ilb) because the nohz_full CPU going back to userspace concurrently
> doesn't want to be disturbed by a loose IPI telling it to do idle balancing. But
> we still want nohz_full CPUs to be part of nohz.idle_cpus_mask so that the
> idle balancing can be performed on them by a non isolated CPU. Right?

I'm confused, none of that makes sense. If you're part of a
load-balancer, you're part of a load-balancer, no ifs buts or other
nonsense.

idle load balancer is no different from regular load balancing.

Fundamentally, you can't disable the tick if you're part of a
load-balance group, the load-balancer needs the tick.

The only possible way to use nohz_full is to not be part of a
load-balancer, and the only way that is so is by having (lots of) single
CPU partitions.


