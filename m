Return-Path: <linux-kernel+bounces-228432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB2F915FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01141C22CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D963146A73;
	Tue, 25 Jun 2024 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZT1sQrMk"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848C73463
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299950; cv=none; b=FRXK7or9ACbFuC3c8V6nQml46JGoJ4PhxV/KtSWK5a+WJpISc9jYK+dsyBEsbc5pk9c9jd3CXtw2fbyQ+F58b3rlz6oFvzVpgQ9MXDdc94QeQ8Qoq6K63X0O54Cz7pMea597JjqpKVTmc75c3v+X2LXcMgBi/mZ85r5i44csNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299950; c=relaxed/simple;
	bh=GPggDJpFoPYrNqi2vxesvuOginzapb5uIDDqY52CkSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGpV7pbsUmZKxdpOQ6dBkyRi3vH+s2jk+BRmlVmN4pAsXNKbfrpMLJ4ZuAuoTl6bvTiBTwzumWB19X+zS7bDmlo6hZeWD2VC73RNf3jI8hVyv6f6VSRujs47/34v3g76ZPthv/Vq2MLcnpS16c7uaG7LcqW4OZ49Y3LQ3djKiAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZT1sQrMk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a724b3a32d2so243765966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719299945; x=1719904745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa1dXwsTDyXpTpChTur8Cwz6bqWTxj/Pfd0DAoAHav4=;
        b=ZT1sQrMkcxJHmcv3UHmXAcfGWsmPj7HNVEZ5gOG1gYrqR/xmg1260tTy1/yTRY2EAb
         HKCkFlhBV8V4mndOTZ7fBp2wWPgmyI/Il3LIN63lGyyoCTnGuqCa6ZIEhiMY2k7+W/ya
         1XhHuMwZUGQCaDQkmzX/S7oxTJYLNRu0qoQ551ccZiMcghnJeijX9scs9/M84LUYt1GU
         qOjhxQQP2QESX5gfmjePeDFEW9syF1l39Brc8MIkmuF7IjKk4GFdfndu4cLrqhdxSAbo
         GaoxB4+ic/0IwV/ZeTh5AVQB1Y9/4PTfFyyywl2rvm8qW1uiATG7B+Uv164lD9Pkc6Zz
         1l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299945; x=1719904745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa1dXwsTDyXpTpChTur8Cwz6bqWTxj/Pfd0DAoAHav4=;
        b=eAqbbPxfBy3xjTSYILfDn6c0+RBupEu+J6aVA5rLf59b4DEYZrv3yG4zynQyDVjTpR
         UEaxt50trkXbMWEAJ6RFB4NZ2qQUjYoAQQyTLEBpHntpznsyTsI6xcTZtmQIakAY/KpB
         xYTufL3UMuTJr/Sdr+IejJ1HikdzW1Y1gNYXK1lDso2ev4Ar82k5aqgs4OkRoVrTWVxZ
         LsZ1sO66wncZlTNwuE3qLA/eMxkPrwuE+hVLhnP/Zmciv0nqxvfU1vUTbcDnwoQuTi6t
         0XM/aHa4imyBU25WS4xCGrkBk4veAWH2AA6n5TgVww/uRvMFRdUo3D/Q85z0RwAqta/q
         kFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQNpTiDa+05NzySAIG7S66kR3qliubGCbI4PBRrNE9NVI7QufcrusXnaw5pLSvDuO18jdTj990syz3uI2cwucOtpJB2b8sQ3e7fu+3
X-Gm-Message-State: AOJu0Yx00ahzOXrtufoP315XgVcDO8dwNLsy48M5AQIOyGp+NNPMYww/
	0sGMbdXc6NQk3UL8vEzi3Dlqzbus13JLg7d2vjUTYPX/UguTSxEoQnRtIIsRKhU=
X-Google-Smtp-Source: AGHT+IHXi0A2g6VkORAwIDvbqiLAFMyUcih2zGBTlHUq4ZwB9wc0AmGajmkQoxOqW28NkDbWoVACbA==
X-Received: by 2002:a17:906:aace:b0:a6f:4b4a:588e with SMTP id a640c23a62f3a-a7245b80dfbmr363665766b.34.1719299945448;
        Tue, 25 Jun 2024 00:19:05 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe03b4528sm377057866b.206.2024.06.25.00.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:19:05 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:19:04 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 13/14] mm: memcg: put cgroup v1-related members of
 task_struct under config option
Message-ID: <ZnpvaFCLrwmzTRGO@tiehlicka>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-14-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-14-roman.gushchin@linux.dev>

On Mon 24-06-24 17:59:05, Roman Gushchin wrote:
> Guard cgroup v1-related members of task_struct under the CONFIG_MEMCG_V1
> config option, so that users who adopted cgroup v2 don't have to waste
> the memory for fields which are never accessed.

This patch does more than that, right? It is essentially making the
whole v1 code conditional. Please change the wording accordingly.

I also think we should make it more clear when to enable the option. I
would propose the following for the config option help text:

Legacy cgroup v1 memory controller which has been deprecated by cgroup
v2 implementation. The v1 is there for legacy applications which haven't
migrated to the new cgroup v2 interface yet. If you do not have any such
application then you are completely fine leaving this option disabled.

Please note that feature set of the legacy memory controller is likely
going to shrink due to deprecation process. New deployments with v1
controller are highly discouraged.

> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

With that updated feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h |  6 +++---
>  init/Kconfig               |  9 +++++++++
>  mm/Makefile                |  3 ++-
>  mm/memcontrol-v1.h         | 21 ++++++++++++++++++++-
>  mm/memcontrol.c            | 10 +++++++---
>  5 files changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a70d64ed04f5..796cfa842346 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1851,7 +1851,7 @@ static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
>  
>  /* Cgroup v1-related declarations */
>  
> -#ifdef CONFIG_MEMCG
> +#ifdef CONFIG_MEMCG_V1
>  unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  					gfp_t gfp_mask,
>  					unsigned long *total_scanned);
> @@ -1883,7 +1883,7 @@ static inline void mem_cgroup_unlock_pages(void)
>  	rcu_read_unlock();
>  }
>  
> -#else /* CONFIG_MEMCG */
> +#else /* CONFIG_MEMCG_V1 */
>  static inline
>  unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  					gfp_t gfp_mask,
> @@ -1922,6 +1922,6 @@ static inline bool mem_cgroup_oom_synchronize(bool wait)
>  	return false;
>  }
>  
> -#endif /* CONFIG_MEMCG */
> +#endif /* CONFIG_MEMCG_V1 */
>  
>  #endif /* _LINUX_MEMCONTROL_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index febdea2afc3b..5191b6435b4e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -969,6 +969,15 @@ config MEMCG
>  	help
>  	  Provides control over the memory footprint of tasks in a cgroup.
>  
> +config MEMCG_V1
> +	bool "Legacy memory controller"
> +	depends on MEMCG
> +	default n
> +	help
> +	  Legacy cgroup v1 memory controller.
> +
> +	  San N is unsure.
> +
>  config MEMCG_KMEM
>  	bool
>  	depends on MEMCG
> diff --git a/mm/Makefile b/mm/Makefile
> index 124d4dea2035..d2915f8c9dc0 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -96,7 +96,8 @@ obj-$(CONFIG_NUMA) += memory-tiers.o
>  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
> -obj-$(CONFIG_MEMCG) += memcontrol.o memcontrol-v1.o vmpressure.o
> +obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
> +obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
>  ifdef CONFIG_SWAP
>  obj-$(CONFIG_MEMCG) += swap_cgroup.o
>  endif
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 89d420793048..64b053d7f131 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -75,7 +75,7 @@ unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
>  int memory_stat_show(struct seq_file *m, void *v);
>  
>  /* Cgroup v1-specific declarations */
> -
> +#ifdef CONFIG_MEMCG_V1
>  void memcg1_remove_from_trees(struct mem_cgroup *memcg);
>  
>  static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
> @@ -110,4 +110,23 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
>  extern struct cftype memsw_files[];
>  extern struct cftype mem_cgroup_legacy_files[];
>  
> +#else	/* CONFIG_MEMCG_V1 */
> +
> +static inline void memcg1_remove_from_trees(struct mem_cgroup *memcg) {}
> +static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg) {}
> +static inline bool memcg1_wait_acct_move(struct mem_cgroup *memcg) { return false; }
> +static inline void memcg1_css_offline(struct mem_cgroup *memcg) {}
> +
> +static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked) { return true; }
> +static inline void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked) {}
> +static inline void memcg1_oom_recover(struct mem_cgroup *memcg) {}
> +
> +static inline void memcg1_check_events(struct mem_cgroup *memcg, int nid) {}
> +
> +static inline void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s) {}
> +
> +extern struct cftype memsw_files[];
> +extern struct cftype mem_cgroup_legacy_files[];
> +#endif	/* CONFIG_MEMCG_V1 */
> +
>  #endif	/* __MM_MEMCONTROL_V1_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c7341e811945..d2e1f8baeae8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4471,18 +4471,20 @@ struct cgroup_subsys memory_cgrp_subsys = {
>  	.css_free = mem_cgroup_css_free,
>  	.css_reset = mem_cgroup_css_reset,
>  	.css_rstat_flush = mem_cgroup_css_rstat_flush,
> -	.can_attach = memcg1_can_attach,
>  #if defined(CONFIG_LRU_GEN) || defined(CONFIG_MEMCG_KMEM)
>  	.attach = mem_cgroup_attach,
>  #endif
> -	.cancel_attach = memcg1_cancel_attach,
> -	.post_attach = memcg1_move_task,
>  #ifdef CONFIG_MEMCG_KMEM
>  	.fork = mem_cgroup_fork,
>  	.exit = mem_cgroup_exit,
>  #endif
>  	.dfl_cftypes = memory_files,
> +#ifdef CONFIG_MEMCG_V1
> +	.can_attach = memcg1_can_attach,
> +	.cancel_attach = memcg1_cancel_attach,
> +	.post_attach = memcg1_move_task,
>  	.legacy_cftypes = mem_cgroup_legacy_files,
> +#endif
>  	.early_init = 0,
>  };
>  
> @@ -5653,7 +5655,9 @@ static int __init mem_cgroup_swap_init(void)
>  		return 0;
>  
>  	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
> +#ifdef CONFIG_MEMCG_V1
>  	WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
> +#endif
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>  	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, zswap_files));
>  #endif
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

