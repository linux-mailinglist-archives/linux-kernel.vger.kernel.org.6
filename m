Return-Path: <linux-kernel+bounces-181141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE02C8C7822
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392B81F21D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A44A1482F0;
	Thu, 16 May 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FiU1fX0M"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378794206C
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868018; cv=none; b=UwSl+birF0u1icODVt9vyfOC8+0Ug1h0F4yMSpTuM8Xzk1CtM1nzWOxS/oUN7feGRLgCz7lF2zVA7Tn7MaFwbOrxj6kMwKvvOtPZFIuzSlZrAL5UH/d+u2+Exk8XOL1omg8ncdnbzWZRMIA+kYCeHKJ3eeBZ1lE+jlUiV7gk9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868018; c=relaxed/simple;
	bh=Z44HfOis4I3fdlPx4U47pPmt0zhFLMa/0hoq6Xx5TFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnUwcm5yi6Ipc4dj5x9l8DuFQwPHTwMdB+9JbCAYo8LmM8T1FzTXzFYJIc6RqXFTZktucwp+w8WP6sHuWC51OEdLNmfFxhaG6tk4o9+2qBCrvr/sNW3hnZBKdY1dIQ+XQYw4No3CsH8Rt/Wp8JyJzYvbV7uvQyxij3JS6YFxYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FiU1fX0M; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xXfXkL4WuKhoAECAIFlizwdWFgytCe7hv/faaiB5gWc=; b=FiU1fX0MVFSsyXu1ypcgj9/YWV
	8pp179aO6Hzq1tPnkozqLuLoh0n0sq6PVHl9GpvS63qT+cxp1CCUm9GBZ30HSXp43HcEJUdKTCLH1
	rjJwf1m8+SUZA+bQyLuDU7rUX6tAW4wVHEbJIMW2DtWQgGEzEfZKgKmXLVWagydU8TP8oqcMaH/At
	am9v2GMHJ01lPmzjS0Pwp//K86x4I7PGxiPKHKBCS8ZnumAY9820qSK42HqD+ApPNGbfQ18LtT+ZQ
	tymC/j4y/yoPPvQ7/x1VEvv4RpbahpIrsEMu/tD0exUa0pFiTuSUT9WN4phnfVTXcdxHqF0fawoJB
	5jl9ybfA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7beQ-00000005Rdm-46ZU;
	Thu, 16 May 2024 14:00:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F3B6730068B; Thu, 16 May 2024 16:00:03 +0200 (CEST)
Date: Thu, 16 May 2024 16:00:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yun Levi <ppbuk5246@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
Message-ID: <20240516140003.GJ22557@noisy.programming.kicks-ass.net>
References: <20240508172621.30069-1-ppbuk5246@gmail.com>
 <20240509092931.35209-2-ppbuk5246@gmail.com>
 <ZkU8lm2tjm_r9FpZ@pavilion.home>
 <20240516075628.GC22557@noisy.programming.kicks-ass.net>
 <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>
 <20240516084911.GF22557@noisy.programming.kicks-ass.net>
 <ZkXtHv+fHUD2+lFJ@lothringen>
 <CAM7-yPTSq0CSmRsTpeXwzhFk77gfwUK_LZKnbgo4NPk5zPCaAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPTSq0CSmRsTpeXwzhFk77gfwUK_LZKnbgo4NPk5zPCaAg@mail.gmail.com>

On Thu, May 16, 2024 at 01:43:49PM +0100, Yun Levi wrote:
> > > > > As such, I don't think the HK_TYPE_SCHED check in
> > > > > nohz_balance_enter_idle() actually makes sense, the on_null_omain()
> > > > > check a little below that should already take care of things, no?
> > > >
> > > > IIUC,
> > > > currently, whether cpu belongs on domain or null is determined by
> > > > HK_DOMAIN_FLAGS
> > >
> > > No! you can create NULL domains without any of the HK nonsense. Both
> > > isolcpus and cpusets can create single CPU partitions.
> 
> Yes. However what I said, nohz_full cpu isn't on null_domain
> unless it was configured by cpusets.
> even with option "nohz_full="

So if a CPU isn't isolated, either by isolcpus or cpusets, you get to
participate in load-balancing -- end of story.

> > > > However, when "nohz_full=" is used, it still on HK_DOMAIN, so it
> > > > belongs to sched_domain
> > > > so, it couldn't be filtered out by on_null_domain().
> > > >
> > > > unless "isolcpus=domain" or "isolcpus={cpu_list}", it's on null domain.
> > > > with "isolcpus=tick", it participates sched_domain.
> > >
> > > Frederic ?!? You can use nohz_full without isolcpus? That makes no
> > > sense. If you do that you get to keep the pieces.
> >
> > I fear you can yes, even though most users combine it with isolcpus. I
> > know, that interface is terrible but it dates from times when we weren't
> > sure about all the potential usecases of nohz_full. There was a possibility
> > that HPC could just want to reduce ticks without all the hard and costly
> > isolation around. But all the usecases I have witnessed so far in ten years
> > involved wanting 0 noise after all...
> 
> 
> If I make you annoyed I'm sorry in advance but let me clarify please.
> 
> 1. In case of none-HK-TICK-housekeeping cpu (a.k.a nohz_full cpu),
>     It should be on the null_domain. right?
> 
> 2. If (1) is true, when none-HK-TICK is set, should it set none-HK-DOMAIN
>     to prevent on any sched_domain (cpusets filter out none-HK-DOMAIN cpu)?
> 
> 3. If (1) is true, Is HK_SCHED still necessary? There seems to be no use case
>     and the check for this can be replaced by on_null_domain().

I've no idea about all those HK knobs, it's all insane if you ask me.

Frederic, afaict all the HK_ goo in kernel/sched/fair.c is total
nonsense, can you please explain?

If the CPU participates in load-balancing, it gets to fully participate.
If you want to get out of load-balancing, you get single CPU partitions.

