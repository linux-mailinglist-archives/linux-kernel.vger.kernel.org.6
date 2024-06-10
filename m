Return-Path: <linux-kernel+bounces-208520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A7590262B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52411C211E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32637140E4D;
	Mon, 10 Jun 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDwXhIlv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F359D13F450
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035012; cv=none; b=Gv9Sa+41eg1ryyIKf9X8Fm0gXe5R2g50UZLX+s5UpwPgkDp4FlLltbk0dRUIfys+H9cuwSGD6Tj/5VVj0TZzNFOVsJQTzHAUr6Hr3nqVmgBm88amDGhi+bOLdm+yAW1NhqsuMIol/2B1Yvc7SPT9LWxYMQReemqbMquRaGfIE+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035012; c=relaxed/simple;
	bh=xpjNp3XUnTkhabt16yBIEJ1ajLl8po3Zg+CZU1LwKJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dw2FrrKsIhzo2fnsAqF4W3TkWrZQw5lzZAje+T9xRg8EA72VAYkq4XRTuvyUEllrdoOnr7N4OMFHnZQAIJe7553MUnmkRpdf6mdZi1futxr5rJjS7WeV2QRy1y6aRy0xR3Ck0xUdpfFnE7bHdsFJKP3sFiQ7MdKm8UfdJAZF77Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDwXhIlv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718035009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BS5eTgnHlkFCzrxbZOb8hmMMzPTpAoIPnvvRf/vsaRQ=;
	b=JDwXhIlvMVrVpSLws/anjO/0yR0J6QaplzqXDq2L2Sd+YnQ8GFdVE8pgUE/6JtxrjAL7ix
	EBuKb6G5m5PjvK74KzTC15qZIc51Z5KPZJ9YFZL/j7kqFk8LEp1CFDNTzvHiWe7wUwhUFW
	iNU6voc6BOCcMqm1JNCxyF1JrvgsYhg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-iHDB393jPmWTff-N5659ew-1; Mon,
 10 Jun 2024 11:56:46 -0400
X-MC-Unique: iHDB393jPmWTff-N5659ew-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D9E61954B0B;
	Mon, 10 Jun 2024 15:56:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 90A5A1956048;
	Mon, 10 Jun 2024 15:56:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Jun 2024 17:55:12 +0200 (CEST)
Date: Mon, 10 Jun 2024 17:55:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PING ;)] Re: [PATCH] tick/nohz_full: don't abuse
 smp_call_function_single() in tick_setup_device()
Message-ID: <20240610155505.GA24299@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Thomas, et al,

should I redo and/or resend this patch (and the next one on top of it) ?

Or what else can I do to fix this problem?

Thanks,

Oleg.

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


