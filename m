Return-Path: <linux-kernel+bounces-334951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E4997DEC4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354E01C20CF1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252C8126BEC;
	Sat, 21 Sep 2024 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dg7RHM+n"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD416126BE7
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726950508; cv=none; b=aISQ6xqkh/diYIWpqXvjinS0/3par3A6hE6YTbQ5QltDUAJfiHRt3WPySqGuFLLG0r1WZZqIJAlCkdmA+IMJ9m8yWUVhkoJkWTsasRyx+WRQXsqc6HQHoyrHyVmGnhnRUQSQHfQCBHbeyohGT5SiAnpXs1SY6B7gXZ/QHBFpPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726950508; c=relaxed/simple;
	bh=zOobiCuH38JMpEqvBSTQ5fyo9Vps5+/oUClcHiB54MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yhyny4gWFeIKUs2xWA5zCAFu8VNlu5aFE1LxjEenOkQeUiWgcSazlYlmTB0ftA4OskYYPClPJVCKvXVFu5+yyjimDzcDQy1H7r1nNVaTJXwwt7EpAX652YECs5hPrZDjT+HvmYWeOGSueRsfk6kWhWY9Vy1uZsK5tnuJiyg4vZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dg7RHM+n; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5365392cfafso3200442e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726950505; x=1727555305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvDX+Qkf6ul5sVNd1hp47xzf2SFXNZFnERGsXMXc2Jc=;
        b=Dg7RHM+nS0QgT+8X5cKlx9uUIM8JTANxtjcyfF+hSDzrHzM12bh9+z+HSQXue3aMkH
         y4/SRheoPY5omWv2XrQJmNHi/BUZ/Bc7MHy9zqvw0yi00OwICIf4jjYxPn+IAoCthOTL
         gDSK/1bmDrzuXT95ZMgSkvKPZLkY6EPd9iZlb8gSuIis6GFecw8zcMO/5BrE6iF2dM2B
         b9FxFFh0A52XhrUB6I+g/VArHOUmQFKpFkNncrH/Ucj/cPqXzaC/FMmiM1GPe1JNP6Rq
         tFdzidlCcc9EKQNmxOe6QOCt79nRGaKdxII+x18kWmp5kIUpInVvHXaWo/gtmTDkdevt
         2SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726950505; x=1727555305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvDX+Qkf6ul5sVNd1hp47xzf2SFXNZFnERGsXMXc2Jc=;
        b=RpAF++y7zjVlZEOT4pGmuqdvP+SUFr6CNB3B5FJTH31vM1+JpE81Y4tAlSy0kHni5h
         tg2QubihW1f2p8Pe4I7tS36oV+nZVGePQRUrRIDBw9STk1gZ17DNk2CuR/Cz9Ac7wNs0
         7YRADQxaW0BnNT9BL7KWVMcwMSo+G0N+ACFyrxE5gf4ORDByEta7lNWxirQ/zoEYFOdj
         cp37zF/WA/9t1IktQiYdzTYoVTJdP0K4yhnJE3dXA+RVKEIQ/TtR7Rz+2cA3nFPvbIfx
         AGAlIPVz02LZc7Hq9HAFZ18IJAAYiOlzzFZfDOmH8BV0t732SrXvr1GblNCD8QMp/mZH
         WmEg==
X-Forwarded-Encrypted: i=1; AJvYcCUKr4GQfgVpSiTQXPOttfA6iZ5+RFGBdPJ9KmT0lvRUBQnDyo0FJjEMvuDNn3djkTkQWj2v1AZtztNM3uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF771/+N55WjoFZqrZ0/yzfkZ+XPSN3bhZdlsVrBNEGFNok/VK
	rkckD4g+5bRYi62olyUu6yVY4xRo60hEbAqFMB5aTvSxpRAb+crtNIcSEsRQNHw=
X-Google-Smtp-Source: AGHT+IFhPIT+q2MyB5RN+pnWTfR+TceVTQH7kIiLDuOrDILRvZI3ajKI2nahwHEWM6RNEd8Ms9wrXg==
X-Received: by 2002:a05:6512:acb:b0:536:a4e9:9cf7 with SMTP id 2adb3069b0e04-536ac3400e3mr3783318e87.56.1726950504875;
        Sat, 21 Sep 2024 13:28:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53691d62993sm2264292e87.269.2024.09.21.13.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 13:28:23 -0700 (PDT)
Date: Sat, 21 Sep 2024 23:28:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sandor Yu <Sandor.yu@nxp.com>, vkoul@kernel.org, mripard@kernel.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, 
	daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, mripard@kernel.org, 
	kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com, 
	alexander.stein@ew.tq-group.com, sam@ravnborg.org
Subject: Re: [PATCH v16 2/8] phy: Add HDMI configuration options
Message-ID: <5bn3qcbzyyudjh34y76jj2r5j2p7mzpig4xntmjjlneznoipjw@ca7sbco5ceyk>
References: <cover.1719903904.git.Sandor.yu@nxp.com>
 <b1acbd48470d41b53b359d27fa2ea9358a037324.1719903904.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1acbd48470d41b53b359d27fa2ea9358a037324.1719903904.git.Sandor.yu@nxp.com>

On Tue, Jul 02, 2024 at 08:22:34PM GMT, Sandor Yu wrote:
> Allow HDMI PHYs to be configured through the generic
> functions through a custom structure added to the generic union.
> 
> The parameters added here are based on HDMI PHY
> implementation practices.  The current set of parameters
> should cover the potential users.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
> v15->v16:
> - Remove pixel_clk_rate, bpc and color_space fields from struct
>   phy_configure_opts_hdmi, they were replaced by unsigned long long tmds_char_rate.
> - Remove r-b and a-c tags because this patch have important change.
> 
> v9->v15:
>  *No change.
> 
>  include/linux/phy/phy-hdmi.h | 20 ++++++++++++++++++++
>  include/linux/phy/phy.h      |  7 ++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/phy/phy-hdmi.h
> 
> diff --git a/include/linux/phy/phy-hdmi.h b/include/linux/phy/phy-hdmi.h
> new file mode 100644
> index 000000000000..dd923e19d17c
> --- /dev/null
> +++ b/include/linux/phy/phy-hdmi.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2022 NXP
> + */
> +
> +#ifndef __PHY_HDMI_H_
> +#define __PHY_HDMI_H_
> +
> +#include <linux/hdmi.h>

This header is not neccessary anymore. With it removed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Maxime, is this patch fine with you?

Vinod, could you please pick up this patch for 6.13 and possibly provide
an immutable tag for it? I see drm drivers using bad workarounds because
we don't have this in the API yet.

> +/**
> + * struct phy_configure_opts_hdmi - HDMI configuration set
> + * @tmds_char_rate: HDMI TMDS Character Rate in Hertz.
> + *
> + * This structure is used to represent the configuration state of a HDMI phy.
> + */
> +struct phy_configure_opts_hdmi {
> +	unsigned long long tmds_char_rate;
> +};
> +
> +#endif /* __PHY_HDMI_H_ */
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 03cd5bae92d3..4ac486b101fe 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>  
>  #include <linux/phy/phy-dp.h>
> +#include <linux/phy/phy-hdmi.h>
>  #include <linux/phy/phy-lvds.h>
>  #include <linux/phy/phy-mipi-dphy.h>
>  
> @@ -42,7 +43,8 @@ enum phy_mode {
>  	PHY_MODE_MIPI_DPHY,
>  	PHY_MODE_SATA,
>  	PHY_MODE_LVDS,
> -	PHY_MODE_DP
> +	PHY_MODE_DP,
> +	PHY_MODE_HDMI,
>  };
>  
>  enum phy_media {
> @@ -60,11 +62,14 @@ enum phy_media {
>   *		the DisplayPort protocol.
>   * @lvds:	Configuration set applicable for phys supporting
>   *		the LVDS phy mode.
> + * @hdmi:	Configuration set applicable for phys supporting
> + *		the HDMI phy mode.
>   */
>  union phy_configure_opts {
>  	struct phy_configure_opts_mipi_dphy	mipi_dphy;
>  	struct phy_configure_opts_dp		dp;
>  	struct phy_configure_opts_lvds		lvds;
> +	struct phy_configure_opts_hdmi		hdmi;
>  };
>  
>  /**
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

