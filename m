Return-Path: <linux-kernel+bounces-230804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B007991820F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5692C28699F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3018A94D;
	Wed, 26 Jun 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rj+c4Qfn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A48184119
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407508; cv=none; b=q4RRrGrCPowQJiR2dPK7swQKGvVbB0Kw08cqH0QYJ4QyaE8B2tqubLRCXzRQIo7IuO9l05vtypkAmk446YwyAJqqh+ZFf8CfPJrcg1Bi8JNTooy2LGPT10VL7J8Qk6mBPL2fOZkEQTV6AWeN2S1FvTexARNw6qdrmiJyH45zC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407508; c=relaxed/simple;
	bh=qvMJ5bUN02mqqbvpZUWGCMYagD/zh1vH0Q1modm4hJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XW5rJ/9SM4LvrQN6fd26n1ayL4Tg3vxS5i6EPGOJuFm9UMtuPzZs0aWQnwVazRVmhfNmKNd3UieLez+aqJmeYKaIDtbn5CJqOA+ymINJjBBp5wlGOPd67YDqa21FKA1sAwX5I56hOewpparL380Dx/X/nw686Y0lrGFppqItvK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rj+c4Qfn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719407506; x=1750943506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qvMJ5bUN02mqqbvpZUWGCMYagD/zh1vH0Q1modm4hJg=;
  b=Rj+c4QfngBNSoUKcB9xFBmCh21S+c/818vf9SC699Upy6ikKYM2d2sb8
   PxnlB2EvqD+gkGl+KctkhW+BR/agaHweebZvDz5yoUTHRYVjAMaIC66FF
   YNBHBSUtsuYjX8nakbbbRMF/YpmgFMV18MS2JOodLqjf4Ty09SMnYtdFn
   699pzJZlG1uFbjkXcQBoqKxdCN9+wb4fFw9GBd9PvyXkvHO3YW7YIRdng
   3K94DhijugPeBltOfhSd4VGaVc0+0vG1lqgjefhAhUQLACcUzNaZlN7gs
   4nHzcw/pgUgYmrDUyxfg1SfHoDYtyb9fSRVK44nh4wAgfDb/YcvsNV5H0
   g==;
X-CSE-ConnectionGUID: W2weJipHQxuWODn68P0A7g==
X-CSE-MsgGUID: LK9jHU52TteDHJdAvJ7oJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16357529"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16357529"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 06:11:45 -0700
X-CSE-ConnectionGUID: BrRmKNneTk26zUR/DXFm4g==
X-CSE-MsgGUID: EGKtTtYTQUiDLl6fb8vxaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="49164370"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 06:11:46 -0700
Received: from [10.212.45.60] (kliang2-mobl1.ccr.corp.intel.com [10.212.45.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 320D420B5703;
	Wed, 26 Jun 2024 06:11:44 -0700 (PDT)
Message-ID: <2a4a8ef5-a292-42a8-80fa-a2e8373ab375@linux.intel.com>
Date: Wed, 26 Jun 2024 09:11:42 -0400
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXvmDSPVOWhcNzSZ7icBh6PhdgpbopFCZgzZWYk_kGadA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-06-26 1:20 a.m., Ian Rogers wrote:
> On Tue, Jun 25, 2024 at 11:22 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Changes since V1:
>> - Add x86/intel_pmu_max_num_pebs/counters/counters_fixed()
>> - Rename model-specific pebs_latency_data functions
>> - Rename V6 counter MSRs
>>
>> From the core PMU' perspective, the Lunar Lake and Arrow Lake are the
>> same, which are similar to the previous generation Meteor Lake. Both are
>> hybrid platforms, with e-core and p-core.
>>
>> The key differences include:
>> - The e-core supports 3 new fixed counters
>> - The p-core supports an updated PEBS Data Source format
>> - More GP counters (Updated event constraint table)
>> - New Architectural performance monitoring V6
>>   (New Perfmon MSRs aliasing, umask2, eq).
>> - New PEBS format V6 (Counters Snapshotting group)
>> - New RDPMC metrics clear mode
>>
>> The details for the above new features can be found in the Intel
>> Architecture Instruction Set Extensions and Future Features (052).
>> https://cdrdv2.intel.com/v1/dl/getContent/671368
>>
>> The counters may not be continuous anymore. Patch 1-2 converts the max
>> number of counters to a mask of counters. The change is a generic change
>> which impacts all X86 platforms.
>>
>> Patch 3-4 supports all the legacy features on LNL and ARL.
>>
>> Patch 5-7 supports the new Architectural performance monitoring V6.
>>
>> Patch 8-11 supports the new PEBS format V6.
>>
>> Patch 12 supports the new RDPMC metrics clear mode.
>>
>> Kan Liang (13):
>>   perf/x86/intel: Support the PEBS event mask
>>   perf/x86: Support counter mask
>>   perf/x86: Add Lunar Lake and Arrow Lake support
>>   perf/x86/intel: Rename model-specific pebs_latency_data functions
>>   perf/x86/intel: Support new data source for Lunar Lake
>>   perf/x86: Add config_mask to represent EVENTSEL bitmask
>>   perf/x86/intel: Support PERFEVTSEL extension
>>   perf/x86/intel: Support Perfmon MSRs aliasing
>>   perf/x86: Extend event update interface
>>   perf: Extend perf_output_read
>>   perf/x86/intel: Move PEBS event update after the sample output
>>   perf/x86/intel: Support PEBS counters snapshotting
>>   perf/x86/intel: Support RDPMC metrics clear mode
> 
> Fwiw and beside the nit:
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!

> 
> It seems some of the behaviors could have tests upon them, would it be
> possible to add them skipping the test on older and non-Intel
> architectures?

I think only the two features (Architectural performance monitoring V6
and the RDPMC metrics clear mode) add new formats, which impacts the ABI.

The perf tool has a "Sysfs PMU tests" case to verify the event format.
It creates a fake sysfs mount to verify all the possible format
definitions, rather than the real format on a given machine.

I think the test case make sense, since it's impossible to test all the
formats. As long as all the possible combinations of the format
definition are supported, the perf tool should be good.

The umask becomes non-contiguous in V6. There is already a case in the
"Sysfs PMU tests" to cover such format definition.
The current perf test should be good enough to cover the ABI changes.

9: Sysfs PMU tests                                                 :
9.1: Parsing with PMU format directory                             : Ok
9.2: Parsing with PMU event                                        : Ok
9.3: PMU event names                                               : Ok
9.4: PMU name combining                                            : Ok
9.5: PMU name comparison                                           : Ok
Thanks,
Kan
> 
> Thanks,
> Ian
> 
>>  arch/x86/events/amd/core.c           |  26 +-
>>  arch/x86/events/core.c               | 123 +++----
>>  arch/x86/events/intel/core.c         | 471 ++++++++++++++++++++-------
>>  arch/x86/events/intel/ds.c           | 288 +++++++++++++---
>>  arch/x86/events/intel/knc.c          |   2 +-
>>  arch/x86/events/intel/p4.c           |  12 +-
>>  arch/x86/events/intel/p6.c           |   2 +-
>>  arch/x86/events/perf_event.h         | 105 +++++-
>>  arch/x86/events/perf_event_flags.h   |   2 +-
>>  arch/x86/events/zhaoxin/core.c       |  14 +-
>>  arch/x86/include/asm/intel_ds.h      |   1 +
>>  arch/x86/include/asm/msr-index.h     |   6 +
>>  arch/x86/include/asm/perf_event.h    |  27 ++
>>  include/uapi/linux/perf_event.h      |   6 +-
>>  kernel/events/core.c                 |  15 +-
>>  tools/perf/Documentation/topdown.txt |   9 +-
>>  16 files changed, 839 insertions(+), 270 deletions(-)
>>
>> --
>> 2.35.1
>>
> 

