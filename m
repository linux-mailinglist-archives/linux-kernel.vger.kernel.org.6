Return-Path: <linux-kernel+bounces-189299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18C58CEE1E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 09:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AD628208D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 07:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE827FBED;
	Sat, 25 May 2024 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jefBiLAS"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60316BE4B
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716621158; cv=none; b=du/96lWbFR/cv6Bi8wcw/Tqr8oTyvPbeYviVm4DFxIhyYsqVz0m6LUS8LikuQbB9rhHHjrWI6o2M+7nfcUGEZnRNoSKgcI6A74B86OnBhLsRDfQkZp47mMjJJeMCLlZKKaH2pd8Mn+8+lEhOdvtdn7DKL95ul3YupVbRY8INNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716621158; c=relaxed/simple;
	bh=HHYNBzmrY3K2RD7J4rY+nMkppxrdSNNVabRkntKVknE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIwbGSBmcSzfTH5VODnM2WE80H3LWZJWe6dEjH6CdtgQHXtzNEGq28LuBb///pFg39nvK06I7vmbYYKp5BoXuAjKWpr9dqtlvySfBxmcsBOVRnqpbX8YGTnKVPHjpbYy61tsYBgNakEIuY0tOeAPjGINr7LFXygA5dwZEkadbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jefBiLAS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f44b45d6abso14084395ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 00:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716621156; x=1717225956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fb2z3nmHoMhzHbgUsiZMAh19uOQGG1aEzUpQJqiuJ1c=;
        b=jefBiLAShUXj6X8155SddhSTusfgkUttmtK3H8nH/c5q2mqd0JAcg7tcVaYwAOSFkY
         Z235KygaIP/uHzdceZImS1w2JzYKylevR3SCU/JCw5+evyj+vN9bdyQm+5Mw6Oft/7vG
         ReXnjfRKiNuCsxACYHbuxBGjEXODiJL/rxIqsDwRj8OTOl5FIKNZYwijCP49jbZSvH54
         apzMosVSoPkQALSLAUDB/PBT3iceOZhLdE+xcmHz3/BS1XIuuBfwu1TJjRT9dAgkR/NW
         WAlcX57IBPh5I7dqs0/WwhIvzAC4+/j1quGwDhr8R1uBiow4aAheX390XB1Ws69FVE/1
         FX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716621156; x=1717225956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fb2z3nmHoMhzHbgUsiZMAh19uOQGG1aEzUpQJqiuJ1c=;
        b=TOpq2OLBoCWnWPByyZfdbYs5LLXTpMsQVdl88OI9JDEIKCp+E2uj0pFQII3azJQh3n
         jAikVwyNKCCmiF/KrfObj3i1u5HsnNQLGgeNczl/ypHUB58UOzQ5n9/CsMlWdyoxN4yS
         72AMDWcm10aC0CKvQbaT6gIdaJsnCKL5SRQCwYD1Bhq5r1rhqnOKv870DF+Q4Ur5FhBN
         qIPxMkNbhUjZnyJ6Yr1Yrr1D3ie5L32yzkjk0u5pCesiAcXFT0wDhywwVynHgNxSnGgC
         1ZHjyOszGIYwxFW3RXCk/cNzdpVwOGehkS2+FS+dY8U4yxmHRfVKgzFgOT41jff47pSM
         I6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7jcjjXqERUtltWGq7mUM5Fag+P3dxPTLqzR908T12zWGjfHDXl2KFcHWB5CIKdDp0syAexSC5lTBqXV5p31M8di/18RRkA9QAoURl
X-Gm-Message-State: AOJu0Yx3o9Z2Vv9q9GG7HOpbGDmyoRW3oAPGPJodFI6dHAjBSHQOWMk9
	ewaACd7sj8Tyy94QJV4i+wjXcDQ4gdwob3Y+heC2M1qQZzqILxV2
X-Google-Smtp-Source: AGHT+IFbaXJCkb9zPhfRLTDH3PBTlrYqdvihr2qHgl4nG35A3rX48ISCmRk98SKFBDWl5zW+G4fv0A==
X-Received: by 2002:a17:902:e5c5:b0:1f4:4d6c:e381 with SMTP id d9443c01a7336-1f44d6ce61bmr43987875ad.29.1716621156285;
        Sat, 25 May 2024 00:12:36 -0700 (PDT)
Received: from [0.0.0.0] (42-3-109-144.ptr.netvigator.com. [42.3.109.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9a6fd0sm24441095ad.226.2024.05.25.00.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 00:12:35 -0700 (PDT)
Message-ID: <21f0f2ac-dada-4e19-a0df-086021320101@gmail.com>
Date: Sat, 25 May 2024 15:12:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ASoC: qcom: display port changes
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <dd14e3ff-3ff7-426e-88e0-b16a49eafaf0@gmail.com>
 <44fad635-1b17-47bc-97f0-9a541e0b4f35@linaro.org>
Content-Language: en-US
From: Xilin Wu <wuxilin123@gmail.com>
In-Reply-To: <44fad635-1b17-47bc-97f0-9a541e0b4f35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Srini,

On 2024/5/24 20:50, Srinivas Kandagatla wrote:
> Hi Xilin,
> 
> On 23/05/2024 05:09, Xilin Wu wrote:
>>>
>>> Srinivas Kandagatla (4):
>>>    ASoC: qcom: q6dsp: parse Display port tokens
>>>    ASoC: qcom: common: add Display port Jack function
>>>    ASoC: qcom: sc8280xp: add Display port Jack
>>>    ASoC: qcom: sm8250: fix a typo in function name
>>>
>>>   sound/soc/qcom/common.c         | 29 +++++++++++++++++++++++++++++
>>>   sound/soc/qcom/common.h         |  3 +++
>>>   sound/soc/qcom/qdsp6/topology.c | 26 ++++++++++++++++++++++++++
>>>   sound/soc/qcom/sc8280xp.c       | 14 ++++++++++++++
>>>   sound/soc/qcom/sm8250.c         |  4 ++--
>>>   5 files changed, 74 insertions(+), 2 deletions(-)
>>>
>>
>> Hi Srini,
>>
>> I tested this series on SM8550 with tplg in [1] and ucm in [2]. But 
>> the kernel output errors attached below. Headphone does work properly 
>> without DisplayPort in the ucm.
>>
>> What could be the possible cause of this? Is there any significant 
>> change from sc8280xp to sm8550?
>>
>> -- 
>> Thanks,
>> Xilin Wu
>>
>> [1] 
>> https://github.com/edk2-porting/audioreach-topology/blob/sakuramist/QCS8550-AYN-ODIN2.m4
>> [2] 
>> https://github.com/strongtz/alsa-ucm-conf/blob/odin2/ucm2/Qualcomm/sm8550/HiFi.conf
>>
>> [ 1552.313713] qcom-apm gprsvc:service:2:1: Error (1) Processing 
>> 0x01001000 cmd
>> [ 1552.313730] qcom-apm gprsvc:service:2:1: DSP returned error[1001000] 1
>> [ 1552.314455] qcom-apm gprsvc:service:2:1: Error (1) Processing 
> 
> Is the DP cable connected?

I'm sure that the cable is connected and I have desktop on external display.
If it's not connected, kernel gives the following error when using aplay:

hdmi-audio-codec hdmi-audio-codec.1.auto: ASoC: error at 
snd_soc_dai_hw_params on i2s-hifi: -22

> 
> if its not connected the dsp will throw this error.
> 
> due to this issue I did workaround this issue by modeling it as 
> conflicting device to Speaker in x13s ucm.
> 
> I see in your ucm setup its not the case.
> which is why you might be hitting this issue.
> 
> Can you try
> amixer -c 0 cset iface=MIXER,name='DISPLAY_PORT_RX_0 Audio Mixer 
> MultiMedia2' 1
> aplay -D plughw:0,1 some-wav-file.wav
> 
> both with and without display connected.
> 

aplay always gives the following error:

Playing WAVE 'Summer.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, 
Stereo
aplay: set_params:1456: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (42666 42667)
PERIOD_SIZE: (1881 1882)
PERIOD_BYTES: (7524 7528)
PERIODS: (3 5)
BUFFER_TIME: (170657 170658)
BUFFER_SIZE: 7526
BUFFER_BYTES: 30104
TICK_TIME: 0

and kernel gives the following when display is connected:

[drm:dp_catalog_audio_config_sdp] sdp_cfg = 0x100066
[drm:dp_catalog_audio_config_sdp] sdp_cfg2 = 0x1b800004
[drm:dp_audio_hw_params] Header Byte 1: value = 0xce020000, parity_byte 
= 0xce
[drm:dp_audio_hw_params] Header Byte 2: value = 0x67010000, parity_byte 
= 0x0
[drm:dp_audio_hw_params] Header Byte 3: value = 0x67010000, parity_byte 
= 0x67
[drm:dp_audio_hw_params] Header Byte 1: value = 0x67010000, parity_byte 
= 0x67
[drm:dp_audio_hw_params] Header Byte 2: value = 0x33443517, parity_byte 
= 0x35
[drm:dp_audio_hw_params] Header Byte 3: value = 0x33443517, parity_byte 
= 0x33
[drm:dp_audio_hw_params] Header Byte 1: value = 0x84840000, parity_byte 
= 0x84
[drm:dp_audio_hw_params] Header Byte 2: value = 0x3344d71b, parity_byte 
= 0xd7
[drm:dp_audio_hw_params] Header Byte 3: value = 0x44, parity_byte = 0x33
[drm:dp_audio_hw_params] Header Byte 1: value = 0xd8050000, parity_byte 
= 0xd8
[drm:dp_audio_hw_params] Header Byte 2: value = 0x4b0f, parity_byte = 0x4b
[drm:dp_audio_hw_params] Header Byte 3: value = 0x4b0f, parity_byte = 0x0
[drm:dp_audio_hw_params] Header Byte 1: value = 0x71060000, parity_byte 
= 0x71
[drm:dp_audio_hw_params] Header Byte 2: value = 0x4b0f, parity_byte = 0x4b
[drm:dp_catalog_audio_config_acr] select: 0x3, acr_ctrl: 0x80004130
[drm:dp_catalog_audio_sfe_level] mainlink_level = 0xa08, 
safe_to_exit_level = 0x8
[drm:dp_catalog_audio_enable] dp_audio_cfg = 0xc1
qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001006 cmd
qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001006 cmd
qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001001 cmd
qcom-apm gprsvc:service:2:1: DSP returned error[1001001] 1
q6apm-lpass-dais 30000000.remoteproc:glink-edge:gpr:service@1:bedais: 
Failed to prepare Graph -22
q6apm-lpass-dais 30000000.remoteproc:glink-edge:gpr:service@1:bedais: 
ASoC: error at snd_soc_pcm_dai_prepare on DISPLAY_PORT_RX_0: -22
[drm:dp_catalog_audio_enable] dp_audio_cfg = 0xc0

> 
> --srini
> 
> 
> 
>> 0x01001006 cmd
>> [ 1552.314463] qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
>> [ 1552.315496] qcom-apm gprsvc:service:2:1: Error (1) Processing 
>> 0x01001006 cmd
>> [ 1552.315506] qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
>> [ 1552.316033] qcom-apm gprsvc:service:2:1: Error (1) Processing 
>> 0x01001001 cmd
>> [ 1552.316042] qcom-apm gprsvc:service:2:1: DSP returned error[1001001] 1
>> [ 1552.316045] q6apm-lpass-dais 
>> 30000000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to prepare 
>> Graph -22
>> [ 1552.316047] q6apm-lpass-dais 
>> 30000000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC: error at 
>> snd_soc_pcm_dai_prepare on DISPLAY_PORT_RX_0: -22

-- 
Thanks,
Xilin Wu


