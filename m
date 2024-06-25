Return-Path: <linux-kernel+bounces-228414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63E915FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE56B235C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5621494C7;
	Tue, 25 Jun 2024 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ep0KUHqE"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F3E1494AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299297; cv=none; b=tyMripwYUV+swx6uj8p945kWiGYrTdh0e2S1rNX4CLWdR44oHzQZOk4NL49HZRP9mOzI8xPeQalmbZxShvqgVq17c7+LAfUqYQ7aVUHZZCHCX05GAMQ1azSDQcolMD4PPWzDZeTpLa3RHv7jbMqiiXaPXOQ1L69W3bpBStp3Ozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299297; c=relaxed/simple;
	bh=qyTX48xmtbUyn49TK+wZjzy4ql1MUzUYs5crv1pUYd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6XUuBXK1M1olq4kdLIVrpVzEYF5dbh4Se4GsbtjBKxvwhm3KG7xpH+21IBwX8Y5hUe6UmZQut/23kmIwbtd/8hgQOpAxykGS6ukV6ZHGwXRVhXOrc1v5Ii2YZqrzQ8WbqjfPKxlljH/0rLZbL2ddHZOpdshZ9A65yKMTBway8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ep0KUHqE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a72604c8c5bso161347966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719299293; x=1719904093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gPmf8JrNAJELxCAuJ9enLvpVFftABv9+GR65thp0q78=;
        b=Ep0KUHqEigj2GYxI61q96b2fQVOOK+4Ovd0jHGY48+c/6oLq5VBCtY5dbIqF3God9o
         TZV0qViqrKYZwHbNBVCC93m3OzDdTY6MXmrcEZ08UbJo7XcAHdwW05Qf/OKJLt3wPRIR
         Er6nKhcIwNeX8K5uRTC2BQ34Me0BsxkIsC0VONi9qF2tNRqv5RezAu0WZQi1FkSKOQEJ
         AE1GsWFFh3KXPDoOEi7Tbsm869YE76n55j+eMUMlW6YFSdcSRyk8aPjCkB+P6EfydFTu
         AtqlkhxKA5AhKqA0jOPoeUKzalTEa+J4pDRIaE6LdZCy1n3fDKsEBhTL2suopPS3mAfg
         oR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299293; x=1719904093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPmf8JrNAJELxCAuJ9enLvpVFftABv9+GR65thp0q78=;
        b=ZexvYb4QP364yuBH4LcAIzKTg/9f6pbHNJ4SYONognX/MUc4n7L8BBAX/6rvzLsGV+
         5klVvDFtvs14rbBPT1034pJw9tCX0m8PEsBhnMANrgU20WjWudUZ0t3b02ve+llc93gb
         2/UNrcmdz5O4EKr+c3sYZSxmVNBvnNWCpqHHEAK1+Yv/ODwOXDpOS80sLzUejnQMSMsC
         jCECQHasUuLhmgXWDaBH/epqiMS8KEX7znsczWcztzun1svknEnGyxG6zBI+0t0H/n66
         8hNSRWKEcFqZ6Uh5ydi8ohclClwzi8egWrl6JA/5Eta3Drn9cxR2faCpI6ByS23jMS/4
         /D0w==
X-Forwarded-Encrypted: i=1; AJvYcCUmznGRIY8sK46B6HujQtDBUpDi24SJg5Q/yvCR2tHqfhBPrKvo/oyq+dFINz0IncEIEpgxKmDs2fK+3+/mnbiVJyCV0bWPFU1wxpUB
X-Gm-Message-State: AOJu0Yyvcmwmsz3IhCNAY511pZRYiV1/wv8SFhGonJp3V2pStn+uHpnU
	zQrTBOK2D2IAVxqppOBAV4sFPDgQ2aMQTv23Ym6eQgtQr6Evehezz4cOlwM8gwY=
X-Google-Smtp-Source: AGHT+IHCwpbLAXbF2I0ruqrqQv4cNF+RPF/xKNyZPjInXI3/GXOG9IZcWsfO4KVpVF1cD/JmtBfN5A==
X-Received: by 2002:a17:906:68d4:b0:a72:428f:cd66 with SMTP id a640c23a62f3a-a7245b73276mr389391966b.39.1719299293323;
        Tue, 25 Jun 2024 00:08:13 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725d7b190fsm124917366b.50.2024.06.25.00.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:08:12 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:08:12 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/14] mm: memcg: rename memcg_check_events()
Message-ID: <Znps3KMgSb693jyq@tiehlicka>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-8-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-8-roman.gushchin@linux.dev>

On Mon 24-06-24 17:58:59, Roman Gushchin wrote:
> Rename memcg_check_events() into memcg1_check_events() for
> consistency with other cgroup v1-specific functions.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol-v1.c | 6 +++---
>  mm/memcontrol-v1.h | 2 +-
>  mm/memcontrol.c    | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 4b2290ceace6..d7b5c4c14732 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -835,9 +835,9 @@ static int mem_cgroup_move_account(struct folio *folio,
>  
>  	local_irq_disable();
>  	mem_cgroup_charge_statistics(to, nr_pages);
> -	memcg_check_events(to, nid);
> +	memcg1_check_events(to, nid);
>  	mem_cgroup_charge_statistics(from, -nr_pages);
> -	memcg_check_events(from, nid);
> +	memcg1_check_events(from, nid);
>  	local_irq_enable();
>  out:
>  	return ret;
> @@ -1424,7 +1424,7 @@ static void mem_cgroup_threshold(struct mem_cgroup *memcg)
>   * Check events in order.
>   *
>   */
> -void memcg_check_events(struct mem_cgroup *memcg, int nid)
> +void memcg1_check_events(struct mem_cgroup *memcg, int nid)
>  {
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		return;
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 524a2c76ffc9..ef1b7037cbdc 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -12,7 +12,7 @@ static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
>  }
>  
>  void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
> -void memcg_check_events(struct mem_cgroup *memcg, int nid);
> +void memcg1_check_events(struct mem_cgroup *memcg, int nid);
>  void memcg_oom_recover(struct mem_cgroup *memcg);
>  int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		     unsigned int nr_pages);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bd4b26a73596..92fb72bbd494 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2632,7 +2632,7 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  
>  	local_irq_disable();
>  	mem_cgroup_charge_statistics(memcg, folio_nr_pages(folio));
> -	memcg_check_events(memcg, folio_nid(folio));
> +	memcg1_check_events(memcg, folio_nid(folio));
>  	local_irq_enable();
>  }
>  
> @@ -5697,7 +5697,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  	local_irq_save(flags);
>  	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
>  	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
> -	memcg_check_events(ug->memcg, ug->nid);
> +	memcg1_check_events(ug->memcg, ug->nid);
>  	local_irq_restore(flags);
>  
>  	/* drop reference from uncharge_folio */
> @@ -5836,7 +5836,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
>  
>  	local_irq_save(flags);
>  	mem_cgroup_charge_statistics(memcg, nr_pages);
> -	memcg_check_events(memcg, folio_nid(new));
> +	memcg1_check_events(memcg, folio_nid(new));
>  	local_irq_restore(flags);
>  }
>  
> @@ -6104,7 +6104,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
>  	memcg_stats_lock();
>  	mem_cgroup_charge_statistics(memcg, -nr_entries);
>  	memcg_stats_unlock();
> -	memcg_check_events(memcg, folio_nid(folio));
> +	memcg1_check_events(memcg, folio_nid(folio));
>  
>  	css_put(&memcg->css);
>  }
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

