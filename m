Return-Path: <linux-kernel+bounces-556949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BCEA5D14C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6904A3B852F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982842222DB;
	Tue, 11 Mar 2025 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EybcrF6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30778BF8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726826; cv=none; b=hGbcy0VnN8xkumvzxC7dlULzcYEDljUxrWXMnGFpvn/sx5Bg/AIIihldwN/Mb7LLdFkIz1AKGzvvebeMKfUWyI8Z6E/xgXg4T09kaSaRg7j2d72sQr49jGgE+rnXs+z+3u7GBGISe3mfnd7SX+x5OvkFNEP5WC2vktaCNXIJBFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726826; c=relaxed/simple;
	bh=QLkONEElsgGKxIzNwS3VferQTigrHPHxuZz5dFwdp5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KNMJQRSu4gE3rTw5yVlTirZNanWnd+NSfAHwciDPKSWIG93FASmScO9YA/DLvirUEwEySNdwIRWDYiH3zy4ahokLkocZoRML04azHmGVEGBl7Uh4gTh18JdPwuhNpGL6rXQFz4sJClpyfZW+/3CYpq3CQYSNt6gJcZBXJZLDIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EybcrF6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D71AC4CEE9;
	Tue, 11 Mar 2025 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741726825;
	bh=QLkONEElsgGKxIzNwS3VferQTigrHPHxuZz5dFwdp5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EybcrF6mztt/bLYNcuSF2rCGMEPvxvMLV/UEQGBqRccO0fFU0RoFznkIYcX/c+NLf
	 Q0kxEjONBkyhvtip0iJkEaZihjA0e2TENb/PBuBlNPhVcbVgilBsFMz4HAAxwoL2m4
	 ZaJXyj8rW2EO9iTwjElzPDOnK+R743BcX7ouTbaNdgTS9VF6rcjmYrVcAmkQ+eRf79
	 Xm37L0xrPhd0glAOPz6Py3uVce2Ync3qlXsGPxqEEKkLVeyLPIOpdg6u7fYLw0wvAh
	 8rIe4nKRawf+/SBEhgyvxZGxR57THsyCpMkHtlzGY1CZ/lvOmqSYrMFqCy0cVth/s8
	 vi0dZ6rNs0PIQ==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 7/9] mm/madvise: let madvise_{dontneed,free}_single_vma() caller batches tlb flushes
Date: Tue, 11 Mar 2025 14:00:23 -0700
Message-Id: <20250311210023.85435-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <e55c43a1-55de-4720-9177-8af08c797d17@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 13:07:25 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Super super UBER nitty but... pretty sure the subject here should be <= 75
> chars right? :P

I believe that's not a hard limit, but I will try to make it shorter in the
next spin.

> 
> On Mon, Mar 10, 2025 at 10:23:16AM -0700, SeongJae Park wrote:
> > Update madvise_dontneed_single_vma() and madvise_free_single_vma()
> > functions so that the caller can pass an mmu_gather object that should
> > be initialized and will be finished outside, for batched tlb flushes.
> > Also modify their internal code to support such usage by skipping the
> > initialization and finishing of self-allocated mmu_gather object if it
> > received a valid mmu_gather object.
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/internal.h |  3 +++
> >  mm/madvise.c  | 37 +++++++++++++++++++++++++------------
> >  mm/memory.c   | 16 +++++++++++++---
> >  3 files changed, 41 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 0caa64dc2cb7..ce7fb2383f65 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -438,6 +438,9 @@ void unmap_page_range(struct mmu_gather *tlb,
> >  			     struct vm_area_struct *vma,
> >  			     unsigned long addr, unsigned long end,
> >  			     struct zap_details *details);
> > +void unmap_vma_single(struct mmu_gather *tlb, struct vm_area_struct *vma,
> > +		      unsigned long addr, unsigned long size,
> > +		      struct zap_details *details);
> >  int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
> >  			   gfp_t gfp);
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index ba2a78795207..d7ea71c6422c 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -794,12 +794,19 @@ static const struct mm_walk_ops madvise_free_walk_ops = {
> >  	.walk_lock		= PGWALK_RDLOCK,
> >  };
> >
> > -static int madvise_free_single_vma(struct vm_area_struct *vma,
> > -			unsigned long start_addr, unsigned long end_addr)
> > +static int madvise_free_single_vma(
> > +		struct mmu_gather *caller_tlb, struct vm_area_struct *vma,
> 
> I find this interface horrible, and super confusing. It's not clear at all
> what's going on here.
> 
> Why not use your new helper struct to add a field you can thread through
> here?

I will do so in the next spin.

> 
> > +		unsigned long start_addr, unsigned long end_addr)
> >  {
> >  	struct mm_struct *mm = vma->vm_mm;
> >  	struct mmu_notifier_range range;
> > -	struct mmu_gather tlb;
> > +	struct mmu_gather self_tlb;
> > +	struct mmu_gather *tlb;
> > +
> > +	if (caller_tlb)
> > +		tlb = caller_tlb;
> > +	else
> > +		tlb = &self_tlb;
> >
> >  	/* MADV_FREE works for only anon vma at the moment */
> >  	if (!vma_is_anonymous(vma))
> > @@ -815,16 +822,18 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
> >  				range.start, range.end);
> >
> >  	lru_add_drain();
> > -	tlb_gather_mmu(&tlb, mm);
> > +	if (!caller_tlb)
> > +		tlb_gather_mmu(tlb, mm);
> 
> Yeah really don't like this.
> 
> Ideally we'd abstract the mmu_gather struct to the helper struct (which I
> see you do in a subsequent patch anyway) would be ideal if you could find a
> way to make that work.
> 
> But if not, then:
> 
> if (behavior->batched_tlb)
> 	tlb_gather_mmu(&tlb, mm);
> 
> etc. etc.
> 
> Would work better.

Agreed.

> 
> >  	update_hiwater_rss(mm);
> >
> >  	mmu_notifier_invalidate_range_start(&range);
> > -	tlb_start_vma(&tlb, vma);
> > +	tlb_start_vma(tlb, vma);
> 
> Also not a fan of making tlb refer to a pointer now when before it
> didn't... I mean that's more of a nit and maybe unavoidable, but still!
> 
> I mean yeah ok this is probably unavoidable, ignore.

Yeah... I also find no good way to make this very cleaner without the followup
cleanup for now.

> 
> >  	walk_page_range(vma->vm_mm, range.start, range.end,
> > -			&madvise_free_walk_ops, &tlb);
> > -	tlb_end_vma(&tlb, vma);
> > +			&madvise_free_walk_ops, tlb);
> > +	tlb_end_vma(tlb, vma);
> >  	mmu_notifier_invalidate_range_end(&range);
> > -	tlb_finish_mmu(&tlb);
> > +	if (!caller_tlb)
> > +		tlb_finish_mmu(tlb);
> >
> >  	return 0;
> >  }
> > @@ -848,7 +857,8 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
> >   * An interface that causes the system to free clean pages and flush
> >   * dirty pages is already available as msync(MS_INVALIDATE).
> >   */
> > -static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
> > +static long madvise_dontneed_single_vma(struct mmu_gather *tlb,
> > +					struct vm_area_struct *vma,
> >  					unsigned long start, unsigned long end)
> >  {
> >  	struct zap_details details = {
> > @@ -856,7 +866,10 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
> >  		.even_cows = true,
> >  	};
> >
> > -	zap_page_range_single(vma, start, end - start, &details);
> > +	if (!tlb)
> > +		zap_page_range_single(vma, start, end - start, &details);
> 
> Please don't put the negation case first, it's confusing. Swap them!

Ok, I will do so.

> 
> 
> > +	else
> > +		unmap_vma_single(tlb, vma, start, end - start, &details);
> >  	return 0;
> >  }
> >
> > @@ -951,9 +964,9 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> >  	}
> >
> >  	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
> > -		return madvise_dontneed_single_vma(vma, start, end);
> > +		return madvise_dontneed_single_vma(NULL, vma, start, end);
> >  	else if (behavior == MADV_FREE)
> > -		return madvise_free_single_vma(vma, start, end);
> > +		return madvise_free_single_vma(NULL, vma, start, end);
> 
> Not to labour the point, but this is also horrid, passing a mystery NULL
> parameter first...

Agreed again.  I will just pass the madvise_behavior struct in the next spin.

> 
> >  	else
> >  		return -EINVAL;
> >  }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 88c478e2ed1a..3256b9713cbd 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1995,9 +1995,19 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> >  	mmu_notifier_invalidate_range_end(&range);
> >  }
> >
> > -static void unmap_vma_single(struct mmu_gather *tlb,
> > -		struct vm_area_struct *vma, unsigned long address,
> > -		unsigned long size, struct zap_details *details)
> > +/**
> > + * unmap_vma_single - remove user pages in a given range
> > + * @tlb: pointer to the caller's struct mmu_gather
> > + * @vma: vm_area_struct holding the applicable pages
> > + * @address: starting address of the pages
> > + * @size: number of bytes to remove
> > + * @details: details of shared cache invalidation
> > + *
> > + * @tlb shouldn't be NULL.  The range must fit into one VMA.
> 
> Can we add some VM_WARN_ON[_ONCE]()'s for these conditions please?

Nice suggestion, I will do so.

> 
> Thanks for documenting!

Kudos to Shakeel, who suggested this kerneldoc comment :)


Thanks,
SJ

[...]

