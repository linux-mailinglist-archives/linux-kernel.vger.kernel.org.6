Return-Path: <linux-kernel+bounces-396660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565969BD035
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877381C20BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCD51D515B;
	Tue,  5 Nov 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nhICYwv6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2013BB21
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819820; cv=none; b=KT5MgRkI2w66KW0lh5aE2shW1GEc6PDP3u6WJAl1pnB17/bUNLnEVwsFtIsR/QK13VxbHHnP7wcgY0Zg+lUwhUTjWaWdCICghWPiDEjiospLNnx986Y0iqt46IS2PnP5rfkErri9FqS9HaWdQvDoEeaGZWSDYczZ5UXC/tj0UBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819820; c=relaxed/simple;
	bh=WX9G8mErWjcrtYnHITqw+7AzRQEBKn/4vD1Oh5elbfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwdGZs/TcUSUd+IfzpFMTM8WNjLv4EQjs4yukdHYP936y+ZfP9NHJhYmftnW3qa9+aSPyQF6StJAMLfyowgthHV9Rt4MEbg6EyRzVtG4vHUHvKEv0+N41v6PCly2PFDCA3yVfK0c+pd/4L8w60SJ+Qpxtla95FoMSi+6b5BxJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nhICYwv6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K6Ca7hy+beyKKnXMhBc0QIEa2lp6HRg2a2TqNRdqdE0=; b=nhICYwv6IpDC4HoZErgBfW/mZo
	D42KjAOxMlvQfxRsmyIpDQ5Dn0pI7UKdK4CidnatO5ElrCPznF+Hz3k5gfejU/zyk2B5SxyDa8HS2
	wWSDdEr1fst/eusxv3agzO00lNTEkxOahHkv2XOdnHjcEvGKQsFmOgpMk5z5Pjhy+q0EqpeGGwHul
	MmYJTUXJyHrSOPEHgR30fFD87PwSLKcX4Uq8AVZ7HRmHmYSjha7jCQJFeTKk4ND6zjOx0uStwpCv7
	jEyMc50dgavzbKc+4Me1twCjzztl1It5rxfEUuWIVDkg7vTmvXVGedViZI+8TtSFUunUS9HVAwYUP
	09XjOsZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8LIZ-00000003CEN-11RL;
	Tue, 05 Nov 2024 15:16:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6ADE030042E; Tue,  5 Nov 2024 16:16:51 +0100 (CET)
Date: Tue, 5 Nov 2024 16:16:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com
Subject: Re: [PATCH 19/19] perf: Make perf_pmu_unregister() useable
Message-ID: <20241105151651.GI10375@noisy.programming.kicks-ass.net>
References: <20241104133909.669111662@infradead.org>
 <20241104135519.715883982@infradead.org>
 <98e43590-6e9f-4d7d-8ae5-184262dae434@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98e43590-6e9f-4d7d-8ae5-184262dae434@linux.intel.com>

On Tue, Nov 05, 2024 at 10:08:54AM -0500, Liang, Kan wrote:
> > @@ -2427,6 +2429,7 @@ __perf_remove_from_context(struct perf_e
> >  			   void *info)
> >  {
> >  	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
> > +	enum perf_event_state state = PERF_EVENT_STATE_OFF;
> 
> Set the PERF_EVENT_STATE_OFF as default seems dangerous.
> If the event was in an error state, the state will be overwritten to the
> PERF_EVENT_STATE_OFF later.
> 
> One example may be the perf_pmu_migrate_context(). After the migration,
> it looks like all the error state will be cleared.
> 
> Thanks,
> Kan
> 
> >  	unsigned long flags = (unsigned long)info;
> >  
> >  	ctx_time_update(cpuctx, ctx);
> > @@ -2435,16 +2438,22 @@ __perf_remove_from_context(struct perf_e
> >  	 * Ensure event_sched_out() switches to OFF, at the very least
> >  	 * this avoids raising perf_pending_task() at this time.
> >  	 */
> > -	if (flags & DETACH_DEAD)
> > +	if (flags & DETACH_EXIT)
> > +		state = PERF_EVENT_STATE_EXIT;
> > +	if (flags & DETACH_REVOKE)
> > +		state = PERF_EVENT_STATE_REVOKED;
> > +	if (flags & DETACH_DEAD) {
> >  		event->pending_disable = 1;
> > +		state = PERF_EVENT_STATE_DEAD;
> > +	}
> >  	event_sched_out(event, ctx);
> >  	if (flags & DETACH_GROUP)
> >  		perf_group_detach(event);
> >  	if (flags & DETACH_CHILD)
> >  		perf_child_detach(event);
> >  	list_del_event(event, ctx);
> > -	if (flags & DETACH_DEAD)
> > -		event->state = PERF_EVENT_STATE_DEAD;
> > +
> > +	event->state = state;

How about we make this:

	event->state = min(event->state, state);

?


