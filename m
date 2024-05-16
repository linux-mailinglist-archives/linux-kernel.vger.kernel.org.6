Return-Path: <linux-kernel+bounces-180939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387ED8C752D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A15D1C21F22
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B24F1459EE;
	Thu, 16 May 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHESXcPa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADA14534B
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715858721; cv=none; b=s3mr9ogqtqZUBXri2adwPmN63m6FkQKgnbS9I3F9Hh3Zq3bs7etugvDjsmjKbVH9GYiM4ABkC3ZGp0oeyXEv89evbGoxIm+kFo8jQRP2+VU7eXNiDyXeNuyS++jqq6zXwwYgi+Ps3E8Q6GgylCrZHUqQ8nioirDOTUj2aF73aKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715858721; c=relaxed/simple;
	bh=Z3mpnLIUmt7AHRISjQddMdml+3gLRLCWGiU+qcDJh8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAHrFa2RnkxlBORl8jVe6S/6alHMsmXWzWe9UvbxlZWr3Cc9Q/LqQy/VxHmbhVsCPHUvVc7i2RPewwbngCs7poZLimV2NonIcVvX5KzDn489fRlEOcrJSslmWhUKPDzUa4hbLYJlwSBmKsHkd9iUtvGIw8wVGWRt08nwd8Vp6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHESXcPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071FFC32782;
	Thu, 16 May 2024 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715858721;
	bh=Z3mpnLIUmt7AHRISjQddMdml+3gLRLCWGiU+qcDJh8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHESXcPat6gtqcuZi1lj1aZnOYsoBm2cW7PhCfJuGbmdmZJWkNQceN1sc87j49v3Z
	 GGLKLPmqSPwFXOc5wq7XOeNBDbVwTy/K3IKx26eRKjJx5zffXf3oI/UcjSWJ7EW+QZ
	 cMaASId65loQmqLIp+ImHpQuDsAtFPBAcu3SXyX5PUzxApkF2W88M6oNYx/SJ5REWz
	 uNyaL1bTutiem6s8howHjAnknBBCbm/EDas/gIm9u7fCa7Jb2vHl8wRHoDvgHc12YU
	 2Yk5n8SxW93BU64LckCwyh94pTKShGUh5jII0/z5N//LjrijG+6iQl2cesE2rIXp1f
	 cqhwGfl+nhf3w==
Date: Thu, 16 May 2024 13:25:18 +0200
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
Message-ID: <ZkXtHv+fHUD2+lFJ@lothringen>
References: <20240508172621.30069-1-ppbuk5246@gmail.com>
 <20240509092931.35209-2-ppbuk5246@gmail.com>
 <ZkU8lm2tjm_r9FpZ@pavilion.home>
 <20240516075628.GC22557@noisy.programming.kicks-ass.net>
 <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>
 <20240516084911.GF22557@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516084911.GF22557@noisy.programming.kicks-ass.net>

On Thu, May 16, 2024 at 10:49:11AM +0200, Peter Zijlstra wrote:
> On Thu, May 16, 2024 at 09:20:08AM +0100, Yun Levi wrote:
> > > None of that HK nonsense is relevant. The NOHZ_FULL nonsense implies
> > > single CPU partitions, and *that* should be avoiding any and all
> > > load-balancing.
> > 
> > Do you mean.. tick_nohz_full cpu (non-HK-ticked cpu) shouldn't belong
> > to any sched_domain?
> 
> AFAIK NOHZ_FULL still hard relies on the isolcpus garbage, so yeah, it
> should be all single cpu partitions, which don't have a domain.
> 
> (this really should migrate to use cpusets partitions)
> 
> > > If there still is, that's a bug, but that's not related to HK goo.
> > >
> > > As such, I don't think the HK_TYPE_SCHED check in
> > > nohz_balance_enter_idle() actually makes sense, the on_null_omain()
> > > check a little below that should already take care of things, no?
> > 
> > IIUC,
> > currently, whether cpu belongs on domain or null is determined by
> > HK_DOMAIN_FLAGS
> 
> No! you can create NULL domains without any of the HK nonsense. Both
> isolcpus and cpusets can create single CPU partitions.
> 
> > However, when "nohz_full=" is used, it still on HK_DOMAIN, so it
> > belongs to sched_domain
> > so, it couldn't be filtered out by on_null_domain().
> > 
> > unless "isolcpus=domain" or "isolcpus={cpu_list}", it's on null domain.
> > with "isolcpus=tick", it participates sched_domain.
> 
> Frederic ?!? You can use nohz_full without isolcpus? That makes no
> sense. If you do that you get to keep the pieces.

I fear you can yes, even though most users combine it with isolcpus. I
know, that interface is terrible but it dates from times when we weren't
sure about all the potential usecases of nohz_full. There was a possibility
that HPC could just want to reduce ticks without all the hard and costly
isolation around. But all the usecases I have witnessed so far in ten years
involved wanting 0 noise after all...

