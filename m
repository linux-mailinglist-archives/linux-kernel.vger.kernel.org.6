Return-Path: <linux-kernel+bounces-171430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F1A8BE435
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F5B287856
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFFD15F316;
	Tue,  7 May 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9lm/B7J"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CEB15E7E8
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088047; cv=none; b=Gr95auxNMhCLSeolmXyK24aK5EWhxhCbRJwmfc/SD+BgI4qb8A2kqyXLC59tRaGtYory7U+vCobqbGccb0i/k41gdr/8819LgYoEOa00QJgVZ+h4KZ1agdmgZa2dRY1HVxt7cE7dWJmJwOM3pe+Bkd1DKKSPPk+g157z2/4XPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088047; c=relaxed/simple;
	bh=mamtRdpVuLvc5n7H5rO8CzIxnBOX+3m2jzq6NAnyw8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksSezIVIrps4I9BBnuog3760FVsyY3A9IgCiJYb4+U4SpQKzVXxrSbYlHmXXGqLm1VyZHYutqeYis2+q5iSgDZAm8z2GEAW3Fi9RT/+X+rvu/XC2fJdoUtoIySqy5g1N0HcPXnk2TCrXa2bjAAlLhUHs9TfeNbo1k7ZgPayXTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I9lm/B7J; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f29e80800so3441117e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715088044; x=1715692844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K752O0Pcm3pbK7QoMDyqSQ3O3yzgRSedQhsNAlMKLtQ=;
        b=I9lm/B7JeM6zCxEnqG9ogfOlR4YvRk2h64PjUiVbUsMyzt+ZHPB5WypBd2ikN44reo
         YsBaCqBwXU7ixmFaBFPO3AL7Id2DHszD0m9OVnOTNgJquy7zyrlatO7bxBhw1OGcFIa2
         Rv5u4k0HZOmVPT4JgmEUfe9kgAjkkKVu0+jUzzMPtlTNQIDFOQvGdxl1gynmg0x0H8sj
         pEgenzVepqG/Ra3EsNvj9qO3XQ0dopJsojfroyat7rOttrl/2QsWEyzk2UJHzOK6r/D9
         cAcuTadS2+T31PF/c4CvMU2RfTD4QYKnQnIQ9mB1QguqoVVjXWXQJKG3JrpoiI8eCcrh
         ynfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715088044; x=1715692844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K752O0Pcm3pbK7QoMDyqSQ3O3yzgRSedQhsNAlMKLtQ=;
        b=K2PWRJRZSxToTTeaNxVtqrLLIebQjPxl0JPp2wuRSfjyBXCWdkcFGBaEm7N5jkOnwB
         lysEkiGc8FU7iufnBYZUVaI/asAjcgQgyJnMsL7gT+xk/jhDX6ih1BTp/US8TGDcS7Uq
         qerJNUeHxrJBs5JERdE442rcw5xiMmbXJ1ICzgTR7yul8OlPWf5RajYC6Y4uqMhsvN5u
         jk1uyHE1vwPmnS+N66MNqKfx/LSrjtJdX0p78u8iL+d9uV804+sc15+LEq7wQ1CGZdvU
         uauvqKNgBL7fmHWnBScm3kKg2x9V3O0HJZ8Wne8DZvYUWr47cB5GL1oWWK4g79EC7eIQ
         adJA==
X-Forwarded-Encrypted: i=1; AJvYcCXvCPu/OfDJ04FWDfMybS0R4Wr5PkSc5U128LBK7lEBqBFRJgM6RvnOAVkS2qaFrLIiz+kCI6cSiWT+ZnkWUV0hqWFe4PDsCZYCpNUB
X-Gm-Message-State: AOJu0Yw2fzhm+xz26eykRPsLWXpLha31lQwZ8obHUWajzHH8TUxSebML
	bSj6CdzhW+f2002eUqynXTsx1t7ZdEVNu/Qui4XjAANKGsmbwPqZkNNO5cxnWpA=
X-Google-Smtp-Source: AGHT+IEGgqheSj5TrFbScUYvwODCUxXLu8LisrOI8dAlAhc9ZxNegHyZOZbMATbWnAgxeOagu8p+xA==
X-Received: by 2002:ac2:490b:0:b0:51e:fd97:af89 with SMTP id n11-20020ac2490b000000b0051efd97af89mr8145136lfi.16.1715088043422;
        Tue, 07 May 2024 06:20:43 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a6-20020a05600c348600b0041c14e42e2bsm19558165wmq.44.2024.05.07.06.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 06:20:42 -0700 (PDT)
Message-ID: <738045d2-a445-4f93-abfd-203348a538d1@linaro.org>
Date: Tue, 7 May 2024 14:20:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ASoC: qcom: x1e80100: Correct channel mapping
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Banajit Goswami <bgoswami@quicinc.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240507-asoc-x1e80100-4-channel-mapping-v1-0-b12c13e0a55d@linaro.org>
 <20240507-asoc-x1e80100-4-channel-mapping-v1-4-b12c13e0a55d@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240507-asoc-x1e80100-4-channel-mapping-v1-4-b12c13e0a55d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Krzystof for the patch.

On 07/05/2024 11:27, Krzysztof Kozlowski wrote:
> X1E80100 CRD board comes with four speakers arranged as left front+back
> and then right front+back.  Using default channel mapping causes front
> right speaker to play left back stream.
> 
> Adjust the channel maps for frontend DAIs to fix stereo and four-channel
> playback.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   sound/soc/qcom/x1e80100.c | 37 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
> index c3c8bf7ffb5b..e90c68815b5c 100644
> --- a/sound/soc/qcom/x1e80100.c
> +++ b/sound/soc/qcom/x1e80100.c
> @@ -12,6 +12,7 @@
>   
>   #include "common.h"
>   #include "qdsp6/q6afe.h"
> +#include "qdsp6/q6dsp-common.h"
>   #include "sdw.h"
>   
>   struct x1e80100_snd_data {
> @@ -74,7 +75,7 @@ static int x1e80100_snd_hw_params(struct snd_pcm_substream *substream,
>   	return qcom_snd_sdw_hw_params(substream, params, &data->sruntime[cpu_dai->id]);
>   }
>   
> -static int x1e80100_snd_prepare(struct snd_pcm_substream *substream)
> +static int x1e80100_snd_be_prepare(struct snd_pcm_substream *substream)
>   {
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>   	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
> @@ -96,12 +97,34 @@ static int x1e80100_snd_hw_free(struct snd_pcm_substream *substream)
>   				    &data->stream_prepared[cpu_dai->id]);
>   }
>   
> +static int x1e80100_snd_fe_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
> +	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		const unsigned int rx_slot[4] = { PCM_CHANNEL_FL,
> +						  PCM_CHANNEL_LB,
> +						  PCM_CHANNEL_FR,
> +						  PCM_CHANNEL_RB };
> +
> +		snd_soc_dai_set_channel_map(cpu_dai, 0, NULL, ARRAY_SIZE(rx_slot),
> +					    rx_slot);

Channel mapping are specific to backend dais rather than front end pcm dais.

This will set all the playback pcms with this channel maps, which is a 
problem.

example the 2 channel headset we will endup with data of front channel 
and zeros on the right channel, however a speaker might work as you have 
4 speakers in your system.


So No for this approach.


--srini

> +	}
> +
> +	return 0;
> +}
> +
>   static const struct snd_soc_ops x1e80100_be_ops = {
>   	.startup = qcom_snd_sdw_startup,
>   	.shutdown = x1e80100_snd_shutdown,
>   	.hw_params = x1e80100_snd_hw_params,
>   	.hw_free = x1e80100_snd_hw_free,
> -	.prepare = x1e80100_snd_prepare,
> +	.prepare = x1e80100_snd_be_prepare,
> +};
> +
> +static const struct snd_soc_ops x1e80100_fe_ops = {
> +	.prepare = x1e80100_snd_fe_prepare,
>   };
>   
>   static void x1e80100_add_be_ops(struct snd_soc_card *card)
> @@ -118,6 +141,15 @@ static void x1e80100_add_be_ops(struct snd_soc_card *card)
>   	}
>   }
>   
> +static int x1e80100_add_dai_link(struct snd_soc_card *card, struct snd_soc_dai_link *link)
> +{
> +	/* Add ops for Frontend DAIs coming from Topology */
> +	if (link->dynamic && !link->no_pcm && !link->ops)
> +		link->ops = &x1e80100_fe_ops;
> +
> +	return 0;
> +}
> +
>   static int x1e80100_platform_probe(struct platform_device *pdev)
>   {
>   	struct snd_soc_card *card;
> @@ -135,6 +167,7 @@ static int x1e80100_platform_probe(struct platform_device *pdev)
>   
>   	card->owner = THIS_MODULE;
>   	card->dev = dev;
> +	card->add_dai_link = x1e80100_add_dai_link;
>   	dev_set_drvdata(dev, card);
>   	snd_soc_card_set_drvdata(card, data);
>   
> 

