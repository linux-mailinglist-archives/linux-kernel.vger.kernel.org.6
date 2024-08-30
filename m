Return-Path: <linux-kernel+bounces-308272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023C59659A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCD6282C36
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928B158A37;
	Fri, 30 Aug 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MlEAcENo"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051D16D4DC
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005462; cv=none; b=Dy4FrvR4AswrA9TPNs5Sx4rRULUSxfRHSFnXUvEzWpE0DKijvnUWH5sU7ipF7ASiiAKU92knxCT4H3AjJhMri+nvAe26nr9x1dHWzPNxB6V68Skib7JRsulcN3hah+tLHyTpWdD7MZGdGsw0agyfI4UVRSGHm+C2BCsYa4jcHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005462; c=relaxed/simple;
	bh=9z3YfkVRBOEdyi8A6e1Zg8UZALKCLrr0DiI8DjSKPwM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ze19RJ7kqlFce7WXxbadmDbZZLIc3cGOCH6z0AU11u6nT1XWYIDDWfdvcMsVK4xPgrEzBZ82neg+sqHtmURkloSYQQBMNVW6bTPZHaAtnfd7yG1PhC67X/bBUVKJ4jIaWRkeR9uH1UGR/XITKoL7x5QqIa2ici46drEBZOE0dNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MlEAcENo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428e0d18666so12787315e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725005457; x=1725610257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DE7sKvtjgY6go5jRlrCMD+37GbJUv0vo/1wyI129w/w=;
        b=MlEAcENoRCSaNUNXJfiZudG7RiJQzNMc+QvWRdAG0S1C2Vwsz08Vq+5iWc18IiQcUD
         9Y5LlvQG8t8W4TKdnSQdsCOkD2kKlaO3qvznvCt7iGAtTB68zrkVuuE7yZlM1w2B+RmB
         cGGsLPvv/4pHqeEJFSxxORq8I1Bt5ELKmfxVfcEveKaaFFVq1JdGphbqNWjyQHSuRhN2
         tlI2UMjb5dRWQ6AhpNH3Mgdbrt71ycKvCt1FkZ/gQeZRqjZCitj3qlxpUSCUyjCjgcus
         OsnGYQpPWrLE0Hvdel4aGMuzdXIYiE6QrZTL6XURiqCaZ/j7227TZo7Do7dJIg7alUPc
         MYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725005457; x=1725610257;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DE7sKvtjgY6go5jRlrCMD+37GbJUv0vo/1wyI129w/w=;
        b=goKIS9LYoyzUKXZnZpYODi4aEdfGeqwIHgdjAOdVzzliJuLb0HQNq0f/5KrPXl5VJP
         fvl8x9scs00ZNAIK9Tbf6qjeA8rJ5fzvWx9AkcMik5GE74KhZhN/6bXh1lVZDzibOpQG
         SvMFQPfZ6tcjwj/iLYDwMuAWnXGLxda3iyaXnSDnLaDrtmTTUT9fO6JQ+fYYKkjQusny
         4Y42ZZF4AvkzauF4tk7oWTz7ByFwMDQk9iy+LJeazHikpf1EmvUQ3RA7MJ7Cyta12Pr5
         EXQAgq0Yjb/mXWogTWUmQAxrgqOjPzvo6Ww02Fgjr0gA1epnxkV7t3CHYGMfMsUWJ+41
         /DTA==
X-Forwarded-Encrypted: i=1; AJvYcCVCoyi/9jYQwK4mHjBRiWOvhu4cbU/XlEni+dPFXfNNf93/pCh+aQ26IFupdvFQbXZ9c5FFyuoLA9Q0S4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3oofMYy8cUPXRx8YTpQ62ux7dkHBGNPk4+i6+nXIVN9Kyevjv
	rqn0wNvKI+wGmXDlLMXbR8J+P3iQkd2aClttmHeQRDYJxsKNFK6ljALbJPqd4fM=
X-Google-Smtp-Source: AGHT+IE8CgTn4oggTYbkVSuAmbVLaX8Ju7npD4F/+/abIV6aStqHamLisSulEQios/dAVl6ac/ufVw==
X-Received: by 2002:a05:600c:1554:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-42bbb436e16mr10809285e9.22.1725005456217;
        Fri, 30 Aug 2024 01:10:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5001:8e1b:dd18:1d3? ([2a01:e0a:982:cbb0:5001:8e1b:dd18:1d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba641db12sm72713885e9.35.2024.08.30.01.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:10:55 -0700 (PDT)
Message-ID: <4f36f29d-93c9-4f7d-bb35-c29e5ba55966@linaro.org>
Date: Fri, 30 Aug 2024 10:10:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 2/3] arm64: dts: amlogic: add some device nodes for C3
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
References: <20240830-c3_add_node-v4-0-b56c0511e9dc@amlogic.com>
 <20240830-c3_add_node-v4-2-b56c0511e9dc@amlogic.com>
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
In-Reply-To: <20240830-c3_add_node-v4-2-b56c0511e9dc@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/08/2024 07:26, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add some device nodes for SoC C3, including periphs clock controller
> node, PLL clock controller node, SPICC node, regulator node, NAND
> controller node, sdcard node, Ethernet MAC and PHY node.
> 
> The sdacrd depends on regulator and pinctrl(select), so some
> property fields are placed at the board level. The nand chip
> is placed on the board, So some property fields about SPIFC
> and NAND controller node are placed at the board level.
> THe Ethernet MAC support outchip PHY, so place this property
> field(select PHY) at the board level.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   .../boot/dts/amlogic/amlogic-c3-c302x-aw409.dts    | 233 ++++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 488 ++++++++++++++++++++-
>   2 files changed, 720 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
> index edce8850b338..b8d2037afc00 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
> @@ -16,14 +16,247 @@ / {
>   
>   	aliases {
>   		serial0 = &uart_b;
> +		spi0 = &spifc;
>   	};
>   
>   	memory@0 {
>   		device_type = "memory";
>   		reg = <0x0 0x0 0x0 0x10000000>;
>   	};
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
>   };
>   
>   &uart_b {
>   	status = "okay";
>   };
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
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> index c913dd409e64..c0ce776ec463 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -7,6 +7,11 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/reset/amlogic,c3-reset.h>
> +#include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
> +#include <dt-bindings/clock/amlogic,c3-scmi-clkc.h>
> +#include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>
> +#include <dt-bindings/power/amlogic,c3-pwrc.h>
> +#include <dt-bindings/gpio/amlogic-c3-gpio.h>
>   
>   / {
>   	cpus {
> @@ -57,6 +62,34 @@ pwrc: power-controller {
>   		};
>   	};
>   
> +	sram {
> +		compatible = "mmio-sram";
> +		reg = <0x0 0x07f50e00 0x0 0x100>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x0 0x07f50e00 0x100>;
> +
> +		scmi_shmem: sram@0 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0x100>;
> +		};
> +	};
> +
> +	firmware {
> +		scmi: scmi {
> +			compatible = "arm,scmi-smc";
> +			arm,smc-id = <0x820000C1>;
> +			shmem = <&scmi_shmem>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			scmi_clk: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +	};
> +
>   	soc {
>   		compatible = "simple-bus";
>   		#address-cells = <2>;
> @@ -82,6 +115,44 @@ apb4: bus@fe000000 {
>   			#size-cells = <2>;
>   			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>   
> +			clkc_periphs: clock-controller@0 {
> +				compatible = "amlogic,c3-peripherals-clkc";
> +				reg = <0x0 0x0 0x0 0x49c>;
> +				#clock-cells = <1>;
> +				clocks = <&xtal>,
> +					 <&scmi_clk CLKID_OSC>,
> +					 <&scmi_clk CLKID_FIXED_PLL_OSC>,
> +					 <&clkc_pll CLKID_FCLK_DIV2>,
> +					 <&clkc_pll CLKID_FCLK_DIV2P5>,
> +					 <&clkc_pll CLKID_FCLK_DIV3>,
> +					 <&clkc_pll CLKID_FCLK_DIV4>,
> +					 <&clkc_pll CLKID_FCLK_DIV5>,
> +					 <&clkc_pll CLKID_FCLK_DIV7>,
> +					 <&clkc_pll CLKID_GP0_PLL>,
> +					 <&scmi_clk CLKID_GP1_PLL_OSC>,
> +					 <&clkc_pll CLKID_HIFI_PLL>,
> +					 <&scmi_clk CLKID_SYS_CLK>,
> +					 <&scmi_clk CLKID_AXI_CLK>,
> +					 <&scmi_clk CLKID_SYS_PLL_DIV16>,
> +					 <&scmi_clk CLKID_CPU_CLK_DIV16>;
> +				clock-names = "xtal_24m",
> +					      "oscin",
> +					      "fix",
> +					      "fdiv2",
> +					      "fdiv2p5",
> +					      "fdiv3",
> +					      "fdiv4",
> +					      "fdiv5",
> +					      "fdiv7",
> +					      "gp0",
> +					      "gp1",
> +					      "hifi",
> +					      "sysclk",
> +					      "axiclk",
> +					      "sysplldiv16",
> +					      "cpudiv16";
> +			};
> +
>   			reset: reset-controller@2000 {
>   				compatible = "amlogic,c3-reset";
>   				reg = <0x0 0x2000 0x0 0x98>;
> @@ -108,6 +179,237 @@ gpio: bank@4000 {
>   					#gpio-cells = <2>;
>   					gpio-ranges = <&periphs_pinctrl 0 0 55>;
>   				};
> +
> +				i2c0_pins1: i2c0-pins1 {
> +					mux {
> +						groups = "i2c0_sda_e",
> +							 "i2c0_scl_e";
> +						function = "i2c0";
> +						bias-disable;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c0_pins2: i2c0-pins2 {
> +					mux {
> +						groups = "i2c0_sda_d",
> +							 "i2c0_scl_d";
> +						function = "i2c0";
> +						bias-disable;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c1_pins1: i2c1-pins1 {
> +					mux {
> +						groups = "i2c1_sda_x",
> +							 "i2c1_scl_x";
> +						function = "i2c1";
> +						bias-disable;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c1_pins2: i2c1-pins2 {
> +					mux {
> +						groups = "i2c1_sda_d",
> +							 "i2c1_scl_d";
> +						function = "i2c1";
> +						bias-disable;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c1_pins3: i2c1-pins3 {
> +					mux {
> +						groups = "i2c1_sda_a",
> +							 "i2c1_scl_a";
> +						function = "i2c1";
> +						bias-disable;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c1_pins4: i2c1-pins4 {
> +					mux {
> +						groups = "i2c1_sda_b",
> +							 "i2c1_scl_b";
> +						function = "i2c1";
> +						bias-disable;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c2_pins1: i2c2-pins1 {
> +					mux {
> +						groups = "i2c2_sda",
> +							 "i2c2_scl";
> +						function = "i2c2";
> +						bias-disable;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c3_pins1: i2c3-pins1 {
> +					mux {
> +						groups = "i2c3_sda_c",
> +							 "i2c3_scl_c";
> +						function = "i2c3";
> +						bias-disable;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c3_pins2: i2c3-pins2 {
> +					mux {
> +						groups = "i2c3_sda_x",
> +							 "i2c3_scl_x";
> +						function = "i2c3";
> +						bias-disable;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c3_pins3: i2c3-pins3 {
> +					mux {
> +						groups = "i2c3_sda_d",
> +							 "i2c3_scl_d";
> +						function = "i2c3";
> +						bias-disable;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				nand_pins: nand-pins {
> +					mux {
> +						groups = "emmc_nand_d0",
> +							 "emmc_nand_d1",
> +							 "emmc_nand_d2",
> +							 "emmc_nand_d3",
> +							 "emmc_nand_d4",
> +							 "emmc_nand_d5",
> +							 "emmc_nand_d6",
> +							 "emmc_nand_d7",
> +							 "nand_ce0",
> +							 "nand_ale",
> +							 "nand_cle",
> +							 "nand_wen_clk",
> +							 "nand_ren_wr";
> +						function = "nand";
> +						input-enable;
> +					};
> +				};
> +
> +				sdcard_pins: sdcard-pins {
> +					mux {
> +						groups = "sdcard_d0",
> +							 "sdcard_d1",
> +							 "sdcard_d2",
> +							 "sdcard_d3",
> +							 "sdcard_clk",
> +							 "sdcard_cmd";
> +						function = "sdcard";
> +						bias-pull-up;
> +						drive-strength-microamp = <4000>;
> +					};
> +				};
> +
> +				sdcard_clk_gate_pins: sdcard-clk-cmd-pins {
> +					mux {
> +						groups = "GPIOC_4";
> +						function = "gpio_periphs";
> +						bias-pull-down;
> +						drive-strength-microamp = <4000>;
> +					};
> +				};
> +
> +				sdio_m_clk_gate_pins: sdio-m-clk-cmd-pins {
> +					mux {
> +						groups = "sdio_clk";
> +						function = "sdio";
> +						bias-pull-down;
> +						drive-strength-microamp = <4000>;
> +					};
> +				};
> +
> +				sdio_m_pins: sdio-m-all-pins {
> +					mux {
> +						groups = "sdio_d0",
> +							 "sdio_d1",
> +							 "sdio_d2",
> +							 "sdio_d3",
> +							 "sdio_clk",
> +							 "sdio_cmd";
> +						function = "sdio";
> +						input-enable;
> +						bias-pull-up;
> +						drive-strength-microamp = <4000>;
> +					};
> +				};
> +
> +				spicc0_pins1: spicc0-pins1 {
> +					mux {
> +						groups = "spi_a_mosi_b",
> +							 "spi_a_miso_b",
> +							 "spi_a_clk_b";
> +						function = "spi_a";
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				spicc0_pins2: spicc0-pins2 {
> +					mux {
> +						groups = "spi_a_mosi_c",
> +							 "spi_a_miso_c",
> +							 "spi_a_clk_c";
> +						function = "spi_a";
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				spicc0_pins3: spicc0-pins3 {
> +					mux {
> +						groups = "spi_a_mosi_x",
> +							 "spi_a_miso_x",
> +							 "spi_a_clk_x";
> +						function = "spi_a";
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				spicc1_pins1: spicc1-pins1 {
> +					mux {
> +						groups = "spi_b_mosi_d",
> +							 "spi_b_miso_d",
> +							 "spi_b_clk_d";
> +						function = "spi_b";
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				spicc1_pins2: spicc1-pins2 {
> +					mux {
> +						groups = "spi_b_mosi_x",
> +							 "spi_b_miso_x",
> +							 "spi_b_clk_x";
> +						function = "spi_b";
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				spifc_pins: spifc-pins {
> +					mux {
> +						groups = "spif_mo",
> +							 "spif_mi",
> +							 "spif_clk",
> +							 "spif_cs",
> +							 "spif_hold",
> +							 "spif_wp",
> +							 "spif_clk_loop";
> +						function = "spif";
> +						drive-strength-microamp = <4000>;
> +					};
> +				};
>   			};
>   
>   			gpio_intc: interrupt-controller@4080 {
> @@ -119,13 +421,131 @@ gpio_intc: interrupt-controller@4080 {
>   					<10 11 12 13 14 15 16 17 18 19 20 21>;
>   			};
>   
> +			clkc_pll: clock-controller@8000 {
> +				compatible = "amlogic,c3-pll-clkc";
> +				reg = <0x0 0x8000 0x0 0x1a4>;
> +				#clock-cells = <1>;
> +				clocks = <&scmi_clk CLKID_TOP_PLL_OSC>,
> +					 <&scmi_clk CLKID_MCLK_PLL_OSC>,
> +					 <&scmi_clk CLKID_FIXED_PLL_OSC>;
> +				clock-names = "top",
> +					      "mclk",
> +					      "fix";
> +			};
> +
> +			eth_phy: mdio-multiplexer@28000 {
> +				compatible = "amlogic,g12a-mdio-mux";
> +				reg = <0x0 0x28000 0x0 0xa4>;
> +
> +				clocks = <&clkc_periphs CLKID_SYS_ETH_PHY>,
> +					 <&xtal>,
> +					 <&clkc_pll CLKID_FCLK_50M>;
> +				clock-names = "pclk", "clkin0", "clkin1";
> +				mdio-parent-bus = <&mdio0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				ext_mdio: mdio@0 {
> +					reg = <0>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +				};
> +
> +				int_mdio: mdio@1 {
> +					reg = <1>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					internal_ephy: ethernet_phy@8 {
> +						compatible = "ethernet-phy-id0180.3301",
> +							     "ethernet-phy-ieee802.3-c22";
> +						interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +						reg = <8>;
> +						max-speed = <100>;
> +					};
> +				};
> +			};
> +
> +			spicc0: spi@50000 {
> +				compatible = "amlogic,meson-g12a-spicc";
> +				reg = <0x0 0x50000 0x0 0x44>;
> +				interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc_periphs CLKID_SYS_SPICC_0>,
> +					 <&clkc_periphs CLKID_SPICC_A>;
> +				clock-names = "core", "pclk";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spicc1: spi@52000 {
> +				compatible = "amlogic,meson-g12a-spicc";
> +				reg = <0x0 0x52000 0x0 0x44>;
> +				interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc_periphs CLKID_SYS_SPICC_1>,
> +					 <&clkc_periphs CLKID_SPICC_B>;
> +				clock-names = "core", "pclk";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spifc: spi@56000 {
> +				compatible = "amlogic,a1-spifc";
> +				reg = <0x0 0x56000 0x0 0x290>;
> +				interrupts = <GIC_SPI 182 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc_periphs CLKID_SPIFC>;
> +				clock-names = "core";
> +				status = "disabled";
> +			};
> +
> +			i2c0: i2c@66000 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x66000 0x0 0x24>;
> +				interrupts = <GIC_SPI 160 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_M_A>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@68000 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x68000 0x0 0x24>;
> +				interrupts = <GIC_SPI 161 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_M_B>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c@6a000 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x6a000 0x0 0x24>;
> +				interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_M_C>;
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c@6c000 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x6c000 0x0 0x24>;
> +				interrupts = <GIC_SPI 163 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_M_D>;
> +				status = "disabled";
> +			};
> +
>   			uart_b: serial@7a000 {
>   				compatible = "amlogic,meson-s4-uart",
>   					   "amlogic,meson-ao-uart";
>   				reg = <0x0 0x7a000 0x0 0x18>;
>   				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
>   				status = "disabled";
> -				clocks = <&xtal>, <&xtal>, <&xtal>;
> +				clocks = <&xtal>, <&clkc_periphs CLKID_SYS_UART_B>, <&xtal>;
>   				clock-names = "xtal", "pclk", "baud";
>   			};
>   
> @@ -136,6 +556,72 @@ sec_ao: ao-secure@10220 {
>   				reg = <0x0 0x10220 0x0 0x140>;
>   				amlogic,has-chip-id;
>   			};
> +
> +			sdio: mmc@88000 {
> +				compatible = "amlogic,meson-axg-mmc";
> +				reg = <0x0 0x88000 0x0 0x800>;
> +				interrupts = <GIC_SPI 176 IRQ_TYPE_EDGE_RISING>;
> +				power-domains = <&pwrc PWRC_C3_SDIOA_ID>;
> +				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_A>,
> +					  <&clkc_periphs CLKID_SD_EMMC_A>,
> +					  <&clkc_pll CLKID_FCLK_DIV2>;
> +				clock-names = "core","clkin0", "clkin1";
> +				no-mmc;
> +				no-sd;
> +				resets = <&reset RESET_SD_EMMC_A>;
> +				status = "disabled";
> +			};
> +
> +			sd: mmc@8a000 {
> +				compatible = "amlogic,meson-axg-mmc";
> +				reg = <0x0 0x8a000 0x0 0x800>;
> +				interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
> +				power-domains = <&pwrc PWRC_C3_SDCARD_ID>;
> +				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_B>,
> +					<&clkc_periphs CLKID_SD_EMMC_B>,
> +					<&clkc_pll CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				no-mmc;
> +				no-sdio;
> +				resets = <&reset RESET_SD_EMMC_B>;
> +				status = "disabled";
> +			};
> +
> +			nand: nand-controller@8d000 {
> +				compatible = "amlogic,meson-axg-nfc";
> +				reg = <0x0 0x8d000 0x0 0x200>,
> +					<0x0 0x8C000 0x0 0x4>;
> +				reg-names = "nfc", "emmc";
> +				interrupts = <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_C>,
> +					<&clkc_pll CLKID_FCLK_DIV2>;
> +				clock-names = "core", "device";
> +				status = "disabled";
> +			};
> +		};
> +
> +		ethmac: ethernet@fdc00000 {
> +			compatible = "amlogic,meson-g12a-dwmac",
> +				     "snps,dwmac-3.70a",
> +				     "snps,dwmac";
> +			reg = <0x0 0xfdc00000 0x0 0x10000>,
> +			      <0x0 0xfe024000 0x0 0x8>;
> +			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			power-domains = <&pwrc PWRC_C3_ETH_ID>;
> +			clocks = <&clkc_periphs CLKID_SYS_ETH_MAC>,
> +				 <&clkc_pll CLKID_FCLK_DIV2>,
> +				 <&clkc_pll CLKID_FCLK_50M>;
> +			clock-names = "stmmaceth", "clkin0", "clkin1";
> +			rx-fifo-depth = <4096>;
> +			tx-fifo-depth = <2048>;
> +			status = "disabled";
> +
> +			mdio0: mdio {
> +				compatible = "snps,dwmac-mdio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
>   		};
>   	};
>   };
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

