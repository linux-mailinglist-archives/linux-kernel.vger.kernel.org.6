Return-Path: <linux-kernel+bounces-371674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F289A3E74
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F0B1F226E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA6A26AD9;
	Fri, 18 Oct 2024 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCrnzQuN"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2431344C8F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254687; cv=none; b=Dwfvoe1ggur4NUuQsVCpYRTweUHb6dHQ7A3xT3Um76paNprgLaSDstuj/gorZJJOspDYKknAoszejz5YxpRuBpjJs3aCTi89EcE+G99MqSAPILkwNo9i3KUVNjzBwLrueoLjUmlCodMDfKyTxYxJZEqi1QSg6+gm7sf4iIstYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254687; c=relaxed/simple;
	bh=aw6mseRDDe/wDjXyXjamvdSdeBFmFUV1YRWwiLwkZ7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSwDui0QV6i3PLU/wOizAykdzVRoKk6J6m/h4DsdlCeJXDf9t36yamZ6WMgfwqEwiH4qO9UXYdzq5X9e9qg+3bh0ScqN/m9BdrhftTtL5OK86Jqqa9ChQP9RsJQtXfJm/LOU0ZIbRGEdpVXptg10U1tzqo47V3ZJGUevFST6gKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MCrnzQuN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539fb49c64aso3016322e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729254683; x=1729859483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8AGZam4n06viI04ibKwIHu8ebEmTULIu0XIfkMmLleM=;
        b=MCrnzQuNdYkWa+tBc0nCdU3U2iKs8wT/4lKeJ6CSBEwjCjMSbruiBaSpCPrh2Tb7cn
         vGiOrd5oUOacNJ+yp7RawYKGS5Tw/fUQVUnjmfoyd4COGUwEl+1/3RcoQqP9Y59QSoQd
         AG5JOdv5/VcR5Iu44TXVHfOogAaVkmKCR39oL0eQ96+TCl5B+NfPUFQ4xTyjZ+X6EOl/
         sghcoayxVFjcfhRa/ZShHwqIToZB+6GMc3JdP1ftrKe+eBC+yQ/QwlicZCI6um45Hh0K
         BCYQRtJUWrE79pnk5vZkJb6Q01i6eR/QW6NFeHihcE28mMx1tgsg/DvIpEOj7euIav2P
         50tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729254683; x=1729859483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AGZam4n06viI04ibKwIHu8ebEmTULIu0XIfkMmLleM=;
        b=cvw69idgSDjfAGxKDGVxJx0/m+S/tHY+6sROna0WaoIy8de7wEWMeanRi3T26ysEwl
         jBHEDYKOtlYHDiXiffJyRoDCatNWgp8OhGC5EGr6JoBbplCVO5a9aN2SXS+h4/qvENCL
         tjWi/JIrkjeY4mrvXXYFAgRsAgtiv1VPLqhZz55hB0AvboyXLlpzKbH5jIPA4yOoTBtu
         5WTRVeKtuSKXeZB9i/UJwUH0Tg5z0VZWh7IOe4LFLVPe2VKYpqf9PaK9Hcs+0yoc7LXH
         m+sMltK7+3MuTy0+O/m8owEPqJ1ovSQ6EyhWWJCgHrMhhg+bb5tDN1DM/S4EnkO2mZ2Q
         Pf/A==
X-Forwarded-Encrypted: i=1; AJvYcCXdsWyNKnyV2CqwCZ1BqjykE+1uxWC3Nk8yitp/ocK/hm5xoCfQjDVOvn7NNd5rPxngUZyz1TimjL0sZuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPk7lWXjzwWnpv252f/faoXQdt3f3IPKpwvujrwk3lWT98F/4+
	KSIZZuTf/rnX3CpmacSyfvALG4ViN2iFfwcCrEU70lx3BL6yAGeRe1QEhoUDse0=
X-Google-Smtp-Source: AGHT+IF5+uQbidjUeJm/YIP54JRQhHenrE8LF08c1wGN7AL7hbF7Y70yrjPM2DsLa+7UkJwLWiqkDA==
X-Received: by 2002:a05:6512:1384:b0:53a:64:6818 with SMTP id 2adb3069b0e04-53a154c9d93mr2164357e87.47.1729254683205;
        Fri, 18 Oct 2024 05:31:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a1521fecdsm206273e87.298.2024.10.18.05.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:31:22 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:31:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, marex@denx.de, stefan@agner.ch
Subject: Re: [PATCH 4/5] drm/bridge: imx8mp-hdmi-tx: Set output_port to 1
Message-ID: <vvsj6ri2ke25nzocbq736yv7rphzma6pn3yk2uh7iu43zfe2sa@2fwye4k4w6he>
References: <20241018064813.2750016-1-victor.liu@nxp.com>
 <20241018064813.2750016-5-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018064813.2750016-5-victor.liu@nxp.com>

On Fri, Oct 18, 2024 at 02:48:12PM +0800, Liu Ying wrote:
> Set DW HDMI platform data's output_port to 1 in imx8mp_dw_hdmi_probe()
> so that dw_hdmi_probe() called by imx8mp_dw_hdmi_probe() can tell the
> DW HDMI bridge core driver about the output port we are using, hence
> the next bridge can be found in dw_hdmi_parse_dt() according to the port
> index, and furthermore the next bridge can be attached to bridge chain in
> dw_hdmi_bridge_attach() when the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is
> set.  The output_port value aligns to the value used by devicetree.
> This is a preparation for making the i.MX8MP LCDIF driver use
> drm_bridge_connector which requires the DRM_BRIDGE_ATTACH_NO_CONNECTOR
> flag.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> index 8fcc6d18f4ab..54a53f96929a 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> @@ -96,6 +96,7 @@ static int imx8mp_dw_hdmi_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(hdmi->pixclk),
>  				     "Unable to get pixel clock\n");
>  
> +	plat_data->output_port = 1;

This will break compatibility with older DT files, which don't have
output port. I think you need to add output_port_optional flag to
dw_hdmi_plat_data and still return 0 from dw_hdmi_parse_dt() if the flag
is set, but there is no remote node.

Last, but not least, this changes behaviour of the connector.
dw_hdmi_connector_create() implements CEC support, handles
ycbcr_420_allowed, HDR metadata, etc.

We are slowly moving towards the supporting all of this in bridge
connector via the HDMI Connector framework, but this is not
implemented for now.

>  	plat_data->mode_valid = imx8mp_hdmi_mode_valid;
>  	plat_data->phy_ops = &imx8mp_hdmi_phy_ops;
>  	plat_data->phy_name = "SAMSUNG HDMI TX PHY";
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

