Return-Path: <linux-kernel+bounces-259887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD30939EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A81F22D86
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2026814EC79;
	Tue, 23 Jul 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz/5htZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7314D711;
	Tue, 23 Jul 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721731345; cv=none; b=rZOKZ0Q+w6N6yjihLN3iyvxq8rJZbwgor0rbJC/voL7yfhCzUwyAYxVdQDJ2oumHTu6EwmhAo8Z2p+eP0HWZBBtGInONE4OBqbllXw/7tjkwdIKEXkzEAicBJxDJmCJtclEXCn3HVNBCU+U9craFe+mLTbZ5f+CmpFU9bsCHzJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721731345; c=relaxed/simple;
	bh=4QoKm4L4N0dQCpl1EJWKuRlJU5EU8KSEXc0sJOpWP3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYanKxirr+7RTw4TVyFKCsuokwqoo3CkmWqd3F/9KnWya+g0NO0CfcZ+HFvW8DhGowwJgpGBJbE4y8jtZ516o112hDRM1cDtnpNtHlaZzTSvz3jeJWXZt8CG/g9Y376hHa+FnZBXjkKXomNdXwgnAe9GfJFEYInc7NFshm/Z0ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz/5htZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791ACC4AF0A;
	Tue, 23 Jul 2024 10:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721731344;
	bh=4QoKm4L4N0dQCpl1EJWKuRlJU5EU8KSEXc0sJOpWP3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uz/5htZmkRUJMT3OYtj0uhQSZ056sGgfASjVPhAm7EvpWMQkDFDuwx2ioWpabM0gm
	 kcdEzvQtAvROOqLWqGtrPcaNzCRnzY6u/9yHSQTt1JRovkAgITxLB2Xok1ppc5XbMp
	 ZspuumCY/cyfqebaUz/AXFkhKTHCxhvZb7DR9HjSFa2/h0qHuYJXpfhAKw5P+rZlVo
	 +2x6pKsv93pJVSatHTgQm8md0hJJ+o7udYZAhJqyWV6tI4OUtiA6MQWCpnYVZbWyDh
	 lC5h6pntLHo2nvDSwH0MNMMBSbGZWPzy1WBYprEqIpjdx/XqJABfiRRkfMl/x7k3wp
	 0U+Nh/Ky35iJw==
Date: Tue, 23 Jul 2024 12:42:17 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mpe@ellerman.id.au, chandan.babu@oracle.com,
	christian.koenig@amd.com, maz@kernel.org, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: kvmalloc: align kvrealloc() with krealloc()
Message-ID: <Zp-JCWCPbDLkzRVw@pollux>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-3-dakr@kernel.org>
 <Zp9gtelmvzN5tfpS@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp9gtelmvzN5tfpS@tiehlicka>

On Tue, Jul 23, 2024 at 09:50:13AM +0200, Michal Hocko wrote:
> On Mon 22-07-24 18:29:24, Danilo Krummrich wrote:
> > Besides the obvious (and desired) difference between krealloc() and
> > kvrealloc(), there is some inconsistency in their function signatures
> > and behavior:
> > 
> >  - krealloc() frees the memory when the requested size is zero, whereas
> >    kvrealloc() simply returns a pointer to the existing allocation.
> > 
> >  - krealloc() behaves like kmalloc() if a NULL pointer is passed, whereas
> >    kvrealloc() does not accept a NULL pointer at all and, if passed,
> >    would fault instead.
> > 
> >  - krealloc() is self-contained, whereas kvrealloc() relies on the caller
> >    to provide the size of the previous allocation.
> > 
> > Inconsistent behavior throughout allocation APIs is error prone, hence make
> > kvrealloc() behave like krealloc(), which seems superior in all mentioned
> > aspects.
> 
> I completely agree with this. Fortunately the number of existing callers
> is small and none of them really seem to depend on the current behavior
> in that aspect.
>  
> > Besides that, implementing kvrealloc() by making use of krealloc() and
> > vrealloc() provides oppertunities to grow (and shrink) allocations more
> > efficiently. For instance, vrealloc() can be optimized to allocate and
> > map additional pages to grow the allocation or unmap and free unused
> > pages to shrink the allocation.
> 
> This seems like a change that is independent on the above and should be
> a patch on its own.

The optimizations you mean? Yes, I intend to do this in a separate series. For
now, I put TODOs in vrealloc.

> 
> [...]
> 
> > diff --git a/mm/util.c b/mm/util.c
> > index bc488f0121a7..0ff5898cc6de 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -608,6 +608,28 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
> >  }
> >  EXPORT_SYMBOL(vm_mmap);
> >  
> > +static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
> 
> This seems like a generally useful helper which it is not. I would call
> it something like __kvmalloc_gfp_adjust or something similar so that it is
> clear that this is just a helper to adjust gfp flag for slab allocator
> path

Christoph proposed this name, I think he wanted to encode the target of the
flags, whereas you want to encode where the function is intended to be called
from.

When I originally named this thing, I had the same conflict - encoding both
turns out clumsy - and came up with to_kmalloc_flags().

Personally, I'd be fine with __kvmalloc_gfp_adjust() too.

> 
> [...]
> > -void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
> > +/**
> > + * kvrealloc - reallocate memory; contents remain unchanged
> > + * @p: object to reallocate memory for
> > + * @size: the size to reallocate
> > + * @flags: the flags for the page level allocator
> > + *
> > + * The contents of the object pointed to are preserved up to the lesser of the
> > + * new and old size (__GFP_ZERO flag is effectively ignored).
> > + *
> > + * If @p is %NULL, kvrealloc() behaves exactly like kvmalloc(). If @size is 0
> > + * and @p is not a %NULL pointer, the object pointed to is freed.
> > + *
> > + * Return: pointer to the allocated memory or %NULL in case of error
> > + */
> > +void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
> >  {
> > -	void *newp;
> > +	void *n;
> > +
> 
> 	if (!size && p) {
> 		kvfree(p);
> 		return NULL;
> 	}
> 
> would make this code flow slightly easier to read because the freeing
> path would be shared for all compbinations IMO.

Personally, I like it without. For me the simplicity comes from directing things
to either krealloc() or vrealloc(). But I'd be open to change it however.

> 
> > +	if (is_vmalloc_addr(p))
> > +		return vrealloc_noprof(p, size, flags);
> > +
> > +	n = krealloc_noprof(p, size, kmalloc_gfp_adjust(flags, size));
> > +	if (!n) {
> > +		/* We failed to krealloc(), fall back to kvmalloc(). */
> > +		n = kvmalloc_noprof(size, flags);
> 
> Why don't you simply use vrealloc_noprof here?

We could do that, but we'd also need to do the same checks kvmalloc() does, i.e.

	/*
	 * It doesn't really make sense to fallback to vmalloc for sub page
	 * requests
	 */
	if (ret || size <= PAGE_SIZE)
		return ret;

	/* non-sleeping allocations are not supported by vmalloc */
	if (!gfpflags_allow_blocking(flags))
		return NULL;

	/* Don't even allow crazy sizes */
	if (unlikely(size > INT_MAX)) {
		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
		return NULL;
	}

Does the kmalloc() retry through kvmalloc() hurt us enough to do that? This
should only ever happen when we switch from a kmalloc buffer to a vmalloc
buffer, which we only do once, we never switch back.

> 
> > +		if (!n)
> > +			return NULL;
> > +
> > +		if (p) {
> > +			/* We already know that `p` is not a vmalloc address. */
> > +			memcpy(n, p, ksize(p));
> > +			kfree(p);
> > +		}
> > +	}
> >  
> > -	if (oldsize >= newsize)
> > -		return (void *)p;
> > -	newp = kvmalloc_noprof(newsize, flags);
> > -	if (!newp)
> > -		return NULL;
> > -	memcpy(newp, p, oldsize);
> > -	kvfree(p);
> > -	return newp;
> > +	return n;
> >  }
> >  EXPORT_SYMBOL(kvrealloc_noprof);
> >  
> > -- 
> > 2.45.2
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

