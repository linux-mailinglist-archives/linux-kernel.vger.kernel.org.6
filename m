Return-Path: <linux-kernel+bounces-226840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35392914494
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C611C214D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0307061FD7;
	Mon, 24 Jun 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e9MMo3OS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AE34C622
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217312; cv=none; b=HLwspwQr2MZ80m9brxyBOqeBL6h1zj7A9gG6PgOHoxyxLKJmEJ9DRdpJcTJvovxScFgeSumf1nL9pN7WdU2yig8SNHbPDvKK7cjGnRhzXk0qbac8RdOGxn4OuLRZsb3ab9yU5WuRVti8BQpzrdXh7Z9WMtHtYip10l0d8q4jE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217312; c=relaxed/simple;
	bh=o72XGXJarTIIk/EM3iGa/hBJvjvByToqEICPTEuAX7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk1Cy/cq2hNBTKvLACqa55SKZi4lvUpPxAE6d6ufSfROQghbr6wSAgshO1XbAo9yOVMMyKr+ldc7O+yXmKHVu7nZDgtH/IAYspTabscuzd2R36oGykzLag3cUWWeadM38gWGN7bAVDTwsYE4C6zwL0Js/mES70bt2QcIe/jZ0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e9MMo3OS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S3QvUB9aNR+hCjeRjeQZ+meH2MBvZwZ+4EEV3q9PK/4=; b=e9MMo3OSaVSj90HQQOFh0zoq5v
	BvqjVS8u7OZa5dTYDfXI+DBYnxwNBGTw03gHDnPB2ccmf/duuSGsyRwWogSG3XKrnFexEOE+qBeY9
	Gmr843bZYzeotiZTBFCR0G4u8IZRAJZ7O8xQ7jy+REpPnAq61I5QXUwmvhUYZqhRziM/rPzFOWYWQ
	jbw9zMf0ZTiHCdte6tIwd0O45QLysyml/K42dGH3ZivCpqUA0A3o95Thpm/UcQKVUfBfwsoNzSEfN
	uwDYwCSAhqb5rRYR/09y2u7ZTXjvuv0rpS5cV7T6KFe+Yu9UxQArnnaXnsfzg2CorzZ3xR0GfyaXb
	puxVmT3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLexG-00000009qP3-3v73;
	Mon, 24 Jun 2024 08:21:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 234F8300754; Mon, 24 Jun 2024 10:21:38 +0200 (CEST)
Date: Mon, 24 Jun 2024 10:21:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com
Subject: Re: [RESEND PATCH 01/12] perf/x86/intel: Support the PEBS event mask
Message-ID: <20240624082138.GA31592@noisy.programming.kicks-ass.net>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-2-kan.liang@linux.intel.com>
 <20240620070215.GP31592@noisy.programming.kicks-ass.net>
 <840ced10-cc0f-4883-8559-772c5521a092@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <840ced10-cc0f-4883-8559-772c5521a092@linux.intel.com>

On Thu, Jun 20, 2024 at 11:58:42AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-06-20 3:02 a.m., Peter Zijlstra wrote:
> > On Tue, Jun 18, 2024 at 08:10:33AM -0700, kan.liang@linux.intel.com wrote:
> >> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> >> index e010bfed8417..a0104c82baed 100644
> >> --- a/arch/x86/events/intel/ds.c
> >> +++ b/arch/x86/events/intel/ds.c
> > 
> >> @@ -2157,6 +2157,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
> >>  	void *base, *at, *top;
> >>  	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
> >>  	short error[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
> >> +	int max_pebs_events = hweight64(x86_pmu.pebs_events_mask);
> > 
> > Consider pebs_events_mask = 0xf0, then max_pebs_events becomes 4.
> 
> The intel_pmu_drain_pebs_nhm() is a NHM specific function. It's
> impossible that there is a pebs_events_mask = 0xf0.
> 
> There are only 4 counters. The mask should always be 0xf.
> > 
> >>  	int bit, i, size;
> >>  	u64 mask;
> >>  
> >> @@ -2168,8 +2169,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
> >>  
> >>  	ds->pebs_index = ds->pebs_buffer_base;
> >>  
> >> -	mask = (1ULL << x86_pmu.max_pebs_events) - 1;
> >> -	size = x86_pmu.max_pebs_events;
> >> +	mask = x86_pmu.pebs_events_mask;
> >> +	size = max_pebs_events;
> > 
> > This is wrong.. you have 8 bits to iterate, of which only the top 4 are
> > set.
> > 
> >>  	if (x86_pmu.flags & PMU_FL_PEBS_ALL) {
> >>  		mask |= ((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED;
> >>  		size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
> >> @@ -2208,8 +2209,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
> >>  			pebs_status = p->status = cpuc->pebs_enabled;
> >>  
> >>  		bit = find_first_bit((unsigned long *)&pebs_status,
> >> -					x86_pmu.max_pebs_events);
> >> -		if (bit >= x86_pmu.max_pebs_events)
> >> +					max_pebs_events);
> >> +		if (bit >= max_pebs_events)
> >>  			continue;
> > 
> > But the bit check here then truncates the thing to the lower 4 bits
> > which are all 0.
> > 
> > Should this not be something like:
> > 
> > 		if (!(pebs_event_mask & (1 << bit)))
> > 			continue;
> > 
> > ?
> > 
> 
> For the existing hardware, I don't think it's necessary. The counters
> are contiguous.

Sure, but it still makes no sense. Fundamentally the operation is wrong,
it works by accident in this one special case. The moment someone reuses
the code (or copy/pastes) it and it goes outside the special case it
goes to hell.

Also, anybody that actually understands bitops will have a giant WTF
when they read this -- which is what happened here.

