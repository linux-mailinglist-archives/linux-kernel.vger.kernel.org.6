Return-Path: <linux-kernel+bounces-233619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01A591BA46
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CEDF1C218DF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A3614B06C;
	Fri, 28 Jun 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DsgJBdtC"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D314D6FF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564197; cv=none; b=C5eiMMOSYV3Rti76yd0sLpNCdJfVNDcw2kIvicSe4UljrDuDM9D0UdDJh+jF0BDLfNQLmaJU4h0i1an2I2nxwYGUSVrf801rLY/vJhBiITvgjAmSj0PRrWcODjhb8/J1gkzGY9J9newhAKV8t7tSC28OLD7YkQE+fj1vbRQiMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564197; c=relaxed/simple;
	bh=5gJYdAxMiPtWI/amBZbj1a4YrOnZfQKoCzdv8ypltqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7z1gJDi7O3v6T0TDa0RkXhRtU3YyeZu8O+bnHl2/DR2GzB9zZZhmYADH0PpuKB5ajFe+zh3ccUh0W2blkyImrB9Vwfrzmna3NcW1ncJmQUij4GVAINpZa49lpqa4lHo5lx9nY3TMrT5ZWshxBpVEOhJPbuqMyO1wnDARBtLzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DsgJBdtC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1EajT2M7HiMVKYWzNmxeXjdvYgdqYyWDRfjFgTSXgxo=; b=DsgJBdtCbCk9i/2m/DxGvr9/G9
	cZ6iMhJi3B1Zbau9jDnWY9MlLaqVTsuKyxRjkgOXZI+/mIjbLluz75jfCjQXD5LdF9T/v8iTovHLL
	D/6THAbz22wR5HMa8LGEpZyj8vMhXS6HzpbwY2hUil6T+tgNfpRh4FW/rpt+Rb2LeGoUsM7bak09q
	DqenFAVjmybxspOVpIZr3cWDPp4xqG8zX6JuX6DafCXFO3qp0j1NS1Kwd7VGNjrokyvk1aWvA3Slo
	nKkcrspz4dWx6z11QAFDeefkhRtMScB6dVP8vhbg6Hlr13qLbc+M/DRln05REg8c2JATnOrxiwjBR
	DHX6goSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sN7Bz-000000090d8-2nbG;
	Fri, 28 Jun 2024 08:42:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 89F6D300400; Fri, 28 Jun 2024 10:42:48 +0200 (CEST)
Date: Fri, 28 Jun 2024 10:42:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V3 01/13] perf/x86/intel: Support the PEBS event mask
Message-ID: <20240628084248.GE31592@noisy.programming.kicks-ass.net>
References: <20240626143545.480761-1-kan.liang@linux.intel.com>
 <20240626143545.480761-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626143545.480761-2-kan.liang@linux.intel.com>

On Wed, Jun 26, 2024 at 07:35:33AM -0700, kan.liang@linux.intel.com wrote:

> @@ -1661,6 +1661,16 @@ static inline int is_ht_workaround_enabled(void)
>  	return !!(x86_pmu.flags & PMU_FL_EXCL_ENABLED);
>  }
>  
> +static inline u64 intel_pmu_pebs_mask(u64 cntr_mask)
> +{
> +	return MAX_PEBS_EVENTS_MASK & cntr_mask;
> +}
> +
> +static inline int intel_pmu_max_num_pebs(struct pmu *pmu)
> +{
> +	return find_last_bit((unsigned long *)&hybrid(pmu, pebs_events_mask), MAX_PEBS_EVENTS) + 1;

I'll write that like:

	static_assert(MAX_PEBS_EVENTS == 32);
	return fls((u32)hybrid(pmu, pebs_events_mask));

> +}
> +
>  #else /* CONFIG_CPU_SUP_INTEL */
>  
>  static inline void reserve_ds_buffers(void)
> diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
> index 2f9eeb5c3069..5dbeac48a5b9 100644
> --- a/arch/x86/include/asm/intel_ds.h
> +++ b/arch/x86/include/asm/intel_ds.h
> @@ -9,6 +9,7 @@
>  /* The maximal number of PEBS events: */
>  #define MAX_PEBS_EVENTS_FMT4	8
>  #define MAX_PEBS_EVENTS		32
> +#define MAX_PEBS_EVENTS_MASK	GENMASK_ULL(MAX_PEBS_EVENTS - 1, 0)
>  #define MAX_FIXED_PEBS_EVENTS	16
>  
>  /*
> -- 
> 2.38.1
> 

