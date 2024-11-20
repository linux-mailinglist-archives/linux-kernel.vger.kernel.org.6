Return-Path: <linux-kernel+bounces-416402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC39D4447
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97821F22C31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5034B1C8315;
	Wed, 20 Nov 2024 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaOoXn9t"
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D401C75ED
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143746; cv=none; b=g3cj4W89wEqFWr4NMnPYJuej7H7QLUqMU3IRvh0vbLg73zaZIjUefII9IhAm09piX2A4ogpt3l3Y4UmI7ccFZIPmchYnyZ86xw8vpsndC54qvC7Gge3J2BdAsCQvJKTSsUNvR26gXZYJHbNNG0Mq6hEjipbzFMWtMhobKE0nj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143746; c=relaxed/simple;
	bh=r722JIbjWKTV6x5kIRUMPrrtZ91RAYRiLvlDgi1scsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXRcCH6Cvy92rNuazTHvkNHpA55NhPQEDzIEmXLJDr/mcEe8cL/hpQ6RsROv+j9CCe+sFzpXxd2uFA9rKhs33nA45TTLLoeliAlUdj/N68oF4XxDglEloP581D83vQoEzd59E8HqRHnhwPJPLMbpx0lwMC/ouoXvzYoNyToonN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WaOoXn9t; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2fb4feba303so402441fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732143742; x=1732748542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C99xPu0F2JrLLvKVuob7osXujIs4pqASysQpASNt43U=;
        b=WaOoXn9ter8ri2p2KOWZL+1QR70McZ6/gJJ1dCWTQArNeJJV3CcCCdzTQMm6//Hiw8
         MkY4fV/T8nXQw0h91ZuCnTVajQWhu76QYG+80re/aIaP7U+Xmf4NeE24wUl3cWv5AMGv
         zLCLRM8CLItyQ91JCPsUOBUJ6OZ69shr4HO/zK++sulV6E9ZLJWWN/Dw/oOOzjcLyrKZ
         ic7FONw2lGOvK2cl5XPJOXJQekCYEQeEa1U/laPF1790PVScsy9ONKK0+FQQexOxLNoa
         81yU6IK8txaFbScrwvRGzzoyDm1BbCT0030TyGPkvWu6u4pqWLsFuaNBVJCMv4XofbVo
         OQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732143742; x=1732748542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C99xPu0F2JrLLvKVuob7osXujIs4pqASysQpASNt43U=;
        b=n+h8Xk4/jvNPOpBZuJ/BuLyONj1mJ6709jTjh818fLSUFwbFGVzFyErIy0Mesv8jFv
         vzQG+PuospKUaJRlGddlN78MPnlxtW5bd3k3cTVp9k6yIc4SmQNJ1X3DYpIWXfeqiSzS
         LVlppDf2bKXezE1SDyLvb/UHRiO3GYVTNKQaF9tq9nfRGK6gYarIenO+KxHs4NZcLWjs
         izfl52VZ1OPW1JcOBqJYtr+R8gOg9A1WUOZxuSpIxwna6LSjmmh5SaCqF0fYNr6DxQWb
         NqSplPey9shdbgtJW/0PrH2fpDpoaCCg3uul6XtCBTlmFq5DWOfh0hL6iYD5kn9HjfXs
         Nz5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXx3f7TOJDAmlGPR+AW6pY9lv5sFFN0dT0euHwUeBGsa5jFgeQqi14iFbmftftG0EtFE7GbKHLU+L5IhfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLoJXMH4dNit1zGS6+MDCL2BeUBLiozmn7zccxx1+En2ieM4iy
	9GoEOoEOodwkPzPVFMwD/fS9emZjdeHbV8MvvA8Vtbxvht2FH9ILOPbH0qLBKAI=
X-Gm-Gg: ASbGncsG204r0HezDTWq3xncqdquhTphhNgoDfzNUghQE6T+qkakTw4l6h2ZLGDzOso
	BIAuoVnDxvrkOqj86n43VCoOjY5Bs2H3MWPVCTzZ8+aLYGh1Vn4cLd674IizPC06jiY/bvBB1i6
	BLLT4UnQ7n8X0UJidR+bHJxrauYmG3dfXcM/zOKbzOTwpUZ5i5nc+iNNavzNrsctptqdgtfn7io
	2UM2rJ9Jdl++slITuXspGn7Bzh6IV8QUclJCUD8JsmjW1gD2C8glme70czqtOMU9dotyRvCUB/T
	Z+30VzHoLIM43fS+zN8kHBY5cBrq
X-Google-Smtp-Source: AGHT+IF/LUBkOpj9adAK7WT3mpKAbftOM6gI9+oD0hdR5L9Ychgb0xD20dJNLpqrS9C2lqgIaJYcTQ==
X-Received: by 2002:a05:6512:2311:b0:53d:a4d8:1b3d with SMTP id 2adb3069b0e04-53dc1369787mr532834e87.10.1732143741959;
        Wed, 20 Nov 2024 15:02:21 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd3ee026sm773736e87.14.2024.11.20.15.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:02:20 -0800 (PST)
Message-ID: <bb58d02f-9ed6-476f-8bc6-ad56cb35e37f@linaro.org>
Date: Thu, 21 Nov 2024 01:02:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: media: Add qcom,x1e80100-camss binding
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Loic Poulain <loic.poulain@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-clk@vger.kernel.org
References: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-0-54075d75f654@linaro.org>
 <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-2-54075d75f654@linaro.org>
 <92f3f608-1ca6-4c41-9406-28c7ad589872@linaro.org>
 <66d1c50f-ebfc-41c7-95a4-5d555b336da4@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <66d1c50f-ebfc-41c7-95a4-5d555b336da4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bryan,

On 11/19/24 17:11, Bryan O'Donoghue wrote:
> On 19/11/2024 14:34, Vladimir Zapolskiy wrote:
>> Hi Bryan,
>>
>> please find a few review comments below.
>>
>> On 11/19/24 15:10, Bryan O'Donoghue wrote:
>>> Add bindings for qcom,x1e80100-camss in order to support the camera
>>> subsystem for x1e80100 as found in various Co-Pilot laptops.
>>>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> ---
>>>    .../bindings/media/qcom,x1e80100-camss.yaml        | 354 +++++++++++
>>> ++++++++++
>>>    1 file changed, 354 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/qcom,x1e80100-
>>> camss.yaml b/Documentation/devicetree/bindings/media/qcom,x1e80100-
>>> camss.yaml
>>> new file mode 100644
>>> index
>>> 0000000000000000000000000000000000000000..ca2499cd52a51e14bad3cf8a8ca94c9d23ed5030
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml
>>> @@ -0,0 +1,354 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/media/qcom,x1e80100-camss.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm X1E80100 Camera Subsystem (CAMSS)
>>> +
>>> +maintainers:
>>> +  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> +
>>> +description: |
>>> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,x1e80100-camss
>>> +
>>> +  clocks:
>>> +    maxItems: 29
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: camnoc_rt_axi
>>> +      - const: camnoc_nrt_axi
>>> +      - const: core_ahb
>>> +      - const: cpas_ahb
>>> +      - const: cpas_fast_ahb
>>> +      - const: cpas_vfe0
>>> +      - const: cpas_vfe1
>>> +      - const: cpas_vfe_lite
>>> +      - const: cphy_rx_clk_src
>>> +      - const: csid
>>> +      - const: csid_csiphy_rx
>>> +      - const: csiphy0
>>> +      - const: csiphy0_timer
>>> +      - const: csiphy1
>>> +      - const: csiphy1_timer
>>> +      - const: csiphy2
>>> +      - const: csiphy2_timer
>>> +      - const: csiphy4
>>> +      - const: csiphy4_timer
>>
>> What does happen to csiphy3? Could it fall through the cracks?
>>
> 
> Nope.
> 
> For whatever reason csiphy4 is the name here. I guess different SKUs
> have been fused out this way. I'd assume there's some version that does
> csiphy0-csiphy4 inclusive.
> 
> Not here though.
> 
>>> +      - const: gcc_axi_hf
>>> +      - const: gcc_axi_sf
>>> +      - const: vfe0
>>> +      - const: vfe0_fast_ahb
>>> +      - const: vfe1
>>> +      - const: vfe1_fast_ahb
>>> +      - const: vfe_lite
>>> +      - const: vfe_lite_ahb
>>> +      - const: vfe_lite_cphy_rx
>>> +      - const: vfe_lite_csid
>>> +
>>> +  interrupts:
>>> +    maxItems: 13
>>> +
>>> +  interrupt-names:
>>> +    items:
>>> +      - const: csid0
>>> +      - const: csid1
>>> +      - const: csid2
>>> +      - const: csid_lite0
>>> +      - const: csid_lite1
>>> +      - const: csiphy0
>>> +      - const: csiphy1
>>> +      - const: csiphy2
>>> +      - const: csiphy4
>>> +      - const: vfe0
>>> +      - const: vfe1
>>> +      - const: vfe_lite0
>>> +      - const: vfe_lite1
>>> +
>>> +  iommus:
>>> +    maxItems: 13
>>> +
>>> +  interconnects:
>>> +    maxItems: 4
>>> +
>>> +  interconnect-names:
>>> +    items:
>>> +      - const: cam_ahb
>>> +      - const: cam_hf_mnoc
>>> +      - const: cam_sf_mnoc
>>> +      - const: cam_sf_icp_mnoc
>>> +
>>> +  power-domains:
>>> +    items:
>>> +      - description: IFE0 GDSC - Image Front End, Global Distributed
>>> Switch Controller.
>>> +      - description: IFE1 GDSC - Image Front End, Global Distributed
>>> Switch Controller.
>>> +      - description: Titan Top GDSC - Titan ISP Block, Global
>>> Distributed Switch Controller.
>>> +
>>> +  power-domain-names:
>>> +    items:
>>> +      - const: ife0
>>> +      - const: ife1
>>> +      - const: top
>>> +
>>> +  ports:
>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>> +
>>> +    description:
>>> +      CSI input ports.
>>> +
>>> +    patternProperties:
>>> +      "^port@[03]+$":
>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>> +        unevaluatedProperties: false
>>> +
>>> +        description:
>>> +          Input port for receiving CSI data from a CSIPHY.
>>> +
>>> +        properties:
>>> +          endpoint:
>>> +            $ref: video-interfaces.yaml#
>>> +            unevaluatedProperties: false
>>> +
>>> +            properties:
>>> +              clock-lanes:
>>> +                maxItems: 1
>>> +
>>> +              data-lanes:
>>> +                minItems: 1
>>> +                maxItems: 4
>>> +
>>> +            required:
>>> +              - clock-lanes
>>> +              - data-lanes
>>> +
>>> +  reg:
>>> +    maxItems: 12
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: csid0
>>> +      - const: csid1
>>> +      - const: csid2
>>> +      - const: csid_wrapper
>>> +      - const: csiphy0
>>> +      - const: csiphy1
>>> +      - const: csiphy2
>>> +      - const: csiphy4
>>> +      - const: vfe_lite0
>>> +      - const: vfe_lite1
>>> +      - const: vfe0
>>> +      - const: vfe1
>>> +
>>> +  vdda-phy-supply:
>>> +    description:
>>> +      Phandle to a 0.9V regulator supply to PHY core block.
>>> +
>>> +  vdda-pll-supply:
>>> +    description:
>>> +      Phandle to 1.2V regulator supply to PHY refclk pll block.
>>
>> I believe it's very unlikely that the SoC pads are called like this,
>> as we discussed it in the recent past.
>>
>> Please rename the properties to reflect the names inherited from
>> the actual hardware.
> 
> I believe we agreed to convert to the PHY infrastructure after 8550,
> 7280 and x1e80100.
> 
> So these names should rename as is.

my ask is not related to the planned PHY conversion, it's much simpler and
easily doable, just reflect the proper pad names in the property names.

There is no such hardware objects on the SoC, which names can be associated
to "vdda-phy" or "vdda-pll" property names. Okay, split of CSIPHY specific
supplies can be done separately, but can you introduce here property names
like "vdd-csiphy-0p9-supply" and "vdd-csiphy-1p2-supply"?

Also you put a description like "supply to PHY refclk pll block", but if I
remember correctly once you've said that the datasheet (of another SoC)
does not give any clues about the usage of the supply, thus it invalidates
the given description.

I'm unhappy that people tend to copy defects, which are trivial to fix or
avoid at least.

--
Best wishes,
Vladimir

