Return-Path: <linux-kernel+bounces-512969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 655BDA33FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB237A1BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D000A23F40D;
	Thu, 13 Feb 2025 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmhUzOeb"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986E23F400
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452036; cv=none; b=soamSn12PwYy6ZY4Ow1zPtVkwLLlQCSw6to7haOqx55o3zN4i0WBGgNJnCJ3MiNGcSAFT/gthIpRDCU4I23F4qj6hRIWL/srfSSLHCDgGhRo5HjEOg5BVzp8/bukSyc0FuthBvcJbnTNiBxSPjT4BSzpJHE3l254PSORCKznkXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452036; c=relaxed/simple;
	bh=9AGuksxWME13+i3DmZ2reGSF4MYUhV4H+W/okayIy6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFBCHv4XbMjpgzfnPoldfv6r5yDc5hP8l2E4BgZR9L2Q5+cEcAwL0FWIUC2Go3jWEKO1q2FqQ9Rm20OBu7yEjHcGGtBd+wjom36Cvzs8N4W4aJ6rt7F9m8tDAQ0U//LWYHRHOcSXAxweD8sIXGcxphMiPkI5Hm56g1M1K+30X1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RmhUzOeb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8jApXK6h1YFXRBUpbQbvIE5r0DHPlvCvz1gmWx3VreY=; b=RmhUzOebAO+KMdxKUy8iDALgGq
	WgF0sf2/OwPUkf5lnZe9JM6lBtgU4VBMBYI2BXhuBmuaVMifioJEKg9tvlsST82lPyc7h8JvYnsCl
	HqmUTIqY6GtRrBnTqs+0I5YCZHuj5xWj4DXCP1JyHmQAEW1cHMPQaUjcU/5npjPTukIXBeOON+iXo
	Wh2mKUs+3GJJtC2HPxXfGvjCYMwnlTWMY74VhtOJubf+0N7L3wgOh5ktyMjatNOhoi4wOM01BRkqM
	ZISxj1SNO34AogOXDzzYXk3dNsCqYPf5WrijogjDK0pkhlM26ZcEBaL4XyjS1a0mk5J2YIfGj4IAP
	gNyPEEwQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tiYvp-00000000zrn-3Szu;
	Thu, 13 Feb 2025 13:07:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 83FBC3001AC; Thu, 13 Feb 2025 14:07:04 +0100 (CET)
Date: Thu, 13 Feb 2025 14:07:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH v2 24/24] perf: Make perf_pmu_unregister() useable
Message-ID: <20250213130704.GG28068@noisy.programming.kicks-ass.net>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.888979808@infradead.org>
 <50723a74-7d7c-4613-97fa-f4ee4ae0bbee@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50723a74-7d7c-4613-97fa-f4ee4ae0bbee@amd.com>

On Mon, Feb 10, 2025 at 12:29:21PM +0530, Ravi Bangoria wrote:
> On 05-Feb-25 3:51 PM, Peter Zijlstra wrote:
> > Previously it was only safe to call perf_pmu_unregister() if there
> > were no active events of that pmu around -- which was impossible to
> > guarantee since it races all sorts against perf_init_event().
> > 
> > Rework the whole thing by:
> > 
> >  - keeping track of all events for a given pmu
> > 
> >  - 'hiding' the pmu from perf_init_event()
> > 
> >  - waiting for the appropriate (s)rcu grace periods such that all
> >    prior references to the PMU will be completed
> > 
> >  - detaching all still existing events of that pmu (see first point)
> >    and moving them to a new REVOKED state.
> > 
> >  - actually freeing the pmu data.
> > 
> > Where notably the new REVOKED state must inhibit all event actions
> > from reaching code that wants to use event->pmu.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Another race between perf_event_init_task() failure path and
> perf_pmu_unregister():
> 
>         CPU 1                                          CPU 2
> 
>   perf_event_init_task()
>     perf_event_free_task()
>       perf_free_event(event1)
>       /* event1->refcount is 1 */
>                                                   perf_pmu_unregister()
>                                                     pmu_detach_events()
>                                                       pmu_get_event(pmu) /* Picks event1 */
>                                                         atomic_long_inc_not_zero(&event1->refcount) /* event1 */
>       /* event1->refcount became 2 (by CPU 2) */
>         free_event(event1)
>           WARN()

I've unified perf_event_free_task() and perf_event_exit_task(). This
makes both use perf_event_exit_event() and as such should no longer have
this free_event().



