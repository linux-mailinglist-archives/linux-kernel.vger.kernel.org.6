Return-Path: <linux-kernel+bounces-280859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C741894D017
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465481F21B72
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C55119408B;
	Fri,  9 Aug 2024 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WWhU2uP2"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29B1DFF5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206235; cv=none; b=F+9+A+rWhD6VCbA03QCkXdKzuMBdpuMI6LaRSj3/XodqJ7CN+J76/ByDM+oF7baHByc+7qW5EMLskrvR3M82y78VKLuWxQlftKA1zPl3FKauJZBSjS1d1QXHkjreejWpaV1P4hOGCF4WMhVKUfh8702IkR+Qp0AysELHSJUHvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206235; c=relaxed/simple;
	bh=TwSWuXjH9wqg7Yc110tYoFxSRezpHjvYzT69Pi/ZYn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFgYQGIHhG3rAzlLUZAHNV4ovGhU1O++JUBOuiBEZBqGt4bi50djEZVkfog/3PKoC7hIUOmFtX1nuVc5N4Pv4X6nkf80QhZrBhZ2AJQZMk0seUl0/7I2GBAlFoZgZCv3c57Mt7jAcplGP0Hs/r2feai90pC1QV2HOorjl1O7pLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WWhU2uP2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so1814319a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723206232; x=1723811032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u0FoO/uu3owml8B+aDiAdNgR8TEdOerha2mgYrb48hE=;
        b=WWhU2uP2WFJ3m9HexiqyorXA7H/csG+zim4TU8uIpmosZ4yDJKYkpmiSo5ItJH6/eX
         fVrWMcmD/U+hsaMjBlpdQygGBPuWb585rEnuGVWd3/ICvXvu8pTwgMpgph6M1/OYZ+jZ
         8q+wObRbosQLIAg+/rC9QYOxROxYGxn1pE4CaiekTakFl6m7s8YPKVyXGnstsSR4vqFf
         v1VIJ/vCTeb8YamCkMl0OE4VuskYUeo7BOVaemh2t1OXgDocjitrfKhKMSn57ONR8U2l
         0Gv/MlNZJIMS3PdLd+nBvkxDH4WHzsH3Q3Mot2s1wkD28PFN9XuPaZ8mj26yhfu1bgf6
         C3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723206232; x=1723811032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0FoO/uu3owml8B+aDiAdNgR8TEdOerha2mgYrb48hE=;
        b=gt58ju4e1gt2NVWD9QIQe1NaLyVsXbKzF7b4YECMK59yziP5Rup8E+7V5zsDv+eN/c
         x+1A+dd+ujYcdJhd0v0tSHx4rZzrEH9tAsPYgaog+rQnDhX0BVNUQlcyOeax6Ry7s3i4
         2d5ieBgpTTx92rUG6i4yRXYL7VJriwxBvjyxl+o94Ms8RalREtLYkQkc2C2WelzMAPam
         HEt2FqCHAjdcsH4RUFGfDOOVRF5s344JaW1STq1LEEmApOx5ARy3UsKfEJeldOV1EGK8
         kidgdjQByGATZR+SfYjBcVAk9VN/DfvjJjxJohU9Xx7PHUs6BUdlT6SHCvOE7VFjK//D
         lp1A==
X-Forwarded-Encrypted: i=1; AJvYcCVxwfODCmnEyfm6/aZ96e22fcfJUgQIefxf5fUbsTN35i3uhJd48huOeV+QNL4u9phqHWQQ0fNs3eDu8SxfRNKbJnBSE0dA7PsBZLIq
X-Gm-Message-State: AOJu0Ywb96lBbJZjdPW11VP2a0jGFi96a2Xuwqd7O1wNvY1az54RUmk7
	XhiQ71BE5wr5UMDTcw8Ewf7AYteBvWbAlGvBLFTGFTc0daYdX5TyEukBeESBpG4=
X-Google-Smtp-Source: AGHT+IFIe1154CGlnlvVU0+T3yIWXjKE3bqt5wZBs8RFMTHp5RVFAhJ0dgFH4iIDd4JGooeRaV9rjw==
X-Received: by 2002:a05:6402:1d4a:b0:5a3:5218:3f91 with SMTP id 4fb4d7f45d1cf-5bd0a63f1b1mr1005990a12.24.1723206231569;
        Fri, 09 Aug 2024 05:23:51 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c40084sm1465089a12.37.2024.08.09.05.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 05:23:51 -0700 (PDT)
Date: Fri, 9 Aug 2024 14:23:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] memcg: protect concurrent access to mem_cgroup_idr
Message-ID: <ZrYKVtDXzGXaZ7wH@tiehlicka>
References: <20240802235822.1830976-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802235822.1830976-1-shakeel.butt@linux.dev>

On Fri 02-08-24 16:58:22, Shakeel Butt wrote:
> The commit 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure
> after many small jobs") decoupled the memcg IDs from the CSS ID space to
> fix the cgroup creation failures. It introduced IDR to maintain the
> memcg ID space. The IDR depends on external synchronization mechanisms
> for modifications. For the mem_cgroup_idr, the idr_alloc() and
> idr_replace() happen within css callback and thus are protected through
> cgroup_mutex from concurrent modifications. However idr_remove() for
> mem_cgroup_idr was not protected against concurrency and can be run
> concurrently for different memcgs when they hit their refcnt to zero.
> Fix that.
> 
> We have been seeing list_lru based kernel crashes at a low frequency in
> our fleet for a long time. These crashes were in different part of
> list_lru code including list_lru_add(), list_lru_del() and reparenting
> code. Upon further inspection, it looked like for a given object (dentry
> and inode), the super_block's list_lru didn't have list_lru_one for the
> memcg of that object. The initial suspicions were either the object is
> not allocated through kmem_cache_alloc_lru() or somehow
> memcg_list_lru_alloc() failed to allocate list_lru_one() for a memcg but
> returned success. No evidence were found for these cases.
> 
> Looking more deeper, we started seeing situations where valid memcg's id
> is not present in mem_cgroup_idr and in some cases multiple valid memcgs
> have same id and mem_cgroup_idr is pointing to one of them. So, the most
> reasonable explanation is that these situations can happen due to race
> between multiple idr_remove() calls or race between
> idr_alloc()/idr_replace() and idr_remove(). These races are causing
> multiple memcgs to acquire the same ID and then offlining of one of them
> would cleanup list_lrus on the system for all of them. Later access from
> other memcgs to the list_lru cause crashes due to missing list_lru_one.
> 
> Fixes: 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure after many small jobs")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Sorry for being late here. Thanks for catching this up.
Acked-by: Michal Hocko <mhocko@suse.com>

Cc: stable is definitely due here as those races are really nasty to
debug.

Thanks!

> ---
>  mm/memcontrol.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b889a7fbf382..8971d3473a7b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3364,11 +3364,28 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
>  
>  #define MEM_CGROUP_ID_MAX	((1UL << MEM_CGROUP_ID_SHIFT) - 1)
>  static DEFINE_IDR(mem_cgroup_idr);
> +static DEFINE_SPINLOCK(memcg_idr_lock);
> +
> +static int mem_cgroup_alloc_id(void)
> +{
> +	int ret;
> +
> +	idr_preload(GFP_KERNEL);
> +	spin_lock(&memcg_idr_lock);
> +	ret = idr_alloc(&mem_cgroup_idr, NULL, 1, MEM_CGROUP_ID_MAX + 1,
> +			GFP_NOWAIT);
> +	spin_unlock(&memcg_idr_lock);
> +	idr_preload_end();
> +	return ret;
> +}
>  
>  static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>  {
>  	if (memcg->id.id > 0) {
> +		spin_lock(&memcg_idr_lock);
>  		idr_remove(&mem_cgroup_idr, memcg->id.id);
> +		spin_unlock(&memcg_idr_lock);
> +
>  		memcg->id.id = 0;
>  	}
>  }
> @@ -3502,8 +3519,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  	if (!memcg)
>  		return ERR_PTR(error);
>  
> -	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
> -				 1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
> +	memcg->id.id = mem_cgroup_alloc_id();
>  	if (memcg->id.id < 0) {
>  		error = memcg->id.id;
>  		goto fail;
> @@ -3648,7 +3664,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	 * publish it here at the end of onlining. This matches the
>  	 * regular ID destruction during offlining.
>  	 */
> +	spin_lock(&memcg_idr_lock);
>  	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
> +	spin_unlock(&memcg_idr_lock);
>  
>  	return 0;
>  offline_kmem:
> -- 
> 2.43.5

-- 
Michal Hocko
SUSE Labs

