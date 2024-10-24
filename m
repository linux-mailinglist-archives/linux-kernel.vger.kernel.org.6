Return-Path: <linux-kernel+bounces-379671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD89AE219
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A4B2B23801
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F191C07CD;
	Thu, 24 Oct 2024 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S91c0fUV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5151BC9EB;
	Thu, 24 Oct 2024 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764362; cv=none; b=PdeR0kDQDocwP+5MxzuMG0Lfcatfa9mmZr3hoOoasO8A0e3NiPEI9DVdQ+VArJdXZH/DVPBKSzzOy34PMs2jMxrl4zFxuRveccAjRJiBTpEo8CN9m8DyHewgs1cDag0cqi9Sz9E354SvSNiFvI+cYY/e+w+9/KaL8gTvtpOwHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764362; c=relaxed/simple;
	bh=vMnzIe1Y7VLgul6Sg3fg/HURFiCbI/ZKfQebAyqFYdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3wY0+Q4nC1BIhgurWBmwYx9UaEDuA88s3V9U9ZV4uBY3M4Bdn2vPkDCsmf5Zz7cU0ynASUbqw96ILlhPiYdWp80UBb6VKjpNT2L9TCKBH89YtW6JWFkmGIBXk4JbyYEG5K3yLBBAsFBUamZ6z180bIySv2/87/CBfQA6JeNqf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S91c0fUV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m0wed4gUWIFjxZRcY+/N6dXDmR+cmXo9MUg9q4akerw=; b=S91c0fUV8L1tqPcUolusAK1XeB
	q6UBGyKlQ1QC9iatUFekrOqrTGz4DnC+JmKJlYz9fMWLy7B/zbUQd1lCf0Vw4m5EGVIq7vrPcNLia
	VXp2ByYpa5/TGCg577IChXWoy2nSGEgfFkRaEvcuVRGRmmDgvdJyHOpQV9xauMIUq8zqxgPA6cdkb
	Iv6fhEtiZABufyHrz6z7vVzlHyzoE6ABXQDUTUSdb/bpOMJxcFgN9BCkBZTz5Sdv8xl9tqagb2vxs
	1z7WQONYbiQ6KYh71/Ui+ZwAP3AGjH3S1zINjIwpKmiOm+03Jz4Gw1SiOvYU8SXzzHSQRuRZFocuF
	SMLqh85g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3uio-0000000426s-1yeJ;
	Thu, 24 Oct 2024 10:05:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4BAE1300599; Thu, 24 Oct 2024 12:05:38 +0200 (CEST)
Date: Thu, 24 Oct 2024 12:05:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Dirk Behme <dirk.behme@gmail.com>,
	Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>, will@kernel.org,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>, aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [POC 1/6] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <20241024100538.GE9767@noisy.programming.kicks-ass.net>
References: <20241018055125.2784186-2-boqun.feng@gmail.com>
 <87a5eu7gvw.ffs@tglx>
 <20241023195152.GE11151@noisy.programming.kicks-ass.net>
 <877c9y7dwx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877c9y7dwx.ffs@tglx>

On Wed, Oct 23, 2024 at 10:38:38PM +0200, Thomas Gleixner wrote:
> On Wed, Oct 23 2024 at 21:51, Peter Zijlstra wrote:
> > On Wed, Oct 23, 2024 at 09:34:27PM +0200, Thomas Gleixner wrote:
> >> On Thu, Oct 17 2024 at 22:51, Boqun Feng wrote:
> >> Ideally you make that part of the preemption count. Bit 24-30 are free
> >> (or we can move them around as needed). That's deep enough and you get
> >> the debug sanity checking of the preemption counter for free (might need
> >> some extra debug for this...)
> >
> > Urgh, so we've already had trouble that nested spinlocks bust through
> > the 0xff preempt mask (because lunacy).
> 
> Seriously? Such overflow should just panic the kernel. That's broken by
> definition.

It will not panic, it will mostly work and randomly do weird things.
Only once you build with DEBUG_PREEMPT=y will you notice.

> > You sure you want to be this stingy with bits?
> 
> Anything above 64 nest levels is beyond insane.

Agreed.

> But if we want to support insanity then we make preempt count 64 bit and
> be done with it. But no, I don't think that encouraging insanity is a
> good thing.

The problem is that in most release builds the overflow will be silent
and cause spurious weirdness that is a pain in the arse to debug :/

That is my only concern -- making insane code crash hard is good, making
it silently mostly work but cause random weirdness is not.

> It actually makes a lot of sense even for the non rust case to avoid
> local_irq_save/restore. We discussed that for years and I surely have
> some half finished patch set to implement it somewhere in the poison
> cabinet.

Heh, yeah, me too. I even have patches using CR8 *somewhere*.

