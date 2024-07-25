Return-Path: <linux-kernel+bounces-262268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A3193C344
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B861C20EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4E01993A5;
	Thu, 25 Jul 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F726falk"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945151DA4D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915281; cv=none; b=gC9vZtN6gZaJ9NBZzjpDfhfNHRMQZvoeuYLVNbXR+duA6Osfu42pwfsQJ5C8Y0c4Bzv+jqUa8Q/JrEPNtUnwucRJlMqNrcQvHq41A5ERJI/9BCZLtCzh6M1fHfwx1YfttUnTvQzuEBgtDrFndZbOa4BupEQ6wxTqrIKHt1CcUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915281; c=relaxed/simple;
	bh=Wm8ilx4x4Erxx+u78DJk8dIS71vA0lZ1xbLwcWlLjhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk0AW8BiriSmTH5cbfBYBhQJY/TWDsEyfmQyypve4VRr4XG00UlhBwAlNG3/gZqLtsrPbpNqoTMJOny/9cskE2Ui12gGLWnL5SXi2mo4MCmNeSxcOx/eM7lTbJjTN036fCYMLFzdbBLueMCtmS/q/qgyb94hssOUfWvvDH3qx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F726falk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wm8ilx4x4Erxx+u78DJk8dIS71vA0lZ1xbLwcWlLjhc=; b=F726falkCUxKnITcG+hmWz3D9B
	M0PT/XRjMhC3LyqqnJGeFSzL+mOSTw0V7nrvRhQi3iPH/BLMYHCJMBZByGbviT1XtgkSq7MIl2OCa
	1lJck2g3lbiZ1ChFePZorKhNgr/odagUczbDVs2SOEIclmAQnim1U02W66gXx4ruCRMX210F7DKki
	C8EE6PP3zN6JgDGlHm+5I/OqYBl8xHM4QM7tRPe+7PGUDabebRiC1k/8aXzcialFBVv6JKbKOPeMt
	I4c+R2tt67YdiznX2fyTwEzSvvO2EtC5Mq3PEjEPW9nhOFyuAK/tMl1BZ33511yt52YmqmoVGtqR5
	ws9uTKRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWyop-000000041p1-3Sq3;
	Thu, 25 Jul 2024 13:47:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A0C9630037B; Thu, 25 Jul 2024 15:47:42 +0200 (CEST)
Date: Thu, 25 Jul 2024 15:47:42 +0200
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
Message-ID: <20240725134742.GG13387@noisy.programming.kicks-ass.net>
References: <Zp-_7R49fIHgIhaq@pathway.suse.cz>
 <CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com>
 <87ed7jvo2c.fsf@jogness.linutronix.de>
 <CAHk-=wh+cxX2Sxc6RPBKkgYO67o2mdVfW6sQNMYc_x2QoP4LOQ@mail.gmail.com>
 <ZqC-TW7ygSSF3MyO@pathway.suse.cz>
 <20240724124743.GC13387@noisy.programming.kicks-ass.net>
 <CAHk-=wgJrCwOwj4myGgpgyig9dX37hir1S2Xdeg1=kVS-hPzAg@mail.gmail.com>
 <ZqJKbcLgTeYRkDd6@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqJKbcLgTeYRkDd6@pathway.suse.cz>

On Thu, Jul 25, 2024 at 02:51:57PM +0200, Petr Mladek wrote:

> I am afraid that we have to live with some buffering. Otherwhise,
> the speed of the system might be limited by the speed of the consoles.
> This might be especially noticeable during boot when a lot of HW
> gets initialized and tons of messages are flushed to a slow serial console.

Only if you create a slow atomic console. But other than that, I've been
booting like that for at least the last decade or so.

Most all my test boxes have forced synchronous earlyprintk at 115200
baud. It has saved me untold times.

I suppose I'll just keep my own printk hackery around for longer.

