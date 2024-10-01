Return-Path: <linux-kernel+bounces-345762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DF698BACB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE561F21759
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AB019DFBF;
	Tue,  1 Oct 2024 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9akqXkq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC72155738
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781381; cv=none; b=Nq7JoPO2bQ35sfiC+gEO4CidpDLM9z/c0a13Ou4J0MDM6PCApddtta4TrdSBEwHX7mSkvA14F4WGCxPQvedO/DMqvGUm81sShDqbyty9Equtqm4gkuswqucKWCNZ9hHU+O5mP/To3Gvp/8UerjDEp9sqN1iXzAzmCUv2ZYx6sB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781381; c=relaxed/simple;
	bh=6htS2YySCD10Z6Q6du79vcy25YcyaZ/2rbL6mVtrTD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu949gnsjsLZe8UXPb23CAk1B/x3pZoc8iP4pWCZQx/l4Z6A17RWqIkHxZRkkQUoozQUmzdPdzwW3Egf+LEZBP2OymGpCLFJGXtIB0ttBxZbomsOY+myQVndlatTUZ5XolJvPX+6q4fFCfQO6D12llQ4pYgt0SVdcOXbmWfX2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9akqXkq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727781379; x=1759317379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6htS2YySCD10Z6Q6du79vcy25YcyaZ/2rbL6mVtrTD4=;
  b=D9akqXkqu2Am1g/DcscRcDKNeYQ1cgGh6jjn1PEwgYwWjpk0HntpqglK
   71n+y0ZH9k0GZ3TNTkvjjFVX8xqPT1BKna3OnRcgw44YvnqEBFtSpJq6o
   zJ9hswonVSL3VztVG8WHUnyLu2uF2BRI01rSq5d0og3Ov80y9jApL12YO
   3zQH9zo3ITSl/7/Wt3JlmV1YBR5pjJoNn88vECctYDI3LPNjDx3gT8Mgj
   COrP/fQoiPRmLTv0nyl012WSwEMQCJtr4IJ41CaFjJKLlCkIsRGrs7PN5
   8a9yyuPPizo/hYHEyJHnfjWkmbsfmoxUPpBaIdBnRHwry1+lZk0APYxJU
   g==;
X-CSE-ConnectionGUID: 3ctKxquwRvWo9wwOtKqoOg==
X-CSE-MsgGUID: IXPwYG13QcqGOiMJIkZ/UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="38270151"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="38270151"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 04:16:19 -0700
X-CSE-ConnectionGUID: SaW6ZWKsSz+Ymu3KjyM2xA==
X-CSE-MsgGUID: W7EAQ5RqSbWzDjuAY+GlIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="104462354"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 04:16:18 -0700
Date: Tue, 1 Oct 2024 04:16:14 -0700
From: Andi Kleen <ak@linux.intel.com>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@kernel.org, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org, eranian@google.com,
	thomas.falcon@intel.com
Subject: Re: [PATCH 3/3] perf/x86/intel: Support auto counter reload
Message-ID: <ZvvZ78QAH254TiHe@tassilo>
References: <20240930154122.578924-1-kan.liang@linux.intel.com>
 <20240930154122.578924-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930154122.578924-4-kan.liang@linux.intel.com>


I hope the perf tools will support a nicer syntax, the mask is quite
obscure.

On Mon, Sep 30, 2024 at 08:41:22AM -0700, kan.liang@linux.intel.com wrote:
>  }
>  
> +static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int msr_b, msr_c;
> +
> +	if (!mask && cpuc->acr_cfg_b[idx] == mask)
> +		return;


if (!mask && !cpuc->acr_cfg_b[idx])

> +
> +	if (idx < INTEL_PMC_IDX_FIXED) {
> +		msr_b = MSR_IA32_PMC_V6_GP0_CFG_B;
> +		msr_c = MSR_IA32_PMC_V6_GP0_CFG_C;
> +	} else {
> +		msr_b = MSR_IA32_PMC_V6_FX0_CFG_B;
> +		msr_c = MSR_IA32_PMC_V6_FX0_CFG_C;
> +		idx -= INTEL_PMC_IDX_FIXED;
> +	}

Does this handle metrics correctly?

I assume you ran the fuzzer over this.

> +	if (cpuc->acr_cfg_b[idx] != mask) {
> +		wrmsrl(msr_b + x86_pmu.addr_offset(idx, false), mask);
> +		cpuc->acr_cfg_b[idx] = mask;
> +	}
> +	/* Only need to update the reload value when there is a valid config value. */
> +	if (mask && cpuc->acr_cfg_c[idx] != reload) {
> +		wrmsrl(msr_c + x86_pmu.addr_offset(idx, false), reload);
> +		cpuc->acr_cfg_c[idx] = reload;

Can reload be larger than the counter width? What happens then?

>  	return c2;
>  }
>  
> @@ -3948,6 +4004,78 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
>  	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
>  }
>  
> +static bool intel_pmu_is_acr_group(struct perf_event *event)
> +{
> +	if (!hybrid(event->pmu, acr_cntr_mask64))
> +		return false;

Shouldn't this error when the group leader
has the flag set?

> +	/* The group leader has the ACR flag set */
> +	if (is_acr_event_group(event))
> +		return true;
> +
> +	/* The acr_mask is set */
> +	if (event->attr.config2)
> +		return true;

> +		 * the group. Reconfigure the dyn_mask of each X86 event
> +		 * every time when add a new event.
> +		 *
> +		 * Check whether the reloadable counters is enough and
> +		 * initialize the dyn_mask.
> +		 */
> +		if (intel_pmu_acr_check_reloadable_event(event))
> +			return -EINVAL;
> +
> +		/* Reconfigure the dyn_mask for each event */
> +		intel_pmu_set_acr_dyn_mask(leader, event_idx++, event);
> +		for_each_sibling_event(sibling, leader)
> +			intel_pmu_set_acr_dyn_mask(sibling, event_idx++, event);
> +		intel_pmu_set_acr_dyn_mask(event, event_idx, event);
> +

Shouldn't there be an error somewhere when a mask bit is set that
exceeds the group? (maybe I missed it)

I assume it could #GP on the MSR write, or maybe even overflow into
some other field.

-Andi

