Return-Path: <linux-kernel+bounces-558304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA6FA5E419
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0007177A74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82052256C9E;
	Wed, 12 Mar 2025 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QZ/s72Cc"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E4250BFC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806340; cv=none; b=YD3sTp2FTOsuOiLvuym8KEQ7Xn1kq7FFEaZzKsw5Qzhj5wyEKZI21dJLsL0ulTcKpVziXOttCSMcZhjEOXXHXi6wJdwk55Rp7Fl6oaN12mzWifraAdn0JI60WOmgiXmDDJXF10bdD1LKaKFcdpGUlH9LcaiRObyU4TKUeRHno0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806340; c=relaxed/simple;
	bh=pipdSOj1oF2CVOdQ8oNb7NXXjNn50Cc8d9IQ8y6XcGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4zCjmD+3+lg6T68Q8EJ80KUPuhr02XjxlJ2V0M/oRBtK0dto00PwnwrnEFPIckxK7N5eipBrtfmmELVBb3wW5h4DVO8NFsF5k7cHT5IpbPWw69NJS3nGjpynZ6T/tcTwZbg+EhSE3/LzuZ/E19j0q2HoWsG5FzXyEU7j/wgmkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QZ/s72Cc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HktMF3/MYJfU02oLRc5WZbsNrXFmz3Uj9rcfS/MppcA=; b=QZ/s72CceYKOSDvdFXSV3h8lBe
	O6siS5cyGYzcKUZzpSIvu1ea50HJEWv9ZXykXv5EcP5ODpNvH13e3DqDCWUPhM5dbKxzM+YSpzEZk
	g3f0U196XI6rN+Xy+hN1/EwsTgKU/2p66hFFpP3zya0BVoriiaV7T0petHPwgkyoO0Q5VwZoBaLXc
	rKICsiuY95BflLstkcZ0syfEENG2e5ZMObwxT5Ey3FsofXeXAtEFj7ZgI9Z0z3zo7i3IUOvP7QYhP
	1/HdOQYHrrrYfwXop415QAsdzHsPovnCEg4V0rLtCCX23jx8bF8ss/zJIJdqTM4k0K1uh3jK/SHKE
	yBkUZJ3A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsROY-0000000DDzs-0RGj;
	Wed, 12 Mar 2025 19:05:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 34BEA300599; Wed, 12 Mar 2025 20:05:33 +0100 (CET)
Date: Wed, 12 Mar 2025 20:05:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com,
	linux-kernel@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH V8 1/6] perf: Save PMU specific data in task_struct
Message-ID: <20250312190533.GA10453@noisy.programming.kicks-ass.net>
References: <20250312182525.4078433-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312182525.4078433-1-kan.liang@linux.intel.com>


I'm sorry, but since I spotted a bug in the second patch, I'm going to
reply and suggest some overall changes.

On Wed, Mar 12, 2025 at 11:25:20AM -0700, kan.liang@linux.intel.com wrote:

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 3e270822b915..b8442047a2b6 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1021,6 +1021,36 @@ struct perf_event_context {
>  	local_t				nr_no_switch_fast;
>  };
>  
> +/**
> + * struct perf_ctx_data - PMU specific data for a task
> + * @rcu_head:  To avoid the race on free PMU specific data
> + * @refcount:  To track users
> + * @global:    To track system-wide users
> + * @ctx_cache: Kmem cache of PMU specific data
> + * @data:      PMU specific data
> + *
> + * Currently, the struct is only used in Intel LBR call stack mode to
> + * save/restore the call stack of a task on context switches.
> + * The data only be allocated when Intel LBR call stack mode is enabled.
> + * The data will be freed when the mode is disabled. The rcu_head is
> + * used to prevent the race on free the data.
> + * The content of the data will only be accessed in context switch, which
> + * should be protected by rcu_read_lock().
> + *
> + * Careful: Struct perf_ctx_data is added as a pointor in struct task_struct.

pointer

> + * When system-wide Intel LBR call stack mode is enabled, a buffer with
> + * constant size will be allocated for each task.
> + * Also, system memory consumption can further grow when the size of
> + * struct perf_ctx_data enlarges.
> + */
> +struct perf_ctx_data {
> +	struct rcu_head			rcu_head;
> +	refcount_t			refcount;
> +	int				global;
> +	struct kmem_cache		*ctx_cache;
> +	void				*data;
> +};

I can't remember why this is complicated like this. Why do we have a
kmemcache and yet another data pointer in there?

Specifically, why can't we do something like:

struct perf_ctx_data {
	struct rcu_head		rcu;
	refcount_t		refcount;
	int			global;
	char			data[];
};

and simply allocate the whole thing as a single allocation?

So then the allocation is something like:

	cd = kzalloc(sizeof(*cd) + event->pmu->task_ctx_size, GFP_KERNEL);



