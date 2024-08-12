Return-Path: <linux-kernel+bounces-283637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2F794F733
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5786F1F22B14
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E9B19149E;
	Mon, 12 Aug 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWtJQr0p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA2190470
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489557; cv=none; b=oGh1Wmt9r4hSkTJ7slF1yo8C4AB92Ax+odylwiUQ8O7ZP7gk5mlkb4ifWEDejx3TgZryJOvSpg7pweyy5ex3hgCenDQ13miIHtDTuBjE1DagY/SrTQMDJCXv2FSXMkV8VCQ+3B69WY/EQnixD4R1ss9RjGzfXTSj9IZrxy0JZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489557; c=relaxed/simple;
	bh=qex7tbBtNhCnUhGbju+uO76z0q9IsTf6CB4hr36kAc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZIio+0oKzFjG1IzNACPHWZhjB+wP/YYxtR8if2J3kElOwsLLesSMNSdxjpxkz2wJAHWhHIVBjDIK/eOESbaNRHHVRqpK5ugZpe8WEN9an0cg6OG1Eh34AYD542tp7lByHsA225YkU9iKttSY8AfkBEl5M9TmJhuWUpvKzuKd2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWtJQr0p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723489554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HzakOI9YGqv9HtFf9jIxuThCq3IEoBU6xpTlkdeG+TM=;
	b=JWtJQr0pjOiYDniv3k2CKLwf64+TSaQTvC1B3/Y0MzKs0b8qAfTRwoZisCYOjZuJlEBCr5
	kYytbkCEbvv/BKGyzZvgg5+VxmwTi0yA/v9JzDoiyX10u62vtPyvk0PAGrFcOuMAr9YeGe
	aAhgzRgOFYn6CKBLyVNMf9ZuPcj4NPU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-jdfr5jxZOEObKy73iDSb9A-1; Mon, 12 Aug 2024 15:05:53 -0400
X-MC-Unique: jdfr5jxZOEObKy73iDSb9A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6ba92dd246fso10461856d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489553; x=1724094353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzakOI9YGqv9HtFf9jIxuThCq3IEoBU6xpTlkdeG+TM=;
        b=D4BQazdyoj26KxIS2zuOsPazL2sL+5aAE0sKn5dELpGIVjNS+ZPOTa7+RvSpZ/Wgw5
         PsRckcskOG6oHLOJ0kxSVp9rjETluaQbXkYOTr+pusf8E89f43bFtedsMCTJ/m9evasq
         tEvQCP92hA4JQT6Sz2oD5FlMUl4cldZBmTn2pbnRFL7T3v4n9HiHACSdc23VQR1xoXA7
         6FyZDUwpqGb+mI9sQ2jrpJMZMJI8rR7zXOUSX1O0nvlgU3jIhgyhLm7hduDGK8yzbtGy
         s0/n7wESpapR0I0R6QgeXNJ8x+fq/ckhcWq8JlHHm8kig7a5kBsv+fREaZXAyiNepu17
         heSw==
X-Forwarded-Encrypted: i=1; AJvYcCXyXQGUCnKD62V4/9U4qmFJH/jGu81YhlP9j4+LGAMRhBn2WeU+D2eQTtAgd4BSlmJ5MfZHIxa65efJd0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dnE5yR2IHdZAg46ZQ5dsoQthKsz8EQjbwtas5h5ELQhjkfXy
	Ie+SretJ3I47uBLfmhr0ww6vLE1OZirYJ9V4m8+VLYZ/+uBpf3sGKM911RzfOV2rvFUQe0hI+HI
	KQxpimAxVJ+t6qkP+DNCH+CB5HekLaldVqRQb80o2cNlZ67hJRodQBZTcCHgHvQ==
X-Received: by 2002:a05:6214:e41:b0:6bf:5037:34f2 with SMTP id 6a1803df08f44-6bf5266e6damr316376d6.0.1723489552703;
        Mon, 12 Aug 2024 12:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHULEPrzuVK7C4EVg3OxKvCsQnbJxY4NNhAXiFtPbLqFyv/lM4Rh6yLbZbETy8EfhglpTaRGQ==
X-Received: by 2002:a05:6214:e41:b0:6bf:5037:34f2 with SMTP id 6a1803df08f44-6bf5266e6damr316036d6.0.1723489552107;
        Mon, 12 Aug 2024 12:05:52 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e6dcb3sm27136416d6.144.2024.08.12.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 12:05:51 -0700 (PDT)
Date: Mon, 12 Aug 2024 15:05:48 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 07/19] mm/fork: Accept huge pfnmap entries
Message-ID: <ZrpdDI18wnYJcyIM@x1n>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-8-peterx@redhat.com>
 <d7fcec73-16f6-4d54-b334-6450a29e0a1d@redhat.com>
 <ZrZOqbS3bcj52JZP@x1n>
 <8ef394e6-a964-41c4-b33c-0e940b6b9bd8@redhat.com>
 <ZrpUm-Lz-plw_fZy@x1n>
 <9155deaa-b6c5-4e6c-95a7-9a5311b7085a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9155deaa-b6c5-4e6c-95a7-9a5311b7085a@redhat.com>

On Mon, Aug 12, 2024 at 08:50:12PM +0200, David Hildenbrand wrote:
> On 12.08.24 20:29, Peter Xu wrote:
> > On Fri, Aug 09, 2024 at 07:59:58PM +0200, David Hildenbrand wrote:
> > > On 09.08.24 19:15, Peter Xu wrote:
> > > > On Fri, Aug 09, 2024 at 06:32:44PM +0200, David Hildenbrand wrote:
> > > > > On 09.08.24 18:08, Peter Xu wrote:
> > > > > > Teach the fork code to properly copy pfnmaps for pmd/pud levels.  Pud is
> > > > > > much easier, the write bit needs to be persisted though for writable and
> > > > > > shared pud mappings like PFNMAP ones, otherwise a follow up write in either
> > > > > > parent or child process will trigger a write fault.
> > > > > > 
> > > > > > Do the same for pmd level.
> > > > > > 
> > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > > ---
> > > > > >     mm/huge_memory.c | 27 ++++++++++++++++++++++++---
> > > > > >     1 file changed, 24 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > > > index 6568586b21ab..015c9468eed5 100644
> > > > > > --- a/mm/huge_memory.c
> > > > > > +++ b/mm/huge_memory.c
> > > > > > @@ -1375,6 +1375,22 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > > > > >     	pgtable_t pgtable = NULL;
> > > > > >     	int ret = -ENOMEM;
> > > > > > +	pmd = pmdp_get_lockless(src_pmd);
> > > > > > +	if (unlikely(pmd_special(pmd))) {
> > > > > > +		dst_ptl = pmd_lock(dst_mm, dst_pmd);
> > > > > > +		src_ptl = pmd_lockptr(src_mm, src_pmd);
> > > > > > +		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> > > > > > +		/*
> > > > > > +		 * No need to recheck the pmd, it can't change with write
> > > > > > +		 * mmap lock held here.
> > > > > > +		 */
> > > > > > +		if (is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd)) {
> > > > > > +			pmdp_set_wrprotect(src_mm, addr, src_pmd);
> > > > > > +			pmd = pmd_wrprotect(pmd);
> > > > > > +		}
> > > > > > +		goto set_pmd;
> > > > > > +	}
> > > > > > +
> > > > > 
> > > > > I strongly assume we should be using using vm_normal_page_pmd() instead of
> > > > > pmd_page() further below. pmd_special() should be mostly limited to GUP-fast
> > > > > and vm_normal_page_pmd().
> > > > 
> > > > One thing to mention that it has this:
> > > > 
> > > > 	if (!vma_is_anonymous(dst_vma))
> > > > 		return 0;
> > > 
> > > Another obscure thing in this function. It's not the job of copy_huge_pmd()
> > > to make the decision whether to copy, it's the job of vma_needs_copy() in
> > > copy_page_range().
> > > 
> > > And now I have to suspect that uffd-wp is broken with this function, because
> > > as vma_needs_copy() clearly states, we must copy, and we don't do that for
> > > PMDs. Ugh.
> > > 
> > > What a mess, we should just do what we do for PTEs and we will be fine ;)
> > 
> > IIUC it's not a problem: file uffd-wp is different from anonymous, in that
> > it pushes everything down to ptes.
> > 
> > It means if we skipped one huge pmd here for file, then it's destined to
> > have nothing to do with uffd-wp, otherwise it should have already been
> > split at the first attempt to wr-protect.
> 
> Is that also true for UFFD_FEATURE_WP_ASYNC, when we call
> pagemap_scan_thp_entry()->make_uffd_wp_pmd() ?
> 
> I'm not immediately finding the code that does the "pushes everything down
> to ptes", so I might miss that part.

UFFDIO_WRITEPROTECT should have all those covered, while I guess you're
right, looks like the pagemap ioctl is overlooked..

> 
> > 
> > > 
> > > Also, we call copy_huge_pmd() only if "is_swap_pmd(*src_pmd) ||
> > > pmd_trans_huge(*src_pmd) || pmd_devmap(*src_pmd)"
> > > 
> > > Would that even be the case with PFNMAP? I suspect that pmd_trans_huge()
> > > would return "true" for special pfnmap, which is rather "surprising", but
> > > fortunate for us.
> > 
> > It's definitely not surprising to me as that's the plan.. and I thought it
> > shoulidn't be surprising to you - if you remember before I sent this one, I
> > tried to decouple that here with the "thp agnostic" series:
> > 
> >    https://lore.kernel.org/r/20240717220219.3743374-1-peterx@redhat.com
> > 
> > in which you reviewed it (which I appreciated).
> > 
> > So yes, pfnmap on pmd so far will report pmd_trans_huge==true.
> 
> I review way to much stuff to remember everything :) That certainly screams
> for a cleanup ...

Definitely.

> 
> > 
> > > 
> > > Likely we should be calling copy_huge_pmd() if pmd_leaf() ... cleanup for
> > > another day.
> > 
> > Yes, ultimately it should really be a pmd_leaf(), but since I didn't get
> > much feedback there, and that can further postpone this series from being
> > posted I'm afraid, then I decided to just move on with "taking pfnmap as
> > THPs".  The corresponding change on this path is here in that series:
> > 
> > https://lore.kernel.org/all/20240717220219.3743374-7-peterx@redhat.com/
> > 
> > @@ -1235,8 +1235,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> >   	src_pmd = pmd_offset(src_pud, addr);
> >   	do {
> >   		next = pmd_addr_end(addr, end);
> > -		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
> > -			|| pmd_devmap(*src_pmd)) {
> > +		if (is_swap_pmd(*src_pmd) || pmd_is_leaf(*src_pmd)) {
> >   			int err;
> >   			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
> >   			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
> > 
> 
> Ah, good.
> 
> [...]
> 
> > > Yes, as stated above, likely broken with UFFD-WP ...
> > > 
> > > I really think we should make this code just behave like it would with PTEs,
> > > instead of throwing in more "different" handling.
> > 
> > So it could simply because file / anon uffd-wp work very differently.
> 
> Or because nobody wants to clean up that code ;)

I think in this case maybe the fork() part is all fine? As long as we can
switch pagemap ioctl to do proper break-downs when necessary, or even try
to reuse what UFFDIO_WRITEPROTECT does if still possible in some way.

In all cases, definitely sounds like another separate effort.

Thanks,

-- 
Peter Xu


