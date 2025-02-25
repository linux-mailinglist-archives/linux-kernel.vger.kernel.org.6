Return-Path: <linux-kernel+bounces-531874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE7A44628
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041C63BACD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA241192D77;
	Tue, 25 Feb 2025 16:30:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AE0193402
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501017; cv=none; b=d3EUK8y/uG7evX4VgSpYy3JUJyahQ1+4X8B3193eVafGXM8k0DgEPQVGSyMY6by8aiuL8nJejHMBeOJjnDMVPOPUUx+unKYPxUXyoOYWVWRKk05qfecaGC0GmmL3rhXa/PA1BTZIMJDlojwBv6bjGa37PaW+7X2wEnQBZH/9SWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501017; c=relaxed/simple;
	bh=OMwHRdqCbz9+lywEfJd1MRf24+RGEZh3cRJprlUXwPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/rM7+BDYPI5ZX+3s7Xx+3P2DUKyFsAJDGpZ/QNddBBlgSFO+WUcoeehSC+v2JsAOvwjXzJXH3OHG8tD8C2vXRo7kD7vR74pjaPdFcUwths/Djyqt+x2oB71yrlmJkhqMjPeYUQwui0XsZdoHbM7yXbV8h3VLvC7ji9n/okYDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC5EF1063;
	Tue, 25 Feb 2025 08:30:29 -0800 (PST)
Received: from [192.168.4.165] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 074173F6A8;
	Tue, 25 Feb 2025 08:30:11 -0800 (PST)
Message-ID: <5c74673c-4ad7-4da0-84d9-71357246977f@arm.com>
Date: Tue, 25 Feb 2025 16:30:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dma: Introduce generic dma_decrypted/dma_encrypted
 helpers
Content-Language: en-GB
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
 catalin.marinas@arm.com
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 aneesh.kumar@kernel.org, steven.price@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20250219220751.1276854-1-suzuki.poulose@arm.com>
 <20250219220751.1276854-3-suzuki.poulose@arm.com>
 <cdecd882-64ed-426c-98e1-9e8815f1c6ad@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <cdecd882-64ed-426c-98e1-9e8815f1c6ad@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Robin

Thanks for your comments, response below.

On 25/02/2025 12:49, Robin Murphy wrote:
> On 2025-02-19 10:07 pm, Suzuki K Poulose wrote:
>> AMD SME added __sme_set/__sme_clr primitives to modify the DMA address 
>> for
>> encrypted/decrypted traffic. However this doesn't fit in with other 
>> models,
>> e.g., Arm CCA where the meanings are the opposite. i.e., "decrypted" 
>> traffic
>> has a bit set and "encrypted" traffic has the top bit cleared.
>>
>> In preparation for adding the support for Arm CCA DMA conversions, 
>> convert the
>> existing primitives to more generic ones that can be provided by the 
>> backends.
>> i.e., add helpers to
>>   1. dma_encrypted - Convert a DMA address to "encrypted" [ == 
>> __sme_set() ]
>>   2. dma_decrypted - Convert a DMA address to "decrypted" [ None 
>> exists today ]
>>   3. dma_clear_encryption - Clear any "encryption"/"decryption" bits 
>> from DMA
>>      address [ SME uses __sme_clr() ]
> 
> Nit: I'd still prefer to have as much distinction as possible between 
> manipulation of the address representation itself, and any other aspects 
> such as the manipulation of underlying pagetable attributes also implied 
> by force_dma_unencrypted() on x86. So how about:
> 
> dma_addr_encrypted
> dma_addr_unencrypted
> dma_addr_clear_encryption
> 
> ?

Sure, sounds better. I am still not convinced about the 
dma_addr_clear_encryption() as it really applies to "clear" decryption
too.

The options we have are :

dma_addr_canonical(), dma_addr_normal() or any others.

> 
> Note that we intentionally avoided "decrypted" in the existing APIs to 
> minimise confusion, the only time any actual decryption is involved is 
> for an "encrypted" address.

Agreed.

> 
> (Stuff like that being why I personally would prefer to generalise away 
> from encryption as an implementation detail at all, but since everyone 
> else seems to be accustomed to the existing terminology and not 
> complaining, I'm prepared to compromise that far!)
> 
> Otherwise, the overall shape looks good to me.

I will respin this, with the changes.

Suzuki

> 
> Thanks,
> Robin.
> 
>> Since the original __sme_xxx helpers come from linux/mem_encrypt.h, 
>> use that
>> as the home for the new definitions and provide dummy ones when none 
>> is provided
>> by the architectures.
>>
>> With the above, phys_to_dma_unencrypted() uses the newly added 
>> dma_decrypted()
>> helper and to make it a bit more easier to read and avoid double 
>> conversion,
>> provide __phys_to_dma().
>>
>> No functional changes intended. Compile tested on x86 defconfig with
>> CONFIG_AMD_MEM_ENCRYPT.
>>
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   include/linux/dma-direct.h  | 12 ++++++++----
>>   include/linux/mem_encrypt.h | 23 +++++++++++++++++++++++
>>   2 files changed, 31 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
>> index d20ecc24cb0f..9b5cc0ee86d5 100644
>> --- a/include/linux/dma-direct.h
>> +++ b/include/linux/dma-direct.h
>> @@ -78,14 +78,18 @@ static inline dma_addr_t dma_range_map_max(const 
>> struct bus_dma_region *map)
>>   #define phys_to_dma_unencrypted        phys_to_dma
>>   #endif
>>   #else
>> -static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
>> -        phys_addr_t paddr)
>> +static inline dma_addr_t __phys_to_dma(struct device *dev, 
>> phys_addr_t paddr)
>>   {
>>       if (dev->dma_range_map)
>>           return translate_phys_to_dma(dev, paddr);
>>       return paddr;
>>   }
>> +static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
>> +                        phys_addr_t paddr)
>> +{
>> +    return dma_decrypted(__phys_to_dma(dev, paddr));
>> +}
>>   /*
>>    * If memory encryption is supported, phys_to_dma will set the 
>> memory encryption
>>    * bit in the DMA address, and dma_to_phys will clear it.
>> @@ -94,14 +98,14 @@ static inline dma_addr_t 
>> phys_to_dma_unencrypted(struct device *dev,
>>    */
>>   static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t 
>> paddr)
>>   {
>> -    return __sme_set(phys_to_dma_unencrypted(dev, paddr));
>> +    return dma_encrypted(__phys_to_dma(dev, paddr));
>>   }
>>   static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t 
>> dma_addr)
>>   {
>>       phys_addr_t paddr;
>> -    dma_addr = __sme_clr(dma_addr);
>> +    dma_addr = dma_clear_encryption(dma_addr);
>>       if (dev->dma_range_map)
>>           paddr = translate_dma_to_phys(dev, dma_addr);
>>       else
>> diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
>> index ae4526389261..c8dcc1be695a 100644
>> --- a/include/linux/mem_encrypt.h
>> +++ b/include/linux/mem_encrypt.h
>> @@ -26,11 +26,34 @@
>>    */
>>   #define __sme_set(x)        ((x) | sme_me_mask)
>>   #define __sme_clr(x)        ((x) & ~sme_me_mask)
>> +
>> +#define dma_encrypted(x)    __sme_set(x)
>> +#define dma_clear_encryption(x)    __sme_clr(x)
>> +
>>   #else
>>   #define __sme_set(x)        (x)
>>   #define __sme_clr(x)        (x)
>>   #endif
>> +/*
>> + * dma_encrypted() and dma_decrypted() are for converting a given DMA
>> + * address to the respective type of addressing.
>> + *
>> + * dma_clear_encryption() is used to reverse the conversion back to 
>> "normal"
>> + * DMA address.
>> + */
>> +#ifndef dma_encrypted
>> +#define dma_encrypted(x)    (x)
>> +#endif
>> +
>> +#ifndef dma_decrypted
>> +#define dma_decrypted(x)    (x)
>> +#endif
>> +
>> +#ifndef dma_clear_encryption
>> +#define dma_clear_encryption(x)    (x)
>> +#endif
>> +
>>   #endif    /* __ASSEMBLY__ */
>>   #endif    /* __MEM_ENCRYPT_H__ */
> 


