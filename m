Return-Path: <linux-kernel+bounces-226853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3EA9144D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE379B248FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B391E13048F;
	Mon, 24 Jun 2024 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CMIJ0yLW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8461FE0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217578; cv=none; b=sw5uqp1lhEBcjJw6CZQxBrZcy6A6jgjfjmYJEuYWZa6JugW4ZN5VPTizFbGJnhIOz5+etB/4hY69Bh1izCucUgh8uGmfhFioyu+iO2un1aI3R6wUGjp34majAnCx24z31UMeX3utZdSSRLdNdgw9mfWbAs2l3jzssmEW7Xg4S4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217578; c=relaxed/simple;
	bh=zJ1CRPiWc2XXOn/ylPBVcF+KZN20HfgI7f293IYMdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ7gib5n72po2KWd5dmyd6Gu26IQJH6zTPuY6F3HEEWIVVOhfu899pGtNZK4pn5aWPzLf1Pp94gpl3sAchObjiJTNOT49Whl+CA9LWfEMQfyeErSSwaOFl8UtBzLKQY+lg5gZSA50NPHnygbXoISj7yHlSIGaJtRu5aaIc63ILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CMIJ0yLW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TahS1pryTxPDBHZ8uKVn6M6E9+BT/j8XTxK77xn486k=; b=CMIJ0yLW7KpMW/z1TUMcbelvRB
	C+v+OHj/ozsPqQVuWiKqyLxbGe9Ph3nSSvCN7RTFfVb3IVhSkiWBSasz5s7o+PWpOYHphT439bSf9
	UvXo6OPWdisOe9w84Z6F/1RB4882OKmtPI48tkzwGTA3wkhvZ+WLgV1AiK2SCbO2uh/apmamOuiLN
	sVBFzTCnaXGrYQzKUu6jrJKFQXqguZ7B0LQod6cpfXHOdLdi1mzrncCsEsXgVFmYyuBCxOLGbIrLl
	l4/6HXdWDcJw6W7Z8kNVgVu6bMOfdZz9PMR9pkkd2RhdbHhe3cwesFNzUGdNw227Sskqm8rfqJ3eB
	TUMJg4wg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLf1e-00000009qcu-2wgL;
	Mon, 24 Jun 2024 08:26:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 58682300754; Mon, 24 Jun 2024 10:26:10 +0200 (CEST)
Date: Mon, 24 Jun 2024 10:26:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [RESEND PATCH 05/12] perf/x86: Add config_mask to represent
 EVENTSEL bitmask
Message-ID: <20240624082610.GB31592@noisy.programming.kicks-ass.net>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-6-kan.liang@linux.intel.com>
 <20240620074402.GS31592@noisy.programming.kicks-ass.net>
 <4cce9f37-7698-418d-a9c5-4aa1dc01b719@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cce9f37-7698-418d-a9c5-4aa1dc01b719@linux.intel.com>

On Thu, Jun 20, 2024 at 12:16:46PM -0400, Liang, Kan wrote:
> 
> 
> On 2024-06-20 3:44 a.m., Peter Zijlstra wrote:
> > On Tue, Jun 18, 2024 at 08:10:37AM -0700, kan.liang@linux.intel.com wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Different vendors may support different fields in EVENTSEL MSR, such as
> >> Intel would introduce new fields umask2 and eq bits in EVENTSEL MSR
> >> since Perfmon version 6. However, a fixed mask X86_RAW_EVENT_MASK is
> >> used to filter the attr.config.
> >>
> > 
> >> @@ -1231,6 +1233,11 @@ static inline int x86_pmu_num_counters_fixed(struct pmu *pmu)
> >>  	return hweight64(hybrid(pmu, fixed_cntr_mask64));
> >>  }
> >>  
> >> +static inline u64 x86_pmu_get_event_config(struct perf_event *event)
> >> +{
> >> +	return event->attr.config & hybrid(event->pmu, config_mask);
> >> +}
> > 
> > Seriously, we're going to be having such major event encoding
> > differences between cores on a single chip?
> 
> For LNL, no. But ARL-H may have an event encoding differences.
> I will double check.
> 
> The problem is that there is no guarantee for the future platforms.
> With the CPUID leaf 0x23, all the features are enumerated per CPU.
> In theory, it's possible that different layout of the EVENTSEL MSR
> between different types of core.
> If we take the virtualization into account, that's even worse.

Virt and hybrid is a trainwreck anyway :/

> It should be a safe way to add the hybrid() check.

Safe yes, sad also yes :-( It would be really nice if they all at least
can commit to the same event format. Could you please check?

