Return-Path: <linux-kernel+bounces-225185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D55912D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D3E1F21F91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF1C17A934;
	Fri, 21 Jun 2024 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBE1Dhdm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7A8820
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994880; cv=none; b=dl8qK1M0OSWaDBBJj7tNEmChfruBYAIVyLd1ZP9HA0OfKkk0ZzYtaA/nXzGsevB9URTGGpm/Ae07hGWfes0ibXJYMDI5iMvAQZY71qfz2Ks/yjUuPjRcMOgbGP2mG3X92sxKcNmNw8ebV0Fz5Z7vfNavxKoCrYO3wLgRjIFCC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994880; c=relaxed/simple;
	bh=Ll8DjW5jUPAt2frCXZ65KlFjmwWhUN1eHOpMVoKCuOY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lChqtiajTI6uGWA7BHBRH9krfYYp9xZZ5v6ntr3cjSm6TUgCK7TlTcejHNnySRNwev8YRm3udmdEnCGrsLr/leqK6AZyhVV7po7n03fdJJXF0JreTjMG+46bnMiDLvqScaom3cZDx6QsMf3AiI4WY282AJyhMEB7nIbL83CBsJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBE1Dhdm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718994879; x=1750530879;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Ll8DjW5jUPAt2frCXZ65KlFjmwWhUN1eHOpMVoKCuOY=;
  b=bBE1DhdmA/G2N7X0efmL8iVmBW1lf6FrsxbsJgCDtpiqpWCDpjE19m7r
   vTKpr+yo6gZt5HClGJyAezkX31Gjn9xA8+aoNkHjrUQX+s3BNxBrulZ/g
   dsL07cuJSUJY9yBhDqEO2CCSi6dKh6wTkAXxpbzqUTljOZsEPE5/SH4zN
   UkjNcrj1VXs9Cr/NMwB0eEu7varjfrEc61zrej3ibfZi7CHPDxe3xOi47
   PWXP4NzU4m5WMVJfwSguR4bWMkBu1hTHJsr3f9lVJ2Xg/ZPx6JrZWJHKH
   hkmgDldtl3IquvE2Etz49AlB+zHwTaYwjji9kWCq5X2Zq+oxJTBpTDZXf
   w==;
X-CSE-ConnectionGUID: 9yv5VIYZT8ahtqHE81QXfg==
X-CSE-MsgGUID: 6eojwDFARRGv7ESSC47IUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="19819352"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="19819352"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 11:34:38 -0700
X-CSE-ConnectionGUID: s2lhMfSVTlqBd3gcnpi6zg==
X-CSE-MsgGUID: +KbUjQ+LS7qCKeUb8rZD/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="42486443"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 11:34:38 -0700
Received: from [10.212.73.237] (kliang2-mobl1.ccr.corp.intel.com [10.212.73.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 249A220B5703;
	Fri, 21 Jun 2024 11:34:36 -0700 (PDT)
Message-ID: <ff25c37f-cb62-4687-adaa-596e8fc3a52a@linux.intel.com>
Date: Fri, 21 Jun 2024 14:34:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 05/12] perf/x86: Add config_mask to represent
 EVENTSEL bitmask
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-6-kan.liang@linux.intel.com>
 <20240620074402.GS31592@noisy.programming.kicks-ass.net>
 <4cce9f37-7698-418d-a9c5-4aa1dc01b719@linux.intel.com>
Content-Language: en-US
In-Reply-To: <4cce9f37-7698-418d-a9c5-4aa1dc01b719@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-20 12:16 p.m., Liang, Kan wrote:
> 
> 
> On 2024-06-20 3:44 a.m., Peter Zijlstra wrote:
>> On Tue, Jun 18, 2024 at 08:10:37AM -0700, kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> Different vendors may support different fields in EVENTSEL MSR, such as
>>> Intel would introduce new fields umask2 and eq bits in EVENTSEL MSR
>>> since Perfmon version 6. However, a fixed mask X86_RAW_EVENT_MASK is
>>> used to filter the attr.config.
>>>
>>
>>> @@ -1231,6 +1233,11 @@ static inline int x86_pmu_num_counters_fixed(struct pmu *pmu)
>>>  	return hweight64(hybrid(pmu, fixed_cntr_mask64));
>>>  }
>>>  
>>> +static inline u64 x86_pmu_get_event_config(struct perf_event *event)
>>> +{
>>> +	return event->attr.config & hybrid(event->pmu, config_mask);
>>> +}
>>
>> Seriously, we're going to be having such major event encoding
>> differences between cores on a single chip?
> 
> For LNL, no. But ARL-H may have an event encoding differences.
> I will double check.

There are two generations of e-core on ARL-H. The event encoding is
different.

The new fields umask2 and eq bits are enumerated by CPUID.(EAX=23H,
ECX=0H):EBX. They are supported by CPU 11 but not CPU 12.

CPU 11:
   0x00000023 0x00: eax=0x0000000f ebx=0x00000003 ecx=0x00000008
edx=0x00000000
CPU 12:
   0x00000023 0x00: eax=0x0000000b ebx=0x00000000 ecx=0x00000006
edx=0x00000000


Thanks,
Kan
> 
> The problem is that there is no guarantee for the future platforms.
> With the CPUID leaf 0x23, all the features are enumerated per CPU.
> In theory, it's possible that different layout of the EVENTSEL MSR
> between different types of core.
> If we take the virtualization into account, that's even worse.
> 
> It should be a safe way to add the hybrid() check.
> 
> 
> Thanks,
> Kan
> 

