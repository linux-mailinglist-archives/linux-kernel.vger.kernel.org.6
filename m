Return-Path: <linux-kernel+bounces-363331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD43599C0CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1132835EC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255D9146588;
	Mon, 14 Oct 2024 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8dEzWQb"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F94C7C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889828; cv=none; b=f/jgLL3l6AkIJ+hpilfxqeRScTYdE07jSny3A1dzkGS8SvEYPXDQXyBP8W6pqfchFd4UsYfcUEZA4x46vO8p8twvLsjjXs14wg1/GqaPDiEr9XEc5QQJJq8sFqLNeqmkEbQESKgVATZmCPGnhzoirv7P29B2whLdMU2gkT06S+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889828; c=relaxed/simple;
	bh=zlUcn/AjQMBhE2mjFPqYAlKColqDLt9MD/frGVn3oJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIIKWfstF3SfwPa3IBCineKfeBXlnDnmYoSPZIvotTcmOkFOg9tpQSGjvJVy6I/clG8kipzlcZKqGrQRBFKNh6nyGXcMB65THjxsKkdSbQm+anG3m0FOccMN7f45Pp8K06+U9RSYUytAafrE0lvWmolkEzkRz1xMgiUNltVb190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8dEzWQb; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so8487331fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728889824; x=1729494624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vaSk6MvJTraXtkEXPaCgc+gi7dKimM6BaWMyPcB8SXg=;
        b=B8dEzWQbTnJo3BWuTpdt66EHm4wdTJoRCsdxBLWF2VqiQTH0tPsI+w/Gtrkq6G54pB
         2qg2qV7t/tJu4MHEPf9fIKOTqfkc4OAwV1rfkbbNoq6DeMxgKNb45RK/3OvcIh6o46H2
         kSLoZ/O+iQo61vPpqe0BIVcgVBpq/oyTlDl8S+P1hRwfGBM2T/P4+VurMAkMuGiNytK1
         F62SZtgifvhK0Rk0V8b2YaJd7/N1tkTk0hJ96311vjUSnk7YNtyIqDb+vQQEMc2PPmdN
         ArZyoP80Xx0h2J6h/8cTcgH+NbJI012Xo10/DzaoXwrIv+GMEOjg+XpNUpKvgxIcfpmO
         N1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728889824; x=1729494624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaSk6MvJTraXtkEXPaCgc+gi7dKimM6BaWMyPcB8SXg=;
        b=suNRIJWuIBcTjy/6pBHFvAif5sOBkIpkRDNcqff9nKmMHau8xcwAVkfMbykugcqwQ/
         S+7jlz2UFvC/My2QSfDJQGz83Tu5/qy8wa/M6rKOlmJSxQfTnZW/6l5bqC+mddIKCZ3E
         pYMAaCSfum4aQAwpT3nGErVCq79uVxYBhtBHTHO0IYnedlif0ZXcXMDFXe2UlkCo/GKq
         44vgX7AgTwR++EkwSIumKCxyhFwnVUQBVSUAjx1QBUoAytf8L+FUUFd5kJqCC3tNhAjC
         UCs0nPdsZ/AZjYu27BUs9TKNsx0boK3e2wQ+dlwQwN+8XIEtg3GPZsFe0IxruReWvbR/
         rrvw==
X-Forwarded-Encrypted: i=1; AJvYcCV1lXxjNxV1cVQ19q4vQx00h06WxfvLx2QMpM0gDa09FjLV0Wo6cJSLDdN86aVkKpsT4JAf75vP58N/qZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysM9oNXYjd+Hmu6GdYfVLE8EBoaKNdnQDg1l90Qm0QgEn8kMXk
	l5mdvS/29oafi9hjTqOCwDEwcBaxql/xpZTQTvg4/VwcLAnhqHOXXp/upZBpzFw=
X-Google-Smtp-Source: AGHT+IGAd9UjWxXud+NWbfMZgYsAU4lizOECIK9dLoFGOaFd9MGxBfs40mqKeTPH0r6byj/NCWRwuQ==
X-Received: by 2002:a2e:4e19:0:b0:2f7:ad6b:a31e with SMTP id 38308e7fff4ca-2fb327a672emr38410631fa.31.1728889823683;
        Mon, 14 Oct 2024 00:10:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb4aa297f7sm4681891fa.15.2024.10.14.00.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:10:22 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:10:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, 
	quic_bjorande@quicinc.com, geert+renesas@glider.be, arnd@arndb.de, nfraprado@collabora.com, 
	o.rempel@pengutronix.de, y.moog@phytec.de, marex@denx.de, isaac.scott@ideasonboard.com, 
	biju.das.jz@bp.renesas.com
Subject: Re: [PATCH v2 6/9] drm/bridge: Add ITE IT6263 LVDS to HDMI converter
Message-ID: <dtloyyghjep5rm34qjjinvhvrar5jzj3n24czvpdmnkfesntjq@t2uijuez7myj>
References: <20241012073543.1388069-1-victor.liu@nxp.com>
 <20241012073543.1388069-7-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012073543.1388069-7-victor.liu@nxp.com>

On Sat, Oct 12, 2024 at 03:35:40PM +0800, Liu Ying wrote:
> Add basic HDMI video output support. Currently, only RGB888 output
> pixel format is supported.  At the LVDS input side, the driver
> supports single LVDS link and dual LVDS links with "jeida-24" LVDS
> mapping.
> 
> Product link:
> https://www.ite.com.tw/en/product/cate1/IT6263
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2:
> * Add AVI inforframe support.  (Maxime)
> * Add DRM_MODE_CONNECTOR_HDMIA.  (Biju)
> * Rename it6263_reset() to it6263_hw_reset().  (Biju)
> * Check number of LVDS link data lanes.  (Biju)
> 
>  drivers/gpu/drm/bridge/Kconfig      |   8 +
>  drivers/gpu/drm/bridge/Makefile     |   1 +
>  drivers/gpu/drm/bridge/ite-it6263.c | 919 ++++++++++++++++++++++++++++
>  3 files changed, 928 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/ite-it6263.c
> 

[...]

> +static int it6263_parse_dt(struct it6263 *it)
> +{
> +	struct device *dev = it->dev;
> +	struct device_node *port0, *port1;
> +	int ret;
> +
> +	ret = of_property_read_u8(dev->of_node, "ite,lvds-link-num-data-lanes",
> +				  &it->lvds_link_num_dlanes);
> +	if (ret) {
> +		dev_err(dev, "failed to get LVDS link number of data lanes: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	it->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
> +	if (IS_ERR(it->next_bridge))
> +		return dev_err_probe(dev, PTR_ERR(it->next_bridge),
> +				     "failed to get next bridge\n");
> +
> +	port0 = of_graph_get_port_by_id(dev->of_node, 0);
> +	port1 = of_graph_get_port_by_id(dev->of_node, 1);
> +	if (port0 && port1) {
> +		if (of_property_read_bool(port0, "dual-lvds-even-pixels") &&
> +		    of_property_read_bool(port1, "dual-lvds-odd-pixels")) {
> +			it->lvds_dual_link = true;
> +			it->lvds_link12_swap = true;
> +		} else if (of_property_read_bool(port0, "dual-lvds-odd-pixels") &&
> +			   of_property_read_bool(port1, "dual-lvds-even-pixels")) {
> +			it->lvds_dual_link = true;
> +		}
> +
> +		if (!it->lvds_dual_link) {
> +			dev_err(dev,
> +				"failed to get LVDS dual link pixel order\n");
> +			ret = -EINVAL;
> +		}

Please use drm_of_lvds_get_dual_link_pixel_order(), it validates that
the DT definition is sound: one port for odd pixels, one port for even
pixels.

> +	} else if (port1) {
> +		ret = -EINVAL;
> +		dev_err(dev, "single input LVDS port1 is not supported\n");
> +	} else if (!port0) {
> +		ret = -EINVAL;
> +		dev_err(dev, "no input LVDS port\n");
> +	}
> +
> +	of_node_put(port0);
> +	of_node_put(port1);
> +
> +	return ret;
> +}
> +

-- 
With best wishes
Dmitry

