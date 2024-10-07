Return-Path: <linux-kernel+bounces-353241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C148992B26
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8251F23756
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DAB1D2223;
	Mon,  7 Oct 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cd1pGCY2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cQZugCeo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276418B483
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303094; cv=none; b=BaOV+l7XjZx7386d4ZhOQGzfm1903to+87sdIlTVIDW6k1RsdGthxXtqREcLPouvoy1ahOfnW2tOp7bXtf+AYiSEiPsMGboGcNSxKfZWArMMwRtvrTt8kfY7x896bI0m9kcrvQVVqbZkakpmtcNBK0t7CjSAlbUR1fayScIQB6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303094; c=relaxed/simple;
	bh=Zn/Wpnj3cwhJhWqS4LkHHMLONniIADYAf1ITLlgSsVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kgzHtMLgQvzojxphDqmND7S3qah2gBPD2etDjsAy1o7YYBtuXq8gowjiT4jqDWT+zZiXonEn2UYpDrYftPmqCd5zOV0RBwtEdSxSXFYKjTslif9GCPJ8tAjU2x236Hx5gK0/nIDc7dC0PPZKP5YFwHDy9yTTHdPavmd/OT4On3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cd1pGCY2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cQZugCeo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728303090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTRX2E/caJSxKYAG5qhU4BSqcKSEG/mvB3eZdZUAjNw=;
	b=Cd1pGCY2rRH4/r3JCYid6w5CYbQAiFtE7m/HhTJfHR1BvvIl/ztvV8ArnIGcamYSMoU8u+
	E1wDMkp6CXlrZxw/ByTLaC4dkJB+DG/oeecF4XYBHqhxa8ARWDPVj+Br3jq23HOCjA/FfG
	wUokjGCM65RoFBExrKWUCvGRJhvu4I6cB0Kocu/BZsX5HVTWjITNCBeRnQcY1e5lpa9KnK
	vRDEJOnrwgfKo79MC2r0DyaBUDE9Pw96R9mJ6VGlxDVAcG+xjQQV9hz+L1qDLxgnm76eDi
	DPJkn4SIq2GJay1e1m0C1noFheryNHhOEktNqekoAfIsylOFIGDRoiWET4dKSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728303090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTRX2E/caJSxKYAG5qhU4BSqcKSEG/mvB3eZdZUAjNw=;
	b=cQZugCeoyWlmXCJm8AkTUnsx6nT4BsMGMCvlJvo2rTWpUIN3rqnm7NXKvoPOP3EHFhhIRU
	0N6+pMbDhRhiTaAA==
To: Bart Van Assche <bvanassche@acm.org>, David Laight
 <David.Laight@ACULAB.COM>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King
 <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 07/21] hpet: Switch to number_of_interrupts()
In-Reply-To: <cb045717-5eb8-456f-aa50-667e9f8aabfd@acm.org>
References: <20240930181600.1684198-1-bvanassche@acm.org>
 <20240930181600.1684198-8-bvanassche@acm.org>
 <b315cbe2e1264d98b57ce57fe5f66a23@AcuMS.aculab.com>
 <cb045717-5eb8-456f-aa50-667e9f8aabfd@acm.org>
Date: Mon, 07 Oct 2024 14:11:30 +0200
Message-ID: <874j5oun7x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Oct 06 2024 at 17:45, Bart Van Assche wrote:
> On 10/6/24 10:13 AM, David Laight wrote:
>> From: Bart Van Assche
>>> Sent: 30 September 2024 19:16
>>> --- a/drivers/char/hpet.c
>>> +++ b/drivers/char/hpet.c
>>> @@ -195,7 +195,7 @@ static void hpet_timer_set_irq(struct hpet_dev *devp)
>>>   		v &= ~0xffff;
>>>
>>>   	for_each_set_bit(irq, &v, HPET_MAX_IRQ) {
>>> -		if (irq >= nr_irqs) {
>>> +		if (irq >= number_of_interrupts()) {
>>>   			irq = HPET_MAX_IRQ;
>>>   			break;
>>>   		}
>> 
>> This is horrid.
>> You've replaced the read of a global variable (which, in some cases the
>> compiler might be able to pull outside the loop) with a real function
>> call in every loop iteration.
>> 
>> With all the mitigations for cpu speculative execution 'issues' you
>> pretty much don't want trivial function calls.
>> 
>> If you are worried about locals shadowing globals just change one of the names.
>
> Since HPET_MAX_IRQ == 32 and since the lower 16 bits of 'v' are cleared
> on modern systems, would it be such a big deal if number_of_interrupts()
> is called 16 times?

No. The context is open() which is a slow path operation.

> Since number_of_interrupts() has been marked as __pure, and since the
> kernel is built with -O2, do you agree that this should be sufficient to
> let the compiler CSE optimization step move function calls like the
> above from inside a loop out of the loop?

It could do so.

Thanks,

        tglx

