Return-Path: <linux-kernel+bounces-265358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3509993EFFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB031F22849
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E798113C685;
	Mon, 29 Jul 2024 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xCqf2Uwd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6g/j110t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8D13C3C9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242168; cv=none; b=Lo6UjWq9ePYtntaWPCZp6iL7qbONKRNIHgJFpkak9KCUnln2FXk5DmviE6cxPsdmLUqyHymRlg6oWe8v7Ted9yBCvZroGAHEMpejmNSYVEzKNEmLEpZZ5UdPzHd/LuPfDCCMLcOdNbunXdJeviWFMJc7xuHN/mBBY6YWyh2EAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242168; c=relaxed/simple;
	bh=m/cVxycBaCP6m2KMp0poN4M55GPvSXbTLcNI2BwZ/uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DZcZWJuzxuyWA5rhXigpBysPrT8mOs/3Jffz/9n/ORjLUKAvTtT7VBYJtJMHU0PT6Fujtf1Yfiiy5hEHEWVIMdpKqktBhPNn1r+iJDAR55SXDZIdMC/jCETwIKRNG+IC6UcroW7lZG5Ic7emaeAxi6bAjaXj8yg6PH4YYEL+mBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xCqf2Uwd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6g/j110t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722242165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qzM88Rh9E4HZyFscQRm+i0+1KObsBD1PAAlVcReVmNo=;
	b=xCqf2Uwdfw0nm8f29bIZGnNjjYhmcZotcCfKWWlDNq8QzBDV6osLOci/6vOzxRtnvOtv8z
	UKpHIwF1qiilFErsTRvMfO0wvpEVlil39HWEX7YAPjFmCUbFe9GmgKxHc9YPyVOvOJ0Wy2
	2G7Cnidjdggcnz7fz5IDwAErPnZ0BIpf4k8zBpt2MSGsrgljZLqT0/EDuDLg4GWB7p3Z+C
	dkuT70z8SviURzd+jKeAQ4BQbR4uRZPt5MGYOiCdDjXh2v9cti5cS9cv2yZOxhH4N1VRxw
	kkxbdnidFCRBsYRis2bIJh1X7Ga5lhs8EibOn1rmJUByYUOFzpPh9buAu/BiyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722242165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qzM88Rh9E4HZyFscQRm+i0+1KObsBD1PAAlVcReVmNo=;
	b=6g/j110tnfZK8YpruK7DOqKSK/ytEexD7N6LJB6jRzrGTI7NQT0eMk+qiqZjRAYecbpVdM
	JyDRY1GjMGdOcmDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 03/19] printk: nbcon: Add function for
 printers to reacquire ownership
In-Reply-To: <ZqOVsZ1KGh3rkxE6@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-4-john.ogness@linutronix.de>
 <ZqOVsZ1KGh3rkxE6@pathway.suse.cz>
Date: Mon, 29 Jul 2024 10:42:04 +0206
Message-ID: <87cymwfvd7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-26, Petr Mladek <pmladek@suse.com> wrote:
> On Mon 2024-07-22 19:25:23, John Ogness wrote:
>> Since ownership can be lost at any time due to handover or
>> takeover, a printing context _must_ be prepared to back out
>> immediately and carefully. However, there are scenarios where
>> the printing context must reacquire ownership in order to
>> finalize or revert hardware changes.
>> 
>> One such example is when interrupts are disabled during
>> printing. No other context will automagically re-enable the
>> interrupts. For this case, the disabling context _must_
>> reacquire nbcon ownership so that it can re-enable the
>> interrupts.
>
> I am still not sure how this is going to be used. It is suspicious.
> If the context lost the ownership than another started flushing
> higher priority messages.
>
> Is it really safe to manipulate the HW at this point?
> Won't it break the higher priority context?

Why would it break anything? It spins until it normally and safely
acquires ownership again. The commit message provides a simple example
of why it is necessary. With a threaded printer, this situation happens
almost every time a warning occurs.

>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -911,6 +948,15 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
>>  		return false;
>>  	}
>>  
>> +	if (!wctxt->outbuf) {
>
> This check works only when con->write_atomic() called
> nbcon_reacquire_nobuf().

Exactly. That is what it is for.

> At least, we should clear the buffer also in nbcon_enter_unsafe() and
> nbcon_exit_unsafe() when they realize that they do own the context.

OK.

> Even better would be to add a check whether we still own the context.
> Something like:
>
> bool nbcon_can_proceed(struct nbcon_write_context *wctxt)
> {
> 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> 	struct nbcon_state cur;
>
> 	nbcon_state_read(con, &cur);
>
> 	return nbcon_context_can_proceed(ctxt, &cur);
> }

nbcon_can_proceed() is meant to check ownership. And it only makes sense
to use it within an unsafe section. Otherwise it is racy.

Once a reacquire has occurred, the driver is allowed to proceed. It just
is not allowed to print (because its buffer is gone).

>> +		/*
>> +		 * Ownership was lost and reacquired by the driver.
>> +		 * Handle it as if ownership was lost.
>> +		 */
>> +		nbcon_context_release(ctxt);
>> +		return false;

John

