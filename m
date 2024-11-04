Return-Path: <linux-kernel+bounces-395508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD8F9BBEDE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCF0282BCF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FF41CC177;
	Mon,  4 Nov 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPUEjxTJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62E1F6666
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752633; cv=none; b=HquRcJL+KkAiqzq+o4yTUQntTqadl1a4wVh8kHpFzl7vCeLSrLDR32gJjHMg3tsOD5GLvCEXcIVTekYrZA+wbAYng7bbnv98eJZqsfqcLFEWDUKMTWMxpQXe/daIusvcZmGGu2XU7wigZHgQBQGR17Ma/pDP9n9vlhqZ9n8cbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752633; c=relaxed/simple;
	bh=Guwysl2O3tRoWL5qZmEUZDmsCr5aph8nqMI04YcoB9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvG8QNp4bFsGxme1kMJEVqqmsdDw800lzIneuK/iliq7wyZEIb/RwM/aZGIh4mkSB5arGxTwcOJvcGRT9IHDhWE0ByCK5eYpc6/Y98o3x++wk1Fn2Iov5Eo4d9xSuRvL5CA0EvbYmRs2TDceMyhvbBIL8iZKFVgqcWOCehNqlaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPUEjxTJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730752632; x=1762288632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Guwysl2O3tRoWL5qZmEUZDmsCr5aph8nqMI04YcoB9c=;
  b=FPUEjxTJl601DUv+HqXqZ0EK/+Qq2o0Lf4sX2dpvWqettVuHEIgf2dS2
   4Rqx4uFPtrVndlBqJWQXQNJx9vaBSS2aiptA5MPEL9tdRoNwc6bxbkcd4
   /q3u6H9yoA1pbY+sFoF8nDu06vdEtfAofEZRIEGO2ikHjO55hPVBzGqj8
   SFQePnnwy3l63UbwDkmdI4d6xB42ov0UI+ylPuTVIdQyC9ePenIzHgIiM
   MTlcOek0wsBYezTUVZgoBllOxjYTCAhzRLPHeF8sqnQadaRUuwYi7rqLk
   yJv7sOtMDDa2qMuEkBdo3fyjNa1uT5CZUMRmRh9aNg/+J0xDFMr3V08v0
   Q==;
X-CSE-ConnectionGUID: 1gNWUUR3QDiEYq8zJdm5Pg==
X-CSE-MsgGUID: 8ibXk608RQS1VHwIPEoDgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="47978159"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="47978159"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 12:37:11 -0800
X-CSE-ConnectionGUID: 6s6OyJi5QdCY4bTF1fOnEg==
X-CSE-MsgGUID: uGhsO/UwQvacQL/Uf3ZaIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="121243540"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 12:37:11 -0800
Received: from [10.212.67.175] (kliang2-mobl1.ccr.corp.intel.com [10.212.67.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9E53720B5703;
	Mon,  4 Nov 2024 12:37:09 -0800 (PST)
Message-ID: <7fa16a12-2b31-4bab-893e-ba4fe017339b@linux.intel.com>
Date: Mon, 4 Nov 2024 15:37:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/3] Support auto counter reload
To: peterz@infradead.org, mingo@kernel.org, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 ak@linux.intel.com, linux-kernel@vger.kernel.org
Cc: eranian@google.com, thomas.falcon@intel.com
References: <20241010192844.1006990-1-kan.liang@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241010192844.1006990-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Peter,

Ping. Could you please let me know if you have any comments.

Thanks,
Kan

On 2024-10-10 3:28 p.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V1:
> - Add a check to the reload value which cannot exceeds the max period
> - Avoid invoking intel_pmu_enable_acr() for the perf metrics event.
> - Update comments explain to case which the event->attr.config2 exceeds
>   the group size
> 
> The relative rates among two or more events are useful for performance
> analysis, e.g., a high branch miss rate may indicate a performance
> issue. Usually, the samples with a relative rate that exceeds some
> threshold are more useful. However, the traditional sampling takes
> samples of events separately. To get the relative rates among two or
> more events, a high sample rate is required, which can bring high
> overhead. Many samples taken in the non-hotspot area are also dropped
> (useless) in the post-process.
> 
> Auto Counter Reload (ACR) provides a means for software to specify that,
> for each supported counter, the hardware should automatically reload the
> counter to a specified initial value upon overflow of chosen counters.
> This mechanism enables software to sample based on the relative rate of
> two (or more) events, such that a sample (PMI or PEBS) is taken only if
> the rate of one event exceeds some threshold relative to the rate of
> another event. Taking a PMI or PEBS only when the relative rate of
> perfmon events crosses a threshold can have significantly less
> performance overhead than other techniques.
> 
> The details can be found at Intel Architecture Instruction Set
> Extensions and Future Features (053) 8.7 AUTO COUNTER RELOAD.
> 
> Examples:
> 
> Here is the snippet of the mispredict.c. Since the array has random
> numbers, jumps are random and often mispredicted.
> The mispredicted rate depends on the compared value.
> 
> For the Loop1, ~11% of all branches are mispredicted.
> For the Loop2, ~21% of all branches are mispredicted.
> 
> main()
> {
> ...
>         for (i = 0; i < N; i++)
>                 data[i] = rand() % 256;
> ...
>         /* Loop 1 */
>         for (k = 0; k < 50; k++)
>                 for (i = 0; i < N; i++)
>                         if (data[i] >= 64)
>                                 sum += data[i];
> ...
> 
> ...
>         /* Loop 2 */
>         for (k = 0; k < 50; k++)
>                 for (i = 0; i < N; i++)
>                         if (data[i] >= 128)
>                                 sum += data[i];
> ...
> }
> 
> Usually, a code with a high branch miss rate means a bad performance.
> To understand the branch miss rate of the codes, the traditional method
> usually sample both branches and branch-misses events. E.g.,
> perf record -e "{cpu_atom/branch-misses/ppu, cpu_atom/branch-instructions/u}"
>                -c 1000000 -- ./mispredict
> 
> [ perf record: Woken up 4 times to write data ]
> [ perf record: Captured and wrote 0.925 MB perf.data (5106 samples) ]
> The 5106 samples are from both events and spread in both Loops.
> In the post process stage, a user can know that the Loop 2 has a 21%
> branch miss rate. Then they can focus on the samples of branch-misses
> events for the Loop 2.
> 
> With this patch, the user can generate the samples only when the branch
> miss rate > 20%.
> perf record -e "{cpu_atom/branch-misses,period=200000,acr_mask=0x2/ppu,
>                  cpu_atom/branch-instructions,period=1000000,acr_mask=0x3/u}"
>                 -- ./mispredict
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.098 MB perf.data (2498 samples) ]
> 
>  $perf report
> 
> Percent       │154:   movl    $0x0,-0x14(%rbp)
>               │     ↓ jmp     1af
>               │     for (i = j; i < N; i++)
>               │15d:   mov     -0x10(%rbp),%eax
>               │       mov     %eax,-0x18(%rbp)
>               │     ↓ jmp     1a2
>               │     if (data[i] >= 128)
>               │165:   mov     -0x18(%rbp),%eax
>               │       cltq
>               │       lea     0x0(,%rax,4),%rdx
>               │       mov     -0x8(%rbp),%rax
>               │       add     %rdx,%rax
>               │       mov     (%rax),%eax
>               │    ┌──cmp     $0x7f,%eax
> 100.00   0.00 │    ├──jle     19e
>               │    │sum += data[i];
> 
> The 2498 samples are all from the branch-misses events for the Loop 2.
> 
> The number of samples and overhead is significantly reduced without
> losing any information.
> 
> Kan Liang (3):
>   perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
>   perf/x86/intel: Add the enumeration and flag for the auto counter
>     reload
>   perf/x86/intel: Support auto counter reload
> 
>  arch/x86/events/intel/core.c       | 262 ++++++++++++++++++++++++++++-
>  arch/x86/events/perf_event.h       |  21 +++
>  arch/x86/events/perf_event_flags.h |   2 +-
>  arch/x86/include/asm/msr-index.h   |   4 +
>  arch/x86/include/asm/perf_event.h  |   4 +-
>  include/linux/perf_event.h         |   2 +
>  6 files changed, 288 insertions(+), 7 deletions(-)
> 


