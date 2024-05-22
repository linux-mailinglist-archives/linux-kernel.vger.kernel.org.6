Return-Path: <linux-kernel+bounces-186372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE88CC35B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBE21F213D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5C2199B0;
	Wed, 22 May 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UO4he5Hr"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B717556;
	Wed, 22 May 2024 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388729; cv=none; b=VJxcWzz+65QCKPqHpqLRwhf+pKG+268DHdavuVo0BraqWYuHlbWJ5ilGIqTD7fYRBo1HivFMNvx2W+kSDddsbzhxG1O4rY76j4fJos8FFqYoDEmD8Z+NRQ8oRsKzkRx6PE1m8IZwvz7r2hBMvOqjMITB57XA738H8WvCVtbrUJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388729; c=relaxed/simple;
	bh=Jbhf0L3QJiTE2xMO7r1jXskL7plBAjAKFFNa8PpOrOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrkmqUHwUJ9I3NlFu1hKI7DZT3HZrDps7NxmysacVXVdzFjxCalRcbeEo+grK0ZaEYQW1o+4pgv/zUoNZV0aYjNTb3ph8ndD6F0cl2qt2Fh4LFNhFKYD5VH9YQtWKCAV2DnxOugDW4rj0Pu5OOPDXXBgBo14Ee85HpqGaG/VnjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UO4he5Hr; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso69395521fa.2;
        Wed, 22 May 2024 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716388726; x=1716993526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4t6X8f6A0pmbuPAdvILW68xz75GrtymY5yJoCkmIez0=;
        b=UO4he5Hr7tIWNEgw9ttx07x3QQI6T+/nTyijD44p1QoLRYm+fAzbRdXOcs5AdUCSFi
         CwKGkeDKQHa/q+FKcuOF/15EZHatBxN/E3Lv5v4ZbQ2ZGZJVo3wWITAIV9pWc/245G8N
         kzESekqipoxQsbPlDsmtmUXzvY4AEGgP3gnV3PIYX9nqjR4yqcsgqOwo+B3N3MwpARR1
         IrXpqJKESmIAxzeHR2XkUkYoLd6a31amZ8c9FsRnttoi4X7OBZxyLWEUNsERvPd5tCC0
         r22s1v3Hltm+g54hfzJj/dgdfcrJLYZl959vN1yZ15Ei+2ZQ7DGMVBVmfltjtnwoxm9l
         71oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716388726; x=1716993526;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4t6X8f6A0pmbuPAdvILW68xz75GrtymY5yJoCkmIez0=;
        b=bYVwhtrn4+8JoEeTz3ix9SZiFjMbrGrNzghrqCNmlzX4uuyhicQhCdGALuZPFBB/XG
         Fd2ha9BDGCww/7gnaf+pM9K8jAUmHLnlYr/t9YusWrT1bqbsn/lEo5yJ9xNBK/2DY8Oz
         zusdOQg+rFMpPUAYUT0f6yCit14Th6uen5KzdlbWmeysDgNb9nIDbJEFeOD9FErmwQbJ
         IrxbetoXkK28aMF2qMA5AoC5axiYzJRIP5AvRXPWGvQ5lk71O1EWYs3aCey4YfRvdHgy
         6+ZglDsxiz+5/valNRBxP0cJo4qULmSeV40j+3w09i5d8Lh4sz15kJomL1+0QO80Ne4i
         lMSg==
X-Forwarded-Encrypted: i=1; AJvYcCW3sE8vC/YAZhGLxbnjxPOvCyZnJMKIKlgrYgJd9aj4H3zZYri4lWtpJLY0dD9NvwEbD1MfQDSmY3Bq8zdWeB3nuwoUmmNyydds4KjnwnPbJ5QoYADcHKxkEYM4p5/L9zKefyl7H4bg/a3qcd3lnNDh7LWBAQy2MJ6VKM5MvRSbFrv3GMF2
X-Gm-Message-State: AOJu0Yxf7fvi04x1Zetife7hAhlZpTvBXy6ZXlyzeWSw6k8qyc5UR785
	U4NEvHa5H5ZFhZXO4JddieeoZ3PZKHv+DrCBv3+Ow5NFDRtsEbNz
X-Google-Smtp-Source: AGHT+IEu4PmQnQwYKAzbrUIgik9Ky1Tdc2QxDfcwrLbziz7fSFeCsutKrh7bzCvy0dupOxgLIN6oNA==
X-Received: by 2002:a05:6512:3f17:b0:51e:ef3f:e74d with SMTP id 2adb3069b0e04-526bf545f82mr1925484e87.62.1716388725902;
        Wed, 22 May 2024 07:38:45 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52733b3e732sm125225e87.184.2024.05.22.07.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 07:38:45 -0700 (PDT)
Message-ID: <1c54c68e-1c0e-4ebe-821a-4bc7d4fb8577@gmail.com>
Date: Wed, 22 May 2024 17:39:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Rob Herring <robh@kernel.org>
Cc: Mighty <bavishimithil@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lopez Cruz <misael.lopez@ti.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522075245.388-1-bavishimithil@gmail.com>
 <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <20240522142222.GA3233115-robh@kernel.org>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20240522142222.GA3233115-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/05/2024 17:22, Rob Herring wrote:
> On Wed, May 22, 2024 at 04:56:11PM +0300, Péter Ujfalusi wrote:
>> Hi,
>>
>> On 22/05/2024 10:52, Mighty wrote:
>>> From: Mithil Bavishi <bavishimithil@gmail.com>
>>>
>>> Convert the OMAP4+ McPDM bindings to DT schema.
>>>
>>> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
>>> ---
>>> Changelog v5:
>>> - Add imports for constants
>>> - Add desc to ti,hwmods
>>>
>>>  .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ---------
>>>  .../bindings/sound/ti,omap4-mcpdm.yaml        | 61 +++++++++++++++++++
>>>  2 files changed, 61 insertions(+), 30 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
>>>  create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
>>> deleted file mode 100644
>>> index ff98a0cb5..000000000
>>> --- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
>>> +++ /dev/null
>>> @@ -1,30 +0,0 @@
>>> -* Texas Instruments OMAP4+ McPDM
>>> -
>>> -Required properties:
>>> -- compatible: "ti,omap4-mcpdm"
>>> -- reg: Register location and size as an array:
>>> -       <MPU access base address, size>,
>>> -       <L3 interconnect address, size>;
>>> -- interrupts: Interrupt number for McPDM
>>> -- ti,hwmods: Name of the hwmod associated to the McPDM
>>> -- clocks:  phandle for the pdmclk provider, likely <&twl6040>
>>> -- clock-names: Must be "pdmclk"
>>> -
>>> -Example:
>>> -
>>> -mcpdm: mcpdm@40132000 {
>>> -	compatible = "ti,omap4-mcpdm";
>>> -	reg = <0x40132000 0x7f>, /* MPU private access */
>>> -	      <0x49032000 0x7f>; /* L3 Interconnect */
>>> -	interrupts = <0 112 0x4>;
>>> -	interrupt-parent = <&gic>;
>>> -	ti,hwmods = "mcpdm";
>>> -};
>>> -
>>> -In board DTS file the pdmclk needs to be added:
>>> -
>>> -&mcpdm {
>>> -	clocks = <&twl6040>;
>>> -	clock-names = "pdmclk";
>>> -	status = "okay";
>>> -};
>>> diff --git a/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
>>> new file mode 100644
>>> index 000000000..966406078
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
>>> @@ -0,0 +1,61 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/ti,omap4-mcpdm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: OMAP McPDM
>>> +
>>> +maintainers:
>>> +  - Misael Lopez Cruz <misael.lopez@ti.com>
>>> +
>>> +description:
>>> +  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ti,omap4-mcpdm
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: MPU access base address
>>> +      - description: L3 interconnect address
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  ti,hwmods:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    enum: [mcpdm]
>>> +    description: Name of the hwmod associated to the McPDM, likely "mcpdm"
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: pdmclk
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
> I imagine both were review comments. I can only imagine given the poor 
> changelog.
> 
> Unused labels in examples should be dropped.
> 
> Node names should be generic. Though if we haven't defined the name in 
> the spec or a schema, I don't care too much what is used.

McPDM uses it's own flavor of PDM, it is not the normal PDM as we all
know, I don't know what other generic name can be used.

> 
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
> That's a .dtsi structuring decision which is irrelevant to the 
> binding.

I see, but then the dmas/dma-names should also be in here somewhere, yes
it was not part of the original binding doc, but it is mandatory.

Looking at the code and DT files, the reg-names also mandatory.

> 
> Rob

-- 
Péter

