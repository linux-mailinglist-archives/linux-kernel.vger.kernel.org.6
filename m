Return-Path: <linux-kernel+bounces-188701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536548CE580
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E711F21721
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE928627C;
	Fri, 24 May 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9Jv7Rk6"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1985640
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555034; cv=none; b=N0zXq9c619BiDvOIASaRWeRK5qI+nr2byeKj/ue4RUhqSpFb8xSKx6ebyUnWExJALaEO1G7Rv1a29afNvNSErLZXBfxlUh5EaIc//EdFpjtrqoVpGEdwEhWAAxyV4gQ3g4G2mOyxMr3XzwN1+FmvKw/7l2RDcICEN/JKETygrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555034; c=relaxed/simple;
	bh=eDQamOWoYYuEXUmhcnkWpL4VqjxwVBduLj3lV779nKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRJLjVlgQjL3H2PuFUo/ZRAozRB6lufWCBJaVNprCd9BHTASocM0RfoaDLS6NbPIefDLHHfZ9ygbTu9Vz4OEkTK5kpBu0nfLdwgcDuakq9REdC37KaDT0Rh7fNl6UJNKtaExPAyBrK0JPsRM1bkCpVAMkGyUtcrO3c97luAITw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y9Jv7Rk6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6265d3ccbdso78270566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716555031; x=1717159831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVhdVIXzrZrH2rtYxzShcwZuJrIsOZ0s1vaYMg0zfDg=;
        b=Y9Jv7Rk6DCqqL1LheOJHGpXE9ftpiYXtSNPpKqyimAraC0jocGvYwEeUHF0Btzr8AJ
         TpKQmsidod/shHfuYP4IZS5Epu/lv17tTpwsxb6cOX90gIha4CWjbX2ywqKyxA952aE7
         TUKDkqRbq196eET5uO4a7JUuGVK6NYzZnc0IsyVi+OKXU53hXEsN3+rn9ZufrIk+sUFv
         MzADraOomI4OGitT5ZmhQyO9U5iUzXWXpnadPULi8vKZHDtnMlOHoFGC2NuR86EeALru
         yTz8uLKTa1TMiyaiDqOtj4Ipq/Y5/0KuzutasicmaFCkkOutEY1WsjZNFk1G4WrsPVkA
         ySHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716555031; x=1717159831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVhdVIXzrZrH2rtYxzShcwZuJrIsOZ0s1vaYMg0zfDg=;
        b=FeB1Anlc5375FYe3CCYC1RSCdKeRhrgBohKNu8vn6bFC86cbcuvR2Nazc0RKKCVM6H
         +XH4d4gOQacP/PZsWZIBlK1rJLrNUlz3ibaC/noJkn4k3l2WR8YTt4fcfp+SEjiOUHj/
         jtx4fPxj6jO35ZuitA4ZsOESdUavgK+8J80MP8Q2jgWGPldENszU4WUDBlFB6rl4l3ib
         jUP0W5Lwv9hrbfbf0iavkn0XM4UR8jnfdnrKcavmUAQ0QcnqEn5/FLYRqCV8LsvJ3s0f
         QXT+SHSS6z67MAgUCVDgvq5P5tky8RS6gs4IJtVz5PCD9USOdpubHw4j+HReF2HpHg0q
         0zXw==
X-Forwarded-Encrypted: i=1; AJvYcCXG4w+fkYXZ4oek16AJKouqMKj730MR8zbFDPMr8PQBVRdTS7oPCpUKP2zwS+jAJtbQx9ZDBD7IjUlSYgCXsEb6EnDXT+JTKKtfBuMY
X-Gm-Message-State: AOJu0YwmjxsntL7LxWnLauC0VzA1cCl2++mnuVMOuKGw4I+sj3T825hw
	rQzraQCv9B/VBO4/t8qUp47Ddxa+0bSH4oGYCZjRoTmj5MbzyI5H518I6mH+MEo=
X-Google-Smtp-Source: AGHT+IFpUY4zjxxZhQ4WmxohR/RqzsfJWJIcqAFeDsf1BhikFV0aBErJ2LAdMU88HyK8cXfon3fzeg==
X-Received: by 2002:a17:906:3c13:b0:a59:c9ad:bd26 with SMTP id a640c23a62f3a-a62641b32a8mr141937066b.12.1716555030604;
        Fri, 24 May 2024 05:50:30 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a626cc4ff19sm128293766b.121.2024.05.24.05.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 05:50:29 -0700 (PDT)
Message-ID: <44fad635-1b17-47bc-97f0-9a541e0b4f35@linaro.org>
Date: Fri, 24 May 2024 13:50:28 +0100
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
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <dd14e3ff-3ff7-426e-88e0-b16a49eafaf0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Xilin,

On 23/05/2024 05:09, Xilin Wu wrote:
>>
>> Srinivas Kandagatla (4):
>>    ASoC: qcom: q6dsp: parse Display port tokens
>>    ASoC: qcom: common: add Display port Jack function
>>    ASoC: qcom: sc8280xp: add Display port Jack
>>    ASoC: qcom: sm8250: fix a typo in function name
>>
>>   sound/soc/qcom/common.c         | 29 +++++++++++++++++++++++++++++
>>   sound/soc/qcom/common.h         |  3 +++
>>   sound/soc/qcom/qdsp6/topology.c | 26 ++++++++++++++++++++++++++
>>   sound/soc/qcom/sc8280xp.c       | 14 ++++++++++++++
>>   sound/soc/qcom/sm8250.c         |  4 ++--
>>   5 files changed, 74 insertions(+), 2 deletions(-)
>>
> 
> Hi Srini,
> 
> I tested this series on SM8550 with tplg in [1] and ucm in [2]. But the 
> kernel output errors attached below. Headphone does work properly 
> without DisplayPort in the ucm.
> 
> What could be the possible cause of this? Is there any significant 
> change from sc8280xp to sm8550?
> 
> -- 
> Thanks,
> Xilin Wu
> 
> [1] 
> https://github.com/edk2-porting/audioreach-topology/blob/sakuramist/QCS8550-AYN-ODIN2.m4
> [2] 
> https://github.com/strongtz/alsa-ucm-conf/blob/odin2/ucm2/Qualcomm/sm8550/HiFi.conf
> 
> [ 1552.313713] qcom-apm gprsvc:service:2:1: Error (1) Processing 
> 0x01001000 cmd
> [ 1552.313730] qcom-apm gprsvc:service:2:1: DSP returned error[1001000] 1
> [ 1552.314455] qcom-apm gprsvc:service:2:1: Error (1) Processing 

Is the DP cable connected?

if its not connected the dsp will throw this error.

due to this issue I did workaround this issue by modeling it as 
conflicting device to Speaker in x13s ucm.

I see in your ucm setup its not the case.
which is why you might be hitting this issue.

Can you try
amixer -c 0 cset iface=MIXER,name='DISPLAY_PORT_RX_0 Audio Mixer 
MultiMedia2' 1
aplay -D plughw:0,1 some-wav-file.wav

both with and without display connected.


--srini



> 0x01001006 cmd
> [ 1552.314463] qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
> [ 1552.315496] qcom-apm gprsvc:service:2:1: Error (1) Processing 
> 0x01001006 cmd
> [ 1552.315506] qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
> [ 1552.316033] qcom-apm gprsvc:service:2:1: Error (1) Processing 
> 0x01001001 cmd
> [ 1552.316042] qcom-apm gprsvc:service:2:1: DSP returned error[1001001] 1
> [ 1552.316045] q6apm-lpass-dais 
> 30000000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to prepare 
> Graph -22
> [ 1552.316047] q6apm-lpass-dais 
> 30000000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC: error at 
> snd_soc_pcm_dai_prepare on DISPLAY_PORT_RX_0: -22

