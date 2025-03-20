Return-Path: <linux-kernel+bounces-570257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B46AA6AE13
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED497ABE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FE4227E9C;
	Thu, 20 Mar 2025 19:03:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72EC1E8339
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497419; cv=none; b=LWarBoRmEn4/QWRBX9Khqf1GsRc0AWyv+68tlXkJvXXrn83N1U68Tjtxg4hfJugeVrul94i+7xIVhxn1G+qHqvhuhF2ADvN6At/tuXmC5DyeRYibScoD/6XMXlCSuGRaCj5Ewtq3VYfEO7cr0+dwAPGGu9RgH9o9ppf24/56VGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497419; c=relaxed/simple;
	bh=mm+dj8wSs978+mApZ/0we3RAsELyN7uir68uaj2JFRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afDpT77ioyLrztTiguB4Xg0Gf3yoXhS+EcSce+AfaUTXMtzW78G3u/8dSmbpsWzJCScq+s0d55yi55GFd74zdOhDeHd22BEIzdU46K/o/NmLMll7tjT+k+dCtd/+tDAMoeuVZHhsHSvKXh16ar8LdfwkdC0tmd6Tw+vH82w254o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B4381424
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:03:43 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA7DD3F63F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:03:35 -0700 (PDT)
Date: Thu, 20 Mar 2025 19:03:24 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] drm/panthor: Add support for Mali-G710,
 Mali-G510, and Mali-G310
Message-ID: <Z9xmfJDCEz_-u8PH@e110455-lin.cambridge.arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
 <20250320111741.1937892-10-karunika.choo@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250320111741.1937892-10-karunika.choo@arm.com>

On Thu, Mar 20, 2025 at 11:17:41AM +0000, Karunika Choo wrote:
> This patch adds GPU model name and FW binary support for Mali-G710,
> Mali-G510, and Mali-G310.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 2 ++
>  drivers/gpu/drm/panthor/panthor_hw.c | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 8a967af0e2b4..7050adfaa8b6 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1398,6 +1398,8 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  }
>  
>  MODULE_FIRMWARE("arm/mali/arch10.8/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch10.10/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch10.12/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch12.8/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch13.8/mali_csffw.bin");

Firmware available for testing here:

https://gitlab.com/dliviu/linux-firmware

Best regards,
Liviu

> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index e6354304bbef..6f18b7420f90 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -49,8 +49,14 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>  	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
>  
>  	switch (product_id) {
> +	case GPU_PROD_ID_MAKE(10, 2):
> +		return "Mali-G710";
>  	case GPU_PROD_ID_MAKE(10, 7):
>  		return "Mali-G610";
> +	case GPU_PROD_ID_MAKE(10, 3):
> +		return "Mali-G510";
> +	case GPU_PROD_ID_MAKE(10, 4):
> +		return "Mali-G310";
>  	case GPU_PROD_ID_MAKE(11, 2):
>  		if (shader_core_count > 10 && ray_intersection)
>  			return "Mali-G715-Immortalis";
> -- 
> 2.47.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

