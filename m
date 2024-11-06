Return-Path: <linux-kernel+bounces-399030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C58F9BF9D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AF41C21B8F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB2120D4FB;
	Wed,  6 Nov 2024 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RXSFROyD"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF66201110
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935088; cv=none; b=ZFX7/EUfShFvsmxhtqlc+zN7tvoWPj6azKlsKeHIFbUjqeJG6x8HWkRC2J6gt36MV/ZMoRpWACqmDILaNr27Q0zCoX91LdjJJ1O8ghRXQHJ7MMBGTbiLTYRDw7EtFzu7xy2v/3aftpBkkM/Ell1a+DvFw1ikF9MVp0mF1a1mXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935088; c=relaxed/simple;
	bh=PUmzDhC+uKnfHyfhNP+/2eA5FZ8D+PqVS/ZGZ8V4VNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eM309ZpKAoACij+OiGMgY9/lWzCLj9/hEWGFuH9PEfptKICLxTznqDIK3ZuDtuOd2p0hCBgYRT4nPLEN+/F/PcrIbAL9+OFPP+rbFDD3BYwYAQb/LhB9swb77M8vVhg90sXHDw3/Ts3AcLTjCnLFYCgy3PD/X9pc1XLMvt13Kv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RXSFROyD; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Nov 2024 15:17:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730935083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVNrxnOTWHw6OWmvKt8/LXHQA09+jId2msib6dundh4=;
	b=RXSFROyDzEB9tUKffr0Rj0kBDUtbDnAtgKjs9ckhRQ1I7+9NsVePjXPKvOIBfqi2r+hNxB
	5IUHUCbcZfffV48SVsy7X44NDu4qctGk0L5nzcfrJDnFep62Tl0XQ3/J7qUFFLtpACn+fs
	PB2mvdhWZpcOasvmNMWvQuZxEZW6hw4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/2] memcg/hugetlb: Introduce memcg_accounts_hugetlb
Message-ID: <xy4c7ts7ijnyowurayb5qpw2cnrbcouypw47ka7cbvxkbbukgt@srna4jid2qxq>
References: <20241106221434.2029328-1-joshua.hahnjy@gmail.com>
 <20241106221434.2029328-2-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106221434.2029328-2-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 06, 2024 at 02:14:33PM -0800, Joshua Hahn wrote:
> This patch isolates the check for whether memcg accounts hugetlb.
> This condition can only be true if the memcg mount option
> memory_hugetlb_accounting is on, which includes hugetlb usage
> in memory.current.
> 
> Signed-of-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> 
> ---
>  include/linux/memcontrol.h |  2 ++
>  mm/memcontrol.c            | 12 ++++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 34d2da05f2f1..25761d55799e 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -694,6 +694,8 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
>  	return __mem_cgroup_charge(folio, mm, gfp);
>  }
>  
> +bool memcg_accounts_hugetlb(void);
> +
>  int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
>  		long nr_pages);
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5444d0e7bb64..59dea0122579 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4497,6 +4497,15 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
>  	return ret;
>  }
>  
> +bool memcg_accounts_hugetlb(void)

If this is only used in memcontrol.c then no need to add in the header,
just make it static here.

> +{
> +#ifdef CONFIG_HUGETLB_PAGE
> +	return cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
> +#else
> +	return false;
> +#endif
> +}
> +
>  /**
>   * mem_cgroup_hugetlb_try_charge - try to charge the memcg for a hugetlb folio
>   * @memcg: memcg to charge.
> @@ -4522,8 +4531,7 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
>  	 * but do not attempt to commit charge later (or cancel on error) either.
>  	 */
>  	if (mem_cgroup_disabled() || !memcg ||
> -		!cgroup_subsys_on_dfl(memory_cgrp_subsys) ||
> -		!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))

Why not replace in mem_cgroup_hugetlb_try_charge() as well?

> +		!cgroup_subsys_on_dfl(memory_cgrp_subsys) || !memcg_accounts_hugetlb())
>  		return -EOPNOTSUPP;
>  
>  	if (try_charge(memcg, gfp, nr_pages))
> -- 
> 2.43.5
> 

