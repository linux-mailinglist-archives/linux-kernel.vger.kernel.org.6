Return-Path: <linux-kernel+bounces-302429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569C895FE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C48128232E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 01:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71414322E;
	Tue, 27 Aug 2024 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hlfWdGf/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7dtox4/X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1349F79CC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724722378; cv=none; b=H4q4N0jtMXMZKj2OzLC00RUzpZahEW9A60VLn7M2hR6F4u7pxXSxNpTE/jKlTUxMZ3ZHZ4mm1Vo6S1L1MEuIZaHDkTnQMP8/Co+S2m2bHWULOSBvhQaBPzN+umei3oyhmx1JZPcKFQ3nwJRY6Ds6Wz77Er62zMyA8n7cSvg5t5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724722378; c=relaxed/simple;
	bh=E+0UJB+1QT4OIZork/Uqcny0+WHDtNGIleijDe28ugE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=beF0wQ0pTpKhyZ3gc4ih3aWGwU6dp1DCAJU8593vU+fJkpo4il00t38pG92RVo02lKEqSp0REoTY67vu3quygMnTwvIL8IIP12bTmlVXyo5i54wi7QKtv8SYwNf92aGW1p2yTSQntoyGA/g88126+uBf/XsA4WdCVKTE60SRdhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hlfWdGf/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7dtox4/X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724722374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqJLg0A9Lp+JLrWMX4eT38HNjMX8Sqz8hnELo6fRc68=;
	b=hlfWdGf/TGgJ1gsPxZhTy4hLqn14Jc0JPFQby5/Ti3Fwr0zaEU4DD9wugOCap/ckTHJou9
	etPA3had1xf2VSf0rSRNJdZhrkTUzpf6NugBhnLJL4R7J76PlBU1SF4dwE+8anMZVzEq5u
	2V1/J719nrOUCJJcFj4RqNHXNWd57FK1ne5AIush8UTPoA8wNTOW3rJVPwFJeqTcPcbJcR
	zkOnfkCG0zkiTVcLS5Z2/VWY7ICxGfiX4nLsVkjVvOri7Zu4pFEyruOUIVGHFYXWBmqpxB
	tPryi4ZQzlKKqUFIn2EcGl2XOtywfM4XdU4/SZ9BFQk2BzuLNaHLZwQ+df0wHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724722374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqJLg0A9Lp+JLrWMX4eT38HNjMX8Sqz8hnELo6fRc68=;
	b=7dtox4/XNzVscz9xmp5xinny4vRdwkgxcWVNUs59yZRuc2rYpc1SudxBcSKBDNJBNEQTg8
	OIklsf/AoItnHzAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 03/19] printk: nbcon: Add function for
 printers to reacquire ownership
In-Reply-To: <ZqixOLkuo0IW2qql@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-4-john.ogness@linutronix.de>
 <ZqOVsZ1KGh3rkxE6@pathway.suse.cz> <87cymwfvd7.fsf@jogness.linutronix.de>
 <ZqixOLkuo0IW2qql@pathway.suse.cz>
Date: Tue, 27 Aug 2024 03:38:54 +0206
Message-ID: <874j76hhrt.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-30, Petr Mladek <pmladek@suse.com> wrote:
> My idea was: "If we still own the context that we have owned it all
> 	      the time and con-write_atomic() succeeded."
>
> The race is is not important. If we lose the ownership before updating
> nbcon_seq then the line will get written again anyway.
>
>> Once a reacquire has occurred, the driver is allowed to proceed. It just
>> is not allowed to print (because its buffer is gone).
>
> I see. My idea does not work because the driver is going to reacquire
> the ownership. It means that nbcon_can_proceed() would return true
> even when con->atomic_write() failed.
>
> But it is not documented anywhere. And what if the driver has a bug
> and does not call reacquire. Or what if the driver does not need
> to restore anything.
>
> IMHO, nbcon_emit_next_record() should check both:
>
> 	if (use_atomic)
> 		con->write_atomic(con, wctxt);
> 	else
> 		con->write_thread(con, wctxt);
>
> 	/* Still owns the console? */
> 	if (!nbcon_can_proceed(wctxt)
> 		return false;
>
> 	if (!wctxt->outbuf) {
> 		/*
> 		 * Ownership was lost and reacquired by the driver.
> 		 * Handle it as if ownership was lost.
> 		 */
> 		nbcon_context_release(ctxt);
> 		return false;
> 	}

Except that the next thing nbcon_emit_next_record() does is
nbcon_context_enter_unsafe(), which checks ownership. So your suggested
nbcon_can_proceed() is redundant.

For v4 I can add comments explaining this. It would look like this (at
this point in the series):

	/* Initialize the write context for driver callbacks. */
	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);

	if (con->write_atomic) {
		con->write_atomic(con, wctxt);
	} else {
		/*
		 * This function should never be called for legacy consoles.
		 * Handle it as if ownership was lost and try to continue.
		 */
		WARN_ON_ONCE(1);
		nbcon_context_release(ctxt);
		return false;
	}

	if (!wctxt->outbuf) {
		/*
		 * Ownership was lost and reacquired by the driver. Handle it
		 * as if ownership was lost.
		 */
		nbcon_context_release(ctxt);
		return false;
	}

	/*
	 * Ownership may have been lost but _not_ reacquired by the driver.
	 * This case is detected and handled when entering unsafe to update
	 * dropped/seq values.
	 */

	/*
	 * Since any dropped message was successfully output, reset the
	 * dropped count for the console.
	 */
	dropped = 0;
update_con:
	/*
	 * The dropped count and the sequence number are updated within an
	 * unsafe section. This limits update races to the panic context and
	 * allows the panic context to win.
	 */

	if (!nbcon_context_enter_unsafe(ctxt))
		return false;

John Ogness

