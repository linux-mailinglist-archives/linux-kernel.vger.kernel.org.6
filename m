Return-Path: <linux-kernel+bounces-533682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838E0A45D96
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279DE16E938
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012FD218ADF;
	Wed, 26 Feb 2025 11:45:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F411121D3D2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570329; cv=none; b=EJttchaw+K/M4zyGcyKG8S9gCtBNjnj27rikE6m1c09k6CWhSRh5vJG+UGEcMuV4OMuE1FmL57+jLL/ON1DIFL3vNlPvCTnc5zvLPShOE382ke78hBF1C/FRroNtWMaKAoDNE6u0OS51rWgFNsw0avq4fB6WAwzfvwKr6gf0+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570329; c=relaxed/simple;
	bh=0R88SCK6AaON9aBmUcGzT7P1J69Uy3dcE5TQ8ZG87lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvgoW4gPEOtx5zSbWX/qA4KUA0Oc9SZ+ynqrB6BjGHjVKWe/a/SS1h0CRmwUjvJFNdcJszVVRdyJply1hjb+O0d/72bn4gb/1F4fRyHEjr4xdzgyXBJtD86IQ15EEdGQLofegsypklw+jmL36U+uy6/WNF7Dj3Bh8j7wEnuDLgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BA681516;
	Wed, 26 Feb 2025 03:45:43 -0800 (PST)
Received: from [10.163.40.69] (unknown [10.163.40.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 744B83F673;
	Wed, 26 Feb 2025 03:45:25 -0800 (PST)
Message-ID: <fc357e47-a727-4ba3-9019-877ce8bc443f@arm.com>
Date: Wed, 26 Feb 2025 17:15:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Explicit cast conversions to correct data type
To: Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250219035646.536707-1-anshuman.khandual@arm.com>
 <Z724Q1ofM1GvKquV@J2N7QTR9R3> <9e1721a1-54a4-4007-a0f5-d651f5f21ae2@arm.com>
 <Z73LEkHklpjvIlmZ@J2N7QTR9R3.cambridge.arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Z73LEkHklpjvIlmZ@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/25/25 19:22, Mark Rutland wrote:
> On Tue, Feb 25, 2025 at 01:00:40PM +0000, Ryan Roberts wrote:
>> On 25/02/2025 12:32, Mark Rutland wrote:
>>> On Wed, Feb 19, 2025 at 09:26:46AM +0530, Anshuman Khandual wrote:
>>>> From: Ryan Roberts <ryan.roberts@arm.com>
>>>>
>>>> When CONFIG_ARM64_PA_BITS_52 is enabled, page table helpers __pte_to_phys()
>>>> and __phys_to_pte_val() are functions which return phys_addr_t and pteval_t
>>>> respectively as expected. But otherwise without this config being enabled,
>>>> they are defined as macros and their return types are implicit.
>>>>
>>>> Until now this has worked out correctly as both pte_t and phys_addr_t data
>>>> types have been 64 bits. But with the introduction of 128 bit page tables,
>>>> pte_t becomes 128 bits. Hence this ends up with incorrect widths after the
>>>> conversions, which leads to compiler warnings.
>>>
>>> Does 128-bit page table not imply 52-bit PAs?
>>
>> Not to my knowledge. For now the prototype code base is explicitly sticking to
>> 48-bit PA and 44-bit VA (for initial simplicitly because that's the limit for 4
>> levels).
> 
> Fair enough; info dump below, but hopefully nothing of consequence.
> 
> I assume that you're relying on the VMSAv9-128 PA bits [48:12] being in the
> same place as in the VMSAv8-64 descriptors, and being handled by the same
> PTE_ADDR_LOW mask that we use for CONFIG_ARM64_PA_BITS_52=n.
> 
>>From a quick scan of ARM DDI 0487 L.a, the VMSAv9-128 translation table
> descriptor format always contains a 56-bit PA (though PARange could be
> smaller than that). Bits [51:49] are packed differently than in
> VMSAv8-64 descriptors, and bits [55:52] are obviously new.
> 
>>>> Fix the warnings by explicitly casting to the correct type after doing the
>>>> conversion.
>>>
>>> I think it would be simpler and clearer if we replaced the macros with
>>> functions, such that __pte_to_phys() and __phys_to_pte_val() are
>>> *always* functions.
>>
>> Yeah, agreed. This was initially just a hack I did to get things working.
> 
> Cool; sounds like we're aligned.

Planning for the following respin instead.

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b2a2ad1b9e8..4ebfa60ea5c6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -68,10 +68,6 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define pte_ERROR(e)	\
 	pr_err("%s:%d: bad pte %016llx.\n", __FILE__, __LINE__, pte_val(e))
 
-/*
- * Macros to convert between a physical address and its placement in a
- * page table entry, taking care of 52-bit addresses.
- */
 #ifdef CONFIG_ARM64_PA_BITS_52
 static inline phys_addr_t __pte_to_phys(pte_t pte)
 {
@@ -84,8 +80,15 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 	return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PHYS_TO_PTE_ADDR_MASK;
 }
 #else
-#define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_LOW)
-#define __phys_to_pte_val(phys)	(phys)
+static inline phys_addr_t __pte_to_phys(pte_t pte)
+{
+	return pte_val(pte) & PTE_ADDR_LOW;
+}
+
+static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
+{
+	return phys;
+}
 #endif
 
 #define pte_pfn(pte)		(__pte_to_phys(pte) >> PAGE_SHIFT)
-- 
2.30.2



