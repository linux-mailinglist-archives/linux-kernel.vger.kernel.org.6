Return-Path: <linux-kernel+bounces-304041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2BE961909
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6E21C22B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071111D4157;
	Tue, 27 Aug 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2k7KNHjV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xMSEyhyp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF31D414B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793220; cv=none; b=Z7t2I3vEv/eeXkTSOZUMlMcSFJ88N35jv1HWtJf+5X9jICXeVOWO0jPyPPDMOimx0v7JPz4tqwKl1lJIGJTXzKNSkeEu5mnXAfC3EC7Lel7UMGT45nrvOqkMysivea5mIz/KyBGFU2nCGeot5zI2dWEvedGF22hjKh76zCUce9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793220; c=relaxed/simple;
	bh=KXW547sRSDkgs/B9YTOs7FydyemildDKNUb9DoMPyI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KZuP4CtHufYsk+anWHEn0TyUve80VLGRAmwwanGiuMIAhqK/R3mw3W1mM4w/gWDfMWoWAQ9ZTR6DwhH7Qdfil+NI1qwwJUt9SlJ5gZd6yGpROby9z5dUzWpbjXlCUQ0+DnPNz3JQN48Oj8yZ6rcIdXw2tKR2hVFoUiF0rJZsGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2k7KNHjV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xMSEyhyp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724793217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y7WsAN0plIc4npI3dPY0qnxNfjMaysVK4Aa12R7UB3A=;
	b=2k7KNHjV0cgNBn/UhApoSZj4LCw+PA3JnLlKRg4aXuWAIeMDslQ5hyWwF7Bz14P1weuwUI
	1TFz4Krv/R9ivkDXa4yTZGI3ZbHR86VLWpxn7t5NTvkG4LDgZnwLOwzh+kiSQXISXmNb/r
	KZiUk73iY1gBPjHZCit4xrWt/3kzZYv38UU/silDfEexGLxsyR6eui6FeQkqraNiAbHQ3F
	md2sxQs3wQUOeQ2BsmugBuDPeQDfQYS+XyzuBKd8pSqzdon83DJ+B7ut/Bu1dHYFvmE97C
	FFmWltgaKw8df5rpjcFsEOcbD3uctDglL4cdhiyjKKlMVVWp9cmGUFVZ3KBagw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724793217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y7WsAN0plIc4npI3dPY0qnxNfjMaysVK4Aa12R7UB3A=;
	b=xMSEyhypdZSQH1sSdpOCnard0SD0u2aa/qGen/Ah0oihgNkVVbyEJmS5hqJHNffyq02fQ3
	b51cfmmYVC52l0Cw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 09/17] printk: nbcon: Rely on kthreads for
 normal operation
In-Reply-To: <Zs31xM0Nn0hEb74O@pathway.suse.cz>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
 <20240827044333.88596-10-john.ogness@linutronix.de>
 <Zs31xM0Nn0hEb74O@pathway.suse.cz>
Date: Tue, 27 Aug 2024 23:19:36 +0206
Message-ID: <871q298y9r.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-27, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2749,6 +2753,10 @@ void resume_console(void)
>>  	 */
>>  	synchronize_srcu(&console_srcu);
>>  
>> +	printk_get_console_flush_type(&ft);
>> +	if (ft.nbcon_offload)
>> +		nbcon_kthreads_wake();
>
> Who would flush the nbcon consoles in the following case?
>
>   ft.nbcon_atomic == true && ft.legacy_direct == false
>
> pr_flush() won't call the legacy loop in this case.
>
> We should probably update pr_flush() to call nbcon_atomic_flush_pending()
> in this case.

Agreed.

>> @@ -3387,9 +3405,25 @@ EXPORT_SYMBOL(console_stop);
>>  
>>  void console_start(struct console *console)
>>  {
>> +	struct console_flush_type ft;
>> +	bool is_nbcon;
>> +
>>  	console_list_lock();
>>  	console_srcu_write_flags(console, console->flags | CON_ENABLED);
>> +	is_nbcon = console->flags & CON_NBCON;
>>  	console_list_unlock();
>> +
>> +	/*
>> +	 * Ensure that all SRCU list walks have completed. The related
>> +	 * printing context must be able to see it is enabled so that
>> +	 * it is guaranteed to wake up and resume printing.
>> +	 */
>> +	synchronize_srcu(&console_srcu);
>> +
>> +	printk_get_console_flush_type(&ft);
>> +	if (is_nbcon && ft.nbcon_offload)
>> +		nbcon_kthread_wake(console);
>
> Same here.
>
>
>>  	__pr_flush(console, 1000, true);

Agreed, via adding nbcon_atomic_flush_pending() within __pr_flush().

>> @@ -4629,8 +4665,13 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>>   */
>>  void console_try_replay_all(void)
>>  {
>> +	struct console_flush_type ft;
>> +
>> +	printk_get_console_flush_type(&ft);
>>  	if (console_trylock()) {
>>  		__console_rewind_all();
>> +		if (ft.nbcon_offload)
>> +			nbcon_kthreads_wake();
>
> And here. We in this case, we should likely call add here:
>
> 		if (ft.nbcon_atomic)
> 			nbcon_atomic_flush_pending()

Agreed.

You once mentioned having a generic flush function that simply evaluates
the flush types and then executes them appropriately. It would be nice
to get rid of all/most these individual eval/flush snippets.

At a quick glance, the significant variations are:

- for legacy_direct: console_trylock() vs. console_lock() usage

- only performing direct/atomic flushing

- only performing offload flushing

- vprintk_emit(), console_start(), nbcon_device_release() are special

The first three variations could all be covered by arguments to the
generic flush function:

void console_flush(bool do_direct, bool do_offload, bool may_sleep);

or by packing it into bits/macros for readability, with call examples
such as:

console_flush(CON_FLUSH_OFFLOAD);
console_flush(CON_FLUSH_DIRECT | CON_FLUSH_OFFLOAD);
console_flush(CON_FLUSH_DIRECT | CON_FLUSH_MAY_SLEEP);

Such a function would have avoided the issues you found in this review.

John Ogness

