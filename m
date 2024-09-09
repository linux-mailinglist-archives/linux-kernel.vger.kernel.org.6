Return-Path: <linux-kernel+bounces-321483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4379E971B0D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D59285C83
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0151B86FC;
	Mon,  9 Sep 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nO21K//H"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4DE1B9B4F;
	Mon,  9 Sep 2024 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888585; cv=none; b=RU1iJ1hE1LnEmNKToKNWqJ6V0o++6D9O1j6xrQMhNPlGl6/bYXXL5/iZX6jRxZK966RCALQaf72qpmYgECf48AWgziBY6FIGPmZRdbm+vJ/CobIQS+Q5FvtAEBj/r/iCe0BXGxXBzW66a0x3rNnw+GA+SiRt2fd0jEtWcT7441k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888585; c=relaxed/simple;
	bh=NSVxsFaqGlzoYc1D7+gbTul5M5Fdu6Sgfob6CN3TRhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz1QXNRJD9/BpTC4XFA8SQqfH1dzeS7KK0z4GvcDcxOE2vKi5wY4U4XAB1iZI+CCmGPx5B8j3+Jto4lqhTdbcZQ6S7fxsxhEddg+DjRH/e0Xec1Hh4CQPyPwl0eELYJroPd5OH/iaaC3IqyK/YL3+wULbPi8Jy5oiu3mkZcMLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nO21K//H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x6iQ/z/XvJ4BIsYA0tRbAU4qSXMzVxil+GOt5Tk6KkE=; b=nO21K//H+VzyF+uatXpYFlLdrS
	fRnGVBaQf8CRjrXouGKw188kJuiVQyWgftLtni/zaOK5P3M1/YO60dEUUtMSyU45BE8YUZ1rSeytF
	mhJs0xipBROCD476AS96yg5+funVP8ykEa0m2nxJVUkDUX3lzCppXbeheuTpUCP1tl2Z+b2GHlVtt
	+YlmroLMhjlPNZhU7HcHUbkg+VAQHgCVRxA6ESXor9k4TKJAHr9yaIW+wDhaXvghVo7iyHE2Wz6SF
	B87MhtORBTmaMbJy8obcG5uWZ14PiJ3q5Lwr5o1WRgjLCoVqb51S14s+kjQ5lAsvDY9kX86Yq5b6U
	RrNNIn5Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sneSa-0000000DC8Y-2Rgl;
	Mon, 09 Sep 2024 13:29:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 15AA230047C; Mon,  9 Sep 2024 15:29:41 +0200 (CEST)
Date: Mon, 9 Sep 2024 15:29:41 +0200
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
Message-ID: <20240909132941.GE4723@noisy.programming.kicks-ass.net>
References: <20240909115839.1022530-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909115839.1022530-1-andriy.shevchenko@linux.intel.com>

On Mon, Sep 09, 2024 at 02:58:39PM +0300, Andy Shevchenko wrote:
> When one or more inline heplers are unused, it prevents kernel builds
> with clang, `make W=1` and CONFIG_WERROR=y:
> 
> kernel/locking/rwsem.c:187:20: error: unused function 'is_rwsem_reader_owned' [-Werror,-Wunused-function]
>   187 | static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
>       |                    ^~~~~~~~~~~~~~~~~~~~~
> kernel/locking/rwsem.c:271:35: error: unused function 'rwsem_owner' [-Werror,-Wunused-function]
>   271 | static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
>       |                                   ^~~~~~~~~~~
> 
> Fix this by marking inline helpers with __maybe_unused.
> 
> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build").

:-(

And now you're back to the exact situation that people tried to avoid.
The moment one of these functions goes unused it will no longer scream
about it.

I'm for reverting the above commit, that gets all static inline on the
same footing, it should not matter if code is from a header file or not.

