Return-Path: <linux-kernel+bounces-315030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30CB96BCB6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B30286FA9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DD41D9344;
	Wed,  4 Sep 2024 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lx6Esf6p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AE1D58B0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453891; cv=none; b=dDYrraMwJQkF5mCDkQFtVUAYshyv/VlvWeLcHgk+D+t9Xh+pleKttvbD8k+l/SABJ92chEH5KOCG2VfDS5NTTsO/wOLHmBhIY1pF5OFPE+i/N84lNkdL0NtzkWZzu76puertZdKRg81VTeknocQLpUKSQF/Ofkd8j3OOB0yKPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453891; c=relaxed/simple;
	bh=v7fVXR7pVzAugjJ5b6domRUKEYCHm+1h1VQHWRwd2Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IGd1FSn0VFmPf9qZgNNryA5ZcdtuuUUEXqgjHSSbLgE07y/9b57IF1jG5cKeVuGPa0s2r77Fgbgx6f/snjAJMqjGg8ZjIucBCDLPFKcEWrjtITvmyTMCFyJkZ33VVxmq8BNkG6IoKqKchmoU8BR6llqH8KazD1SgwjTbf6KVWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lx6Esf6p; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725453890; x=1756989890;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=v7fVXR7pVzAugjJ5b6domRUKEYCHm+1h1VQHWRwd2Vg=;
  b=lx6Esf6p/1/+3w5+LIDqGO1NCo2aFRzHYFjxtVG2KtJpII8jtg+IUHaE
   O1878IPx6z5+7PFFjAk0FL6GXlpXpWGUQwZjmc6mUWHyRSgmP+3zVjOSN
   +Xay/jLjLSblWoJiZdHUfjKAaIxEn3GDCssRrgKbj29gYZk0W1X6pZkHC
   28OF7uLKTSLD6/Gctka0oConlMiEIK9yuhIE7BwfEhR0g+PKQEZ7KMYt8
   U4E1oViYFz1ye82tj8mgXHpnDfQcxzHbQUb3ZtNgkoPy7fELnNcfR4lG9
   H6gkB0uDq3IdtIwRE98tybTEfTFYBoL2V/zlmVwRyEaZGWQWYedTOTEab
   A==;
X-CSE-ConnectionGUID: 1MVfnLrzRZG2DIekZcchfA==
X-CSE-MsgGUID: tZucLqe5TWGCvDKEagPeLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24219674"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24219674"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:44:49 -0700
X-CSE-ConnectionGUID: aJHqLRxrQhO8y7pAYXrO7w==
X-CSE-MsgGUID: L1ZXSVr7QVygV7LyWjuc+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="70054527"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:44:49 -0700
Received: from [10.212.20.134] (kliang2-mobl1.ccr.corp.intel.com [10.212.20.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5912520B5782;
	Wed,  4 Sep 2024 05:44:48 -0700 (PDT)
Message-ID: <b97ab074-3889-47ae-a66f-46a2f8a99005@linux.intel.com>
Date: Wed, 4 Sep 2024 08:44:47 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Generic hotplug support for a PMU with a scope
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240802151643.1691631-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Gentle ping.

The patch set provides a generic hotplug support to facilitate various
specific PMU drivers. Could you please take a look?

Thanks,
Kan
On 2024-08-02 11:16 a.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The perf subsystem assumes that the counters of a PMU are per-CPU. So
> the user space tool reads a counter from each CPU in the system wide
> mode. However, many PMUs don't have a per-CPU counter. The counter is
> effective for a scope, e.g., a die or a socket. To address this, a
> cpumask is exposed by the kernel driver to restrict to one CPU to stand
> for a specific scope. In case the given CPU is removed,
> the hotplug support has to be implemented for each such driver.
> 
> The codes to support the cpumask and hotplug are very similar.
> - Expose a cpumask into sysfs
> - Pickup another CPU in the same scope if the given CPU is removed.
> - Invoke the perf_pmu_migrate_context() to migrate to a new CPU.
> - In event init, always set the CPU in the cpumask to event->cpu
> - Usually, an event can be read from any CPU of the scope. (For now,
>   it is only supported by the pkg scope PMU, via
>   PERF_EV_CAP_READ_ACTIVE_PKG, e.g., cstate_pkg, rapl, etc)
> 
> Similar duplicated codes are implemented for each such PMU driver. It
> would be good to introduce a generic infrastructure to avoid such
> duplication.
> 
> The patch series introduce 5 popular scopes, core, die, cluster, pkg,
> and the system-wide. The PMU drivers for cstate, iommu, idxd and rapl
> are updated to apply the new infrastructure. The new infrastructure
> can also be applied for other PMU drivers from different ARCHs as well.
> But I don't have such platforms. It's not done in this patch series.
> They can be added later separately.
> 
> The uncore driver isn't updated either. Because a per-PMU cpumask is
> required since commit c74443d92f68 ("perf/x86/uncore: Support per PMU
> cpumask"). Since different types of PMU share the same hotplug codes,
> more factor out works and verification are expected. The cleanup of the
> uncore driver can be done later separately.
> 
> Kan Liang (7):
>   perf: Generic hotplug support for a PMU with a scope
>   perf: Add PERF_EV_CAP_READ_SCOPE
>   perf/x86/intel/cstate: Clean up cpumask and hotplug
>   iommu/vt-d: Clean up cpumask and hotplug
>   dmaengine: idxd: Clean up cpumask and hotplug
>   perf/x86/rapl: Move the pmu allocation out of CPU hotplug
>   perf/x86/rapl: Clean up cpumask and hotplug
> 
>  arch/x86/events/intel/cstate.c | 140 +-------------------------
>  arch/x86/events/rapl.c         | 119 ++++++----------------
>  drivers/dma/idxd/idxd.h        |   7 --
>  drivers/dma/idxd/init.c        |   3 -
>  drivers/dma/idxd/perfmon.c     |  98 +-----------------
>  drivers/iommu/intel/iommu.h    |   2 -
>  drivers/iommu/intel/perfmon.c  | 111 +--------------------
>  include/linux/cpuhotplug.h     |   3 -
>  include/linux/perf_event.h     |  21 ++++
>  kernel/events/core.c           | 176 ++++++++++++++++++++++++++++++++-
>  10 files changed, 229 insertions(+), 451 deletions(-)
> 

