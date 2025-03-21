Return-Path: <linux-kernel+bounces-570902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46937A6B60E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C76127A4A95
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8E1EF0A6;
	Fri, 21 Mar 2025 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c7yBHCqq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A9A17C210
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742545704; cv=none; b=GM5ttWYztAEh32MVcPz5M1zBQcjQ/ysFtJh258K5NsDYlyZ1o1BkwGN1TBSAR3f0zxJb3AJzZh0CDQ5PF/hIONIWuOaxIFi2nD0JW+0x9HqHYlvQ9F5cQlkI4eFWEUseMaKP998R6pagRChLkTTHmkar2nQhYw1oru0CDI3FzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742545704; c=relaxed/simple;
	bh=3zmNVpWdo3j6NDIPP6/8TVQkTX3zooLzL7cRQn0r3PI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrSa7BiwgVOC34lZFNF/Ji92ZKOEB2qKBdqfQuCtI2Sa3UkoHQfDSTsq4/mtcH9/YDVOaydr+IHESh1mE2X7YvRdnEizc0IezaoZcLK14T0WxT+0vJUoZzZPMObFM0Rm2KfQ2aOdqYDSgGz9qsbSLHtOKsY6imC9GMnOfkeOh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c7yBHCqq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742545700;
	bh=3zmNVpWdo3j6NDIPP6/8TVQkTX3zooLzL7cRQn0r3PI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c7yBHCqqEcr7dG7McbMN5i359ZQyXBDAaTo1mzPtrMcbgh6IEs6GjMfySGGLF0Ni/
	 PQshbqKHNcrjRxC5T7ycPpM+zp5TYEWLDktzpBOMVlv21M8dNAOg9qWwYfkOiAspYe
	 /5WbWw2YDvev7h+ZAWEoyyBUdwUa8znxlPmwlhHGScgHbSnIgbkxpGiyeXrRL9picX
	 CqemaURuKgGVU4X3+uNDfteO8MJfwqb0/k38Ce0+QIbu4HXQe+hp3YlNesvKCz/jhK
	 bNS2LwPwrVG2AiIPf2dQQ22McG3DYoY7DuNLvwuveMQdvWe0zDiaSXEJAtEqn1bN6Z
	 iNlnAMjPBgYEw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2BAC117E0147;
	Fri, 21 Mar 2025 09:28:20 +0100 (CET)
Date: Fri, 21 Mar 2025 09:28:15 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] drm/panthor: Add GPU specific initialization
 framework
Message-ID: <20250321092815.66ab1798@collabora.com>
In-Reply-To: <20250320111741.1937892-4-karunika.choo@arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
	<20250320111741.1937892-4-karunika.choo@arm.com>
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

On Thu, 20 Mar 2025 11:17:35 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> This patch aims to lay the foundation to provide support for multiple
> Mali GPUs through a framework by which differences in registers,
> functionality, and features can be managed.
> 
> It introduces the concept of the arch_id which is a 32-bit ID in the
> format of ((arch_major << 16) | (arch_minor << 8) | arch_rev). The 8-bit
> fields of the arch_id provides future proofing past the 4-bit fields of
> the GPU_ID's arch_major, arch_minor, and arch_rev.
> 
> The arch_id is used to select the correct abstraction for the GPU, such
> as function pointers for operations specific to the GPU, base addresses
> describing changes in register offsets, and supported features.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/Makefile         |  1 +
>  drivers/gpu/drm/panthor/panthor_device.c |  5 ++
>  drivers/gpu/drm/panthor/panthor_device.h |  3 +
>  drivers/gpu/drm/panthor/panthor_hw.c     | 70 ++++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_hw.h     | 63 +++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_regs.h   |  2 +
>  6 files changed, 144 insertions(+)
>  create mode 100644 drivers/gpu/drm/panthor/panthor_hw.c
>  create mode 100644 drivers/gpu/drm/panthor/panthor_hw.h
> 
> diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
> index 15294719b09c..02db21748c12 100644
> --- a/drivers/gpu/drm/panthor/Makefile
> +++ b/drivers/gpu/drm/panthor/Makefile
> @@ -8,6 +8,7 @@ panthor-y := \
>  	panthor_gem.o \
>  	panthor_gpu.o \
>  	panthor_heap.o \
> +	panthor_hw.o \
>  	panthor_mmu.o \
>  	panthor_sched.o
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index a9da1d1eeb70..a6fca6b3fabd 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -18,6 +18,7 @@
>  #include "panthor_device.h"
>  #include "panthor_fw.h"
>  #include "panthor_gpu.h"
> +#include "panthor_hw.h"
>  #include "panthor_mmu.h"
>  #include "panthor_regs.h"
>  #include "panthor_sched.h"
> @@ -243,6 +244,10 @@ int panthor_device_init(struct panthor_device *ptdev)
>  			return ret;
>  	}
>  
> +	ret = panthor_hw_init(ptdev);
> +	if (ret)
> +		goto err_rpm_put;
> +
>  	ret = panthor_gpu_init(ptdev);
>  	if (ret)
>  		goto err_rpm_put;
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index da6574021664..82741bf1a49b 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -120,6 +120,9 @@ struct panthor_device {
>  	/** @csif_info: Command stream interface information. */
>  	struct drm_panthor_csif_info csif_info;
>  
> +	/** @hw: GPU specific data. */
> +	struct panthor_hw *hw;
> +
>  	/** @gpu: GPU management data. */
>  	struct panthor_gpu *gpu;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> new file mode 100644
> index 000000000000..234bfd50cf0d
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +/* Copyright 2025 ARM Limited. All rights reserved. */
> +
> +#include "panthor_device.h"
> +#include "panthor_hw.h"
> +#include "panthor_regs.h"
> +
> +static struct panthor_hw panthor_hw_devices[] = {
> +	{
> +		.arch_id = GPU_ARCH_ID_MAKE(10, 0, 0),
> +		.arch_mask = GPU_ARCH_ID_MAKE(0xFF, 0, 0),
> +	},
> +};
> +
> +static int init_gpu_id(struct panthor_device *ptdev)
> +{
> +	ptdev->gpu_info.gpu_id = gpu_read(ptdev, GPU_ID);
> +
> +	if (!ptdev->gpu_info.gpu_id) {
> +		drm_err(&ptdev->base, "Invalid GPU ID (0x0)");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
> +int panthor_hw_init(struct panthor_device *ptdev)
> +{
> +	struct panthor_hw *hdev = NULL;
> +	u32 arch_id = 0;
> +	int i, ret;
> +
> +	ret = init_gpu_id(ptdev);
> +	if (ret)
> +		return ret;
> +
> +	arch_id = GPU_ARCH_ID_MAKE(GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id),
> +				   GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id),
> +				   GPU_ARCH_REV(ptdev->gpu_info.gpu_id));
> +	if (!arch_id) {
> +		drm_err(&ptdev->base, "Invalid arch_id (0x0)");
> +		return -ENXIO;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(panthor_hw_devices); i++) {
> +		u32 mask = panthor_hw_devices[i].arch_mask;
> +		u32 hw_arch_id = panthor_hw_devices[i].arch_id;
> +
> +		if ((arch_id & mask) == (hw_arch_id & mask)) {
> +			hdev = &panthor_hw_devices[i];
> +			break;
> +		}
> +	}
> +
> +	if (!hdev) {
> +		drm_err(&ptdev->base, "Unsupported GPU (arch 0x%x)", arch_id);
> +		return -ENODEV;
> +	}
> +
> +	ptdev->hw = hdev;
> +
> +	return 0;
> +}
> +
> +bool panthor_hw_supports(struct panthor_device *ptdev,
> +			 enum panthor_hw_feature feature)
> +{
> +	return test_bit(feature, ptdev->hw->features);
> +}
> +
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> new file mode 100644
> index 000000000000..5eb0549ad333
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
> +/* Copyright 2025 ARM Limited. All rights reserved. */
> +
> +#ifndef __PANTHOR_HW_H__
> +#define __PANTHOR_HW_H__
> +
> +#include <linux/types.h>
> +#include <linux/bitmap.h>
> +
> +struct panthor_device;
> +
> +/**
> + * enum panthor_hw_feature - Bit position of each HW feature
> + *
> + * Used to define GPU specific features based on the GPU architecture ID.
> + * New feature flags will be added with support for newer GPU architectures.
> + */
> +enum panthor_hw_feature {
> +	/** @PANTHOR_HW_FEATURES_END: Must be last. */
> +	PANTHOR_HW_FEATURES_END
> +};
> +
> +/**
> + * struct panthor_hw_regmap - Register offsets for specific register blocks
> + */
> +struct panthor_hw_regmap {
> +
> +};
> +
> +/**
> + * struct panthor_hw_ops - HW operations that are specific to a GPU
> + */
> +struct panthor_hw_ops {
> +
> +};
> +
> +/**
> + * struct panthor_hw - GPU specific register mapping and functions
> + */
> +struct panthor_hw {
> +	/** @arch_id: Architecture id to match against */
> +	u32 arch_id;
> +
> +	/** @arch_mask: Mask for architecture id comparison */
> +	u32 arch_mask;
> +
> +	/** @features: Bitmap containing panthor_hw_feature */
> +	DECLARE_BITMAP(features, PANTHOR_HW_FEATURES_END);
> +
> +	/** @map: Panthor regmap */
> +	struct panthor_hw_regmap map;
> +
> +	/** @ops: Panthor HW specific operations */
> +	struct panthor_hw_ops ops;

Do we really need per minor arch specialization if we already have per
GPU information through panthor_model?

The way I see it, we can have a device operation specialization per
major arch, then some tweaking done in the arch major init callback
based on the minor version. And the final tweaks applied per GPU model.

> +};
> +
> +int panthor_hw_init(struct panthor_device *ptdev);
> +
> +bool panthor_hw_supports(struct panthor_device *ptdev,
> +			 enum panthor_hw_feature feature);
> +
> +#endif /* __PANTHOR_HW_H__ */
> +
> diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
> index 7ec4a1d04e20..ba452c1dd644 100644
> --- a/drivers/gpu/drm/panthor/panthor_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_regs.h
> @@ -19,6 +19,8 @@
>  #define   GPU_VER_MINOR(x)				(((x) & GENMASK(11, 4)) >> 4)
>  #define   GPU_VER_STATUS(x)				((x) & GENMASK(3, 0))
>  
> +#define GPU_ARCH_ID_MAKE(major, minor, rev)		(((major) << 16) | ((minor) << 8) | (rev))
> +
>  #define GPU_L2_FEATURES					0x4
>  #define  GPU_L2_FEATURES_LINE_SIZE(x)			(1 << ((x) & GENMASK(7, 0)))
>  


