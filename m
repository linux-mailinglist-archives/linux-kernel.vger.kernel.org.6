Return-Path: <linux-kernel+bounces-311066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC23968479
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0969A1F21D8C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFAC13D503;
	Mon,  2 Sep 2024 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCHVdbly"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F70261FEB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272396; cv=none; b=c+If2QqyOGEvwbxFFTlIZDSNnuO1XYDQQ5xCFtqDT1bsCjHBXFl+fKKqJ7UQ18BYBXt7L/tA7/HAfxIzeOt+w75K+tlELXc9qR10vKN4OtoOGeeO+/0vKhDclDAFLwu9/4F/elUgGV5I6Iho+A+eVwEtYB30SoBaYXplmlVdP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272396; c=relaxed/simple;
	bh=M5Dk1DR76FCutQXB41Y8ZbzvG44gAJn5FSu1u6qiuS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rq2RXo4uWzqWpf2MDfaYp9uDqb4K2EKSrDSYn6gDXzG8SI74IcajPw8cn6RxJJXcJEaiYJL3zJv9Lcje7aM04v4mEW/cByY3eCd9EL0iRQuO4WqWmnzsGcEjFejIAyt3x3/RydRZ4J6NnufkFt8j8DDCSm66py9VOaA7xVazWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MCHVdbly; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374d1dd1e75so687f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725272393; x=1725877193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yB0m1PaaQZ5aM1VaopXlx4ZLr5GQtRTo/OSTIwNnsfo=;
        b=MCHVdblyWvaz6Ya1/9dJ9kN8AlQfhnbBpNoXOsw0Ew6W0LhEKZe23dLbj8Jt8Gi1Kt
         rrtrK87ls3lNQKzhwkK+KgbNz+eV5ONHIL332D1jVETKbUn0WAg8MzRp38veJSH7DjJS
         VdnVrzeF3KD/D2sg/JWCpMfh3u20nNJfSkmTcrpwa1b/r3BEfqr83k85zfeAfhwAj2X0
         GxSmwswD+iITmcZkAtMgn7mKPzga42BZ4Jg6MmhOhXTjGCVko+vMycvQdFkrOz71J3lP
         /8lRBIyWkrnWgrLANWCUNS6EqrkmJifegWOm2lQLFaTeBBKSjCVI+0/CyzfEZSCLyUgk
         x9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272393; x=1725877193;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yB0m1PaaQZ5aM1VaopXlx4ZLr5GQtRTo/OSTIwNnsfo=;
        b=b9a7wOAUWdfJrAY11TqCSXu96IPBTjPN07gX6cyBdG8m5GJlXmI2ErAkMOPYc6P7Jd
         be+zD4UPL+NkF0Vn+/2bZsfRNEAcOgqRUPCaKBjsVq1hqNlPcLqQJRhIqjHrDtEXIhZs
         VT7D/BRfqqovHXmD2OYiXY1liesOvySG76yXkRuG0XiGQOjnIr7tz0+s4QXw+Og+TiLI
         tZAN4jUkwkFR3YBHh14ZkLZ31E1sl9KXC/FL3fmzEpA07xvOPh13g4EhD2fQAWVQpHPS
         fURKaFiS8VEU5HWSJWQOzhdHT5FUYnp/zUn54CfMf48VOGY5hF6jgmpyujRYFY+pXbC9
         TMFw==
X-Forwarded-Encrypted: i=1; AJvYcCW+0r0hmemXZAgcGpi3da+UnhRrRUVZDgxRFPl1fwz50X7LOgcMy55kz4R28Y0y1NYDK7ZJyW4jCTaGc9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7aT7b7ohCfYRIS2AgmmV7zipH8uWHQYUHGrDI0fHaGUXy9qz
	/wYJJLxuIViyLpQzkAd+j9aXqR7aOZHQ0K0nR0uiLLaK2DKBJxDJ5f2b/xhPrWs=
X-Google-Smtp-Source: AGHT+IGghnVNFM35t4xUZUUsLVLz8sb17LpnDS62KKdW6kZiRcsgHzzg6aJ9AUskGiV9JDyUlEWMMQ==
X-Received: by 2002:a05:6000:2a5:b0:364:8215:7142 with SMTP id ffacd0b85a97d-374a953f858mr3766027f8f.1.1725272392716;
        Mon, 02 Sep 2024 03:19:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4a55fsm10997734f8f.10.2024.09.02.03.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 03:19:51 -0700 (PDT)
Message-ID: <7fbc4549-79e0-4fb0-9468-41a0babae95a@linaro.org>
Date: Mon, 2 Sep 2024 12:19:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-var-som: drop unused top-level
 compatible
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
 <PAXPR04MB8459FB36872E71E1605DDC2088922@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <PAXPR04MB8459FB36872E71E1605DDC2088922@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2024 12:13, Peng Fan wrote:
>> Subject: [PATCH 1/2] arm64: dts: imx8mm-var-som: drop unused top-
>> level compatible
>>
>> The Variscite VAR-SOM-MX8MM System-on-Module cannot be used
>> alone without motherboard, so drop the top-level compatible field to
>> avoid any false impression that such usage is possible.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
>> b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
>> index d7830df5b6f9..cdfacbc35db5 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
>> @@ -8,7 +8,6 @@
>>
>>  / {
>>  	model = "Variscite VAR-SOM-MX8MM module";
>> -	compatible = "variscite,var-som-mx8mm", "fsl,imx8mm";
>>
>>  	chosen {
>>  		stdout-path = &uart4;
>> --
>> 2.43.0
>>
> 
> Should the " variscite,var-som-mx8mm " also removed from
> imx8mm-var-som-symphony.dts?

No, why?

Best regards,
Krzysztof


