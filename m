Return-Path: <linux-kernel+bounces-531547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA34A441B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3837A31D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC8926A0A4;
	Tue, 25 Feb 2025 14:04:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8012686A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492287; cv=none; b=Nbn8/GAGOdShnmuxq25HoBpcdp7WKEeRu8mJY6i44Pj2YzFh+pknmk63p2L+sfOE8Wont+yGmdtgxD8VdbWusoMQCQROi6LEqeashjSpt/FmkrzDHkRcW0VDw0WILFShlh/irRR+vy7vU+C3m2S4vl5jydvQT5wa3OlYGFvEyb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492287; c=relaxed/simple;
	bh=L434M/O3oCkZpW7cHEiVIKwlK34tRrLWx2AxIrRqUj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9q9Jgow16Cwm6WAbR66/H3tMk8MaSpVYQ0r2OXBST9qa0iVOCxUslsXg480id18IAQMrxgbnI6SfmUog2AcI+3pQvGcIHo8XfEbYmYlyTCMt45DLTD2l3VHpkLoSvC2Fiky1hOf5oa0SvZ1rQo6oGob1LPpVAaiZNBCP3T1zp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15760152B;
	Tue, 25 Feb 2025 06:05:00 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49A9A3F6A8;
	Tue, 25 Feb 2025 06:04:42 -0800 (PST)
Message-ID: <34a0b098-d9c5-4605-8ce7-abd6fa59d38b@arm.com>
Date: Tue, 25 Feb 2025 14:04:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dma: Fix encryption bit clearing for dma_to_phys
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
 catalin.marinas@arm.com
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 aneesh.kumar@kernel.org, steven.price@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20250219220751.1276854-1-suzuki.poulose@arm.com>
 <20250219220751.1276854-2-suzuki.poulose@arm.com>
 <68405608-564c-4e79-9cbc-545626e736f1@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <68405608-564c-4e79-9cbc-545626e736f1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/02/2025 11:25, Robin Murphy wrote:
> On 2025-02-19 10:07 pm, Suzuki K Poulose wrote:
>> phys_to_dma() sets the encryption bit on the translated DMA address. But
>> dma_to_phys() clears the encryption bit after it has been translated back
>> to the physical address, which could fail if the device uses DMA ranges.
>>
>> Hopefully, AMD SME doesn't use it.
> 
> ...by which you mean we don't think any AMD systems are using the ACPI 
> _DMA method to constrain physical DMA ranges, otherwise SME with dma- 
> direct would presumably already be broken by this lookup going wrong.

Yep, that AMD systems aren't using DMA ranges.


> 
>> Anyways, let us fix it, before cleanup
>> the infrastructure for supporting other architectures.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks

Suzuki

> 
>> Reported-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>> Link: https://lkml.kernel.org/r/yq5amsen9stc.fsf@kernel.org
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   include/linux/dma-direct.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
>> index d7e30d4f7503..d20ecc24cb0f 100644
>> --- a/include/linux/dma-direct.h
>> +++ b/include/linux/dma-direct.h
>> @@ -101,12 +101,13 @@ static inline phys_addr_t dma_to_phys(struct 
>> device *dev, dma_addr_t dma_addr)
>>   {
>>       phys_addr_t paddr;
>> +    dma_addr = __sme_clr(dma_addr);
>>       if (dev->dma_range_map)
>>           paddr = translate_dma_to_phys(dev, dma_addr);
>>       else
>>           paddr = dma_addr;
>> -    return __sme_clr(paddr);
>> +    return paddr;
>>   }
>>   #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
> 


