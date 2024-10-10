Return-Path: <linux-kernel+bounces-358860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 235949984D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522711C23E86
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51B41C244C;
	Thu, 10 Oct 2024 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S/xeoDtQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1A91BDA9C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559299; cv=none; b=coFPW0zI8/mVFGDHE1EuZ9yD0lPx3i1gs81XmIhdL5yiBvC5N+9XYu6GiED6KLoqKleYvD0KdLbrmp7Opo9bQ/wKVMYaIFmcmA7dzaMcOUPaqTD5yNvYz9v/DEMfKu1uHFvfqe8mz1bLj6eQnAErfyBRnK8a/mcOdp0DAzoR6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559299; c=relaxed/simple;
	bh=rR8f+de+D5b0oudKUsUYnxAfnq3kygzsXm/DO2e+OqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgT4gNunpTZuAkrnNDvXNiy09wEFgZdtIgFFUwMD96gdutsGvgqtadd07/emfP+0pFq0iiDjnemSh2FOwlZmfjVGCR2A4k9zHUE9517eG0mS38FlIHemjMviZ/XmqEBZv6IfC2pMaIh0OO7D7xiJZfIYpTRClA3PDrbDJpbs2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S/xeoDtQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l+ulxE4xZbMUB2WbEqYu/8bVJ1wR+ekFv4y5fuKOpJw=; b=S/xeoDtQiynkh0IifpkO0FjVmr
	NJdLQdYCd5yMk5eQCryNsOQBF8zpCLbKXCP6Hl2TUO9SK6nYxT0cThI+gMwOBHSx3p43RBuUdLVCr
	sSaT7WxXwXb0VXKTozRVqK2WwLpKXPyzhNRqlq+qgDPcel1/d5rjkbhpdJxQJ20OAZlcjgJjwF23Z
	lLPd62Nsg0+ve7YMg84VSYTUN+fhN36mxGFwi9wCJEpFPwvBlPQ/P/L79R37qhf8Qc2VPAHkhWxr5
	Cn0gL4EvQz0z+lZt4Pol1MmX/TRMVUuniAbyvbf49icKfnnjkk/Wi7GKK1WWyZw8Z07/pLfZ1fM9+
	8BBm3qoA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syrEa-00000007Tg3-1OT3;
	Thu, 10 Oct 2024 11:21:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 88CD130088D; Thu, 10 Oct 2024 13:21:32 +0200 (CEST)
Date: Thu, 10 Oct 2024 13:21:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
	riel@surriel.com, leobras@redhat.com, tglx@linutronix.de,
	qiyuzhu2@amd.com
Subject: Re: locking/csd-lock: Switch from sched_clock() to
 ktime_get_mono_fast_ns()
Message-ID: <20241010112132.GF17263@noisy.programming.kicks-ass.net>
References: <da9e8bee-71c2-4a59-a865-3dd6c5c9f092@paulmck-laptop>
 <20241009180708.GU17263@noisy.programming.kicks-ass.net>
 <663ad810-3318-43af-8607-17ff7fe26e4a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663ad810-3318-43af-8607-17ff7fe26e4a@paulmck-laptop>

On Wed, Oct 09, 2024 at 11:18:34AM -0700, Paul E. McKenney wrote:
> On Wed, Oct 09, 2024 at 08:07:08PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 09, 2024 at 10:57:24AM -0700, Paul E. McKenney wrote:
> > > Currently, the CONFIG_CSD_LOCK_WAIT_DEBUG code uses sched_clock()
> > > to check for excessive CSD-lock wait times.  This works, but does not
> > > guarantee monotonic timestamps. 
> > 
> > It does if you provide a sane TSC
> 
> What is this "sane TSC" of which you speak?  ;-)
> 
> More seriously, the raw reads from the TSC that are carried out by
> sched_clock() are not guaranteed to be monotonic due to potential
> instruction reordering and the like.  This is *not* a theoretical
> statement -- we really do see this on the fleet.  Very rarely for any
> given system, to be sure, but not at all rare across the full set of them.
> 
> This results in false-positive CSD-lock complaints claiming almost 2^64
> nanoseconds of delay, which are not good complaints to have.

Ooh, so the real difference is that clocksource_tsc ends up using
rdtsc_ordered() while sched_clock() ends up using rdtsc(), and you're
actually seeing that reordering happen.

*urgh*.

Yes, please put that in the Changelog.

