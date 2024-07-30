Return-Path: <linux-kernel+bounces-267713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6FF9414A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2226D1F24187
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069F71A2C2B;
	Tue, 30 Jul 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLDm1GIj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zUILXe1o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73271A2C14
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350692; cv=none; b=k3cyTiwaz9henpUbEaVY6d3ROYpixhMpeWMsYbPbQTer7aBYqpooE6Bewhz3TG7zLE33FFbXziO9+GhFxut6LI87uysvqxQXCRCXUjEr7Oxc6NmPthvmwdLbXYQ5pJIP+L76y0WgILXc8/pupeFKs5VZmfKj4h+bpaigTpjyC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350692; c=relaxed/simple;
	bh=ZhNDsibfxYp0EqZqkFA+mzwy7syy0osi3AXGATSHLik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GUeS14vQTMwFngJghBtMSfmiA8EQHnk4Ssnb4RiZM/bvW9HuSB42mMl2GaomH4lmLn+EZw3vRocDdVrFFQPAc3ubxJjeogJk9YPReBi7nYd4QMHrav3qFayn8QiQjlxzIVWasCipJ6aQgxK7o5bufeseAk54EPr9iqoHeBgDXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLDm1GIj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zUILXe1o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722350688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KBPSYycLm+Hxs9OxGsqcRUDjEHzyYk/DNTtVSBAzrVI=;
	b=NLDm1GIj5wz0yF3S8BMLfqeNesNYZIPBQ5vo7+iQxHWC7D2u/aZse9Itqr+n6zHs0/6Gpx
	fXCKaWo/Q6YT6Qwri6GdyPxVYblQmLrUDI/T6yYsFQ638RE7LerfqMbarNahp9gJMNJgKn
	zSoYyooO0aGCr+1p+IkEKMmwBBLxMTAOINlH24p69+p7YT7qswJUdOhYuglQBYKbiSgbcA
	nB4AM6YloZfckL48w0JN9yepOvz/Vs44//IrouWmdl3JD+Uy9lIkbo/bZf1GiMPcUlHZMK
	RBF5oreJUTTszbKXV3iP3yG71iZAQTVe1BJrwimY2yY63IAkW5jfC98VPEQfNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722350688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KBPSYycLm+Hxs9OxGsqcRUDjEHzyYk/DNTtVSBAzrVI=;
	b=zUILXe1oZWWS4K8wnbJdbKUTujPHlULcSPvxDVqMdeW8YCSJQZGf0RhKLDOzNI51frICmA
	D06uqstoVk254eDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 09/19] printk: nbcon: Introduce printer kthreads
In-Reply-To: <20240722171939.3349410-10-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-10-john.ogness@linutronix.de>
Date: Tue, 30 Jul 2024 16:50:47 +0206
Message-ID: <871q3bkkgw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-22, John Ogness <john.ogness@linutronix.de> wrote:
> +/**
> + * nbcon_kthread_should_wakeup - Check whether a printer thread should wakeup
> + * @con:	Console to operate on
> + * @ctxt:	The nbcon context from nbcon_context_try_acquire()
> + *
> + * Return:	True if the thread should shutdown or if the console is
> + *		allowed to print and a record is available. False otherwise.
> + *
> + * After the thread wakes up, it must first check if it should shutdown before
> + * attempting any printing.
> + */
> +static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_context *ctxt)
> +{
> +	bool ret = false;
> +	short flags;
> +	int cookie;
> +
> +	if (kthread_should_stop())
> +		return true;
> +
> +	cookie = console_srcu_read_lock();
> +
> +	flags = console_srcu_read_flags(con);
> +	if (console_is_usable(con, flags, false)) {
> +		/* Bring the sequence in @ctxt up to date */
> +		ctxt->seq = nbcon_seq_read(con);
> +
> +		ret = prb_read_valid(prb, ctxt->seq, NULL);

With this v3 series, the kthreads could be started before @nbcon_seq has
been set to the correct initial value. This will cause it to start
printing immediately from 0.

To fix this, I would change nbcon_alloc() to initialize @nbcon_seq to
the highest possible value:

	/*
	 * Initialize @nbcon_seq to the highest possible sequence number so
	 * that practically speaking it will have nothing to print until a
	 * desired initial sequence number has been set via nbcon_seq_force().
	 */
	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), ULSEQ_MAX(prb));

With the following ULSEQ_MAX macro added to printk_ringbuffer.h:

#ifdef CONFIG_64BIT
#define ULSEQ_MAX(rb) (-1)
#else
#define ULSEQ_MAX(rb) (prb_first_seq(rb) + 0x80000000)
#endif

This will allow the prb_read_valid() in nbcon_kthread_should_wakeup() to
return false and the kthread will sleep until @nbcon_seq has been
correctly setup and the kthread is woken when the "enabled" printk() is
called.

> +	}
> +
> +	console_srcu_read_unlock(cookie);
> +	return ret;
> +}

Other options would be to add extra checks to
nbcon_kthread_should_wakeup() or add some wait/notify code before
entering the kthread main loop. But both are overkill for this simple
startup scenario.

Thoughts?

John Ogness

