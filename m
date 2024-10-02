Return-Path: <linux-kernel+bounces-347995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD17398E147
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9029C281C06
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3AF1D14E3;
	Wed,  2 Oct 2024 16:58:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5616419
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888301; cv=none; b=ti5JYvuUC9/yFUPu0/oWS713icjSSmrocYYqkFOYk0eelPpFQCgpO7+iTSPBi6XR/y5jM7tKM8h2+IWpOeniYWhYIo2OIVABZjN2hoqLdYeDJYG0gZO3v5K0ItKkF/HNWpP5qjZYjct1R/+BT9yUxK6CMJaPS0rYVWsmo7T90l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888301; c=relaxed/simple;
	bh=g/h1vr4NQSEaTJ80wST7E2pG2lct8fhCkRc2zYyLu7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTePX16CsYryZsSM74BpM9dcYfoR45qE1FyJYjtOZvjEdpVlLu48Utsq1vPEEbejJLYvqkbWGM2zsKC8b7lMyYUF0vnBl1LNVxiaKjsBRqJMpOf4h6Jm856397qCIOkLQ/dnCC/tdIm/740WhAV9/b0WGDTvsBnW04ge0VSHVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8C3B339;
	Wed,  2 Oct 2024 09:58:48 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 006D43F64C;
	Wed,  2 Oct 2024 09:58:17 -0700 (PDT)
Message-ID: <ffb88c7e-ad62-4e87-a516-ebaafa377898@arm.com>
Date: Wed, 2 Oct 2024 17:58:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
 <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
 <20241001191800.GA1369530@ziepe.ca>
 <0e84f3c0-09d6-4485-ac76-ca296d1ee07e@os.amperecomputing.com>
 <20241001194620.GB1369530@ziepe.ca>
 <e374e8ec-29db-48a2-95d7-6fc9ac6317d9@os.amperecomputing.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <e374e8ec-29db-48a2-95d7-6fc9ac6317d9@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 01/10/2024 21:47, Yang Shi wrote:
> On 10/1/24 12:46 PM, Jason Gunthorpe wrote:
>> On Tue, Oct 01, 2024 at 12:38:56PM -0700, Yang Shi wrote:
>>>
>>> On 10/1/24 12:18 PM, Jason Gunthorpe wrote:
>>>> On Tue, Oct 01, 2024 at 12:09:03PM -0700, Yang Shi wrote:
>>>>>> Also, there are other places doing "1 << smmu->sid_bits", e.g.
>>>>>> arm_smmu_init_strtab_linear().
>>>>> The disassembly shows it uses "sbfiz x21, x20, 6, 32" instead of lsl. 1UL
>>>>> should be used if we want to take extra caution and don't prefer rely on
>>>>> compiler.
>>>> Still, we should be fixing them all if sid_bits == 32, all those
>>>> shifts should be throwing a UBSAN error. It would be crazy to have a
>>> OK, will cover this is v2.
>> Maybe just make a little inline function to do this math and remove
>> the repated open coding? Then the types can be right, etc.
> 
> Something like this?
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 01a2faee04bc..0f3aa7962117 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3624,8 +3624,9 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>  {
>         u32 l1size;
>         struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> +       unsigned int max_sid = arm_smmu_strtab_max_sid(smmu->sid_bits);
>         unsigned int last_sid_idx =
> -               arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);
> +               arm_smmu_strtab_l1_idx(max_sid - 1);
> 
>         /* Calculate the L1 size, capped to the SIDSIZE. */
>         cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
> @@ -3657,8 +3658,9 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>  {
>         u32 size;
>         struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> +       unsigned int max_sid = arm_smmu_strtab_max_sid(smmu->sid_bits);
> 
> -       size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
> +       size = max_sid * sizeof(struct arm_smmu_ste);
>         cfg->linear.table = dmam_alloc_coherent(smmu->dev, size,
> &cfg->linear.ste_dma,
>                                                 GFP_KERNEL);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 1e9952ca989f..de9f14293485 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -235,6 +235,11 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
>         return sid % STRTAB_NUM_L2_STES;
>  }
> 
> +static inline unsigned int arm_smmu_strtab_max_sid(unsigned int sid_bits)
> +{
> +       return (1UL << sid_bits);
> +}
> +

On the same platform - this also fixes the issue:
Tested-by: James Morse <james.morse@arm.com>


Thanks,

James

