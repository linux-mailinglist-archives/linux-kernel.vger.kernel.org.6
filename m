Return-Path: <linux-kernel+bounces-363367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E3799C15D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF7C1F2379D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F42B1482E7;
	Mon, 14 Oct 2024 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BipLYaiS"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD983CC1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891130; cv=none; b=JyXWmYbtQGrbUkZUGYFOWpHwDTR62xqfYtCy6uxNbob1wTXyzVUBxfJVRt/g4G+61p6JmSA8p+G+rgJkFYV5ODTZ9cgDOXlPiCj2WrkwMauEbbg2Kswn7R1QIEOiwWYHQDx/fv58Xa/MRQlJ/Jcjr0T9VKvMYnTw+l+Js+1l77M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891130; c=relaxed/simple;
	bh=xsdqhXIVJnZkOoTSSEX+6oyDcw+MQtfhAhCytFlvR5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+3hqfEQ/9TbmdNJ8zvQKJ9mRcYqv1fXlQNUL2deiGsXW2D+aUvCo5MTW6j2iyZrBMPT/m5qDLoM1KQrb4g868d8VDqdB3GLrWfJ+6Ex4gMkTkf9e1ET59GX5IcyneRAmjWJEK4zPYgA3w6ZLol64ThfxVFy2B8K2PyuQ3SLYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BipLYaiS; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so2013961fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728891127; x=1729495927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0l5Vpt48y+wyU8Bmw/8CtDa7S7s/PIqP43uNSVoXr+M=;
        b=BipLYaiSSEQjufj57LUXo5o/0IS/D9JgFbaSGr5WL7LBx12Daef0nZsBmefaNrexMF
         f80pk2Zg5CAE7jG5Jb3+Mf2mBznOawxbN2pAFRx2gYywXOr+2BXtxp7Us7AIpIdmgzHh
         8aviOzk5aBNSrduqCZmXAZ+Gr8JIAu19SdQ7zVN1FYdQPHtRoGf0XSX+rawgC3C/8NEH
         GIUZ/PMGa43guNW2ypUG7VDLk4MrFFcKuq1d331AI2LKesbf2Cz/ZBt8G/eJGZnIxNEF
         adcxRQgZrkg+RmzTPQK5JFS91Fbgfk3PIaNlW6P/sHzifdlVVNrg4vAbyZvjLBbZgiQS
         eD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891127; x=1729495927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l5Vpt48y+wyU8Bmw/8CtDa7S7s/PIqP43uNSVoXr+M=;
        b=Lu1rUackejIHRftdaysJdNtnZUJBkdw/4Q/bVHXw0+iELpnjQDvacBcIAKh1iMNspR
         g06qZb7t4qLDBbQkzhr1elwAntJB5KleuygU9XGKa2BQXdwQ5uke+ewKys3gMOt7LCFH
         2MxFSF6mjSU2sfvBJAP8tzxwoWj5gvtfhnO9wibpxX5P2PRT8JSQk6M5pmn6MN0ZOUrs
         TTWpUhzhUa0yK4cBn0Y6Tn1XhEbXJLQsvYLPN/OteTYr1WlQiSAKDkMVtyZvBsz3NA3A
         eJBeqB4ZpP6U8lmzVFZkqbI8lHb6+Lus8qdMkPBd9IZqJ5IE15ol//yN/jEqCEx8eZLy
         e4OQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1dQWty4c51b7QRmLvD8WOZY0NzVvP1Sm0ilmwf735xCjAqBznBwuajw2sOOnobe/aVE4WPAbk/kQulTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+qFafGwV6bPd/j9CC0ghlToeUW1jj+58k/vte6HcrbaLlKUd
	Brc1+hO52qp2dia80K57HqeKCFl1UScZlx8VR/T+SKDb7cNGG9b6jNIH6S3Q1No=
X-Google-Smtp-Source: AGHT+IGiaLeQf8+Vr/79F1V0S+ghGnacb+eZWAJIcx/Xabv/TekeMK0rkcfw0OdHNeB4hMf+D9aZrg==
X-Received: by 2002:a2e:4a19:0:b0:2fb:3d91:f218 with SMTP id 38308e7fff4ca-2fb3f1d10e8mr20878621fa.26.1728891126669;
        Mon, 14 Oct 2024 00:32:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb497affa6sm5058111fa.74.2024.10.14.00.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:32:05 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:32:02 +0300
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
Message-ID: <kaoqse23we5lyhaawk6xe2ouxwwjtjfpkiqb3j7xe64o2jscny@3yswlkjhuuxw>
References: <20241012073543.1388069-1-victor.liu@nxp.com>
 <20241012073543.1388069-7-victor.liu@nxp.com>
 <dtloyyghjep5rm34qjjinvhvrar5jzj3n24czvpdmnkfesntjq@t2uijuez7myj>
 <f47bc3f1-20d9-4f7e-acdd-85eabdb8d743@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f47bc3f1-20d9-4f7e-acdd-85eabdb8d743@nxp.com>

On Mon, Oct 14, 2024 at 03:18:15PM +0800, Liu Ying wrote:
> On 10/14/2024, Dmitry Baryshkov wrote:
> > On Sat, Oct 12, 2024 at 03:35:40PM +0800, Liu Ying wrote:
> >> Add basic HDMI video output support. Currently, only RGB888 output
> >> pixel format is supported.  At the LVDS input side, the driver
> >> supports single LVDS link and dual LVDS links with "jeida-24" LVDS
> >> mapping.
> >>
> >> Product link:
> >> https://www.ite.com.tw/en/product/cate1/IT6263
> >>
> >> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >> ---
> >> v2:
> >> * Add AVI inforframe support.  (Maxime)
> >> * Add DRM_MODE_CONNECTOR_HDMIA.  (Biju)
> >> * Rename it6263_reset() to it6263_hw_reset().  (Biju)
> >> * Check number of LVDS link data lanes.  (Biju)
> >>
> >>  drivers/gpu/drm/bridge/Kconfig      |   8 +
> >>  drivers/gpu/drm/bridge/Makefile     |   1 +
> >>  drivers/gpu/drm/bridge/ite-it6263.c | 919 ++++++++++++++++++++++++++++
> >>  3 files changed, 928 insertions(+)
> >>  create mode 100644 drivers/gpu/drm/bridge/ite-it6263.c
> >>
> > 
> > [...]
> > 
> >> +static int it6263_parse_dt(struct it6263 *it)
> >> +{
> >> +	struct device *dev = it->dev;
> >> +	struct device_node *port0, *port1;
> >> +	int ret;
> >> +
> >> +	ret = of_property_read_u8(dev->of_node, "ite,lvds-link-num-data-lanes",
> >> +				  &it->lvds_link_num_dlanes);
> >> +	if (ret) {
> >> +		dev_err(dev, "failed to get LVDS link number of data lanes: %d\n",
> >> +			ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	it->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
> >> +	if (IS_ERR(it->next_bridge))
> >> +		return dev_err_probe(dev, PTR_ERR(it->next_bridge),
> >> +				     "failed to get next bridge\n");
> >> +
> >> +	port0 = of_graph_get_port_by_id(dev->of_node, 0);
> >> +	port1 = of_graph_get_port_by_id(dev->of_node, 1);
> >> +	if (port0 && port1) {
> >> +		if (of_property_read_bool(port0, "dual-lvds-even-pixels") &&
> >> +		    of_property_read_bool(port1, "dual-lvds-odd-pixels")) {
> >> +			it->lvds_dual_link = true;
> >> +			it->lvds_link12_swap = true;
> >> +		} else if (of_property_read_bool(port0, "dual-lvds-odd-pixels") &&
> >> +			   of_property_read_bool(port1, "dual-lvds-even-pixels")) {
> >> +			it->lvds_dual_link = true;
> >> +		}
> >> +
> >> +		if (!it->lvds_dual_link) {
> >> +			dev_err(dev,
> >> +				"failed to get LVDS dual link pixel order\n");
> >> +			ret = -EINVAL;
> >> +		}
> > 
> > Please use drm_of_lvds_get_dual_link_pixel_order(), it validates that
> > the DT definition is sound: one port for odd pixels, one port for even
> > pixels.
> 
> It cannot be used, because it get the pixel order for the LVDS
> source not sink. IT6263 is the LVDS sink.

Then you need a similar function for the sink side. Add it to the
drm_of.c

> 
>  * drm_of_lvds_get_dual_link_pixel_order - Get LVDS dual-link pixel order        
>  * @port1: First DT port node of the Dual-link LVDS source                       
>  * @port2: Second DT port node of the Dual-link LVDS source      
> 
> > 
> >> +	} else if (port1) {
> >> +		ret = -EINVAL;
> >> +		dev_err(dev, "single input LVDS port1 is not supported\n");
> >> +	} else if (!port0) {
> >> +		ret = -EINVAL;
> >> +		dev_err(dev, "no input LVDS port\n");
> >> +	}
> >> +
> >> +	of_node_put(port0);
> >> +	of_node_put(port1);
> >> +
> >> +	return ret;
> >> +}
> >> +
> > 
> 
> -- 
> Regards,
> Liu Ying
> 

-- 
With best wishes
Dmitry

