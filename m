Return-Path: <linux-kernel+bounces-262461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C65293C767
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91781F23F03
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D6D19DF43;
	Thu, 25 Jul 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZTdk3jwn"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C1A19D082
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926152; cv=none; b=Z0nWbfwVOBsgWhzdtIgvuOJnMvTxYXcliqYovicMty/MpbJWg4sRE47AdI4CZNP2gdLejjhEIS825avQJBiM6jNVjUe5D/0XjmWUqRru447KyqAw3VGJef1Jld+MzotCYWYH51tlc67Xc1z4xt1doLPCWhKIeLqyH0fZc/yEPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926152; c=relaxed/simple;
	bh=cPah+Wuy8P6ObhLGMXmipqHt2RP/YayZ3+KlLsaGglQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtaB13d+aL8i/xQeFE30e9uMy3Xkna8cItfeR9TTNG+LeT5nB54KR1gsPEiPuH4o+YpxGTR/ConjGJfWg+rGC0HR0kBGcdzbUjJKccQdaWIiFcUIsp/1vhziTCXDyubRHjHmKstEvcvCR1tJGm78vDG5tB/mbiDBGdMZMB+axmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZTdk3jwn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a22f09d976so3854639a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721926148; x=1722530948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n1g4Lobkb8cHDChYW5yTj0cGrMNA3ynmU1ffrscMD0U=;
        b=ZTdk3jwnAwkXkYWvgBdjvjPUL0vIFGIKKUpuv5QnJftd9w4IAP1E4IqyhW005mELJ9
         rZ2LjJ3agy3nsfJ6ZdkeU0Bv0g9hrSwwtvR4kUAAED01K5RItyIsIy8jtnSPqxSzwaB9
         Skba0qNuYITldAA5F/+ncQ55YZRSNOPbi9ZxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721926148; x=1722530948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1g4Lobkb8cHDChYW5yTj0cGrMNA3ynmU1ffrscMD0U=;
        b=wdog0IPHO1gdzvClVXolayrhMaPsiXyb92MeBgHA/kr6lPZzXjYfvM839qBVc3cRdt
         X/5dXdUpwA/mo/1lDnsqKH3t8RRRe/3tpS8y/jGEwQD5Wg7C9Q9qe5hJQfQYYQbBvCF0
         /7ClelruQz+JnwAXqJKSaWRPm44eAmSPCOkLWEvqgvs23YuaIvP5esb11evCwY5sGktC
         iWOyL5nyBskPI3aI4TEC1NmTyxd4/tywgChArTYSffoZQbKrl7L/KN/51ordqwgFRWSj
         c15HlMCXA0GP+Qmc7cflfCwZsXfkYV+It3icR2clmpEZkdiIRWKyh4htWxWV7ifCGf0e
         c9lg==
X-Forwarded-Encrypted: i=1; AJvYcCX9C3Qh+Lh6Hw5JUGESgLpcPyCMUulYlLUIqZMxsT20X1dj94Mv6/Kqc+fojVq4E1LzkHfvZuj61lXF93kcjPJgpVcMCcdHQkgXADFb
X-Gm-Message-State: AOJu0YyMHq8XJpc7sKXhHi1XyCzisD6wprTuVk7UoorFpWkuPr9JwEVb
	ZihTU3kJQtprKOwzGqCOyu7/1+yXche60tC3UcQkPlsUYA9lQj8If9z6W8J5Y627nVd3Jp57gid
	Sxhc+eQ==
X-Google-Smtp-Source: AGHT+IHnl6tfnoo1CTlxFTtMlp2SCVNN0TfXsWOjrTkMdgxlDIsGTdztq6pk06ViRJtId2nVDjsIsQ==
X-Received: by 2002:a17:907:604:b0:a7a:bae8:f2b5 with SMTP id a640c23a62f3a-a7ac46e15f3mr281077766b.36.1721926147744;
        Thu, 25 Jul 2024 09:49:07 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e34sm88727266b.164.2024.07.25.09.49.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 09:49:07 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so1887255a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:49:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWk/DR80NIHMYWoxIQBfMablugrw8lqGQRNHf6XH44k0J0i5+6Fxk8tpHIB9IrJ417LwO3HXuuDrgYY5lf/Hfg545QDs0dsJ/S4OBCR
X-Received: by 2002:a50:cd47:0:b0:59e:a1a6:11b9 with SMTP id
 4fb4d7f45d1cf-5ac123a2ed7mr3212454a12.2.1721926146551; Thu, 25 Jul 2024
 09:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zp-_7R49fIHgIhaq@pathway.suse.cz> <CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com>
 <87ed7jvo2c.fsf@jogness.linutronix.de> <CAHk-=wh+cxX2Sxc6RPBKkgYO67o2mdVfW6sQNMYc_x2QoP4LOQ@mail.gmail.com>
 <ZqC-TW7ygSSF3MyO@pathway.suse.cz> <20240724124743.GC13387@noisy.programming.kicks-ass.net>
 <CAHk-=wgJrCwOwj4myGgpgyig9dX37hir1S2Xdeg1=kVS-hPzAg@mail.gmail.com> <ZqJKbcLgTeYRkDd6@pathway.suse.cz>
In-Reply-To: <ZqJKbcLgTeYRkDd6@pathway.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 09:48:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh79gaaKahsmTeCiyZRKLtpWMGNRY5QH5NU94iKR0=rvA@mail.gmail.com>
Message-ID: <CAHk-=wh79gaaKahsmTeCiyZRKLtpWMGNRY5QH5NU94iKR0=rvA@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 6.11
To: Petr Mladek <pmladek@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 05:52, Petr Mladek <pmladek@suse.com> wrote:
>
> I am afraid that we have to live with some buffering. Otherwhise,
> the speed of the system might be limited by the speed of the consoles.
> This might be especially noticeable during boot when a lot of HW
> gets initialized and tons of messages are flushed to a slow serial console.

Oh, I don't mind buffering during *normal* operations. Particularly
not for some slow serial line.

It's literally just oopses and KERN_ERR and similar that I think are special.

And I do think some consoles are more special than others.

"I want to buffer because serial lines are slow" does not mean "we
should always buffer" when realistically not everybody has a serial
line.

> Just for record. The idea of "buffering in emergency" came up
> in the opposite scenario:
>
> <flood of messages>
>
> CPU 0                                   CPU 1
>
> WARN()
>   printk()
>     flush_consoles()
>       # handling long backlog
>
>                                         panic()
>                                           printk()
>                                             flush_consoles()
>                                             # successfully took over the lock
>                                             # and continued flushing the backlog
>
> Result: CPU 0 never printed the rest of the WARN()

First off, I do think that's fine. This is - by definition - not a
normal situation, and a panic() is *way* more important than some
WARN.

Yes, they may obviously be related, but at the same time, if you
panic, and particularly if you have reboot-on-panic, you damn well get
what you asked for: other things *will* be hidden by the panic. Tough
luck.

There's a very real reason why I tell people that using "BUG_ON()" is
not ok for things where you can just return an error.

And there's also a very real reason why I think people who do
reboot-on-panic get to keep both pieces. It's self-inflicted damage,
and if they come crying to you, tell them so.

What you should *really* take away from this is

 (a) you fundamentally can't handle all situations.

We are - by definition - talking catastrophic kernel bugs, and
something unexpected went very very wrong,

You can always make up some case that won't work, and you NEED TO REALIZE THAT.

 (b) that means that you have to prioritize what you *DO* handle.

And I'm telling you that what needs to be prioritized is a oops (not a
warning), but particularly the *first* one.

Now, unrelated to that, I'm also claiming that the problem you
actually talk about is at least partially caused *by* the excessive
buffering. The whole "long backlog" should never happen, and never be
considered normal behavior.

So I think we also tend to have a behavioral problem, in that our
default console loglevel is too high. It's high by default, and I
suspect some users do console=verbose, which sets

        console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;

which does exactly what it looks like it would do (or, more commonly,
the debug case that "only" sets it to CONSOLE_LOGLEVEL_DEBUG, which is
effectively the same thing in practice - I don't think we have any
users that actually use log-levels past KERN_DEBUG).

The thing is, if you have CONSOLE_LOGLEVEL_DEBUG set, and a big
machine, your bootup *will* be printing a lot of data.

And it *will* be slow over a serial console, particularly one that
runs at some historical speed because that's how a lot of these silly
things work.

But dammit, we literally have a "buffer messages" mode. It's this:

    static bool suppress_message_printing(int level)
    {
        return (level >= console_loglevel && !ignore_loglevel);
    }

and it was *ALWAYS* that. This is literally why log levels exist: they
say "some messages should not be printed, because it's slow and people
don't want to see it unless they need it".

So I think in a very real sense, the "solution" may be to make sure
our loglevel is something reasonable, and find the messages that cause
excessive noise, and make sure that they are buffered by being
sufficiently low log levels!

And maybe make sure our log level logic actually works right - I think
it should always have been per-console, but for obvious reasons that
was never the original behavior, and I suspect it was never fixed
because all the loglevel stuff I see from a quick grep is just
global).

A loglevel that makes sense for a fast directly connected console may
not make sense for a server with emulated serial lines and tons of
debug info.

IOW, I think a lot of the whole "long backlog" issues come from us
doing badly with log levels.

             Linus

