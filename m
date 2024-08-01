Return-Path: <linux-kernel+bounces-271626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801859450E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022391F2A318
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F52A1BD512;
	Thu,  1 Aug 2024 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aaHz21Sq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9D1BD51D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530189; cv=none; b=YmLquNFJMxIp5wH4hB2EC67QaivXya8TaoAojlmDmb+ypWRu27OwCSuNxf/NvB28qV6Wp07cWpf7UbRuSg3nQ72L+bsztPImUlYzm3lvkWUkoGGqHzsRKIH6KTMOlWg+SPdriwNWH9wdPRRvECnxvSMclcJrBy1nCyAh19UTzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530189; c=relaxed/simple;
	bh=td39YTy0YblpBN7U8Cca15KBI7XvywPv0hYyTHJE4TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asprP27BOQ6elK+c/Zv95KrfKgFcc2D7E0XcbCb7Cl68XOVvWulDGbzuWUew7iGklwZnqUYUYX4AbJ53a0op1I76h4ZAtKGGBeX473ivX28EuILdXlPLLS3sF568zowQu+mRkANVgvosyp+TqyankDbSDV9NzTcE1mbAZ8c+srY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aaHz21Sq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5kgU7L+oZQyGtcBGDMc4U5ijvvwscVi4AgswguOBaaQ=; b=aaHz21SqHW9Z9nkdj1tL8/shnl
	RHcFzIK1wofXSkqTshfpjB8VJzYiPOSW5o1xpxen+3ZuPKzumrnghKN4XJeZWrcdP42K/LsGuB9jt
	RPwmJgOy7QF9CMrZ3Qym0at5bsvrZvJx72wsXgrIFQbfwt/JeUabZEej0r8Ku9wrlUB/oD5VMDvO4
	ljyvaKt0Jndz8MctzW0JgzXmlKvoHC8JUb8aq7z2uLB64nc6jmE5MOYXBrVO/8n1kWKSAIx6oUGqp
	9ielfs2VC94HkhIkL/dNoMLrpZMa3y0FWRN9KKpM9NrOmCdNoH1CFS6Kx+p5yGHU3Wy3WpxcSbeTa
	H0JmCqxQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZYmo-000000004YR-3SkX;
	Thu, 01 Aug 2024 16:36:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 372B530074E; Thu,  1 Aug 2024 18:36:18 +0200 (CEST)
Date: Thu, 1 Aug 2024 18:36:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com,
	Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	silviazhao <silviazhao-oc@zhaoxin.com>
Subject: Re: [PATCH V4 1/5] perf/x86: Extend event update interface
Message-ID: <20240801163618.GD39708@noisy.programming.kicks-ass.net>
References: <20240731143835.771618-1-kan.liang@linux.intel.com>
 <20240731143835.771618-2-kan.liang@linux.intel.com>
 <20240801140340.GF37996@noisy.programming.kicks-ass.net>
 <f9b18e66-eb7d-4998-8843-b1a16cc004b0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9b18e66-eb7d-4998-8843-b1a16cc004b0@linux.intel.com>

On Thu, Aug 01, 2024 at 11:31:40AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-08-01 10:03 a.m., Peter Zijlstra wrote:
> > On Wed, Jul 31, 2024 at 07:38:31AM -0700, kan.liang@linux.intel.com wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The current event update interface directly reads the values from the
> >> counter, but the values may not be the accurate ones users require. For
> >> example, the sample read feature wants the counter value of the member
> >> events when the leader event is overflow. But with the current
> >> implementation, the read (event update) actually happens in the NMI
> >> handler. There may be a small gap between the overflow and the NMI
> >> handler.
> > 
> > This...
> > 
> >> The new Intel PEBS counters snapshotting feature can provide
> >> the accurate counter value in the overflow. The event update interface
> >> has to be updated to apply the given accurate values.
> >>
> >> Pass the accurate values via the event update interface. If the value is
> >> not available, still directly read the counter.
> > 
> >> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> >> index 12f2a0c14d33..07a56bf71160 100644
> >> --- a/arch/x86/events/core.c
> >> +++ b/arch/x86/events/core.c
> >> @@ -112,7 +112,7 @@ u64 __read_mostly hw_cache_extra_regs
> >>   * Can only be executed on the CPU where the event is active.
> >>   * Returns the delta events processed.
> >>   */
> >> -u64 x86_perf_event_update(struct perf_event *event)
> >> +u64 x86_perf_event_update(struct perf_event *event, u64 *val)
> >>  {
> >>  	struct hw_perf_event *hwc = &event->hw;
> >>  	int shift = 64 - x86_pmu.cntval_bits;
> >> @@ -131,7 +131,10 @@ u64 x86_perf_event_update(struct perf_event *event)
> >>  	 */
> >>  	prev_raw_count = local64_read(&hwc->prev_count);
> >>  	do {
> >> -		rdpmcl(hwc->event_base_rdpmc, new_raw_count);
> >> +		if (!val)
> >> +			rdpmcl(hwc->event_base_rdpmc, new_raw_count);
> >> +		else
> >> +			new_raw_count = *val;
> >>  	} while (!local64_try_cmpxchg(&hwc->prev_count,
> >>  				      &prev_raw_count, new_raw_count));
> >>  
> > 
> > Does that mean the following is possible?
> > 
> > Two counters: C0 and C1, where C0 is a PEBS counter that also samples
> > C1.
> > 
> >   C0: overflow-with-PEBS-assist -> PEBS entry with counter value A
> >       (DS buffer threshold not reached)
> > 
> >   C1: overflow -> PMI -> x86_perf_event_update(C1, NULL)
> >       rdpmcl reads value 'A+d', and sets prev_raw_count
> > 
> >   C0: more assists, hit DS threshold -> PMI
> >       PEBS processing does x86_perf_event_update(C1, A)
> >       and sets prev_raw_count *backwards*
> 
> I think the C0 PMI handler doesn't touch other counters unless
> PERF_SAMPLE_READ is applied. For the PERF_SAMPLE_READ, only one counter
> does sampling. It's impossible that C0 and C1 do sampling at the same
> time. I don't think the above scenario is possible.

It is perfectly fine for C0 to have PERF_SAMPLE_READ and C1 to be a
normal counter, sampling or otherwise.

> Maybe we can add the below check to further prevent the abuse of the
> interface.

There is no abuse in the above scenario. You can have a group with all
sampling events and any number of them can have PERF_SAMPLE_READ. This
is perfectly fine.

> WARN_ON_ONCE(!(event->attr.sample_type & PERF_SAMPLE_READ) && val);

I don't see how PERF_SAMPLE_READ is relevant, *any* PMI for the C1 event
will cause x86_perf_event_update() to be called. And remember that even
non-sampling events have EVENTSEL_INT set to deal with counter overflow.

The problem here is that C0/PEBS will come in late and try to force
update an out-of-date value.

If you have C1 be a non-sampling event, this will typically not happen,
but it still *can*, and when you do, you get your counter moving
backwards.

