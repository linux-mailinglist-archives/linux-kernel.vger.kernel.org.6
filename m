Return-Path: <linux-kernel+bounces-429932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A339E2926
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45FA169741
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2A01FA251;
	Tue,  3 Dec 2024 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="juGiEp1w"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96431FA252
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246799; cv=none; b=YsILr93ELd7RxS0twwFd+e1EBjZOgbPjOKHTp6Ssabiau3kbAWe3Xt3IIHGv0AKwoq3xrYcJPsEkNdnURyW1631ELZt84w6MC73UCvlXpHEflwknPTYujvr4O1QVe9RgMSaKUYcICMCb5WCBctyL0akyeQDUggKeUhesF1qoX/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246799; c=relaxed/simple;
	bh=Iei3XMGaeu2NW99Qz4aaJQtc9xdHR0PI77YhyfrL8BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/xfx57WudXjUkPlI4kFkLqtjWdNshExluRhaE19BAfDCvqbZWfVEAdm7rgMVYufnzG5y0LJX8MXQ7AWNPUNyKRzJZg5rILeMcPNZxP2rNy2g4P23i6c9lB5gIIbiTPEFKhrzomCZKPyrde3Vx0err40EYl4V5nOdtzm+ycnV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=juGiEp1w; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc86948dcso59745151fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 09:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733246796; x=1733851596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz/rrNS+hlEL9lqbe3mK8LVGBrP6tU57imWfKl+L6qk=;
        b=juGiEp1wX4rWKrTmbBExzJxAeTdo8jpfkPkZSYFLRddBR+mPI0Y7XPOROogwsO/avP
         KmVkn4fTSvmTeGIawJG96hJyIGZZzhW6BskpB4tLY2+bSItdp2BR90hI8/Rqef2HJQNU
         Oj1kLH9zkfDsXUSqDYOcqmqH3v4XMGOp/AL4s1pYTZacRNvqt2p3WAR2cLG0Dq/4R7d8
         Tf9awsFFbcWFilhp/XZpqjtc/kMjagsUKHEQLS2vUC9THrGrdKS/TfcPULkmTDpjYwZf
         XqX7ql2WG7RBWrBvDMwvPDK44pPgr5vAReHFwDUWSrLPvbWVSQDpcO+GUtkcCYsvjAQv
         DN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246796; x=1733851596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz/rrNS+hlEL9lqbe3mK8LVGBrP6tU57imWfKl+L6qk=;
        b=fTmLiFo8C8Qi1Pttakh+TXxZPwhtNeDY244W3Fy3mlhh/FVVT2UOjBM1INx8oVenGg
         Pq9i6KISviCCJSaWio3z8V2wH9C+Kvh86OTf17dAs1NaAeutz2Yitwt65hbt0OPOkGCV
         8lFHG1iA7Rfbe4jgEieZ/ktbI4sHTZg3Pq4F390w+ZLWMVDXOPSR6MULrApxXHuGRcqK
         WHFQw/CHAAxngMnEN5/g+Lh8I6q0AKcX3P9Afqad4EL5FeTFbFnHznh5Uyfkfs4WR5nV
         JQC1e87WtT5+2h/VNb1pgU1Ui/8k08eZUkpjsrffkcuOzOZii4PUOlSnlDswGY9bqCvw
         pOBA==
X-Forwarded-Encrypted: i=1; AJvYcCW2PYRBpaYi8hklxcGNUi2BaXkL3ShKLAy4V+BMsvozwSBP0n5YhQ4Ft4tpCaExrKwVZIYk2rW34FAvssY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+y2zCXXMYD6da/VlHeMVkiNCo4ED/uMF5w8Imaxhb7wjBtmmP
	E45qeV6Y6XJ9XtRAMITY7uSUXoE2TYXpXdCh7f0TnJ+mJhJ2DaGbVk1vcGSMpGI=
X-Gm-Gg: ASbGncuKxlZhZWfdWFbYjZgtlfww4fbiX/CUVIPPxz1aol+cqk4S4IW5xwy4T9Glajg
	oAvU99En1EC6wU8Hm52n7TqMunHVZHu8hlbCfL7nstVGgJd7Y5l4e/yT9eA1y2ihoRNnvZOYrS9
	pOrCYsX/5HCEnQgCEeoo4CULx9OP8CsmMOHlYsnqNV1pRakkJwYjEsb/qKGGKwnq0OvJ/k8yQzP
	pYljFFlUVe8GZg3Srhi+/uNHjlybBPYjM4RLAJpGA3NYXzpu58kGn+DvW9f8OEiF5gezNCPi3s7
	ESkPF7A0ZdfAfVD35TUDu7QnPpm1Gw==
X-Google-Smtp-Source: AGHT+IHDzL+kViFvLr4LvMnl3L0hi2JMmKApYJ/jwTbetTdwojNyOBaCgkw29eR2Ie0p1Bi0zs9POQ==
X-Received: by 2002:a2e:a911:0:b0:2ff:d2c8:84fb with SMTP id 38308e7fff4ca-30009c61a31mr24281101fa.24.1733246795808;
        Tue, 03 Dec 2024 09:26:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbeb8cbsm17312061fa.33.2024.12.03.09.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:26:34 -0800 (PST)
Date: Tue, 3 Dec 2024 19:26:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Andrej Picej <andrej.picej@norik.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, marex@denx.de, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
Subject: Re: [PATCH v3 2/3] drm/bridge: ti-sn65dsi83: Add ti, lvds-vod-swing
 optional properties
Message-ID: <sjcspny5lmynm4q2dnkhktvwte5e3gigtujynaiqp5gr5rkqfn@j2h5f6xiwz34>
References: <20241203110054.2506123-1-andrej.picej@norik.com>
 <20241203110054.2506123-3-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203110054.2506123-3-andrej.picej@norik.com>

On Tue, Dec 03, 2024 at 12:00:53PM +0100, Andrej Picej wrote:
> Add a optional properties to change LVDS output voltage. This should not
> be static as this depends mainly on the connected display voltage
> requirement. We have three properties:
> - "ti,lvds-termination-ohms", which sets near end termination,
> - "ti,lvds-vod-swing-data-microvolt" and
> - "ti,lvds-vod-swing-clock-microvolt" which both set LVDS differential
> output voltage for data and clock lanes. They are defined as an array
> with min and max values. The appropriate bitfiled will be set if
> selected constraints can be met.
> 
> If "ti,lvds-termination-ohms" is not defined the default of 200 Ohm near
> end termination will be used. Selecting only one:
> "ti,lvds-vod-swing-data-microvolt" or
> "ti,lvds-vod-swing-clock-microvolt" can be done, but the output voltage
> constraint for only data/clock lanes will be met. Setting both is
> recommended.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
> Changes in v3:
> - use microvolts for default array values 1000 mV -> 1000000 uV.
> Changes in v2:
> - use datasheet tables to get the proper configuration
> - since major change was done change the authorship to myself
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 144 +++++++++++++++++++++++++-
>  1 file changed, 141 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 57a7ed13f996..1a070df5ea12 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -132,6 +132,16 @@
>  #define  REG_IRQ_STAT_CHA_SOT_BIT_ERR		BIT(2)
>  #define  REG_IRQ_STAT_CHA_PLL_UNLOCK		BIT(0)
>  
> +enum sn65dsi83_channel {
> +	CHANNEL_A,
> +	CHANNEL_B
> +};
> +
> +enum sn65dsi83_lvds_term {
> +	OHM_100,
> +	OHM_200
> +};
> +
>  enum sn65dsi83_model {
>  	MODEL_SN65DSI83,
>  	MODEL_SN65DSI84,
> @@ -147,6 +157,10 @@ struct sn65dsi83 {
>  	struct regulator		*vcc;
>  	bool				lvds_dual_link;
>  	bool				lvds_dual_link_even_odd_swap;
> +	int				lvdsA_vod_swing_conf;
> +	int				lvdsB_vod_swing_conf;
> +	int				lvdsA_term_conf;
> +	int				lvdsB_term_conf;
>  };
>  
>  static const struct regmap_range sn65dsi83_readable_ranges[] = {
> @@ -237,6 +251,36 @@ static const struct regmap_config sn65dsi83_regmap_config = {
>  	.max_register = REG_IRQ_STAT,
>  };
>  
> +static const int lvds_vod_swing_data_table[2][4][2] = {
> +	{	/* 100 Ohm */
> +		{ 180000, 313000 },
> +		{ 215000, 372000 },
> +		{ 250000, 430000 },
> +		{ 290000, 488000 },
> +	},
> +	{	/* 200 Ohm */
> +		{ 150000, 261000 },
> +		{ 200000, 346000 },
> +		{ 250000, 428000 },
> +		{ 300000, 511000 },
> +	},
> +};
> +
> +static const int lvds_vod_swing_clock_table[2][4][2] = {
> +	{	/* 100 Ohm */
> +		{ 140000, 244000 },
> +		{ 168000, 290000 },
> +		{ 195000, 335000 },
> +		{ 226000, 381000 },
> +	},
> +	{	/* 200 Ohm */
> +		{ 117000, 204000 },
> +		{ 156000, 270000 },
> +		{ 195000, 334000 },
> +		{ 234000, 399000 },
> +	},
> +};
> +
>  static struct sn65dsi83 *bridge_to_sn65dsi83(struct drm_bridge *bridge)
>  {
>  	return container_of(bridge, struct sn65dsi83, bridge);
> @@ -435,12 +479,16 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>  		val |= REG_LVDS_FMT_LVDS_LINK_CFG;
>  
>  	regmap_write(ctx->regmap, REG_LVDS_FMT, val);
> -	regmap_write(ctx->regmap, REG_LVDS_VCOM, 0x05);
> +	regmap_write(ctx->regmap, REG_LVDS_VCOM,
> +			REG_LVDS_VCOM_CHA_LVDS_VOD_SWING(ctx->lvdsA_vod_swing_conf) |
> +			REG_LVDS_VCOM_CHB_LVDS_VOD_SWING(ctx->lvdsB_vod_swing_conf));
>  	regmap_write(ctx->regmap, REG_LVDS_LANE,
>  		     (ctx->lvds_dual_link_even_odd_swap ?
>  		      REG_LVDS_LANE_EVEN_ODD_SWAP : 0) |
> -		     REG_LVDS_LANE_CHA_LVDS_TERM |
> -		     REG_LVDS_LANE_CHB_LVDS_TERM);
> +		     (ctx->lvdsA_term_conf ?
> +			  REG_LVDS_LANE_CHA_LVDS_TERM : 0) |
> +		     (ctx->lvdsB_term_conf ?
> +			  REG_LVDS_LANE_CHB_LVDS_TERM : 0));
>  	regmap_write(ctx->regmap, REG_LVDS_CM, 0x00);
>  
>  	le16val = cpu_to_le16(mode->hdisplay);
> @@ -576,10 +624,96 @@ static const struct drm_bridge_funcs sn65dsi83_funcs = {
>  	.atomic_get_input_bus_fmts = sn65dsi83_atomic_get_input_bus_fmts,
>  };
>  
> +static int sn65dsi83_select_lvds_vod_swing(struct device *dev,
> +	u32 lvds_vod_swing_data[2], u32 lvds_vod_swing_clk[2], u8 lvds_term)
> +{
> +	int i;
> +
> +	for (i = 0; i <= 3; i++) {
> +		if (lvds_vod_swing_data_table[lvds_term][i][0] >= lvds_vod_swing_data[0] &&
> +		lvds_vod_swing_data_table[lvds_term][i][1] <= lvds_vod_swing_data[1] &&
> +		lvds_vod_swing_clock_table[lvds_term][i][0] >= lvds_vod_swing_clk[0] &&
> +		lvds_vod_swing_clock_table[lvds_term][i][1] <= lvds_vod_swing_clk[1])
> +			return i;
> +	}
> +
> +	dev_err(dev, "failed to find appropriate LVDS_VOD_SWING configuration\n");
> +	return -EINVAL;
> +}
> +
> +static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
> +{
> +	struct device *dev = ctx->dev;
> +	struct device_node *endpoint;
> +	/* Set so the property can be freely selected if not defined */
> +	u32 lvds_vod_swing_data[2] = { 0, 1000000 };
> +	u32 lvds_vod_swing_clk[2] = { 0, 1000000 };
> +	u32 lvds_term = 200;
> +	u8 lvds_term_conf;
> +	int endpoint_reg;
> +	int lvds_vod_swing_conf;
> +	int ret = 0;
> +	int ret_data;
> +	int ret_clock;
> +
> +	if (channel == CHANNEL_A)
> +		endpoint_reg = 2;
> +	else
> +		endpoint_reg = 3;
> +
> +	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, endpoint_reg, -1);
> +	of_property_read_u32(endpoint, "ti,lvds-termination-ohms", &lvds_term);
> +
> +	if (lvds_term == 200)
> +		lvds_term_conf = OHM_200;
> +	else
> +		lvds_term_conf = OHM_100;
> +
> +	if (channel == CHANNEL_A)
> +		ctx->lvdsA_term_conf = lvds_term_conf;
> +	else
> +		ctx->lvdsB_term_conf = lvds_term_conf;

This sounds like ctx->lvds_term_conf[channel] = ...;

And so on for other properties.

> +
> +	ret_data = of_property_read_u32_array(endpoint,
> +			"ti,lvds-vod-swing-data-microvolt", lvds_vod_swing_data,
> +			ARRAY_SIZE(lvds_vod_swing_data));
> +	ret_clock = of_property_read_u32_array(endpoint,
> +			"ti,lvds-vod-swing-clock-microvolt", lvds_vod_swing_clk,
> +			ARRAY_SIZE(lvds_vod_swing_clk));
> +	/* If any of the two properties is defined. */
> +	if (!ret_data || !ret_clock) {

I think it's not that easy. We were usually ignoring errors for a
single-value properties, but for the arrays I think we should make a
diffence between the property being not present in DT and the property
being erroneous or not being parsed correctly.

> +		lvds_vod_swing_conf = sn65dsi83_select_lvds_vod_swing(dev,
> +			lvds_vod_swing_data, lvds_vod_swing_clk,
> +			lvds_term_conf);
> +		if (lvds_vod_swing_conf < 0) {
> +			ret = lvds_vod_swing_conf;
> +			goto exit;
> +		}
> +		if (channel == CHANNEL_A)
> +			ctx->lvdsA_vod_swing_conf = lvds_vod_swing_conf;
> +		else
> +			ctx->lvdsB_vod_swing_conf = lvds_vod_swing_conf;
> +	}
> +	ret = 0;
> +exit:
> +	of_node_put(endpoint);
> +	return ret;
> +}
> +
>  static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
>  {
>  	struct drm_bridge *panel_bridge;
>  	struct device *dev = ctx->dev;
> +	int ret;
> +
> +	ctx->lvdsA_vod_swing_conf = 0x1;
> +	ctx->lvdsB_vod_swing_conf = 0x1;
> +	ctx->lvdsA_term_conf = 0x1;
> +	ctx->lvdsB_term_conf = 0x1;
> +
> +	ret = sn65dsi83_parse_lvds_endpoint(ctx, CHANNEL_A);
> +	if (ret < 0)
> +		return ret;
>  
>  	ctx->lvds_dual_link = false;
>  	ctx->lvds_dual_link_even_odd_swap = false;
> @@ -587,6 +721,10 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
>  		struct device_node *port2, *port3;
>  		int dual_link;
>  
> +		ret = sn65dsi83_parse_lvds_endpoint(ctx, CHANNEL_B);
> +		if (ret < 0)
> +			return ret;
> +
>  		port2 = of_graph_get_port_by_id(dev->of_node, 2);
>  		port3 = of_graph_get_port_by_id(dev->of_node, 3);
>  		dual_link = drm_of_lvds_get_dual_link_pixel_order(port2, port3);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

