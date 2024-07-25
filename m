Return-Path: <linux-kernel+bounces-262207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D60493C27F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D96F1F23013
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA4419AD41;
	Thu, 25 Jul 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OXCVx+kH"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27AB19AA59
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911922; cv=none; b=jQgn/n14hzkxdC4nvIfgK5T1wbxvxTWm1skWLQQ7Ig/9E2TNU4r35hYMI+7uetJcYyDKOaX/EM3ucue+PWNd3zoHr+3uLVPZ7IxtNo8nXDtgf24J3C24bBucbGTf8kRvVaK36xqCIwzrqz4cwHgqm7AgGIiO0ckeg0rmg3YVuVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911922; c=relaxed/simple;
	bh=JkurEmOt6KTGmxR6n1XWYCDZwS2FEnw1ox4HLgbTw68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJdyNCWjN1357eThtWN7xq4eBsAWevz9pzEc0zCvmHFlMQ2LWNwitV2p8qmJpGKDueDcr06KgjaFaaYH+sQt47nmxwfdvHf35Ood5oHZnsrftMmlh1NtA3ELsO4CaCfJ7m3wP76nHXpZeLEogHjaJQFRUD0DFBHk5fo6pzLCg+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OXCVx+kH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso1068282a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721911919; x=1722516719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=833DM91lBSOZraKnd4KEEgR5oPZoVd8U/ezpKCFPn/Q=;
        b=OXCVx+kHxAsI9NSBe9SFErQlYmlSomZgjAhMJLpiDd2xi7GNbeZaDOnDhHMB3YXrLW
         1VqVKSJUyw/9FEYhPPq7IDSRPI4UnqL9CiSYvqO8bWGguLx6FqikhvAqDbf2w00Xfj6a
         XEK8hqongF70jca5rKvFj+euJoAVv8s3dCI6lmxZvuCQ5be1GiRbbbwvSNq0v9op3qHR
         wqMgF2oMK8q6/Eu7np+UOX2lyucK48syxKz5AtCROCbl0rofMrrQCmvkk2TVNGWg2vZa
         OPs2qL4mOYEKzZa7VvX9k3wFWpnpHMpeUGrj8J3rqKz7VZ+IWWLPu4DzqjUtUVnjrOsH
         RWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721911919; x=1722516719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=833DM91lBSOZraKnd4KEEgR5oPZoVd8U/ezpKCFPn/Q=;
        b=bkO93watRq3NywwByDh0T7iAbjsv7tcKKd9gK1tU9OQqVLeEK5ZF5HPCJuxS5r7zc6
         dPmPFP6xReYNsjIPyOnhkQGeD/IyHM47zWJLkfKz04gxydNVN89mfo3QQiRGS5Mho/gz
         7Xl6o+awboZ00Vp+CFxayZ3c8wWXMOrIduvhsld0cpaW+welSC2G9U8qQhmi2i6YGbKU
         BbjAgYrGECzaP9my3XXM3+AHklyV9HjajVEykXBkYamhuk2rl4N5F2OLRczSfqcRVQ6C
         N4e/Cp13j7j2n7Vj4MmDaCDrCQJl5NIkI23qZdYpxOIq9Tb0Tt0dh3qbNDPNqjIUpGdv
         rDAg==
X-Forwarded-Encrypted: i=1; AJvYcCUS71X5SV8qXxqAN/hZXuc7TlDgtIObUHUB5QJJonSFgHa501kdI2EQMlYYEEzewnZlhRRoIaW/GlP2vdbjcVjlPmTJTo85bSzO1ENI
X-Gm-Message-State: AOJu0YyfaFuV7vJCOcDuWFVoW2S1Y5dUWf4Jt7d9wu4gNU7A49X0Q8cx
	JUsBKQVg6nyimz8enKfMQ5gxjvhmRYX66hT5TZIZ6dCm2MCd6pnm73dRZjXQbZb48TAtOXLxaum
	Y
X-Google-Smtp-Source: AGHT+IHPNvUC1JDhB6KcHIvgtVB1bJpkCmkiT5Y4K/ML1ol3SBwZD/NLI0voRiHAaraQkhaT0HJOCg==
X-Received: by 2002:a17:907:7202:b0:a77:cd4f:e4f5 with SMTP id a640c23a62f3a-a7ac53375d5mr219039066b.68.1721911918949;
        Thu, 25 Jul 2024 05:51:58 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb8039sm69968466b.200.2024.07.25.05.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:51:58 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:51:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] printk for 6.11
Message-ID: <ZqJKbcLgTeYRkDd6@pathway.suse.cz>
References: <Zp-_7R49fIHgIhaq@pathway.suse.cz>
 <CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com>
 <87ed7jvo2c.fsf@jogness.linutronix.de>
 <CAHk-=wh+cxX2Sxc6RPBKkgYO67o2mdVfW6sQNMYc_x2QoP4LOQ@mail.gmail.com>
 <ZqC-TW7ygSSF3MyO@pathway.suse.cz>
 <20240724124743.GC13387@noisy.programming.kicks-ass.net>
 <CAHk-=wgJrCwOwj4myGgpgyig9dX37hir1S2Xdeg1=kVS-hPzAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgJrCwOwj4myGgpgyig9dX37hir1S2Xdeg1=kVS-hPzAg@mail.gmail.com>

On Wed 2024-07-24 13:33:20, Linus Torvalds wrote:
> On Wed, 24 Jul 2024 at 05:47, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > So.. I've complained about this emergency buffering before. At the very
> > least the atomic consoles should never buffer and immediately print
> > everything. Per their definition they always work.
> 
> Yeah, my personal preference would be some variation of this.
>
> And when I say "some variation of this", I do think that having a
> per-console trylock is fine, and buffering *if* the atomic console is
> already busy (presumably with an existing oops, but possibly also for
> "setup issues" - ie things like "serial line is being configured" or
> "VGACON is in the middle of a redraw or console size change
> operation".
> 
> And yes, before anybody speaks up, that is kind of the approximation
> of the current console_trylock() logic. I am aware. And I'm also aware
> of how much people have hated it. And I'm not claiming it's perfect.

I am afraid that we have to live with some buffering. Otherwhise,
the speed of the system might be limited by the speed of the consoles.
This might be especially noticeable during boot when a lot of HW
gets initialized and tons of messages are flushed to a slow serial console.

After all, the trylock trick has been added already in 2001. It has been
only 3 years after adding SMP support (console_lock) to consoles in 1998.

> But I do think that the *typically* important case is "something went
> horribly wrong, and the console was *not* busy at the time", and
> that's the case where there is no excuse to not just print out ASAP.

Yup.

Just for record. The idea of "buffering in emergency" came up
in the opposite scenario:

<flood of messages>

CPU 0					CPU 1

WARN()
  printk()
    flush_consoles()
      # handling long backlog

					panic()
					  printk()
					    flush_consoles()
					    # successfully took over the lock
					    # and continued flushing the backlog


Result: CPU 0 never printed the rest of the WARN()

It looked acceptable because WARN() code was just printing messages,
was well tested and should never fail (last famous words).

Another motivation was that the consoles were handled by separate
threads. They might allow to see the entire WARN() on fast consoles
before a serial one prints the first line.

Also there are ways to see the messages without working consoles,
e.g. via crash dump, pstore, persistent memory. The buffer-first
approach might make even more sense in this case.

> But I really do think that we should never buffer "by default". And
> that's why I kind of hate that whole concept of "oops_begin starts
> buffering". It's exactly the kind of "buffer by default" mental model
> that I was really hoping we'd never have.

I agree that buffering in emeregency is more risky than in normal
situation. The idea needs more love. Let's continue a more
conservative way for now.

John is going to rework the series and remove the buffering in
emeregency. I am going to send another pull request with
just few trivial fixes for 6.11.

Best Regards,
Petr

