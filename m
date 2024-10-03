Return-Path: <linux-kernel+bounces-349154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A90798F1D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC131B230ED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBF519EEBD;
	Thu,  3 Oct 2024 14:51:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7BB1E52C
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967059; cv=none; b=ZZnP31nT74pFiIwCdGQlqqALXCnmKNKgnk/RTEipEHWgqa2GykVgy6wIVwWGTWKTPkqOnLjlxpvjBfA7dQCX7zvKyk5qMsKMcfVws1KNuXowB4s8CQEjGJk6xrStBTTbMEH4/tlFL6hJlBJ/YxAkTF9p/uvRptqZghp5KuqxCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967059; c=relaxed/simple;
	bh=TEfogYn9xzP6HJJRErVyjd3nPWHlrpana0Ri8DoQ6Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+6FPJ5LXx1rJpYdWIuaI3wxryuFQGbgeDRvrxJtmjXoshh6ECQgLNnavXgON5S1qrge9O/FkNQq05EZeyDx0N60yaUQjeDTC9bpGzK977YZyshXXLeoEek4y4okUflAdj6T/HqxLw2i7klXOQEciRDLxu8a02upDGyAIlTCzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8574B339;
	Thu,  3 Oct 2024 07:51:26 -0700 (PDT)
Received: from [10.1.39.32] (e122027.cambridge.arm.com [10.1.39.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 948B53F640;
	Thu,  3 Oct 2024 07:50:54 -0700 (PDT)
Message-ID: <327ea967-bb29-4634-9a23-4b6bc48b0d63@arm.com>
Date: Thu, 3 Oct 2024 15:50:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/panfrost: Add missing OPP table refcnt
 decremental
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241003133037.3398144-1-adrian.larumbe@collabora.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20241003133037.3398144-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/10/2024 14:30, Adrián Larumbe wrote:
> Commit f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
> retrieves the OPP for the maximum device clock frequency, but forgets to
> keep the reference count balanced by putting the returned OPP object. This
> eventually leads to an OPP core warning when removing the device.
> 
> Fix it by putting OPP objects as many times as they're retrieved. That
> includes putting the OPP object in case setting it fails.
> 
> Also remove an unnecessary whitespace.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 2d30da38c2c3..4b8840a41779 100644
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
> @@ -184,9 +184,12 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>  	ret = dev_pm_opp_set_opp(dev, opp);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
> +		dev_pm_opp_put(opp);
>  		return ret;
>  	}
>  
> +	dev_pm_opp_put(opp);
> +
>  	/* Find the fastest defined rate  */
>  	opp = dev_pm_opp_find_freq_floor(dev, &freq);
>  	if (IS_ERR(opp))


