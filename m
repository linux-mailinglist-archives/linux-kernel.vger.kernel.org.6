Return-Path: <linux-kernel+bounces-207751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A51CD901B85
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D091C21565
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB641CF8D;
	Mon, 10 Jun 2024 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdRZ5nnK"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089881BF2A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718003123; cv=none; b=I6/O6WAOXZTpJGybTpybR3X31QEiljYz39Of9E0MB01DyIZJXu1wkyQTv2qv7uMd/I8wBBGh8WUlNZKhsNQKcELDR10wiyYta1BbqYmMEf2TCtumm6hY5Qixktwji3PFxbSSa0wFMKOngG1Ue7qNEs6ES0vPJmcKJLJm3KaBhhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718003123; c=relaxed/simple;
	bh=/AvsbsUJd/zTGNO42rFXKAiiuS8ZEWlCyClzMR+cMBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIk2JWlJCZmErfnWBH1Puvl9ok8ElBMQsPvUyTlMkYSwJFjGsR/cAESbLcaCbPysSvIpDatIaEzZVKXuXka6XqczyKoSlQ1+KpilRvaFqlUfnQTcF6QJFf4LV57P7PHQss0AWvOdaewXUZX5i1LiJuRq+gEffvjvVUWWafvzX80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CdRZ5nnK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57c68c3f8adso2048820a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 00:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718003120; x=1718607920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPZSLa5VJ9ZJ5ThCXQZcFW6Ti5Z+EHbBJU7SLERjk6Q=;
        b=CdRZ5nnK12/P3OrRhY2mW8r9y79KJ8tDxDEsbc+1YCHKhg6Mpk/48GN5tnd1dXIBz3
         f+7bw+eRHk6TCMGV3BY91p+720Bo/sQF9LXS+Prg4ejkS/34nIDygXbYywF5yqoIuptA
         NmVbIa9yaCctoUQW8tllBDO27ljO0DLtADcfWxRzf7zRWfU1mTkEIukoMXMACzLKGt2W
         zlqAM2HUeJETWMMJQGdSn2ah/RlsEoWz6dgPbqaoTOZyCBvV+Tx22dOMv+iDfMnO4Kr4
         PeB5olWdW3SM8Z4QTgOlMZKdCbceeuiSmJ6EVrEByjfkYQ6mXGbcaKJOlZGpB79Jqr3Y
         pohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718003120; x=1718607920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPZSLa5VJ9ZJ5ThCXQZcFW6Ti5Z+EHbBJU7SLERjk6Q=;
        b=Du+5cx+t5zRcklBuWrU1tRG5euBLL5eBuQtJ+sYW0OgeIk937Y/ukoTEiAyCuDWp1U
         PPiqSB0IPtueS2UBYJBkXuMidcsOpBXiIWY7BacugTaF9SbLQDkk3OvwUWl60l6sOrC2
         cBbXDZMXI3KOXNHlZ4mgj9vkQt8aihZfZUpGsxQVFUzFChBjMdzHoDUY3bshHWaogxGm
         d8cfRFtRiZHQNjjtkkabAWU4pWoyU0oAEx0KHyu8V5Cvlyk0vntinyeTNL43Sv9MSMRK
         72CeMqIPQ59gi6Kx3mWPLCiDXt+uqBByLUqcHv0MLABTio1tfiK9D4xisLg51DujV5Xy
         DOXg==
X-Forwarded-Encrypted: i=1; AJvYcCW6d1nkI/ABNiZSqzCT7hg50oMmnkosG0UjVyf5rSLLdp6jdvrAKt1x72RK0W9KFre4smPWYv5Y/IFSawV7JCI6vgMsWOQd5Wwgs+w7
X-Gm-Message-State: AOJu0YykK1T+XeIWrU+Q8lblcisEkQJL1ySRfWI9fcgTv5Nbnca71nyN
	zl+9kWROW4r7EKFAfIR8POFlfXmqkvtA8b79RwR+m3qbsllNhBKn15uxY016eDE=
X-Google-Smtp-Source: AGHT+IEgv3JegFvQ+6vLGmNwNKNTfnIzW5enFDnscw96CRYsquxgRG1RrvcEtuTnAeCT9o3J9KN8iQ==
X-Received: by 2002:a17:906:4ecd:b0:a6f:7cb:6e76 with SMTP id a640c23a62f3a-a6f07cb723emr358812166b.51.1718003120208;
        Mon, 10 Jun 2024 00:05:20 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6f2d4138ccsm7698766b.220.2024.06.10.00.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 00:05:19 -0700 (PDT)
Message-ID: <ba911ebd-aef5-46af-ace1-84d13bee6876@linaro.org>
Date: Mon, 10 Jun 2024 08:05:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v5 6/7] ASoC: codecs: wcd937x: add capture dapm widgets
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
 quic_pkumpatl@quicinc.com, Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20240527111956.444425-1-quic_mohs@quicinc.com>
 <20240527111956.444425-7-quic_mohs@quicinc.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240527111956.444425-7-quic_mohs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/05/2024 12:19, Mohammad Rafi Shaik wrote:
> +static int __wcd937x_codec_enable_micbias(struct snd_soc_dapm_widget *w,
> +					  int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	int micb_num;
> +
> +	if (strnstr(w->name, "MIC BIAS1", sizeof("MIC BIAS1")))
> +		micb_num = MIC_BIAS_1;
> +	else if (strnstr(w->name, "MIC BIAS2", sizeof("MIC BIAS2")))
> +		micb_num = MIC_BIAS_2;
> +	else if (strnstr(w->name, "MIC BIAS3", sizeof("MIC BIAS3")))
> +		micb_num = MIC_BIAS_3;
> +	else
> +		return -EINVAL;
> +
See last comment..

> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		wcd937x_micbias_control(component, micb_num,
> +					MICB_ENABLE, true);
> +		break;
> +	case SND_SOC_DAPM_POST_PMU:
> +		usleep_range(1000, 1100);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		wcd937x_micbias_control(component, micb_num,
> +					MICB_DISABLE, true);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int wcd937x_codec_enable_micbias(struct snd_soc_dapm_widget *w,
> +					struct snd_kcontrol *kcontrol,
> +					int event)
> +{
> +	return __wcd937x_codec_enable_micbias(w, event);
> +}
> +
> +static int __wcd937x_codec_enable_micbias_pullup(struct snd_soc_dapm_widget *w,
> +						 int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	int micb_num;
> +
> +	if (strnstr(w->name, "VA MIC BIAS1", sizeof("VA MIC BIAS1")))
> +		micb_num = MIC_BIAS_1;
> +	else if (strnstr(w->name, "VA MIC BIAS2", sizeof("VA MIC BIAS2")))
> +		micb_num = MIC_BIAS_2;
> +	else if (strnstr(w->name, "VA MIC BIAS3", sizeof("VA MIC BIAS3")))
> +		micb_num = MIC_BIAS_3;
> +	else
> +		return -EINVAL;
> +
same..
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		wcd937x_micbias_control(component, micb_num, MICB_PULLUP_ENABLE, true);
> +		break;
> +	case SND_SOC_DAPM_POST_PMU:
> +		usleep_range(1000, 1100);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		wcd937x_micbias_control(component, micb_num, MICB_PULLUP_DISABLE, true);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +

...

>   static const struct snd_soc_dapm_widget wcd937x_dapm_widgets[] = {
...> +	/* MIC_BIAS widgets */
> +	SND_SOC_DAPM_SUPPLY("MIC BIAS1", SND_SOC_NOPM, 0, 0,
Please use shift here like
         SND_SOC_DAPM_SUPPLY("MIC BIAS1", SND_SOC_NOPM, MIC_BIAS_1, 0,
         SND_SOC_DAPM_SUPPLY("MIC BIAS2", SND_SOC_NOPM, MIC_BIAS_2, 0,

to avoid doing a string compares on wideget name.

--srini

> +			    wcd937x_codec_enable_micbias,
> +			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
> +			    SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_SUPPLY("MIC BIAS2", SND_SOC_NOPM, 0, 0,
> +			    wcd937x_codec_enable_micbias,
> +			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
> +			    SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_SUPPLY("MIC BIAS3", SND_SOC_NOPM, 0, 0,
> +			    wcd937x_codec_enable_micbias,
> +			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
> +			    SND_SOC_DAPM_POST_PMD),
> +
>   	SND_SOC_DAPM_SUPPLY("VDD_BUCK", SND_SOC_NOPM, 0, 0,
>   			    wcd937x_codec_enable_vdd_buck,
>   			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> @@ -2007,11 +2312,101 @@ static const struct snd_soc_dapm_widget wcd937x_dapm_widgets[] = {
>   	SND_SOC_DAPM_MIXER("HPHR_RDAC", SND_SOC_NOPM, 0, 0,
>   			   hphr_rdac_switch, ARRAY_SIZE(hphr_rdac_switch)),
>   
> +	/* TX output widgets */
> +	SND_SOC_DAPM_OUTPUT("ADC1_OUTPUT"),
> +	SND_SOC_DAPM_OUTPUT("ADC2_OUTPUT"),
> +	SND_SOC_DAPM_OUTPUT("ADC3_OUTPUT"),
> +	SND_SOC_DAPM_OUTPUT("WCD_TX_OUTPUT"),
> +
>   	/* RX output widgets */
>   	SND_SOC_DAPM_OUTPUT("EAR"),
>   	SND_SOC_DAPM_OUTPUT("AUX"),
>   	SND_SOC_DAPM_OUTPUT("HPHL"),
>   	SND_SOC_DAPM_OUTPUT("HPHR"),
> +
> +	/* MIC_BIAS pull up widgets */
> +	SND_SOC_DAPM_SUPPLY("VA MIC BIAS1", SND_SOC_NOPM, 0, 0,
> +			    wcd937x_codec_enable_micbias_pullup,
> +			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
> +			    SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_SUPPLY("VA MIC BIAS2", SND_SOC_NOPM, 0, 0,
> +			    wcd937x_codec_enable_micbias_pullup,
> +			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
> +			    SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_SUPPLY("VA MIC BIAS3", SND_SOC_NOPM, 0, 0,
> +			    wcd937x_codec_enable_micbias_pullup,
> +			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
> +			    SND_SOC_DAPM_POST_PMD),

