Return-Path: <linux-kernel+bounces-566296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3911A6762C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8AC19C06C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2DB20E012;
	Tue, 18 Mar 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lAAaoRY/"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB220DD5C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307025; cv=none; b=N6YZhKilnCFapmaTkwwbRtIDsnRA3iaeimny5jZBRJCLwvqD3IVwWcY43lugEYA5NtIqvQuYRK4VPPNHyPY1upi/I2sSZ+NS9TH/ubhDA0oGBnJkA7WigApq8X588OOsAcyT//lsiSMRQ3ujYetHawM4VzPPOmdjVWcJCj4MHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307025; c=relaxed/simple;
	bh=L/s03vrxGi8wDre+KKeUbgbJXRYK5FL3hEEpvhZlSsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFE40Kr/bFY2sDbkZ3ZWY/glT67PQQbUn9HvXZIjxbWcETC/mQucITpPB4p0aZx/Mch0oDQ13vKjeo4dZ3dFh22XkkuTGyScq7RhqRmrgTS1MH00zBtJHtxfmWBw/2RGbmfGjBP8RTY7T4AgH1YdXRV1fRUMd9y3ESlMoE/swUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lAAaoRY/; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 14:10:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742307020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/yh8Ym+ECWzQ1Tx2CMjrE4Vg5wnvaSOPbsBq3IpvaIM=;
	b=lAAaoRY/wdVvq+G5Z0aQ7RPljrBAVKz4psTXspaaz8OHii4FtoiNVPOZxKTRmMJ0SrGVEt
	fHIaAePt57dmK905b/oRE98zXZj9HkQeTgHlPpH/Vjc0dM7e+NcSvufkBHsrRLjbCwL3ea
	t6v9oec4XFwNH1m2yedXc7gOY6zu2Is=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yuzhao@google.com,
	mhocko@suse.com, muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add swappiness=max arg to memory.reclaim for only
 anon reclaim
Message-ID: <Z9l-x-b9W32vE8Qn@google.com>
References: <20250318135330.3358345-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318135330.3358345-1-hezhongkun.hzk@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 18, 2025 at 09:53:30PM +0800, Zhongkun He wrote:
> With this patch 'commit <68cd9050d871> ("mm: add swappiness= arg to
> memory.reclaim")', we can submit an additional swappiness=<val> argument
> to memory.reclaim. It is very useful because we can dynamically adjust
> the reclamation ratio based on the anonymous folios and file folios of
> each cgroup. For example,when swappiness is set to 0, we only reclaim
> from file folios.
> 
> However,we have also encountered a new issue: when swappiness is set to
> the MAX_SWAPPINESS, it may still only reclaim file folios.
> 
> So, we hope to add a new arg 'swappiness=max' in memory.reclaim where
> proactive memory reclaim only reclaims from anonymous folios when
> swappiness is set to max. The swappiness semantics from a user
> perspective remain unchanged.
> 
> For example, something like this:
> 
> echo "2M swappiness=max" > /sys/fs/cgroup/memory.reclaim
> 
> will perform reclaim on the rootcg with a swappiness setting of 'max' (a
> new mode) regardless of the file folios. Users have a more comprehensive
> view of the application's memory distribution because there are many
> metrics available. For example, if we find that a certain cgroup has a
> large number of inactive anon folios, we can reclaim only those and skip
> file folios, because with the zram/zswap, the IO tradeoff that
> cache_trim_mode or other file first logic is making doesn't hold -
> file refaults will cause IO, whereas anon decompression will not.
> 
> With this patch, the swappiness argument of memory.reclaim has a new
> mode 'max', means reclaiming just from anonymous folios both in traditional
> LRU and MGLRU.

Is MGLRU handled in this patch?

> 
> Here is the previous discussion:
> https://lore.kernel.org/all/20250314033350.1156370-1-hezhongkun.hzk@bytedance.com/
> https://lore.kernel.org/all/20250312094337.2296278-1-hezhongkun.hzk@bytedance.com/
> 
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  4 ++++
>  include/linux/swap.h                    |  4 ++++
>  mm/memcontrol.c                         |  5 +++++
>  mm/vmscan.c                             | 10 ++++++++++
>  4 files changed, 23 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index cb1b4e759b7e..c39ef4314499 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1343,6 +1343,10 @@ The following nested keys are defined.
>  	same semantics as vm.swappiness applied to memcg reclaim with
>  	all the existing limitations and potential future extensions.
>  
> +	If set swappiness=max, memory reclamation will exclusively
> +	target the anonymous folio list for both traditional LRU and
> +	MGLRU reclamation algorithms.
> +

I don't think we need to specify LRU and MGLRU here. What about:

Setting swappiness=max exclusively reclaims anonymous memory.

>    memory.peak
>  	A read-write single value file which exists on non-root cgroups.
>  
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index b13b72645db3..a94efac10fe5 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -419,6 +419,10 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
>  #define MIN_SWAPPINESS 0
>  #define MAX_SWAPPINESS 200
> +
> +/* Just recliam from anon folios in proactive memory reclaim */
> +#define ONLY_ANON_RECLAIM_MODE (MAX_SWAPPINESS + 1)
> +

This is a swappiness value so let's keep that clear, e.g.
SWAPPINESS_ANON_ONLY or similar.

>  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  						  unsigned long nr_pages,
>  						  gfp_t gfp_mask,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4de6acb9b8ec..0d0400f141d1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4291,11 +4291,13 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
>  
>  enum {
>  	MEMORY_RECLAIM_SWAPPINESS = 0,
> +	MEMORY_RECLAIM_ONLY_ANON_MODE,
>  	MEMORY_RECLAIM_NULL,
>  };
>  
>  static const match_table_t tokens = {
>  	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
> +	{ MEMORY_RECLAIM_ONLY_ANON_MODE, "swappiness=max"},

MEMORY_RECLAIM_SWAPPINESS_MAX?

>  	{ MEMORY_RECLAIM_NULL, NULL },
>  };
>  
> @@ -4329,6 +4331,9 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  			if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
>  				return -EINVAL;
>  			break;
> +		case MEMORY_RECLAIM_ONLY_ANON_MODE:
> +			swappiness = ONLY_ANON_RECLAIM_MODE;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c767d71c43d7..779a9a3cf715 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2438,6 +2438,16 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  		goto out;
>  	}
>  
> +	/*
> +	 * Do not bother scanning file folios if the memory reclaim
> +	 * invoked by userspace through memory.reclaim and set
> +	 * 'swappiness=max'.
> +	 */

/* Proactive reclaim initiated by userspace for anonymous memory only */

> +	if (sc->proactive && (swappiness == ONLY_ANON_RECLAIM_MODE)) {

Do we need to check sc->proactive here? Supposedly this swappiness value
can only be passed in from proactive reclaim. Instead of silently
ignoring the value from other paths, I wonder if we should WARN on
!sc->proactive instead.

> +		scan_balance = SCAN_ANON;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Do not apply any pressure balancing cleverness when the
>  	 * system is close to OOM, scan both anon and file equally
> -- 
> 2.39.5
> 

