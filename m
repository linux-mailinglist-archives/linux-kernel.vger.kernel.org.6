Return-Path: <linux-kernel+bounces-432877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CF89E5160
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647CB188141B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62091D5AD1;
	Thu,  5 Dec 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Waw9U2pu"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173318DF81
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391072; cv=none; b=lONFTgGHB5fMA5t3kTWMJ/B5dgq1iHDH2IOwfZfb7FmjX41fum+h3dR1dO9j6PlUigRKYD5PlkYO8kWnLU2H9FGJtwqB7xI0EWmkozFA5ZXpVjuCnXnFb8RpJvfJHTv5gtzcBbQfoU8O0ZqDr2TshHm3PpK3iqVHWhi2W3ptpOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391072; c=relaxed/simple;
	bh=kH+ox1maGVnEq4Rys99X7DDfTmUkTMqWbANuc4asftY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zacsc4SLHZhjCu4uUpoF01N1u1xJ+qkJuG/a6uDdMVH6AD2OZ7yg4xc8SgaMG5NLDtoVQxcI6OAhi2E3Xc1nptm9t5vpAW5zP3wmhTycP03QXRf74/5czQZi9jvNMyKeyyoF8oxAmzj8Q7AGCWg/SYDzqW9GaRpsx2u+zu8ARmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Waw9U2pu; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e19902535so124717e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733391069; x=1733995869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bjo/4+E6bnCGeHgA1eNp7/F/+hny/nKrIQB7DTvVsq8=;
        b=Waw9U2puhQ1mVROoYZJJIX/RAXZ7xpQGsTjhCQNnrjx3LVr3lO/6U+JdwbD/wS8H2G
         33C9L/NolppTCnl9o+fuLn0ZJamYpLK3HZ2+F2rhKLs/OuJpgLQ+yW7+AieuR0N+ZUsg
         JkgE854kH4Q4fYWMcDBN831K5AoQfkgGfACRDR1B9ls6crU/aUFDnlLZfw0p0II7GCcl
         h9MvcZsgoK2aJ1YW5MRmNGkALvSsRpa7iC9Bf8d6ey9opwDm4DONtq0erIczfFNTzeQu
         hhbhsBZShMVfYOOvuzBEYbgimmOCwvpjldE2XcsWekjESai1/aSOZvs5PYUAgb9B33C6
         BIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733391069; x=1733995869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bjo/4+E6bnCGeHgA1eNp7/F/+hny/nKrIQB7DTvVsq8=;
        b=YBlzt6nD0YN9WBT+24WpX6CyXydMGKWjqWz9tJZXISLazq8F/vh13Cx2RPi/9jaQRI
         b6ZQ/qLIw+fTptFVqmQ2oneuEUqgO0sbUFpEx2SOvsZ8FSJd8KwV3pF+M69DO0GPYHPk
         2vfyeLweInrvVS4f8lAmvp5pNh3wd98/qLblECnJz/zLkZOWMrk9DV4aaN1D2vQDt5lV
         6DBC6MavI3rISfQwl7LwR85II6riXK+R7YkNZmMI7bo0/K5BGu4UVIEbAeEiAJpkhG1e
         fctZUS+z5M8HwOUemMmSDaWVtTIsMj/880PsCSo/qqLLbbhw7tphIZ1yx2+0fnoEILTz
         U6OA==
X-Forwarded-Encrypted: i=1; AJvYcCUB8ePBCkEdeYx6C3yhkt656VYWplMNRd6CUPWlybM8ShW+2VGOE9PrR9QF9CpdAHVm3W0lP/AhG2E2VuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPScHTikWEb9B8p1VgOqWbC6t6jXxmlEo50ewbkTErTCXuFOw
	Kn8Jg4YF2I71slmKlKkzZOmgrzuXbxJ2q/TAxKcoMVq4yPHn9Df5QjWT38aMTAU=
X-Gm-Gg: ASbGncu/P+sIz675Dl15kRqZkZWCMm7pMae5BI589TvIIac9pSwP+sLvSHrXdI6JJLn
	cNjPVi9NChdtl2en8hIoCisvCCJyxqSi4ttH2lU6Ci5yGAzERwIH8lJSBK/EZon9A/0XnwUQWj7
	cM3Fc5NdZ/FClSinpru29Rrek23nZDlx7GXCMtcmBjlMRiJ3PdcXmeQ4fgIN4FKl7gB2yNReQ62
	+/o32iUU55rAE0Fvx7dtD+ncVI0P0+uH9HWw0co1WO2hyOm+OrAkoE4dNRk/I8pbtxjzL8iSg/t
	yZh7hS+19qAAZ1jJ7ID4fBLfufS7
X-Google-Smtp-Source: AGHT+IH/qUkZkwvIvLRdpmRtedgp5svRT+ToJptAUdT7zSqIbtCe+vqm/+eXjOGfPmGe2mxSaNVDTw==
X-Received: by 2002:a05:6512:3d0c:b0:53e:20b3:9833 with SMTP id 2adb3069b0e04-53e20b39935mr489922e87.14.1733391068638;
        Thu, 05 Dec 2024 01:31:08 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ca170sm177229e87.240.2024.12.05.01.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:31:07 -0800 (PST)
Message-ID: <b60bd72a-66ea-48eb-ae2e-085cd090c940@linaro.org>
Date: Thu, 5 Dec 2024 11:31:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sdm845-db845c-navigation-mezzanine:
 fix ov7251 lane properties
Content-Language: en-US
To: neil.armstrong@linaro.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
 <20241204-topic-misc-dt-fixes-v1-2-6d320b6454e6@linaro.org>
 <vlvchjynnwvevr2raosrwggwmjd5bdrs5skbsztskmzxjjdg7v@6qkhrjyaxlsz>
 <0c1f4e6a-a77b-46d1-b944-9eb47d66556d@linaro.org>
 <cd754842-42f0-4938-b590-34ed7c4503c6@linaro.org>
 <eb7fc499-d60f-4a3f-8279-1c9de19c2328@linaro.org>
 <e9e8e34b-cd6a-41d8-a267-3b9336e3ca24@linaro.org>
 <2499c1b4-8cf7-4061-9cc8-d6c0c6aef0fb@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <2499c1b4-8cf7-4061-9cc8-d6c0c6aef0fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/5/24 11:27, neil.armstrong@linaro.org wrote:
> On 04/12/2024 14:30, Vladimir Zapolskiy wrote:
>> On 12/4/24 15:16, neil.armstrong@linaro.org wrote:
>>> On 04/12/2024 14:10, Vladimir Zapolskiy wrote:
>>>> On 12/4/24 14:16, Neil Armstrong wrote:
>>>>> On 04/12/2024 12:05, Dmitry Baryshkov wrote:
>>>>>> On Wed, Dec 04, 2024 at 11:56:54AM +0100, Neil Armstrong wrote:
>>>>>>> Bindings documents data-lanes as a single entry with a separate
>>>>>>> clock-lanes property, but DT uses 2 entries in data-lanes.
>>>>>>>
>>>>>>> This would suggest clock-lanes is missing, fix the DT using the
>>>>>>> bindings example.
>>>>>>>
>>>>>>> This fixes:
>>>>>>> sdm845-db845c-navigation-mezzanine.dtso: camera@60: port:endpoint:data-lanes: [0, 1] is too long
>>>>>>>       from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#
>>>>>>>
>>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>>> ---
>>>>>>>      arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso | 3 ++-
>>>>>>>      1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>>>>>> index 0a87df806cafc8e726aacc07a772ca478d0ee3df..5a16f4c2b346b314af3d614266e1ca034057e643 100644
>>>>>>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>>>>>> @@ -115,7 +115,8 @@ camera@60 {
>>>>>>>              port {
>>>>>>>                  ov7251_ep: endpoint {
>>>>>>> -                data-lanes = <0 1>;
>>>>>>> +                clock-lanes = <1>;
>>>>>>> +                data-lanes = <0>;
>>>>>>
>>>>>> Is it really this way or the other way around, clock = <0>, data = <1>?
>>>>>
>>>>> No idea actually, on the schematics the lanes from the DB845 are :
>>>>>
>>>>> CSI0_P/N -> OV7251_CSI3_LANE0_P/N -> MIPI_CSI3_LANE0_P -> SoC
>>>>> and
>>>>> CLKP/N -> OV7251_CSI3_CLK_P/N -> MIPI_CSI3_CLK_P/N -> SoC
>>>>>
>>>>> So I assume the data-lane is 0, for clock-lane I just used
>>>>> the example, but I found nothing in the code using those assignments
>>>>>
>>>>
>>>> It's a sensor property, and OV7251 sensor has the non-selectable clock lane.
>>>>
>>>> If it's technically acceptable, I would rather suggest to deprecate and
>>>> remove "clock-lanes" property and hard-code "data-lanes" value to <1>.
>>>
>>>
>>> Ok indeed while looking at the OV7251 sensor datasheet, there's a single
>>> fixed data lane and a single fixed clock lane, so on the sensor side we
>>> can't select anything but how would we define lane0 is used on the SoC side ?
>>
>> It's done right in the common way, there are clock-lanes and data-lanes
>> properties on the ISP endpoint side.
> 
> For the ov8856 yes, but in the current state the ov7251 endpoint is not

Above I gave a generic description of describing the lanes.

> connected to the csiphy3, so it's currently not usable and disabled,
> so I'd rather remove this node completely instead of fixing an
> untestable dtso.

Sure, if the device is unused, it shall be removed.

--
Best wishes,
Vladimir

