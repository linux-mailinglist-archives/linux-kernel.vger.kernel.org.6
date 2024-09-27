Return-Path: <linux-kernel+bounces-341637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F0C9882CA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42830282E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5A188CD6;
	Fri, 27 Sep 2024 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijD0Bixl"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1D183092;
	Fri, 27 Sep 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434205; cv=none; b=DMDe56VvO2lOFs/hMv/n0wmazPrgRC33pRMufS/sjLWliQbgYq0cyshRcyLZS7vLw6mrc8Jlb+QWGd2cJT1KHHDVPb1yL9bouradXgp49ZHzme3v9uEmoFjX2QzzomOm+Y+0B+3tiPGxKL+PRSsagRX6+WxeSCwNOpdMxiIVB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434205; c=relaxed/simple;
	bh=8dAV29tDl0in/jujhsDMPKKy8mxkYTcUS99fDHyNz4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmeskleVIDkM4P5/gSUVAd09Qwle2F7r2g299EOZzNs6RM3AwjyZjClqsjJPAY8TLZCqv/fGHTJLVp5DSZzOF+jrdbGN1zhuXsieYAH7kaCG/kxk3WW7Ypj5WzfYZxJAzeqAZpvuVHKnyrV/gBNVFd5dsz+V2NVcsPdFj9wKkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijD0Bixl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e0a47fda44so286156a91.1;
        Fri, 27 Sep 2024 03:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727434204; x=1728039004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Cm/CaH+7rnCuQElMA0wHSDFr0ElI/GNiHs3+I9HxOc=;
        b=ijD0BixlbWUQr2KwsjCGLSOb0t0d3JrBUeTZ3LMBIYEMR7rjjMcIR3qrBNKHsUzkeT
         o9N2J+MXZWZ1XQfaoKRqzSaY8cgID62VBXqpZvyKG1QYML53VZxlviGzz/7ZnzoaMAWl
         i3bgBPLXX+USUKxBj5LODl9D7UF/XOs2Dl9nGasoSAOasrGTLqyObtInNJ5g5Dvm75mf
         x4Jj26Jb2Kbj7qSbkB0FHf2IN3tqb4FtuLxbMgPP7iuFjNL8/wiRZRtVMIys/LWOcwh5
         hWUg+tAqvad4irtgzl1i/81ggWsNBMlNfJiRqZ8iY623on/Rx51WHmuJprGSG2Tf5fSR
         1Ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727434204; x=1728039004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Cm/CaH+7rnCuQElMA0wHSDFr0ElI/GNiHs3+I9HxOc=;
        b=XTVIJ5Be+jwJyyqtKTkp0F6l2Q7THc/+Mfr8Z22wNaPCOG1CqXBKc5Q+XakDlp2yr2
         r34QOV9FIVaxeabV+HpJerymUM9XGR1MwbupdIzItEzmCGvVb5rd+x/31dHraecbwJRl
         Ebrva8vGGd7WMJEqb3mA0cQXlfqTiKchksm8FAajsVqAJQWGBEWkXSSiNK88aBrS9CVP
         gL5Lfh9HB/57ZpAXjdU0lMOgY5rJFwF75BzujpOCheooBofX4geaSPR1OFpbNdtUkY9M
         ezLHXdzIGPVClQlhYPGy+BOEGZt6UCdxtLmAdGrL6BmvpA6rVTINu/XVp1hxCEXuCv8E
         FUlw==
X-Forwarded-Encrypted: i=1; AJvYcCW+xACvfKUaZsDPe5E9laPg3jhDhZkQ5POq0uDv3rCXRsGksbIfrk0kjvDYarvGgXpTQEvjRnR0z5OR@vger.kernel.org, AJvYcCXSYY8+kbp6eeksc+e28Lkx/3JjhKz2ccMLzX30PuOFLCGMImmfa4Qht9I4+KjIp8A5fQBhoJSxIpqJQr0w@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTAdOdFwFT3RJeheZgOE3hVVBgeFNKPFeiV7a1+VoR186so4E
	to3TigMfDPU/5bX+QW1fbyb3y1cy6nx9II0Ai2UK4F7BE6bdl9v3m9L6Kgis
X-Google-Smtp-Source: AGHT+IHSYMyuGVO/gtIn+YKc6BCcgImGwsAagdTinej2ygKLLnFEyRNG87k8Y5G0jBj0H9zg6u8HXA==
X-Received: by 2002:a05:6a20:1590:b0:1cf:2be2:8dd1 with SMTP id adf61e73a8af0-1d4fa7adf82mr1868218637.10.1727434203743;
        Fri, 27 Sep 2024 03:50:03 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2653726csm1315488b3a.205.2024.09.27.03.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 03:50:03 -0700 (PDT)
Message-ID: <7eead817-fe37-472d-ab5a-f46133031e18@gmail.com>
Date: Fri, 27 Sep 2024 18:49:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, frank.wang@rock-chips.com
References: <20240926103223.29538-1-frawang.cn@gmail.com>
 <ed829240-d4f7-471f-84f6-3509f87f11a1@kernel.org>
 <7944f4dd-96f0-40df-8c91-523409e3cb20@gmail.com>
 <4b98196a-c898-4d08-9101-31feb4e59b5c@kernel.org>
 <a06af01a-656b-4ef6-84a6-bc1c35d5bafa@gmail.com>
 <2815219e-3a20-4a5b-8573-d8a4ad2df1c9@kernel.org>
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <2815219e-3a20-4a5b-8573-d8a4ad2df1c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

On 2024/9/27 17:52, Krzysztof Kozlowski wrote:
> On 27/09/2024 09:59, Frank Wang wrote:
>>>> -  clocks:
>>>> -    maxItems: 1
>>>> +  clocks: true
>>>>
>>>> -  clock-names:
>>>> -    const: phyclk
>>>> +  clock-names: true
>>> For the third time, read the code I gave you. Do you see something like
>>> this there? Why doing all the time something different than existing code?
>> Refer to the link you sent me that I must add minItems property for
>> clocks, just like the below codes:
>>
>> @@ -35,7 +35,8 @@ properties:
>>        const: 0
>>
>>      clocks:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 3
> Yes, for all variable properties, so also names.
>
>> That can pass dt_binding and dtb checking, however, "clocks" is the
>> optional property for some old Rockchip PHYs,  I am not sure is it right
>> to force set  minItems as 1 .
>> If just keep maxItems, the dt_binding checking is failure.
> Please specify the question you want to ask.
>

Q1: The "clocks" is an optional property for some old Rockchip PHYs, so 
set "minItems: 1" likes the below, is this a suitable setting?

    clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3Q2: Do you want me to amend the code to like this? 
clocks: minItems: 1 maxItems: 3 clock-names: minItems: 1 maxItems: 3 
allOf: [...] - if: properties: compatible: contains: enum: - 
rockchip,px30-usb2phy - rockchip,rk3128-usb2phy - 
rockchip,rk3228-usb2phy - rockchip,rk3308-usb2phy - 
rockchip,rk3328-usb2phy - rockchip,rk3366-usb2phy - 
rockchip,rk3399-usb2phy - rockchip,rk3568-usb2phy - 
rockchip,rk3588-usb2phy - rockchip,rv1108-usb2phy then: properties: 
clocks: maxItems: 1 clock-names: const: phyclk - if: properties: 
compatible: contains: enum: - rockchip,rk3576-usb2phy then: properties: 
clocks: minItems: 3 maxItems: 3 clock-names: items: - const: phyclk - 
const: aclk - const: aclk_slv


Best regards,
Frank

> Best regards,
> Krzysztof
>


