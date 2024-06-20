Return-Path: <linux-kernel+bounces-222408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFD5910100
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E555282DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0481A8C0A;
	Thu, 20 Jun 2024 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uueBH38v"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1B7E58C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877725; cv=none; b=HrbovZYHgpEhT4H2jMOIuHdXJMe88Fbb3risBEK6m4R4ezjmIt5FOzfAruGvUdk0kqoKAiDzUzzaDB6z4JqMW98iCfqT4Gf+HbcLAYegy0rEiVJ3waEdnS14MMK42o0+iJVVPylpoZ81lhUfey4GPqHCAt2yVWAxnCuzke+Smd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877725; c=relaxed/simple;
	bh=Yxur/w0Bkx4Zjgurm0XEuiN7KxqnOvXz/Yod12bA/gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI5q62vM4YrGR8nnN/9LueZD2pMrTo/fcvBW3qHsEE7TJOrxyFhgufjIa8W1SCeG6g3ABPQcrh9lNYZh10iIGB++A/UXMMjSDT2PRJkojke4fKZ1pq2oPiAia0ZbNwhQHR2a+o4HazUn0ff/k2dPh19loB2Awg3FbhSucM/iELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uueBH38v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GlUm0HbEhsQoWOg/X8YOOm8Qn0v9eqUgzNiji0P/orU=; b=uueBH38vQs9jy9yaqNJrNpAuXK
	wpCYUJUbG663Nua6UlhnhhCs6cGdyX2sdU7BkvNDsNZB7TFWKau7VgJBy4JEn6tn3m7pKSJD3lQik
	RYO423Q2M1MB4t3IARnQkpTcrpyX+mvG0NC/qaoQnjyhSG68ajN0bA+XDDqaQEEOeQibW2+AH/a12
	BETbztR/xlLaiXbmJtQmoHMHPZwHlTQViL6W3tDuXvYKuXIrwa+bQAKGLPJaHbiIjK23a4tt2Kt4D
	2P+TyGSgsmz+UfgvKoH4S1S4z0qFEkxs0uW7TXS4lxLcgIB6fiDg28WhcsyZ/UUijHmXa8GyBnlfW
	BDre4zkg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKEc8-00000005v83-2r4B;
	Thu, 20 Jun 2024 10:01:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F26B1300CB9; Thu, 20 Jun 2024 12:01:55 +0200 (CEST)
Date: Thu, 20 Jun 2024 12:01:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com
Subject: Re: [RESEND PATCH 09/12] perf: Extend perf_output_read
Message-ID: <20240620100155.GU12673@noisy.programming.kicks-ass.net>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-10-kan.liang@linux.intel.com>
 <20240620090028.GW31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620090028.GW31592@noisy.programming.kicks-ass.net>

On Thu, Jun 20, 2024 at 11:00:28AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 18, 2024 at 08:10:41AM -0700, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > The event may have been updated in the PMU-specific implementation,
> > e.g., Intel PEBS counters snapshotting. The common code should not
> > read and overwrite the value.
> > 
> > The PERF_SAMPLE_READ in the data->sample_type can be used to detect
> > whether the PMU-specific value is available. If yes, avoid the
> > pmu->read() in the common code.
> > 
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> >  kernel/events/core.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 8f908f077935..733e507948e6 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7243,7 +7243,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
> >  
> >  static void perf_output_read_group(struct perf_output_handle *handle,
> >  			    struct perf_event *event,
> > -			    u64 enabled, u64 running)
> > +			    u64 enabled, u64 running, bool read)
> >  {
> >  	struct perf_event *leader = event->group_leader, *sub;
> >  	u64 read_format = event->attr.read_format;
> > @@ -7265,7 +7265,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
> >  	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
> >  		values[n++] = running;
> >  
> > -	if ((leader != event) &&
> > +	if ((leader != event) && read &&
> >  	    (leader->state == PERF_EVENT_STATE_ACTIVE))
> >  		leader->pmu->read(leader);
> >  
> > @@ -7280,7 +7280,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
> >  	for_each_sibling_event(sub, leader) {
> >  		n = 0;
> >  
> > -		if ((sub != event) &&
> > +		if ((sub != event) && read &&
> >  		    (sub->state == PERF_EVENT_STATE_ACTIVE))
> >  			sub->pmu->read(sub);
> >  
> > @@ -7307,7 +7307,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
> >   * on another CPU, from interrupt/NMI context.
> >   */
> >  static void perf_output_read(struct perf_output_handle *handle,
> > -			     struct perf_event *event)
> > +			     struct perf_event *event,
> > +			     bool read)
> >  {
> >  	u64 enabled = 0, running = 0, now;
> >  	u64 read_format = event->attr.read_format;
> > @@ -7325,7 +7326,7 @@ static void perf_output_read(struct perf_output_handle *handle,
> >  		calc_timer_values(event, &now, &enabled, &running);
> >  
> >  	if (event->attr.read_format & PERF_FORMAT_GROUP)
> > -		perf_output_read_group(handle, event, enabled, running);
> > +		perf_output_read_group(handle, event, enabled, running, read);
> >  	else
> >  		perf_output_read_one(handle, event, enabled, running);
> >  }
> > @@ -7367,7 +7368,7 @@ void perf_output_sample(struct perf_output_handle *handle,
> >  		perf_output_put(handle, data->period);
> >  
> >  	if (sample_type & PERF_SAMPLE_READ)
> > -		perf_output_read(handle, event);
> > +		perf_output_read(handle, event, !(data->sample_flags & PERF_SAMPLE_READ));
> >  
> >  	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
> >  		int size = 1;
> 
> this can't be right. The output is order sensitive. If a
> PERF_SAMPLE_READ is part of the PERF_RECORD_SAMPLE, it must be in this
> location.

Oh, n/n. I read that wrong. I'll try again after a break.

