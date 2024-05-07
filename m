Return-Path: <linux-kernel+bounces-171973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625CB8BEB58
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859DF1C24674
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD9516D4EA;
	Tue,  7 May 2024 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="za29yH6G"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB516D4DF
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105755; cv=none; b=We1ZHksVIo6gbaYhTPSse0FC7pG4hCWtOh2PK/URSXODV4HC21/9TAr3wlNCOUhV1epWWWSBUPN7hV2NjCXCvIgEI4BbWQawM/HfzWPdIO5ss1hFtc+ABpGXPOh1K92LLOLjWqTqxQtANpKtbrPLqazn1slIuSV6Tg1KJA0RdT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105755; c=relaxed/simple;
	bh=e+Ui+xuAdmPzJfWHKGip4nd/QAAMiIFEurpFnUaCqqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGXU3hjWkwwJx7PSRS8bAtUv2+CRKm9kZ+FTLiGs6/+Tn9pJmZt0fFCYTTNeOb5o6byLUpaxW0EnKRL7Ki/eEkCsnla5qGiHdOcAXigMfNcnHtGpuNPbOlFqXsDQRG9J6KLklg9jJqsYdeqw+kNyo4oO4aWBaRDGmdAklz8z4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=za29yH6G; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a0168c75so899171066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715105752; x=1715710552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=32C2VWO0lNkaeoP0mjNW3/Db2bUiU2Lhen0koGKYiUM=;
        b=za29yH6GuqAy7ACnaDkTEepI4s1nM4gfmGbvStsBMOA0puPJpm9OJOPuaYKjVM86eT
         4iSABOQ3U+I8auaBcEMxyXTFXgDr9vpTa/k40izuFXehAWWUGvNwjyqheNg9LFdxgTtp
         Usnu7JuR1It/AqLVDHkOwLWmMLxyWZHLmyzdybdVtc/O7AlPmsPr+wOQbJ8l0WMObfiq
         R5uwtq1Kyp3vO0A3+MsLiSu8lI1GccKgwfWndRPl652dpUP0GoLP4MNvd1c19BOcAcBS
         pxAfhuY3XSeb7mhNxu6vAE1XXHqIVuxedQK8b1ZlvKq3ywfwuwtblyvhaLz3wXYNT2ub
         anog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105752; x=1715710552;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32C2VWO0lNkaeoP0mjNW3/Db2bUiU2Lhen0koGKYiUM=;
        b=gVL1Y844mzsDR4iwR0/9sLy3Mn4DLhyl+OI2fGa44MbLClvjlBdE/Ls24mg3C4AK3u
         HQbae2u6QDMm89IrXy0A39Hi8500CclN8iRrJOF4IUbZ4/Dixs08IJCA/95giKrxbr8Z
         GdjbRK6Eggzv9yRNYxk1edUS/TnCGm5CD8bPfm3DNgWrrx6Gfo4aHiTBRggmxcI8HIbs
         K6R0pyltYmfao3F1m+iQJZNnFx2pjMszPw6dXIGDKFSnjA9zR+wc9WaADJTk5bttgSJo
         MzBk5esDjpBoM2y4UOd+y4JZh3ww/Ws1Zw3JtR1NddI0kjrO6mkFGJsafnizw919+F2p
         BxiA==
X-Forwarded-Encrypted: i=1; AJvYcCUG8XDGu4yw3J5FEaP7KB489B0UDtofaQPzmperaLjQHD91Axyhexz8x1uz+6iJ6XkVJGZ/dvtzTItLpcKf5ngud9K02SPhuiu8tY6h
X-Gm-Message-State: AOJu0YwNWwE94dWpalx7MKxkB5HDHWkoneb/2KFZn19YOIQaTzi7OEos
	NwvOYRYR8ew2DsOfOLSAgDPtidiXPx2h35qWfTjF5tcTiH4iTixO7u8PGQ9sSqk=
X-Google-Smtp-Source: AGHT+IGqQGhRcCdpz1oNkC71DfaAcJyX6V8oR2QBO2ftNr4lnVvUu68bKc6YICcBN4y8APlxouEmKA==
X-Received: by 2002:a50:c319:0:b0:570:5b3d:91f with SMTP id 4fb4d7f45d1cf-5731d9db2d1mr347441a12.23.1715105752469;
        Tue, 07 May 2024 11:15:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id n15-20020a05640206cf00b00572b029ca57sm6499357edy.25.2024.05.07.11.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 11:15:52 -0700 (PDT)
Message-ID: <c9462148-2131-4660-9f65-b53f22979387@linaro.org>
Date: Tue, 7 May 2024 20:15:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ASoC: qcom: x1e80100: Correct channel mapping
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
 <738045d2-a445-4f93-abfd-203348a538d1@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <738045d2-a445-4f93-abfd-203348a538d1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2024 15:20, Srinivas Kandagatla wrote:
> Thanks Krzystof for the patch.
> 
> On 07/05/2024 11:27, Krzysztof Kozlowski wrote:
>> X1E80100 CRD board comes with four speakers arranged as left front+back
>> and then right front+back.  Using default channel mapping causes front
>> right speaker to play left back stream.
>>
>> Adjust the channel maps for frontend DAIs to fix stereo and four-channel
>> playback.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   sound/soc/qcom/x1e80100.c | 37 +++++++++++++++++++++++++++++++++++--
>>   1 file changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
>> index c3c8bf7ffb5b..e90c68815b5c 100644
>> --- a/sound/soc/qcom/x1e80100.c
>> +++ b/sound/soc/qcom/x1e80100.c
>> @@ -12,6 +12,7 @@
>>   
>>   #include "common.h"
>>   #include "qdsp6/q6afe.h"
>> +#include "qdsp6/q6dsp-common.h"
>>   #include "sdw.h"
>>   
>>   struct x1e80100_snd_data {
>> @@ -74,7 +75,7 @@ static int x1e80100_snd_hw_params(struct snd_pcm_substream *substream,
>>   	return qcom_snd_sdw_hw_params(substream, params, &data->sruntime[cpu_dai->id]);
>>   }
>>   
>> -static int x1e80100_snd_prepare(struct snd_pcm_substream *substream)
>> +static int x1e80100_snd_be_prepare(struct snd_pcm_substream *substream)
>>   {
>>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>   	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
>> @@ -96,12 +97,34 @@ static int x1e80100_snd_hw_free(struct snd_pcm_substream *substream)
>>   				    &data->stream_prepared[cpu_dai->id]);
>>   }
>>   
>> +static int x1e80100_snd_fe_prepare(struct snd_pcm_substream *substream)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
>> +	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
>> +
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +		const unsigned int rx_slot[4] = { PCM_CHANNEL_FL,
>> +						  PCM_CHANNEL_LB,
>> +						  PCM_CHANNEL_FR,
>> +						  PCM_CHANNEL_RB };
>> +
>> +		snd_soc_dai_set_channel_map(cpu_dai, 0, NULL, ARRAY_SIZE(rx_slot),
>> +					    rx_slot);
> 
> Channel mapping are specific to backend dais rather than front end pcm dais.
> 
> This will set all the playback pcms with this channel maps, which is a 
> problem.
> 
> example the 2 channel headset we will endup with data of front channel 
> and zeros on the right channel, however a speaker might work as you have 
> 4 speakers in your system.
> 
> 
> So No for this approach.

OK, I'll go with setting channels for MFC (and expecting MFC being part
of backend).

Best regards,
Krzysztof


