Return-Path: <linux-kernel+bounces-192584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E038D1F63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727131F235E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2F51094E;
	Tue, 28 May 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NlGiyNP2"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69EA1667C5
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908406; cv=none; b=Nn+jeMWxWivWUzzKDc0w9sNBXlyNEMXuTvyNrvNqpilwX/xFmiNqbzTfGtZkHAhlaoRLkB1zG39Hw6qbDwg4ABqU9taDR2GTbbVII9nQ4cIiAHPCDnF36AxCr1kyCTwv70pVKAPC26VOEG+cmCI5IJW2azBBAnAP/A6J3MXHlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908406; c=relaxed/simple;
	bh=/AmBie/cpg2EO4euYtI9iMGd1p4j1CSfgwVjth6e9rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDgwQmfc0x1iFYIYCYRRDNqDpAAhiu2H6+2JmFr/wPk5yMkGvB0DDuo/47JIkBUd8uMrL4UqR2lhs47r/mX6GRnkCBZt6KvhhtqZbR5RgaX/byzEWHt0DUptUaAo+mOJ4dRfwIpL7Ba2AT1j9norBDtZ5Y5AQNj6atNH/RZMgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NlGiyNP2; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bigeasy@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716908402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ELpKrf3yGg/U1k60rinfhuNPqARS7v2TuZgtOoQ2sk=;
	b=NlGiyNP284ZecaX4V/B7HHJ/PIVBiPiBRiayMqi2qcwUHFR9EdHinOz8+C5Z+LPXhLLXMu
	285nXeDPZG4Gt0zR/nRSQ/U339mugT/puBl7oUtFcKyWYLS1cx9Q6nEl3M+VyrDg5Uzt/N
	uq7h4aoNm0kyf+CbSWmRhYmCjRl2qhQ=
X-Envelope-To: vbabka@kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tglx@linutronix.de
Date: Tue, 28 May 2024 07:59:57 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] memcg: Remove the lockdep assert from
 __mod_objcg_mlstate().
Message-ID: <dk4tgppzjy53qr6274cetbyhqjjvsvmjgtknzrsueagoomuchb@sxolann3nib6>
References: <20240528121928.i-Gu7Jvg@linutronix.de>
 <09e085bb-f09e-4901-a2dd-a0b789bb8a4d@kernel.org>
 <20240528134027.OxDASsS3@linutronix.de>
 <c84d6962-34fa-42e5-899c-925579cbfb26@kernel.org>
 <20240528141341.rz_rytN_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528141341.rz_rytN_@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 04:13:41PM GMT, Sebastian Andrzej Siewior wrote:
> The assert was introduced in the commit cited below as an insurance that
> the semantic is the same after the local_irq_save() has been removed and
> the function has been made static.
> 
> The original requirement to disable interrupt was due the modification
> of per-CPU counters which require interrupts to be disabled because the
> counter update operation is not atomic and some of the counters are
> updated from interrupt context.
> 
> All callers of __mod_objcg_mlstate() acquire a lock
> (memcg_stock.stock_lock) which disables interrupts on !PREEMPT_RT and
> the lockdep assert is satisfied. On PREEMPT_RT the interrupts are not
> disabled and the assert triggers.
> 
> The safety of the counter update is already ensured by
> VM_WARN_ON_IRQS_ENABLED() which is part of __mod_memcg_lruvec_state() and
> does not require yet another check.

One question on VM_WARN_ON_IRQS_ENABLED() in __mod_memcg_lruvec_state().
On a PREEMPT_RT kernel with CONFIG_DEBUG_VM, will that
VM_WARN_ON_IRQS_ENABLED() cause a splat or VM_WARN_ON_IRQS_ENABLED is
special on PREEMPT_RT kernels?

> 
> Remove the lockdep assert from __mod_objcg_mlstate().
> 
> Fixes: 91882c1617c15 ("memcg: simple cleanup of stats update functions")
> Link: https://lore.kernel.org/r/20240528121928.i-Gu7Jvg@linutronix.de
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> On 2024-05-28 15:44:51 [+0200], Vlastimil Babka (SUSE) wrote:
> > I think just s/memcg_stats_lock()/__mod_memcg_lruvec_state()/ in your
> > phrasing, since we are removing the lockdep assert from path that calls
> > __mod_memcg_lruvec_state() and not memcg_stats_lock()?
> > Or am I missing something?
> 
> Yeah, makes sense.
> 
>  mm/memcontrol.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3147,8 +3147,6 @@ static inline void __mod_objcg_mlstate(s
>  	struct mem_cgroup *memcg;
>  	struct lruvec *lruvec;
>  
> -	lockdep_assert_irqs_disabled();
> -
>  	rcu_read_lock();
>  	memcg = obj_cgroup_memcg(objcg);
>  	lruvec = mem_cgroup_lruvec(memcg, pgdat);

