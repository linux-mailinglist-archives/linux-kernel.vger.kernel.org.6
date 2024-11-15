Return-Path: <linux-kernel+bounces-411281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1734E9CF59A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B277F282934
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05EE1D88D7;
	Fri, 15 Nov 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E0jW7+/Z"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7FE161320
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701875; cv=none; b=GMrg7kysXVrgOl+mpTyrBZgK6LkpbBsOSrwLRGhe5CaQWMR0v8WIBdrKpcpEXbRkqa5FcNflV/fzPZOTDk2w2UlhVcEr/q6KsWM2Hj6/V3P5Ysfr6tALRf/kuEbFh2ztJIfjKaeXaZWMNxWTOqEU0F19RZS5wQRojuIh1b/t78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701875; c=relaxed/simple;
	bh=CfaiwzRO/eJmKADjj0KOQHld4y2IaVd6NuIBCCSpym0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMdRxTrVX7KfKbvCpgbWly0nB3KIo/1GegpY5un0XXY6kah/8tqZZlRQo792K6JQWaU21wWrGWPHMFk7J0M/73UIgGxJ3b4NkN1Aee8APqC8c3jzZMGEdtrRQuDsKTy5VnuhIaLjuDFXV27+/P7j82/2+xc8YsddGOYwwret/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E0jW7+/Z; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Nov 2024 12:17:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731701870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=najDsHmODNqiP2kOmSNl9NRg7MwERwwNvjljWc5wx1E=;
	b=E0jW7+/ZUeDlWSAZSOxyUQx+L9K3YNXehmrJiiZTiAq7or9ErWEA/EZ/suJjIfkq/NlgqN
	hxV5+T3hQ7yb1wPF0LMRM+htbyFzmnPZugnfVyrvwGIN3GRDAdiNGCEpWekBvjLtps/Lt/
	U7xwl+tvTRgLLsNEyMcWzYTKVS18m+k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/2] mm: swap_cgroup: allocate swap_cgroup map using
 vcalloc()
Message-ID: <tygpha75uaeztnihylxyiguts2xfdzwr4arz4dwsygmbspdubr@gqwcze4d5ufd>
References: <20241115190229.676440-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115190229.676440-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 15, 2024 at 07:02:28PM +0000, Roman Gushchin wrote:
> Currently swap_cgroup's map is constructed as a vmalloc()'s-based
> array of pointers to individual struct pages. This brings an
> unnecessary complexity into the code.
> 
> This patch turns the swap_cgroup's map into a single space
> allocated by vcalloc().
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

[...]
> @@ -215,19 +169,8 @@ void swap_cgroup_swapoff(int type)
>  	mutex_lock(&swap_cgroup_mutex);
>  	ctrl = &swap_cgroup_ctrl[type];
>  	map = ctrl->map;
> -	length = ctrl->length;
>  	ctrl->map = NULL;
> -	ctrl->length = 0;
>  	mutex_unlock(&swap_cgroup_mutex);
>  
> -	if (map) {
> -		for (i = 0; i < length; i++) {
> -			struct page *page = map[i];
> -			if (page)
> -				__free_page(page);
> -			if (!(i % SWAP_CLUSTER_MAX))
> -				cond_resched();
> -		}
> -		vfree(map);
> -	}
> +	kvfree(map);

Any reason to use kvfree() instead of just vfree()?

>  }
> -- 
> 2.47.0.338.g60cca15819-goog
> 

