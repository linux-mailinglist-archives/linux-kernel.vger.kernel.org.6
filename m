Return-Path: <linux-kernel+bounces-313804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CEB96AA06
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8B0280E2D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E801A18E047;
	Tue,  3 Sep 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQWDzXep"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4B1EC013
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398627; cv=none; b=Q8y5b/RkBP3tBBrXM/kA1uX/G8+cdhlJrknqNoJ8MJtgnsOcN9FVX6/ZKNM0HAoc65Lvh8NXhwSglWsgvx0UKzwU5o5fXp5vUg06lui2UOCeGkfTmBa5FgLPqBsPvnBimjbNCslbm36dtZws9LtViKmTdacQ9twXDFKJ8B3lrUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398627; c=relaxed/simple;
	bh=EYF78CP979Wl57jZ8NUAZGx8yDd97++LwymXHvVbAhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsFa0PcW9T1kRTqIKIDX4lOKapMbI1cH2bxBiZsvK6OJe6ruiUy0A4uSqJMFm5ivr3Da7pfTN/byAd6f+iGhbmhq4jhx/Ob7T40WDtF8WGfOii2hXdbMbhCVgraJ4Wrg19l8JZxphr7mjExsWnyqkwHWj/5xvkcs2GreYm1Y0Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQWDzXep; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725398624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9BUz8/XF0Y9T8CJfW/HZEGzqGxZl9wZoaf3L2iMKE4=;
	b=EQWDzXephu9FfoFD8D7UZUW+6jULG/8DnO0f9hTZizO4LZUAIeug6Q96JGvZ+lZHpthAXY
	Cfig3aQNT0tHSYkXuAqg1UFME5kqfTmBVLYCj64kXjuQ1eeagSSkGFys1yimLfVS0n6vqE
	WU6bEeCm42atTLrjghzvmI+DNs/Zre8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-rAJ7zhrtNfaYDf1AeikQ2Q-1; Tue, 03 Sep 2024 17:23:43 -0400
X-MC-Unique: rAJ7zhrtNfaYDf1AeikQ2Q-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f4e119c57so43685905ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 14:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725398623; x=1726003423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9BUz8/XF0Y9T8CJfW/HZEGzqGxZl9wZoaf3L2iMKE4=;
        b=EbY6ibY0JuWd0w39fPvesw5cMxWkLMaT2XTAhO0RI/Sw2nPt1DsPG9vIAozoYLxDst
         7rpUTg71g/0dPUI+aQUKIrqcbqXUGEW5dXLBZwHIcK0kcoAuYm4n3GTPmSvJxzdUjvI4
         yADX3ZUE/NNfCAUArByYvjZ68kR780d9C7APt2luvcfO7aDoWvCc4y1m0COnZHsixI66
         Y/EWmjTZfkhXmpZ40MSjPgTRBANBxkT5SqexHPfbJywSQ3QTtrhORBOcfxMZ5geXX46j
         PsHhOXTNPjXiE+xYMyz2kuJYh0vXHbW4KOZ6p0wr0bLHpWH/q0/RYYluPDj1jMRLmnp3
         e46A==
X-Gm-Message-State: AOJu0YyZqQSx055phk84wy0E8yf+dbjXd0zZqDB71kGBiW0Jddv7r4lg
	42Jsv6KkC+hFNh3rOjjA28NTROGuVpGL5+qVNvmo7XvxUkkG1kmSbSZ+oj8lcaS1C0ESo8UTaOS
	cgD1tfhfmQ1RmCz1hG1dd9J3H2lssY9hI/XiKZYX7krtzk7ZImvQWqFAnNMqX3g==
X-Received: by 2002:a05:6e02:1a27:b0:39f:58f9:8d7c with SMTP id e9e14a558f8ab-39f58f999d6mr98609425ab.26.1725398622643;
        Tue, 03 Sep 2024 14:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxvBmrKrUXlRMceLmp36Br27W1bNa2xkEzECgslwDjjql0QNiHatEZ4EKpj7lp4mRqT0s0iw==
X-Received: by 2002:a05:6e02:1a27:b0:39f:58f9:8d7c with SMTP id e9e14a558f8ab-39f58f999d6mr98608875ab.26.1725398622195;
        Tue, 03 Sep 2024 14:23:42 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3af969dfsm32923855ab.14.2024.09.03.14.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 14:23:41 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:23:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alistair Popple <apopple@nvidia.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>, Borislav Petkov <bp@alien8.de>,
	Zi Yan <ziy@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>, Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 07/19] mm/fork: Accept huge pfnmap entries
Message-ID: <Ztd-WkEoFJGZ34xj@x1n>
References: <20240826204353.2228736-1-peterx@redhat.com>
 <20240826204353.2228736-8-peterx@redhat.com>
 <ZtVwLntpS0eJubFq@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtVwLntpS0eJubFq@yzhao56-desk.sh.intel.com>

On Mon, Sep 02, 2024 at 03:58:38PM +0800, Yan Zhao wrote:
> On Mon, Aug 26, 2024 at 04:43:41PM -0400, Peter Xu wrote:
> > Teach the fork code to properly copy pfnmaps for pmd/pud levels.  Pud is
> > much easier, the write bit needs to be persisted though for writable and
> > shared pud mappings like PFNMAP ones, otherwise a follow up write in either
> > parent or child process will trigger a write fault.
> > 
> > Do the same for pmd level.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/huge_memory.c | 29 ++++++++++++++++++++++++++---
> >  1 file changed, 26 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index e2c314f631f3..15418ffdd377 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1559,6 +1559,24 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >  	pgtable_t pgtable = NULL;
> >  	int ret = -ENOMEM;
> >  
> > +	pmd = pmdp_get_lockless(src_pmd);
> > +	if (unlikely(pmd_special(pmd))) {
> > +		dst_ptl = pmd_lock(dst_mm, dst_pmd);
> > +		src_ptl = pmd_lockptr(src_mm, src_pmd);
> > +		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> > +		/*
> > +		 * No need to recheck the pmd, it can't change with write
> > +		 * mmap lock held here.
> > +		 *
> > +		 * Meanwhile, making sure it's not a CoW VMA with writable
> > +		 * mapping, otherwise it means either the anon page wrongly
> > +		 * applied special bit, or we made the PRIVATE mapping be
> > +		 * able to wrongly write to the backend MMIO.
> > +		 */
> > +		VM_WARN_ON_ONCE(is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd));
> > +		goto set_pmd;
> > +	}
> > +
> >  	/* Skip if can be re-fill on fault */
> >  	if (!vma_is_anonymous(dst_vma))
> >  		return 0;
> > @@ -1640,7 +1658,9 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >  	pmdp_set_wrprotect(src_mm, addr, src_pmd);
> >  	if (!userfaultfd_wp(dst_vma))
> >  		pmd = pmd_clear_uffd_wp(pmd);
> > -	pmd = pmd_mkold(pmd_wrprotect(pmd));
> > +	pmd = pmd_wrprotect(pmd);
> > +set_pmd:
> > +	pmd = pmd_mkold(pmd);
> >  	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
> >  
> >  	ret = 0;
> > @@ -1686,8 +1706,11 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >  	 * TODO: once we support anonymous pages, use
> >  	 * folio_try_dup_anon_rmap_*() and split if duplicating fails.
> >  	 */
> > -	pudp_set_wrprotect(src_mm, addr, src_pud);
> > -	pud = pud_mkold(pud_wrprotect(pud));
> > +	if (is_cow_mapping(vma->vm_flags) && pud_write(pud)) {
> > +		pudp_set_wrprotect(src_mm, addr, src_pud);
> > +		pud = pud_wrprotect(pud);
> > +	}
> Do we need the logic to clear dirty bit in the child as that in
> __copy_present_ptes()?  (and also for the pmd's case).
> 
> e.g.
> if (vma->vm_flags & VM_SHARED)
> 	pud = pud_mkclean(pud);

Yeah, good question.  I remember I thought about that when initially
working on these lines, but I forgot the details, or maybe I simply tried
to stick with the current code base, as the dirty bit used to be kept even
in the child here.

I'd expect there's only performance differences, but still sounds like I'd
better leave that to whoever knows the best on the implications, then draft
it as a separate patch but only when needed.

Thanks,

-- 
Peter Xu


