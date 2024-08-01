Return-Path: <linux-kernel+bounces-271519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B47944F53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69A31C239B6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07531B4C26;
	Thu,  1 Aug 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CYYnTMua"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48301B373D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526306; cv=none; b=P3juUWitE9C5WVep1w4LjGAb8s/Hpa3xXtBTII+YFJ9BZZ3pKTRlnI8AVHxvfB1s0WItWILtLiVEqvveN6Ei19vmGjLPfGJHOr71lRkGDaGwjR362bwy+0TjjkU7ymjew3YscL+3w2E+cZBlberQEiHBqSmxD0zC8LpDktZWFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526306; c=relaxed/simple;
	bh=IWjUDJPUvp5gTsn3jKb7oDEC0MgGATxcHJAzfNxuKL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0ucpD/zPH1pAZpff1hHCwCL4bLCFXdBN1uLStkTaU3haTgjwDXAP4lpvmqgAQQ8Z0wt3cmfhQ2wkvql+636ME+ih+xRitUyqcFQxCSnl51y5bnM4zNHAyTaFHB/PweyRIQVpubx5ES/uqVyWJZAOF6jW2TJ+w7E0o3iqcETodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CYYnTMua; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722526305; x=1754062305;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IWjUDJPUvp5gTsn3jKb7oDEC0MgGATxcHJAzfNxuKL0=;
  b=CYYnTMuap7wxm4HmJgxrvVtYB+/HTdIF7wdxXI7rH2vyGlZg+SVrKVkD
   QgnNFIKzfG4p/+CI8Cy1PKtAcbplcAVTCsw0xR6mVPfruzPJ02Juc3YHo
   vc7S4f98+tYyh6chKwQZ0S0kfBpssIYk1I+MpzsgD6eGzvOVwD/Uwfqt/
   I9BXh22zSG7HrNG1CznXEx022s36dwv7WjSlXhrTU6HDAtyRRovwp/8CK
   C4q5VYoWEjDLUsp0LseIgqfh7gjxrpQNw34Fq3st+xUb0g5iDukWDhJEZ
   sGP9iWigGGIo6yBm8t6N6n27SrRGh+UGr3fgoFHT+AeVQaL0010l4l8da
   w==;
X-CSE-ConnectionGUID: rg0xwJ7eTPGY9Flc0vPaXg==
X-CSE-MsgGUID: 05nUDASOQhOp893ILKdt6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="31139866"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="31139866"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 08:31:44 -0700
X-CSE-ConnectionGUID: Kqo0h2veRmSeV1lveoavGg==
X-CSE-MsgGUID: SmM2hfa6SHW9Ep50Aqdb3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="59719086"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 08:31:44 -0700
Received: from [10.212.79.217] (kliang2-mobl1.ccr.corp.intel.com [10.212.79.217])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id CB5EE20BA6EC;
	Thu,  1 Aug 2024 08:31:41 -0700 (PDT)
Message-ID: <f9b18e66-eb7d-4998-8843-b1a16cc004b0@linux.intel.com>
Date: Thu, 1 Aug 2024 11:31:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/5] perf/x86: Extend event update interface
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com, Sandipan Das <sandipan.das@amd.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, silviazhao <silviazhao-oc@zhaoxin.com>
References: <20240731143835.771618-1-kan.liang@linux.intel.com>
 <20240731143835.771618-2-kan.liang@linux.intel.com>
 <20240801140340.GF37996@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240801140340.GF37996@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-01 10:03 a.m., Peter Zijlstra wrote:
> On Wed, Jul 31, 2024 at 07:38:31AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The current event update interface directly reads the values from the
>> counter, but the values may not be the accurate ones users require. For
>> example, the sample read feature wants the counter value of the member
>> events when the leader event is overflow. But with the current
>> implementation, the read (event update) actually happens in the NMI
>> handler. There may be a small gap between the overflow and the NMI
>> handler.
> 
> This...
> 
>> The new Intel PEBS counters snapshotting feature can provide
>> the accurate counter value in the overflow. The event update interface
>> has to be updated to apply the given accurate values.
>>
>> Pass the accurate values via the event update interface. If the value is
>> not available, still directly read the counter.
> 
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 12f2a0c14d33..07a56bf71160 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -112,7 +112,7 @@ u64 __read_mostly hw_cache_extra_regs
>>   * Can only be executed on the CPU where the event is active.
>>   * Returns the delta events processed.
>>   */
>> -u64 x86_perf_event_update(struct perf_event *event)
>> +u64 x86_perf_event_update(struct perf_event *event, u64 *val)
>>  {
>>  	struct hw_perf_event *hwc = &event->hw;
>>  	int shift = 64 - x86_pmu.cntval_bits;
>> @@ -131,7 +131,10 @@ u64 x86_perf_event_update(struct perf_event *event)
>>  	 */
>>  	prev_raw_count = local64_read(&hwc->prev_count);
>>  	do {
>> -		rdpmcl(hwc->event_base_rdpmc, new_raw_count);
>> +		if (!val)
>> +			rdpmcl(hwc->event_base_rdpmc, new_raw_count);
>> +		else
>> +			new_raw_count = *val;
>>  	} while (!local64_try_cmpxchg(&hwc->prev_count,
>>  				      &prev_raw_count, new_raw_count));
>>  
> 
> Does that mean the following is possible?
> 
> Two counters: C0 and C1, where C0 is a PEBS counter that also samples
> C1.
> 
>   C0: overflow-with-PEBS-assist -> PEBS entry with counter value A
>       (DS buffer threshold not reached)
> 
>   C1: overflow -> PMI -> x86_perf_event_update(C1, NULL)
>       rdpmcl reads value 'A+d', and sets prev_raw_count
> 
>   C0: more assists, hit DS threshold -> PMI
>       PEBS processing does x86_perf_event_update(C1, A)
>       and sets prev_raw_count *backwards*

I think the C0 PMI handler doesn't touch other counters unless
PERF_SAMPLE_READ is applied. For the PERF_SAMPLE_READ, only one counter
does sampling. It's impossible that C0 and C1 do sampling at the same
time. I don't think the above scenario is possible.

Maybe we can add the below check to further prevent the abuse of the
interface.

WARN_ON_ONCE(!(event->attr.sample_type & PERF_SAMPLE_READ) && val);

Thanks,
Kan


