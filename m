Return-Path: <linux-kernel+bounces-204813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4F18FF3D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB911F28AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22EB198E86;
	Thu,  6 Jun 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahEf0rf8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F84F19597A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695208; cv=none; b=QKK1z71IOpSbgTEDsHIqhcahsBDclOOBMAX7w7qfqqGv9e/frPFKDlig/XjuejrTpTyEeUT5VI1AKXK/NZg0+QSciJZb0F5cwWu/rpcb45iDPGSmUzNFtzbaZ35gVICrJg2bT1pM2LwOdxQEyWWbjeG3JO0kM5KYVXXVPZy7wsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695208; c=relaxed/simple;
	bh=AZNV3pTVmDHmXeRINlmQituZgEwc942Ka9Pjh5NrzCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spLeR6C6Z5CLHnr38zpSBu5+e4d6rTESNLkijAqgTiJNc6Ynx/aHsReNfSvY3RZNhXXku7zfWk+DktSSZKRSeRejyZzAwyxFF52ogComqh7G6StAjSQrNG+U4ivhz3SX+9xTqkSBsD9am8Et+V8nIS6RfjegTT1Ns3kTBomctVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahEf0rf8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717695208; x=1749231208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AZNV3pTVmDHmXeRINlmQituZgEwc942Ka9Pjh5NrzCw=;
  b=ahEf0rf8DrzgkSWabip+lnkJTAeNG/q9yTj0IIaJIjlfZdCQt53NBvfM
   61aPFhKYwTLu6mdlpdGvNwYHuGLk2NKmcWd8pau1yx1hbcH/0qAEZmqfb
   DepcgIfb4eKmSuou32ov/B0A8l/mbE69qhH38nTiEpcCK5azq5to13bm0
   1yYrGS7kmH4r4Rk8G0PSTwP5i/m6nlGnMXwgEDpSTGvpNCNZbwWutSVlh
   G6RtV361pBi3+Oe1YRp6TrQFcGMkGYtyh2UbD08LGlP1wyjaLo3ObLk1Q
   fIB22LFvNZGpjY/PZGH/Fafj9t9zVktZ9DT83QICni61WyFR0gG5LbB1L
   g==;
X-CSE-ConnectionGUID: T73vty9QRNGugW7SGQ5F4A==
X-CSE-MsgGUID: Cf6DYNl4QBCiGb0ev6QCaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25790449"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25790449"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 10:33:27 -0700
X-CSE-ConnectionGUID: sDHjmgSsTR+gBzgynMfZ8Q==
X-CSE-MsgGUID: 9VPzf9icQva99F34Wkfoew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="61251418"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 10:33:26 -0700
Received: from [10.212.72.92] (kliang2-mobl1.ccr.corp.intel.com [10.212.72.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 1F6E820B5703;
	Thu,  6 Jun 2024 10:33:24 -0700 (PDT)
Message-ID: <97f4f35b-e6b2-4a2e-bbea-3f6f127cb9c8@linux.intel.com>
Date: Thu, 6 Jun 2024 13:33:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] perf_events: exclude_guest impact on
 time_enabled/time_running
To: Stephane Eranian <eranian@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML
 <linux-kernel@vger.kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, "Narayan, Ananth" <ananth.narayan@amd.com>,
 "Bangoria, Ravikumar" <ravi.bangoria@amd.com>,
 Namhyung Kim <namhyung@google.com>, Mingwei Zhang <mizhang@google.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhang Xiong <xiong.y.zhang@intel.com>
References: <CABPqkBQ3LQ_dXQSQVSrriinvSSXm2fHx4yOms=jRsa2WaXSsog@mail.gmail.com>
 <4622060b-b758-4629-9aa4-cc8334111be0@linux.intel.com>
 <CABPqkBR4CGx9EY4nMmnRT1Uuw0p5iefnFZa0hphh+HBBYqQ71A@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CABPqkBR4CGx9EY4nMmnRT1Uuw0p5iefnFZa0hphh+HBBYqQ71A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-06-06 1:08 p.m., Stephane Eranian wrote:
> On Thu, Jun 6, 2024 at 8:48 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-06-06 3:57 a.m., Stephane Eranian wrote:
>>> Hi Peter,
>>>
>>> In the context of the new vPMU passthru patch series, we have to look
>>> closer at the definition and implementation of the exclude_guest
>>> filter in the perf_event_attr structure. This filter has been in the
>>> kernel for many years. See patch:
>>> https://lore.kernel.org/all/20240506053020.3911940-8-mizhang@google.com/
>>>
>>> The presumed  definition of the filter is that the user does not want
>>> the event to count while the processor is running in guest mode (i.e.,
>>> inside the virtual machine guest OS or guest user code).
>>>
>>> The perf tool sets is by default on all core PMU events:
>>> $ perf stat -vv -e cycles sleep 0
>>> ------------------------------------------------------------
>>> perf_event_attr:
>>>   size                             112
>>>   sample_type                      IDENTIFIER
>>>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>>   disabled                         1
>>>   inherit                          1
>>>   enable_on_exec                   1
>>>   exclude_guest                    1
>>> ------------------------------------------------------------
>>>
>>> In the kernel, the way this is treated differs between AMD and Intel because AMD
>>> does provide a hardware filter for guest vs. host in the PMU counters
>>> whereas Intel
>>> does not. For the latter, the  kernel simply disables the event in the
>>> hardware counters,
>>> i.e., the event is not descheduled.  Both approaches produce pretty
>>> much the same
>>> desired effect, the event is not counted while in guest mode.
>>>
>>> The issue I would like to raise has to do with the effects on
>>> time_enabled and time_running
>>> for exclude_guest=1 events.
>>>
>>> Given the event is not scheduled out while in guest mode, even though
>>> it is stopped, both time_enabled and time_running continue ticking
>>> while in guest mode.  If a measurement is 10s
>>> long but only 5s are in non-guest mode, then time_enabled=10s,
>>> time_running=10s. The count
>>> represents 10s worth of non guest mode, of which only 5s were really
>>> actively monitoring, but
>>> the user has no way of determining this.
>>
>>
>> For the latest design/implementation, only the exclude_guest=1 host
>> event can be successfully created for the case.
>> The end user should not expect that anything is collected in the guest
>> mode. So both the time_enabled and the time_running will be 5s.
>>
>>>
>>> If we look at vPMU passthru, the host event must have exclude_guest=1
>>> to avoid going into
>>> an error state on context switch to the vCPU thread (with vPMU
>>> enabled).
>>
>> That's the design in V1. There is no error state anymore in V2 and later
>> as suggested by Sean.
>> https://lore.kernel.org/all/ZhmIrQQVgblrhCZs@google.com/
>>
>> The VM cannot be created if there are host events with exclude_guest=0.
>> If a VM has been created, user cannot create an event with
>> exclude_guest=0. So nothing will be moved to an error state on context
>> switch to the vCPU thread.
>>
> Ok, that's new.
> 
>>> But this time,
>>> the event is scheduled out, that means that time_enabled keeps
>>> counting, but time_running
>>> stops. On context switch back in, the host event is scheduled again
>>> and time_running restarts
>>> ticking. For a 10s measurement, where 5s here in the guest, the event
>>> will come out with
>>> time_enabled=10s, time_running=5s, and the tool will scale it up
>>> because it thinks the event
>>> was multiplexed, when in fact it was not. This is not the intended
>>> outcome here. The tool should
>>> not scale the count, it was not multiplexed, it was descheduled
>>> because the filter forced it out.
>>> Note that if the event had been multiplexed while running on the host,
>>> then the scaling would be
>>> appropriate.
>>
>> The scaling will not happen, since both time_enabled and time_running
>> should be the same when there are enough counter resources.
>>
> If an event with exclude_guest=1 is sched out (event_sched_out), time_enabled
> will keep running but time_running will stop. Because the code assumes
> it is stopped
> because of multiplexing. However, here this is not the case. The event
> is stopped because
> the CPU is entering an execution domain that is excluded for the event.
> Unless you've modified the event_sched_out() code or added code to
> patch up time_running
> I don't see how they could be equal. The alternative, as you suggest,
> is to stop time_enabled.
> But usually time_enabled is controlled by ENABLE/DISABLE which are
> different from
> event_sched_out() and event_sched_in().

The entire context are scheduled, ctx_sched_{in,out}.
https://lore.kernel.org/all/20240507085807.GS40213@noisy.programming.kicks-ass.net/

The time in the guest mode doesn't be accumulated in the ctx->time,
which will be used to calculate the event time later.

The event_sched_in() never be failed (assuming enough PMU resources in
the host after be back from the guest). The time_enabled and
time_running should be equal.

Thanks,
Kan
> 
> 
>>>
>>> In that case, I argue, time_running should be updated to cover the
>>> time the event was not running. That would bring us back to the case I
>>> was describing earlier.
>>>
>>> It boils down to the exact definition of exclude_guest and expected
>>> impact on time_enabled
>>> and time_running. Then, with or without vPMU passthru, we can fix the
>>> kernel to ensure a
>>> uniform behavior.
>>
>> I think the time_enabled should be the one that has a controversial
>> definition.
>> Should the time in the guest mode count as the enabled time for an host
>> event that explicitly sets the exclude_guest=1?
>>
>> I think the answer is NO. So I implemented it in the code.
>>
>>>
>>> What are your thoughts on this problem?
>>>
>>
>> Peter, please share your thoughts. We want to make sure the design is on
>> the right track.
>>
>> Thanks,
>> Kan

