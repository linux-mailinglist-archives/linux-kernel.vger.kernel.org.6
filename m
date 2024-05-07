Return-Path: <linux-kernel+bounces-171653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287DC8BE6EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12B028482B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E87216130D;
	Tue,  7 May 2024 15:06:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EAF15FCF0
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094393; cv=none; b=jL/bvm+XIkKjAQ1IPSAeDQ0aN96mPNMpJ8ZGZyoTGCLXtLONDeBcv+Mgo0qly99i3h4sQ1ohI5DS1qGMv+QOKYt66OCydf6lgWbiag56ECTA4MzjiV3n80splQVSE5tmjhWu5e0eFffNDKrcp3fVyZLJhFEvHcDJXkc323ppnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094393; c=relaxed/simple;
	bh=kx8ryq2Q9jWubxTgl2bS/1e6iya/F4CelrT21M8vm6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHpig8lrwTF7+eJVsixOCAimDkYpqodelBKuKwKGryl8m2Lrwpiw3blFQ+8wyCDs6V2BrIsB0dj5o5FMOj8ve6RPa98bagwsMRs9CEACGRScq5jkip3VHv4ozYM5D38FsWJO3CkiWQ/2AkrV664M7vWSq56jLfURmk8V3oaWPJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFA861063;
	Tue,  7 May 2024 08:06:55 -0700 (PDT)
Received: from [10.1.34.181] (XHFQ2J9959.cambridge.arm.com [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AE113F587;
	Tue,  7 May 2024 08:06:28 -0700 (PDT)
Message-ID: <e60295b6-caa1-40a3-bc37-ecae00902565@arm.com>
Date: Tue, 7 May 2024 16:06:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] arm64/mm: generalize PMD_PRESENT_INVALID for all
 levels
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240503144604.151095-1-ryan.roberts@arm.com>
 <20240503144604.151095-2-ryan.roberts@arm.com>
 <d8373b6d-ec81-4010-8e01-cfc7d7e219a7@redhat.com>
 <4b63f70c-8a48-4290-90c7-25627de0d52d@arm.com> <Zjo114ph-vAN-yPY@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zjo114ph-vAN-yPY@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/05/2024 15:08, Catalin Marinas wrote:
> On Tue, May 07, 2024 at 01:34:36PM +0100, Ryan Roberts wrote:
>> On 07/05/2024 12:38, David Hildenbrand wrote:
>>> On 03.05.24 16:45, Ryan Roberts wrote:
>>>> --- a/arch/arm64/include/asm/pgtable-prot.h
>>>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>>>> @@ -21,11 +21,11 @@
>>>> ï¿½ #define PTE_PROT_NONEï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ (_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>>>> ï¿½ ï¿½ /*
>>>> - * This bit indicates that the entry is present i.e. pmd_page()
>>>> - * still points to a valid huge page in memory even if the pmd
>>>> - * has been invalidated.
>>>> + * PTE_PRESENT_INVALID=1 & PTE_VALID=0 indicates that the pte's fields should be
>>>> + * interpreted according to the HW layout by SW but any attempted HW access to
>>>> + * the address will result in a fault. pte_present() returns true.
>>>> ï¿½ï¿½ */
>>>> -#define PMD_PRESENT_INVALIDï¿½ï¿½ï¿½ (_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
>>>> +#define PTE_PRESENT_INVALIDï¿½ï¿½ï¿½ (_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */
>>>
>>> Ah, so PTE_VALID == PMD_SECT_VALID. Would that also be a reasonable
>>> generalization independent of this? (or do we keep it as is because it's a HW def?)
>>
>> To be honest, I'm not sure of the history, but some things are implemented as
>> wrappers around pte functions and others are implemented specifically for
>> pmd/pud/etc.
> 
> There's also a bit of historical arm32 code moved over to arm64 when we
> did the port. On classic arm32 page tables, the ptes and pmds were
> pretty different.>
>> On arm64, block mappings (all levels except last level) have the same HW format
>> as page mappings (last level) except that bit 1 must be 0 for block and 1 for
>> page. And with this series, SW/non-present bits are all matching too. So my vote
>> would be to harmonise toward a single implementation in future (modulus the bit
>> 1 problem), which would include getting rid of things like PMD_SECT_VALID.
> 
> For PMD_SECT_VALID vs PTE_VALID, it's fine to only use the latter. The
> PMD_TABLE_BIT, however, only makes sense for p*d levels. I think we can
> get rid of all the PMD_SECT_* macros, just keeping PMD_TYPE_* and the
> table bit.

OK, perhaps I'll get around to sending a patch at some point.

> 
> For a bit of architecture history, the reason the pmd block entries have
> bit 1 clear while the ptes have it set is to allow recursive mappings
> where an entry in the pgd points to the pgd itself. The hardware page
> table walk would end on the pmd entry when accessed at the specific VA,
> giving quick access to the pte. The downside is wasting a bit of the VA
> space.

Ahh ok. I had to think about that for a while, but makes sense. Thanks!

