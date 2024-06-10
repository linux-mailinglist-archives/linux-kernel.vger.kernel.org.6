Return-Path: <linux-kernel+bounces-208666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D049027E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0022F1C21840
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32BB147C6E;
	Mon, 10 Jun 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eySB/Vf1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB48F6D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041183; cv=none; b=hxj/kAqWYCWTKRQ6e5EEA5TRIAys3wDfMcXHKYPhac9YEcHNfK8PEQLkvgh3MacakIkrgmocPWgzgcqs8tUvk776w3qYLUVRWzRSbVrqlfqTOx8qHXh35s51MmKcR0o6hRQL4sMl9UFIapQnyCOBz0q+jYbW4AlRO/4lwjDNLtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041183; c=relaxed/simple;
	bh=L0BXahp69tle3ddoy61ZL+EX3x7XEMJH/fsOq1O4ahg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=edkG5YvHecu1m2NlPMAlFB54M6zg4BG28PdtTYNu/y5RdeQufzFndr2FFlKNAskGLzljVhXxo1jH/e5+If+cmcBp4hHWJZ/kxbzcxxPfgen99kzvH6F2J3bz73QnA4nf69sNcdo1FlpuWom+XQp8h0DxyT98s2jCWiMhC74br5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eySB/Vf1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718041182; x=1749577182;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=L0BXahp69tle3ddoy61ZL+EX3x7XEMJH/fsOq1O4ahg=;
  b=eySB/Vf1907iRCk/XOSKC5CU+M0sRbWLvLVaAJe96isD6wWjkub3BhBr
   aJoxF97mM3DTNkotdkmv13vokSwXplGHlReKBJWxA1tWvDN+VvrvqB9Ce
   tZqDN8B9L2HeNVLfBJm7xeb/VgJwtQa6nY1H7TnxRtQK3ObMyOFO5SBua
   Xp7HMUpmq+7L52XqUZ797ZjVrtsk71BBbvM+/vNi6+wBAHbEVmtwf9XVY
   d8zqaAoxtMTC4r0Z9dCnFdLdm7M3aLigSBkJuJ1bcgq/RNiuXAwv8TFkJ
   o5gPupYcof6jYb4zX6OuUfJ2byYPMYsT91SeGwq47wLzlQhfsz/VUAxcY
   A==;
X-CSE-ConnectionGUID: 3GdrcDCtR1ewbTJ0FL/dgQ==
X-CSE-MsgGUID: 3PMcwVazSPitej1bTZm2pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="12003174"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="12003174"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 10:39:41 -0700
X-CSE-ConnectionGUID: xmMqnAa8Ry+rk/vibtXq0A==
X-CSE-MsgGUID: MCYlI1MARfabQppcaMucrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="44266182"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 10:39:40 -0700
Received: from [10.213.169.239] (kliang2-mobl1.ccr.corp.intel.com [10.213.169.239])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 67F9820B5703;
	Mon, 10 Jun 2024 10:39:39 -0700 (PDT)
Message-ID: <5ab50872-4906-4ec1-8d72-617f85dff8c2@linux.intel.com>
Date: Mon, 10 Jun 2024 13:39:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] perf_events: exclude_guest impact on
 time_enabled/time_running
From: "Liang, Kan" <kan.liang@linux.intel.com>
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
 <97f4f35b-e6b2-4a2e-bbea-3f6f127cb9c8@linux.intel.com>
Content-Language: en-US
In-Reply-To: <97f4f35b-e6b2-4a2e-bbea-3f6f127cb9c8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-06-06 1:33 p.m., Liang, Kan wrote:
> 
> 
> On 2024-06-06 1:08 p.m., Stephane Eranian wrote:
>> On Thu, Jun 6, 2024 at 8:48 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>
>>>
>>>
>>> On 2024-06-06 3:57 a.m., Stephane Eranian wrote:
>>>> Hi Peter,
>>>>
>>>> In the context of the new vPMU passthru patch series, we have to look
>>>> closer at the definition and implementation of the exclude_guest
>>>> filter in the perf_event_attr structure. This filter has been in the
>>>> kernel for many years. See patch:
>>>> https://lore.kernel.org/all/20240506053020.3911940-8-mizhang@google.com/
>>>>
>>>> The presumed  definition of the filter is that the user does not want
>>>> the event to count while the processor is running in guest mode (i.e.,
>>>> inside the virtual machine guest OS or guest user code).
>>>>
>>>> The perf tool sets is by default on all core PMU events:
>>>> $ perf stat -vv -e cycles sleep 0
>>>> ------------------------------------------------------------
>>>> perf_event_attr:
>>>>   size                             112
>>>>   sample_type                      IDENTIFIER
>>>>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>>>   disabled                         1
>>>>   inherit                          1
>>>>   enable_on_exec                   1
>>>>   exclude_guest                    1
>>>> ------------------------------------------------------------
>>>>
>>>> In the kernel, the way this is treated differs between AMD and Intel because AMD
>>>> does provide a hardware filter for guest vs. host in the PMU counters
>>>> whereas Intel
>>>> does not. For the latter, the  kernel simply disables the event in the
>>>> hardware counters,
>>>> i.e., the event is not descheduled.  Both approaches produce pretty
>>>> much the same
>>>> desired effect, the event is not counted while in guest mode.
>>>>
>>>> The issue I would like to raise has to do with the effects on
>>>> time_enabled and time_running
>>>> for exclude_guest=1 events.
>>>>
>>>> Given the event is not scheduled out while in guest mode, even though
>>>> it is stopped, both time_enabled and time_running continue ticking
>>>> while in guest mode.  If a measurement is 10s
>>>> long but only 5s are in non-guest mode, then time_enabled=10s,
>>>> time_running=10s. The count
>>>> represents 10s worth of non guest mode, of which only 5s were really
>>>> actively monitoring, but
>>>> the user has no way of determining this.
>>>
>>>
>>> For the latest design/implementation, only the exclude_guest=1 host
>>> event can be successfully created for the case.
>>> The end user should not expect that anything is collected in the guest
>>> mode. So both the time_enabled and the time_running will be 5s.
>>>
>>>>
>>>> If we look at vPMU passthru, the host event must have exclude_guest=1
>>>> to avoid going into
>>>> an error state on context switch to the vCPU thread (with vPMU
>>>> enabled).
>>>
>>> That's the design in V1. There is no error state anymore in V2 and later
>>> as suggested by Sean.
>>> https://lore.kernel.org/all/ZhmIrQQVgblrhCZs@google.com/
>>>
>>> The VM cannot be created if there are host events with exclude_guest=0.
>>> If a VM has been created, user cannot create an event with
>>> exclude_guest=0. So nothing will be moved to an error state on context
>>> switch to the vCPU thread.
>>>
>> Ok, that's new.
>>
>>>> But this time,
>>>> the event is scheduled out, that means that time_enabled keeps
>>>> counting, but time_running
>>>> stops. On context switch back in, the host event is scheduled again
>>>> and time_running restarts
>>>> ticking. For a 10s measurement, where 5s here in the guest, the event
>>>> will come out with
>>>> time_enabled=10s, time_running=5s, and the tool will scale it up
>>>> because it thinks the event
>>>> was multiplexed, when in fact it was not. This is not the intended
>>>> outcome here. The tool should
>>>> not scale the count, it was not multiplexed, it was descheduled
>>>> because the filter forced it out.
>>>> Note that if the event had been multiplexed while running on the host,
>>>> then the scaling would be
>>>> appropriate.
>>>
>>> The scaling will not happen, since both time_enabled and time_running
>>> should be the same when there are enough counter resources.
>>>
>> If an event with exclude_guest=1 is sched out (event_sched_out), time_enabled
>> will keep running but time_running will stop. Because the code assumes
>> it is stopped
>> because of multiplexing. However, here this is not the case. The event
>> is stopped because
>> the CPU is entering an execution domain that is excluded for the event.
>> Unless you've modified the event_sched_out() code or added code to
>> patch up time_running
>> I don't see how they could be equal. The alternative, as you suggest,
>> is to stop time_enabled.
>> But usually time_enabled is controlled by ENABLE/DISABLE which are
>> different from
>> event_sched_out() and event_sched_in().
> 
> The entire context are scheduled, ctx_sched_{in,out}.
> https://lore.kernel.org/all/20240507085807.GS40213@noisy.programming.kicks-ass.net/
> 
> The time in the guest mode doesn't be accumulated in the ctx->time,
> which will be used to calculate the event time later.
>

The ctx->time is shared among PMUs. The core PMU doesn't want the time
in the guest mode, but other PMUs, e.g., uncore, still need it.
So we do need to track the time in the guest mode.

Something as below is planed to be implemented in the V3.
The host ctx should keeps active in the guest mode as well.
The event of core PMU will deduct the time of the guest mode.
https://lore.kernel.org/linux-perf-users/902c40cc-6e0b-4b2f-826c-457f533a0a76@linux.intel.com/

For example,
perf stat -e cpu/cycles/H,uncore_cha_0/event=0x1/ -C0 -vvv sleep 16

(when the perf command runs, a guest runs ~8s at the same CPU.)

cpu/cycles/H: 55426106 7813838542 7813838542
uncore_cha_0/event=0x1/: 14302016384 16004903742 16004903742

 Performance counter stats for 'CPU(s) 0':

        55,426,106      cpu/cycles/H
    14,302,016,384      uncore_cha_0/event=0x1/

      16.034896147 seconds time elapsed

The time_enabled and time_running for cycles is 7813838542.
For uncore_cha_0/event=0x1/, it's 16004903742.

Thanks,
Kan

> The event_sched_in() never be failed (assuming enough PMU resources in
> the host after be back from the guest). The time_enabled and
> time_running should be equal.
> 
> Thanks,
> Kan
>>
>>
>>>>
>>>> In that case, I argue, time_running should be updated to cover the
>>>> time the event was not running. That would bring us back to the case I
>>>> was describing earlier.
>>>>
>>>> It boils down to the exact definition of exclude_guest and expected
>>>> impact on time_enabled
>>>> and time_running. Then, with or without vPMU passthru, we can fix the
>>>> kernel to ensure a
>>>> uniform behavior.
>>>
>>> I think the time_enabled should be the one that has a controversial
>>> definition.
>>> Should the time in the guest mode count as the enabled time for an host
>>> event that explicitly sets the exclude_guest=1?
>>>
>>> I think the answer is NO. So I implemented it in the code.
>>>
>>>>
>>>> What are your thoughts on this problem?
>>>>
>>>
>>> Peter, please share your thoughts. We want to make sure the design is on
>>> the right track.
>>>
>>> Thanks,
>>> Kan
> 

