Return-Path: <linux-kernel+bounces-271788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2352945337
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3C9B2266F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE314A4E9;
	Thu,  1 Aug 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/MHtyrq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AB149C47
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539894; cv=none; b=C2OZFu86SwAT3odsNYiQBxILdXoF2nAb90DM6iV2clCZzg2qY38Ngf3A3FSmv8aKYSOsIJHtZit+53I3O7JCU936308l9Noy1iHARGJJBco6f0cNGL6pcEHwr7xJikHeS6UawJLn0Lct4VjI0Hrpum7mY/Sm756gyyErwCf6eic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539894; c=relaxed/simple;
	bh=06xLZBAZ6APtprUg5SVCpVvZUwNXs8SgrulBPssGy8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3jIF/idN0vntmmGLMBxzVifA/yiGU2BImHUZbjJ5+xn84JoZ94KuABhv3G+Kh0zJMJaG+3Qv1vaFqAfna0AKbEe5lVW7uD1HpeYmS/iP3cudWf0U5RBqi1jbu4aN1PRdWZtC+3sd3jztPwmAUWIITwBll9IUcMY/u0PA7Qi/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/MHtyrq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722539893; x=1754075893;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=06xLZBAZ6APtprUg5SVCpVvZUwNXs8SgrulBPssGy8w=;
  b=j/MHtyrq0jFfYuHok6QrU8t2droQzrlyAXS25j1lv2Q1YC4ylEGYNkoD
   YyEZU27QHV6UqqUyacKQPcJIqYxOoly1nAcC2P9wNOKOTMmj4NdQNWZJG
   rKh4Orr836/dBSRefgF5yY6h5RpfsNqq5H/tNqdAQEWVtlbbGKAZrUUBB
   KzjZNKjbW2BdmYhnfHu4WH5M2R/AYuCwAvRihwDRWFnfhWpfVEiWV1s1l
   6MpTSE59Q694DAOdJVR0011KGgArXnSBRmZJfnZX056Z6fePprBzh9Vvv
   dZI5G0Jloi1Sc7HpJWR4scVoTzqMo2idN+1Rdhi/LQAQglLlKfLCyNoPU
   A==;
X-CSE-ConnectionGUID: xhgikn4HT26oUK14lWQXXg==
X-CSE-MsgGUID: XHn3aX3YSJmtQcvpxpN3sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20661020"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="20661020"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 12:18:12 -0700
X-CSE-ConnectionGUID: UrCM/vA4SI+ckH0G9wSuSg==
X-CSE-MsgGUID: 4WMQ5p0USWuj+eZQcSstCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="92686992"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 12:18:11 -0700
Received: from [10.212.79.217] (kliang2-mobl1.ccr.corp.intel.com [10.212.79.217])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0AF3C20BA6EC;
	Thu,  1 Aug 2024 12:18:09 -0700 (PDT)
Message-ID: <d3e901d6-5159-4638-8ae0-f5ecabdb1e93@linux.intel.com>
Date: Thu, 1 Aug 2024 15:18:08 -0400
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
 <f9b18e66-eb7d-4998-8843-b1a16cc004b0@linux.intel.com>
 <20240801163618.GD39708@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240801163618.GD39708@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-01 12:36 p.m., Peter Zijlstra wrote:
> On Thu, Aug 01, 2024 at 11:31:40AM -0400, Liang, Kan wrote:
>>
>>
>> On 2024-08-01 10:03 a.m., Peter Zijlstra wrote:
>>> On Wed, Jul 31, 2024 at 07:38:31AM -0700, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> The current event update interface directly reads the values from the
>>>> counter, but the values may not be the accurate ones users require. For
>>>> example, the sample read feature wants the counter value of the member
>>>> events when the leader event is overflow. But with the current
>>>> implementation, the read (event update) actually happens in the NMI
>>>> handler. There may be a small gap between the overflow and the NMI
>>>> handler.
>>>
>>> This...
>>>
>>>> The new Intel PEBS counters snapshotting feature can provide
>>>> the accurate counter value in the overflow. The event update interface
>>>> has to be updated to apply the given accurate values.
>>>>
>>>> Pass the accurate values via the event update interface. If the value is
>>>> not available, still directly read the counter.
>>>
>>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>>> index 12f2a0c14d33..07a56bf71160 100644
>>>> --- a/arch/x86/events/core.c
>>>> +++ b/arch/x86/events/core.c
>>>> @@ -112,7 +112,7 @@ u64 __read_mostly hw_cache_extra_regs
>>>>   * Can only be executed on the CPU where the event is active.
>>>>   * Returns the delta events processed.
>>>>   */
>>>> -u64 x86_perf_event_update(struct perf_event *event)
>>>> +u64 x86_perf_event_update(struct perf_event *event, u64 *val)
>>>>  {
>>>>  	struct hw_perf_event *hwc = &event->hw;
>>>>  	int shift = 64 - x86_pmu.cntval_bits;
>>>> @@ -131,7 +131,10 @@ u64 x86_perf_event_update(struct perf_event *event)
>>>>  	 */
>>>>  	prev_raw_count = local64_read(&hwc->prev_count);
>>>>  	do {
>>>> -		rdpmcl(hwc->event_base_rdpmc, new_raw_count);
>>>> +		if (!val)
>>>> +			rdpmcl(hwc->event_base_rdpmc, new_raw_count);
>>>> +		else
>>>> +			new_raw_count = *val;
>>>>  	} while (!local64_try_cmpxchg(&hwc->prev_count,
>>>>  				      &prev_raw_count, new_raw_count));
>>>>  
>>>
>>> Does that mean the following is possible?
>>>
>>> Two counters: C0 and C1, where C0 is a PEBS counter that also samples
>>> C1.
>>>
>>>   C0: overflow-with-PEBS-assist -> PEBS entry with counter value A
>>>       (DS buffer threshold not reached)
>>>
>>>   C1: overflow -> PMI -> x86_perf_event_update(C1, NULL)
>>>       rdpmcl reads value 'A+d', and sets prev_raw_count
>>>
>>>   C0: more assists, hit DS threshold -> PMI
>>>       PEBS processing does x86_perf_event_update(C1, A)
>>>       and sets prev_raw_count *backwards*
>>
>> I think the C0 PMI handler doesn't touch other counters unless
>> PERF_SAMPLE_READ is applied. For the PERF_SAMPLE_READ, only one counter
>> does sampling. It's impossible that C0 and C1 do sampling at the same
>> time. I don't think the above scenario is possible.
> 
> It is perfectly fine for C0 to have PERF_SAMPLE_READ and C1 to be a
> normal counter, sampling or otherwise.
> 
>> Maybe we can add the below check to further prevent the abuse of the
>> interface.
> 
> There is no abuse in the above scenario. You can have a group with all
> sampling events and any number of them can have PERF_SAMPLE_READ. This
> is perfectly fine.
> 
>> WARN_ON_ONCE(!(event->attr.sample_type & PERF_SAMPLE_READ) && val);
> 
> I don't see how PERF_SAMPLE_READ is relevant, *any* PMI for the C1 event
> will cause x86_perf_event_update() to be called. And remember that even
> non-sampling events have EVENTSEL_INT set to deal with counter overflow.
> 
> The problem here is that C0/PEBS will come in late and try to force
> update an out-of-date value.
> 
> If you have C1 be a non-sampling event, this will typically not happen,
> but it still *can*, and when you do, you get your counter moving
> backwards.

Now, only the PEBS records may include an out-of-date value. I think we
can always drain PEBS before handling the overflow from the non PEBS
event overflow.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0c9c2706d4ec..255eb7231181 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3109,6 +3109,9 @@ static int handle_pmi_common(struct pt_regs *regs,
u64 status)
 		if (!test_bit(bit, cpuc->active_mask))
 			continue;

+		if (event->hw.flags & PERF_X86_EVENT_PEBS_CNTR)
+			x86_pmu.drain_pebs(regs, &data);
+
 		if (!intel_pmu_save_and_restart(event))
 			continue;


Thanks,
Kan


