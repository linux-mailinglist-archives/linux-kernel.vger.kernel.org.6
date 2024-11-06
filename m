Return-Path: <linux-kernel+bounces-398697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2686D9BF4D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D0F1C23270
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F08207A1F;
	Wed,  6 Nov 2024 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iSlLa/Wt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AFE207A19
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916383; cv=none; b=qpTTr2vfJQShOPXsgBEHncitBO+aAhD4Q00cTyS8mGMU4e7PgjQPMDaaX727Ul9k++DLBTNS4lYAR4B+GlfBgpXaO1E+sjko09/Ewykdj0CVYoLDSJuLfdnJW7pW3Fo+8hB5GsuW8z45nRRQgiy1BPASw+clL7JgnYkJQSPOllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916383; c=relaxed/simple;
	bh=GTHKe0ymyoYw3PBQepXHYDCepXxmuKG5AEFhsgkQVwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dz/YonbszsOm/16y05utXIY29tMPD74aV/pVpp7TmomDHyCdyM3yKLVAD4Zc5EvLtbKqg1bDV+TVsdBJo1WsWic4qse4qkNT4aEtp31qz1/38J4Vj4K4Dyhej66vB9IarrUTq3bcNhndolPFC9rN1xKvS9Elw2jMG58zcI63NcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iSlLa/Wt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ktiYEZPNTXVbDlJWeKZ3D8MKCbiDmZrAL5yTcsVdQuM=; b=iSlLa/WtvxZIvXIZa+i3IFbcyf
	ipIOmx/nd9gxsyS4j7IJrVxScrpsdJLHxtBJ5J5D4Ogl/tjcZOG4Orv8biwWfAGrhGASbF6A5pP8n
	grODpsMjLnKKnaxzpfDbUDF9FQn6ZMOh94FxcNIlRr7LBz5Rzmkc1HHeF1CpPFNxWQeATvN3paXRa
	xr/q+90e85IPfOmExxgtbVDLRuLdleIFlcUf/OrynPk9cBbzzn4jjDEIrwl9oPxhtA6x/Dp23Iwy3
	Eb5KXQrWbuzSH1ih9M5Ft/IBPXXrYLO4Qck7x51De1m0mflL6biybh4vCMiGrV9Dl+Z0T4WaBIa8k
	4o0yoCBA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8kQ1-000000054Gx-0O6g;
	Wed, 06 Nov 2024 18:06:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 594DB300478; Wed,  6 Nov 2024 19:06:13 +0100 (CET)
Date: Wed, 6 Nov 2024 19:06:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Chen Yu <yu.c.chen@intel.com>, Leonardo Bras <leobras@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3 0/3] sched/topology: optimize topology_span_sane()
Message-ID: <20241106180613.GQ10375@noisy.programming.kicks-ass.net>
References: <20240902183609.1683756-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902183609.1683756-1-yury.norov@gmail.com>

On Mon, Sep 02, 2024 at 11:36:04AM -0700, Yury Norov wrote:
> The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> even when cpu != i. In such case, cpumask_equal() would always return
> true, and we can proceed to the next iteration immediately.
> 
> Valentin Schneider shares on it:
> 
>   PKG can potentially hit that condition, and so can any
>   sched_domain_mask_f that relies on the node masks...
> 
>   I'm thinking ideally we should have checks in place to
>   ensure all node_to_cpumask_map[] masks are disjoint,
>   then we could entirely skip the levels that use these
>   masks in topology_span_sane(), but there's unfortunately
>   no nice way to flag them... Also there would be cases
>   where there's no real difference between PKG and NODE
>   other than NODE is still based on a per-cpu cpumask and
>   PKG isn't, so I don't see a nicer way to go about this.
> 
> v1: https://lore.kernel.org/lkml/ZrJk00cmVaUIAr4G@yury-ThinkPad/T/
> v2: https://lkml.org/lkml/2024/8/7/1299
> v3:
>  - add topology_cpumask_equal() helper in #3;
>  - re-use 'cpu' as an iterator int the for_each_cpu() loop;
>  - add proper versioning for all patches.
> 
> Yury Norov (3):
>   sched/topology: pre-compute topology_span_sane() loop params
>   sched/topology: optimize topology_span_sane()
>   sched/topology: reorganize topology_span_sane() checking order

Why are we doing this? Subject says optimize, but I see no performance
numbers?

