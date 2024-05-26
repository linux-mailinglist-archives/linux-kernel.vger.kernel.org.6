Return-Path: <linux-kernel+bounces-189872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB58CF60B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8CCB20A77
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643DB139D1B;
	Sun, 26 May 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhenBsoa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8C29CF0
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716757027; cv=none; b=OgAIX39LsOQV63mqb0TInZg2G/ExeQg9WQnGSZmeFrJUifRIS2cNPsJDMUgdCgwQrpYKvC+Mn7XNCQ827YW+qFt8odLigGPyHuRiNsK3r/8kG+gpIU1Hhy5fp8ZiBqNOZoEAUYAdpYoj/AKTPp+E6BdsMaF2vrEE1fU4FIEgcw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716757027; c=relaxed/simple;
	bh=BKXmSLBwhsuZSE0EbqW+pJjwzw8HRsPk9vLOKGQLJcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTZxlQpFRcSYvyvtCh19AvKpqm0NQ7rNVCAGD8yvg1tbHihHCIadSy+xJyC59QTiX+ca+L78qA6EryKodWOoGjKvhP6pF0ZKyDuNuw3v7uUFsuT9YYnl4uS1yT5N7i6H1WvZkF5mo5grAi7qxSDnTFYO8W5XcH1fOKHLAzOFPyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhenBsoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAA6C2BD10;
	Sun, 26 May 2024 20:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716757027;
	bh=BKXmSLBwhsuZSE0EbqW+pJjwzw8HRsPk9vLOKGQLJcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhenBsoaIDohaV8EZkK13uU0hxchwQaaDGBjzHLl3JTfUJkEC2aHWjx5zAsb8DJ7F
	 h/+lTyVt1rg8xhbpJPspXdf7ve+TeDY5fOT8VNVKKznnTp5S7ifAbbN4YO/WavR/+A
	 dHr4WlViha2lKUJuLYGGjpz6kIfPPnnA5ux7u8wHUP/I5wiXM2ljvIlBgI+Hqp4yUy
	 NCn5HIzSLTYdwVo5xjbAckLmyRPRh/vxX5tqWq1x6DNoo++y3ODTVqNxKGk64xe/aP
	 39QzfGrJahHjTS66vGhs6L5sBMzzJvyZx6GvBX9y+10/16cESVNu/M95m7ne0Ju6Ew
	 fS4xsQUflWYNg==
Date: Sun, 26 May 2024 22:57:04 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <ZlOiIONRExNkgZ0R@pavilion.home>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com>
 <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home>
 <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v832dfw1.ffs@tglx>

Le Sat, May 25, 2024 at 12:06:06AM +0200, Thomas Gleixner a écrit :
> On Fri, May 24 2024 at 20:37, Oleg Nesterov wrote:
> 
> > I've already had a few beers today, I know I'll regret about this
> > email tomorrow, but I can't resist ;)
> 
> You won't regret it. :)
> 
> > On 05/24, Frederic Weisbecker wrote:
> > But again, again. tick_sched_do_timer() says
> >
> > 	* If nohz_full is enabled, this should not happen because the
> > 	* 'tick_do_timer_cpu' CPU never relinquishes.
> >
> > so I guess it is not supposed to happen?
> 
> Right. It does not happen because the kernel starts with jiffies as
> clocksource except on S390. The jiffies clocksource is not qualified to
> switch over to NOHZ mode for obvious reasons. But even on S390 which has
> a truly usable and useful clocksource the tick stays periodic to begin
> with. Why?
> 
> The NOHZ ready notification happens late in the boot process via:
> fs_initcall(clocksource_done_booting)
> 
> So by the time that happens, the secondary CPUs are up and have taken
> over the do timer duty.
> 
> [    0.600381] smp: Bringing up secondary CPUs ...
> 
> ....
> 
> [    1.917842] clocksource: Switched to clocksource kvm-clock
> [    1.918548] clocksource_done_booting: Switched to NOHZ // debug printk
> 
> This is the point where tick_nohz_activate() is called first time and
> that does:
> 
>   tick_sched_flag_set(ts, TS_FLAG_NOHZ);
> 
> So up to this point the tick is never stopped neither on housekeeping
> nor on NOHZ FULL CPUs:
> 
> tick_nohz_full_update_tick()
>   if (!tick_sched_flag_test(ts, TS_FLAG_NOHZ))
>     return;

Oh nice! I indeed completely skipped the clocksource part of the picture!

Thanks.

