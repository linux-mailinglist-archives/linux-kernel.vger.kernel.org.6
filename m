Return-Path: <linux-kernel+bounces-310943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C55896831D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D780A1F21BD6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100E41C3317;
	Mon,  2 Sep 2024 09:23:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518AD1C2DB0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268994; cv=none; b=HNrzXZEGjhaE7GpFqsPk6xvnZ5f2o5//7g00UHNmbYbEGRH4r/lYtF66im44KQnXNFCwN8IIcEHqrGsCLtcJoO+VtBke1GaihH/chwHUXQelopjJD2zyLW0COeykZr+AX5EDRotEj2y6VgxIe3Kw95UqzUn9TENpN/0hCNJciY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268994; c=relaxed/simple;
	bh=3dZ+qMEdTPAnExXnKwgW7L+RBL/mU1jNp+/RCwY3Eag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DFaBirLalcfYJpovbti/2UsZTTZjRXHnF58Ukf/UXrm72Ve603UaD8K9PHpCgVdyvhfp0pPRr9P2fNGS+yd0BLaCA8lX5rr4UxoZcKM3KHbWoMnffiL9mvf7VS1E3IrXN9QcZd2WD/vesQCD6Z5A6PDz/FIbwd2V4aoYLhVYjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3890FEC;
	Mon,  2 Sep 2024 02:23:38 -0700 (PDT)
Received: from [10.57.74.147] (unknown [10.57.74.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 887C83F73F;
	Mon,  2 Sep 2024 02:23:10 -0700 (PDT)
Message-ID: <33ff88fc-0372-48ed-b66e-85841eda83aa@arm.com>
Date: Mon, 2 Sep 2024 10:23:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] drm/panthor: Use the BITS_PER_LONG macro
To: Jinjie Ruan <ruanjinjie@huawei.com>, boris.brezillon@collabora.com,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240831024532.455361-1-ruanjinjie@huawei.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240831024532.455361-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/08/2024 03:45, Jinjie Ruan wrote:
> sizeof(unsigned long) * 8 is the number of bits in an unsigned long
> variable, replace it with BITS_PER_LONG macro to make them simpler.
> 
> And fix the warning:
> 	WARNING: Comparisons should place the constant on the right side of the test
> 	#23: FILE: drivers/gpu/drm/panthor/panthor_mmu.c:2696:
> 	+       if (BITS_PER_LONG < va_bits) {
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d47972806d50..2a0c46391374 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2693,7 +2693,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	 * which passes iova as an unsigned long. Patch the mmu_features to reflect this
>  	 * limitation.
>  	 */
> -	if (sizeof(unsigned long) * 8 < va_bits) {
> +	if (va_bits > BITS_PER_LONG) {
>  		ptdev->gpu_info.mmu_features &= ~GENMASK(7, 0);
>  		ptdev->gpu_info.mmu_features |= sizeof(unsigned long) * 8;

Can you fix this to BITS_PER_LONG too? Since this code is clamping the
value in mmu_features it looks really odd to have the new value written
differently to the test in the 'if' statement.

Also, a minor point, but the "-next" tag in the subject is
pointless/confusing - this code is in mainline already (merged for
v6.10-rc1).

Thanks,
Steve

