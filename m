Return-Path: <linux-kernel+bounces-178990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6108C5A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C105528172F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7CD1802AD;
	Tue, 14 May 2024 17:14:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44B517EBBD
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706887; cv=none; b=hiQCe0zOm+w1PyT02g9RvqQBHUEFEOzbkOo95pUeVBLcbEPNQXGxMlSfbafGniiZo7kvm1IlHgG8+heMMvibw7LgbJCX5vMPm3CJ+HLDQCUGk+sWJCtsxTJfinxU8N6oWYhSouAeyk68nqIL8Npoy3OkrEcclD0f1iL+Rl+3O7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706887; c=relaxed/simple;
	bh=Q10Xrs0iHK5CqwyAlQPfrvVmIhRbHxx1gQvxIBuMnPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwD2cN8w2qmYsnlFZEO9d3FiN2BZmz8g64dh8r7x2bPL7kcNlSdm6sWUQ0jR9SDLdHsdsirIBylKEE5LfdK6rmpT4LkpLBOkHR5yJ1x2hn/CfQT1UyJ3DN1k1c8ZOQX3WgNQ+/NUbOLleCWBzNR50mdWYXP7/bOlWKK7kPBAq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5B961007;
	Tue, 14 May 2024 10:15:08 -0700 (PDT)
Received: from [10.1.30.65] (010265703453.arm.com [10.1.30.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48B53F641;
	Tue, 14 May 2024 10:14:42 -0700 (PDT)
Message-ID: <cb8e151c-c0b8-4256-9b39-f66f73621a3d@arm.com>
Date: Tue, 14 May 2024 18:14:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: Don't disable next-page prefetcher on
 devices it works on
To: Douglas Anderson <dianders@chromium.org>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Cc: Stephen Boyd <swboyd@chromium.org>, Chen Lin <chen45464546@163.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240513161343.1.I5db5530070a1335e6cc3c55e056c2a84b1031308@changeid>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240513161343.1.I5db5530070a1335e6cc3c55e056c2a84b1031308@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Doug,

On 2024-05-14 12:13 am, Douglas Anderson wrote:
> On sc7180 trogdor devices we get a scary warning at bootup:
>    arm-smmu 15000000.iommu:
>    Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK
> 
> We spent some time trying to figure out how we were going to fix these
> errata and whether we needed to do a firmware update. Upon closer
> inspection, however, we realized that the errata don't apply to us.
> Specifically, the errata document says that for these errata:
> * Found in: r0p0
> * Fixed in: r2p2
> 
> ...and trogdor devices appear to be running r2p4. That means that they
> are unaffected despite the scary warning.
> 
> The issue is that the kernel unconditionally tries to disable the
> prefetcher even on unaffected devices and then warns when it's unable
> to.
> 
> Let's change the kernel to only disable the prefetcher on affected
> devices, which will get rid of the scary warning on devices that are
> unaffected. As per the comment the prefetcher is
> "not-particularly-beneficial" but it shouldn't hurt to leave it on for
> devices where it doesn't cause problems.

Unfortunately by now there are also at least #562869 and #1047329, plus 
a small possibility of further corners of systemic brokenness in the 
prefetcher yet to be discovered (or at least characterised sufficiently 
to be reported as an erratum). One could argue that we're not currently 
meeting the conditions for #1047329 yet, but with the IOMMUFD APIs 
finally falling into place, and potential pKVM use-cases on the horizon 
too, there's a distinct chance that someone will be interested in 
nesting support for SMMUv2 sooner or later.

Thanks,
Robin.

> Fixes: f87f6e5b4539 ("iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> index 9dc772f2cbb2..d9b38b0db0d4 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> @@ -109,7 +109,7 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
>   
>   int arm_mmu500_reset(struct arm_smmu_device *smmu)
>   {
> -	u32 reg, major;
> +	u32 reg, major, minor;
>   	int i;
>   	/*
>   	 * On MMU-500 r2p0 onwards we need to clear ACR.CACHE_LOCK before
> @@ -118,6 +118,7 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
>   	 */
>   	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_ID7);
>   	major = FIELD_GET(ARM_SMMU_ID7_MAJOR, reg);
> +	minor = FIELD_GET(ARM_SMMU_ID7_MINOR, reg);
>   	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sACR);
>   	if (major >= 2)
>   		reg &= ~ARM_MMU500_ACR_CACHE_LOCK;
> @@ -131,14 +132,18 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
>   	/*
>   	 * Disable MMU-500's not-particularly-beneficial next-page
>   	 * prefetcher for the sake of errata #841119 and #826419.
> +	 * These errata only affect r0p0 through r2p1 (fixed in r2p2).
>   	 */
> -	for (i = 0; i < smmu->num_context_banks; ++i) {
> -		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> -		reg &= ~ARM_MMU500_ACTLR_CPRE;
> -		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
> -		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> -		if (reg & ARM_MMU500_ACTLR_CPRE)
> -			dev_warn_once(smmu->dev, "Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK\n");
> +	if (major < 2 || (major == 2 && minor < 2)) {
> +		for (i = 0; i < smmu->num_context_banks; ++i) {
> +			reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> +			reg &= ~ARM_MMU500_ACTLR_CPRE;
> +			arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
> +			reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> +			if (reg & ARM_MMU500_ACTLR_CPRE)
> +				dev_warn_once(smmu->dev,
> +					      "Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK\n");
> +		}
>   	}
>   
>   	return 0;

