Return-Path: <linux-kernel+bounces-301778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6C695F575
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1051C21668
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD291946A0;
	Mon, 26 Aug 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cb1+8UtZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x77DAFfu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920D619413C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687199; cv=none; b=qJ+1w+FMYo0mlWY1RDy3xQmduz+8++PhU/MscUutHUv/n7DyEm6EBX5f5BYyFUR6QoBGdiBveQY0BQyM1OW75IPUDw2s5zIkw+Hh5n0a4kRLor0zdr8aBZZd5vgV3FrgmOMsObAUMyzUZsPx7x63EgQUXCk2pK665X5FJrpmi0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687199; c=relaxed/simple;
	bh=r+qgaJdA25fP8sjeQbqNaN1kAi25iEv2HpFZFZB3KPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UbsPPzDK+/qavgXbnH4Q5mjU8bOpbzJkOwe/9tGM9YYEF34roRn4tu1gOi+rbfwz25RxL9KujMe6ckdJDHT6wAAOSwPCNv1djFWJg5DMAlxlAkZxxtyR3sWSU92aAK4duhoqV2sqoUdcrGxELUT1NnBqhnjlIujXHTy0ZktffKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cb1+8UtZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x77DAFfu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724687195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XInPgjKWrwpXT2yotO6xYZIrSGsVmYztBJiO4xMkrNU=;
	b=cb1+8UtZFmdD7nijYZbx8l6iz/mY4BQna5B22dk9O5Ezd2pN4lJbTwTGySZqByrpzWHPJD
	ybMtYCvnSSUrqbLzPBLcWpGnUbKvdXQFsso4AEcPp+y22VJ3jSecjmo3bfSadLg02rTcIE
	G+NVAFwsbgmMFlW5FYqWQJXS5wRUWB1RLib6pk3wmj8ceotoRGyS3FspPLMgc5nmG7KF2c
	eQgWKeT0ecgX6LzF3DJxEPUFilTmih90nqosi6T/UadrIy6NtqtPjI8eGs+HZQPZl8WSU7
	kwvgl+HofLxfpM/orFow8LCVWE87ORuqU5jStSFidVM2owEPxhPvKCWNhOgpew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724687195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XInPgjKWrwpXT2yotO6xYZIrSGsVmYztBJiO4xMkrNU=;
	b=x77DAFfu+C4Nd1cANZtGoEpBxU0x9OFFHGAOltQJeGOvTtLmar1omEfWE0K/HagGQAm+yU
	YPAFxMWwLe1HsrBQ==
To: takakura@valinux.co.jp, pmladek@suse.com
Cc: akpm@linux-foundation.org, bhe@redhat.com, feng.tang@intel.com,
 j.granados@samsung.com, linux-kernel@vger.kernel.org, lukas@wunner.de,
 nishimura@valinux.co.jp, rostedt@goodmis.org, senozhatsky@chromium.org,
 stephen.s.brennan@oracle.com, taka@valinux.co.jp, takakura@valinux.co.jp,
 ubizjak@gmail.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 2/2] Handle flushing of CPU backtraces during panic
In-Reply-To: <20240821050254.69853-1-takakura@valinux.co.jp>
References: <87y14sjp0d.fsf@jogness.linutronix.de>
 <20240821050254.69853-1-takakura@valinux.co.jp>
Date: Mon, 26 Aug 2024 17:52:34 +0206
Message-ID: <877cc38exx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-21, takakura@valinux.co.jp wrote:
>>> /**
>>>  * console_try_or_trigger_flush - try to flush consoles directly when
>>>  *   safe or the trigger deferred flush.
>>>  *
>>>  * Context: Any
>>>  */
>>> void console_try_or_trigger_flush(void)
>>> {
>>>      if (!is_printk_legacy_deferred() && console_trylock())
>>>              console_unlock();
>>>      else
>>>              defer_console_output();
>>> }
>>>
>>> and use it instead of printk_trigger_flush() in
>>> nmi_trigger_cpumask_backtrace().
>>
>> Just to be clear, you are talking about removing
>> printk_trigger_flush() entirely and instead provide the new
>> console_try_or_trigger_flush()?  Which then also involves updating
>> the call sites:
>>
>> lib/nmi_backtrace.c:nmi_trigger_cpumask_backtrace()
>> arch/powerpc/kernel/watchdog.c:watchdog_timer_interrupt()
>>
>
> Taking a look at [0], in addition to the mentioned call sites, 
> nbcon_device_release() will also be calling printk_trigger_flush()?
> For nbcon_device_release(), I thought its better not to be replaced as 
> it calles for @legacy_off, in which case printk_trigger_flush() seems 
> more suitable as it always defers printing.

The @legacy_off logic would be within console_try_or_trigger_flush(),
so the result would be the same.

> Also taking a look at the [1], for nmi_trigger_cpumask_backtrace(), 
> I thought that it will not comply with the syncing of 
> legacy_allow_panic_sync. I believe it will allow flushing of legacy consoles 
> before printk_legacy_allow_panic_sync() which is out of sync.

But isn't your patch also causing that violation?

printk_legacy_allow_panic_sync() performs a trylock/unlock. Isn't that
good enough?

John

