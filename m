Return-Path: <linux-kernel+bounces-186382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB0B8CC37E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D661F217F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987B018645;
	Wed, 22 May 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR44/EN4"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D4D29E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389294; cv=none; b=Z5sdPQNpMldWue1IX0j6jWbuwuux6OK+eXcsdjchdiTxVDkuvx+iuGYX4DBqyOjGzC+pnlcFKAxex4/PpeAjirHmXc2gkZKBUXTJEzJQ+1hsvjudBKwKog5ByaecG2EpIiVggz8G4GytSWpH8bZhjRF0swlKTCYk6bSTZKgiEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389294; c=relaxed/simple;
	bh=LPSI3RWQh4dvQYFxL9JPByxi8aRayC5JxIyxGTfR0JI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RHFVwjON8X6AuqsT7rjiGK6fgDxvpZ5HMvirk/Rcf0LBAnKXx3IOKx8xBc75TrAgTBDCs/s3Ry4Sqakq0ruiDN9+a2W61fM45MBhJqOYoJXz/ve1yDZIEYJpVNqy7bTzre80bpzZ4rkb2rumM5lt3oFVVp9LK+32M3F/ttA96F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR44/EN4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-420104e5336so5471255e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716389291; x=1716994091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xPsuD4fZJWaOvckyqtS50exhDAnEUIl9m+MkVDUOvd4=;
        b=HR44/EN4LkHulwiITSpsGyt8kETPCCDwKfdgXh/qNpqlaFY/rgcg5ljsM/j0R7nzlU
         /YoMEaM5IFn3ER5YhJ8hIz2KFHEiFcKaypgSIf/7DGqNSm/AN4CxVI/CUDsqHTfP8DZ2
         R2Z3dcKRPjldHAdmp/QIJSP3mejZjfviIMwfRQRWqOTDlk6ipj+8xkj+TQhlOy5cjVvn
         EQ/6bULsMaVxSB7JNNXwWVCvAEVUQQvldUvduUn9wee7e54aC+/JsoUKcms4avMXAHsa
         VM6XYnP8P2Jgnrvf9dforoUsmnMtk7FdLfrggrhVPP9vMg7U6gkca4IGlMGeN9lWPzsE
         13cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716389291; x=1716994091;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPsuD4fZJWaOvckyqtS50exhDAnEUIl9m+MkVDUOvd4=;
        b=NtM66atVBF/bcpQKj7njvSqWYYFBR2K/hATSAz4y3H4eRvWkhqWCMKc+YQCoKS4pNY
         6C9uOsGuvr1lMZ9bhKBlOeT0HlmTon/DC/AwkY/ckCVtu/tNOvUWe6vSRyZqobkmRI6V
         DEQ2X+mvsHyrxEOvhabdfb/LdRKSpP+on97Z7Ze7vS5ORZGVCy4DKCgDayTjZ7s5tNx/
         h7LIhuxsHbgai/Ag0NR628X0oQVx0J5ykZCdvLypwJBvsN9P+l61H64iV3D3pW+1H6ye
         xveqYB8j/cvWzS5rqQy57bXosjyZMhohKsLhr4GcrC282JQc4OdCRm4SfdlT6g7GmO6N
         TCPA==
X-Forwarded-Encrypted: i=1; AJvYcCWIy8JQjnFV3vAJD9P849MhFR3aFrCJ+pGjoWLW8rd2BJ8Fv/o8rpA0aKVzZdixk3/M1Rki31uH8qEFLxKwMeZfyfUmCZmGSYRun1AN
X-Gm-Message-State: AOJu0YypS1CPHQ68RPw4TRssKSxVtlTcCPsSQWZwF8UnIFVMTnvHrP21
	FmnXPht/3RZZ2uGX9rVrtHUy9MQ59U8JIc9z17TReruf1itT5MKC
X-Google-Smtp-Source: AGHT+IGwx/GdGNYjlfC3GGBGIHJR2veib6YybEoxGNT5Qgi7TqYjRa+sO8i9l1uNsrT9q2aUGlfWAw==
X-Received: by 2002:a05:600c:4f56:b0:418:9d4a:1ba5 with SMTP id 5b1f17b1804b1-420e19d56b1mr103855175e9.6.1716389290896;
        Wed, 22 May 2024 07:48:10 -0700 (PDT)
Received: from [192.168.1.127] ([185.77.198.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420149b1c24sm393676565e9.41.2024.05.22.07.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 07:48:10 -0700 (PDT)
Message-ID: <df115f89-2979-42a5-b521-4bc4f8f4a335@gmail.com>
Date: Wed, 22 May 2024 16:48:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vc4: remove all usages of of_node_put()
From: Amer Al Shanawany <amer.shanawany@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@inria.fr>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240427134044.38910-1-amer.shanawany@gmail.com>
Content-Language: en-US
In-Reply-To: <20240427134044.38910-1-amer.shanawany@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/04/2024 15.40, Amer Al Shanawany wrote:
> Use the scope-based cleanup feature to clean up 'struct device_node *'
> when they go out of scope, and remove all instances of of_node_put()
> within the same scope, to simplify function exit and avoid potential
> memory leaks.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
> ---
>   drivers/gpu/drm/vc4/vc4_drv.c  | 14 ++++++--------
>   drivers/gpu/drm/vc4/vc4_hdmi.c |  4 +---
>   drivers/gpu/drm/vc4/vc4_hvs.c  |  4 +---
>   3 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index c133e96b8aca..bb0bb052e595 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -289,7 +289,6 @@ static int vc4_drm_bind(struct device *dev)
>   	struct rpi_firmware *firmware = NULL;
>   	struct drm_device *drm;
>   	struct vc4_dev *vc4;
> -	struct device_node *node;
>   	struct drm_crtc *crtc;
>   	bool is_vc5;
>   	int ret = 0;
> @@ -302,11 +301,10 @@ static int vc4_drm_bind(struct device *dev)
>   	else
>   		driver = &vc4_drm_driver;
>   
> -	node = of_find_matching_node_and_match(NULL, vc4_dma_range_matches,
> -					       NULL);
> +	struct device_node *node __free(device_node) =
> +		of_find_matching_node_and_match(NULL, vc4_dma_range_matches, NULL);
>   	if (node) {
>   		ret = of_dma_configure(dev, node, true);
> -		of_node_put(node);
>   
>   		if (ret)
>   			return ret;
> @@ -341,10 +339,10 @@ static int vc4_drm_bind(struct device *dev)
>   			goto err;
>   	}
>   
> -	node = of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
> -	if (node) {
> -		firmware = rpi_firmware_get(node);
> -		of_node_put(node);
> +	struct device_node *np __free(device_node) =
> +		of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
> +	if (np) {
> +		firmware = rpi_firmware_get(np);
>   
>   		if (!firmware) {
>   			ret = -EPROBE_DEFER;
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index d30f8e8e8967..915e8da3f41a 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -3661,7 +3661,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>   	struct drm_device *drm = dev_get_drvdata(master);
>   	struct vc4_hdmi *vc4_hdmi;
>   	struct drm_encoder *encoder;
> -	struct device_node *ddc_node;
>   	int ret;
>   
>   	vc4_hdmi = drmm_kzalloc(drm, sizeof(*vc4_hdmi), GFP_KERNEL);
> @@ -3699,14 +3698,13 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>   	if (ret)
>   		return ret;
>   
> -	ddc_node = of_parse_phandle(dev->of_node, "ddc", 0);
> +	struct device_node *ddc_node __free(device_node) = of_parse_phandle(dev->of_node, "ddc", 0);
>   	if (!ddc_node) {
>   		DRM_ERROR("Failed to find ddc node in device tree\n");
>   		return -ENODEV;
>   	}
>   
>   	vc4_hdmi->ddc = of_find_i2c_adapter_by_node(ddc_node);
> -	of_node_put(ddc_node);
>   	if (!vc4_hdmi->ddc) {
>   		DRM_DEBUG("Failed to get ddc i2c adapter by node\n");
>   		return -EPROBE_DEFER;
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 04af672caacb..6e3613e06e09 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -845,15 +845,13 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
>   
>   	if (vc4->is_vc5) {
>   		struct rpi_firmware *firmware;
> -		struct device_node *node;
> +		struct device_node *node __free(device_node) = rpi_firmware_find_node();
>   		unsigned int max_rate;
>   
> -		node = rpi_firmware_find_node();
>   		if (!node)
>   			return -EINVAL;
>   
>   		firmware = rpi_firmware_get(node);
> -		of_node_put(node);
>   		if (!firmware)
>   			return -EPROBE_DEFER;
>   
Hi,

This patch is marked as new/archived on patchwork[1], however it didn't 
receive any feedback, and a similar patch has been already merged [2].


[1]: 
https://patchwork.kernel.org/project/dri-devel/patch/20240427134044.38910-1-amer.shanawany@gmail.com/

[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d65bfb9546eb627e3c578336355c5b81797f2255

Thank you

Amer


