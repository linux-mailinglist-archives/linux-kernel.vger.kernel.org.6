Return-Path: <linux-kernel+bounces-229623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030CE9171FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC31288342
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69FB17D8AA;
	Tue, 25 Jun 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1hz8A6iX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jTSQ652N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD517D890
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345393; cv=none; b=AARdLDdTgCoOqNjVPJTpMlVkKAHMsC5KQ7GXaL+cqD4+ciIm5enk1k0DzkK026E5ujUA3ZFS+Z7cJXsLAKUSe/aKDWXyO855WlIXSbgPCAP1gnyChJn7sqpqvWatRgkkBD5zy4TfPIG9fHzS3nh8EqflBElLmZn67otTqq4wk+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345393; c=relaxed/simple;
	bh=KnEiOwAWRojsejXCxmgnhpxSmZ1SRiCKg/aXX+AJWRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cNd8Laq2HbovAa2RCiick2SWKB0yLxebQuj0lb5U55cFarzMprLebhP2ChKa3XrZ+Ji5wYKUqrK2WiRdcF16RcPKzbU9HLalsSeUCESs7c2Z/fll4Ksj0XTKrqkjJPV0g7t2cXMX1r6s3XdpJJZspiOf15oTnlIv328T5vBnUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1hz8A6iX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jTSQ652N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719345390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcDM9ERFRPSMcyIl4N1wIJdu6qzGP3QrT+zHPuM7L98=;
	b=1hz8A6iXDmuervTPokJEBH/jfMssFSWTWRWePHR2pKlr2KBGrAime15N97MB2CrHcfdOYn
	5MOOnSJFftX2YCSeMgj9pH0iLAuBwjCYWsYRcyB36I6l8VcQGV9JEgeSrcTNFYIuLZaMRv
	vurfxfeOIDmLmFaok1kIu6cs/34OqFs/JDlg57atP2RdcUlxQgUEjQ+wXzFXT8rJ14C8mX
	rQkjzJ13846dM7Ji5TFXo1EXvmXEl/macZM0tZ9YhMBOi9uTCxHIuXiHIzw6SCw7VagjUZ
	IcYjM9COA9uoqAORbALTr3gj/UhcFzOuhcvBkyo0CDfeD1smkqSeHm4nwIvpPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719345390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcDM9ERFRPSMcyIl4N1wIJdu6qzGP3QrT+zHPuM7L98=;
	b=jTSQ652NJW9VKlqnwzUYHqzU1y4UltJNVgkwIahrgtrkL7KlvOvc1NqW5aZ3JQ5O5/T8Cf
	PS0xD0NfQqRFB4CA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 08/18] printk: nbcon: Stop threads on
 shutdown/reboot
In-Reply-To: <ZnBUe0ZJgjbZXlAL@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-9-john.ogness@linutronix.de>
 <ZnBUe0ZJgjbZXlAL@pathway.suse.cz>
Date: Tue, 25 Jun 2024 22:02:30 +0206
Message-ID: <874j9gyexd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-06-17, Petr Mladek <pmladek@suse.com> wrote:
> First ideas (how the waterfall of questions started):
>
>     + I though that we should do here:
>
> 	    printk_threads_enabled = false;
>
>       It would tell vprintk_emit() to call
>       nbcon_atomic_flush_pending().  And it would be symetric with
>       printk_setup_threads().

This makes sense. I created @printk_threads_enabled to have a clean
startup of the threads. I did not consider recycling it for shutdown
purposes.

>     + Also I though whether to call it before or after stopping the
>       kthreads.
>
>       If we set the variable before stopping kthreads then the
>       kthreads might try to flush the messages in parallel with the
>       flush from vprintk_emit(). It should be safe because it would be
>       serialized via the nbcon console context. But it would be the
>       first scenario where this happen => not much tested.

It is safe. The scenario is not that unusual. Non-printing activities
can contend with thread via the port_lock wrapper quite often.

>       Well, we should start the direct flush before stopping kthreads.
>       So that we could see the messages when the stopping fails.
>
>
> But then I realized:
>
> Ha, vprintk_emit() would call nbcon_atomic_flush_pending() anyway
> because these notifiers are called with:
>
> 	system_state > SYSTEM_RUNNING
>
> This makes me wonder whether we need to stop the kthreads at all.

Well, that overlap was not intentional. There probably should be a flag
to signify the transition rather than just looking at @system_state.

> How exactly does this make printk more robust during shutdown?

Because by stopping them, the printing threads are guaranteed to go
silent before they suddenly freeze. Without the clean shutdown, I could
create shutdown/reboot scenarios where the printing thread would stop
mid-line. Then the atomic printing would never be able to finish because
it is a non-panic situation and the thread was frozen while holding the
context. The result: the user never sees the final printk messages.

> Well, there is one differece. The kthreads could not interferre with
> the direct flush when they are stopped.
>
> But we have the same problem also with suspend/resume. And we do not
> stop the kthreads in this case.

Suspend/resume is something different. Suspend needs to stop _all_
printing. I do not think it makes sense to shutdown threads for
this. The consoles becoming temporarily !usable() is enough.

For shutdown, the consoles are usable() the entire time. I just want the
threads to get out of the way before they freeze so that the user can
see all the messages on shutdown/reboot.

> Maybe, we should just add a check of
>
>        system_state > SYSTEM_RUNNING
>
> also into the nbcon_kthread_func(). Maybe, the kthread should not try
> to flush the messages when they are flushed directly by
> vprintk_emit().

It gets racy when we start relying on the contexts noticing some
variables. By racy, I mean there are scenarios where there are unprinted
records and no context is printing. I think it is easiest when the
following steps occur within a notifier:

1. notifier sets a flag to allow atomic printing from vprintk_emit()

2. notifier stops all threads (with the kthread_should_stop() moved
   inside the printing loop of nbcon_kthread_func())

3. notifier performs nbcon_atomic_flush_pending()

This guarantees that no messages are lost and that all get flushed.

>> +static int __init printk_init_ops(void)
>> +{
>> +	register_syscore_ops(&printk_syscore_ops);
>> +	return 0;
>> +}
>> +device_initcall(printk_init_ops);
>
> I guess that "device_initcall" is cut&pasted ;-) IMHO, it does not
> fit much. That said, I do not have strong opinion where
> it belongs.
>
> IMHO, the best solution would be to register the notifier in
> printk_setup_threads() before we actually allow creating them.

OK.

John Ogness

