Return-Path: <linux-kernel+bounces-411883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A91999D00B2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 20:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387A3B2152D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4FF191F6F;
	Sat, 16 Nov 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PunmrEmr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4816419
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785569; cv=none; b=CuuzHVGcxeTqBg76x6wIwT1Ia2QQ+UZSfwlgavZiJT/5FNg/C8adnEmvSBe7nASBbSe4wy1fugR++x8MytdlI/Dnuy8K0jOAVPsXhffBur5ovRxuTUv/g3PGzY+ekD6HLQL+PDDbmR3BU1FyeVjc8BBmQQv7+OlOrY/10PfRYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785569; c=relaxed/simple;
	bh=l+2VyFr12c1gLjpG/21qZnJHHcAPMqJfdwtNyzJNtCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoL9IGEJO9fIxB0XHkSVpC11mLFrIgtkmJANSqbqRFqN6vEv721sWYKBU3k5/QLTxFX3dPWJk3dBYDwgQCkGcOLyyED8AdIENO5jGokw7+311EeSiDFfzhp8XT+WmyndY/nbFWi2x9qdMUQ1tNAYY8SGj8eb96wvKmDbDn9Lpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PunmrEmr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eChOwQECLVJIHCvz2Glp/wxD9OrPGWmo7NV/iFNeswk=; b=PunmrEmrq9bsEDMrZU3b+AYqBS
	ehWXVHbBlZTeRl7Ufhwf2xA+D7ZWEhtwX7eJ8Y6qnbjpzlJI0MF7S4e8LoHMskWjpRmdlNb3bJe5H
	pOl/w9SR9l+hEyB4CYL39l/6eaefjBCiOxvLkBwb1hL+ryVYf4z5IpebAAajmUx0z046jWcNpXA1c
	mWe5C7Uhak3GBhdLHhfyUjBTVMMkRKx1FsZf0rhFJBmdwZJWDbdGMDtBiwVk++O6Itcwb7ptf9GXZ
	qQnK0G0syoxgVCqQzcd9y4KLsYN/8IgeJlobIKZg+NDATfJSWwHHFV3n9i2693V+8wBQd4TBJTdbu
	qUlNSICA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tCOX5-00000001Oms-1Hxf;
	Sat, 16 Nov 2024 19:32:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DABC7300472; Sat, 16 Nov 2024 20:32:35 +0100 (CET)
Date: Sat, 16 Nov 2024 20:32:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Changwoo Min <multics69@gmail.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
	changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] sched_ext: Manage the validity of scx_rq_clock
Message-ID: <20241116193235.GQ22801@noisy.programming.kicks-ass.net>
References: <20241116160126.29454-1-changwoo@igalia.com>
 <20241116160126.29454-3-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116160126.29454-3-changwoo@igalia.com>

On Sun, Nov 17, 2024 at 01:01:23AM +0900, Changwoo Min wrote:
> An rq clock becomes valid when it is updated using update_rq_clock()
> and invalidated when the rq is unlocked using rq_unpin_lock(). Also,
> after long running operations -- ops.running() and ops.update_idle() --
> in a BPF scheduler, the sched_ext core invalidates the rq clock.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  kernel/sched/core.c  | 6 +++++-
>  kernel/sched/ext.c   | 3 +++
>  kernel/sched/sched.h | 2 +-
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a910a5b4c274..d0eb58b6a2da 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -784,6 +784,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>  void update_rq_clock(struct rq *rq)
>  {
>  	s64 delta;
> +	u64 clock;
>  
>  	lockdep_assert_rq_held(rq);
>  
> @@ -795,11 +796,14 @@ void update_rq_clock(struct rq *rq)
>  		SCHED_WARN_ON(rq->clock_update_flags & RQCF_UPDATED);
>  	rq->clock_update_flags |= RQCF_UPDATED;
>  #endif
> +	clock = sched_clock_cpu(cpu_of(rq));
> +	scx_rq_clock_update(rq, clock);

It is not at all clear why you think you need to keep a second copy of
that value. You like cache misses?

