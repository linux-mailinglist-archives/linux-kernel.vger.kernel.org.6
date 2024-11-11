Return-Path: <linux-kernel+bounces-403981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6C9C3D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11BE284E67
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65662199249;
	Mon, 11 Nov 2024 11:31:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6421991AA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324678; cv=none; b=NhvjjfyUVg9DNFf5BNMP8wIMGb/o3odUYP5Vc1mpWvxWnnlv8MLLB2/ETFXZFtsGk9oC8gzgrE+M3clkGtOvRD26i2UnZLRgh0DhxyZlKx+sE+05cvEDAaWJiFUbFZkF+6AsNzhAxYBRJn91FJ628uqYYcjXuRVnoIAbA4BAaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324678; c=relaxed/simple;
	bh=P6IqENS6xfIuFFZgeNsg4qDCruzvn+4syWoHMlvrRWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjApuve5HKzERWd54KI/bU1amTf8Fh8+36pAET0h/a0oiTsPYebKXrBloSgJO9J/3VCaOoyX8zOVPnA7M9DywPzGxXlea9MnHeWlSq4F2Sslmb3kQ3LBOkqGkRh+wESIXSCw/vLqlLgfH9u2R2wq5eILQ6nudDg2sceY19BxHak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 126DA1D14;
	Mon, 11 Nov 2024 03:31:45 -0800 (PST)
Received: from [10.1.26.32] (e122027.cambridge.arm.com [10.1.26.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A33D3F6A8;
	Mon, 11 Nov 2024 03:31:13 -0800 (PST)
Message-ID: <bff9ae58-8587-4f44-a797-d919770978aa@arm.com>
Date: Mon, 11 Nov 2024 11:31:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Fix handling of partial GPU mapping of BOs
To: Akash Goel <akash.goel@arm.com>, boris.brezillon@collabora.com,
 liviu.dudau@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mihail.atanassov@arm.com, ketil.johnsen@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
References: <20241111092621.763285-1-akash.goel@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241111092621.763285-1-akash.goel@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2024 09:26, Akash Goel wrote:
> This commit fixes the handling of partial GPU mapping of buffer objects
> in Panthor.
> VM_BIND ioctl allows Userspace to partially map the BOs to GPU.
> To map a BO, Panthor walks through the sg_table to retrieve the physical
> address of pages. If the mapping is created at an offset into the BO,
> then the scatterlist(s) at the beginning have to be skipped to reach the
> one corresponding to the offset. But the case where the offset didn't
> point to the first page of desired scatterlist wasn't handled correctly.
> The bug caused the partial GPU mapping of BO to go wrong for the said
> case, as the pages didn't get map at the expected virtual address and
> consequently there were kernel warnings on unmap.
> 
> Signed-off-by: Akash Goel <akash.goel@arm.com>

Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d8cc9e7d064e..6bc188d9a9ad 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -957,6 +957,7 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
>  
>  		paddr += offset;
>  		len -= offset;
> +		offset = 0;
>  		len = min_t(size_t, len, size);
>  		size -= len;
>  


