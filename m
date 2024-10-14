Return-Path: <linux-kernel+bounces-364716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186299D84C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 803A1B21A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272B1D0BA4;
	Mon, 14 Oct 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ect6gHv/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFE1C879A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938122; cv=none; b=W+QXsnvDwfXaU1LbHvCfsLkoaZnmFP+mM8U4Sb1OS1PZKKmJRUZVU8McgBeHv+mdxu4aq/805qgiCPR5fqNYjoIyN5Wt+TO2IHVvBy2L1fmDHIDTZe1Q13yfvqPbQc8Sk1nLDN4l3Y+UeF4dfvs1tNvFYySeBApH9Mm4CmIu74A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938122; c=relaxed/simple;
	bh=wLhf3jR8M5Z8MMOJ1B8t6VL9zgSh30irh8dHs0m90j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuP6dcEQ3/IPE9JqTuGzCx+mzbAEw70+o0+LqsA5YJo7lCF+k8fyGvd4IOa4uTXe+r4nDVlMaUK0qsavtiLqsAZw3fX+xi61hk7DpKq/tsPLG0wHKU2f6PpvdY3xW8XOywKv65Z2cN74RH+dqfqPcfO+nlHdIq1y1K6sljHqbTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ect6gHv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59E6C4CECE;
	Mon, 14 Oct 2024 20:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728938121;
	bh=wLhf3jR8M5Z8MMOJ1B8t6VL9zgSh30irh8dHs0m90j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ect6gHv/bZie0Eolgfh8N6DRlAQnyFyCJplGNFbrR19cey3SPPXqQx2sIvoYxica1
	 MHzCSzEtHhkgLbo9RTbnPvVyNu/q7tFCmo7oqlKqdMs7r/OMMZ15Hf1RXed+hDI07a
	 y6TL+Xa+h45NN+ls3czivjkjwX5Wg1ah4mNFN9ZeqH3cPRxjNknZ3h5b/cQJPiU+Df
	 9fv9/Hv/fdEZgpPoTRXnxx77K3lgP9M4/abqUsGVLw8sYlVX8nwBS2eQw03cbPIsDz
	 mr5PXWZKapJr0TioKVO0GC/V6GoEp+5zhZOgaUkmn0k/GRqMND9+pWPiNzFzA8eQUr
	 2EXr1TCygBH9w==
Date: Mon, 14 Oct 2024 13:35:17 -0700
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Feng Tang <feng.tang@intel.com>, Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Gow <davidgow@google.com>, Danilo Krummrich <dakr@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
Message-ID: <202410141330.CAF56E3@keescook>
References: <20240911064535.557650-1-feng.tang@intel.com>
 <d3dd32ba-2866-40ce-ad2b-a147dcd2bf86@suse.cz>
 <CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com>
 <49ef066d-d001-411e-8db7-f064bdc2104c@suse.cz>
 <2382d6e1-7719-4bf9-8a4a-1e2c32ee7c9f@suse.cz>
 <ZwzNtGALCG9jUNUD@feng-clx.sh.intel.com>
 <a34e6796-e550-465c-92dc-ee659716b918@suse.cz>
 <Zw0UKtx5d2hnHvDV@feng-clx.sh.intel.com>
 <0e8d49d2-e89b-44df-9dff-29e8f24de105@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e8d49d2-e89b-44df-9dff-29e8f24de105@suse.cz>

On Mon, Oct 14, 2024 at 03:12:09PM +0200, Vlastimil Babka wrote:
> On 10/14/24 14:52, Feng Tang wrote:
> > On Mon, Oct 14, 2024 at 10:53:32AM +0200, Vlastimil Babka wrote:
> >> On 10/14/24 09:52, Feng Tang wrote:
> >> > On Fri, Oct 04, 2024 at 05:52:10PM +0800, Vlastimil Babka wrote:
> >> > Thanks for the suggestion!
> >> > 
> >> > As there were error report about the NULL slab for big kmalloc object, how
> >> > about the following code for 
> >> > 
> >> > __do_krealloc(const void *p, size_t new_size, gfp_t flags)
> >> > {
> >> > 	void *ret;
> >> > 	size_t ks = 0;
> >> > 	int orig_size = 0;
> >> > 	struct kmem_cache *s = NULL;
> >> > 
> >> > 	/* Check for double-free. */
> >> > 	if (likely(!ZERO_OR_NULL_PTR(p))) {
> >> > 		if (!kasan_check_byte(p))
> >> > 			return NULL;
> >> > 
> >> > 		ks = ksize(p);
> >> 
> >> I think this will result in __ksize() doing
> >>   skip_orig_size_check(folio_slab(folio)->slab_cache, object);
> >> and we don't want that?
> > 
> > I think that's fine. As later code will re-set the orig_size anyway.
> 
> But you also read it first.
> 
> >> > 		/* Some objects have no orig_size, like big kmalloc case */
> >> > 		if (is_kfence_address(p)) {
> >> > 			orig_size = kfence_ksize(p);
> >> > 		} else if (virt_to_slab(p)) {
> >> > 			s = virt_to_cache(p);
> >> > 			orig_size = get_orig_size(s, (void *)p);
> 
> here.
> 
> >> > 		}
> 
> >> Also the checks below repeat some of the checks of ksize().
> > 
> > Yes, there is some redundancy, mostly the virt_to_slab() 
> > 
> >> So I think in __do_krealloc() we should do things manually to determine ks
> >> and not call ksize(). Just not break any of the cases ksize() handles
> >> (kfence, large kmalloc).
> > 
> > OK, originally I tried not to expose internals of __ksize(). Let me
> > try this way.
> 
> ksize() makes assumptions that a user outside of slab itself is calling it.
> 
> But we (well mostly Kees) also introduced kmalloc_size_roundup() to avoid
> querying ksize() for the purposes of writing beyond the original
> kmalloc(size) up to the bucket size. So maybe we can also investigate if the
> skip_orig_size_check() mechanism can be removed now?
> 
> Still I think __do_krealloc() should rather do its own thing and not call
> ksize().

The goal was to avoid having users of the allocation APIs change the
sizes of allocations without calling into realloc. This is because
otherwise the "alloc_size" attribute used by compilers inform
__builtin_dynamic_object_size() can get confused:

ptr = alloc(less_than_bucket_size);
...
size = ksize(ptr); /* larger size! */
memcpy(ptr, src, size); /* compiler instrumentation doesn't see that ptr "grows" */

So the callers use kmalloc_size_roundup() to just allocate the rounded
up size immediately. Internally, the allocator can do what it wants.

-- 
Kees Cook

