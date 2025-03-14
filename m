Return-Path: <linux-kernel+bounces-562151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54585A61D81
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988281775E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E74E19E7D0;
	Fri, 14 Mar 2025 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g4+7MCO6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A5919883C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986261; cv=none; b=tkTmm0nbK1Bcb21shnD5QXpI9rxQ0BBsa9cmSZ51ABU/OLTGZUBXFrqrDCVgiCkMlR2hLYEwXH8SaFb7Jym3domFoDkQCpUeTelLuzBcBjGSKTramJd3WlsKLsbcI4hvMRnrZIeuBiw7l9CcYnylECmGIJ5Iu4xQJaxx9ExJ5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986261; c=relaxed/simple;
	bh=eeRrQbvrlzsm9mo7suWPzGFqEaXfQ8hIq6jCw1ihYD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbdJjvad7G98NyiJSqSBseoIDNFHVmhQ87PNoBM1qDfmmiQWh+b5oDwk3LxUM+ZnwxqRtVKeLI849jPXl66yAWC7wDZb78vyav4MxEBp9rKJPzhvZGo9oIm1fcmzGcnX5pR12I/0OWZidM9FhC0+z2OTUTTSNy9kQneQ7YoapqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g4+7MCO6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZITUSRNPLprkKVt3En18iXNm9NI6Htv8maC5m6qlXvg=; b=g4+7MCO61NI8fH8ZxS34t7A+nF
	/pkiAx06PksEGFqcId77UlNT6v/MU2SAOCKNV1w2HTptAjJU9q1erwR9wya4+XgRErUvhQ2ihzBuQ
	i9n2B0TEXBeq04rk5W1vzZ/OThlBf05aHZtvjb3DVoaBtbX4YwTxvWxa0ApL1etOnef77QE9m+kZA
	9g1Xw/KqpYVs/jwH+27VCfGHrygff+Ccya7MsUwNKL3y9ewNFEZQfe7M4DFIiwxwAlPvxzDb43Ncf
	hs5jd0FNEtjsHHMalTdk0B9/nWBLoUwG0EbFhI05Riyh8kKbE8j947XIzerXHT9q+ENEC1g28rIPj
	uK+Z4ATQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ttCCF-00000006IDw-2q5I;
	Fri, 14 Mar 2025 21:04:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 667E8300599; Fri, 14 Mar 2025 22:03:58 +0100 (CET)
Date: Fri, 14 Mar 2025 22:03:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com,
	linux-kernel@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH V9 3/7] perf: attach/detach PMU specific data
Message-ID: <20250314210358.GA21786@noisy.programming.kicks-ass.net>
References: <20250314000242.323199-1-kan.liang@linux.intel.com>
 <20250314000242.323199-3-kan.liang@linux.intel.com>
 <20250314125958.GC36322@noisy.programming.kicks-ass.net>
 <a619615f-3313-4e55-a780-f280fbb643dc@linux.intel.com>
 <1ec56e83-be22-480c-be60-5b898fc5f5b7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec56e83-be22-480c-be60-5b898fc5f5b7@linux.intel.com>

On Fri, Mar 14, 2025 at 10:38:29AM -0400, Liang, Kan wrote:
> I think the attach_perf_ctx_data() should be moved even earlier, right
> after the perf_init_event(). Because the PERF_ATTACH_TASK_DATA is set in
> the event_init()->hw_config(), rather than after perf attach the data.
> 
> So any errors between perf_init_event() and attach_perf_ctx_data(event)
> would cause the detach_perf_ctx_data() mistakenly invoked.
> 
> @@ -5393,6 +5607,9 @@ static void __free_event(struct perf_event *event)
>  	if (is_cgroup_event(event))
>  		perf_detach_cgroup(event);
> 
> +	if (event->attach_state & PERF_ATTACH_TASK_DATA)
> +		detach_perf_ctx_data(event);
> +
>  	if (event->destroy)
>  		event->destroy(event);
> @@ -12481,6 +12746,18 @@ perf_event_alloc(struct perf_event_attr *attr,
> int cpu,
>  	if (IS_ERR(pmu))
>  		return (void*)pmu;
> 
> +	/*
> +	 * The PERF_ATTACH_TASK_DATA is set in the event_init()->hw_config().
> +	 * The attach should be right after the perf_init_event().
> +	 * Otherwise, the __free_event() would mistakenly detach the non-exist
> +	 * perf_ctx_data because of the other errors between them.
> +	 */
> +	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
> +		err = attach_perf_ctx_data(event);
> + 		if (err)
> +			return ERR_PTR(err);
> +	}
> +

AFAICT it is possible for perF_init_event() to return an error *and* set
ATTACH_TASK_DATA, at which point we're up a creek with __free_event().

I'm afraid we need more state to track this.

(additionally, I'll need to rebase the pmu_unregister patch on top of
this -- that needs more changes still).

Anyway, let me go poke at this a bit, see what I can do with v10.

I'll reply there.

