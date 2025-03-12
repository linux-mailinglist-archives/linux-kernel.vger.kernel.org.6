Return-Path: <linux-kernel+bounces-558349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3EA5E4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E21A3ACC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61661258CD5;
	Wed, 12 Mar 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jP54j0tT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937A2586FE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808472; cv=none; b=R0UX9Or98x3TAugHGGZrA6Chm28Mup73GYWNVxHm79cQkCkLtR2z6kCgPm6n7n1spTfKFl2wmvisIBrjJq4ps0IkCacRam5lQuCKyxkUqwRzqQhh7ZLSXEjE5l7UFKoj4ko4OBAJbp18T586/XYOTUyJxMY/v1SgETp1yP33vOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808472; c=relaxed/simple;
	bh=ecsMIWvUU/Gtq8Owfq4Mz0WiDv5U6XrDbR3jMx9dpgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AH0JcikiflFD6Fns3G0pnEvCETeXVSWFQkAXtDLmIFYSTB+paH3gn1hsgd1uOrDalNmz34nQuUoS1Uuf8xU1ucJidw9xP/VPAdJ7TXoUWN7mu3i+NJjuneLuoWgMD3piyzUbA2mOWk6VbBax7vsSBIO+k+Z+9Q6AFJ5eUP4wKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jP54j0tT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741808471; x=1773344471;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ecsMIWvUU/Gtq8Owfq4Mz0WiDv5U6XrDbR3jMx9dpgY=;
  b=jP54j0tT/a5Wn6eRA9dF5TuY+hjM456L+P9vXRWG2lsRpmzJa3IXEKoM
   eZXY5utfoId9fqUalrZ6EqqM7sKbim6noIQIYqm8bhqstGx4Bb2TSgMYb
   gPJEo3yHlLF2zgjV7IDbxrEK1mkF1RwJLEYN4cYMoE5tG7vxjSV4vtytc
   3uXXVKvIebZS4/0l0e+d3ResLmDjLp3PP9qfJwKXWntEMDhzA8ll2Iziz
   Iu8cQrRKL4LP/tsLXoY27eGk7oL/d9VQZ7rk8LlxDUxKbVdmSLghc8G6t
   YopETJUUlduxvMWI/D2EBCDQ3AiZmCgSIlInFBQUKGDrldGKGWUaBBPvW
   g==;
X-CSE-ConnectionGUID: f93pAmgeROKOs6WZBu2PPA==
X-CSE-MsgGUID: xyyZLN35QcyR9wO2sxNifA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="30492400"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="30492400"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:41:09 -0700
X-CSE-ConnectionGUID: 0xtBciT3Q861ki5WaYEpNA==
X-CSE-MsgGUID: IYD5duLyTMa4rlfYR4phCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125357528"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:41:09 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D30D220B58A2;
	Wed, 12 Mar 2025 12:41:07 -0700 (PDT)
Message-ID: <702802d2-7318-4575-81ac-4fad6f8ff42f@linux.intel.com>
Date: Wed, 12 Mar 2025 15:41:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/6] perf: Save PMU specific data in task_struct
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com
References: <20250312182525.4078433-1-kan.liang@linux.intel.com>
 <20250312190533.GA10453@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250312190533.GA10453@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-03-12 3:05 p.m., Peter Zijlstra wrote:
> 
> I'm sorry, but since I spotted a bug in the second patch, I'm going to
> reply and suggest some overall changes.

Sure. Thanks.

> 
> On Wed, Mar 12, 2025 at 11:25:20AM -0700, kan.liang@linux.intel.com wrote:
> 
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 3e270822b915..b8442047a2b6 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1021,6 +1021,36 @@ struct perf_event_context {
>>  	local_t				nr_no_switch_fast;
>>  };
>>  
>> +/**
>> + * struct perf_ctx_data - PMU specific data for a task
>> + * @rcu_head:  To avoid the race on free PMU specific data
>> + * @refcount:  To track users
>> + * @global:    To track system-wide users
>> + * @ctx_cache: Kmem cache of PMU specific data
>> + * @data:      PMU specific data
>> + *
>> + * Currently, the struct is only used in Intel LBR call stack mode to
>> + * save/restore the call stack of a task on context switches.
>> + * The data only be allocated when Intel LBR call stack mode is enabled.
>> + * The data will be freed when the mode is disabled. The rcu_head is
>> + * used to prevent the race on free the data.
>> + * The content of the data will only be accessed in context switch, which
>> + * should be protected by rcu_read_lock().
>> + *
>> + * Careful: Struct perf_ctx_data is added as a pointor in struct task_struct.
> 
> pointer
> 
>> + * When system-wide Intel LBR call stack mode is enabled, a buffer with
>> + * constant size will be allocated for each task.
>> + * Also, system memory consumption can further grow when the size of
>> + * struct perf_ctx_data enlarges.
>> + */
>> +struct perf_ctx_data {
>> +	struct rcu_head			rcu_head;
>> +	refcount_t			refcount;
>> +	int				global;
>> +	struct kmem_cache		*ctx_cache;
>> +	void				*data;
>> +};
> 
> I can't remember why this is complicated like this. Why do we have a
> kmemcache and yet another data pointer in there?

The kmem_cache is introduced to address the alignment requirement for
Arch LBR.
https://lore.kernel.org/lkml/159420190705.4006.11190540790919295173.tip-bot2@tip-bot2/

When users do system-wide profiling, perf has to allocate a buffer when
forking a thread or delete a buffer when deleting a thread. The
pmu->task_ctx_cache is required. Perf has to search the perf_event_list
every time to find the proper PMU.
So the *ctx_cache is introduced to avoid the search.

Thanks,
Kan

> 
> Specifically, why can't we do something like:
> 
> struct perf_ctx_data {
> 	struct rcu_head		rcu;
> 	refcount_t		refcount;
> 	int			global;
> 	char			data[];
> };
> 
> and simply allocate the whole thing as a single allocation?
> 
> So then the allocation is something like:
> 
> 	cd = kzalloc(sizeof(*cd) + event->pmu->task_ctx_size, GFP_KERNEL);
> 
> 


