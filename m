Return-Path: <linux-kernel+bounces-193594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7108D2E56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC08B25C98
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3481167D81;
	Wed, 29 May 2024 07:35:18 +0000 (UTC)
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C6E16728E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968118; cv=none; b=Q0Zu8g9Qk1i3qT/P5JZFbM/ehZEsOVWAUZsxrW9S3bS8HoUCCUWgcXppq3PtvMsuwnadzJar5lVjy5KUFT/dpj4JGb1R45WsXrQ564JCY7d9SqIe3OloxO7iw4eUoJllFyxdzby/0sKSNfaDDBROr4HhnoBBBjOIz8EWskIpysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968118; c=relaxed/simple;
	bh=WIrKkfWB9mUTmEf6z4WjJTAXw9ftK94d7qWGvNCTcno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6tBhzW14kQIuUDjnDlXOIOfM7TQy8O6/DwXILRSLAdCZdFP7p+9RpODc7FpfDfbuTn6X+iaFbaz258stEh25ZHaaS+nCqP9/dNCQ0alH5SIHNcG45/enquE8SBUMCSf4ZQOeDRQe9KYR3kCCFNWT6TbhwpFd0BusfZTbXRY/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (2a02-a420-77-cc79-164f-8aff-fee4-5930.mobile6.kpn.net [IPv6:2a02:a420:77:cc79:164f:8aff:fee4:5930])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8C5771FE87;
	Wed, 29 May 2024 09:27:36 +0200 (CEST)
Date: Wed, 29 May 2024 09:27:35 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, Vinod Koul <vkoul@kernel.org>, 
	Caleb Connolly <caleb@connolly.tech>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 2/3] drm/panel/lg-sw43408: mark sw43408_backlight_ops
 as static
Message-ID: <anspa5kgrmfvv2c23mjlukc7vrsctyk34yzud7cffjiljccisz@v7mazfwaxhu6>
References: <20240528-panel-sw43408-fix-v4-0-330b42445bcc@linaro.org>
 <20240528-panel-sw43408-fix-v4-2-330b42445bcc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-panel-sw43408-fix-v4-2-330b42445bcc@linaro.org>

On 2024-05-28 22:39:19, Dmitry Baryshkov wrote:
> Fix sparse warning regarding symbol 'sw43408_backlight_ops' not being
> declared.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404200739.hbWZvOhR-lkp@intel.com/
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> index 115f4702d59f..2b3a73696dce 100644
> --- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
> +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> @@ -182,7 +182,7 @@ static int sw43408_backlight_update_status(struct backlight_device *bl)
>  	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
>  }
>  
> -const struct backlight_ops sw43408_backlight_ops = {
> +static const struct backlight_ops sw43408_backlight_ops = {
>  	.update_status = sw43408_backlight_update_status,
>  };
>  
> 
> -- 
> 2.39.2
> 

