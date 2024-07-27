Return-Path: <linux-kernel+bounces-264291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF893E156
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 00:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2301C20B91
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEC515ADB2;
	Sat, 27 Jul 2024 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9athftF"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9A1F956
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722118958; cv=none; b=Qa/tP/k/GcAsdpvXVCiFFQX8tDF5AxnLi/DQC45LELq92VGE0ruLXGshsQIUEDhbs7TvKxx+kHr8xYBhY/qNI9nE0scJfTDSS6tRgher7HQcZRf9BOldU2BzqjKot1tV4SIvhoBq8tPSBeWBgIxKRn0a5JGdJRZdWP3aSdsv4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722118958; c=relaxed/simple;
	bh=fDjNUHr6dA8rOXDlgnigy+h72KTsuiW6mnnOcpO2mks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIpEu9QFgZwVbFsKeif9bd9b5QktKKKJhUSe//IycAjTvoQPm46bWSDngNGrg7qe/9XcTq66UwfGcP6K1sfjyPLdjH6NWv4sTXoLlNNR0YowjaG1QXihUV62RzzHyjJmhT7gsw5Duaepkob5uYV4qyQakX8TfHYkVLyx6y30VSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i9athftF; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efd855adbso3469900e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 15:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722118954; x=1722723754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmqlrirUFtzyURY6qK3fyfdNBiwmBrDBIWtbVFCj68k=;
        b=i9athftFb3IK36fqslbvcmnAQ2IVj8sK6Mh52pfqUBCgX3WoERtBL9+5ztFVpR5mGw
         4PQnq/6uc/zWab+VEKNuJh+NGuj2UrvOBU/YAM1VugJJiGEmd9TKWVoSzrmEXiUlh9WK
         ZQpdhFfZ/G1piXm9/mwveuZ318WjblQELLd78tKIbXv2TN+Xmlt/TGaiN6eO24pqjKaL
         xEAgEUDJXS+9RQ43DlfTWZ9ypyZEQTTFyyNUkdyWvxy2O4AADzYYmUldCTnKltzTBfFj
         WKPMzh+0id9tNbZwaMghrkAx37nO/aqeBErILlJLZyOY5vJIBtRqcB9i7BQDWnCew5D4
         MbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722118954; x=1722723754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmqlrirUFtzyURY6qK3fyfdNBiwmBrDBIWtbVFCj68k=;
        b=wUBeBbmELm3tFMPxkY+F7HNwa6C8opIpCjPiabNVRpSeNAHJEZWeqhhwbqZ90AE+8l
         8XNhkyosxYACtZkJNJtxt6V7oOFZnRR0g/+8oNPXaAog+z9muGqfzu2uwL2rs+vmY5fg
         8MOdttPm+Y/VlEJzR+9D5l0wrHJMI/u8O0Z1Nev2dY8HaLEnL8Olhtu96usLGgcccjWE
         7mAAtaA3uecYnULZkyKWZT/O4yY58zYB5FysK+kWi5/tefSiLRDRhITdxDmdUFakX7l+
         adyiajk3yMqvRgmx3v3Xu9Pl032FB0MTRs21mWB/7RJO8VHbAvu2J+Q/Y4mnuJ6YH4D2
         rDrg==
X-Forwarded-Encrypted: i=1; AJvYcCU7XqPkZmOYLSDAZqYUAZIPw66aQu35Id+hwunkVilM+RcxALAxf3NPYRSpAPMDk92hnCviMxlLn7ldX6PrxX2Ry7jV2MM4dtEqq+LC
X-Gm-Message-State: AOJu0YxCgOxs+fFP+8i6ITJXESRYFwcYtVEyilwetlXT+r4K2lTyNYZW
	SF996ey+30QiikOu3zrD+K84RSszUEN8ewinA/irlTJp7tTpB/P5KL6MAZmETIk=
X-Google-Smtp-Source: AGHT+IF/s11CSBZC1Ioc8fNTDjjnGQIm4OyRZiAH0axmuM5wcvd3DkIFT4ZzI5q6QFp25Q1zWlz7ZA==
X-Received: by 2002:ac2:511c:0:b0:52e:6d71:e8f1 with SMTP id 2adb3069b0e04-5309b2ce524mr2179378e87.53.1722118953841;
        Sat, 27 Jul 2024 15:22:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc40cesm871534e87.28.2024.07.27.15.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 15:22:33 -0700 (PDT)
Date: Sun, 28 Jul 2024 01:22:31 +0300
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
Subject: Re: [PATCH v2 4/4] ASoC: qcom: apq8016_sbc: Add support for
 msm8953/msm8976 SoC
Message-ID: <4ncs2zopzh2qnf4cgb7wnq2ai3vw2zjyhnv4tsgdhu3zqqnvug@63ypk324n3mr>
References: <20240727182031.35069-1-a39.skl@gmail.com>
 <20240727182031.35069-5-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727182031.35069-5-a39.skl@gmail.com>

On Sat, Jul 27, 2024 at 08:20:27PM GMT, Adam Skladowski wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Introduce support for audio card on MSM8953/MSM8976 platform.
> Main difference between those two is Q6AFE CLK API supported by firmware
> which influence way we enable digital codec clock.
> Either inside machine driver or outside via q6afe-clocks driver.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> [Adam: Add MSM8976, rename functions, add mclk setting,add msg]
> Co-developed-by: Adam Skladowski <a39.skl@gmail.com>
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  sound/soc/qcom/apq8016_sbc.c | 68 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
> index 303dd88206b1..453ca4795603 100644
> --- a/sound/soc/qcom/apq8016_sbc.c
> +++ b/sound/soc/qcom/apq8016_sbc.c
> @@ -22,6 +22,11 @@
>  
>  #define MI2S_COUNT  (MI2S_QUINARY + 1)
>  
> +enum afe_clk_api {
> +	Q6AFE_CLK_V1,
> +	Q6AFE_CLK_V2
> +};

Are these v1/v2 coming from some msm-N.M kernel? It's not obvious from
the patch, but msm8916 also falls into v1 category. Is that expected?

> +
>  struct apq8016_sbc_data {
>  	struct snd_soc_card card;
>  	void __iomem *mic_iomux;
> @@ -29,6 +34,8 @@ struct apq8016_sbc_data {
>  	void __iomem *quin_iomux;
>  	struct snd_soc_jack jack;
>  	bool jack_setup;
> +	enum afe_clk_api q6afe_clk_ver;
> +	bool dig_cdc_mclk_en;
>  	int mi2s_clk_count[MI2S_COUNT];
>  };
>  
> @@ -192,6 +199,28 @@ static int qdsp6_dai_get_lpass_id(struct snd_soc_dai *cpu_dai)
>  	}
>  }
>  
> +static int qdsp6_get_clk_id(struct apq8016_sbc_data *data, int mi2s_id)
> +{
> +	if (data->q6afe_clk_ver == Q6AFE_CLK_V2) {
> +		switch (mi2s_id) {
> +		case MI2S_PRIMARY:
> +			return Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT;
> +		case MI2S_SECONDARY:
> +			return Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT;
> +		case MI2S_TERTIARY:
> +			return Q6AFE_LPASS_CLK_ID_TER_MI2S_IBIT;
> +		case MI2S_QUATERNARY:
> +			return Q6AFE_LPASS_CLK_ID_QUAD_MI2S_IBIT;
> +		case MI2S_QUINARY:
> +			return Q6AFE_LPASS_CLK_ID_QUI_MI2S_IBIT;
> +		default:
> +			break;
> +		}
> +	}
> +	/* If AFE CLK isn't V2 return V1 */
> +	return LPAIF_BIT_CLK;
> +}
> +
>  static int msm8916_qdsp6_dai_init(struct snd_soc_pcm_runtime *rtd)
>  {
>  	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
> @@ -214,8 +243,17 @@ static int msm8916_qdsp6_startup(struct snd_pcm_substream *substream)
>  
>  	if (++data->mi2s_clk_count[mi2s] > 1)
>  		return 0;
> +	/*
> +	 * On newer legacy SoC (MSM8976) lpass codec clocks are not available in gcc region
> +	 * so we have to request clock from machine driver using V1 API)
> +	 */
> +	if (data->q6afe_clk_ver == Q6AFE_CLK_V1 && data->dig_cdc_mclk_en == true) {

Nit: line feed after &&

> +		ret = snd_soc_dai_set_sysclk(cpu_dai,  LPAIF_DIG_CLK, DEFAULT_MCLK_RATE, 0);
> +		if (ret)
> +			dev_err(card->dev, "Failed to enable LPAIF dig clk: %d\n", ret);
> +	}
>  
> -	ret = snd_soc_dai_set_sysclk(cpu_dai, LPAIF_BIT_CLK, MI2S_BCLK_RATE, 0);
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, qdsp6_get_clk_id(data, mi2s), MI2S_BCLK_RATE, 0);
>  	if (ret)
>  		dev_err(card->dev, "Failed to enable LPAIF bit clk: %d\n", ret);
>  	return ret;
> @@ -236,9 +274,16 @@ static void msm8916_qdsp6_shutdown(struct snd_pcm_substream *substream)
>  	if (--data->mi2s_clk_count[mi2s] > 0)
>  		return;
>  
> -	ret = snd_soc_dai_set_sysclk(cpu_dai, LPAIF_BIT_CLK, 0, 0);
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, qdsp6_get_clk_id(data, mi2s), 0, 0);
>  	if (ret)
>  		dev_err(card->dev, "Failed to disable LPAIF bit clk: %d\n", ret);
> +
> +	if (data->q6afe_clk_ver == Q6AFE_CLK_V1 && data->dig_cdc_mclk_en == true) {

Nit: And here too, please.

> +		ret = snd_soc_dai_set_sysclk(cpu_dai,  LPAIF_DIG_CLK, 0, 0);
> +		if (ret)
> +			dev_err(card->dev, "Failed to disable LPAIF dig clk: %d\n", ret);
> +	}
> +
>  }
>  
>  static const struct snd_soc_ops msm8916_qdsp6_be_ops = {
> @@ -279,6 +324,23 @@ static void msm8916_qdsp6_add_ops(struct snd_soc_card *card)
>  	}
>  }
>  
> +static void msm8953_qdsp6_add_ops(struct snd_soc_card *card)
> +{
> +	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
> +
> +	pdata->q6afe_clk_ver = Q6AFE_CLK_V2;
> +	msm8916_qdsp6_add_ops(card);
> +}
> +
> +static void msm8976_qdsp6_add_ops(struct snd_soc_card *card)
> +{
> +	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
> +
> +	pdata->q6afe_clk_ver = Q6AFE_CLK_V1;
> +	pdata->dig_cdc_mclk_en = true;
> +	msm8916_qdsp6_add_ops(card);
> +}
> +
>  static const struct snd_kcontrol_new apq8016_sbc_snd_controls[] = {
>  	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
>  	SOC_DAPM_PIN_SWITCH("Mic Jack"),
> @@ -343,6 +405,8 @@ static int apq8016_sbc_platform_probe(struct platform_device *pdev)
>  static const struct of_device_id apq8016_sbc_device_id[] __maybe_unused = {
>  	{ .compatible = "qcom,apq8016-sbc-sndcard", .data = apq8016_sbc_add_ops },
>  	{ .compatible = "qcom,msm8916-qdsp6-sndcard", .data = msm8916_qdsp6_add_ops },
> +	{ .compatible = "qcom,msm8953-qdsp6-sndcard", .data = msm8953_qdsp6_add_ops },
> +	{ .compatible = "qcom,msm8976-qdsp6-sndcard", .data = msm8976_qdsp6_add_ops },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, apq8016_sbc_device_id);
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

