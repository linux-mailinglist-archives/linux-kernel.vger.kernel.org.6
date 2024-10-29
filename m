Return-Path: <linux-kernel+bounces-387267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F8F9B4ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193B31F23AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5784195FE8;
	Tue, 29 Oct 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wa0HywIe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+tCYeB8R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F5718754F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217789; cv=none; b=EAYAUUXgy1spGYALkXf2TPRf34cZE+HEEqnINEvg6TPmuXw8rNAxOAv5zdnMgP7veyQ6IoyftYiCvxgngDNduYiUi3m4ENjjbadzQUMqhf1nQQnuZ7rde/Br3/8BhoN3QGbtZavAPHcNr8CWLJ8WhY9nAFEwvSHQxg4ZzIluhpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217789; c=relaxed/simple;
	bh=ZX2Rmf/qgGCZ8j60Lem2+OGomVztJke9Q1ZLZb5p1vM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qJYDtGnUwT8wxVH6cST3ieKRwje61/3PcY9ZTR9IMEdKxnP4QAxVocVVlyPQJ4Ia+Ij3AtFUIxFPIGldZjneBVoBwi1priWe8Rjp7i7uK6TS4CAN5hcOulfxWsoLYJca/2cjXyuN6NmTAihbtox8h40FjvaVAOqM9Ynb6Ntlp8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wa0HywIe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+tCYeB8R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730217785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71DAZNonQx1HuNt9crWe33SlwsU+gxyh/l4cngw6mHM=;
	b=Wa0HywIemKOcjASOxoiGVZnR0AVfpY1fX5/zj3yEnMuh/9As6Rm5xepRT3cpn3th9DzZFX
	hVZbs9PoMHw99BVqSuu6I9+dsgTTcg+5yXcCVU8kWy1zAb+bWcaF//JkCaEuEL/FMpMrOm
	1VAlGu0R0/LsZJU3Ese+FJpt/mn/qxSj7DUcdzwZNAQ8xF2HcXxtOg4jlyA3hG1upzZsP/
	JArpQpBbhSQYhrkmIXfsOXxXppsGcQr1CP6/uDPUWlWBJWf9Y51WfiWq5Htw67uCBXoRtr
	RBzzUy986M79Z9XteJmvrKoDJ5ggfp52H4K6gV7KDMW5DInzZS5FRKw8Lr0XSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730217785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71DAZNonQx1HuNt9crWe33SlwsU+gxyh/l4cngw6mHM=;
	b=+tCYeB8R6zMvq9ss6Z04juDQhe58iBZnStTXiPf6VfCTcxfL0nQqfjQqmdCKfi2hMvpFOp
	Lob63uLL/YYQnRDg==
To: Benjamin ROBIN <dev@benjarobin.fr>, jstultz@google.com
Cc: sboyd@kernel.org, linux-kernel@vger.kernel.org, Benjamin ROBIN
 <dev@benjarobin.fr>
Subject: Re: [PATCH v2] ntp: Make sure RTC is synchronized for any time jump
In-Reply-To: <20241027174335.60261-1-dev@benjarobin.fr>
References: <20241027174335.60261-1-dev@benjarobin.fr>
Date: Tue, 29 Oct 2024 17:03:04 +0100
Message-ID: <87zfmm28xz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Oct 27 2024 at 18:43, Benjamin ROBIN wrote:
> Follow-up of commit 35b603f8a78b ("ntp: Make sure RTC is synchronized
> when time goes backwards").
>
> sync_hw_clock() is normally called every 11 minutes when time is
> synchronized. This issue is that this periodic timer uses the REALTIME
> clock, so when time moves backwards, the timer expires late.
>
> If the timer expires late, which can be days later, the RTC will no longer
> be updated, which is an issue if the device is abruptly powered OFF during
> this period. When the device will restart (when powered ON), it will have
> the date prior to the time jump.
>
> This follow-up handles all kernel API (syscall) that can trigger a time
> jump. Cancel periodic timer on any time jump, if and only if STA_UNSYNC
> flag was previously set (net_clear() was called).

This does not parse. previously set means it was set before the
operation. What you want to say here is:

  Cancel the RTC synchronization timer if the operation set the
  STA_UNSYNC flag.

net_clear()? I assume you mean ntp_clear(). But that's not the only way:

  do_adjtimex() can modify STA_UNSYNC via process_adj_status()

Also ADJ_TAI modifies CLOCK_REALTIME, which is why clock_set() is
invoked. That can make CLOCK_REALTIME go backwards.

>  	clock_was_set(CLOCK_SET_WALL);
> +	ntp_notify_cmos_timer(true);

>  	clock_was_set(CLOCK_SET_WALL);
> +	ntp_notify_cmos_timer(true);

>  	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);
> +	ntp_notify_cmos_timer(true);

Can we please have a helper function which wraps all of this?

timekeeping_clock_was_set(bases)
{
        clock_was_set(bases);
        if (bases & CLOCK_SET_WALL)
        	ntp_notify_cmos_timer(true);
}

?

> @@ -2714,7 +2715,11 @@ int do_adjtimex(struct __kernel_timex *txc)
>  	if (clock_set)
>  		clock_was_set(CLOCK_SET_WALL);
>  
> -	ntp_notify_cmos_timer(offset_set);
> +	/* Time jump (ADJ_SETOFFSET) is handled by timekeeping_inject_offset(),
> +	 * which calls ntp_notify_cmos_timer() to cancel NTP sync hrtimer.
> +	 * For the rest of do_adjtimex(), NTP sync flag is not cleared, so no
> +	 * need to cancel NTP sync hrtimer here. */

/*
 * Aside of the horrible comment formatting this is wrong as I pointed
 * out above.
 */

The problem here is that ADJ_SETOFFSET is handled seperately. This
really want's all to be in one tk_core.lock held section.

Just split out the inner workings of timekeeping_inject_offset() into a
helper and invoke it under the lock from both places which call it.

Same for timekeeping_advance().

Make sure to move all the audit and randomness muck outside of the
locked region.

That allows to cover ADJ_SETOFFSET and ADJ_TAI, but still fails to take
the modifications of STA_UNSYNC into account, but that's trivial to
solve because you can let do_adjtimex() indicate that change to the
caller.

Then you end up with:

     if (clock_set)
     	timekeeping_clock_was_set(CLOCK_SET_WALL);
     else
     	ntp_notify_cmos_timer(sta_unsync_changed);

or something like that. The latter makes sure that the timer is canceled
when STA_UNSYNC changed. It does not matter whether it was set or
cleared. You always want to cancel.

That obviously needs to be split into several patches, but you get the
idea.

Thanks,

        tglx





