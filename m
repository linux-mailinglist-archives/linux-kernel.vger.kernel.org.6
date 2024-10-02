Return-Path: <linux-kernel+bounces-347994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D793998E146
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B514280EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5A01D0F79;
	Wed,  2 Oct 2024 16:58:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153E916419
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888295; cv=none; b=agLnq7F4pbfddvcuy996KoRnFED5bHlPLWRLRMgwqQT0ladNTlm8g95KVCwBXR2noekXPRWRTxH+Ok4p6MzDWFt66S3dVr48S8vncgbrd6lQmLrajEFoe/gtdGj/ZMiKB09XMat6DXKneZhkw1uqZtoO8t++zpTu5pmnCFlzo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888295; c=relaxed/simple;
	bh=kiL9n7LZagD4Ipn7zJIirkf4iS4rIEZQ4b/V8OvLTc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZKm9VeCKP+v688ik0ycho7Zk816VS2vAFNQX1GQsAa8Htjr/pSEE6TfgVK9fs7QmksUh8IHXhPAbE1vTlRKg5QrK+WhIjqexRf5r0afyT7rwOkM9CwoDdLkEu5KpUzKCvX7Be0zzu1XK9cK4FUuD6Ov8m9TDKwcrOdyCDEmKG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E086339;
	Wed,  2 Oct 2024 09:58:42 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D51ED3F64C;
	Wed,  2 Oct 2024 09:58:11 -0700 (PDT)
Message-ID: <d4b53bbb-333a-45b9-9eb0-23ddd0820a14@arm.com>
Date: Wed, 2 Oct 2024 17:58:09 +0100
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
To: Yang Shi <yang@os.amperecomputing.com>, jgg@ziepe.ca,
 nicolinc@nvidia.com, will@kernel.org, robin.murphy@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <20241001180346.1485194-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello!

On 01/10/2024 19:03, Yang Shi wrote:
> The commit ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
> calculated the last index of L1 stream table by 1 << smmu->sid_bits. 1
> is 32 bit value.
> However AmpereOne has 32-bit stream id size.  This resulted in
> ouf-of-bound shift.  The disassembly of shift is:
> 
>     ldr     w2, [x19, 828]  //, smmu_7(D)->sid_bits
>     mov     w20, 1
>     lsl     w20, w20, w2
> 
> According to ARM spec, if the registers are 32 bit, the instruction actually
> does:
>     dest = src << (shift % 32)
> 
> So it actually shifted by zero bit.
> 
> This caused v6.12-rc1 failed to boot on AmpereOne

Same here - one of arm's reference designs prints 1 giga-tonne of:
| arm-smmu-v3 arm-smmu-v3.5.auto: event 0x02 received:
| arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000c90000000002
| arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000000000000000
| arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000000000000000
| arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000000000000000

during boot - then fails to find the nvme.
Bisect points to ce410410f1a7, and the below diff fixes it.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 737c5b882355..01a2faee04bc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3625,7 +3625,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>  	u32 l1size;
>  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>  	unsigned int last_sid_idx =
> -		arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
> +		arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);
>  
>  	/* Calculate the L1 size, capped to the SIDSIZE. */
>  	cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);


Tested-by: James Morse <james.morse@arm.com>


Thanks,

James

