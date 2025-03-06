Return-Path: <linux-kernel+bounces-548833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AD8A549CE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA07A1899F92
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5314420C025;
	Thu,  6 Mar 2025 11:39:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8A20C006
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261160; cv=none; b=BTsFlRrMMC9QwiFhRnHFnGjMOh9y3jcHLWGzS+OYNLoE1A0zx+K/cuKILylKzVvaNYiyKFdynnITK1VAQGk9Gn3R2M0H89Eg91eUGD+TRqiIlzaphn+7tjWBxRT3xt6rKw0E1hRwZlJeKLfWmF2dkf0gNP3wSxyejuxn29iaEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261160; c=relaxed/simple;
	bh=dWVb/SXTpDtb7mwLqEemWB++22QPNT6n+SXCs+yAruI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAf9WJv3oVz/DRxydK71UmSEyEC+BodSf0STgk/hoVIOtG7UxznHtbDx8+FXAom0DxLvLxtqkLXQTRNUaaw2AhNzL+i7YzabZdujUf593CXc2ONhBqNs8uTncPEE1cHfZPRqt9wX2d+MItousy80MVh8fJ3t60T+jLvddAc1eko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C90891007;
	Thu,  6 Mar 2025 03:39:29 -0800 (PST)
Received: from [10.57.38.145] (unknown [10.57.38.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E204C3F66E;
	Thu,  6 Mar 2025 03:39:14 -0800 (PST)
Message-ID: <7ad365f0-d335-4da1-845a-8fe3bc5eb055@arm.com>
Date: Thu, 6 Mar 2025 11:39:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] arm64: realm: Fix DMA address for devices
Content-Language: en-GB
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: maz@kernel.org, steven.price@arm.com, aneesh.kumar@kernel.org,
 gshan@redhat.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20250227144150.1667735-1-suzuki.poulose@arm.com>
 <CGME20250303113525eucas1p1099e087e2c11b9021603a6f13f8135c4@eucas1p1.samsung.com>
 <2b6d5287-bdea-4ec3-a07f-986bd3c3b285@arm.com>
 <7b5c90cf-00e4-4684-8719-f380badab064@samsung.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <7b5c90cf-00e4-4684-8719-f380badab064@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/03/2025 13:40, Marek Szyprowski wrote:
> Hi,
> 
> On 03.03.2025 12:35, Suzuki K Poulose wrote:
>> On 27/02/2025 14:41, Suzuki K Poulose wrote:
>>> Linux can be run as a Confidential Guest in Arm CCA from Linux v6.13.
>>> The address
>>> space (GPA or IPA) of a Realm VM is split into two halves, with
>>> private bottom
>>> half and shared top half. In Linux we treat the "top" bit of the IPA
>>> space as
>>> an attribute, to indicate whether it is shared or not (MSB == 1
>>> implies shared).
>>> Stage2 (GPA to PA) translations used by the CPU accesses, cover the
>>> full IPA space,
>>> and are managed by RMM. The "top" bit as attribute is only a software
>>> construct.
>>>
>>> At present any device passed through to a Realm is treated as
>>> untrusted and the
>>> Realm uses bounce buffering for any DMA, using the "decrypted"
>>> (shared) DMA
>>> buffers (i.e., IPA with top bit set). In Linux, we only send the
>>> "DMA" address
>>> masking the "top" bit. In Arm CCA, SMMU for untrusted devices are
>>> managed by the
>>> non-secure Host and thus it can be confusing for the host/device when
>>> an unmasked
>>> address is provided. Given there could be other hypervisors than
>>> Linux/KVM
>>> running Arm CCA guests, the Realm Guest must adhere to a single
>>> convention for
>>> the DMA address. This gets further complicated when we add support
>>> for trusted
>>> devices, which can DMA into the full Realm memory space, once
>>> accepted. Thus,
>>> a DMA masked address (with "top" bit lost) will prevent a trusted
>>> device from
>>> accessing a shared buffer.
>>>
>>> To resolve this Arm has decided to standardise the DMA address used
>>> by the Realm
>>> to include the full IPA address bits (including the "top" bit, which
>>> Linux uses
>>> as an attribute). This implies, any DMA to a shared buffer must have
>>> the top bit
>>> of the IPA space set.
>>>
>>> There is already a provision to do this in phys_to_dma* and
>>> dma_to_phys(), but
>>> that is specific to AMD SME and is quite the opposite of what we need
>>> for Arm CCA.
>>> i.e., For Arm CCA we need to set the bit for "decrypted" DMA and
>>> clear the bit
>>> for "encrypted".
>>>
>>> This series converts the existing __sme_* helpers to a bit more
>>> generalised versions :
>>> dma_addr_decrypted() and dma_encrypted(). Also, while converting a
>>> DMA address back
>>> to CPU physical address requires clearing off any
>>> "encryption/decryption" bits.
>>> I have named this "dma_addr_canonical()". (The other options are :
>>>     * dma_addr_clear_encryption - Well, not just for encryption, but
>>> we clear decryption
>>>       too, so not ideal.
>>>     * dma_addr_normal
>>>     * dma_addr_clear
>>>     * dma_addr_default
>>>
>>> This also implies that the VMMs must take care to :
>>>
>>>    1. Create the S2-SMMU mappings for VFIO at the "unprotected" alias.
>>>    2. Always mask the "top" bit off any IPA it receives from the Realm
>>> for DMA.
>>>       KVM already does that today and no changes are required.
>>>
>>> A kvmtool branch with the changes above is available here [1]. There
>>> are two
>>> patches [2] & [3], that are really required on top of the Arm CCA
>>> support.
>>>
>>> Ideally it would be good to get this backported to v6.13 stable
>>> kernel releases
>>> to make sure that they are compliant with this change.
>>>
>>
>> Please could you take a look at this series and let us know your
>> thoughts ? If you are happy with the changes, are you happy to pull
>> this through the DMA MAP tree ? The relevant bits have been reviewed/
>> acked by people (arm64 and AMD bits).
> 
> The changes look fine. However I won't be able to setup new dma-mapping
> git tree this week because I got really sick has to stay in bed. :/ If
> You don't want such delay, please merge it via ARM64 tree. Here is my:

Sorry to hear that. Hope you feel better soon.

> 
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks Marek.

Btw, this series fixes the "Realm Guest" support for Linux, which was 
merged in v6.13. To be precise, this should have :

Fixes: 42be24a4178f ("arm64: Enable memory encrypt for Realms")

Will/Catalin,

Please let me know if you would like me to send the series with
all the Acks, Reviews and mainly the Fixes tag added ?

Kind regards
Suzuki

> 
> 
> Best regards


