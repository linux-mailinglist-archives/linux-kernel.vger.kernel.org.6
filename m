Return-Path: <linux-kernel+bounces-431233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA1C9E3ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4480167C10
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE4D1B87F7;
	Wed,  4 Dec 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/bR2/XE"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73C1A724C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317860; cv=none; b=Hiw4unA5pvhj8tPTQCVS1+hb1/nawTTlCVSSR/rydWV0Kc4Ya8IrpK2ejIc25eGivloNJhgnpcNK1gk2UsDl62Fk6aC0UTd2VKU7Nz9+08ShjI6c61cjbJzX3zlLyxryx9xaCwcPe4GqJ7tDS7zOdxSDu4+feMVaIpHgj8UnAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317860; c=relaxed/simple;
	bh=d9srN0x/w14KgArGFuugj5uKagGGfKV7pLkuONxS+Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Art12ayU6HEjDXpXzfEqzbmf70WZmRdOZBztvYXIz2vHqJ30IMcSmPmbZ1vybFs3UgAIGoVseRjlnxOoMm3Ql9P/mhxE6dAVmf69GoJqhIAeGw+A/v5sJ8MyuKqkd0lK/Hz4UPTl1zHVDAl74pYFiw1PnksvAXnZtQDJgSnSI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U/bR2/XE; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-53e19902535so174891e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733317856; x=1733922656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v90yvB7RAiniL1C2+QudwZhiuoJT9vTsYZRhdNmXhhc=;
        b=U/bR2/XE1pLGEwUhn6Y8QPGosmAFEYSvYHhcPjHJUFAGxUi3wFYWoI08zykZUHulgL
         GG0RD3+N2llGfANP0g30nd0YL8AO1ni/GMVstW664ebzGlEKrMwcMiJya6hKAzNmOQ3x
         pPo8LvwI9yrNCcirxN2/y6fRuPbeBQUZnmyI9MWud2Rm/ed3JIayDiTz5ipV4I6hju0K
         /fw71MBTzcVgaFNWGj5Nw+3jEoqHCslSGrNZO649bWPBV6zFfgu0NaX3q2JUXx3EUaqG
         33hu8lMxw/7mmfYll9A4VxXCymiBlGMeFbpvaf/O/zzS0WzWQ7tA/802uudMT2L+xLVQ
         5vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733317856; x=1733922656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v90yvB7RAiniL1C2+QudwZhiuoJT9vTsYZRhdNmXhhc=;
        b=WAUeuhvTe6rQRufo7kVoOalvriUz1wOv8KWnJ4rSQosduWEvjy//cY1BNBugEG3L6q
         uDpG6/AXdxwAKwz4zxMsr4i8TyhHWLZxoomSce0SLnNHEBuPjtoziKeVUYatkFNEKR3x
         BBprOZFA3V7CXfNQTao7jyM8IirRSyuGyqhUi2LSaRDYznba7po3Rwdjnm13sQhCUJBY
         35gSBdMScRytLTOlZISuRujrpyQnrY6ElFkWh0oncbh8A66Z4Ms0eQWUuJiMU6Lz9JsD
         r31M2r4w99qm0JqCrqWQYK2zdPQ140JPvadxq8FHpdkc5evU2WD2F4YMnI+ZJGtaGSDD
         xI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6qqFLN0JewXpSlEAGBIs4XsTc/HWsQW5Xa8lBcdin3vUfDfqGeaeOKmVp+JUBecnXLEuCUNg+gEmsK9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtu8GrwRZX41Oyd/fDChGZ9jWjo3zqgXqU9DYyC1sab/Rc6j6
	/aj57lm6o6GMaJgCSICbTuiafBWUcAnaGLD3kDO2SGRAugVZ+LPAPcFeVQqNBiE=
X-Gm-Gg: ASbGncvjBp1BcvMy/RrNja4mxGEmLI/1e3ogkdZ7BLIw1Y6yg27DQO1YpgyS+M1JlTF
	jNSbh6jcyzCtBkexb+bioJh5JU+zYFpDp3pCzds/7bxZH73TZOpq5znVLhlpU6p4j76CajznCz9
	8e0JZm7EFgF9ry+sek6uill8lIDv7FMUmJpat9Yu9V0+PCFa5F/tW43bPgZmtdCTafxNVqwSCvM
	EnQ3cdv9hnZg28GGtKJgZ/Df0r0tlXZbgmhXjlU0g1Bp1W+uwhoxSjZmdzxvoY2xxteq/15VZR+
	cbXmrhBjmeRfcl7fNXIixcfiDZna
X-Google-Smtp-Source: AGHT+IH8wgGCDm9wMUjZa+Ps9/xwljaqHUU5uVvMp2BZp/GBAgPi1/iYQ27QcuFH9QI7yv36jUzghQ==
X-Received: by 2002:a05:6512:2397:b0:53e:1f1e:130d with SMTP id 2adb3069b0e04-53e1f1e17demr168656e87.3.1733317856104;
        Wed, 04 Dec 2024 05:10:56 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1c715607sm274323e87.39.2024.12.04.05.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 05:10:54 -0800 (PST)
Message-ID: <cd754842-42f0-4938-b590-34ed7c4503c6@linaro.org>
Date: Wed, 4 Dec 2024 15:10:47 +0200
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
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <0c1f4e6a-a77b-46d1-b944-9eb47d66556d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/24 14:16, Neil Armstrong wrote:
> On 04/12/2024 12:05, Dmitry Baryshkov wrote:
>> On Wed, Dec 04, 2024 at 11:56:54AM +0100, Neil Armstrong wrote:
>>> Bindings documents data-lanes as a single entry with a separate
>>> clock-lanes property, but DT uses 2 entries in data-lanes.
>>>
>>> This would suggest clock-lanes is missing, fix the DT using the
>>> bindings example.
>>>
>>> This fixes:
>>> sdm845-db845c-navigation-mezzanine.dtso: camera@60: port:endpoint:data-lanes: [0, 1] is too long
>>> 	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>    arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>> index 0a87df806cafc8e726aacc07a772ca478d0ee3df..5a16f4c2b346b314af3d614266e1ca034057e643 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>> @@ -115,7 +115,8 @@ camera@60 {
>>>    
>>>    		port {
>>>    			ov7251_ep: endpoint {
>>> -				data-lanes = <0 1>;
>>> +				clock-lanes = <1>;
>>> +				data-lanes = <0>;
>>
>> Is it really this way or the other way around, clock = <0>, data = <1>?
> 
> No idea actually, on the schematics the lanes from the DB845 are :
> 
> CSI0_P/N -> OV7251_CSI3_LANE0_P/N -> MIPI_CSI3_LANE0_P -> SoC
> and
> CLKP/N -> OV7251_CSI3_CLK_P/N -> MIPI_CSI3_CLK_P/N -> SoC
> 
> So I assume the data-lane is 0, for clock-lane I just used
> the example, but I found nothing in the code using those assignments
> 

It's a sensor property, and OV7251 sensor has the non-selectable clock lane.

If it's technically acceptable, I would rather suggest to deprecate and
remove "clock-lanes" property and hard-code "data-lanes" value to <1>.

By the way, this particular device tree bindings miss bus-type property,
it could be either MIPI or LVDS serial output.

--
Best wishes,
Vladimir

