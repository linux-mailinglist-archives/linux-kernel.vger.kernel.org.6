Return-Path: <linux-kernel+bounces-222993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BB6910B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF33289DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B801B1513;
	Thu, 20 Jun 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ok593mI1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234103BB50
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899791; cv=none; b=q/hsniBWFs8/Bly4VhjxbFTnyQFQB63X+yut92YD/NYB9iJU8DjrwBYK317nFKlBoO+wjUPXBfStShUrzAZEgysc4yxNOUwdRzhwZ7ZHE0p5DiOp8uQFk1aoi9dW9NHTN5Bo8cyfovQ13o184+Vs8DolzW+HbNdJsAE0BI4iFVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899791; c=relaxed/simple;
	bh=sJ+GyPLEyonouArm6Ms4v+PbxCZjrYA1AmFNnZ461R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWk/YIvmbwHUJaWG8Se3WiiSH99X4cm2osHFp3d4maKey8igM9ontvugxVJ7xE9Uo5iANm2rqg4eWOkZ/KdPMdM9dcERsFVJ2npPQXoGbV/dLAxec9l3fHqyzk2A2Jzi8hxeobl3tRF5Hv7BebNs3pU8KhO31rnV2re1VA4cBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ok593mI1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718899790; x=1750435790;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sJ+GyPLEyonouArm6Ms4v+PbxCZjrYA1AmFNnZ461R4=;
  b=Ok593mI1e8gZ4yRgp7DWPTrBwSOKgIA8ydwCZrVr1h7TJDD8r8sVjd7c
   gUIwIYJ6lblxkMpAFU0+MC89/7H1eLC/iAWbYoD8o5ShIWGGlZhInbzmL
   JUyChmHWlUKmOJ6gQlfuQZIzhpM0APAN1jXXibiDuYeAq4aEJGeoSnMz8
   18nOWHRrKzUmDoYXQJawyINqA7Pm7yQnRZVPtzKZm153viCiDvZyXITQo
   2D+zb1EuWZd0kfns/h0SVS6iAcUGK7RS5uF6M/sMBr/cLunEqDGdNpy4U
   5tOutMFp4xQHO6Z7Qbn97s98Wkm/M3qAmFpVmAa7znh4dz+NXPR0AG/Tq
   A==;
X-CSE-ConnectionGUID: M9KpX1QJR7eTwLGvPnfA9w==
X-CSE-MsgGUID: VQEEaSUXRMa5Yr/47kP5gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="19768525"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="19768525"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:09:46 -0700
X-CSE-ConnectionGUID: BLFtV6XxTRWCVkzKne5x3w==
X-CSE-MsgGUID: CWve3jpwQuWBUVGD21jQRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="47248307"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:09:46 -0700
Received: from [10.212.43.222] (kliang2-mobl1.ccr.corp.intel.com [10.212.43.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C877820B5703;
	Thu, 20 Jun 2024 09:09:44 -0700 (PDT)
Message-ID: <62e2dfd9-24e3-4fb6-b116-8c4238e1946a@linux.intel.com>
Date: Thu, 20 Jun 2024 12:09:43 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 04/12] perf/x86/intel: Support new data source for
 Lunar Lake
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-5-kan.liang@linux.intel.com>
 <20240620073426.GR31592@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240620073426.GR31592@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-20 3:34 a.m., Peter Zijlstra wrote:
> On Tue, Jun 18, 2024 at 08:10:36AM -0700, kan.liang@linux.intel.com wrote:
> 
>> @@ -77,7 +86,7 @@ union intel_x86_pebs_dse {
>>  #define SNOOP_NONE_MISS (P(SNOOP, NONE) | P(SNOOP, MISS))
>>  
>>  /* Version for Sandy Bridge and later */
>> -static u64 pebs_data_source[] = {
>> +static u64 pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX] = {
>>  	P(OP, LOAD) | P(LVL, MISS) | LEVEL(L3) | P(SNOOP, NA),/* 0x00:ukn L3 */
>>  	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),  /* 0x01: L1 local */
>>  	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE), /* 0x02: LFB hit */
>> @@ -173,6 +182,40 @@ void __init intel_pmu_pebs_data_source_cmt(void)
>>  	__intel_pmu_pebs_data_source_cmt(pebs_data_source);
>>  }
>>  
>> +/* Version for Lunar Lake p-core and later */
>> +static u64 lnc_pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX] = {
> 
> Comment and naming are inconsistent, please lion-cove and lnc
> 
>> +	P(OP, LOAD) | P(LVL, MISS) | LEVEL(L3) | P(SNOOP, NA),	/* 0x00: ukn L3 */
>> +	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),	/* 0x01: L1 hit */
>> +	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),	/* 0x02: L1 hit */
>> +	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE),	/* 0x03: LFB/L1 Miss Handling Buffer hit */
>> +	0,							/* 0x04: Reserved */
>> +	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, NONE),	/* 0x05: L2 Hit */
>> +	OP_LH | LEVEL(L2_MHB) | P(SNOOP, NONE),			/* 0x06: L2 Miss Handling Buffer Hit */
>> +	0,							/* 0x07: Reserved */
>> +	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, NONE),	/* 0x08: L3 Hit */
>> +	0,							/* 0x09: Reserved */
>> +	0,							/* 0x0a: Reserved */
>> +	0,							/* 0x0b: Reserved */
>> +	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOPX, FWD),	/* 0x0c: L3 Hit Snoop Fwd */
>> +	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM),	/* 0x0d: L3 Hit Snoop HitM */
>> +	0,							/* 0x0e: Reserved */
>> +	P(OP, LOAD) | P(LVL, MISS) | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM),	/* 0x0f: L3 Miss Snoop HitM */
>> +	OP_LH | LEVEL(MSC) | P(SNOOP, NONE),			/* 0x10: Memory-side Cache Hit */
>> +	OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, NONE), /* 0x11: Local Memory Hit */
>> +};
>> +
>> +void __init intel_pmu_pebs_data_source_lnl(void)
>> +{
>> +	u64 *data_source;
>> +
>> +	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].pebs_data_source;
>> +	memcpy(data_source, lnc_pebs_data_source, sizeof(lnc_pebs_data_source));
>> +
>> +	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX].pebs_data_source;
>> +	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
>> +	__intel_pmu_pebs_data_source_cmt(data_source);
>> +}
>> +
>>  static u64 precise_store_data(u64 status)
>>  {
>>  	union intel_x86_pebs_dse dse;
>> @@ -264,7 +307,7 @@ static u64 __adl_latency_data_small(struct perf_event *event, u64 status,
>>  
>>  	WARN_ON_ONCE(hybrid_pmu(event->pmu)->pmu_type == hybrid_big);
>>  
>> -	dse &= PERF_PEBS_DATA_SOURCE_MASK;
>> +	dse &= PERF_PEBS_DATA_SOURCE_GRT_MASK;
>>  	val = hybrid_var(event->pmu, pebs_data_source)[dse];
>>  
>>  	pebs_set_tlb_lock(&val, tlb, lock);
>> @@ -300,6 +343,45 @@ u64 mtl_latency_data_small(struct perf_event *event, u64 status)
>>  					dse.mtl_fwd_blk);
>>  }
>>  
>> +u64 lnl_latency_data(struct perf_event *event, u64 status)
>> +{
>> +	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
>> +	union intel_x86_pebs_dse dse;
>> +	union perf_mem_data_src src;
>> +	u64 val;
>> +
>> +	if (pmu->pmu_type == hybrid_small)
>> +		return mtl_latency_data_small(event, status);
> 
> argh,.. can you please go and rename this mtl_small nonsense to .. /me
> googles.. crestmont / crm ?
> 
> Oh gawd, and the adl_small things to gracemont / gcm ?

Sure, I will add a cleanup patch to use the specific code name.

Thank,
Kan

> 
>> +
> 	return lnc_latency_data();
> }
> 
> 
> u64 lnc_latency_data()
> {
>> +	dse.val = status;
>> +
>> +	/* LNC core latency data */
>> +	val = hybrid_var(event->pmu, pebs_data_source)[status & PERF_PEBS_DATA_SOURCE_MASK];
>> +	if (!val)
>> +		val = P(OP, LOAD) | LEVEL(NA) | P(SNOOP, NA);
>> +
>> +	if (dse.lnc_stlb_miss)
>> +		val |= P(TLB, MISS) | P(TLB, L2);
>> +	else
>> +		val |= P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
>> +
>> +	if (dse.lnc_locked)
>> +		val |= P(LOCK, LOCKED);
>> +
>> +	if (dse.lnc_data_blk)
>> +		val |= P(BLK, DATA);
>> +	if (dse.lnc_addr_blk)
>> +		val |= P(BLK, ADDR);
>> +	if (!dse.lnc_data_blk && !dse.lnc_addr_blk)
>> +		val |= P(BLK, NA);
>> +
>> +	src.val = val;
>> +	if (event->hw.flags & PERF_X86_EVENT_PEBS_ST_HSW)
>> +		src.mem_op = P(OP, STORE);
>> +
>> +	return src.val;
>> +}
> 

