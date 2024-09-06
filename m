Return-Path: <linux-kernel+bounces-319118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A59696F7F1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA222283617
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A0A1D278F;
	Fri,  6 Sep 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="idHu+fYR"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA2C1D0490
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635570; cv=none; b=ML2Yat9oxdjHaIui9Q2WZdHsEunydLlW86ZWjtbx5DAQce+b/ZQgDApZlXKqDzmvbkpfZ2sAal6aqN9rHpmVkiJZ5HlWTLjxHjPyR0a0SaSRys6i6G6ZC224HJjOQBJdnn8FoiE5IZEgzVZgqogifemoPIjClLvARML80ltkqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635570; c=relaxed/simple;
	bh=KnnkHDdioDyhNF7njg9jY6YXI/7IBIP2EeYMs2XGo0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVtHFM8BBs87Geam75pbh1rkgu4GXfgdc6NuxK9mYFstUy/Fdhc5tP7ZO+hgh42y7kq5kUWtGi3xftewu0Ez/fwCn7SKxHOQ2hHeMR6belyo7cFM1H7rNI+uOJkfpN47zeDb0ntUrQYfPe56SJTvr+Dmwg124VjUyaEVPSs3J58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=idHu+fYR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LgdiGtWdacd1pjB3cvjhBNF65EA5QckInJ+tiDV/76w=; b=idHu+fYRSv/GZbZZENpvatBOBz
	F7krcXvVbBA4spQI6stwetKra3p3vOOsrol9HUKEHZZdkcKWDpkBBZ21BaCJc1Zt23UQPuq2rw8uU
	yheAR3AF/qjr22LwLFo2SthyF3ivh30jLkbTpq+9F/KjucSuEOXE7XLIzFg0plCtAAdMOOsvs7p9K
	O3PW9x2S0+KOECvbQRN78kA8nzlbNcKeWUA4LFbf1AVmKRqlLyKGP2owDWiPvct8SO73IDJEScIV7
	TjiG70CJU3r7V5lHvuZEAiSbLNyRH37QQQREem70BA2dKMUxC5IIuNiRm4hi616Puz+iXL0oPcMPA
	O/h3Keeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smadf-00000000goq-25aQ;
	Fri, 06 Sep 2024 15:12:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 271713003E1; Fri,  6 Sep 2024 17:12:43 +0200 (CEST)
Date: Fri, 6 Sep 2024 17:12:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Generic hotplug support for a PMU with a scope
Message-ID: <20240906151243.GY4723@noisy.programming.kicks-ass.net>
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802151643.1691631-1-kan.liang@linux.intel.com>

On Fri, Aug 02, 2024 at 08:16:36AM -0700, kan.liang@linux.intel.com wrote:
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

Looks like we have another RAPL driver in:

  drivers/powercap/intel_rapl_common.c

that wants to be converted.

