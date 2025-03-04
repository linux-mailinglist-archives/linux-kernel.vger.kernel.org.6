Return-Path: <linux-kernel+bounces-545140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1221A4E9AF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590968A6EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76087298CBF;
	Tue,  4 Mar 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SgJgYQu+"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3E298CB3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108346; cv=none; b=kf8HQSaUUpyPvwSvE6FhshP3e/ZEy7JyqgMOzLG/HiqWrVKETpzitSyL5WhNn+wWbBGsfRITmUZtaF6zfWZTEwivkjuhh/wktFLGV0ruD/INhiNdgIvWFX2tPWf3hXY+EMerKv/o88s9g+9DkeJn+JThtVEvE0cdYABbb7KNsuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108346; c=relaxed/simple;
	bh=tK7rBHUGh88Jv85U3Obnwi/LSusFZfvVT+DZtwysNBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYusDMs+01+C9vrcGBEE0t0UUJnXI81QAhpP6kH1X98ZXfr/F/5o+3rEckPLezhDWYvNdrptiAXpUAju+paD43ShrkKPM0j3HMUkA/pqnTexCFF3RmSF5HkqR6QLY202bEagrUG35lEDxs3CSqrpcYa5onA5eG5UbfbHOsYFwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SgJgYQu+; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e44fda56e3so55177976d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741108344; x=1741713144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=huCv0mb4ZOJJrK8J1aZdeB4j1q2c+FJIRS5JdUarnXk=;
        b=SgJgYQu+2UAm9iJIvCNO8UzFEzypayzj6iM3eEGAbcJKJAG44aIrwCfutRhnxKJB2m
         SvDXcT2ATCz9xBOnllCSE/6kGCsvi3uvKTMnen4cPV0939r1rt/joMkJ3QkQhyLOorPc
         5ewPuCrkbkgeFHFMrcUrjctpSNW2RlKuBA1gg6dyUHn+NEdnUR8WWb7lcfNAW8y5jQIP
         gE9bmHZBCGTnaX56Vk3lm2IugCyHLpDPp8KjJA7bMifR1MfQPY0kIpfh5hktFe/AvWAC
         0KqY4QxfuDYUm3fHtJPFt6mAK1Wox7oTy18Lstigv5/7sk+4VwJfi7HCVLzZVQJ4QQpC
         0gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108344; x=1741713144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huCv0mb4ZOJJrK8J1aZdeB4j1q2c+FJIRS5JdUarnXk=;
        b=AHe82czlQsAhnoloLIQP0Pk+Kpy5JdvpD9KahVkyqdjEvIi7gSrHZKYWSg9/1Hc/uU
         y1iuD24cupROyyOUJUbn42JS6JavgHEVOyX96CLeeomw/Tp61ByQ2NYrVGjcQ/YAEiOw
         jgr2c0sfBXsQnpTHWcUEtUG1s9oBPkmtYz6PY+DxTvrXcPwzYzk/XyJYmXzhEdd75VJz
         LsjwNLkTK6hDGUwW6cTDtKxZRFWo+S5UKlhJ/qTAbGx+hqA3HTb5Z+5HjORwHggmPeUi
         CM1zlYq5/Gj0rKZKOLupxKoEHz4dLuFzQQZbytbVJ/Z6AJ7aKSPLSVR6NEKtCzkHVyl1
         5bxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfDZ72Bp5MO9adTWYanXl6uuOwPBLVN7cSRWd0gq8sgnmdLvWQmIG3aKcUn5K0/yAgAfA3WJ07LkFOSa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRzfRN8nTDxnaGGfdExcHjge/kOqV6dJKtADVlRueVGpBIUC+p
	1x+MMSlOxNTG/Sh8V8TB0MLdncxzh20nR6Pjf42Cjz/1xse1gLAHFCvIr6bgShc=
X-Gm-Gg: ASbGncv76ObcLLyVTU5bcuchPkS9fkbZvW7f/rt54NOBV4h6VjdXg00tZ3PrVysJstp
	s26i79kyOdxgnIvAEvQ5diYRmmTvokRh25RJOR8KgZzGa+i/xdv6g8JUgMXGHtiWBoReWiNSp10
	TznAQd9Mc/4mKJ7cPEfslXikfVxMeP2w8KrwG+CmOFcCyLg/GcIEQXLVAbdQpwz6O+wiAXlihnt
	lNvgNaBIV9nqf2qD4Ll8ciyHmRU/rbbrZsoiHMR5Ojs7vIgUcpGRUp3qonc5syZY+tCCInlkBf4
	HdG3/k+A9z3N1/tBJTqYiEUu0pLDUFajEbL2q94JO6ppBWylWIQEtfO6wuKBmwM=
X-Google-Smtp-Source: AGHT+IHfPOMGCbV4hkPXelv9oZ/KI5jlSwi7fgElY8sgzLskKKZnKJpWwLFxwJldwCE+ZDN8gBZpKA==
X-Received: by 2002:ad4:5fc9:0:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6e8da892b1emr57409106d6.15.1741108344085;
        Tue, 04 Mar 2025 09:12:24 -0800 (PST)
Received: from [192.168.68.113] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6e8bf2c3ed0sm37973426d6.11.2025.03.04.09.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:12:23 -0800 (PST)
Message-ID: <5831d9b1-4a05-4a7b-8733-5050588b4e59@linaro.org>
Date: Tue, 4 Mar 2025 17:12:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] ASoC: q6apm: fix under runs and fragment sizes
To: Johan Hovold <johan@kernel.org>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmitry.baryshkov@linaro.org, johan+linaro@kernel.org
References: <20250304105723.10579-1-srinivas.kandagatla@linaro.org>
 <Z8cyt2n7qj4GkcJC@hovoldconsulting.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Z8cyt2n7qj4GkcJC@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/03/2025 17:04, Johan Hovold wrote:
> On Tue, Mar 04, 2025 at 10:57:17AM +0000, Srinivas Kandagatla wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> On Qualcomm Audioreach setup, some of the audio artifacts are seen in
>> both recording and playback. These patches fix issues by
>> 1. Adjusting the fragment size that dsp can service.
>> 2. schedule available playback buffers in time for dsp to not hit under runs
>> 3. remove some of the manual calculations done to get hardware pointer.
>>
>> With these patches, am able to see Audio quality improvements.
>>
>> Any testing would be appreciated.
> 
> This fixes the playback and capture issues with Pipewire, including the
> heavily distorted, choppy playback when pavucontrol is open. Turns out
> that the pavucontrol volume meters reduces the output sink quantum size
> from the default 1024 to 256, which was too low with v2 but now seems to
> work.
> 
> Unfortunately, this series still regresses Pulseaudio as capture is now
> choppy (e.g. when recording using parecord).

> 
> During our off-list debugging sessions you suggested reducing the max
> capture period size (that this series increases) to 6144 (same as min)
> and that fixed the Pulseaudio capture issue. In v3 the, the max period
> is again increased to 65536 which appears to break Pulseaudio capture.

I have verified pulseaudio on my side as well, the 64 byte alignment 
should have fixed the issue on the pulseaudio side.

Did you pick up the [PATCH v3 4/6] ASoC: qdsp6: q6apm-dai: set correct 
period and buffer alignment. patch in your tests?

thanks,
Srini
> 
>> Changes since v2:
>> 	- dropped patch which is causing regression with pluseaudio.
>> 	- setup period sizes only for capture path
>> 	- fix underruns/overruns in dsp pipelines.
>> 	- add fixes tag
>> 	- add patch to fix buffer alignment
> 
> Johan

