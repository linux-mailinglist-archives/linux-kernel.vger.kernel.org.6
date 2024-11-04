Return-Path: <linux-kernel+bounces-395500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE99BBECC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2144F1C21C6C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE201E5027;
	Mon,  4 Nov 2024 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erapmm2D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FF618EB1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752154; cv=none; b=mvni85aPTT7J9ZCVoeYJpVsZuyO39usNIJi7CZ/MirPbTSUg1rbSbcs4FRzYl5aILYVhBI/gyQ00Gc3YPT6ruOyQ+Ke42xx094QiY374Ej8FBgg7F6Y/HG7v/fEOBaIoHd0TBP08mX1MOs7AVpvvVaQ+29qZxSFTKvZr2Kdh6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752154; c=relaxed/simple;
	bh=Pi4KsuclGDnuuQ1HSilJDslmkD/MTGD/k1I3Biy6IYc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mMb/GbYHaBu3fvyApQBhqqxFYySPSqonX/cUJ+zI5ChkZxoiH6FWhnuWQzpx886DIR2AHpoweDEWjwcLEvKbrtlypTT9oT7jlEAXlLts1aOZD5+mgoE1aBn6zxZvJGg/Bsj0Qm1LvyV3wafvxYjblsj1MKrZhzWT2inGyDB9flo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erapmm2D; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730752152; x=1762288152;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Pi4KsuclGDnuuQ1HSilJDslmkD/MTGD/k1I3Biy6IYc=;
  b=erapmm2DHMDjJTSHclOY335MDcSEj5FhGjH0x7VIPAydutm6lZURsCuH
   ni6TksV1tSqAtKyEl5dSIe7zzkWcYMgVLPNX4xXYXICnJPmWzE+DaLXVF
   rYpNvhniw4aKo7Ych5whQMuwN1NK1N6qOSCvFm635iLKiw4FPGAzygg9q
   YohXSTJMfmDTsruriou91Abpi0Qz9p/NyD7ytJ+x4zCrbNX5piJpetoBN
   8jO3zSBh9dFXGfODCEsE6xJprT3inKpa4v8DlL0T1jMUn1dibHY7nXJYB
   wtQSMusGX7LaP989uRVMSdi26new5uEfGwMJlRL6GC6fOvfBAPN1HEsC3
   Q==;
X-CSE-ConnectionGUID: zJNAdj2RTEmgKGc0bmTbXA==
X-CSE-MsgGUID: 6FKqwBi/RhSQe6Bea70JuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="55872620"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="55872620"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 12:29:11 -0800
X-CSE-ConnectionGUID: rRrv1VTJSaSWyqK/TgFeVQ==
X-CSE-MsgGUID: TlRRJ5R+T0Kzvb3apV/L5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="114547324"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 12:29:11 -0800
Received: from [10.212.67.175] (kliang2-mobl1.ccr.corp.intel.com [10.212.67.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7116220B5703;
	Mon,  4 Nov 2024 12:29:10 -0800 (PST)
Message-ID: <25c7236e-d888-4cdc-be19-5e582220097d@linux.intel.com>
Date: Mon, 4 Nov 2024 15:29:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH V4] perf/x86/intel: Support RDPMC metrics clear
 mode
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: peterz@infradead.org, mingo@kernel.org, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 linux-kernel@vger.kernel.org
Cc: eranian@google.com, Andi Kleen <ak@linux.intel.com>
References: <20240926184558.3797290-1-kan.liang@linux.intel.com>
 <c6b2fd89-5f68-46cc-a249-0c354d8d391f@linux.intel.com>
Content-Language: en-US
In-Reply-To: <c6b2fd89-5f68-46cc-a249-0c354d8d391f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Ping. Could you please let me know if you have any comments.

Thanks,
Kan

On 2024-10-09 3:31 p.m., Liang, Kan wrote:
> Hi Peter,
> 
> Gentle ping. Please let me know if you have any comments.
> 
> Thanks,
> Kan
> 
> On 2024-09-26 2:45 p.m., kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The new RDPMC enhancement, metrics clear mode, is to clear the
>> PERF_METRICS-related resources as well as the fixed-function performance
>> monitoring counter 3 after the read is performed. It is available for
>> ring 3. The feature is enumerated by the
>> IA32_PERF_CAPABILITIES.RDPMC_CLEAR_METRICS[bit 19]. To enable the
>> feature, the IA32_FIXED_CTR_CTRL.METRICS_CLEAR_EN[bit 14] must be set.
>>
>> Two ways were considered to enable the feature.
>> - Expose a knob in the sysfs globally. One user may affect the
>>   measurement of other users when changing the knob. The solution is
>>   dropped.
>> - Introduce a new event format, metrics_clear, for the slots event to
>>   disable/enable the feature only for the current process. Users can
>>   utilize the feature as needed.
>> The latter solution is implemented in the patch.
>>
>> The current KVM doesn't support the perf metrics yet. For
>> virtualization, the feature can be enabled later separately.
>>
>> Update the document of perf metrics.
>>
>> Suggested-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Ian Rogers <irogers@google.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>
>> The original V4 can be found at
>> https://lore.kernel.org/lkml/20240731143835.771618-6-kan.liang@linux.intel.com/
>>
>> The patch was one of the PMU features in the LNL enabling patch set.
>> The other feature is now blocked. Send the patch separately.
>>
>>  arch/x86/events/intel/core.c         | 20 +++++++++++++++++++-
>>  arch/x86/events/perf_event.h         |  1 +
>>  arch/x86/include/asm/perf_event.h    |  4 ++++
>>  tools/perf/Documentation/topdown.txt |  9 +++++++--
>>  4 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 5182075e111b..342f8b1a2f93 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2816,6 +2816,9 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
>>  			return;
>>  
>>  		idx = INTEL_PMC_IDX_FIXED_SLOTS;
>> +
>> +		if (event->attr.config1 & INTEL_TD_CFG_METRIC_CLEAR)
>> +			bits |= INTEL_FIXED_3_METRICS_CLEAR;
>>  	}
>>  
>>  	intel_set_masks(event, idx);
>> @@ -4067,7 +4070,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  	 * is used in a metrics group, it too cannot support sampling.
>>  	 */
>>  	if (intel_pmu_has_cap(event, PERF_CAP_METRICS_IDX) && is_topdown_event(event)) {
>> -		if (event->attr.config1 || event->attr.config2)
>> +		/* The metrics_clear can only be set for the slots event */
>> +		if (event->attr.config1 &&
>> +		    (!is_slots_event(event) || (event->attr.config1 & ~INTEL_TD_CFG_METRIC_CLEAR)))
>> +			return -EINVAL;
>> +
>> +		if (event->attr.config2)
>>  			return -EINVAL;
>>  
>>  		/*
>> @@ -4676,6 +4684,8 @@ PMU_FORMAT_ATTR(in_tx,  "config:32"	);
>>  PMU_FORMAT_ATTR(in_tx_cp, "config:33"	);
>>  PMU_FORMAT_ATTR(eq,	"config:36"	); /* v6 + */
>>  
>> +PMU_FORMAT_ATTR(metrics_clear,	"config1:0"); /* PERF_CAPABILITIES.RDPMC_METRICS_CLEAR */
>> +
>>  static ssize_t umask2_show(struct device *dev,
>>  			   struct device_attribute *attr,
>>  			   char *page)
>> @@ -4695,6 +4705,7 @@ static struct device_attribute format_attr_umask2  =
>>  static struct attribute *format_evtsel_ext_attrs[] = {
>>  	&format_attr_umask2.attr,
>>  	&format_attr_eq.attr,
>> +	&format_attr_metrics_clear.attr,
>>  	NULL
>>  };
>>  
>> @@ -4719,6 +4730,13 @@ evtsel_ext_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>  	if (i == 1)
>>  		return (mask & ARCH_PERFMON_EVENTSEL_EQ) ? attr->mode : 0;
>>  
>> +	/* PERF_CAPABILITIES.RDPMC_METRICS_CLEAR */
>> +	if (i == 2) {
>> +		union perf_capabilities intel_cap = hybrid(dev_get_drvdata(dev), intel_cap);
>> +
>> +		return intel_cap.rdpmc_metrics_clear ? attr->mode : 0;
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index 82c6f45ce975..31c2771545a6 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -624,6 +624,7 @@ union perf_capabilities {
>>  		u64	pebs_output_pt_available:1;
>>  		u64	pebs_timing_info:1;
>>  		u64	anythread_deprecated:1;
>> +		u64	rdpmc_metrics_clear:1;
>>  	};
>>  	u64	capabilities;
>>  };
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index 91b73571412f..e3b5e8e96fb3 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -41,6 +41,7 @@
>>  #define INTEL_FIXED_0_USER				(1ULL << 1)
>>  #define INTEL_FIXED_0_ANYTHREAD			(1ULL << 2)
>>  #define INTEL_FIXED_0_ENABLE_PMI			(1ULL << 3)
>> +#define INTEL_FIXED_3_METRICS_CLEAR			(1ULL << 2)
>>  
>>  #define HSW_IN_TX					(1ULL << 32)
>>  #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
>> @@ -372,6 +373,9 @@ static inline bool use_fixed_pseudo_encoding(u64 code)
>>  #define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_MEM_BOUND
>>  #define INTEL_TD_METRIC_NUM			8
>>  
>> +#define INTEL_TD_CFG_METRIC_CLEAR_BIT		0
>> +#define INTEL_TD_CFG_METRIC_CLEAR		BIT_ULL(INTEL_TD_CFG_METRIC_CLEAR_BIT)
>> +
>>  static inline bool is_metric_idx(int idx)
>>  {
>>  	return (unsigned)(idx - INTEL_PMC_IDX_METRIC_BASE) < INTEL_TD_METRIC_NUM;
>> diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
>> index ae0aee86844f..f36c8ca1dc53 100644
>> --- a/tools/perf/Documentation/topdown.txt
>> +++ b/tools/perf/Documentation/topdown.txt
>> @@ -280,8 +280,13 @@ with no longer interval than a few seconds
>>  
>>  	perf stat -I 1000 --topdown ...
>>  
>> -For user programs using RDPMC directly the counter can
>> -be reset explicitly using ioctl:
>> +Starting from the Lunar Lake p-core, a RDPMC metrics clear mode is
>> +introduced. The metrics and the fixed counter 3 are automatically
>> +cleared after the read is performed. It is recommended to always enable
>> +the mode. To enable the mode, the config1 of slots event is set to 1.
>> +
>> +On the previous platforms, for user programs using RDPMC directly, the
>> +counter has to be reset explicitly using ioctl:
>>  
>>  	ioctl(perf_fd, PERF_EVENT_IOC_RESET, 0);
>>  
> 


