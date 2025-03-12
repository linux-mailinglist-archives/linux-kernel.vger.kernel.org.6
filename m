Return-Path: <linux-kernel+bounces-557748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67594A5DD31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A638F17919A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC25124292B;
	Wed, 12 Mar 2025 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mkS3gcFb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782B7083C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784284; cv=none; b=aQospBO4Z7ewYp8bm3ocAaaK1FePMiDSUMWL1+UdXrtGyrak0WrhJlamdG9lO+pNGlVQlOtC+nv60miiVH9ceM09oKEXT6KSCWHpoPA68q9+v9Id7A5KL9e/GWlR7j/jon//bP1t3e8JmlQbC4Vji01+/XrxwuHtxxFbfFgbsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784284; c=relaxed/simple;
	bh=bl74ciPvTW5Ds69DkMal9hOQn07uY4RaUw/Gasyua4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qs9qOc308ZoxQbi+dijsFSs5+KEdvoK/L7o9mMjqgfl6yDO64x814tmQbtHJINqifqhfQhIMCgcOsTYFHof08sXBn6jO7sUSfbnRLU+K0N2gQZEabVxmnAywyL1AuRw6YSgYu9EomrDL9o1nWXp02gNuhW04WdW+RuiIhHbEBqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mkS3gcFb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ai6ukKOfO621HctvE3ks1IHNTAO+lgUNMqcOjSC6b2E=; b=mkS3gcFbmjqrcOF+bJOTqpmmWN
	yHHZsFiHq09JvFzzOCx9uYVW2jzF1mJRW76vrSDSv2Eezf6JHl2SyDeSwwqvyHIxmKfdXMxZM4Bgr
	HQ4rRRekK+5B+dhOLgKbK2mPQD8rNlp1TfeNQtMTrG2S4STqQguB7e7hmROLgYN43pJWkL1onsah+
	GRtHObTt2NpxMuSUX/6EmrG58fxD9bOKOz+Wb09km6rpAnKwl7rh/La2Fv/EQrrk4twW0kJafszRT
	isRsTRn1RheVdyW5oazyLITbrGhh7w/lKnp9KYE+YG7cnIM5r9Vog6G/CUbbdNQHNC4FrvmyWDfBx
	PAcCh1Xw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsLel-0000000CrgP-0MTR;
	Wed, 12 Mar 2025 12:57:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 15B36300599; Wed, 12 Mar 2025 13:57:54 +0100 (CET)
Date: Wed, 12 Mar 2025 13:57:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH v3 7/7] perf: Make perf_pmu_unregister() useable
Message-ID: <20250312125753.GL19424@noisy.programming.kicks-ass.net>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.525402029@infradead.org>
 <05e39b53-8e2f-4e21-8106-028fe54c37a0@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e39b53-8e2f-4e21-8106-028fe54c37a0@amd.com>

On Mon, Mar 10, 2025 at 10:16:09PM +0530, Ravi Bangoria wrote:
> On 08-Mar-25 1:03 AM, Peter Zijlstra wrote:
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
> 
> I think perf_event_init_task() failure path can still race with
> perf_pmu_unregister() and trigger a WARN():
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
> 

Yeah, I think most free_event() users are broken at this point. Let me
rip all that out. Not really worth the trouble anymore.

