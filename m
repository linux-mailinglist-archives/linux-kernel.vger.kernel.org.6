Return-Path: <linux-kernel+bounces-558940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9795EA5ED5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4897AA008
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A5B25FA2F;
	Thu, 13 Mar 2025 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gvnkWa1d"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA033A8D2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852354; cv=none; b=ey6KvHvgwJkbzCV4NDe7VUtw7QZ0HlxEOEUYGp6zHVgVvLMd5HN3p4mcEpcbw6wxA0a5LWXOdo9RdgDTXH9yqo7IcBnkdilYPOuGQABYUfGKdqHOeX92v/VvKtN87bPDbjLwr9uuKQZblQibzYVPupU5wxOzMXkWCJgs/s3ZDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852354; c=relaxed/simple;
	bh=g+coC1tcSoO2mePh9mteUAAAd7rmYV5+RU0XhaHQIq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdN1ztlzoifiVoZZ5V+5fnoHmF2Tg76bKvOkDjnJBieA3n3hHc3dO7gnqx3sL3/O58YoivRps2tMoGmCRIh8+Kug+6ycYVHW1Txbkp7xSAiHYTpRN/dyfkw2SI9P9H/qbjHA+yOYkHEYEU75iC+XjGBJkfF1t78UpH5mzMz9uM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gvnkWa1d; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso3529795e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741852349; x=1742457149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwKhF6W+tY2SZzFtha8IxW1ChO3y61zw2i9r0o8B2QM=;
        b=gvnkWa1dTn8bnDsDsjzCGK+rpozRpKybJ2qqofvSGjcfUKLLYWdHnpuG17AEbE6acL
         XOp/E2G+kWaEZysM0ai/bppHNYH4h2MMreiozIiLzHek2c5I9Vv+Sy0l2kY3Caxa37m3
         iLg13YSoislMrABZvJtjPf7wCzOT6e/avUIuPWdmIbJFG6PhE5aW6iDodwBg9icFpy+Y
         mix3HBf3krai6JTYzrv5q+/tOX9MRIHgh30Kb1EhbChyyb4F0hRGxah1ovbz9K4wFiBe
         Ni8tiMmWs852FQWFqma8uZK0ikONpyU3mCo4upBTPfCvIUA2wcOsYcEEC70iBCbQgivu
         eFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741852349; x=1742457149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwKhF6W+tY2SZzFtha8IxW1ChO3y61zw2i9r0o8B2QM=;
        b=wfrCGJcnHUpBpaq35NWjw0t3WztRWLqqstQq7S0R4J2M4NqE9AFaA2T+NbiaVfl6Rl
         Dtcd5QWnLyWXyjJoYRkW5ge318MCFR2cY721HRtvb0SdQ/gcolTXF/Gr3W2JNBopyKhT
         bliyaX9JIqXZG7IaGPzOUC2rE/dXK9Rrgjpz7baIcLZ/lScq1ffKhz8nK3L1/iX7R6fl
         H1lClIHEHCe8oUwR930yMpxmhJAPHGMSlxVPVkZGFhuhU7jceu7rLJp6MM6lgzTUTdC1
         zCCnhXN4eyR/mKVe9qHmPEA2syOMzICj0TxpoHm8TZzg91NF33OWR35Bi2VZhbiiKdEa
         JywQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0BMz4kDz2D+XzqVXbs6yk2Fdur/ji6F4Soc/gpm5aQbHrsVrDrnTiVxh7auMOtCgVDEtBVK6CYmY9HeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw90LfTH0Q3SiqJyTXB8cxdcymUYpNDIdHZLNOLtojHYVnRiB9a
	W7xCvy3lCDO2ojYmeslhLJLDtg1aGX07XGGYBapSYVg0EvNuUkPzkugYXrKy5zbdBUZY45ArWIs
	O
X-Gm-Gg: ASbGnctLWpxYo6i3T9n12WN4YTuf55oOnmeh+3xYQ48LTwqnxbvJJtuY636F+IetJo9
	TUEVlIWz8oaX5iSYewZtJUZhtKfoHnRjDnRq0C+Ax+8jowFt3d3ACBZmctPMRpcTJvw8jf98x2L
	AYAKj24ONDMfuF8Ks+4+b0O7D7H0hQUgKoYL6MnU+Zc1uitOdulF/29PcZMzu1qLkIi5dCAfjHI
	32AqbbF8fCjzQEx3TuxEfugIE6pO40C7t7P57Qq++tkx8v4wI6BMf4TUmqfNbCk9SXyDSq91zMI
	2JohHPeUCLs4YL1iUUJXyaFhGceohmerRQwbbyTD/Ue25mSHVY5Kwl7lwA==
X-Google-Smtp-Source: AGHT+IElPecKlbEZZxwASyZJ3LHCo6Gze44psTuhhZlIHYx5NP2MBXEcSOn5ghjbG0glf2GQOqurSA==
X-Received: by 2002:a05:600c:4f0c:b0:43c:eeee:b706 with SMTP id 5b1f17b1804b1-43ceeeeb95amr117545505e9.24.1741852348716;
        Thu, 13 Mar 2025 00:52:28 -0700 (PDT)
Received: from localhost (109-81-85-167.rct.o2.cz. [109.81.85.167])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c7df3537sm1197565f8f.8.2025.03.13.00.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:52:28 -0700 (PDT)
Date: Thu, 13 Mar 2025 08:52:27 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: avoid refill_stock for root memcg
Message-ID: <Z9KOu9XTe5O7tqRd@tiehlicka>
References: <20250313054812.2185900-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313054812.2185900-1-shakeel.butt@linux.dev>

On Wed 12-03-25 22:48:12, Shakeel Butt wrote:
> We never charge the page counters of root memcg, so there is no need to
> put root memcg in the memcg stock. At the moment, refill_stock() can be
> called from try_charge_memcg(), obj_cgroup_uncharge_pages() and
> mem_cgroup_uncharge_skmem().
> 
> The try_charge_memcg() and mem_cgroup_uncharge_skmem() are never called
> with root memcg, so those are fine. However obj_cgroup_uncharge_pages()
> can potentially call refill_stock() with root memcg if the objcg object
> has been reparented over to the root memcg. Let's just avoid
> refill_stock() from obj_cgroup_uncharge_pages() for root memcg.

Makes sense. It is just pointless draining of a different memcg.

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhockoc@suse.com>
Thanks!

> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e08ce52caabd..393b73aec6dd 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2643,7 +2643,8 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
>  
>  	mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
>  	memcg1_account_kmem(memcg, -nr_pages);
> -	refill_stock(memcg, nr_pages);
> +	if (!mem_cgroup_is_root(memcg))
> +		refill_stock(memcg, nr_pages);
>  
>  	css_put(&memcg->css);
>  }
> -- 
> 2.47.1
> 

-- 
Michal Hocko
SUSE Labs

