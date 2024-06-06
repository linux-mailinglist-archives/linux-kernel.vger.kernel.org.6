Return-Path: <linux-kernel+bounces-204772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB338FF382
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D15B256AB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CD3198E84;
	Thu,  6 Jun 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwLPMfxO"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB6224D1;
	Thu,  6 Jun 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693826; cv=none; b=QzAFBabIdUnpMa9uBE0aaPxNwhnnBnIPSRqZ7x7mM7VLIvASBcI7EgbLzjmxqKeDelznWBJ76MqynSOEv9/BzeM9QA0gUfAG3z8DVQV7Dz55ynj1uubkghMSeBdr4GiySDsNDvLtBTPBE8moowdBkQFHQ8zyrkd8o5RvN0nk9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693826; c=relaxed/simple;
	bh=M70tp6532oErosXvST9jh7Vo9666z4tcB3oOndDwuWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiDu3bUys2KrKvot9jGaqVjx5UY/uZ84oDjqYAT9z1x1xxB7aq7SD1z/yuSkr7lZmTXfesfk8XTbEWoCGw6x3+U7BO2m+A6v8CcnBT+TIzC1rjclIhdmcbihZnWNutKPsAkcUTgI1bH2xKdJ+10J4obYuH84LY9g4gqYAWEj9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwLPMfxO; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b94ad88cbso1882106e87.0;
        Thu, 06 Jun 2024 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717693823; x=1718298623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfcPheLV0NZCmf87grsxqRgL031WLMyzJrb0w/6enLU=;
        b=FwLPMfxOY2UivHsEBqPZJSUYsTJ2gFu9CCyLYNTISJh9QqTx2uYLsxqsURO8Ffw0eK
         VUC2vozC6NnqwZl4yn0V1yCajm/GzIIExF0KSafQEVYNmX4XAyj9+mE/4VXTj3vvvzmU
         0oZPusyxzTLjBAEMteDVtHpq/5rqyLPVGJIEC+NXR/Kv4qCpphb2fy/BoiDBMcZ6gU9u
         QQux5JzIW/Tpa8cLoWgt6K0afncWT7ozOhT9o3WzR+uEWVD8cHTy57YDH/ZPEv6PLWgI
         59puwfdbabzuOcwairzvGVCXpgQ2ZRgTeTSEkZfVb0oz3EpzWGOPTUF4hFFZzS/zZ4HK
         rd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717693823; x=1718298623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfcPheLV0NZCmf87grsxqRgL031WLMyzJrb0w/6enLU=;
        b=pEU2hzL6XX8s+P4ELdiqVNzK+YnZP0jRZwsI9hYa0dO8OKTOd9XyhZNDQbRlsJgr4O
         T3YqIx44F+JjEOGon7akoyNQ+incqc3OfTC5aylSH6i0oX/yllQ1ovZ7uOy3jnI02D6U
         X3LjT+G37vfgFGageMZo51zicXZ7sIMDUPSi34sUhg+/7XNzZWhFydKwxTUZrVLCz0ca
         ovzNpy9aZAkBYjpdhKq/Y3j+2BF7xzkbp4oszFUrAjg5e7g8lffksQsHGHm4tv84l1Qq
         wttaqD0iVXLtOURHWcpIvmWxyfkcpGqyCfQGyF7TG09sBgaFFKrNkd1LxcAnXrs69VhH
         uk3g==
X-Forwarded-Encrypted: i=1; AJvYcCWy+GvOMYSJLZg03U9nkga4yhj8sbckBDMxAp57PYrUXrpHEHHTntqvcWamaFF8AH2DJa3bmEPmOmAxdqsD18kYm6G0tkaBkATLeWY+
X-Gm-Message-State: AOJu0YyeGvYovP0QC86AT+6n1059wmksY8zn36AtQfTTq7mpVc/yqwab
	5hWcJFGxf4nX1TrCyDC/6teO4sE49l9xUw1cXy1xUn8n468xTtw0
X-Google-Smtp-Source: AGHT+IHjAV1sRFdp+OWciQrMCzE/Ou7KGCZoDPrUBVN8JEZkK68c3eqRAB4TI9M5ylBpowsDZcF8Qg==
X-Received: by 2002:a05:6512:3f09:b0:51f:3e0c:ace3 with SMTP id 2adb3069b0e04-52bb9f785d9mr227002e87.16.1717693822817;
        Thu, 06 Jun 2024 10:10:22 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb423cf28sm246062e87.194.2024.06.06.10.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 10:10:22 -0700 (PDT)
Message-ID: <6a88c1b3-b3d0-48d0-a620-b17464cb559e@gmail.com>
Date: Thu, 6 Jun 2024 20:13:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: ti: davinci-mcasp: Set min period size using
 FIFO config
To: Jai Luthra <j-luthra@ti.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240604-asoc_next-v1-0-e895c88e744d@ti.com>
 <20240604-asoc_next-v1-2-e895c88e744d@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240604-asoc_next-v1-2-e895c88e744d@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/4/24 1:01 PM, Jai Luthra wrote:
> The minimum period size was enforced to 64 as older devices integrating
> McASP with EDMA used an internal FIFO of 64 samples.
> 
> With UDMA based platforms this internal McASP FIFO is optional, as the
> DMA engine internally does some buffering which is already accounted for
> when registering the platform. So we should read the actual FIFO
> configuration (txnumevt/rxnumevt) instead of hardcoding frames.min to
> 64.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index 1e760c315521..2a53fb7e72eb 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -70,6 +70,7 @@ struct davinci_mcasp_context {
>  struct davinci_mcasp_ruledata {
>  	struct davinci_mcasp *mcasp;
>  	int serializers;
> +	u8 numevt;
>  };
>  
>  struct davinci_mcasp {
> @@ -1470,12 +1471,13 @@ static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
>  static int davinci_mcasp_hw_rule_min_periodsize(
>  		struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
>  {
> +	struct davinci_mcasp_ruledata *rd = rule->private;
>  	struct snd_interval *period_size = hw_param_interval(params,
>  						SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
>  	struct snd_interval frames;
>  
>  	snd_interval_any(&frames);
> -	frames.min = 64;
> +	frames.min = rd->numevt;

64 was a nice number ;)

>  	frames.integer = 1;
>  
>  	return snd_interval_refine(period_size, &frames);
> @@ -1516,6 +1518,9 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
>  		if (mcasp->serial_dir[i] == dir)
>  			max_channels++;
>  	}
> +	ruledata->numevt = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
> +				   mcasp->txnumevt :
> +				   mcasp->rxnumevt;

Do this at the same location where the rest of the ruledata members are
initialized, or

>  	ruledata->serializers = max_channels;
>  	ruledata->mcasp = mcasp;
>  	max_channels *= tdm_slots;
> @@ -1591,7 +1596,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
>  
>  	snd_pcm_hw_rule_add(substream->runtime, 0,
>  			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> -			    davinci_mcasp_hw_rule_min_periodsize, NULL,
> +			    davinci_mcasp_hw_rule_min_periodsize, ruledata,

You could just pass a pointer to txnumevt/rxnumevt directly...

>  			    SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
>  
>  	return 0;
> 

-- 
Péter

