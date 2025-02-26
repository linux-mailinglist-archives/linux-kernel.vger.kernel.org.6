Return-Path: <linux-kernel+bounces-533477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E116CA45B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B51F18888C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B41238165;
	Wed, 26 Feb 2025 10:01:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820B51A01CC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564062; cv=none; b=F+SmSmhdn9t2z+y4OpLxOUZSx6rWkfsaYjKNOwPEr8wGmXc50PMKUdxtH5UGYWabXU0Ko1aKI1pwWbgFsuiRxORekgBTrIlA6R+3VwcvrN2stty4gBrH+iNKeT1N9qPZY6qys6s1svNFKSvNzyjaFWQqhPFSq/3uG/KSvVQEDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564062; c=relaxed/simple;
	bh=j9HZfNHMSPpxW0m+Uu2JcLmzkUjqgBzMMCN/fPXpqOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kf/tgF5SoitneFEXSn251D4PQ0OYpMidIPV+mncGuetW0ybddUFefnC06M0sCaVOIVnPsCAmhvWyhmG6kR7Rc/FWhmeKTdwvJEBVjbGZaHiOG5HQDQw6bWnFf6jKIxMUpMHhZoqSh/cQ1rDeUG0ZXv1zM+MaJLcIsuKLmHdlKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BEC31007;
	Wed, 26 Feb 2025 02:01:15 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 271503F6A8;
	Wed, 26 Feb 2025 02:00:58 -0800 (PST)
Message-ID: <9807df16-f09d-4ea2-af21-1e97d380c041@arm.com>
Date: Wed, 26 Feb 2025 10:00:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: realm: Use aliased addresses for device DMA
 to shared buffers
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
 catalin.marinas@arm.com
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 aneesh.kumar@kernel.org, steven.price@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20250219220751.1276854-1-suzuki.poulose@arm.com>
 <20250219220751.1276854-4-suzuki.poulose@arm.com>
 <0b0705aa-8c85-4502-8450-a6c7fdbdbdbd@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <0b0705aa-8c85-4502-8450-a6c7fdbdbdbd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/02/2025 13:04, Robin Murphy wrote:
> On 2025-02-19 10:07 pm, Suzuki K Poulose wrote:
>> When a device performs DMA to a shared buffer using physical addresses,
>> (without Stage1 translation), the device must use the "{I}PA address" 
>> with the
>> top bit set in Realm. This is to make sure that a trusted device will 
>> be able
>> to write to shared buffers as well as the protected buffers. Thus, a 
>> Realm must
>> always program the full address including the "protection" bit, like 
>> AMD SME
>> encryption bits.
>>
>> Enable this by providing arm64 specific 
>> dma_{encrypted,decrypted,clear_encryption}
>> helpers for Realms. Please note that the VMM needs to similarly make 
>> sure that
>> the SMMU Stage2 in the Non-secure world is setup accordingly to map 
>> IPA at the
>> unprotected alias.
>>
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
>>   arch/arm64/include/asm/mem_encrypt.h | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/ 
>> include/asm/mem_encrypt.h
>> index f8f78f622dd2..aeda3bba255e 100644
>> --- a/arch/arm64/include/asm/mem_encrypt.h
>> +++ b/arch/arm64/include/asm/mem_encrypt.h
>> @@ -21,4 +21,26 @@ static inline bool force_dma_unencrypted(struct 
>> device *dev)
>>       return is_realm_world();
>>   }
>> +static inline dma_addr_t dma_decrypted(dma_addr_t daddr)
>> +{
>> +    if (is_realm_world())
>> +        daddr |= prot_ns_shared;
>> +    return daddr;
>> +}
>> +#define dma_decrypted dma_decrypted
>> +
>> +static inline dma_addr_t dma_encrypted(dma_addr_t daddr)
>> +{
>> +    if (is_realm_world())
>> +        daddr &= prot_ns_shared - 1;
> 
> Nit: is there a reason this isn't the direct inverse of the other 
> operation, i.e. "daddr &= ~prot_ns_shared"? If so, it might be worth 

It could be. The IPA size for the realm is split into half with the
lower half protected/encrypted and anything above that unprotected. 
Technically any addr >= prot_ns_shared is "unencrypted" (even though it
may be invalid, if >= BIT(IPA_Size) - 1). But now when I think of it, it
is much better to trigger a Stage2 fault if the address is illegal 
(i.e., > BIT(IPA_Size) - 1) than corrupting some valid memory, by
masking the top bits (beyond prot_ns_shared).

So, I will fix it.

Suzuki


> dropping a comment why we're doing slightly unintuitive arithmetic on a 
> pagetable attribute (and if not then maybe just do the more obvious 
> thing). I doubt anyone's in a rush to support TBI for DMA, and this 
> would be far from the only potential hiccup for that, but still... :)
> 
> Thanks,
> Robin.
> 
>> +    return daddr;
>> +}
>> +#define dma_encrypted dma_encrypted
>> +
>> +static inline dma_addr_t dma_clear_encryption(dma_addr_t daddr)
>> +{
>> +    return dma_encrypted(daddr);
>> +}
>> +#define dma_clear_encryption dma_clear_encryption
>> +
>>   #endif    /* __ASM_MEM_ENCRYPT_H */
> 


