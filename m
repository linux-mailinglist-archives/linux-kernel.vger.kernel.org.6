Return-Path: <linux-kernel+bounces-223015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7721910BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165B81F21026
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1211B3F1B;
	Thu, 20 Jun 2024 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhxhDep6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399E1B372F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900211; cv=none; b=jlYP9SAGu5fPWxvdy1IyJMc81CjGHXA6drfmK80fIRai3S2GK3RqKRqWUNpYqIRTOzDQSoOEwPdAQBu5vvc6q8zwJM4Qxhn3exnT01rWFxOuMZ6DuWeWssmn0Q2DaJ4N2CAIJTUCoSFqJpZyJ2oRssv5ASpYi9yxIbL5gw4DBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900211; c=relaxed/simple;
	bh=+SqyJkoIErTrnlzyt9GtOIsskudssLb0nIT/gSHuTwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZtsK8mAWE7va6p4KeGNm2KtQwkJVZz1mjSGbXN+fqmThmeNr+rLdk5LuKJL9yNf4/qIzIJ6aih8nS0uTeuVOX3IMl+UBX2JuYGDVzOL9RwXiuqQtAdoCqAmvNPqdwuzA8LwnMpHJWqKVFkfwiToNDNKu8LhXdV1uCAlTgAms6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhxhDep6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718900210; x=1750436210;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+SqyJkoIErTrnlzyt9GtOIsskudssLb0nIT/gSHuTwU=;
  b=KhxhDep6/74nrcr4hCKIgOpUd0KMDpQfPkWQ6ubzzk6Lcwzry6ouYAWr
   XLHteyUWh0slHL7fXDHSsMQwe8A7NVqzmaDl06EFD4AJNgdkj78Hct1uY
   mn5p/xfMSsxXhUs/c74uNz0GAkce8BD21eN3xKCX6Jwft8BF1zh7JkPIA
   TM67+2Zl9wocmwbnf4wS68s4VGMjSv4NFbwDeetyJlTINMxglMYacSU+E
   UyO7VLEuYDP5AJtHen+ba/wXKu6EcBHeCJkUHbVFAFuIg7+xUGdQhGmrw
   zvOTYvfBAPUv+r+NKS054uM9GmI+0GJvomNaFrRWRq8JJ6Jvxb4tjOlwP
   g==;
X-CSE-ConnectionGUID: bpoaz8OPRUSpDCGKPDQWZQ==
X-CSE-MsgGUID: ghsscLcDQPWcojFlVdL+rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="33436997"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="33436997"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:16:50 -0700
X-CSE-ConnectionGUID: FmyXfYqMSqWmN38HMlM0EQ==
X-CSE-MsgGUID: 4AjvyFn8Q1SBMnLt14VUaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42962394"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:16:49 -0700
Received: from [10.212.43.222] (kliang2-mobl1.ccr.corp.intel.com [10.212.43.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id EC72D20B5703;
	Thu, 20 Jun 2024 09:16:47 -0700 (PDT)
Message-ID: <4cce9f37-7698-418d-a9c5-4aa1dc01b719@linux.intel.com>
Date: Thu, 20 Jun 2024 12:16:46 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 05/12] perf/x86: Add config_mask to represent
 EVENTSEL bitmask
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-6-kan.liang@linux.intel.com>
 <20240620074402.GS31592@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240620074402.GS31592@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-20 3:44 a.m., Peter Zijlstra wrote:
> On Tue, Jun 18, 2024 at 08:10:37AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Different vendors may support different fields in EVENTSEL MSR, such as
>> Intel would introduce new fields umask2 and eq bits in EVENTSEL MSR
>> since Perfmon version 6. However, a fixed mask X86_RAW_EVENT_MASK is
>> used to filter the attr.config.
>>
> 
>> @@ -1231,6 +1233,11 @@ static inline int x86_pmu_num_counters_fixed(struct pmu *pmu)
>>  	return hweight64(hybrid(pmu, fixed_cntr_mask64));
>>  }
>>  
>> +static inline u64 x86_pmu_get_event_config(struct perf_event *event)
>> +{
>> +	return event->attr.config & hybrid(event->pmu, config_mask);
>> +}
> 
> Seriously, we're going to be having such major event encoding
> differences between cores on a single chip?

For LNL, no. But ARL-H may have an event encoding differences.
I will double check.

The problem is that there is no guarantee for the future platforms.
With the CPUID leaf 0x23, all the features are enumerated per CPU.
In theory, it's possible that different layout of the EVENTSEL MSR
between different types of core.
If we take the virtualization into account, that's even worse.

It should be a safe way to add the hybrid() check.


Thanks,
Kan

