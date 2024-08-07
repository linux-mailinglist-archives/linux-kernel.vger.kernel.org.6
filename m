Return-Path: <linux-kernel+bounces-278021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C494A984
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEE1280D9A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A051039FFE;
	Wed,  7 Aug 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oheWyQBM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xSaLPbez"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374528399
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039914; cv=none; b=rjfuwXA19Bk3cwdBli3AScku8+WM2Eu8/xaeYmZKkRtnrKuNucHflsmYYS9KRPydA9y+thMpKuFwjDAE9sI2RukKsA7g9UYGY6jgGJtCJejKAlzcfdLtmCupj+LLKNCkVzk/xK4r2S7s9dFIB7YI6YxpukMbIlmaS6agNmk22I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039914; c=relaxed/simple;
	bh=vRRU7EOYazizOoY3qdicbHX7zveXmxX8FSHnVkmj9gc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jA62qZNsRAQSEi90F/G9FuUB41/jYunEuU0RU07b1FRoIHGNjtMkdOPqHn9GYwSvL/Rmuf5TEurB9WeEdi8eoa2iJG99nlcnU9pN4wdenWEmjs8lwrNcFUKrCFXYUEdJw8bq2FLGltxfqd+aoYthk3gAyDQms7iAxOdB2OAyiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oheWyQBM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xSaLPbez; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723039911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HUYAMeejBq+6dWwULzKkxmmdiZjAXsl6Rcbo+GWpq/g=;
	b=oheWyQBMIGZ8fgW2TrheSvdEKVvH4heica9j6j6dYMVVwdYiFK5eAlSzWRz/b1E8mH6Gnw
	zhKzFQ48deHdsnbLQuaSUS9IYIXOW5T7I/yNiW9JFOLRrwTv/eK1KLyGXaHFk6w3h/P/jD
	X/HzwH7MIBbaz5yBp7bNPviuD/Kx3ZF7mrIhSY4PM2M8iIbbfYsSdlwEBiNlzn+RckR51R
	OO1B1AbewtKrvUUGmR7XOoTgDAXG4Fo9y2znZtyTSQRG8VVABh8u2p1WiVy6TdIiIiJa0q
	3Z16wOrdeXrHCZRkSc8sNDp41wvo7gRXIx8xrcPpHG9lRFD5RJn5MgMgw4wrjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723039911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HUYAMeejBq+6dWwULzKkxmmdiZjAXsl6Rcbo+GWpq/g=;
	b=xSaLPbezn9i9PTGio2/ZCJyD5ZI5E/8qZ100L0IVXzByZ1hHCwv4Zv+IxU2PZgt6wfP/YP
	8zjGKOKnxKi6FtCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v7 30/35] printk: Add helper for flush type logic
In-Reply-To: <ZrNcr5-uZoQnSHii@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-31-john.ogness@linutronix.de>
 <ZrNcr5-uZoQnSHii@pathway.suse.cz>
Date: Wed, 07 Aug 2024 16:17:51 +0206
Message-ID: <87zfpozal4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-07, Petr Mladek <pmladek@suse.com> wrote:
> I would suggest to change the semantic and set the _preferred_
> flush method instead of an _available_ one.

I will need to evaluate this closely. I worry that the caller needs to
understands how the helper function is choosing the preference. For
example, at the end you make a suggestion that is broken with this
suggested change.

>> +		if (ft.nbcon_atomic) {
>> +			stop_seq = prb_next_reserve_seq(prb);
>> +			goto again;
>> +		}
>
> BTW: I wonder how this code would look like after adding the printk
>      threads. We should do "goto again" only when ft.nbcon_atomic
>      is the preferred (only available) flush type for nbcon consoles.

	if (ft.nbcon_offload) {
		...
	} else if (ft.nbcon_atomic) {
		...
	}

>      IMHO, it is another reason to change the semantic.

The caller does not need to rely on the helper "choosing" the right
one. I understand your point that: It is easier for the caller when we
can blindly rely on the helper to choose for us. But I worry that if we
ever adjust the helper, we might break various call sites that blindly
rely on the helper making a certain choice. If the helper's job is only
to say what is possible, then I would worry less for the future when we
may need to adjust the helper.

>> +	printk_get_console_flush_type(&ft);
>
> It is a nice trick to call printk_get_console_flush_type() this early.
> I allows to hack the result when processing the hacky LOGLEVEL_SCHED ;-)
>
>> +
>>  	/* If called from the scheduler, we can not call up(). */
>>  	if (level == LOGLEVEL_SCHED) {
>>  		level = LOGLEVEL_DEFAULT;
>>  		do_trylock_unlock = false;
>> -		defer_legacy = true;
>> +	} else {
>> +		do_trylock_unlock = ft.legacy_direct;
>>  	}
>
> We could hack the @ft structure directly here:
>
> 	if (level == LOGLEVEL_SCHED) {
> 		level = LOGLEVEL_DEFAULT;
> 		ft.legacy_offload |= ft.legacy_direct;
> 		ft.legacy_direct = false;
> 	}

The hack seems a bit complicated to me. Especially when the helper is
choosing preferred methods. I will think about it.

>> +	if (!cpuhp_tasks_frozen) {
>> +		printk_get_console_flush_type(&ft);
>> +		if (ft.legacy_direct) {
>> +			if (console_trylock())
>> +				console_unlock();
>
> Why do we actually call only the legacy loop here?
> IMHO, we should also do
>
> 	if (ft.nbcon_atomic)
>  		nbcon_atomic_flush_pending();

Atomic consoles do not care if a CPU was online or not. I can add this,
but I expect there is nothing for the atomic console to flush. And when
threading is added, we would need the extra code to avoid atomic
flushing:

	if (!ft.nbcon_offload && ft.nbcon_atomic)                
		nbcon_atomic_flush_pending();

>> @@ -3327,7 +3316,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
>>  	if (mode == CONSOLE_REPLAY_ALL)
>>  		__console_rewind_all();
>>  
>> -	if (!have_boot_console)
>> +	printk_get_console_flush_type(&ft);
>> +	if (ft.nbcon_atomic)
>>  		nbcon_atomic_flush_pending();
>
> I would use "ft.legacy_direct" also below for the decision about
> the legacy loop:
>
> -	if (legacy_allow_panic_sync)
> +	if (ft.legacy_direct)
> 		console_flush_all(false, &next_seq, &handover);

No, because it would mean the console is not flushed if the CPU is in
the deferred state. That is why I added an extra comment in the helper
saying that console_flush_on_panic() will _always_ flush directly.

I thought about adding that extra logic into the helper, but it really
isn't possible. @legacy_allow_panic_sync does not matter if there are no
nbcon consoles. So somehow the helper would need to know that CPU is in
the deferred state, but now it is allowed to do direct printing.

So it seemed more straight forward to have console_flush_on_panic() not
care about what is allowed (for legacy). It is going to flush directly
no matter what.

I will reconsider your suggestions about the helper and also compare the
end result at the call sites (also with threading changes applied) to
see what looks simpler to maintain.

John

