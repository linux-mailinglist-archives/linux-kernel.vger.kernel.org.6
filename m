Return-Path: <linux-kernel+bounces-319134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950EF96F82D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DD7B22EE9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B181D0DCB;
	Fri,  6 Sep 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i82MdJAB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2C381C2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636652; cv=none; b=b87nMHhtxoG4afrU7sfwwuyocthd/SoW0km9UBcI9I+smtwUra/LqlC7IKLtCt7uC9tMU9c/nFaxD7UvtjB18y3N9RxLrP86pekv5dapphCvomvX21hBETaGUpHVJcrORx3EErAgJMYoH7AD+Y6HpSm/dRG3taaU7ItKtZ1bKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636652; c=relaxed/simple;
	bh=q27S7ZZa+eBDIj98BLy7DaI14Ti0I47VLXciU6HMZns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRPKMhtlWtiuq4hYnWnf2M0JWvpW9ox61/OK+dvE4R/7Cl49jYek82BHI+tjBXiHdH9FwtB+sHQBKx8MO8mjM/dthlJSj6mkYyDh4rLrP+PSZra3LKajZykDh5Q9MOZwSdPAY79X/ubxy8dNpYH7MFfHBgpzYaBF3/Fz3AW25y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i82MdJAB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725636651; x=1757172651;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q27S7ZZa+eBDIj98BLy7DaI14Ti0I47VLXciU6HMZns=;
  b=i82MdJABCNe5xx6Zqda9/TI3BivgmXzwR8H7+J7TignV2ernObxz0MPE
   /k/U/v2+1yO7g/EeX1QqdrvKQRTEo+JR7vpOpxYPxf8L4Nx46M0CG4Bh+
   1HhfDErhTFwjYw/Gi93rsuG3rQzZNA9vseA6MPsKIWy+Sz8YsKSvb0aIk
   OgSFNi6t7ZKaFjZeSMTm+4e5cCvVIsrZh4faaBSfNLu+ZRCgSUWOGgwcX
   mFi5ef+psDIkBhpxX9J8KtAnv5EOThPvWpiiy11FftGENy2AVXlF9BlY6
   JhseveQ6wWHuLEzPTAgDMEftoUbX3v8jf/wMe6ENc27KUxKMylfiYmIAR
   A==;
X-CSE-ConnectionGUID: ABJW5D4vT9K63smKzkte5g==
X-CSE-MsgGUID: eqIhehkzQoaHhER8yxJOcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24594704"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="24594704"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 08:30:24 -0700
X-CSE-ConnectionGUID: HVZuwmf6SzWcptvpFSXOZA==
X-CSE-MsgGUID: EaDe0VGkTiylDH5JYdJJbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="70930636"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 08:30:24 -0700
Received: from [10.212.119.23] (kliang2-mobl1.ccr.corp.intel.com [10.212.119.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B87E020B5782;
	Fri,  6 Sep 2024 08:30:22 -0700 (PDT)
Message-ID: <8d47e4ec-d34a-4c24-ae40-82c5d2ea64e9@linux.intel.com>
Date: Fri, 6 Sep 2024 11:30:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Generic hotplug support for a PMU with a scope
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-kernel@vger.kernel.org
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240906151243.GY4723@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240906151243.GY4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-06 11:12 a.m., Peter Zijlstra wrote:
> On Fri, Aug 02, 2024 at 08:16:36AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The perf subsystem assumes that the counters of a PMU are per-CPU. So
>> the user space tool reads a counter from each CPU in the system wide
>> mode. However, many PMUs don't have a per-CPU counter. The counter is
>> effective for a scope, e.g., a die or a socket. To address this, a
>> cpumask is exposed by the kernel driver to restrict to one CPU to stand
>> for a specific scope. In case the given CPU is removed,
>> the hotplug support has to be implemented for each such driver.
>>
>> The codes to support the cpumask and hotplug are very similar.
>> - Expose a cpumask into sysfs
>> - Pickup another CPU in the same scope if the given CPU is removed.
>> - Invoke the perf_pmu_migrate_context() to migrate to a new CPU.
>> - In event init, always set the CPU in the cpumask to event->cpu
>> - Usually, an event can be read from any CPU of the scope. (For now,
>>   it is only supported by the pkg scope PMU, via
>>   PERF_EV_CAP_READ_ACTIVE_PKG, e.g., cstate_pkg, rapl, etc)
>>
>> Similar duplicated codes are implemented for each such PMU driver. It
>> would be good to introduce a generic infrastructure to avoid such
>> duplication.
>>
>> The patch series introduce 5 popular scopes, core, die, cluster, pkg,
>> and the system-wide. The PMU drivers for cstate, iommu, idxd and rapl
>> are updated to apply the new infrastructure. The new infrastructure
>> can also be applied for other PMU drivers from different ARCHs as well.
>> But I don't have such platforms. It's not done in this patch series.
>> They can be added later separately.
>>
>> The uncore driver isn't updated either. Because a per-PMU cpumask is
>> required since commit c74443d92f68 ("perf/x86/uncore: Support per PMU
>> cpumask"). Since different types of PMU share the same hotplug codes,
>> more factor out works and verification are expected. The cleanup of the
>> uncore driver can be done later separately.
>>
>> Kan Liang (7):
>>   perf: Generic hotplug support for a PMU with a scope
>>   perf: Add PERF_EV_CAP_READ_SCOPE
>>   perf/x86/intel/cstate: Clean up cpumask and hotplug
>>   iommu/vt-d: Clean up cpumask and hotplug
>>   dmaengine: idxd: Clean up cpumask and hotplug
>>   perf/x86/rapl: Move the pmu allocation out of CPU hotplug
>>   perf/x86/rapl: Clean up cpumask and hotplug
>>
>>  arch/x86/events/intel/cstate.c | 140 +-------------------------
>>  arch/x86/events/rapl.c         | 119 ++++++----------------
> 
> Looks like we have another RAPL driver in:
> 
>   drivers/powercap/intel_rapl_common.c
> 
> that wants to be converted.

Right, but I need to talk with the power guys first. I have a vague
impression that some of the counters are not exactly PKG scope.

Thanks,
Kan

