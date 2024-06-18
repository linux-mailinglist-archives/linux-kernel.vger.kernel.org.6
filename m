Return-Path: <linux-kernel+bounces-218901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473F690C786
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8959B20CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792E154BEF;
	Tue, 18 Jun 2024 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kuYlMxTS"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F215381F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701188; cv=none; b=X/JuifPCrdnMPBJS79yXCwSNG/5DEzaVP//LEXIxdi3PYi/2cK27smn+lFhaqmEYqNMiYjiuIakMZzMI1qefsbf+cx3Y3kLtULpkHlzu+e9I6CfK2sfLAEQLIuTBUlKgE7ng9CznTiV7uT1d2SeFlsyVez4Pxv+6f0lYB9V5B28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701188; c=relaxed/simple;
	bh=+HMoiIlhz52gdOxy3/nChbAlKTEWWQB0RSZG/jMWpgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cON6zcJSkYY7V8tP6jqY42QEF8nwvfl/9cuU3S/T62XbRTV4azYnSBtLpZ5wC/LsGLYidbLh1C9o82b1RtEp2nWwvp3hjJCK/KwLJaZPW9vDL43RUQdj7l5xqYO+gnkZc6CiCF/tqwsVwgwZueO6uvRN5lAVGltBkJ5ohOu/IQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kuYlMxTS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso56075581fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718701185; x=1719305985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv3e4JRhjiyKiq+/BCg7UVEko8aCXARCf3y5M1sULhc=;
        b=kuYlMxTS/ekaAvBKZX16yYDQ3WM8RMeRLUcQBGytkOdPB1qjXRwFGn4bh2n1PqAflc
         Mnu7DMbSxe/TWU8C3RprJCqaVOpSfNu4i/Ip6KoRv/QyDUj7snTCPZg+WjIVajTkW2L3
         IXWZVUW3/XXD5qv7dBNsBosd7d5MgHjZb35AhRPGR8liWF6U1WwDvXZ5NH9wNaaagMqf
         zK9fRNtmFsqQWoTYaO3uewDKvLGou+9EvtOSgxWJrDwIDoUF/YVBvA4gGvfieTe1XC/6
         38e9QKUIipnQ3go7JW109s7atDwYhbZYFu/pbzabj7DfrYchu5bLC/d1qEszWMjQ3LeF
         7dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718701185; x=1719305985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fv3e4JRhjiyKiq+/BCg7UVEko8aCXARCf3y5M1sULhc=;
        b=igHoZuS855rV+Euyx6/B/KBh5s6C+xRfK6+aFVBWy7sBlLRXMEYkI3uBmocmeTyU2l
         GYeyrlr53oS7o6tkvWDADipWMsIao94IQv1M7AuNTuZP9D254ZxvJc3xNZcm2S6LtSyq
         pRfGgl+YR+ZVQZQ7SINAfE8AORkkYDeiSg8wHjb6t7M6rHu9gnXDh90qxYElHLPrG659
         AU/R07xXlCYSOKDN/TyzoVv3+Xh/BAzXAhMJQgTDxxU1SG9x3cjzpue7LjNU21BlOsN3
         tBbGiFjpRwu6SVmYlFqlyfdY5sMW3KkUdIJeVg2GeHoPaXHnAnPZreFW8a/P7KvyHTJF
         FG6g==
X-Forwarded-Encrypted: i=1; AJvYcCVTOe/190h03TeqkM0wfqCkByGfjZr2IF3EElt49yOxa9Koxpy5lPYFoIMiQEfgvCn9g3tQfk9bRswhRD/DZ9+f2co8R1/kFDBg+oaU
X-Gm-Message-State: AOJu0Yw5KJ1Cb80VNzjVgDvI9bv0YMfG4oj2WtIEPJg0sXDQn4qNxiJq
	OmtMCrv0ZoFO2TOFzFUM7jF3pk4ZwmfnIYur4mfoUpmwS8KoY+oDWo7t5iWgj3c=
X-Google-Smtp-Source: AGHT+IFBkkdBYmR6cGYeikqpydjZVFKiKCkvsC51A/80Pa0YSrMuQ5aysBlI+NciEeQ7Edaw/2jfaQ==
X-Received: by 2002:a2e:9b54:0:b0:2eb:dc13:2d6b with SMTP id 38308e7fff4ca-2ec0e5c57a5mr73189251fa.13.1718701184574;
        Tue, 18 Jun 2024 01:59:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c8a72bsm16142861fa.115.2024.06.18.01.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:59:44 -0700 (PDT)
Date: Tue, 18 Jun 2024 11:59:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: dianders@chromium.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	mripard@kernel.org, linux-kernel@vger.kernel.org, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, spanda@codeaurora.org, a-bhatia1@ti.com, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/2] drm/bridge: ti-sn65dsi86: Add atomic_check hook
 for the bridge
Message-ID: <r5szraxdqfs4v4hnvqgx6tbmc5e5ew5ljyf5xlaobywm55bohy@6kygxenn2tvd>
References: <20240618081418.250953-1-j-choudhary@ti.com>
 <20240618081418.250953-2-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618081418.250953-2-j-choudhary@ti.com>

On Tue, Jun 18, 2024 at 01:44:17PM GMT, Jayesh Choudhary wrote:
> Add the atomic_check hook to ensure that the parameters are within the
> valid range.
> As of now, dsi clock freqency is being calculated in bridge_enable but
> this needs to be checked in atomic_check which is called before
> bridge_enable so move this calculation to atomic_check and write the
> register value in bridge_enable as it is.
> 
> For now, add mode clock check for the max resolution supported by the
> bridge as mentioned in the SN65DSI86 datasheet[0] and dsi clock range
> check for SN_DSIA_CLK_FREQ_REG.
> According to the datasheet[0], the minimum value for that reg is 0x08
> and the maximum value is 0x96. So add check for that.
> 
> [0]: <https://www.ti.com/lit/gpn/sn65dsi86>
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 65 +++++++++++++++++++--------
>  1 file changed, 46 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 84698a0b27a8..d13b42d7c512 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -113,6 +113,20 @@
>  
>  #define MIN_DSI_CLK_FREQ_MHZ	40
>  
> +/*
> + * NOTE: DSI clock frequency range: [40MHz,755MHz)
> + * DSI clock frequency range is in 5-MHz increments
> + * So [40MHz,45MHz) translates to 0x08 (min value)
> + * And [750MHz,755MHz) translates to 0x96 (max value)
> + */
> +#define MIN_DSI_CLK_RANGE	0x8
> +#define MAX_DSI_CLK_RANGE	0x96
> +
> +/* Pixel clock to support max resolution (4K@60Hz) supported
> + * by the bridge.
> + */
> +#define SN65DSI86_MAX_PIXEL_CLOCK_KHZ 600000
> +
>  /* fudge factor required to account for 8b/10b encoding */
>  #define DP_CLK_FUDGE_NUM	10
>  #define DP_CLK_FUDGE_DEN	8
> @@ -191,6 +205,7 @@ struct ti_sn65dsi86 {
>  	u8				ln_polrs;
>  	bool				comms_enabled;
>  	struct mutex			comms_mutex;
> +	u32				dsi_clk_range;
>  
>  #if defined(CONFIG_OF_GPIO)
>  	struct gpio_chip		gchip;
> @@ -820,24 +835,6 @@ static void ti_sn_bridge_atomic_disable(struct drm_bridge *bridge,
>  	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABLE, 0);
>  }
>  
> -static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
> -{
> -	unsigned int bit_rate_mhz, clk_freq_mhz;
> -	unsigned int val;
> -	struct drm_display_mode *mode =
> -		&pdata->bridge.encoder->crtc->state->adjusted_mode;
> -
> -	/* set DSIA clk frequency */
> -	bit_rate_mhz = (mode->clock / 1000) *
> -			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
> -	clk_freq_mhz = bit_rate_mhz / (pdata->dsi->lanes * 2);
> -
> -	/* for each increment in val, frequency increases by 5MHz */
> -	val = (MIN_DSI_CLK_FREQ_MHZ / 5) +
> -		(((clk_freq_mhz - MIN_DSI_CLK_FREQ_MHZ) / 5) & 0xFF);
> -	regmap_write(pdata->regmap, SN_DSIA_CLK_FREQ_REG, val);
> -}
> -
>  static unsigned int ti_sn_bridge_get_bpp(struct drm_connector *connector)
>  {
>  	if (connector->display_info.bpc <= 6)
> @@ -1104,7 +1101,7 @@ static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
>  			   pdata->ln_polrs << LN_POLRS_OFFSET);
>  
>  	/* set dsi clk frequency value */
> -	ti_sn_bridge_set_dsi_rate(pdata);
> +	regmap_write(pdata->regmap, SN_DSIA_CLK_FREQ_REG, pdata->dsi_clk_range);
>  
>  	/*
>  	 * The SN65DSI86 only supports ASSR Display Authentication method and
> @@ -1215,6 +1212,35 @@ static const struct drm_edid *ti_sn_bridge_edid_read(struct drm_bridge *bridge,
>  	return drm_edid_read_ddc(connector, &pdata->aux.ddc);
>  }
>  
> +static int ti_sn_bridge_atomic_check(struct drm_bridge *bridge,
> +				     struct drm_bridge_state *bridge_state,
> +				     struct drm_crtc_state *crtc_state,
> +				     struct drm_connector_state *conn_state)
> +{
> +	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
> +	struct drm_display_mode *mode = &crtc_state->mode;
> +	unsigned int bit_rate_mhz, clk_freq_mhz;
> +
> +	/* Pixel clock check */
> +	if (mode->clock > SN65DSI86_MAX_PIXEL_CLOCK_KHZ)
> +		return -EINVAL;
> +
> +	bit_rate_mhz = (mode->clock / 1000) *
> +			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
> +	clk_freq_mhz = bit_rate_mhz / (pdata->dsi->lanes * 2);
> +
> +	/* for each increment in dsi_clk_range, frequency increases by 5MHz */
> +	pdata->dsi_clk_range = (MIN_DSI_CLK_FREQ_MHZ / 5) +
> +		(((clk_freq_mhz - MIN_DSI_CLK_FREQ_MHZ) / 5) & 0xFF);

atomic_check might be called several times, it might be called to test
the state. As such, it should not modify anything outside of the
state variables.

> +
> +	/* SN_DSIA_CLK_FREQ_REG check */
> +	if (pdata->dsi_clk_range > MAX_DSI_CLK_RANGE ||
> +	    pdata->dsi_clk_range < MIN_DSI_CLK_RANGE)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static const struct drm_bridge_funcs ti_sn_bridge_funcs = {
>  	.attach = ti_sn_bridge_attach,
>  	.detach = ti_sn_bridge_detach,
> @@ -1228,6 +1254,7 @@ static const struct drm_bridge_funcs ti_sn_bridge_funcs = {
>  	.atomic_reset = drm_atomic_helper_bridge_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_check = ti_sn_bridge_atomic_check,
>  };
>  
>  static void ti_sn_bridge_parse_lanes(struct ti_sn65dsi86 *pdata,
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

