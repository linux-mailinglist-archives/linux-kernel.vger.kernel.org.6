Return-Path: <linux-kernel+bounces-572993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A0A6D131
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEB01657E6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 21:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B81A704B;
	Sun, 23 Mar 2025 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEJ5qO5y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D320C2AF1D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742764710; cv=none; b=DVgUcAd6FmPsH6i+xpJt7AFvnjUSiEnFS0+yJDyk7pq9o6SFje5mXGfiwTcsoArMmIBS8MiUec4e8g1S8olXe/mrUeKBEkpW0MQMrteZyc9R19Bu5z4FCjL8oHNnZ7E8HitLUnCHsFAXitQD0JO5ajSrGAAyDrK3HaVHXe9J5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742764710; c=relaxed/simple;
	bh=TED3ljt5Bkf0dQsrUBCHIS/zTAfOz+5D+i8lk6McDio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNwFuXDz6kzZcWi9ORex9NDeKmvDCsXQpmv5jrxQfAQaWe4BXqzDgAtWUSGGWDTQtTk/OuVv9PgmpcGzKcVX0UZ6aS29BOXbVyNtetMeBKNtVRhYMs71qMn5jDDMr8xyVSioUXCynjYef0FVXuTiBmbh7Qd8Aas5matDNpsSAts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEJ5qO5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94785C4CEE2;
	Sun, 23 Mar 2025 21:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742764710;
	bh=TED3ljt5Bkf0dQsrUBCHIS/zTAfOz+5D+i8lk6McDio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEJ5qO5yqqhsFo9pM0XwZtRnbQA15/PZlL+XrumVI+/yILYcKY2w0s+X9KtjtejKQ
	 pQyk1PevX4vmgUmvvnKnjNc4mzD7eX9wub9BWa3UwYT+W/kawtX8q85o8WSw1UHNBq
	 XQ1BUvWrWSAiq/AhGQbUWdTcoeH3Sf+s6f4M0VC2UPx6KidSIk/MgN3kiOjxphT0Qx
	 gygNN5GuZciS6JP80Oh1OncbopEi8TaF0scbC+nUpfPFBFWhTgfLdA5z6GbMoWRLQc
	 WiyTKf5K+AneEro7zUfua3q0Fw1PMWlIbhgeuXrtuhePkp6K6XLxcLnYlhYiwLyHAq
	 xkMWHd9CPMnDA==
Date: Sun, 23 Mar 2025 22:18:25 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc: x86@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
	dwmw@amazon.co.uk, mhkelley@outlook.com
Subject: Re: [PATCH] x86/i8253: fix possible deadlock when turning off the PIT
Message-ID: <Z-B6ob0zLZr81e8i@gmail.com>
References: <20250323150924.3326-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323150924.3326-1-ffmancera@riseup.net>


* Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:

> As the PIT could be disabled during the init, it can possibly cause a
> deadlock when resuming from suspend due to a lock dependency created at
> pcspkr_event(). This new dependency connect a HARDIRQ-irq-safe to a
> HARDIRQ-irq-unsafe.
> 
> Solve this warning by using the raw_spin_lock_irqsave() variant when
> turning off the PIT.
> 
> [   45.408952] =====================================================
> [   45.408970] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> [   45.408974] 6.14.0-rc7+ #6 Not tainted
> [   45.408978] -----------------------------------------------------
> [   45.408980] systemd-sleep/3324 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> [   45.408986] ffffffffb2c23398 (i8253_lock){+.+.}-{2:2}, at: pcspkr_event+0x3f/0xe0 [pcspkr]
> [   45.409004]
>                and this task is already holding:
> [   45.409006] ffff9c334d7c2230 (&dev->event_lock){-.-.}-{3:3}, at: input_dev_resume+0x21/0x50
> [   45.409023] which would create a new lock dependency:
> [   45.409025]  (&dev->event_lock){-.-.}-{3:3} -> (i8253_lock){+.+.}-{2:2}
> [   45.409043]
>                but this new dependency connects a HARDIRQ-irq-safe lock:
> [   45.409045]  (&dev->event_lock){-.-.}-{3:3}
> [   45.409052]
>                ... which became HARDIRQ-irq-safe at:
> [   45.409055]   lock_acquire+0xd0/0x2f0
> [   45.409062]   _raw_spin_lock_irqsave+0x48/0x70
> [   45.409067]   input_event+0x3c/0x80
> [   45.409071]   atkbd_receive_byte+0x9b/0x6e0
> [   45.409077]   ps2_interrupt+0xb2/0x1d0
> [   45.409082]   serio_interrupt+0x4a/0x90
> [   45.409087]   i8042_handle_data+0xf8/0x280
> [   45.409091]   i8042_interrupt+0x11/0x40
> [   45.409095]   __handle_irq_event_percpu+0x87/0x260
> [   45.409100]   handle_irq_event+0x38/0x90
> [   45.409105]   handle_edge_irq+0x8b/0x230
> [   45.409109]   __common_interrupt+0x5c/0x120
> [   45.409114]   common_interrupt+0x80/0xa0
> [   45.409120]   asm_common_interrupt+0x26/0x40
> [   45.409125]   pv_native_safe_halt+0xf/0x20
> [   45.409130]   default_idle+0x9/0x20
> [   45.409135]   default_idle_call+0x7a/0x1d0
> [   45.409140]   do_idle+0x215/0x260
> [   45.409144]   cpu_startup_entry+0x29/0x30
> [   45.409149]   start_secondary+0x132/0x170
> [   45.409153]   common_startup_64+0x13e/0x141
> [   45.409158]
>                to a HARDIRQ-irq-unsafe lock:
> [   45.409161]  (i8253_lock){+.+.}-{2:2}
> [   45.409167]
>                ... which became HARDIRQ-irq-unsafe at:
> [   45.409170] ...
> [   45.409172]   lock_acquire+0xd0/0x2f0
> [   45.409177]   _raw_spin_lock+0x30/0x40
> [   45.409181]   clockevent_i8253_disable+0x1c/0x60
> [   45.409186]   pit_timer_init+0x25/0x50
> [   45.409191]   hpet_time_init+0x46/0x50
> [   45.409196]   x86_late_time_init+0x1b/0x40
> [   45.409201]   start_kernel+0x962/0xa00
> [   45.409206]   x86_64_start_reservations+0x24/0x30
> [   45.409211]   x86_64_start_kernel+0xed/0xf0
> [   45.409215]   common_startup_64+0x13e/0x141
> [   45.409220]
>                other info that might help us debug this:
> 
> [   45.409222]  Possible interrupt unsafe locking scenario:
> 
> [   45.409224]        CPU0                    CPU1
> [   45.409226]        ----                    ----
> [   45.409228]   lock(i8253_lock);
> [   45.409234]                                local_irq_disable();
> [   45.409237]                                lock(&dev->event_lock);
> [   45.409243]                                lock(i8253_lock);
> [   45.409249]   <Interrupt>
> [   45.409251]     lock(&dev->event_lock);
> [   45.409257]
>                 *** DEADLOCK ***
> 
> Fixes: 70e6b7d9ae3c ("x86/i8253: Disable PIT timer 0 when not in use")
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> ---
>  drivers/clocksource/i8253.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
> index 39f7c2d736d1..9a91ce66e16e 100644
> --- a/drivers/clocksource/i8253.c
> +++ b/drivers/clocksource/i8253.c
> @@ -103,7 +103,9 @@ int __init clocksource_i8253_init(void)
>  #ifdef CONFIG_CLKEVT_I8253
>  void clockevent_i8253_disable(void)
>  {
> -	raw_spin_lock(&i8253_lock);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&i8253_lock, flags);
>  
>  	/*
>  	 * Writing the MODE register should stop the counter, according to
> @@ -133,7 +135,7 @@ void clockevent_i8253_disable(void)
>  
>  	outb_p(0x30, PIT_MODE);
>  
> -	raw_spin_unlock(&i8253_lock);
> +	raw_spin_unlock_irqrestore(&i8253_lock, flags);
>  }

That's a nice one - and in general the clockevent shutdown/disable 
handlers are called with IRQs off: hpet_time_init()->pit_timer_init() 
being the odd one out post-70e6b7d9ae3c that introduced this bug.

So the real bug is that hpet_time_init() just blindly assumes that 
clockevent_i8253_disable() is IRQ-safe, which it isn't and never was.

So the slightly better fix would be to save-disable interrupts in 
pit_timer_init() around the clockevent_i8253_disable() call. This would 
avoid the IRQ disable/enable dance for all the other callers. (Not that 
it really matters for the PIT driver, but it's the principle.)

Thanks,

	Ingo

