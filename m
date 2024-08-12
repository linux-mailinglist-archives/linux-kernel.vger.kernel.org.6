Return-Path: <linux-kernel+bounces-282758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6998894E83F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4C51C20C22
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EDD165F07;
	Mon, 12 Aug 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S/2glqmW"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F343F1474D3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450049; cv=none; b=ZDJCPa+eCqVOMXIETuzCS9gP50pSTgl0KcQaOGT1jYhb1Kyl2jKP3eVCviulHf8Lf/24Lb/E/lfFHfFDeQtlE5VRgyHwQkfBcj+jMZ/DAsyTV7cVcFs1arA8JtlfMr16Ws3QLRAUeS/o9DeHXLgSnNtvrk7In80GQog/94pF1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450049; c=relaxed/simple;
	bh=7QMaOhjKWz/4uf+ZseTauwr5hcIZO7MW2sI+AmMlfO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAbeKPyXrq/BC9erZNUaOMtegSke/OINHiL5/r3+Wp/5d8oMwEEh/1mJfFnnsyWDW3HuaB9c9V5uqOS/M24+lc+bjokZA4FXleGnMjCjrHPPKlmXrr+E0QgzrQxzLqj8U/lAwjIa5MOARrRsvUKKcGnIwAcgNrsVSi9Z/A7ANHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S/2glqmW; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so4701196a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723450045; x=1724054845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YFgRF8LFfOau3/MGIyoZIgJMI33380v6d+GDkrcvOw=;
        b=S/2glqmWp774nMwzqcAK4HyL3kVDUR1bZJyQ0XI0deno7nmB8uetrEncxl1Dy4yYbr
         Uump+j+u62yNkP+Olq2yiHeNdW0QqAAATuP5AGgEw+jj5GXqwEHh0eKLdScjUDp44opY
         bqpVuHft4AeLj5WqDrjXO8eYTyhAwf1Xt1qzuIT5o08n8PA7gjvNKNXOYw+fG+VFIkT6
         CrTGww+zctdolF7+rAiMoE8NM8lC6eL6hMxQGIP9U+0RGHCP9a1dXFykKnM+dJu6Jhmo
         MZDw3ymiAnTiw2ujeeZorlL7BgpXdoF07K86ddGh/TIfUjszC7ARhDBQuJ1WfoddS+lC
         ebbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723450045; x=1724054845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YFgRF8LFfOau3/MGIyoZIgJMI33380v6d+GDkrcvOw=;
        b=XO4amDgY9Ni4e194Loakix2Cadv1t/tv7PqBdk6krZPAVKZV9dVHFPit2o8MLYbJjg
         8in2a0zCpIxj9iSbvy0jNSOTxZ3ThP5lC1oB7Se1hyMx3DRFqo01BLiN2MnktFvHHYP8
         iD4p8vqZ/0VaZ+wujSsMtN9MkbvkayfLekvbd45djsbpemmMcFBEBViHERAd76pQEkej
         SYaB+pWHrAdb+ts8y5IjWUmzr5NPfi05IahKC/3ukUmuLRAw6BcMTaJWHDvtAxXiuYpe
         cmdjd+Lz+39JVMRHWO+TEkwpiJIi+rjtjjrkWBYW3J/bvMQPJ5fR8UhhA5DqqX8N/HDR
         oVpw==
X-Forwarded-Encrypted: i=1; AJvYcCVYtdpIYXXL1ytMe1OYCIHftZZFPV3bvDhVHPNj0DOrOU9ahYeaoA5FSASyWt8UcVHBzNpsjI16E6HSttP0a/8gHfr7DWeFupke+qK8
X-Gm-Message-State: AOJu0Yz0pyf5N9XK6Wd9DxHj3GXd7l/1ZkvEhv9g4nvwJmSxwfR1YyIt
	3f1utpLhzPwtZ5t6j8Z5QH+LBmkqy+spVT8M0wvUhDJWTmKCCXxSQmOfR0xdWJw=
X-Google-Smtp-Source: AGHT+IGrIoJZ2UjhjzCuoPlILeJ6ErUrFE2kwTpCS1owp14Bcwlj6/O6oJalpWVnT5vj0VKGM+laZA==
X-Received: by 2002:a05:6402:274c:b0:5b8:d362:3f46 with SMTP id 4fb4d7f45d1cf-5bd0a6e32b8mr5603488a12.35.1723450045156;
        Mon, 12 Aug 2024 01:07:25 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f4fedsm1924275a12.6.2024.08.12.01.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 01:07:24 -0700 (PDT)
Date: Mon, 12 Aug 2024 10:07:19 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] memcg: replace memcg ID idr with xarray
Message-ID: <ZrnCt_cGOOwQxWn3@tiehlicka>
References: <20240809172618.2946790-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809172618.2946790-1-shakeel.butt@linux.dev>

On Fri 09-08-24 10:26:18, Shakeel Butt wrote:
> At the moment memcg IDs are managed through IDR which requires external
> synchronization mechanisms and makes the allocation code a bit awkward.
> Let's switch to xarray and make the code simpler.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Neat! I was not aware of this feature of XArray. Is there any actual
reason for idr to have its own implementation with XArray offering a
better interface?

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 34 +++++++---------------------------
>  1 file changed, 7 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e1ffd2950393..b8e6b98485c6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3363,29 +3363,12 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
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
> @@ -3420,7 +3403,7 @@ static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
>  struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
>  {
>  	WARN_ON_ONCE(!rcu_read_lock_held());
> -	return idr_find(&mem_cgroup_idr, id);
> +	return xa_load(&mem_cgroup_ids, id);
>  }
>  
>  #ifdef CONFIG_SHRINKER_DEBUG
> @@ -3519,11 +3502,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  	if (!memcg)
>  		return ERR_PTR(error);
>  
> -	memcg->id.id = mem_cgroup_alloc_id();
> -	if (memcg->id.id < 0) {
> -		error = memcg->id.id;
> +	error = xa_alloc(&mem_cgroup_ids, &memcg->id.id, NULL,
> +			 XA_LIMIT(1, MEM_CGROUP_ID_MAX), GFP_KERNEL);
> +	if (error)
>  		goto fail;
> -	}
>  
>  	memcg->vmstats = kzalloc(sizeof(struct memcg_vmstats),
>  				 GFP_KERNEL_ACCOUNT);
> @@ -3664,9 +3646,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	 * publish it here at the end of onlining. This matches the
>  	 * regular ID destruction during offlining.
>  	 */
> -	spin_lock(&memcg_idr_lock);
> -	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
> -	spin_unlock(&memcg_idr_lock);
> +	xa_store(&mem_cgroup_ids, memcg->id.id, memcg, GFP_KERNEL);
>  
>  	return 0;
>  offline_kmem:
> -- 
> 2.43.5
> 

-- 
Michal Hocko
SUSE Labs

