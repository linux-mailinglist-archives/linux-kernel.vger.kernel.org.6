Return-Path: <linux-kernel+bounces-233994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC72491C086
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A8D1F2186D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0091BF311;
	Fri, 28 Jun 2024 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HEqMAkNO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/tv6x01s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF8819B5A2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583877; cv=none; b=NUM/i/JPIHRThmNzBsIp62knj2fgeY6pfHSIciqd3+Iswxyibd4fUhBeNIldgKPVZIAb2F4REgN+gs5CYiPnB5AE2uygbxdJLv1tR8Oji5MBPK41XxIkGbu9sXa3Gh8HVKZFDWXBJfuYoU6TIX5rMHd3xFOPrKLZpuLUIh3LZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583877; c=relaxed/simple;
	bh=z0Z6+L/8dFrrvyR8eVGAuh87cInBmCHWpD/EUJPQNFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HUaNup6Wy0R2xRlELzP+GJMvnfcBgnORV4x6z08DBUJJztwEx9msyAUFAKrdFMCENIkbSIG6Prb1ABpkULpuovRDGXUMw4dGCRlqedwbng0sGvg5G4cI3H42F11T5F/dSYZMSEdaVXXNw1WefjcCrvrIXlisnePpQRG2N0VfMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HEqMAkNO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/tv6x01s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719583874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WfnJBJaJKRfMnoTosqnImnuIvhFpBT55UVzSmIC18b0=;
	b=HEqMAkNOsIxlX+e8E9AxdPhoSapNz5c7ZfBzaTJ/xAEZwIVd5o8PI1iKavrpmahfpxU4EU
	kYbpLSf0IBVhYhHoNvzBI/EFz2AwXEURu5RbhHF94b0yAs4noNmBAtJAumgZPANdfjVQCh
	Hv7gWDwJ4+wTW8wu4bo8MPPgBzMDXwToNuJ5kCa+PDqTsyMybT9lOn8JOE8ZeoevfsOpza
	G9fG6rO3WRmiyc6quHQCol3j9V7CedvOvk2aSUSoA97aOYjOwRHJpvIkFQzzzmDNTJF98g
	TvdHP67OwbavmkqPHMEb36b/HbXalhSmwN/CyZUskvVhsHdyXOKDXTeJHDsw8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719583874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WfnJBJaJKRfMnoTosqnImnuIvhFpBT55UVzSmIC18b0=;
	b=/tv6x01s1EgwEJdiM5wenpXhkXhHl1sxyr4md1mp5i1qa5A3aCkR+q6EvMKFICSvGf+s1j
	zspQVUWx+sAGZQDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 12/18] printk: Add kthread for all legacy
 consoles
In-Reply-To: <Zn67hDCEHdgtYPv3@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-13-john.ogness@linutronix.de>
 <Zn6iq3n2ggL138Gs@pathway.suse.cz> <87cyo1xnmw.fsf@jogness.linutronix.de>
 <Zn67hDCEHdgtYPv3@pathway.suse.cz>
Date: Fri, 28 Jun 2024 16:17:13 +0206
Message-ID: <877ce9xim6.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-06-28, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2024-06-28 14:28:47, John Ogness wrote:
>> On 2024-06-28, Petr Mladek <pmladek@suse.com> wrote:
>> >> @@ -1494,7 +1508,9 @@ void nbcon_cpu_emergency_exit(void)
>> >>  		 * to handle it.
>> >>  		 */
>> >>  		do_trigger_flush = true;
>> >> -		if (printing_via_unlock && !is_printk_deferred()) {
>> >> +		if (!force_printkthreads() &&
>> >
>> > Is this correct? We still need to flush the messages directly
>> > when the legacy kthread is not ready yet.
>> 
>> No! If force_printkthreads() is set, messages will never flush directly
>> except for console_flush_on_panic().
>
> But this is an _emergency_ context! This would be inconsistent with
> the nbcon consoles where the messages are flushed directly.
>
> Is RT sheduling quaranteed when the system reached emergency state?

No.

> In fact, we probably should not check force_printkthreads() here at
> all. It would be only for NBCON_PRIO_NORMAL context.

On PREEMPT_RT, legacy consoles are not allowed to print from
non-preemptible contexts because they use spinlocks (rtmutexes).

This is a disadvantage for legacy consoles on PREEMPT_RT. If people want
a legacy console to gain the reliability attribute on PREEMPT_RT, then
that console _must_ be converted to nbcon.

force_printkthreads() is used to establish the same console printing
behavior as PREEMPT_RT. (A later patch makes this behavior available to
all preemption models so that users can enjoy the non-interference
attribute of the rework.)

>> For the next version, any failed
>> thread creation leads to unregistering the console. In the case of the
>> legacy thread, it will mean unregistering all legacy consoles on
>> failure.
>
> It means that the system would become silent. Is this a good idea?

In the threaded model, the thread is a critical component of the
console. If the thread cannot start, it is the same as if memory could
not be allocated. The registration must fail. And just as it is now, the
user will only see that it failed via dmesg (or some other console that
did not fail).

> IMHO, we have a fundamental problem here.
> Are RT guarantees more important than printk() or vice versa?

That is not the issue. The problem is that you want legacy consoles in
RT to print without the printing thread. That is not possible. Those
drivers are not RT compatible and will cause deadlocks. They _must_ be
modified i.e. converted to nbcon consoles.

We have worked really hard to allow legacy consoles to work "as is" for
!PREEMPT_RT. But when PREEMPT_RT is enabled legacy consoles must be
forced into the thread (except for panic, where we close our eyes and
hope for the best).

John

