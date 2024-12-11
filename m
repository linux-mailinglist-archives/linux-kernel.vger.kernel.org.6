Return-Path: <linux-kernel+bounces-442318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D4D9EDAD1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DCA1687B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFB61F2389;
	Wed, 11 Dec 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+FZIPPj"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2111EC4FF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958253; cv=none; b=ZYwQIzyKT5IO8jktAgKxbnhNGASE+29pYRKllpRb84oHWTt5nuq7VKT26CiMny+z9baaco7MqzgHxQftf0WcseBceDaZjPtQKt3LC0tL7A8vKqWfIvkkOlSSWuvJSY8fd1uSCBpFcoW/7KPxLgipEnJs9YbOnyYftZkGUG23C0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958253; c=relaxed/simple;
	bh=lHZ50fRN68M/L9LdirMs0A7G8lwQh+oMMom8ZL+Lh9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzxgZ1TbTwWrAgGFw8VFE6CtWr0ggYWJGvOLrzwAZH4eTQpEzkmjXSmq7AO2D9WXzMB4walouGrG79ca9FQTLoH1f1kN3cuMjRC691UpEkYqaLXBAM+7k1yALuLu1nLoU8Z5+qHn/ONcXPpIgaqgM9oousWwgRZBwDhckaRLvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+FZIPPj; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5401ab97206so3802718e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733958249; x=1734563049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMqUgu29dr/kC2j1L26UmKv/roqpPimVfYqNx+1TUQA=;
        b=G+FZIPPj47NsG4hFpaoQbHYEpMS4e1MQDwYLlCXf/rlIp4BcBe3naUG7pgIwyIx26g
         KqkaTslg4HC8hJwx2iPB1PeXEvWEGN7v5r5V1J+cb2fc5QWnXCXYDUeiWE3Y7odVOWeP
         +Auh+A+L1K19dNOlQrzs6i7jfbhh1Kw+hwomrr9OyWRqFLDslMf7t6wSgACzF8mhQH4P
         8/lit4oCvVuL8YnpkEH9BDTcl7H0/DITS6OzXusNnzRkY93aN0np4lmOda5AvSSHQ+P1
         +F2fKTr972h2IhC5aQt/sW6j3tUMCHCz8rvwGvOdznNtqWKVGozKm13SFQXv6cpH8IbI
         dVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958249; x=1734563049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMqUgu29dr/kC2j1L26UmKv/roqpPimVfYqNx+1TUQA=;
        b=kCBRpEBz1g721Tczypo/ioYiq1UFvTEL1VtpHDrSnqDWqddle3dsYHK9+TOp2qjUmA
         1dSBHM6okaJKirQI4hEENoNu+d/25b0yMGBR0AEuWGFHX4UAG4oGt59KuVaJyGGOWYVy
         65pn/v+xVeKn7NQHkOXV97hQhLPL26vcaT+f4OZhQfyzUIOshzKzmEX1JgKsLXRw3TYA
         /9UHp2aViFl/1x9f5HgqS8OsQXcRsN/RY29KYO0MUvGt3HkPL2gR0d4AHo6v5v5l6j5s
         gIzsNEuLw+ayAEPstcg/9fRjr7bCjWJw8M4MgTu4IXWVCUMaDGsa0BgYmYYPrm8Kg+s0
         wCdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfXmY2LEIGGJMk64pPf/TJx/27gT5UPRnIL4ffhhzPKsUISNtKjLQYmQ94Mhr6cfj6SCqtFQh2Bd91U3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy174fIY0uYj0I/yT0684m05SBcy19Un4tx0H3DKNPOyGfVnrtj
	ExOv54rnajqbYEYSYyOiAVSkcjjLGRQCezMKWHPKzfxinjxOx53wFZsEDBzRFGQ=
X-Gm-Gg: ASbGncswRyUKemwbnMIxGUrHeit3r8Bt552Bhe0jU08IsHGWKKHJD2nG3HZ4Uo8N/pe
	g1uKEDrCG96GUaNkkK+pTIX20YOo/5Yc48uK198GL2bmQaOpSgtGFO+7JjB8NJNoE8tCrxJZ+sR
	2JduJlb8xn68IhJLGZsyoN5Qi5nyLy+sZ6hSEmfSD0s0HwJ1Ok3E/rAxjx8oZLaZll4myhv31r+
	bHf42r9yT9K7v0Q8gq1lzLeQFkb/i3MrlGbKdUeP+CenTpUIAI6gm2VUuOukSXYjmkmEoQDC4yQ
	mQq32FQxf9Xc4DozOvG8z1IR+PqUlVPnvw==
X-Google-Smtp-Source: AGHT+IEhqGDw0cNCr+jN+DdXJHOmo3kKoG/lFAosZWpVVqXUd4oFiJE89F6qLxbtZeNdIPawBJHAgw==
X-Received: by 2002:a05:6512:3c99:b0:53f:8c46:42bd with SMTP id 2adb3069b0e04-5402a5e0a12mr1498950e87.15.1733958249174;
        Wed, 11 Dec 2024 15:04:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401fb5f496sm1102790e87.237.2024.12.11.15.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:04:07 -0800 (PST)
Date: Thu, 12 Dec 2024 01:04:05 +0200
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
Message-ID: <rputm4gnjj6nb66ix7dqbxr2janltia6rlb6zunhf7x3mgooxw@o3lblnyp5cci>
References: <20241210091901.83028-1-andrej.picej@norik.com>
 <20241210091901.83028-3-andrej.picej@norik.com>
 <irpmhq7vxjra6vhmdh7p63ajj57n3h2c4br3ija2jmwtoewist@zyxfmx6k5m4e>
 <aa2de99d-21f4-4843-83b7-5d2db78be86f@norik.com>
 <qhmsobin3fsmoc7ic2jtancowfscoauyroruxdpwhmqwlogtkz@6by3s2ruwzwp>
 <519cc025-0782-4f96-a169-1fe87b280173@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519cc025-0782-4f96-a169-1fe87b280173@norik.com>

On Wed, Dec 11, 2024 at 08:57:17AM +0100, Andrej Picej wrote:
> 
> 
> On 10. 12. 24 14:59, Dmitry Baryshkov wrote:
> > On Tue, Dec 10, 2024 at 02:41:01PM +0100, Andrej Picej wrote:
> > > 
> > > 
> > > On 10. 12. 24 12:43, Dmitry Baryshkov wrote:
> > > > On Tue, Dec 10, 2024 at 10:19:00AM +0100, Andrej Picej wrote:
> > > > > Add a optional properties to change LVDS output voltage. This should not
> > > > > be static as this depends mainly on the connected display voltage
> > > > > requirement. We have three properties:
> > > > > - "ti,lvds-termination-ohms", which sets near end termination,
> > > > > - "ti,lvds-vod-swing-data-microvolt" and
> > > > > - "ti,lvds-vod-swing-clock-microvolt" which both set LVDS differential
> > > > > output voltage for data and clock lanes. They are defined as an array
> > > > > with min and max values. The appropriate bitfield will be set if
> > > > > selected constraints can be met.
> > > > > 
> > > > > If "ti,lvds-termination-ohms" is not defined the default of 200 Ohm near
> > > > > end termination will be used. Selecting only one:
> > > > > "ti,lvds-vod-swing-data-microvolt" or
> > > > > "ti,lvds-vod-swing-clock-microvolt" can be done, but the output voltage
> > > > > constraint for only data/clock lanes will be met. Setting both is
> > > > > recommended.
> > > > > 
> > > > > Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> > > > > ---
> > > > > Changes in v5:
> > > > > - specify default values in sn65dsi83_parse_lvds_endpoint,
> > > > > - move sn65dsi83_parse_lvds_endpoint for channel B up, outside if,
> > > > > Changes in v4:
> > > > > - fix typo in commit message bitfiled -> bitfield
> > > > > - use arrays (lvds_vod_swing_conf and lvds_term_conf) in private data, instead
> > > > > of separate variables for channel A/B
> > > > > - add more checks on return value of "of_property_read_u32_array"
> > > > > Changes in v3:
> > > > > - use microvolts for default array values 1000 mV -> 1000000 uV.
> > > > > Changes in v2:
> > > > > - use datasheet tables to get the proper configuration
> > > > > - since major change was done change the authorship to myself
> > > > > ---
> > > > >    drivers/gpu/drm/bridge/ti-sn65dsi83.c | 142 +++++++++++++++++++++++++-
> > > > >    1 file changed, 139 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > > > index 57a7ed13f996..f9578b38da28 100644
> > > > > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > > > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > > > > @@ -132,6 +132,16 @@
> > > > >    #define  REG_IRQ_STAT_CHA_SOT_BIT_ERR		BIT(2)
> > > > >    #define  REG_IRQ_STAT_CHA_PLL_UNLOCK		BIT(0)
> > > > > +enum sn65dsi83_channel {
> > > > > +	CHANNEL_A,
> > > > > +	CHANNEL_B
> > > > > +};
> > > > > +
> > > > > +enum sn65dsi83_lvds_term {
> > > > > +	OHM_100,
> > > > > +	OHM_200
> > > > > +};
> > > > > +
> > > > >    enum sn65dsi83_model {
> > > > >    	MODEL_SN65DSI83,
> > > > >    	MODEL_SN65DSI84,
> > > > > @@ -147,6 +157,8 @@ struct sn65dsi83 {
> > > > >    	struct regulator		*vcc;
> > > > >    	bool				lvds_dual_link;
> > > > >    	bool				lvds_dual_link_even_odd_swap;
> > > > > +	int				lvds_vod_swing_conf[2];
> > > > > +	int				lvds_term_conf[2];
> > > > >    };
> > > > >    static const struct regmap_range sn65dsi83_readable_ranges[] = {
> > > > > @@ -237,6 +249,36 @@ static const struct regmap_config sn65dsi83_regmap_config = {
> > > > >    	.max_register = REG_IRQ_STAT,
> > > > >    };
> > > > > +static const int lvds_vod_swing_data_table[2][4][2] = {
> > > > > +	{	/* 100 Ohm */
> > > > > +		{ 180000, 313000 },
> > > > > +		{ 215000, 372000 },
> > > > > +		{ 250000, 430000 },
> > > > > +		{ 290000, 488000 },
> > > > > +	},
> > > > > +	{	/* 200 Ohm */
> > > > > +		{ 150000, 261000 },
> > > > > +		{ 200000, 346000 },
> > > > > +		{ 250000, 428000 },
> > > > > +		{ 300000, 511000 },
> > > > > +	},
> > > > > +};
> > > > > +
> > > > > +static const int lvds_vod_swing_clock_table[2][4][2] = {
> > > > > +	{	/* 100 Ohm */
> > > > > +		{ 140000, 244000 },
> > > > > +		{ 168000, 290000 },
> > > > > +		{ 195000, 335000 },
> > > > > +		{ 226000, 381000 },
> > > > > +	},
> > > > > +	{	/* 200 Ohm */
> > > > > +		{ 117000, 204000 },
> > > > > +		{ 156000, 270000 },
> > > > > +		{ 195000, 334000 },
> > > > > +		{ 234000, 399000 },
> > > > > +	},
> > > > > +};
> > > > > +
> > > > >    static struct sn65dsi83 *bridge_to_sn65dsi83(struct drm_bridge *bridge)
> > > > >    {
> > > > >    	return container_of(bridge, struct sn65dsi83, bridge);
> > > > > @@ -435,12 +477,16 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
> > > > >    		val |= REG_LVDS_FMT_LVDS_LINK_CFG;
> > > > >    	regmap_write(ctx->regmap, REG_LVDS_FMT, val);
> > > > > -	regmap_write(ctx->regmap, REG_LVDS_VCOM, 0x05);
> > > > > +	regmap_write(ctx->regmap, REG_LVDS_VCOM,
> > > > > +			REG_LVDS_VCOM_CHA_LVDS_VOD_SWING(ctx->lvds_vod_swing_conf[CHANNEL_A]) |
> > > > > +			REG_LVDS_VCOM_CHB_LVDS_VOD_SWING(ctx->lvds_vod_swing_conf[CHANNEL_B]));
> > > > >    	regmap_write(ctx->regmap, REG_LVDS_LANE,
> > > > >    		     (ctx->lvds_dual_link_even_odd_swap ?
> > > > >    		      REG_LVDS_LANE_EVEN_ODD_SWAP : 0) |
> > > > > -		     REG_LVDS_LANE_CHA_LVDS_TERM |
> > > > > -		     REG_LVDS_LANE_CHB_LVDS_TERM);
> > > > > +		     (ctx->lvds_term_conf[CHANNEL_A] ?
> > > > > +			  REG_LVDS_LANE_CHA_LVDS_TERM : 0) |
> > > > > +		     (ctx->lvds_term_conf[CHANNEL_B] ?
> > > > > +			  REG_LVDS_LANE_CHB_LVDS_TERM : 0));
> > > > >    	regmap_write(ctx->regmap, REG_LVDS_CM, 0x00);
> > > > >    	le16val = cpu_to_le16(mode->hdisplay);
> > > > > @@ -576,10 +622,100 @@ static const struct drm_bridge_funcs sn65dsi83_funcs = {
> > > > >    	.atomic_get_input_bus_fmts = sn65dsi83_atomic_get_input_bus_fmts,
> > > > >    };
> > > > > +static int sn65dsi83_select_lvds_vod_swing(struct device *dev,
> > > > > +	u32 lvds_vod_swing_data[2], u32 lvds_vod_swing_clk[2], u8 lvds_term)
> > > > > +{
> > > > > +	int i;
> > > > > +
> > > > > +	for (i = 0; i <= 3; i++) {
> > > > > +		if (lvds_vod_swing_data_table[lvds_term][i][0] >= lvds_vod_swing_data[0] &&
> > > > > +		lvds_vod_swing_data_table[lvds_term][i][1] <= lvds_vod_swing_data[1] &&
> > > > > +		lvds_vod_swing_clock_table[lvds_term][i][0] >= lvds_vod_swing_clk[0] &&
> > > > > +		lvds_vod_swing_clock_table[lvds_term][i][1] <= lvds_vod_swing_clk[1])
> > > > > +			return i;
> > > > > +	}
> > > > > +
> > > > > +	dev_err(dev, "failed to find appropriate LVDS_VOD_SWING configuration\n");
> > > > > +	return -EINVAL;
> > > > > +}
> > > > > +
> > > > > +static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
> > > > > +{
> > > > > +	struct device *dev = ctx->dev;
> > > > > +	struct device_node *endpoint;
> > > > > +	int endpoint_reg;
> > > > > +	/* Set so the property can be freely selected if not defined */
> > > > > +	u32 lvds_vod_swing_data[2] = { 0, 1000000 };
> > > > > +	u32 lvds_vod_swing_clk[2] = { 0, 1000000 };
> > > > > +	u32 lvds_term;
> > > > > +	u8 lvds_term_conf = 0x1;
> > > > > +	int lvds_vod_swing_conf = 0x1;
> > > > 
> > > > Magic values
> > > 
> > > Can you please elaborate.
> > > 
> > > I can use:
> > > u8 lvds_term_conf = OHM_200;
> > > 
> > > What about lvds_vod_swing_conf? Should I create additional define for it?
> > > But this doesn't solve a hidden meaning? Maybe additional comment above?
> > > Would like to avoid using voltages for it, since then we are reverse
> > > engineering the table in datasheet to match the default reg value.
> > 
> > I think the following example solves both problems:
> > 
> > lvds_term = 200;
> > of_property_read_u32(..., &lvds_term);
> > 
> > if (lvds_term == 100)
> > 	ctx->lvds_term_conf[channel] = OHM_100;
> > else if (lvds_term == 200)
> > 	ctx->lvds_term_conf[channel] = OHM_200;
> > else
> > 	return -EINVAL;
> > 
> > The same approach can be applied to lvds_vod_swing_conf, resulting in
> > removal of magic values.
> 
> Sorry, but I think it is not that easy when it comes to the
> lvds_vod_swing_conf. We should assign default value if
> "ti,lvds-vod-swing-data-microvolt" and "ti,lvds-vod-swing-clock-microvolt"
> are not defined. Default value of the lvds_vod_swing_conf is 0x1, but this
> doesn't have any straight forward meaning like OHM_200 for example.
> 
> What we can do in that case is that we copy the values from defined
> datasheet tables to the "lvds_vod_swing_data[2]" and "lvds_vod_swing_clk[2]"
> arrays and then run the
> sn65dsi83_select_lvds_vod_swing with it, which will return the default value
> (0x1).
> 
> /* If both properties are not defined assign default limits */
> if (ret_data && ret_clock) {
> 	memcpy(lvds_vod_swing_data,
> 	     lvds_vod_swing_data_table[ctx->lvds_term_conf[channel]][1],
> 	     sizeof(lvds_vod_swing_data));
> 	memcpy(lvds_vod_swing_clk,
> 	    lvds_vod_swing_clock_table[ctx->lvds_term_conf[channel]][1],
> 	    sizeof(lvds_vod_swing_clk));
> }
> lvds_vod_swing_conf = sn65dsi83_select_lvds_vod_swing(dev,
> 	lvds_vod_swing_data, lvds_vod_swing_clk,
> 	ctx->lvds_term_conf[channel]);
> if (lvds_vod_swing_conf < 0) {
> 	ret = lvds_vod_swing_conf;
> 	goto exit;
> }
> 
> ctx->lvds_vod_swing_conf[channel] = lvds_vod_swing_conf;
> 
> I'm not sure if using this approach gets rid of the problem with magic
> values.
> Or maybe I'm not seeing the obvious solution so please bear with me.

Yes, the defaults (0..1000000) should be fixed to result in the same
value (0x01) as if the property wasn't specified at all.

I think the following should work:

	/* artifical values to select the defaults in both cases */
	u32 lvds_vod_swing_data[2] = { 190000, 330000 };
	u32 lvds_vod_swing_clk[2] = { 150000, 250000 };

Yes, they are artificial, as stated in the comment. Yes, I think it's
better than special-casing in the property handling.

-- 
With best wishes
Dmitry

