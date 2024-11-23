Return-Path: <linux-kernel+bounces-419134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E79D69D0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AE2281A87
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758233D0C5;
	Sat, 23 Nov 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icXeyQxB"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4369E2943F;
	Sat, 23 Nov 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377406; cv=none; b=fLj06iglNjKIbV3SJsxPSGaQJnVIvCHFrev+cIFM+Ae8+wO00uE8Hwnwix9Q6lqJJxtIL2UA6QcvK0d1aIu9ZcTto+PYbg8Ms/rZyuBE1Qz0KkxrYYjNr17b+Gye03j4EW4Ego9FJ5HxlGqD0A6DO4YnRSJ1bRgZJOjxVyv4B68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377406; c=relaxed/simple;
	bh=9YvKJJUYKOQQj/XXgK4v1/NRI7+lGgmBsUraJqPjh/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC5w8YgDnrO27Q7b6jKt4htZRWN3vtyvnO/KrUuKJgifq1/m3Tc6Z8JeCP+OcRG1EMdZW7+EHq9mZRNkyMaMvrbiO/QWJvgGD5eOCLeRxBMQhzGmcD+pibtWUZCzjz9HHJMUG0TRLysvRwscspIlLMdXZDz4WFXIWgcmXZ9/wso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icXeyQxB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21260cfc918so22693665ad.0;
        Sat, 23 Nov 2024 07:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732377404; x=1732982204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdhhpCg+taJ4xsLRypTZUl8HmDm+NFsq0ODj29ISJ0M=;
        b=icXeyQxBS22O961MBUERL4WjCaWQx/0h3RJutZie7zuLLFLKi12or/+t+cJxjcmIvB
         GZ36/xtLwRPmOTRwsXTdeIphLLrd17owWzjhIbD9BYDBc4WjrXBIZ9T9hODl9Jw5gBDW
         95W4G4ukFFMiCV82haMdxnRiM35tvUcVttIZAf8ctxSLIjDfjwoa87OlRg8ODreTaGbc
         j+UIEse/O9O+rJKeITUxJpsb2t4fRMBfZ8k2WWFByf4u9Bnl/79uABdZGI2NXTqKPlum
         9Fqf5+BmdIKsfn1FOQEb3FRnEeh1KdPJvnlFMqahgyXx0+39g1ZwlXEBKOqvCSF49Mro
         A9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732377404; x=1732982204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdhhpCg+taJ4xsLRypTZUl8HmDm+NFsq0ODj29ISJ0M=;
        b=niNPGLGG4zAmIU6LEsAs4Fk/gaETGnHm9I2Pj8CTLglOMzejqNh8e3fzrwbuNazpJj
         4RlYN1MFtKGP++gg0P8vlBmR18P9KoSIWADliZGiMtYNArBBumb9DMZqVq/dOwW5SsmG
         mUSM5XSOwGQL0zkBaWUxPcHH0Ce9PGZms0SzDlcGkfeKoYM6r7C/hCLQxnwMY0X3cM4H
         f+fiR82/DBHMyCV5QQzOCk02cYj56UCWesJY+rNUNVJDijpbjREnN2KSykXYthtdgZF3
         tR5YtV4wRk+Ze6hDe92Ae/UEtqRie9fBQF3hWh/YwjTnUDtISDQXWfTu8anCHKCZmM5y
         YDpw==
X-Forwarded-Encrypted: i=1; AJvYcCXavWEBsfHtjcddWyKw/N5NbviUHdIxeVP2GW1kGetFsCNAilbaT7hipEaTjvCgA+AQ0yUPTRUQARhU@vger.kernel.org, AJvYcCXqQxazFqH/oQZwYGQ8/oxocSdMsDHA+H4BxP+EKtl8aPPvxVHOwHCceC09tpGhIZ2ClKfXvnDnzP7BUd/7@vger.kernel.org
X-Gm-Message-State: AOJu0YzPuMmoJ1xVQ/tHSqI6/GbAIr/S5akqLMDPDIknrEWMiLLNvJvT
	99K5EMwwtqTQn6wL6+tg70qO5AXGlDBunqOasgBqws4/r1qV7Rkp
X-Gm-Gg: ASbGnctr2VxLXTWinWOqFIVffIMNx+z/8DOmm0DUTrucdA78hvnHD2RZiF5GH7jl1sT
	Tq9WJg6pASuNP//s2SVfuYhRvhe02haKDnUGPE4mlYp0ijanCsCe24LVkinWwAKIk/3Ox/8S6Q3
	5WS5bpCNI4fH1M1iuwBpegg/oHg86gsCbDaMdpTenJPrBaIcCs5g6tzfeetURXGGKFMcpWxnSFV
	g3YglHf3DKiSSzSHdrVQRw9ewnPfsU99TwlBAG4Uu/2I8xfRjbu+lxhx+5soaU=
X-Google-Smtp-Source: AGHT+IHB49Ds6XF42rhaBzmjNmAHIN7vXsDlDSoz7p5lUyfP90T9HB2pni6uH8yauXHUV/+wJVdjQw==
X-Received: by 2002:a17:903:283:b0:20e:57c8:6ab3 with SMTP id d9443c01a7336-2129f7300c2mr99379585ad.4.1732377404385;
        Sat, 23 Nov 2024 07:56:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc131d1sm34098095ad.187.2024.11.23.07.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 07:56:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 23 Nov 2024 07:56:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Yao <markyao0591@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
	Luis de Arquer <ldearquer@gmail.com>,
	Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [v10,3/3] drm/rockchip: Add basic RK3588 HDMI output support
Message-ID: <790091a1-00af-43bb-8cdf-814f4cc38d83@roeck-us.net>
References: <20241016-b4-rk3588-bridge-upstream-v10-3-87ef92a6d14e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-b4-rk3588-bridge-upstream-v10-3-87ef92a6d14e@collabora.com>

On Wed, Oct 16, 2024 at 11:06:53PM +0300, Cristian Ciocaltea wrote:
> The RK3588 SoC family integrates the newer Synopsys DesignWare HDMI 2.1
> Quad-Pixel (QP) TX controller IP and a HDMI/eDP TX Combo PHY based on a
> Samsung IP block.
> 
> Add just the basic support for now, i.e. RGB output up to 4K@60Hz,
> without audio, CEC or any of the HDMI 2.1 specific features.
> 
> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
[ ... ]

> +static void dw_hdmi_qp_rockchip_encoder_enable(struct drm_encoder *encoder)
> +{
> +	struct rockchip_hdmi_qp *hdmi = to_rockchip_hdmi_qp(encoder);
> +	struct drm_crtc *crtc = encoder->crtc;
> +	unsigned long long rate;
> +
> +	/* Unconditionally switch to TMDS as FRL is not yet supported */
> +	gpiod_set_value(hdmi->enable_gpio, 1);
> +
> +	if (crtc && crtc->state) {
> +		rate = drm_hdmi_compute_mode_clock(&crtc->state->adjusted_mode,
> +						   8, HDMI_COLORSPACE_RGB);
> +		clk_set_rate(hdmi->ref_clk, rate);
> +		/*
> +		 * FIXME: Temporary workaround to pass pixel clock rate
> +		 * to the PHY driver until phy_configure_opts_hdmi
> +		 * becomes available in the PHY API. See also the related
> +		 * comment in rk_hdptx_phy_power_on() from
> +		 * drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> +		 */
> +		phy_set_bus_width(hdmi->phy, rate / 100);

On 32-bit systems:

ERROR: modpost: "__udivdi3" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!

in the mainline kernel.

If the driver is not build tested (much less working) on 32-bit builds,
please consider restricting it to 64 bit builds.

Thanks,
Guenter

