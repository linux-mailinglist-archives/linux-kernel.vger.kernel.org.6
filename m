Return-Path: <linux-kernel+bounces-195554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3C78D4E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAA61C23D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A0D17E445;
	Thu, 30 May 2024 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFiPtTit"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9C17C208
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080764; cv=none; b=sRNn+0HFZ71pEjTvQdF1D29fdV/wRtYGejXG4M3JZOD89xgrlyJOk7SFUWFDJvOXLY8wsRRn8PbRJqkN2i5KxJ9jkImoETo1A9PV5QTVHs2FR/MVbE+SKVYMB8su1n6La9kT7WTdjCUbwCe50yaEouogTzx9kD7mM+DA6n3qZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080764; c=relaxed/simple;
	bh=s2jfnC+z9PdX3/MD9tCvXh6rlIgRo352NcXJuNAammk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNaYPXgWjT8JjhiWZg2+wDnGZzsKspx4eh4mUfeV21F6F1hulJ1mk4173mH2SvHOTiDE0VEVbzoQdVmsKqVWrIw2rallUYZN8MFYoVvsiD2IB0V0MtEu9wJcdekknPSBG2KSiNQ/9DMnb4qhb/XWSf+4RadVNwqeAn5+TaqNJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFiPtTit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961CDC2BBFC;
	Thu, 30 May 2024 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717080764;
	bh=s2jfnC+z9PdX3/MD9tCvXh6rlIgRo352NcXJuNAammk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFiPtTit7XmQKexrkCbj1Z1RFjT5mXv88tspZG6cUQ7RICY6VkfjqaYBUUV6+YduV
	 lC5YnIPoERusrh446Zq8Q2mkEzRH+ruNETJ8qkXnTpLjNfyOLGBmiRmLu68REnxumI
	 pUj1rODlGUi+H+u/PY1L0kN390IyOKCu4RcMw+uJqXaUgUts+HAVDN83dU+u85whvU
	 jK2RiCIPu45FQuIlNPq1bfzLvD+prwdVcPZ0LiM+FsI2BY/xupy7W9xbVWX3F5a3M2
	 h/GtB+12CF7SuPe+VQSuvLL0F0x2P/PGJokzAoqTIEcAIguKAuTB5EGE48MpnlLPE8
	 qps/NWZgFluGw==
Date: Thu, 30 May 2024 16:52:39 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/nohz_full: don't abuse smp_call_function_single()
 in tick_setup_device()
Message-ID: <ZliSt-RDyxf1bZ_t@localhost.localdomain>
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528122019.GA28794@redhat.com>

Le Tue, May 28, 2024 at 02:20:19PM +0200, Oleg Nesterov a écrit :
> After the recent commit 5097cbcb38e6 ("sched/isolation: Prevent boot
> crash when the boot CPU is nohz_full") the kernel no longer crashes, but
> there is another problem.
> 
> In this case tick_setup_device() calls tick_take_do_timer_from_boot() to
> update tick_do_timer_cpu and this triggers the WARN_ON_ONCE(irqs_disabled)
> in smp_call_function_single().
> 
> Kill tick_take_do_timer_from_boot() and just use WRITE_ONCE(), the new
> comment tries to explain why this is safe (thanks Thomas!).
> 
> Fixes: 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full")
> Link: https://lore.kernel.org/all/20240522151742.GA10400@redhat.com
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/time/tick-common.c | 39 +++++++++++++--------------------------
>  1 file changed, 13 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index d88b13076b79..27d0018c8b05 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -178,26 +178,6 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
>  	}
>  }
>  
> -#ifdef CONFIG_NO_HZ_FULL
> -static void giveup_do_timer(void *info)
> -{
> -	int cpu = *(unsigned int *)info;
> -
> -	WARN_ON(tick_do_timer_cpu != smp_processor_id());
> -
> -	tick_do_timer_cpu = cpu;
> -}
> -
> -static void tick_take_do_timer_from_boot(void)
> -{
> -	int cpu = smp_processor_id();
> -	int from = tick_do_timer_boot_cpu;
> -
> -	if (from >= 0 && from != cpu)
> -		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
> -}
> -#endif
> -
>  /*
>   * Setup the tick device
>   */
> @@ -221,19 +201,26 @@ static void tick_setup_device(struct tick_device *td,
>  			tick_next_period = ktime_get();
>  #ifdef CONFIG_NO_HZ_FULL
>  			/*
> -			 * The boot CPU may be nohz_full, in which case set
> -			 * tick_do_timer_boot_cpu so the first housekeeping
> -			 * secondary that comes up will take do_timer from
> -			 * us.
> +			 * The boot CPU may be nohz_full, in which case the
> +			 * first housekeeping secondary will take do_timer()
> +			 * from us.
>  			 */
>  			if (tick_nohz_full_cpu(cpu))
>  				tick_do_timer_boot_cpu = cpu;
>  
>  		} else if (tick_do_timer_boot_cpu != -1 &&
>  						!tick_nohz_full_cpu(cpu)) {
> -			tick_take_do_timer_from_boot();
>  			tick_do_timer_boot_cpu = -1;
> -			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
> +			/*
> +			 * The boot CPU will stay in periodic (NOHZ disabled)
> +			 * mode until clocksource_done_booting() called after
> +			 * smp_init() selects a high resolution clocksource and
> +			 * timekeeping_notify() kicks the NOHZ stuff alive.
> +			 *
> +			 * So this WRITE_ONCE can only race with the READ_ONCE
> +			 * check in tick_periodic() but this race is harmless.
> +			 */
> +			WRITE_ONCE(tick_do_timer_cpu, cpu);

Looks good, but can we have a WARN_ONCE(tick_do_timer_cpu != tick_do_timer_boot_cpu)
right before that, just to make sure our assumptions above are right forever and
the boot CPU hasn't stopped the tick up to that point?

And after all, pushing a bit further your subsequent patch, can we get rid of
tick_do_timer_boot_cpu and ifdefery altogether? Such as:

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index fb0fdec8719a..63a7bd405de7 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -48,14 +48,6 @@ ktime_t tick_next_period;
  *    procedure also covers cpu hotplug.
  */
 int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
-#ifdef CONFIG_NO_HZ_FULL
-/*
- * tick_do_timer_boot_cpu indicates the boot CPU temporarily owns
- * tick_do_timer_cpu and it should be taken over by an eligible secondary
- * when one comes online.
- */
-static int tick_do_timer_boot_cpu __read_mostly = -1;
-#endif
 
 /*
  * Debugging: see timer_list.c
@@ -177,26 +169,6 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 	}
 }
 
-#ifdef CONFIG_NO_HZ_FULL
-static void giveup_do_timer(void *info)
-{
-	int cpu = *(unsigned int *)info;
-
-	WARN_ON(tick_do_timer_cpu != smp_processor_id());
-
-	tick_do_timer_cpu = cpu;
-}
-
-static void tick_take_do_timer_from_boot(void)
-{
-	int cpu = smp_processor_id();
-	int from = tick_do_timer_boot_cpu;
-
-	if (from >= 0 && from != cpu)
-		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
-}
-#endif
-
 /*
  * Setup the tick device
  */
@@ -211,29 +183,28 @@ static void tick_setup_device(struct tick_device *td,
 	 * First device setup ?
 	 */
 	if (!td->evtdev) {
+		int timekeeper = READ_ONCE(tick_do_timer_cpu);
 		/*
 		 * If no cpu took the do_timer update, assign it to
 		 * this cpu:
 		 */
-		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
+		if (timekeeper == TICK_DO_TIMER_BOOT) {
 			tick_do_timer_cpu = cpu;
 			tick_next_period = ktime_get();
-#ifdef CONFIG_NO_HZ_FULL
+		} else if (timekeeper == TICK_DO_TIMER_NONE) {
+			if (WARN_ON_ONCE(tick_nohz_full_enabled()))
+				WRITE_ONCE(tick_do_timer_cpu, cpu);
+		} else if (tick_nohz_full_cpu(timekeeper) && !tick_nohz_full_cpu(cpu)) {
 			/*
-			 * The boot CPU may be nohz_full, in which case set
-			 * tick_do_timer_boot_cpu so the first housekeeping
-			 * secondary that comes up will take do_timer from
-			 * us.
+			 * The boot CPU will stay in periodic (NOHZ disabled)
+			 * mode until clocksource_done_booting() called after
+			 * smp_init() selects a high resolution clocksource and
+			 * timekeeping_notify() kicks the NOHZ stuff alive.
+			 *
+			 * So this WRITE_ONCE can only race with the READ_ONCE
+			 * check in tick_periodic() but this race is harmless.
 			 */
-			if (tick_nohz_full_cpu(cpu))
-				tick_do_timer_boot_cpu = cpu;
-
-		} else if (tick_do_timer_boot_cpu != -1 &&
-						!tick_nohz_full_cpu(cpu)) {
-			tick_take_do_timer_from_boot();
-			tick_do_timer_boot_cpu = -1;
-			WARN_ON(tick_do_timer_cpu != cpu);
-#endif
+			WRITE_ONCE(tick_do_timer_cpu, cpu);
 		}
 
 		/*

