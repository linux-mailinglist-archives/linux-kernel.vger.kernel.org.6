Return-Path: <linux-kernel+bounces-294232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34125958B06
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5647B1C20C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8061F192B66;
	Tue, 20 Aug 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TlNMxw/0"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C961FC11
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167269; cv=none; b=Cr3mxAJOkxsaz6afKu4KJiDV03HAD+NtXqg27JtOfr/+iXsSWTg0LEMd12aTLJ+/mdMHtaxI0YORW0gCmcLjccuorQbNsm371k4MF8t75cpRWQBJQ9JNfQam+J8w+N5rhtHe6OgCt71q7KdHlCEuM4N08UwkY9kcwp175uBLhig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167269; c=relaxed/simple;
	bh=JNJbdZjtdi/ZRIagFhoJGMlZsaqDrIwuXJ3+vWJkqds=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oUfZy2vq7m+nx5eAv19y3ACfY1CtxECGKPAAExcXh31Lc9xGc9nzHpptY07m0cLAV4Uqycs3dqJ7Q0PIFwV6ACVc6SIUxZZxqhLHzo/IN5Z72RehWlirIZeWPEDMacw9UTaDiWd/HhQ4c8uAAMpt+BAjRsF09yYJDM9aT9YRRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TlNMxw/0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42ab97465c8so6592705e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724167266; x=1724772066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2tA9LFggrWKbk/UOWjvTfxL+YIz6Gz6PVWFmL4uSdM=;
        b=TlNMxw/02h8AEmvS9U+hB1Zx9yegxYHeXhNAvUt/lN6z7bJV0U0veX9c490Sp1bb5s
         JwlVN+w1V3NWFnXOXvojRj6B2CzRsMOFwlreZWeqlnLAThqiiOXVQV813Z/JPk19accd
         nCgBPQwGhCO82PONWQC19LvbO8n8brUwaxvZJsrBE1fn3Ajy1ZQzkBVuxQLNNfh1v8Zi
         mZtcAkJ4CibreRchHC3XITQxNHNoxOqRLIuX3Vvunx0b6DN0GHIPQrYHvBgBSRFBFnLH
         vT6MT6LwH1HwFNGrztTX2oHUM3hBY8olhNHT84Aa544ZGAFmdEWMESsCITt8y9MP9DGw
         xAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167266; x=1724772066;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y2tA9LFggrWKbk/UOWjvTfxL+YIz6Gz6PVWFmL4uSdM=;
        b=BIutxQVGtupEKgLMR6sip+xThqO4EAu+xoCVQIqPWos09dbRhyPlKeiMdfg5yiKNzA
         1omKaPX6svn+DDbm6r7B1Uxs1b2C/g0HICNjdy1twX23aJvlJUMs9z2fMpit3b9l2a2D
         THDPKRguvPQmAoIvFsepfeSbKMkBGOLDKhcpCw/9SiTAIwY8w2VO70AhPYU94s4p9KtC
         TDtaZzl/6ZR/GaAOPrfXsvK+iHQXhiKIeamh3/nHy12Kauv9AY/zPK8nkVP9FQmYwE0r
         G7ewherX4fN3Anl+n5+9cfB1RaLJxhZTadCwC41x4EhhOFLwIMDjw+pr0hHUqplU+22K
         s4lA==
X-Forwarded-Encrypted: i=1; AJvYcCUF/SzzM9T+GOgQFYj/XEUe6P2RJJOH5GH6rwHoDXSLYLBPHOJx19IEZwlxFVC7H42Ikq5XmRGVBV1htAnzCNGsfNUUFnbYxsgISm1T
X-Gm-Message-State: AOJu0YzDWCCXpzMlu86U2snRAus5svEeByV86ZS4yyRxTuTNkNVPJxPg
	8ehWqCwnRpCGmZbBCFRvnsgJHBCz5wWCybzEatqoSPNiANO2fou3XCKfCofdMJA=
X-Google-Smtp-Source: AGHT+IHemxa2nbJj0/NmVNVEo98bhoLj2Z9iunPvs/ge3ntFX1BaT6XiDKT3esr37y+beieHG5VurQ==
X-Received: by 2002:a05:600c:19c9:b0:428:151b:e8e with SMTP id 5b1f17b1804b1-429ed79c7a5mr104493115e9.10.1724167265459;
        Tue, 20 Aug 2024 08:21:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ebdf:8de4:37af:6aad? ([2a01:e0a:982:cbb0:ebdf:8de4:37af:6aad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded28cdasm196927895e9.16.2024.08.20.08.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 08:21:04 -0700 (PDT)
Message-ID: <50004796-8229-4d4a-b7bf-11d27c90518b@linaro.org>
Date: Tue, 20 Aug 2024 17:21:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/3] arm64: dts: amlogic: add C3 AW419 board
To: xianwei.zhao@amlogic.com, Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240820-c3_add_node-v2-0-8fd3f06b7bce@amlogic.com>
 <20240820-c3_add_node-v2-3-8fd3f06b7bce@amlogic.com>
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
In-Reply-To: <20240820-c3_add_node-v2-3-8fd3f06b7bce@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2024 11:41, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add Amlogic C3 C308L AW419 board. The corresponding binding
> has been applied, therefore, this series does not need to
> add a binding corresponding to the AW419 board.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>   .../boot/dts/amlogic/amlogic-c3-c308l-aw419.dts    | 262 +++++++++++++++++++++
>   2 files changed, 263 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 29417f04f886..2fbda8419c65 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -2,6 +2,7 @@
>   dtb-$(CONFIG_ARCH_MESON) += amlogic-a4-a113l2-ba400.dtb
>   dtb-$(CONFIG_ARCH_MESON) += amlogic-a5-a113x2-av400.dtb
>   dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
> +dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c308l-aw419.dtb
>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
> new file mode 100644
> index 000000000000..4477a2659e27
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "amlogic-c3.dtsi"
> +
> +/ {
> +	model = "Amlogic C308l aw419 Development Board";
> +	compatible = "amlogic,aw419", "amlogic,c3";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart_b;
> +		spi0 = &spifc;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 9 MiB reserved for ARM Trusted Firmware */
> +		secmon_reserved: secmon@7f00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x07f00000 0x0 0x900000>;
> +			no-map;
> +		};
> +	};
> +
> +	main_12v: regulator-main-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "12V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vcc_5v: regulator-vcc-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&main_12v>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vddq: regulator-vddq {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDQ";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		vin-supply = <&main_12v>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vddao_3v3: regulator-vddao-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&main_12v>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vddao_1v8: regulator-vddao-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vddao_3v3>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	ddr4_2v5: regulator-ddr4-2v5 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "DDR4_2V5";
> +		regulator-min-microvolt = <2500000>;
> +		regulator-max-microvolt = <2500000>;
> +		vin-supply = <&vddao_3v3>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vcc_3v3: regulator-vcc-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vddao_3v3>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vcc_1v8: regulator-vcc-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_3v3>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vdd_1v8: regulator-vdd-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD1V8_BOOT";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_3v3>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vddio_b: regulator-vddio-3v3-b {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_B";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	sdcard: regulator-sdcard {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SDCARD_POWER";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vddao_3v3>;
> +		gpio = <&gpio GPIOA_4 GPIO_ACTIVE_LOW>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +};
> +
> +&uart_b {
> +	status = "okay";
> +};
> +
> +&nand {
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	pinctrl-0 = <&nand_pins>;
> +	pinctrl-names = "default";
> +
> +	nand@0 {
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		nand-on-flash-bbt;
> +
> +		partition@0 {
> +			label = "boot";
> +			reg = <0x0 0x00200000>;
> +		};
> +		partition@200000 {
> +			label = "env";
> +			reg = <0x00200000 0x00400000>;
> +		};
> +		partition@600000 {
> +			label = "system";
> +			reg = <0x00600000 0x00a00000>;
> +		};
> +		partition@1000000 {
> +			label = "rootfs";
> +			reg = <0x01000000 0x03000000>;
> +		};
> +		partition@4000000 {
> +			label = "media";
> +			reg = <0x04000000 0x8000000>;
> +		};
> +	};
> +};
> +
> +&ethmac {
> +	status = "okay";
> +	phy-handle = <&internal_ephy>;
> +	phy-mode = "rmii";
> +};
> +
> +&spifc {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	pinctrl-0 = <&spifc_pins>;
> +	pinctrl-names = "default";
> +
> +	nand@0 {
> +		compatible = "spi-nand";
> +		reg = <0>;
> +		spi-max-frequency = <83000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		status = "disabled";
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "boot";
> +				reg = <0 0x200000>;
> +			};
> +
> +			partition@200000 {
> +				label = "env";
> +				reg = <0x200000 0x400000>;
> +			};
> +
> +			partition@600000 {
> +				label = "system";
> +				reg = <0x600000 0xa00000>;
> +			};
> +
> +			partition@1000000 {
> +				label = "rootfs";
> +				reg = <0x1000000 0x3000000>;
> +			};
> +
> +			partition@4000000 {
> +				label = "data";
> +				reg = <0x4000000 0x8000000>;
> +			};
> +		};
> +	};
> +};
> +
> +&sd {
> +	status = "okay";
> +	pinctrl-0 = <&sdcard_pins>;
> +	pinctrl-1 = <&sdcard_clk_gate_pins>;
> +	pinctrl-names = "default","clk-gate";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	max-frequency = <50000000>;
> +	disable-wp;
> +
> +	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&sdcard>;
> +	vqmmc-supply = <&sdcard>;
> +};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

