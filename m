Return-Path: <linux-kernel+bounces-227520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F4A91529A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A89B1F2106F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6519CCFB;
	Mon, 24 Jun 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXFGOj0e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC071EB48
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243393; cv=none; b=YMeiMdJ1/Js+UTVPOQEfdP+2R/BGmV9CpsvpZ8doqkn9fRrdCiUNvoXRY4bWqGt6fqEZ2yryZjLUqEtL44F1vNZQaoaGP70Va3x69uN3iWmX7HQt55w+NF6ufXaJXAXs3ZL9f/+AaKbZsyRpc75t6oVAA8gqtqb7uwYXEcebjkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243393; c=relaxed/simple;
	bh=IvzxzwoU9wgfno97OQYnGfsIOXaDQHq7IrJHTBf1rlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0k3BuGwh6PSsF5V7Y4BGSm1Wcn2eLQCNm6JnMHg0zR0QRnuv2e1oi/l7IZ0Z+69BhPro+6JYsc6iyysJBIedDJmJqG3MS+hkue3Srap2Hn4FsWLrV8454HVPmsdzW71isw7iZWjT9KJYbVWKprRna2OQEdZh/2/rlMwCd/mrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXFGOj0e; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719243392; x=1750779392;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IvzxzwoU9wgfno97OQYnGfsIOXaDQHq7IrJHTBf1rlk=;
  b=EXFGOj0e+GgESddxE2ZgHh2pgpRj13nS9LbXPWDNFluSCKdcvDve8ojI
   rrIr5y4Qz42pbueVpCiNkJlgN8+/ZnX7aXFEooQeqjyKA/+TJ0A9HeAXA
   LdzKPOdqDaJvId8avhoAqLsYmZGdk5KVibS/aXen3Ocoxv+g36kdcWMtA
   5Ik7Jus3f3AcjIDsFmSfoFILlEIzVdzkU+tR2Ido4bz1GpIRs6fPqh3g2
   jUfXv8wUAKzvORze2HTn1QopwtBHDfu6ygX3kOdozNd+HJVuPwhn5Jkxn
   tC0Qt1Ch7os0om6K2ATC5cT3ND3ACjpOod/ZgkEeJwp+9lTHNNzL7ot/j
   w==;
X-CSE-ConnectionGUID: x3g15t+USw6AI33h5RSOug==
X-CSE-MsgGUID: XllAsDU7RzCgPnWnb/9ghA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16364067"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16364067"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 08:36:31 -0700
X-CSE-ConnectionGUID: O8JDtPZbS0iI3nh4th3Z/Q==
X-CSE-MsgGUID: TDcpJABiRxG3Zs5kmQQWmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43147551"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 08:36:31 -0700
Received: from [10.212.44.172] (kliang2-mobl1.ccr.corp.intel.com [10.212.44.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 46F6920B5703;
	Mon, 24 Jun 2024 08:36:29 -0700 (PDT)
Message-ID: <7774dffe-4e1c-4a86-826e-dbac8e82dc74@linux.intel.com>
Date: Mon, 24 Jun 2024 11:36:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 05/12] perf/x86: Add config_mask to represent
 EVENTSEL bitmask
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-6-kan.liang@linux.intel.com>
 <20240620074402.GS31592@noisy.programming.kicks-ass.net>
 <4cce9f37-7698-418d-a9c5-4aa1dc01b719@linux.intel.com>
 <ff25c37f-cb62-4687-adaa-596e8fc3a52a@linux.intel.com>
 <20240624082809.GC31592@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240624082809.GC31592@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-24 4:28 a.m., Peter Zijlstra wrote:
> On Fri, Jun 21, 2024 at 02:34:35PM -0400, Liang, Kan wrote:
>>
>>
>> On 2024-06-20 12:16 p.m., Liang, Kan wrote:
>>>
>>>
>>> On 2024-06-20 3:44 a.m., Peter Zijlstra wrote:
>>>> On Tue, Jun 18, 2024 at 08:10:37AM -0700, kan.liang@linux.intel.com wrote:
>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>
>>>>> Different vendors may support different fields in EVENTSEL MSR, such as
>>>>> Intel would introduce new fields umask2 and eq bits in EVENTSEL MSR
>>>>> since Perfmon version 6. However, a fixed mask X86_RAW_EVENT_MASK is
>>>>> used to filter the attr.config.
>>>>>
>>>>
>>>>> @@ -1231,6 +1233,11 @@ static inline int x86_pmu_num_counters_fixed(struct pmu *pmu)
>>>>>  	return hweight64(hybrid(pmu, fixed_cntr_mask64));
>>>>>  }
>>>>>  
>>>>> +static inline u64 x86_pmu_get_event_config(struct perf_event *event)
>>>>> +{
>>>>> +	return event->attr.config & hybrid(event->pmu, config_mask);
>>>>> +}
>>>>
>>>> Seriously, we're going to be having such major event encoding
>>>> differences between cores on a single chip?
>>>
>>> For LNL, no. But ARL-H may have an event encoding differences.
>>> I will double check.
>>
>> There are two generations of e-core on ARL-H. The event encoding is
>> different.
>>
>> The new fields umask2 and eq bits are enumerated by CPUID.(EAX=23H,
>> ECX=0H):EBX. They are supported by CPU 11 but not CPU 12.
>>
>> CPU 11:
>>    0x00000023 0x00: eax=0x0000000f ebx=0x00000003 ecx=0x00000008
>> edx=0x00000000
>> CPU 12:
>>    0x00000023 0x00: eax=0x0000000b ebx=0x00000000 ecx=0x00000006
>> edx=0x00000000
>>
> 
> *groan*...
> 
> So we're going to be having 3 PMUs on that thing I suppose. Oh well.

Yes, 3 PMUs. 1 PMU For p-core. The other 2 PMUs are for two different
types of e-cores.

Thanks,
Kan


