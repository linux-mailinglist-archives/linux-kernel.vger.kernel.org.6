Return-Path: <linux-kernel+bounces-230821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A2091824E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78231B22586
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC83181D1E;
	Wed, 26 Jun 2024 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCzx7XBC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDE4181CE3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408332; cv=none; b=Ynu4AenloQuVCbv/tMTIh2/UQEBhbcks5PMIZtTLaUH1Al66sdFGoIWL76Ere7kUV0b+vEXIukfwX4ywY8FH0ZAZlv0WJTWWSsKZGkc4Pj8FIaaSChwRnBNRsEcyBSyDhmwTHyj/EQZfhf/qBt7TqwgB+hUWzar0hriT7EAGJnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408332; c=relaxed/simple;
	bh=fO1yxlrPin0T8o+N/crxs6lXgQyrPpjk/IHMXViLGhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dodlFZJr112mOGrztc2HgBR12rNaXrFMJfitwBn4oxiyqFJcJvP2u3+e4EvnXHI7QaIoWBi6OzDDPZgfblHfz575ysD3PfzLSuCdvcaGG4jgWD3/qKJgpXoZHCDUWlEU4qQ+fo13YhMUSFqGkDEV/ktqugKyVKw3MvKo0zTwFs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCzx7XBC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719408330; x=1750944330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fO1yxlrPin0T8o+N/crxs6lXgQyrPpjk/IHMXViLGhc=;
  b=NCzx7XBCMge0OP4kW+5KtgbMvXFUz5vpmV5H8Q+yojqXY9JVsp39fxYZ
   nGC1tI4jF06Lm8WLMNojz92b+CX/YSptZd66C8f3q7NDkKlohJCsUqgBh
   0EJeHdTcqW7AvM+wC5RxXsg6nU71zKt9c31ijwZu/0bYniITQXdhS4XbH
   ZAC1eXS2rFCGhHE8/IPD7NZQCdlxR4a6Ywg+AY07hOceghOzklOhBOQFC
   NXNPEG/ED//KSvvd/kWWhwOibEQIogdvpQ0fHiow4bQLBQXXJIBfSG2AF
   RXQWUkGMUsSWuVTZj8i48rrsXnUVU1aauN3h1gHVMhLspQtagYkSBrPP7
   w==;
X-CSE-ConnectionGUID: Lg5wPkfUSFC5hxDPvqrmLQ==
X-CSE-MsgGUID: UX3BlVsgT2Sow9DULK4Szg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="12259260"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="12259260"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 06:25:30 -0700
X-CSE-ConnectionGUID: TA0bhTz/Ry6QUjLpPPaflQ==
X-CSE-MsgGUID: laX8ALI5SWm/YBo4NwM1eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="43971138"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 06:25:30 -0700
Received: from [10.212.45.60] (kliang2-mobl1.ccr.corp.intel.com [10.212.45.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4266120B5703;
	Wed, 26 Jun 2024 06:25:28 -0700 (PDT)
Message-ID: <e57cf98a-89c6-4913-99af-6a70e098f37b@linux.intel.com>
Date: Wed, 26 Jun 2024 09:25:27 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 07/13] perf/x86/intel: Support PERFEVTSEL extension
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@kernel.org, acme@kernel.org,
 namhyung@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20240625182256.291914-1-kan.liang@linux.intel.com>
 <20240625182256.291914-8-kan.liang@linux.intel.com>
 <CAP-5=fU4Mn0BhgS3n_aUmfamtD77d-VDhnZ1OoiRvXFrGJERCQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fU4Mn0BhgS3n_aUmfamtD77d-VDhnZ1OoiRvXFrGJERCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-06-25 9:34 p.m., Ian Rogers wrote:
> On Tue, Jun 25, 2024 at 11:22 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Two new fields (the unit mask2, and the equal flag) are added in the
>> IA32_PERFEVTSELx MSRs. They can be enumerated by the CPUID.23H.0.EBX.
>>
>> Update the config_mask in x86_pmu and x86_hybrid_pmu for the true layout
>> of the PERFEVTSEL.
>> Expose the new formats into sysfs if they are available. The umask
>> extension reuses the same format attr name "umask" as the previous
>> umask. Add umask2_show to determine/display the correct format
>> for the current machine.
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c      | 69 +++++++++++++++++++++++++++++--
>>  arch/x86/include/asm/perf_event.h |  4 ++
>>  2 files changed, 69 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 23e074fd25e1..9d50e1049e30 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4632,8 +4632,55 @@ PMU_FORMAT_ATTR(pc,      "config:19"     );
>>  PMU_FORMAT_ATTR(any,   "config:21"     ); /* v3 + */
>>  PMU_FORMAT_ATTR(inv,   "config:23"     );
>>  PMU_FORMAT_ATTR(cmask, "config:24-31"  );
>> -PMU_FORMAT_ATTR(in_tx,  "config:32");
>> -PMU_FORMAT_ATTR(in_tx_cp, "config:33");
>> +PMU_FORMAT_ATTR(in_tx,  "config:32"    );
>> +PMU_FORMAT_ATTR(in_tx_cp, "config:33"  );
> 
> nit: It seems unfortunate these 2 lines change for the sake of spaces
> before the ')'. Perhaps leave unchanged.

The two lines don't follow the existing formats. It kind of ugly when
reading the code.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c#n4569

I just want to make the format consistent to facilitate the future code
review.

Thanks,
Kan

> 
> Thanks,
> Ian
> 
>> +PMU_FORMAT_ATTR(eq,    "config:36"     ); /* v6 + */
>> +
>> +static ssize_t umask2_show(struct device *dev,
>> +                          struct device_attribute *attr,
>> +                          char *page)
>> +{
>> +       u64 mask = hybrid(dev_get_drvdata(dev), config_mask) & ARCH_PERFMON_EVENTSEL_UMASK2;
>> +
>> +       if (mask == ARCH_PERFMON_EVENTSEL_UMASK2)
>> +               return sprintf(page, "config:8-15,40-47\n");
>> +
>> +       /* Roll back to the old format if umask2 is not supported. */
>> +       return sprintf(page, "config:8-15\n");
>> +}
>> +
>> +static struct device_attribute format_attr_umask2  =
>> +               __ATTR(umask, 0444, umask2_show, NULL);
>> +
>> +static struct attribute *format_evtsel_ext_attrs[] = {
>> +       &format_attr_umask2.attr,
>> +       &format_attr_eq.attr,
>> +       NULL
>> +};
>> +
>> +static umode_t
>> +evtsel_ext_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>> +{
>> +       struct device *dev = kobj_to_dev(kobj);
>> +       u64 mask;
>> +
>> +       /*
>> +        * The umask and umask2 have different formats but share the
>> +        * same attr name. In update mode, the previous value of the
>> +        * umask is unconditionally removed before is_visible. If
>> +        * umask2 format is not enumerated, it's impossible to roll
>> +        * back to the old format.
>> +        * Does the check in umask2_show rather than is_visible.
>> +        */
>> +       if (i == 0)
>> +               return attr->mode;
>> +
>> +       mask = hybrid(dev_get_drvdata(dev), config_mask);
>> +       if (i == 1)
>> +               return (mask & ARCH_PERFMON_EVENTSEL_EQ) ? attr->mode : 0;
>> +
>> +       return 0;
>> +}
>>
>>  static struct attribute *intel_arch_formats_attr[] = {
>>         &format_attr_event.attr,
>> @@ -4786,8 +4833,14 @@ static inline bool intel_pmu_broken_perf_cap(void)
>>
>>  static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
>>  {
>> -       unsigned int sub_bitmaps = cpuid_eax(ARCH_PERFMON_EXT_LEAF);
>> -       unsigned int eax, ebx, ecx, edx;
>> +       unsigned int sub_bitmaps, eax, ebx, ecx, edx;
>> +
>> +       cpuid(ARCH_PERFMON_EXT_LEAF, &sub_bitmaps, &ebx, &ecx, &edx);
>> +
>> +       if (ebx & ARCH_PERFMON_EXT_UMASK2)
>> +               pmu->config_mask |= ARCH_PERFMON_EVENTSEL_UMASK2;
>> +       if (ebx & ARCH_PERFMON_EXT_EQ)
>> +               pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
>>
>>         if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
>>                 cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
>> @@ -5810,6 +5863,12 @@ static struct attribute_group group_format_extra_skl = {
>>         .is_visible = exra_is_visible,
>>  };
>>
>> +static struct attribute_group group_format_evtsel_ext = {
>> +       .name       = "format",
>> +       .attrs      = format_evtsel_ext_attrs,
>> +       .is_visible = evtsel_ext_is_visible,
>> +};
>> +
>>  static struct attribute_group group_default = {
>>         .attrs      = intel_pmu_attrs,
>>         .is_visible = default_is_visible,
>> @@ -5823,6 +5882,7 @@ static const struct attribute_group *attr_update[] = {
>>         &group_caps_lbr,
>>         &group_format_extra,
>>         &group_format_extra_skl,
>> +       &group_format_evtsel_ext,
>>         &group_default,
>>         NULL,
>>  };
>> @@ -6042,6 +6102,7 @@ static const struct attribute_group *hybrid_attr_update[] = {
>>         &group_caps_gen,
>>         &group_caps_lbr,
>>         &hybrid_group_format_extra,
>> +       &group_format_evtsel_ext,
>>         &group_default,
>>         &hybrid_group_cpus,
>>         NULL,
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index 400c909b8658..91b73571412f 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -32,6 +32,8 @@
>>  #define ARCH_PERFMON_EVENTSEL_INV                      (1ULL << 23)
>>  #define ARCH_PERFMON_EVENTSEL_CMASK                    0xFF000000ULL
>>  #define ARCH_PERFMON_EVENTSEL_BR_CNTR                  (1ULL << 35)
>> +#define ARCH_PERFMON_EVENTSEL_EQ                       (1ULL << 36)
>> +#define ARCH_PERFMON_EVENTSEL_UMASK2                   (0xFFULL << 40)
>>
>>  #define INTEL_FIXED_BITS_MASK                          0xFULL
>>  #define INTEL_FIXED_BITS_STRIDE                        4
>> @@ -185,6 +187,8 @@ union cpuid10_edx {
>>   * detection/enumeration details:
>>   */
>>  #define ARCH_PERFMON_EXT_LEAF                  0x00000023
>> +#define ARCH_PERFMON_EXT_UMASK2                        0x1
>> +#define ARCH_PERFMON_EXT_EQ                    0x2
>>  #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT      0x1
>>  #define ARCH_PERFMON_NUM_COUNTER_LEAF          0x1
>>
>> --
>> 2.35.1
>>

