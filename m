Return-Path: <linux-kernel+bounces-411881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D49D00B0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 20:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE4BB24A31
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F31922F9;
	Sat, 16 Nov 2024 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rdFSAoSm"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194EA79F6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785501; cv=none; b=ba15TNxGaUPHtYWyld/XpwvjK/I/5EFKbPcEKHjeClb38h25T7mmG432SH1Xu7ah3T4nLg6eviSdvXJYTAemhg5TeVFRUSo7xV8W8JBi0bV/yBSFlSvaqx7B/qArpFerXP5lXlHUTFa7MOWZVRPwAXYKn/ZjB/tRYf1zspa09sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785501; c=relaxed/simple;
	bh=r6oQfix8wUuXlVmYjQb9v1ZYf0vJmxNgyEXzPC8Q97k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gz/8jrSugygInFE+ZVaz+SxvHYQ7pFgEt63zeKt2vmLFbRgudT3p9ZEG2bNJFuPuf/YYZ8K5Cp/JWglo0Sbpp4hTZ/7YETGkG2rITWqgY/aQ7v6aBaj2wDsM3izEfXi3jxo2WR7nj8ee8XTrmjYfLODF3B2OZC6QR70cks6rJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rdFSAoSm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T2o4z8+d/HYkkXnvqMQD2BrDXBLXib5DWkBuQRiuISc=; b=rdFSAoSmnwX8wiuEvW0lMJJH1x
	iiiXoKiQcdxuY+IditwxTuEUE5F17Pvec99VAahsm/M9a0GEsS9GhDx1HHLvWVXjZkULmPgUNAVZR
	4cj9gs2mHhbTCbc1irbz7qT32IltZHptoPX6Z2S5ejK67Uj9c3fxUcoln5wvDVFSDOz38I7KgbDH5
	hmryjxabRCcYljgfvcEh+EYEgcPEsJRnfjpiJoe31KsPMTtMAdWHQ0jdzkaF/hWDNQpksBjlok/Y4
	/wJN9lAVv2x7RjciefgmSerbJcLzoYSQt2ib0Gbm7FkWALLsN+1fAYzpeE6OY9hiVAPtMsscw3iW9
	fxOe12ug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tCOVw-000000003NZ-2W8c;
	Sat, 16 Nov 2024 19:31:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CFF7E300472; Sat, 16 Nov 2024 20:31:23 +0100 (CET)
Date: Sat, 16 Nov 2024 20:31:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Changwoo Min <multics69@gmail.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
	changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] sched_ext: Implement scx_bpf_clock_get_ns()
Message-ID: <20241116193123.GP22801@noisy.programming.kicks-ass.net>
References: <20241116160126.29454-1-changwoo@igalia.com>
 <20241116160126.29454-4-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116160126.29454-4-changwoo@igalia.com>

On Sun, Nov 17, 2024 at 01:01:24AM +0900, Changwoo Min wrote:
> Returns a high-performance monotonically non-decreasing clock for the
> current CPU. The clock returned is in nanoseconds.
> 
> It provides the following properties:
> 
> 1) High performance: Many BPF schedulers call bpf_ktime_get_ns()
>  frequently to account for execution time and track tasks' runtime
>  properties. Unfortunately, in some hardware platforms, bpf_ktime_get_ns()
>  -- which eventually reads a hardware timestamp counter -- is neither
>  performant nor scalable. scx_bpf_clock_get_ns() aims to provide a
>  high-performance clock by using the rq clock in the scheduler core
>  whenever possible.
> 
> 2) High enough resolution for the BPF scheduler use cases: In most BPF
>  scheduler use cases, the required clock resolution is lower than the
>  most accurate hardware clock (e.g., rdtsc in x86). scx_bpf_clock_get_ns()
>  basically uses the rq clock in the scheduler core whenever it is valid.
>  It considers that the rq clock is valid from the time the rq clock is
>  updated (update_rq_clock) until the rq is unlocked (rq_unpin_lock).
>  In addition, it invalidates the rq clock after long operations --
>  ops.running() and ops.update_idle() -- in the BPF scheduler.
> 
> 3) Monotonically non-decreasing clock for the same CPU:
>  scx_bpf_clock_get_ns() guarantees the clock never goes backward when
>  comparing them in the same CPU. On the other hand, when comparing clocks
>  in different CPUs, there is no such guarantee -- the clock can go backward.
>  It provides a monotonically *non-decreasing* clock so that it would provide
>  the same clock values in two different scx_bpf_clock_get_ns() calls in the
>  same CPU during the same period of when the rq clock is valid.

Have you seen the insides of kernel/sched/clock.c ?

