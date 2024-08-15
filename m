Return-Path: <linux-kernel+bounces-288501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8E2953AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49201F25A84
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E417BB15;
	Thu, 15 Aug 2024 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rsWuo946"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536CD5644E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750312; cv=none; b=N9BRTDvjoHns9pGJw65TjNN6rfYn0A0gwQCy4ycVVlRqM30cwGBAe9yRutrtX2+cNyCaljGH89M/wDPyu74kbFjSv5wuddMhIrs0e3uqhmaxezhWxMfc6Yugy1TuiQTZDgfFYqaz8o5+YFTUBqzzBH/EXJ0YjPM1mcjA8mX2lbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750312; c=relaxed/simple;
	bh=vvPutBJy7ASMcST2a0PknGC2RHmZ5IOtSvilW5cVdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYL5XSJhDVcXye+JIf4Z1JRWOl9nOGl08mptj42/BIZHB6V6rDIi8Uq8ALlh1t+qDi5KWHkl1N5emk+OHWpPZKE1R19VxVql3VyWJ1oK/2JK4GHOANfGP8bfmFJSlDdPXkFEe2UG3afbs937KpXI8hndlEVg5SauctMy/W6EMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rsWuo946; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Aug 2024 19:31:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723750307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tp8gjGHWxMUcXCpVWv5SwKW/CTSzHvOts/jHqTX+r9I=;
	b=rsWuo9466d2OLEr7R4fZLS7UlWWe1VAiN4O1ZNn+Tu0kzX4vI/tm6Q1GafDUxwPNzc19SA
	8+hp7ZROiRdPaYQFyIJTNybqRbJXZs2StpLfUxYzdc40f6/B/kQabRLydF8J/AOwlS5bWg
	A4KbN7VlB6eijY5jUbVOs5/nwxGwvsU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] memcg: replace memcg ID idr with xarray
Message-ID: <Zr5Xn45wEJytFTl8@google.com>
References: <20240815155402.3630804-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815155402.3630804-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 15, 2024 at 08:54:02AM -0700, Shakeel Butt wrote:
> At the moment memcg IDs are managed through IDR which requires external
> synchronization mechanisms and makes the allocation code a bit awkward.
> Let's switch to xarray and make the code simpler.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
> Changes since v1:
> - Fix error path in mem_cgroup_alloc (Dan Carpenter)
> 
>  mm/memcontrol.c | 39 ++++++++++-----------------------------
>  1 file changed, 10 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index df84683a0e1c..e8e03a5e1e5e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3408,29 +3408,12 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
>   */
>  
>  #define MEM_CGROUP_ID_MAX	((1UL << MEM_CGROUP_ID_SHIFT) - 1)
> -static DEFINE_IDR(mem_cgroup_idr);
> -static DEFINE_SPINLOCK(memcg_idr_lock);
> -
> -static int mem_cgroup_alloc_id(void)
> -{
> -	int ret;
> -
> -	idr_preload(GFP_KERNEL);
> -	spin_lock(&memcg_idr_lock);
> -	ret = idr_alloc(&mem_cgroup_idr, NULL, 1, MEM_CGROUP_ID_MAX + 1,
> -			GFP_NOWAIT);
> -	spin_unlock(&memcg_idr_lock);
> -	idr_preload_end();
> -	return ret;
> -}
> +static DEFINE_XARRAY_ALLOC1(mem_cgroup_ids);
>  
>  static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>  {
>  	if (memcg->id.id > 0) {
> -		spin_lock(&memcg_idr_lock);
> -		idr_remove(&mem_cgroup_idr, memcg->id.id);
> -		spin_unlock(&memcg_idr_lock);
> -
> +		xa_erase(&mem_cgroup_ids, memcg->id.id);
>  		memcg->id.id = 0;
>  	}
>  }
> @@ -3465,7 +3448,7 @@ static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
>  struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
>  {
>  	WARN_ON_ONCE(!rcu_read_lock_held());
> -	return idr_find(&mem_cgroup_idr, id);
> +	return xa_load(&mem_cgroup_ids, id);
>  }
>  
>  #ifdef CONFIG_SHRINKER_DEBUG
> @@ -3558,17 +3541,17 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  	struct mem_cgroup *memcg;
>  	int node, cpu;
>  	int __maybe_unused i;
> -	long error = -ENOMEM;
> +	long error;
>  
>  	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
>  	if (!memcg)
> -		return ERR_PTR(error);
> +		return ERR_PTR(-ENOMEM);
>  
> -	memcg->id.id = mem_cgroup_alloc_id();
> -	if (memcg->id.id < 0) {
> -		error = memcg->id.id;
> +	error = xa_alloc(&mem_cgroup_ids, &memcg->id.id, NULL,
> +			 XA_LIMIT(1, MEM_CGROUP_ID_MAX), GFP_KERNEL);
> +	if (error)
>  		goto fail;
> -	}
> +	error = -ENOMEM;

There is another subtle change here: xa_alloc() returns -EBUSY in the case
of the address space exhaustion, while the old code returned -ENOSPC.
It's unlikely a big practical problem.

