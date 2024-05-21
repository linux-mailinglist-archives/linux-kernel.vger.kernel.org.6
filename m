Return-Path: <linux-kernel+bounces-185147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 048E28CB12D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272701C2171C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9B4143C67;
	Tue, 21 May 2024 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9kSksGw"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827DD1442F4
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305110; cv=none; b=WOgkQkxdjnl1vDfv+CP92RVju4dpNqiqRZ0G2BYg2ob0AEhilTudjUiI9urpqbrngb0ZS19rhZpmDz/fPqW1i2fNwbFJK6TuuDj7UBx5VXSrtQcHCaHxMPiRwKvGNJ2OjbsIyZVR/6L0xmmbg3VyZ2hc3JzC7gUeZfFd6b193zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305110; c=relaxed/simple;
	bh=N909/jYUBOF77kMTLcm6D6mBRd3K1pIODTOJI2DxZo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfWPVFp40y4KsoeQ1c3eFB2GEnjTynCeMw58txNebhh4id9EIs2Ok66ycvP0GaHaHPEC52P1/yHS/pV7FQOymg7XmtPv8JGSJfUHxNxnFnx0j1NaeR7Jc2NntbYTTP1k09RAjzz37OAwsyvHyy9tjWwMj8pfpa19ifKHJA+PKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k9kSksGw; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f40b5e059so5677332e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716305106; x=1716909906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOC2cvHHsCfE/XZDQOspaP8vFm7DFyYrnaEnVeU9qAQ=;
        b=k9kSksGw4rj2mUqweuu/mzXizEo1vXkmMfu9fDH7ncNb3+oNX8ilFSNqgEi0R5p2NL
         sb05fGN21UnBQ/Hpg9AauAPTFIyEZBOk9zceJ9WwRyYiMMkJG1y7QAIezcEgNIYgVytv
         MCfare1YdJcTp1eYiznj+zPqpOBRS1HmcwRCAh1OZrz2qowtZ5MKXFs+CcB+w2fqJTCc
         K14TlEiZXgWktVSkPwh3K+j6hCZ3dbOBeXlmpqA+0RskQbdV6Q7LDRmuXIhkpmWiJgAJ
         pDf1ixZajd9+uVYgH71hb169SfV1DTozS7g5aaTpHectkpvFn6xKsZwYMvAjSJ5zfDkd
         c/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305106; x=1716909906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOC2cvHHsCfE/XZDQOspaP8vFm7DFyYrnaEnVeU9qAQ=;
        b=Z2LqVpqO79lb5CyOyf9DtIzwY4+YsJk2iqTwFqNkkOXHJceA3hVrL4O0EYYI5iG8a9
         GYi3bj7ooaDV5i3Kto8FGjBWAR5mPjfXMoIN8Se40kMrcM23QmjlYUupmbhhZ6hzcX2N
         F8OSn0mZOzHrObCI+1o0kVJPuF9JQ8H3/Ow+rpZBeTlPxWdNbZUIQtmeJbQKJhwIscEU
         KtksH1mCHkQ6+/T5OfKXKpAUWjOFtHj199hrWivYeTHGPbbYsbdgEP+MogG5U1/+z8Z8
         8kO+00wj6PIYS/zAhEusxDBAdXowR4LoSvg3S4Z4vSnFr0NkWFHiGdlk1ykr9Ex3XFBf
         mw0w==
X-Forwarded-Encrypted: i=1; AJvYcCVX1za1ULACwIUHyrY670eueyjTPfM7BXxNPVymM1ZczEk8PNnhjPPCxBM9cJGDp+wvNm98V9t+lTqfeJzGijvX5bKGFlrSNdsiO0U5
X-Gm-Message-State: AOJu0Yy7zbcBdRM8xFsUdXetXEEFNBnmUxdEvv7K+/not677JqZCDlHp
	oDpAf1g03dRgpluJO6PoFs6VcOvCadLsHvR6p0aeT3BQidmqN6w/hwsD38YX3sw=
X-Google-Smtp-Source: AGHT+IEGx09qqQZGznwGLK2bUqHiwP3SooCwqZgFFp68n5i919CsAWusJO9RSDejXheh0g79t6XsdQ==
X-Received: by 2002:a05:6512:3b0c:b0:51d:4af6:bb86 with SMTP id 2adb3069b0e04-5220f666ad9mr23745352e87.0.1716305105449;
        Tue, 21 May 2024 08:25:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5238aba8438sm2540161e87.94.2024.05.21.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:25:04 -0700 (PDT)
Date: Tue, 21 May 2024 18:25:02 +0300
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
Subject: Re: [PATCH v4 10/10] drm/vs: add simple dsi encoder
Message-ID: <cej2d72e6bacbjabyjecoqhjlhz4sxx4bgn2w43rgl3cfyyuwt@jq5kq4egj2wo>
References: <20240521105817.3301-1-keith.zhao@starfivetech.com>
 <20240521105817.3301-11-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521105817.3301-11-keith.zhao@starfivetech.com>

On Tue, May 21, 2024 at 06:58:17PM +0800, keith wrote:
> add encoder to match cdns dsi driver
> 
> Signed-off-by: keith <keith.zhao@starfivetech.com>

Please fix your git configuration to include your full name into the
S-o-B and Author fields.

> ---
>  drivers/gpu/drm/verisilicon/Makefile        |   3 +-
>  drivers/gpu/drm/verisilicon/vs_drv.c        |   1 +
>  drivers/gpu/drm/verisilicon/vs_drv.h        |   1 +
>  drivers/gpu/drm/verisilicon/vs_simple_enc.c | 190 ++++++++++++++++++++
>  drivers/gpu/drm/verisilicon/vs_simple_enc.h |  25 +++
>  5 files changed, 219 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_simple_enc.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_simple_enc.h
> 
> diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
> index 2d02b4a3a567..c35ba9bd6f81 100644
> --- a/drivers/gpu/drm/verisilicon/Makefile
> +++ b/drivers/gpu/drm/verisilicon/Makefile
> @@ -4,7 +4,8 @@ vs_drm-objs := vs_dc_hw.o \
>  		vs_modeset.o \
>  		vs_plane.o \
>  		vs_crtc.o \
> -		vs_drv.o
> +		vs_drv.o \
> +		vs_simple_enc.o
>  
>  vs_drm-$(CONFIG_DRM_INNO_STARFIVE_HDMI) += inno_hdmi-starfive.o
>  obj-$(CONFIG_DRM_VERISILICON_DC8200) += vs_drm.o
> diff --git a/drivers/gpu/drm/verisilicon/vs_drv.c b/drivers/gpu/drm/verisilicon/vs_drv.c
> index 6f04102b05b3..2748d48f2c7e 100644
> --- a/drivers/gpu/drm/verisilicon/vs_drv.c
> +++ b/drivers/gpu/drm/verisilicon/vs_drv.c
> @@ -612,6 +612,7 @@ static struct platform_driver *drm_sub_drivers[] = {
>  #ifdef CONFIG_DRM_INNO_STARFIVE_HDMI
>  	&starfive_hdmi_driver,
>  #endif
> +	&simple_encoder_driver,
>  };
>  
>  static struct component_match *vs_add_external_components(struct device *dev)
> diff --git a/drivers/gpu/drm/verisilicon/vs_drv.h b/drivers/gpu/drm/verisilicon/vs_drv.h
> index c3c08ed5f8ac..f3f0f170777d 100644
> --- a/drivers/gpu/drm/verisilicon/vs_drv.h
> +++ b/drivers/gpu/drm/verisilicon/vs_drv.h
> @@ -17,6 +17,7 @@
>  #include <drm/drm_managed.h>
>  
>  #include "vs_dc_hw.h"
> +#include "vs_simple_enc.h"
>  
>  /*@pitch_alignment: buffer pitch alignment required by sub-devices.*/
>  struct vs_drm_device {
> diff --git a/drivers/gpu/drm/verisilicon/vs_simple_enc.c b/drivers/gpu/drm/verisilicon/vs_simple_enc.c
> new file mode 100644
> index 000000000000..d0b1755d77d2
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_simple_enc.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 VeriSilicon Holdings Co., Ltd.

Now it is 2024, so the copyright should probably cover the range.

> + */
> +#include <linux/component.h>
> +#include <linux/of_device.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_of.h>
> +
> +#include "vs_crtc.h"
> +#include "vs_simple_enc.h"
> +
> +static const struct simple_encoder_priv dsi_priv = {
> +	.encoder_type = DRM_MODE_ENCODER_DSI

So, is it 'simple' aka something generic or DSI? In the latter case,
please rename it accordingly.

> +};
> +
> +static inline struct vs_simple_encoder *to_simple_encoder(struct drm_encoder *enc)
> +{
> +	return container_of(enc, struct vs_simple_encoder, encoder);
> +}
> +
> +static int encoder_parse_dt(struct device *dev)
> +{
> +	struct vs_simple_encoder *simple = dev_get_drvdata(dev);
> +	unsigned int args[2];
> +
> +	simple->dss_regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
> +								  "starfive,syscon",
> +								  2, args);
> +
> +	if (IS_ERR(simple->dss_regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(simple->dss_regmap),
> +				     "getting the regmap failed\n");
> +	}
> +
> +	simple->offset = args[0];
> +	simple->mask = args[1];

Is the value that you've read platform dependent or use case dependent?
What is the actual value being written? Why are you using syscon for it?

> +
> +	return 0;
> +}
> +
> +static void vs_encoder_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_state *state)
> +{
> +	struct vs_simple_encoder *simple = to_simple_encoder(encoder);
> +
> +	regmap_update_bits(simple->dss_regmap, simple->offset, simple->mask, simple->mask);


A purist in me would ask to have separate mask and value to write.

> +}

Is it necessary to clear those bits when stopping the stream?


[skipped the rest]

> +
> +
> +struct platform_driver simple_encoder_driver = {
> +	.probe = vs_encoder_probe,
> +	.remove = vs_encoder_remove,
> +	.driver = {
> +		.name = "vs-simple-encoder",
> +		.of_match_table = of_match_ptr(simple_encoder_dt_match),
> +	},
> +};
> +
> +MODULE_DESCRIPTION("Simple Encoder Driver");

VeriSilicon DSI Encoder

> +MODULE_LICENSE("GPL");
> diff --git a/drivers/gpu/drm/verisilicon/vs_simple_enc.h b/drivers/gpu/drm/verisilicon/vs_simple_enc.h
> new file mode 100644
> index 000000000000..73e356bfeb2c
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_simple_enc.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 VeriSilicon Holdings Co., Ltd.
> + */
> +
> +#ifndef __VS_SIMPLE_ENC_H_
> +#define __VS_SIMPLE_ENC_H_
> +
> +#include <drm/drm_encoder.h>
> +
> +struct simple_encoder_priv {
> +	unsigned char encoder_type;
> +};
> +
> +struct vs_simple_encoder {
> +	struct drm_encoder encoder;
> +	struct device *dev;
> +	const struct simple_encoder_priv *priv;
> +	struct regmap *dss_regmap;
> +	unsigned int offset;
> +	unsigned int mask;
> +};

Is there a need for aheader for the encoder? Can you move the
definitions to the source file?

> +
> +extern struct platform_driver simple_encoder_driver;
> +#endif /* __VS_SIMPLE_ENC_H_ */
> -- 
> 2.27.0
> 

-- 
With best wishes
Dmitry

