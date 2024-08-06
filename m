Return-Path: <linux-kernel+bounces-275844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE76948AE6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3AC1C22732
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1131BCA13;
	Tue,  6 Aug 2024 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NMTDURMV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5911BCA0D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931686; cv=none; b=fxEcfBwM1bBa79YtGzOKvPoUHpmaw+gV93JnV7PnR2fMQ1Law8iQkKu12TH+EStpkW/VtJVWhPzR5GDvMZRWx0cpLGX3876gZ6n+vEhFGBhILzMlnwvkH3Z7FdYCIxlCVY1DPtHSOr6jN2MUrUTw+b+U2T4fPH1mB11Si6ASnoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931686; c=relaxed/simple;
	bh=FBmv/1mMUMtmoVaqDCjCNU+JbyEqNiF+6Rx1D/EScDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcHVYi3MilhSkphBxMBZgc6zVab0rVDmvidmq+ZuUfSNFhPDs2vhQlA5sbOm7AymuqnHLP14J6cNneEKMODxDq9vDNsjiSKN9Bf6b23jBvHlO+jjLuJZ1VJlXT94nnBqdf5nwr6qnxk1YaozIOfU4UEb4T1BJgUoymPhZVIyq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NMTDURMV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2l9hno7U/++q07/aPrJaio/HGg/vk7idZdCdfjSW4Zg=; b=NMTDURMV9O41mygfelcFKtBWIk
	kg8GeRcwQt+r+P+ijFB0BhVHPMDA6AxPUTeysyjw94j3hVTuS2oMQTDVET+Dk61OVEv/ga501vy7Z
	1uhnLz0pq+YNgMgi4ggTvDxMW0l3+T8IP70/tCkRRH9ckaHVWm5vMgTFBlCDKZAP3sxDR2BdmxyuV
	NKuXbuFphfwAJNH1kbWTrCypJDTtInlqEk5GescK57GCB50KVyRkHes1zInhCrNYbvFITdbOTbyd/
	7kfyh90Nk7QQ5tUIoXtC/Dozwcci0I56O/bgZKt9neNtWSpiRDITyhdP1/+6t5InCTVhlFON/UbN+
	I0NWLGcg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbFEc-00000005Qdh-126R;
	Tue, 06 Aug 2024 08:07:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DADAA300ABE; Tue,  6 Aug 2024 10:07:57 +0200 (CEST)
Date: Tue, 6 Aug 2024 10:07:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH v2] perf/core: Optimize event reschedule for a PMU
Message-ID: <20240806080757.GF12673@noisy.programming.kicks-ass.net>
References: <20240731000607.543783-1-namhyung@kernel.org>
 <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240805092058.GK37996@noisy.programming.kicks-ass.net>
 <20240805145827.GE12673@noisy.programming.kicks-ass.net>
 <CAM9d7cj8YMt-YiVZ=7dRiEnfODqo=WLRJ87Rd134YR_O6MU_Qg@mail.gmail.com>
 <20240806075630.GL37996@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806075630.GL37996@noisy.programming.kicks-ass.net>

On Tue, Aug 06, 2024 at 09:56:30AM +0200, Peter Zijlstra wrote:

> Does this help? What would be an easy reproducer?
> 
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c67fc43fe877..4a04611333d9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -179,23 +179,27 @@ static void perf_ctx_lock(struct perf_cpu_context *cpuctx,
>  	}
>  }
>  
> +static inline void __perf_ctx_unlock(struct perf_event_context *ctx)
> +{
> +	/*
> +	 * If ctx_sched_in() didn't again set any ALL flags, clean up
> +	 * after ctx_sched_out() by clearing is_active.
> +	 */
> +	if (ctx->is_active & EVENT_FROZEN) {
> +		if (!(ctx->is_active & EVENT_ALL))
> +			ctx->is_active = 0;
> +		else
> +			ctx->is_active &= ~EVENT_FROZEN;
> +	}
> +	raw_spin_unlock(&ctx->lock);
> +}
> +
>  static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
>  			    struct perf_event_context *ctx)
>  {
> -	if (ctx) {
> -		/*
> -		 * If ctx_sched_in() didn't again set any ALL flags, clean up
> -		 * after ctx_sched_out() by clearing is_active.
> -		 */
> -		if (ctx->is_active & EVENT_FROZEN) {
> -			if (!(ctx->is_active & EVENT_ALL))
> -				ctx->is_active = 0;
> -			else
> -				ctx->is_active &= ~EVENT_FROZEN;
> -		}
> -		raw_spin_unlock(&ctx->lock);
> -	}
> -	raw_spin_unlock(&cpuctx->ctx.lock);
> +	if (ctx)
> +		__perf_ctx_unlock(ctx);
> +	__perf_ctx_unlock(&cpuctx->ctx.lock);

Obviously that wants to be just: &cpuctx->ctx :-)

>  }
>  
>  #define TASK_TOMBSTONE ((void *)-1L)

