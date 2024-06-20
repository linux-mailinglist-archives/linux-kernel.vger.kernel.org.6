Return-Path: <linux-kernel+bounces-223443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5283C91131A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8621C2136F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AFC1BA86C;
	Thu, 20 Jun 2024 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjzbVqr9"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735F1BA071
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915210; cv=none; b=R720mBPkK1gCY/6KaYyolLjpmrx44i0xVwFF4UwloXR/zKTxp43qKzC1jrhSMlxhQY4HvzKVEwzJVqX4RJNrOppFD2S2Db+HRoQ7j1Fgj2haEGzXlvkf97RsxTAbR0BXISxxI7gp6N22oV+G2a2WWmf5ek0Udmk35w7ylVxnfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915210; c=relaxed/simple;
	bh=sFCHX618nzTm6sLAYJPe7BYHyHyu7xj0KoZYjZgfiFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUZOquG3bHTZ6fhCeQ1xPUBuorWTT9Ni1Bgj+Gj+zBYVC6/PbiEgzu7N1B+maNPplbQoOd1iVqATendOfMN+EyBFr2bRCBZFVPXODMmD//FvrnF4JtxzFy9ntktsLt2h0JuRW7f0tOwMTCl/9qrlqoQ7ChRdbuav+h2K+twO1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MjzbVqr9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c7fbad011so1600986e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718915206; x=1719520006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8kmsXX8+t7q4fze1b5xWV2DOaP1fCecJ7UVyeVkxV4=;
        b=MjzbVqr9J1d8ylUDIZvykMfEAXk6/9Omn9iWjzl4XE6Gk5YLSh9/sqpK6OvdZNHGrz
         BdYQ1B12ke295UytS1hagJNaccA6IQjtW50LxXG4iBjxaLZR4eGtKvex8nVHYBrTUEg1
         xhPnh0X8LhZCSg0gQ8Om8981WsNYHgYpmAtXd/KnBWYDlE5xBXf2uYU1OKDn60CoHnHR
         kbZ8hm4orlJjQH6qCIaw7AqG4L4dSedaqL8Nc13vyfX6bZgWYm3pK+FzVlt38nZsxCj1
         9Ey/a7C1/aY4BvQdQiB0F3U2gdYVfhKZp4wyjs6+/FK5bceYmXYhLo5g2nIhxlsbNcOg
         myAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718915206; x=1719520006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8kmsXX8+t7q4fze1b5xWV2DOaP1fCecJ7UVyeVkxV4=;
        b=KfT/at3bvYMd2Lqu6CSz1bq/doKp2bLk9IKMsHxa279K+pfVUbi2FM96z5AM0Nncbf
         Qap7lXg2CoYyyD4jtHq5kjwCw5Ep593FG+iAl9cnXUMUS+2CEfam5VmANMGzZ+oznx8T
         TLftl3ELc1Qr1bAQg/ycZPQr49cti1ywNNvmCA2PIuFI0u7t4XYtnq+40CSY+3EbJw/6
         Rhst3CwnLfWl6W0mt/c+23+b38lDwUvhFQDKAVejimFnpIgSaNeiBuD+hwsLX/2XI114
         SEe4i00Ri0jGij6hKSgS7E93HxZ1/+ojrMPximEObAM7k+5jYMTvRSVGxTN34rVZ+m1k
         n9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVh8U/8QOFqzADAUieD/cc0PjXyf77v4javSaAaWhbAt3n6mFmsdem58Ldaz5ijya2cWiWgy+DDitoEun+omar7rbb2vBUgyDo6243
X-Gm-Message-State: AOJu0YwDTuNbqXB07MyCrFBazFAaK4IZKQGbl/qnTJEwxnvN/ygjpNG6
	vVtx3dHI6lvjsKL67fCUkLv7LML9q3qJiKSe8DROPjVc0MCAuxmD5VrAnBYY6pk=
X-Google-Smtp-Source: AGHT+IHzDL4LA0M5hK+v+OwKwF0rXAEquerAfuzkP8LWy81w8k3FKZLYPQ1yOmy3eJQg3LBJXI1g6g==
X-Received: by 2002:a05:6512:318e:b0:52c:cc40:a732 with SMTP id 2adb3069b0e04-52ccc40a864mr4612649e87.43.1718915205915;
        Thu, 20 Jun 2024 13:26:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282edc1sm2142712e87.115.2024.06.20.13.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:26:45 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:26:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: codecs:lpass-wsa-macro: Fix vi feedback rate
Message-ID: <45iy6ksg25iqfnfezzsutmh7ihgbdy5wukul5bek2rmzm7jbbl@65rk4o6ednor>
References: <20240619-lpass-wsa-vi-v2-0-7aff3f97a490@linaro.org>
 <20240619-lpass-wsa-vi-v2-1-7aff3f97a490@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-lpass-wsa-vi-v2-1-7aff3f97a490@linaro.org>

On Wed, Jun 19, 2024 at 02:42:00PM GMT, Srinivas Kandagatla wrote:
> Currently the VI feedback rate is set to fixed 8K, fix this by getting
> the correct rate from params_rate.

What kind of issues are observed without this patch? What is the actual
issue that is getting fixed?

> 
> Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/lpass-wsa-macro.c | 39 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index 6ce309980cd1..ec9f0b5d6778 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -66,6 +66,10 @@
>  #define CDC_WSA_TX_SPKR_PROT_CLK_DISABLE	0
>  #define CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK	GENMASK(3, 0)
>  #define CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K	0
> +#define CDC_WSA_TX_SPKR_PROT_PCM_RATE_16K	1
> +#define CDC_WSA_TX_SPKR_PROT_PCM_RATE_24K	2
> +#define CDC_WSA_TX_SPKR_PROT_PCM_RATE_32K	3
> +#define CDC_WSA_TX_SPKR_PROT_PCM_RATE_48K	4
>  #define CDC_WSA_TX0_SPKR_PROT_PATH_CFG0		(0x0248)
>  #define CDC_WSA_TX1_SPKR_PROT_PATH_CTL		(0x0264)
>  #define CDC_WSA_TX1_SPKR_PROT_PATH_CFG0		(0x0268)
> @@ -347,6 +351,7 @@ struct wsa_macro {
>  	int ear_spkr_gain;
>  	int spkr_gain_offset;
>  	int spkr_mode;
> +	u32 pcm_rate_vi;
>  	int is_softclip_on[WSA_MACRO_SOFTCLIP_MAX];
>  	int softclip_clk_users[WSA_MACRO_SOFTCLIP_MAX];
>  	struct regmap *regmap;
> @@ -974,6 +979,7 @@ static int wsa_macro_hw_params(struct snd_pcm_substream *substream,
>  			       struct snd_soc_dai *dai)
>  {
>  	struct snd_soc_component *component = dai->component;
> +	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
>  	int ret;
>  
>  	switch (substream->stream) {
> @@ -985,6 +991,11 @@ static int wsa_macro_hw_params(struct snd_pcm_substream *substream,
>  				__func__, params_rate(params));
>  			return ret;
>  		}
> +		break;
> +	case SNDRV_PCM_STREAM_CAPTURE:
> +		if (dai->id == WSA_MACRO_AIF_VI)
> +			wsa->pcm_rate_vi = params_rate(params);
> +
>  		break;
>  	default:
>  		break;
> @@ -1159,6 +1170,28 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
>  	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
>  	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
>  	u32 tx_reg0, tx_reg1;
> +	u32 rate_val;
> +
> +	switch (wsa->pcm_rate_vi) {
> +	case 8000:
> +		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
> +		break;
> +	case 16000:
> +		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_16K;
> +		break;
> +	case 24000:
> +		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_24K;
> +		break;
> +	case 32000:
> +		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_32K;
> +		break;
> +	case 48000:
> +		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_48K;
> +		break;
> +	default:
> +		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
> +		break;
> +	}
>  
>  	if (test_bit(WSA_MACRO_TX0, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
>  		tx_reg0 = CDC_WSA_TX0_SPKR_PROT_PATH_CTL;
> @@ -1170,7 +1203,7 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
>  
>  	switch (event) {
>  	case SND_SOC_DAPM_POST_PMU:
> -			/* Enable V&I sensing */
> +		/* Enable V&I sensing */
>  		snd_soc_component_update_bits(component, tx_reg0,
>  					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
>  					      CDC_WSA_TX_SPKR_PROT_RESET);
> @@ -1179,10 +1212,10 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
>  					      CDC_WSA_TX_SPKR_PROT_RESET);
>  		snd_soc_component_update_bits(component, tx_reg0,
>  					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK,
> -					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K);
> +					      rate_val);
>  		snd_soc_component_update_bits(component, tx_reg1,
>  					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK,
> -					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K);
> +					      rate_val);
>  		snd_soc_component_update_bits(component, tx_reg0,
>  					      CDC_WSA_TX_SPKR_PROT_CLK_EN_MASK,
>  					      CDC_WSA_TX_SPKR_PROT_CLK_ENABLE);
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

