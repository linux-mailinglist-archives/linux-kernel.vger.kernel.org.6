Return-Path: <linux-kernel+bounces-224837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A6D912772
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761C81C2127C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C491D55D;
	Fri, 21 Jun 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyIJsmok"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6E1D54B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979579; cv=none; b=BqAU4hc/6bw3enl08jt6cBFBl91IFVNS9BrdxXl34yKhp2ysNzYRHcTlAKJeqdHSpnHCqJ+WOjg3End4AqdRk86BdRY9pFbSXp8thIz79ITPYijYs1/CMfhsBDi1TqUIL7gysMmeWk69VFAo3K5tgaIrbJ91dwKpRZu6Wfa+TRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979579; c=relaxed/simple;
	bh=SrnMZZQ5PZc4IG0LvJ6ZbP8gP6dzaE1XqalB6uw3P7A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cj/yrNp/XfCt5pNyobSN0qqDyyOQefeVwVSeKfnrpgc6zdMKgIoOoJ9nTsyyUvpiBakTcMnpSWtZTgUE4+EIGTo6+v41ZnQwP+wCy/WxSnS+6AmAs8akibzRpQS0iDEm2SfKza4Kp3ah9qPBxAl3q8RG44XGt9pO9tQZksfDeDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyIJsmok; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718979579; x=1750515579;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=SrnMZZQ5PZc4IG0LvJ6ZbP8gP6dzaE1XqalB6uw3P7A=;
  b=eyIJsmoks+lxPIwE3ssFWg7kF8vr6G2v9KRJ95xjVf/gRmbxtyLvmSHb
   k8JCVzy/sey2189av8VGDMK/fLVkp2ZIDSHW+6jHexx5mUemgTvX/TIwu
   ZcryMVoLj3+Vsad8iTMenrCYoddiWNHQ8prPcxBR2Y3I7KQWEIoqMyOfV
   vbWn4cU9McMyYiTOblgnin05RJq7llgBJHcqjbUP+iJmTxurMn4AZFb3I
   5dg1RxU1GHbKCmV0oupqO3Ae2ukGPg8Iq04QPFXscTghpkM5NZnGIt688
   eu2Vzndao/w17DBlmi6nHXxU9BMZQxSZyc3N43AUAzV/d+EJCHRSAhP89
   g==;
X-CSE-ConnectionGUID: BDfqVR1ES+KGUkH80A8uDA==
X-CSE-MsgGUID: e6x1qx8qRfmGqyxlf2qHdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="16157971"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="16157971"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 07:19:38 -0700
X-CSE-ConnectionGUID: 5E69wIE2QSGp2zyLsBtNgg==
X-CSE-MsgGUID: ZGZEW1v7TbacaISnnru5Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="47520889"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 07:19:38 -0700
Received: from [10.212.73.237] (kliang2-mobl1.ccr.corp.intel.com [10.212.73.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0CD3120B5703;
	Fri, 21 Jun 2024 07:19:35 -0700 (PDT)
Message-ID: <ab9ca3e3-6484-482b-aaf8-6be21dd6fc9a@linux.intel.com>
Date: Fri, 21 Jun 2024 10:19:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 01/12] perf/x86/intel: Support the PEBS event mask
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-2-kan.liang@linux.intel.com>
 <20240620070215.GP31592@noisy.programming.kicks-ass.net>
 <840ced10-cc0f-4883-8559-772c5521a092@linux.intel.com>
Content-Language: en-US
In-Reply-To: <840ced10-cc0f-4883-8559-772c5521a092@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-20 11:58 a.m., Liang, Kan wrote:
> 
> 
> On 2024-06-20 3:02 a.m., Peter Zijlstra wrote:
>> On Tue, Jun 18, 2024 at 08:10:33AM -0700, kan.liang@linux.intel.com wrote:
>>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>>> index e010bfed8417..a0104c82baed 100644
>>> --- a/arch/x86/events/intel/ds.c
>>> +++ b/arch/x86/events/intel/ds.c
>>
>>> @@ -2157,6 +2157,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>>  	void *base, *at, *top;
>>>  	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
>>>  	short error[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
>>> +	int max_pebs_events = hweight64(x86_pmu.pebs_events_mask);
>>
>> Consider pebs_events_mask = 0xf0, then max_pebs_events becomes 4.
> 
> The intel_pmu_drain_pebs_nhm() is a NHM specific function. It's
> impossible that there is a pebs_events_mask = 0xf0.
> 
> There are only 4 counters. The mask should always be 0xf.
>>
>>>  	int bit, i, size;
>>>  	u64 mask;
>>>  
>>> @@ -2168,8 +2169,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>>  
>>>  	ds->pebs_index = ds->pebs_buffer_base;
>>>  
>>> -	mask = (1ULL << x86_pmu.max_pebs_events) - 1;
>>> -	size = x86_pmu.max_pebs_events;
>>> +	mask = x86_pmu.pebs_events_mask;
>>> +	size = max_pebs_events;
>>
>> This is wrong.. you have 8 bits to iterate, of which only the top 4 are
>> set.
>>
>>>  	if (x86_pmu.flags & PMU_FL_PEBS_ALL) {
>>>  		mask |= ((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED;
>>>  		size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
>>> @@ -2208,8 +2209,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>>  			pebs_status = p->status = cpuc->pebs_enabled;
>>>  
>>>  		bit = find_first_bit((unsigned long *)&pebs_status,
>>> -					x86_pmu.max_pebs_events);
>>> -		if (bit >= x86_pmu.max_pebs_events)
>>> +					max_pebs_events);
>>> +		if (bit >= max_pebs_events)
>>>  			continue;
>>
>> But the bit check here then truncates the thing to the lower 4 bits
>> which are all 0.
>>
>> Should this not be something like:
>>
>> 		if (!(pebs_event_mask & (1 << bit)))
>> 			continue;
>>
>> ?
>>
> 
> For the existing hardware, I don't think it's necessary. The counters
> are contiguous.
> 

Think about it twice. Although either code works, we should try to make
the code as generic as possible.

I will introduce a generic x86_pmu_max_num_pebs() and check the highest
set bit, rather than hweight64. It can be used by both NHM and the
future platforms.


Thanks,
Kan

