Return-Path: <linux-kernel+bounces-264289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A304693E14D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 00:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9C51C20E38
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8321A12EBE6;
	Sat, 27 Jul 2024 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tzzoE4jm"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE239AE3
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722118427; cv=none; b=qFO6inprhQWeszp31iK1Pm/4/c/mNHY6nrEbODZvLG1w82S2GJEFJ7QgMJbSwPaiiU/EFs5aiNGSDWhsrwTZuHjzr/zkD5csB6OlSZyp96Og4KOitfEuyYNWA9d8LXyAOd6jtAyrCQpPz3ZQIbQJUg0Fh+wTKthgsF7wcA9tKIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722118427; c=relaxed/simple;
	bh=xTufxf82ZcI8yph5qtryfWMk73NHkLewGz4Mh0eSR9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYLGbKtKupff+Zpb1SWe1MRgYzxKKUkj4tzE4CUtqgkMPWi/7BShavU7jUe0btU4TuQidP/uLu3n6PU8/6VBm4szdEW4309DgmjuEg1fcVZ1nDgW+ZPXWWWumT7PUYM8yp4RviJjNqcqQ9YX9+clSCAFfj19b9MaBiEm9aii1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tzzoE4jm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2c109eabso29997411fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722118423; x=1722723223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QXKci/NSkTkc7j5F8GcMlz5bnFyJnE5pZB5gvn3Nv7g=;
        b=tzzoE4jmPJLi1vxu8fv6vtDeoEsqvjZyvNN5hDsOy47dZoidS/t+cYaeGQ/ZJHA+JQ
         zJwXSxDoOYgQJMxl+k9WCW+8v7yaWsbAqoRbULNmlmfZSs60R3GoJxfQrNUnsFhLqk95
         xVVMhuBGaVSvcl3gNqHaYuYvscIe0bbPIJ67WNlpvkCA1Bq37SdwEESEoATqQZmIa1cH
         Dttzxtlj36skQRZdse+m7smHPaoFY/SLQ5PVy1M0VhWbJ4/ZCDlOPjUwLZhuyleelnDb
         GTu4Qc/E4q0S1MLhgpvdI3qJOPG3B8DzxFF98oV8a4jaKBn3HUqgyFXMnTTrrWX2iMzf
         4EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722118423; x=1722723223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXKci/NSkTkc7j5F8GcMlz5bnFyJnE5pZB5gvn3Nv7g=;
        b=FPORXe9nhw9dNDxL43YwcHXIQAwfz1XSu8Y6CCOTWC/YCK6QulH74BEuQ/ppRvp/1d
         aAn0/VU46+b8E5982cHah4nyEYNLqdBEop7kIdXqykSUqya0rOO5gsrUgnKTmkiTi/BY
         Aftgjga8eRFNjekd3+JZ1ASpkCrWTCxIMYDPPtNBF8chi3V63X6vvywLQWaNaptTIWIu
         JqtMGM+u+P+3PYgDfkeCmo5jhOFGHC+oDpLrYDFlbWBdLFC9FCWv3GnjXg+0y5aYMumx
         LabK2bTWB/WOLM2tHUutHB1AdHHwj1rUCizDJrQ96PrWXR3aF68rKL27T67ap/i5Dava
         KEHw==
X-Forwarded-Encrypted: i=1; AJvYcCX3qNNW7+NQYtMuLgUDUAPjqVfAYA9uHIjcFyNDLy5b+/SR1Bl45d+kiScZFwa3DtM2qPwMW7brOm8vYOYqAaJOSlVcnD3ZwzyN4NNB
X-Gm-Message-State: AOJu0YwTlPhKp0MqgxYKAh39UbL4tYPFtNOx9YeDn3Bp3nMC9sUKhaQ6
	ILc+Sj6Ksv3GsiIi8XLhUcx0LiVDSm/uNmhIBsR4OhLYCLFOlfZvId0a0Np9j48=
X-Google-Smtp-Source: AGHT+IHkNunJs80mXYRHwnrzwHYeTT7dYtIIdvFSJvbxhJtb1sB6ciAg8z3hcjNebhQgLpPjAhVO2Q==
X-Received: by 2002:a2e:9608:0:b0:2ef:2f17:9edd with SMTP id 38308e7fff4ca-2f12ee2f188mr21770451fa.44.1722118422335;
        Sat, 27 Jul 2024 15:13:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf0dc4bsm7945261fa.18.2024.07.27.15.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 15:13:41 -0700 (PDT)
Date: Sun, 28 Jul 2024 01:13:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Stephan Gerhold <stephan@gerhold.net>, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: Re: [PATCH v2 2/4] ASoC: msm8916-wcd-analog: add cajon and cajon v2
 support
Message-ID: <g2aj4z3t54esit6u63i2pwovyujqg45orhpcnp5zad6l3dhvyr@5qgpcbcghg77>
References: <20240727182031.35069-1-a39.skl@gmail.com>
 <20240727182031.35069-3-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727182031.35069-3-a39.skl@gmail.com>

On Sat, Jul 27, 2024 at 08:20:25PM GMT, Adam Skladowski wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Add regs overrides for Cajon(PM8952) and Cajon v2(PM8953) codecs.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> [Adam: Add Cajon support,add msg]
> Co-developed-by: Adam Skladowski <a39.skl@gmail.com>
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  sound/soc/codecs/msm8916-wcd-analog.c | 63 +++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> index 9ca381812975..daf65f5d4e99 100644
> --- a/sound/soc/codecs/msm8916-wcd-analog.c
> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> @@ -250,6 +250,7 @@
>  		SPKR_DRV_CAL_EN | SPKR_DRV_SETTLE_EN | \
>  		SPKR_DRV_FW_EN | SPKR_DRV_BOOST_SET | \
>  		SPKR_DRV_CMFB_SET | SPKR_DRV_GAIN_SET)
> +#define CDC_A_SPKR_ANA_BIAS_SET		(0xf1B3)
>  #define CDC_A_SPKR_OCP_CTL		(0xf1B4)
>  #define CDC_A_SPKR_PWRSTG_CTL		(0xf1B5)
>  #define SPKR_PWRSTG_CTL_DAC_EN_MASK	BIT(0)
> @@ -264,12 +265,15 @@
>  
>  #define CDC_A_SPKR_DRV_DBG		(0xf1B7)
>  #define CDC_A_CURRENT_LIMIT		(0xf1C0)
> +#define CDC_A_BYPASS_MODE		(0xf1C2)
>  #define CDC_A_BOOST_EN_CTL		(0xf1C3)
>  #define CDC_A_SLOPE_COMP_IP_ZERO	(0xf1C4)
>  #define CDC_A_SEC_ACCESS		(0xf1D0)
>  #define CDC_A_PERPH_RESET_CTL3		(0xf1DA)
>  #define CDC_A_PERPH_RESET_CTL4		(0xf1DB)
>  
> +#define CDC_A_RX_EAR_STATUS		(0xf1A1)

This one should go before CDC_A_SPKR_DAC_CTL

> +
>  #define MSM8916_WCD_ANALOG_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
>  			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000)
>  #define MSM8916_WCD_ANALOG_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
> @@ -715,6 +719,50 @@ static const struct reg_default wcd_reg_defaults_2_0[] = {
>  	{CDC_A_MASTER_BIAS_CTL, 0x30},
>  };
>  
> +static const struct reg_default wcd_reg_defaults_cajon[] = {
> +	{CDC_A_RX_COM_OCP_CTL, 0xD1},
> +	{CDC_A_RX_COM_OCP_COUNT, 0xFF},
> +	{CDC_D_SEC_ACCESS, 0xA5},
> +	{CDC_D_PERPH_RESET_CTL3, 0x0F},
> +	{CDC_A_TX_1_2_OPAMP_BIAS, 0x4C},
> +	{CDC_A_NCP_FBCTRL, 0xA8},
> +	{CDC_A_NCP_VCTRL, 0xA4},
> +	{CDC_A_SPKR_DRV_CTL, 0x69},
> +	{CDC_A_SPKR_DRV_DBG, 0x01},
> +	{CDC_A_SEC_ACCESS, 0xA5},
> +	{CDC_A_PERPH_RESET_CTL3, 0x0F},
> +	{CDC_A_CURRENT_LIMIT, 0x82},
> +	{CDC_A_SPKR_ANA_BIAS_SET, 0x41},
> +	{CDC_A_SPKR_DAC_CTL, 0x03},
> +	{CDC_A_SPKR_OCP_CTL, 0xE1},
> +	{CDC_A_RX_HPH_BIAS_PA, 0xFA},
> +	{CDC_A_MASTER_BIAS_CTL, 0x30},
> +	{CDC_A_MICB_1_INT_RBIAS, 0x00},
> +};
> +
> +static const struct reg_default wcd_reg_defaults_cajon_2_0[] = {
> +	{CDC_A_RX_COM_OCP_CTL, 0xD1},
> +	{CDC_A_RX_COM_OCP_COUNT, 0xFF},
> +	{CDC_D_SEC_ACCESS, 0xA5},
> +	{CDC_D_PERPH_RESET_CTL3, 0x0F},
> +	{CDC_A_TX_1_2_OPAMP_BIAS, 0x4C},
> +	{CDC_A_NCP_FBCTRL, 0xA8},
> +	{CDC_A_NCP_VCTRL, 0xA4},
> +	{CDC_A_SPKR_DRV_CTL, 0x69},
> +	{CDC_A_SPKR_DRV_DBG, 0x01},
> +	{CDC_A_SEC_ACCESS, 0xA5},
> +	{CDC_A_PERPH_RESET_CTL3, 0x0F},
> +	{CDC_A_CURRENT_LIMIT, 0xA2},
> +	{CDC_A_BYPASS_MODE, 0x18},
> +	{CDC_A_SPKR_ANA_BIAS_SET, 0x41},
> +	{CDC_A_SPKR_DAC_CTL, 0x03},
> +	{CDC_A_SPKR_OCP_CTL, 0xE1},
> +	{CDC_A_RX_HPH_BIAS_PA, 0xFA},
> +	{CDC_A_RX_EAR_STATUS, 0x10},
> +	{CDC_A_MASTER_BIAS_CTL, 0x30},
> +	{CDC_A_MICB_1_INT_RBIAS, 0x00},
> +};
> +
>  static int pm8916_wcd_analog_probe(struct snd_soc_component *component)
>  {
>  	struct pm8916_wcd_analog_priv *priv = dev_get_drvdata(component->dev);
> @@ -738,9 +786,18 @@ static int pm8916_wcd_analog_probe(struct snd_soc_component *component)
>  	snd_soc_component_write(component, CDC_D_PERPH_RESET_CTL4, 0x01);
>  	snd_soc_component_write(component, CDC_A_PERPH_RESET_CTL4, 0x01);
>  
> -	for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults_2_0); reg++)
> -		snd_soc_component_write(component, wcd_reg_defaults_2_0[reg].reg,
> -			      wcd_reg_defaults_2_0[reg].def);
> +	if (priv->codec_version == 4)
> +		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults_cajon_2_0); reg++)
> +			snd_soc_component_write(component, wcd_reg_defaults_cajon_2_0[reg].reg,
> +					wcd_reg_defaults_cajon_2_0[reg].def);
> +	else if (priv->codec_version == 3)
> +		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults_cajon); reg++)
> +			snd_soc_component_write(component, wcd_reg_defaults_cajon[reg].reg,
> +					wcd_reg_defaults_cajon[reg].def);
> +	else
> +		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults_2_0); reg++)
> +			snd_soc_component_write(component, wcd_reg_defaults_2_0[reg].reg,
> +					wcd_reg_defaults_2_0[reg].def);

I have mixed feelings towards this. Would it be better to use
PMIC-specific compatibles and pass register init as match data instead?

>  
>  	priv->component = component;
>  
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

