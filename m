Return-Path: <linux-kernel+bounces-260968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6802693B109
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A62B1C2127A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B705158A30;
	Wed, 24 Jul 2024 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k6HqRnnQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F145158A0D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825270; cv=none; b=EGqrVm3lZQUflL66Qccj3UfTzo95Ctqw+0YUg6r23YbMkV7B8cbiXCl5XeuTQBOdcxeV93uV84erTWqqWxKsxgAeshnzkDaq3dAh2ghETdPWoDrQVH484W0W8oOzfA4VKGSv8tfgjxWVPisHTJ42auL0oAI2cejuGDXgKw+zofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825270; c=relaxed/simple;
	bh=rEI68kbO01IsWFxfuQB5t/R8f7beMuFombf1KZ9aXx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEphdAafgwAZ/MXiCjhVIF1FqpxtZNQP4Hpcjgq2K2K+GLAsRz3JDpuv2S9a/ww3kThwVed8vW24GINLNc/Rf8UzQgmR+2YesZ4pRiYtB+d0jot2aDcJMXavW6vlvZVVdR/r94mc/ws2ctFYdtF2w+iIpJdaoeiW/Oq6SiZ+z+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k6HqRnnQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N39Wbz9ddKy//W04IGsAxxlEegLFgZNdpWHYEUMLTdw=; b=k6HqRnnQjjn4HRp1TAzHaMDwlU
	pxp2W4z2Jb1M3pQrAa+l46aD3UoQ7fSxmeCKzEyay2yQMLNWNHw8fKmMZGxNjTqaZIOJiCj8Ay1E+
	9AqZATYMBiAdPho1fIs7EqxWhIZR9G4ICITUeojLmH8jH1K4Ibg7eKAjgTkhCWrsmmlgFihZ7UHoS
	AIm14HcA/ga7KUHbaGiHqeP6+hNTeaVnJlTGzOoOJrWdFYqPRHP5JYETEHx4aHwZ6Z86+SA5H+vBs
	64OFTcFFITcq8yVJeVGkdoWe/4PYg0evlgD/hAJJhR557FDepOKC0U5zC3C3co6chsRlYOJgU2KWv
	tGWtjA+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWbPE-00000007pbv-0m6f;
	Wed, 24 Jul 2024 12:47:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CD0C33003EA; Wed, 24 Jul 2024 14:47:43 +0200 (CEST)
Date: Wed, 24 Jul 2024 14:47:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] printk for 6.11
Message-ID: <20240724124743.GC13387@noisy.programming.kicks-ass.net>
References: <Zp-_7R49fIHgIhaq@pathway.suse.cz>
 <CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com>
 <87ed7jvo2c.fsf@jogness.linutronix.de>
 <CAHk-=wh+cxX2Sxc6RPBKkgYO67o2mdVfW6sQNMYc_x2QoP4LOQ@mail.gmail.com>
 <ZqC-TW7ygSSF3MyO@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqC-TW7ygSSF3MyO@pathway.suse.cz>

On Wed, Jul 24, 2024 at 10:42:11AM +0200, Petr Mladek wrote:
> On Tue 2024-07-23 14:07:12, Linus Torvalds wrote:
> > On Tue, 23 Jul 2024 at 13:41, John Ogness <john.ogness@linutronix.de> wrote:
> > >
> > > Petr's pull request provides the functionality for a CPU to call
> > > printk() during emergencies so that each line only goes into the
> > > buffer. We also include a function to perform the flush at any time. As
> > > the series is implemented now, that flush happens after the warning is
> > > completely stored into the buffer. In cases where there is lots of data
> > > in the warning (such as in RCU stalls or lockdep splats), the flush
> > > happens after significant parts of the warning.
> > 
> > I really think the flushing needs to be *way* more aggressive for any
> > oops. The "flush at end" is not even remotely sane.
> > 
> > Some amount of buffering can make sense, eg when printing out the
> > regular register state over a few lines, there certainly shouldn't be
> > anything there that can cause problems.
> 
> Yes, this was the intention. I have missed the code path calling
> the notifiers. The Oops/die code is more complicated.
> 
> Otherwise, nbcon_cpu_emergency_enter()/exit() is
> used only around code printing various well defined debug
> reports, like WARN(), lockdep, or RCU stall.
> 
> Note that the buffering is only in the emergency sections.
> The messages are flushed directly after reaching panic().
> 
> Just to be sure. The buffering is _not_ there to solve cosmetic
> problems. It should allow storing important information before
> trying to flush it to consoles. It is because the flushing to consoles
> is slow, might trigger softlockups and even cause system to die.

So.. I've complained about this emergency buffering before. At the very
least the atomic consoles should never buffer and immediately print
everything. Per their definition they always work.

Slow is not a consideration. You might never reach the end of the
section, anything you can get before the machine dies is a win.

