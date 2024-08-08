Return-Path: <linux-kernel+bounces-279827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BB194C24C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D842282BE6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846C8190480;
	Thu,  8 Aug 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPKTu6O6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A2319047A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133254; cv=none; b=TNx6ICPbJw+jAAZEtZrOUpxAy2YE4nxIis1cVAdzZLNPftcHImgxRYdvTYFEaraLoALjud+WdPeXZUZ/xAaKdlNyrQh8HqcWFxyg6K2380F/y96TPuWKqmMeeVFpLjo5inPggoAUDADqzTSR1S/u/AlfBDLe1yFu9CS0nG0PyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133254; c=relaxed/simple;
	bh=iBuvNDtr8sQijZU8uNHCONv7MRMCENObhUoZXwML5Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eapnB4ALwSQqsI2mIhDyuMhfkVykg0j1EGLj2UQ7ABpYA24qse5V09tc17C4RSthdChADJlRBkUaoM0/W1vufbIq2LJ3w3crrZB2PEGytEng8LAtCOm/4lgmZqoLEn+7oYubOScsxJI//rePoM1/zO5ClFqaOGbWRZTMwQXofsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPKTu6O6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723133253; x=1754669253;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iBuvNDtr8sQijZU8uNHCONv7MRMCENObhUoZXwML5Ds=;
  b=SPKTu6O6XG4cYoRfzMcwAS25f/i7CZP17haXytn5iQ3b9GGKDNzpNP4A
   loGuVAdynkEy9eske+/udI/aaaUmOTf2mnaFjtbXToqd9uEs69Aa4xs97
   R+Bg3ZLyniNNxSGl4D1ZD082EPUOdwMerZI58Ue/cxcKYxCbpacpM8QiI
   RpACke6Lufh+Idvjln1w47EWcT+potgRIlAqXYCeQIxq0tUEcCeoD3aN8
   I8+JuB1YqF/DfHMVVaqLQXCJyT6biS+STZ1MQw0r1s8Bn0AdjXfjBolw/
   /XBi3Oppxmi3IeJKDwuwIlbeQx7YhY0GqKCEe4tW72An7wzWuDBfXSJzQ
   Q==;
X-CSE-ConnectionGUID: qfUY7137Q6K3oA+A0qqJaA==
X-CSE-MsgGUID: PF0W2CP4T+6Cd38P3HBz5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21439490"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21439490"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 09:07:32 -0700
X-CSE-ConnectionGUID: jwJIlJS1SvG1j5pbDvuXCA==
X-CSE-MsgGUID: jIq4BBJ4TpKqknR1vRtBLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="87922090"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 09:07:32 -0700
Received: from [10.212.64.50] (kliang2-mobl1.ccr.corp.intel.com [10.212.64.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 99A8320CFED4;
	Thu,  8 Aug 2024 09:07:29 -0700 (PDT)
Message-ID: <3a49f9e8-b188-468d-933b-31f176e599d8@linux.intel.com>
Date: Thu, 8 Aug 2024 12:07:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Enable PMU for ArrowLake-H
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Zhenyu Wang <zhenyuw@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-08 10:02 a.m., Dapeng Mi wrote:
> ArrowLake-H is a specific variant of regular ArrowLake. It shares same
> PMU features on lioncove P-cores and skymont E-cores with regular
> ArrowLake except ArrowLake-H adds extra crestmont uarch E-cores.
> 
> Thus ArrowLake-H contains two different atom uarchs. This is totally
> different with previous Intel hybrid platforms which contains only one
> kind of atom uarchs. In this case, it's not enough to distinguish the
> uarchs just by core type. So CPUID.1AH.EAX[23:0] provides an unique
> native model ID for each uarch, this unique native model ID combining
> the core type can be used to uniquely identity the uarch.
> 
> This patch series introduces PMU support for ArrowLake-H. Besides
> inheriting the same PMU support from regular ArrowLake, it leverages
> the native model ID to detect the 2nd kind of atom uarch core and
> enables PMU support. To distinguish the two atom uarchs in sysfs, the
> PMU of 2nd atom uarch is named to "cpu_atom2".
> 
> Run basic counting, PMI based sampling, PEBS based sampling, LBR and
> topdown metrics tests on ArrowLake-H platform, no issue is found.
> 
> Dapeng Mi (4):
>   perf/x86: Refine hybrid_pmu_type defination
>   x86/cpu/intel: Define helper to get CPU core native ID
>   perf/x86/intel: Support hybrid PMU with multiple atom uarchs
>   perf/x86/intel: Add PMU support for ArrowLake-H

For the series,

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> 
>  arch/x86/events/intel/core.c | 129 ++++++++++++++++++++++++++++++++---
>  arch/x86/events/intel/ds.c   |  21 ++++++
>  arch/x86/events/perf_event.h |  33 ++++++---
>  arch/x86/include/asm/cpu.h   |   6 ++
>  arch/x86/kernel/cpu/intel.c  |  15 ++++
>  5 files changed, 186 insertions(+), 18 deletions(-)
> 
> 
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b

