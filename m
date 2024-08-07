Return-Path: <linux-kernel+bounces-277425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06394A14C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604C5B20F67
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E41BF311;
	Wed,  7 Aug 2024 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBjxDnLC"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D11917F1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014117; cv=none; b=G98kl8IB+IDttjmkXI+oXqhnXMX8QdSA15WsohmP7pX2gzIZQVBX0HGmBbGqxtf/BmOdLxsI5yGaYnv/deGTBRbwb3ELPhs2a9Ra7enzDBOSBK8GkpUEgx9qYbU6ZGeGCEdWI0LAGZMu9SgsTJYqEx5UgCtSvhHXmPtRDiUurr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014117; c=relaxed/simple;
	bh=av+yhOilfbWKeFpOG6RbWtFK6IsS2/pamAjLRCRBXDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0MuOjNz7WWPP1gXCQ8ed8+EsV0vCXPMTkoiCF2z+f2YB/4BBl2sBKPnNU6BQrMGUYcqCnr8J27DajAC3H5oEaxlkuTJUzbbcbaPaSozxwXKjJ7lAIDAiv/Fsoejr/WdxqRmfDfPBQWfjuZ5RJleSg2ASrD5UO3rOSWVpcrCWNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OBjxDnLC; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso15856561fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 00:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723014114; x=1723618914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YAXW1jLrla8ijt9mi/dpWXVSNou305aEMISH8Qz9pDc=;
        b=OBjxDnLCDly+uabmDPLp1x2pOXYX2UTx/g1M07gl66VoI99wBaBsnhvTU642j6EmJc
         x4LFIq6HesKO9UHGXwvukCQLaVm9iZrriz+ol25KPAvh1fm20nwZPMqzSV9rkHj8l/hc
         B8k9UvF2LPFmLL3i8kaoVsIP36bIKaAnZ0mngsQbIaCjHE2cOsue1Vu35tz5PfJYetZo
         qi0Wvsb01bVv+GCgcKTYCif3amMrxOXrgOPzc87hdCKog7Z6Q7K0sqQiwnt/+DbXdjHi
         FeqjeuMQcnr9eRg4iiIqpu+rkeXWT41YIqT4qgPO1ZT/m3Dlcy/ZOk999SxVH18eiCAZ
         V1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723014114; x=1723618914;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAXW1jLrla8ijt9mi/dpWXVSNou305aEMISH8Qz9pDc=;
        b=C1puWNRx9IRQbYAnmUBIeAVepLJ4GGsDUmfU12jgBacJCOUQQmgVRHM+/DuG120pZ6
         qJuYEgYQ1Dc/Lmkc2ab99g5Cl7D9fwyBcgR05OwigJWVxLGQPp3FIlOxVLZLXmG+pE7b
         TESnroNtNrzHkKMNbpxTjLyHw0xNVgUkMCYS6WW3Hx/NPJY3zaypwhHIc55otRsTU8k5
         LHp91HmAQjOA/8rFrhou/Cg6jXrWNMPnCW2Uvgd9K7biwxmKNg30I3Hs9sN2Z1LjUMFw
         j0JTgNQPrCgTnz9xhj02Lf/adwis8mkZGbLr5KGyxKPls9NwTfXQo6kUB0D0y1ib1Bcc
         NnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv+OWXydIySjZMef22GtW+dv8oM6xnTQ/RaL74rvU5SRkzeymQN+QBYCluCViSKGWIkMWpYyrIJNaVU2w+JhqLoPkIufQEgiSKA49z
X-Gm-Message-State: AOJu0YyYZOpYnnFjkfReWOCDpLyItVMqQeEkiib7lmPxdvo3hGBroBbD
	wWMV1Htburcau1olHXIS1TjIaz6DnFQqZZikii97ze+GpjgUrE7oQR73qmTIfTc=
X-Google-Smtp-Source: AGHT+IEhqkgC65vo0kh7KsKYLQ2+XSZm4JrXvwLGtjt9W3pwge4ImAMPw/K1N/FgVlqtCs6CCNh7+Q==
X-Received: by 2002:a05:651c:212:b0:2ef:185d:e3d7 with SMTP id 38308e7fff4ca-2f15ab06524mr106390061fa.38.1723014113521;
        Wed, 07 Aug 2024 00:01:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290580c720sm14265135e9.41.2024.08.07.00.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 00:01:52 -0700 (PDT)
Message-ID: <41aa85d2-a84d-4fea-9d48-ce137437203d@linaro.org>
Date: Wed, 7 Aug 2024 09:01:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clock: fix C3 PLL input parameter
To: Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240806-c3_add_node-v1-0-c0de41341632@amlogic.com>
 <20240806-c3_add_node-v1-1-c0de41341632@amlogic.com>
 <b63fe216-ee29-489e-a175-e1525ac12722@kernel.org>
 <86b01ecb-6ca8-496e-b3a8-0b21bb951a60@amlogic.com>
 <2da06dac-7a1a-461c-956d-13b74320723e@linaro.org>
 <43a600fb-8094-414d-8a3c-0573286a11f7@amlogic.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <43a600fb-8094-414d-8a3c-0573286a11f7@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2024 08:40, Xianwei Zhao wrote:
> Hi Krzysztof,
>     Thank you for your reply.
> 
> On 2024/8/7 13:44, Krzysztof Kozlowski wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 07/08/2024 03:55, Xianwei Zhao wrote:
>>> Hi Krzysztof,
>>>       Thanks for your review.
>>>
>>> On 2024/8/6 21:10, Krzysztof Kozlowski wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> On 06/08/2024 12:27, Xianwei Zhao via B4 Relay wrote:
>>>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>
>>>>> Add C3 PLL controller input clock parameters "fix".
>>>>
>>>> What is "parameters" here? Why you are adding it? Is it missing?
>>>> Something is not working?
>>>>
>>> Yes. The previous submission was lost.
>>
>> What submission is lost?
>>
>>>
>>>>>
>>>>> Fixes: 0e6be855a96d ("dt-bindings: clock: add Amlogic C3 PLL clock controller")
>>>>
>>>> Why? What bug are you fixing?
>>>
>>> The input clock of PLL clock controller need the clock whose fw_name is
>>> called "fix".
>>
>> Then explain this in commit msg.
>>
> Will add this in commit msg.
>>>>
>>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml | 7 +++++--
>>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>>> index 43de3c6fc1cf..700865cc9792 100644
>>>>> --- a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>>> @@ -24,11 +24,13 @@ properties:
>>>>>        items:
>>>>>          - description: input top pll
>>>>>          - description: input mclk pll
>>>>> +      - description: input fix pll
>>>>>
>>>>>      clock-names:
>>>>>        items:
>>>>>          - const: top
>>>>>          - const: mclk
>>>>> +      - const: fix
>>>>
>>>> and that's not an ABI break because?
>>> This is "fixed" clock.
>>> I will modify "fix" to "fixed",in next version.
>>
>> With "fixed" it is still ABI break, right?
>> No. The clock named "fixed" was initially implemented in the PLL clock 
> controller driver, but some registers needed secure zone access,
> so we put it in secure zone(BL31) implemented and access it through the 
> SCMI. but the PLL clock driver need uses this clock, so the "fixed" 
> clock is input as an input source,
> We changed the driver and forgot to change the binding, so we added it here.

Fix your quoting or your email program - I don't understand what you are
saying here.

Anyway, provide justification in the commit msg.

Best regards,
Krzysztof


