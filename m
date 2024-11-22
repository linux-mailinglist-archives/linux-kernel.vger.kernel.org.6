Return-Path: <linux-kernel+bounces-417607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F9A9D568F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738E6B211DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218A81388;
	Fri, 22 Nov 2024 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZwGUJCI"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC4A31
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732234131; cv=none; b=UwWMCw8j/3ncNZf7KkMj38QoAOOrFiXq1ax/HsEyxpuFsE38Q7KZy5Lp/iHjhCnuKgDUvlnjwS6Fffzvx9Yck06Peg645l6f1NUVsr4AHzVFj7b353+8Z++EUDkSSQsqJW+3v+0b8iwjNillKxcK74KLFmIbQhAPgy3BMnTJlec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732234131; c=relaxed/simple;
	bh=8QY0OoK99j6oVx8eixrtqtZjvjlLwAKj9WJXGC3Ants=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPRxbIrlPlVh/j1ChMvch66u+dFrhKXfMf8oERyRNJ+ZQctLCXqqidrOwLyiHOVtMEJ/AiLPYzebMUSona3ob6C84ZHF5/SCa70ZwPPa0F3fkrW6tAwe52gK1ZqdYUfbaOZsoTrIpl5JOyxsXGWa96LgTZ29Vz0J5l9+DfmaoCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZwGUJCI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ff589728e4so29240531fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732234126; x=1732838926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb10zmYHQSv3I83zcr7E+6kREcna9ZYNd5sNu4/LV7s=;
        b=jZwGUJCIjy/OBiAsXU38+IsoIlXzBW8rfsWcdDAujRNQKPpqGun8d7sho4EXpxV/EI
         uJt4Y8IJpLsWzaMpRyqu+0ox+jDr6DJ3c3CycRy7hmAlusl05HMEmnt8m0dB2ZPMoVzM
         u5P9LbP/BiUeXTc+s5BQRAW3Dg4egTLNGu5FNDl5OHJwhWj/6wg1HWJYhh8K4SxG+1pY
         r5sm8gmIHvf5+I0E70gxOXv5gzTn8EOoiDYj4CrqiH6gguR4OJmpg4kADRxrx7TzAvhs
         qoshMs8cuxFf/oZkqyAnrXHSMI2kb2uD0dYDZG1Cam5MfzdBuNd0iYa/bo9ofNrJ6bmg
         eJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732234126; x=1732838926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb10zmYHQSv3I83zcr7E+6kREcna9ZYNd5sNu4/LV7s=;
        b=cbhRbVwb/czEJmvOKt6O3qBpM8fboHg2SvQTfeV0xJW5nUFuq5KwnkuIMaIBxXzWwm
         G8kxFVsN3F5kSVq/b1N7e6tfN8rFongN/Pq9W0l/nIdWeqLX9ZEUsNJdbyjLR0rqPbBm
         t32HCEHS0n6YRBv3ut9JHXP5RRSm4UBMMTUZTZ9xoca0WQVLlvolKGiVuQj64EUipXGy
         WS9Q36jFo0jfZ60tPssszRh/ijLaQBvU5bqaPStIboqZf0GJ7gcvpkpoyS/8KyD8BauA
         6cbX+End6WrdnPsSlhs70rT6ERaqwYeU/hvMZ89OZyBBcUchtpORUdj8lyLaowT0zq9s
         7AJw==
X-Forwarded-Encrypted: i=1; AJvYcCWgvKXKJxyD5CDLPkySJ7PyHsO21ISYI8qG80qvXjHtDqfaAYxRzBA9IAKQnJOnKZNEFySRhiHvI6lY5WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdnahP1mIZYc6140NBy0F2PqPowlVcNlhVaggyY8NEnLUzlWkO
	Vx+8x5D7eY6Ti713J56FvqmwhAO1nEKmRpDZJn7pThtgbUBnk8AsZfcugvU0hA0=
X-Gm-Gg: ASbGncteNJvuoi5RW28SQZMqjnCM1IXVFfRIVOKqN/ijUXSr2rx/TIOszsNCw0hNzlR
	HztCwg2NpKA3Qqj93VLIRyuGyPU6SoiT/6zRKUlGX4p+8GYhY2oLjoaUnUe0aMJRDJsVRqXx0kf
	F+dOCYXWZF7rnVTnIiAn4KXe6E6BcMHmJUfIaru1VXgbRvF2R+mt20yEImPYrH5f1cLM8CPlLK1
	LUWWRs0p4L5fXZIQ+ZB0tFwPAmw5eaArRqaQa0l5moOxASPH7u5fAju6PAyHXL6rOwDK2x2YotA
	7hAqC7fk59potDuiYSGsTyhllf/nIw==
X-Google-Smtp-Source: AGHT+IEuYo3TXwIBAta2+QFFKa258N+W0wLgiRkvqaQO6FoTfco4TU0xkpE/1Qfqy0nPr2pRscBPLQ==
X-Received: by 2002:a05:6512:2247:b0:53d:d06c:cdf8 with SMTP id 2adb3069b0e04-53dd06ccfbamr1006096e87.1.1732234126460;
        Thu, 21 Nov 2024 16:08:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2489841sm120742e87.178.2024.11.21.16.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 16:08:44 -0800 (PST)
Date: Fri, 22 Nov 2024 02:08:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: keith zhao <keith.zhao@starfivetech.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, 
	william.qiu@starfivetech.com, xingyu.wu@starfivetech.com, kernel@esmil.dk, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	p.zabel@pengutronix.de, changhuang.liang@starfivetech.com, jack.zhu@starfivetech.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] drm/vs: Add Base API for VS Mode Configuration
Message-ID: <6nztdhkgx5wm5byq46jbhivws4kvwpnmnc7r5jsqaqm5rlzb2k@dz7ohbcirnd4>
References: <20241120061848.196754-1-keith.zhao@starfivetech.com>
 <20241120061848.196754-6-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120061848.196754-6-keith.zhao@starfivetech.com>

On Wed, Nov 20, 2024 at 02:18:44PM +0800, keith zhao wrote:
> This commit adds a base API for configuring VS modes,
> which will streamline the setup and management of display modes
> in the VS DRM subsystem.
> 
> In this implementation, we are using drm_atomic_helper_commit_tail_rpm()
> instead of drm_atomic_helper_commit_tail() to ensure that
> we skip planes related to inactive CRTCs.
> 
> This helps to optimize the commit process and reduces unnecessary overhead
> when dealing with inactive display resources.

 * This is an alternative implementation for the
 * &drm_mode_config_helper_funcs.atomic_commit_tail hook, for drivers
 * that support runtime_pm or need the CRTC to be enabled to perform a
 * commit. Otherwise, one should use the default implementation
 * drm_atomic_helper_commit_tail().

Neither of the cases seem to apply here. Please use
drm_atomic_helper_commit_tail().

> Signed-off-by: keith zhao <keith.zhao@starfivetech.com>
> ---
>  drivers/gpu/drm/verisilicon/Makefile     |  3 ++-
>  drivers/gpu/drm/verisilicon/vs_modeset.c | 31 ++++++++++++++++++++++++
>  drivers/gpu/drm/verisilicon/vs_modeset.h | 10 ++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.h
> 
> diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
> index 7da54b259940..842867dad4cb 100644
> --- a/drivers/gpu/drm/verisilicon/Makefile
> +++ b/drivers/gpu/drm/verisilicon/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -vs_drm-objs := vs_dc_hw.o
> +vs_drm-objs := vs_dc_hw.o \
> +	       vs_modeset.o
>  
>  obj-$(CONFIG_DRM_VERISILICON_DC8200) += vs_drm.o
> diff --git a/drivers/gpu/drm/verisilicon/vs_modeset.c b/drivers/gpu/drm/verisilicon/vs_modeset.c
> new file mode 100644
> index 000000000000..0873a3465143
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_modeset.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) VeriSilicon Holdings Co., Ltd.
> + */
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +
> +#include "vs_modeset.h"
> +
> +static const struct drm_mode_config_funcs vs_mode_config_funcs = {
> +	.fb_create			 = drm_gem_fb_create,
> +	.atomic_check		 = drm_atomic_helper_check,
> +	.atomic_commit		 = drm_atomic_helper_commit,
> +};
> +
> +static struct drm_mode_config_helper_funcs vs_mode_config_helpers = {
> +	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
> +};
> +
> +void vs_mode_config_init(struct drm_device *dev)
> +{
> +	int ret;
> +
> +	ret = drmm_mode_config_init(dev);
> +	if (ret)
> +		return;
> +
> +	dev->mode_config.funcs = &vs_mode_config_funcs;
> +	dev->mode_config.helper_private = &vs_mode_config_helpers;
> +}
> diff --git a/drivers/gpu/drm/verisilicon/vs_modeset.h b/drivers/gpu/drm/verisilicon/vs_modeset.h
> new file mode 100644
> index 000000000000..bd04f81d2ad2
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_modeset.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 VeriSilicon Holdings Co., Ltd.
> + */
> +
> +#ifndef __VS_MODESET_H__
> +#define __VS_MODESET_H__
> +
> +void vs_mode_config_init(struct drm_device *dev);
> +#endif /* __VS_FB_H__ */

There is no point in having single-function headers, please find
something more global.

> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

