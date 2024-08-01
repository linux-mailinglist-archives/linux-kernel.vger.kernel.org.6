Return-Path: <linux-kernel+bounces-271413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 560EF944DE0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8081F24A87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE01A4B2C;
	Thu,  1 Aug 2024 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FVk1uT5v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oMIStrT0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A093C16DECD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522153; cv=none; b=ufMLS5JRnTOCFFC+vd1tgf+wEp/Q5r1NUnpdi76A8MjFmBq16EaG+JKkuO8ubQ+13zhRQrGEBSr+B1csLex7ggATLAY60xC71Z22uouI8oD5GiSEDneK8AmUWxS1bgsNxudNDAjUBSvtAc1AW/YYnKjVrKW5eBtoXMq5nQx90ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522153; c=relaxed/simple;
	bh=WXlbsm8Ymu+R94UIcr3gCVF/oF+DZOLLyvULEUPqkf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=akv+2r/3qQ7j2MywFAMja7bIpXDVoKBiR3FkjjD+G1PRC3Y12JmRS26bU7FNDM2XKivKPGFpqMFhq6LX1HDldtC0DKocBSqXlpgda6S+XrwvfEIF4zfhkkq4yfGgvj5uXrVZ/utNjFu6AAGC0f+S9RyYfE20E48Ey4Dp6/WusF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FVk1uT5v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oMIStrT0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722522149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gaHaU3IkY2Jf1nPS7uPoGLEx+hVc1fctaQkNhB2/9zE=;
	b=FVk1uT5vVL21I6rdp17UGa1sAr4wYJovTjrvptv6iJEzCGkpqEMRxrqmw0NOp0AbQL+hFJ
	tFrZ9L4R/rM1TIJwmpXZz3IJ65f150A7YCqqc8rmSuj8HmIaHr/DRAtyUV9RM27rr6AtAW
	LsiARXfdV6Oru4vGI+/9zSzg6gpgmSyHIk+IBq34gTKc6zX2JM8b5FXoD7SH9vXdqf87O2
	OU+5MRae1vCKjos6I6TihIteOXfrIBgA6n1wOBuhw5svnXbtxx8MeChLWs4a8Yf2Ph5KTj
	U9LMFauHmLqYbGa+eE2S35jgywD2MGCHjT0OqZjTphUC/hzWZ5AODN8WSxqzbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722522149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gaHaU3IkY2Jf1nPS7uPoGLEx+hVc1fctaQkNhB2/9zE=;
	b=oMIStrT0nlaGgGZcECQKvH3QlDQj6GhwbCrnUbyoCpm7RRYGgr1jc/3QhAgCs0zCbNUNwJ
	7Fdy5+WjY32+lhBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: preffer_ofload param: was: Re: [PATCH printk v3 11/19] printk:
 nbcon: Rely on kthreads for normal operation
In-Reply-To: <ZqpAJgKeB0cIlTg7@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-12-john.ogness@linutronix.de>
 <ZqpAJgKeB0cIlTg7@pathway.suse.cz>
Date: Thu, 01 Aug 2024 16:28:28 +0206
Message-ID: <8734noz5jv.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-31, Petr Mladek <pmladek@suse.com> wrote:
>> @@ -1511,10 +1511,10 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
>>  
>>  	/*
>>  	 * If flushing was successful but more records are available, this
>> -	 * context must flush those remaining records because there is no
>> -	 * other context that will do it.
>> +	 * context must flush those remaining records if the printer thread
>> +	 * is not available do it.
>>  	 */
>> -	printk_get_console_flush_type(&ft, false);
>> +	printk_get_console_flush_type(&ft, true);
>
> Hmm, it is a bit weird that we change the value even though it does
> not affect the behavior. The parameter @prefer_offload affects only
> the legacy loop.

For nbcon consoles, prefer_offload is really only annotating the
intentions. In this case, nbcon_atomic_flush_pending_con() is interested
in knowing if kthread printer is available, thus using
prefer_offload=true.

If the query yields ft.nbcon_atomic set, it means that the kthread
printer is _not_ available (nbcon_atomic and nbcon_offload are
exclusive) and it can (and must) handle its flushing responsibilities
directly (immediately, using the atomic callbacks).

You might ask, why does it not check ft.nbcon_offload? Although that
would tell it that the kthread is not available, it does not imply that
atomic printing is allowed. In order to see if atomic printing is
allowed, it would need to check ft.nbcon_atomic. And since the two are
exclusive, really it is enough just to check ft.nbcon_atomic. If
ft.nbcon_atomic is not set, either the kthread is available or there is
nothing the nbcon console can do about it anyway (for example, it must
rely on the legacy loop to handle it).

I suppose it is wrong that nbcon_atomic_flush_pending_con(false) will
set ft.nbcon_offload if the kthreads are available. I would fix that.

> IMHO, __wake_up_klogd() is the only location where we really need
> to know if there are any messages for the legacy loop, for example,
> when called from printk_deferred().
>
> It should not be needed in other situations because it there
> is always __pr_flush() or console_unlock() which would flush
> the legacy consoles directly anyway.
>
> => I suggest to
>
> 1. Remove @prefer_offload parameter from printk_get_console_flush_type
>
> 2. Update __wake_up_klogd() to check both ft.legacy_offload and
>    ft.legacy_direct, like:
>
> 	printk_get_console_flush_type(&ft);
> 	if (!ft.legacy_offload && !ft.legacy_direct)
> 		val &= ~PRINTK_PENDING_OUTPUT;
>
>
> NOTE: I actually suggested to use in vprintk_emit():
>
> 	printk_get_console_flush_type(&ft, deffer_legacy);
>
>       But it can be done even without this parameter. Like it
>       is done in this version of the patchset.

I understand what you are saying. But I don't like it. :-)

It would mean that functions only interested in offloading must check
direct. And that direct and offload are no longer exclusive. IMHO this
is a hack. The whole point of printk_get_console_flush_type() is so that
the flusher does not need any special code to figure out what to do.

If the flusher is only interested in offloaded flushing capabilities, it
should be able to query that. We could wrap things into macros to make
it clearer, but it might get a bit ugly with the efficience (depending
on how well compilers can optimize the macro usage):

#define is_nbcon_offload_available() ({			\
	struct console_flush_type ft;			\
	printk_get_console_flush_type(&ft, true);	\
	ft.nbcon_offload;				\
})

#define is_nbcon_atomic_available() ({			\
	struct console_flush_type ft;			\
	printk_get_console_flush_type(&ft, false);	\
	ft.nbcon_atomic;				\
})

And then this code looks like:

if (prb_read_valid(prb, nbcon_seq_read(con), NULL)) &&
    !is_nbcon_offload_available() &&
    is_nbcon_atomic_available()) {
	/* flush directly using atomic callback */
}

I have backported the printk_get_console_flush_type() macro to the
atomic series for v7. I would like to keep @prefer_offload and I will
try to add comments to clarify why the different query types are used.

John

