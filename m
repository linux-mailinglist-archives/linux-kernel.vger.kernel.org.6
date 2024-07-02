Return-Path: <linux-kernel+bounces-237627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9085923BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231921C23FB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6136E15B0E8;
	Tue,  2 Jul 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFEr1G22"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EB115A849
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917235; cv=none; b=YcHsMFcpv9nXBni/mERj268E+MMyHIKZSuXe2m6CsUzYPngg63lMOKFKnvTINYIweCJqHeUJy1aTulNlGZO3ov+G189O0jIncOGLWyGgn3I64cWJ0+tCw4nmJLQeuVMhGODQDxd6acFnpss4Z4SyCZg+fDgqegkKmvodzimvx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917235; c=relaxed/simple;
	bh=7InumcdbShV1TGz15zBQgZ0+mPGbge1JfKR5C/3XHwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oR4eB5YCsfgVLIM2JwBIk/S/x+y9aHmKVtfNWq8CUqKZhRpzERX6R7yvIc+ed0SlQamIVBwjEO8N4z4iAqucyj4LLmP8ENC0ZYNbKrliB33gVkrB2zkL/7QMSOnEbItBmgiOxTLvvvf1QsbviduAHmAa7nyDLIJh6yci7WcyCGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mFEr1G22; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec52fbb50cso39491861fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719917232; x=1720522032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P92+0FeJgLTWh83yvzOS18H2gViBFUz3gdnOBY11d/4=;
        b=mFEr1G229uKj0uvuWgo5wYcV+OSaPWya0e00YsapS/I5vI5aPniLSuvrGDq/mu8W47
         Ch6FuhKw3XaovNbYv1FEt+UejWJf5Owl3f9RFSU7/t+NK5Z/HuhrALagZG1SQ6xOqaLW
         JzUjfEqSV+orwPEjwqwXePFW3/3pM7f2INZA6pInVOFDJlX5t2ROoSVwPJEJIIDcDmTD
         9CfPxT2bQ7848xRrZK9DddrytoluCO8A/KZaNuGvyYkRik+q7A2jyivO8ayYZjvirmri
         6N/jF9qjeauWPSJEgLD+gbg7ntShmKqKmA/sVOUSNxVXuo3fzB0FG1RJ9eS5ZUwJmkeJ
         7Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719917232; x=1720522032;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P92+0FeJgLTWh83yvzOS18H2gViBFUz3gdnOBY11d/4=;
        b=l66Z3cf/9RReAKnT0LIvodxnrv8A7QThjQwgOxheNBI5QOsPgGBqEoNpUaqoaD4WPw
         3vc+uChTMy+fS7+XgJKFusohx328pHCDaaBIL8DUfKzS2L5RGEruBM/TMaVWBNVKXcFE
         mxrlQ/yZ67MWCt8OzDsgCwam7zmhcRZXS7zrfkcklQ4rcOR5ycoyYuBYdYe6bt5dRW6T
         gi90cxFNIl9cy9h93kgN9lcuF6VS1O5YKZ4qbDUF2dW9VpehV6roepKwZ5qRez4qicyI
         Jn3rDgadknshsgzJHJGMzyHBpkpRYrybJBq88phTj9CTTpHzVoNCEEJVQta21HN2jE53
         38cw==
X-Forwarded-Encrypted: i=1; AJvYcCU9oSgKCBQFEfOq4YJ9xM2PFj3JlDVFIJWBVAWqyQ6xaFm7EEJIx8KeFCmh4YOx2wAE5M3vRND6IGf9q7orVmeq6vOCCNqAhg6b+yVk
X-Gm-Message-State: AOJu0Yx6zFhvszJjBncN3/byvnmEh1Jgj5Z8yWbnhKHC9duesS5faa8g
	HKTgeuQ8L25U9eAxw8CMhY0U6AJTZZHkmns5UuW8q0jj30EjG6eVMWT0TdiklQA=
X-Google-Smtp-Source: AGHT+IGsyY8yXpt8X5axUiNk+A3akY1RMqxa/35yt/ICICyWTKIxiqpZt3x3eK+iUQN8LDGEn+W8hA==
X-Received: by 2002:a05:651c:b0b:b0:2ec:56d1:f28 with SMTP id 38308e7fff4ca-2ee5e3b241fmr62678771fa.26.1719917231561;
        Tue, 02 Jul 2024 03:47:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324eb41sm5539498a12.30.2024.07.02.03.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 03:47:10 -0700 (PDT)
Message-ID: <d7281992-821b-4eee-b028-7402a58524e3@linaro.org>
Date: Tue, 2 Jul 2024 12:47:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] ARM: dts: aspeed: Add IEISystems NF5280M7 BMC
 machine
To: George Liu <liuxiwei1013@gmail.com>, linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au
References: <20240701105259.972135-1-liuxiwei@ieisystem.com>
 <20240701105259.972135-3-liuxiwei@ieisystem.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240701105259.972135-3-liuxiwei@ieisystem.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/07/2024 12:52, George Liu wrote:
> The IEISystems NF5280M7 is an x86 platform server with an
> AST2600-based BMC.
> This dts file provides a basic configuration for its OpenBMC
> development.
> 

...

> +		i2c613 = &i2c6s1ch3;
> +		i2c614 = &i2c6s1ch4;
> +		i2c615 = &i2c6s1ch5;
> +		i2c616 = &i2c6s1ch6;
> +		i2c617 = &i2c6s1ch7;
> +		i2c620 = &i2c6s2ch0;
> +		i2c621 = &i2c6s2ch1;
> +		i2c622 = &i2c6s2ch2;
> +		i2c623 = &i2c6s2ch3;
> +		i2c624 = &i2c6s2ch4;
> +		i2c625 = &i2c6s2ch5;
> +		i2c626 = &i2c6s2ch6;
> +		i2c627 = &i2c6s2ch7;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8 earlycon";

earlycon is debugging tool, not production, drop. This leads to totally
redundant bootargs, so drop it entirely.

> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +

...


> +&i2c2 {
> +	status = "okay";

Missing blank line (everywhere)

> +	pca9546@70{

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "nxp,pca9546";
> +		reg = <0x70>;
> +		bus2_mux70_0: i2c@2{
> +			reg = <0>;
> +			tmp112@49{

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Everywhere: missing space before {


> +				compatible = "ti,tmp112";
> +				reg = <0x49>;
> +				label = "Inlet_Temp";
> +			};

Missing blank line

> +			emc1413@4c{

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "microchip,emc1413";
> +				reg = <0x4c>;
> +				label = "Outlet_Temp";
> +			};
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	multi-master;
> +	status = "okay";
> +	ipmb0@10 {
> +		compatible = "ipmb-dev";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +};
> +
> +&i2c5 {
> +	bus-frequency = <1000000>;
> +	multi-master;
> +	status = "okay";
> +	pca9546@70{

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Above comment applies to multiple places.

> +		compatible = "nxp,pca9546";
> +		reg = <0x70>;
> +		bus5_mux00: i2c@0 {
> +			reg = <0>;
> +			status = "okay";

Where is it disabled?

> +			vrmp2888@76 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "mps,mp2888";
> +				reg = <0x76>;
> +			};
> +			vrmp2888@72 {
> +				compatible = "mps,mp2888";
> +				reg = <0x72>;
> +			};
> +			vrmp2888@62{
> +				compatible = "mps,mp2888";
> +				reg = <0x62>;
> +			};
> +		};
> +		bus5_mux01: i2c@1{
> +			reg = <1>;
> +			status = "okay";

Where is it disabled?

> +			vrmp2888@76{

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "mps,mp2888";
> +				reg = <0x76>;
> +			};
> +			vrmp2888@72 {
> +				compatible = "mps,mp2888";
> +				reg = <0x72>;
> +			};
> +			vrmp2888@62{
> +				compatible = "mps,mp2888";
> +				reg = <0x62>;
> +			};
> +		};
> +		bus5_mux02: i2c@2{
> +			reg = <2>;
> +		};
> +		bus5_mux03: i2c@3{
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +&i2c6 {
> +	multi-master;
> +	status = "okay";
> +
> +	i2c-switch@70 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c6s0ch0: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			eeprom@50 {
> +				compatible = "atmel,24c256";
> +				reg = <0x50>;
> +			};
> +			pca9548@71 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "nxp,pca9548";
> +				reg = <0x71>;
> +				i2c-mux-idle-disconnect;
> +
> +				i2c6s1ch0: i2c@0 {




> +		};
> +	};
> +};
> +
> +&i2c7 {
> +	multi-master;
> +	#retries = <3>;
> +	status = "okay";
> +
> +	adc128d818@1d {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "ti,adc128d818";
> +		reg = <0x1d>;
> +		ti,mode = /bits/ 8 <0x01>;
> +	};



Best regards,
Krzysztof


