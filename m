Return-Path: <linux-kernel+bounces-439673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A5A9EB273
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA4128A25F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC061AAE19;
	Tue, 10 Dec 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sW838HXZ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C72B1AAA38
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839172; cv=none; b=IE1yHTY4bzYaRY7vUAObgu2ErM2qR3cWy6oOPRfSOc09RWbBtS4pedZVXXLpmhoSBLfziyRq2HEj+Pgmx66g7xiKvUZBLqTyQCg1r2zTYMeL5oPJhq3aYPbX5RPr3KkVfzHJbVBShtYPZ5DGxwWuoW+ZdyFGgdroxnzwh0lHG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839172; c=relaxed/simple;
	bh=YFHaCumLgVztfNtujqj8vfapc7ypLWnAYDrIDmo+bdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICzWAWIQDY+r4lcqWJ1VesuuIYCALEVEISOXeQq5GGLSGnnw1Q4oOfJHTEEjOP5ICf7Z3jvbiAgVOpffiVOsBjfVHxYPg8GBRRwvq3g4tSIs+1GP9t7rJeONHhrgWbqV4mDW+3dNunP28jkjrKsnLJNMhcnww/JiHPrU2lJ+0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sW838HXZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30229d5b22fso16780471fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733839168; x=1734443968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1b2CN5KijSQW1PyEx+uqHMLZ82Jfnx81Mjxlq0yFxLw=;
        b=sW838HXZq1dBd5yXCj+J2p3Fxd6LDLunb2XpH5eYCvF82PX7BpefV8g+QATZEXu9xH
         hvXpSVCUlhdd0x1ur87uKaVCnHQ0smCAgFXoxeY0qxyUrUBSpvw71CIr3590DkP5Srwt
         2hWwYSDAU+vrRKvQbYOJFkRRq8C60Os1909pdzbUp2EPaywLtlww0XI3bGP4wOcU0sy+
         DsNMMlbR51qng2i65Nl5nBJFprCIME/YJbEMlA3KY/3HJM5kEgB9bSydHzrQ0bsnIobJ
         jgGa63avszwM8qacGtGxNYAC0yTbSrGy2qdk3UqSzd7JDY+dYsDxM3qdHXYKoUVQOzMj
         CAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839168; x=1734443968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b2CN5KijSQW1PyEx+uqHMLZ82Jfnx81Mjxlq0yFxLw=;
        b=KndlxNoObzor5nAHAT0GN2GPOIoinfL5Rfc0f4iL12hQDsugrdoxBBd89abZ7lKZnH
         sHz7R/kaITHIIApBZxwZjUngccvI26byzU3/HeLmI4RqtLkMPNOJ8cd9/sYmNmqm0f+n
         8077dFKNoriak2xNgAc58HshrRSkFJzfA5pxpZOJi3X1bPRj0QWH6Mw+p0gUUcqwhi6r
         K2J8qex8qjdYBKt18158Y2yvS0HMmABNbCcDxLztchzJARgpE0rrzbGjgaR5BYB4p5E4
         gJHd2pJ2qnA573bWr+wMjygRoooqdkOk9Ga331AQia8u69IIkc8s/GQ74PmfAN2fUXkf
         ZaHg==
X-Forwarded-Encrypted: i=1; AJvYcCX/EqE12cyN7XxjAz0As38xwzojgD/NG+FzrYG57nWfRlBqhMqalIdCbnKVXtAzq0H4wixIFTGPYntCfa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynK7/kZm/J6apAnI0MwqVBu8Ii5apQSNDmrSVv5jhVEPcXpKlP
	pW09QqA//ULF+GbNcO+LtQfHr/6YMsoNY/ntG6VOw9NcYPwxk8SnfWIfQ3EeBk4=
X-Gm-Gg: ASbGnct/CubWbeBbQ2GBebUyvb+xyY02qu+LaHGgt2qQI7gCQ9Wt6P9pMDT3d0vwPKg
	iX6PgQynnmbGG6m81wJm+EoPvT373J8klraeOo9hmIhSiA4mayDboYZOUHFwB4cPOxPdX6kYKYN
	Z2Tr8xmtneshKG2FlSmI3x2BdRczFWJUPN4TyvR8Tu8RLIn8jUNcWBskBor5KVZHEUfDXxkJVGk
	Si8D5THCrpCVSQn/CH0NFVX6AxV4YxMEcoD+0IevBSLwiSZqDC9943mwm2jMn3YJ2jYrAHKd8tm
	AHWmCrr+oXYP5niw6lzbOhIPqA6zi6WnXQ==
X-Google-Smtp-Source: AGHT+IGdkjQtYlZTfLzIp6AvgDXHgPosZz1omSRVn2htXRtkRgglyTI/N9ZYTrDiJZmOIRaiPOr3Yg==
X-Received: by 2002:a05:6512:3da3:b0:53f:f074:801c with SMTP id 2adb3069b0e04-54024104977mr1653910e87.41.1733839168101;
        Tue, 10 Dec 2024 05:59:28 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e301cffd8sm1342870e87.204.2024.12.10.05.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 05:59:26 -0800 (PST)
Date: Tue, 10 Dec 2024 15:59:24 +0200
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
Message-ID: <qhmsobin3fsmoc7ic2jtancowfscoauyroruxdpwhmqwlogtkz@6by3s2ruwzwp>
References: <20241210091901.83028-1-andrej.picej@norik.com>
 <20241210091901.83028-3-andrej.picej@norik.com>
 <irpmhq7vxjra6vhmdh7p63ajj57n3h2c4br3ija2jmwtoewist@zyxfmx6k5m4e>
 <aa2de99d-21f4-4843-83b7-5d2db78be86f@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa2de99d-21f4-4843-83b7-5d2db78be86f@norik.com>

On Tue, Dec 10, 2024 at 02:41:01PM +0100, Andrej Picej wrote:
> 
> 
> On 10. 12. 24 12:43, Dmitry Baryshkov wrote:
> > On Tue, Dec 10, 2024 at 10:19:00AM +0100, Andrej Picej wrote:
> > > Add a optional properties to change LVDS output voltage. This should not
> > > be static as this depends mainly on the connected display voltage
> > > requirement. We have three properties:
> > > - "ti,lvds-termination-ohms", which sets near end termination,
> > > - "ti,lvds-vod-swing-data-microvolt" and
> > > - "ti,lvds-vod-swing-clock-microvolt" which both set LVDS differential
> > > output voltage for data and clock lanes. They are defined as an array
> > > with min and max values. The appropriate bitfield will be set if
> > > selected constraints can be met.
> > > 
> > > If "ti,lvds-termination-ohms" is not defined the default of 200 Ohm near
> > > end termination will be used. Selecting only one:
> > > "ti,lvds-vod-swing-data-microvolt" or
> > > "ti,lvds-vod-swing-clock-microvolt" can be done, but the output voltage
> > > constraint for only data/clock lanes will be met. Setting both is
> > > recommended.
> > > 
> > > Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> > > ---
> > > Changes in v5:
> > > - specify default values in sn65dsi83_parse_lvds_endpoint,
> > > - move sn65dsi83_parse_lvds_endpoint for channel B up, outside if,
> > > Changes in v4:
> > > - fix typo in commit message bitfiled -> bitfield
> > > - use arrays (lvds_vod_swing_conf and lvds_term_conf) in private data, instead
> > > of separate variables for channel A/B
> > > - add more checks on return value of "of_property_read_u32_array"
> > > Changes in v3:
> > > - use microvolts for default array values 1000 mV -> 1000000 uV.
> > > Changes in v2:
> > > - use datasheet tables to get the proper configuration
> > > - since major change was done change the authorship to myself
> > > ---
> > >   drivers/gpu/drm/bridge/ti-sn65dsi83.c | 142 +++++++++++++++++++++++++-
> > >   1 file changed, 139 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > index 57a7ed13f996..f9578b38da28 100644
> > > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > @@ -132,6 +132,16 @@
> > >   #define  REG_IRQ_STAT_CHA_SOT_BIT_ERR		BIT(2)
> > >   #define  REG_IRQ_STAT_CHA_PLL_UNLOCK		BIT(0)
> > > +enum sn65dsi83_channel {
> > > +	CHANNEL_A,
> > > +	CHANNEL_B
> > > +};
> > > +
> > > +enum sn65dsi83_lvds_term {
> > > +	OHM_100,
> > > +	OHM_200
> > > +};
> > > +
> > >   enum sn65dsi83_model {
> > >   	MODEL_SN65DSI83,
> > >   	MODEL_SN65DSI84,
> > > @@ -147,6 +157,8 @@ struct sn65dsi83 {
> > >   	struct regulator		*vcc;
> > >   	bool				lvds_dual_link;
> > >   	bool				lvds_dual_link_even_odd_swap;
> > > +	int				lvds_vod_swing_conf[2];
> > > +	int				lvds_term_conf[2];
> > >   };
> > >   static const struct regmap_range sn65dsi83_readable_ranges[] = {
> > > @@ -237,6 +249,36 @@ static const struct regmap_config sn65dsi83_regmap_config = {
> > >   	.max_register = REG_IRQ_STAT,
> > >   };
> > > +static const int lvds_vod_swing_data_table[2][4][2] = {
> > > +	{	/* 100 Ohm */
> > > +		{ 180000, 313000 },
> > > +		{ 215000, 372000 },
> > > +		{ 250000, 430000 },
> > > +		{ 290000, 488000 },
> > > +	},
> > > +	{	/* 200 Ohm */
> > > +		{ 150000, 261000 },
> > > +		{ 200000, 346000 },
> > > +		{ 250000, 428000 },
> > > +		{ 300000, 511000 },
> > > +	},
> > > +};
> > > +
> > > +static const int lvds_vod_swing_clock_table[2][4][2] = {
> > > +	{	/* 100 Ohm */
> > > +		{ 140000, 244000 },
> > > +		{ 168000, 290000 },
> > > +		{ 195000, 335000 },
> > > +		{ 226000, 381000 },
> > > +	},
> > > +	{	/* 200 Ohm */
> > > +		{ 117000, 204000 },
> > > +		{ 156000, 270000 },
> > > +		{ 195000, 334000 },
> > > +		{ 234000, 399000 },
> > > +	},
> > > +};
> > > +
> > >   static struct sn65dsi83 *bridge_to_sn65dsi83(struct drm_bridge *bridge)
> > >   {
> > >   	return container_of(bridge, struct sn65dsi83, bridge);
> > > @@ -435,12 +477,16 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
> > >   		val |= REG_LVDS_FMT_LVDS_LINK_CFG;
> > >   	regmap_write(ctx->regmap, REG_LVDS_FMT, val);
> > > -	regmap_write(ctx->regmap, REG_LVDS_VCOM, 0x05);
> > > +	regmap_write(ctx->regmap, REG_LVDS_VCOM,
> > > +			REG_LVDS_VCOM_CHA_LVDS_VOD_SWING(ctx->lvds_vod_swing_conf[CHANNEL_A]) |
> > > +			REG_LVDS_VCOM_CHB_LVDS_VOD_SWING(ctx->lvds_vod_swing_conf[CHANNEL_B]));
> > >   	regmap_write(ctx->regmap, REG_LVDS_LANE,
> > >   		     (ctx->lvds_dual_link_even_odd_swap ?
> > >   		      REG_LVDS_LANE_EVEN_ODD_SWAP : 0) |
> > > -		     REG_LVDS_LANE_CHA_LVDS_TERM |
> > > -		     REG_LVDS_LANE_CHB_LVDS_TERM);
> > > +		     (ctx->lvds_term_conf[CHANNEL_A] ?
> > > +			  REG_LVDS_LANE_CHA_LVDS_TERM : 0) |
> > > +		     (ctx->lvds_term_conf[CHANNEL_B] ?
> > > +			  REG_LVDS_LANE_CHB_LVDS_TERM : 0));
> > >   	regmap_write(ctx->regmap, REG_LVDS_CM, 0x00);
> > >   	le16val = cpu_to_le16(mode->hdisplay);
> > > @@ -576,10 +622,100 @@ static const struct drm_bridge_funcs sn65dsi83_funcs = {
> > >   	.atomic_get_input_bus_fmts = sn65dsi83_atomic_get_input_bus_fmts,
> > >   };
> > > +static int sn65dsi83_select_lvds_vod_swing(struct device *dev,
> > > +	u32 lvds_vod_swing_data[2], u32 lvds_vod_swing_clk[2], u8 lvds_term)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i <= 3; i++) {
> > > +		if (lvds_vod_swing_data_table[lvds_term][i][0] >= lvds_vod_swing_data[0] &&
> > > +		lvds_vod_swing_data_table[lvds_term][i][1] <= lvds_vod_swing_data[1] &&
> > > +		lvds_vod_swing_clock_table[lvds_term][i][0] >= lvds_vod_swing_clk[0] &&
> > > +		lvds_vod_swing_clock_table[lvds_term][i][1] <= lvds_vod_swing_clk[1])
> > > +			return i;
> > > +	}
> > > +
> > > +	dev_err(dev, "failed to find appropriate LVDS_VOD_SWING configuration\n");
> > > +	return -EINVAL;
> > > +}
> > > +
> > > +static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
> > > +{
> > > +	struct device *dev = ctx->dev;
> > > +	struct device_node *endpoint;
> > > +	int endpoint_reg;
> > > +	/* Set so the property can be freely selected if not defined */
> > > +	u32 lvds_vod_swing_data[2] = { 0, 1000000 };
> > > +	u32 lvds_vod_swing_clk[2] = { 0, 1000000 };
> > > +	u32 lvds_term;
> > > +	u8 lvds_term_conf = 0x1;
> > > +	int lvds_vod_swing_conf = 0x1;
> > 
> > Magic values
> 
> Can you please elaborate.
> 
> I can use:
> u8 lvds_term_conf = OHM_200;
> 
> What about lvds_vod_swing_conf? Should I create additional define for it?
> But this doesn't solve a hidden meaning? Maybe additional comment above?
> Would like to avoid using voltages for it, since then we are reverse
> engineering the table in datasheet to match the default reg value.

I think the following example solves both problems:

lvds_term = 200;
of_property_read_u32(..., &lvds_term);

if (lvds_term == 100)
	ctx->lvds_term_conf[channel] = OHM_100;
else if (lvds_term == 200)
	ctx->lvds_term_conf[channel] = OHM_200;
else
	return -EINVAL;

The same approach can be applied to lvds_vod_swing_conf, resulting in
removal of magic values.

> 
> > 
> > > +	int ret = 0;
> > > +	int ret_data;
> > > +	int ret_clock;
> > > +
> > > +	if (channel == CHANNEL_A)
> > > +		endpoint_reg = 2;
> > > +	else
> > > +		endpoint_reg = 3;
> > > +
> > > +	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, endpoint_reg, -1);
> > > +	if (!of_property_read_u32(endpoint, "ti,lvds-termination-ohms", &lvds_term)) {
> > 
> > The code has been better before:
> > provide default for lvds_term, read the property (keeping the default in
> > case of an error), then use the lvds_term to set up lvds_term_conf, as
> > expected.
> 
> Ok, will revert back.
> 
> > 
> > > +		if (lvds_term == 100)
> > > +			lvds_term_conf = OHM_100;
> > > +		else
> > > +			lvds_term_conf = OHM_200;
> > > +	}
> > > +
> > > +	ctx->lvds_term_conf[channel] = lvds_term_conf;
> > > +
> > > +	ret_data = of_property_read_u32_array(endpoint,
> > > +			"ti,lvds-vod-swing-data-microvolt", lvds_vod_swing_data,
> > > +			ARRAY_SIZE(lvds_vod_swing_data));
> > > +	if (ret_data != 0 && ret_data != -EINVAL) {
> > > +		ret = ret_data;
> > > +		goto exit;
> > > +	}
> > > +
> > > +	ret_clock = of_property_read_u32_array(endpoint,
> > > +			"ti,lvds-vod-swing-clock-microvolt", lvds_vod_swing_clk,
> > > +			ARRAY_SIZE(lvds_vod_swing_clk));
> > > +	if (ret_clock != 0 && ret_clock != -EINVAL) {
> > > +		ret = ret_clock;
> > > +		goto exit;
> > > +	}
> > > +
> > > +	/* If any of the two properties is defined. */
> > > +	if (!ret_data || !ret_clock) {
> > > +		lvds_vod_swing_conf = sn65dsi83_select_lvds_vod_swing(dev,
> > > +			lvds_vod_swing_data, lvds_vod_swing_clk,
> > > +			lvds_term_conf);
> > > +		if (lvds_vod_swing_conf < 0) {
> > > +			ret = lvds_vod_swing_conf;
> > > +			goto exit;
> > > +		}
> > > +	}
> > > +
> > > +	ctx->lvds_vod_swing_conf[channel] = lvds_vod_swing_conf;
> > > +	ret = 0;
> > > +exit:
> > > +	of_node_put(endpoint);
> > > +	return ret;
> > > +}
> > > +
> > >   static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
> > >   {
> > >   	struct drm_bridge *panel_bridge;
> > >   	struct device *dev = ctx->dev;
> > > +	int ret;
> > > +
> > > +	ret = sn65dsi83_parse_lvds_endpoint(ctx, CHANNEL_A);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret = sn65dsi83_parse_lvds_endpoint(ctx, CHANNEL_B);
> > > +	if (ret < 0)
> > > +		return ret;
> > >   	ctx->lvds_dual_link = false;
> > >   	ctx->lvds_dual_link_even_odd_swap = false;
> > > -- 
> > > 2.34.1
> > > 
> > 

-- 
With best wishes
Dmitry

