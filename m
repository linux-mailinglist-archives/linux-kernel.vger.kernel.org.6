Return-Path: <linux-kernel+bounces-269519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA69433BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A151F2286D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979E01BBBD9;
	Wed, 31 Jul 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QKvg0pVv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E21799F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441360; cv=none; b=s094qQP45ZEMChB8LXXAdMcinj+s5rnF3uT7Pm6gsSuWAql2FUApG8FmtJG76LHfwjQcSfxKHeh/XpdQU+Gvukg7ozpmnyRfOU1/yynL3QFKmPUCxTDWGh+xe8muYDjAMzfrWPKXZP7NKcjlh415qk0/UJQaT/uo5AfdJqpdq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441360; c=relaxed/simple;
	bh=6XF4YIj59e7zrAsbn8/nH1a0LI0bb8OJzuqyiCDeigQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWgmJHEz3SzGt95gnZKN29B88ROvDaQWVzVxWjQfHEywOWSpU8p8fKq4cUSo+XJVKQToh7mis5pWiJv8CjlOD5B8Evx3BjZS/TEW6iwQDPvEUihsHjSxPx3rimQM3IeCwruha3FS1KHt1j/k1lHh5u85ZhRxmoVH8vDXo1KtRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QKvg0pVv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oqWCpJ/IOCwO3N+Fd14LHfpkFTfnRK6w+dw2iKEizK0=; b=QKvg0pVvfP6GByrjF5RTsBd/IB
	0mrOk5uiFo6vls/A43wl+u85uZKa4S+R4qZY83pFjAhqjY1AQ4ogWQ+6VZLVnL+LoFsaTNT0yVoc7
	uu1zEt0fGwDDHNMlEGkAIjmi72AW85gUSBHXye3SLFPhd5C1AG/gdSBJEsfTY9nMLbUrrpYdeXMFI
	t/k0azIIASgptrjPpHKNw/ew9RF0da5fJLxmkiY3S5c/da16tlibloclyqW9dIQ1y5iMCLfCrd7tR
	zyqPjK/Uagvbo63IZdWIPhVyM/CutGfLENWb6fGSWnDcngDXb9UQ1dg7eIOGmNP3UXFq4G/PSlQiq
	kVUZaZNw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZBg8-0000000GJ0l-3nCK;
	Wed, 31 Jul 2024 15:55:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A971B300820; Wed, 31 Jul 2024 17:55:51 +0200 (CEST)
Date: Wed, 31 Jul 2024 17:55:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240731155551.GF33588@noisy.programming.kicks-ass.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net>
 <87mslx67dm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mslx67dm.ffs@tglx>

On Wed, Jul 31, 2024 at 03:03:33PM +0200, Thomas Gleixner wrote:
> On Wed, Jul 31 2024 at 14:20, Peter Zijlstra wrote:
> > On Tue, Jul 30, 2024 at 01:24:34PM -0700, Guenter Roeck wrote:
> >> An interesting bit of information: The problem is seen with many,
> >> but not all CPUs. For example, I don't see it with athlon, n270, Dhyana,
> >> or EPYC. qemu32 is affected, but qemu64 is fine. But on the other side
> >> both kvm32 and kvm64 are affected.
> >
> > pti=off makes it go away, could be those CPU models don't have meltdown
> > and as such don't enable PTI.
> 
> The AMD ones don't have meltdown and neither does n270 which is an
> in-order atom.

Right, so Thomas found that i386-pti fails to map the entire entry text.
Specifically pti_clone_pgtable() hard relies -- and does not verify --
that the start address is aligned to the given granularity.

Now, i386 does not align __entry_text_start, and so the termination
condition goes sideways and pte_clone_entry() does not always work right
and it becomes a games of code layout roulette.

Still trying to figure out what the right fix is. I've tried page
aligning the section and using PTE cloning, and that works -- mostly. If
you hit a source PMD the clone logic still does a PMD level clone and
that might not be what we want, see the alignment thing again.

Also, should we just kill PTI on 32bit perhaps?

