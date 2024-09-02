Return-Path: <linux-kernel+bounces-310975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E3E96837B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8461F22D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0801D1F6E;
	Mon,  2 Sep 2024 09:42:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BAD179654
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270156; cv=none; b=pa+vhp3nH46J5IYwvIx5iOP3T6/b3nfhzGK7kjzEsLD7QqRyAar/JQVeAeQQ9kYvCOlG3e/HPwNp+z44X/qPcn8t9b0BffVk29z6OIS5cgnb2pS9NC//IMXszWZWECqJfYurhRxsoM7a/Zv8eMBs9O+6p/CZ7YxBItXH/l5W1J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270156; c=relaxed/simple;
	bh=Maca3mRh6RpGRtFkSAyPI3bo7fSXEbYVB5sqwc2Idmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ce4f6AhpaG4pjxosl0RiHUoMJe4uwhH1Taak/pHiTdvr2szpFt7brgXbRZE/4B3Ndl/QCKy9Xf6ZmytahWQt1HYJyAFQBCig7pG8FByzqOduXBAP9+OBN/Q+jfoelrW2yISP4tvJEPPtvj7hmWbqYhNFGA6XfyB2evfOG1WUzBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1141FEC;
	Mon,  2 Sep 2024 02:42:59 -0700 (PDT)
Received: from [10.57.74.147] (unknown [10.57.74.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7E403F66E;
	Mon,  2 Sep 2024 02:42:31 -0700 (PDT)
Message-ID: <8c69e939-3019-45cb-9486-510ce7fcb78e@arm.com>
Date: Mon, 2 Sep 2024 10:42:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Use the BITS_PER_LONG macro
To: Jinjie Ruan <ruanjinjie@huawei.com>, boris.brezillon@collabora.com,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240902094404.1943710-1-ruanjinjie@huawei.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240902094404.1943710-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2024 10:44, Jinjie Ruan wrote:
> sizeof(unsigned long) * 8 is the number of bits in an unsigned long
> variable, replace it with BITS_PER_LONG macro to make them simpler.
> 
> And fix the warning:
> 	WARNING: Comparisons should place the constant on the right side of the test
> 	#23: FILE: drivers/gpu/drm/panthor/panthor_mmu.c:2696:
> 	+       if (BITS_PER_LONG < va_bits) {
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks, I'll push to drm-misc-next.

Steve

> ---
> v2:
> - Also fix for below mmu_features.
> - Remoove -next.
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index fa0a002b1016..7b1c345669b7 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2693,9 +2693,9 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	 * which passes iova as an unsigned long. Patch the mmu_features to reflect this
>  	 * limitation.
>  	 */
> -	if (sizeof(unsigned long) * 8 < va_bits) {
> +	if (va_bits > BITS_PER_LONG) {
>  		ptdev->gpu_info.mmu_features &= ~GENMASK(7, 0);
> -		ptdev->gpu_info.mmu_features |= sizeof(unsigned long) * 8;
> +		ptdev->gpu_info.mmu_features |= BITS_PER_LONG;
>  	}
>  
>  	return drmm_add_action_or_reset(&ptdev->base, panthor_mmu_release_wq, mmu->vm.wq);


