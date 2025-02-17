Return-Path: <linux-kernel+bounces-516984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D82A37A98
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300923AD0BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7FA14A4DF;
	Mon, 17 Feb 2025 04:33:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F4D15C0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739766820; cv=none; b=nW464E/gA1yVmDlnpM3XF7HzNI8/ZieZitv3O8OsiPwmuzR0BcsCl5iC2JBjwPdb2u52B+6a6wg0KmyBbaI7Rw78xxEEuMqk7J/P8+CPjWF5LmfyDgQR9JByoHCydv/QA8JYaulFMGU/skOFALoAa1+aQic9wFKNHpcnpSLLBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739766820; c=relaxed/simple;
	bh=ngdiaS6kobfS+FwjdswoDTh9JXleLpuviZIZEQj80fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lxhi6PsOePHBNZETIEaFjNrtWy2hsDZcBb4I5dpzHUBLdwoxEjOD1KueRHb80UTPzndushXiRdY0MKhYq5rq7AXmGB+yK1i5KCL+4jf2HpZ78ghw4IlpBODjxZ4GceM5mERgTOZ/lOi4fAWB5CSWQjfPI+u+xjYFnhfw9ns/+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3077E1063;
	Sun, 16 Feb 2025 20:33:58 -0800 (PST)
Received: from [10.162.16.135] (unknown [10.162.16.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C2B43F59E;
	Sun, 16 Feb 2025 20:33:34 -0800 (PST)
Message-ID: <72f188c5-c078-4ff5-81a6-3a0c8b2edaea@arm.com>
Date: Mon, 17 Feb 2025 10:03:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/16] arm64/mm: Support huge pte-mapped pages in vmap
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Steve Capper <steve.capper@linaro.org>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250205151003.88959-1-ryan.roberts@arm.com>
 <20250205151003.88959-13-ryan.roberts@arm.com>
 <9a0d3009-18fc-4b53-941a-b6d830fce36a@arm.com>
 <21da59a8-165d-4423-a00d-d5859f42ec11@arm.com>
 <0dd74f57-902a-4a6d-9f77-31963b5953d1@arm.com>
 <d6af21f1-e539-4fa6-a3f8-c4859b1325c5@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <d6af21f1-e539-4fa6-a3f8-c4859b1325c5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/25 14:39, Ryan Roberts wrote:
> 
>>>>> +#define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
>>>>> +static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
>>>>> +						unsigned long end, u64 pfn,
>>>>> +						unsigned int max_page_shift)
>>>>> +{
>>>>> +	if (max_page_shift < CONT_PTE_SHIFT)
>>>>> +		return PAGE_SIZE;
>>>>> +
>>>>> +	if (end - addr < CONT_PTE_SIZE)
>>>>> +		return PAGE_SIZE;
>>>>> +
>>>>> +	if (!IS_ALIGNED(addr, CONT_PTE_SIZE))
>>>>> +		return PAGE_SIZE;
>>>>> +
>>>>> +	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
>>>>> +		return PAGE_SIZE;
>>>>> +
>>>>> +	return CONT_PTE_SIZE;
>>>>
>>>> A small nit:
>>>>
>>>> Should the rationale behind picking CONT_PTE_SIZE be added here as an in code
>>>> comment or something in the function - just to make things bit clear.
>>>
>>> I'm not sure what other size we would pick?
>>
>> The suggestion was to add a small comment in the above helper function explaining
>> the rationale for various conditions in there while returning either PAGE_SIZE or
>> CONT_PTE_SIZE to improve readability etc.
> 
> OK I've added the following:
> 
> /*
>  * If the block is at least CONT_PTE_SIZE in size, and is naturally
>  * aligned in both virtual and physical space, then we can pte-map the
>  * block using the PTE_CONT bit for more efficient use of the TLB.
>  */

Sounds good, thanks !

