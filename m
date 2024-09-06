Return-Path: <linux-kernel+bounces-319131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CDF96F828
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5161F24702
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB5C1D2F6C;
	Fri,  6 Sep 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsYD+YBE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2C1D2F64
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636401; cv=none; b=hdcNHnd7ctsn1juMVPA/v6oGwmLxl9F+WblQpncLncHrvTn7fG0rKYh7VmHYcUfJhVU/zoZX62tx6CKufeKGhowoSsCJlQwAsTLkD+loBD0ayTvpVmU0lv+nD8cPYgVqohPCYcX/2oJIwyLIlVtAyyVCjcesgR8AJHcjqYTRhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636401; c=relaxed/simple;
	bh=D4nQ5fN6RGMDT+fWiTyzh8QTZ6r0ny9lEHlj7lX/p9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdHnQ+uRprDLNQiapCmescaefgchcIQnIdM/abGhlvVP4/FAF127RYM8b0GYGj1eZE2l90ywUNUCrtGhSPQxIQuYQOqeUHPOsvFSjGeDMXy/BAAVGxYlAH1ol4gsaxyLtLaTI8fCMtkEAUOS7IDc+nWoW4Dm2KBjl2SPl6/SHaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsYD+YBE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725636399; x=1757172399;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D4nQ5fN6RGMDT+fWiTyzh8QTZ6r0ny9lEHlj7lX/p9k=;
  b=GsYD+YBE9ZlJTEYjNvz+vdn7Zmr+08RWabP1S55K7pQ/W9fWT/cQo8PM
   FNdU4APPo7SSiN3oC7S23FipDikWM/EB0w4kUfg2i8Yj5eXp6UZwXfzph
   XTVNLC6Kv64WIOPtpT3pimyq0RNgVt7Cg6fnUiRxdfuEDc/6YVsOJKkqV
   SLZ/05rKZ9xZ20spCDln6WeznWskxR7mX23jVCQVWSB/AAzaCYjVfBsyZ
   Mq/hnaM1gIBH786cDVBJ1XsU1L9wJGAxGoSK3Uhn4m53sl+veUkLzANqq
   dwTDPV0LAW1fqHJKM5Cwc8MifIxN+/cOqg0nekQCESTX7uhKMR8IX43y0
   Q==;
X-CSE-ConnectionGUID: Guv0G/uMR+aeuThLBM/4RA==
X-CSE-MsgGUID: 3OJiNz1LRdeQ3VSuMMwRqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="23958098"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="23958098"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 08:26:38 -0700
X-CSE-ConnectionGUID: yLBq8TeGQ4uOdL6WccNjTw==
X-CSE-MsgGUID: t24Klk13Rr2QWTRIMK+L3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="65673220"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 08:26:38 -0700
Received: from [10.212.119.23] (kliang2-mobl1.ccr.corp.intel.com [10.212.119.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 90C8320B5782;
	Fri,  6 Sep 2024 08:26:37 -0700 (PDT)
Message-ID: <ff22bcc8-98a2-4975-91e8-29740e6dac45@linux.intel.com>
Date: Fri, 6 Sep 2024 11:26:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] perf: Add PERF_EV_CAP_READ_SCOPE
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-kernel@vger.kernel.org
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-3-kan.liang@linux.intel.com>
 <20240906151153.GX4723@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240906151153.GX4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-06 11:11 a.m., Peter Zijlstra wrote:
> On Fri, Aug 02, 2024 at 08:16:38AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Usually, an event can be read from any CPU of the scope. It doesn't need
>> to be read from the advertised CPU.
>>
>> Add a new event cap, PERF_EV_CAP_READ_SCOPE. An event of a PMU with
>> scope can be read from any active CPU in the scope.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  include/linux/perf_event.h |  3 +++
>>  kernel/events/core.c       | 14 +++++++++++---
>>  2 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 1102d5c2be70..1206bc86eb4f 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -633,10 +633,13 @@ typedef void (*perf_overflow_handler_t)(struct perf_event *,
>>   * PERF_EV_CAP_SIBLING: An event with this flag must be a group sibling and
>>   * cannot be a group leader. If an event with this flag is detached from the
>>   * group it is scheduled out and moved into an unrecoverable ERROR state.
>> + * PERF_EV_CAP_READ_SCOPE: A CPU event that can be read from any CPU of the
>> + * PMU scope where it is active.
>>   */
>>  #define PERF_EV_CAP_SOFTWARE		BIT(0)
>>  #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
>>  #define PERF_EV_CAP_SIBLING		BIT(2)
>> +#define PERF_EV_CAP_READ_SCOPE		BIT(3)
>>  
>>  #define SWEVENT_HLIST_BITS		8
>>  #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 5e1877c4cb4c..c55294f34575 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -4463,16 +4463,24 @@ struct perf_read_data {
>>  	int ret;
>>  };
>>  
>> +static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int scope, int cpu);
>> +
>>  static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
>>  {
>> +	int local_cpu = smp_processor_id();
>>  	u16 local_pkg, event_pkg;
>>  
>>  	if ((unsigned)event_cpu >= nr_cpu_ids)
>>  		return event_cpu;
>>  
>> -	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
>> -		int local_cpu = smp_processor_id();
>> +	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
>> +		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
>> +
>> +		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
>> +			return local_cpu;
>> +	}
>>  
>> +	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
> 
> I'm guessing the goal is to eventually remove this one, right?

Yes, after I have the uncore cleaned up. It should be able to remove the
PERF_EV_CAP_READ_ACTIVE_PKG.

Thanks,
Kan
> 

