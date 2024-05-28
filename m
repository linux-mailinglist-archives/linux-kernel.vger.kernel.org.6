Return-Path: <linux-kernel+bounces-192289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF368D1B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4ED1C20BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FEC16D9BE;
	Tue, 28 May 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrVEGPT3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7F16D4ED
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899050; cv=none; b=fVC1FF8/SNaXspWLNDYLUpoFHup/Dz2X9Yrb86T7akxk40Tp3Av9ZhLKEHMvYeUV86EQyMrOY5SIr4woGXwixHN5io05LSdVfTlMLjirqfUbH8fyVyPRlH93pBiaR2SvU2bJHtFgwcOsm41tEfhXoF4ggfUVFMoN/FDe6cU++pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899050; c=relaxed/simple;
	bh=/MJqfAee7OGT7xTNKJA57WCoB+d01NTLAU8YZ2IFO0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmIqeXw7tIpfYNoyFR3AkLoEKKfuzUp/WWV09Pihp2bXSgDC5vDIBzfIgXpEOIP4IzyFNbpCtAbFdexNEWvl+7p2JhNGH7k1BnSiwAKwPlqdTMdR2XnJ9HZruYU315SGjDeEOTV+mY7QXImKV4lAioADvCnaMoRwMXraOHMiWxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrVEGPT3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716899048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5hXCAyCRLskJTU1cugcsSNJSbjQozoJ0z0zbajvdQU=;
	b=MrVEGPT3pfJ1foCpVG3EjG9ueXkHp+0WKjlkaSNOdt2UHA0ZAXBDWf/bVSUHSAA/+7QLy/
	9dsKUTWcBymVDerW1EMF7NQiYGxFjEZk/CT73QL79ugCpeGyCxqYdlexm3JCpXcRdvspMh
	1G2WessU1hZ8rHJZHE/tynzVUrp+QkY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-7AT-4PBFNam1O4vlP9KA1A-1; Tue,
 28 May 2024 08:24:05 -0400
X-MC-Unique: 7AT-4PBFNam1O4vlP9KA1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A936A29AA382;
	Tue, 28 May 2024 12:24:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.131])
	by smtp.corp.redhat.com (Postfix) with SMTP id 4E2C02026D68;
	Tue, 28 May 2024 12:24:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 28 May 2024 14:22:36 +0200 (CEST)
Date: Tue, 28 May 2024 14:22:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/nohz_full: don't abuse smp_call_function_single()
 in tick_setup_device()
Message-ID: <20240528122233.GB28794@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528122019.GA28794@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

If this patch/changelog/comment is fine, I'll send another trivial
one which turns tick_do_timer_boot_cpu into "bool boot_cpu_is_nohz_full".

On 05/28, Oleg Nesterov wrote:
>
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
>  #endif
>  		}
>  
> -- 
> 2.25.1.362.g51ebf55
> 


