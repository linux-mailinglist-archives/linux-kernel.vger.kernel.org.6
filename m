Return-Path: <linux-kernel+bounces-282046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047094DEE0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9736D1C21739
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82111422C2;
	Sat, 10 Aug 2024 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m+/Q2RHU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479913DB9F
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723326951; cv=none; b=uTB5mf35dDD9LIyU6CDt4Jx6VBFGiXnHzEeQ5MMtQd6MaKKqssr1xRxf/I7/smuwOClu4VH2F11kC/pN0Z7f4Q5v8z9mD+vxekyZX18DSdgTKBA01gL7DtQzZWwCTy36dMkKgylgovjwmcAR1xWiVs1BNEMmKVZ07tYWpmgqclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723326951; c=relaxed/simple;
	bh=U8bcmDBXkTIxukwEhMku5zbCLJq9MNK5DWkDxC6hCus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAsilHDOLhXsU5dLgKLbuNwj8o/e3QyauKnhLsteA1XDsWbIljqErGhTdOPgN4AjcskNawpLc7za9YIi8b+dJhCmF+4LAzBUrd2qIfPvY+vB86PAXf8rpCWiSam/OQRtZSufMkEf3DBUpBdTOPsLGR7bgRS8Qb3/XtyO2b9HbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m+/Q2RHU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ldkd9ySFZTnUyDyfGMd9P+rt5PkOKjZMT1XjP/tPpX8=; b=m+/Q2RHUxVpTB1AvHLZ+XOe0QL
	XIXutWReBDtm75X/E1E1VYfCVm2zHfacDm9qL++dx5/EV3hIK3VOAUtrou2CyktZAl3WfZZ/FUiE/
	cQeYyGE8wb0vZMBJYxM5eV3fK3t1L9Q6zj73VHQIBmSYGHfhI1t1zRMylu8BKCZjJKI3D3CNB/YC8
	oI2+vyBdOZ8gRrWIWFVSChRxLldL7Qvtuj3mr/Phmea/+SMWKQH1WLs5zDmxKpzV+YNjeXTG+ngrS
	NBBYFM6xQu+g/sb6sydhYnDqzyR7SLj1JtITKWD5PpslZ/Xsfco9QizbHk1ueavxUl1QMTCfk2SWY
	sAsoVGkg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scu3o-0000000Cmh5-2BO7;
	Sat, 10 Aug 2024 21:55:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E2C0D300729; Sat, 10 Aug 2024 23:55:39 +0200 (CEST)
Date: Sat, 10 Aug 2024 23:55:39 +0200
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
Subject: Re: [PATCH 3/4] perf/x86/intel: Support hybrid PMU with multiple
 atom uarchs
Message-ID: <20240810215539.GG11646@noisy.programming.kicks-ass.net>
References: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
 <20240808140210.1666783-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808140210.1666783-4-dapeng1.mi@linux.intel.com>

On Thu, Aug 08, 2024 at 02:02:09PM +0000, Dapeng Mi wrote:
>  arch/x86/events/intel/core.c | 24 +++++++++++++++++-------
>  arch/x86/events/perf_event.h | 18 +++++++++++++++++-
>  2 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0c9c2706d4ec..b6429bc009c0 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

> @@ -6218,6 +6227,7 @@ static inline int intel_pmu_v6_addr_offset(int index, bool eventsel)
>  static const struct { enum hybrid_pmu_type id; char *name; } intel_hybrid_pmu_type_map[] __initconst = {
>  	{ hybrid_small, "cpu_atom" },
>  	{ hybrid_big, "cpu_core" },
> +	{ hybrid_small2, "cpu_atom2" },

This is awfully uninspired and quite terrible. How is one supposed to
know which is which? A possibly better naming might be: hybrid_tiny,
"cpu_lowpower" or whatever.

>  };
>  
>  static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
> @@ -6250,7 +6260,7 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
>  							0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
>  
>  		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
> -		if (pmu->pmu_type & hybrid_small) {
> +		if (pmu->pmu_type & hybrid_small_all) {
>  			pmu->intel_cap.perf_metrics = 0;
>  			pmu->intel_cap.pebs_output_pt_available = 1;
>  			pmu->mid_ack = true;
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 5d1677844e04..f7b55c909eff 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -668,6 +668,13 @@ enum {
>  #define PERF_PEBS_DATA_SOURCE_GRT_MAX	0x10
>  #define PERF_PEBS_DATA_SOURCE_GRT_MASK	(PERF_PEBS_DATA_SOURCE_GRT_MAX - 1)
>  
> +
> +/*
> + * CPUID.1AH.EAX[31:0] uniquely identifies the microarchitecture
> + * of the core. Bits 31-24 indicates its core type (Core or Atom)
> + * and Bits [23:0] indicates the native model ID of the core.
> + * Core type and native model ID are defined in below enumerations.
> + */
>  enum hybrid_cpu_type {
>  	HYBRID_INTEL_NONE,
>  	HYBRID_INTEL_ATOM	= 0x20,
> @@ -676,12 +683,21 @@ enum hybrid_cpu_type {
>  
>  #define X86_HYBRID_PMU_ATOM_IDX		0
>  #define X86_HYBRID_PMU_CORE_IDX		1
> +#define X86_HYBRID_PMU_ATOM2_IDX	2
>  enum hybrid_pmu_type {
>  	not_hybrid,
>  	hybrid_small		= BIT(X86_HYBRID_PMU_ATOM_IDX),
>  	hybrid_big		= BIT(X86_HYBRID_PMU_CORE_IDX),
> +	hybrid_small2		= BIT(X86_HYBRID_PMU_ATOM2_IDX),
> +	/* The belows are only used for matching */
> +	hybrid_big_small	= hybrid_big | hybrid_small,
> +	hybrid_small_all	= hybrid_small | hybrid_small2,
> +	hybrid_big_small_arl_h	= hybrid_big | hybrid_small_all,

Same complaint, how about:

+	hybrid_tiny		= BIT(X86_HYBRID_PMU_TINY_IDX),
	hybrid_big_small	= hybrid_big | hybrid_small,
+	hybrid_small_tiny	= hybrid_small | hybrid_tiny,
+	hybrid_big_small_tiny	= hybrid_big_small | hybrid_tiny,


> +};
>  
> -	hybrid_big_small	= hybrid_big | hybrid_small, /* only used for matching */
> +enum atom_native_id {
> +	cmt_native_id           = 0x2,  /* Crestmont */
> +	skt_native_id           = 0x3,  /* Skymont */
>  };
>  
>  struct x86_hybrid_pmu {
> -- 
> 2.40.1
> 

