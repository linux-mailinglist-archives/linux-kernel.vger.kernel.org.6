Return-Path: <linux-kernel+bounces-541898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E3EA4C332
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9F33AA2AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE562139D4;
	Mon,  3 Mar 2025 14:16:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC75C2139B2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011381; cv=none; b=G1y2FYvzcdQ8ck6TV55RDcbYTFkazI9ZrGS23cEyzpFADLQgeWmhtiin0EOnS0d3maFqEI5L9X2b/oAWKLVWgJGMdasuOuVkgOBY4DGq4Zl5ImIcf22osAvuQnXikUTPVzQMtuPN0NUDB2odeFPMAPi0kE5dzgw8Q7zh+cxz+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011381; c=relaxed/simple;
	bh=ZVet9WWrU5EEGnlmSvCAocDQVc7LV4XLsCQJOOYoIgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6eMHchM31rC4GTy69zSVRXZvCzPc0a/BSACk3sTXo97Dj/Vn7E/U+gK7TvAkEwdFlM2Vz6NoIFrtrArshDPXAsV8+tLegZKX2ASS0JNxvGwi7lHbx0J0hKxwGue7+jO4Lnuyu9j2+TAHHCaU8mFphJ4Al8yo63AHcicpOfDiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DECF0106F;
	Mon,  3 Mar 2025 06:16:31 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B11D3F66E;
	Mon,  3 Mar 2025 06:16:16 -0800 (PST)
Message-ID: <79b28d96-2a56-45b9-a5ae-5c120fe35a35@arm.com>
Date: Mon, 3 Mar 2025 14:16:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: realm: Use aliased addresses for device DMA
 to shared buffers
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org
Cc: will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, gshan@redhat.com,
 linux-arm-kernel@lists.infradead.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20250227144150.1667735-1-suzuki.poulose@arm.com>
 <20250227144150.1667735-4-suzuki.poulose@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250227144150.1667735-4-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2025 2:41 pm, Suzuki K Poulose wrote:
> When a device performs DMA to a shared buffer using physical addresses,
> (without Stage1 translation), the device must use the "{I}PA address" with the
> top bit set in Realm. This is to make sure that a trusted device will be able
> to write to shared buffers as well as the protected buffers. Thus, a Realm must
> always program the full address including the "protection" bit, like AMD SME
> encryption bits.
> 
> Enable this by providing arm64 specific dma_addr_{encrypted, canonical}
> helpers for Realms. Please note that the VMM needs to similarly make sure that
> the SMMU Stage2 in the Non-secure world is setup accordingly to map IPA at the
> unprotected alias.

FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Will Deacon <will@kernel.org>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v2:
>   - Drop dma_addr_encrypted() helper, which is a NOP for CCA ( Aneesh )
>   - Only mask the "top" IPA bit and not all the bits beyond top bit. ( Robin )
>   - Use PROT_NS_SHARED, now that we only set/clear top bit. (Gavin)
> ---
>   arch/arm64/include/asm/mem_encrypt.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
> index f8f78f622dd2..a2a1eeb36d4b 100644
> --- a/arch/arm64/include/asm/mem_encrypt.h
> +++ b/arch/arm64/include/asm/mem_encrypt.h
> @@ -21,4 +21,15 @@ static inline bool force_dma_unencrypted(struct device *dev)
>   	return is_realm_world();
>   }
>   
> +/*
> + * For Arm CCA guests, canonical addresses are "encrypted", so no changes
> + * required for dma_addr_encrypted().
> + * The unencrypted DMA buffers must be accessed via the unprotected IPA,
> + * "top IPA bit" set.
> + */
> +#define dma_addr_unencrypted(x)		((x) | PROT_NS_SHARED)
> +
> +/* Clear the "top" IPA bit while converting back */
> +#define dma_addr_canonical(x)		((x) & ~PROT_NS_SHARED)
> +
>   #endif	/* __ASM_MEM_ENCRYPT_H */

