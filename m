Return-Path: <linux-kernel+bounces-324083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEA09747BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF081C259E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86311E87B;
	Wed, 11 Sep 2024 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXzzh+ll"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5555B660
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726017970; cv=none; b=N9Fyj1sIiJ1dc8fR7sNxrhhFhmsuwEp9Srt/H1kljSg82zO9Q6ULaWOqdFUsGeiRsiOZb0UdJFoZ/vSAPMZdIMUutBIyUkFH54d24c0lyvSm/MmvdnwnGmn5K53vdZqfu3U1pAK4QaqmWe00QMQ+SDwGNYfb95Qg/LMoQrLK89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726017970; c=relaxed/simple;
	bh=55dLKbjd4k3GAkqckVjG1s3EfiAs+xXe3S1H13He4Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k777qn1+qA8wBUkXiYoo2Xild0zEiKvueBvshkFLMxlJhN7Y3wVV0j0jfo133dJocLPWUfxSMYeg9h097m7O17JGz0A5vUh0gdOHKVC7g/MsXs8UQnFLASYcKfpfI/92/Mkaxod57AhDLHpmtrh2ivoZJaGhKKvMhlbskI5TrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXzzh+ll; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726017969; x=1757553969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=55dLKbjd4k3GAkqckVjG1s3EfiAs+xXe3S1H13He4Kc=;
  b=BXzzh+llSbrtEJnbdP/drzSUXH4q4ZJYdldz9nTtrzHhK3wzS9S8B+Ai
   SJr7n2Alt765pbwztfKZwwwISS+HyMzT7AyetolNN+c086iyE0jgkU+7F
   gYLNGLHiIE+i/8e6ZxRsck/6v8z+q9uNl6ZtoZBjHsTmRoaFIFJ57TTA+
   ZdJ6QyP3aUw17f8TTgemPlFpIRMTQqB4RU4BoRGIbe33BIMdCTV4AcShb
   iuzctR0C2Gleg28ffb8BDDaqyWLmSa9F0TiNoFGu3HHQ4Era4vaK2oH6M
   Mymff2pPoZfTHFASYeZI1DSdoQ5JRVwblhHEnQ4i/anc6SceDXcWlEgb4
   A==;
X-CSE-ConnectionGUID: d1Uqyeg/SwOSKUPBD2gUgQ==
X-CSE-MsgGUID: 6htGqkD6R+iohp52JwxGOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24290494"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="24290494"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 18:26:08 -0700
X-CSE-ConnectionGUID: Zbwq4DIgSXW6ARspI58veg==
X-CSE-MsgGUID: LuUwO+iXR0W5hj17TYD3SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="67057183"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.229.37]) ([10.124.229.37])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 18:26:04 -0700
Message-ID: <0525e13d-7439-4b42-af69-85aa33f5d3c8@linux.intel.com>
Date: Wed, 11 Sep 2024 09:26:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 0/4] Enable PMU for ArrowLake-H
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240820073853.1974746-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20240820073853.1974746-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/20/2024 3:38 PM, Dapeng Mi wrote:
> No code changes comparing v2, just add back the missed reviewed-by.
>
> Changes:
>   v2 -> v3:
>     * Add Kan's review-by.
>   v1 -> v2:
>     * Change PMU name of 2nd atom uarch cores to "cpu_lowpower" (Peter)
>     * Rename "hybrid_small2" to "hybrid_tiny" (Peter)
>     * Rebase to 6.11-rc4
>
> History:
>   * v2: https://lore.kernel.org/all/20240819145543.1833126-1-dapeng1.mi@linux.intel.com/
>   * v1: https://lore.kernel.org/all/20240808140210.1666783-1-dapeng1.mi@linux.intel.com/
>
> Dapeng Mi (4):
>   perf/x86: Refine hybrid_pmu_type defination
>   x86/cpu/intel: Define helper to get CPU core native ID
>   perf/x86/intel: Support hybrid PMU with multiple atom uarchs
>   perf/x86/intel: Add PMU support for ArrowLake-H
>
>  arch/x86/events/intel/core.c | 129 ++++++++++++++++++++++++++++++++---
>  arch/x86/events/intel/ds.c   |  21 ++++++
>  arch/x86/events/perf_event.h |  34 ++++++---
>  arch/x86/include/asm/cpu.h   |   6 ++
>  arch/x86/kernel/cpu/intel.c  |  15 ++++
>  5 files changed, 187 insertions(+), 18 deletions(-)
>
>
> base-commit: 47ac09b91befbb6a235ab620c32af719f8208399

Hi Peter, could you please kindly review this new version patchset? Thanks.



