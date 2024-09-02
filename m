Return-Path: <linux-kernel+bounces-311069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDA6968484
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8161F22082
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6515FD13;
	Mon,  2 Sep 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7+6kU3i"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406713F43B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272433; cv=none; b=E7xgufJ8CZYM6PPWYAj7xbC4k3Ibyu3NrkrvFYQ5Sow4vRhWrlhGRTlb7ZsaDHBOqRRrl46Ju2xh3E+clUXnrgZS9Ouqa2bzDNURdHnGUEZCeYzfRD1e/DTZnXRV7wfVl2XbKOTMROb7zb7hvrMPmnbXehAHmEU4GUm41eDtFCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272433; c=relaxed/simple;
	bh=m2+SbPzms8UxM+xJL/ev64HbjIgPl7KAqZRsS7pn7eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r8scw+005vCBBzEwocJrczikDI44BWRfxPDWC3crzzYCQIdT0K1FXCztuMvBD63X57AGo288lDxyV4J3ZNVdlOQJ50eI6WvWnoDK2n3Z4jXYuSXhG7/YflwXbUAMcfB+N+sigxScXk6ypsEdMXOp5JMaZ4AGgSFDbr9NWejcnDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K7+6kU3i; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42baecbd4fbso5747335e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725272430; x=1725877230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vRSKkhAdeleXt0LAg5y5qL40UQ/77V2R6wYH8YoUM0s=;
        b=K7+6kU3iJa6LEPNbbcyRijt4UlnHCvgwBsDbdBwwP9mesu5kNzz0elwtRQBbLPvzeo
         C34sx8mPn65HIkZcov23qEUX4txpmcs8v8jrm4kP8EIUYKQhr5KhAhFFSWG4wEhgE6u1
         pxU0dq0++f+zmGYgIIf90mn8Lw/4lJQfIvbqOYuYxFT7GjCs1Z+tBHl78NkKV/8doyYm
         dQaf6G/Wyjs3sSEva8tc+coG9RESMgS1o9luLfS3nEN4BeXxcugHdQji7iCWKM2i9jy/
         s5GHS3BkqCcPsVeotGS8jNAklfSCcHLhpTUYe3O+37OFcFwMeb901AjL+YKwNTjc58d6
         BDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272430; x=1725877230;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRSKkhAdeleXt0LAg5y5qL40UQ/77V2R6wYH8YoUM0s=;
        b=MIaWrKb7i9b44OfWuMXcxtGVUCsx9PyX4Aw8LQNigGXOzUzdi7dOP8/sqXP/+HifvU
         /rP7niq9p10wZ8OvpX6k4X7Y8OtSRdHbDvTa98OnYh0ploZpwvp1JLGT2JIrQbP3GkX6
         RqeqwQ5cc1t1dAnWtXNYi6UtCWD/zc6Vnoi9Jz0J37yTL9u57aI8AW+nUqveMOenN+DT
         ByGbPem6vWvf6vaAip9DFN1E6FLdNYZSL6PYXJO8yZqaptOPXE05tXcsl5MTaXQ5RgVr
         5b4sMmqNTw/TD28r6ADQ2BMiF2yZsnlupXbmTUmaxvslhGCsCu5kDxFqXdgbEYEjIQWD
         AsUw==
X-Forwarded-Encrypted: i=1; AJvYcCVb8gaiTlnrjILRXb+8Q+y40OFqqxuuq4sUAYcfq031Lx/uIeD7/pLl2TKV2+R2A8Zj3gcCREjYGeHc3Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX/Ky4o+/6CIn3yNPvM8qgThEGVWP/MzENZ0GRTTcgpUXDy9g1
	+B2OgTdVMtS4tmeLRzlNxOeFo8+uwz5Cfvi3PjcfX/ywtN6PtQZ01EA7hkkanh0=
X-Google-Smtp-Source: AGHT+IGjtdOTho2XQUieF5n90G9IGbxC8GYlG09ryb+5aH9rGBOQeeQHSZh6Pjs3rtK+CDlStyH+jQ==
X-Received: by 2002:a05:600c:46c9:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-42bbb43423dmr38592725e9.3.1725272430441;
        Mon, 02 Sep 2024 03:20:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df100csm132306735e9.20.2024.09.02.03.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 03:20:29 -0700 (PDT)
Message-ID: <91ca3ddc-c33f-45ca-b55a-0e0d4a8835a4@linaro.org>
Date: Mon, 2 Sep 2024 12:20:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: drop usage of VAR-SOM-MX8MM
 SoM compatible alone
To: Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240902075220.27971-1-krzysztof.kozlowski@linaro.org>
 <20240902075220.27971-2-krzysztof.kozlowski@linaro.org>
 <PAXPR04MB84596E0C1F9ED62F6A5B5FCE88922@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <PAXPR04MB84596E0C1F9ED62F6A5B5FCE88922@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2024 12:15, Peng Fan wrote:
>> Subject: [PATCH 2/2] dt-bindings: arm: fsl: drop usage of VAR-SOM-
>> MX8MM SoM compatible alone
>>
>> The Variscite VAR-SOM-MX8MM System-on-Module cannot be used
>> alone without motherboard, so drop the usage of its compatible alone.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
>> b/Documentation/devicetree/bindings/arm/fsl.yaml
>> index 1abdeb804468..e5f982fa750b 100644
>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>> @@ -953,7 +953,6 @@ properties:
>>                - toradex,verdin-imx8mm     # Verdin iMX8M Mini Modules
>>                - toradex,verdin-imx8mm-nonwifi  # Verdin iMX8M Mini
>> Modules without Wi-Fi / BT
>>                - toradex,verdin-imx8mm-wifi  # Verdin iMX8M Mini Wi-Fi /
>> BT Modules
>> -              - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-
>> MX8MM module
>>                - prt,prt8mm                # i.MX8MM Protonic PRT8MM Board
>>            - const: fsl,imx8mm
>>
> 
> Line 1072
> "const: variscite,var-som-mx8mm" should this one also need removed?

Of course not! How is this related to patch description?

Best regards,
Krzysztof


