Return-Path: <linux-kernel+bounces-310916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF0A9682D2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFAA281D66
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19F9186E5D;
	Mon,  2 Sep 2024 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lO63YpXG"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912B185B62
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268363; cv=none; b=tSwVMnybtgX6C4iYoq4jgl+KildtRIRz5ozjxRZcBGnuzxwksb4scrg1CEh0mZz3tR7RV4TbmBRRBu5y8JE/cI0wkzvL7tijBQPSYJ9mVEUVd8WMNwPGebEsbfOlt8JAjxdWgVBSQkFQGcOb3hjsGGfNUr6ULX3VeCeZRuHZskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268363; c=relaxed/simple;
	bh=Ay8inXS5TzmGAkg8JgdFwFl+DzijYnXWkeMynFXdFLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBHG0SBhGkz0U7JCuZv3eR2R+zYjaCAEfDXCT6eYBuEYq1yzeJumOCTQxu62aUtR5ZqDb6I6YEq5LIeXbq6F+la8J0pPndV0cOjpRcPxeLGgaIF6j1WZzb+5AJvG4Mb1a9NL15cE2pWcfeFIhfMv0PFgXYa1EUbBVX/ewD/UCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lO63YpXG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xFbo0gUMuahJpidW3Nn32F1ntuS8gES6qMijDhVArmw=; b=lO63YpXGyKNX5W9mYnOnw5ZPPY
	KDKCEoF0J0nnqLoSiiAtVCACcRZwQd6xyqDC6AsJzRTXNNPmu5Oa008EZn42ZPeeNjvWq+l+NdJXV
	jx6Hr9vwMgJAf8nk0XISTaHFFPrtDefuxEAymtuh+NnS6A70MRo03gJnq8bCKeEQiC+LEzpAYlGGb
	uxGreMkFWfL8OPTE1GxVsV2D4EYroMMJvZiVaHGVHwmjt6rzQgqpIJlM8MGGdDsuB0Eu2PhZSpu+Q
	OfX1mjbHuLT1kCpx3up/uBaiSvGuEFPiozmwPcM4KU5eqC6hL3hPNF93fR/bj9Fq0LvePQ0MpJ08s
	0WRI43eQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sl36u-00000006MXD-2RMN;
	Mon, 02 Sep 2024 09:12:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0CACA300642; Mon,  2 Sep 2024 11:12:32 +0200 (CEST)
Date: Mon, 2 Sep 2024 11:12:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC/PATCH 4/4] perf/x86: Relax privilege filter restriction on
 AMD IBS
Message-ID: <20240902091232.GB4723@noisy.programming.kicks-ass.net>
References: <20240830232910.1839548-1-namhyung@kernel.org>
 <20240830232910.1839548-5-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830232910.1839548-5-namhyung@kernel.org>

On Fri, Aug 30, 2024 at 04:29:10PM -0700, Namhyung Kim wrote:
> While IBS is available for per-thread profiling, still regular users
> cannot open an event due to the default paranoid setting (2) which
> doesn't allow unprivileged users to get kernel samples.  That means
> it needs to set exclude_kernel bit in the attribute but IBS driver
> would reject it since it has PERF_PMU_CAP_NO_EXCLUDE.  This is not what
> we want and I've been getting requests to fix this issue.
> 
> This should be done in the hardware, but until we get the HW fix we may
> allow exclude_{kernel,user} in the attribute and silently drop the
> samples in the PMU IRQ handler.  It won't guarantee the sampling
> frequency or even it'd miss some with fixed period too.  Not ideal,
> but that'd still be helpful to regular users.

Urgh.... this is really rather bad. And I'm sure a bunch of people are
going to be spending a lot of time trying to figure out why their
results don't make sense.

I realize that having entry hooks to disable/enable the counters is also
not going to happen, this has a ton of problems too.

Also, that PMU passthrough patch set has guest hooks, so you can
actually do the exclude_host/guest nonsense with those, right?

> This uses perf_exclude_event() which checks regs->cs.  But it should be
> fine because set_linear_ip() also updates the CS according to the RIP
> provided by IBS.
> 
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  arch/x86/events/amd/ibs.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index e91970b01d62..e40e2255239a 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -290,6 +290,11 @@ static int perf_ibs_init(struct perf_event *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
>  
> +	/* handle exclude_{user,kernel} in the IRQ handler */
> +	if (event->attr.exclude_hv || event->attr.exclude_idle ||
> +	    event->attr.exclude_host || event->attr.exclude_guest)
> +		return -EINVAL;
> +
>  	ret = validate_group(event);
>  	if (ret)
>  		return ret;
> @@ -667,7 +672,6 @@ static struct perf_ibs perf_ibs_fetch = {
>  		.start		= perf_ibs_start,
>  		.stop		= perf_ibs_stop,
>  		.read		= perf_ibs_read,
> -		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>  	},
>  	.msr			= MSR_AMD64_IBSFETCHCTL,
>  	.config_mask		= IBS_FETCH_CONFIG_MASK,
> @@ -691,7 +695,6 @@ static struct perf_ibs perf_ibs_op = {
>  		.start		= perf_ibs_start,
>  		.stop		= perf_ibs_stop,
>  		.read		= perf_ibs_read,
> -		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>  	},
>  	.msr			= MSR_AMD64_IBSOPCTL,
>  	.config_mask		= IBS_OP_CONFIG_MASK,
> @@ -1111,6 +1114,12 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  		regs.flags |= PERF_EFLAGS_EXACT;
>  	}
>  
> +	if (perf_exclude_event(event, &regs)) {
> +		throttle = perf_event_account_interrupt(event);
> +		atomic64_inc(&event->dropped_samples);
> +		goto out;
> +	}
> +
>  	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
>  		raw = (struct perf_raw_record){
>  			.frag = {
> -- 
> 2.46.0.469.g59c65b2a67-goog
> 

