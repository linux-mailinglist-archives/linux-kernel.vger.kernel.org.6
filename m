Return-Path: <linux-kernel+bounces-237490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297EA923998
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634461C214C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97015533B;
	Tue,  2 Jul 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ef0Q0TyH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468E153BFA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911733; cv=none; b=WDt6CklCv7VoqHL6TASVOvjLfrt9Y+dm8UmVPXBpwckDxgKXbphyJlYJNYjvdGRRASWOUrg3RotalNS5xD0OzooWVEJYiUZ7/ph423+NYIMgFuZmbYoIxPFS2FYKB7cHKDuVRMkRs83esotFConxvZAXHi+v618JSd1oPdymWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911733; c=relaxed/simple;
	bh=x8O97DEZPgQhWLob7+pXj/VXdusYxVqk5LngBSgOZCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwK8GUCTUlhcy5UsQ3Vlqi7yFUWKpc93u8IM4E85+MyDxYMneItTtpHYVlRikK+zV8xuxAVYuXI7/wsf5g5JP83TeHEUTq/jrO+IRxWBsz2ZNsXiBAiZIr4Y1Fv0ITw09bDak+rDSlzfuR0AQFOa2VFOo9HboJlyDomAiBzHsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ef0Q0TyH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nFOLrii+a7A5+5R1fp/ZHouWeXJUp2LUhKv44nnc4qM=; b=Ef0Q0TyH9F1UktnQ+QschrioxN
	DjnZYikYKUZosbbf511FUt0JMY5HD5wCv1GExsOhZNeJHuagh9v3J3MEp1gL1+itjtrfOsosHknEn
	WeZuNtYhplCfJ2R6SH9Gm9pqbK3/jJimsJAKEUrDCcB6VOugifOj5VGXv2gjMtXoNLO0dZiHdocxn
	INK2/l2Ml9JLNPcGEzPOcn8Dc6C3ISWm+/JjNQv9vPTyt3L395ceKnxwzUkObx2Ad/MeXjJlRFkPf
	n76ObZhb7G/xTX9NeHSIS3V68MgncXtIGfuDpBaDebUdLzd1x/vkjVzioSnlTC9/Yat7kv/HJled8
	qLOce4UA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZbj-00000000cyy-0FTK;
	Tue, 02 Jul 2024 09:15:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0F7D0300694; Tue,  2 Jul 2024 11:15:24 +0200 (CEST)
Date: Tue, 2 Jul 2024 11:15:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Stephane Eranian <eranian@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [RESEND Patch 1/2] perf/x86: Remove perf_events_lapic_init()
 calling from x86_pmu_enable()
Message-ID: <20240702091523.GD11386@noisy.programming.kicks-ass.net>
References: <20240702225703.346951-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702225703.346951-1-dapeng1.mi@linux.intel.com>

On Wed, Jul 03, 2024 at 06:57:02AM +0800, Dapeng Mi wrote:
> perf_events_lapic_init() helper is called to configure PMI to NMI vector
> and clear MASK bit simultaneously by writing APIC_LVTPC MSR. It's called
> firstly to initialize APIC_LVTPC MSR by init_hw_perf_events(), and the
> PMI handler would always to clear the MASK bit in APIC_LVTPC MSR by
> writing APIC_LVTPC MSR directly.
> 
> So it becomes unnecessary to call perf_events_lapic_init() again in
> x86_pmu_enable(), and worse x86_pmu_enable() could be called very
> frequently in some scenarios with very high context-switches. This would
> cause performance overhead which can't be ignored especially in KVM guest
> environment since frequent APIC_LVTPC writing would cause huge number
> of VM-Exits.
> 
> For example, in guest environment Geekbench score (running multiplxing
> perf-stat command in background) increases 1% and perf-sched benchmark
> increases 7% after removing perf_events_lapic_init() calling from
> x86_pmu_enable().
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 5b0dd07b1ef1..580923443813 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1347,7 +1347,6 @@ static void x86_pmu_enable(struct pmu *pmu)
>  			x86_pmu_start(event, PERF_EF_RELOAD);
>  		}
>  		cpuc->n_added = 0;
> -		perf_events_lapic_init();
>  	}

Stephane, I don't suppose you remember why you put that there? Afaict
the above reasoning is correct and this one is entirely superfluous, but
this hardware is 'funny' at the best of times and maybe I'm overlooking
something.



