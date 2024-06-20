Return-Path: <linux-kernel+bounces-222140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970CC90FD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD301C239A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1935541C92;
	Thu, 20 Jun 2024 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t3/LIUFp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D64594C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866943; cv=none; b=PXeirZ+sSpbTKF9lry1eJ7oweoAiVlRASWt8SCf+fQnYhmrVpwb092RO1xnvc/UnnlhSOzNn1QFbny3XENYtHjCJjLW1aLHE3pCuMjO82P7mrn6eFbMupfm+9EDArBpM5r1cGJCrPidLUJ5NVXKSZtb6QOuLT2aouy+pmK8siKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866943; c=relaxed/simple;
	bh=XSu0m37RNztvrIh0oxVM7nFM1Q+3yr2oB5nImyBc784=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZCY+gpKpInxJ8w/J0TBDAyaNcjkx8VMjbDMmkVv/7zRLPA+fxPiKGdFUmdvfI1le5QWFRciquEqfypDfPBxPRfVjDRkK3T4hc9SB82hsPN5wSi3jSQfymBWUs82ZnVLj+f0/q9pAfGsPCwLL2VsAM+oRsR3GR374CaS2gCEqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t3/LIUFp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QgFJdjyF8aseci8IshIoTJNFhHkSOzL0GPxvSiZaR7g=; b=t3/LIUFpTbzpZpgKF9lX7d8doT
	2Eky5ZcDEKJKR+RL1y4mfo8akJnrbbf5dh1LlGXAzt4XwfuGIVXIE+9YvByibMA4YYYH9i7e7tla9
	dtJiHynJmikZfR0767JO8zkqJQnAFvAxStYWWEPVWbDucdrXB0ww02dOWVmxSowTupkoUunEsfWte
	8D74PGZb/VY3ikm4+tsHOrof+VY3O+ez2uF0Zba0x9347yrFD0DX7ugr/Ba167dTW/ErDImUIvoA4
	iKCSBalC6sLEPsRLr1zOazBeRJutAPIbgLk1xnjV6FrmIto8NZ6jWytG3+DRnA5CWdrTQpVFTXVxY
	PrsHk6Ww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBoF-00000005kKk-3KaG;
	Thu, 20 Jun 2024 07:02:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6EEC0300CB9; Thu, 20 Jun 2024 09:02:15 +0200 (CEST)
Date: Thu, 20 Jun 2024 09:02:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com
Subject: Re: [RESEND PATCH 01/12] perf/x86/intel: Support the PEBS event mask
Message-ID: <20240620070215.GP31592@noisy.programming.kicks-ass.net>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618151044.1318612-2-kan.liang@linux.intel.com>

On Tue, Jun 18, 2024 at 08:10:33AM -0700, kan.liang@linux.intel.com wrote:
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index e010bfed8417..a0104c82baed 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c

> @@ -2157,6 +2157,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  	void *base, *at, *top;
>  	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
>  	short error[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
> +	int max_pebs_events = hweight64(x86_pmu.pebs_events_mask);

Consider pebs_events_mask = 0xf0, then max_pebs_events becomes 4.

>  	int bit, i, size;
>  	u64 mask;
>  
> @@ -2168,8 +2169,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  
>  	ds->pebs_index = ds->pebs_buffer_base;
>  
> -	mask = (1ULL << x86_pmu.max_pebs_events) - 1;
> -	size = x86_pmu.max_pebs_events;
> +	mask = x86_pmu.pebs_events_mask;
> +	size = max_pebs_events;

This is wrong.. you have 8 bits to iterate, of which only the top 4 are
set.

>  	if (x86_pmu.flags & PMU_FL_PEBS_ALL) {
>  		mask |= ((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED;
>  		size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
> @@ -2208,8 +2209,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  			pebs_status = p->status = cpuc->pebs_enabled;
>  
>  		bit = find_first_bit((unsigned long *)&pebs_status,
> -					x86_pmu.max_pebs_events);
> -		if (bit >= x86_pmu.max_pebs_events)
> +					max_pebs_events);
> +		if (bit >= max_pebs_events)
>  			continue;

But the bit check here then truncates the thing to the lower 4 bits
which are all 0.

Should this not be something like:

		if (!(pebs_event_mask & (1 << bit)))
			continue;

?


