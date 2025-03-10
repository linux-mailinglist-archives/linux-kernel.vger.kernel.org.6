Return-Path: <linux-kernel+bounces-553593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF6EA58C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C49188AD19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 06:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9051CAA60;
	Mon, 10 Mar 2025 06:38:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571CB1B87F0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741588724; cv=none; b=mmwMjQwLcvEoRj0DmbtjAmT4aq4d/pdTwJHw8tNvnzzqZuT/GjGFN6ZW4SQQguuY9PYWRkFWbBqUQ4eQI44QN426M4ypp85NWKteq1eFqiS4sETbGsQ7eJI2WRzSbVgVIEo7mGsxIZfACXmurhyH1pJT/RDMprbOrV9umk35kIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741588724; c=relaxed/simple;
	bh=GcUQaczN2hMHgbVRjK+6slnDE3ztZsb62TwjLId28Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnBkTeDUACl731anS+9AEuodxkWm6Rz1I7/DH0qzFcIOvdN5yApWNUJgrguf+T0hNhFmItDYT7wg7iZO3w3Ih1w3ZGWd9s/19Vj93rN60k8Hv8fomKqJS1bLNiI++bTVgfAotmqUex81D8BQdW4nzl6a7HHyFHqb/QX9QeBa4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A3DC15A1;
	Sun,  9 Mar 2025 23:38:52 -0700 (PDT)
Received: from [10.163.42.69] (unknown [10.163.42.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4AF43F673;
	Sun,  9 Mar 2025 23:38:36 -0700 (PDT)
Message-ID: <aae26951-3409-476c-b31d-1738cafe730a@arm.com>
Date: Mon, 10 Mar 2025 12:08:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/8] arm64/mm: Drop PXD_TABLE_BIT
To: arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250221044227.1145393-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250221044227.1145393-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 10:12, Anshuman Khandual wrote:
> Remove the PXX_TABLE_BIT definitions and instead rely on PXX_TYPE_MASK,
> PXX_TYPE_SECT and PXX_TYPE_TABLE. The latter versions are more abstract
> and also include the PTE_VALID bit.
> 
> This abstraction is valuable for the impending D128 page table support,
> which doesn't have a single page table bit to determine table vs block.
> Instead it has the skip level (SKL) field, where it will consider 0 to
> mean table and any other value to mean a block entry. So PXX_TABLE_BIT
> therefore doesn't fit into the D128 model well, but the type fields do.
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

Gentle ping again. Does this series look okay or is there any objection ?

