Return-Path: <linux-kernel+bounces-282037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0494DEC9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A173B21569
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DFD13D621;
	Sat, 10 Aug 2024 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VO9D14ed"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7983AC2B
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723325745; cv=none; b=F0yt7OxMTeZMlAGRylNYK7SIkmBhGhwUJjyAn+l6Vzj37iD4RyiKVpQbz8SBX+ue7rRfb0SdM6dE1OF77j52Mc8j/6rbZnc8FsYecUsgL4ugwkuFlY9K14b5DZQeJsVYlvV4JUrVxpkG3KFidswVw3/5KndCWrLts2YZUVBeGeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723325745; c=relaxed/simple;
	bh=l7oM5x4WGa2u1OKU4MdPUOnH5Xhhtt8L4Xb67naPNWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCq7S0rksnBJdHAqS88gkBSCMDDcNsvATEk4sAIFVKSswZVhxblkIcdi/DX0DCEoYY19J8rcda6JHkTuzvWTq5SeH2THJD/l/9ofM9KDC/wQYSifZC1vhU+XZgcwdbN47j6Oav5WjFZOfbo3tbxT3oWicM6BQmhJeP0Z+t7x95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VO9D14ed; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4gcqhWsBya8247yjgKWGEDCYv2TTHi2FGR7PViuowaM=; b=VO9D14edoZ4CvEVvlV5ceHIdI+
	QH45u9XOpvPbQSXlmNw6P+sbuxGTtqOmnrMTgHC7H67sww03uiFGLI5IVDsgXcfCDFYvopAbgOy18
	J0AS1ju3HQSbt6iqs9iQsnIedBf9LVrnOMB6h6uuhh4o2JQ0Kl6oxpHuq1STVNAZ5Df2/EaNlOGIJ
	i0fgiSUAoh9Y0LzDXtRUueBOaD8QGAkVnW0GKJxvMX0NwYjiGCevhR2vd3s3vOC08PPthQt4JC7oc
	9834E/C+f6Us9nItiihvAutJ6C19H3s+7ntbDy326pa/6wNC+1nsWur87OxOm6vxj5S1+awcQ9ZTo
	3pt88L/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sctkN-0000000Clvs-3awl;
	Sat, 10 Aug 2024 21:35:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 68528300729; Sat, 10 Aug 2024 23:35:35 +0200 (CEST)
Date: Sat, 10 Aug 2024 23:35:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 1/4] perf/x86: Refine hybrid_pmu_type defination
Message-ID: <20240810213535.GF11646@noisy.programming.kicks-ass.net>
References: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
 <20240808140210.1666783-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808140210.1666783-2-dapeng1.mi@linux.intel.com>

On Thu, Aug 08, 2024 at 02:02:07PM +0000, Dapeng Mi wrote:
> Use macros instead of magic number to define hybrid_pmu_type and remove
> X86_HYBRID_NUM_PMUS since it's never used.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> ---
>  arch/x86/events/perf_event.h | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index ac1182141bf6..5d1677844e04 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -674,19 +674,16 @@ enum hybrid_cpu_type {
>  	HYBRID_INTEL_CORE	= 0x40,
>  };
>  
> +#define X86_HYBRID_PMU_ATOM_IDX		0
> +#define X86_HYBRID_PMU_CORE_IDX		1

There wants to be some whitespace here..

>  enum hybrid_pmu_type {
>  	not_hybrid,
> -	hybrid_small		= BIT(0),
> -	hybrid_big		= BIT(1),
> +	hybrid_small		= BIT(X86_HYBRID_PMU_ATOM_IDX),
> +	hybrid_big		= BIT(X86_HYBRID_PMU_CORE_IDX),
>  
>  	hybrid_big_small	= hybrid_big | hybrid_small, /* only used for matching */
>  };
>  
> -#define X86_HYBRID_PMU_ATOM_IDX		0
> -#define X86_HYBRID_PMU_CORE_IDX		1
> -
> -#define X86_HYBRID_NUM_PMUS		2
> -
>  struct x86_hybrid_pmu {
>  	struct pmu			pmu;
>  	const char			*name;
> -- 
> 2.40.1
> 

