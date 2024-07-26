Return-Path: <linux-kernel+bounces-263708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CDB93D989
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA021F258C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DD161FED;
	Fri, 26 Jul 2024 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eedt70eF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96E1F5E6;
	Fri, 26 Jul 2024 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024347; cv=none; b=NBQ28ww0cJhgIApRi9hbsYMat5VpvcJ+s+mKgm1sUEe30+3Etr6ENGXAti7HUJGNmrynbZSFoNC+1CTI1+4qbHm/9s+W5x26Prmz4qz/7yqTmIbyUPl7x1E7vgNpTHsHxzTz8i7fxFIQ8spAe61uu/BIxwYftiWlLA6sxVD3l30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024347; c=relaxed/simple;
	bh=AShS2jKtZvO/mkVIxA3nuG1UttT0Q7WGEGmLtVP7i+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeQyuEv02my0fJZbqYpPQIEx6n4EPgdrmXUERecUDOXEtEbHhySMiFEv0w1/o8Pu0Yv6qwnTvP1xGJ+n2eZv08MUe/dyTBh8XnGVOLcqSMraja8wb2c1PdpggR3XXm7Wde2qNb0jtJfFKQ6GPEieYW/sv+4zz6jeRUhz/zpzdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eedt70eF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090FFC32782;
	Fri, 26 Jul 2024 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722024347;
	bh=AShS2jKtZvO/mkVIxA3nuG1UttT0Q7WGEGmLtVP7i+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eedt70eFelGstMsiJ2EuO+cAGBh3kUXY0fq0tkhSUgh2X6WhNh7HrSVBtghbqQosp
	 SdNFOr9RWSRJ3f+wsKTbzfnf8omPNTyjA/+0HuqN76cVlDMZECrNz4j3JKsddkQo3f
	 4WTIYj8RjQ7NjdLhLZlfK5+7SZz/mhsHoJS2m3h8lm7qBMhb1vppBhcGcU7eNCzUTH
	 FoN1gq2kighwUbYi6Krhbq7uAyxl359gFsaCkYGW86WVjRLjQ4rtftE98YqEXiMx2s
	 A8lE0fS/EKeBTerr0cZbAGqjheExbqKBGMAsNrYzDf3jwDQuVCKj0RkHL7JboVADcA
	 h5Spuqrn4SNbQ==
Date: Fri, 26 Jul 2024 22:05:34 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mhocko@kernel.org, mpe@ellerman.id.au,
	chandan.babu@oracle.com, christian.koenig@amd.com, maz@kernel.org,
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: vmalloc: implement vrealloc()
Message-ID: <ZqQBjjtPXeErPsva@cassiopeiae>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-2-dakr@kernel.org>
 <07491799-9753-4fc9-b642-6d7d7d9575aa@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07491799-9753-4fc9-b642-6d7d7d9575aa@suse.cz>

On Fri, Jul 26, 2024 at 04:37:43PM +0200, Vlastimil Babka wrote:
> On 7/22/24 6:29 PM, Danilo Krummrich wrote:
> > Implement vrealloc() analogous to krealloc().
> > 
> > Currently, krealloc() requires the caller to pass the size of the
> > previous memory allocation, which, instead, should be self-contained.
> > 
> > We attempt to fix this in a subsequent patch which, in order to do so,
> > requires vrealloc().
> > 
> > Besides that, we need realloc() functions for kernel allocators in Rust
> > too. With `Vec` or `KVec` respectively, potentially growing (and
> > shrinking) data structures are rather common.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -4037,6 +4037,65 @@ void *vzalloc_node_noprof(unsigned long size, int node)
> >  }
> >  EXPORT_SYMBOL(vzalloc_node_noprof);
> >  
> > +/**
> > + * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
> > + * @p: object to reallocate memory for
> > + * @size: the size to reallocate
> > + * @flags: the flags for the page level allocator
> > + *
> > + * The contents of the object pointed to are preserved up to the lesser of the
> > + * new and old size (__GFP_ZERO flag is effectively ignored).
> 
> Well, technically not correct as we don't shrink. Get 8 pages, kvrealloc to
> 4 pages, kvrealloc back to 8 and the last 4 are not zeroed. But it's not
> new, kvrealloc() did the same before patch 2/2.

Taking it (too) literal, it's not wrong. The contents of the object pointed to
are indeed preserved up to the lesser of the new and old size. It's just that
the rest may be "preserved" as well.

I work on implementing shrink and grow for vrealloc(). In the meantime I think
we could probably just memset() spare memory to zero.

nommu would still uses krealloc() though...

> 
> But it's also fundamentally not true for krealloc(), or kvrealloc()
> switching from a kmalloc to valloc. ksize() returns the size of the kmalloc
> bucket, we don't know what was the exact prior allocation size.

Probably a stupid question, but can't we just zero the full bucket initially and
make sure to memset() spare memory in the bucket to zero when krealloc() is
called with new_size < ksize()?

> Worse, we
> started poisoning the padding in debug configurations, so even a
> kmalloc(__GFP_ZERO) followed by krealloc(__GFP_ZERO) can give you unexpected
> poison now...

As in writing magics directly to the spare memory in the bucket? Which would
then also be copied over to a new buffer in __do_krealloc()?

> 
> I guess we should just document __GFP_ZERO is not honored at all for
> realloc, and maybe start even warning :/ Hopefully nobody relies on that.

I think it'd be great to make __GFP_ZERO work in all cases. However, if that's
really not possible, I'd prefer if we could at least gurantee that
*realloc(NULL, size, flags | __GFP_ZERO) is a valid call, i.e.
WARN_ON(p && flags & __GFP_ZERO).

> 
> > + *
> > + * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
> > + * @p is not a %NULL pointer, the object pointed to is freed.
> > + *
> > + * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
> > + *         failure
> > + */
> > +void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> > +{
> > +	size_t old_size = 0;
> > +	void *n;
> > +
> > +	if (!size) {
> > +		vfree(p);
> > +		return NULL;
> > +	}
> > +
> > +	if (p) {
> > +		struct vm_struct *vm;
> > +
> > +		vm = find_vm_area(p);
> > +		if (unlikely(!vm)) {
> > +			WARN(1, "Trying to vrealloc() nonexistent vm area (%p)\n", p);
> > +			return NULL;
> > +		}
> > +
> > +		old_size = get_vm_area_size(vm);
> > +	}
> > +
> > +	if (size <= old_size) {
> > +		/*
> > +		 * TODO: Shrink the vm_area, i.e. unmap and free unused pages.
> > +		 * What would be a good heuristic for when to shrink the
> > +		 * vm_area?
> > +		 */
> > +		return (void *)p;
> > +	}
> > +
> > +	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
> > +	n = __vmalloc_noprof(size, flags);
> > +	if (!n)
> > +		return NULL;
> > +
> > +	if (p) {
> > +		memcpy(n, p, old_size);
> > +		vfree(p);
> > +	}
> > +
> > +	return n;
> > +}
> > +
> >  #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
> >  #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
> >  #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
> 

