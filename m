Return-Path: <linux-kernel+bounces-441083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773629EC929
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6E0285BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149BD1CD3F;
	Wed, 11 Dec 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gvmmC+9r"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508C236F8A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909585; cv=none; b=EyO+pxZvHnCGLoltcf4Wg184zvPB+0CeqknTTs7ggxGa9DpQG0A0qoFG0sAkG9KHzPEptdc25fq2qQJxIg/NioNzrmP/JZpPd+KBDXMJOTwEOC9E9T0NxzNlZNlzhTP69MTWvW3MLbpglseKpncXBtyBkU1UPCSrnlsAaGw1tiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909585; c=relaxed/simple;
	bh=9fjDu/y8yet/RL/b2DpZvykDRlJLzoeh6Ah58IfRVsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFUqMEQc9piFyICqGG39EJPk3N5ePVmcaw4lKMP33qL3jSkOQD5ch5jfuPlm7flE0GO+/W50gZlMYAH8RwK4wUTiaXdraNFEoAL5MM3ueG2QcG7Z/gUeo91c+u9lbHSI40qbqIoMmpLnoVj14uc1FK4G90LkWHmchQAA9E7e8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gvmmC+9r; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zpAsqWbKfG1Ovbpxe2gNjT6HVihnpR50NOW7dLBU31M=; b=gvmmC+9rfy0n2c23fBhtoX2bdn
	Wlhk6BOWljqdJ5oFUctFFWGhuifj8/Azzw8vMKvsdBjB1bIgAoDDuWfNz2U0Q016cl8qfdrMG01wU
	M7z+S4C9vTuvXPIkIKHeZ+4Wv89WfDm9YHnw3oQEuTzFpyuxiXIzv87LolfD9xYONrn+n/7SWwFp9
	fKFf21tqfzcQEELwvsPxUWcb++4fpXv4KMy9bQYimpiAFc+YnR7UVJLn3AKlFAOLE5T+PXJ/3LGMI
	XYcKTQwb7SQs0weLkPVGY2DjFStnNQEfr8ePQuqKuc3m92+x719qDa8fF1NWqDPieA6kEucX5fFvS
	RymNMWOw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLJ5U-00000003nur-46vl;
	Wed, 11 Dec 2024 09:32:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 73032300402; Wed, 11 Dec 2024 10:32:56 +0100 (CET)
Date: Wed, 11 Dec 2024 10:32:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Changwoo Min <multics69@gmail.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
	changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] sched_ext: Implement scx_bpf_now_ns()
Message-ID: <20241211093256.GY35539@noisy.programming.kicks-ass.net>
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

On Mon, Dec 09, 2024 at 03:15:29PM +0900, Changwoo Min wrote:

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

As TJ said, it's best to consider that the clock can wrap.

> +		/*
> +		 * If the rq clock is invalid or goes backward,
> +		 * start a new rq clock period with a fresh sched_clock_cpu().
> +		 *
> +		 * The cached rq clock can go backward because there is a
> +		 * race with a timer interrupt. Suppose that a timer interrupt
> +		 * occurred while running scx_bpf_now_ns() *after* reading the
> +		 * rq clock and *before* comparing the if condition. The timer
> +		 * interrupt will eventually call a BPF scheduler's ops.tick(),
> +		 * and the BPF scheduler can call scx_bpf_now_ns(). Since the
> +		 * scheduler core updates the rq clock before calling
> +		 * ops.tick(), the scx_bpf_now_ns() call will get the fresh
> +		 * clock. After handling the timer interrupt, the interrupted
> +		 * scx_bpf_now_ns() will be resumed, so the if condition will
> +		 * be compared. In this case, the clock, which was read before
> +		 * the timer interrupt, will be the same as rq->scx.prev_clock.
> +		 * When such a case is detected, start a new rq clock period
> +		 * with a fresh sched_clock_cpu().

This has a wall-of-text problem; use paragraphs?

> +		 */
> +		clock = sched_clock_cpu(cpu_of(rq));
> +		scx_rq_clock_update(rq, clock);

Doesn't this set the VALID bit again? How is using this outside of
RQ-lock and setting VALID a good idea?

> +	}
> +
> +	preempt_enable();
> +
> +	return clock;
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_any)
> @@ -7632,6 +7704,7 @@ BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
>  #ifdef CONFIG_CGROUP_SCHED
>  BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
>  #endif
> +BTF_ID_FLAGS(func, scx_bpf_now_ns)
>  BTF_KFUNCS_END(scx_kfunc_ids_any)
>  
>  static const struct btf_kfunc_id_set scx_kfunc_set_any = {
> -- 
> 2.47.1
> 

