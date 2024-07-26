Return-Path: <linux-kernel+bounces-263055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79A193D06D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6E31C217A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98527176FA3;
	Fri, 26 Jul 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsarib6J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B2C17557B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721986182; cv=none; b=dvtkLMVabU5koNZQ8li0kwJ7+UArirrD6a2bDIvbBhD4QnTF9wgZ6TtE2ZuRlxKnyukDXsBRomxb/f72rigfJS7unpPc50t78xFDBH6uaORDVZ2oz7r4lqun7QOW9oN3aKw45gOXr9U4Z5VdXXVIndKdGEVsnCk7MMA8hnwU27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721986182; c=relaxed/simple;
	bh=JjcNPWM2tx6HJZguDUoEKrnS8wTVS/c1kmrlB2l/PBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Chk4K3ZgroUpP8udWK1LwkKEW9hu4R3wP4cAKEZoiDVCC5Poet3jlWmTJ8qqQaAjkmrTu4k6WaP0TAgy2hThd7qEe5p6Rr9kaczdG3fqjfSKzafY+AdFVESrM0Sc5giOhvjH7OBRYA0tcngKMCBxHarLJwYAv3Bc+VdZTQa6ER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsarib6J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721986179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJTdMoDMeV6ZkZEHxIrp+DXkTDs07/EHR6SJpwQn7MI=;
	b=gsarib6JbceWgaGu2eHSdOvtgPBrQxDlon0vhUbNgK5tQMwzA1de5/y70cq7PnnhDA0Vfa
	GmPUgh3zvmdaCQQvjDf27wlDLNj/FqZ30VaQpxBC8shMIjRLkAYNaWpLgXb7Z7pKkoVCxu
	AsKXkjhGIw0eS4kuDhpydunRHBCJlF8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-LbZVJEjsNrK4clV6Ti2IRA-1; Fri,
 26 Jul 2024 05:29:35 -0400
X-MC-Unique: LbZVJEjsNrK4clV6Ti2IRA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E9EE1955D4C;
	Fri, 26 Jul 2024 09:29:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.25])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C3191955F40;
	Fri, 26 Jul 2024 09:29:30 +0000 (UTC)
Date: Fri, 26 Jul 2024 17:29:26 +0800
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
Message-ID: <ZqNsdmxa6cQfxKFP@MiWiFi-R3L-srv>
References: <20240725035318.471-1-hailong.liu@oppo.com>
 <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com>
 <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
 <20240726040052.hs2gvpktrnlbvhsq@oppo.com>
 <20240726050356.ludmpxfee6erlxxt@oppo.com>
 <CAGsJ_4xOauOwkHO5MTKHBP=fpeoNiP_9VJ31G4gBECFvLG4y0g@mail.gmail.com>
 <ZqNgY1T/VuWQvtfL@MiWiFi-R3L-srv>
 <20240726084809.gdz2axvawwwekpu6@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240726084809.gdz2axvawwwekpu6@oppo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/26/24 at 04:48pm, Hailong Liu wrote:
> On Fri, 26. Jul 16:37, Baoquan He wrote:
> > On 07/26/24 at 05:29pm, Barry Song wrote:
> > > On Fri, Jul 26, 2024 at 5:04 PM Hailong Liu <hailong.liu@oppo.com> wrote:
> > > >
> > > > On Fri, 26. Jul 12:00, Hailong Liu wrote:
> > > > > On Fri, 26. Jul 10:31, Baoquan He wrote:
> > > > > [...]
> > > > > > > The logic of this patch is somewhat similar to my first one. If high order
> > > > > > > allocation fails, it will go normal mapping.
> > > > > > >
> > > > > > > However I also save the fallback position. The ones before this position are
> > > > > > > used for huge mapping, the ones >= position for normal mapping as Barry said.
> > > > > > > "support the combination of PMD and PTE mapping". this  will take some
> > > > > > > times as it needs to address the corner cases and do some tests.
> > > > > >
> > > > > > Hmm, we may not need to worry about the imperfect mapping. Currently
> > > > > > there are two places setting VM_ALLOW_HUGE_VMAP: __kvmalloc_node_noprof()
> > > > > > and vmalloc_huge().
> > > > > >
> > > > > > For vmalloc_huge(), it's called in below three interfaces which are all
> > > > > > invoked during boot. Basically they can succeed to get required contiguous
> > > > > > physical memory. I guess that's why Tangquan only spot this issue on kvmalloc
> > > > > > invocation when the required size exceeds e.g 2M. For kvmalloc_node(),
> > > > > > we have told that in the code comment above __kvmalloc_node_noprof(),
> > > > > > it's a best effort behaviour.
> > > > > >
> > > > > Take a __vmalloc_node_range(2.1M, VM_ALLOW_HUGE_VMAP) as a example.
> > > > > because the align requirement of huge. the real size is 4M.
> > > > > if allocation first order-9 successfully and the next failed. becuase the
> > > > > fallback, the layout out pages would be like order9 - 512 * order0
> > > > > order9 support huge mapping, but order0 not.
> > > > > with the patch above, would call vmap_small_pages_range_noflush() and do normal
> > > > > mapping, the huge mapping would not exist.
> > > > >
> > > > > >  mm/mm_init.c <<alloc_large_system_hash>>
> > > > > >  table = vmalloc_huge(size, gfp_flags);
> > > > > >  net/ipv4/inet_hashtables.c <<inet_pernet_hashinfo_alloc>>
> > > > > >  new_hashinfo->ehash = vmalloc_huge(ehash_entries * sizeof(struct inet_ehash_bucket),
> > > > > >  net/ipv4/udp.c <<udp_pernet_table_alloc>>
> > > > > >  udptable->hash = vmalloc_huge(hash_entries * 2 * sizeof(struct udp_hslot)
> > > > > >
> > > > > > Maybe we should add code comment or document to notice people that the
> > > > > > contiguous physical pages are not guaranteed for vmalloc_huge() if you
> > > > > > use it after boot.
> > > > > >
> > > > > > >
> > > > > > > IMO, the draft can fix the current issue, it also does not have significant side
> > > > > > > effects. Barry, what do you think about this patch? If you think it's okay,
> > > > > > > I will split this patch into two: one to remove the VM_ALLOW_HUGE_VMAP and the
> > > > > > > other to address the current mapping issue.
> > > > > > >
> > > > > > > --
> > > > > > > help you, help me,
> > > > > > > Hailong.
> > > > > > >
> > > > > >
> > > > > >
> > > > I check the code, the issue only happen in gfp_mask with __GFP_NOFAIL and
> > > > fallback to order 0, actuaally without this commit
> > > > e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
> > > > if __vmalloc_area_node allocation failed, it will goto fail and try order-0.
> > > >
> > > > fail:
> > > >         if (shift > PAGE_SHIFT) {
> > > >                 shift = PAGE_SHIFT;
> > > >                 align = real_align;
> > > >                 size = real_size;
> > > >                 goto again;
> > > >         }
> > > >
> > > > So do we really need fallback to order-0 if nofail?
> > >
> > > Good catch, this is what I missed. I feel we can revert Michal's fix.
> > > And just remove __GFP_NOFAIL bit when we are still allocating
> > > by high-order. When "goto again" happens, we will allocate by
> > > order-0, in this case, we keep the __GFP_NOFAIL.
> >
> > With Michal's patch, the fallback will be able to satisfy the allocation
> > for nofail case because it fallback to 0-order plus __GFP_NOFAIL. The
> 
> Hi Baoquan:
> 
> int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> 		pgprot_t prot, struct page **pages, unsigned int page_shift)
> {
> 	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
> 
> 	WARN_ON(page_shift < PAGE_SHIFT);
> 
> 	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> 			page_shift == PAGE_SHIFT)
> 		return vmap_small_pages_range_noflush(addr, end, prot, pages);
> 
> 	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {  ---> huge mapping
> 		int err;
> 
> 		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
> 					page_to_phys(pages[i]), prot, ---------> incorrect mapping would occur here if nofail and fallback to order0

Thanks. I have got this issue from your patch. I mean if we have adjusted
the page_shift and page_order after fallback with the draft patch I
proposed, Barry still mentioned the nofail issue, that confuses me.

> 					page_shift);
> 		if (err)
> 			return err;
> 
> 		addr += 1UL << page_shift;
> 	}
> 
> 	return 0;
> }
> > 'if (shift > PAGE_SHIFT)' conditional checking and handling may be
> > problemtic since it could jump to fail becuase vmap_pages_range()
> > invocation failed, or partially allocate huge parges and break down,
> > then it will ignore the already allocated pages, and do all the thing again.
> >
> > The only thing 'if (shift > PAGE_SHIFT)' checking and handling makes
> > sense is it fallback to the real_size and real_align. BUT we need handle
> > the fail separately, e.g
> > 1)__get_vm_area_node() failed;
> > 2)vm_area_alloc_pages() failed when shift > PAGE_SHIFT and non-nofail;
> > 3)vmap_pages_range() failed;
> >
> > Honestly, I didn't see where the nofail is mishandled, could you point
> > it out specifically? I could miss it.
> >
> > Thanks
> > Baoquan
> >
> 
> --
> help you, help me,
> Hailong.
> 


