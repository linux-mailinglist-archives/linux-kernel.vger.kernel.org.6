Return-Path: <linux-kernel+bounces-253731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1D932604
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163231C20B93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA105199EA4;
	Tue, 16 Jul 2024 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPyj+UER"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994A199EAB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131011; cv=none; b=hXoiO96uQO+ATSLjjMfaIkTlTMFuhlKuVbKs1AD53fwxHvOrebk8ly+nX+Ym9AXLmsLXSZ0MTQQkLtzBTwL4dDJsbDQ1crEWAy6XErA60iyV64TVy56C9wQ9nJQvl7hDC6k6D6N73oazmSsGOlHw91IwVc2oJ2WZ/CHpapisjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131011; c=relaxed/simple;
	bh=iHL+uPLvt/KxRZwY9FnS42VfkJTPjqeZ5ibUcTCaN2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f02mF4aqLw1f0LsZX1MGXW9Zxatz98Abr8a+lq3FQdW6dLiEm1M7qhcS36FSiyMeJ81dreL2FDTtP+/Xkxq1r4S/xgvRqYsiXood48Xztm1KQnS0GAN1MrQcEv4ATD2V+GtIB27GiKrYkQbjkkJUp7mjazasJU5UgFRycFFF8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wPyj+UER; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so858536966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721131008; x=1721735808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q07X/9cHC21L2J2kDcebKLKVfHxULB2QbqEJK6tKlE=;
        b=wPyj+UERMTmH4rG4PaCF0Tm/rzmVP3SF0tj2qu7HwuQ1l9UkHMfkAGpJGOZXyMZ6hQ
         M6bxxceu2xctwrPcqrjVih6rWZ0XIfxOzoaA/FJdvO++nbowflH628SPpZOzyiCYNmye
         02VJBe9v3HWrKYNweckN75C9FrhUXSww+JN0fnWB+yeZWqc8eZr8fcKManW267A6PJf+
         d/l2WmjHZxHRuPyNjqmm7O+Y3eOFeJdYnqzmqr70hQXIHscnpl4ogR21bV4B6WPUiush
         xol3b26MaTT/SXnYlyQT2peHAdyvaal01XpQj93dca/zBfKhrmgLNoNK30zd+wOWKRIi
         Y0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721131008; x=1721735808;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q07X/9cHC21L2J2kDcebKLKVfHxULB2QbqEJK6tKlE=;
        b=KnBgD52POQLaMw0UinEbfSQKAdIjxnyXiAFcdCqq/Et3HwiN4Sb0ukLoqsXEOb5RWo
         yfIpFdkVs4/ZFDcLjk//UulKLMBzvynMdtSj9eikv2TTfsc6kz41Ay4m3aPXMidl5Wyp
         gpg/PgkV+B/HuyQ0D6/VugUcblV7BwvufgtfUzE5ieUIDu4qQ5Kxy23oDPkqGa7RO1T8
         RpKV6d133WEJC/ekso+m8LmV7x4FsxzAV6a2xF0sOM3Nlw150BBw0rKlBP+yBY50msth
         LvQKsoqYFeIXg631AYCC3agIMNpAQobnNG74bHPAjR6PNFfW4RCr97d+HYmlNVhqh1pP
         5RjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSBkBBIVscdOHsezcWvPaI76nOKLdj0C4BpGERNIO+sIajguRQRvXXPrIYe705Euec/TLTyiRuhNeAJQNicpI8nAzbN5Q+6GaFYgd5
X-Gm-Message-State: AOJu0YyCptoyHkkEJLlguMYQPJDxacnjZ5iDa5hIasLlm9BdFZpL0Cbb
	af3S38rCsLzT3FUmSDK7v9kqT3c3Wz6qxuJmnJWSKZxdtGSgdE7JqPLowauyrrl7CFjd8XHIPeh
	v
X-Google-Smtp-Source: AGHT+IERPmjrIM2aDqr7ZP8eOgQJXvSWAdRl9PJTlPlWacu9qkHu2w5vUbj1p6hAJbTPMyu7yz2lAg==
X-Received: by 2002:a17:907:20cf:b0:a72:5f3f:27a2 with SMTP id a640c23a62f3a-a79edc4bbe5mr141764666b.26.1721131007390;
        Tue, 16 Jul 2024 04:56:47 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc80d688sm305157866b.189.2024.07.16.04.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 04:56:47 -0700 (PDT)
Message-ID: <8e2ebc97-f455-4f41-81da-af56263e6cf6@linaro.org>
Date: Tue, 16 Jul 2024 13:56:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] drm/msm/adreno: Implement SMEM-based speed bin
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240709-topic-smem_speedbin-v5-0-e2146be0c96f@linaro.org>
 <20240709-topic-smem_speedbin-v5-1-e2146be0c96f@linaro.org>
 <20240715200419.l47ng6efa25in6sg@hu-akhilpo-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240715200419.l47ng6efa25in6sg@hu-akhilpo-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.07.2024 10:04 PM, Akhil P Oommen wrote:
> On Tue, Jul 09, 2024 at 12:45:29PM +0200, Konrad Dybcio wrote:
>> On recent (SM8550+) Snapdragon platforms, the GPU speed bin data is
>> abstracted through SMEM, instead of being directly available in a fuse.
>>
>> Add support for SMEM-based speed binning, which includes getting
>> "feature code" and "product code" from said source and parsing them
>> to form something that lets us match OPPs against.
>>
>> Due to the product code being ignored in the context of Adreno on
>> production parts (as of SM8650), hardcode it to SOCINFO_PC_UNKNOWN.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---

[...]

>>  
>> -	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
>> +	if (adreno_read_speedbin(adreno_gpu, dev, &speedbin) || !speedbin)
>>  		speedbin = 0xffff;
>> -	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
>> +	adreno_gpu->speedbin = speedbin;
> 
> There are some chipsets which uses both Speedbin and Socinfo data for
> SKU detection [1].

0_0


> We don't need to worry about that logic for now. But
> I am worried about mixing Speedbin and SKU_ID in the UABI with this patch.
> It will be difficult when we have to expose both to userspace.
> 
> I think we can use a separate bitfield to expose FCODE/PCODE. Currently,
> the lower 32 bit is reserved for chipid and 33-48 is reserved for speedbin,
> so I think we can use the rest of the 16 bits for SKU_ID. And within that
> 16bits, 12 bits should be sufficient for FCODE and the rest 8 bits
> reserved for future PCODE.

Right, sounds reasonable. Hopefully nothing overflows..

Konrad

