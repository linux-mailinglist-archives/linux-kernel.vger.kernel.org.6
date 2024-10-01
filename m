Return-Path: <linux-kernel+bounces-346160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3E798C083
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E291C238A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2351C9EBD;
	Tue,  1 Oct 2024 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkSI2Y7h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B71C7B9D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793683; cv=none; b=SxiDOWI1N4B2+Br4FjsKjOCdzfS1gxRQ04xJ461yc2hq8qTA3VAMP07idf+KH1fPQOwrn2k0wEJkNy5e8LrOcUHSPlKBXkTGGLzDkjeNHKWNBmEAQdA2E2rek7RNSwwCnw06s0QCUFRl50IHtZn0DsiOfmOdH2gepLd2FXzakiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793683; c=relaxed/simple;
	bh=q+pR5Hyk93EPohurVGBw+JRAYbGlRxHW+GhE1y5tCPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENsa9L1GfLoF7OGJ31nDQyqiPFAcmPZ7sS5JMzAM4trK7bfvlwb9M+LdWCxV8sOjN6G6BvBXgnuGjDRpTxIaf8B+Vu2cuVMRTazkVLgBV4FrrncORoN1GFA1qPcXqzMuwIOpm+ibmVK2UQ4OeHhBmpay042UNITSmh867rpLF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkSI2Y7h; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727793681; x=1759329681;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q+pR5Hyk93EPohurVGBw+JRAYbGlRxHW+GhE1y5tCPk=;
  b=BkSI2Y7hNoIuzJ0MjtB0Uwsh5I5h4Zoq+0pKAI7xamPu8MXXbSeW/qdH
   7Qj0ksa2Id84Uhso+VorQudjoBt8FfFSF6ZLoxjd4J1D5OGzCSNqAcqF7
   wFiq6CIoiDIj13SUS/KxnUtQgJUUN5+Tj0SQ5bDjvLO2Mf+PvOR51xufu
   xVuZ9fgrMS0+tM3Rd/l2i/2bZAVkcJsRRZ6i3BZkZTq08p35lX0Xur3DP
   7V+F1Jn2ev5y/WWdIHFdMb7vuq283UjxNv0kxNPyCMNAdjA+bMJ4V9Ml6
   Nq0c+jBqTQ74NswH/st5J82/VOe/0Rme1/orNtGK1M0SeQ2VNL5CLr2WK
   w==;
X-CSE-ConnectionGUID: tOvlzDQSQtmVctUGqmVBqw==
X-CSE-MsgGUID: IcDOaJRLQZq2BeiRC1Joog==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="49454293"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="49454293"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 07:41:21 -0700
X-CSE-ConnectionGUID: PAuirELBRY+1mEnwV+unaw==
X-CSE-MsgGUID: uN/JxacAQv6VAWnWUl2+ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73655206"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 07:41:20 -0700
Received: from [10.212.71.24] (kliang2-mobl1.ccr.corp.intel.com [10.212.71.24])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id F13CC20B8DDA;
	Tue,  1 Oct 2024 07:41:18 -0700 (PDT)
Message-ID: <513602fc-38fd-4764-82a4-7b91dfb37d0e@linux.intel.com>
Date: Tue, 1 Oct 2024 10:41:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf/x86/intel: Support auto counter reload
To: Andi Kleen <ak@linux.intel.com>
Cc: peterz@infradead.org, mingo@kernel.org, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 linux-kernel@vger.kernel.org, eranian@google.com, thomas.falcon@intel.com
References: <20240930154122.578924-1-kan.liang@linux.intel.com>
 <20240930154122.578924-4-kan.liang@linux.intel.com>
 <ZvvZ78QAH254TiHe@tassilo>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZvvZ78QAH254TiHe@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-10-01 7:16 a.m., Andi Kleen wrote:
> 
> I hope the perf tools will support a nicer syntax, the mask is quite
> obscure.

Yes, it's a little bit hard to use, but it's workable with the current
perf too. So I post the kernel patch separately.
Thomas will work on improving the tool side, which will provide a new
and more convenient option.

> 
> On Mon, Sep 30, 2024 at 08:41:22AM -0700, kan.liang@linux.intel.com wrote:
>>  }
>>  
>> +static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	int msr_b, msr_c;
>> +
>> +	if (!mask && cpuc->acr_cfg_b[idx] == mask)
>> +		return;
> 
> 
> if (!mask && !cpuc->acr_cfg_b[idx])
> 

Sure

>> +
>> +	if (idx < INTEL_PMC_IDX_FIXED) {
>> +		msr_b = MSR_IA32_PMC_V6_GP0_CFG_B;
>> +		msr_c = MSR_IA32_PMC_V6_GP0_CFG_C;
>> +	} else {
>> +		msr_b = MSR_IA32_PMC_V6_FX0_CFG_B;
>> +		msr_c = MSR_IA32_PMC_V6_FX0_CFG_C;
>> +		idx -= INTEL_PMC_IDX_FIXED;
>> +	}
> 
> Does this handle metrics correctly?
> 

You mean perf metric? The perf errors out if a perf metric event is
detected.

> I assume you ran the fuzzer over this.
> 
>> +	if (cpuc->acr_cfg_b[idx] != mask) {
>> +		wrmsrl(msr_b + x86_pmu.addr_offset(idx, false), mask);
>> +		cpuc->acr_cfg_b[idx] = mask;
>> +	}
>> +	/* Only need to update the reload value when there is a valid config value. */
>> +	if (mask && cpuc->acr_cfg_c[idx] != reload) {
>> +		wrmsrl(msr_c + x86_pmu.addr_offset(idx, false), reload);
>> +		cpuc->acr_cfg_c[idx] = reload;
> 
> Can reload be larger than the counter width? What happens then?

I will add a check in the hw_config() to make sure that the period is
less than the counter width for the auto-reload case.

> 
>>  	return c2;
>>  }
>>  
>> @@ -3948,6 +4004,78 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
>>  	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
>>  }
>>  
>> +static bool intel_pmu_is_acr_group(struct perf_event *event)
>> +{
>> +	if (!hybrid(event->pmu, acr_cntr_mask64))
>> +		return false;
> 
> Shouldn't this error when the group leader
> has the flag set?

Only when both config2 and acr_cntr_mask64 have values, the group leader
has the flag set by the kernel. The case cannot happen, when
!acr_cntr_mask64, but a group leader has the flag set.

> 
>> +	/* The group leader has the ACR flag set */
>> +	if (is_acr_event_group(event))
>> +		return true;
>> +
>> +	/* The acr_mask is set */
>> +	if (event->attr.config2)
>> +		return true;
> 
>> +		 * the group. Reconfigure the dyn_mask of each X86 event
>> +		 * every time when add a new event.
>> +		 *
>> +		 * Check whether the reloadable counters is enough and
>> +		 * initialize the dyn_mask.
>> +		 */
>> +		if (intel_pmu_acr_check_reloadable_event(event))
>> +			return -EINVAL;
>> +
>> +		/* Reconfigure the dyn_mask for each event */
>> +		intel_pmu_set_acr_dyn_mask(leader, event_idx++, event);
>> +		for_each_sibling_event(sibling, leader)
>> +			intel_pmu_set_acr_dyn_mask(sibling, event_idx++, event);
>> +		intel_pmu_set_acr_dyn_mask(event, event_idx, event);
>> +
> 
> Shouldn't there be an error somewhere when a mask bit is set that
> exceeds the group? (maybe I missed it)

We have no idea how big the whole group is at that moment. We don't know
if the current event is the last one in a group.
Even if the mask (config2) exceeds the group, the invalid part will be
ignored. It should be harmless.

> 
> I assume it could #GP on the MSR write, or maybe even overflow into
> some other field.

The mask (config2) set by the user cannot be directly written to the
MSRs. They are used to find the reloadable mask and caused reload mask,
which are from the enumeration. It guarantees that only the supported
MSRs/counters will be accessed.

The mask (config2) is also used in the intel_pmu_update_acr_mask() which
is after the scheduler. The n - n0 guarantees that only the bits in the
group is converted. The invalid part of the mask (config2) is ignored.

+		/* Convert the group index into the counter index */
+		for_each_set_bit(off, (unsigned long *)&event->attr.config2, n - n0)
+			set_bit(assign[n0 + off], (unsigned long *)&event->hw.config1);



Thanks,
Kan

