Return-Path: <linux-kernel+bounces-260388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260B293A82D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD33282D67
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1F3143894;
	Tue, 23 Jul 2024 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/ZaQoTh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JNhwd2/a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6B142633
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767285; cv=none; b=NdL3Sz2jFx72sgE96uYRN0XKSHMioY+3sIPtHq58auDSN25ITnj5Qo66M8UN6m8Tou7cM/0KqA71oc/V21FfAu1XfYhnJwClwlDT6kKNb/fI1zMuWoze/vMLyAo2CcywwqFf8n3iJWGJZLvCFVupgPvyiLv+tM60P3EH6GWAvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767285; c=relaxed/simple;
	bh=09875ZYhZWNX38sEsbubKgqKVwYQRxZdzw456QKdBck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TDXfiVkPC4N6Rk0aVigWx6P7DdbuUOPMtLWG2G53DX+RVASdP38PAmYPS2zRrNUHtmXlWLNq6j4bwioMQ1GNK2lAwu96s2flkxTnm0q+peKWta3fFT+KqWkNzirmWQc8/aEXb2ZptNgLTZtqJ3knw9/ERdfN5VXUeJS/+/DRbqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/ZaQoTh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JNhwd2/a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721767275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd0ICeGjjJKtXJ1DuunfJsbYX2PpYmpHsGXgmAbF31w=;
	b=D/ZaQoThSC3pISUOWBZbJMdz+BzxtaknoOPvV/dLY8L2bmlYgAFEPPrksuuP9ytKsQfbel
	hg4Lyf0Z5FX2mcb5N0rfO6Lgt2LXo054fqkFJBZyj03IDByAo00TYpBGMGHTPTd/B8E3y9
	eLBRbri++qZSrK7Rd9NSUAU8CAW1ei/ZHdpn/AccrOrbYR5fd8YY+tLIsX18Deuk9qiDqz
	8SSz7/KOtHkdroR9r/RmRPLSsQYvEq5DK70vJXl6zSxNVYRpRKnbJHZOhaZA75Djcs8C+H
	zL0gnEnT9agyBKhgiufVzBopvGLk8qcSvCWlLOqxzRzFKyJ79fHNhTGv5gSywA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721767275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd0ICeGjjJKtXJ1DuunfJsbYX2PpYmpHsGXgmAbF31w=;
	b=JNhwd2/ahhizMegAZH3x7whvgzTdhNCu1bc4CUF+nLL0xrTKNruqyVechxmeMn4l98Hubd
	l8pdCVn82fA/BCCA==
To: Linus Torvalds <torvalds@linux-foundation.org>, Petr Mladek
 <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara
 <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] printk for 6.11
In-Reply-To: <CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com>
References: <Zp-_7R49fIHgIhaq@pathway.suse.cz>
 <CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com>
Date: Tue, 23 Jul 2024 22:47:15 +0206
Message-ID: <87ed7jvo2c.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

On 2024-07-23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>   - In an emergency section, directly from nbcon_cpu_emergency_exit()
>>     or nbcon_cpu_emergency_flush(). It allows to see the messages
>>     when the system is in an unexpected state and might not be
>>     able to continue properly.
>>
>>     The messages are flushed at the end of the emergency section
>>     to allow storing the full log (backtrace) first.
>
> What? No.
>
> One of the historically problematic situations is when a recursive
> oops or a deadlock occurs *during* the first oops.
>
> The "recursive oops" may be simple to sort out by forcing a flush at
> that point, in that hopefully the machine is "alive", but what about
> random deadlocks or other situations where the printk machinery simply
> is never ever entered again?
>
> And we most definitely have had exactly that happen due to the call
> trace code etc.
>
> At that point, it's ok if the machine is dead (this is obviously a
> very catastrophic situation - nobody should worry about how to
> continue), but it's really important that the first problem report
> makes it out.
>
> The whole notion of "to allow storing the full log (backtrace) first"
> is completely crazy. It's entirely secondary whether you have a full
> log or not, when the primary goal MUST BE that you have any output at
> all!
>
> How can this have _continued_ to be unclear, when it was my one hard
> requirement for this whole thing from day one? My *ONE* requirement
> has always been that the printk code ALWAYS does its absolute best to
> print out problem reports.
>
> Because when an oops happen, all other rules go out the window.
>
> We no longer care about "what pretty printouts", and we should strive
> to always try to just get at least *some* basic print out. The kernel
> is known to not be in a great state, and maybe the printout will fail
> due to where the problem happened, but the kernel NEEDS TO TRY.

As the primary author, I would like to clarify the motivation.

During LPC2022 at the printk proof-of-concept demonstration is where
this requirement came from. The second point in my summary [0] of that
meeting stated the new requirement.

The requirement came about because during the demonstration we
accidentally hit a situation where a warning backtrace could not be seen
because while trying to print the warning, a panic was hit. In the end
we could see the panic, but not the original warning. At that meeting we
genrally agreed that it would be better to at least get the backtrace
into the buffer before entering the complex machinery of pushing out the
backlog to consoles. Then, if a panic occurs while printing, the warning
is already in the buffer and will be flushed out ahead of any panic
messages. That discussion is available online [1] (starting at 56:20).

In your response [2] to my summary email, you mentioned that we could
tweak how much is buffered as well as possibly changing the print order
to get the important stuff out first. But it all relied on the ability
to get things into the buffer first without requiring each individual
printk() to synchronously push out the backlog to all consoles.

Petr's pull request provides the functionality for a CPU to call
printk() during emergencies so that each line only goes into the
buffer. We also include a function to perform the flush at any time. As
the series is implemented now, that flush happens after the warning is
completely stored into the buffer. In cases where there is lots of data
in the warning (such as in RCU stalls or lockdep splats), the flush
happens after significant parts of the warning.

John Ogness

[0] https://lore.kernel.org/lkml/875yheqh6v.fsf@jogness.linutronix.de

[1] https://www.youtube.com/watch?v=TVhNcKQvzxI (from 56:20)

[2] https://lore.kernel.org/lkml/CAHk-=wieXPMGEm7E=Sz2utzZdW1d=9hJBwGYAaAipxnMXr0Hvg@mail.gmail.com

