Return-Path: <linux-kernel+bounces-558917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0F2A5ED0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC72178906
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA725F994;
	Thu, 13 Mar 2025 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gxUvWowm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5787813BC3F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851235; cv=none; b=rFzBb/YxRKy8NraEQX+zxcuFPxfkdxSpi0VtN0GxC1avbnzDaDw5keevaj8+9hL5sor+2ewZkaQXufl4GRz2iu4ZKnS74X3c4Ej55ZMPrYnsRNWXB28ilc2CYTlmYNmIvD21eVTCGmVq+RQ/o/3Tsd3Clr14kt/eVKJtlFcgTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851235; c=relaxed/simple;
	bh=vObYQsP7GkP0nRI6tEymGrq2o97DTg5Y6+GNPwRsdtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdVOetNYiJ0+fk/0yyfYepcVNLQV2bhNEr36usV5BDGxh//vOkKrz6Q2aVICzgKaR0MbVUqc+vmp8IRcMIzoc/blDb9Ns+RB8ZPriXEo05pnsRJBNnPa+4EcbVRGcqBSwxlwjjRvgRfwqSDz0fRUAxUPZnXWJZudQyXhnCOdm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gxUvWowm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf257158fso3436465e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741851230; x=1742456030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5iry1yvg4WZMN2YDV1CqlFA/zutLhrsd/H0iQw/Ekw8=;
        b=gxUvWowmNw39FShfhyabCKU2MPKLt4p2HBmhYto7uxFo/YbQeLmBhtAuMerrJp/Ia4
         fh4ccI/kd3/Q8uXz2XF3gYdHvx4u7p5IiUHdIhOtJkhT6Z9DVIYOXpsOn6xjSF2u1sKk
         6eIPWivrrDDjJidUGHA58KiX5bb1e6jOkowtJOlT1Tw4TsdLqi6uX/iYTMK+e6gaaD4J
         Z5cDv90Y4Hmq5UqwP8vTbzs2DCg6rUkNJji6LA8d6anJ4v+7cMXuTH4PR1UVfEOGzYQF
         ieKf2eDahvMzK3eg3WM4now7g+xW4gFVqBgFGrTdrgoHgXs0q04GUNh3cIsQQ7ZEvmdM
         dmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741851230; x=1742456030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iry1yvg4WZMN2YDV1CqlFA/zutLhrsd/H0iQw/Ekw8=;
        b=HhV1vHrIFFfyqUsE5AemCFKQXdeJBqi4UNxHeBjTRQCcD84572jofbthaDnB3V8Mxp
         PcHjLdejNvatHFmO6W1P1pRGNYnmF4HhnH5Njcgw6CyQb5qlmFlz2FV8BDtEQ2Y8T+yT
         9qJy6cf7m1nKO9+BOq45a3gM30ELtUh7IVXRUCn7qFLS3CVS00ZCrJTtg99mW4Kz1E7D
         H9BPirKggxODgBcoHusSwA8Sf99GUgXFtD9wK6oQHlVJT5nYxC7LPos4UZcjQOktlARl
         piCLTom7TOeG6xm53I3pMyaP+zOobosmLXBy+Bfg/iPfxn/+uTz9CH6WTLapvr708nr1
         uALw==
X-Forwarded-Encrypted: i=1; AJvYcCUmDyF59+o8fVrLZZ54l3KtYn0XFNmrfX8S5sgHDAXYgLq5MmE62ir7M48T2gqMIqG7KEZ13BxTcfyL5PI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/LObHZidIM292ou1Dz8HSG6dPWTK9L9IsolS3MwIL8Al2Qb35
	f60WBHIHceFLpve0aXVOfpVbVFkw2NEOzejWog9v6MYb1Sk88JODETj/fGZS5P8=
X-Gm-Gg: ASbGncue0YXxK+zLGnrB9gKG8v2sq1Cd2dC+XvVAgaGmNt5TlFKNcUe9eimm77+4a/L
	QuWALc/y6l6466BKiwq+dOWmRpwExEcT+YnYbBXHHUCBatQBvM7RVokbqP2K6HJDvs5Fqu0cKfi
	DaBvsZX5z6sOzNiBRz2ZKKc+rpEXmP6CcppBA7xotMO+z8/r6s/2+SG5muxlHQ2aRgqxzeQHSU7
	GyVQ5eCavck2nKcZ3mKPI0CMzLteQmQKrmirLru1I6mF3NpUJH75xmRsA5W/4vUpv51/XBE8d29
	/TltW3ICsNTxPe+vTRGnMxbkJNiWxwGRagYAd0Lmxq+ExStHh2YGKE7emw==
X-Google-Smtp-Source: AGHT+IGqSdtxUzy4WVCEjGF5SMHyXXXJMyFQAnCcaO8h0IsRnJgjQQ/oyOP70bQSW5L64iW4bCi0rA==
X-Received: by 2002:a05:600c:3512:b0:43c:fded:9654 with SMTP id 5b1f17b1804b1-43cfded98b3mr105776725e9.19.1741851230496;
        Thu, 13 Mar 2025 00:33:50 -0700 (PDT)
Received: from localhost (109-81-85-167.rct.o2.cz. [109.81.85.167])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d0a731031sm45483895e9.7.2025.03.13.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:33:50 -0700 (PDT)
Date: Thu, 13 Mar 2025 08:33:48 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: move do_memsw_account() to CONFIG_MEMCG_V1
Message-ID: <Z9KKXF-CSYuGKSXW@tiehlicka>
References: <20250312222552.3284173-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312222552.3284173-1-shakeel.butt@linux.dev>

On Wed 12-03-25 15:25:52, Shakeel Butt wrote:
> The do_memsw_account() is used to enable or disable legacy memory+swap
> accounting in memory cgroup. However with disabled CONFIG_MEMCG_V1, we
> don't need to keep checking it. So, let's always return false for
> !CONFIG_MEMCG_V1 configs.
> 
> Before the patch:
> 
> $ size mm/memcontrol.o
>    text    data     bss     dec     hex filename
>   49928   10736    4172   64836    fd44 mm/memcontrol.o
> 
> After the patch:
> 
> $ size mm/memcontrol.o
>    text    data     bss     dec     hex filename
>   49430   10480    4172   64082    fa52 mm/memcontrol.o
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/memcontrol-v1.h | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 653ff1bad244..6358464bb416 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -22,12 +22,6 @@
>  	     iter != NULL;				\
>  	     iter = mem_cgroup_iter(NULL, iter, NULL))
>  
> -/* Whether legacy memory+swap accounting is active */
> -static inline bool do_memsw_account(void)
> -{
> -	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
> -}
> -
>  unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
>  
>  void drain_all_stock(struct mem_cgroup *root_memcg);
> @@ -42,6 +36,12 @@ struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
>  /* Cgroup v1-specific declarations */
>  #ifdef CONFIG_MEMCG_V1
>  
> +/* Whether legacy memory+swap accounting is active */
> +static inline bool do_memsw_account(void)
> +{
> +	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
> +}
> +
>  unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
>  unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx);
>  unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
> @@ -94,6 +94,7 @@ extern struct cftype mem_cgroup_legacy_files[];
>  
>  #else	/* CONFIG_MEMCG_V1 */
>  
> +static inline bool do_memsw_account(void) { return false; }
>  static inline bool memcg1_alloc_events(struct mem_cgroup *memcg) { return true; }
>  static inline void memcg1_free_events(struct mem_cgroup *memcg) {}
>  
> -- 
> 2.47.1

-- 
Michal Hocko
SUSE Labs

