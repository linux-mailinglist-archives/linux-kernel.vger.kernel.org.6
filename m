Return-Path: <linux-kernel+bounces-449132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BE29F4A52
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E411188C04B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E991EF0B1;
	Tue, 17 Dec 2024 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FUaaihAj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9231EC01F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436348; cv=none; b=f1LDhlFQS9zquhwYNwNE37DA9329ErqbYx70pj/mF3NivcW6k1Q+7QBWBTzwathgaPApBodvX3AqCzKB7zEzbjuMo5Qpm/q+tP46PKNIyJl0l+J8o686pDQoIt6zbcrX6uaILYMcfO74vxCisPxkWcnJqbRrlGXQBNGtCCjRzUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436348; c=relaxed/simple;
	bh=Uyr/af5piLgIAsxETlp/Y6uGDkFZNrbFB8D0SeSre3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpR3lJJ3VMrQBqbuovVtwHIo19WexWK7IdH8wwpE3/uvY2x1RV9SvCi1MuOtOz6p/xZ2drVSRIh3VVZ1l372IkZYaq5HgaU/31fPz2rhsalYO1ioX775kI54pTuBckvO1OzHAmcsPZEvsPDoLFNN3/KwcIxl1ILCQt3n8eC19c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FUaaihAj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ClCG25SUeVRyaAwiRmoF8ZisFQMziOb3AiLechO0cTo=; b=FUaaihAjoS2ArDwyBiJEEc7Qq1
	V7qx+Vw2eFWsQkomhxIEXRJbuCOzqv85SHNdhU86tWRPHMazpCUoP++me0iVsZLidRTag5KwGsBqL
	g2r+RiOZA6J6mUqm0hy8PIX8mzUybM92jFG7LogRwLSLa6Vv+Z0Ln7ZbqMxpn8r2WUiEHt7x5u8d+
	EYvo9zMEKILgFZRHoaMBFJO149r+X5qbhRsI8rD85mLi4wwzx1WPKU+MdIMv+PRaJufJ/PrZnVxdT
	YIpdnoVuEDTGLS6Y6IHkpacfkrHxFo16M0448Xnf1HP4N1pM3VnwNJLzjjn2zJzjf4f9bZJSa6zaz
	8eKE4R7Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNW7f-00000006i9V-3tHt;
	Tue, 17 Dec 2024 11:52:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 28FFA30015F; Tue, 17 Dec 2024 12:52:19 +0100 (CET)
Date: Tue, 17 Dec 2024 12:52:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>,
	"lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
Subject: Re: [PATCH 19/19] perf: Make perf_pmu_unregister() useable
Message-ID: <20241217115219.GH12500@noisy.programming.kicks-ass.net>
References: <20241104133909.669111662@infradead.org>
 <20241104135519.715883982@infradead.org>
 <ae1f9492-dae0-4ce8-aa6b-f1890faf67e7@amd.com>
 <20241217091216.GK35539@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217091216.GK35539@noisy.programming.kicks-ass.net>

On Tue, Dec 17, 2024 at 10:12:16AM +0100, Peter Zijlstra wrote:
> 
> 
> Oh sorry, I seem to have missed this email :/
> 
> On Mon, Nov 25, 2024 at 09:40:28AM +0530, Ravi Bangoria wrote:
> > Hi Peter,
> > 
> > > @@ -6507,6 +6540,7 @@ static void perf_mmap_close(struct vm_ar
> > >  	unsigned long size = perf_data_size(rb);
> > >  	bool detach_rest = false;
> > >  
> > > +	/* FIXIES vs perf_pmu_unregister() */
> > >  	if (event->pmu->event_unmapped)
> > >  		event->pmu->event_unmapped(event, vma->vm_mm);
> > 
> > I assume you are already aware of the race between __pmu_detach_event()
> > and perf_mmap_close() since you have put that comment. 
> 
> That comment was mostly about how we can't fix up the whole
> ->event_unmapped() thing and have to abort pmu_unregister for it.
> 
> > In any case, below sequence of operations triggers a splat when
> > perf_mmap_close() tries to access event->rb, event->pmu etc. which
> > were already freed by __pmu_detach_event().
> > 
> > Sequence:
> > 
> >     Kernel                       Userspace
> >     ------                       ---------
> >     perf_pmu_register()
> >                                 fd = perf_event_open()
> >                                 p = mmap(fd)
> >     perf_pmu_unregister()
> >                                 munmap(p)
> >                                 close(fd)
> 
> Right, let me go have a look. Thanks!

Bah, that's a right mess indeed, however did I miss all that.

The easiest solution is probably to leave the RB around on detach, but
now I need to remember why I did that in the first place :/

Oh.. I think I mostly that to serialize against perf_mmap(), which
should reject creating further maps. But we can do that without actually
detaching the RB -- we only need to acquire and release mmap_mutex.

Ah, there's that perf_event_stop() inside of ring_buffer_attach(), that
must not happen after detach, obviously. So that must be dealt with.

Hmm, also if we leave ->rb around, then we need to deal with
perf_event_set_output(), someone could try and redirect their things
into our buffer -- which isn't technically broken, but still weird.

Something like the below.

How did you test; perf-fuzzer or something?

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1742,7 +1742,7 @@ static inline bool needs_branch_stack(st
 
 static inline bool has_aux(struct perf_event *event)
 {
-	return event->pmu->setup_aux;
+	return event->pmu && event->pmu->setup_aux;
 }
 
 static inline bool has_aux_action(struct perf_event *event)
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5409,7 +5409,6 @@ static void _free_event(struct perf_even
 	security_perf_event_free(event);
 
 	if (event->rb) {
-		WARN_ON_ONCE(!event->pmu);
 		/*
 		 * Can happen when we close an event with re-directed output.
 		 *
@@ -12023,7 +12022,10 @@ static void __pmu_detach_event(struct pm
 	 */
 	scoped_guard (mutex, &event->mmap_mutex) {
 		WARN_ON_ONCE(pmu->event_unmapped);
-		ring_buffer_attach(event, NULL);
+		/* 
+		 * Mostly an empy lock sequence, such that perf_mmap(), which
+		 * relies on mmap_mutex, is sure to observe the state change.
+		 */
 	}
 
 	perf_event_free_bpf_prog(event);
@@ -12823,6 +12825,9 @@ perf_event_set_output(struct perf_event
 		goto unlock;
 
 	if (output_event) {
+		if (output_event->state <= PERF_EVENT_STATE_REVOKED)
+			goto unlock;
+
 		/* get the rb we want to redirect to */
 		rb = ring_buffer_get(output_event);
 		if (!rb)

