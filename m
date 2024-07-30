Return-Path: <linux-kernel+bounces-267566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689319412E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA53EB25570
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84D119F467;
	Tue, 30 Jul 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDLf5vP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188519E7D1;
	Tue, 30 Jul 2024 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345295; cv=none; b=Ju7gB4QcAu5C8Fbm+eF574AZzHOBeYJnw8ER+0BSmwyMvefKFASMv+ebVBQYwDp6Osdq/mZMIATWRDuR212RMHT5iSLReDCr9Uv3hq7GPx251XgBZ/D2MIasZ4zSQr0E8PdcfTYCB81dPKuPkVZE4oC7h8kcFumtrd/9PoNZEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345295; c=relaxed/simple;
	bh=XHUplKf8leN8eySXFx5w2kpqF4LBiAT9/qcEzFQ+L7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh6Mj225MOJId+5XomBYXyL6kEwW27ASi99Axtgk/xXm5Ydqw8qUR77HuUzo6XvzuVxFfBAelSoGvhQ+oelXiSkjBskmSgO+R0nMNFMfx0g+EfgE6wlQj9ESrerBrA6xhLQTGvBPXFJV0MyyGSqpuC9qBVzW8khh6NzV+bJNfqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDLf5vP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80495C32782;
	Tue, 30 Jul 2024 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722345295;
	bh=XHUplKf8leN8eySXFx5w2kpqF4LBiAT9/qcEzFQ+L7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDLf5vP9hkwdpxMEUoGCyZV9ZMZA4eIy5TbADgI59GB16jEo/g0Cmqg9ZUsGqAtg0
	 fVSNlU2U7m/UCV0Mz/cfi31VJeJ8x6TJf2vIhLfRT4d7ocpzmKK5lSpG3edj1Un65h
	 oHpJBSB9CGRqv5fX+Z56tr1d0YgK/ZVmnIZuf/LiR9dvszafiOakyBxKgQK3As5NwZ
	 bqsyGpwyvpALAcJ+cy/KDbhhaSVKKSNk9ALGq+EUyfbQUYTfax9IH7Bq8RzV2MPfoW
	 OzPLWCFleVSHM0x740xrWqHBDFh8fvztDnoD7lkOp1FNf+ewqf9p0Ijmh8Cnb+eFRr
	 89Wm2JuOnh/3g==
Date: Tue, 30 Jul 2024 15:14:47 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mhocko@kernel.org, mpe@ellerman.id.au,
	chandan.babu@oracle.com, christian.koenig@amd.com, maz@kernel.org,
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>,
	kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v2 1/2] mm: vmalloc: implement vrealloc()
Message-ID: <ZqjnR4Wxzf-ciUGW@pollux>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-2-dakr@kernel.org>
 <07491799-9753-4fc9-b642-6d7d7d9575aa@suse.cz>
 <ZqQBjjtPXeErPsva@cassiopeiae>
 <ZqfomPVr7PadY8Et@cassiopeiae>
 <ZqhDXkFNaN_Cx11e@cassiopeiae>
 <44fa564b-9c8f-4ac2-bce3-f6d2c99b73b7@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44fa564b-9c8f-4ac2-bce3-f6d2c99b73b7@suse.cz>

On Tue, Jul 30, 2024 at 02:15:34PM +0200, Vlastimil Babka wrote:
> On 7/30/24 3:35 AM, Danilo Krummrich wrote:
> > On Mon, Jul 29, 2024 at 09:08:16PM +0200, Danilo Krummrich wrote:
> >> On Fri, Jul 26, 2024 at 10:05:47PM +0200, Danilo Krummrich wrote:
> >>> On Fri, Jul 26, 2024 at 04:37:43PM +0200, Vlastimil Babka wrote:
> >>>> On 7/22/24 6:29 PM, Danilo Krummrich wrote:
> >>>>> Implement vrealloc() analogous to krealloc().
> >>>>>
> >>>>> Currently, krealloc() requires the caller to pass the size of the
> >>>>> previous memory allocation, which, instead, should be self-contained.
> >>>>>
> >>>>> We attempt to fix this in a subsequent patch which, in order to do so,
> >>>>> requires vrealloc().
> >>>>>
> >>>>> Besides that, we need realloc() functions for kernel allocators in Rust
> >>>>> too. With `Vec` or `KVec` respectively, potentially growing (and
> >>>>> shrinking) data structures are rather common.
> >>>>>
> >>>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >>>>
> >>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >>>>
> >>>>> --- a/mm/vmalloc.c
> >>>>> +++ b/mm/vmalloc.c
> >>>>> @@ -4037,6 +4037,65 @@ void *vzalloc_node_noprof(unsigned long size, int node)
> >>>>>  }
> >>>>>  EXPORT_SYMBOL(vzalloc_node_noprof);
> >>>>>  
> >>>>> +/**
> >>>>> + * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
> >>>>> + * @p: object to reallocate memory for
> >>>>> + * @size: the size to reallocate
> >>>>> + * @flags: the flags for the page level allocator
> >>>>> + *
> >>>>> + * The contents of the object pointed to are preserved up to the lesser of the
> >>>>> + * new and old size (__GFP_ZERO flag is effectively ignored).
> >>>>
> >>>> Well, technically not correct as we don't shrink. Get 8 pages, kvrealloc to
> >>>> 4 pages, kvrealloc back to 8 and the last 4 are not zeroed. But it's not
> >>>> new, kvrealloc() did the same before patch 2/2.
> >>>
> >>> Taking it (too) literal, it's not wrong. The contents of the object pointed to
> >>> are indeed preserved up to the lesser of the new and old size. It's just that
> >>> the rest may be "preserved" as well.
> >>>
> >>> I work on implementing shrink and grow for vrealloc(). In the meantime I think
> >>> we could probably just memset() spare memory to zero.
> >>
> >> Probably, this was a bad idea. Even with shrinking implemented we'd need to
> >> memset() potential spare memory of the last page to zero, when new_size <
> >> old_size.
> >>
> >> Analogously, the same would be true for krealloc() buckets. That's probably not
> >> worth it.
> 
> I think it could remove unexpected bad surprises with the API so why not
> do it.

We'd either need to do it *every* time we shrink an allocation on spec, or we
only do it when shrinking with __GFP_ZERO flag set, which might be a bit
counter-intuitive.

If we do it, I'd probably vote for the latter semantics. While it sounds more
error prone, it's less wasteful and enough to cover the most common case where
the actual *realloc() call is always with the same parameters, but a changing
size.

> 
> >> I think we should indeed just document that __GFP_ZERO doesn't work for
> >> re-allocating memory and start to warn about it. As already mentioned, I think
> >> we should at least gurantee that *realloc(NULL, size, flags | __GFP_ZERO) is
> >> valid, i.e. WARN_ON(p && flags & __GFP_ZERO).
> > 
> > Maybe I spoke a bit to soon with this last paragraph. I think continuously
> > gowing something with __GFP_ZERO is a legitimate use case. I just did a quick
> > grep for users of krealloc() with __GFP_ZERO and found 18 matches.
> > 
> > So, I think, at least for now, we should instead document that __GFP_ZERO is
> > only fully honored when the buffer is grown continuously (without intermediate
> > shrinking) and __GFP_ZERO is supplied in every iteration.
> > 
> > In case I miss something here, and not even this case is safe, it looks like
> > we have 18 broken users of krealloc().
> 
> +CC Feng Tang
> 
> Let's say we kmalloc(56, __GFP_ZERO), we get an object from kmalloc-64
> cache. Since commit 946fa0dbf2d89 ("mm/slub: extend redzone check to
> extra allocated kmalloc space than requested") and preceding commits, if
> slub_debug is enabled (red zoning or user tracking), only the 56 bytes
> will be zeroed. The rest will be either unknown garbage, or redzone.
> 
> Then we might e.g. krealloc(120) and get a kmalloc-128 object and 64
> bytes (result of ksize()) will be copied, including the garbage/redzone.
> I think it's fixable because when we do this in slub_debug, we also
> store the original size in the metadata, so we could read it back and
> adjust how many bytes are copied.
> 
> Then we could guarantee that if __GFP_ZERO is used consistently on
> initial kmalloc() and on krealloc() and the user doesn't corrupt the
> extra space themselves (which is a bug anyway that the redzoning is
> supposed to catch) all will be fine.

Ok, so those 18 users are indeed currently broken, but only when slub_debug is
enabled (assuming that all of those are consistently growing with __GFP_ZERO).

> 
> There might be also KASAN side to this, I see poison_kmalloc_redzone()
> is also redzoning the area between requested size and cache's object_size?
> 
> >>
> >>>
> >>> nommu would still uses krealloc() though...
> >>>
> >>>>
> >>>> But it's also fundamentally not true for krealloc(), or kvrealloc()
> >>>> switching from a kmalloc to valloc. ksize() returns the size of the kmalloc
> >>>> bucket, we don't know what was the exact prior allocation size.
> >>>
> >>> Probably a stupid question, but can't we just zero the full bucket initially and
> >>> make sure to memset() spare memory in the bucket to zero when krealloc() is
> >>> called with new_size < ksize()?
> >>>
> >>>> Worse, we
> >>>> started poisoning the padding in debug configurations, so even a
> >>>> kmalloc(__GFP_ZERO) followed by krealloc(__GFP_ZERO) can give you unexpected
> >>>> poison now...
> >>>
> >>> As in writing magics directly to the spare memory in the bucket? Which would
> >>> then also be copied over to a new buffer in __do_krealloc()?
> >>>
> >>>>
> >>>> I guess we should just document __GFP_ZERO is not honored at all for
> >>>> realloc, and maybe start even warning :/ Hopefully nobody relies on that.
> >>>
> >>> I think it'd be great to make __GFP_ZERO work in all cases. However, if that's
> >>> really not possible, I'd prefer if we could at least gurantee that
> >>> *realloc(NULL, size, flags | __GFP_ZERO) is a valid call, i.e.
> >>> WARN_ON(p && flags & __GFP_ZERO).
> >>>
> >>>>
> >>>>> + *
> >>>>> + * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
> >>>>> + * @p is not a %NULL pointer, the object pointed to is freed.
> >>>>> + *
> >>>>> + * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
> >>>>> + *         failure
> >>>>> + */
> >>>>> +void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> >>>>> +{
> >>>>> +	size_t old_size = 0;
> >>>>> +	void *n;
> >>>>> +
> >>>>> +	if (!size) {
> >>>>> +		vfree(p);
> >>>>> +		return NULL;
> >>>>> +	}
> >>>>> +
> >>>>> +	if (p) {
> >>>>> +		struct vm_struct *vm;
> >>>>> +
> >>>>> +		vm = find_vm_area(p);
> >>>>> +		if (unlikely(!vm)) {
> >>>>> +			WARN(1, "Trying to vrealloc() nonexistent vm area (%p)\n", p);
> >>>>> +			return NULL;
> >>>>> +		}
> >>>>> +
> >>>>> +		old_size = get_vm_area_size(vm);
> >>>>> +	}
> >>>>> +
> >>>>> +	if (size <= old_size) {
> >>>>> +		/*
> >>>>> +		 * TODO: Shrink the vm_area, i.e. unmap and free unused pages.
> >>>>> +		 * What would be a good heuristic for when to shrink the
> >>>>> +		 * vm_area?
> >>>>> +		 */
> >>>>> +		return (void *)p;
> >>>>> +	}
> >>>>> +
> >>>>> +	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
> >>>>> +	n = __vmalloc_noprof(size, flags);
> >>>>> +	if (!n)
> >>>>> +		return NULL;
> >>>>> +
> >>>>> +	if (p) {
> >>>>> +		memcpy(n, p, old_size);
> >>>>> +		vfree(p);
> >>>>> +	}
> >>>>> +
> >>>>> +	return n;
> >>>>> +}
> >>>>> +
> >>>>>  #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
> >>>>>  #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
> >>>>>  #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
> >>>>
> 

