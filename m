Return-Path: <linux-kernel+bounces-266109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDA593FB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E832E1F237DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D7416C874;
	Mon, 29 Jul 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvT8pF+G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2615D5C1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270368; cv=none; b=jUNB2oVgXVa/Hqm+zEb2B43l9vujFsMEj/g5UvRWsFBWVmBbYBG62JDYjzoq/8RiTD/6X81ZGZAkhAF15Fv2ziPSjwpv0+5ZZhTsR4GTu14p/yfuKVCMTNZU1+YYhhQHIBYT7b09zciXlgM5RZVMdNvxSUR3Jw0cdsOt+coD2lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270368; c=relaxed/simple;
	bh=VKbgwg5wit7ovnZP0AwxBxvSYXqk2qY2+OrRxJyAFy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAqF8bu8vq07GWw4topH2iCh+WR83oOMXCaYWFgLQSmWxPWjoDTnHk3mOYUu75D+eZWnMDe9fSchaEkgC9Lzlg8MjtlvRfbeUgGkPIwfQrSTmRHQTQscnZCDrUdKw8y7RN7jQr64DnvL/rVe1nyH8qB3cYfIAaT2TLG0ltkBvbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvT8pF+G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ce2AMpW5fHbl44BfHagVxzwYFNwU0KTNeNYlNdLKeJE=;
	b=GvT8pF+GJ81RqMGqtEBJwKQNqmA1qthyvd8ESfjWSElTQmhcUMYof2IbXcLVwitGmTLG3n
	jopihHTRe61TgL56k88+RLT7vkpCDWFFbW1ZOQjaGtJTIgsaD5ZdV+XfA+BRC1xjLvFkSJ
	GOA8flrOEmXG2Q/cFYVFVkXgCi06JE8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-xqptuDVfMTKpnpC0pGctfA-1; Mon, 29 Jul 2024 12:26:04 -0400
X-MC-Unique: xqptuDVfMTKpnpC0pGctfA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5d5d0612dbdso659376eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722270363; x=1722875163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ce2AMpW5fHbl44BfHagVxzwYFNwU0KTNeNYlNdLKeJE=;
        b=lioeP8mEAMSkM3Y8eNJg7A+ZemEnMVFXhAYGVIwBMV1YPKjFrMS7sYCy1wtkezwcxx
         9AsQsjmdAlrScjBxUgvcKWsjIH4yjXF3rqS/4hGvnuaUdMjqwY0H4lH2TzDqY72ELIIN
         dbsvt5XAM/eFXt6CUuBLA7K8wF71n7XjNBuZ5cu53x2J7ZpnrySmGYo6GVpZGTKJ6olZ
         AjAsEmnXgTlJwFxAIVzJkE4PRHePcZFjB+YCa85ALQfkygugV6gh8gPzugTTGvJ63kcr
         D5AsPQg5780udZif3yLBCTeVcHomkEVYaMiPbPRlGNmPUPEwXvHFbPXRep1E6BRLG8eL
         lZfQ==
X-Gm-Message-State: AOJu0YyTCIWi4xYwcWy+xFt+EZ293kXbVEvywz2PIx5XG7F9+E7z8+UT
	jkTOtYfbRKEAbdbXalm/q7dPZ6s+P7ugSSbemKk5qEkA+/kTsBskDArWbJhAuzraYNajAMprNgX
	gQw+cKEvMSjtOP7Vq9I1V5XNQT2QcJeCf8IxOKdfzfVXTdaUMyP2JVzChB0Ib5w==
X-Received: by 2002:a05:6359:4ca1:b0:1ac:f6e3:dbcd with SMTP id e5c5f4694b2df-1acfad22919mr850342155d.3.1722270363159;
        Mon, 29 Jul 2024 09:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7hiOlPZ8Srn4PYCzoISj3h6+sv4uf1sjLt2dNjrz7/a5dgHrae7Z+jGqCfZWntysMWZz10w==
X-Received: by 2002:a05:6359:4ca1:b0:1ac:f6e3:dbcd with SMTP id e5c5f4694b2df-1acfad22919mr850340155d.3.1722270362590;
        Mon, 29 Jul 2024 09:26:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d74600a3sm545365285a.128.2024.07.29.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:26:02 -0700 (PDT)
Date: Mon, 29 Jul 2024 12:26:00 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
Message-ID: <ZqfCmFUFyPU3WGES@x1n>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com>
 <ZqPCjd35OdNRrcfl@x1n>
 <bf2069ed-f2b8-49d4-baf0-dbd2189362f9@redhat.com>
 <ZqQVDwv4RM-wIW7S@x1n>
 <9e671388-a5c6-4de1-8c85-b7af8aee7f44@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e671388-a5c6-4de1-8c85-b7af8aee7f44@redhat.com>

On Fri, Jul 26, 2024 at 11:48:01PM +0200, David Hildenbrand wrote:
> On 26.07.24 23:28, Peter Xu wrote:
> > On Fri, Jul 26, 2024 at 06:02:17PM +0200, David Hildenbrand wrote:
> > > On 26.07.24 17:36, Peter Xu wrote:
> > > > On Thu, Jul 25, 2024 at 08:39:54PM +0200, David Hildenbrand wrote:
> > > > > pte_lockptr() is the only *_lockptr() function that doesn't consume
> > > > > what would be expected: it consumes a pmd_t pointer instead of a pte_t
> > > > > pointer.
> > > > > 
> > > > > Let's change that. The two callers in pgtable-generic.c are easily
> > > > > adjusted. Adjust khugepaged.c:retract_page_tables() to simply do a
> > > > > pte_offset_map_nolock() to obtain the lock, even though we won't actually
> > > > > be traversing the page table.
> > > > > 
> > > > > This makes the code more similar to the other variants and avoids other
> > > > > hacks to make the new pte_lockptr() version happy. pte_lockptr() users
> > > > > reside now only in  pgtable-generic.c.
> > > > > 
> > > > > Maybe, using pte_offset_map_nolock() is the right thing to do because
> > > > > the PTE table could have been removed in the meantime? At least it sounds
> > > > > more future proof if we ever have other means of page table reclaim.
> > > > 
> > > > I think it can't change, because anyone who wants to race against this
> > > > should try to take the pmd lock first (which was held already)?
> > > 
> > > That doesn't explain why it is safe for us to assume that after we took the
> > > PMD lock that the PMD actually still points at a completely empty page
> > > table. Likely it currently works by accident, because we only have a single
> > > such user that makes this assumption. It might certainly be a different once
> > > we asynchronously reclaim page tables.
> > 
> > I think it's safe because find_pmd_or_thp_or_none() returned SUCCEED, and
> > we're holding i_mmap lock for read.  I don't see any way that this pmd can
> > become a non-pgtable-page.
> > 
> > I meant, AFAIU tearing down pgtable in whatever sane way will need to at
> > least take both mmap write lock and i_mmap write lock (in this case, a file
> > mapping), no?
> 
> Skimming over [1] where I still owe a review I think we can now do it now
> purely under the read locks, with the PMD lock held.

Err, how I missed that.. yeah you're definitely right, and that's the
context here where we're collapsing.  I think I somehow forgot all Hugh's
work when I replied there, sorry.

> 
> I think this is also what collapse_pte_mapped_thp() ends up doing: replace a
> PTE table that maps a folio by a PMD (present or none, depends) that maps a
> folio only while holding the mmap lock in read mode. Of course, here the
> table is not empty but we need similar ways of making PT walkers aware of
> concurrent page table retraction.
> 
> IIRC, that was the magic added to __pte_offset_map(), such that
> pte_offset_map_nolock/pte_offset_map_lock can fail on races.

Said that, I still think current code (before this patch) is safe, same to
a hard-coded line to lock the pte pgtable lock.  Again, I'm fine if you
prefer pte_offset_map_nolock() but I just think the rcu read lock and stuff
can be avoided.

I think it's because such collapse so far can only happen in such path
where we need to hold the large folio (PMD-level) lock first.  It means
anyone who could change this pmd entry to be not a pte pgtable is blocked
already, hence it must keeping being a pte pgtable page even if we don't
take any rcu.

> 
> 
> But if we hold the PMD lock, nothing should actually change (so far my
> understanding) -- we cannot suddenly rip out a page table.
> 
> [1]
> https://lkml.kernel.org/r/cover.1719570849.git.zhengqi.arch@bytedance.com
> 
> > 
> > > 
> > > But yes, the PMD cannot get modified while we hold the PMD lock, otherwise
> > > we'd be in trouble
> > > 
> > > > 
> > > > I wonder an open coded "ptlock_ptr(page_ptdesc(pmd_page(*pmd)))" would be
> > > > nicer here, but only if my understanding is correct.
> > > 
> > > I really don't like open-coding that. Fortunately we were able to limit the
> > > use of ptlock_ptr to a single user outside of arch/x86/xen/mmu_pv.c so far.
> > 
> > I'm fine if you prefer like that; I don't see it a huge deal to me.
> 
> Let's keep it like that, unless we can come up with something neater. At
> least it makes the code also more consistent with similar code in that file
> and the overhead should be  minimal.
> 
> I was briefly thinking about actually testing if the PT is full of
> pte_none(), either as a debugging check or to also handle what is currently
> handled via:
> 
> if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
> 
> Seems wasteful just because some part of a VMA might have a private page
> mapped / uffd-wp active to let all other parts suffer.
> 
> Will think about if that is really worth it.
> 
> ... also because I still want to understand why the PTL of the PMD table is
> required at all. What if we lock it first and somebody else wants to lock it
> after us while we already ripped it out? Sure there must be some reason for
> the lock, I just don't understand it yet :/.

IIUC the pte pgtable lock will be needed for checking anon_vma safely.

e.g., consider if we don't take the pte pgtable lock, I think it's possible
some thread tries to inject a private pte (and prepare anon_vma before
that) concurrently with this thread trying to collapse the pgtable into a
huge pmd.  I mean, when without the pte pgtable lock held, I think it's
racy to check this line:

        if (unlikely(vma->anon_vma || userfaultfd_wp(vma))) {
                ...
        }

On the 1st condition.

Thanks,

-- 
Peter Xu


