Return-Path: <linux-kernel+bounces-398527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26A19BF268
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E99B281571
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5748E2022F9;
	Wed,  6 Nov 2024 16:00:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9941DCB06
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908841; cv=none; b=gbe+TvM0twEx/xXqqX5uey2x+Dje/reXE6JQI9FfUXskE0ETVyZ6ucOiFSex33VQ6wlbYC6JjBe1MX64vbkXNMRa0WbBRg3F05wHFuUfz+BphnsNkNzJQpm6vXDjWzAhamvX1TwICDAT9vOzlqPCYt7K4Xev7bNJ5UCWAiIHFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908841; c=relaxed/simple;
	bh=LblUuHpk9rD76tWSPiChPc+yXFwygHWinmkZe1FE57w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFfBMVvHWmHfGAQ6wJ7iOUupbQw+uCQbDdDObPEX/0HgyWdaT+Y0zTxoMqPOMQZtucOG3UeExTaQAbIieaQnJPRhWORK1AI9PEEY2TqjKTFmGEcPnhCq8OT9MHgXjrTgZSQ0sDNF/y+PhIzcHm+TJ9RV4vvqG3di3fCRlXlh22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39DE6497;
	Wed,  6 Nov 2024 08:01:06 -0800 (PST)
Received: from [10.57.91.71] (unknown [10.57.91.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DDD83F528;
	Wed,  6 Nov 2024 08:00:33 -0800 (PST)
Message-ID: <7c4a3ed4-d37b-4de9-af53-5f022b5170c0@arm.com>
Date: Wed, 6 Nov 2024 16:00:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/panfrost: Add missing OPP table refcnt
 decremental
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241105205458.1318989-1-adrian.larumbe@collabora.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20241105205458.1318989-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/11/2024 20:54, Adrián Larumbe wrote:
> Commit f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
> retrieves the OPP for the maximum device clock frequency, but forgets to
> keep the reference count balanced by putting the returned OPP object. This
> eventually leads to an OPP core warning when removing the device.
> 
> Fix it by putting OPP objects as many times as they're retrieved.
> 
> Also remove an unnecessary whitespace.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Both pushed to drm-misc-next.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 2d30da38c2c3..3385fd3ef41a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -38,7 +38,7 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
>  		return PTR_ERR(opp);
>  	dev_pm_opp_put(opp);
>  
> -	err =  dev_pm_opp_set_rate(dev, *freq);
> +	err = dev_pm_opp_set_rate(dev, *freq);
>  	if (!err)
>  		ptdev->pfdevfreq.current_frequency = *freq;
>  
> @@ -182,6 +182,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>  	 * if any and will avoid a switch off by regulator_late_cleanup()
>  	 */
>  	ret = dev_pm_opp_set_opp(dev, opp);
> +	dev_pm_opp_put(opp);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
>  		return ret;
> 
> base-commit: aadcf584583ca9833b4fb2140a4f437569ddbcd7


