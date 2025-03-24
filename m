Return-Path: <linux-kernel+bounces-573229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DACDA6D482
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3367F3AFBAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7FC1F560D;
	Mon, 24 Mar 2025 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7pMJOe/"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E11EEA43
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742799594; cv=none; b=QdnpR2oG7MiIr1kKjBg9Own6eSyVk5uESMlo19rEY7t+iBXwqwK3M+yTLbLZMQZRfjInc4hV0DJc3B04stUiOft3yO7BLmyyAAFxzv+NPQ9R4QlEALLJGSHdsk+LJF0HERxeYIBfgoMQ89xX7evrwcTeUBqrnbvzYdRB0NYAwQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742799594; c=relaxed/simple;
	bh=Jy0FNp3ZcF/f6v/FdqF2ElfeoOVY4lfbC6loLyB0JJ8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c5Ma+l1DkhOgv69j+Bumhaoy50g7IwCgmEXYPTAsRkpq+QzfulBqgNWPMAq9s4e2RCQRPZcGAKAaXxMZuIFDeQKh/BenDXaEJ2dDWRCGbiXlgx5n0uRxx+/F/OCUNQ1sMNPwjr6G4Dax65NGEQZUEfMZ+IuljYCJ2yGH/92tqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c7pMJOe/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso24563305e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 23:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742799589; x=1743404389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LeKKrgnLBG9T/eG/Gk6XtoPpi6QMVkqmhURfP3vslIg=;
        b=c7pMJOe/auaiK+8hd4niRJZalku/K+5ueUFArUILL6QW7FHNBi4tDvQcC5+vznnk01
         +wOTSpastl9kBa3kk3YCDsCGMYAgkuhJl7cPuXNdRFdZmuFVHxvKFBRLlu2rJminU7wJ
         THAmsgkOefLhAHBf1wt8vb6po0LZgLeg1Tbmmllsj0n2sMXzd1ab1tKXHPSclJ0WQE0x
         oQvV+gy7/Imt12HPhDnSweF8jf50eszQgKx2UXqH4MzbAE/KN5UwE0Mi5g7hC1m2dWCe
         kz17jWyIJ7z61lZUaa3evS/LHmnW0i2ZgO5NxwGeItBl1hjgXEJvjtzSm7VFyIGIjPKU
         Z/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742799589; x=1743404389;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LeKKrgnLBG9T/eG/Gk6XtoPpi6QMVkqmhURfP3vslIg=;
        b=xSqw6nnej+CcjF2HjK12UyllO41FAU7T6lMXMWuc/l2S2bQVID9hJgTZVB1w1LYMWv
         6ckG8eyoLzWN9s4Kuz53LOKyhQXuny33ruxxfI9o0XDEcD8w9A/CRWAnXvUT2xdRNWy5
         Qg7fgURftgmV548f8gpnM6DHhj7m/ClPn84cdWBBHKAevEfnp3lvzZ244CjRwlT2RfwI
         uWWDkQxJgWIAcyfveONEv8naC/kpaB1Xy8P9oX39L1WzfYgQtUEp66RWwi82zPdEOvmN
         ZvXrwxjDFaSROLWzmnOOz8wza8sVfLukcsqS81k9bwY/xEFlEOSjtY9zuLydEcS/zvPz
         AK5A==
X-Forwarded-Encrypted: i=1; AJvYcCXlDxCjey6IWEUZdLkkzVNqiB3YW7c9Vz9Se6fwugHH/Tf6UhPBWKBVws+i0g8ShsXfttJIaWSuRf3G35Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqED8uicMysvdFWk0+JfeiD5s6PZdaleLSqpTGc8wFssOIZdKK
	yjYFXU9W5zMXMx/pUSbiD7K1EeIvNsyqACFFQGS61DAP9IchmtZs9Gp8oLGYo4Q=
X-Gm-Gg: ASbGncsnsRHVFJC2+keesA6cPlDSLCS2C9SR4sCfp54SCvOddaE1g6a3CE9puCtWOGS
	ktlFwT/cZfyatTB3Hz4vIf99Q0CD3mUPnyiMND/gZafLwGqTRgzwa4PbW9ptx/zlTKwEGqq2aoN
	5LC6vTl5rS1ZPjV4S+PpD9+2LEbc/jHXpaVPKiAvKb0PE2oyTBpytfaYLsGP3jL7LEFAAVZj6bJ
	9aq7RvuJardn/TiypYXrwthX8WXNGSCRtxU1WIkFbTeYYfq73VewJa89SMAdXkdAe3cmw8APZeE
	fKiaXsNnh3gnGqKmm5yz95R4cBQiaqOafFX3bll34J+vqG3ZeisQmaclJhNovhZffFCUrFOausE
	BcpgXtTRPxf6m0ZWE
X-Google-Smtp-Source: AGHT+IEV7+p8YJkKF2xllJmF1iygnLG2rxwF8AEdIWdNJB9wMlJdgYfQKAIWCl4+n4viMeZeNUkRYQ==
X-Received: by 2002:a05:600c:35ca:b0:43c:fc04:6d48 with SMTP id 5b1f17b1804b1-43d50873ee8mr110879945e9.0.1742799589482;
        Sun, 23 Mar 2025 23:59:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a356:8d0:d4d:bb5f? ([2a01:e0a:3d9:2080:a356:8d0:d4d:bb5f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f55c99sm162223625e9.24.2025.03.23.23.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 23:59:49 -0700 (PDT)
Message-ID: <c3f84f77-dc2c-447e-99cf-dedb20a2f93a@linaro.org>
Date: Mon, 24 Mar 2025 07:59:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] ARM: dts: amlogic: Add TCU Fernsehfee 3.0
To: j.ne@posteo.net, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20250323-fernsehfee-v1-0-2621341cd37a@posteo.net>
 <20250323-fernsehfee-v1-3-2621341cd37a@posteo.net>
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
In-Reply-To: <20250323-fernsehfee-v1-3-2621341cd37a@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/03/2025 13:37, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> Fernsehfee[1] ("TV fairy") 3.0 is a set-top box with HDMI input and
> output ports. It originally ran Android 4.4 and a Linux 3.10 kernel.
> 
> The following features are tested and known to work:
> 
> - Ethernet
> - Power LED (switching between green and red)
> - Power button
> - eMMC
> - SD Card
> - USB
> - Wifi
> 
> The following features are untested or not working:
> 
> - HDMI input and output
> - Infrared remote control input and output
> 
> [1]: https://fernsehfee.de/ (German), https://telefairy.com/ (English)
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>   arch/arm/boot/dts/amlogic/Makefile               |   1 +
>   arch/arm/boot/dts/amlogic/meson8-fernsehfee3.dts | 219 +++++++++++++++++++++++
>   arch/arm/boot/dts/amlogic/meson8.dtsi            |  18 ++
>   3 files changed, 238 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/amlogic/Makefile b/arch/arm/boot/dts/amlogic/Makefile
> index 504c533b1173298ec7f45099888d88b2fb74b978..3c8a1e88b386cd7fb9b5f41f47d7ff78fe7eeacc 100644
> --- a/arch/arm/boot/dts/amlogic/Makefile
> +++ b/arch/arm/boot/dts/amlogic/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   dtb-$(CONFIG_MACH_MESON8) += \
>   	meson8-minix-neo-x8.dtb \
> +	meson8-fernsehfee3.dtb \
>   	meson8b-ec100.dtb \
>   	meson8b-mxq.dtb \
>   	meson8b-odroidc1.dtb \
> diff --git a/arch/arm/boot/dts/amlogic/meson8-fernsehfee3.dts b/arch/arm/boot/dts/amlogic/meson8-fernsehfee3.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..47507316ac4a56f2bcf84ad0446a06ea9fe890cd
> --- /dev/null
> +++ b/arch/arm/boot/dts/amlogic/meson8-fernsehfee3.dts
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +// Copyright (C) 2025 J. Neuschäfer <j.ne@posteo.net>
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/leds/common.h>
> +
> +#include "meson8.dtsi"
> +
> +/ {
> +	model = "Fernsehfee 3.0";
> +	compatible = "tcu,fernsehfee3", "amlogic,meson8";
> +
> +	aliases {
> +		serial0 = &uart_AO;
> +		gpiochip0 = &gpio;
> +		gpiochip1 = &gpio_ao;
> +		i2c0 = &i2c_AO;
> +		i2c1 = &i2c_B;
> +		mmc0 = &sdhc;
> +		mmc1 = &sdio;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000>;  /* 1 GiB */
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys-polled";
> +		poll-interval = <100>;
> +
> +		power-button {
> +			label = "Power button";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			/*
> +			 * The power LED can be turned red, otherwise it is green.
> +			 */
> +			gpios = <&gpio_ao GPIO_TEST_N GPIO_ACTIVE_LOW>;
> +			function = LED_FUNCTION_POWER;
> +			color = <LED_COLOR_ID_RED>;
> +		};
> +	};
> +
> +	vcc_5v: regulator-5v {
> +		/* 5V rail, always on as long as the system is running */
> +		compatible = "regulator-fixed";
> +		regulator-name = "5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_3v3: regulator-3v3 {
> +		/* Chipown AP2420 step-down converter */
> +		compatible = "regulator-fixed";
> +		regulator-name = "3.3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_5v>;
> +	};
> +
> +	vcc_1v8: regulator-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1.8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_3v3>;
> +	};
> +
> +	wifi_3v3: regulator-wifi {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3.3V-WIFI";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3>;
> +		gpio = <&gpio GPIOX_11 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +&ethmac {
> +	status = "okay";
> +	pinctrl-0 = <&eth_pins>;
> +	pinctrl-names = "default";
> +	phy-handle = <&eth_phy0>;
> +	phy-mode = "rmii";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		eth_phy0: ethernet-phy@0 {
> +			/* IC Plus IP101A (0x02430c54) */
> +			reg = <0>;
> +
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <10000>;
> +			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&i2c_AO {
> +	status = "okay";
> +	pinctrl-0 = <&i2c_ao_pins>;
> +	pinctrl-names = "default";
> +
> +	pmic@32 {
> +		compatible = "ricoh,rn5t618";
> +		reg = <0x32>;
> +		system-power-controller;
> +	};
> +
> +	eeprom@50 {
> +		/* Fairchild FM24C08A */
> +		compatible = "atmel,24c08";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +		wp-gpios = <&gpio GPIOH_3 GPIO_ACTIVE_HIGH>;
> +		num-addresses = <4>;
> +	};
> +};
> +
> +&i2c_B {
> +	status = "okay";
> +	pinctrl-0 = <&i2c_b_pins>;
> +	pinctrl-names = "default";
> +
> +	/* TODO: SiI9293 HDMI receiver @ 0x39 */
> +};
> +
> +&sdhc {
> +	status = "okay";
> +	pinctrl-0 = <&sdxc_c_pins>;
> +	pinctrl-names = "default";
> +
> +	/* eMMC */
> +	bus-width = <8>;
> +	max-frequency = <100000000>;
> +
> +	disable-wp;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	no-sdio;
> +
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +};
> +
> +&sdio {
> +	status = "okay";
> +	pinctrl-0 = <&sd_b_pins>;
> +
> +	/* SD card */
> +	sd_card_slot: slot@1 {

Small NIT: no need to for a label here

> +		compatible = "mmc-slot";
> +		reg = <1>;
> +		status = "okay";
> +
> +		bus-width = <4>;
> +		cap-mmc-highspeed;
> +		cap-sd-highspeed;
> +		disable-wp;
> +
> +		cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
> +
> +		vmmc-supply = <&vcc_3v3>;
> +	};
> +};
> +
> +&uart_AO {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb0_phy {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +	dr_mode = "host";
> +	/*
> +	 * This bus features a Realtek RTL8188 2.4GHz WiFi module, with a
> +	 * 3.3V supply voltage that must be enabled before use.
> +	 */
> +	vbus-supply = <&wifi_3v3>;
> +};
> +
> +&usb1_phy {
> +	status = "okay";
> +};
> +
> +&ir_receiver {
> +	status = "okay";
> +	pinctrl-0 = <&ir_recv_pins>;
> +	pinctrl-names = "default";
> +};
> diff --git a/arch/arm/boot/dts/amlogic/meson8.dtsi b/arch/arm/boot/dts/amlogic/meson8.dtsi
> index 9ff142d9fe3f4576fdd3230a966c8a6250870de7..300eccbfc0071ce10290be1c496132ac6b6a4dbc 100644
> --- a/arch/arm/boot/dts/amlogic/meson8.dtsi
> +++ b/arch/arm/boot/dts/amlogic/meson8.dtsi
> @@ -477,6 +477,14 @@ gpio: bank@80 {
>   			gpio-ranges = <&pinctrl_cbus 0 0 120>;
>   		};
>   
> +		i2c_b_pins: i2c-b {
> +			mux {
> +				groups = "i2c_sda_b", "i2c_sck_b";
> +				function = "i2c_b";
> +				bias-disable;
> +			};
> +		};
> +
>   		sd_a_pins: sd-a {
>   			mux {
>   				groups = "sd_d0_a", "sd_d1_a", "sd_d2_a",
> @@ -522,6 +530,16 @@ mux {
>   			};
>   		};
>   
> +		sdxc_c_pins: sdxc-c {
> +			mux {
> +				groups = "sdxc_d0_c", "sdxc_d13_c",
> +					"sdxc_clk_c", "sdxc_cmd_c",
> +					"sdxc_d47_c";
> +				function = "sdxc_c";
> +				bias_pull_up;
> +			};
> +		};
> +
>   		spdif_out_pins: spdif-out {
>   			mux {
>   				groups = "spdif_out";
> 

Apart that:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks !
Neil

