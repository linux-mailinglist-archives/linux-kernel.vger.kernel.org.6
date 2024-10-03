Return-Path: <linux-kernel+bounces-349156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5716798F1D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B26282EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C91A2574;
	Thu,  3 Oct 2024 14:51:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69C21A08A3
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967064; cv=none; b=KepSk0Pc6K7T5K3WGGvjuGLbhHgecllKzj9RtZY3GBTj4CQmzeLlG2s3WPqE22RiqOBGxdClvb3Qn74XnT7qAXJE+t3x9GPcfPEcm3h6WzxqcYNzLh6XcFVYF0IYr+x8oA0CNA69dFi1R+GDzfMWljOZWPiAFBVDeqA67QVpjkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967064; c=relaxed/simple;
	bh=VMmC5QOAxcBKYUB0+COtsMIidxqWBJbVoh0HvymUq3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgMrZHS6MefYuMOCrGO+fR3i16ycaUe+IihPpP/NnIOr4tgOyYD+W2EmTwbBfpzk+kfXh+eAq1BXREAT1BQ2niY2qwQiVwZMuEKh7uJX7/X4H2szaeu5CRCLW7WASeoLyd1dVaRDjUK/ZZregI1gTm7jI6+FDagDy3dCRqXkHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBC84339;
	Thu,  3 Oct 2024 07:51:31 -0700 (PDT)
Received: from [10.1.39.32] (e122027.cambridge.arm.com [10.1.39.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02BC83F640;
	Thu,  3 Oct 2024 07:50:58 -0700 (PDT)
Message-ID: <7e19cfaf-7c22-42d2-8d53-f654e61124c1@arm.com>
Date: Thu, 3 Oct 2024 15:50:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/panthor: Fix OPP refcnt leaks in devfreq
 initialisation
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=
 <peron.clem@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Grant Likely <grant.likely@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241003133037.3398144-1-adrian.larumbe@collabora.com>
 <20241003133037.3398144-2-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241003133037.3398144-2-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/10/2024 14:30, Adrián Larumbe wrote:
> Make sure in case of errors between the first fetch of an OPP in
> panthor_devfreq_init and its successive put, the error path decrements its
> reference count to avoid OPP object leaks when removing the device.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: fac9b22df4b1 ("drm/panthor: Add the devfreq logical block")

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index 9d0f891b9b53..ce0ac4563f65 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -197,7 +197,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  	if (ret && ret != -ENODEV) {
>  		if (ret != -EPROBE_DEFER)
>  			DRM_DEV_ERROR(dev, "Couldn't retrieve/enable sram supply\n");
> -		return ret;
> +		goto opp_err;
>  	}
>  
>  	/*
> @@ -207,7 +207,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  	ret = dev_pm_opp_set_opp(dev, opp);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
> -		return ret;
> +		goto opp_err;
>  	}
>  
>  	dev_pm_opp_put(opp);
> @@ -242,6 +242,10 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
>  
>  	return 0;
> +
> +opp_err:
> +	dev_pm_opp_put(opp);
> +	return ret;
>  }
>  
>  int panthor_devfreq_resume(struct panthor_device *ptdev)


