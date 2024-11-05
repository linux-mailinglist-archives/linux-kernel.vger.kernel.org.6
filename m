Return-Path: <linux-kernel+bounces-396208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CF69BC95A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269B51C22470
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43391D0F63;
	Tue,  5 Nov 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y153kTmV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977B1CCB56
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799321; cv=none; b=h8G4X0xGIGbstChr4ithucKI+HF8tzv8yUwVlLa/mDmPc0rQ8cn/FYZz/JiUgdgfsxVXum2gMKQ80s285tri4ZyGZRL+eU3voAlrAanU7UdffzBchx0Kj72vTn+xnq0iCebiPKDhTGliKITTOcp8PE1djAxdQQftdXsoxOZzi90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799321; c=relaxed/simple;
	bh=99IJmx6f12Niwpv2988wr49Eyk36O3LUDYqGQ4qyTVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBUoj1/qWHZr4GsRzcQ7g4AcZrAC3qTQCSrYQF6Hd0FxGRY3vmd/Rx/X2KqPABvZjMAA3Fs1vVlkYfHe3XfnlA9n4dWkSvns8uVKLDEMaESmgTk5f1WM8aQgXXPK4AHKUP7SjEXv6A7KQE5Plscj7Zm6+VmmBbfTUQasZab/yuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y153kTmV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FRaK+l/7iIYfosK4LCr3DExnL+BzEF6OlZuBLjXKDJc=; b=Y153kTmVcZrHV4tMzQWwnpYNr2
	uRf/LyBHhzv4i5shlLrUCk/+AxpQojzwLGTdGAiULLlOeS+1NSIbsCnvOvdKF7tNfinRWa2yYDBLw
	Po/8A+0dX1Mj3Urv9x2bgzjmo6ZnbmvgHNmRU6fUh0QrJOa2CeVUc7h2YwkMrbJoZrskXPxvTYAq0
	lYkqeoIhbHuAuP9mwE4sjBT+spP2HFa/aHzcyJs6tJvxx4D1FhkJspqKLGK5+qSxDOT7Tu1DvJP8S
	ZxS0cGAHL7rmOGTn6ZQ9w6WSoauqKG+aVelIKA6pmS9dFaqR87Fuwv88qt4XffJJXw1MLy6eJYvWj
	6ISmljgA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Fxz-00000002OBt-3yDk;
	Tue, 05 Nov 2024 09:35:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3958B30083E; Tue,  5 Nov 2024 10:35:16 +0100 (CET)
Date: Tue, 5 Nov 2024 10:35:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] time/sched_clock: Broaden sched_clock()'s
 instrumentation coverage
Message-ID: <20241105093516.GB10375@noisy.programming.kicks-ass.net>
References: <20241104161910.780003-1-elver@google.com>
 <20241104161910.780003-3-elver@google.com>
 <CANpmjNNBo6SvESFxo6Kk2v4_HOa=CeAVR_unTJvQEP8UZQG6gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNBo6SvESFxo6Kk2v4_HOa=CeAVR_unTJvQEP8UZQG6gg@mail.gmail.com>

On Tue, Nov 05, 2024 at 10:22:51AM +0100, Marco Elver wrote:
> Oops, typo'd the commit message:
> 
> On Mon, 4 Nov 2024 at 17:19, Marco Elver <elver@google.com> wrote:
> >
> > Most of sched_clock()'s implementation is ineligible for instrumentation
> > due to relying on sched_clock_noinstr().
> >
> > Split the implementation off into an __always_inline function
> > __sched_clock(), which is then used by the noinstr and instrumentable
> > version, to allow more of sched_clock() to be covered by various
> > instrumentation.
> >
> > This will allow instrumentation with the various sanitizers (KASAN,
> > KCSAN, KMSAN, UBSAN). For KCSAN, we know that raw seqcount_latch usage
> > without annotations will result in false positive reports: tell it that
> > all of __sched_clock() is "atomic" for the latch writer; later changes
> 
> s/writer/reader/
> 
> > in this series will take care of the readers.
> 
> s/readers/writers/
> 
> ... might be less confusing. If you apply, kindly fix up the commit
> message, so that future people will be less confused. The code comment
> is correct.

So done. Thanks!

