Return-Path: <linux-kernel+bounces-188554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5860E8CE380
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8251F221D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320E86658;
	Fri, 24 May 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ge8bqQJF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQJgCp3A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB58562C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543077; cv=none; b=PMnEnu3+nkaE621CKas/P9f0LMf5Bl1RF3J+5pHGZzyG7EHchbc8tVBlDVcA9Q1zJDdjkmpyyasE8lqDCXQEP3JFARvduBr18KkpVxufMlJbkjZujXs4CarqYTuOInd7NCfVwkMdrXObCAf9MIJfgkhvtgwPqsNxaVTzuFR/NQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543077; c=relaxed/simple;
	bh=+P2e3s0y0C4Pks7attKusPI8h+dAOs18zDHPleld+qU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IDxx+qc3zDYdcrNcuP+Lz0vnLrXFDQcZIT3UKX+Uerh9DdcnlxV71EsS0KtQAS5UpPDssoJkDsWNA6PtOS96XPN3WerQDz/kAT+J7ygRFU46OYxKB1sLa9NU9FNA3j4u1pVNhtvDPgXlyHzA1TaEh3e2cgLkQFBz3DBrN1HUQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ge8bqQJF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQJgCp3A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716543073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zfwf84QV1XuABUHDoQRVCBsT26HgLUpQTAb2wWaPWXc=;
	b=Ge8bqQJFsHco1DUeGW1jqENBhPHDwLkCcvI4EDCYddP2noQYogzwJJy/FrAyBA2OR+H3sl
	4YdlOk0GDCvj6IZX2az1TZJFTTkFwWqY+UqXi1O+KlmPnVRHdeThLg7Za7hXqP0B2ONWuc
	HfNsT0HrsbBOL9svGy1sETLhuMs51ugfAVrKelLIPOftY9ce2w01SUzYSbJm9VEQwFkiKF
	4SYaYduqhJjrdw9ZgP/IKkmi4wbpYZkVcdxdn2/l9adjiSEeVRmrPqcgSr5fdHEtUNJd3i
	VKWz+lNk0IygcwsCYP6Y8VRAeWfSDGaY/UUH8K38sQKVPEKLm/H4Z70vOBhEJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716543073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zfwf84QV1XuABUHDoQRVCBsT26HgLUpQTAb2wWaPWXc=;
	b=GQJgCp3A+qXgOUx1r08ieKza558Kquo6Y+psxMd9IW3B6sRcN7PSX5dFz0ctRt1xynB3kk
	r5r17/sRL7edEoBg==
To: Oleg Nesterov <oleg@redhat.com>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Phil Auld
 <pauld@redhat.com>
Cc: Chris von Recklinghausen <crecklin@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
In-Reply-To: <20240523132358.GA1965@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com>
Date: Fri, 24 May 2024 11:31:12 +0200
Message-ID: <87h6eneeu7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oleg!

On Thu, May 23 2024 at 15:23, Oleg Nesterov wrote:
> On 05/22, Oleg Nesterov wrote:
>>
>> After the recent comment 5097cbcb38e6 ("sched/isolation: Prevent boot crash
>> when the boot CPU is nohz_full") the kernel no longer crashes, but there is
>> another problem.
>>
>> In this case tick_setup_device() does tick_take_do_timer_from_boot() to
>> update tick_do_timer_cpu and this triggers WARN_ON_ONCE(irqs_disabled())
>> in smp_call_function_single().
>>
>> I don't understand this code even remotely, I failed to find the fix.
>>
>> Perhaps we can use smp_call_function_single_async() as a workaround ?
>>
>> But I don't even understand why exactly we need smp_call_function()...

It's not required at all.

>> Race with tick_nohz_stop_tick() on boot CPU which can set
>> tick_do_timer_cpu = TICK_DO_TIMER_NONE? Is it really bad?

This can't happen.

> And is it supposed to happen if tick_nohz_full_running ?
>
> tick_sched_do_timer() and can_stop_idle_tick() claim that
> TICK_DO_TIMER_NONE is not possible in this case...

What happens during boot is:

  1) The boot CPU takes the do_timer duty when it installs its
     clockevent device

  2) The boot CPU does not give up the duty because of this
     condition in can_stop_idle_tick():

     if (tick_nohz_full_enabled()) {
     	if (tick_cpu == cpu)
           return false;
        ...

So there is no race because the boot CPU _cannot_ reach
tick_nohz_stop_tick() as long as no secondary has taken over.

It's far from obvious. What a horrible maze...

> So, once again, could you explain why the patch below is wrong?

> -			tick_take_do_timer_from_boot();
>  			tick_do_timer_boot_cpu = -1;
> -			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
> +			WRITE_ONCE(tick_do_timer_cpu, cpu);

This part is perfectly fine.

> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 71a792cd8936..3b1d011d45e1 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1014,6 +1014,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  	 */
>  	tick_cpu = READ_ONCE(tick_do_timer_cpu);
>  	if (tick_cpu == cpu) {
> +#ifdef CONFIG_NO_HZ_FULL
> +		WARN_ON_ONCE(tick_nohz_full_running);
> +#endif

                WARN_ON_ONCE(tick_nohz_full_enabled());

which spares the ugly #ifdef?

>  		WRITE_ONCE(tick_do_timer_cpu, TICK_DO_TIMER_NONE);
>  		tick_sched_flag_set(ts, TS_FLAG_DO_TIMER_LAST);
>  	} else if (tick_cpu != TICK_DO_TIMER_NONE) {

Thanks,

        tglx

