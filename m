Return-Path: <linux-kernel+bounces-417600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E29D567A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00511F2450C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90561D63DC;
	Thu, 21 Nov 2024 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xsN2lZhE"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AAE19F410
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732233440; cv=none; b=r5QCu/jEFVdy2kJvZ01UTOWyWgrp1KNhLAc1K27nTrCxMd3yOhFkLtETVNVE9eBSqFyD7oA7qZqxa4CvJksBdFlPufSCtLzHwDTfCAoD9TQ5XH/ufc+8qKrS79+qzVhpNiEEZcwsSP+9rr8Y9cvT4iZaJ4dS1DmG+AmhkMqcCcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732233440; c=relaxed/simple;
	bh=UMOpRKdbXrU4NoO+Ttp5Od2ly8k7VvCMhCAhmP5R6P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3VpR6cqh0DhyQhLmUZBTU/ioFmcGPcxDbq0ywTDEyx9/cR9Y8iU0aC59WcAZAEh0tf8Y/UlZEXvXKQ43O1XogKsVww9M6dZHbffZ1Vrl2BJit+rZ/0D7xtJbnvOdOuefzNLrYfyj7r8Hn27u0E0NZX6mTUDC2mugSbPryIQ6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xsN2lZhE; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f84907caso1629025e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732233436; x=1732838236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGZRbTR/uK+ftQ2TfPgufc2P+z5Ye/l5g2WR5F5d4JQ=;
        b=xsN2lZhEjxXAohLSxNO/BfjqGK7hbvrD8iodSQjRcXisrpqkq0t5dISYgk2zL2IG7W
         8x17ia2DKt54LtQjvSjT3F2OeUEr50JdUU5e+D/z5u5QtuYS2nO91En6hLVyenKY6lNd
         KLEw6/uXV1v+Suwg+AOjb+MAee6WZVa4Rtj3AUYXTPtY1EnC4aMjgjUOxMVWr9k4suHC
         iGjdYgJ5jGECXv4JRvMhDoezubeVpoblX6a2a0o7/mMP/rrIqQCN5khkZD0KnOt+j0iq
         ZfQ8mH/QVoiXkZKSyBvAQFrNOc8RMO6L5hZZEw9xPc9M1zcR9xJNH9G8JML2tJFEiuX7
         GsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732233436; x=1732838236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGZRbTR/uK+ftQ2TfPgufc2P+z5Ye/l5g2WR5F5d4JQ=;
        b=I61cdvf5OH9xs0+b+wlcIT/wYvdiI6OapOucSc37oTwLPghkGY5ZiPQqcvQzJ15sic
         gKCGEQDADqXGjm733u/rado9hK1Vq10EJW71AJetpt6q1IT2yZZPJ0O8mBiVzToxVWT6
         Nk64orilgg18qhcBkd7KDVe+1sFSpUIBpvF5Tm3tINW1kSkV/yh6TiIoCVQeNHOTCzi2
         RRObJsaZqdMA7E+ldnPStobYIriw1UXQzSx7mef0yLEafCrQh2YCQGFzxEY6T4bVYfJj
         2vY2njodkI3/dW/gOV0WHzox72SdQWaHNK+ykOoj0FC5xNS+dABRMH/wj1eJngldHK4N
         388Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmb3UJqkBMrITIwZUWxjS3JyhgSpkQ4hpvSNuWyx1RfW+2IigbfubglUG0qAoqWqQrPePYDC7ftZOcuSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5R4bpoRL8Gvf5M4D0CXqxdRIGs1YJRPVt87D6Z3RlBQEL7JK0
	srvFHBKvVufPKoOH7JKqnveLukHLWlNy03yLxWAAm1KYus5DDwNc8ieDNifnlXU=
X-Gm-Gg: ASbGncsq9a5PTBQBZJNv/evM3vlMEtLUv3ruPiDE/kusXBr54WP+0QCl3zCc+2oDRgT
	vH00agRwNGyoeykVoqw9Qfr7Z5sv3GDMdDtlqSQTTkXmC1Do5u7RLe5mPOvRShHjuFBmof15EOq
	DN5kMIQg85K1FvCwk7FEoss6KxuBO2cEXkLhApa7voxjmmIDXumgAruD/kjPuZkdp0MfnhdoK6M
	gTAE8t5Cou+THX87dyL8Pikm6Po1f7ARHFFzXuj3S3bajsHPnQ3WMGBNeISr75s5NOUa++JtUTg
	K5H1Zklzzk6nJwlqfuBRNSQzhYkyhg==
X-Google-Smtp-Source: AGHT+IEmXbDQJcAUYj6lojIiC9JM4M4ujCCevK4TnX7twcBWShy1O7UHHnGrFWe77gpB0XWeTqJyWw==
X-Received: by 2002:a05:6512:b10:b0:539:adb0:b91 with SMTP id 2adb3069b0e04-53dd3ab11a5mr254370e87.57.1732233436333;
        Thu, 21 Nov 2024 15:57:16 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481e38sm114731e87.123.2024.11.21.15.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 15:57:14 -0800 (PST)
Date: Fri, 22 Nov 2024 01:57:12 +0200
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
Subject: Re: [PATCH v5 3/9] drm: bridge: inno-hdmi: add inno bridge driver.
Message-ID: <u4iaxbpuozap5rhjraxktq2wzxwdpqxj7ldglpvsmvpnxcutuz@ak2eiwtb5fg5>
References: <20241120061848.196754-1-keith.zhao@starfivetech.com>
 <20241120061848.196754-4-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120061848.196754-4-keith.zhao@starfivetech.com>

On Wed, Nov 20, 2024 at 02:18:42PM +0800, keith zhao wrote:
> move rochchip inno hdmi connector to a newly created directory named
> inno-hdmi.c, and rename rockchip/inno_hdmi.c to
> rockchip/inno_hdmi-rockchip.c
> 
> This patch refines the Innosilicon HDMI architecture by abstracting
> the existing connector into a bridge architecture.
> The drm_bridge_connector_init function is used to create the connector.
> 
> Signed-off-by: keith zhao <keith.zhao@starfivetech.com>
> ---
>  MAINTAINERS                                   |    2 +
>  drivers/gpu/drm/bridge/Kconfig                |    2 +
>  drivers/gpu/drm/bridge/Makefile               |    1 +
>  drivers/gpu/drm/bridge/innosilicon/Kconfig    |    6 +
>  drivers/gpu/drm/bridge/innosilicon/Makefile   |    2 +
>  .../gpu/drm/bridge/innosilicon/inno-hdmi.c    |  376 ++++++
>  .../gpu/drm/bridge/innosilicon/inno-hdmi.h    |   34 +
>  drivers/gpu/drm/rockchip/Kconfig              |    1 +
>  drivers/gpu/drm/rockchip/Makefile             |    2 +-
>  drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c |  690 +++++++++++
>  .../{inno_hdmi.h => inno_hdmi-rockchip.h}     |    0
>  drivers/gpu/drm/rockchip/inno_hdmi.c          | 1025 -----------------
>  include/drm/bridge/inno_hdmi.h                |   56 +
>  13 files changed, 1171 insertions(+), 1026 deletions(-)
>  create mode 100644 drivers/gpu/drm/bridge/innosilicon/Kconfig
>  create mode 100644 drivers/gpu/drm/bridge/innosilicon/Makefile
>  create mode 100644 drivers/gpu/drm/bridge/innosilicon/inno-hdmi.c
>  create mode 100644 drivers/gpu/drm/bridge/innosilicon/inno-hdmi.h
>  create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
>  rename drivers/gpu/drm/rockchip/{inno_hdmi.h => inno_hdmi-rockchip.h} (100%)
>  delete mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.c
>  create mode 100644 include/drm/bridge/inno_hdmi.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f787dd625497..7766ee0bdd74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7439,6 +7439,8 @@ S:	Maintained
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:	Documentation/devicetree/bindings/display/bridge/innosilicon,inno-hdmi.yaml
>  F:	Documentation/devicetree/bindings/display/starfive/
> +F:	drivers/gpu/drm/bridge/innosilicon/
> +F:	include/drm/bridge/inno_hdmi.h

Separate entry, please. This is not specific to StarFive.

>  
>  DRM DRIVER FOR SYNAPTICS R63353 PANELS
>  M:	Michael Trimarchi <michael@amarulasolutions.com>

-- 
With best wishes
Dmitry

