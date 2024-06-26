Return-Path: <linux-kernel+bounces-231354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7863919010
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C985B1C2150B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F57190465;
	Wed, 26 Jun 2024 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6nFIkgm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2414EC59
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428114; cv=none; b=t5TQstbeUpo2HK3QdHFulqXfYj3R8cYaY/tWFcrYt+b79/EMwEMuix72jYaK4x+ehwX1m/kzX045mS4t669qVz6QRDNAG+KOFeQJH3OhRd6c6bUsIErQnym+sEz/AGvbYO3rY/MRYIXM3P0Sbg2JRQFJwczqLiGDIDj7Wy1HmHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428114; c=relaxed/simple;
	bh=guldabG94uC4/EebUoISaIDxtFAMupCpcqfJiUEwxY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYV0O0/k46BwcljsUzcDkCMYD1OuSa4fMDFb+gEzs8USY3rn0hE1mBIdO7dWHts/v7C81zT0HGDBL8C80MPoAPw27yhHJB6gzJ5d4O3or8AfY/vs5rU63LqU92dzRrmoP94yxuLzwPatF6gdv8YShlD8U6iqLjrGJ9KMyiT7ZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6nFIkgm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719428112; x=1750964112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=guldabG94uC4/EebUoISaIDxtFAMupCpcqfJiUEwxY0=;
  b=H6nFIkgmeYdYQaknz6hIiwVsjEiMYknPB4sL4XTeQZTetRQkaFfeZn8+
   V5av9vhzv6WWURr0WLpvYQYQYnoK7w64fQ9+ZIqj8TZFkJFYcPmo9rUYP
   CXJLT3/o+elSFqUL7149pI97j4JiCV4bCX5GI8eu2CKepChx/blYJFgdC
   9FiQCSeWlPIuCAwf18W+WLLD+bDLbctFHVzZr2+4UdzDv8bsPz+g3UYo0
   rwS2rmU+Zr4LPl/aRlrsY+gLrO7iWkD481Av+RVFSiUY0ivxlrWqKA/Eg
   JRMq3DTGQTs0ZTBd95vG+n30dPN//6q4jxoNJvVi+xsrMRr2FnMoxDKTv
   Q==;
X-CSE-ConnectionGUID: 19dgkRELRnaOkNzDkQtBKQ==
X-CSE-MsgGUID: XFQ1SFQqTzSR3DZdr/0QBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16670764"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16670764"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 11:55:11 -0700
X-CSE-ConnectionGUID: k/fytwsVRcalnASeZajMLQ==
X-CSE-MsgGUID: SZuGrkGOT8CKp0es5fJAPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="44207761"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 11:55:12 -0700
Received: from [10.212.45.60] (kliang2-mobl1.ccr.corp.intel.com [10.212.45.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 94FA120B5703;
	Wed, 26 Jun 2024 11:55:10 -0700 (PDT)
Message-ID: <a5b216b0-6b02-46c4-a26f-7acceb1e6b3d@linux.intel.com>
Date: Wed, 26 Jun 2024 14:55:09 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/13] Support Lunar Lake and Arrow Lake core PMU
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@kernel.org, acme@kernel.org,
 namhyung@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com
References: <20240625182256.291914-1-kan.liang@linux.intel.com>
 <CAP-5=fXvmDSPVOWhcNzSZ7icBh6PhdgpbopFCZgzZWYk_kGadA@mail.gmail.com>
 <2a4a8ef5-a292-42a8-80fa-a2e8373ab375@linux.intel.com>
 <CAP-5=fUkg-cAXTb+3wbFOQCfdXgpQeZw40XHjfrNFbnBD=NMXg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUkg-cAXTb+3wbFOQCfdXgpQeZw40XHjfrNFbnBD=NMXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-06-26 1:22 p.m., Ian Rogers wrote:
> On Wed, Jun 26, 2024 at 6:11 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-06-26 1:20 a.m., Ian Rogers wrote:
>>> On Tue, Jun 25, 2024 at 11:22 AM <kan.liang@linux.intel.com> wrote:
>>>>
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> Changes since V1:
>>>> - Add x86/intel_pmu_max_num_pebs/counters/counters_fixed()
>>>> - Rename model-specific pebs_latency_data functions
>>>> - Rename V6 counter MSRs
>>>>
>>>> From the core PMU' perspective, the Lunar Lake and Arrow Lake are the
>>>> same, which are similar to the previous generation Meteor Lake. Both are
>>>> hybrid platforms, with e-core and p-core.
>>>>
>>>> The key differences include:
>>>> - The e-core supports 3 new fixed counters
>>>> - The p-core supports an updated PEBS Data Source format
>>>> - More GP counters (Updated event constraint table)
>>>> - New Architectural performance monitoring V6
>>>>   (New Perfmon MSRs aliasing, umask2, eq).
>>>> - New PEBS format V6 (Counters Snapshotting group)
>>>> - New RDPMC metrics clear mode
>>>>
>>>> The details for the above new features can be found in the Intel
>>>> Architecture Instruction Set Extensions and Future Features (052).
>>>> https://cdrdv2.intel.com/v1/dl/getContent/671368
>>>>
>>>> The counters may not be continuous anymore. Patch 1-2 converts the max
>>>> number of counters to a mask of counters. The change is a generic change
>>>> which impacts all X86 platforms.
>>>>
>>>> Patch 3-4 supports all the legacy features on LNL and ARL.
>>>>
>>>> Patch 5-7 supports the new Architectural performance monitoring V6.
>>>>
>>>> Patch 8-11 supports the new PEBS format V6.
>>>>
>>>> Patch 12 supports the new RDPMC metrics clear mode.
>>>>
>>>> Kan Liang (13):
>>>>   perf/x86/intel: Support the PEBS event mask
>>>>   perf/x86: Support counter mask
>>>>   perf/x86: Add Lunar Lake and Arrow Lake support
>>>>   perf/x86/intel: Rename model-specific pebs_latency_data functions
>>>>   perf/x86/intel: Support new data source for Lunar Lake
>>>>   perf/x86: Add config_mask to represent EVENTSEL bitmask
>>>>   perf/x86/intel: Support PERFEVTSEL extension
>>>>   perf/x86/intel: Support Perfmon MSRs aliasing
>>>>   perf/x86: Extend event update interface
>>>>   perf: Extend perf_output_read
>>>>   perf/x86/intel: Move PEBS event update after the sample output
>>>>   perf/x86/intel: Support PEBS counters snapshotting
>>>>   perf/x86/intel: Support RDPMC metrics clear mode
>>>
>>> Fwiw and beside the nit:
>>>
>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>
>> Thanks!
>>
>>>
>>> It seems some of the behaviors could have tests upon them, would it be
>>> possible to add them skipping the test on older and non-Intel
>>> architectures?
>>
>> I think only the two features (Architectural performance monitoring V6
>> and the RDPMC metrics clear mode) add new formats, which impacts the ABI.
>>
>> The perf tool has a "Sysfs PMU tests" case to verify the event format.
>> It creates a fake sysfs mount to verify all the possible format
>> definitions, rather than the real format on a given machine.
>>
>> I think the test case make sense, since it's impossible to test all the
>> formats. As long as all the possible combinations of the format
>> definition are supported, the perf tool should be good.
>>
>> The umask becomes non-contiguous in V6. There is already a case in the
>> "Sysfs PMU tests" to cover such format definition.
>> The current perf test should be good enough to cover the ABI changes.
>>
>> 9: Sysfs PMU tests                                                 :
>> 9.1: Parsing with PMU format directory                             : Ok
>> 9.2: Parsing with PMU event                                        : Ok
>> 9.3: PMU event names                                               : Ok
>> 9.4: PMU name combining                                            : Ok
>> 9.5: PMU name comparison                                           : Ok
> 
> That's good. I was thinking more about leader sampling testing. We
> have an attribute test and an event parsing test, but nothing that
> currently tests leader sampling actually works even if it is just a
> coverage test. 

Yes, the sampling read test is missed.

> We could do something like this:
> 
> ```
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 3d1a7759a7b2..9b61e2d01c9e 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -190,11 +190,29 @@ test_branch_counter() {
>   echo "Basic branch counter test [Success]"
> }
> 
> +test_leader_sampling() {
> +  echo "Basic leader sampling test"
> +  if ! perf record -o "${perfdata}" -g -e
> "{instructions,branch-misses}:S" ${testprog} 2> /dev/null
> +  then
> +    echo "Leader sampling [Failed record]"
> +    err=1
> +    return
> +  fi
> +  if ! perf script -D -i "${perfdata}" | grep -q "sample_read:"
> +  then
> +    echo "Leader sampling [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  echo "Basic leader sampling test [Success]"
> +}
> +
> test_per_thread
> test_register_capture
> test_system_wide
> test_workload
> test_branch_counter
> +test_leader_sampling
> 
> cleanup
> exit $err
> ```
> 
> But it'd be nice if we had coverage of things like fixed counters vs
> generic, the improvements now fixed in LNL, etc.

The improvements in LNL should be transparent for the perf tool. It just
changes the places where to read the counter (from "directly read the HW
counter" to "read it in a PEBS record"). It is hard to design a perf
tool test case to verify the small difference.

But, I guess we can choose proper events to test the fixed counters vs
generic.

Also, there are some special cases for the sampling read. For example,
the AUX area event and the Topdown slots event cannot be sampled. If
they are the leader, the next event will be the sampling event.
We may also design a case to cover it as well.

I will think about it and send a separate patch to cover the sampling read.

Thanks,
Kan

> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>>
>>> Thanks,
>>> Ian
>>>
>>>>  arch/x86/events/amd/core.c           |  26 +-
>>>>  arch/x86/events/core.c               | 123 +++----
>>>>  arch/x86/events/intel/core.c         | 471 ++++++++++++++++++++-------
>>>>  arch/x86/events/intel/ds.c           | 288 +++++++++++++---
>>>>  arch/x86/events/intel/knc.c          |   2 +-
>>>>  arch/x86/events/intel/p4.c           |  12 +-
>>>>  arch/x86/events/intel/p6.c           |   2 +-
>>>>  arch/x86/events/perf_event.h         | 105 +++++-
>>>>  arch/x86/events/perf_event_flags.h   |   2 +-
>>>>  arch/x86/events/zhaoxin/core.c       |  14 +-
>>>>  arch/x86/include/asm/intel_ds.h      |   1 +
>>>>  arch/x86/include/asm/msr-index.h     |   6 +
>>>>  arch/x86/include/asm/perf_event.h    |  27 ++
>>>>  include/uapi/linux/perf_event.h      |   6 +-
>>>>  kernel/events/core.c                 |  15 +-
>>>>  tools/perf/Documentation/topdown.txt |   9 +-
>>>>  16 files changed, 839 insertions(+), 270 deletions(-)
>>>>
>>>> --
>>>> 2.35.1
>>>>
>>>

