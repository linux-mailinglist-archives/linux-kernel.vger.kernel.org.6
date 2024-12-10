Return-Path: <linux-kernel+bounces-439498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F8B9EB015
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7E7166B30
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1560A210F49;
	Tue, 10 Dec 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w6ok7z94"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4332578F4E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831006; cv=none; b=LA7NpYvCZq/8rWdkCmxbUPEyFGhQ8SXKpdVZJ42bhIeT51KLMaNw9yAQ4iAjI6Q9qQuaVfguxJeSBgEbEu6xnbb8CCPI2LaWCLTtpeiCSUYDWIP0aMNTSGJFxFrK1qemqAOkXIZeelmicAvOEhuczDwAu9CgJM7TJQTuL9kCnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831006; c=relaxed/simple;
	bh=e8vDgDOcO5RIqHjRBTI9VvF3Ghj3iqWpCsSjLOYAe1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ+3n9hvc4uBz44TfW38F7OGcN7Efb+HVEukJYOjyeU8MKSnVlzPvc+OJ+OxneH/Kgfh7pTbv/6zPTNr6+4s2ConP7jGpm2qPTGDHpTqOxTXMseL9l81QtGlkVv/ZmevTA8aEx/JQh55GtIPzwnxQ9Pe/qNLW73mQe4UWeIWcyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w6ok7z94; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401c68b89eso2277593e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733831002; x=1734435802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bDuD4vOJTu/+TNrDw776dXillG1+SO1nfewpcnHal5U=;
        b=w6ok7z94MY2r//v23HeSurYchUtgl9pTqJVejn+rfg+60ZfXd1/joS11BKZLHLQbZQ
         RdUSPMabIoVbDlgl/3jpS/2sh2nUH6JHN91mqEocmE4qZHfPOn51wzMJTREf7AbQRG80
         O7zeHvxoIKt1Lr25qKddrgPSv+7FrRzFvgvyC6KsB7rGlmM1zJa7A48EGYVv6v8S9QI1
         CXAiYUSNZQ5yXdJm7K2ic3/11MPhkZbGhf4b2p6ka3L4zFOun00cRpsOxEyXN8FrQyFn
         ZxwV3Eth1Edzc7dBwszzFJUGZHlOYg7buLlFWZHqcPrntiKW3VhASD2TFNr/p/ZC/6Wp
         EhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733831002; x=1734435802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDuD4vOJTu/+TNrDw776dXillG1+SO1nfewpcnHal5U=;
        b=fFcYhqWopsYBjaQrqUcwaT5k8LB70rUCY+6qfojpOVCNjSJpA0V5dD9e0QPG/jKadM
         N4CLZ6kHEDi/NvaebKPCt3OsKGJrtg1F6UGaUVvl/w49ffmFc+lxKv6ofHEtfTbEaV7d
         3Uq8bDfLBHWNRCg4rPpG5FSUFM32uCPWD4FWoz7l2gQqA5inmcrK9yNHTsr4DjZMmDZb
         v1Lk0MrvpF57x8bwvSb/4pH9ACUO6T8hyCc9Pf96ddZC3iy11NqaCF+lwMB0iuLRAb+P
         FTH7Q7qlYjPgDHerD5Nlh39BkewdgA3gw5EHm9r9BuwjuwAeS3nmnVrAm/Iuo9wCyhMK
         7OqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlO1XuvVXyaiSMgMliLBdxw9F2DI+a2Sahqxib2ZWNS70kwfGJ0jETnTellzmE72YtoJxg4iIGdHzSxTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlTDTMCQ3FcJMn3W5o+tUvjyIsazMSPnIEoIa8xSQZglmB+rw6
	Dr/rInKsdwYd3a2ns0la67azKiYZha6EjhaDuCqj/9/TkaEMpxsklFGRMLNvIkM=
X-Gm-Gg: ASbGnctGnpxt9HN/D6QqfiCWT+7xLlaKczzhY8uV2uWNPIlIfulA5bT6ZbjWVcRP7VN
	LMzYBs3KFsvwDUssX9X8tRikU1lOGUpPqnf9Kln+qzz1uBsEQpL6nccVv2xWXZvYU9IxMDvCwYK
	2GzAfoYToZGBL/7H1QQSFViz6GYsjLIZBUqXzvk7LOqv3l8gfPPlVIpgjJqvt37OlCRKB0Y94im
	6GQ++KHYN8eVm7Gh4O46YkTtcRwnpoGZmWJ5kiuoCaJZ6/E8bQq3LNOvkuGQcYpilBVp2DlQxBp
	4S0DbJWVVMqCotZKnHBFQaDM0ARRIfkFnQ==
X-Google-Smtp-Source: AGHT+IHlLpHoQkMoGAXULRnbsa1CNz7DxSd8e5Kk0AkHyX98cxKn2C9E6+kb+xX37fsZPZiAJHZ8UA==
X-Received: by 2002:a05:6512:3a8e:b0:53e:2246:c262 with SMTP id 2adb3069b0e04-54024f87ef1mr883959e87.0.1733831002365;
        Tue, 10 Dec 2024 03:43:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3a36ee3fsm1127765e87.107.2024.12.10.03.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 03:43:21 -0800 (PST)
Date: Tue, 10 Dec 2024 13:43:19 +0200
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
Subject: Re: [PATCH v5 2/3] drm/bridge: ti-sn65dsi83: Add ti,lvds-vod-swing
 optional properties
Message-ID: <irpmhq7vxjra6vhmdh7p63ajj57n3h2c4br3ija2jmwtoewist@zyxfmx6k5m4e>
References: <20241210091901.83028-1-andrej.picej@norik.com>
 <20241210091901.83028-3-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210091901.83028-3-andrej.picej@norik.com>

On Tue, Dec 10, 2024 at 10:19:00AM +0100, Andrej Picej wrote:
> Add a optional properties to change LVDS output voltage. This should not
> be static as this depends mainly on the connected display voltage
> requirement. We have three properties:
> - "ti,lvds-termination-ohms", which sets near end termination,
> - "ti,lvds-vod-swing-data-microvolt" and
> - "ti,lvds-vod-swing-clock-microvolt" which both set LVDS differential
> output voltage for data and clock lanes. They are defined as an array
> with min and max values. The appropriate bitfield will be set if
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
> Changes in v5:
> - specify default values in sn65dsi83_parse_lvds_endpoint,
> - move sn65dsi83_parse_lvds_endpoint for channel B up, outside if,
> Changes in v4:
> - fix typo in commit message bitfiled -> bitfield
> - use arrays (lvds_vod_swing_conf and lvds_term_conf) in private data, instead
> of separate variables for channel A/B
> - add more checks on return value of "of_property_read_u32_array"
> Changes in v3:
> - use microvolts for default array values 1000 mV -> 1000000 uV.
> Changes in v2:
> - use datasheet tables to get the proper configuration
> - since major change was done change the authorship to myself
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 142 +++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 57a7ed13f996..f9578b38da28 100644
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
> @@ -147,6 +157,8 @@ struct sn65dsi83 {
>  	struct regulator		*vcc;
>  	bool				lvds_dual_link;
>  	bool				lvds_dual_link_even_odd_swap;
> +	int				lvds_vod_swing_conf[2];
> +	int				lvds_term_conf[2];
>  };
>  
>  static const struct regmap_range sn65dsi83_readable_ranges[] = {
> @@ -237,6 +249,36 @@ static const struct regmap_config sn65dsi83_regmap_config = {
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
> @@ -435,12 +477,16 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>  		val |= REG_LVDS_FMT_LVDS_LINK_CFG;
>  
>  	regmap_write(ctx->regmap, REG_LVDS_FMT, val);
> -	regmap_write(ctx->regmap, REG_LVDS_VCOM, 0x05);
> +	regmap_write(ctx->regmap, REG_LVDS_VCOM,
> +			REG_LVDS_VCOM_CHA_LVDS_VOD_SWING(ctx->lvds_vod_swing_conf[CHANNEL_A]) |
> +			REG_LVDS_VCOM_CHB_LVDS_VOD_SWING(ctx->lvds_vod_swing_conf[CHANNEL_B]));
>  	regmap_write(ctx->regmap, REG_LVDS_LANE,
>  		     (ctx->lvds_dual_link_even_odd_swap ?
>  		      REG_LVDS_LANE_EVEN_ODD_SWAP : 0) |
> -		     REG_LVDS_LANE_CHA_LVDS_TERM |
> -		     REG_LVDS_LANE_CHB_LVDS_TERM);
> +		     (ctx->lvds_term_conf[CHANNEL_A] ?
> +			  REG_LVDS_LANE_CHA_LVDS_TERM : 0) |
> +		     (ctx->lvds_term_conf[CHANNEL_B] ?
> +			  REG_LVDS_LANE_CHB_LVDS_TERM : 0));
>  	regmap_write(ctx->regmap, REG_LVDS_CM, 0x00);
>  
>  	le16val = cpu_to_le16(mode->hdisplay);
> @@ -576,10 +622,100 @@ static const struct drm_bridge_funcs sn65dsi83_funcs = {
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
> +	int endpoint_reg;
> +	/* Set so the property can be freely selected if not defined */
> +	u32 lvds_vod_swing_data[2] = { 0, 1000000 };
> +	u32 lvds_vod_swing_clk[2] = { 0, 1000000 };
> +	u32 lvds_term;
> +	u8 lvds_term_conf = 0x1;
> +	int lvds_vod_swing_conf = 0x1;

Magic values

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
> +	if (!of_property_read_u32(endpoint, "ti,lvds-termination-ohms", &lvds_term)) {

The code has been better before:
provide default for lvds_term, read the property (keeping the default in
case of an error), then use the lvds_term to set up lvds_term_conf, as
expected.

> +		if (lvds_term == 100)
> +			lvds_term_conf = OHM_100;
> +		else
> +			lvds_term_conf = OHM_200;
> +	}
> +
> +	ctx->lvds_term_conf[channel] = lvds_term_conf;
> +
> +	ret_data = of_property_read_u32_array(endpoint,
> +			"ti,lvds-vod-swing-data-microvolt", lvds_vod_swing_data,
> +			ARRAY_SIZE(lvds_vod_swing_data));
> +	if (ret_data != 0 && ret_data != -EINVAL) {
> +		ret = ret_data;
> +		goto exit;
> +	}
> +
> +	ret_clock = of_property_read_u32_array(endpoint,
> +			"ti,lvds-vod-swing-clock-microvolt", lvds_vod_swing_clk,
> +			ARRAY_SIZE(lvds_vod_swing_clk));
> +	if (ret_clock != 0 && ret_clock != -EINVAL) {
> +		ret = ret_clock;
> +		goto exit;
> +	}
> +
> +	/* If any of the two properties is defined. */
> +	if (!ret_data || !ret_clock) {
> +		lvds_vod_swing_conf = sn65dsi83_select_lvds_vod_swing(dev,
> +			lvds_vod_swing_data, lvds_vod_swing_clk,
> +			lvds_term_conf);
> +		if (lvds_vod_swing_conf < 0) {
> +			ret = lvds_vod_swing_conf;
> +			goto exit;
> +		}
> +	}
> +
> +	ctx->lvds_vod_swing_conf[channel] = lvds_vod_swing_conf;
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
> +	ret = sn65dsi83_parse_lvds_endpoint(ctx, CHANNEL_A);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = sn65dsi83_parse_lvds_endpoint(ctx, CHANNEL_B);
> +	if (ret < 0)
> +		return ret;
>  
>  	ctx->lvds_dual_link = false;
>  	ctx->lvds_dual_link_even_odd_swap = false;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

