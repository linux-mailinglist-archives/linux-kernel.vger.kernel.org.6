Return-Path: <linux-kernel+bounces-288103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E849534EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84731F29A37
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37C1A00F8;
	Thu, 15 Aug 2024 14:31:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D1917BEC0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732302; cv=none; b=ZQT1tBa1g0l6G6g0MjhmTve7aBKuqWBd936BVF4WFBMz6W72fswcVU2gDO667+MPoArza3JZPXqG5dJycnM4HuecMoA2yJFe8dUSC2djbSm0UmUcVv2QSgdpMuN7eYzV/1utK/byq0gmh3AXu6Gpy8YwIqw4yan5agawwuNxB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732302; c=relaxed/simple;
	bh=wdPsUSN8wroJJs1E+BLLT7tv+WWAWafAl4/Qb0F5IYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mw7rkln8XW/f2uyZ3dWf/97qGjf2Zme2fTPkiAwlCssjMBQvA4S+BBlE+crC1ywF7/ZP7DtfYfEcciBsYudq4VhqIMddst9kOPAOWpp3PpYuQneLChoRj4V0NT/37MtTaDCzQ4qRL2sPNGgxdsmYFMRBMoXJZLAJ1pgHtxzv678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1665414BF;
	Thu, 15 Aug 2024 07:32:05 -0700 (PDT)
Received: from [10.1.36.19] (e122027.cambridge.arm.com [10.1.36.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9E603F58B;
	Thu, 15 Aug 2024 07:31:36 -0700 (PDT)
Message-ID: <72ad853a-cb65-42aa-829e-335362d2a4b5@arm.com>
Date: Thu, 15 Aug 2024 15:31:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/panfrost: Add SYSTEM_TIMESTAMP and
 SYSTEM_TIMESTAMP_FREQUENCY parameters
To: Mary Guillemard <mary.guillemard@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240814112121.61137-2-mary.guillemard@collabora.com>
 <20240814112121.61137-3-mary.guillemard@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240814112121.61137-3-mary.guillemard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2024 12:21, Mary Guillemard wrote:
> Expose system timestamp and frequency supported by the GPU.
> 
> Mali uses an external timer as GPU system time. On ARM, this is wired to
> the generic arch timer so we wire cntfrq_el0 as device frequency.
> 
> This new uAPI will be used in Mesa to implement timestamp queries and
> VK_KHR_calibrated_timestamps.
> 
> v2:
> - Rewrote to use GPU timestamp register
> - Add missing include for arch_timer_get_cntfrq
> - Rework commit message
> 
> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c  | 35 ++++++++++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c  | 12 ++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.h  |  1 +
>  drivers/gpu/drm/panfrost/panfrost_regs.h |  2 ++
>  include/uapi/drm/panfrost_drm.h          |  2 ++
>  5 files changed, 52 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 671eed4ad890..83696d06d697 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -3,6 +3,10 @@
>  /* Copyright 2019 Linaro, Ltd., Rob Herring <robh@kernel.org> */
>  /* Copyright 2019 Collabora ltd. */
>  
> +#ifdef CONFIG_ARM_ARCH_TIMER
> +#include <asm/arch_timer.h>
> +#endif
> +
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pagemap.h>
> @@ -24,10 +28,26 @@
>  static bool unstable_ioctls;
>  module_param_unsafe(unstable_ioctls, bool, 0600);
>  
> +static int panfrost_ioctl_query_timestamp(struct panfrost_device *pfdev,
> +					  u64 *arg)
> +{
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(pfdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	*arg = panfrost_timestamp_read(pfdev);
> +
> +	pm_runtime_put(pfdev->dev);
> +	return 0;
> +}
> +
>  static int panfrost_ioctl_get_param(struct drm_device *ddev, void *data, struct drm_file *file)
>  {
>  	struct drm_panfrost_get_param *param = data;
>  	struct panfrost_device *pfdev = ddev->dev_private;
> +	int ret;
>  
>  	if (param->pad != 0)
>  		return -EINVAL;
> @@ -69,6 +89,21 @@ static int panfrost_ioctl_get_param(struct drm_device *ddev, void *data, struct
>  		PANFROST_FEATURE_ARRAY(JS_FEATURES, js_features, 15);
>  		PANFROST_FEATURE(NR_CORE_GROUPS, nr_core_groups);
>  		PANFROST_FEATURE(THREAD_TLS_ALLOC, thread_tls_alloc);
> +
> +	case DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP:
> +		ret = panfrost_ioctl_query_timestamp(pfdev, &param->value);
> +		if (ret)
> +			return ret;
> +		break;
> +
> +	case DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP_FREQUENCY:
> +#ifdef CONFIG_ARM_ARCH_TIMER
> +		param->value = arch_timer_get_cntfrq();
> +#else
> +		param->value = 0;
> +#endif
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index fd8e44992184..92de71725f53 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -380,6 +380,18 @@ unsigned long long panfrost_cycle_counter_read(struct panfrost_device *pfdev)
>  	return ((u64)hi << 32) | lo;
>  }
>  
> +unsigned long long panfrost_timestamp_read(struct panfrost_device *pfdev)
> +{
> +	u32 hi, lo;
> +
> +	panfrost_cycle_counter_get(pfdev);
> +	hi = gpu_read(pfdev, GPU_TIMESTAMP_HI);
> +	lo = gpu_read(pfdev, GPU_TIMESTAMP_LO);

To get a reliable timestamp you need to use the hi-lo-hi trick:

do {
	hi = gpu_read(pfdev, GPU_TIMESTAMP_HI);
	lo = gpu_read(pfdev, GPU_TIMESTAMP_LO);
} while (hi != gpu_read(pfdev, GPU_TIMESTAMP_HI);

Otherwise if you read around the point of overflowing from LO to HI
you'll get a value which is 2^32 out - see panfrost_cycle_counter_read().

I'm also a little concerned that we have a different API here -
panfrost_cycle_counter_read() assumes that the cycle counter has been
enabled by the caller, but this doesn't. It would be nice to keep these
two functions consistent (i.e. move the get/put into
panfrost_ioctl_query_timestamp()).

Steve

> +	panfrost_cycle_counter_put(pfdev);
> +
> +	return ((u64)hi << 32) | lo;
> +}
> +
>  static u64 panfrost_get_core_mask(struct panfrost_device *pfdev)
>  {
>  	u64 core_mask;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.h b/drivers/gpu/drm/panfrost/panfrost_gpu.h
> index d841b86504ea..b4fef11211d5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.h
> @@ -20,6 +20,7 @@ void panfrost_gpu_suspend_irq(struct panfrost_device *pfdev);
>  void panfrost_cycle_counter_get(struct panfrost_device *pfdev);
>  void panfrost_cycle_counter_put(struct panfrost_device *pfdev);
>  unsigned long long panfrost_cycle_counter_read(struct panfrost_device *pfdev);
> +unsigned long long panfrost_timestamp_read(struct panfrost_device *pfdev);
>  
>  void panfrost_gpu_amlogic_quirk(struct panfrost_device *pfdev);
>  
> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
> index c25743b05c55..c7bba476ab3f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
> @@ -78,6 +78,8 @@
>  
>  #define GPU_CYCLE_COUNT_LO		0x90
>  #define GPU_CYCLE_COUNT_HI		0x94
> +#define GPU_TIMESTAMP_LO		0x98
> +#define GPU_TIMESTAMP_HI		0x9C
>  
>  #define GPU_THREAD_MAX_THREADS		0x0A0	/* (RO) Maximum number of threads per core */
>  #define GPU_THREAD_MAX_WORKGROUP_SIZE	0x0A4	/* (RO) Maximum workgroup size */
> diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
> index 9f231d40a146..52b050e2b660 100644
> --- a/include/uapi/drm/panfrost_drm.h
> +++ b/include/uapi/drm/panfrost_drm.h
> @@ -172,6 +172,8 @@ enum drm_panfrost_param {
>  	DRM_PANFROST_PARAM_NR_CORE_GROUPS,
>  	DRM_PANFROST_PARAM_THREAD_TLS_ALLOC,
>  	DRM_PANFROST_PARAM_AFBC_FEATURES,
> +	DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP,
> +	DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP_FREQUENCY,
>  };
>  
>  struct drm_panfrost_get_param {


