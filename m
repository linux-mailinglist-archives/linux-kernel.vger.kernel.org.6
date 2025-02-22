Return-Path: <linux-kernel+bounces-527223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847EAA4089E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14673AFC5D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC3208961;
	Sat, 22 Feb 2025 13:17:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423A881AC8
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740230273; cv=none; b=N01VOgosorIKNkbFAkiFmAW6otq1SZO8GN4gVDzkcB9+SMQPqYgDkuB9qdOiOr8kR2EN428chhCgOkZePhaz1dm+NZFw1PA33JHy3WQcT860JDvgbYFuIfPsBfz8fboYyuQmNLvbD7TR58i2sDylKNwpG4AHHeeH7p+JEe8Zsew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740230273; c=relaxed/simple;
	bh=KUlxt/6vwrgMtCDDxiCmKoEtBqWWLd9nx/4gj92JSzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFm6Sf2wNj4FHNOJmwVPJl3Ikihlh2u5cpR7gpR9mvbo00Os2RdrCNGebLGU/FDTmL/ONJFjIbYZlGEOwU7iwyy/yDT8gH3QwAD5L64iXrTnRYaC1bJ4Sk2SgTrVC4VGdet8+b44It1lC+ZrbxySaRGqItzlfKSzLiYhEyfY+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221E4C4CED1;
	Sat, 22 Feb 2025 13:17:49 +0000 (UTC)
Date: Sat, 22 Feb 2025 13:17:47 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] arm64/mm: Avoid barriers for invalid or
 userspace mappings
Message-ID: <Z7nOe78W4JXFAkMb@arm.com>
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-8-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217140809.1702789-8-ryan.roberts@arm.com>

On Mon, Feb 17, 2025 at 02:07:59PM +0000, Ryan Roberts wrote:
> __set_pte_complete(), set_pmd(), set_pud(), set_p4d() and set_pgd() are
> used to write entries into pgtables. And they issue barriers (currently
> dsb and isb) to ensure that the written values are observed by the table
> walker prior to any program-order-future memory access to the mapped
> location.
> 
> Over the years some of these functions have received optimizations: In
> particular, commit 7f0b1bf04511 ("arm64: Fix barriers used for page
> table modifications") made it so that the barriers were only emitted for
> valid-kernel mappings for set_pte() (now __set_pte_complete()). And
> commit 0795edaf3f1f ("arm64: pgtable: Implement p[mu]d_valid() and check
> in set_p[mu]d()") made it so that set_pmd()/set_pud() only emitted the
> barriers for valid mappings.

The assumption probably was that set_pmd/pud() are called a lot less
often than set_pte() as they cover larger address ranges (whether table
or leaf).

> set_p4d()/set_pgd() continue to emit the barriers unconditionally.

We probably missed them, should have been the same as set_pmd().

> This is all very confusing to the casual observer; surely the rules
> should be invariant to the level? Let's change this so that every level
> consistently emits the barriers only when setting valid, non-user
> entries (both table and leaf).

Also see commit d0b7a302d58a ("Revert "arm64: Remove unnecessary ISBs
from set_{pte,pmd,pud}"") why we added back the ISBs to the pmd/pud
accessors and the last paragraph on why we are ok with the spurious
faults for PTEs.

For user mappings, the translation fault is routed through the usual
path that can handle mapping new entries, so I think we are fine. But
it's worth double-checking Will's comment (unless he only referred to
kernel table entries).

> It seems obvious that if it is ok to elide barriers all but valid kernel
> mappings at pte level, it must also be ok to do this for leaf entries at
> other levels: If setting an entry to invalid, a tlb maintenance
> operation must surely follow to synchronise the TLB and this contains
> the required barriers.

Setting to invalid is fine indeed, handled by the TLB flushing code,
hence the pmd_valid() checks.

> If setting a valid user mapping, the previous
> mapping must have been invalid and there must have been a TLB
> maintenance operation (complete with barriers) to honour
> break-before-make.

That's not entirely true for change_protection() for example or the
fork() path when we make the entries read-only from writeable without
BBM. We could improve these cases as well, I haven't looked in detail.
ptep_modify_prot_commit() via change_pte_range() can defer the barriers
to tlb_end_vma(). Something similar on the copy_present_ptes() path.

> So the worst that can happen is we take an extra
> fault (which will imply the DSB + ISB) and conclude that there is
> nothing to do. These are the arguments for doing this optimization at
> pte level and they also apply to leaf mappings at other levels.

It's worth clarifying Will's comment in the commit I mentioned above.

> For table entries, the same arguments hold: If unsetting a table entry,
> a TLB is required and this will emit the required barriers. If setting a
> table entry, the previous value must have been invalid and the table
> walker must already be able to observe that. Additionally the contents
> of the pgtable being pointed to in the newly set entry must be visible
> before the entry is written and this is enforced via smp_wmb() (dmb) in
> the pgtable allocation functions and in __split_huge_pmd_locked(). But
> this last part could never have been enforced by the barriers in
> set_pXd() because they occur after updating the entry. So ultimately,
> the wost that can happen by eliding these barriers for user table
> entries is an extra fault.
> 
> I observe roughly the same number of page faults (107M) with and without
> this change when compiling the kernel on Apple M2.

That's microarch specific, highly dependent on timing, so you may never
see a difference.

> +static inline bool pmd_valid_not_user(pmd_t pmd)
> +{
> +	/*
> +	 * User-space table entries always have (PXN && !UXN). All other
> +	 * combinations indicate it's a table entry for kernel space.
> +	 * Valid-not-user leaf entries follow the same rules as
> +	 * pte_valid_not_user().
> +	 */
> +	if (pmd_table(pmd))
> +		return !((pmd_val(pmd) & (PMD_TABLE_PXN | PMD_TABLE_UXN)) == PMD_TABLE_PXN);
> +	return pte_valid_not_user(pmd_pte(pmd));
> +}

With the 128-bit format I think we lost the PXN/UXNTable bits, though we
have software bits if we need to. I just wonder whether it's worth the
hassle of skipping some barriers for user non-leaf entries. Did you see
any improvement in practice?

-- 
Catalin

