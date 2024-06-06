Return-Path: <linux-kernel+bounces-203972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4408FE26C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17531C235D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CDF15216D;
	Thu,  6 Jun 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tv4Z30Br"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB7613C833
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665504; cv=none; b=TDF8d1kqze2SM82K3WoFtra1JQkf9pdM/nkBncq9twObL9YI4EbyvYJ+35rBclL9pMUjXZ92yX5stKI1dAChF2pRy9iopKOTIDAIbKIWuiTPSwewcJdlpsN5NtqycTBUgoycpFOJaPmfVGvZQb4DhYsAZ2OYHu43CtyvKTsiRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665504; c=relaxed/simple;
	bh=r872hk76aQr0n4O8MujB1oCORR4MPudLMN6k8jgi0lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNpShaCfg0QDRbNTp3RU0H3NzzvKD5wRs/Ry3tBth5zY/7fTTnFnzAgefN+xJzEA2nqraSOGS76XwWhMBNAWSEImYs345ji5WgMQ9mX/q12LGlo41oRoLa0qbOLQZLyoHN6ljsK4XEzr6ePyyqk4W4Kw9zQiY/YwUiKFKouae84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tv4Z30Br; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b92e73e2fso759624e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717665500; x=1718270300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYWa3RzbG0HUx/GfVkXqV1gm2vwpRDwUlnvYYRSC6iY=;
        b=tv4Z30BrIDuDhHnwJ8kX9AOYXBuOQBfEoi5fyHjVAD/yyoYq+r/CKsIQL4ZVy2N8Do
         PVm/EQ2WctIrenmItqChLuyjTP+2AiJ9tT3Et+yIouiSOc52fswRdyN0uRZExmQvEqKU
         JgBpXalfZRJq0+ZgcCqEjCuqwHrrTnB8q+NBx+Bii8DonvzOqDLv4iQYLigEL9HZll0x
         FmYvDzmMambgOnB9+kHYtVlMy6ZP3TWSjpqX+2hJW7kNfAMv2e3h+cZ2ry4NK47/7S1K
         i4RHTcjY5LN65wK2PXTeoGHyIB3l1JOIgNNFcDSiw8Ylap/lY8LX8vRZ6LVmxpO8HmTY
         f3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665500; x=1718270300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYWa3RzbG0HUx/GfVkXqV1gm2vwpRDwUlnvYYRSC6iY=;
        b=uM0Tw/AuCHkYjsS3743fcn8DrCzbfBO0JVmUubiFNNNzH2Kmqt2qTm91EXh710hYVC
         X8K6qhQ2CTt+23fqQ6in/G2i4Mw7ymIUsEO3POlwJ9Hovineck0F3XM0rSVcNcNmBbTp
         a5iSyA7o0y/O8IY3aPKedt6rVWODa9uUXAAR9fih53nBnVU2eFck68JP7zfvH2YC+/25
         dcI3feEbL3yf70x9XasNZ0NtuFI2UU176Nh5qrS6HaTCTO/o02DkJUEBk1y/RHuevHEW
         OtuPfoFEezQqB+Wv5MkAggfsSQ91QaIshBSg+EWj8vxt2iWWs6e59sK31vyMmAkA0U6v
         EYDg==
X-Forwarded-Encrypted: i=1; AJvYcCWg8pDxFtODYyQRlieKh0FpN4m1FU7oJ8qjA7YiOloQeEe/bN/HLudPaahrUNJg7oIYQFzkDJUixfcT1UqwJrwIQ1fAbuH8LmaEOZjt
X-Gm-Message-State: AOJu0Yy79HeEoR8uPON+MUyjen+PoAT90drot3Ny/L8rv6+PKoddSiHS
	JHBDEtUhVxhy3EGymP4J+uHOOkJGkkQQhIqy6NOwBkNFP1MEQvcn1zvgnA+X82w=
X-Google-Smtp-Source: AGHT+IE6z/kG5jsknCvlfvxK3SmNh7Dq1i0rEsSxpui1SZZ37TNlbM5BwOQyTCYbxW9qJHmS/x12VA==
X-Received: by 2002:a05:6512:281c:b0:52b:7917:9966 with SMTP id 2adb3069b0e04-52bab4b0abemr3952237e87.8.1717665500062;
        Thu, 06 Jun 2024 02:18:20 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35ef5d6990csm1035951f8f.58.2024.06.06.02.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 02:18:19 -0700 (PDT)
Message-ID: <11803812-56cd-48d0-a0fc-8ca99d6f79d5@linaro.org>
Date: Thu, 6 Jun 2024 10:18:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ASoC: qcom: display port changes
To: Xilin Wu <wuxilin123@gmail.com>, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <dd14e3ff-3ff7-426e-88e0-b16a49eafaf0@gmail.com>
 <44fad635-1b17-47bc-97f0-9a541e0b4f35@linaro.org>
 <21f0f2ac-dada-4e19-a0df-086021320101@gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <21f0f2ac-dada-4e19-a0df-086021320101@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Xilin

On 25/05/2024 08:12, Xilin Wu wrote:
> Hi Srini,
> 
> On 2024/5/24 20:50, Srinivas Kandagatla wrote:
>> Hi Xilin,
>>
>> On 23/05/2024 05:09, Xilin Wu wrote:
>>>>
>>>> Srinivas Kandagatla (4):
>>>>    ASoC: qcom: q6dsp: parse Display port tokens
>>>>    ASoC: qcom: common: add Display port Jack function
>>>>    ASoC: qcom: sc8280xp: add Display port Jack
>>>>    ASoC: qcom: sm8250: fix a typo in function name
>>>>
>>>>   sound/soc/qcom/common.c         | 29 +++++++++++++++++++++++++++++
>>>>   sound/soc/qcom/common.h         |  3 +++
>>>>   sound/soc/qcom/qdsp6/topology.c | 26 ++++++++++++++++++++++++++
>>>>   sound/soc/qcom/sc8280xp.c       | 14 ++++++++++++++
>>>>   sound/soc/qcom/sm8250.c         |  4 ++--
>>>>   5 files changed, 74 insertions(+), 2 deletions(-)
>>>>
>>>
>>> Hi Srini,
>>>
>>> I tested this series on SM8550 with tplg in [1] and ucm in [2]. But 
>>> the kernel output errors attached below. Headphone does work properly 
>>> without DisplayPort in the ucm.
>>>
>>> What could be the possible cause of this? Is there any significant 
>>> change from sc8280xp to sm8550?
>>>
>>> -- 
>>> Thanks,
>>> Xilin Wu
>>>
>>> [1] 
>>> https://github.com/edk2-porting/audioreach-topology/blob/sakuramist/QCS8550-AYN-ODIN2.m4
>>> [2] 

For sm8550 you would need this patch for tplg

https://git.codelinaro.org/krzysztof.kozlowski/audioreach-topology/-/commit/d8ef47bc85700a7cdfabee5e06808d9f359b0a26

can you try this as the Container CAP Id changed for platforms from sm8550.

Kryzstof verified Display port tplg and these patches on x1e80100.


thanks,
srini

>>> https://github.com/strongtz/alsa-ucm-conf/blob/odin2/ucm2/Qualcomm/sm8550/HiFi.conf
>>>
>>> [ 1552.313713] qcom-apm gprsvc:service:2:1: Error (1) Processing 
>>> 0x01001000 cmd
>>> [ 1552.313730] qcom-apm gprsvc:service:2:1: DSP returned 
>>> error[1001000] 1
>>> [ 1552.314455] qcom-apm gprsvc:service:2:1: Error (1) Processing 
>>
>> Is the DP cable connected?
> 
> I'm sure that the cable is connected and I have desktop on external 
> display.
> If it's not connected, kernel gives the following error when using aplay:
> 
> hdmi-audio-codec hdmi-audio-codec.1.auto: ASoC: error at 
> snd_soc_dai_hw_params on i2s-hifi: -22
> 
>>
>> if its not connected the dsp will throw this error.
>>
>> due to this issue I did workaround this issue by modeling it as 
>> conflicting device to Speaker in x13s ucm.
>>
>> I see in your ucm setup its not the case.
>> which is why you might be hitting this issue.
>>
>> Can you try
>> amixer -c 0 cset iface=MIXER,name='DISPLAY_PORT_RX_0 Audio Mixer 
>> MultiMedia2' 1
>> aplay -D plughw:0,1 some-wav-file.wav
>>
>> both with and without display connected.
>>
> 
> aplay always gives the following error:
> 
> Playing WAVE 'Summer.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, 
> Stereo
> aplay: set_params:1456: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  S16_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: 16
> FRAME_BITS: 32
> CHANNELS: 2
> RATE: 44100
> PERIOD_TIME: (42666 42667)
> PERIOD_SIZE: (1881 1882)
> PERIOD_BYTES: (7524 7528)
> PERIODS: (3 5)
> BUFFER_TIME: (170657 170658)
> BUFFER_SIZE: 7526
> BUFFER_BYTES: 30104
> TICK_TIME: 0
> 
> and kernel gives the following when display is connected:
> 
> [drm:dp_catalog_audio_config_sdp] sdp_cfg = 0x100066
> [drm:dp_catalog_audio_config_sdp] sdp_cfg2 = 0x1b800004
> [drm:dp_audio_hw_params] Header Byte 1: value = 0xce020000, parity_byte 
> = 0xce
> [drm:dp_audio_hw_params] Header Byte 2: value = 0x67010000, parity_byte 
> = 0x0
> [drm:dp_audio_hw_params] Header Byte 3: value = 0x67010000, parity_byte 
> = 0x67
> [drm:dp_audio_hw_params] Header Byte 1: value = 0x67010000, parity_byte 
> = 0x67
> [drm:dp_audio_hw_params] Header Byte 2: value = 0x33443517, parity_byte 
> = 0x35
> [drm:dp_audio_hw_params] Header Byte 3: value = 0x33443517, parity_byte 
> = 0x33
> [drm:dp_audio_hw_params] Header Byte 1: value = 0x84840000, parity_byte 
> = 0x84
> [drm:dp_audio_hw_params] Header Byte 2: value = 0x3344d71b, parity_byte 
> = 0xd7
> [drm:dp_audio_hw_params] Header Byte 3: value = 0x44, parity_byte = 0x33
> [drm:dp_audio_hw_params] Header Byte 1: value = 0xd8050000, parity_byte 
> = 0xd8
> [drm:dp_audio_hw_params] Header Byte 2: value = 0x4b0f, parity_byte = 0x4b
> [drm:dp_audio_hw_params] Header Byte 3: value = 0x4b0f, parity_byte = 0x0
> [drm:dp_audio_hw_params] Header Byte 1: value = 0x71060000, parity_byte 
> = 0x71
> [drm:dp_audio_hw_params] Header Byte 2: value = 0x4b0f, parity_byte = 0x4b
> [drm:dp_catalog_audio_config_acr] select: 0x3, acr_ctrl: 0x80004130
> [drm:dp_catalog_audio_sfe_level] mainlink_level = 0xa08, 
> safe_to_exit_level = 0x8
> [drm:dp_catalog_audio_enable] dp_audio_cfg = 0xc1
> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001006 cmd
> qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001006 cmd
> qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001001 cmd
> qcom-apm gprsvc:service:2:1: DSP returned error[1001001] 1
> q6apm-lpass-dais 30000000.remoteproc:glink-edge:gpr:service@1:bedais: 
> Failed to prepare Graph -22
> q6apm-lpass-dais 30000000.remoteproc:glink-edge:gpr:service@1:bedais: 
> ASoC: error at snd_soc_pcm_dai_prepare on DISPLAY_PORT_RX_0: -22
> [drm:dp_catalog_audio_enable] dp_audio_cfg = 0xc0
> 
>>
>> --srini
>>
>>
>>
>>> 0x01001006 cmd
>>> [ 1552.314463] qcom-apm gprsvc:service:2:1: DSP returned 
>>> error[1001006] 1
>>> [ 1552.315496] qcom-apm gprsvc:service:2:1: Error (1) Processing 
>>> 0x01001006 cmd
>>> [ 1552.315506] qcom-apm gprsvc:service:2:1: DSP returned 
>>> error[1001006] 1
>>> [ 1552.316033] qcom-apm gprsvc:service:2:1: Error (1) Processing 
>>> 0x01001001 cmd
>>> [ 1552.316042] qcom-apm gprsvc:service:2:1: DSP returned 
>>> error[1001001] 1
>>> [ 1552.316045] q6apm-lpass-dais 
>>> 30000000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to 
>>> prepare Graph -22
>>> [ 1552.316047] q6apm-lpass-dais 
>>> 30000000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC: error at 
>>> snd_soc_pcm_dai_prepare on DISPLAY_PORT_RX_0: -22
> 

