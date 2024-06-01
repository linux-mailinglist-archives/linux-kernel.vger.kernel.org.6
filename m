Return-Path: <linux-kernel+bounces-197728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5B28D6E83
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BDC1C245D0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7507812E78;
	Sat,  1 Jun 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sjTM+oLf"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1573D8E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717223986; cv=none; b=lnq4zKCpf788NaAPz/+s/T4A31rPZGYh3I80fAraU6NcsYePBD2uM9BmgrvDIauHUpQuWAAcOM7OIT0Xc5c9SiglvgZeOWRe9aVzxzLyFAJmgLNXg7+qqGAJIks6EZ+UR72DG2xrAC9HFgnA3eYwcVpTH5ewdks7R8J0joWYVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717223986; c=relaxed/simple;
	bh=542MK8VuOdG91ZNpdSaYyMqOFHbvTF/wtaA7IMeJHAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SogXOmIF8cckp+iG8g0TIllDO0WPxvMRR27RZlPejvSPiVG3Y34/NmaJLMt1/5uk3uPkUviJLeuprkiX0FWUdE78bIyqrCKeOXoFiSP3Vm8noXbFCI4/SglKhVW/tMyBwnDFSvRqh3klZYXhwIvXx6TCSkhlDT1Lcedo7mUxi/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sjTM+oLf; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717223982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hm9DbePAxZcy5wqy3IhckEJObhpoh9YOVaNcMwxBlYo=;
	b=sjTM+oLfqfdeuMnKKb9nsH/8FjelAbWqfbe1Rg2hCmQrZRBPlgBw3PLVcVLqO/Nm6KSAEj
	WtA57GjtQ4kjBevZ8vxdmblTnAh1bVaNi2ElG5qQKj0b8Zzc2cPHQxlSWYrw+efxmewX5y
	9B5UlySR+W/hcn63V+tOA4d5BFMvEu0=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:39:39 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/14] mm: memcg: rename memcg_check_events()
Message-ID: <axhunwfljdqe7cq6qofkyu3pybqnyqzkxuezjr5srmalqmzzmy@6avfwsk7w7bb>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528202101.3099300-8-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528202101.3099300-8-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 01:20:59PM GMT, Roman Gushchin wrote:
> Rename memcg_check_events() into memcg1_check_events() for
> consistency with other cgroup v1-specific functions.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/memcontrol-v1.c | 6 +++---
>  mm/memcontrol-v1.h | 2 +-
>  mm/memcontrol.c    | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index c47ffb6105931..8b8c2c9516349 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -835,9 +835,9 @@ static int mem_cgroup_move_account(struct folio *folio,
>  
>  	local_irq_disable();
>  	mem_cgroup_charge_statistics(to, nr_pages);
> -	memcg_check_events(to, nid);
> +	memcg1_check_events(to, nid);
>  	mem_cgroup_charge_statistics(from, -nr_pages);
> -	memcg_check_events(from, nid);
> +	memcg1_check_events(from, nid);
>  	local_irq_enable();
>  out:
>  	return ret;
> @@ -1424,7 +1424,7 @@ static void mem_cgroup_threshold(struct mem_cgroup *memcg)
>   * Check events in order.
>   *
>   */
> -void memcg_check_events(struct mem_cgroup *memcg, int nid)
> +void memcg1_check_events(struct mem_cgroup *memcg, int nid)
>  {
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		return;
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 524a2c76ffc97..ef1b7037cbdcc 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -12,7 +12,7 @@ static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
>  }
>  
>  void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
> -void memcg_check_events(struct mem_cgroup *memcg, int nid);
> +void memcg1_check_events(struct mem_cgroup *memcg, int nid);
>  void memcg_oom_recover(struct mem_cgroup *memcg);
>  int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		     unsigned int nr_pages);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6bc9009bee517..c14b1b01bcf53 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2632,7 +2632,7 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  

Once we have memcg->vmstats_v1_percpu field, we can move
mem_cgroup_charge_statistics() to v1 file and the following code blocks
can be abstracted out as well.

>  	local_irq_disable();
>  	mem_cgroup_charge_statistics(memcg, folio_nr_pages(folio));
> -	memcg_check_events(memcg, folio_nid(folio));
> +	memcg1_check_events(memcg, folio_nid(folio));
>  	local_irq_enable();
>  }
>  
> @@ -5699,7 +5699,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  	local_irq_save(flags);
>  	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
>  	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
> -	memcg_check_events(ug->memcg, ug->nid);
> +	memcg1_check_events(ug->memcg, ug->nid);
>  	local_irq_restore(flags);
>  
>  	/* drop reference from uncharge_folio */
> @@ -5839,7 +5839,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
>  
>  	local_irq_save(flags);
>  	mem_cgroup_charge_statistics(memcg, nr_pages);
> -	memcg_check_events(memcg, folio_nid(new));
> +	memcg1_check_events(memcg, folio_nid(new));
>  	local_irq_restore(flags);
>  }
>  
> @@ -6106,7 +6106,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
>  	memcg_stats_lock();
>  	mem_cgroup_charge_statistics(memcg, -nr_entries);
>  	memcg_stats_unlock();
> -	memcg_check_events(memcg, folio_nid(folio));
> +	memcg1_check_events(memcg, folio_nid(folio));
>  
>  	css_put(&memcg->css);
>  }
> -- 
> 2.45.1
> 

