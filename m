Return-Path: <linux-kernel+bounces-245489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4ED92B33C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CA9B22A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6610C1534FD;
	Tue,  9 Jul 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnEXZKoB"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102457BAE3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516116; cv=none; b=iCqIue3KtF7myhoFKAScrNlhUnES6Djc6anm/ogpyd6qgK0z/kyYPh9rydNokXT901NlAFxpV6vNrCkx60K1XMmPrgOJs7iQa2FRmojwgnaQ941e0ZoBMLePrqOFsCR7Zc2QEG+FuYSNRf+btVnfUDOt6Fku6vuUT6e43J+8KzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516116; c=relaxed/simple;
	bh=kB/OaWouFNU3hqh04VJ5xn/I4pF+y0PiN4vGWGxRAaY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jwqDowS0vSmeRGMERDSw3sIHal6v6ZQWf8tONVGjpb09PEe6B2lX4PxDSRezsEKwfupTYJ2O0UBgoy1U7hIgkJYropzJ8wsmOqZvmix0PG5yaFXsIFKjfG9S7X87DggXl0A53ujYIRE/2gxSGpgA98HfBbPbU/2G5Zyfsxvhhgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XnEXZKoB; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso48365191fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720516111; x=1721120911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmdthfUB0lCia3+pjHR/TlqzyKmsnOAaiH7zcFhwtHw=;
        b=XnEXZKoBxapXagxJ5ueyFqI03DEMohuWyLQEL81f+a4n6KfXFEaN8HLVkh38nHA5ky
         3ZglG6b8T2BqhI36OO4BZE1+HkNcj+wFEAff1g14TBH6rtBQ0T0PFg3gzvujv7u4Xo1O
         3701bUS4FxjO1v3ZJOSXVoDsjgoWK4qPLsP/XoksjFdGRiG/m3oM3snF/oPleO75yy7Z
         ybE5wQwGtM32RZSA62dTkawmU90eN5ZYuDMvs70eAorhoKX2mQG9/6IlKPb/LM3ibY5H
         EPCKT0DRGZo8NmPQypH99MBO+wDeZ6SdaQixpsW6x6NeAxDWF3ygSnBiCUz6J1z3nFEG
         2mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720516111; x=1721120911;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CmdthfUB0lCia3+pjHR/TlqzyKmsnOAaiH7zcFhwtHw=;
        b=vkimMAqUAK6EBKsMZ8XH2461EuHi+p7Xi4KpB6UoJyKU4xlQGc0QP4YBUtPet9TJ3f
         b3WF8VQucQVWnhyZE1BDHDNNvfcBsOZKc6CGRGWPkRRP6i0Ni9GMUca0L39PJMGm6ew3
         /XRuv+ChhxoPPQDImWeh/PqkXVCrp5ePLO49taLmSx/tfKjhrWVkAXMf1Pydla6WDswY
         ZjY4j12vLfYkH56kgV+F26p0x6LeBSFkfINuPaoq61c7jTeKxTQvuHb4WHZhDcpOL6KR
         EVqIDLGfv43n4+e6tYDud1WZyQGGF1BF5gRG2qW/wEXwlxW1ayaZ5ID/PNmG+H1RDuio
         9gGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8nkQB1EGFAyjp6lL/YAR0f5Q7V2c8UdieEAzkyLch6taDJqixI8aAvsyIJgstHy7PGzvB03gYvozRivO4GbRRHXN3JPMHaJyfP3Fu
X-Gm-Message-State: AOJu0YwXZQXysDhJfqZn1yg7bKIbTkbMrvQYLVKl/UfwsGj4o4+rsZnY
	OVDpnco3Hu/cnc7+M9ceaIRO6Ryxokk7jU4Mipf+mgd/GeQk2Ij+Alfo/jEhrtIE9ibb8AhINcO
	U0u8=
X-Google-Smtp-Source: AGHT+IEtJIiE86xhBgxBKeQv7zMaRRuPXmv/jRIb3QypyrUCqGULk6d0VIimsfliwDU5MxU0qIHW4A==
X-Received: by 2002:a2e:9903:0:b0:2ec:5fe1:c762 with SMTP id 38308e7fff4ca-2eeb3197c6fmr12601331fa.46.1720516110918;
        Tue, 09 Jul 2024 02:08:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:b12a:8461:5e2a:dfe? ([2a01:e0a:cad:2140:b12a:8461:5e2a:dfe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f74462esm30643605e9.48.2024.07.09.02.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 02:08:30 -0700 (PDT)
Message-ID: <f4a17dbc-07f3-4335-8e0c-ec64e2f80727@linaro.org>
Date: Tue, 9 Jul 2024 11:08:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: amlogic: enable some device nodes for S4
To: xianwei.zhao@amlogic.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240705-s4_node-v1-1-646ca7ac4f09@amlogic.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240705-s4_node-v1-1-646ca7ac4f09@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/07/2024 07:39, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Enable some device nodes for AQ222 base S4, including
> SD, regulator and ethnernet node.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   .../boot/dts/amlogic/meson-s4-s805x2-aq222.dts     | 146 +++++++++++++++++++++
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 128 ++++++++++++++++++
>   2 files changed, 274 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> index 983caddc409c..2ab685d9bd1d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> @@ -34,6 +34,112 @@ secmon_reserved: secmon@5000000 {
>   			no-map;
>   		};
>   	};
> +
> +	sdio_32k: sdio-32k {
> +		compatible = "pwm-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> +		clocks = <&sdio_32k>;
> +		clock-names = "ext_clock";
> +	};
> +
> +	main_12v: regulator-main-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "12V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-always-on;
> +	};
> +
> +	vddao_3v3: regulator-vddao-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&main_12v>;
> +		regulator-always-on;
> +	};
> +
> +	vddio_ao1v8: regulator-vddio-ao1v8 {
> +	       compatible = "regulator-fixed";
> +	       regulator-name = "VDDIO_AO1V8";
> +	       regulator-min-microvolt = <1800000>;
> +	       regulator-max-microvolt = <1800000>;
> +	       vin-supply = <&vddao_3v3>;
> +	       regulator-always-on;
> +	};
> +
> +	/* SY8120B1ABC DC/DC Regulator. */
> +	vddcpu: regulator-vddcpu {
> +		compatible = "pwm-regulator";
> +
> +		regulator-name = "VDDCPU";
> +		regulator-min-microvolt = <689000>;
> +		regulator-max-microvolt = <1049000>;
> +
> +		vin-supply = <&main_12v>;
> +
> +		pwms = <&pwm_ij 1 1500 0>;
> +		pwm-dutycycle-range = <100 0>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +		/* Voltage Duty-Cycle */
> +		voltage-table = <1049000 0>,
> +				<1039000 3>,
> +				<1029000 6>,
> +				<1019000 9>,
> +				<1009000 12>,
> +				<999000 14>,
> +				<989000 17>,
> +				<979000 20>,
> +				<969000 23>,
> +				<959000 26>,
> +				<949000 29>,
> +				<939000 31>,
> +				<929000 34>,
> +				<919000 37>,
> +				<909000 40>,
> +				<899000 43>,
> +				<889000 45>,
> +				<879000 48>,
> +				<869000 51>,
> +				<859000 54>,
> +				<849000 56>,
> +				<839000 59>,
> +				<829000 62>,
> +				<819000 65>,
> +				<809000 68>,
> +				<799000 70>,
> +				<789000 73>,
> +				<779000 76>,
> +				<769000 79>,
> +				<759000 81>,
> +				<749000 84>,
> +				<739000 87>,
> +				<729000 89>,
> +				<719000 92>,
> +				<709000 95>,
> +				<699000 98>,
> +				<689000 100>;
> +		status = "okay";

You can drop status=okay here

> +	};
> +};
> +
> +&pwm_ef {
> +	status = "okay";
> +	pinctrl-0 = <&pwm_e_pins1>;
> +	pinctrl-names = "default";
> +};
> +
> +&pwm_ij {
> +	status = "okay";
>   };
>   
>   &uart_b {
> @@ -46,6 +152,40 @@ &ir {
>   	pinctrl-names = "default";
>   };
>   
> +&sdio {
> +	pinctrl-0 = <&sdio_pins>;
> +	pinctrl-1 = <&sdio_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	disable-wp;
> +	no-sd;
> +	no-mmc;
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&vddio_ao1v8>;
> +};
> +
> +&sd {
> +	status = "okay";
> +	pinctrl-0 = <&sdcard_pins>;
> +	pinctrl-1 = <&sdcard_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	max-frequency = <200000000>;
> +	disable-wp;
> +
> +	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&vddao_3v3>;
> +};
> +
>   &nand {
>   	status = "okay";
>   	#address-cells = <1>;
> @@ -90,3 +230,9 @@ &spicc0 {
>   	pinctrl-0 = <&spicc0_pins_x>;
>   	cs-gpios = <&gpio GPIOX_10 GPIO_ACTIVE_LOW>;
>   };
> +
> +&ethmac {
> +	status = "okay";
> +	phy-handle = <&internal_ephy>;
> +	phy-mode = "rmii";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index b686eacb9662..c11c947fa18c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
>   #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>   #include <dt-bindings/power/meson-s4-power.h>
> +#include <dt-bindings/reset/amlogic,meson-s4-reset.h>
>   
>   / {
>   	cpus {
> @@ -466,6 +467,93 @@ mux {
>   					};
>   				};
>   
> +				sdcard_pins: sdcard-pins {
> +					mux {
> +						groups = "sdcard_d0_c",
> +							 "sdcard_d1_c",
> +							 "sdcard_d2_c",
> +							 "sdcard_d3_c",
> +							 "sdcard_clk_c",
> +							 "sdcard_cmd_c";
> +						function = "sdcard";
> +						bias-pull-up;
> +						drive-strength-microamp = <4000>;
> +					};
> +				};
> +
> +				sdcard_clk_gate_pins: sdcard-clk-gate-pins {
> +					mux {
> +						groups = "GPIOC_4";
> +						function = "gpio_periphs";
> +						bias-pull-down;
> +						drive-strength-microamp = <4000>;
> +					};
> +				};
> +
> +				emmc_pins: emmc-pins {
> +					mux-0 {
> +						groups = "emmc_nand_d0",
> +							 "emmc_nand_d1",
> +							 "emmc_nand_d2",
> +							 "emmc_nand_d3",
> +							 "emmc_nand_d4",
> +							 "emmc_nand_d5",
> +							 "emmc_nand_d6",
> +							 "emmc_nand_d7",
> +							 "emmc_cmd";
> +						function = "emmc";
> +						bias-pull-up;
> +						drive-strength-microamp = <4000>;
> +					};
> +					mux-1 {
> +						groups = "emmc_clk";
> +						function = "emmc";
> +						bias-pull-up;
> +						drive-strength-microamp = <4000>;
> +					};
> +				};
> +
> +				emmc_ds_pins: emmc-ds-pins {
> +					mux {
> +						groups = "emmc_nand_ds";
> +						function = "emmc";
> +						bias-pull-down;
> +						drive-strength-microamp = <4000>;
> +					};
> +				};
> +
> +				emmc_clk_gate_pins: emmc-clk-gate-pins {
> +					mux {
> +						groups = "GPIOB_8";
> +						function = "gpio_periphs";
> +						bias-pull-down;
> +						drive-strength-microamp = <4000>;
> +					};
> +				};
> +
> +				sdio_pins: sdio-pins {
> +					mux {
> +						groups = "sdio_d0",
> +							 "sdio_d1",
> +							 "sdio_d2",
> +							 "sdio_d3",
> +							 "sdio_clk",
> +							 "sdio_cmd";
> +						function = "sdio";
> +						bias-pull-up;
> +						drive-strength-microamp = <4000>;
> +					};
> +				};
> +
> +				sdio_clk_gate_pins: sdio-clk-gate-pins {
> +					mux {
> +						groups = "GPIOX_4";
> +						function = "gpio_periphs";
> +						bias-pull-down;
> +						drive-strength-microamp = <4000>;
> +					};
> +				};
> +
>   				spicc0_pins_x: spicc0-pins_x {
>   					mux {
>   						groups = "spi_a_mosi_x",
> @@ -712,5 +800,45 @@ mdio0: mdio {
>   				compatible = "snps,dwmac-mdio";
>   			};
>   		};
> +
> +		sdio: mmc@fe088000 {
> +			compatible = "amlogic,meson-axg-mmc";
> +			reg = <0x0 0xfe088000 0x0 0x800>;
> +			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clkc_periphs CLKID_SDEMMC_A>,
> +				 <&xtal>,
> +				 <&clkc_pll CLKID_FCLK_DIV2>;
> +			clock-names = "core", "clkin0", "clkin1";
> +			resets = <&reset RESET_SD_EMMC_A>;
> +			cap-sdio-irq;
> +			keep-power-in-suspend;
> +			status = "disabled";
> +		};
> +
> +		sd: mmc@fe08a000 {
> +			compatible = "amlogic,meson-axg-mmc";
> +			reg = <0x0 0xfe08a000 0x0 0x800>;
> +			interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
> +			clocks = <&clkc_periphs CLKID_SDEMMC_B>,
> +				 <&clkc_periphs CLKID_SD_EMMC_B>,
> +				 <&clkc_pll CLKID_FCLK_DIV2>;
> +			clock-names = "core", "clkin0", "clkin1";
> +			resets = <&reset RESET_SD_EMMC_B>;
> +			status = "disabled";
> +		};
> +
> +		emmc: mmc@fe08c000 {
> +			compatible = "amlogic,meson-axg-mmc";
> +			reg = <0x0 0xfe08c000 0x0 0x800>;
> +			interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
> +			clocks = <&clkc_periphs CLKID_NAND>,
> +				 <&xtal>,
> +				 <&clkc_pll CLKID_FCLK_DIV2>;
> +			clock-names = "core", "clkin0", "clkin1";
> +			resets = <&reset RESET_NAND_EMMC>;
> +			no-sdio;
> +			no-sd;
> +			status = "disabled";
> +		};
>   	};
>   };
> 
> ---
> base-commit: 338c92a5d1956f1841f84b86923087676d1d0cea
> change-id: 20240705-s4_node-8110e3286c0c
> 
> Best regards,

With that fixed:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


