Return-Path: <linux-kernel+bounces-211208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7934E904E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC801C23C89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6819916D4E9;
	Wed, 12 Jun 2024 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lkvhQpNv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HW9x/WYr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F85757F8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182276; cv=none; b=nW4rHvvXypMzxVBEszc2ndwb3P4P/EwZ3RLZYSGG1lyJdVAFldA7UCg6sZsQxMf9K1kdKww8w9k9Xhgc2Ua7pnQvsaR03dgwwDmpP1LBdy05muHLZ1jMfp3oVxc1iTnaWHQRIAwM6O0mwwzUQc1G6yE7lftf0CWPKFf/E36FmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182276; c=relaxed/simple;
	bh=495m9HxPHYr/5H74fGx8CTczkWpY7LDCUx73meagEvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iuhumyVXSFGCjtVxgPwnZjTASF9ELFNEgPcFXaV/HKPayDjtojyXCgCwWfYuEblwQyfLoRTs0BSkjBH1VXuGHnK8m23n+Gnal9Up/cU2k5Kig3rD+TT8tk8yuuG6g94IE8au/x5UnBQmMuSLhfMomMxrC/UhagWzs3/oycNpRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lkvhQpNv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HW9x/WYr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718182272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gL2d9RypHwCJaSs5JDV9EMRa6x7TrwKPMjwS58c1CoM=;
	b=lkvhQpNvvEw+Wvno/G/oKIGrXNGmohWAQZDOoSYCkHxObRRQgomoRoC4wCllyMO1qLSwii
	tAutj/GN0HqjGeTIcRcFjq4MPhZJljFoQ1IzJlCEIC+J0i+TwfQvjinp35w/H0TL/d3kfo
	fEzKscaXEaN1mw9j66PK609IUDBpH0vu1a1SDD10hMs8BP9A9mbThMRAWdezg1dsI5q+N4
	QCNio1YuFtGRJA+KQmjOKmZk0tEZ6cJ6RPEgcUCatb9G5xi02rPWiJvuA5zH9aWbYHIEq7
	qNei+1NKKdfyrk8QsiSPJbvdIJCR5bzKsWfmYs40Wmmu3wuubUoBXx4akp627A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718182272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gL2d9RypHwCJaSs5JDV9EMRa6x7TrwKPMjwS58c1CoM=;
	b=HW9x/WYrqhzuf2b6wLUCEt3bM0EfijQ4QZr1vthAmj74k9Sx0Pl6Xu+ifI7xES1XBlXMKR
	37fkt3N782bSOoDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/18] printk: nbcon: Introduce printing kthreads
In-Reply-To: <ZmhkVAC_3FMohrEr@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-5-john.ogness@linutronix.de>
 <ZmMIOWEAMgXz4j-U@pathway.suse.cz> <87ed95j8yh.fsf@jogness.linutronix.de>
 <ZmhkVAC_3FMohrEr@pathway.suse.cz>
Date: Wed, 12 Jun 2024 10:57:11 +0206
Message-ID: <87sexipmrk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-06-11, Petr Mladek <pmladek@suse.com> wrote:
>> During normal operation, the inner safety (console context) will never
>> be contended. That really only exists to synchronize the atomic case.
>
> I see. For example, the spin_lock_irqsave() in __uart_port_lock_irqsave()
> will be sleeping lock in RT => preserving RT guarantees. And it will
> make sure that the inner nbcon_context_try_acquire() would never
> have to spin => never break the RT guarantees.
>
> It makes perfect sense. Do I get it correctly?

Yes.

> Well, I would still like to describe the role of device_lock()
> for write_kthread(). It would help even me to create a better
> mental model ;-)
>
> What about the following?
>
> <proposal-2>
> 	/**
> 	 * @write_thread:
> 	 *
> 	 * NBCON callback to write out text in task context.
> 	 *
> 	 * This callback must be called only in task context with both
> 	 * device_lock() and the nbcon console acquired with
> 	 * NBCON_PRIO_NORMAL.
> 	 *
> 	 * The same rules for console ownership verification and unsafe
> 	 * sections handling applies as with write_atomic().
> 	 *
> 	 * The console ownership handling is necessary for synchronization
> 	 * against write_atomic() which is synchronized only via the context.
> 	 *
> 	 * The device_lock() provides the primary serialization for operations
> 	 * on the device. It might be as relaxed (mutex)[*] or as tight
> 	 * (disabled preemption and interrupts) as needed. It allows
> 	 * the kthread to operate in the least restrictive mode[**].
> 	 *
> 	 * [*] Standalone nbcon_context_try_acquire() is not safe with
> 	 *     the preemption enabled, see nbcon_owner_matches(). But it
> 	 *     can be safe when always called in the preemptive context
> 	 *     under the device_lock().
> 	 *
> 	 * [**] The device_lock() makes sure that nbcon_context_try_acquire()
> 	 *      would never need to spin which is important especially with
> 	 *      PREEMPT_RT.
> 	 */
> </proposal-2>

OK. I will use this.

>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3995,6 +3995,8 @@ static int unregister_console_locked(struct console *console)
>>  	if (res > 0)
>>  		return 0;
>>  
>> +	__pr_flush(console, 1000, true);
>> +
>>  	/* Disable it unconditionally */
>>  	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
>
> Makes sense.
>
> And it actually means that it is too late to flush messages
> when kthread_should_stop() returns true. So, it does not matter if
> we check it in the while(backlog) loop or not. Well, it might be
> worth a comment in the code.

I will add a comment for this.

>> The thread failing to start is a serious issue. Particularly for
>> PREEMPT_RT.
>
> I agree.
>
>> Probably it should be something like:
>> 
>> 	if (WARN_ON(IS_ERR(kt))) {
>
> Might make sense.

I will add this for v2.

> Honestly, if the system is not able to start the kthread then
> it is probably useless anyway. I would prefer if printk keeps working
> so that people know what is going on ;-)

OK. For v2 I will change it to fallback to the legacy printing for those
consoles that do not have a kthread.

> After all, I would add two comments, like these:
>
> <proposal-2>
> 	/*
> 	 * Any access to the console device is serialized either by
> 	 * device_lock() or console context or both.
> 	 */
> 	kt = kthread_run(nbcon_kthread_func, con, "pr/%s%d", con->name,
> con->index);
> [...]
>
> 	/*
> 	 * Some users check con->kthread to decide whether to flush
> 	 * the messages directly using con->write_atomic(). But they
> 	 * do so only when the console is already in @console_list.
> 	 */

I do not understand how @console_list is related to racing between
non-thread and thread. kthreads are not only created during
registration. For example, they can be created much later when the last
boot console unregisters.

I am OK with the first comment of this proposal. I do not understand the
second comment.

> 	 con->kthread = kt;
> </proposal-2>

John

