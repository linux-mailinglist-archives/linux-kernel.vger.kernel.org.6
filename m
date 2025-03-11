Return-Path: <linux-kernel+bounces-556233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BFFA5C2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52573A7B11
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859651CAA63;
	Tue, 11 Mar 2025 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILyfvOlp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CDE1F94D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700688; cv=none; b=Jx6TZArtW4puiSbkXpdEdpegWI/bPUyUERo6IeVx8TYlT6KHBjRADaEiSsH3ZKa0YU2vM71MyfITCnP2gI04SyXBIQr31Taex05OJiKqSGPqwepGqTHiZdAdAGUXWga8FNha5+cbpcuhxy7L6xT5laElX3ZqpG3Gb372te8az4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700688; c=relaxed/simple;
	bh=cm+iF+aGtZjkYIMhVaaxWe+vQ2fbA3j5p5hkXA2Xykc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOkozq3mHSFwIjivlX3nKBvt+/XRvff4p1rlH8F02Z2jcI2ngPC6RUxg41pDVweW7KRkK2IZYaBu9j3zYmh10W6/+5dGSFY1DsyBh3so6CU6YFDetoAUNrVCEjK6PvNwVD0M6s+HSq4eNjbt3h/FBsGhSx4qxfywNYfB4XEP0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILyfvOlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D1CC4CEEC;
	Tue, 11 Mar 2025 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741700688;
	bh=cm+iF+aGtZjkYIMhVaaxWe+vQ2fbA3j5p5hkXA2Xykc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILyfvOlp7Z4I6SodkTKdJSTYTf5kKzu2EEv9pN1husrXOrgF2akBtG6g+MNz/rxie
	 RzAbnegiFIfGxduyPmKiW9RMB73pBf+6e5Ty4N1B0blcCSXTejRkxuCryjIBbENypv
	 n+KySCDsA3+5iyTqQ6WyT1M3GZ6zOsINXm3LM/N4bd0xKqIGFnUV+dwN0OuW9ocSp/
	 tpySPlbORbf3pMslyXbTApSQKrYP7Amusz9hbdgQov+wgHFWFmtJa4XXQxRFLSvtqU
	 YPnOsTD5mLZwctcJf2wVCpFjDG99uKkvrn1NvTl7fc7DHm4/EvjxDymdN+PXbVRExn
	 UISIxty4l4o7w==
Date: Tue, 11 Mar 2025 14:44:45 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3 12/18] posix-timers: Improve hash table performance
Message-ID: <Z9A-TWTX9Yl6zlst@localhost.localdomain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.216091571@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308155624.216091571@linutronix.de>

Le Sat, Mar 08, 2025 at 05:48:38PM +0100, Thomas Gleixner a écrit :
> Eric and Ben reported a significant performance bottleneck on the global
> hash, which is used to store posix timers for lookup.
> 
> Eric tried to do a lockless validation of a new timer ID before trying to
> insert the timer, but that does not solve the problem.
> 
> For the non-contended case this is a pointless exercise and for the
> contended case this extra lookup just creates enough interleaving that all
> tasks can make progress.
> 
> There are actually two real solutions to the problem:
> 
>   1) Provide a per process (signal struct) xarray storage
> 
>   2) Implement a smarter hash like the one in the futex code
> 
> #1 works perfectly fine for most cases, but the fact that CRIU enforced a
>    linear increasing timer ID to restore timers makes this problematic.
> 
>    It's easy enough to create a sparse timer ID space, which amounts very
>    fast to a large junk of memory consumed for the xarray. 2048 timers with
>    a ID offset of 512 consume more than one megabyte of memory for the
>    xarray storage.
> 
> #2 The main advantage of the futex hash is that it uses per hash bucket
>    locks instead of a global hash lock. Aside of that it is scaled
>    according to the number of CPUs at boot time.
> 
> Experiments with artifical benchmarks have shown that a scaled hash with
> per bucket locks comes pretty close to the xarray performance and in some
> scenarios it performes better.
> 
> Test 1:
> 
>      A single process creates 20000 timers and afterwards invokes
>      timer_getoverrun(2) on each of them:
> 
>             mainline        Eric   newhash   xarray
> create         23 ms       23 ms      9 ms     8 ms
> getoverrun     14 ms       14 ms      5 ms     4 ms
> 
> Test 2:
> 
>      A single process creates 50000 timers and afterwards invokes
>      timer_getoverrun(2) on each of them:
> 
>             mainline        Eric   newhash   xarray
> create         98 ms      219 ms     20 ms    18 ms
> getoverrun     62 ms       62 ms     10 ms     9 ms
> 
> Test 3:
> 
>      A single process creates 100000 timers and afterwards invokes
>      timer_getoverrun(2) on each of them:
> 
>             mainline        Eric   newhash   xarray
> create        313 ms      750 ms     48 ms    33 ms
> getoverrun    261 ms      260 ms     20 ms    14 ms
> 
> Erics changes create quite some overhead in the create() path due to the
> double list walk, as the main issue according to perf is the list walk
> itself. With 100k timers each hash bucket contains ~200 timers, which in
> the worst case need to be all inspected. The same problem applies for
> getoverrun() where the lookup has to walk through the hash buckets to find
> the timer it is looking for.
> 
> The scaled hash obviously reduces hash collisions and lock contention
> significantly. This becomes more prominent with concurrency.
> 
> Test 4:
> 
>      A process creates 63 threads and all threads wait on a barrier before
>      each instance creates 20000 timers and afterwards invokes
>      timer_getoverrun(2) on each of them. The threads are pinned on
>      seperate CPUs to achive maximum concurrency. The numbers are the
>      average times per thread:
> 
>             mainline        Eric   newhash   xarray
> create     180239 ms    38599 ms    579 ms   813 ms
> getoverrun   2645 ms     2642 ms     32 ms     7 ms
> 
> Test 5:
> 
>      A process forks 63 times and all forks wait on a barrier before each
>      instance creates 20000 timers and afterwards invokes
>      timer_getoverrun(2) on each of them. The processes are pinned on
>      seperate CPUs to achive maximum concurrency. The numbers are the
>      average times per process:
> 
>             mainline        eric   newhash   xarray
> create     157253 ms    40008 ms     83 ms    60 ms
> getoverrun   2611 ms     2614 ms     40 ms     4 ms
> 
> So clearly the reduction of lock contention with Eric's changes makes a
> significant difference for the create() loop, but it does not mitigate the
> problem of long list walks, which is clearly visible on the getoverrun()
> side because that is purely dominated by the lookup itself. Once the timer
> is found, the syscall just reads from the timer structure with no other
> locks or code paths involved and returns.
> 
> The reason for the difference between the thread and the fork case for the
> new hash and the xarray is that both suffer from contention on
> sighand::siglock and the xarray suffers additionally from contention on the
> xarray lock on insertion.
> 
> The only case where the reworked hash slighly outperforms the xarray is a
> tight loop which creates and deletes timers.
> 
> Test 4:
> 
>      A process creates 63 threads and all threads wait on a barrier before
>      each instance runs a loop which creates and deletes a timer 100000
>      times in a row. The threads are pinned on seperate CPUs to achive
>      maximum concurrency. The numbers are the average times per thread:
> 
>             mainline        Eric   newhash   xarray
> loop	    5917  ms	 5897 ms   5473 ms  7846 ms
> 
> Test 5:
> 
>      A process forks 63 times and all forks wait on a barrier before each
>      each instance runs a loop which creates and deletes a timer 100000
>      times in a row. The processes are pinned on seperate CPUs to achive
>      maximum concurrency. The numbers are the average times per process:
> 
>             mainline        Eric   newhash   xarray
> loop	     5137 ms	 7828 ms    891 ms   872 ms
> 
> In both test there is not much contention on the hash, but the ucount
> accounting for the signal and in the thread case the sighand::siglock
> contention (plus the xarray locking) contribute dominantly to the overhead.
> 
> As the memory consumption of the xarray in the sparse ID case is
> significant, the scaled hash with per bucket locks seems to be the better
> overall option. While the xarray has faster lookup times for a large number
> of timers, the actual syscall usage, which requires the lookup is not an
> extreme hotpath. Most applications utilize signal delivery and all syscalls
> except timer_getoverrun(2) are all but cheap.
> 
> So implement a scaled hash with per bucket locks, which offers the best
> tradeoff between performance and memory consumption.
> 
> Reported-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Benjamin Segall <bsegall@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

