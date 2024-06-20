Return-Path: <linux-kernel+bounces-223019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB5C910BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918441F21574
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00491CD3D;
	Thu, 20 Jun 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLc65xT4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2AE1AD48C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900267; cv=none; b=I2AxCdaKTDn8Mm4uyZT3pbrZ3DvUMHj90gslV2T2E0Iosko9YxhbKvwUgswYDWyB44XWo1wH8s+HbeMyaL2ICN7629T5gQsNy9u14wHcz+77uFLhUntjLjya1lBpxALL6iKhuSb4w+lHRD5H/NwFz4pRwAc05ZIOa8vVfdz3Pu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900267; c=relaxed/simple;
	bh=OB7U7lqMLVcERbuFIMmlZujrMO1sCqLLsyifTmFy0QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYBb1zJJJQH/lgrnA/+I4bJOJ4D9gMLBun86Jox2Sf9M2adbkzzgLmKZOqReqXXHgAkZ+ihmshYbl8mIaXOz8BfhC+Dk5Cr5n6sWaaLdP8BtqM2upAkQS7ETt5fQCL9GHd07hTQdQDGQ6vnmBtnYPXP+O3FUPaJcMCkyrxHIWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLc65xT4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718900266; x=1750436266;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OB7U7lqMLVcERbuFIMmlZujrMO1sCqLLsyifTmFy0QQ=;
  b=RLc65xT4CObI7p7wYP92bY5pevH7MAQC5RU7SwPMFRlKjaH7JuoVfVRd
   G9M33NhDnhN6wb4ac3mU0Rzv+/QFkeG8MOxZ305Nfbkk7CFbX2AQdejGR
   lQwhg1KlBaKAumVSLutuuhbb9h+btxJnsvUpE7LlPC1zgYcb7YD2WoTq0
   W03DijEOPahpyZFboVAyMBcIe7YKbWRPreQwOcLf/C+e+/07WXUYRlHBj
   fj5VnnLRFxTET0ZKykpwWO+wuYgryBbXdYQqbP86O8zDvhhFvayeMVv+p
   ofUPvJSv3GnUy5xsXUechg81dW74JPlI7XPS71kuuQGEZMr/TW1FfyI9s
   g==;
X-CSE-ConnectionGUID: 2Iueos+8T22j5593fY7uTQ==
X-CSE-MsgGUID: mUr5wFIGTSyRb+Qaff1P+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="41299767"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="41299767"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:17:45 -0700
X-CSE-ConnectionGUID: vPkJ9EWwS6yjslZYhtwXqA==
X-CSE-MsgGUID: vlgl6N+4QYKUTNSogEf+Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42198624"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:17:45 -0700
Received: from [10.212.43.222] (kliang2-mobl1.ccr.corp.intel.com [10.212.43.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id CFFB820B5703;
	Thu, 20 Jun 2024 09:17:43 -0700 (PDT)
Message-ID: <2cc9a843-a532-49b1-9d53-b1544ccb740e@linux.intel.com>
Date: Thu, 20 Jun 2024 12:17:42 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 07/12] perf/x86/intel: Support Perfmon MSRs
 aliasing
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-8-kan.liang@linux.intel.com>
 <20240620080224.GT31592@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240620080224.GT31592@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-20 4:02 a.m., Peter Zijlstra wrote:
> On Tue, Jun 18, 2024 at 08:10:39AM -0700, kan.liang@linux.intel.com wrote:
>> @@ -6179,6 +6181,11 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs)
>>  	}
>>  }
>>  
>> +static inline int intel_pmu_addr_offset(int index, bool eventsel)
>> +{
>> +	return MSR_IA32_PMC_STEP * index;
>> +}
> 
> This should have v6 in the name or somesuch... no?

Sure, I will add V6 in the name.

Thanks,
Kan
> 
>>  static const struct { enum hybrid_pmu_type id; char *name; } intel_hybrid_pmu_type_map[] __initconst = {
>>  	{ hybrid_small, "cpu_atom" },
>>  	{ hybrid_big, "cpu_core" },
>> @@ -7153,6 +7160,14 @@ __init int intel_pmu_init(void)
>>  		pr_cont("full-width counters, ");
>>  	}
>>  
>> +	/* Support V6+ MSR Aliasing */
>> +	if (x86_pmu.version >= 6) {
>> +		x86_pmu.perfctr = MSR_IA32_PMC_GP0_CTR;
>> +		x86_pmu.eventsel = MSR_IA32_PMC_GP0_CFG_A;
>> +		x86_pmu.fixedctr = MSR_IA32_PMC_FX0_CTR;
>> +		x86_pmu.addr_offset = intel_pmu_addr_offset;
>> +	}

