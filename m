Return-Path: <linux-kernel+bounces-171285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448658BE236
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0035D282D4F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C886D158A22;
	Tue,  7 May 2024 12:34:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAA071B4F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085284; cv=none; b=hd/Hj1Cc06yblQRkNbAX3UYcYjydPb+aLcHfCUYuKak2vmyzlvbc4Uw/Con48RRWuzb7XZbm1/ZMQa52yEhUTPsEvJojHvFtGvMkmgz2BKA0TcSNbwGARXB7MadsC0YcMpLK9MhrmzWQNqzkJ36vq0Z5WI6hHVN5IoIlsvuqRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085284; c=relaxed/simple;
	bh=MuZocPLrDQMWjzglAACdrjEA0TChpt+Y5xKG6olGa54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmBfNKQNWDnqoaqjZuHpbQmOckidlQCnjXLWISR8JDvZglOJjABSUxNquGuWR8y3yxgE1B4ak6kAMNPhVUUN5fQuhOppDpysSRiN3U39zNS4mzDXWuVQ8O6DLv/KDWR274jqGcSuYUaCPqyE494G1yTb5JdmK50tMGXK5sBzEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86BDF1063;
	Tue,  7 May 2024 05:35:05 -0700 (PDT)
Received: from [10.1.34.181] (XHFQ2J9959.cambridge.arm.com [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AB903F793;
	Tue,  7 May 2024 05:34:37 -0700 (PDT)
Message-ID: <4b63f70c-8a48-4290-90c7-25627de0d52d@arm.com>
Date: Tue, 7 May 2024 13:34:36 +0100
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
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240503144604.151095-1-ryan.roberts@arm.com>
 <20240503144604.151095-2-ryan.roberts@arm.com>
 <d8373b6d-ec81-4010-8e01-cfc7d7e219a7@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d8373b6d-ec81-4010-8e01-cfc7d7e219a7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/05/2024 12:38, David Hildenbrand wrote:
> On 03.05.24 16:45, Ryan Roberts wrote:
>> As preparation for the next patch, which frees up the PTE_PROT_NONE
>> present pte and swap pte bit, generalize PMD_PRESENT_INVALID to
>> PTE_PRESENT_INVALID. This will then be used to mark PROT_NONE ptes (and
>> entries at any other level) in the next patch.
>>
>> While we're at it, fix up the swap pte format comment to include
>> PTE_PRESENT_INVALID. This is not new, it just wasn't previously
>> documented.
>>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   arch/arm64/include/asm/pgtable-prot.h |  8 ++++----
>>   arch/arm64/include/asm/pgtable.h      | 21 ++++++++++++---------
>>   2 files changed, 16 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h
>> b/arch/arm64/include/asm/pgtable-prot.h
>> index dd9ee67d1d87..cdbf51eef7a6 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -21,11 +21,11 @@
>>   #define PTE_PROT_NONE        (_AT(pteval_t, 1) << 58) /* only when
>> !PTE_VALID */
>>     /*
>> - * This bit indicates that the entry is present i.e. pmd_page()
>> - * still points to a valid huge page in memory even if the pmd
>> - * has been invalidated.
>> + * PTE_PRESENT_INVALID=1 & PTE_VALID=0 indicates that the pte's fields should be
>> + * interpreted according to the HW layout by SW but any attempted HW access to
>> + * the address will result in a fault. pte_present() returns true.
>>    */
>> -#define PMD_PRESENT_INVALID    (_AT(pteval_t, 1) << 59) /* only when
>> !PMD_SECT_VALID */
>> +#define PTE_PRESENT_INVALID    (_AT(pteval_t, 1) << 59) /* only when
>> !PTE_VALID */
> 
> Ah, so PTE_VALID == PMD_SECT_VALID. Would that also be a reasonable
> generalization independent of this? (or do we keep it as is because it's a HW def?)

To be honest, I'm not sure of the history, but some things are implemented as
wrappers around pte functions and others are implemented specifically for
pmd/pud/etc.

On arm64, block mappings (all levels except last level) have the same HW format
as page mappings (last level) except that bit 1 must be 0 for block and 1 for
page. And with this series, SW/non-present bits are all matching too. So my vote
would be to harmonise toward a single implementation in future (modulus the bit
1 problem), which would include getting rid of things like PMD_SECT_VALID.

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks for all the R-bs!


