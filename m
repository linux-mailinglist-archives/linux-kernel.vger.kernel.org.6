Return-Path: <linux-kernel+bounces-322870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D7D973159
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7661A1C25459
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8063191F6F;
	Tue, 10 Sep 2024 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP9NOIs2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE421917FF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962771; cv=none; b=ijWbdqzmNlVhfXG/w+yF/boKvsM9HNupfsAnUyJCpiFmIm3E1TkvQ6Xx8r56cl5vvI2hZ7j1ljWXtYeYzKm5cbDVTZoA0ZhSXFKw98dFNoz4HpQhrFegskKtvy+RjdaJheSelpg/3zy3V6SpGro/Q43lnksvyzj0dw9driXaij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962771; c=relaxed/simple;
	bh=er8gmKzN5Faog+t3Xxq4cRtUP9mJj5HchMtTy2TFXrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9oqLjtN+jpBOdl5QP6lxx5+EqXpcGgtgsQkPlBxrWU/LHD9PfLKt6X9qmr8YG4MAmyZb+lBWC67P6TOIiRTfHCVXwUSJQ4kpx7KW5hEhIaGTlIpTojaeHjy6E7zJ2IAgVHDMZBQnNsIvC/2tewkx8cxcfK1eE3dF6D1yxgH8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP9NOIs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D24C4CEC6;
	Tue, 10 Sep 2024 10:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725962771;
	bh=er8gmKzN5Faog+t3Xxq4cRtUP9mJj5HchMtTy2TFXrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cP9NOIs2J4fY6fWtmL/u5awHpTS3jgROfQOdd1iyGEcmgcjvmGbn2ZO2i6Squevc9
	 Xk4K/Veu34zbmRuv+Pi0+TMzxqElg8LbBhBdx1cUcHHEqJ1JHdmHEeggzNBFxw6pf/
	 awKuxU79p0FKmlhREpUsoj3EhIpvqmJPSS29125+5dBO2S2DCkWCM9zKxde36DnoUA
	 BrSvXfDfvc39eq4ZpYouTc1Mnr1hOpNibNp1QIQuXNGxzOPAmVYwLR+TLKUo61XK5F
	 XyxP0jx4t0MaGcTKjIjrtVwcvMROQ45kMVWheMcJBJVkFjWuKIUKu4V7qhiS7ecV6u
	 Cby1zk7tMtz7g==
Date: Tue, 10 Sep 2024 12:06:05 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Feng Tang <feng.tang@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Gow <davidgow@google.com>, linux-mm@kvack.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm/slub: Improve redzone check and zeroing for
 krealloc()
Message-ID: <ZuAaDbSMtpLVJPrY@pollux>
References: <20240909012958.913438-1-feng.tang@intel.com>
 <20240909012958.913438-4-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909012958.913438-4-feng.tang@intel.com>

On Mon, Sep 09, 2024 at 09:29:56AM +0800, Feng Tang wrote:
> For current krealloc(), one problem is its caller doesn't know what's
> the actual request size, say the object is 64 bytes kmalloc one, but
> the original caller may only requested 48 bytes. And when krealloc()
> shrinks or grows in the same object, or allocate a new bigger object,
> it lacks this 'original size' information to do accurate data preserving
> or zeroing (when __GFP_ZERO is set).
> 
> And when some slub debug option is enabled, kmalloc caches do have this
> 'orig_size' feature. So utilize it to do more accurate data handling,
> as well as enforce the kmalloc-redzone sanity check.
> 
> The krealloc() related code is moved from slab_common.c to slub.c for
> more efficient function calling.

I think it would be good to do this in a separate commit, for a better diff and
history.

> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/slab_common.c |  84 -------------------------------------
>  mm/slub.c        | 106 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+), 84 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index ad438ba62485..e59942fb7970 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1297,90 +1297,6 @@ module_init(slab_proc_init);
>  
>  #endif /* CONFIG_SLUB_DEBUG */
>  
> -static __always_inline __realloc_size(2) void *
> -__do_krealloc(const void *p, size_t new_size, gfp_t flags)
> -{
> -	void *ret;
> -	size_t ks;
> -
> -	/* Check for double-free before calling ksize. */
> -	if (likely(!ZERO_OR_NULL_PTR(p))) {
> -		if (!kasan_check_byte(p))
> -			return NULL;
> -		ks = ksize(p);
> -	} else
> -		ks = 0;
> -
> -	/* If the object still fits, repoison it precisely. */
> -	if (ks >= new_size) {
> -		/* Zero out spare memory. */
> -		if (want_init_on_alloc(flags)) {
> -			kasan_disable_current();
> -			memset((void *)p + new_size, 0, ks - new_size);
> -			kasan_enable_current();
> -		}
> -
> -		p = kasan_krealloc((void *)p, new_size, flags);
> -		return (void *)p;
> -	}
> -
> -	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
> -	if (ret && p) {
> -		/* Disable KASAN checks as the object's redzone is accessed. */
> -		kasan_disable_current();
> -		memcpy(ret, kasan_reset_tag(p), ks);
> -		kasan_enable_current();
> -	}
> -
> -	return ret;
> -}
> -
> -/**
> - * krealloc - reallocate memory. The contents will remain unchanged.
> - * @p: object to reallocate memory for.
> - * @new_size: how many bytes of memory are required.
> - * @flags: the type of memory to allocate.
> - *
> - * If @p is %NULL, krealloc() behaves exactly like kmalloc().  If @new_size
> - * is 0 and @p is not a %NULL pointer, the object pointed to is freed.
> - *
> - * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
> - * initial memory allocation, every subsequent call to this API for the same
> - * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
> - * __GFP_ZERO is not fully honored by this API.
> - *
> - * This is the case, since krealloc() only knows about the bucket size of an
> - * allocation (but not the exact size it was allocated with) and hence
> - * implements the following semantics for shrinking and growing buffers with
> - * __GFP_ZERO.
> - *
> - *         new             bucket
> - * 0       size             size
> - * |--------|----------------|
> - * |  keep  |      zero      |
> - *
> - * In any case, the contents of the object pointed to are preserved up to the
> - * lesser of the new and old sizes.
> - *
> - * Return: pointer to the allocated memory or %NULL in case of error
> - */
> -void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
> -{
> -	void *ret;
> -
> -	if (unlikely(!new_size)) {
> -		kfree(p);
> -		return ZERO_SIZE_PTR;
> -	}
> -
> -	ret = __do_krealloc(p, new_size, flags);
> -	if (ret && kasan_reset_tag(p) != kasan_reset_tag(ret))
> -		kfree(p);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL(krealloc_noprof);
> -
>  /**
>   * kfree_sensitive - Clear sensitive information in memory before freeing
>   * @p: object to free memory of
> diff --git a/mm/slub.c b/mm/slub.c
> index 4cb3822dba08..d4c938dfb89e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4709,6 +4709,112 @@ void kfree(const void *object)
>  }
>  EXPORT_SYMBOL(kfree);
>  
> +static __always_inline __realloc_size(2) void *
> +__do_krealloc(const void *p, size_t new_size, gfp_t flags)
> +{
> +	void *ret;
> +	size_t ks;
> +	int orig_size = 0;
> +	struct kmem_cache *s;
> +
> +	/* Check for double-free before calling ksize. */
> +	if (likely(!ZERO_OR_NULL_PTR(p))) {
> +		if (!kasan_check_byte(p))
> +			return NULL;
> +
> +		s = virt_to_cache(p);
> +		orig_size = get_orig_size(s, (void *)p);
> +		ks = s->object_size;
> +	} else
> +		ks = 0;
> +
> +	/* If the object doesn't fit, allocate a bigger one */
> +	if (new_size > ks)
> +		goto alloc_new;
> +
> +	/* Zero out spare memory. */
> +	if (want_init_on_alloc(flags)) {
> +		kasan_disable_current();
> +		if (orig_size < new_size)
> +			memset((void *)p + orig_size, 0, new_size - orig_size);
> +		else
> +			memset((void *)p + new_size, 0, ks - new_size);
> +		kasan_enable_current();
> +	}
> +
> +	if (slub_debug_orig_size(s) && !is_kfence_address(p)) {
> +		set_orig_size(s, (void *)p, new_size);
> +		if (s->flags & SLAB_RED_ZONE && new_size < ks)
> +			memset_no_sanitize_memory((void *)p + new_size,
> +						SLUB_RED_ACTIVE, ks - new_size);
> +	}
> +
> +	p = kasan_krealloc((void *)p, new_size, flags);
> +	return (void *)p;
> +
> +alloc_new:
> +	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
> +	if (ret && p) {
> +		/* Disable KASAN checks as the object's redzone is accessed. */
> +		kasan_disable_current();
> +		if (orig_size)
> +			memcpy(ret, kasan_reset_tag(p), orig_size);
> +		kasan_enable_current();
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * krealloc - reallocate memory. The contents will remain unchanged.
> + * @p: object to reallocate memory for.
> + * @new_size: how many bytes of memory are required.
> + * @flags: the type of memory to allocate.
> + *
> + * If @p is %NULL, krealloc() behaves exactly like kmalloc().  If @new_size
> + * is 0 and @p is not a %NULL pointer, the object pointed to is freed.
> + *
> + * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
> + * initial memory allocation, every subsequent call to this API for the same
> + * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
> + * __GFP_ZERO is not fully honored by this API.
> + *
> + * When slub_debug_orig_size() is off,  since krealloc() only knows about the

I think you want to remove ' since ' here.

> + * bucket size of an allocation (but not the exact size it was allocated with)
> + * and hence implements the following semantics for shrinking and growing
> + * buffers with __GFP_ZERO.
> + *
> + *         new             bucket
> + * 0       size             size
> + * |--------|----------------|
> + * |  keep  |      zero      |
> + *
> + * Otherwize, the original allocation size 'orig_size' could be used to

Typo in 'otherwise'.

> + * precisely clear the requested size, and the new size will also be stored as
> + * the new 'orig_size'.
> + *
> + * In any case, the contents of the object pointed to are preserved up to the
> + * lesser of the new and old sizes.
> + *
> + * Return: pointer to the allocated memory or %NULL in case of error
> + */
> +void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
> +{
> +	void *ret;
> +
> +	if (unlikely(!new_size)) {
> +		kfree(p);
> +		return ZERO_SIZE_PTR;
> +	}
> +
> +	ret = __do_krealloc(p, new_size, flags);
> +	if (ret && kasan_reset_tag(p) != kasan_reset_tag(ret))
> +		kfree(p);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(krealloc_noprof);
> +
>  struct detached_freelist {
>  	struct slab *slab;
>  	void *tail;
> -- 
> 2.34.1
> 

