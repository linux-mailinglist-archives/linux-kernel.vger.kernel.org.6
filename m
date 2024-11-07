Return-Path: <linux-kernel+bounces-400182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAD89C0A0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237591F25F38
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6590E212F0E;
	Thu,  7 Nov 2024 15:26:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6F1714DF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993190; cv=none; b=GA9G7sxLd0DIVB+7tLJ60AruHqsum5fyZXdmaL5IQB1ES5H6gJazgdocfQxqIx4LSboWeVJva6PhdF1zcpjkH9CjjnSEco15snkuwnplBQbdtvON00jBBRWR4GJaUJVpG8Larme0P+UfHRnLl8j5akbiuwPkbNCT0uEHNobyLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993190; c=relaxed/simple;
	bh=Yuhvg2ti1GojkBt+AHIcsCE7rRpAXVsGBTLi80LI8jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLBqtZmkoUxVRQ4GYOmvSzH9gfi3mJdKtKunQM6FNaIbwlH4MKtRYXrM5szmC4IwAeOFDknroU0tU/M0BMST445vOB7xkNTuIWRluNnWtSg7KrJ0BUPkY3hrTS6bljoVq80iInWD0jLquIO+77UGb9uUSVoPUemHHjqBnGNj2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 431E7497;
	Thu,  7 Nov 2024 07:26:55 -0800 (PST)
Received: from [10.1.30.33] (e122027.cambridge.arm.com [10.1.30.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 988043F66E;
	Thu,  7 Nov 2024 07:26:23 -0800 (PST)
Message-ID: <695172f7-4ccb-488a-b49f-605caae99cc2@arm.com>
Date: Thu, 7 Nov 2024 15:26:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Lock XArray when getting entries for the
 VM
To: Liviu Dudau <liviu.dudau@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>
References: <20241106185806.389089-1-liviu.dudau@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241106185806.389089-1-liviu.dudau@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2024 18:58, Liviu Dudau wrote:
> Similar to cac075706f29 ("drm/panthor: Fix race when converting
> group handle to group object") we need to use the XArray's internal
> locking when retrieving a vm pointer from there.
> 
> v2: Removed part of the patch that was trying to protect fetching
> the heap pointer from XArray, as that operation is protected by
> the @pool->lock.
> 
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> Reported-by: Jann Horn <jannh@google.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Pushed to drm-misc-fixes.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 8ca85526491e6..46b84a557d9cc 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1580,7 +1580,9 @@ panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 handle)
>  {
>  	struct panthor_vm *vm;
>  
> +	xa_lock(&pool->xa);
>  	vm = panthor_vm_get(xa_load(&pool->xa, handle));
> +	xa_unlock(&pool->xa);
>  
>  	return vm;
>  }


