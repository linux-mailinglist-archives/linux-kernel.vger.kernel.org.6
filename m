Return-Path: <linux-kernel+bounces-271141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FC7944A14
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75D21F29AAD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE78188004;
	Thu,  1 Aug 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wR9b9+4O"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767E183CC7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510507; cv=none; b=AXD9oIkNEAEx26t2Jdip7C0AbwvTv67pcsd2kvrRgy7a2kpwkBtipTETgUfNLuzgXrauQZQDb+fjfJnfqTfzkBDuqaSeD6/RvWZdO0VNFgbK1st8ETkVf3sEgagRGqYIu3e5bEWnOE1bMEaSZwbDBlwhVAHG51d0AVKI+WEDI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510507; c=relaxed/simple;
	bh=IzTwNrilBUAlwP925WvEJZboHMLUQHtVa3f+NyNlaK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWiM7L5MK3Ad/gy8AGmioq42YKqAZdgsUcsp85eutgyjxFqSNQTQN5uMUNue0AMcdbMoldZoEmd/8kPR41qls/jfNUXtzAn2XgfocgRas0aVHA0YktiWO+urqw9tEJsOg4pwDqKjrnOE40d3W95lcgLs63X0VoEVFXznEtSH2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wR9b9+4O; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so11256697a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722510503; x=1723115303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FExuf/EqIwu44cXtirgV7vgVSEt4vB1L1sgTb2On32Q=;
        b=wR9b9+4OOXpTQ0I8stwU8yflGZq6VTSBr59qQI4VuVSECCN+95WpPfagNe/0IO7Tsz
         zfRECyqRpsNKC8LZ/EjgT3HKFGd7osf38I58ZqVUuL4IeqWpWVDBiavphvwwHXhqMbZ9
         EhKLi++MxU8MwJM6DcBtii4wyESADyeRh6CUEHvNki8u6VIK3NlmdP/7WGiM20pCLQRZ
         ys3GNfVOpvPL1juJLa+wfDz5qW1UHhYcBm1SKeiK/XTRa3PEagqARrbjcMuRAvDjL5ay
         bjT0RNpvELLFo8Wi6uHWtrKl3/r9cgESOgs1eqD1wFdDOsEBWxhgByV0VrdTWPwZXrFK
         m/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510503; x=1723115303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FExuf/EqIwu44cXtirgV7vgVSEt4vB1L1sgTb2On32Q=;
        b=MWTsTBFvRFT8cUW0c2K87izZe8gIrswQUBMNcL277jYLslx7bKfd0DsijEyTECodLY
         sB6eIKTlu/uSru563x2Ffent31hNuJt+M/ofiQ7YWcJBYZKVFKTMPDvlhxQ/KkfB6GpP
         r+lfqIDmN3zqXbByBEnrOYC0eHf/93+O427Jd7jeT59InY+62j59dcaAzeYe9aekPuLK
         xnHd+bU5biY92g+Vq62vqEijXxHlYxmZK6lgl/YnAvm2L8d59vKehmm398l2sqfUikie
         vc2kzR69qGzZTYFl/9RYQKSQy1JC6OALAxfRF5LUcFNcDfVjKGpE20YaXkFNEkfoHfSF
         CaLg==
X-Forwarded-Encrypted: i=1; AJvYcCWijAoa42GQ4ekEBBzx+aLc2sgODeQEx8B8hZXRYUoFO1slkI16HJwASpuUk6v88FaZJKolMl0wAeNudrbczBy7fTI8/O/xNi6Jf514
X-Gm-Message-State: AOJu0Yygpaqeto4aTorXM4a+YQnzUhPS/wstJTgnMBKt8hlNmoN7p1OI
	sQhaYB0hdJItW/FW7RyElSRLoVnZMJ/MEGrkpk3MhY0zccDiCMND/diqVEBYSPk=
X-Google-Smtp-Source: AGHT+IGqr7N4CpNmN1ermVEFWMT0947mfSXTC3VHJzla+OoRW5oknSUl8o0Y7+o27NpeeOS8sdiOuw==
X-Received: by 2002:a17:907:25c3:b0:a77:e48d:bc8 with SMTP id a640c23a62f3a-a7daf4c8093mr173415166b.21.1722510502384;
        Thu, 01 Aug 2024 04:08:22 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff1f:b280:31d2:aeb1:18cd:e482])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90264sm894932366b.148.2024.08.01.04.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:08:22 -0700 (PDT)
Date: Thu, 1 Aug 2024 13:08:20 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Stephan Gerhold <stephan@gerhold.net>, alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/8] ASoC: qcom: apq8016_sbc: Add support for msm8976
 SoC
Message-ID: <ZqtspO9hO0yFus1u@linaro.org>
References: <20240731-msm8953-msm8976-asoc-v3-0-163f23c3a28d@gmail.com>
 <20240731-msm8953-msm8976-asoc-v3-7-163f23c3a28d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-msm8953-msm8976-asoc-v3-7-163f23c3a28d@gmail.com>

On Wed, Jul 31, 2024 at 05:25:31PM +0200, Adam Skladowski wrote:
> Introduce support for audio card on MSM8976 platform.
> While MSM8976 falls into v1 category with MSM8916, digitial codec clock
> is not available in GCC so we have to set it in machine driver.
> For that reason for V1 clocks new boolean is added to check
> if we need to enable codec clock.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  sound/soc/qcom/apq8016_sbc.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
> index 3ed35beb671a..8219d4d55625 100644
> --- a/sound/soc/qcom/apq8016_sbc.c
> +++ b/sound/soc/qcom/apq8016_sbc.c
> @@ -35,6 +35,7 @@ struct apq8016_sbc_data {
>  	struct snd_soc_jack jack;
>  	bool jack_setup;
>  	enum afe_clk_api q6afe_clk_ver;
> +	bool dig_cdc_mclk_en;
>  	int mi2s_clk_count[MI2S_COUNT];
>  };
>  
> @@ -242,6 +243,16 @@ static int msm8916_qdsp6_startup(struct snd_pcm_substream *substream)
>  
>  	if (++data->mi2s_clk_count[mi2s] > 1)
>  		return 0;
> +	/*
> +	 * On newer legacy SoC (MSM8976) lpass codec clocks are not available in gcc region
> +	 * so we have to request clock from machine driver using V1 API)
> +	 */
> +	if (data->q6afe_clk_ver == Q6AFE_CLK_V1 &&
> +	    data->dig_cdc_mclk_en) {
> +		ret = snd_soc_dai_set_sysclk(cpu_dai,  LPAIF_DIG_CLK, DEFAULT_MCLK_RATE, 0);
> +		if (ret)
> +			dev_err(card->dev, "Failed to enable LPAIF dig clk: %d\n", ret);
> +	}
>  
>  	ret = snd_soc_dai_set_sysclk(cpu_dai, qdsp6_get_clk_id(data, mi2s), MI2S_BCLK_RATE, 0);
>  	if (ret)
> @@ -267,6 +278,13 @@ static void msm8916_qdsp6_shutdown(struct snd_pcm_substream *substream)
>  	ret = snd_soc_dai_set_sysclk(cpu_dai, qdsp6_get_clk_id(data, mi2s), 0, 0);
>  	if (ret)
>  		dev_err(card->dev, "Failed to disable LPAIF bit clk: %d\n", ret);
> +
> +	if (data->q6afe_clk_ver == Q6AFE_CLK_V1 &&
> +	    data->dig_cdc_mclk_en) {
> +		ret = snd_soc_dai_set_sysclk(cpu_dai,  LPAIF_DIG_CLK, 0, 0);
> +		if (ret)
> +			dev_err(card->dev, "Failed to disable LPAIF dig clk: %d\n", ret);
> +	}
>  }

I'm a bit confused why this works correctly. The digital codec clock
(mclk) is needed whenever accessing registers of the digital codec
("qcom,msm8916-wcd-digital-codec"). This is why the clock is directly
assigned to it in the DT, so the codec driver can request it when
needed. The startup/shutdown callbacks in this patch are only called
during audio playback, while the codec registers might be accessed any
time e.g. when changing the volume mixers. Perhaps you are lucky not to
hit that, but if the clock is off at that point the device will crash or
hang.

Instead of requesting the clock here, we should assign it to the digital
codec in the DT. I think Otto's series also allowed that for the older
v1 firmware [1]. Can we work towards finishing that up instead? That
should be more reliable.

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-arm-msm/20231029165716.69878-1-otto.pflueger@abscue.de/

