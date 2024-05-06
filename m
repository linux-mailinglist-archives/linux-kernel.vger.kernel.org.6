Return-Path: <linux-kernel+bounces-169667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F58BCBFE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0AD1F2223A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062651428F5;
	Mon,  6 May 2024 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jt1Rqg3r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mjX2g5On"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC043AA5
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991254; cv=none; b=BqBaPGBXRxmFPpMIISnnuTXCkDug5GRfpEDSNjQv71jX6Zh/xhHU5CObsWNRK08zD0kmWqwiyrQkdIe2y8Be3466YAvr97PAuQpGwtICZLWs/d0cXZ8d2VTFMZWwX4q4d3mZKJEMbdTXFO1e3JI6gaXajaGwArUDsDD8hPM9Ges=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991254; c=relaxed/simple;
	bh=O7CuAc53qoweqFaCbds+l7yVEfHtaHVes11Wpj9zS7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eRyKlj0fuIJog9Y6fYUR8QkthFW2s8ITD+BGJob1FgsbSlxK3wdsgz6J2HWBQOXGnWRBK3xz8vG8sOZnV1osb/hLVVZZwWnUxSQXEm96qLQ7do3xINYy2kF++4RHXY+QueOt9yMT21ruTS2ZRvqTstDPr02siuyv5pECoiSF8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jt1Rqg3r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mjX2g5On; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714991251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NDblSiaqpXJLG2pJGM/FfvdmGrpG1TyOiQ39YQ89Y4=;
	b=jt1Rqg3rUcr2x//xCIkj/DmSwTF4YCG/WoUTSP5KMj1z2eNBm4xVFkTuwDEq0LVXsJFjCY
	VR7zhnBeZdRJROsCzgRBt0D+RVIjye7++bQb9jK1KYcZPwSKTzmtLhXtjmI4U07IV82rON
	CSNBpVw6EHDS3GAwy2cO6IYMO/DIp6bT+Xf9eROYUzHdegG+uTFYTAJeV2NTgSrDLtR7HN
	UyNEsB/GxPv/Q4YTsHEZoJ9S9rnQFX0em2NTGuRzcH/uzvAKVCUkhaCiMeU8OVvpy5PGRy
	wAggfG3MKZnBpq/8osuxvnJLQ6DPpWQGjMF+AOY4dF9QbNwdX9ybvfqokwQWuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714991251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NDblSiaqpXJLG2pJGM/FfvdmGrpG1TyOiQ39YQ89Y4=;
	b=mjX2g5On2ZMcJAJ3QpJEJNpSOWkXQQZIsloslp447SB9UZcaDTW5Ng4odD75+RYij0772A
	b5Lo9BEtnT9dkJDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 07/30] printk: nbcon: Use driver
 synchronization while (un)registering
In-Reply-To: <20240502213839.376636-8-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-8-john.ogness@linutronix.de>
Date: Mon, 06 May 2024 12:33:28 +0206
Message-ID: <87msp3i6b3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-05-02, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e6b91401895f..15d19d8461ed 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3537,6 +3538,19 @@ void register_console(struct console *newcon)
>  		newcon->seq = init_seq;
>  	}
>  
> +	/*
> +	 * If another context is actively using the hardware of this new
> +	 * console, it will not be aware of the nbcon synchronization. This
> +	 * is a risk that two contexts could access the hardware
> +	 * simultaneously if this new console is used for atomic printing
> +	 * and the other context is still using the hardware.
> +	 *
> +	 * Use the driver synchronization to ensure that the hardware is not
> +	 * in use while this new console transitions to being registered.
> +	 */
> +	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
> +		newcon->device_lock(newcon, &flags);
> +
>  	/*
>  	 * Put this console in the list - keep the
>  	 * preferred driver at the head of the list.
> @@ -3561,6 +3575,10 @@ void register_console(struct console *newcon)
>  	 * register_console() completes.
>  	 */
>  
> +	/* This new console is now registered. */
> +	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
> +		newcon->device_unlock(newcon, flags);
> +

Rather than writing the conditions twice, I will add a local variable
and check that instead.

bool use_device_lock = (newcon->flags & CON_NBCON) && newcon->write_atomic;

..

if (use_device_lock)
	newcon->device_lock(newcon, &flags);

..

if (use_device_lock)
	newcon->device_unlock(newcon, flags);

> @@ -3607,8 +3626,18 @@ static int unregister_console_locked(struct console *console)
>  	if (!console_is_registered_locked(console))
>  		return -ENODEV;
>  
> +	/*
> +	 * Use the driver synchronization to ensure that the hardware is not
> +	 * in use while this console transitions to being unregistered.
> +	 */
> +	if ((console->flags & CON_NBCON) && console->write_atomic)
> +		console->device_lock(console, &flags);
> +
>  	hlist_del_init_rcu(&console->node);
>  
> +	if ((console->flags & CON_NBCON) && console->write_atomic)
> +		console->device_unlock(console, flags);
> +

Ditto for unregister_console_locked().

John

