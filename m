Return-Path: <linux-kernel+bounces-186377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1088CC36D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BA2283EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9015A1C6AF;
	Wed, 22 May 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOiJwRsh"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3C1864C;
	Wed, 22 May 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388993; cv=none; b=AG3mbeh68rsF7MmmKiaAoJY3lVLehjzRV1eXKn7mOW9AuUpDt0jRsLnk+iiO3xFhu2SaRFBVgMUwAl2L0MQiljIpCM2/3perUi3MkPp7kCx/9MI3y+20DIpVEAX4FpccnxCtGxtvoO5De4nEIRgmguQB+oiXVuNWtKM2d9GlwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388993; c=relaxed/simple;
	bh=cU0VfFRghGglmx3GPYhyRadXAJpo3i6tBsjliiSd/5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feIL77WB5s0jFtahqq7wjBQLtqd3cx6FdpnHF2mvf03A2kb+ulCDZo+1+2n8X76wcxVHVv+4h+rwLzZeLTt6zelMEfPKJ+fpRwrNNiQHoRVhvewLcgIKbDx9QZkh7W5MSS5KHzlUBu4vEBd5TvnWzFvquDmxX4HNkRiavv5M46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOiJwRsh; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-520f9d559f6so7937741e87.3;
        Wed, 22 May 2024 07:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716388990; x=1716993790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKGz5EzGEJV05Hj0JhuGrkXsXmjzWO6dC3DmXo4LzKE=;
        b=FOiJwRshJQ9jaNEKzOhV/UVNGIvOKytkCpc+DSshQCnXIdNVuz5/EWNGrTgEZyHjnv
         5gv9sxRvGUGsBwS17R3QzaJpQQrPHqU5gIwEBMFAC8CEf9oTiZVRXZiHW2gxN/gCrBwP
         R1xzS9iQZbpsmkLCKhgModDegMntPWSMrY16nnznc7ngygTsd1GsJI1qSC43VpecLTLK
         tWtK0cHMvpYT5NSTsKfqc63uDrWohV16beQLrJU/oS5j+mlDUCjBEtc6RdwAmsIrSG4t
         g8uC46dMQgWmRfMokY5cI4fzoebFyo4dXx1O6ftwwZwJqpMH2cgvtRCAna+if0lY1z7V
         mPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716388990; x=1716993790;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKGz5EzGEJV05Hj0JhuGrkXsXmjzWO6dC3DmXo4LzKE=;
        b=cbRxCpEWegTdD9EBv5Z9XcRdjArmXycOvhG3c3PEPoizp3ybsHlXYOLKG8Iwmb1p7j
         yXs1FEZZz45aIxd3Wxi+KcONWrzxdGDKH80ye8gd72TJ7ZwvqHuHxCU3y/Luu74ZNjd2
         kPAad+585HMUX5AFCthBSPu+IAS8KBR7nQ5+te4KnecMEeHMKfOXGBL7QOD1aI3CMmXH
         6HV9Y1l4JuUtl6IhYh2p3uqbs9xM8IamBF2cpNvV+uDELHQEkvpLIe0ySqA3AB8A9LBD
         LzXU/lvLzShd9vievj2UnrvtwbxlpMu78dxlqFj5lffxeMp/uxYSHOrtBgDO2vHIAuKs
         MRQA==
X-Forwarded-Encrypted: i=1; AJvYcCVGasCA8yuB3Ytuyu7iCMulhg4raMaufde3TU2fj4X0Wcqof+EbGP8xkb9QfsT4gKVNO+LdtbGrN3tRaGviiyHf5QtEG+D8iIyvf8l29PKrV/7VUWAmGsQ/eis/IYRbdnwob6gilYh6H4P8jCNyfHOJokTirNJq+CVHlx7dXo55mfZALZfE
X-Gm-Message-State: AOJu0YxH/RJMSIrGssgA/AdKZLJMD7ppwVZSWFucfqmzH2IJOoVMINnq
	olt5Nwib3LDPHPtCqp3uWpzrQv8YpPSuPlkigLQaIAIFgiu2dHm5
X-Google-Smtp-Source: AGHT+IG4fUvdOa89iMSUKAiQ1AAmrXW4cgIx9Qlz27fd1jVvMkQLth48Htq0VZuMOnG63nSQyDH2yw==
X-Received: by 2002:ac2:59c6:0:b0:523:9747:4920 with SMTP id 2adb3069b0e04-526be316495mr1617301e87.36.1716388990067;
        Wed, 22 May 2024 07:43:10 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52733b3e732sm126213e87.184.2024.05.22.07.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 07:43:09 -0700 (PDT)
Message-ID: <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
Date: Wed, 22 May 2024 17:43:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>, Mighty <bavishimithil@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lopez Cruz <misael.lopez@ti.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522075245.388-1-bavishimithil@gmail.com>
 <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <4f722e53-011f-4176-b6af-080522165007@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/05/2024 17:16, Krzysztof Kozlowski wrote:
> On 22/05/2024 15:56, Péter Ujfalusi wrote:
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - ti,hwmods
>>> +  - clocks
>>> +  - clock-names
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    pdm@40132000 {
>>
>> The original label and name is preferred to be used.
> 
> Label is not used here.
> 
> About node name, not:
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
>>
>>> +      compatible = "ti,omap4-mcpdm";
>>> +      reg = <0x40132000 0x7f>, /* MPU private access */
>>> +            <0x49032000 0x7f>; /* L3 Interconnect */
>>> +      interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>>> +      interrupt-parent = <&gic>;
>>> +      ti,hwmods = "mcpdm";
>>> +      clocks = <&twl6040>;
>>> +      clock-names = "pdmclk";
>>
>> The clocks cannot be added at the time when the node is defined, it is
>> board specific. This way you imply that it is OK to have it in main dtsi
>> file. It is not.
> 
> Wait, what? That's example and pretty standard. Example should be
> complete. This is not an exceptional binding.

The fclk for the McPDM is coming from external source, and the McPDM is
designed in pair with twl6040/6041, there were plan for other codecs to
support the McPDM protocol and in those cases the clock would come from
the connected codec.

The example (as the original binding was bit rot) is missing reg-names,
dmas and dma-names to be complete.

> 
> Best regards,
> Krzysztof
> 

-- 
Péter

