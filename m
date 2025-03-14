Return-Path: <linux-kernel+bounces-560550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20BCA60682
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE9B3BCFCE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E85E4C7D;
	Fri, 14 Mar 2025 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ejugr1nw"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43CE645
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741911469; cv=none; b=KiSN2omR5fWgLveITCO7LUXE6PVuA1Qubecv/EXfjlToNNu8fQLxiOspjj3eIvrzXfR9rMs5UWwe44odKppxhw6oDws1c9N7KAiQzP/7PoL0k2Pqp6AJMP5PjB+3BjRYr/I5O4921FV0qfKgscP975e+PCFk77+16lBE8rU3Ylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741911469; c=relaxed/simple;
	bh=rwkPiqhj55gkg+bn1X7ruwYdkuVVT3kqHqRUb1eBaek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqW1TotRG+dG2IaNRa/qycsi8JGodQ4lkB0cYgmmdw9d609EZjXL5JwH2x3ZxdIw8/ZxPJej0jAvedCkeDhiXYVEsbHkL2KIA3a9FLLymk+TkOlRfjOqUW/n72jHbKdnUXOxJjax5ZynMLDgIP3mNhIY0Lha+VklRH1XdOKSkWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ejugr1nw; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 00:17:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741911464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+4LDr8b1UADNuiOjRFlkioCNLHtqn/OFPYvEBwiVkY=;
	b=Ejugr1nwbZ+MM0aIlGoFdawDyyNuEFjuJGu+2l90TaF2p3vGyHU5Y0m14TDotM2NeDLV4q
	bjhBIu215h/cYt1eDA/5orirKC7i0pi/u66o3/TBr/2IE++SxMMe6bg0tv4t8HcICVZuHd
	pUBCFgDNvZ1yWiDZGI5/pcFGw37CVow=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
	muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: skip the file folios in proactive reclaim if
 swappiness is MAX
Message-ID: <Z9N1ntdaKpxlrq26@google.com>
References: <20250312094337.2296278-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312094337.2296278-1-hezhongkun.hzk@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 12, 2025 at 05:43:37PM +0800, Zhongkun He wrote:
> With this patch 'commit <68cd9050d871> ("mm: add swappiness= arg to
> memory.reclaim")', we can submit an additional swappiness=<val> argument
> to memory.reclaim. It is very useful because we can dynamically adjust
> the reclamation ratio based on the anonymous folios and file folios of
> each cgroup. For example,when swappiness is set to 0, we only reclaim
> from file pages.
> 
> However,we have also encountered a new issue: when swappiness is set to
> the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
> to the knob of cache_trim_mode, which depends solely on the ratio of
> inactive folios, regardless of whether there are a large number of cold
> folios in anonymous folio list.
> 
> So, we hope to add a new control logic where proactive memory reclaim only
> reclaims from anonymous folios when swappiness is set to MAX_SWAPPINESS.
> For example, something like this:
> 
> echo "2M swappiness=200" > /sys/fs/cgroup/memory.reclaim
> 
> will perform reclaim on the rootcg with a swappiness setting of 200 (max
> swappiness) regardless of the file folios. Users have a more comprehensive
> view of the application's memory distribution because there are many
> metrics available.
> 
> With this patch, the swappiness argument of memory.reclaim has a more
> precise semantics: 0 means reclaiming only from file pages, while 200
> means reclaiming just from anonymous pages.
> 
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  mm/vmscan.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c767d71c43d7..f4312b41e0e0 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2438,6 +2438,16 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  		goto out;
>  	}
>  
> +	/*
> +	 * Do not bother scanning file folios if the memory reclaim
> +	 * invoked by userspace through memory.reclaim and the
> +	 * swappiness is MAX_SWAPPINESS.
> +	 */
> +	if (sc->proactive && (swappiness == MAX_SWAPPINESS)) {
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
> 

