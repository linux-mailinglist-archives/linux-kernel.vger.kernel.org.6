Return-Path: <linux-kernel+bounces-201368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1068FBD9F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83EC283495
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009714BF99;
	Tue,  4 Jun 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vwCk8V8u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3rCI3neq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vwCk8V8u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3rCI3neq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498814B97D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534504; cv=none; b=F2vMHSH/BBzGB1AXzSmJaBh3V0y6dUIA7//VmCZHirQW6xKGY/z1gZn7xmC68aAM7W04DmR8YfgwLuFQ8FiWuOtWMIhGD242WU2DfIFTnVqtj9fpZGVufLhe9X71OgrgieOwTSYmliqyWVXDgn62OSrSpaf/JXrKQNs3R0zMj/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534504; c=relaxed/simple;
	bh=gbOBWVD+xEHfsIlvSPwQ2phfTctiJ5vr6ufoh4w0apE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4SSrh+TY87bEBNv4+tOtdLINr7rKKiZWskB68SYaUbKqrdGht+uhvRf+gK9w22Lh9NvGz/tWHWJ0/B0r+TEr63pw7v7OpTuXuiXblXnBIzfQrQUPOrzWp08KUqiDQmMmSGr+NfkICjWY3JZ1JLslJ9Y4zwZRAPZR0IO4U9sKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vwCk8V8u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3rCI3neq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vwCk8V8u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3rCI3neq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B45721A2E;
	Tue,  4 Jun 2024 20:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717534500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8nhrgz2vR/AdUZfOm8MElpEy8/0DQfmNxSsIR7PvCtM=;
	b=vwCk8V8umOZQcSwAQ4W6gBYHPNiX8fhEHABOZUj/Uqt2FJtb8xgcmoojY4PRbK36DtZxR+
	JMS27RVUf9/ZsPQa3voJRGPGalVls4UKt8Do1N/PlDE5XhMvO7wXo1e8X4m/NM1B2ODWeT
	Lmx+tP8gFd1BfR5xLwgdWI3QFkpH+eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717534500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8nhrgz2vR/AdUZfOm8MElpEy8/0DQfmNxSsIR7PvCtM=;
	b=3rCI3neqRhEjrfPpWzber3s/VezZTEoXwEghxyFLt0vOTk0UQivOGBS/XfTeARehklc3xC
	hhbbYHDYLNp6DcDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717534500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8nhrgz2vR/AdUZfOm8MElpEy8/0DQfmNxSsIR7PvCtM=;
	b=vwCk8V8umOZQcSwAQ4W6gBYHPNiX8fhEHABOZUj/Uqt2FJtb8xgcmoojY4PRbK36DtZxR+
	JMS27RVUf9/ZsPQa3voJRGPGalVls4UKt8Do1N/PlDE5XhMvO7wXo1e8X4m/NM1B2ODWeT
	Lmx+tP8gFd1BfR5xLwgdWI3QFkpH+eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717534500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8nhrgz2vR/AdUZfOm8MElpEy8/0DQfmNxSsIR7PvCtM=;
	b=3rCI3neqRhEjrfPpWzber3s/VezZTEoXwEghxyFLt0vOTk0UQivOGBS/XfTeARehklc3xC
	hhbbYHDYLNp6DcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34D871398F;
	Tue,  4 Jun 2024 20:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OcR6DCR/X2aBfAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 04 Jun 2024 20:55:00 +0000
Message-ID: <62921f15-8172-462e-8ca7-8ab8236fd7b5@suse.cz>
Date: Tue, 4 Jun 2024 22:54:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: zsmalloc: share slab caches for all zsmalloc zpools
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240604175340.218175-1-yosryahmed@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240604175340.218175-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]

On 6/4/24 7:53 PM, Yosry Ahmed wrote:
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
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

As mentioned in the thread, CONFIG_SLAB_MERGE_DEFAULT would normally cover
the zsmalloc caches case too, but was disabled. I agree with the arguments
for this change though, so it doesn't depend on the general merging.

Acked-by: Vlastimil Babka <vbabka@suse.cz>

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


