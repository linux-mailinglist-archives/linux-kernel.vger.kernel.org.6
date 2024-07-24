Return-Path: <linux-kernel+bounces-260772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832493ADFC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A45285133
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4F214C588;
	Wed, 24 Jul 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V7hooiT5"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417314A618
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810537; cv=none; b=hUcs6mvOpOmfv1P5idkGO5cGyVLBtZghKQXKSAQ54hHvcZvjH5OIMOnmzIZRh+keB1rO+sVL4PB7jkvSCDAVn/ppLhIQNhNosucubsagQh3Fie7zwMEhUVD7pYeIkldZN0XHfFS3Yz2L72RAonjSzwVaZC6o+TPk8eI0yfHIFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810537; c=relaxed/simple;
	bh=dRaXx4zhc1Zv0qN6tW50e9lUanIHMymNOcrHGs+mgwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZbo8GxmWt6C/i1/tWXMOrZNaGGegkAX+QPX7GJm/aYlascz3EUjyVVHLNQGJRpLYgQ+GbwXSLjZ2ojXnSWyhs/e5MM6iuGlduiyFhOwHpKoXdLVY5ANwPh/LTVEJ2QIpZ7ByhC9OqXQ2nSeLBVEIJ20PtC1Rl4g0YeXY7pCKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V7hooiT5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6fd513f18bso69092966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721810534; x=1722415334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KtyQv5HexZe2fk5kRP3WPGWGtAq8HhrTt6oatWGn9o=;
        b=V7hooiT59Fkl4GCVrDFMVlVWCFQyX+OfU8wghLnu2eIRJ1ehZLG1DhSnCbeTnWNi2X
         Frs2c6hd5tbQPCGS7SkifknnhgCy4e6b+tnGum0pUsjQa/PeGiBRAtJPOjTaKW4QtNJX
         RumZZ9eNztFVyG7gWwJOTTB0tf6bPpOH8qnEVIRhfnw4fbVPAssNYuSjhBWiGQm9BLOq
         2T1YT8F079hsQtHWIG5WiSmtKMMF/tVCa618u2FOUBg/ZuR6NgtQLvFc+sJV7pFcpn+0
         RhGQt069ZOSQjlifqhNQxDb9lCa7lL9zD5qQOxAqufqrRn5f4YixwhPB/WFOKUgqBYpt
         /bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721810534; x=1722415334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KtyQv5HexZe2fk5kRP3WPGWGtAq8HhrTt6oatWGn9o=;
        b=TAsTJMgDSWb6+za2kgo+9vVztc6C3GO+FReSLAVRsHe/N0ElQZK4BxwcT7yKHZt2gK
         6+2qp3cK5ylsclUDvvCPJGFGD+spw1B04Hihmbcz6B+DSPIADuDmwRJeVG7giXB5mldw
         nejRGNCE7LaHGZNJPoGEqlIQ0i/Y9be+ZT0RVEK/62yXeVc+3/dK7hcFjHRtKvAJHYHM
         xHCtJINcuKoSHMEb9/bdrqGSjcSTJUKvq27aWj9ZScgiWc2f+MInXlJtKySMZByPzSB+
         aQ3tQPsmoUhmoCo8usbqni+9aKNln7gugmdGeyuTL/mJIldx8olNbPCgsrnwCe8jre3q
         ko9g==
X-Forwarded-Encrypted: i=1; AJvYcCWhqx2xFFbkMqlmZuKg2hTXXEDelS07nSjGtSMqpFeb3OnLG6PjDqvuysAix4zHvQrygnTzJt+iMYfdjbifqyRsp1/lpAr3YEV2yaUv
X-Gm-Message-State: AOJu0YyZLZOYUS+Yt/zd5UOLKgXTnQnlMjOOTfg3V3gsF0cf+LpMQut1
	+PciV4ed2HZhDAn+xJVQEEVgbRSFxbl0nfo9e+gYTJUFGymSuxKunyubPun2h2g=
X-Google-Smtp-Source: AGHT+IEtTP2j6IqBui4R3toQ/I+dJ9h1Y47mZGqO6BPCAnTdP6wRHzXCVqelZuz9MMc5vKDou9Z4yw==
X-Received: by 2002:a17:907:7f0f:b0:a7a:a5ed:43d0 with SMTP id a640c23a62f3a-a7aa5ed4babmr203610566b.47.1721810533683;
        Wed, 24 Jul 2024 01:42:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a8cdd4409sm181606366b.66.2024.07.24.01.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:42:13 -0700 (PDT)
Date: Wed, 24 Jul 2024 10:42:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] printk for 6.11
Message-ID: <ZqC-TW7ygSSF3MyO@pathway.suse.cz>
References: <Zp-_7R49fIHgIhaq@pathway.suse.cz>
 <CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com>
 <87ed7jvo2c.fsf@jogness.linutronix.de>
 <CAHk-=wh+cxX2Sxc6RPBKkgYO67o2mdVfW6sQNMYc_x2QoP4LOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+cxX2Sxc6RPBKkgYO67o2mdVfW6sQNMYc_x2QoP4LOQ@mail.gmail.com>

On Tue 2024-07-23 14:07:12, Linus Torvalds wrote:
> On Tue, 23 Jul 2024 at 13:41, John Ogness <john.ogness@linutronix.de> wrote:
> >
> > Petr's pull request provides the functionality for a CPU to call
> > printk() during emergencies so that each line only goes into the
> > buffer. We also include a function to perform the flush at any time. As
> > the series is implemented now, that flush happens after the warning is
> > completely stored into the buffer. In cases where there is lots of data
> > in the warning (such as in RCU stalls or lockdep splats), the flush
> > happens after significant parts of the warning.
> 
> I really think the flushing needs to be *way* more aggressive for any
> oops. The "flush at end" is not even remotely sane.
> 
> Some amount of buffering can make sense, eg when printing out the
> regular register state over a few lines, there certainly shouldn't be
> anything there that can cause problems.

Yes, this was the intention. I have missed the code path calling
the notifiers. The Oops/die code is more complicated.

Otherwise, nbcon_cpu_emergency_enter()/exit() is
used only around code printing various well defined debug
reports, like WARN(), lockdep, or RCU stall.

Note that the buffering is only in the emergency sections.
The messages are flushed directly after reaching panic().

Just to be sure. The buffering is _not_ there to solve cosmetic
problems. It should allow storing important information before
trying to flush it to consoles. It is because the flushing to consoles
is slow, might trigger softlockups and even cause system to die.


> Let me pick a very specific example of a common thing:
> 
>    int __die(const char *str, struct pt_regs *regs, long err)
> 
> in arch/x86/kernel/dumpstack.c.
> 
> Look, do I expect problems in "__die_header()"? No.
> 
> But the *moment* you call "notify_die()", you are now calling random
> debug code. The register state NEEDS TO HAVE BEEN FLUSHED before this
> point.

This primary goes down to notifiers (random debug code). It would make sense
to try flushing the consoles before calling them. A generic solution
would be:

diff --git a/kernel/notifier.c b/kernel/notifier.c
index b3ce28f39eb6..82989022d8fe 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -77,6 +77,8 @@ static int notifier_call_chain(struct notifier_block **nl,
 	int ret = NOTIFY_DONE;
 	struct notifier_block *nb, *next_nb;
 
+	nbcon_cpu_emergency_flush();
+
 	nb = rcu_dereference_raw(*nl);
 
 	while (nb && nr_to_call) {


> This is not something I'm willing to debate. Some of the most painful
> debugging sessions I have *EVER* had have been due to "debug code that
> failed".

I could imagine a bug even in WARN() or lockdep. We should probably
add an option to disable the buffering in emergency sections.

All in all, the buffering in emergency sections was just
a "sounds reasonable" idea which popped out during the demo at
Plumbers. It is not a clear win. We just wanted to give it a try.

Will it get acceptable if we flush the messages before calling
notifiers and with an option to disable it? I am not sure
whether it deserves more code. It probably would make sense to remove
it when it causes more harm than good in practice.

Best Regards,
Petr

