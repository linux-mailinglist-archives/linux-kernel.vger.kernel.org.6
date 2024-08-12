Return-Path: <linux-kernel+bounces-282513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF3194E52B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CBA1F220D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 02:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A33136348;
	Mon, 12 Aug 2024 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IA85hltW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6FB4D599
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723430683; cv=none; b=E5by39jcqVOz+Jn7F0t6qFJcRGw+O0rYaFvtF59EwgtnEfTe11UcLXpGQI1p+Yd0P9Ni/QMrr3rLQUVj+LbCJo/oYlLvdsZnIzGMQN0tb0CZDD6l8R0B5L3EGeczLKdGZaPgxStLJL8gPddyigU+tKJVhkvhycqgDwxaJ5iEBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723430683; c=relaxed/simple;
	bh=CGSY5rpUe9d331LaluQGYoomtPXholpDeXc5Bu36hJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ia6hQ5sTgbeUDIV1b5PROtKWr7dzvq+P+6lwUVE96gBnF3z3has8FMawV+sKhd2xMIeigwBf2m9t2Ig0oFC71bLsFe5qLuYLhxLlYhlqbC3vqjQe75/AjMljGdtR+gKvwaikxEbRajRwI/iSuiHF9cQ8OnMZAmOnj1SgHPpRlSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IA85hltW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723430682; x=1754966682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CGSY5rpUe9d331LaluQGYoomtPXholpDeXc5Bu36hJI=;
  b=IA85hltWvwX0zpBrmnuiJ/qebVwI13HMzY3mLcgYJM0w6JqxI6Ty1t22
   5jtLnZ9DPRixnP203upZj1qjiKyIGu3PuyoNhfI63GAwgZcMetOceTH4z
   WooMR0bTjwTdJyl1qvw+ZwBjqPxc70QIZzSiQHi4hMwXxklvYon3PJnHv
   YhY7eLrjaaafQKseI1joSfF2pY7LxyxZA6Mk19m/7eblKSeUe4CDG2USg
   hp33RgnEAeXUfTm/bUlfxP80Sp1MgisoGWObmJr+lSh7BTqO8iCraAMfA
   l6Xp5dA92znilHuJnD7JYh7U2Xr8Q+wpp252rccZxXvZ44qlQYG6EVSBp
   A==;
X-CSE-ConnectionGUID: LGP6WiAGRiyEGy1CHaC9jw==
X-CSE-MsgGUID: whiGbhBhRNy11u4RJ8UZ6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="25321816"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="25321816"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 19:44:41 -0700
X-CSE-ConnectionGUID: 5wz8gFwfSFa5A/8HkPuwuA==
X-CSE-MsgGUID: FfguGYxgR52QcKEQVK+sTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="88765625"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.203]) ([10.124.232.203])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 19:44:37 -0700
Message-ID: <2ec2023e-953f-4496-a27a-f604d1782243@linux.intel.com>
Date: Mon, 12 Aug 2024 10:44:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] perf/x86: Refine hybrid_pmu_type defination
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
 <20240808140210.1666783-2-dapeng1.mi@linux.intel.com>
 <20240810213535.GF11646@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20240810213535.GF11646@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/11/2024 5:35 AM, Peter Zijlstra wrote:
> On Thu, Aug 08, 2024 at 02:02:07PM +0000, Dapeng Mi wrote:
>> Use macros instead of magic number to define hybrid_pmu_type and remove
>> X86_HYBRID_NUM_PMUS since it's never used.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
>> ---
>>  arch/x86/events/perf_event.h | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index ac1182141bf6..5d1677844e04 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -674,19 +674,16 @@ enum hybrid_cpu_type {
>>  	HYBRID_INTEL_CORE	= 0x40,
>>  };
>>  
>> +#define X86_HYBRID_PMU_ATOM_IDX		0
>> +#define X86_HYBRID_PMU_CORE_IDX		1
> There wants to be some whitespace here..

Sure. Thanks.


>
>>  enum hybrid_pmu_type {
>>  	not_hybrid,
>> -	hybrid_small		= BIT(0),
>> -	hybrid_big		= BIT(1),
>> +	hybrid_small		= BIT(X86_HYBRID_PMU_ATOM_IDX),
>> +	hybrid_big		= BIT(X86_HYBRID_PMU_CORE_IDX),
>>  
>>  	hybrid_big_small	= hybrid_big | hybrid_small, /* only used for matching */
>>  };
>>  
>> -#define X86_HYBRID_PMU_ATOM_IDX		0
>> -#define X86_HYBRID_PMU_CORE_IDX		1
>> -
>> -#define X86_HYBRID_NUM_PMUS		2
>> -
>>  struct x86_hybrid_pmu {
>>  	struct pmu			pmu;
>>  	const char			*name;
>> -- 
>> 2.40.1
>>

