Return-Path: <linux-kernel+bounces-186160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CD88CC07C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041AB1F23493
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B82130A51;
	Wed, 22 May 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xb7q+M//"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC912DDBF
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378195; cv=none; b=lRsafQMPhZyNA7gc56Yr5rLPSDOcmc2a7iBNJH9gS3JsVPz8AQ2j0uwX9IgO0sQliRtUWci/A5ww/OBpCNEkX4QWyDD8lsJgkl3iOqPRTv4/BXP/KOzxJLKLQW5bs5SF5Yt1i0TpvKgTquEATD3XKau8coU5omSnwNNlNx4LTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378195; c=relaxed/simple;
	bh=m06XhZprW9svXJ9Gx6BgklYLMT59WlO68E3+jw99O3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwyGTl2YKoRSIBK1GwRk1Ey5Olhsz/ZLssxql8xC9QVxNuOkbZ30zsFJhcMsnGzWQd8OrZQJ2jGy7RdxPK8Eeu1aLl3DJ9wNziYETejR9hVCugwIw0ag5qP38gjGRxynWW9F0Rp/7XqpsiAVrluiPwNe2yThZ5PyZieifq7RKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xb7q+M//; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716378190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XxS87BGxX1olD+7CSOfjFsEFgitx6Qy9iXmHFao31+4=;
	b=xb7q+M//MYQx0auGzyEOp4hI02NeK7/Qz4bjmTyklWHGQ2ikFLQ8gIBDqv/vX+Qi0yhxau
	ujx6kCUAurrCfVxq/eqPkeJsOXWNrMVs7oKlqGSMso5V+RglUVxbAerbPyJ2JBrHSRDPzn
	JTT/nNWrKC5o3JEJiHDpiEAJ0EF1vSA=
X-Envelope-To: cl@linux.com
X-Envelope-To: rientjes@google.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: surenb@google.com
X-Envelope-To: keescook@chromium.org
Date: Wed, 22 May 2024 07:43:07 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mm, slab: don't wrap internal functions with
 alloc_hooks()
Message-ID: <pspuuwcloal4tzpfqkkofjhl3wzbuymurnwxlhsen3xfvtdjw5@lahobrxhbb7h>
References: <20240522095037.13958-1-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522095037.13958-1-vbabka@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, May 22, 2024 at 11:50:37AM +0200, Vlastimil Babka wrote:
> The functions __kmalloc_noprof(), kmalloc_large_noprof(),
> kmalloc_trace_noprof() and their _node variants are all internal to the
> implementations of kmalloc_noprof() and kmalloc_node_noprof() and are
> only declared in the "public" slab.h and exported so that those
> implementations can be static inline and distinguish the build-time
> constant size variants. The only other users for some of the internal
> functions are slub_kunit and fortify_kunit tests which make very
> short-lived allocations.
> 
> Therefore we can stop wrapping them with the alloc_hooks() macro and
> drop the _noprof suffix. Instead add a __prefix where missing and a
> comment documenting these are internal. Also rename __kmalloc_trace() to
> __kmalloc_cache() which is more descriptive - it is a variant of
> __kmalloc() where the exact kmalloc cache has been already determined.

I agree with dropping the alloc_hooks() wrappers - but can we keep them
with the _noprof() suffix? I find it makes the code easier to read,
since there are internal slab allocations which we _do_ want accounted
locally and thus call non _noprof() functions.

> 
> Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> The intention is to use the slab tree after rc1 if no big conflicts with
> mm.
> 
>  include/linux/slab.h | 53 ++++++++++++++++++++++----------------------
>  lib/slub_kunit.c     |  2 +-
>  mm/slub.c            | 32 +++++++++++++-------------
>  3 files changed, 43 insertions(+), 44 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 7247e217e21b..5ce84ffd0423 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -528,9 +528,6 @@ static_assert(PAGE_SHIFT <= 20);
>  
>  #include <linux/alloc_tag.h>
>  
> -void *__kmalloc_noprof(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
> -#define __kmalloc(...)				alloc_hooks(__kmalloc_noprof(__VA_ARGS__))
> -
>  /**
>   * kmem_cache_alloc - Allocate an object
>   * @cachep: The cache to allocate from.
> @@ -568,31 +565,33 @@ static __always_inline void kfree_bulk(size_t size, void **p)
>  	kmem_cache_free_bulk(NULL, size, p);
>  }
>  
> -void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
> -							 __alloc_size(1);
> -#define __kmalloc_node(...)			alloc_hooks(__kmalloc_node_noprof(__VA_ARGS__))
> -
>  void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
>  				   int node) __assume_slab_alignment __malloc;
>  #define kmem_cache_alloc_node(...)	alloc_hooks(kmem_cache_alloc_node_noprof(__VA_ARGS__))
>  
> -void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
> -		    __assume_kmalloc_alignment __alloc_size(3);
> +/*
> + * The following functions are not to be used directly and are intended only for
> + * internal use from kmalloc() and kmalloc_node(), with the exception of kunit
> + * tests.
> + */
> +void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment
> +					  __alloc_size(1);
> +
> +void *__kmalloc_node(size_t size, gfp_t flags, int node)
> +			__assume_kmalloc_alignment __alloc_size(1);
>  
> -void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
> -		int node, size_t size) __assume_kmalloc_alignment
> -						__alloc_size(4);
> -#define kmalloc_trace(...)			alloc_hooks(kmalloc_trace_noprof(__VA_ARGS__))
> +void *__kmalloc_cache(struct kmem_cache *s, gfp_t flags, size_t size)
> +			__assume_kmalloc_alignment __alloc_size(3);
>  
> -#define kmalloc_node_trace(...)			alloc_hooks(kmalloc_node_trace_noprof(__VA_ARGS__))
> +void *__kmalloc_cache_node(struct kmem_cache *s, gfp_t gfpflags, int node,
> +			   size_t size)	__assume_kmalloc_alignment
> +				__alloc_size(4);
>  
> -void *kmalloc_large_noprof(size_t size, gfp_t flags) __assume_page_alignment
> -					      __alloc_size(1);
> -#define kmalloc_large(...)			alloc_hooks(kmalloc_large_noprof(__VA_ARGS__))
> +void *__kmalloc_large(size_t size, gfp_t flags)	__assume_page_alignment
> +			__alloc_size(1);
>  
> -void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node) __assume_page_alignment
> -							     __alloc_size(1);
> -#define kmalloc_large_node(...)			alloc_hooks(kmalloc_large_node_noprof(__VA_ARGS__))
> +void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
> +				__assume_page_alignment __alloc_size(1);
>  
>  /**
>   * kmalloc - allocate kernel memory
> @@ -654,14 +653,14 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
>  		unsigned int index;
>  
>  		if (size > KMALLOC_MAX_CACHE_SIZE)
> -			return kmalloc_large_noprof(size, flags);
> +			return __kmalloc_large(size, flags);
>  
>  		index = kmalloc_index(size);
> -		return kmalloc_trace_noprof(
> +		return __kmalloc_cache(
>  				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>  				flags, size);
>  	}
> -	return __kmalloc_noprof(size, flags);
> +	return __kmalloc(size, flags);
>  }
>  #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
>  
> @@ -671,14 +670,14 @@ static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gf
>  		unsigned int index;
>  
>  		if (size > KMALLOC_MAX_CACHE_SIZE)
> -			return kmalloc_large_node_noprof(size, flags, node);
> +			return __kmalloc_large_node(size, flags, node);
>  
>  		index = kmalloc_index(size);
> -		return kmalloc_node_trace_noprof(
> +		return __kmalloc_cache_node(
>  				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>  				flags, node, size);
>  	}
> -	return __kmalloc_node_noprof(size, flags, node);
> +	return __kmalloc_node(size, flags, node);
>  }
>  #define kmalloc_node(...)			alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))
>  
> @@ -756,7 +755,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_
>  		return NULL;
>  	if (__builtin_constant_p(n) && __builtin_constant_p(size))
>  		return kmalloc_node_noprof(bytes, flags, node);
> -	return __kmalloc_node_noprof(bytes, flags, node);
> +	return __kmalloc_node(bytes, flags, node);
>  }
>  #define kmalloc_array_node(...)			alloc_hooks(kmalloc_array_node_noprof(__VA_ARGS__))
>  
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 4ce960438806..3b5fea45b8fe 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -140,7 +140,7 @@ static void test_kmalloc_redzone_access(struct kunit *test)
>  {
>  	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
>  				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
> -	u8 *p = kmalloc_trace(s, GFP_KERNEL, 18);
> +	u8 *p = __kmalloc_cache(s, GFP_KERNEL, 18);
>  
>  	kasan_disable_current();
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index 0809760cf789..31c25e0ebed8 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4053,7 +4053,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
>   * directly to the page allocator. We use __GFP_COMP, because we will need to
>   * know the allocation order to free the pages properly in kfree.
>   */
> -static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
> +static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
>  {
>  	struct folio *folio;
>  	void *ptr = NULL;
> @@ -4078,25 +4078,25 @@ static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
>  	return ptr;
>  }
>  
> -void *kmalloc_large_noprof(size_t size, gfp_t flags)
> +void *__kmalloc_large(size_t size, gfp_t flags)
>  {
> -	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
> +	void *ret = ___kmalloc_large_node(size, flags, NUMA_NO_NODE);
>  
>  	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
>  		      flags, NUMA_NO_NODE);
>  	return ret;
>  }
> -EXPORT_SYMBOL(kmalloc_large_noprof);
> +EXPORT_SYMBOL(__kmalloc_large);
>  
> -void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
> +void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
>  {
> -	void *ret = __kmalloc_large_node(size, flags, node);
> +	void *ret = ___kmalloc_large_node(size, flags, node);
>  
>  	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
>  		      flags, node);
>  	return ret;
>  }
> -EXPORT_SYMBOL(kmalloc_large_node_noprof);
> +EXPORT_SYMBOL(__kmalloc_large_node);
>  
>  static __always_inline
>  void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
> @@ -4123,17 +4123,17 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
>  	return ret;
>  }
>  
> -void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
> +void *__kmalloc_node(size_t size, gfp_t flags, int node)
>  {
>  	return __do_kmalloc_node(size, flags, node, _RET_IP_);
>  }
> -EXPORT_SYMBOL(__kmalloc_node_noprof);
> +EXPORT_SYMBOL(__kmalloc_node);
>  
> -void *__kmalloc_noprof(size_t size, gfp_t flags)
> +void *__kmalloc(size_t size, gfp_t flags)
>  {
>  	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
>  }
> -EXPORT_SYMBOL(__kmalloc_noprof);
> +EXPORT_SYMBOL(__kmalloc);
>  
>  void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
>  				       int node, unsigned long caller)
> @@ -4142,7 +4142,7 @@ void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
>  }
>  EXPORT_SYMBOL(kmalloc_node_track_caller_noprof);
>  
> -void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
> +void *__kmalloc_cache(struct kmem_cache *s, gfp_t gfpflags, size_t size)
>  {
>  	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE,
>  					    _RET_IP_, size);
> @@ -4152,10 +4152,10 @@ void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
>  	ret = kasan_kmalloc(s, ret, size, gfpflags);
>  	return ret;
>  }
> -EXPORT_SYMBOL(kmalloc_trace_noprof);
> +EXPORT_SYMBOL(__kmalloc_cache);
>  
> -void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
> -			 int node, size_t size)
> +void *__kmalloc_cache_node(struct kmem_cache *s, gfp_t gfpflags, int node,
> +			   size_t size)
>  {
>  	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
>  
> @@ -4164,7 +4164,7 @@ void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
>  	ret = kasan_kmalloc(s, ret, size, gfpflags);
>  	return ret;
>  }
> -EXPORT_SYMBOL(kmalloc_node_trace_noprof);
> +EXPORT_SYMBOL(__kmalloc_cache_node);
>  
>  static noinline void free_to_partial_list(
>  	struct kmem_cache *s, struct slab *slab,
> -- 
> 2.45.1
> 

