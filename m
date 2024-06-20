Return-Path: <linux-kernel+bounces-222959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E234910AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CC0B214D1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADD91B0132;
	Thu, 20 Jun 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MY6whC6b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0881CAAD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899128; cv=none; b=ryXS11FPg1l04+qtAm3WorHkfRosqfPMP46olVIYftzKZV2Le83RJCXfF+21VmJfbLZn8/rFqf46dw7vKNzzoIXqKmSRlm6oo9gAE26tH7ipSebwLKdQ0KqWLFvc6dSYKyj9o45EMwaNeXG7wwso87hVe4QnULM5Kp7g2AQCWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899128; c=relaxed/simple;
	bh=9q9rClF+tFSwxrNLMJGeOmaxNkDNjY8hflzzm/DbT5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAswvecwijGl6zHu7rIMCdihr6CySY79x4n6MLgzEIrwFEXs20wCSL5ZTMseWK3OxlKTKRlHP7jbK6UVn0Y6vYFYdQymTyPy9+DgOKHLRSvQK2ERDCydI2TxnWZ+j02Jar6YanPHOvdfcGJLLZ3Sx4JcGSXVjXseQgOVmq2hs94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MY6whC6b; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718899126; x=1750435126;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9q9rClF+tFSwxrNLMJGeOmaxNkDNjY8hflzzm/DbT5Y=;
  b=MY6whC6bylZIxdgTEuXGhVpnOzqjz1a5zuV8tDu3bV6tCtIen/8OtoaC
   2LkvWCCR4ut+vOl4lmGtdrQ9PENFiSJQLb5w71SFr1VjNLiCu5Vc3nlUZ
   c0MAyHFThRV50btIJ1ihxSt/QAgDxY9eDpWNtDkhtcyVwXo3MoAYfxYWi
   DxYxbgT9opjoLh/UrZZ6npzuKWo0kjrWYphUFPNjZMm0LbZjdmDQRHhFT
   YtviaY+29kBr7BhaVgz1eGq+euulKnbr+0vOqzpvLyb/rVbgVIg60m/r8
   o3JUMNJFFIQ+HfBu8eSsbrskCJ+qno7v01pR67U3kQuYwWHBahkwKkvAc
   A==;
X-CSE-ConnectionGUID: fWzKbHE1RDOF5gXwe4qAzA==
X-CSE-MsgGUID: N6vpzvySRHeJPP0DwcigsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15864767"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15864767"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 08:58:45 -0700
X-CSE-ConnectionGUID: cacj085HREaVgeuoTgy5rw==
X-CSE-MsgGUID: FMa6p5i9SIOQCsrTOAzB1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="46817968"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 08:58:45 -0700
Received: from [10.212.43.222] (kliang2-mobl1.ccr.corp.intel.com [10.212.43.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 28B4120B5703;
	Thu, 20 Jun 2024 08:58:44 -0700 (PDT)
Message-ID: <840ced10-cc0f-4883-8559-772c5521a092@linux.intel.com>
Date: Thu, 20 Jun 2024 11:58:42 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 01/12] perf/x86/intel: Support the PEBS event mask
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-2-kan.liang@linux.intel.com>
 <20240620070215.GP31592@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240620070215.GP31592@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-20 3:02 a.m., Peter Zijlstra wrote:
> On Tue, Jun 18, 2024 at 08:10:33AM -0700, kan.liang@linux.intel.com wrote:
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index e010bfed8417..a0104c82baed 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
> 
>> @@ -2157,6 +2157,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>  	void *base, *at, *top;
>>  	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
>>  	short error[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
>> +	int max_pebs_events = hweight64(x86_pmu.pebs_events_mask);
> 
> Consider pebs_events_mask = 0xf0, then max_pebs_events becomes 4.

The intel_pmu_drain_pebs_nhm() is a NHM specific function. It's
impossible that there is a pebs_events_mask = 0xf0.

There are only 4 counters. The mask should always be 0xf.
> 
>>  	int bit, i, size;
>>  	u64 mask;
>>  
>> @@ -2168,8 +2169,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>  
>>  	ds->pebs_index = ds->pebs_buffer_base;
>>  
>> -	mask = (1ULL << x86_pmu.max_pebs_events) - 1;
>> -	size = x86_pmu.max_pebs_events;
>> +	mask = x86_pmu.pebs_events_mask;
>> +	size = max_pebs_events;
> 
> This is wrong.. you have 8 bits to iterate, of which only the top 4 are
> set.
> 
>>  	if (x86_pmu.flags & PMU_FL_PEBS_ALL) {
>>  		mask |= ((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED;
>>  		size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
>> @@ -2208,8 +2209,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>  			pebs_status = p->status = cpuc->pebs_enabled;
>>  
>>  		bit = find_first_bit((unsigned long *)&pebs_status,
>> -					x86_pmu.max_pebs_events);
>> -		if (bit >= x86_pmu.max_pebs_events)
>> +					max_pebs_events);
>> +		if (bit >= max_pebs_events)
>>  			continue;
> 
> But the bit check here then truncates the thing to the lower 4 bits
> which are all 0.
> 
> Should this not be something like:
> 
> 		if (!(pebs_event_mask & (1 << bit)))
> 			continue;
> 
> ?
> 

For the existing hardware, I don't think it's necessary. The counters
are contiguous.

Thanks,
Kan


