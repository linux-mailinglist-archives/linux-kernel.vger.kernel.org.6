Return-Path: <linux-kernel+bounces-348079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB50598E237
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92D2282CF1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739E7212F0B;
	Wed,  2 Oct 2024 18:21:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B1212F00
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893296; cv=none; b=LPAFSUsMe7Y3lfaQoYyOoGE8kSUoLCenLFjmx7PFVmVVKJkiF373dMOztDT9uj5w21TwwDX1wBEjd7mjSipjVmvYgUJtEyt0YemPb2DQLr4K1Y6X4vz/lDawXil+fcmQETvC+YPCyh5Cunm+xx45PZn4H6alrehfs39+otK3FLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893296; c=relaxed/simple;
	bh=sdqeMzU4KozmLh31zEm2+ojKYLhm9GLk3YC3gOVLC6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9agtJepP0OzbPt2nW0dvSVAdZPuxt56e45+8OAdQFJQ2BIUFB0IlgCnMERCuvOjJjHQhnRPfPPf+4rdegsz+56oaQN2kY1pfuUYpN8rYsx+Mm+MT8iNXnYNxyGSTTS4AUOXIlAVI/s4w8aEsJzvo7lYqZtyatoY03imDmPA8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1C1D339;
	Wed,  2 Oct 2024 11:22:01 -0700 (PDT)
Received: from [10.57.75.22] (unknown [10.57.75.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 252103F58B;
	Wed,  2 Oct 2024 11:21:30 -0700 (PDT)
Message-ID: <0a0c6d4f-e9f7-4fe6-9bb8-25772856c345@arm.com>
Date: Wed, 2 Oct 2024 19:21:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Yang Shi <yang@os.amperecomputing.com>, jgg@ziepe.ca,
 nicolinc@nvidia.com, james.morse@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241002175514.1165299-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-02 6:55 pm, Yang Shi wrote:
> The commit ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
> calculated the last index of L1 stream table by 1 << smmu->sid_bits. 1
> is 32 bit value.
> However some platforms, for example, AmpereOne, have 32-bit stream id size.
> This resulted in ouf-of-bound shift.  The disassembly of shift is:
> 
>      ldr     w2, [x19, 828]  //, smmu_7(D)->sid_bits
>      mov     w20, 1
>      lsl     w20, w20, w2
> 
> According to ARM spec, if the registers are 32 bit, the instruction actually
> does:
>      dest = src << (shift % 32)
> 
> So it actually shifted by zero bit.
> 
> This caused v6.12-rc1 failed to boot on AmpereOne and other platform [1].

FWIW it's going to be seen on any platform with Arm MMU-700 since that 
always advertises 32-bit StreamID support (as other SMMU implementations 
may do too).

> UBSAN also reported:
> 
> UBSAN: shift-out-of-bounds in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3628:29
> shift exponent 32 is too large for 32-bit type 'int'

At best, those two lines of actual UBSAN warning are the only part 
relevant to the point, the rest of the backtrace below is definitely 
not, please trim it.

> CPU: 70 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1 #4
> Hardware name: ZOLLNER SUNMOONLAKE/SunMoon Lake, BIOS 00.00. 2024-08-28 18:42:45 08/28/2024
> Call trace:
>   dump_backtrace+0xdc/0x140
>   show_stack+0x20/0x40
>   dump_stack_lvl+0x60/0x80
>   dump_stack+0x18/0x28
>   ubsan_epilogue+0x10/0x48
>   __ubsan_handle_shift_out_of_bounds+0xd8/0x1a0
>   arm_smmu_init_structures+0x374/0x3c8
>   arm_smmu_device_probe+0x208/0x600
>   platform_probe+0x70/0xe8
>   really_probe+0xc8/0x3a0
>   __driver_probe_device+0x84/0x160
>   driver_probe_device+0x44/0x130
>   __driver_attach+0xcc/0x208
>   bus_for_each_dev+0x84/0x100
>   driver_attach+0x2c/0x40
>   bus_add_driver+0x158/0x290
>   driver_register+0x70/0x138
>   __platform_driver_register+0x2c/0x40
>   arm_smmu_driver_init+0x28/0x40
>   do_one_initcall+0x60/0x318
>   do_initcalls+0x198/0x1e0
>   kernel_init_freeable+0x18c/0x1e8
>   kernel_init+0x28/0x160
>   ret_from_fork+0x10/0x20
> 
> Using 64 bit immediate when doing shift can solve the problem.  The
> disassembly after the fix looks like:
>      ldr     w20, [x19, 828] //, smmu_7(D)->sid_bits
>      mov     x0, 1
>      lsl     x0, x0, x20
> 
> There are a couple of problematic places, extracted the shift into a helper.
> 
> [1] https://lore.kernel.org/lkml/d4b53bbb-333a-45b9-9eb0-23ddd0820a14@arm.com/
> Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
> Tested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 5 +++++
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> v2: * Extracted the shift into a helper per Jason Gunthorpe.
>      * Covered more places per Nicolin Chen and Jason Gunthorpe.
>      * Used 1ULL instead of 1UL to guarantee 64 bit per Robin Murphy.
>      * Made the subject more general since this is not AmpereOne specific
>        problem per the report from James Morse.
>      * Collected t-b tag from James Morse.
>      * Added Fixes tag in commit log.
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 737c5b882355..4eafd9f04808 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3624,8 +3624,9 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>   {
>   	u32 l1size;
>   	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> +	unsigned int max_sid = arm_smmu_strtab_max_sid(smmu);
>   	unsigned int last_sid_idx =
> -		arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
> +		arm_smmu_strtab_l1_idx(max_sid - 1);
>   
>   	/* Calculate the L1 size, capped to the SIDSIZE. */
>   	cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
> @@ -3657,8 +3658,9 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>   {
>   	u32 size;
>   	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> +	unsigned int max_sid = arm_smmu_strtab_max_sid(smmu);
>   
> -	size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
> +	size = max_sid * sizeof(struct arm_smmu_ste);
>   	cfg->linear.table = dmam_alloc_coherent(smmu->dev, size,
>   						&cfg->linear.ste_dma,
>   						GFP_KERNEL);
> @@ -3668,7 +3670,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>   			size);
>   		return -ENOMEM;
>   	}
> -	cfg->linear.num_ents = 1 << smmu->sid_bits;
> +	cfg->linear.num_ents = max_sid;
>   
>   	arm_smmu_init_initial_stes(cfg->linear.table, cfg->linear.num_ents);
>   	return 0;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 1e9952ca989f..f7e8465c629a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -853,6 +853,11 @@ struct arm_smmu_master_domain {
>   	ioasid_t ssid;
>   };
>   
> +static inline unsigned int arm_smmu_strtab_max_sid(struct arm_smmu_device *smmu)

Nit: "max_sid" implies returning the largest supported StreamID value, 
so it would be logical to either include the "- 1" in here and adjust 
the other callers, or instead call this something like "num_sids".

Thanks,
Robin.

> +{
> +	return (1ULL << smmu->sid_bits);
> +}
> +
>   static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>   {
>   	return container_of(dom, struct arm_smmu_domain, domain);

