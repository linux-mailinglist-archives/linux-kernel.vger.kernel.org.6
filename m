Return-Path: <linux-kernel+bounces-321565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E85D8971C12
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58FC2849F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6526E1B9B55;
	Mon,  9 Sep 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EHAtE3kG"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37422095;
	Mon,  9 Sep 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890629; cv=none; b=hq84vnmy4xYEy0JpRUQ4R3pYGBu3IW1Gx2EP+FdQ+pwtHFoIkTnWv8P0ehHpcYbWvTevX3ysw7tqPj/OqSFP9hnk4aiEKdnKbdhddZYG5qgTrBNVqGkRBItD7FSJGgLzHPtXebt9Iboxj/mnJxw5F1ThbsrBLBbjKMt+QUHbYdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890629; c=relaxed/simple;
	bh=+vGpIVSxvSwqHTTP9hcUvgqSNHUq1cCP96E1lJCiJu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2FQv0TlZLecF4JRjbo4iWJqgs8638P9kt1hCSL3hNL3iQkRJk1NkbNSCwTqGcJVPQm92f649XeSL4cudDa/2bMmC1KVUZY60AEMvY/pIobNyyWa44i5eckqKa+oquTcYE9heo3cH0Lu73GHEPcDEHjEOXtIxXZvJ6vpGba27h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EHAtE3kG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gOA5j5oi1gDKRnnYQnE6/p97+jQgJiwAHIJ+Jxwcn0U=; b=EHAtE3kG8+bND9m9IqjIych841
	4VAKpI9fhQbH9Ss5i7s0wymzeVO7RdrUYByC2wEY24XjchmThOh1NlRJO0f+2c3J4e8FGPL+ne/A7
	RT7A2shJF5Ohid7lMaX2Rq+QAcCdZyQy6zBGtZwz5EIlSqZ8ixLMR8XYQfDyuKlY9+FTCabes4/pJ
	2Q+4tLqoAXR64x6hicwmU2E37YkuwPmS17BP2wrIUZKlN7HoZNfCUCEOqISpA8eRO2RF/053Q0ukY
	EFL833eee0aY4s9ekxyXa8kARKWhFqZ6wRcktGjBgNUmeuFN5gJC3ffu8Ot3VnIVwnnwY+htxzrLr
	jV6UMKCg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snezX-00000000RlF-1icY;
	Mon, 09 Sep 2024 14:03:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C758130047C; Mon,  9 Sep 2024 16:03:42 +0200 (CEST)
Date: Mon, 9 Sep 2024 16:03:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] locking/rwsem: Mark inline helpers with
 __maybe_unused
Message-ID: <20240909140342.GF4723@noisy.programming.kicks-ass.net>
References: <20240909115839.1022530-1-andriy.shevchenko@linux.intel.com>
 <20240909132941.GE4723@noisy.programming.kicks-ass.net>
 <Zt7-zhkwxy7E-KGb@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt7-zhkwxy7E-KGb@smile.fi.intel.com>

On Mon, Sep 09, 2024 at 04:57:34PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 09, 2024 at 03:29:41PM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 09, 2024 at 02:58:39PM +0300, Andy Shevchenko wrote:
> > > When one or more inline heplers are unused, it prevents kernel builds
> > > with clang, `make W=1` and CONFIG_WERROR=y:
> > > 
> > > kernel/locking/rwsem.c:187:20: error: unused function 'is_rwsem_reader_owned' [-Werror,-Wunused-function]
> > >   187 | static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
> > >       |                    ^~~~~~~~~~~~~~~~~~~~~
> > > kernel/locking/rwsem.c:271:35: error: unused function 'rwsem_owner' [-Werror,-Wunused-function]
> > >   271 | static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
> > >       |                                   ^~~~~~~~~~~
> > > 
> > > Fix this by marking inline helpers with __maybe_unused.
> > > 
> > > See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> > > inline functions for W=1 build").
> > 
> > :-(
> > 
> > And now you're back to the exact situation that people tried to avoid.
> > The moment one of these functions goes unused it will no longer scream
> > about it.
> 
> Yeah... The problem is that I don't know well this code. This is, of course,
> just a quickfix, the proper one should probably locate the function under
> the proper guards (here all of them are used only for debugging AFAICS).
> But I'm not sure. Hence consider this as
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Yeah, so I'm *waaaay* too overloaded to care about this make-work
nonsense, the people that made this happen can either go and revert
their ill considered patch or spend their own time trying to come up
with a sane solution.

> > I'm for reverting the above commit, that gets all static inline on the
> > same footing, it should not matter if code is from a header file or not.
> 
> Is it the case? Because to me it seems to complain only on C files.

It's a clang special, and it used to be suppressed, but for some
mysterious reason people seem to want to re enable this behaviour. But
like said, if they want this, they can spend the time fixing their own
fallout.

