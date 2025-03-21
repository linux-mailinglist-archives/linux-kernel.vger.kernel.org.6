Return-Path: <linux-kernel+bounces-570883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F93A6B5C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D18C189A459
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13281EFFA5;
	Fri, 21 Mar 2025 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mIQIvL/b"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F401DE2DF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544183; cv=none; b=sHzM0z9zIbUR5/+DVtSgNUx3wspN2Kbb6WpvtIsQblJbgLCz740zcEkFdqLjUr/7qXp6ncGRTdHdvdUMra9y1f8pId/6WpqqRnk8R+rpqpr9TwzBbrErUt8pa+Rw4jchEUACm8JkYZl/ZCoPw9bOXu0x6GjZX4rDN4OL+05HTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544183; c=relaxed/simple;
	bh=rhsDyrz4zR+5L67y8VXAF6e+qnJE23mVLj+8WRtBdTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6P3FQA2lZ3tOKu8z5Q4PZK3l+B+BEo4dbfPmRUQr6ewxSKKUtBZIVsa+3xZi7yCJROj64Jt+7s0zSxHasUxiMkRh1LGtaRndMYX3Zf9+psFzVt1QgOJeUofIS5FcfoFAl1tDfDbLfi+eDNcGSYJcLKqZpSt96N7N10exDaWmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mIQIvL/b; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742544179;
	bh=rhsDyrz4zR+5L67y8VXAF6e+qnJE23mVLj+8WRtBdTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mIQIvL/bkBGDqsvLGdO61e5lAjksHiMgYpD/lx7tojgtIrNFjo0CKMaqiAkFGiv7/
	 d3UpG/rJFSKE8PATRzlp8EtqR+HniUSc7ZGoStM5zuXTTTwDeGZAVZ6iJQ8Ab6lbut
	 DZS7kId9eHAm7QqV/MPsOWQ1JDpSjEJ/01Rh9ObQnjPY9gWF4rpem1QFRxt6nCvnCw
	 2krctEMc8VLigDLiBMSb9r9H4D/mACaYE8sIiR7qZtwtBY0xe/TCEX49UZBu5jurD4
	 6tYaJk/6hm4vwJ83ctA2KPy56IE2EZW8V4sw6hGXEzPNDrKCMHgv0tX0tcFkKkhpNW
	 D2TMacjkNsIkQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AC18517E0C81;
	Fri, 21 Mar 2025 09:02:58 +0100 (CET)
Date: Fri, 21 Mar 2025 09:02:54 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] drm/panthor: Make getting GPU model name simple
 and extensible
Message-ID: <20250321090254.667a86cb@collabora.com>
In-Reply-To: <20250320111741.1937892-6-karunika.choo@arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
	<20250320111741.1937892-6-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 11:17:37 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> This patch replaces the previous panthor_model structure with a simple
> switch case based on the product_id, which is in the format of:
>         ((arch_major << 24) | product_major)
> 
> This not only simplifies the comparison, but also allows extending the
> function to accommodate naming differences based on GPU features.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_hw.c   | 63 +++++++-------------------
>  drivers/gpu/drm/panthor/panthor_regs.h |  1 +
>  2 files changed, 18 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 4cc4b0d5382c..12183c04cd21 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -5,40 +5,6 @@
>  #include "panthor_hw.h"
>  #include "panthor_regs.h"
>  
> -/**
> - * struct panthor_model - GPU model description
> - */
> -struct panthor_model {
> -	/** @name: Model name. */
> -	const char *name;
> -
> -	/** @arch_major: Major version number of architecture. */
> -	u8 arch_major;
> -
> -	/** @product_major: Major version number of product. */
> -	u8 product_major;
> -};
> -
> -/**
> - * GPU_MODEL() - Define a GPU model. A GPU product can be uniquely identified
> - * by a combination of the major architecture version and the major product
> - * version.
> - * @_name: Name for the GPU model.
> - * @_arch_major: Architecture major.
> - * @_product_major: Product major.
> - */
> -#define GPU_MODEL(_name, _arch_major, _product_major) \
> -{\
> -	.name = __stringify(_name),				\
> -	.arch_major = _arch_major,				\
> -	.product_major = _product_major,			\
> -}
> -
> -static const struct panthor_model gpu_models[] = {
> -	GPU_MODEL(g610, 10, 7),
> -	{},
> -};
> -
>  static void arch_10_8_gpu_info_init(struct panthor_device *ptdev)
>  {
>  	unsigned int i;
> @@ -66,29 +32,34 @@ static void arch_10_8_gpu_info_init(struct panthor_device *ptdev)
>  	ptdev->gpu_info.l2_present = gpu_read64(ptdev, GPU_L2_PRESENT_LO);
>  }
>  
> +static char *get_gpu_model_name(struct panthor_device *ptdev)
> +{
> +	const u32 gpu_id = ptdev->gpu_info.gpu_id;
> +	const u32 product_id = GPU_PROD_ID_MAKE(GPU_ARCH_MAJOR(gpu_id),
> +						GPU_PROD_MAJOR(gpu_id));
> +
> +	switch (product_id) {
> +	case GPU_PROD_ID_MAKE(10, 7):
> +		return "Mali-G610";
> +	}

I a big fan of these ever growing switch statements with nested
conditionals. Could we instead add an optional ::get_variant() callback
in panthor_model and have the following formatting:

	"Mali-%s%s%s", model->name,
		       model->get_variant ? "-" : "",
		       model->get_variant ? model->get_variant() : ""

> +
> +	return "(Unknown Mali GPU)";
> +}
> +
>  static void panthor_gpu_init_info(struct panthor_device *ptdev)
>  {
> -	const struct panthor_model *model;
> -	u32 arch_major, product_major;
> +	const char *gpu_model_name = get_gpu_model_name(ptdev);
>  	u32 major, minor, status;
>  
>  	ptdev->hw->ops.gpu_info_init(ptdev);
>  
> -	arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
> -	product_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
>  	major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
>  	minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
>  	status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
>  
> -	for (model = gpu_models; model->name; model++) {
> -		if (model->arch_major == arch_major &&
> -		    model->product_major == product_major)
> -			break;
> -	}
> -
>  	drm_info(&ptdev->base,
> -		 "mali-%s id 0x%x major 0x%x minor 0x%x status 0x%x",
> -		 model->name ?: "unknown", ptdev->gpu_info.gpu_id >> 16,
> +		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
> +		 gpu_model_name, ptdev->gpu_info.gpu_id >> 16,
>  		 major, minor, status);
>  
>  	drm_info(&ptdev->base,
> diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
> index ba452c1dd644..d9e0769d6f1a 100644
> --- a/drivers/gpu/drm/panthor/panthor_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_regs.h
> @@ -20,6 +20,7 @@
>  #define   GPU_VER_STATUS(x)				((x) & GENMASK(3, 0))
>  
>  #define GPU_ARCH_ID_MAKE(major, minor, rev)		(((major) << 16) | ((minor) << 8) | (rev))
> +#define GPU_PROD_ID_MAKE(arch_major, prod_major)	(((arch_major) << 24) | (prod_major))
>  
>  #define GPU_L2_FEATURES					0x4
>  #define  GPU_L2_FEATURES_LINE_SIZE(x)			(1 << ((x) & GENMASK(7, 0)))


