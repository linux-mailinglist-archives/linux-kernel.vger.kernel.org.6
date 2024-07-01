Return-Path: <linux-kernel+bounces-237018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF3E91E9F0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC6E1C21A46
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD8E170855;
	Mon,  1 Jul 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sxZ6whwU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FrmkFebO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478F381C4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867688; cv=none; b=kSAIHUWllPsIJjoOtrjQpjT3nG/Hk9bP54sHXXM/in9y71q7h4cHSNImJDGwWKui4nf44NADwPbJ7BlLC5TAQIaVcTYTwSCBwUANwUPCBeF+d7HxgjdzWOKhTSgH6dmaqCOuh8KAU5DesGWl/K3WTTt96uYE82F67v8e9Mb69mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867688; c=relaxed/simple;
	bh=qB+yNI+C3XJHyXFp7MsaCdVO1syUN0fqMB845DnhQpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iMVJ5Oeqm+FJtq2PYrOct8hUDh2pYrqoqYML4efjHyXDurDg4czOCn8kljzICbZj+AFa7g1zgvDHZ0jXPLWX/NfGZt/+rwLpJBRzhB2DmcZ2VAeFGLDqArs+BAuZzRbWfRyxVI64Ly8DAvNOZ/lJACYBLmCtq6t4YWV4Tekc89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sxZ6whwU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FrmkFebO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719867684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZ70kGKilZAZhG8cvf7287O96cAQDxNGVcNjniBK7KU=;
	b=sxZ6whwUiXYy9Hx1NikSlC3FxTDtVBD5i2YQTbrKmQnCN65BWvfpOCfY/rNwakDt0mF3e4
	9Fs5W/ZoP+nFYEvIWUdWcyLNtgUS3w9y52pof+MTIGnuYr3viig84KZKL6LQR5H7DeUWRZ
	I+ulAn0sGxDcFlA616O4Pxz6KMNmMPYOEmwdBf1iNWsG4xXBeS5R9OnqgI8t/a32tGKnRs
	f7Q6l025Jvy7NIGeC/MD5pajSUQzKlm5syG81+hOUonfWjGR6pVFCPDTkpAVh2Lv8F/hmS
	k2YeZ4zwRK8FVwetFV4+8vFDPwXb5wXqznDcy5CzX8RmGkGSx5OldjG2SJJb9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719867684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PZ70kGKilZAZhG8cvf7287O96cAQDxNGVcNjniBK7KU=;
	b=FrmkFebOZcQxYsnOmb6L2ABZCbPtZJrVVQ+BqoMBIaHRMx/haZXKFCii7l4NOJ28fiRMb8
	y673U8qcsNAY6fDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 12/18] printk: Add kthread for all legacy
 consoles
In-Reply-To: <ZoLMRQhrwZnWMuj9@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-13-john.ogness@linutronix.de>
 <Zn6iq3n2ggL138Gs@pathway.suse.cz> <87cyo1xnmw.fsf@jogness.linutronix.de>
 <Zn67hDCEHdgtYPv3@pathway.suse.cz> <877ce9xim6.fsf@jogness.linutronix.de>
 <874j9dxdr0.fsf@jogness.linutronix.de> <ZoLMRQhrwZnWMuj9@pathway.suse.cz>
Date: Mon, 01 Jul 2024 23:07:23 +0206
Message-ID: <87a5j0kesc.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-01, Petr Mladek <pmladek@suse.com> wrote:
>> I have a new proposal. What if we allow boot consoles to always print
>> in the caller context (for any preemption model)? I hacked a quick
>> test together by providing console_flush_all() an extra argument for
>> printing _only_ on boot consoles. Then in vprintk_emit(), I always do
>> a boot-console-only-flush (under console_trylock) after storing the
>> record in the ringbuffer.
>> 
>> For PREEMPT_RT this is horrible. But I am OK with mandating that RT
>> scheduling cannot be guaranteed with boot consoles (just as it is
>> currently mandated that RT scheduling cannot be guaranteed in
>> emergency situations). Since the boot consoles are lockless, they
>> pose no deadlock threat to RT.
>
> Is this really the case for all boot consoles?
>
> I had the feeling that some boot consoles actually used port->lock.
> And for example, register_earlycon() is initializing this spin lock.

Doing a naive search, it seems like there are a few that do some spin
locking:

- alpha/kernel/srmcons.c
- tty/hvc/hvc_xen.c
- tty/mips_ejtag_fdc.c
- usb/early/xhci-dbc.c

I will need to look at these in more detail.

>> - We get true synchronous printing when using boot consoles (which
>>   should make peterz happy).
>
> Well, Peter's mode is really special because it is done without
> the console_lock(). Every printk() is flushing its own message
> to the console. Parallel printk()'s are busy waiting for each other.

This is also what I would like to see. For debugging purposes (which is
the purpose of CON_BOOT) this mode of operation is probably preferred.

>> Looking to the future, I think this would also provide an excellent
>> foundation for the "sync" console option I would like. For nbcon
>> consoles with the "sync" option specified, it would work the same
>> way, flushing boot consoles and nbcon consoles directly in
>> vprintk_emit().
>
> The sync mode would be nice.
>
> Just to be sure. I guess that you are talking about a sync mode
> using some trylock mechanism where the current owner would be
> responsible for flushing everything.
>
> Peter Zijlstra's mode (serialized printk()) is easy to implement
> and might be needed in some situations. But I am not sure if
> it would be good enough for most other users preferring the
> current "synchronous" output.

I have always envisioned it being a true sync mode. Each console has its
own nbcon state. So if it was set to sync mode, vprintk_emit() could
local_irq_save() and then busy-wait until it acquires the nbcon state
for that console. There would be no handovers and no relying on another
context to print your message. It would be straight forward and truly
synchronous (for that console). Back to the roots of printk().

> Well, let's see what people request after they get some experience
> with the first nbcon consoles and kthreads.


