Return-Path: <linux-kernel+bounces-531395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5AFA43FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AFBD7A4D86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E01268C6C;
	Tue, 25 Feb 2025 13:00:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8491D203709
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488444; cv=none; b=qpVQYnZvlxB96Irems14RSduLf3nbvbT1ARPKSK7VDxKJcsQ/5mXyWogWqbg2lhUfmygcH3YtW6BmRRxRSUFC8PYTNVjZ399WJsNvHYL+1rDJQQ6aq+elDRlgvlrXtrbLuMTthv+C25S3LfOcQimnVCglU5oIoKNK7r8upVZVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488444; c=relaxed/simple;
	bh=gbblQILdYnGULp8hvJ7cxtzaBr5jOaGjLT9aI8IXaoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcWozsFGsW94vV+aFF6G/k6xG7v3+n1hWLJnRqZpbay80Q2BwpmVQ9d70BBqF7j0T4acwywM+U9INP6P6uG05oCInovM/smlYlwJX6AbQjyhkMhX4t7eaPZ9xTc0MzJblCqSJ0oEnN9iNZN+GikL4rEokujORmWZuB+Zvln3e90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36F4A152B;
	Tue, 25 Feb 2025 05:00:59 -0800 (PST)
Received: from [10.1.27.154] (unknown [10.1.27.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 001043F5A1;
	Tue, 25 Feb 2025 05:00:41 -0800 (PST)
Message-ID: <9e1721a1-54a4-4007-a0f5-d651f5f21ae2@arm.com>
Date: Tue, 25 Feb 2025 13:00:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Explicit cast conversions to correct data type
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250219035646.536707-1-anshuman.khandual@arm.com>
 <Z724Q1ofM1GvKquV@J2N7QTR9R3>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z724Q1ofM1GvKquV@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/02/2025 12:32, Mark Rutland wrote:
> On Wed, Feb 19, 2025 at 09:26:46AM +0530, Anshuman Khandual wrote:
>> From: Ryan Roberts <ryan.roberts@arm.com>
>>
>> When CONFIG_ARM64_PA_BITS_52 is enabled, page table helpers __pte_to_phys()
>> and __phys_to_pte_val() are functions which return phys_addr_t and pteval_t
>> respectively as expected. But otherwise without this config being enabled,
>> they are defined as macros and their return types are implicit.
>>
>> Until now this has worked out correctly as both pte_t and phys_addr_t data
>> types have been 64 bits. But with the introduction of 128 bit page tables,
>> pte_t becomes 128 bits. Hence this ends up with incorrect widths after the
>> conversions, which leads to compiler warnings.
> 
> Does 128-bit page table not imply 52-bit PAs?

Not to my knowledge. For now the prototype code base is explicitly sticking to
48-bit PA and 44-bit VA (for initial simplicitly because that's the limit for 4
levels).

> 
>> Fix the warnings by explicitly casting to the correct type after doing the
>> conversion.
> 
> I think it would be simpler and clearer if we replaced the macros with
> functions, such that __pte_to_phys() and __phys_to_pte_val() are
> *always* functions.

Yeah, agreed. This was initially just a hack I did to get things working.

> 
> That way it's easier to compar the CONFIG_ARM64_PA_BITS_52=y and
> CONFIG_ARM64_PA_BITS_52=n versions, and the types are always explciit
> for inputs and outputs, so there'd be less room for error and the
> compiler can warn us of type safety issues in any configuration.
> 
> That and we can delete the comment block immediately above at the same
> time.
> 
> Mark.
> 
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This patch applies on v6.14-rc3
>>
>>  arch/arm64/include/asm/pgtable.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 0b2a2ad1b9e8..1da2421c9a15 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -84,8 +84,8 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>  	return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PHYS_TO_PTE_ADDR_MASK;
>>  }
>>  #else
>> -#define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_LOW)
>> -#define __phys_to_pte_val(phys)	(phys)
>> +#define __pte_to_phys(pte)	((phys_addr_t)(pte_val(pte) & PTE_ADDR_LOW))
>> +#define __phys_to_pte_val(phys)	((pteval_t)(phys))
>>  #endif
>>  
>>  #define pte_pfn(pte)		(__pte_to_phys(pte) >> PAGE_SHIFT)
>> -- 
>> 2.25.1
>>
>>


