Return-Path: <linux-kernel+bounces-263397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B3693D54D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AC01F213E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8895417BA6;
	Fri, 26 Jul 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eEczShzq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AGU4OfKX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDCA125A9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005151; cv=none; b=PNxYDw/k5TTLVeFN3MW0c/KBlR7O3ZPUEou+qZ8KdH0iun5YAYtKodo/B3WAU9SWo5PmsY/1qtFeKi9i5Il6kIsuN3jZUsPShkGbNY5++ghaqZQtLA0TOf+J0K20Qo4GYAk0W3ORgQfQurAhEcJi4i1ktTpUI4NiCQBI43P1EYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005151; c=relaxed/simple;
	bh=oMXt2n+VO8JvLtfmNTP/CoN3bUmBYReR1hjMq4l9XME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pq+IBGpPSwNuHLvyMWUhiNhBXesWZ1WJFlljILz4rGZyTQ9H6zJg9UTyGkDewkgeN7qjOejYG4tpsmTJ4xjS1/D1uB1WbvGR4o8Mwv/jej6xxLQbojSqGJ8iOwN6VT1/rM0nDLuVAHq1e/mvFhmY9JVmtVDjJZV0y87E6uK94xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eEczShzq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AGU4OfKX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722005147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csMf85k1GADskleUM5+0ydEsRr/afAXOEYSLoHHt8Ho=;
	b=eEczShzqoe1RzAhdYLkNflb81tewr6EOjkDNRhHsdX3b29qpXHgySOCK2pNWcbD4SiiiwS
	iO4CKToJNeh+gP63pBOFb6ZYgb9fHmOGZ/wjWh85m3SIjUWiYRO1sKO15M0qSNkEPuAkio
	BFMihZ9P0dG1cWUj4lBCeRPmLKQ8v2JGPB0y9HdniDCcgvAzYMetiB/vjk3+dkSjKQkjtv
	urh9r/tB03W6Q6Wfj0lEFJJaIEw9B/HnDgrcn+J65kw1FAv0VC0+wx2LO2Y73eHAgly60R
	dOuEI1XSTLix/hGb5K8pzb++M5pdXbx4i4BDY5EcAsZ1rhyO2w2VaIdyGVd+Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722005147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csMf85k1GADskleUM5+0ydEsRr/afAXOEYSLoHHt8Ho=;
	b=AGU4OfKXRudqeJMS+8/rSr/aHjvUQ9guXvmTMqCgsdANuiUJbDAUiUWA98+UxrMOnG+r37
	rcJYh5OIONgvZGAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 05/19] printk: Fail pr_flush() if before
 SYSTEM_SCHEDULING
In-Reply-To: <ZqOhNwkJKBSU848O@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-6-john.ogness@linutronix.de>
 <ZqOhNwkJKBSU848O@pathway.suse.cz>
Date: Fri, 26 Jul 2024 16:51:47 +0206
Message-ID: <87o76kw6sk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-26, Petr Mladek <pmladek@suse.com> wrote:
> On Mon 2024-07-22 19:25:25, John Ogness wrote:
>> A follow-up change adds pr_flush() to console unregistration.
>> However, with boot consoles unregistration can happen very
>> early if there are also regular consoles registering as well.
>> In this case the pr_flush() is not important because the
>> regular console manually flushes the boot consoles before
>> unregistering them.
>
> It is not much clear what the "manual flush" means. Is it
> the console_flush_all() in get_init_console_seq()?
>
> I would write something like:
>
> <proposal>
> In this case the pr_flush() is not important because all consoles
> are flushed when checking the initial console sequence number.
> </proposal>

Yes, clearer. Thanks.

>> Allow pr_flush() to fail if @system_state has not yet reached
>> SYSTEM_SCHEDULING. This avoids might_sleep() and msleep()
>> explosions that would otherwise occur.
>
> What do you mean with the explosion, please?
> Does it add some warnings into the log?
> Does it cause extra delays?

I am certain that I could trigger a splat with might_sleep() using some
configured preemption mode. But now I cannot reproduce it. However, with
msleep() it is easy:

[    0.436739][    T0] printk: legacy console [ttyS0] enabled
[    0.439820][    T0] printk: legacy bootconsole [earlyser0] disabled
[    0.446822][    T0] BUG: scheduling while atomic: swapper/0/0/0x00000002
[    0.450491][    T0] 1 lock held by swapper/0/0:
[    0.457897][    T0]  #0: ffffffff82ae5f88 (console_mutex){+.+.}-{4:4}, at: console_list_lock+0x20/0x70
[    0.463141][    T0] Modules linked in:
[    0.465307][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-rc1+ #372
[    0.469394][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[    0.474402][    T0] Call Trace:
[    0.476246][    T0]  <TASK>
[    0.481473][    T0]  dump_stack_lvl+0x93/0xb0
[    0.483949][    T0]  dump_stack+0x10/0x20
[    0.486256][    T0]  __schedule_bug+0x68/0x90
[    0.488753][    T0]  __schedule+0xb9b/0xd80
[    0.491179][    T0]  ? lock_release+0xb5/0x270
[    0.493732][    T0]  schedule+0x43/0x170
[    0.495998][    T0]  schedule_timeout+0xc5/0x1e0
[    0.498634][    T0]  ? __pfx_process_timeout+0x10/0x10
[    0.501522][    T0]  ? msleep+0x13/0x50
[    0.503728][    T0]  msleep+0x3c/0x50
[    0.505847][    T0]  __pr_flush.constprop.0.isra.0+0x56/0x500
[    0.509050][    T0]  ? _printk+0x58/0x80
[    0.511332][    T0]  ? lock_is_held_type+0x9c/0x110
[    0.514106][    T0]  unregister_console_locked+0xe1/0x450
[    0.517144][    T0]  register_console+0x509/0x620
[    0.519827][    T0]  ? __pfx_univ8250_console_init+0x10/0x10
[    0.523042][    T0]  univ8250_console_init+0x24/0x40
[    0.525845][    T0]  console_init+0x43/0x210
[    0.528280][    T0]  start_kernel+0x493/0x980
[    0.530773][    T0]  x86_64_start_reservations+0x18/0x30
[    0.533755][    T0]  x86_64_start_kernel+0xae/0xc0
[    0.536473][    T0]  common_startup_64+0x12c/0x138
[    0.539210][    T0]  </TASK>

And then the kernel goes into an infinite loop complaining about:

1. releasing a pinned lock
2. unpinning an unpinned lock
3. bad: scheduling from the idle thread!
4. goto 1

John

