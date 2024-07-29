Return-Path: <linux-kernel+bounces-266129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0747193FB83
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6989283ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9AD15ECF9;
	Mon, 29 Jul 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+64q7pb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED611534EC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271203; cv=none; b=a/deteE0xIZKU+ndAPda7gmR5orMZxdpe25m4xk8Gbvh6gZtRbOIhFn7PubdPddIeOsZwOySkoUgMkLNWYShH/BRtzkEUIb6+LyIrAM9hkfweVNPxBuxngMvpPqRRp6DONkcrbUfAvkTLytGeT9+1uk0EtDsNAFWugUrzS1i4Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271203; c=relaxed/simple;
	bh=3uOjfSIa3gjCaycPh6rEla8bem66kN5JqAHSKT5j8R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDYjdYa6+wMpBG0yQ3pkY/oRzfobbMFZtYNFWvXLPlBoVou/W2r8VaHGuKglU3awwY1zU3k4IYI0Tfmf0uprXjPcEGjdhccVEqTA+yX+x3cslCHJesFZOBw/ZtkVmzrCyN28HcynJuHakB6/V9r+Z9o0CWO3lQU1FfRBFncKG3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+64q7pb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722271200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nG+U8CP71bDhVREKToFWLK1NsMPuT0lccg4lODePGLw=;
	b=T+64q7pbmQ4Cw9vpbCwN3/vdakQRqXSwCOFqYfC/kM6xMDHWaVmOEEEeVVNjN1/05fPTA7
	KK2J4VDIH3c+L+hT4G9ifl1mwdalpxRilVAkelUgbHkmQdS44W+XQvgyp0ZhMew8bSa2I/
	jYEqIkhEOYNXlTffZ+0zrCkrRVI5YI0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-SawExSGdMc-IVEcnR33RMQ-1; Mon, 29 Jul 2024 12:39:59 -0400
X-MC-Unique: SawExSGdMc-IVEcnR33RMQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b7b1d79bacso7166036d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271199; x=1722875999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG+U8CP71bDhVREKToFWLK1NsMPuT0lccg4lODePGLw=;
        b=BMlamVLngFk5fi6ktb0cC0xjhp2BapBsEq4fZRgHPufFmZ+tNHYPH3UvObwXRDX9Xa
         x9dzm1UJ0LVBDl41vsuUGAbytPPUuvxK0eZYDcNwyHi4W8KrhnzC5IOjpl3ILBTGS1Nj
         CTZF9+P+Jk4lshMGms903m+stFZJX3wOuUsnmetD/AaQ1MzoQAKyrvUL16Ptjr0otoJR
         yC30wJMjTq1jTMsrkddU+NCE13LXycUYJ1Xv/mG6FAwj+LQNw9zv2aE5/FcgiSd7Q+ly
         Or88+Tp7juXq9amlHIXf5zE8KkJ1o3j03kFUHU9tfjWvrbZo84WLWlI5vZ45ugZpuM9y
         7jzQ==
X-Gm-Message-State: AOJu0Yym1TIZwexGiI9680sEmfzPot1kzBAt6mh5Kt3S0YFrbx6kvEGH
	0qLyRaju4YI7cD5MCouK7YoMOBW+XAnbUg/l1p8km7t6bx62rknxEqmPBmrsTxMbqhhURLBcSE8
	WQbJ4hdtPrAD34rqU5n6DHj32/qel9LEMlo38cKl8Xr7sc/iH8tbRM4lq48QOBQ==
X-Received: by 2002:a05:6214:2b0a:b0:6b7:7832:2211 with SMTP id 6a1803df08f44-6bb3e2043dbmr110039666d6.3.1722271198808;
        Mon, 29 Jul 2024 09:39:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVuspPakX+V9lQ3PvkgS/PfvHrGrnZJjM7JWJBxvIiTeHSsdJs+rJCguqpGnqUpgVT690niQ==
X-Received: by 2002:a05:6214:2b0a:b0:6b7:7832:2211 with SMTP id 6a1803df08f44-6bb3e2043dbmr110039506d6.3.1722271198330;
        Mon, 29 Jul 2024 09:39:58 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3faef212sm54076776d6.122.2024.07.29.09.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:39:58 -0700 (PDT)
Date: Mon, 29 Jul 2024 12:39:54 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
Message-ID: <ZqfF2hhe60TE8xhQ@x1n>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com>
 <ZqPCjd35OdNRrcfl@x1n>
 <bf2069ed-f2b8-49d4-baf0-dbd2189362f9@redhat.com>
 <ZqQVDwv4RM-wIW7S@x1n>
 <9e671388-a5c6-4de1-8c85-b7af8aee7f44@redhat.com>
 <ZqfCmFUFyPU3WGES@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqfCmFUFyPU3WGES@x1n>

On Mon, Jul 29, 2024 at 12:26:00PM -0400, Peter Xu wrote:
> On Fri, Jul 26, 2024 at 11:48:01PM +0200, David Hildenbrand wrote:
> > On 26.07.24 23:28, Peter Xu wrote:
> > > On Fri, Jul 26, 2024 at 06:02:17PM +0200, David Hildenbrand wrote:
> > > > On 26.07.24 17:36, Peter Xu wrote:
> > > > > On Thu, Jul 25, 2024 at 08:39:54PM +0200, David Hildenbrand wrote:
> > > > > > pte_lockptr() is the only *_lockptr() function that doesn't consume
> > > > > > what would be expected: it consumes a pmd_t pointer instead of a pte_t
> > > > > > pointer.
> > > > > > 
> > > > > > Let's change that. The two callers in pgtable-generic.c are easily
> > > > > > adjusted. Adjust khugepaged.c:retract_page_tables() to simply do a
> > > > > > pte_offset_map_nolock() to obtain the lock, even though we won't actually
> > > > > > be traversing the page table.
> > > > > > 
> > > > > > This makes the code more similar to the other variants and avoids other
> > > > > > hacks to make the new pte_lockptr() version happy. pte_lockptr() users
> > > > > > reside now only in  pgtable-generic.c.
> > > > > > 
> > > > > > Maybe, using pte_offset_map_nolock() is the right thing to do because
> > > > > > the PTE table could have been removed in the meantime? At least it sounds
> > > > > > more future proof if we ever have other means of page table reclaim.
> > > > > 
> > > > > I think it can't change, because anyone who wants to race against this
> > > > > should try to take the pmd lock first (which was held already)?
> > > > 
> > > > That doesn't explain why it is safe for us to assume that after we took the
> > > > PMD lock that the PMD actually still points at a completely empty page
> > > > table. Likely it currently works by accident, because we only have a single
> > > > such user that makes this assumption. It might certainly be a different once
> > > > we asynchronously reclaim page tables.
> > > 
> > > I think it's safe because find_pmd_or_thp_or_none() returned SUCCEED, and
> > > we're holding i_mmap lock for read.  I don't see any way that this pmd can
> > > become a non-pgtable-page.
> > > 
> > > I meant, AFAIU tearing down pgtable in whatever sane way will need to at
> > > least take both mmap write lock and i_mmap write lock (in this case, a file
> > > mapping), no?
> > 
> > Skimming over [1] where I still owe a review I think we can now do it now
> > purely under the read locks, with the PMD lock held.
> 
> Err, how I missed that.. yeah you're definitely right, and that's the
> context here where we're collapsing.  I think I somehow forgot all Hugh's
> work when I replied there, sorry.
> 
> > 
> > I think this is also what collapse_pte_mapped_thp() ends up doing: replace a
> > PTE table that maps a folio by a PMD (present or none, depends) that maps a
> > folio only while holding the mmap lock in read mode. Of course, here the
> > table is not empty but we need similar ways of making PT walkers aware of
> > concurrent page table retraction.
> > 
> > IIRC, that was the magic added to __pte_offset_map(), such that
> > pte_offset_map_nolock/pte_offset_map_lock can fail on races.
> 
> Said that, I still think current code (before this patch) is safe, same to
> a hard-coded line to lock the pte pgtable lock.  Again, I'm fine if you
> prefer pte_offset_map_nolock() but I just think the rcu read lock and stuff
> can be avoided.
> 
> I think it's because such collapse so far can only happen in such path
> where we need to hold the large folio (PMD-level) lock first.  It means
> anyone who could change this pmd entry to be not a pte pgtable is blocked
> already, hence it must keeping being a pte pgtable page even if we don't
> take any rcu.
> 
> > 
> > 
> > But if we hold the PMD lock, nothing should actually change (so far my
> > understanding) -- we cannot suddenly rip out a page table.
> > 
> > [1]
> > https://lkml.kernel.org/r/cover.1719570849.git.zhengqi.arch@bytedance.com
> > 
> > > 
> > > > 
> > > > But yes, the PMD cannot get modified while we hold the PMD lock, otherwise
> > > > we'd be in trouble
> > > > 
> > > > > 
> > > > > I wonder an open coded "ptlock_ptr(page_ptdesc(pmd_page(*pmd)))" would be
> > > > > nicer here, but only if my understanding is correct.
> > > > 
> > > > I really don't like open-coding that. Fortunately we were able to limit the
> > > > use of ptlock_ptr to a single user outside of arch/x86/xen/mmu_pv.c so far.
> > > 
> > > I'm fine if you prefer like that; I don't see it a huge deal to me.
> > 
> > Let's keep it like that, unless we can come up with something neater. At
> > least it makes the code also more consistent with similar code in that file
> > and the overhead should be  minimal.
> > 
> > I was briefly thinking about actually testing if the PT is full of
> > pte_none(), either as a debugging check or to also handle what is currently
> > handled via:
> > 
> > if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
> > 
> > Seems wasteful just because some part of a VMA might have a private page
> > mapped / uffd-wp active to let all other parts suffer.
> > 
> > Will think about if that is really worth it.
> > 
> > ... also because I still want to understand why the PTL of the PMD table is
> > required at all. What if we lock it first and somebody else wants to lock it
> > after us while we already ripped it out? Sure there must be some reason for
> > the lock, I just don't understand it yet :/.
> 
> IIUC the pte pgtable lock will be needed for checking anon_vma safely.
> 
> e.g., consider if we don't take the pte pgtable lock, I think it's possible
> some thread tries to inject a private pte (and prepare anon_vma before
> that) concurrently with this thread trying to collapse the pgtable into a
> huge pmd.  I mean, when without the pte pgtable lock held, I think it's
> racy to check this line:
> 
>         if (unlikely(vma->anon_vma || userfaultfd_wp(vma))) {
>                 ...
>         }
> 
> On the 1st condition.

Hmm, right after I replied, I think it also guarantees safety on the 2nd
condition..

Note that one thing I still prefer a hard-coded line over
pte_offset_map_nolock() is that, the new code seems to say we can treat the
pte pgtable page differently from the pte pgtable lock.  But I think
they're really in the same realm.

In short, AFAIU the rcu lock not only protects the pte pgtable's existance,
but also protects the pte lock.

From that POV, below new code in this patch:

-               ptl = pte_lockptr(mm, pmd);
+
+               /*
+                * No need to check the PTE table content, but we'll grab the
+                * PTE table lock while we zap it.
+                */
+               pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
+               if (!pte)
+                       goto unlock_pmd;
                if (ptl != pml)
                        spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+               pte_unmap(pte);

Could be very misleading, where it seems to say that it's fine to use the
pte pgtable lock even after rcu unlock.  It might make the code harder to
understand.

Thanks,

-- 
Peter Xu


