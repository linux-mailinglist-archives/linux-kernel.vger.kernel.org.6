Return-Path: <linux-kernel+bounces-271377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC6944D61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5523A1C234AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE7A1A487C;
	Thu,  1 Aug 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNugnmQ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC071A256A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519848; cv=none; b=nHMlmhaTVzLFqO0Q4SvjY1BsdlczV/jTHmooBTZQO8R0nWiCFwBUjg+rWaY7zyp+w/pPl8mahB2BExxn1j+3vYychssihqUh1daOxuzAsfMbWsu9gFqqQzrBS7CRu6LRlvVLrvIvzjMpcAl4ffYw3kTqIDUhens3cBrCB/HwI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519848; c=relaxed/simple;
	bh=RfncJUAECWo6xOr/QiiTb2O6yYVrKFtunr2zn7xLUR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSRx96CUB+wbs/kiltAf+cSvU7Nk9JxbJZVOxe92w/yTi0pNucMLhsc/i/5gfGLPldKRQm+E3dsolDHCTabGjuTMILXNxtz32Ri1JcxSv8lQQAqD9SAKcH78MoZ29jkVjczqXa8FlsoO2AeA5vZRQhgUQ+aPYLdU7hSCnysXAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNugnmQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080FBC4AF0A;
	Thu,  1 Aug 2024 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722519847;
	bh=RfncJUAECWo6xOr/QiiTb2O6yYVrKFtunr2zn7xLUR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNugnmQ8GMePBgVnjTn6Tj9c4WZsv3HiYS7SXlFELmmUxo8GHCiePHWXriBIxpsHm
	 PFY+Qoagxeg9A6AJ1oEcZaJMILdrTNuNeOrh2stASuaPz2Dg5LVR7doW7x8o553Q2X
	 AiI06id5IWdhk/PKW8+fkW6MD0KSc/MpawCDVxtuR2H+9mmy8tJSCg8k+ZVlfaLfj0
	 cxu2ANysbEtQ2r+l1TSwvFqim7cLZQzWbaiEp+32plzi5gKvWYOORhp73d9II9VcQi
	 mKItsep07i1TIZyKWneAWFY1G+VbaBuWCz210B/DlUUdFLU9V7y60I1PHve+81mZSC
	 2Np6G8Btc7e2g==
Date: Thu, 1 Aug 2024 14:43:59 +0100
From: Will Deacon <will@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
	willy@infradead.org, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
	vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
	osalvador@suse.de, baolin.wang@linux.alibaba.com,
	dave.hansen@linux.intel.com, baohua@kernel.org, ioworker0@gmail.com,
	gshan@redhat.com, mark.rutland@arm.com,
	kirill.shutemov@linux.intel.com, hughd@google.com,
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
	peterx@redhat.com, broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: Race condition observed between page migration and page fault
 handling on arm64 machines
Message-ID: <20240801134358.GB4794@willie-the-truck>
References: <20240801081657.1386743-1-dev.jain@arm.com>
 <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
 <bbe411f2-4c68-4f92-af8c-da184669dca8@arm.com>
 <a6a38ad5-c754-44ad-a64b-f9ea5b764291@redhat.com>
 <92df0ee1-d3c9-41e2-834c-284127ae2c4c@arm.com>
 <19902a48-c59b-4e3b-afc5-e792506c2fd6@redhat.com>
 <6486a2b1-45ef-44b6-bd84-d402fc121373@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6486a2b1-45ef-44b6-bd84-d402fc121373@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 01, 2024 at 03:26:57PM +0200, David Hildenbrand wrote:
> On 01.08.24 15:13, David Hildenbrand wrote:
> > > > > To dampen the tradeoff, we could do this in shmem_fault() instead? But
> > > > > then, this would mean that we do this in all
> > > > > 
> > > > > kinds of vma->vm_ops->fault, only when we discover another reference
> > > > > count race condition :) Doing this in do_fault()
> > > > > 
> > > > > should solve this once and for all. In fact, do_pte_missing() may call
> > > > > do_anonymous_page() or do_fault(), and I just
> > > > > 
> > > > > noticed that the former already checks this using vmf_pte_changed().
> > > > 
> > > > What I am still missing is why this is (a) arm64 only; and (b) if this
> > > > is something we should really worry about. There are other reasons
> > > > (e.g., speculative references) why migration could temporarily fail,
> > > > does it happen that often that it is really something we have to worry
> > > > about?
> > > 
> > > 
> > > (a) See discussion at [1]; I guess it passes on x86, which is quite
> > > strange since the race is clearly arch-independent.
> > 
> > Yes, I think this is what we have to understand. Is the race simply less
> > likely to trigger on x86?
> > 
> > I would assume that it would trigger on any arch.
> > 
> > I just ran it on a x86 VM with 2 NUMA nodes and it also seems to work here.
> > 
> > Is this maybe related to deferred flushing? Such that the other CPU will
> > by accident just observe the !pte_none a little less likely?
> > 
> > But arm64 also usually defers flushes, right? At least unless
> > ARM64_WORKAROUND_REPEAT_TLBI is around. With that we never do deferred
> > flushes.
> 
> Bingo!
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index e51ed44f8b53..ce94b810586b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -718,10 +718,7 @@ static void set_tlb_ubc_flush_pending(struct mm_struct
> *mm, pte_t pteval,
>   */
>  static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>  {
> -       if (!(flags & TTU_BATCH_FLUSH))
> -               return false;
> -
> -       return arch_tlbbatch_should_defer(mm);
> +       return false;
>  }
> 
> 
> On x86:
> 
> # ./migration
> TAP version 13
> 1..1
> # Starting 1 tests from 1 test cases.
> #  RUN           migration.shared_anon ...
> Didn't migrate 1 pages
> # migration.c:170:shared_anon:Expected migrate(ptr, self->n1, self->n2) (-2)
> == 0 (0)
> # shared_anon: Test terminated by assertion
> #          FAIL  migration.shared_anon
> not ok 1 migration.shared_anon
> 
> 
> It fails all of the time!

Nice work! I suppose that makes sense as, with the eager TLB
invalidation, the window between the other CPU faulting and the
migration entry being written is fairly wide.

Not sure about a fix though :/ It feels a bit overkill to add a new
invalid pte encoding just for this.

Will

