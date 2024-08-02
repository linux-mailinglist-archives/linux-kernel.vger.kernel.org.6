Return-Path: <linux-kernel+bounces-273042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE819463EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53381C2168C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448FA41C71;
	Fri,  2 Aug 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFYfBTH/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81A1ABED4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627073; cv=none; b=DGWLzLEixbaziOWwjEbiMn9zHD270DDzeLRv3Ws/M7JGat48b542wNhseAaYYG3n/kgoMkH458yzudXEMYMKYj54XjFiN1erhG9JEaROmdKTqd6fRtVjfjFvq+h5lAZ6DdUCLjkPHrVJCysVvs2yCXKjVbbSpTVBzDdFNv5QWPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627073; c=relaxed/simple;
	bh=aXWIEmfqM1zomJZ8ZlmZ/PaBc+fZQ9lCcB76/qCTB14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ai756ohUKadQ0TICBoV0asRd8MdquW8kwrKJDw1plcFm7QwQ5be+F0MIn7F1bW4qH6A3d1ouGgduut/Yy6xdQMrcj1c5Mf1c6M91K+KEDs5Pd02HNHoudTyajCGn+5IAwDFkJPZ98rI2K+68CE4o5JhIQ5Ql/hcEJlbeQQqHomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFYfBTH/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722627071; x=1754163071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aXWIEmfqM1zomJZ8ZlmZ/PaBc+fZQ9lCcB76/qCTB14=;
  b=TFYfBTH/e9szRgQ6SiBEylPO1v1LpUA7OhnajcDgxKuoGCJfg2R1XRcb
   93hZSagoZSsVtJaeSwucO0raN30aXwRSL/Md/EoLaHKtDV7mT+3vtYiAr
   SMB0kptt5z5rcwivGy0JFacZ164Rd+t94b6KpKUtmaPc9UoalfAeaY2uG
   1z2ZwohsZ4FrWP2Oz+nfe4PTE7ERIfqpMJ81k814Hoy0USdVBdh+jJInl
   /8C7J6SBn5h2MqBwTkpIMoCZuxBlPl59R5dA7bTfr2c6YHoNkTboIRxTI
   7bG18VT3XIgqjinxUoaGeoppOv9NCPmzvIJP6Zvl+PXYPovPQfcXcZ3Dg
   A==;
X-CSE-ConnectionGUID: C/WEFM/vTcOJQCJBSTLeSw==
X-CSE-MsgGUID: qGE6NpBCTNuRxz7Du6+VKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20240834"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20240834"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 12:31:11 -0700
X-CSE-ConnectionGUID: QYv1rEqqQ2yd3kiKViN39w==
X-CSE-MsgGUID: NWrp7pzIT02WNb0n1i/lLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="59851781"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 12:31:11 -0700
Received: from [10.212.17.69] (kliang2-mobl1.ccr.corp.intel.com [10.212.17.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 115EA20B5782;
	Fri,  2 Aug 2024 12:31:08 -0700 (PDT)
Message-ID: <1fc7dc5f-c3fa-4993-b46d-8261a6e4b79d@linux.intel.com>
Date: Fri, 2 Aug 2024 15:31:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/core: Optimize event reschedule for a PMU
To: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>,
 Mingwei Zhang <mizhang@google.com>
References: <20240731000607.543783-1-namhyung@kernel.org>
 <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240802183841.GG37996@noisy.programming.kicks-ass.net>
 <20240802184350.GA12673@noisy.programming.kicks-ass.net>
 <20240802185023.GB12673@noisy.programming.kicks-ass.net>
 <20240802191123.GC12673@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240802191123.GC12673@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-02 3:11 p.m., Peter Zijlstra wrote:
> On Fri, Aug 02, 2024 at 08:50:23PM +0200, Peter Zijlstra wrote:
>> On Fri, Aug 02, 2024 at 08:43:50PM +0200, Peter Zijlstra wrote:
>>> On Fri, Aug 02, 2024 at 08:38:41PM +0200, Peter Zijlstra wrote:
>>>> On Fri, Aug 02, 2024 at 02:30:19PM -0400, Liang, Kan wrote:
>>>>>> @@ -2792,7 +2833,14 @@ static int  __perf_install_in_context(void *info)
>>>>>>  	if (reprogram) {
>>>>>>  		ctx_sched_out(ctx, EVENT_TIME);
>>>
>>> Clearly I should read better...
>>>
>>>>>>  		add_event_to_ctx(event, ctx);
>>>>>> -		ctx_resched(cpuctx, task_ctx, get_event_type(event));
>>>>>> +		if (ctx->nr_events == 1) {
>>>>>> +			/* The first event needs to set ctx->is_active. */
>>>>>> +			ctx_resched(cpuctx, task_ctx, NULL, get_event_type(event));
>>>>>> +		} else {
>>>>>> +			ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
>>>>>> +				    get_event_type(event));
>>>>>> +			ctx_sched_in(ctx, EVENT_TIME);
>>>>>
>>>>> The changelog doesn't mention the time difference much. As my
>>>>> understanding, the time is shared among PMUs in the same ctx.
>>>>> When perf does ctx_resched(), the time is deducted.
>>>>> There is no problem to stop and restart the global time when perf
>>>>> re-schedule all PMUs.
>>>>> But if only one PMU is re-scheduled while others are still running, it
>>>>> may be a problem to stop and restart the global time. Other PMUs will be
>>>>> impacted.
>>>
>>> So yeah, this stops ctx time but not all PMUs.
>>
>> But isn't this already the case? We don't have perf_ctx_disable() here
>> currently. 
>>
>> Bah, this heat is melting my brain.
> 
> I think all it wants is to update time and ensure the added event and
> the resched all use the same time, which could be done differently.
>

Yes. I think that's what the current code tries to do.
But it seems the current code doesn't do it clearly either.

ctx_sched_out(ctx, EVENT_TIME); <-- disable the time
ctx_resched()
    perf_ctx_disable()          <-- disable all PMUs

    perf_event_sched_in()
        ctx_sched_in()          <-- enable the time
    perf_ctx_enable()           <-- enable all PMUs

I think the ctx_sched_out(ctx, EVENT_TIME) should be moved after the
perf_ctx_disable();.
Hope it can be fixed by the different way.

> But I'll have to continue staring at this later.

Sure.

Thanks,
Kan

