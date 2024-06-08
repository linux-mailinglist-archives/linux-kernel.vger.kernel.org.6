Return-Path: <linux-kernel+bounces-207020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665DC901159
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 13:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D33281E61
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4BB178380;
	Sat,  8 Jun 2024 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LejN+UCE"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76FD178367
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717846882; cv=none; b=OBD4VytGSd5Cpr1aHVC+jYkMlCO7b4p1oAiOd7X3cbZzwvE2YACAjSDsXm1iKF7xH/SKdKwgArrlRsEjUwgnsoIGoZVf5ODXmH9mjPihJrWuhwxkFwHXHo/Ul2l6HSvazVPTOdEj9tl1ZSOHKd2g0QExSZhmx4LI3f5Uef/PMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717846882; c=relaxed/simple;
	bh=ZDzevxG3p1PqajLdPO9rj9x79cWcafrQbVIEjOXaDLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrSil8k4thsCDb/Q3twOL1SI05X4bTxY1w+HJLd6O0NLEPodtX7YVNOpzZxkT3OpljScw3USgvgNgEH4vg5mvtX+S4X7wYG7Zp0stzgHoxPBx59h0Y5SYlXbcRtQyKZ5YeNoBQvMp+e4A6cNUgVf20kDov9tkWXCuyZsZJPXfNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LejN+UCE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7042882e741so201845b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 04:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717846880; x=1718451680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/IaPEx8THKFazkq+Jntb4fKptpgwwLkbk20yuBqCWA=;
        b=LejN+UCEkM3574qlfFPtqbst51dXZOeXcpM6Ya3Byj6cj2r2eP/POgUIfPCrInFuP3
         0Foz2+0PgmQLNsdDAoMSMFHj4qexI0RUJyd7biu8+VO7iHSmRssyGJYywgSYEg/fa+Wx
         gLpK7WN9pA6NCl8dLzP2rsdKcpjOYwj7wcx/O52oX9xdOC8TizYZLEAp6m+VZSzW6yZT
         42jiTnAUl04sHE65vL5BICpWR8NDIrV0ju6rO6aM1BoMW/6GiTiZxFbF9lL0u/wkJziS
         GP9uPgvDgwBYaKY6mW8/J6muJBSE/E0YOrzPm+gHCyDITX2mIyTRdGpWDiKGb6KbKz6l
         +CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717846880; x=1718451680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/IaPEx8THKFazkq+Jntb4fKptpgwwLkbk20yuBqCWA=;
        b=Qd8rJnVmgWlkbXyK0cMKvm1V0+fI6Lhn4XocWuDWRFxkxsID1XrzCq4BtYgi3dEr+w
         ko3M62g+OetcKIyZdffYIGhjdKFkiRQgS8+r0nsisATcfUC9YoUu7tXqEAqmNalTBBvr
         1fLqu4h+1AUk1/JRdYcXLNBUYQzZTU4KW4jTEXyz3GSKYOrAQSFqf8O1xg/YJD9wguA6
         QVGZ9MNwlTog8LmSZ7qSqktyNtDxeknb3tJuA7abKQouBQM6jsixZqAa1L6T85iLVKWt
         VSnIscD1imIANO6pX8aa3v+maRbinNEFQxJkqSrq3uXAwTFoyJ/s8lKri1z9/JzyKql7
         2zjg==
X-Forwarded-Encrypted: i=1; AJvYcCW9MN1BdOx7QcZc+u0QW3Jh52yNrtd3MPfn/0aExFDmlDkX9MTBNqZt5a8qfZdSI74DF1tPCGZ76X3ZhEgaIqcrYqWbzKSYsHY3S8ms
X-Gm-Message-State: AOJu0Ywui+xnXiTh0Ro8NtXHhsEcun9uMjbvFV2dzgx8iYwG+3BQfHvX
	9pDlvhv1nmrLXsZ3wmtnztnPMDEw7Rsd7N5IDjdygyiKGYibBBjh
X-Google-Smtp-Source: AGHT+IFy4uYbq+b9zg+egzGM+zx7amaxjPJ7tGj+JJKGq1hmx8PxHRVeEmei1GW/HLhjmBwNMStpiw==
X-Received: by 2002:a05:6a00:1823:b0:704:3113:f71f with SMTP id d2e1a72fcca58-7043113ff29mr50851b3a.26.1717846879260;
        Sat, 08 Jun 2024 04:41:19 -0700 (PDT)
Received: from [192.168.0.171] ([223.166.28.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd371f7esm3903211b3a.25.2024.06.08.04.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 04:41:18 -0700 (PDT)
Message-ID: <2ac09106-36df-4e03-94c3-42c7ec9f20f3@gmail.com>
Date: Sat, 8 Jun 2024 19:41:11 +0800
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
 <21f0f2ac-dada-4e19-a0df-086021320101@gmail.com>
 <11803812-56cd-48d0-a0fc-8ca99d6f79d5@linaro.org>
Content-Language: en-US
From: Xilin Wu <wuxilin123@gmail.com>
In-Reply-To: <11803812-56cd-48d0-a0fc-8ca99d6f79d5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/6 17:18, Srinivas Kandagatla wrote:
> Hi Xilin
> 
> On 25/05/2024 08:12, Xilin Wu wrote:
>> Hi Srini,
>>
>> On 2024/5/24 20:50, Srinivas Kandagatla wrote:
>>> Hi Xilin,
>>>
>>> On 23/05/2024 05:09, Xilin Wu wrote:
>>>>>
>>>>> Srinivas Kandagatla (4):
>>>>>    ASoC: qcom: q6dsp: parse Display port tokens
>>>>>    ASoC: qcom: common: add Display port Jack function
>>>>>    ASoC: qcom: sc8280xp: add Display port Jack
>>>>>    ASoC: qcom: sm8250: fix a typo in function name
>>>>>
>>>>>   sound/soc/qcom/common.c         | 29 +++++++++++++++++++++++++++++
>>>>>   sound/soc/qcom/common.h         |  3 +++
>>>>>   sound/soc/qcom/qdsp6/topology.c | 26 ++++++++++++++++++++++++++
>>>>>   sound/soc/qcom/sc8280xp.c       | 14 ++++++++++++++
>>>>>   sound/soc/qcom/sm8250.c         |  4 ++--
>>>>>   5 files changed, 74 insertions(+), 2 deletions(-)
>>>>>
>>>>
>>>> Hi Srini,
>>>>
>>>> I tested this series on SM8550 with tplg in [1] and ucm in [2]. But 
>>>> the kernel output errors attached below. Headphone does work 
>>>> properly without DisplayPort in the ucm.
>>>>
>>>> What could be the possible cause of this? Is there any significant 
>>>> change from sc8280xp to sm8550?
>>>>
>>>> -- 
>>>> Thanks,
>>>> Xilin Wu
>>>>
>>>> [1] 
>>>> https://github.com/edk2-porting/audioreach-topology/blob/sakuramist/QCS8550-AYN-ODIN2.m4
>>>> [2] 
> 
> For sm8550 you would need this patch for tplg
> 
> https://git.codelinaro.org/krzysztof.kozlowski/audioreach-topology/-/commit/d8ef47bc85700a7cdfabee5e06808d9f359b0a26
> 
> can you try this as the Container CAP Id changed for platforms from sm8550.
> 
> Kryzstof verified Display port tplg and these patches on x1e80100.
> 

That exactly solved the previous problem, thanks!

Hot-unplugging type-c caused `fail to close APM port` error, and DP 
audio will no longer work after that. But I guess that would be another 
issue anyway :)

-- 
Thanks,
Xilin Wu

> 
> thanks,
> srini
> 
>>>> https://github.com/strongtz/alsa-ucm-conf/blob/odin2/ucm2/Qualcomm/sm8550/HiFi.conf
>>>>
>>>> [ 1552.313713] qcom-apm gprsvc:service:2:1: Error (1) Processing 
>>>> 0x01001000 cmd
>>>> [ 1552.313730] qcom-apm gprsvc:service:2:1: DSP returned 
>>>> error[1001000] 1
>>>> [ 1552.314455] qcom-apm gprsvc:service:2:1: Error (1) Processing 
>>>
>>> Is the DP cable connected?
>>
>> I'm sure that the cable is connected and I have desktop on external 
>> display.
>> If it's not connected, kernel gives the following error when using aplay:
>>
>> hdmi-audio-codec hdmi-audio-codec.1.auto: ASoC: error at 
>> snd_soc_dai_hw_params on i2s-hifi: -22
>>
>>>
>>> if its not connected the dsp will throw this error.
>>>
>>> due to this issue I did workaround this issue by modeling it as 
>>> conflicting device to Speaker in x13s ucm.
>>>
>>> I see in your ucm setup its not the case.
>>> which is why you might be hitting this issue.
>>>
>>> Can you try
>>> amixer -c 0 cset iface=MIXER,name='DISPLAY_PORT_RX_0 Audio Mixer 
>>> MultiMedia2' 1
>>> aplay -D plughw:0,1 some-wav-file.wav
>>>
>>> both with and without display connected.
>>>
>>
>> aplay always gives the following error:
>>
>> Playing WAVE 'Summer.wav' : Signed 16 bit Little Endian, Rate 44100 
>> Hz, Stereo
>> aplay: set_params:1456: Unable to install hw params:
>> ACCESS:  RW_INTERLEAVED
>> FORMAT:  S16_LE
>> SUBFORMAT:  STD
>> SAMPLE_BITS: 16
>> FRAME_BITS: 32
>> CHANNELS: 2
>> RATE: 44100
>> PERIOD_TIME: (42666 42667)
>> PERIOD_SIZE: (1881 1882)
>> PERIOD_BYTES: (7524 7528)
>> PERIODS: (3 5)
>> BUFFER_TIME: (170657 170658)
>> BUFFER_SIZE: 7526
>> BUFFER_BYTES: 30104
>> TICK_TIME: 0
>>
>> and kernel gives the following when display is connected:
>>
>> [drm:dp_catalog_audio_config_sdp] sdp_cfg = 0x100066
>> [drm:dp_catalog_audio_config_sdp] sdp_cfg2 = 0x1b800004
>> [drm:dp_audio_hw_params] Header Byte 1: value = 0xce020000, 
>> parity_byte = 0xce
>> [drm:dp_audio_hw_params] Header Byte 2: value = 0x67010000, 
>> parity_byte = 0x0
>> [drm:dp_audio_hw_params] Header Byte 3: value = 0x67010000, 
>> parity_byte = 0x67
>> [drm:dp_audio_hw_params] Header Byte 1: value = 0x67010000, 
>> parity_byte = 0x67
>> [drm:dp_audio_hw_params] Header Byte 2: value = 0x33443517, 
>> parity_byte = 0x35
>> [drm:dp_audio_hw_params] Header Byte 3: value = 0x33443517, 
>> parity_byte = 0x33
>> [drm:dp_audio_hw_params] Header Byte 1: value = 0x84840000, 
>> parity_byte = 0x84
>> [drm:dp_audio_hw_params] Header Byte 2: value = 0x3344d71b, 
>> parity_byte = 0xd7
>> [drm:dp_audio_hw_params] Header Byte 3: value = 0x44, parity_byte = 0x33
>> [drm:dp_audio_hw_params] Header Byte 1: value = 0xd8050000, 
>> parity_byte = 0xd8
>> [drm:dp_audio_hw_params] Header Byte 2: value = 0x4b0f, parity_byte = 
>> 0x4b
>> [drm:dp_audio_hw_params] Header Byte 3: value = 0x4b0f, parity_byte = 0x0
>> [drm:dp_audio_hw_params] Header Byte 1: value = 0x71060000, 
>> parity_byte = 0x71
>> [drm:dp_audio_hw_params] Header Byte 2: value = 0x4b0f, parity_byte = 
>> 0x4b
>> [drm:dp_catalog_audio_config_acr] select: 0x3, acr_ctrl: 0x80004130
>> [drm:dp_catalog_audio_sfe_level] mainlink_level = 0xa08, 
>> safe_to_exit_level = 0x8
>> [drm:dp_catalog_audio_enable] dp_audio_cfg = 0xc1
>> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001006 cmd
>> qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
>> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001006 cmd
>> qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
>> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001001 cmd
>> qcom-apm gprsvc:service:2:1: DSP returned error[1001001] 1
>> q6apm-lpass-dais 30000000.remoteproc:glink-edge:gpr:service@1:bedais: 
>> Failed to prepare Graph -22
>> q6apm-lpass-dais 30000000.remoteproc:glink-edge:gpr:service@1:bedais: 
>> ASoC: error at snd_soc_pcm_dai_prepare on DISPLAY_PORT_RX_0: -22
>> [drm:dp_catalog_audio_enable] dp_audio_cfg = 0xc0
>>
>>>
>>> --srini
>>>
>>>
>>>
>>>> 0x01001006 cmd
>>>> [ 1552.314463] qcom-apm gprsvc:service:2:1: DSP returned 
>>>> error[1001006] 1
>>>> [ 1552.315496] qcom-apm gprsvc:service:2:1: Error (1) Processing 
>>>> 0x01001006 cmd
>>>> [ 1552.315506] qcom-apm gprsvc:service:2:1: DSP returned 
>>>> error[1001006] 1
>>>> [ 1552.316033] qcom-apm gprsvc:service:2:1: Error (1) Processing 
>>>> 0x01001001 cmd
>>>> [ 1552.316042] qcom-apm gprsvc:service:2:1: DSP returned 
>>>> error[1001001] 1
>>>> [ 1552.316045] q6apm-lpass-dais 
>>>> 30000000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to 
>>>> prepare Graph -22
>>>> [ 1552.316047] q6apm-lpass-dais 
>>>> 30000000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC: error at 
>>>> snd_soc_pcm_dai_prepare on DISPLAY_PORT_RX_0: -22
>>


