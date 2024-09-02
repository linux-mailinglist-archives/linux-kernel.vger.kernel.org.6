Return-Path: <linux-kernel+bounces-310774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23173968114
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 538D7B22F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A163317CA1F;
	Mon,  2 Sep 2024 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTTgYIKY"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565D217CA12
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263737; cv=none; b=XSi99P4Wurhjh3V/MdDTL7Vwsxnp4dAMjv/w0t6e2RgJnZHhYtF7uAd4aXFjXa40ntwJSlhBgddNfDtlXXocl6EtZiTP2xtKQxCcnhbKarO1JgUbTx13/zOKIz+0/LQvBNlYj1WzH58AB81F5+CDEZtUfEetygyqgpS25NFVSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263737; c=relaxed/simple;
	bh=3+NvHpXWUhV34JFpg/YYDT7z5d90sCQDzNAkE+jlOOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEe+Jji5rKVzGIKI8KELDaCZ48EtA99fQOPM++hCoDNOS+4dAl5wrNJZHMOWwkV2dequKFYrdy/FsXpEunSUqhpmfagRDPWFXohqaK4kEU8i1WU+IjwvAILjvosUUr4yXavbvv5cS4BOWIocOVipTaQDL8Haxbe4qCYIz/2GjQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mTTgYIKY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bbad294edso4204745e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725263734; x=1725868534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rVHeSvOsjcFgyQRO3CEGc6rEIBqlMXjEN8vkm65mcb4=;
        b=mTTgYIKYhSj5sUW8VqCEfheDRkHItGM7ZDoDw0I8PmS2uxHxun0NMHLxy6fQBmTeay
         Ug1VL7M5YSdta6YCdEVD8t8Kee9IFAykrT6ADTA5u/kbQdHes4ZZW3iLFitdkXgm2mpT
         3+WPiW5UF+3BcZn6r9FcAzys1+1RUTSCWbYqSWZ+5WJ+d+TnGkXKx3OM56hMGldnHdPi
         gw36RpnkQh29wl9o7lriL2pBczKRan9qc2DaqEPJ/WqH/f2QhScIJ+N4OyOz8so0+Iwy
         SWQmIpjyR55Pybcudm13BhjGUZ9hROZG5Wtnm6mSuwKHjiv0u2KTklC7DxLfn6YtMJMN
         Uy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725263734; x=1725868534;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVHeSvOsjcFgyQRO3CEGc6rEIBqlMXjEN8vkm65mcb4=;
        b=tt+Ddof7qFL22JCIUJglr3feGrOopwyeA/CD5GO1KUgZXlawzgxu7clImO+u823dEi
         lv4mKjva5mRD8cU9J+XMFWyiN6E3yELP8BVSzH95Q9WCbohFdBHOGKwq75v+e8+V3ZJU
         nAoYmNPsOXwo7D1MOeGK2dh7kOT12zr87gKq1g/aFaRskLMaMClxUWG9Xm0TCfIFDLLb
         UvhvTQ6/G+bgCuvZvA+CcR5hbBZ7EmapakBC1t0bOtvxc3P5RBvqjul8sG5K6j0sm6Pj
         VYwgwvT6ijxC+IXWuy69QgbuRYN586IBLHIqt+QsaNlnbGypQJgjPJmkWzdZJS0bU4g5
         N+pw==
X-Forwarded-Encrypted: i=1; AJvYcCViXzCC2Fbn5DIrEM4ekmKLEzWB5dX/eNf0KpkS6MBft7VXLVpoSMPgqMQ/XbZT2jog7xgo+PkljsJIVMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfBYnEBSpk7xJHi1UECMExUcs4Z8/tlIfjhjLIUsrS1UtfgLf
	77svT8zA2ei6brkfvJsWJ+OBaiqgYyAfvLf0K4fLukf84GzuwzO0beeFDROGfUY=
X-Google-Smtp-Source: AGHT+IF7I5/Aes0I9gaYvVF8BwgDnE2AyqOcEdSi1kgWjC9aERe/N9fbMgUCJ3HVAqUpK2LxOD+sUA==
X-Received: by 2002:a05:6000:1f84:b0:367:4d9d:56a6 with SMTP id ffacd0b85a97d-374a9534480mr3935132f8f.1.1725263733518;
        Mon, 02 Sep 2024 00:55:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c602bd97sm3794831f8f.20.2024.09.02.00.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 00:55:33 -0700 (PDT)
Message-ID: <0035a39c-4e9e-4ffd-84f3-dea4835e95c0@linaro.org>
Date: Mon, 2 Sep 2024 09:55:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ARM: dts: imx6qdl: align pin config nodes with
 bindings
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240831-dts-nxp-imx6-pinctrl-v1-0-f5811032bd40@linaro.org>
 <20240831-dts-nxp-imx6-pinctrl-v1-4-f5811032bd40@linaro.org>
 <ZtUPRciha9lSbraF@dragon>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZtUPRciha9lSbraF@dragon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2024 03:05, Shawn Guo wrote:
> On Sat, Aug 31, 2024 at 12:28:21PM +0200, Krzysztof Kozlowski wrote:
>> Bindings for other NXP pin controllers expect pin configuration nodes in
>> pinctrl to match certain naming, so adjust these as well, even though
>> their bindings are not yet in dtschema format.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---


>>  
>> -	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
>> +	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
>>  		fsl,pins = <
>>  			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x170F9
>>  			MX6QDL_PAD_SD1_CLK__SD1_CLK	0x100F9
>> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
>> index a1ea33c4eeb7..79d80632ee45 100644
>> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
>> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
>> @@ -436,7 +436,7 @@ MX6QDL_PAD_SD3_RST__GPIO7_IO08  0x13059
>>  		>;
>>  	};
>>  
>> -	pinctrl_usdhc3_100mhz: usdhc3grp100mhzgrp {
>> +	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grpgrp {
> 
> s/grpgrp/grp?
> 
>>  		fsl,pins = <
>>  			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170B9
>>  			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100B9
>> @@ -451,7 +451,7 @@ MX6QDL_PAD_SD3_RST__GPIO7_IO08  0x130B9
>>  		>;
>>  	};
>>  
>> -	pinctrl_usdhc3_200mhz: usdhc3grp200mhzgrp {
>> +	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grpgrp {
> 
> Ditto
> 

Indeed, Thanks. I'll check if I did not make same mistake in other places.

Best regards,
Krzysztof


