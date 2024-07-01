Return-Path: <linux-kernel+bounces-236139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6496891DDF0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1869F2824F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B307413E034;
	Mon,  1 Jul 2024 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uFFtBZK4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T4nSLlWj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DDB2B9C6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833508; cv=none; b=MhW6juFuMsP/06voeMSw8xTTt51gjdq56nn8ViW4GqwonmJByyER3PnYrwu3C+SoeEwhu8YWyOeM1FXxJrJwhOVvTV1GkjywuHLBID/eqMsrn7KuzO5+/sDm453lfHG9OWSMOdSzWjDBXEHcNRHU+np/2g1gQpFz+8bvR5UEvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833508; c=relaxed/simple;
	bh=SIzyAB5ADCiCVi9GLD02hZV5x1lP2Hmvw9d4H7TSgC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rFxfSbhxwVGGAh2ZNTnBuiChkqhpbw8M0cY7g0J1KKzIeaGgiAtjwolLIkb7Ziyxbv0hd8fqnpOSC+vR3QN7uFW5v8UrDnPwz6XQ6p7Jk9kueasMsg3oons8o2xo8SnO0OJN/DWkHNG3HRYyJsX3ajnxtYzZJwvt4WuSG3z36a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uFFtBZK4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T4nSLlWj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719833503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2s95bSxxQXSMYVQ+WZQAC/i+DdmuFIVnBLU1rY/o5Sk=;
	b=uFFtBZK4rsuSQzyIGkzg+kWvVOr8xJurC/ikvhzogoy5vF42/MeOzqH0eUCVlchc0kgrr1
	dbZ05fx6o6mtNvN77ZjFfAdBObxzVEgjukY6ju9HAe5YKpsIm7eHU71EzD+i+HkNjBZeRM
	cMf/HwqA+OfNFfoFVHB2YzmKel116x2rHDHWetcJFf2nmt2+g+CEmZCEtyDrsY8obk7Mcf
	PPeBP1kjNqpGJ3gEYzZPAMjDx71YEN+YvLP1CeXXiA7SpKOAK88lwz9eHFq0k6y1A9y279
	fuUeE/rK0zNfqlS9PRjBKfuYPL0c1igjO3ll/H14PGAkcFt/vSwjVIA9Fxz+7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719833503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2s95bSxxQXSMYVQ+WZQAC/i+DdmuFIVnBLU1rY/o5Sk=;
	b=T4nSLlWj8KBnIXXCTxxCKQuTZdY9ijxCj4iJYis3xm5n5QzxG4gWsIBAVyJdHNcV4vtYUh
	t/PSAcgA1finYpDA==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] timers/tick_sched: combine WARN_ON_ONCE and print_once
In-Reply-To: <20240610103552.25252-1-anna-maria@linutronix.de>
References: <20240610103552.25252-1-anna-maria@linutronix.de>
Date: Mon, 01 Jul 2024 13:31:43 +0200
Message-ID: <87r0cdpcv4.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gentle ping :)

And please replace print_once by printk_once in subject line when
reading.

Anna-Maria Behnsen <anna-maria@linutronix.de> writes:

> When the WARN_ON_ONCE() triggers, the printk of the additional information
> related to the warning will not happen in print level "warn". When reading
> the dmesg with a restriction to level "warn", the information published by
> the printk_once() will not show up there.
>
> Transform WARN_ON_ONCE() and printk_once() into a WARN_ONCE().
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/tick-sched.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 71a792cd8936..afeae34e2a09 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1026,10 +1026,10 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  		if (expires == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
>  			return;
>  
> -		WARN_ON_ONCE(1);
> -		printk_once("basemono: %llu ts->next_tick: %llu dev->next_event: %llu timer->active: %d timer->expires: %llu\n",
> -			    basemono, ts->next_tick, dev->next_event,
> -			    hrtimer_active(&ts->sched_timer), hrtimer_get_expires(&ts->sched_timer));
> +		WARN_ONCE(1, "basemono: %llu ts->next_tick: %llu dev->next_event: %llu "
> +			  "timer->active: %d timer->expires: %llu\n", basemono, ts->next_tick,
> +			  dev->next_event, hrtimer_active(&ts->sched_timer),
> +			  hrtimer_get_expires(&ts->sched_timer));
>  	}
>  
>  	/*

