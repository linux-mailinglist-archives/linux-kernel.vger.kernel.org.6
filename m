Return-Path: <linux-kernel+bounces-204793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF658FF3A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433741C264EA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2B31990C4;
	Thu,  6 Jun 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdF2lzmG"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E888E38FB9;
	Thu,  6 Jun 2024 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694670; cv=none; b=aIPqAWZ8ULL4q5MluhQMOiQIwHA9cFWuR3DnYSL467bGE8EYB3fXgmfGDTjQK+1ZX06OZA2rBQJCCjySIChUTbtgmKUvaVC0LbuRvaZNHfA9QPJSrIt11UFE7RZ0njYdASSUjqXr8wNwVuaeAp0mDxJCbSDp6PD5xfaVrYQ/eOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694670; c=relaxed/simple;
	bh=dTxC9S5XIMg5ioG+Q/uZwME7wTTzhbUrfZPA4xxlN5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3COvBK9ZyALezqJYvl7z1OaTYtGbwfsgELPSMFic93fUIt+u7/AxIq3zsEPXHBhRF1Ty4NpjPolJYKzjikeNHHlIuhfCXmh+MmWxqbQjh8n4yQwEC9djtAGNuXOipU3Wy+hR3z9Zp7UxpwA6vol855//hyoaEPVJj1JYOu+Iys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdF2lzmG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b992fd796so1296020e87.0;
        Thu, 06 Jun 2024 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694667; x=1718299467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4LNbr7VfEe6izakn3pwLNIw70DykAuM2PJO0ynb8N4=;
        b=XdF2lzmGv3IToifvd3sNb0kDc7JxmflBItKCg12cIrTXc/wiG/KVqkx580tGcOMH/u
         HOXi6AVjMyuUcEkbpj9r1IL4/L5pwFKKpl4+nlXqjuVVnPgL59S1JyM371FiFmW/Ntpw
         U+AQJn3blWFT8yiOt5j956XEWtgKTTVCCDtg2aiZH1lRj6jYozLOv/1vJ6FH7IpGcbAK
         O/qBMFHv8UVz0eU6tWyLk7/zJvynY3Cudi72hrYql0J0othhBrM6Ajry38zwWF+ODxD5
         rspQM9enjP2N0gN2e0hXSOzddXlGcqq/t/G/CvQZQK6cQ2lk4R6I+FHxSpbES2HJmRAI
         nXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694667; x=1718299467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4LNbr7VfEe6izakn3pwLNIw70DykAuM2PJO0ynb8N4=;
        b=XqcNMg9u3bduLpShWeN0iQYcQfav8BCk174yOKkvc4uLhrHdHmLXWjBes3KFSKo4RG
         9fbcjTEf4JDBx0mJX630tw5/jXWV23nr/0jCH4wst1WRpzwrVstYR3rUlauWJvd/HfZh
         VfzFkt+ud0PUXXLXANliaB69nruBofjzY1Ucyo0v/9vWnkhS6EiQBz6nU5SyXWncKA1U
         JuTue7xk/zVVYB8M4MIRL6RS8zGA8stHo5SPKds9Pn1ZbIeFQ3wLGbM6hnFWztSjAnqF
         MQ466BumAJpJjqXaycogGGJU+MpqRSYCVDpYkJSZg+GiL8x+hjrBscDyPmVBg3NlVfSD
         JGww==
X-Forwarded-Encrypted: i=1; AJvYcCU5cBcTwXgj+NUZWGoyAVuLvGavJlhlxuX1U2gTPTphvPr8EKR+PbOCZORq63fZIecZ/qnTVVflTEFzXqQENlbenqmfgjhIquu8srd5
X-Gm-Message-State: AOJu0YxX3ChwB03R5zoZrZcDqArsGhtLU+D6QGLkkw/dmWG+B7n9pkhP
	41RYFOJfri6LmP/uQXvLpdCq0i867e84KTXqbDKXO6A9kzDmSXps
X-Google-Smtp-Source: AGHT+IFOjYFmBcUyHgIetl0AFa3Qy+ZmzXrs7sFeq0xkgOyXErd6aZfbK+diwqdTip7ERQeoicunDg==
X-Received: by 2002:a19:2d50:0:b0:52b:b89a:cec7 with SMTP id 2adb3069b0e04-52bb9fd150dmr170915e87.60.1717694666798;
        Thu, 06 Jun 2024 10:24:26 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41e1c29sm251177e87.5.2024.06.06.10.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 10:24:26 -0700 (PDT)
Message-ID: <43418c73-b240-461f-af4e-49735304eaa5@gmail.com>
Date: Thu, 6 Jun 2024 20:28:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ALSA: dmaengine: Synchronize dma channel in prepare()
To: Jai Luthra <j-luthra@ti.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240604-asoc_next-v1-0-e895c88e744d@ti.com>
 <20240604-asoc_next-v1-1-e895c88e744d@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240604-asoc_next-v1-1-e895c88e744d@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/24 1:01 PM, Jai Luthra wrote:
> Sometimes the stream may be stopped due to XRUN events, in which case
> the userspace can call snd_pcm_drop() and snd_pcm_prepare() to stop and
> start the stream again.
> 
> In these cases, we must wait for the DMA channel to synchronize before
> marking the stream as prepared for playback, as the DMA channel gets
> stopped by snd_pcm_drop() without any synchronization.

Right, this is a plausible scenario, the xrun is pointing to unhealthy
system, but before re-using the channel we indeed need to make sure that
it is finished with the stop.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  include/sound/dmaengine_pcm.h         |  1 +
>  sound/core/pcm_dmaengine.c            | 10 ++++++++++
>  sound/soc/soc-generic-dmaengine-pcm.c |  8 ++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
> index c11aaf8079fb..9c5800e5659f 100644
> --- a/include/sound/dmaengine_pcm.h
> +++ b/include/sound/dmaengine_pcm.h
> @@ -36,6 +36,7 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream
>  int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
>  	struct dma_chan *chan);
>  int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
> +int snd_dmaengine_pcm_prepare(struct snd_pcm_substream *substream);
>  
>  int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
>  	dma_filter_fn filter_fn, void *filter_data);
> diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> index 12aa1cef11a1..dbf5c6136d68 100644
> --- a/sound/core/pcm_dmaengine.c
> +++ b/sound/core/pcm_dmaengine.c
> @@ -349,6 +349,16 @@ int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
>  }
>  EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
>  
> +int snd_dmaengine_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
> +
> +	dmaengine_synchronize(prtd->dma_chan);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_prepare);
> +
>  /**
>   * snd_dmaengine_pcm_close - Close a dmaengine based PCM substream
>   * @substream: PCM substream
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index ea3bc9318412..af439486d33a 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -318,6 +318,12 @@ static int dmaengine_copy(struct snd_soc_component *component,
>  	return 0;
>  }
>  
> +int dmaengine_pcm_prepare(struct snd_soc_component *component,
> +			  struct snd_pcm_substream *substream)
> +{
> +	return snd_dmaengine_pcm_prepare(substream);
> +}
> +
>  static const struct snd_soc_component_driver dmaengine_pcm_component = {
>  	.name		= SND_DMAENGINE_PCM_DRV_NAME,
>  	.probe_order	= SND_SOC_COMP_ORDER_LATE,
> @@ -327,6 +333,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
>  	.trigger	= dmaengine_pcm_trigger,
>  	.pointer	= dmaengine_pcm_pointer,
>  	.pcm_construct	= dmaengine_pcm_new,
> +	.prepare	= dmaengine_pcm_prepare,
>  };
>  
>  static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
> @@ -339,6 +346,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
>  	.pointer	= dmaengine_pcm_pointer,
>  	.copy		= dmaengine_copy,
>  	.pcm_construct	= dmaengine_pcm_new,
> +	.prepare	= dmaengine_pcm_prepare,
>  };
>  
>  static const char * const dmaengine_pcm_dma_channel_names[] = {
> 

-- 
Péter

