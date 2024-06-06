Return-Path: <linux-kernel+bounces-205121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 734DC8FF7B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66A81F25555
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F9813C9AF;
	Thu,  6 Jun 2024 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs0S760m"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D50224D6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713396; cv=none; b=H5XEUID+Zd2oSLJbDZaU68Ya1mInMNDowZ/54ApDlmzfe9K037L93JnnfZytel6b9tOOwZzSzxsU4eYSNe8yAN0pqsWgKxVENU95+u7mIoI6Yi0BRLiD9NBnRdEfmCd1mlAF0G48bAji4hiB6sYmzEOTasUKZ6whDWLxWiLbmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713396; c=relaxed/simple;
	bh=KJMXvGRu50Yk0xp9eXagV+CZr9mdBS1jhNXae8KQBno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARFTu/uWkHYTPwA7ZISbck37y2QcfugD6J+N1z4WKVwdIqZWnZMkKvY6+Xi0RcAXRrBrbAyN62fXZAgphzhr6WUMK/mpDtsRR8vWAyGACrM1a4aKfKq3y9UcTMqNRFieUAu5DtWTM2OJBGfaqveV7HmGZO14I1i7ZlGM+NrHxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs0S760m; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f630e35a01so13858195ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 15:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717713394; x=1718318194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljHTvvE/zKr2TSmx0HfN6TAzoE4stELOfnNySmAR6LQ=;
        b=Cs0S760meRyt4sEC8hkaYu8goKjbPIe5b2nST1V02DL3k+OdkmWisdBFb+Mg9o0z5L
         B1hYQo5dpK495sPdBsXwVWyPTk3NM+RN9Gh/c3NyLkqXSRpD+dNbVXjR4+UMtGUzgXkS
         XkPzczdSgQXJIwfwUr8ZEi81PLIGQQQ6uZTs/xsmp5v0PwjV8M69uB4de87CkPcUodyx
         InuJFCSP1cmgsKtwDOWJvyV3MhZoJ+r1FmhHMhVthZHU8DdgSYIExq/zlZ0VnU2V2Zxp
         zeLbxS4dT5M3BA0D/E6ax5bNw4OEK6uQtKqHID7LmFv+5YiBmPl3cdJO2jTy+V7zqJLn
         07lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717713394; x=1718318194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljHTvvE/zKr2TSmx0HfN6TAzoE4stELOfnNySmAR6LQ=;
        b=uCG2r+Y4hEtICXrtF6Op+6WZZtk0uD3VUt0v+cInlgnrZfVg7DBk1CjEUjHUKh+bgn
         iZ0QUKKvALnCHwLaKQlCgDI1eTiNZd6mMrDXLZ3UwztWDodJw2B65rq4bLdJSdo0kH7I
         L9aAJtY6vt7WpZI5brGV9eowFWQEpttCFc14rdm6ZzNakVKgh3DUzeIsx1Dhken861G1
         iojVXT41vouejh/7MleDBbNFgDY6xuoq+cpwY5/HrzNIJ1k8dJjFf+JVRA4ysC32iyaa
         Oqmu2ywp73BMflbtZK5ZFW7Qni+yXbhn0bEBSfcieSlyRJHNTXJJseOnC27RWGmGeIHP
         54fg==
X-Forwarded-Encrypted: i=1; AJvYcCXQbTKEUBRK0ISTM1rBjbdxvPnOtAwXaQmGMHJjQVaYGuPVCe9QAKMuIrEAyRbuuCfPJzggUoCsc+xOQJZxdMmgT2iiBGEbuJC32G7P
X-Gm-Message-State: AOJu0YyU+KCuablauL9pJNF4+p2/923p7PVIUW3kppVE6bv5Ju4ER/tg
	OoEzyBzf7KTGeNJP+GCe5FxnsaNl0pysxqdOywVe1GII+W4AxejI
X-Google-Smtp-Source: AGHT+IG3lMXA3+OW7FaYElQK2a7OKbvuinvinQBB8ErYJXaWBqrf+Fb9Wq/Aaq1K/hSaKnF6AnutJA==
X-Received: by 2002:a17:902:e546:b0:1f6:a870:e124 with SMTP id d9443c01a7336-1f6d03c0e11mr9124705ad.42.1717713394277;
        Thu, 06 Jun 2024 15:36:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:8411:1225:d298:7d81:144c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76d6f3sm20515035ad.111.2024.06.06.15.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 15:36:33 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Thu, 6 Jun 2024 15:36:31 -0700
From: Minchan Kim <minchan@kernel.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zsmalloc: share slab caches for all zsmalloc zpools
Message-ID: <ZmI573n9-SoK4dIg@google.com>
References: <20240604175340.218175-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604175340.218175-1-yosryahmed@google.com>

On Tue, Jun 04, 2024 at 05:53:40PM +0000, Yosry Ahmed wrote:
> Zswap creates multiple zpools to improve concurrency. Each zsmalloc
> zpool creates its own 'zs_handle' and 'zspage' slab caches. Currently we
> end up with 32 slab caches of each type.
> 
> Since each slab cache holds some free objects, we end up with a lot of
> free objects distributed among the separate zpool caches. Slab caches
> are designed to handle concurrent allocations by using percpu
> structures, so having a single instance of each cache should be enough,
> and avoids wasting more memory than needed due to fragmentation.
> 
> Additionally, having more slab caches than needed unnecessarily slows
> down code paths that iterate slab_caches.
> 
> In the results reported by Eric in [1], the amount of unused slab memory
> in these caches goes down from 242808 bytes to 29216 bytes (-88%). This
> is calculated by (num_objs - active_objs) * objsize for each 'zs_handle'
> and 'zspage' cache. Although this patch did not help with the allocation
> failure reported by Eric with zswap + zsmalloc, I think it is still
> worth merging on its own.
> 
> [1]https://lore.kernel.org/lkml/20240604134458.3ae4396a@yea/

I doubt this is the right direction.

Zsmalloc is used for various purposes, each with different object
lifecycles. For example, swap operations relatively involve short-lived
objects, while filesystem use cases might have longer-lived objects.
This mix of lifecycles could lead to fragmentation with this approach.

I believe the original problem arose when zsmalloc reduced its lock
granularity from the class level to a global level. And then, Zswap went
to mitigate the issue with multiple zpools, but it's essentially another
bandaid on top of the existing problem, IMO.

The correct approach would be to further reduce the zsmalloc lock
granularity.

> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zsmalloc.c | 87 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 44 insertions(+), 43 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index b42d3545ca856..76d9976442a4a 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -220,8 +220,6 @@ struct zs_pool {
>  	const char *name;
>  
>  	struct size_class *size_class[ZS_SIZE_CLASSES];
> -	struct kmem_cache *handle_cachep;
> -	struct kmem_cache *zspage_cachep;
>  
>  	atomic_long_t pages_allocated;
>  
> @@ -289,50 +287,29 @@ static void init_deferred_free(struct zs_pool *pool) {}
>  static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
>  #endif
>  
> -static int create_cache(struct zs_pool *pool)
> -{
> -	pool->handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
> -					0, 0, NULL);
> -	if (!pool->handle_cachep)
> -		return 1;
> -
> -	pool->zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
> -					0, 0, NULL);
> -	if (!pool->zspage_cachep) {
> -		kmem_cache_destroy(pool->handle_cachep);
> -		pool->handle_cachep = NULL;
> -		return 1;
> -	}
> -
> -	return 0;
> -}
> +static struct kmem_cache *zs_handle_cache;
> +static struct kmem_cache *zspage_cache;
>  
> -static void destroy_cache(struct zs_pool *pool)
> +static unsigned long cache_alloc_handle(gfp_t gfp)
>  {
> -	kmem_cache_destroy(pool->handle_cachep);
> -	kmem_cache_destroy(pool->zspage_cachep);
> -}
> -
> -static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
> -{
> -	return (unsigned long)kmem_cache_alloc(pool->handle_cachep,
> +	return (unsigned long)kmem_cache_alloc(zs_handle_cache,
>  			gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
>  }
>  
> -static void cache_free_handle(struct zs_pool *pool, unsigned long handle)
> +static void cache_free_handle(unsigned long handle)
>  {
> -	kmem_cache_free(pool->handle_cachep, (void *)handle);
> +	kmem_cache_free(zs_handle_cache, (void *)handle);
>  }
>  
> -static struct zspage *cache_alloc_zspage(struct zs_pool *pool, gfp_t flags)
> +static struct zspage *cache_alloc_zspage(gfp_t flags)
>  {
> -	return kmem_cache_zalloc(pool->zspage_cachep,
> +	return kmem_cache_zalloc(zspage_cache,
>  			flags & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
>  }
>  
> -static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
> +static void cache_free_zspage(struct zspage *zspage)
>  {
> -	kmem_cache_free(pool->zspage_cachep, zspage);
> +	kmem_cache_free(zspage_cache, zspage);
>  }
>  
>  /* pool->lock(which owns the handle) synchronizes races */
> @@ -837,7 +814,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>  		page = next;
>  	} while (page != NULL);
>  
> -	cache_free_zspage(pool, zspage);
> +	cache_free_zspage(zspage);
>  
>  	class_stat_dec(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
>  	atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
> @@ -950,7 +927,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
>  {
>  	int i;
>  	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE];
> -	struct zspage *zspage = cache_alloc_zspage(pool, gfp);
> +	struct zspage *zspage = cache_alloc_zspage(gfp);
>  
>  	if (!zspage)
>  		return NULL;
> @@ -967,7 +944,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
>  				dec_zone_page_state(pages[i], NR_ZSPAGES);
>  				__free_page(pages[i]);
>  			}
> -			cache_free_zspage(pool, zspage);
> +			cache_free_zspage(zspage);
>  			return NULL;
>  		}
>  
> @@ -1338,7 +1315,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
>  	if (unlikely(size > ZS_MAX_ALLOC_SIZE))
>  		return (unsigned long)ERR_PTR(-ENOSPC);
>  
> -	handle = cache_alloc_handle(pool, gfp);
> +	handle = cache_alloc_handle(gfp);
>  	if (!handle)
>  		return (unsigned long)ERR_PTR(-ENOMEM);
>  
> @@ -1363,7 +1340,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
>  
>  	zspage = alloc_zspage(pool, class, gfp);
>  	if (!zspage) {
> -		cache_free_handle(pool, handle);
> +		cache_free_handle(handle);
>  		return (unsigned long)ERR_PTR(-ENOMEM);
>  	}
>  
> @@ -1441,7 +1418,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
>  		free_zspage(pool, class, zspage);
>  
>  	spin_unlock(&pool->lock);
> -	cache_free_handle(pool, handle);
> +	cache_free_handle(handle);
>  }
>  EXPORT_SYMBOL_GPL(zs_free);
>  
> @@ -2111,9 +2088,6 @@ struct zs_pool *zs_create_pool(const char *name)
>  	if (!pool->name)
>  		goto err;
>  
> -	if (create_cache(pool))
> -		goto err;
> -
>  	/*
>  	 * Iterate reversely, because, size of size_class that we want to use
>  	 * for merging should be larger or equal to current size.
> @@ -2234,16 +2208,41 @@ void zs_destroy_pool(struct zs_pool *pool)
>  		kfree(class);
>  	}
>  
> -	destroy_cache(pool);
>  	kfree(pool->name);
>  	kfree(pool);
>  }
>  EXPORT_SYMBOL_GPL(zs_destroy_pool);
>  
> +static void zs_destroy_caches(void)
> +{
> +	kmem_cache_destroy(zs_handle_cache);
> +	kmem_cache_destroy(zspage_cache);
> +	zs_handle_cache = NULL;
> +	zspage_cache = NULL;
> +}
> +
> +static int zs_create_caches(void)
> +{
> +	zs_handle_cache = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
> +					    0, 0, NULL);
> +	zspage_cache = kmem_cache_create("zspage", sizeof(struct zspage),
> +					 0, 0, NULL);
> +
> +	if (!zs_handle_cache || !zspage_cache) {
> +		zs_destroy_caches();
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  static int __init zs_init(void)
>  {
>  	int ret;
>  
> +	ret = zs_create_caches();
> +	if (ret)
> +		goto out;
> +
>  	ret = cpuhp_setup_state(CPUHP_MM_ZS_PREPARE, "mm/zsmalloc:prepare",
>  				zs_cpu_prepare, zs_cpu_dead);
>  	if (ret)
> @@ -2258,6 +2257,7 @@ static int __init zs_init(void)
>  	return 0;
>  
>  out:
> +	zs_destroy_caches();
>  	return ret;
>  }
>  
> @@ -2269,6 +2269,7 @@ static void __exit zs_exit(void)
>  	cpuhp_remove_state(CPUHP_MM_ZS_PREPARE);
>  
>  	zs_stat_exit();
> +	zs_destroy_caches();
>  }
>  
>  module_init(zs_init);
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 

