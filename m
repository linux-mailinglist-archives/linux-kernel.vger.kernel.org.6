Return-Path: <linux-kernel+bounces-321424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC7D971A48
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B377F1F23AD3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFC61B86F7;
	Mon,  9 Sep 2024 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyUn2uu1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C441B81DD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886981; cv=none; b=Xq3r3fMV6OJ3rH2qZSltw3uduf+RYxwn2YbPV162Nu/DCUHSs2tEflxL8NSnNDyamFkzzS2cM/IRUNq0ziAcJFuYUbS3SC8lTO4Z7g7gj0cogC24XUTdj0Uwb3iK4Koa/y9wlaVuOqlxNZI23yThBjVGk10AuPbHZ3K2yrnvGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886981; c=relaxed/simple;
	bh=JBqdlsCIKoMBFy7z9S2z1fl6qAminneCJYbvI2ku05A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LcO2ENLcufoZX7zAm/y+4p0tmcYo7UdOfw5DW85NygenYv77HoYAtszPJmzRWFbTwmcChn7EZSs3BoaPcKrfeyXmKKbVT602YEUD4LA+P8Z+rXn2kJujObU66vTEWhmwQPYBSc2wYjRSI5EYl4ooPTbQP65mm7C7WAxsQr/MS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyUn2uu1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725886980; x=1757422980;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=JBqdlsCIKoMBFy7z9S2z1fl6qAminneCJYbvI2ku05A=;
  b=ZyUn2uu17LPTKSRR7Wc2HadG/L1yCDE6yHn/Y9+el1hGRiwgAJ3FXPk5
   hVD3NLiRlnc9n6x9yrWUXojeDCy0o9TCyzThNXSVqxLO4fKD7u3XNF1qY
   vLP1mkDSoa7pNyQWcbEQuUSOxaXrm7AkdaSLmtVWNRxSr+frg6G5y5u2e
   MzWw34dXxlwJkjNeFBiMkpFxaXq3zeM/QgH3T66VlMxyfH7YMicvHiZNl
   +hiLf1bQQJghwNOEzJIFR4bZXZN9bryJoqjZtg62BHqFhnBITb0yUtpno
   8Fx2AJ1R+HRvm4Rf39iAuPdh4R192Tdh8FlfnU44SItOahLGC9s1qN40t
   g==;
X-CSE-ConnectionGUID: ejWaezVhQ/aO5ArW2irAxw==
X-CSE-MsgGUID: qolNbPaZQ8GOSrxMVN5IGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35928612"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="35928612"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 06:02:59 -0700
X-CSE-ConnectionGUID: jEkILrxRSrq42o6TfXDGlQ==
X-CSE-MsgGUID: yfF2DsvaTA27nVEU/6COzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="89951354"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 06:02:58 -0700
Received: from [10.212.55.50] (kliang2-mobl1.ccr.corp.intel.com [10.212.55.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 18D2D20CFEDA;
	Mon,  9 Sep 2024 06:02:56 -0700 (PDT)
Message-ID: <b9893f4f-c91e-4c83-b785-ad78dc2f67f5@linux.intel.com>
Date: Mon, 9 Sep 2024 09:02:56 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] perf/x86/rapl: Move the pmu allocation out of CPU
 hotplug
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 linux-kernel@vger.kernel.org
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-7-kan.liang@linux.intel.com>
 <88fa2064-c054-4833-872c-0cf5ff1e3609@amd.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <88fa2064-c054-4833-872c-0cf5ff1e3609@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dhananjay,

On 2024-09-09 5:26 a.m., Dhananjay Ugwekar wrote:
> Hello Kan,
> 
> On 8/2/2024 8:46 PM, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The rapl pmu just needs to be allocated once. It doesn't matter to be
>> allocated at each CPU hotplug, or the global init_rapl_pmus().
>>
>> Move the pmu allocation to the init_rapl_pmus(). So the generic hotplug
>> supports can be applied.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> ---
>>  arch/x86/events/rapl.c | 43 +++++++++++++++++++++++++++++-------------
>>  1 file changed, 30 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index b985ca79cf97..f8b6d504d03f 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -568,19 +568,8 @@ static int rapl_cpu_online(unsigned int cpu)
>>  	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>>  	int target;
>>  
>> -	if (!pmu) {
>> -		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
>> -		if (!pmu)
>> -			return -ENOMEM;
>> -
>> -		raw_spin_lock_init(&pmu->lock);
>> -		INIT_LIST_HEAD(&pmu->active_list);
>> -		pmu->pmu = &rapl_pmus->pmu;
>> -		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
>> -		rapl_hrtimer_init(pmu);
>> -
>> -		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
>> -	}
>> +	if (!pmu)
>> +		return -ENOMEM;
>>  
>>  	/*
>>  	 * Check if there is an online cpu in the package which collects rapl
>> @@ -673,6 +662,32 @@ static const struct attribute_group *rapl_attr_update[] = {
>>  	NULL,
>>  };
>>  
>> +static void __init init_rapl_pmu(void)
>> +{
>> +	struct rapl_pmu *pmu;
>> +	int cpu;
>> +
>> +	cpus_read_lock();
>> +
>> +	for_each_cpu(cpu, cpu_online_mask) {
>> +		pmu = cpu_to_rapl_pmu(cpu);
>> +		if (pmu)
>> +			continue;
>> +		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
>> +		if (!pmu)
>> +			continue;
>> +		raw_spin_lock_init(&pmu->lock);
>> +		INIT_LIST_HEAD(&pmu->active_list);
>> +		pmu->pmu = &rapl_pmus->pmu;
>> +		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
>> +		rapl_hrtimer_init(pmu);
>> +
>> +		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
>> +	}
>> +
>> +	cpus_read_unlock();
>> +}
>> +
>>  static int __init init_rapl_pmus(void)
>>  {
>>  	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
>> @@ -681,6 +696,8 @@ static int __init init_rapl_pmus(void)
>>  	if (!rapl_pmus)
>>  		return -ENOMEM;
>>  
>> +	init_rapl_pmu();
>> +
>>  	rapl_pmus->nr_rapl_pmu		= nr_rapl_pmu;
> 
> I feel there is one potential bug here, first we are calling init_rapl_pmu() --> cpu_to_rapl_pmu(cpu) --> "return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->pmus[rapl_pmu_idx] : NULL;"
> Then we are updating "rapl_pmus->nr_rapl_pmu = nr_rapl_pmu;". This makes the return check in cpu_to_rapl_pmu() ineffective as the rapl_pmus->nr_rapl_pmu value would be falsely zero. 
> 

Ah, right. A pmu will be allocated for each CPU rather than each socket.
A user wouldn't see a difference, but it wastes memory and may cause
memory leak.

I think we should move the init_rapl_pmu(); to the end of the function.

The patch set has been merged into Peter's perf/core branch. Do you want
to post a fix patch to address the issue?

Thanks,
Kan

> Please let me know if I'm missing something.
> 
> Thanks,
> Dhananjay
> 
>>  	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
>>  	rapl_pmus->pmu.attr_update	= rapl_attr_update;
> 

