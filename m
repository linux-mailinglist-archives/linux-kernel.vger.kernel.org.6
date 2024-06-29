Return-Path: <linux-kernel+bounces-234725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8444B91C9D3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729A71C20A0A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048D7EDF;
	Sat, 29 Jun 2024 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JLn7TnAK"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E97470
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 00:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719622142; cv=none; b=YNrW7/9PodTjA+xfwvqMoVh0E5MMaBH7dlFbSaAdjAMqulzcHLbQNbpFfVqy77EQT193EFoLz95WeSrM7myWrvYSowmHOy87y8jrdNm/XKYcXoeUQEk+2b5ArT0faSY86a6HTX4Ivb8PgWr0uYbgg1SUhvb17MVTeTkeYmsrsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719622142; c=relaxed/simple;
	bh=cSSVhyrAwwBlmAvQqinUvMCdwtdhU+aSbko/sM7z1+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buHA4Y3iv7f1i63U/tPssSvToRyp6v7PrpLfTemOn6F7PhrEjH/ZmRdNR9mpOnUabyBUW4xLhrE55KWupkLwEQIXi8cdD1bOpV0My3LEQavFErK7UIZ8Ps8wqS8Sql6oUsiJuE+DbNprgsI1wZYRXdstNaioS7EVfXZ2xdxCzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JLn7TnAK; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719622138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jXXMqnvS0Z7opNE0y7FN2J4/pi2QNPt5ck9cYfm2ws=;
	b=JLn7TnAKiBYfzhCQPFb08zPiNv6Nnv9RDrF2Xl6gfO+npQ5zGZuS4C3jqjhi+iF3rpNrzC
	ATmE2IgOxotZK3Ws7u0vShIwl+WBbvGppAUU+Gf01VBd5COEgVihWLPdvqWKsDO/QmyXVT
	AMbQDwvHCPu8hVIszBNXV8ZExgez5Lo=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Fri, 28 Jun 2024 17:48:54 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 6/9] mm: memcg: put memcg1-specific struct
 mem_cgroup's members under CONFIG_MEMCG_V1
Message-ID: <ug2qpeiq6jrtr4qtnblquiod7rgqdqsy6nfu5idnpxqwrzdq6o@mmbsul2g6t52>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
 <20240628210317.272856-7-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628210317.272856-7-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 28, 2024 at 09:03:14PM GMT, Roman Gushchin wrote:
> Put memcg1-specific members of struct mem_cgroup under the
> CONFIG_MEMCG_V1 config option. Also group them close to the end
> of struct mem_cgroup just before the dynamic per-node part.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/memcontrol.h | 103 +++++++++++++++++++------------------
>  1 file changed, 53 insertions(+), 50 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 44ab6394c9ed..107b0c5d6eab 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -188,10 +188,6 @@ struct mem_cgroup {
>  		struct page_counter memsw;	/* v1 only */
>  	};
>  
> -	/* Legacy consumer-oriented counters */
> -	struct page_counter kmem;		/* v1 only */
> -	struct page_counter tcpmem;		/* v1 only */
> -
>  	/* Range enforcement for interrupt charges */
>  	struct work_struct high_work;
>  
> @@ -205,8 +201,6 @@ struct mem_cgroup {
>  	bool zswap_writeback;
>  #endif
>  
> -	unsigned long soft_limit;
> -
>  	/* vmpressure notifications */
>  	struct vmpressure vmpressure;
>  
> @@ -215,13 +209,7 @@ struct mem_cgroup {
>  	 */
>  	bool oom_group;
>  
> -	/* protected by memcg_oom_lock */
> -	bool		oom_lock;
> -	int		under_oom;
> -
> -	int	swappiness;
> -	/* OOM-Killer disable */
> -	int		oom_kill_disable;
> +	int swappiness;
>  
>  	/* memory.events and memory.events.local */
>  	struct cgroup_file events_file;
> @@ -230,27 +218,6 @@ struct mem_cgroup {
>  	/* handle for "memory.swap.events" */
>  	struct cgroup_file swap_events_file;
>  
> -	/* protect arrays of thresholds */
> -	struct mutex thresholds_lock;
> -
> -	/* thresholds for memory usage. RCU-protected */
> -	struct mem_cgroup_thresholds thresholds;
> -
> -	/* thresholds for mem+swap usage. RCU-protected */
> -	struct mem_cgroup_thresholds memsw_thresholds;
> -
> -	/* For oom notifier event fd */
> -	struct list_head oom_notify;
> -
> -	/*
> -	 * Should we move charges of a task when a task is moved into this
> -	 * mem_cgroup ? And what type of charges should we move ?
> -	 */
> -	unsigned long move_charge_at_immigrate;
> -	/* taken only while moving_account > 0 */
> -	spinlock_t		move_lock;
> -	unsigned long		move_lock_flags;
> -
>  	CACHELINE_PADDING(_pad1_);

Let's also remove these _pad1_ and also _pad2_ as well as this
rearrangement nullifies the reasons behind these paddings. We need to
run some perf benchmarks to identify the newer false cache sharing
ields.

