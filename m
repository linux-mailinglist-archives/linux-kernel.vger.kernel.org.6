Return-Path: <linux-kernel+bounces-262785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA7493CCBC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BE21C21BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A781BC49;
	Fri, 26 Jul 2024 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Madc4Mvn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9B63D76
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721961083; cv=none; b=Q+PHq/ELNrw1XS9ST8Nkwg80qG/2R4OfL8/QK3NLZfDm+9SbQa5fhsJiYqX0+4Tu9jiimR5mJ56y1sNcJ47MmmYws6MKx8jD5xp3h7U+1gz/UJqdNZCRYJJsPKHQ3l4D9IyO4W1tYdU97IrukAPRNTgpky4P7JDzzMJGmNBIGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721961083; c=relaxed/simple;
	bh=zGl9wdP6GaT46RQ4jDJt0JagzffR20NOZVI6KtY+b+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ee6j8izmiigJkPc+gFAk3DGj83vQguniiNaBwXNVUewjxqMrUX9sWI7Lw7n2iprA3qm7zkFc5NjxXAmJQHJsp+/vF+XA7bjhauujKGuFIm0hDSk9auJZ1xBPoJOb+fDXovMZ8aAPFbQzE/cE5waKZ6qjgS4ucNdCorMSegU5JQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Madc4Mvn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721961079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oCQEKBxu2ULMb9kbDdpPsJ+iaBtA661FLtdvoe2GoJw=;
	b=Madc4Mvns9w7O74dboWY5g59IUtofiec8CUP+YySYuYlUEFHps/Q9gKUev4eRZ+bvbniCp
	dyFZXnE/mRJO1TU6sODLP+yRCr89I9BsKNRNgpi5bfsGEo5vDykT1f9rlsqdLZnGg815SD
	TcEwI9INGg7ilkzslAAV3OcKWfB8IDk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-tL63dCGRNqab7IOa8ZXCpg-1; Thu,
 25 Jul 2024 22:31:13 -0400
X-MC-Unique: tL63dCGRNqab7IOa8ZXCpg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D46F1955D52;
	Fri, 26 Jul 2024 02:31:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 231111955D42;
	Fri, 26 Jul 2024 02:31:08 +0000 (UTC)
Date: Fri, 26 Jul 2024 10:31:03 +0800
From: Baoquan He <bhe@redhat.com>
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Barry Song <21cnbao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tangquan Zheng <zhengtangquan@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect
 __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order
 fallback to order0
Message-ID: <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
References: <20240725035318.471-1-hailong.liu@oppo.com>
 <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725164003.ft6huabwa5dqoy2g@oppo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/26/24 at 12:40am, Hailong Liu wrote:
> On Thu, 25. Jul 19:39, Baoquan He wrote:
> > On 07/25/24 at 11:53am, hailong.liu@oppo.com wrote:
> > > From: "Hailong.Liu" <hailong.liu@oppo.com>
> > >
> > > The scenario where the issue occurs is as follows:
> > > CONFIG: vmap_allow_huge = true && 2M is for PMD_SIZE
> > > kvmalloc(2M, __GFP_NOFAIL|GFP_XXX)
> > >     __vmalloc_node_range(vm_flags=VM_ALLOW_HUGE_VMAP)
> > >         vm_area_alloc_pages(order=9) --->allocs order9 failed and fallback to order0
> > >                                         and phys_addr is aligned with PMD_SIZE
> > >             vmap_pages_range
> > >                 vmap_pages_range_noflush
> > >                     __vmap_pages_range_noflush(page_shift = 21) ----> incorrect vmap *huge* here
> > >
> > > In fact, as long as page_shift is not equal to PAGE_SHIFT, there
> > > might be issues with the __vmap_pages_range_noflush().
> > >
> > > The patch also remove VM_ALLOW_HUGE_VMAP in kvmalloc_node(), There
> > > are several reasons for this:
> > > - This increases memory footprint because ALIGNMENT.
> > > - This increases the likelihood of kvmalloc allocation failures.
> > > - Without this it fixes the origin issue of kvmalloc with __GFP_NOFAIL may return NULL.
> > > Besides if drivers want to vmap huge, user vmalloc_huge instead.
> >
> > Seem there are two issues you are folding into one patch:
> Got it. I will separate in the next version.
> 
> >
> > one is the wrong informatin passed into __vmap_pages_range_noflush();
> > the other is you want to take off VM_ALLOW_HUGE_VMAP on kvmalloc().
> >
> > About the 1st one, do you think below draft is OK to you?
> >
> > Pass out the fall back order and adjust the order and shift for later
> > usage, mainly for vmap_pages_range().
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 260897b21b11..5ee9ae518f3d 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3508,9 +3508,9 @@ EXPORT_SYMBOL_GPL(vmap_pfn);
> >
> >  static inline unsigned int
> >  vm_area_alloc_pages(gfp_t gfp, int nid,
> > -		unsigned int order, unsigned int nr_pages, struct page **pages)
> > +		unsigned int *page_order, unsigned int nr_pages, struct page **pages)
> >  {
> > -	unsigned int nr_allocated = 0;
> > +	unsigned int nr_allocated = 0, order = *page_order;
> >  	gfp_t alloc_gfp = gfp;
> >  	bool nofail = gfp & __GFP_NOFAIL;
> >  	struct page *page;
> > @@ -3611,6 +3611,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  		cond_resched();
> >  		nr_allocated += 1U << order;
> >  	}
> > +	*page_order = order;
> >
> >  	return nr_allocated;
> >  }
> > @@ -3654,7 +3655,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  	page_order = vm_area_page_order(area);
> >
> >  	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> > -		node, page_order, nr_small_pages, area->pages);
> > +		node, &page_order, nr_small_pages, area->pages);
> >
> >  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> >  	if (gfp_mask & __GFP_ACCOUNT) {
> > @@ -3686,6 +3687,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  		goto fail;
> >  	}
> >
> > +
> > +	set_vm_area_page_order(area, page_order);
> > +	page_shift = page_order + PAGE_SHIFT;
> > +
> >  	/*
> >  	 * page tables allocations ignore external gfp mask, enforce it
> >  	 * by the scope API
> >
> The logic of this patch is somewhat similar to my first one. If high order
> allocation fails, it will go normal mapping.
> 
> However I also save the fallback position. The ones before this position are
> used for huge mapping, the ones >= position for normal mapping as Barry said.
> "support the combination of PMD and PTE mapping". this  will take some
> times as it needs to address the corner cases and do some tests.

Hmm, we may not need to worry about the imperfect mapping. Currently
there are two places setting VM_ALLOW_HUGE_VMAP: __kvmalloc_node_noprof()
and vmalloc_huge(). 

For vmalloc_huge(), it's called in below three interfaces which are all
invoked during boot. Basically they can succeed to get required contiguous
physical memory. I guess that's why Tangquan only spot this issue on kvmalloc
invocation when the required size exceeds e.g 2M. For kvmalloc_node(),
we have told that in the code comment above __kvmalloc_node_noprof(),
it's a best effort behaviour.

 mm/mm_init.c <<alloc_large_system_hash>>
 table = vmalloc_huge(size, gfp_flags);
 net/ipv4/inet_hashtables.c <<inet_pernet_hashinfo_alloc>>
 new_hashinfo->ehash = vmalloc_huge(ehash_entries * sizeof(struct inet_ehash_bucket),
 net/ipv4/udp.c <<udp_pernet_table_alloc>>
 udptable->hash = vmalloc_huge(hash_entries * 2 * sizeof(struct udp_hslot)

Maybe we should add code comment or document to notice people that the
contiguous physical pages are not guaranteed for vmalloc_huge() if you
use it after boot.

> 
> IMO, the draft can fix the current issue, it also does not have significant side
> effects. Barry, what do you think about this patch? If you think it's okay,
> I will split this patch into two: one to remove the VM_ALLOW_HUGE_VMAP and the
> other to address the current mapping issue.
> 
> --
> help you, help me,
> Hailong.
> 


