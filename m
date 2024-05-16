Return-Path: <linux-kernel+bounces-181167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF468C7862
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7826284CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F6314A088;
	Thu, 16 May 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmPDn6O9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDAC1474C6
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715869414; cv=none; b=APHzfpe0O9wUHDhD1zx0u5/MJZFU8rd3Rd2MOxOYCo+XQPXJVx7bgC9eQSg9lb6FYJ7JtXoofRWdOqzcz70XF7Dh5Rk+mKMZ/X7Rn4E8dggW5Otf+ZbN91vvjEhevzBaJIQbJuE2uzQmGO8yXvzoUz4CFmGC+vRCJT3iemOicV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715869414; c=relaxed/simple;
	bh=8fNegGSOeNs3leFAk+15asKlQPUrZveHOUDfXJ+0KZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTp0l8aflaM+PP1PhPBjV8AFUnXqsSyNHKFzf+SJpzIyJRTVJ99mdPy4YeRQ3RzpTN+/PKEp43GfcqHt53vGTXppHGbAQu/UySeYF1OHe/5tc7/vdsPfXyKfZPvuKO7EVq1K85VsgPxqGW6G7dO/GWcumSp3Qfx3Vys6K8Xe3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmPDn6O9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF14FC113CC;
	Thu, 16 May 2024 14:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715869414;
	bh=8fNegGSOeNs3leFAk+15asKlQPUrZveHOUDfXJ+0KZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmPDn6O9+rWX7Gdr8rt4wIBLOYlc4x+e4RfeLUvx5hcTf2h0H5wg7cEXlwgDSMQND
	 0HWPFq0OiTStpjcPlFaI8enotPGNPKVrs2JjvS39wxJ2Swbu1okOgcaeL4t3MVEc4K
	 nKgCN+ULp+pfDe1dXajkXUFdTCPNt2qLq14W6D9e9xG1eMI5Qxus0lqJy8QY9CBH0q
	 6hQ3U64b7FRPiFC1fNQXoOaoI+KstJpU3IzlnghN2zwJiuBNMzwebTUH8uXqEEARJe
	 sRNmzLymNkbcrNGBprf7CU/w2BNWHrKVG+2k8LGUsT2TsVMapHFdix2kHYMC0rAWit
	 M/vla6+goWeEg==
Date: Thu, 16 May 2024 16:23:31 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yun Levi <ppbuk5246@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
Message-ID: <ZkYW48dTX2FH5NaD@lothringen>
References: <20240508172621.30069-1-ppbuk5246@gmail.com>
 <20240509092931.35209-2-ppbuk5246@gmail.com>
 <ZkU8lm2tjm_r9FpZ@pavilion.home>
 <20240516075628.GC22557@noisy.programming.kicks-ass.net>
 <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>
 <20240516084911.GF22557@noisy.programming.kicks-ass.net>
 <ZkXtHv+fHUD2+lFJ@lothringen>
 <CAM7-yPTSq0CSmRsTpeXwzhFk77gfwUK_LZKnbgo4NPk5zPCaAg@mail.gmail.com>
 <20240516140003.GJ22557@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516140003.GJ22557@noisy.programming.kicks-ass.net>

On Thu, May 16, 2024 at 04:00:03PM +0200, Peter Zijlstra wrote:
> > If I make you annoyed I'm sorry in advance but let me clarify please.
> > 
> > 1. In case of none-HK-TICK-housekeeping cpu (a.k.a nohz_full cpu),
> >     It should be on the null_domain. right?
> > 
> > 2. If (1) is true, when none-HK-TICK is set, should it set none-HK-DOMAIN
> >     to prevent on any sched_domain (cpusets filter out none-HK-DOMAIN cpu)?
> > 
> > 3. If (1) is true, Is HK_SCHED still necessary? There seems to be no use case
> >     and the check for this can be replaced by on_null_domain().
> 
> I've no idea about all those HK knobs, it's all insane if you ask me.
> 
> Frederic, afaict all the HK_ goo in kernel/sched/fair.c is total
> nonsense, can you please explain?

Yes. Lemme unearth this patch:
https://lore.kernel.org/all/20230203232409.163847-2-frederic@kernel.org/

Because all we need now is:

_ HK_TYPE_KERNEL_NOISE: nohz_full= or isolcpus=nohz
_ HK_TYPE_DOMAIN: isolcpus=domain (or classic isolcpus= alone)
_ HK_TYPE_MANAGED_IRQ: isolcpus=managed_irq

And that's it. Then let's remove HK_TYPE_SCHED that is unused. And then
lemme comment the HK_TYPE_* uses within sched/* within the same
patchset.

Just a question, correct me if I'm wrong, we don't want nohz_full= to ever
take the idle load balancer duty (this is what HK_TYPE_MISC prevents in
find_new_ilb) because the nohz_full CPU going back to userspace concurrently
doesn't want to be disturbed by a loose IPI telling it to do idle balancing. But
we still want nohz_full CPUs to be part of nohz.idle_cpus_mask so that the
idle balancing can be performed on them by a non isolated CPU. Right?

Thanks.



> 
> If the CPU participates in load-balancing, it gets to fully participate.
> If you want to get out of load-balancing, you get single CPU partitions.

