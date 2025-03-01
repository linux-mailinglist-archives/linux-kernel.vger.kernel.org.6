Return-Path: <linux-kernel+bounces-540095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A8CA4AD98
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 21:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3427A54AC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 19:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6D11E5B99;
	Sat,  1 Mar 2025 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Doc8ed8f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61343175D53
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859231; cv=none; b=LbZa69NXhadlEQbeNIa9+pKu+IsUgnVzNb4cPlqeqcdVsxUGw1dnQY+E3zISbje37pDo3AayRcHb3o0WnoarZDo8MRiE6LneYFXTM4fhzaKl6zIxl0jUuBVOw9yy82y8GAmxIMiLgg/Woe+VJjcNuyBZt3vzL5ppFxFCoHCMz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859231; c=relaxed/simple;
	bh=FeFD95bED8rxjd4lyummSC8v6w/Px5UrJJGpc2fhMH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTjmPFYNtrdkuEr1euwjjUejHjsHtYxlKE+Ejdcspv9dU8o4RRich9fJp7/4r/cCj7j7IheXNlIlamXEPFMyEjzvAk209OriGFLBO/Urou0/joZrHJZP5TcLDOAOnrjyINf4Qc2RY0gRbyWFG911pLcs5tguLC4lwk/BxpmKPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Doc8ed8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CAEC4CEDD;
	Sat,  1 Mar 2025 20:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740859230;
	bh=FeFD95bED8rxjd4lyummSC8v6w/Px5UrJJGpc2fhMH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Doc8ed8fgYE9RkBWOxqLFKcG3XnxIVAurpGbLOgR6gSi1t1HNCwHEwzlJM7iOejV6
	 a3EZKHjV1qUnZyBMtUx1b40G++J2ZG9uaBwnwB+ihWaxSgJzQVwCGxrodvJRZAq/QC
	 G2KZa8hFru22RhAIHX3y+4100LFl9JxYLI+bjQi0OHpzZanW4qtU4u+uwFGK03Umki
	 RwJnMUCKC75HoE54bY5wJLt+/EAdaBLN0Jgd0e2Ndo1VG5/1e9Wy+xDTZIfnyNitEr
	 8Il+RYAQaWfwO1kmtYvgTnaCeq15QEt4Y/y6/lwd7Xhh23KMO1fkKAS302UiGdmBK5
	 u3s39Tyhh/t+g==
Date: Sat, 1 Mar 2025 21:00:21 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
	willy@infradead.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 00/19] perf: Make perf_pmu_unregister() usable
Message-ID: <Z8NnVdo8wB-YcrAs@gmail.com>
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104133909.669111662@infradead.org>


* Peter Zijlstra <peterz@infradead.org> wrote:

> Hi,
> 
> Lucas convinced me that perf_pmu_unregister() is a trainwreck; after
> considering a few options I was like, how hard could it be..
> 
> So find here a few patches that clean things up in preparation and then a final
> patch that makes unregistering a PMU work by introducing a new event state
> (REVOKED) and ensuring that any event in such a state will never get to using
> it's PMU methods ever again.

So it looks like this series first got lost in the usual end-of-year 
fog of holidays, then it has become somewhat bitrotten due to other 
perf changes interacting and creating conflicts. I cannot find these 
patches in queue.git anymore, other than the somewhat stale 4+ months 
old perf/pmu-unregister branch from October 2024.

Which I found a bit sad, because these cleanups to the control flow and 
error handling of these key perf primitives was a substantial reduction 
of our years long technical debt in this area.

So to move things forward I dusted off most of these patches, reviewed 
the logic, resolved the conflicts, folded in the fix to pmu_dev_alloc() 
that Ravi found (and upgraded his 'looks OK' reply into Acked-by tags), 
added/extended changelogs, did some testing due diligence and sorted 
them into their appropriate -next branches:

  #
  # tip:[locking/core]
  #
  # After 10 years of this lockdep debug check hidden behind 
  # CONFIG_DEBUG_ATOMIC_SLEEP=y I definitely wasn't brave enough to stick 
  # this into an urgent branch. Sue me.
  #
  a1b65f3f7c6f ("lockdep/mm: Fix might_fault() lockdep check of current->mm->mmap_lock")

  #
  # tip:[perf/urgent]
  #
  # These look like obvious fixes that can be accelerated to -rc6
  #
  003659fec9f6 ("perf/core: Fix perf_pmu_register() vs. perf_init_event()")
  2565e42539b1 ("perf/core: Fix pmus_lock vs. pmus_srcu ordering")

  #
  # tip:[perf/core]
  #
  # These are most of the remaining patches from this series, except for 15/19
  # which I was unsure about and 19/19 which is still under discussion:
  #
  02be310c2d24 ("perf/core: Simplify the perf_event_alloc() error path
  e6b17cfd528d ("perf/core: Simplify the perf_pmu_register() error path")
  742d5df92842 ("perf/core: Simplify perf_pmu_register()")
  9954ea69de5c ("perf/core: Simplify perf_init_event()")
  ebfe83832e39 ("perf/core: Simplify perf_event_alloc()")
  46cc0835d258 ("perf/core: Merge struct pmu::pmu_disable_count into struct perf_cpu_pmu_context::pmu_disable_count")
  a57411b14ea0 ("perf/core: Add this_cpc() helper")
  8e140c656746 ("perf/core: Introduce perf_free_addr_filters()")
  26700b1359a1 ("perf/bpf: Robustify perf_event_free_bpf_prog()")
  7503c90c0df8 ("perf/core: Simplify the perf_mmap() control flow")
  8c7446add31e ("perf/core: Further simplify perf_mmap()")
  6cbfc06a8590 ("perf/core: Remove retry loop from perf_mmap()")
  244b28f87ba4 ("perf/core: Lift event->mmap_mutex in perf_mmap()")

As to 'testing due diligence', that's overselling it really, it was 
mostly just some quick build/boot and functionality test combined
with perf test runs, ie. very light testing. Caveat emptor, but of
course the end result is perfect if we disregard any new bugs.

Thanks,

	Ingo

