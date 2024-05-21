Return-Path: <linux-kernel+bounces-185438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 050438CB4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EF8CB22FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BEE1494D7;
	Tue, 21 May 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJ8inRPn"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276237F49F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324774; cv=none; b=e6tCAGE2jj8n9+VTUkn04tSp/mCFoXyum7yRvZge4rsqOL58QJ+QEcVIiNLlqLqCD2DLowQNOhhG+jjMn8tR+tp6zyoTwQBSFUS4oOQ01Vn+jXyse+XsXNyBAow4jJavZfGTAHYGH6XXn6CeT5nnv3zKUpFheACqGg68K7Uh62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324774; c=relaxed/simple;
	bh=T4r4UOzazpDwOoTNYJRsXcpEc54ba9FCpMQL7fJvH54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKlv30DnCIKL5rWetRMxY6InjMtj/1f/cFy/S4fIp79tCxW08XO7hzISo6HbZBae829fauw2OHZMhmOohtB6nkzL6sjXaNqRNeU3MptbzgqRPSviA864xPjNCf/C264VOsB4/LUGdEhwjdY+xmxV13aspGJkNeG+zTv3A1Vjodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wJ8inRPn; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51f40b5e059so6142244e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716324771; x=1716929571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=msxyCLm+NoD8gt9t5sc/sqtgLcdGE0LrYHv1PtdYhxE=;
        b=wJ8inRPnWrnor0k2WR/+fP0NB5O/XhLyq2tBQSvwEefb/YSFTZCljJjvC3Yemy4ILD
         EKprNoyNDyhSOg6c7/UCkcrHsSHDtwRGThMbi7F21Uz5udPJ3vtUCPMrRfNQLAg7ny76
         fyYMifTbEjRhb/pByyrAOQ/OFZMRtV6vz62Dgy1Sk+8VYWL7cO1/T1phj+1ZaHgAjWLu
         yo2HJ+lYStNV/tfPfLbywAyBud10Xw9avTnmgqebdkWh2OZ+J/OBOA/YuOjelwF6n59+
         5gWJJhxIkd1K+ph2drIpx4+1hatEAsk27hJrH9RirGHPwuqSkBOHTMDdc7RWIi/FemGH
         E1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324771; x=1716929571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msxyCLm+NoD8gt9t5sc/sqtgLcdGE0LrYHv1PtdYhxE=;
        b=fMEITJaF5kp5Y3PKRfCHgBQdSSRxnA3Xd1Xk9bgnyin7yvHb1I5zQtrFLnxEkW5EJr
         +kuzYuk/x9MHRj2SEI/QUH0KwyElsaBAsVXP0/b0FLYWLfa/69imJyc6tK5E3Lmsy1QV
         5OpMtdR8/qRBaRcYFK0cdyCZgROJxJJZreYJ1ciwSkm7M2Nasz8qt/X7JcRMp+Z/O9xm
         lDdzvcPao7GyXbsP+JtKkkqC1Ni8bjfMeTPhmBMhTf7bm2xeu7nDp0phGz+rDWql1LJ/
         sXf1EOijy+bCQp9STF1aiDk8jdtiC79AQb84S++xMjLEAfNyfcvle2mnhQ+aH71BjPBl
         p5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYsYx5ZqSS2+48Jf4OkY2nzl7j60dcsciHlSr1Hc0vurL/P5Z1yn5ZuVeypgtKFCzXlzlWlBgmGOevT7FPXEV8sQWOH0cKL4pIUlnv
X-Gm-Message-State: AOJu0YwWOVhdgVJY704gL1nm+Q24viDjj7m98+M9yk8V5XdXJJKez/n2
	XE5XhFo4uphbe5Rgrg/CSTD7SJyhN+Nw9f8ZdyYaIwhDDWAmIVI4zfTGBX2NMsI=
X-Google-Smtp-Source: AGHT+IH9JnZ8CnZBbmaZFoXCSh2S7w8ZfIIRcaRrDzVz1afxLKCUvUcZ9fni8BZiKaLEuV2o297Qfw==
X-Received: by 2002:a05:6512:3147:b0:523:9747:4920 with SMTP id 2adb3069b0e04-52397475405mr10938328e87.36.1716324771258;
        Tue, 21 May 2024 13:52:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d87a5sm4800254e87.202.2024.05.21.13.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 13:52:50 -0700 (PDT)
Date: Tue, 21 May 2024 23:52:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: keith <keith.zhao@starfivetech.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, 
	xingyu.wu@starfivetech.com, p.zabel@pengutronix.de, jack.zhu@starfivetech.com, 
	shengyang.chen@starfivetech.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 05/10] drm/vs: add vs mode config init
Message-ID: <ttjuehs6ui4dsnexhhodfd22okujx55mof5svxuk47gizhkv52@kdbdvwsamz6i>
References: <20240521105817.3301-1-keith.zhao@starfivetech.com>
 <20240521105817.3301-6-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521105817.3301-6-keith.zhao@starfivetech.com>

On Tue, May 21, 2024 at 06:58:12PM +0800, keith wrote:
> add vs mode config base api

Commit message? Please describe e.g. why are you using
drm_atomic_helper_commit_tail_rpm() instead of
drm_atomic_helper_commit_tail().

> 
> Signed-off-by: keith <keith.zhao@starfivetech.com>

Name

> ---
>  drivers/gpu/drm/verisilicon/Makefile     |  3 +-
>  drivers/gpu/drm/verisilicon/vs_modeset.c | 36 ++++++++++++++++++++++++
>  drivers/gpu/drm/verisilicon/vs_modeset.h | 10 +++++++
>  3 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.h
> 
> diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
> index 7da54b259940..536091f37378 100644
> --- a/drivers/gpu/drm/verisilicon/Makefile
> +++ b/drivers/gpu/drm/verisilicon/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -vs_drm-objs := vs_dc_hw.o
> +vs_drm-objs := vs_dc_hw.o \
> +		vs_modeset.o
>  
>  obj-$(CONFIG_DRM_VERISILICON_DC8200) += vs_drm.o
> diff --git a/drivers/gpu/drm/verisilicon/vs_modeset.c b/drivers/gpu/drm/verisilicon/vs_modeset.c
> new file mode 100644
> index 000000000000..c71fe0d32504
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_modeset.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
> + */
> +#include <drm/drm_damage_helper.h>

I don't see anything concerning damage helpers being used here.

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
> +	dev->mode_config.min_width  = 0;
> +	dev->mode_config.min_height = 0;
> +	dev->mode_config.max_width  = 4096;
> +	dev->mode_config.max_height = 4096;
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
> -- 
> 2.27.0
> 

-- 
With best wishes
Dmitry

