Return-Path: <linux-kernel+bounces-171506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506748BE53F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990901F228DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D7A15F300;
	Tue,  7 May 2024 14:08:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0815F3EB
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090908; cv=none; b=nPc9V/LgIW9JOrho1cZWlMreaHQle5zERvwPcIo0sdUMIXzhV9L7AAkOVzh/WDkjDIwJgfpE7Cwg6DKF6eAvjYgHeqt9mBidJbUfQg/l25lOb4GE1+Scf2bxG8kOHhi+COGWMykEQl0GIDrRr9+Pnz9Rs1Y0D5ugJZWr+LgxPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090908; c=relaxed/simple;
	bh=qQA0lBhknPgxY5yNr+kP9/ueusxyuj3bO9LH0Oa9qcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xo/DE1qXUxHqQpoT0wDUCRpKsRIOrtFl9fkbBjVH4LR6oZ0wIJS5M8j6/NJT3SgEjkeXxbYEAnYifMamPVQLSBZOv9BV/p8y40ojcnyb/PHKZbCAYzUjE6mwuyOhwQ+f0CH/Pj9jJEy6dLxJc7JptdOGHpU5aU2cm3r9N76sFDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FD1C3277B;
	Tue,  7 May 2024 14:08:25 +0000 (UTC)
Date: Tue, 7 May 2024 15:08:23 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Peter Xu <peterx@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] arm64/mm: generalize PMD_PRESENT_INVALID for all
 levels
Message-ID: <Zjo114ph-vAN-yPY@arm.com>
References: <20240503144604.151095-1-ryan.roberts@arm.com>
 <20240503144604.151095-2-ryan.roberts@arm.com>
 <d8373b6d-ec81-4010-8e01-cfc7d7e219a7@redhat.com>
 <4b63f70c-8a48-4290-90c7-25627de0d52d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b63f70c-8a48-4290-90c7-25627de0d52d@arm.com>

On Tue, May 07, 2024 at 01:34:36PM +0100, Ryan Roberts wrote:
> On 07/05/2024 12:38, David Hildenbrand wrote:
> > On 03.05.24 16:45, Ryan Roberts wrote:
> >> --- a/arch/arm64/include/asm/pgtable-prot.h
> >> +++ b/arch/arm64/include/asm/pgtable-prot.h
> >> @@ -21,11 +21,11 @@
> >>   #define PTE_PROT_NONE        (_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
> >>     /*
> >> - * This bit indicates that the entry is present i.e. pmd_page()
> >> - * still points to a valid huge page in memory even if the pmd
> >> - * has been invalidated.
> >> + * PTE_PRESENT_INVALID=1 & PTE_VALID=0 indicates that the pte's fields should be
> >> + * interpreted according to the HW layout by SW but any attempted HW access to
> >> + * the address will result in a fault. pte_present() returns true.
> >>    */
> >> -#define PMD_PRESENT_INVALID    (_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
> >> +#define PTE_PRESENT_INVALID    (_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */
> > 
> > Ah, so PTE_VALID == PMD_SECT_VALID. Would that also be a reasonable
> > generalization independent of this? (or do we keep it as is because it's a HW def?)
> 
> To be honest, I'm not sure of the history, but some things are implemented as
> wrappers around pte functions and others are implemented specifically for
> pmd/pud/etc.

There's also a bit of historical arm32 code moved over to arm64 when we
did the port. On classic arm32 page tables, the ptes and pmds were
pretty different.

> On arm64, block mappings (all levels except last level) have the same HW format
> as page mappings (last level) except that bit 1 must be 0 for block and 1 for
> page. And with this series, SW/non-present bits are all matching too. So my vote
> would be to harmonise toward a single implementation in future (modulus the bit
> 1 problem), which would include getting rid of things like PMD_SECT_VALID.

For PMD_SECT_VALID vs PTE_VALID, it's fine to only use the latter. The
PMD_TABLE_BIT, however, only makes sense for p*d levels. I think we can
get rid of all the PMD_SECT_* macros, just keeping PMD_TYPE_* and the
table bit.

For a bit of architecture history, the reason the pmd block entries have
bit 1 clear while the ptes have it set is to allow recursive mappings
where an entry in the pgd points to the pgd itself. The hardware page
table walk would end on the pmd entry when accessed at the specific VA,
giving quick access to the pte. The downside is wasting a bit of the VA
space.

-- 
Catalin

