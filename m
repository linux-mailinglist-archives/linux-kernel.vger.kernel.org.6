Return-Path: <linux-kernel+bounces-538827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D477CA49D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958901895055
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4125D7DA95;
	Fri, 28 Feb 2025 15:32:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285944A07
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756760; cv=none; b=qI8iyTRozIuF1Q/5KiUz7reZkSn82oklCMkKEeLhJGXWjLq74C2g028rUdIwMw8QzWO+k7NIyqYNWVR5uu9lGFR0aFS0HLYIFnvJLMXX4Vbt5mQO00Ljs5K7Yu4Oh0xRqa43QT900oUSzs0DncbEdGfw07JE/Y+g0HajcaUE1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756760; c=relaxed/simple;
	bh=qVmyXvzIJJsl8HgB675jC4uABINWt4XEGa0kFziWnhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lk/bkYitpLP1UvsBZZRw465ubhirrwnSJAGabnwcZdUzj4v3tSFbB8nIrxX5VxRRSj6nPmcJop+Zurn2+Z27WMJ92B1NerVg84sYtcmqmR7AEM9Peyz38HVQjU2btAbiKEX+aMp2MHVuAv6Xm8tRd5OsWtECIvAt/cM7ADcLnkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 908311515;
	Fri, 28 Feb 2025 07:32:52 -0800 (PST)
Received: from [10.57.85.134] (unknown [10.57.85.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E1173F5A1;
	Fri, 28 Feb 2025 07:32:35 -0800 (PST)
Message-ID: <aa71c6ed-8ff2-4b52-b8f7-49147c7769ba@arm.com>
Date: Fri, 28 Feb 2025 15:32:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/8] arm64/mm: Drop PXD_TABLE_BIT
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250221044227.1145393-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250221044227.1145393-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2025 04:42, Anshuman Khandual wrote:
> Remove the PXX_TABLE_BIT definitions and instead rely on PXX_TYPE_MASK,
> PXX_TYPE_SECT and PXX_TYPE_TABLE. The latter versions are more abstract
> and also include the PTE_VALID bit.
> 
> This abstraction is valuable for the impending D128 page table support,
> which doesn't have a single page table bit to determine table vs block.
> Instead it has the skip level (SKL) field, where it will consider 0 to
> mean table and any other value to mean a block entry. So PXX_TABLE_BIT
> therefore doesn't fit into the D128 model well, but the type fields do.

All the patches look logically correct to me and I agree with the intention of
removing PXX_TABLE_BIT. But personally I'd prefer to see a single patch that
just does everything that's required to remove PXX_TABLE_BIT. And then a second
patch for the pud_bad() fix/improvement (currently patch 6) which is orthogonal
to the removal of PXX_TABLE_BIT.

That would make it much easier to review IMHO, and would also allow for writing
a single commit log which provides the justification for the change. I find the
current set of 7 commit logs to not be hugely helpful.

But I wrote the original patches and wrote them as I'm suggesting, so I would
say that :)

I'm guessing I shouldn't provide a Reviewed-By here, given I wrote the code
originally...

Thanks,
Ryan


> 
> This series applies on v6.14-rc3.
> 
> Changes in V2:
> 
> - Changed pmd_mkhuge() and pud_mkhuge() implementation
> - Changed pud_bad() implementation with an additional patch
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20241005123824.1366397-1-anshuman.khandual@arm.com/
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: James Morse <james.morse@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: kvmarm@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (6):
>   KVM: arm64: ptdump: Test PMD_TYPE_MASK for block mapping
>   arm64/ptdump: Test PMD_TYPE_MASK for block mapping
>   arm64/mm: Clear PXX_TYPE_MASK in mk_[pmd|pud]_sect_prot()
>   arm64/mm: Clear PXX_TYPE_MASK and set PXD_TYPE_SECT in [pmd|pud]_mkhuge()
>   arm64/mm: Check PXD_TYPE_TABLE in [p4d|pgd]_bad()
>   arm64/mm: Drop PXD_TABLE_BIT
> 
> Ryan Roberts (2):
>   arm64/mm: Check PUD_TYPE_TABLE in pud_bad()
>   arm64/mm: Check pmd_table() in pmd_trans_huge()
> 
>  arch/arm64/include/asm/pgtable-hwdef.h |  5 --
>  arch/arm64/include/asm/pgtable.h       | 65 ++++++++++++++++++--------
>  arch/arm64/kvm/ptdump.c                |  4 +-
>  arch/arm64/mm/ptdump.c                 |  4 +-
>  4 files changed, 50 insertions(+), 28 deletions(-)
> 


