Return-Path: <linux-kernel+bounces-541597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32290A4BED1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7918618853A8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19B1FC11E;
	Mon,  3 Mar 2025 11:35:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285C01FC11A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001725; cv=none; b=vArCs+HXrgovhuUlgCHVYrIUjZXwnMh8j+tKjNi+wq5tnO3Vluhj2VZC156TQogD5DLN45wAzTuTvERa1aXUNaqFRLukJe4BF17HgksBhc6+2raWbmXyxZt0z8LEp5Wq54yro/B/rT//XwoMyz+uMUao0ajZ4mf9WNLpgvVuL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001725; c=relaxed/simple;
	bh=v8XqCusruxsmNE0u+56IKmxRCWDfbbAUHBEj0qBMdBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BH0hrjF7s+m8AN8qa1XgJR+9pec0q3vzDYXbT6YOZu7rJTzUWSHmnYtGp99/aU94IbMCoSf1/Q3MU4YqulT7eIaj+BHdUBdXQvXXZNZJ6YnIxEVlY9XNoT7tK17RzoOqJLxBNcL9uJsjuG4g5MYKnTAzTXsXzojiflMf9THxhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 654ED1063;
	Mon,  3 Mar 2025 03:35:36 -0800 (PST)
Received: from [10.57.37.67] (unknown [10.57.37.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 111383F673;
	Mon,  3 Mar 2025 03:35:19 -0800 (PST)
Message-ID: <2b6d5287-bdea-4ec3-a07f-986bd3c3b285@arm.com>
Date: Mon, 3 Mar 2025 11:35:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] arm64: realm: Fix DMA address for devices
Content-Language: en-GB
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, gshan@redhat.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20250227144150.1667735-1-suzuki.poulose@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250227144150.1667735-1-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marek,


On 27/02/2025 14:41, Suzuki K Poulose wrote:
> Linux can be run as a Confidential Guest in Arm CCA from Linux v6.13. The address
> space (GPA or IPA) of a Realm VM is split into two halves, with private bottom
> half and shared top half. In Linux we treat the "top" bit of the IPA space as
> an attribute, to indicate whether it is shared or not (MSB == 1 implies shared).
> Stage2 (GPA to PA) translations used by the CPU accesses, cover the full IPA space,
> and are managed by RMM. The "top" bit as attribute is only a software construct.
> 
> At present any device passed through to a Realm is treated as untrusted and the
> Realm uses bounce buffering for any DMA, using the "decrypted" (shared) DMA
> buffers (i.e., IPA with top bit set). In Linux, we only send the "DMA" address
> masking the "top" bit. In Arm CCA, SMMU for untrusted devices are managed by the
> non-secure Host and thus it can be confusing for the host/device when an unmasked
> address is provided. Given there could be other hypervisors than Linux/KVM
> running Arm CCA guests, the Realm Guest must adhere to a single convention for
> the DMA address. This gets further complicated when we add support for trusted
> devices, which can DMA into the full Realm memory space, once accepted. Thus,
> a DMA masked address (with "top" bit lost) will prevent a trusted device from
> accessing a shared buffer.
> 
> To resolve this Arm has decided to standardise the DMA address used by the Realm
> to include the full IPA address bits (including the "top" bit, which Linux uses
> as an attribute). This implies, any DMA to a shared buffer must have the top bit
> of the IPA space set.
> 
> There is already a provision to do this in phys_to_dma* and dma_to_phys(), but
> that is specific to AMD SME and is quite the opposite of what we need for Arm CCA.
> i.e., For Arm CCA we need to set the bit for "decrypted" DMA and clear the bit
> for "encrypted".
> 
> This series converts the existing __sme_* helpers to a bit more generalised versions :
> dma_addr_decrypted() and dma_encrypted(). Also, while converting a DMA address back
> to CPU physical address requires clearing off any "encryption/decryption" bits.
> I have named this "dma_addr_canonical()". (The other options are :
>    * dma_addr_clear_encryption - Well, not just for encryption, but we clear decryption
>      too, so not ideal.
>    * dma_addr_normal
>    * dma_addr_clear
>    * dma_addr_default
> 
> This also implies that the VMMs must take care to :
> 
>   1. Create the S2-SMMU mappings for VFIO at the "unprotected" alias.
>   2. Always mask the "top" bit off any IPA it receives from the Realm for DMA.
>      KVM already does that today and no changes are required.
> 
> A kvmtool branch with the changes above is available here [1]. There are two
> patches [2] & [3], that are really required on top of the Arm CCA support.
> 
> Ideally it would be good to get this backported to v6.13 stable kernel releases
> to make sure that they are compliant with this change.
> 

Please could you take a look at this series and let us know your
thoughts ? If you are happy with the changes, are you happy to pull
this through the DMA MAP tree ? The relevant bits have been reviewed/
acked by people (arm64 and AMD bits).

Kind regards
Suzuki


> Changes since v2:
>   Link: https://lkml.kernel.org/r/20250219220751.1276854-1-suzuki.poulose@arm.com
>    - Collect Acks & Reviews for Patch 1
>    - Rename helpers
>    	dma_encrypted		=> dma_addr_encrypted
> 	dma_decrypted		=> dma_addr_unencrypted
> 	dma_clear_encryption	=> dma_addr_canonical
>    - For Arm CCA, use PROT_NS_SHARED, set/clear only the top IPA bit.
>    - Drop dma_addr_encrypted() helper for Arm CCA as it is a NOP
> 
> Changes since v1
>   Link: https://lkml.kernel.org/r/20250212171411.951874-1-suzuki.poulose@arm.com
>   - Follow Robin's suggestion to generalise the DMA address conversion helpers
>     to provide dma_{encrypte,decrypted,clear_encryption}. See PATCH 2 for more
>     details.
>   - Add a fix to the ordering of "__sme_clr" for dma_to_phys (PATCH 1)
> 
> [1] git@git.gitlab.arm.com:linux-arm/kvmtool-cca.git cca/guest-dma-alias/v1
> [2] https://gitlab.arm.com/linux-arm/kvmtool-cca/-/commit/ea37a6eb968abe4c75be4a8a90808714657c2ef7
> [3] https://gitlab.arm.com/linux-arm/kvmtool-cca/-/commit/8afd0d5e6a7ee444dd0c1565fe94ecd831054a29
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Gavin Shan <gshan@redhat.com>
> 
> Suzuki K Poulose (3):
>    dma: Fix encryption bit clearing for dma_to_phys
>    dma: Introduce generic dma_addr_*crypted helpers
>    arm64: realm: Use aliased addresses for device DMA to shared buffers
> 
>   arch/arm64/include/asm/mem_encrypt.h | 11 +++++++++++
>   include/linux/dma-direct.h           | 13 +++++++++----
>   include/linux/mem_encrypt.h          | 23 +++++++++++++++++++++++
>   3 files changed, 43 insertions(+), 4 deletions(-)
> 


