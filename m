Return-Path: <linux-kernel+bounces-415873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B40779D3D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D622809A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285201A9B53;
	Wed, 20 Nov 2024 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkRHQxL1"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B4149C42
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112492; cv=none; b=Z4lq6vyyKjHfcnIEoh74A+R8MhLzpFNtiXUtEGstp96t0lIyyt+czyfCZoFPAF0bHSPpcVVDiZSvgtQK1jUZgN8wDylug1zgt47FSGeC9G8DKCnorv2jrpJH7Ku7mZNYwZbATTmdySsctcdNf/MoVb2hLLQvzs+Q4Wd0x0W1Qu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112492; c=relaxed/simple;
	bh=Z01nQIZCQnbX2s7MxdNQNd0nrJq7O7aWYnN7h3NrYnI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t9ZKZ+0bKB4W+2AtCW/aw+DMeJGqCfX6vE10NFvoM21YeGlsWSz8+AR9rm5WwCa5oZ7VNOeJqvcgKGbycHPG68JtussiutRnAnsBNQecBwpgefQ7jW6sgGQzp1nJQBXz4gTVUdjrWSTSJDJEh0RCqVCtEFJHyqzoS96nEgM3Jtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IkRHQxL1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a039511a7so108595666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732112489; x=1732717289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VwRMBWreqVxTaGBRTv34cTudhocbdehkeaHc0Thfy0I=;
        b=IkRHQxL1F/JbhuZ2joUOI1YuG/nzmQOqzNUz7gvWGXc9EJTC9HMKWOOV0YZX1nWMSt
         w/Ce55ygv6vEpDMxgN4OdgmunTm2MS4aFAxzNUWYeWJnxj5MS9OBy++x1MPUY/b3c8eE
         bxLfrqtUTCOcnxbWJ7IPefmkoE68GQqb8FOBVMjvU6AwrV4lXwcM6V5wPg7rud+EP27h
         luu69NFnptLoLSVXbDQaJlZG1OMgXXxkJKC2J3QtNSQRCsPZG+ZG2F4wJk+TWZxrH6uc
         A4/3y+10YaDSv+896Knh9mRzzwjdYIJWEYDebseqE3ZWoSFd1e6Pth56siHSTXCzXoEf
         +dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732112489; x=1732717289;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwRMBWreqVxTaGBRTv34cTudhocbdehkeaHc0Thfy0I=;
        b=W7v2PN3Yoz3ktJYiwGjMeVp1/IIFW20RKkNMEDClZPE478Cjsq4MvOmBGcqs/ly6Cx
         vx4yrbqJN0fEQOSYwT1zy3JW33h/LCLrLxFNHYYJSAXiwLiK0tcEsC1M/chahv95ew0P
         XPBo60WbtjVRqiSOLUu+d79EvsFor7k9gIb22hmSUAF5R89cqyW1YZWuk6xUygvxWS1L
         mb75Kyl7zJpa5O55yXZbReaQNjuE6IFrO6Fl/GGeS2VGVa+Eka4/Kb4ZPfkGY+YWBDcw
         3mWnkHiTii2TGS8xgpxOANsEE1oaqMHB07STTiENZ7Wl7EPS/EHgSFibONZf98i1T+CY
         F+VA==
X-Forwarded-Encrypted: i=1; AJvYcCUpCxKtjfF4ZjvFogAYwYNJ+s5oy3rMXyYA+SuMEuxaPgYZrsuh5q0ZTBNyKHJPU2koUhhg/cvmsOC8w74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEjaEhuT8LRrxlSJR0I5t+gwCrgnR5d0dxYjRaNgCO4H7B9Qy
	GQRGZJ77rB8zA1YYV0K3x4fGjqa0mZVKahHrHibFNLCyXqsyWVHalMNJDENgxSM=
X-Gm-Gg: ASbGnctkSLkMwMMGkRtKAe45HkLhqI8VRmk5yPSH3C0f5Vc+UbehSrioxrC16bs+X5M
	a3bBfQnZ0OplBvLw01mx5wmu8Q/rB45Zjtf+4/Kas3TgPmkDoSYTJkk/dSv+TPp3HPJH1mIiSw+
	HKwLXxtZfT+OkCq2HCydR4gKCjK/v6RWAKIe/LUweBnRaPgnyNyJ9BP8ldfWQsF6c2p54+FzMFO
	DDd1BS5lg+5TceqsejBJhbGzv0Zcm2Ko66uixDGAkolmTHxVWnLsHkazQoeA/KoYQbZIw==
X-Google-Smtp-Source: AGHT+IGsM1zi4rBndmViD78EdsW+yH8WKNnvQyJ3Q37gaISYWGCs4AJLbpimYZSsN8Ism/gSSWiAog==
X-Received: by 2002:a17:907:3685:b0:a9e:c460:ef2f with SMTP id a640c23a62f3a-aa4dd731547mr120429366b.14.1732112489015;
        Wed, 20 Nov 2024 06:21:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e08af75sm778512566b.202.2024.11.20.06.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 06:21:28 -0800 (PST)
Message-ID: <6a1916db-a359-45bb-828c-ecbccaf65f2b@linaro.org>
Date: Wed, 20 Nov 2024 15:21:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] firmware: qcom: scm: Handle various probe ordering
 for qcom_scm_assign_mem()
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Mukesh Ojha
 <quic_mojha@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Kuldeep Singh <quic_kuldsing@quicinc.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Andrew Halaney <ahalaney@redhat.com>,
 Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>,
 Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
 <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-3-7056127007a7@linaro.org>
 <CAMRc=Me=Eu6+SpdguKurWgQDrpuo4qTCwWO6GfzS=YuA9vUzOw@mail.gmail.com>
 <a5343627-a325-465e-b744-747d4c1b2cae@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <a5343627-a325-465e-b744-747d4c1b2cae@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2024 15:19, Krzysztof Kozlowski wrote:
> On 20/11/2024 15:07, Bartosz Golaszewski wrote:
>>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>>> index 5d91b8e22844608f35432f1ba9c08d477d4ff762..93212c8f20ad65ecc44804b00f4b93e3eaaf8d95 100644
>>> --- a/drivers/firmware/qcom/qcom_scm.c
>>> +++ b/drivers/firmware/qcom/qcom_scm.c
>>> @@ -1075,6 +1075,9 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
>>>         int ret, i, b;
>>>         u64 srcvm_bits = *srcvm;
>>>
>>> +       if (!qcom_scm_is_available())
>>> +               return -EPROBE_DEFER;
>>> +
>>
>> Should we be returning -EPROBE_DEFER from functions that are not
>> necessarily limited to being used in probe()? For instance ath10k uses
>> it in a workqueue job. I think this is why this driver is probed in

One more here: qcom_scm_assign_mem() is used in both contexts: probe()
and some other cases like mentioned workqueue. EAGAIN for probe() would
not result in defered probe, I think.


>> subsys_initcall() rather than module_initcall().
> Uh, good point. To my understanding, every resource like function can do
> it, e.g. clk_get. Whether drivers call it in probe() or somewhere else -
> e.g. some startup call like there is plenty in the ASoC or DMA
> device_alloc_chan_resources() - is responsibility of the
> driver/consumer, not the provider of that resource.
> 
> With such explanation returning EPROBE_DEFER is ok, just like returning
> anything else (e.g. EINVAL).
> 
> Now about this function: it is not exactly "get a resource" one, but
> still the caller might want to call it again later, which is implied by
> EPROBE_DEFER. Maybe this should be EAGAIN instead? Just like
> power-supply is doing in power_supply_get_property().
> 
Best regards,
Krzysztof

