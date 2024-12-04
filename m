Return-Path: <linux-kernel+bounces-431265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8609E3B47
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B32D285524
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847221C1F13;
	Wed,  4 Dec 2024 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5PotgG+"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F21B6D1B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319025; cv=none; b=R3G5ILfLnXXWxqU9vb+wcXHW+F+GMefg/pg7foLnUJGkmq1yROSidvDQJ05XQhGAZtpQZ01WVhxloTcdPNguS44XZOa6Db9jVcuETUmdahTY2eJw9ghCZTQl9dBbZhlYPeoJogYcOsEvj4KdZJb+ECdJuNM/JRF9oprVVmq2TAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319025; c=relaxed/simple;
	bh=616Wed4qFzQ70DBWRsYGpsHgbkDViom1lwYe9lI8zc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTzcdtnwsSzPe3LQ1zpxXuvxw2JGzQqG/23fXUW5d2kFofDO8CC6azn9irMF/6gXGR8TmxI9EesL32kFtSCJhfYiIdv6P4MO1IYOs8oYJ5nzEq2Jp5vuHX8FPdf6AoN5lTCK+u4WwK1H9oq2mEntAgSbrw8o8NEZFYjY7BOhUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R5PotgG+; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-53e1f7b8717so41961e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733319022; x=1733923822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhS54bTqI4gBJF5OBvLmxts+dPXcxqo3w/BOpDYlZEQ=;
        b=R5PotgG+m4GSCCIJQTyf4BducorS7Rv2qJ2pWKtisbR5u1BZjkGfAoxuarZDCQTyWr
         wPrZd8izOgoOH2b6+NZWtjboD5YJv4PqOysyWlcWu9ibdrXUjUk6DOQjo56z4Kmzaopc
         OPwfGPPeXCkDuCnqtW2TXEJFx33gjGtQd8b0TGpq2GQcxvzWcEZlGeLsaftOJLHtV7Zx
         kpkiNQ1rp6ugUp904Yx/4dxpfg9miUMTLOBOdnO1l3kmMcNmyHOEPp3VN42Fur7RGGlB
         ANUYHCDOirklI3xMmj8lKCp551n675Tnv1oVMlQ9s6PGC29U/srh7tK9Wx3BW0AsZPlU
         YwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319022; x=1733923822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhS54bTqI4gBJF5OBvLmxts+dPXcxqo3w/BOpDYlZEQ=;
        b=nZIxhfhDcA9ZVIRTKx1+26mMoEzn9SCbqdWWC3kbMD8c/wVNskMjSn3+Cr42PU2uZM
         2t2ATOJJ4YXp3Dw9H6EgGUBwND0cvbCxcjiwU22ZNaefuU9EiE3ubNL4Sh6sJfitCiiI
         fo8e2TRdOPtXscCxc9AQUIb8RQEZnlN/7LNH7YaYqITtffpgce1KHH6q7M/Ig0pSu4ck
         X37TDl8ftrOZa+HfKxqd0hMHUvrg+Rsg5klkjp5HdIRnuFTwJKoRm/VK5zfor0SDD31o
         a27s0gsGkgS7zsX3Cejr99n/exv01UgX0Tx7D+5aoqGXnKFum0U88Vlgd6jby9y0rGA7
         ipIA==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZDWvB6eXyGaz0YmVfg4MbfP4aLfaCvGD7mETPfbrvM500y5sNSw0cAj1mgBPSJ5TqsXYkAb/PNisDmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxejM0uaH78IOfHSfHl8ndfpyks3iJOASongXK7bp2KACvHZic5
	0B1V9ERdJG3OZIiIOESBvSsRpOiztI5YMRexgNibLnCbNqmfLS2ArAX9ytZLgoA=
X-Gm-Gg: ASbGnctHVPbUvZTEx5ug68ogQRlVamNrDveOL+rw//JoUXYcSUbDMfEoQYF0TO7iC8q
	4iLIOZZ3vzBF1tXaswtNI7AtODESayEk8X3ET+DVHsvk3/D+Lxeq3OrJ0dcn+kNY12RZTCc2N+x
	op9sDfrDm1Y4+BcwVfIIjPVGihuMSCHdBX/eGid233UvLNVU3QYnicpoY/N+5NUIyy8E2SaePUA
	g8WoHKai3089GvVNJ3gM0YzsR8Rx7SV2tVnL/jdTFFD3asLwMBL2p5KAKINUnvtzu62yWo069f3
	nPnAX8ql7d7oE2uByZE3w0UIR2Vl
X-Google-Smtp-Source: AGHT+IEwzrSZ05xPopmPfXok5R/ZwJML7B2PctFZX9a7zl+gsTPvnPIDtSr+qaR7Wbr331/QCbHvCA==
X-Received: by 2002:a05:6512:2815:b0:53e:134f:9408 with SMTP id 2adb3069b0e04-53e134f9462mr791296e87.8.1733319022171;
        Wed, 04 Dec 2024 05:30:22 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1ed46cfesm166403e87.249.2024.12.04.05.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 05:30:21 -0800 (PST)
Message-ID: <e9e8e34b-cd6a-41d8-a267-3b9336e3ca24@linaro.org>
Date: Wed, 4 Dec 2024 15:30:19 +0200
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
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <eb7fc499-d60f-4a3f-8279-1c9de19c2328@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/4/24 15:16, neil.armstrong@linaro.org wrote:
> On 04/12/2024 14:10, Vladimir Zapolskiy wrote:
>> On 12/4/24 14:16, Neil Armstrong wrote:
>>> On 04/12/2024 12:05, Dmitry Baryshkov wrote:
>>>> On Wed, Dec 04, 2024 at 11:56:54AM +0100, Neil Armstrong wrote:
>>>>> Bindings documents data-lanes as a single entry with a separate
>>>>> clock-lanes property, but DT uses 2 entries in data-lanes.
>>>>>
>>>>> This would suggest clock-lanes is missing, fix the DT using the
>>>>> bindings example.
>>>>>
>>>>> This fixes:
>>>>> sdm845-db845c-navigation-mezzanine.dtso: camera@60: port:endpoint:data-lanes: [0, 1] is too long
>>>>>      from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#
>>>>>
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>>     arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso | 3 ++-
>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>>>> index 0a87df806cafc8e726aacc07a772ca478d0ee3df..5a16f4c2b346b314af3d614266e1ca034057e643 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>>>> @@ -115,7 +115,8 @@ camera@60 {
>>>>>             port {
>>>>>                 ov7251_ep: endpoint {
>>>>> -                data-lanes = <0 1>;
>>>>> +                clock-lanes = <1>;
>>>>> +                data-lanes = <0>;
>>>>
>>>> Is it really this way or the other way around, clock = <0>, data = <1>?
>>>
>>> No idea actually, on the schematics the lanes from the DB845 are :
>>>
>>> CSI0_P/N -> OV7251_CSI3_LANE0_P/N -> MIPI_CSI3_LANE0_P -> SoC
>>> and
>>> CLKP/N -> OV7251_CSI3_CLK_P/N -> MIPI_CSI3_CLK_P/N -> SoC
>>>
>>> So I assume the data-lane is 0, for clock-lane I just used
>>> the example, but I found nothing in the code using those assignments
>>>
>>
>> It's a sensor property, and OV7251 sensor has the non-selectable clock lane.
>>
>> If it's technically acceptable, I would rather suggest to deprecate and
>> remove "clock-lanes" property and hard-code "data-lanes" value to <1>.
> 
> 
> Ok indeed while looking at the OV7251 sensor datasheet, there's a single
> fixed data lane and a single fixed clock lane, so on the sensor side we
> can't select anything but how would we define lane0 is used on the SoC side ?

It's done right in the common way, there are clock-lanes and data-lanes
properties on the ISP endpoint side.

>>
>> By the way, this particular device tree bindings miss bus-type property,
>> it could be either MIPI or LVDS serial output.
>>

-- 
Best wishes,
Vladimir


