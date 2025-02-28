Return-Path: <linux-kernel+bounces-538676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71882A49BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE961896156
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350526E16D;
	Fri, 28 Feb 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ms4c/5Cg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6a8sGrdQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27753363
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752439; cv=none; b=P1N4qwOSrkY3w4/Zbu+rhhmOuWXeZ6C0UDtd36dt1FqJnB7JU13i8tgWqQqVnngkejDk9pfK0jHkCuVpsVmcBROTrT6DuXzNyMWyuBj/9xCJwRRTpJqQAtrPQYOodKdh5Hz7KXSX+S/Wy+agUMpxOQGLJ1hurq6u19SqT8PApEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752439; c=relaxed/simple;
	bh=Oh7P4Jz0C18b7vPHUv3/Zd2LYJ1SuvtlT2JJoG4kL+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rup1R66sStyflv+UC9QSv3uU6cCj4w3ZJzFDcTTQQgApQ/TI8LzkC3O10WlOdsg64KHLIWuIRlnIxA3BXu+D+nZ3Vj/WA4BjyvJkmvdoGhG5x1gCqaIlDkOCCMogGWCln7CUBa+Sr9lli4Lyuj9R8YFvr9i5NvwkoIh9yT8JRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ms4c/5Cg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6a8sGrdQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740752435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CXlHhn3/4c4lCIOTagOdmV/oDVlTo29eKoQ6Y0m2o3c=;
	b=ms4c/5CgPEPiziUSdAKo2vSF5UuQhVRGuXDL26WP0eYoc5wUqHkQ40Qo8rXekxG2hXdyNd
	68Dljh5DuUrvpL4Yocgvth1AQX4UOLVBxY6U3ioiLGMK4YAT1/SzFBbFQOuwj4L5dxmcy+
	FLp5SDdq/l+v8vGmJ1y8mzXickHJRcN9sf6iw1FR7UZZ0fqF3H5aZf2sVF+PskTL2Wv/o4
	qUVg7hIxMLCbgUSu6GRYDLOP1SWYXOHcAEOXDNv1wpypDMzNf40T4StBUlkb3Vux7pIsyU
	s3jEBgi+CcCX7BtWwB9yss5YUWDcI2BXOPdtnLhnyCEhnpVOp3iSq34r/MOZUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740752435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CXlHhn3/4c4lCIOTagOdmV/oDVlTo29eKoQ6Y0m2o3c=;
	b=6a8sGrdQ0OASjWbIW2h9p/hX4GwVbVEaaKFVxMTCcLvEC41EzAp/SeFrpGdxvWgy2jTY29
	SsegL8+HoI5YJyBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Donghyeok Choe <d7271.choe@samsung.com>, linux-kernel@vger.kernel.org,
 takakura@valinux.co.jp, youngmin.nam@samsung.com, hajun.sung@samsung.com,
 seungh.jung@samsung.com, jh1012.choi@samsung.com
Subject: Re: printk: selective deactivation of feature ignoring non panic
 cpu's messages
In-Reply-To: <Z78eGNIuG_-CVOGl@pathway.suse.cz>
References: <CGME20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0@epcas2p3.samsung.com>
 <20250226031628.GB592457@tiffany> <84ikoxxrfy.fsf@jogness.linutronix.de>
 <Z78eGNIuG_-CVOGl@pathway.suse.cz>
Date: Fri, 28 Feb 2025 15:26:34 +0106
Message-ID: <8434fytakt.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-02-26, Petr Mladek <pmladek@suse.com> wrote:
> I wonder if this is actually safe. I recall that we simplified the
> design somewhere because we expected that non-panic CPUs will not
> add messages.

Perhaps you are recalling commit 7412dc6d55ee ("dump_stack: Do not get
cpu_sync for panic CPU").

> I am not sure that I found all locations. But
> we might want to revise:
>
>
> 1st problem: _prb_read_valid() skips non-finalized records on non-panic CPUs.
>
>    opinion: We should not do it in this case.

I don't know. This could result in seeing even less output if some CPU
didn't finalize a record.

> 2nd problem: Is _prb_read_valid() actually safe when
> 	panic_triggering_all_cpu_backtrace is true?
>
>    opinion: It should be safe because the backtraces from different CPUs
> 	are serialized via printk_cpu_sync_get_irqsave().

To clarify, by "safe" you mean it does not skip backtrace records from
other CPUs.

It does not skip their records because trigger_all_cpu_backtrace() waits
(up to 10 seconds) for the other CPUs to finish storing their backtraces
before continuing.

The use of the printk_cpu_sync is only to avoid interweaving the
multiple non-panic CPU backtraces.

> 3rd problem: nbcon_get_default_prio() returns NBCON_PRIO_NORMAL on
> 	non-panic CPUs. As a result, printk_get_console_flush_type()
> 	would suggest flushing like when the system works as expected.
>
> 	But the legacy-loop will bail out after flushing one
> 	message on one console, see console_flush_all(). It is weird
> 	behavior.

I believe you are talking about commit 8ebc476fd51e ("printk: Drop
console_sem during panic")? And also be aware of commit 51a1d258e50e
("printk: Keep non-panic-CPUs out of console lock").

> 	Another question is who would flush the messages when the panic()
> 	CPU does not reach the explicit flush.

Nobody. That is by design.

>    opinion: We should probably try to flush the messages on non-panic
> 	CPUs in this mode when safe. This is why I prefer the name
> 	"printk_debug_non_panic_cpus".
>
> 	We should update console_flush_all() to do not bail out when
> 	the new option is set.

It is not that simple. Legacy printing involves acquiring the
console_lock, which currently is not possible for non-panic CPUs during
panic.

> 	We should call nbcon_atomic_flush_pending() on non-panic CPUs
> 	when the new option is set. printk_get_console_flush_type()
> 	should behave like with NBCON_PRIO_EMERGENCY.

Note that non-panic CPUs during panic are also forbidden from acquiring
console ownership.

> 	Maybe, nbcon_get_default_prio() should actually return
> 	NBCON_PRIO_EMERGENCY on non-panic CPUs when this option is set.
> 	It allow the non-panic CPUs to take over the nbcon context
> 	from the potentially frozen kthread.

Note that nbcon_waiter_matches() requires that "Only one CPU is allowed
to request PANIC priority."

IMO it is opening up a huge can of worms to start allowing non-panic
CPUs to acquire the console_lock, take over console ownership, and print
(possibly with PANIC priority).

You could argue that this is just a debug mode. But I don't think that
is justification to allow things to explode and possibly deadlock, when
they otherwise would not have.

Perhaps Donghyeok might be happy enough if the debug option simply
allowed the non-panic CPUs to store records. There are plenty of tools
available to get at the dmesg buffer.

John

