Return-Path: <linux-kernel+bounces-279235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264DC94BAD0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67B61F218C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB7189F3B;
	Thu,  8 Aug 2024 10:23:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8FC13AA31
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112638; cv=none; b=PM2jeNDQm6m63e4uUcOfKyTw+7n3Xi8oBoeF7sOUK33d+Yu5rpd7XWv7dxmqkVDFx7VOx3fRZ6+m2Ae8rCUAAK77IeifPEXdLeWYvllr+q2mGZI/5gWJtJ+Rrfau5cEdU9iCDfQs0LItmX3yMqNF5+ztZIek6q4x9JP8/frtxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112638; c=relaxed/simple;
	bh=xB2gDO5J2QGucCuS7UUMMS3iMugWnsEeWiQyM+lBA6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGfb0Im2GHrra/VgnS3dEbWcUl/8B7YCmz/yqI7xQ2+4710IyfoPeOid7VFinQOJr6ytg05pDJx5OcpA1lZO5A4HdhpPPOHwNOrgxNn6td5/FJ6FuG035ucnuEFZGHf7e/KJMvu84wZ4hEq9wHFbCcE64R1PzadkMqREeRuNVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2970EFEC;
	Thu,  8 Aug 2024 03:24:22 -0700 (PDT)
Received: from [10.1.26.21] (e122027.cambridge.arm.com [10.1.26.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19C913F766;
	Thu,  8 Aug 2024 03:23:53 -0700 (PDT)
Message-ID: <37be0bd0-219d-4e46-b17e-cde7f960becb@arm.com>
Date: Thu, 8 Aug 2024 11:23:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/panfrost: Add SYSTEM_TIMESTAMP and
 SYSTEM_TIMESTAMP_FREQUENCY parameters
To: Mary Guillemard <mary.guillemard@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240807160900.149154-1-mary.guillemard@collabora.com>
 <20240807160900.149154-2-mary.guillemard@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240807160900.149154-2-mary.guillemard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2024 17:08, Mary Guillemard wrote:
> Expose system timestamp and frequency supported by the GPU.
> 
> Mali uses the generic arch timer as GPU system time so we currently
> wire cntvct_el0 and cntfrq_el0 respectively to those parameters.
> We could have directly read those values from userland but handling
> this here allows us to be future proof in case of errata related to
> timers for example.

I'm not sure what the benefit is for the kernel driver providing these
(and only on some systems)? The user space driver is still going to need
code to deal with the problematic systems.

> This new uAPI will be used in Mesa to implement timestamp queries and
> VK_KHR_calibrated_timestamps.

VK_KHR_calibrated_timestamps says it should query 'quasi simultaneously
from two time domains' - but this is purely providing an interface to
read a single counter at a time.

It _may_ be useful to report the GPU's view of time and at the same time
(or as near as possible) the architectural counters. That can be used to
deal with drift between the GPU's counters and arch counters[1].

In general we try to avoid providing an interface to something which is
unrelated to the GPU, especially when user space already has a mechanism.

Steve

[1] See Mihail's response to the panthor patches for details of
differences that might occur.

> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 17 +++++++++++++++++
>  include/uapi/drm/panfrost_drm.h         |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 671eed4ad890..d94c9bf5a7f9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -69,6 +69,23 @@ static int panfrost_ioctl_get_param(struct drm_device *ddev, void *data, struct
>  		PANFROST_FEATURE_ARRAY(JS_FEATURES, js_features, 15);
>  		PANFROST_FEATURE(NR_CORE_GROUPS, nr_core_groups);
>  		PANFROST_FEATURE(THREAD_TLS_ALLOC, thread_tls_alloc);
> +
> +	case DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP:
> +#ifdef CONFIG_ARM_ARCH_TIMER
> +		param->value = __arch_counter_get_cntvct();
> +#else
> +		param->value = 0;
> +#endif
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


