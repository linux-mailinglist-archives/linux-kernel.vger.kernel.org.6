Return-Path: <linux-kernel+bounces-237609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B468923B71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C1DB246CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E5C14F106;
	Tue,  2 Jul 2024 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kfali7qx"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B217BBB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916279; cv=none; b=kpSfsRgW6jvA/Sh0MkmkJvpVVdjrlNf9mrzM3EcQTVwQRdlVjhZZCo+YjZc54mbKkuENQgKvruGtq5dovEo8cFvgt9dZ/sU03s6drFVAG7WWlaN5Xl6i15Zb923Gz1Eh+la+q2tpNuPNKbRtDZewJP0JTITZMh4LlnSr8LeFOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916279; c=relaxed/simple;
	bh=4XkWRxS8gQzIhSxHYHXVO0KvUZqxEsIcpzs4WUYWWuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gTaxwHy7Suz+dQqstsU1RQ4Ka9hspVrQ2fLdtbBKoCu5qvk1ywq5qcbinKdnJPPZh6EUvK/pM9gdrrvj7gtUv+tu0bVtFEc7QzA06QDa49cBLaQHVJsJhgzR38bdR6SG5IVA2p1tfdUaVq1DkEX2Wf0mNnCUCaxOJ4Eqa6NJ/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kfali7qx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-363826fbcdeso2343628f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 03:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719916276; x=1720521076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KX/CV+BafaZtGxH5Mjsgnh3IcFAlgk53kLYncqSGovM=;
        b=Kfali7qxenf+G8R+dQdheiZ+QuyUOPKDTtiOklpG/B8q6HEhzlgkOtLO7RSAh+T7zP
         Y5+lypXnPuXOaOGwdet716Hg7Qp8odRoQa+tEezhwp+x7jFtsZSni+vxnEtCHLAfFusR
         7I84GCCnrwgQ6HP1ESsp9K3SQHLoozSX6dU8hGCi6/yHz5Rgk7YXcXKA9RjiHg3TG0EV
         MoxAbjBFuw966sZCtz3D0ifvqwtvRMo+k7pq9wGO1sAIlSpVByyCZY0Gp5gSEzc6bG1s
         Guh41ZGhl7vj5icgHoXkTxCWTxkyP6R27qBV9leLGY7DFSbUCDRoQnayVHpLjdR+2RsL
         hoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719916276; x=1720521076;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KX/CV+BafaZtGxH5Mjsgnh3IcFAlgk53kLYncqSGovM=;
        b=GhK5B3O2ZApMMM3MQZMJOpGOlnRsPkBecDO6evxhB+KXiOO3aqbaFhaF1R2UDdO2dv
         PrMfzR/IYHWOP8ZIc9yGzKMTxsyXu8GDp4XMjm3ZcX4uTw6Icf8wONAeXzTXHblMgMtv
         B2ZCIfpfnjPpz567Sv0KyGA7nDgvu0XZMb5VlObAZ23f8y4kBeTE85/DlHaY/laCZZId
         ZUzVmYPF8fm9LOxLJp7Bz+VlYqqSi4kdRHVOEgI1W6/ZjJxwdMWcriwar6i/cPmyKve9
         FDHDSJmMGpJdH52zsArFEla9Q5Xy+UFsDl0TkgcIFhYowmTJvvFJsyZtAgoHiAqMlwBy
         ic9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPcguwOn4i+X4RfWyRj6Jyz9M1TI5jPFZytrMGHw/zYuJtp5S9i7AeiIa0X856BVIj9c7JJNP+57/wXtFhLUxp/i1hs3ZUwJlCIef+
X-Gm-Message-State: AOJu0YzOZpxrS4hctHK8VVVfYxeJbWNcDfLoxUg+ECREliTrnuqtuqja
	tla/IqQ8eXr7/BfuBHGSO+/84FSiG+shVKdlBcAszKul1SBCBItMbAOq0Ub3B4k=
X-Google-Smtp-Source: AGHT+IGWTlTgSoMaweNJKgDsmD65dpxbQY20CmLW0uDd3FKwBaGVW+Oo6wW8VSa9QA65v5aDz8GrUw==
X-Received: by 2002:adf:e749:0:b0:364:b779:9484 with SMTP id ffacd0b85a97d-36775728d05mr4934373f8f.60.1719916276242;
        Tue, 02 Jul 2024 03:31:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb9c1sm12909978f8f.74.2024.07.02.03.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 03:31:15 -0700 (PDT)
Message-ID: <b7cc46dc-8ce6-45d5-a320-63fdce4967f9@linaro.org>
Date: Tue, 2 Jul 2024 12:31:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: at91: align LED node name with
 bindings
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240701164952.577277-1-krzysztof.kozlowski@linaro.org>
 <20240702-expel-unflawed-b174e82e27c7@thorsis.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240702-expel-unflawed-b174e82e27c7@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2024 10:51, Alexander Dahl wrote:
>> diff --git a/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi
>> index cdd37f67280b..fb3c19bdfcb6 100644
>> --- a/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi
>> +++ b/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi
>> @@ -120,13 +120,13 @@ rootfs@800000 {
>>  	leds {
>>  		compatible = "gpio-leds";
>>  
>> -		pb18 {
>> +		led-pb18 {
>>  			label = "pb18";
>>  			gpios = <&pioB 18 GPIO_ACTIVE_LOW>;
>>  			linux,default-trigger = "heartbeat";
>>  		};
>>  
>> -		pd21 {
>> +		led-pd21 {
>>  			label = "pd21";
>>  			gpios = <&pioD 21 GPIO_ACTIVE_HIGH>;
>>  		};
> 
> In this case these are all gpio-leds and the pattern is in the
> leds-gpio gpio binding.  I'm wondering however why you chose the very
> generic 'led' match over the more strict one requiring the names to

match? Which match? I did not write the match pattern in the binding, did I?

> look like 'led-0', 'led-1' an so forth?  The generic match would also

Works for me too. The easiest was to add led prefix. I am not the
maintainer of this platform, so I am doing just some random cleanups and
prefix is the easiest cleanup.

> match names like 'knowledge' or 'controlled'.  But besides that:

Best regards,
Krzysztof


