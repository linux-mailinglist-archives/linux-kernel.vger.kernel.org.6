Return-Path: <linux-kernel+bounces-331366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 159F297ABE1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976971F234E3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A2D3E47B;
	Tue, 17 Sep 2024 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFaD8EDW"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A614D2B9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557202; cv=none; b=U8umLyOjJQKhoWfDZFZHWGCSR0luJPL8BjXFtrwMIbSDL+aJngLYjvyDhX9DbkI5G0ld+MaoShjL10U2FJTa9aWeOZrYRHjf4Ri0QvGv51khUwY+OQEtZoYMEtGq31eVrqkCNDyycY7uCEGIRrxbhz/YAIhIKM+LAlg8/vsBIx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557202; c=relaxed/simple;
	bh=swNKLDkS2SD8YNTNI87RH+xrjb7mM6lIq0Tjir43pOY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WJ/eElSXH/PE7nATJu/GzvXXwOeOxMSsHTh/8MQYXr/i7SID7bt3eY4MUZFuWA4KJB52w5LjaB2cfWbApW/4tDb+SLpD7MoicRz0HtRATsLA7oleG/w5j6/d53huji1AGJRwqLpTQAimwKSTVPp4aPB+ZhHWXBH/PC2298Zb9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nFaD8EDW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374ba78f192so3970915f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 00:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726557199; x=1727161999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+HBEKsxJcqP81WkAW4sAI0iZg0KYU8heYcnB9a8jAU=;
        b=nFaD8EDWAwZy1DnM+y3V/l69v4xPAOaxxvG39vGF0YWb16YweLYwLLaglMPl9A+Ksl
         /zEBSHYuEdKgBbioTDD+aKObYRwHihZEdVKSq6PLt5/2r0HOfPE9QEQjcW+iN5hu7E/i
         M+DsJEM1NZZL5fGX+YS+gx2dwZ3F7kJSjnn6OPH0Gksxav+BI3OGUM/07GGhTqcfYOx5
         63fi7u89lz2f6GBlcU+hx/K1NCWFMc8eEMOTIi/OL/RYeTFYWod/0h2MKUvoCr7g49NG
         LJrKTwOlwvFCoBmwKui06DDsqjGPA+MsxFe5ADZ/UFv/fl9oizUoB1NkZ1Z1Ewqws9D6
         TFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726557199; x=1727161999;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C+HBEKsxJcqP81WkAW4sAI0iZg0KYU8heYcnB9a8jAU=;
        b=DWAO9N1gPy8S4mrhM+yXj+b+0ocZwh3DCqDiCPftLFUIyQiSfhkTzX3jtrNqvi2qCs
         nmQOJKR6uGIepvFk6hEJGuQ3ZqiUbKtWnp8SvWhjduQk2yPtl7Y5qQ8A4+wyVlZkSBO5
         nDXJO4Rp5ZKZcJpZbsvw98uT3+1ZpjlwfTXwnEpg/SMUPuI2+zUh7oHANg5f3kMWQ30R
         St7X6iYCZtcfn/5Pgo8fvxRZtM/gcRRJUhNJZkIpeYypdE28YPzxW4RsJ5TgFcphbz4F
         Uviby5EB2CKb+iQhjE+t3zRqH17/2fxuATNy1a3Ft/XiTu8lvtw5ToaCB9RtJ5U1Fs+f
         gHrg==
X-Forwarded-Encrypted: i=1; AJvYcCUeAUJbexuXt/aghkmlCHG90uxb3a63TpI1q8HYenoLt31TlEigcWYIido3yv5WhKBilV+iHy0kiCzoKzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWgMtrmjA/gl7ecVWhpa1EgCErYDhaGLu4DxU4eY4VtGDrEWk
	itLMtuVXpdOkYejo7LT12T1r9eW8eAlLk+rWCoe4Mon6WSx0gwwSF8n0N+ASCvZqM1BL/0IfHV1
	2
X-Google-Smtp-Source: AGHT+IFGpq/+J4ssPTXSy5MwONJpkzTKPo1IEOJH30s3xB5j9inEc2DszWR139tQAfWBSHi5+GrDYQ==
X-Received: by 2002:adf:efc9:0:b0:371:8a91:9e72 with SMTP id ffacd0b85a97d-378c2d119f7mr11727570f8f.30.1726557198613;
        Tue, 17 Sep 2024 00:13:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e5df:ee06:f22e:a8cf? ([2a01:e0a:982:cbb0:e5df:ee06:f22e:a8cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b193f2dsm128955935e9.39.2024.09.17.00.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 00:13:17 -0700 (PDT)
Message-ID: <9394d785-5954-4d44-8ad0-9b57fbecde25@linaro.org>
Date: Tue, 17 Sep 2024 09:13:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt to
 dtschema
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v1-1-b7bfae886211@linaro.org>
 <20240916174030.GA835203-robh@kernel.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240916174030.GA835203-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rob,

On 16/09/2024 19:40, Rob Herring wrote:
> On Wed, Sep 11, 2024 at 05:20:47PM +0200, Neil Armstrong wrote:
>> Convert the Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
>> bindings to dt-schema.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../bindings/mmc/amlogic,meson-mx-sdio.txt         |  54 -----------
>>   .../bindings/mmc/amlogic,meson-mx-sdio.yaml        | 101 +++++++++++++++++++++
>>   2 files changed, 101 insertions(+), 54 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
>> deleted file mode 100644
>> index 8765c605e6bc..000000000000
>> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
>> +++ /dev/null
>> @@ -1,54 +0,0 @@
>> -* Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
>> -
>> -The highspeed MMC host controller on Amlogic SoCs provides an interface
>> -for MMC, SD, SDIO and SDHC types of memory cards.
>> -
>> -Supported maximum speeds are the ones of the eMMC standard 4.41 as well
>> -as the speed of SD standard 2.0.
>> -
>> -The hardware provides an internal "mux" which allows up to three slots
>> -to be controlled. Only one slot can be accessed at a time.
>> -
>> -Required properties:
>> - - compatible : must be one of
>> -	- "amlogic,meson8-sdio"
>> -	- "amlogic,meson8b-sdio"
>> -	along with the generic "amlogic,meson-mx-sdio"
>> - - reg : mmc controller base registers
>> - - interrupts : mmc controller interrupt
>> - - #address-cells : must be 1
>> - - size-cells : must be 0
>> - - clocks : phandle to clock providers
>> - - clock-names : must contain "core" and "clkin"
>> -
>> -Required child nodes:
>> -A node for each slot provided by the MMC controller is required.
>> -NOTE: due to a driver limitation currently only one slot (= child node)
>> -      is supported!
>> -
>> -Required properties on each child node (= slot):
>> - - compatible : must be "mmc-slot" (see mmc.txt within this directory)
>> - - reg : the slot (or "port") ID
>> -
>> -Optional properties on each child node (= slot):
>> - - bus-width : must be 1 or 4 (8-bit bus is not supported)
>> - - for cd and all other additional generic mmc parameters
>> -   please refer to mmc.txt within this directory
>> -
>> -Examples:
>> -	mmc@c1108c20 {
>> -		compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
>> -		reg = <0xc1108c20 0x20>;
>> -		interrupts = <0 28 1>;
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -		clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
>> -		clock-names = "core", "clkin";
>> -
>> -		slot@1 {
>> -			compatible = "mmc-slot";
>> -			reg = <1>;
>> -
>> -			bus-width = <4>;
>> -		};
>> -	};
>> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
>> new file mode 100644
>> index 000000000000..4d1142d2ff02
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
>> @@ -0,0 +1,101 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdio.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
>> +
>> +description:
>> +  The highspeed MMC host controller on Amlogic SoCs provides an interface
>> +  for MMC, SD, SDIO and SDHC types of memory cards.
>> +  Supported maximum speeds are the ones of the eMMC standard 4.41 as well
>> +  as the speed of SD standard 2.0.
>> +  The hardware provides an internal "mux" which allows up to three slots
>> +  to be controlled. Only one slot can be accessed at a time.
> 
> You need '|' or this is treated as 1 paragraph. If it is 1 paragraph,
> then format it that way.
> 
> But really if you want 3 paragraphs, then you should use '>' and put 2
> CR's between each paragraph.

Ack

> 
>> +
>> +maintainers:
>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - amlogic,meson8-sdio
>> +          - amlogic,meson8b-sdio
>> +      - const: amlogic,meson-mx-sdio
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +      - const: clkin
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +
>> +patternProperties:
>> +  "slot@[a-f0-9]+$":
> 
> Are you going to add 'slot' to nodename in mmc-controller.yaml?


Hmm, well slot should not be a valid nodename for a direct mmc-controller,
so how to solve that ?

> 
>> +    $ref: mmc-controller.yaml#
>> +    description:
>> +      A node for each slot provided by the MMC controller
> 
> blank line
> 
>> +    properties:
>> +      compatible:
>> +        const: mmc-slot
> 
> This is also used by the Cavium controller. Should be common.

Right but the cavium one isn't in dtschema, is it worth doing a
common yaml for that ?

> 
>> +
>> +      reg:
>> +        description:
>> +          the slot (or "port") ID
>> +        maxItems: 1
> 
> Aren't there limits in the number of slots the h/w can support?

Good question, let me check

> 
>> +
>> +      bus-width:
>> +        enum: [1, 4]
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +
>> +    unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    mmc@c1108c20 {
>> +        compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
>> +        reg = <0xc1108c20 0x20>;
>> +        interrupts = <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>;
>> +        clocks = <&clk_core>, <&clk_in>;
>> +        clock-names = "core", "clkin";
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        slot@1 {
>> +            compatible = "mmc-slot";
>> +            reg = <1>;
>> +            bus-width = <4>;
>> +        };
>> +    };
>>
>> ---
>> base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
>> change-id: 20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-6fa70546ebb8
>>
>> Best regards,
>> -- 
>> Neil Armstrong <neil.armstrong@linaro.org>
>>

Thanks,
Neil

