Return-Path: <linux-kernel+bounces-394823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AEE9BB481
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87591C21ADF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAEB1B6CE1;
	Mon,  4 Nov 2024 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZ95OZlq"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520218DF85
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722736; cv=none; b=TT2qQ0U9FlxIXii8wt7/bCqcykMDE9G2G2oBLT3QkR6fhdGc6vxjvCBtIeJ67IlCCnFmVqaNG4UYxm04IxTl59UytFY3Vlp0+7mByn+x6cKveBq2TrzRnW/Lr/NGGoy65tuks30LXubDMS8Xbtj/he/y3oJwTi8dofjNt+D4XUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722736; c=relaxed/simple;
	bh=QHiVwWgmmxw4VX/IZQpfawfh1XO1qcf7JE324o474LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5+8RG1Li4UntC9DdMKqANyoa6zKQlrT7afafcanx0tswItVyIEv9+g0On2zFo5gYrLGPxQB2Xc0JIOcOmztoinbJrGsMWW5AlvErmysVndbPLxK6cfstRY3plmVeH/vAPNtgx6Dg8y0ON2Sj/iRM0lc1JIbcafUs/kX0fy8Wmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JZ95OZlq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1fMPaIo3r7E9vDWl1Z7EF1qgX2CYTyBY3ImAA0/tokA=; b=JZ95OZlqsXNBd8pv70okFFOhBk
	sYomj4XlZBvwYxzFfqjuY6IFjIF/9+xg/3MeY8wDPgO/4TN862HyRzQWgKXaZSmTrPRz8t7qQ5ajJ
	hNO8iw0/t+yo0Drmsow0jsyvAocI/X1TFwPZWn5f0dFL9cm9yDZwuU0TokjANXj299M36NjZhp+dl
	LxqkLl760rQlPVwUdkqr2/dwFMtEQh2QBFmTNaQpQSwtWijGvG/oh7PdeLp+ZmgheE6V3NqEbeG9S
	lDznNpGHbBB/zMk2H+UDQ3LOb2yw4Sn4+cUamBt7GiYLwbbGjsPmXPT0CT1Tv/gMAki9v1FkpZWFR
	IZlBXhLA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7w2i-0000000BK6B-0wYk;
	Mon, 04 Nov 2024 12:18:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 726C5300324; Mon,  4 Nov 2024 13:18:47 +0100 (CET)
Date: Mon, 4 Nov 2024 13:18:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Remove unnecessary initialization in
 init_cfs_bandwidth() function
Message-ID: <20241104121847.GE24862@noisy.programming.kicks-ass.net>
References: <20241104121443.86468-1-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104121443.86468-1-yaoma@linux.alibaba.com>

On Mon, Nov 04, 2024 at 08:14:43PM +0800, Bitao Hu wrote:
> The root task group is statically defined, and non-root task groups
> are allocated memory using kmem_cache_alloc() with the __GFP_ZERO
> flag. In both cases, the corresponding 'struct cfs_bandwidth' is a
> block of all-zero memory. Therefore, it is unnecessary to explicitly
> set zeros in the init_cfs_bandwidth() function.
> 
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2d16c8545c71..2fd96641164f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6573,10 +6573,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent)
>  {
>  	raw_spin_lock_init(&cfs_b->lock);
> -	cfs_b->runtime = 0;
>  	cfs_b->quota = RUNTIME_INF;
>  	cfs_b->period = ns_to_ktime(default_cfs_period());
> -	cfs_b->burst = 0;
>  	cfs_b->hierarchical_quota = parent ? parent->hierarchical_quota : RUNTIME_INF;
>  
>  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);

But this shows someone thought about it and 0 is the right value, and
not an oversight.


