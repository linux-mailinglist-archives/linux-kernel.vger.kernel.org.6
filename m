Return-Path: <linux-kernel+bounces-427194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D19DFDEA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFCC1632FE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A231FBEA3;
	Mon,  2 Dec 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LnTKyjxd"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F181F949
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133537; cv=none; b=qAsI/D+3thOQKd8fMBHbBL4wg448O5ECGnWrOmRWGT7InhwDLImETCEhOr29NfySilvtX0f/STL37OvpS8/38HbDCUMtw6Fgr/FMJnVwDGbxOioixVqbpwCDToTSjA8bkk9BZowvDd9aI56Kd1j1gOq9PWd7pstevch7Fg4lRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133537; c=relaxed/simple;
	bh=4l2BJnDnqRwMBQWsb/m/LfpV9YNxXPR5iKJQ8ycwhsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGFvf/dKMbOmAtNkqa5BVpviDsIdHTofwyviqMEDR8wDzalaka3hY9R7q1Al5Nxof4D+SvkCW9yJYxd+VXmsfddHi70UylUpv1+ia1Dfq4ZGTJP6AMPCSbHPfHoF5h7RwqImNqlZnIzP7q8+as1umpBf8/XU4G0/u516zfb1xq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LnTKyjxd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/pmSJ6r9IAvyarU/N87P9IsIoLsbj7PYkhCwKxu9feY=; b=LnTKyjxd2IG/myALp33e0JQoZo
	D6b3NgB+OsjC05JZfvTuuQ+M9hYnj9uVLLvh0v+xMeu7Du2EBlzfzdd0QsZG26cA3Vc9lBbWdtY2m
	RlAbkGIYnKHlKwMf+k0uAq+HJxJtcsrav7/CmW8k9ZiPyPn/p9pU51y6TEKQmxZWmEtv7s5mVDCRK
	QWu8Tlfk3lhJeyuSJFo8WL+tvcxGKkA38YESzEpLqSOSWuamAvDRKptqmzHvB8Cr1V0qyWt/G1zAR
	K0TGuSC+MJw5zlqtdyN/XwbV5T/an6TBcUHzTq0QXQDtvGu+ebiOvx7NLByXGe9bEpNLvRaTVcCK4
	tJsle9UQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tI3Ca-000000029Nr-3San;
	Mon, 02 Dec 2024 09:58:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 002B1300402; Mon,  2 Dec 2024 10:58:47 +0100 (CET)
Date: Mon, 2 Dec 2024 10:58:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Changwoo Min <multics69@gmail.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
	changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] sched_ext: Manage the validity of scx_rq_clock
Message-ID: <20241202095847.GK24400@noisy.programming.kicks-ass.net>
References: <20241202043849.1465664-1-changwoo@igalia.com>
 <20241202043849.1465664-3-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202043849.1465664-3-changwoo@igalia.com>

On Mon, Dec 02, 2024 at 01:38:46PM +0900, Changwoo Min wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 95e40895a519..ab8015c8cab4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -789,6 +789,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>  void update_rq_clock(struct rq *rq)
>  {
>  	s64 delta;
> +	u64 clock;
>  
>  	lockdep_assert_rq_held(rq);
>  
> @@ -800,11 +801,14 @@ void update_rq_clock(struct rq *rq)
>  		SCHED_WARN_ON(rq->clock_update_flags & RQCF_UPDATED);
>  	rq->clock_update_flags |= RQCF_UPDATED;
>  #endif
> +	clock = sched_clock_cpu(cpu_of(rq));
> +	scx_rq_clock_update(rq, clock);

This adds a write to a second cacheline for *everyone* always.

Please don't do that.

