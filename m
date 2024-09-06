Return-Path: <linux-kernel+bounces-319115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D768796F7ED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8231F21B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B069E1D2F45;
	Fri,  6 Sep 2024 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MMTINSCa"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F61C9EA4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635525; cv=none; b=k7O0bMquN4Bc7peeQwPZyI4KkALz5vxu0aO1HKEPTxD10ehgnpP9agjKXHKCbyeBqWV9L+jpW8rvuz3zZSoFFLY/DVqD86NglgvlONQNdsGDbR1qadGv7N6Y63zbQwtHrI7axnWloG4jIfuKB5wvKQDCLVGamAu/6/CCn6bSeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635525; c=relaxed/simple;
	bh=KZ8ycNl1smLGMiKkaKG9mqETvEzKrx08A5JeCZehCn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPWWE5/eBlu6j39D95Z9ZHySE7ExA2TP5sQX/TPNGGjHqmdbWPhv6W6UONEXzOc6eG2q1b54xgCba4vIk1eydXVi0O3SQZjGfGQebLUp1wExXX+CKlmWWUe/y3JlzLVojMEDrW+60ABJ+OLJBmosMAXIMy0Ho4mZ/nHr5OWoOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MMTINSCa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4KtlGRE+XqkN5ReAUGUK00NC9g09bXflHijBmLUF1FE=; b=MMTINSCaQIcvKQ+FuKNsn8uYZP
	vP9f/bUG6r5nJcqeGJwdKfbjrOK02SHjK/reaLKJnTtnLODQg+wSOXsgwIZnWwJN3BzY90mP084nt
	D/wfjMHPeAq++2oI5/zHQEAW7JDGHSKr2dBwIdUAyUFXLgv2hdPlJzpQsSFPjPRvkc9wo9bMfTG+h
	FxnOnddK4tICejWXyLWbPE3woLPTaOsnxHqTnXsu3UZDtmIXTBnUXeHxIsQHYvf0OKIEvaiJbRdIp
	qjqCMBlsWr8isAAO/jtUOZxvvewMAsDmF8YMwKQuvvXwdb3fCMLchb787MoHsT56qDh7uJAl7sTqa
	NDldYPFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smacs-00000000goU-3OrL;
	Fri, 06 Sep 2024 15:11:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 042283003E1; Fri,  6 Sep 2024 17:11:54 +0200 (CEST)
Date: Fri, 6 Sep 2024 17:11:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] perf: Add PERF_EV_CAP_READ_SCOPE
Message-ID: <20240906151153.GX4723@noisy.programming.kicks-ass.net>
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802151643.1691631-3-kan.liang@linux.intel.com>

On Fri, Aug 02, 2024 at 08:16:38AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Usually, an event can be read from any CPU of the scope. It doesn't need
> to be read from the advertised CPU.
> 
> Add a new event cap, PERF_EV_CAP_READ_SCOPE. An event of a PMU with
> scope can be read from any active CPU in the scope.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  include/linux/perf_event.h |  3 +++
>  kernel/events/core.c       | 14 +++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 1102d5c2be70..1206bc86eb4f 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -633,10 +633,13 @@ typedef void (*perf_overflow_handler_t)(struct perf_event *,
>   * PERF_EV_CAP_SIBLING: An event with this flag must be a group sibling and
>   * cannot be a group leader. If an event with this flag is detached from the
>   * group it is scheduled out and moved into an unrecoverable ERROR state.
> + * PERF_EV_CAP_READ_SCOPE: A CPU event that can be read from any CPU of the
> + * PMU scope where it is active.
>   */
>  #define PERF_EV_CAP_SOFTWARE		BIT(0)
>  #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
>  #define PERF_EV_CAP_SIBLING		BIT(2)
> +#define PERF_EV_CAP_READ_SCOPE		BIT(3)
>  
>  #define SWEVENT_HLIST_BITS		8
>  #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5e1877c4cb4c..c55294f34575 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4463,16 +4463,24 @@ struct perf_read_data {
>  	int ret;
>  };
>  
> +static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int scope, int cpu);
> +
>  static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
>  {
> +	int local_cpu = smp_processor_id();
>  	u16 local_pkg, event_pkg;
>  
>  	if ((unsigned)event_cpu >= nr_cpu_ids)
>  		return event_cpu;
>  
> -	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
> -		int local_cpu = smp_processor_id();
> +	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
> +		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
> +
> +		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
> +			return local_cpu;
> +	}
>  
> +	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {

I'm guessing the goal is to eventually remove this one, right?

