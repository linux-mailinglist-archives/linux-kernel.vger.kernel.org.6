Return-Path: <linux-kernel+bounces-259801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC6939D66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1A81F22BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DACF14C583;
	Tue, 23 Jul 2024 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5NicG41"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86629208B6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726418; cv=none; b=SStmki3/cksaC0OlM53C4FDcfSmp/twkeUcgma4T/b58giDEOBpSg7OX+ZraLcWiX8G4bIAuGZ8TZgrTN22iy7XQzuf46kBB8Qx0y1Q43C12qhAe9a+x1z5SEEetu1+Yx4sRfNSVIPghPSUPmvuo6ZBFcGZonW2x3y7ZVox0bWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726418; c=relaxed/simple;
	bh=vd1S0S4R6faJqS82aSi3DxtsxXoZ9n6f3a4hhMMeMgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUSiuZkOQ+52SDkwKnFs38MTr3ft/oI2kxir0xMIhYq++O5CnVindJ7lkV+5sBuYZDgdFKpZfeB/xWrqLF77PdGndnBv9n+BU7ynx8hmYbK+w9uBCAYktoNJHEiAbIFCo1n6pmoBtAgMlNZR5YdoQ98sM4zfUVxtX8SBgVI3npE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w5NicG41; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4272738eb9eso39442075e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721726415; x=1722331215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XeYDV5TDW4TbvqxhWxzkBYg//lQZE+u2Ilm183/T57k=;
        b=w5NicG41jmTa6Y2d0KV7qeDBGnW+qZm3Un6QADFESfT60UqWwp3UQ3YKuIpMZfVa2P
         xH3sV1OH3iwDtKXsV+gU+IVc9bdgqTHRvRMNNr/GqqaOzlskTkEtHdwa8yZQ2zhbLUgv
         ApnqrevM7PA3OkUSDhpSV+wbFyl0z7elplMn39/raJ1zkYafZQ6pjSEJJ0cLS/TX65Ja
         RO7zvn6LapAbCRbkVrXjsqTaH+5BuEFnbkK0nKZcn64Ceho5256+4g2tiWrv+tTst4IS
         GlsOWA8GNCiWBmGtQ2IB6x1NUknx8p9sSy2tAdxQoyO+Fufbpp236b/x9N1GXoFvCB6L
         8DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721726415; x=1722331215;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeYDV5TDW4TbvqxhWxzkBYg//lQZE+u2Ilm183/T57k=;
        b=fKoxNw+PFyCTdsPAD9D4R0NGEqg00RfK7mSfxEBpT2DucOmhZ6N4fjFSM9buobJ8u1
         R5jGrZopipc3MpKNUmlQ1vzA2ypctyYYmn4Kz+hHIMS7Wq3a551vO22fUJehl8BiMs7F
         YhkdxoOoEBMg69QQtpT3AN26z1mxamqY6NJ92uih58SMLn/ogP/x8HCHgXEkqyRwJ+6S
         Ap5ND6Ue+qhdUtwSwdf0dSCnQ2/BCdslT5//fMCSYP4MG0kwqxuHiyVGwYPiggLeXIge
         qjM4Dq34ES/UOmWSW6jtX6zg4oBvWE2F1jwCBbSFN6ByqN9buezLMsonARuAEn8VL+mx
         yxwg==
X-Forwarded-Encrypted: i=1; AJvYcCWjVxZ6lN0slo/gFurX6yswderLFDqMJMaa+uDJdql5xjB4HE2qOQIqKL3kNROy2C61EXW2KzSkBcVQN/6Ue5PuBf/0hqvzJ2Q46gDy
X-Gm-Message-State: AOJu0YzA7LIg5KOXz0Z/GQqj47Iew6JXvDDkMPWT4LAlpFS37yN8DNRV
	F2Dxxm1riil5L1kBs+lDraea/59xZ/8eCrJ5gzcIzxCj2ZbdEws6UUwetyRBD64=
X-Google-Smtp-Source: AGHT+IGaGM/zh7C4o7d9dZHFf5LRLE82JFhtgjU7Ngagi8TJvjn5onrtkMbI5qUwwqL7VKf8u6bM4Q==
X-Received: by 2002:a05:600c:35c8:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-427ed06816amr16912975e9.31.1721726414708;
        Tue, 23 Jul 2024 02:20:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a3c0fasm194972015e9.7.2024.07.23.02.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 02:20:14 -0700 (PDT)
Message-ID: <2ab2130f-0fb6-4026-aa17-207182e6d4d9@linaro.org>
Date: Tue, 23 Jul 2024 11:20:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: catalina: add Meta Catalina BMC
To: Potin Lai <potin.lai.pt@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Patrick Williams <patrick@stwcx.xyz>
Cc: Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240722145857.2131100-1-potin.lai.pt@gmail.com>
 <20240722145857.2131100-3-potin.lai.pt@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240722145857.2131100-3-potin.lai.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2024 16:58, Potin Lai wrote:
> From: Potin Lai <potin.lai@quantatw.com>
> 
> Add linux device tree entry for Meta(Facebook) Catalina compute-tray
> BMC using AT2600 SoC.
> 

...

> +		i2c45 = &imux45;
> +		i2c46 = &imux46;
> +		i2c47 = &imux47;
> +		i2c48 = &imux48;
> +		i2c49 = &imux49;
> +		i2c50 = &imux50;
> +		i2c51 = &imux51;
> +		i2c52 = &imux52;
> +		i2c53 = &imux53;
> +		i2c54 = &imux54;
> +		i2c55 = &imux55;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS4,57600n8";

Preferred is to use stdout-path property.

> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +			      <&adc1 2>;
> +	};
> +
> +	spi1_gpio: spi1-gpio {
> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
> +		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
> +		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
> +		num-chipselects = <1>;
> +		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> +
> +		tpm@0 {
> +			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> +			spi-max-frequency = <33000000>;
> +			reg = <0>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			label = "bmc_heartbeat_amber";
> +			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-1 {
> +			label = "fp_id_amber";
> +			default-state = "off";
> +			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-2 {
> +			label = "bmc_ready_noled";
> +			gpios = <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
> +		};
> +
> +		led-3 {
> +			label = "bmc_ready_cpld_noled";
> +			gpios = <&gpio0 ASPEED_GPIO(P, 5) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	status = "okay";
> +};
> +
> +//&mac0 {

Please drop dead code or document why this is being commented out.

> +//	status = "okay";
> +//	phy-mode = "rmii";
> +//	pinctrl-names = "default";
> +//	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +//	fixed-link {
> +//		speed = <1000>;
> +//		full-duplex;
> +//	};
> +//};
> +
> +&mac3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	//pinctrl-0 = <&pinctrl_rmii4_default>;

Drop

> +	pinctrl-0 = <&pinctrl_ncsi4_default>;
> +	use-ncsi;
> +	ncsi-ctrl,start-redo-probe;
> +	ncsi-package = <1>;
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-128.dtsi"
> +	};
> +	flash@1 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "alt-bmc";
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	i2c-mux@71 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x71>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		imux24: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +		imux25: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +		imux26: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +		imux27: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +	};
> +
> +	i2c-mux@72 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x72>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		imux28: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +		imux29: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			// IO Mezz 0 IOEXP
> +			pca9535_30_20: pca9535@20 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "nxp,pca9535";
> +				reg = <0x20>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +			};
> +
> +			// IO Mezz 0 FRU EEPROM
> +			eeprom@50 {
> +				compatible = "atmel,24c64";
> +				reg = <0x50>;
> +			};
> +		};
> +		imux30: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +		imux31: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +	};
> +
> +	i2c-mux@73 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x73>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		imux32: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +		imux33: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			i2c-mux@70 {
> +				compatible = "nxp,pca9548";
> +				reg = <0x70>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				imux48: i2c@0 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0>;
> +				};
> +				imux49: i2c@1 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <1>;
> +				};
> +				imux50: i2c@2 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <2>;
> +				};
> +				imux51: i2c@3 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <3>;
> +				};
> +				imux52: i2c@4 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <3>;
> +				};
> +				imux53: i2c@5 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <3>;
> +				};
> +				imux54: i2c@6 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <3>;
> +				};
> +				imux55: i2c@7 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <3>;
> +
> +					ina230@40 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

In other places as well.


Best regards,
Krzysztof


