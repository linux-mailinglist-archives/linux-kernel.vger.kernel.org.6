Return-Path: <linux-kernel+bounces-531876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BEAA44630
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D337A3AAF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A019259A;
	Tue, 25 Feb 2025 16:31:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D76C6AA7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501075; cv=none; b=q7UcUUoSH7kMwiiW7UjM39s7qCtwPeu4mLpq6S43oWKr7OF9PZxnyzctuyTdju5jiWYc+xEQ+DML6eDD1d9X2m6/eFC0aDYv7ZJLHxbYbiuZpcD0XwNpLQ6n/gb9uBy+fTxbf0/U6Qc2YGPa7jIHBDIYVFIX3Xrtb+PZ2TA0t4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501075; c=relaxed/simple;
	bh=AF7xpY2aY0BqWvgNARUwc9lwQBePnXHjqnFFZj/uZm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hv20j/Gm6Nj3IfMhR2bFpK9sBg+4CWGUctbo1Azi1sg2sEbPG9igxQdAM9S5rkjm3KSAEIAThl18Zptkp/xXDmvM8gFU0ciOadGB4YtCOfMFdqGL4TVQYtVHdJwtFoWjrNMlh7G+vERnFVpC3xIpc3kKr2tf6FWPwOybh08F3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 186951BCB;
	Tue, 25 Feb 2025 08:31:29 -0800 (PST)
Received: from [192.168.4.165] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 414483F6A8;
	Tue, 25 Feb 2025 08:31:11 -0800 (PST)
Message-ID: <5a135acb-b94d-47f5-9436-2d558cf78268@arm.com>
Date: Tue, 25 Feb 2025 16:31:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: realm: Use aliased addresses for device DMA
 to shared buffers
Content-Language: en-GB
To: Gavin Shan <gshan@redhat.com>, will@kernel.org, robin.murphy@arm.com,
 catalin.marinas@arm.com
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 aneesh.kumar@kernel.org, steven.price@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20250219220751.1276854-1-suzuki.poulose@arm.com>
 <20250219220751.1276854-4-suzuki.poulose@arm.com>
 <c710a9d6-bd1b-4867-bdc9-b3a79e577d0e@redhat.com>
 <308f8a08-a6f8-403e-a130-18c7d3db2e23@redhat.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <308f8a08-a6f8-403e-a130-18c7d3db2e23@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Gavin

Thanks for the review.

On 25/02/2025 05:28, Gavin Shan wrote:
> On 2/25/25 3:24 PM, Gavin Shan wrote:
>> On 2/20/25 8:07 AM, Suzuki K Poulose wrote:
>>> When a device performs DMA to a shared buffer using physical addresses,
>>> (without Stage1 translation), the device must use the "{I}PA address" 
>>> with the
>>> top bit set in Realm. This is to make sure that a trusted device will 
>>> be able
>>> to write to shared buffers as well as the protected buffers. Thus, a 
>>> Realm must
>>> always program the full address including the "protection" bit, like 
>>> AMD SME
>>> encryption bits.
>>>
>>> Enable this by providing arm64 specific 
>>> dma_{encrypted,decrypted,clear_encryption}
>>> helpers for Realms. Please note that the VMM needs to similarly make 
>>> sure that
>>> the SMMU Stage2 in the Non-secure world is setup accordingly to map 
>>> IPA at the
>>> unprotected alias.
>>>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: Steven Price <steven.price@arm.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>>> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   arch/arm64/include/asm/mem_encrypt.h | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/ 
>>> include/asm/mem_encrypt.h
>>> index f8f78f622dd2..aeda3bba255e 100644
>>> --- a/arch/arm64/include/asm/mem_encrypt.h
>>> +++ b/arch/arm64/include/asm/mem_encrypt.h
>>> @@ -21,4 +21,26 @@ static inline bool force_dma_unencrypted(struct 
>>> device *dev)
>>>       return is_realm_world();
>>>   }
>>> +static inline dma_addr_t dma_decrypted(dma_addr_t daddr)
>>> +{
>>> +    if (is_realm_world())
>>> +        daddr |= prot_ns_shared;
>>> +    return daddr;
>>> +}
>>> +#define dma_decrypted dma_decrypted
>>> +
>>
>> There is an existing macro (PROT_NS_SHARED), which is preferred to return
>> prot_ns_shared or 0 depending on the availability of the realm 
>> capability.
>> However, that macro needs to be improved a bit so that it can be used 
>> here.
>> We need to return 0UL to match with the type of prot_ns_shared 
>> (unsigned long)
>>
>> -#define PROT_NS_SHARED         (is_realm_world() ? prot_ns_shared : 0)
>> +#define PROT_NS_SHARED         (is_realm_world() ? prot_ns_shared : 0UL)
>>
>> After that, the chunk of code can be as below.
>>
>>      return daddr | PROT_NS_SHARED;
>>
>>> +static inline dma_addr_t dma_encrypted(dma_addr_t daddr)
>>> +{
>>> +    if (is_realm_world())
>>> +        daddr &= prot_ns_shared - 1;
>>> +    return daddr;
>>> +}
>>> +#define dma_encrypted dma_encrypted
>>> +
>>
>> With PROT_NS_SHARED, it can become something like below. 
>> (PROT_NS_SHARED - 1)
>> is equivalent to -1UL, 'daddr & -1UL' should be fine since it does 
>> nothing.
>>
> 
> I meant (PROT_NS_SHARED - 1) is equivalent to -1UL when no realm capability
> is around :)

I didn't want this to be there ;-). But with Robin's comment, I think we
can revert back to PROT_NS_SHARED.

Cheers
Suzuki

> 
>>      return daddr & (PROT_NS_SHARED - 1);
>>
>>> +static inline dma_addr_t dma_clear_encryption(dma_addr_t daddr)
>>> +{
>>> +    return dma_encrypted(daddr);
>>> +}
>>> +#define dma_clear_encryption dma_clear_encryption
>>> +
>>>   #endif    /* __ASM_MEM_ENCRYPT_H */
> 
> Thanks,
> Gavin
> 


