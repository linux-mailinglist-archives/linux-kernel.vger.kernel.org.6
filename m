Return-Path: <linux-kernel+bounces-187086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 687578CCCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 645C6B21C61
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0856513C9DF;
	Thu, 23 May 2024 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPGO3KAq"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4D13C677
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448927; cv=none; b=WCaLx6l4DgK0j/+a/m6zfMlS4c8XxwMVdyH1eTZ6CG8h3JFdpj6rZT6Gygpofey4w/NdgM21Xx1hGHJjX+tp++L7+B2nC3q68BeaIymci01UYDDUbNzj09/1ZyyW/SKdP2Xie5f+3iKAhmsZKzhCGNgMLKR0AvJblx2fEwfR2TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448927; c=relaxed/simple;
	bh=CyPLZVnB/DanKVAH6e9CYdWNhAO3p1CUC8qOiudUuJ0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LRhKeTlHyD4yndmFpj5UOkhtddqFggk0DeHyfIA9783gZHbzBQViDF8tj2h0Oa0V54XKqDBempACpdzkHGMZNnsfdjxXPrONuVyroBrpA6D6UdUpVgUcfBPLsNHq0yhdFTl1aWRltl8JwWk7qM/NxL4noFYXWKCi1/4yb1nEQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPGO3KAq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a9d66a51so973903166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716448923; x=1717053723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1eaJa9pGQU7S2YJvtO3vDk5kdB4Sw7kAba4zxjrsUs=;
        b=cPGO3KAqcAkAramiSYPSnyYA0Ngfo9TBuPvvreFnwbe1CIsWVcZe//oTPl55Fedbyx
         Tj6Ooj2OIJQdnW3jmpd7y8wz+MejFqUngCEfqYAQVOf6c1Af5nF+ASL1wjfhVzOeDJAz
         V9UF54EL+locCy7a7MCGd4wC4hBkhcuuNeyNC1a9ECe71z5xKnhfvQCPCx9SDgtZQar1
         NtRCyl+8Ot+0ZSqiF0PfI/3dsr5QxrXfcjHw0u+1f4yrMQk52eHTwi9P4UneaRq1OTJj
         3XhPghluq7f5O2GtsnCYNGkSG8BXIypo/cn7hVXAmQChZkMULvsxe/EWUPSkFjZw8R4m
         ulfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716448923; x=1717053723;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B1eaJa9pGQU7S2YJvtO3vDk5kdB4Sw7kAba4zxjrsUs=;
        b=Q7hzV4tPverRZZYw23s36ZC2LDL2RT2JIfU19hr0iZHE63M48NQgoZB5oeG7XUQU5R
         n7bgxHdLNMfI6xxjo8AZlHR1uPpXDTv/y+D91/k9yCGgSGWcNL66iLOIrKc5GtQqzz93
         u8nt4eQ0GuCeAiJStwCGlzWdGaeug/jFgJHpXFV38FirxV2Fi+UZsNqpvaCaFxsrfy4f
         KGqWBUuU1Dq+nMOcdW8+j98c9mgKoPsdV7m0foERmKzK6juQavMKjmzcQeRKkFAIzKeu
         ZFia6CYYhNTj/JBMLTGhGpiBXCh52PM2rcprEWuxNO2Q/JSJyB24/HYghBMG9xI1hnhm
         Ub1A==
X-Forwarded-Encrypted: i=1; AJvYcCWLiur+1yfmWb2CiDs9VBPxsJYZ4q82O3sPQxfY1bj4F5VISrPF9KT2ZW0oAJKfarK4bUJKWCzW0Xq/1awinpKaldSP8qPQyAIm/8mo
X-Gm-Message-State: AOJu0YxQTdmYWnb1fAoqf6JnH9SKtjfyYmoyazi0LfYLDx+cxlc0f42h
	Pa0yBKnq0rbi14BC6LauB3GGkpMrJLKwHM0R42yJtukQItye2eodquMEVwlNY+I=
X-Google-Smtp-Source: AGHT+IGHQ70hXNp/B9UnuQ8B827LgRin78upYW/dgAxokP5RsjGBSWMTlvzsJQDwo9+u9Uqen+AA/w==
X-Received: by 2002:a17:906:c799:b0:a59:d2ac:3858 with SMTP id a640c23a62f3a-a622806b89amr255766266b.11.1716448923186;
        Thu, 23 May 2024 00:22:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:825d:600a:c16:a973? ([2a01:e0a:982:cbb0:825d:600a:c16:a973])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cdb5sm1885070766b.29.2024.05.23.00.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 00:22:02 -0700 (PDT)
Message-ID: <53c97dc2-8c2b-4765-ade7-6c9d0b2084ef@linaro.org>
Date: Thu, 23 May 2024 09:22:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/3] Introduce initial support of Amlogic AC200 board
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Lucas Tanure <tanure@linux.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-amlogic@lists.infradead.org
References: <20240521222155.28094-1-jan.dakinevich@salutedevices.com>
 <171638551693.3169786.7201121718393921307.robh@kernel.org>
 <edc6241b-195f-4188-b802-24706ebc9541@salutedevices.com>
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
In-Reply-To: <edc6241b-195f-4188-b802-24706ebc9541@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2024 19:40, Jan Dakinevich wrote:
> On 5/22/24 16:46, Rob Herring (Arm) wrote:
>>
>> On Wed, 22 May 2024 01:21:52 +0300, Jan Dakinevich wrote:
>>>   - Make some cosmetics in existing device tree files;
>>>
>>>   - Add the board.
>>>
>>> Jan Dakinevich (3):
>>>    arch/arm64: dts: ac2xx: make common the sound card
>>>    dt-bindings: arm: amlogic: document AC200 support
>>>    arch/arm64: dts: ac200: introduce initial support of the board
>>>
>>>   .../devicetree/bindings/arm/amlogic.yaml      |  1 +
>>>   .../dts/amlogic/meson-sm1-a95xf3-air-gbit.dts | 87 -------------------
>>>   .../boot/dts/amlogic/meson-sm1-a95xf3-air.dts | 87 -------------------
>>>   .../boot/dts/amlogic/meson-sm1-ac200.dts      | 22 +++++
>>>   .../boot/dts/amlogic/meson-sm1-ac2xx.dtsi     | 87 +++++++++++++++++++
>>>   .../boot/dts/amlogic/meson-sm1-h96-max.dts    | 87 -------------------
>>>   .../dts/amlogic/meson-sm1-x96-air-gbit.dts    | 87 -------------------
>>>   .../boot/dts/amlogic/meson-sm1-x96-air.dts    | 87 -------------------
>>>   8 files changed, 110 insertions(+), 435 deletions(-)
>>>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dts
>>>
>>> --
>>> 2.34.1
>>>
>>>
>>>
>>
>>
>> My bot found new DTB warnings on the .dts files added or changed in this
>> series.
>>
>> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
>> are fixed by another series. Ultimately, it is up to the platform
>> maintainer whether these warnings are acceptable or not. No need to reply
>> unless the platform maintainer has comments.
>>
>> If you already ran DT checks and didn't see these error(s), then
>> make sure dt-schema is up to date:
>>
>>    pip3 install dtschema --upgrade
>>
>>
>> New warnings running 'make CHECK_DTBS=y amlogic/meson-sm1-a95xf3-air-gbit.dtb amlogic/meson-sm1-a95xf3-air.dtb amlogic/meson-sm1-ac200.dtb amlogic/meson-sm1-h96-max.dtb amlogic/meson-sm1-x96-air-gbit.dtb amlogic/meson-sm1-x96-air.dtb' for 20240521222155.28094-1-jan.dakinevich@salutedevices.com:
>>
>> arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dtb: audio-controller@380: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: /soc/bus@ff600000/bus@60000/clock-controller@0: failed to match any schema with compatible: ['amlogic,sm1-audio-clkc']
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller@300: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller@340: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller@380: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller@3c0: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: /soc/bus@ff600000/bus@60000/audio-controller@744: failed to match any schema with compatible: ['amlogic,sm1-tohdmitx', 'amlogic,g12a-tohdmitx']
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: /soc/bus@ff600000/bus@60000/audio-controller@744: failed to match any schema with compatible: ['amlogic,sm1-tohdmitx', 'amlogic,g12a-tohdmitx']
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
>> 	from schema $id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-0: clock-names:0: 'sclk' was expected
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-0: clock-names:1: 'lrclk' was expected
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-0: clock-names:2: 'mclk' was expected
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-1: clock-names:0: 'sclk' was expected
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-1: clock-names:1: 'lrclk' was expected
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-1: clock-names:2: 'mclk' was expected
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-1: Unevaluated properties are not allowed ('clock-names' was unexpected)
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-2: clock-names:0: 'sclk' was expected
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-2: clock-names:1: 'lrclk' was expected
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-2: clock-names:2: 'mclk' was expected
>> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
>> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: sound: 'anyOf' conditional failed, one must be fixed:
>> 	'clocks' is a required property
>> 	'#clock-cells' is a required property
>> 	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
>>
>>
>>
>>
>>
> 
> These errors were here before my modifications, and they require extra
> efforts to rework generic 'meson-sm1.dtsi' etc. But it is not the goal
> of this series. Should I do anything about this right now?

No just make sure you don't introduce new errors.

Thanks,
Neil

> 


