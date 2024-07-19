Return-Path: <linux-kernel+bounces-257360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A43A2937908
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7981F22D76
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8B3143C5C;
	Fri, 19 Jul 2024 14:15:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E814532F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398502; cv=none; b=VCGwv/hZW9mJwl8kkEvpK4xEZB2nZzL+wRyYEs75nWKBiTsuN29XkBTANP+ZWEB9fRbN1utTM1jpy8UOeD/Ab2ibZzIlOqBwOOl9WRU+ZGqvshJrm0ZOwbzbSvro4iR4yxtl37xrUaR496EsqRjLCJ1P2GcII6VpxXuElc71x7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398502; c=relaxed/simple;
	bh=MK1okK1wR/QQVMKEqO1OlzNjFMPixTL2of3FByiAcDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEvU7/k4Zmiv8GKdWHaRtmKX5KecDMoo14Ui7ELIrjR8ylCW3KL28f7RKz2OrbDEIq7Mf6U5fosbNJY8SzsBYbWCOdoqFQYWIqY0e3N6HUyabMKCnO4oV5REbJARQttGp6Ev61rfUaZm0sShQvxEl6kCwu1mSBdrOUO/fb/zBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 480061042;
	Fri, 19 Jul 2024 07:15:25 -0700 (PDT)
Received: from [10.1.38.23] (e122027.cambridge.arm.com [10.1.38.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B5EE3F73F;
	Fri, 19 Jul 2024 07:14:57 -0700 (PDT)
Message-ID: <41847d59-c81c-4d73-9ed4-c3b8ae62eb67@arm.com>
Date: Fri, 19 Jul 2024 15:14:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] drm/panthor: enable fdinfo for memory stats
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240716201302.2939894-1-adrian.larumbe@collabora.com>
 <20240716201302.2939894-4-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240716201302.2939894-4-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/07/2024 21:11, Adrián Larumbe wrote:
> Implement drm object's status callback.
> 
> Also, we consider a PRIME imported BO to be resident if its matching
> dma_buf has an open attachment, which means its backing storage had already
> been allocated.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_gem.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index 38f560864879..c60b599665d8 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -145,6 +145,17 @@ panthor_gem_prime_export(struct drm_gem_object *obj, int flags)
>  	return drm_gem_prime_export(obj, flags);
>  }
>  
> +static enum drm_gem_object_status panthor_gem_status(struct drm_gem_object *obj)
> +{
> +	struct panthor_gem_object *bo = to_panthor_bo(obj);
> +	enum drm_gem_object_status res = 0;
> +
> +	if (bo->base.base.import_attach || bo->base.pages)
> +		res |= DRM_GEM_OBJECT_RESIDENT;
> +
> +	return res;
> +}
> +
>  static const struct drm_gem_object_funcs panthor_gem_funcs = {
>  	.free = panthor_gem_free_object,
>  	.print_info = drm_gem_shmem_object_print_info,
> @@ -154,6 +165,7 @@ static const struct drm_gem_object_funcs panthor_gem_funcs = {
>  	.vmap = drm_gem_shmem_object_vmap,
>  	.vunmap = drm_gem_shmem_object_vunmap,
>  	.mmap = panthor_gem_mmap,
> +	.status = panthor_gem_status,
>  	.export = panthor_gem_prime_export,
>  	.vm_ops = &drm_gem_shmem_vm_ops,
>  };


