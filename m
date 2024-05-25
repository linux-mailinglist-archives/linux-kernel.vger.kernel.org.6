Return-Path: <linux-kernel+bounces-189509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4485B8CF104
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A210EB210B2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF08127E0E;
	Sat, 25 May 2024 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6KbzW7y"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B3F84A41
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716662076; cv=none; b=D6PIZkeBShrauIiAo+Z7/Z5S6J7xaXZkV5dvjNhBdOujcsRcGEdXQzc/uLgKtr4DMNADQONsrPz345ldZUT1tqDxVJUcLF/WiicvcQ7tGgvQ6D276JH/++Kqylz4VPepyyxGrXhHmMZtC0yi+A/QNv+k7Q1HgXgLDY3kHZ25SQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716662076; c=relaxed/simple;
	bh=gXp7mtxI5+En4bOppVLsZ3l7pBgVT0WiilnTsdsYR+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFLquA/6tl7PBtjLTcqg1omxmAX40cZ7EHtXg7jbtJzqcUI9K7MzSRhCr+m0MQxbvHWErmMJczeO7qJ418U+IekUqhS1uasV3EFYwLRt6/cwHsZsXQojYYc+gZ9OURTXdtF84fK9JvLNTTRfry9ftrz1D8vJYxm8yQSjRFEI2E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O6KbzW7y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-351d309bbecso7079212f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716662073; x=1717266873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2rB90Zyk/xnV7pjOge9pMgAzrLvBX8WyYkOhzQ6Icas=;
        b=O6KbzW7yzknn0pq7x6QivTMueEiMUxJtTqkHk7j2pc+5W1MTx0vc6HEfX4jDUH9/Wn
         yi549Nkn4xHZaF2h5yw9qh0g/dKS3/9zkjdu0b6idHM7Dz9g1OxrBMdmYsLOe6ziqs5M
         C+Zizo53KMnhRIMkCPQMwvOJa27+68WUP0LQfbsHuHRMEAVWGYyG09CUKF8y5jC37v+5
         ThFau8hD82znPvTIVUpCH9Q2Ivdj1UUUqe1/qP5cdBWxtQU6e/ByFzjcH2xpj6TUYAK/
         OflsjLpdVCRPthb0o67/qv2xww2MNCZWF43Wlj5FaZMGqKXV2AKMQjY4bAB/TM+ZYyGr
         FJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716662073; x=1717266873;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rB90Zyk/xnV7pjOge9pMgAzrLvBX8WyYkOhzQ6Icas=;
        b=mN7Z5ZF9Kpf2g76cVEdWsCMpRSOrHBYBZdE42sJTZXuOKCqomXary/7imF9lMUYVIA
         MfWae3YMs+sStAIV3vnt2xIXImPBBbXvWKArPDx2j8g9hbsypObkQ/nPJpMVqD6FN6jJ
         Tw5h3LaQ+Me+0EOS5Vtl4xF5KUfWQoWubod875WVKlLVqVBU4k5bfphALP/sjUZ/j0U2
         WNN77KR14DOiPJ/0RM5TSV2ddyEE7JkMyzhMy7I/Hp71J8MBXOwoTC7dSiqrfNbgieqC
         TQBLqGgDDlMZl+X3bE9AGECHAu6IYysNmV6w5jBbv9Keix552Iip/eyhUNjVgbGhpNCU
         5+aA==
X-Forwarded-Encrypted: i=1; AJvYcCXgsQtM2KoEfiJ9gVJ3NDrrDfkW9FLXSePttRN5P6UqlsH5xC7Tcp23UUAvheqdkUfpjyEp+NnUSg2tcOYsRTZe+7g3bC76rtajcddv
X-Gm-Message-State: AOJu0YwiIr+QdE9o7mudFHUn8icbYsLEaZZXFsTqHPtHcaecSkdrBhK6
	JvNXMM11NAe/N50JAxv9XVAx3IREaYqZBSH/TTYxLrBe8Ee5vzbdiyNrRJo/a/s=
X-Google-Smtp-Source: AGHT+IHu4K3qkmTYK4sRJW7Q4z82iFN/TsWlBdU2oIeYfo05jlo/wrTGSzE2FPwp7sn8N/JdOA6LwQ==
X-Received: by 2002:adf:ce06:0:b0:354:f2b0:ebda with SMTP id ffacd0b85a97d-35527056594mr4952326f8f.10.1716662072990;
        Sat, 25 May 2024 11:34:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3558889fb57sm4599424f8f.114.2024.05.25.11.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 11:34:32 -0700 (PDT)
Message-ID: <8007abef-38bb-4d7d-a453-00bb5e6bede5@linaro.org>
Date: Sat, 25 May 2024 20:34:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: rename gw7905 to gw75xx
To: Conor Dooley <conor@kernel.org>, Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240522215043.3747651-1-tharvey@gateworks.com>
 <07250029-7cea-4a82-9e70-22e0e6f7fb37@linaro.org>
 <20240523-vividly-sequester-d85ac7bccbbd@spud>
 <CAJ+vNU3fQt=6t3a_QFU_3jb5mTVLGJiptPnGEmWvvXZYGEPOFQ@mail.gmail.com>
 <20240524-cavalier-outthink-51805f49c8fb@spud>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240524-cavalier-outthink-51805f49c8fb@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/05/2024 20:40, Conor Dooley wrote:
> On Thu, May 23, 2024 at 04:04:50PM -0700, Tim Harvey wrote:
>> On Thu, May 23, 2024 at 7:47 AM Conor Dooley <conor@kernel.org> wrote:
>>>
>>> On Thu, May 23, 2024 at 09:02:46AM +0200, Krzysztof Kozlowski wrote:
>>>> On 22/05/2024 23:50, Tim Harvey wrote:
>>>>> The GW7905 was renamed to GW7500 before production release.
>>>>>
>>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>>>>> index 0027201e19f8..d8bc295079e3 100644
>>>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>>>> @@ -920,8 +920,8 @@ properties:
>>>>>                - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
>>>>>                - fsl,imx8mm-evk            # i.MX8MM EVK Board
>>>>>                - fsl,imx8mm-evkb           # i.MX8MM EVKB Board
>>>>> +              - gateworks,imx8mm-gw75xx-0x # i.MX8MM Gateworks Board
>>>>
>>>> That's not even equivalent. You 7500 != 75xx.
>>>>
>>>
>>>>>                - gateworks,imx8mm-gw7904
>>>>> -              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gateworks Board
>>>>
>>>> Compatibles do not change. It's just a string. Fixed string.
>>>
>>> I think there's justification here for removing it, per the commit
>>> message, the rename happened before the device was available to
>>> customers.
>>> Additionally, I think we can give people that upstream things before they're
>>> publicly available a bit of slack, otherwise we're just discouraging
>>> people from upstreaming early.
>>
>> Hi Conor,
>>
>> Thanks for understanding - that's exactly what happened. I'm in the
>> habit of submitting patches early and often and it's no fun when
>> something like a silly product name gets changed and breaks all the
>> hard work.
>>
>> The board model number is stored in an EEPROM at manufacturing time
>> and that EEPROM model is used to build a dt name. So instead of GW7905
>> which would be a one-off custom design it was decided to change the
>> product to a GW75xx. The difference between GW7500 and GW75xx is
>> because we subload components on boards between GW7500/GW7501/GW7502
>> etc but the dt is the same.
>>
>> If there is resistance to a patch that renames it then I guess I'll
>> have to submit a patch that removes the obsolete board, then adds back
>> the same board under a different name. Shall I do that?
> 
> I think this patch is fine - other than the inconsistency that Krzysztof
> pointed out between the "renamed to gw7500" and the "gw75xx" in the new
> compatible.

I am not a fan of renaming compatibles because of marketing change,
because compatible does not have to reflect the marketing name, but
there was already precedent from Qualcomm which I did not nak, so fine
here as well. Double wildcard 75xx is however a bit worrying.

Best regards,
Krzysztof


