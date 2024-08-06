Return-Path: <linux-kernel+bounces-276342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F5949246
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2541C2158D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825AF1D61B8;
	Tue,  6 Aug 2024 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9WziGis"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346591BE875
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952490; cv=none; b=PB43ee8oqFGShToTAmDClsL9fdeWvAhTy81nQCbP69xSLzYaVNZvcU7STJQNthmOFGnqQFozhj76InBDGL5L6v815m7S6QxkPNNsTMy/b1zcu/8gfSEYT53jkZSJ4x0gbZvZmSNTO+zzFNOSLCd30Ejguf7hP2wGDsAhSRwuaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952490; c=relaxed/simple;
	bh=lzVvA46flIFW5SOBv9NKICUeUiIGsdpzHdpxDo1Paf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGkhKn4OFfsg0cwornWJik6WxgOM26yW8KmbA9lncJoHJUR6mQr1q/F/tPkl09burRwL9MRzrgMg7kZswX4R5rMqsMn2V/lgt8mJihp4pXhzyvM8hccMy2H2EJLjl1QR4b9G0/K51w0R+qdyxvMI2ldOLHzADG2NRG3Et5zE93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9WziGis; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722952489; x=1754488489;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lzVvA46flIFW5SOBv9NKICUeUiIGsdpzHdpxDo1Paf8=;
  b=H9WziGisxNSZREmMWgR1Blf3TmYmlvsVy7UqRLHQ7Dp3L0k0XD7+ocZ1
   BHDLgn8SMWMPpqlzUQU39veE3e95jqny/ce1hlPqU//AgZC9Ep7MGIQ3B
   Hez9hFqo3tKo2vcJK9o4HkU9kj4cbQODEKa+5mYXxwcPGoJJYEluH+tSX
   MSxg2B4VqOJvLMfZ4l4oktSyAX49TY8rle4vin6yafz/7AEOmf42+GsZ8
   KDBlZZmqbFNhlOy9SX8S0g9j2BUxifCJrWZRUwI4m8mpZjb+DTXKWoXAQ
   7hUJWgwB6TnF47bp0MTrCd+28hjHn4OHfeB9cT/hi4mgcBT04Yj8smlGX
   w==;
X-CSE-ConnectionGUID: CMt6ALHwQaSQKG98dJ8oCw==
X-CSE-MsgGUID: L4Hfb+uAS8GuTQcO2btXlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21148787"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="21148787"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 06:54:49 -0700
X-CSE-ConnectionGUID: smxKZ7icQLGSOZO+leMsvQ==
X-CSE-MsgGUID: iePAEBX3SJmBgj7kQ0gmuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="60890033"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 06:54:48 -0700
Received: from [10.212.84.25] (kliang2-mobl1.ccr.corp.intel.com [10.212.84.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5865320CFECD;
	Tue,  6 Aug 2024 06:54:46 -0700 (PDT)
Message-ID: <1d7b6780-6d4c-483f-98d7-539e7c3fcf36@linux.intel.com>
Date: Tue, 6 Aug 2024 09:54:44 -0400
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
 <20240805092058.GK37996@noisy.programming.kicks-ass.net>
 <20240805145827.GE12673@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240805145827.GE12673@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-05 10:58 a.m., Peter Zijlstra wrote:
> On Mon, Aug 05, 2024 at 11:20:58AM +0200, Peter Zijlstra wrote:
>> On Fri, Aug 02, 2024 at 02:30:19PM -0400, Liang, Kan wrote:
>>>> @@ -2792,7 +2833,14 @@ static int  __perf_install_in_context(void *info)
>>>>  	if (reprogram) {
>>>>  		ctx_sched_out(ctx, EVENT_TIME);
>>>>  		add_event_to_ctx(event, ctx);
>>>> -		ctx_resched(cpuctx, task_ctx, get_event_type(event));
>>>> +		if (ctx->nr_events == 1) {
>>>> +			/* The first event needs to set ctx->is_active. */
>>>> +			ctx_resched(cpuctx, task_ctx, NULL, get_event_type(event));
>>>> +		} else {
>>>> +			ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
>>>> +				    get_event_type(event));
>>>> +			ctx_sched_in(ctx, EVENT_TIME);
>>>
>>> The changelog doesn't mention the time difference much. As my
>>> understanding, the time is shared among PMUs in the same ctx.
>>> When perf does ctx_resched(), the time is deducted.
>>> There is no problem to stop and restart the global time when perf
>>> re-schedule all PMUs.
>>> But if only one PMU is re-scheduled while others are still running, it
>>> may be a problem to stop and restart the global time. Other PMUs will be
>>> impacted.
>>
>> So afaict, since we hold ctx->lock, nobody can observe EVENT_TIME was
>> cleared for a little while.
>>
>> So the point was to make all the various ctx_sched_out() calls have the
>> same timestamp. It does this by clearing EVENT_TIME first. Then the
>> first ctx_sched_in() will set it again, and later ctx_sched_in() won't
>> touch time.
>>
>> That leaves a little hole, because the time between
>> ctx_sched_out(EVENT_TIME) and the first ctx_sched_in() gets lost.
>>
>> This isn't typically a problem, but not very nice. Let me go find an
>> alternative solution for this. The simple update I did saturday is
>> broken as per the perf test.
> 
> OK, took a little longer than I would have liked, nor is it entirely
> pretty, but it seems to pass 'perf test'.
> 
> Please look at: queue.git perf/resched

Thanks. If I understand correctly, the freeze doesn't mean that the time
deduction. For the other PMUs, it can still see the time in during the
specific PMU reschedule, right? If so, the general idea looks good to me.

I also think of the vPMU time. For that case, perf has to deduct the
vPMU time. The freeze bit cannot be used in the vPMU case. But I
probably have to rebase the below patch on top of EVENT_FROZEN.
https://lore.kernel.org/kvm/20240801045907.4010984-10-mizhang@google.com/

Thanks,
Kan

