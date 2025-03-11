Return-Path: <linux-kernel+bounces-556950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2868BA5D14D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B6D189CD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CA9224AEB;
	Tue, 11 Mar 2025 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BadLIGob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A4E1E9B0C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726881; cv=none; b=oQ8PCeHhzqKjuRyyBAXgzoR9j6pKuzo9jbcJLt40zTzggRBj2jEsfbepLj8dhWHfH+vJO5N6YpXkNN9W2qWtQ9M4V6XQtFj/UXmw2WjkkFR54hMINGCOZrV8y0U+GBYhkqWEUg3XuCML8Gt8lVlq5PEYN/3O58GSyHExq/0tqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726881; c=relaxed/simple;
	bh=+NTNS0fhln7wAifm0+ONt7nOeyWyL6zedv9NQ16rf7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afGCV9bQDJ3zWJnXjdK/Xb7spq8CtAT71o/RxqUqNIMEEQnFDLXMgdcexVDlPrnp3nmeCiW81IVFpINVx6Gd1eccJh4Z40yWCFPu1/ramXj9a7lBDuCdb23jAehBzsqH1w6teJIDXW84gf8dFI37qTwbgktQ6SqWYlIYmfGzuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BadLIGob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438D0C4CEE9;
	Tue, 11 Mar 2025 21:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741726880;
	bh=+NTNS0fhln7wAifm0+ONt7nOeyWyL6zedv9NQ16rf7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BadLIGob3p2Avw2SasIiOnPmJSmwhz0lacvAgjfidbEk8OEOtXASvEluZ/cqnq5mT
	 GvcwXgfk33hNWLXtVTEKA/GDMBxBCoCT/EuhqD4yan2WD0SFKQ9qa7pVENJiQgKHxd
	 uI83wfED6XDpnbvPAJHy/0Tr+FhXuSlrB7VI297Eo2rlFMbbEIysx+7wF2WDXwkkdR
	 /+JxI+bDN2wwlIKmDecB3rpwXEVR5a1V/mLpcR9yXQgIC3V7xv1kSugcSKSkjt9uqg
	 kWtWvil3XEUjirL97/X54Ekw76Aolae3VKw562TMpGf1ujkhnY+u9gv2XhO2iyMB7V
	 QHQXd8RezjEwQ==
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
	linux-mm@kvack.org,
	Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 8/9] mm/madvise: batch tlb flushes for [process_]madvise(MADV_{DONTNEED[_LOCKED],FREE})
Date: Tue, 11 Mar 2025 14:01:18 -0700
Message-Id: <20250311210118.85501-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <d4ac2770-7ef2-4522-beba-97ba16a2f7ac@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 13:59:10 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> +cc Rik on this, as he's working on TLB flush-related stuff. Maybe worth
> cc-ing him on series respins too? Unless Rik objects of course :P
> 
> Again, nit, but your subject line/first line of commit message is
> definitely too long here! :)

I will reduce.

> 
> On Mon, Mar 10, 2025 at 10:23:17AM -0700, SeongJae Park wrote:
> > MADV_DONTNEED[_LOCKED] and MADV_FREE internal logics for
> > [process_]madvise() can be invoked with batched tlb flushes.  Update
> > vector_madvise() and do_madvise(), which are called for the two system
> > calls  respectively, to use those in the efficient way.  Initialize an
> > mmu_gather object before starting the internal works, and flush the
> > gathered tlb entries at once after all the internal works are done.
> 
> super nit but logics -> logic and works -> work :)
> 
> I think we need more here as to why you're restricting to
> MADV_DONTNEED_LOCKED and MADV_FREE. I see pageout initialises a tlb gather
> object, so does cold, etc. etc.?

Good point.  I'm just trying to start from small things.  I will clarify this
on the next spin.

> 
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> This is really nice, I love how we're able to evolve this towards batching
> flushes.
> 
> Overall though I'd like you to address some of the concerns here before
> giving tags... :)

Thank you for nice comments! :)

> 
> > ---
> >  mm/madvise.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 47 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index d7ea71c6422c..d5f4ce3041a4 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -905,6 +905,7 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
> >
> >  struct madvise_behavior {
> >  	int behavior;
> > +	struct mmu_gather *tlb;
> >  };
> 
> Aha! Good :)
> 
> I see in 9/9 you actually pull the caller_tlb stuff out, I still feel like
> we should be threading this state through further, if possible, rather than
> passing in behavior->tlb as a parameter.

Yes, I will do so.

> 
> But this is nitty I suppose!
> 
> >
> >  static long madvise_dontneed_free(struct vm_area_struct *vma,
> > @@ -964,9 +965,11 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> >  	}
> >
> >  	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
> > -		return madvise_dontneed_single_vma(NULL, vma, start, end);
> > +		return madvise_dontneed_single_vma(
> > +				madv_behavior->tlb, vma, start, end);
> >  	else if (behavior == MADV_FREE)
> > -		return madvise_free_single_vma(NULL, vma, start, end);
> > +		return madvise_free_single_vma(
> > +				madv_behavior->tlb, vma, start, end);
> 
> Yeah as I said above be nice to just pass madv_behavior, makes things more
> flexible to pass a pointer to the helper struct through, as you can

Yes.

> 
> >  	else
> >  		return -EINVAL;
> >  }
> > @@ -1639,6 +1642,32 @@ static void madvise_unlock(struct mm_struct *mm, int behavior)
> >  		mmap_read_unlock(mm);
> >  }
> >
> > +static bool madvise_batch_tlb_flush(int behavior)
> > +{
> > +	switch (behavior) {
> > +	case MADV_DONTNEED:
> > +	case MADV_DONTNEED_LOCKED:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> 
> I kind of hate this madvise_ prefix stuff, like we're in mm/madvise.c, it's
> pretty obvious static functions are related to madvise :) but this is a
> pre-existing thing, not your fault, and it's actually right to maintain
> consistency with this.
> 
> So this is purely a whine that can be >/dev/null.

Thank you for understanding :)

> 
> > +
> > +static void madvise_init_tlb(struct madvise_behavior *madv_behavior,
> > +		struct mm_struct *mm)
> > +{
> > +	if (!madvise_batch_tlb_flush(madv_behavior->behavior))
> > +		return;
> > +	tlb_gather_mmu(madv_behavior->tlb, mm);
> > +}
> > +
> > +static void madvise_finish_tlb(struct madvise_behavior *madv_behavior)
> > +{
> > +	if (!madvise_batch_tlb_flush(madv_behavior->behavior))
> > +		return;
> > +	tlb_finish_mmu(madv_behavior->tlb);
> > +}
> > +
> 
> Nitty, but for both of these, usually I like the guard clause pattern, but
> since it's such a trivial thing I think it reads better as:
> 
> 	if (madvise_batch_tlb_flush(madv_behavior->behavior))
> 		tlb_gather_mmu(madv_behavior->tlb, mm);
> 
> and:
> 
> 	if (madvise_batch_tlb_flush(madv_behavior->behavior))
> 		tlb_finish_mmu(madv_behavior->tlb);

Totally agreed, thank you for catching this.


Thanks,
SJ

[...]

