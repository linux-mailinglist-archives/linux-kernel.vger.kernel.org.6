Return-Path: <linux-kernel+bounces-288895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D2E954023
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D125A1C21F19
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464954F87;
	Fri, 16 Aug 2024 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bm4A4mme"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFAA2F46
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723780494; cv=none; b=Y3CxAK/8b4PXOKgafCmLWVNZpeEukkPDmNmt69X3BEUwnr297V3s0flNprqqmYEPNPPqa3rv54R3sEDAPBNkGPVLL0KN8cf7LNL2yxjykz8yamjmj/Lt6SAyse2HLxRJe6M8mFebUsfV+Nz1pB5R6arlm/6gwB0tuI0ISPC32AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723780494; c=relaxed/simple;
	bh=krzZdBRMXV9ChTWjAwupNhm8+KdogW+2Lfi5JeCU1uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6Bp1RBiU6JltQqYA/YAvoCU3iivBIbMkp1j3IRRRIbTZ8WLhm2kkyaCKRvTbb20OScq8MUadCiYUUll+Ai0V+2bDCSBAgZRwP6naO/far6+K3cv3OytYd+oAG3muXeSzfSXML0Al0p1rtxOBM8u4h0cAtl9e0OpYvqR/Kx1QUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bm4A4mme; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723780493; x=1755316493;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=krzZdBRMXV9ChTWjAwupNhm8+KdogW+2Lfi5JeCU1uk=;
  b=bm4A4mmeP7yLjgvGccJuBZnA8/kueGv6PQNo0Q1PV99zJtLoXFTS/VpM
   EAlNdyUwWhLoYtB3DQolx+DPA0VP46ewGVdAsjeu1U/3V+kwWkqOwmz/x
   oL9huBHCY95ysigSS1POUHBVFGMYaVT6txMZ1l1Ac/OTdTAxMWWVUGowH
   MFprV1wX/N0FeZxT569f8HbaM9Du0mmC1wGd/lZ0ebR03LPKZAfo8/+YN
   Zm5Oa6P8xpbaQCMaSAVMQ3YIBDPXmT0WglwEiR1FDtK9Mqfjfg6LVHI3U
   wdYaYgytOEFAOteCH2UdxRVp3heN9/nbPVciBFDfJBTk5V9UCCsn3YSAJ
   A==;
X-CSE-ConnectionGUID: DZ2Texv/TFiaZJrpLr0IwQ==
X-CSE-MsgGUID: WmxWIGE3RbmT1DaAvwqMZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="25867316"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="25867316"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 20:54:53 -0700
X-CSE-ConnectionGUID: uCuyz59yTWOp4MbYkjfXMQ==
X-CSE-MsgGUID: RdQVfUeSR1CiaCAOeegVDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="63741318"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 20:54:48 -0700
Message-ID: <2dc01150-3ffa-467a-ac39-39e8308e7331@linux.intel.com>
Date: Fri, 16 Aug 2024 11:54:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] perf/x86/intel: Support hybrid PMU with multiple atom
 uarchs
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
 <20240808140210.1666783-4-dapeng1.mi@linux.intel.com>
 <20240810215539.GG11646@noisy.programming.kicks-ass.net>
 <08671266-6daa-4bab-bea8-2a9fa6f0fdc3@linux.intel.com>
 <ZrmBMMSdvLPGlgEI@debian-scheme>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <ZrmBMMSdvLPGlgEI@debian-scheme>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/12/2024 11:27 AM, Zhenyu Wang wrote:
> On 2024.08.12 11:18:34 +0800, Mi, Dapeng wrote:
>> On 8/11/2024 5:55 AM, Peter Zijlstra wrote:
>>> On Thu, Aug 08, 2024 at 02:02:09PM +0000, Dapeng Mi wrote:
>>>>  arch/x86/events/intel/core.c | 24 +++++++++++++++++-------
>>>>  arch/x86/events/perf_event.h | 18 +++++++++++++++++-
>>>>  2 files changed, 34 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index 0c9c2706d4ec..b6429bc009c0 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -6218,6 +6227,7 @@ static inline int intel_pmu_v6_addr_offset(int index, bool eventsel)
>>>>  static const struct { enum hybrid_pmu_type id; char *name; } intel_hybrid_pmu_type_map[] __initconst = {
>>>>  	{ hybrid_small, "cpu_atom" },
>>>>  	{ hybrid_big, "cpu_core" },
>>>> +	{ hybrid_small2, "cpu_atom2" },
>>> This is awfully uninspired and quite terrible. How is one supposed to
>>> know which is which? A possibly better naming might be: hybrid_tiny,
>>> "cpu_lowpower" or whatever.
>> We have lots of discussion internally about the naming, but unfortunately
>> we can't come to a conclusion. The reason that we select "cpu_atom2" is
>> that it's generic enough and won't expose too much model specific
>> information, we can reuse it if there are similar platforms in the future.
>> But of course I admit the name is indeed uninspired and easy to cause
>> confusion.
>>
>> The other names which I ever discussed are "cpu_lp_soc", "cpu_soc" and
>> "cpu_atom_soc", but this name would expose some model specific architecture
>> information more or less, not sure which one is better. How is your opinion
>> on this?
>>
> Now I don't like to put 'soc' in name as it's specific for platform design
> e.g ARL-H, but pmu actually only cares about cpu type. Maybe "cpu_atom_lp"
> is good enough.

Synced with Kan, Andi and Zhenyu, all prefer to use the name
"cpu_lowpower". If no one objects it, it would be used as official name.


>
>>>>  };
>>>>  
>>>>  static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
>>>> @@ -6250,7 +6260,7 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
>>>>  							0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
>>>>  
>>>>  		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
>>>> -		if (pmu->pmu_type & hybrid_small) {
>>>> +		if (pmu->pmu_type & hybrid_small_all) {
>>>>  			pmu->intel_cap.perf_metrics = 0;
>>>>  			pmu->intel_cap.pebs_output_pt_available = 1;
>>>>  			pmu->mid_ack = true;
>>>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>>>> index 5d1677844e04..f7b55c909eff 100644
>>>> --- a/arch/x86/events/perf_event.h
>>>> +++ b/arch/x86/events/perf_event.h
>>>> @@ -668,6 +668,13 @@ enum {
>>>>  #define PERF_PEBS_DATA_SOURCE_GRT_MAX	0x10
>>>>  #define PERF_PEBS_DATA_SOURCE_GRT_MASK	(PERF_PEBS_DATA_SOURCE_GRT_MAX - 1)
>>>>  
>>>> +
>>>> +/*
>>>> + * CPUID.1AH.EAX[31:0] uniquely identifies the microarchitecture
>>>> + * of the core. Bits 31-24 indicates its core type (Core or Atom)
>>>> + * and Bits [23:0] indicates the native model ID of the core.
>>>> + * Core type and native model ID are defined in below enumerations.
>>>> + */
>>>>  enum hybrid_cpu_type {
>>>>  	HYBRID_INTEL_NONE,
>>>>  	HYBRID_INTEL_ATOM	= 0x20,
>>>> @@ -676,12 +683,21 @@ enum hybrid_cpu_type {
>>>>  
>>>>  #define X86_HYBRID_PMU_ATOM_IDX		0
>>>>  #define X86_HYBRID_PMU_CORE_IDX		1
>>>> +#define X86_HYBRID_PMU_ATOM2_IDX	2
>>>>  enum hybrid_pmu_type {
>>>>  	not_hybrid,
>>>>  	hybrid_small		= BIT(X86_HYBRID_PMU_ATOM_IDX),
>>>>  	hybrid_big		= BIT(X86_HYBRID_PMU_CORE_IDX),
>>>> +	hybrid_small2		= BIT(X86_HYBRID_PMU_ATOM2_IDX),
>>>> +	/* The belows are only used for matching */
>>>> +	hybrid_big_small	= hybrid_big | hybrid_small,
>>>> +	hybrid_small_all	= hybrid_small | hybrid_small2,
>>>> +	hybrid_big_small_arl_h	= hybrid_big | hybrid_small_all,
>>> Same complaint, how about:
>>>
>>> +	hybrid_tiny		= BIT(X86_HYBRID_PMU_TINY_IDX),
>>> 	hybrid_big_small	= hybrid_big | hybrid_small,
>>> +	hybrid_small_tiny	= hybrid_small | hybrid_tiny,
>>> +	hybrid_big_small_tiny	= hybrid_big_small | hybrid_tiny,
>> Sure. I would adjust the macro name base on the above discussed final name.
>> Thanks.
>>
>>
>>>
>>>> +};
>>>>  
>>>> -	hybrid_big_small	= hybrid_big | hybrid_small, /* only used for matching */
>>>> +enum atom_native_id {
>>>> +	cmt_native_id           = 0x2,  /* Crestmont */
>>>> +	skt_native_id           = 0x3,  /* Skymont */
>>>>  };
>>>>  
>>>>  struct x86_hybrid_pmu {
>>>> -- 
>>>> 2.40.1
>>>>

