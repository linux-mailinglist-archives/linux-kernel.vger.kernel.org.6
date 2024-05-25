Return-Path: <linux-kernel+bounces-189370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B3D8CEF29
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 15:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B1A28197A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC284D10A;
	Sat, 25 May 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpOopy/+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22007B652
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716645177; cv=none; b=pyeF+l25A0s7He8hQlJKMZMuh2u8wP58Da679vpvgxWkavEeAV7MHn7q3q0688DZXFDqTFFOUB39ZIGLAp3jP80LBI/VG4bhO8UcdoJAA9HRnZkQL0qYZ7SEOD4rAFHxmd3ttJaG9jO2R8iS/T08BdRdJZANbqiYN4qrRZtxjEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716645177; c=relaxed/simple;
	bh=RL98oRYspKWTXIinaeTKVbUTmRUyI/R/FXT08l0/IZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn8b8C2TrPIoCVXYnjCBj2aBErpqJDJO14KbEoM+IsCEASGClEfdAtQzye4QI26DOSJPHwbi/omoS4Wa8fZ+C3Zj8H2HWOmA4xbwigDL+TlI8yK4eHifeMzkef8x0GktVa30ax1aA2u5gjJVZUUndZdXj0LkyntYCwdTMhB2vjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpOopy/+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716645174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpPIU67vhcP/jfmlEx/ArZidppTGGwHtDGNWacckTYM=;
	b=CpOopy/+VqU8Ieej/nOhhRacwFzL1/AJ5GxdSfqeDh5ew/Vw0dtPldjFYLGsS/BreR9jM7
	fDiYUuQEeDO1ngIzudqXp5suXu7fZCdZwVO5SUV+hosgTkW9DoI0pvSFeipOeRclTx8l3/
	TNL1U16egoa4vl68DfalNrTzrQ+3nNI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-hmnx205uOFi538Gnd_xMYw-1; Sat, 25 May 2024 09:52:51 -0400
X-MC-Unique: hmnx205uOFi538Gnd_xMYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8637800CB0;
	Sat, 25 May 2024 13:52:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.8])
	by smtp.corp.redhat.com (Postfix) with SMTP id 823B640C6EB7;
	Sat, 25 May 2024 13:52:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 25 May 2024 15:51:23 +0200 (CEST)
Date: Sat, 25 May 2024 15:51:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <20240525135120.GA24152@redhat.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v832dfw1.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Thomas, thanks a lot!

Let me grep a bit more to better understand your explanations.

Just one note for now.

On 05/25, Thomas Gleixner wrote:
>
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -229,11 +209,9 @@ static void tick_setup_device(struct tick_device *td,
>  			if (tick_nohz_full_cpu(cpu))
>  				tick_do_timer_boot_cpu = cpu;
>
> -		} else if (tick_do_timer_boot_cpu != -1 &&
> -						!tick_nohz_full_cpu(cpu)) {
> -			tick_take_do_timer_from_boot();
> +		} else if (tick_do_timer_boot_cpu != -1 && !tick_nohz_full_cpu(cpu)) {
> +			WRITE_ONCE(tick_do_timer_cpu, cpu);
>  			tick_do_timer_boot_cpu = -1;
> -			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
>  #endif
>  		}
>
> along with the removal of the SMP function call voodoo programming gunk,

Yes,

> Changing the horribly lazy and incomprehensible '-1' to an actual
> meaningful define, e.g. TICK_DO_TIMER_NONE, would definitely help along
> with renaming the variable to tick_do_timer_nohz_full_boot_cpu.

Better yet, we can make it a boolean, we do not need cpu number. And
perhaps we can simply kill it along with #ifdef CONFIG_NO_HZ_FULL ?

	if (!td->evtdev) {
		tick_cpu = READ_ONCE(tick_do_timer_cpu);
		/*
		 * If no cpu took the do_timer update, assign it to
		 * this cpu:
		 */
		if (tick_cpu == TICK_DO_TIMER_BOOT) {
			WRITE_ONCE(tick_do_timer_cpu, cpu);
			tick_next_period = ktime_get();
			/*
			 * The boot CPU may be nohz_full, in which case the
			 * first housekeeping secondary will take do_timer
			 * from us.
			 */
		} else if (tick_nohz_full_cpu(tick_cpu) &&
			  !tick_nohz_full_cpu(cpu)) {
			WRITE_ONCE(tick_do_timer_cpu, cpu);
		}

Oleg.


