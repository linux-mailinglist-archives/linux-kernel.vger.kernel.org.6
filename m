Return-Path: <linux-kernel+bounces-561522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD538A61304
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A3F4605F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77EF1FFC72;
	Fri, 14 Mar 2025 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1qZMQNZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405D1FF61D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960120; cv=none; b=q0uNRz94TVjmU5KCFgfqeelpYGy0KQiJpKJpWfa2KgeMW/DLGwH6IQhtf/dKCHYXzd1T9I0oLp9j1GG19wiFFYohYgIRGKrakj0xbC0naXnZjHrn0Gj0chwZQJONyNZ+TWkErlUGbaD5516HxqVTq0TSSzvWyIvxc5vv/zXX0z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960120; c=relaxed/simple;
	bh=iKTuZJTE+KOZphKhhfb1L14NMcccFoeqdtV8+BiiodU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKsaT4H1yWtD5UjgWq9c9f7iFnVvNMbdmwFkR5qU51/3WTbq1aSHWY2QoSaNOAO6NiFboJHNu3++2L2ZYCwTLMWN5SW/DEmOw25mrbi0dwpqaXXhsHm+mPIYWMOGtMSSqUGc2YV18hCsduDcMKxW90DLr14y+NNJLY18gZXDSJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1qZMQNZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741960118; x=1773496118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iKTuZJTE+KOZphKhhfb1L14NMcccFoeqdtV8+BiiodU=;
  b=l1qZMQNZdKAgVWj4t3FUgrFPnIj0GVxwu0+avuQVUa5Cd1nPVOi8CwDP
   pMyhv5eOJa4C/ik15JFyCXYUOCCk6MRVbJ+gSdxdJrLRfvz1hflzr7Map
   1dz+yBwF/qn1zwXEkBxEUUUrolL+zqX4xEGX8yyeqo+y+r4iHw4eknyuJ
   BfHV0MWTDsLlW9MeraSp0njMbKj1RJdMA+JK4TpV0aDF+3Nx1YQ1ptL6I
   cPLuFCp0S1FFyWrCdpKer8qN3rZo751nHvRP+ZtmTbsrKSx5GvA593+FT
   YX2EHnH1t7Bdf8Ue5ZcZuCMt4CEna1vw/kEdREHpM7K2cgzqCtSxHcYBI
   Q==;
X-CSE-ConnectionGUID: b9m5skBQQ9mXCZYoi9WRgw==
X-CSE-MsgGUID: AOVIVs0xQJSomuzgep0DaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="53317295"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="53317295"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:48:38 -0700
X-CSE-ConnectionGUID: oq6+DxtGTIGecTt7LyqniA==
X-CSE-MsgGUID: LpO4Vu05R6CJe+QDXz6l1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="144471643"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:48:38 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6DF3A20B5736;
	Fri, 14 Mar 2025 06:48:36 -0700 (PDT)
Message-ID: <5c6b52ec-e903-42be-aa57-675abc350241@linux.intel.com>
Date: Fri, 14 Mar 2025 09:48:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] perf/x86/intel: Support auto counter reload
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
 linux-kernel@vger.kernel.org, eranian@google.com, thomas.falcon@intel.com
References: <20241010192844.1006990-1-kan.liang@linux.intel.com>
 <20241010192844.1006990-4-kan.liang@linux.intel.com>
 <20250314102031.GL19344@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250314102031.GL19344@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-03-14 6:20 a.m., Peter Zijlstra wrote:
> On Thu, Oct 10, 2024 at 12:28:44PM -0700, kan.liang@linux.intel.com wrote:
> 
>> @@ -4159,6 +4332,49 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  	return 0;
>>  }
>>  
>> +static void intel_pmu_update_acr_mask(struct cpu_hw_events *cpuc, int n, int *assign)
>> +{
>> +	struct perf_event *event;
>> +	int n0, i, off;
>> +
>> +	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
>> +		n0 = cpuc->n_events - cpuc->n_txn;
>> +	else
>> +		n0 = cpuc->n_events;
>> +
>> +	for (i = n0; i < n; i++) {
>> +		event = cpuc->event_list[i];
>> +		event->hw.config1 = 0;
>> +
>> +		/* Convert the group index into the counter index */
>> +		for_each_set_bit(off, (unsigned long *)&event->attr.config2, n - n0)
>> +			set_bit(assign[n0 + off], (unsigned long *)&event->hw.config1);
> 
> Atomic set_bit() is required?

I don't think so. Will change it to __set_bit().

> 
>> +	}
>> +}
>> +
>> +static int intel_pmu_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
>> +{
>> +	struct perf_event *event;
>> +	int ret = x86_schedule_events(cpuc, n, assign);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (cpuc->is_fake)
>> +		return ret;
>> +
>> +	event = cpuc->event_list[n - 1];
> 
> ISTR seeing this pattern before somewhere and then argued it was all
> sorts of broken. Why is it sane to look at the last event here?

The schedule_events() is invoked for only two cases, a new event or a
new group. Since the event_list[] is in enabled order, the last event
should be either the new event or the last event of the new group.

The is_acr_event_group() always checks the leader's flag. It doesn't
matter which event in the ACR group is used to do the check.

Checking the last event should be good enough to cover both cases.

> 
>> +	/*
>> +	 * The acr_mask(config2) is the event-enabling order.
>> +	 * Update it to the counter order after the counters are assigned.
>> +	 */
>> +	if (event && is_acr_event_group(event))
>> +		intel_pmu_update_acr_mask(cpuc, n, assign);
>> +
>> +	return 0;
>> +}
>> +
>> +
>>  /*
>>   * Currently, the only caller of this function is the atomic_switch_perf_msrs().
>>   * The host perf context helps to prepare the values of the real hardware for
>> @@ -5305,7 +5521,7 @@ static __initconst const struct x86_pmu intel_pmu = {
>>  	.set_period		= intel_pmu_set_period,
>>  	.update			= intel_pmu_update,
>>  	.hw_config		= intel_pmu_hw_config,
>> -	.schedule_events	= x86_schedule_events,
>> +	.schedule_events	= intel_pmu_schedule_events,
>>  	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
>>  	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
>>  	.fixedctr		= MSR_ARCH_PERFMON_FIXED_CTR0,
> 
> How about only setting that function if the PMU actually support ACR ?

Sure. I will also address the other comments which I didn't reply above
in the email.

Thanks,
Kan

