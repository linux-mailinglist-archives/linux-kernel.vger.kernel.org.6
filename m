Return-Path: <linux-kernel+bounces-271394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58076944D99
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6172C1C24B60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3749D1A38C1;
	Thu,  1 Aug 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pCt6pcKk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F332261FF2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521030; cv=none; b=C9JSNXOy8fazq3q3lw5cBWywGK7ki/aXaJrQTk0C1bHAKIYCKsHnm4EV7CtVmqpqrC7mQiz3WniR5YCWkQ6SfgVubxMWqbJBNVLJgp8SCFPT1la1Nza+AiZ/F62Prq201uAJHWKBa9AfM2FCirti6gyg7nDBqbRN2YpTwnapz+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521030; c=relaxed/simple;
	bh=AiR58spUCKAeKiapW34WMroMEZBz19iTKNbDsLys2q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRmQ5CmvnXCAhFcHb6YyO4rRg+JtzACKudNzNQITHzEaKR3oTk7XAegbsQiX03dB0bb8E9lYq8YJhS7mM9ndUHVkARefNAzYznLtSdk9AgRMRHL2PQcgc3HSt9nfWoFYypBdPDuZMwHXR+wFF9NmG1QPWZ3PNHrqZAGd4gL20vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pCt6pcKk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aCT+mZb2Cy+A6isJ8OBSDVk7ibeJ8B2eQ7qPANWY5Kc=; b=pCt6pcKkJq9GkUvMRkL+RXnmm4
	cjidJ7J4ela1NbzhP9SpFFrGXawTyd+wZwmPCD/afEtsdiKDknsiIEjKIYkmQoQXq2oLx0RnyFQ/G
	YJUnAruH60X8qW0r4pFg8tPpT3zfXxIyrgdozZVWGMOIMl434KP1uIs5Suh4U1xkx+qgi41w8N6V5
	jgrFIBtrIVVthbYBsby8pl8t4otgmlDw8NYVd2JBmn8xg+FeAEk45K+7ZjByTkcb2I+zgrcNZrLVQ
	kqoJnfx4mqbChzvbgLOq0nW1YW9unVw/Iv4bjTnNIxh0PywFafruqVx6k/AZqIsJ7KymQ2zdojkcU
	jDk7MfFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZWP7-0000000HX0W-0Gv9;
	Thu, 01 Aug 2024 14:03:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5137330074E; Thu,  1 Aug 2024 16:03:40 +0200 (CEST)
Date: Thu, 1 Aug 2024 16:03:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com,
	Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	silviazhao <silviazhao-oc@zhaoxin.com>
Subject: Re: [PATCH V4 1/5] perf/x86: Extend event update interface
Message-ID: <20240801140340.GF37996@noisy.programming.kicks-ass.net>
References: <20240731143835.771618-1-kan.liang@linux.intel.com>
 <20240731143835.771618-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731143835.771618-2-kan.liang@linux.intel.com>

On Wed, Jul 31, 2024 at 07:38:31AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The current event update interface directly reads the values from the
> counter, but the values may not be the accurate ones users require. For
> example, the sample read feature wants the counter value of the member
> events when the leader event is overflow. But with the current
> implementation, the read (event update) actually happens in the NMI
> handler. There may be a small gap between the overflow and the NMI
> handler.

This...

> The new Intel PEBS counters snapshotting feature can provide
> the accurate counter value in the overflow. The event update interface
> has to be updated to apply the given accurate values.
> 
> Pass the accurate values via the event update interface. If the value is
> not available, still directly read the counter.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 12f2a0c14d33..07a56bf71160 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -112,7 +112,7 @@ u64 __read_mostly hw_cache_extra_regs
>   * Can only be executed on the CPU where the event is active.
>   * Returns the delta events processed.
>   */
> -u64 x86_perf_event_update(struct perf_event *event)
> +u64 x86_perf_event_update(struct perf_event *event, u64 *val)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	int shift = 64 - x86_pmu.cntval_bits;
> @@ -131,7 +131,10 @@ u64 x86_perf_event_update(struct perf_event *event)
>  	 */
>  	prev_raw_count = local64_read(&hwc->prev_count);
>  	do {
> -		rdpmcl(hwc->event_base_rdpmc, new_raw_count);
> +		if (!val)
> +			rdpmcl(hwc->event_base_rdpmc, new_raw_count);
> +		else
> +			new_raw_count = *val;
>  	} while (!local64_try_cmpxchg(&hwc->prev_count,
>  				      &prev_raw_count, new_raw_count));
>  

Does that mean the following is possible?

Two counters: C0 and C1, where C0 is a PEBS counter that also samples
C1.

  C0: overflow-with-PEBS-assist -> PEBS entry with counter value A
      (DS buffer threshold not reached)

  C1: overflow -> PMI -> x86_perf_event_update(C1, NULL)
      rdpmcl reads value 'A+d', and sets prev_raw_count

  C0: more assists, hit DS threshold -> PMI
      PEBS processing does x86_perf_event_update(C1, A)
      and sets prev_raw_count *backwards*

How is that sane?

