Return-Path: <linux-kernel+bounces-440939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313629EC6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD6B1887732
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670A71D7E46;
	Wed, 11 Dec 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGvB4xdy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9F1D6DB6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904890; cv=none; b=FtYRaNOvbmawk//ehSsJDcuwgG9poJODeHpOtsLNhmOJmGvN5Us0BNNUP/OP6vT4OGQaBzKskBw+lT+yH18z/QkLI9pFjzTM5yJqSfu3x5Dcly54bpo/LMQP6N96aaR9JD/xx2WtfHm6zcMAzuVmVfF1Fs2X2fkvDCT0yfRRF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904890; c=relaxed/simple;
	bh=Lw1rJMQtogGQEBRwFuD9lAbQ0MR4ONoVv23htZqM95M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elzbkDNV/QQIYr4cvQNFYolYwdsdCACfyzar7LEzOrT4hnWGUnWORSoXzo/SYaWM1Kbt2WcEgKq/gunUgeM2yq2gMr7EVMSctXiNdei8x5KEbEtkLSiDkUo/mp9cGm1GhH2emUGvwMKXHtVEVqvWln4deITJD4YJZ1cZ5cbYEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGvB4xdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAF5C4CEDF;
	Wed, 11 Dec 2024 08:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733904890;
	bh=Lw1rJMQtogGQEBRwFuD9lAbQ0MR4ONoVv23htZqM95M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGvB4xdy/19SRQBWMV46mqrQSY1rGQ0/Ieb3+kH1kK6w+uMJhIPGSou0+sg1zhcwf
	 4mT0kG+BIcUY4Ndqxcm4fSSAdOdcNtnXQQaKAmNS93ddnRqk+5kXYUq2wRt9YTv/HI
	 OK0e06lcXV1aqAhamgvQ3nhYbJ1TgF9LvHbthi2QzkmeAJH22NYXTl7bdxDzuJfDKx
	 7zG8ojFIEuxbR3ey5x+V5PKlY7ZFG0ZaU3xhZIPc+dECTO+JuJ5Jn8dMH6yRljIBfS
	 uUNJZMFFDZs8Ph6hZ70hkGedQ0oTNdL4ZNsi+iQpml0vyBJykVL/+k1eJyVLVExdFA
	 iEEJZCGQQXuCw==
Date: Tue, 10 Dec 2024 22:14:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] sched_ext: Implement scx_bpf_now_ns()
Message-ID: <Z1lJ-AzRlFIv4OuP@slm.duckdns.org>
References: <20241209061531.257531-1-changwoo@igalia.com>
 <20241209061531.257531-5-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209061531.257531-5-changwoo@igalia.com>

Hello,

I'd roll the preceding two patches into this one.

On Mon, Dec 09, 2024 at 03:15:29PM +0900, Changwoo Min wrote:
...
> 3) Monotonically non-decreasing clock for the same CPU: scx_bpf_now_ns()
>  guarantees the clock never goes backward when comparing them in the same
>  CPU. On the other hand, when comparing clocks in different CPUs, there
>  is no such guarantee -- the clock can go backward. It provides a
>  monotonically *non-decreasing* clock so that it would provide the same
>  clock values in two different scx_bpf_now_ns() calls in the same CPU
>  during the same period of when the rq clock is valid.

We probably should provide helpers to calculate deltas between timestamps
and use them consitently in SCX scheds. e.g. ops.runnable() and
ops.running() can run on different CPUs and it'd be useful and common to
calculate the delta between the two points in time.

...
> +__bpf_kfunc u64 scx_bpf_now_ns(void)
> +{
> +	struct rq *rq;
> +	u64 clock;
> +
> +	preempt_disable();
> +
> +	/*
> +	 * If the rq clock is valid, use the cached rq clock
> +	 * whenever the clock does not go backward.
> +	 */
> +	rq = this_rq();
> +	clock = rq->scx.clock;
> +
> +	if (!(rq->scx.flags & SCX_RQ_CLK_VALID) ||
> +	    (rq->scx.prev_clock >= clock)) {

The clocks usually start at zero but it'd still be a good idea to use
time_after64() and friends when comparing the ordering between timestamps.

> +		/*
> +		 * If the rq clock is invalid or goes backward,
> +		 * start a new rq clock period with a fresh sched_clock_cpu().
> +		 *
> +		 * The cached rq clock can go backward because there is a
> +		 * race with a timer interrupt. Suppose that a timer interrupt

This is not limited to timer interrupts, right? This kfunc can be called
from anywhere including tracepoints for code running in IRQ.

> +		 * occurred while running scx_bpf_now_ns() *after* reading the
> +		 * rq clock and *before* comparing the if condition. The timer
> +		 * interrupt will eventually call a BPF scheduler's ops.tick(),
> +		 * and the BPF scheduler can call scx_bpf_now_ns(). Since the
> +		 * scheduler core updates the rq clock before calling
> +		 * ops.tick(), the scx_bpf_now_ns() call will get the fresh
> +		 * clock. After handling the timer interrupt, the interrupted

This might be easier to explain with two column table explaning what each
party is doing in what order.

> +		 * scx_bpf_now_ns() will be resumed, so the if condition will
> +		 * be compared. In this case, the clock, which was read before
> +		 * the timer interrupt, will be the same as rq->scx.prev_clock.
> +		 * When such a case is detected, start a new rq clock period
> +		 * with a fresh sched_clock_cpu().
> +		 */
> +		clock = sched_clock_cpu(cpu_of(rq));
> +		scx_rq_clock_update(rq, clock);

Hmmm... what happens if e.g. a timer ends up performing multiple operations
each going through rq pin/unpin?

Thanks.

-- 
tejun

