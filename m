Return-Path: <linux-kernel+bounces-199627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24788D89BC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39C71C24612
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E94313C8FE;
	Mon,  3 Jun 2024 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c/TRXiwE"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43113C8F4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442010; cv=none; b=b7ZvAUUKPtknf/xk7Ix5LURbYKmcCLOpOeb5RYy3R0hRWdvbnWzaT8q0KRGTSxuX3TteTtzR0c8y+0BH53MS4qGmZBp5MXO+K469CNkonFIumuYIhMGS/h79HD5Vs/bTyACbw3NvXmYp0DnAAqP9yx5pnikQghji/t5dSJUYLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442010; c=relaxed/simple;
	bh=3EUOQpqoWTALoxHP7cKEi2n07XexJUCq8UIyMIfbT3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD9bgS6qR3e+M8k2ZKYNi8OOCZxdWWvMIX4dSanFQ2jo/LR6JluWXak6SxuRZTaxPthQGuN0Gg1wSTZV3DTCvpdxFycB6SHAtWqpsj9RBU9rdb3BFMF67enIHxsL+S3seATNTq223Mx8WN0sXC3FatXRoRvr5Qc9o5eD42TO1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c/TRXiwE; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ioworker0@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717442002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0CfPycTlesiBI7O8m26mD5Nmbpxcsq3cn9s/d4zl6+c=;
	b=c/TRXiwEQ5O/B931i2eqaWnnWA17s39759N4Grg/wflQ7gTJnyH9jW3WWx0pmxjFf8X3hC
	fhBp7h9B9zFLBp99INlqNTdQTG/v3GRLjnLCy4Qai5gieGPkccJ07WfetG7iKvXyzdeXXI
	3k9ofPrDuJEmVWM8itBv8AY4+8Vu6Uo=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: willy@infradead.org
Date: Mon, 3 Jun 2024 12:13:15 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
	muchun.song@linux.dev, shakeel.butt@linux.dev, willy@infradead.org
Subject: Re: [PATCH v1 13/14] mm: memcg: put cgroup v1-related members of
 task_struct under config option
Message-ID: <Zl4VyyGpMH4dnaKs@P9FQF9L96D>
References: <20240528214435.3125304-4-roman.gushchin@linux.dev>
 <20240602120004.62824-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602120004.62824-1-ioworker0@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 02, 2024 at 08:00:04PM +0800, Lance Yang wrote:
> Hi Roman,
> 
> I noticed that you changed '#ifdef CONFIG_MEMCG' to '#ifdef CONFIG_MEMCG_V1'.
> However, it seems like the comments for the corresponding #else and #endif were
> not updated accordingly.

Hi Lance!

Good catch, thank you!

I gonna update the patch, if there will be another version.
Otherwise I hope Andrew can pick your change as a fixlet.

Thanks!

>  
> It might be something like:
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ba55ebd15354..796cfa842346 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1883,7 +1883,7 @@ static inline void mem_cgroup_unlock_pages(void)
>         rcu_read_unlock();
>  }
> 
> -#else /* CONFIG_MEMCG */
> +#else /* CONFIG_MEMCG_V1 */
>  static inline
>  unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
>                                         gfp_t gfp_mask,
> @@ -1922,6 +1922,6 @@ static inline bool mem_cgroup_oom_synchronize(bool wait)
>         return false;
>  }
> 
> -#endif /* CONFIG_MEMCG */
> +#endif /* CONFIG_MEMCG_V1 */
> 
>  #endif /* _LINUX_MEMCONTROL_H */
> ---
> 
> Thanks,
> Lance

