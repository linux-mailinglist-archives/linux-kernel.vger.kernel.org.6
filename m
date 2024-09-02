Return-Path: <linux-kernel+bounces-311618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35CB968B40
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79921C2260B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CB31A2644;
	Mon,  2 Sep 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ1/lZYR"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99A13C9C7;
	Mon,  2 Sep 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291871; cv=none; b=GC99NDTuzs37NqTLOr9kEga6org4FZTvBmQguRFBtFYRT9GXNoBzZBDOFLCAbxjr9EA/xD2gQumqgy5QGpOb7WOusGv2g0eDeSpZrGwsd5WiriFs+T9h6RESlA+oXhaUGGHTlUYuuZUMdWSUxCNmuII5yX3ix4NEv6fcxwZOxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291871; c=relaxed/simple;
	bh=botBJ1tiJN2v+NSYDlbgyNUsQ2trEkjHt/pGezG+2VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIlR+KVccpbHigHIsWnbkKGS5/9R3u0Aa0pyfRtcwshStahobMyFmJZC4R8XM/4h+FrPflsNco1HzVjst3ieK5K8vnu5mkgEZKchxDRb2zIPUPjekeIzukTbAtljm35RE6VLNnmBgan32naOw5vTk0qJKNGX8y+VYBfM7U/MG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ1/lZYR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334879ba28so6153382e87.3;
        Mon, 02 Sep 2024 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725291868; x=1725896668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FP5u0P3Ro8DGfBZjAhSMaSTilOOjxZnvSRuA8wU6ado=;
        b=QZ1/lZYRdyf0YmGMbm3bRPARiq9nM1QxvvpcQGbhqPYTe3lBXp1ilhG3+wIlYxk2KB
         jsc75FQULiMV8H/YHe490egYeKK5DbwBEAquk2Pa8tOJJCW4nZMuVsvFNV/RqqbklJpI
         gdIdzho/aEA1dyXzlML4J8mYWPz4BXzJXB3KEwaGsaTGdjgzLqYxdD//RXOKRfd2I+Om
         Dau2ih3C8Gi7phFMb41LSTLjDDtiBQPSNwaJ9PTvK28+Zvd/8Al/26d3BsUGmxjLPx6s
         ZYk8wYrqa/TQA4v2iB/LYBE+6EmpZpo3QlPUsLeZzRN+U8CdyJwhm1R2w57N+xM2WE/u
         6WPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725291868; x=1725896668;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP5u0P3Ro8DGfBZjAhSMaSTilOOjxZnvSRuA8wU6ado=;
        b=GAhR8/+CKKquDWjuJoMg+46TBBIoaAj7AGOUkp15WiGgsMViatFsLKgSYm3YesQmwh
         CIWiqaYuzNVibLE30dnlY8Wa6klbgPtxq4tdqnoQjUS/qYy96QYM9fPbLjzTSQa92/bZ
         kUKo0OWCT4W3yxr9TV7VO80KCmn+QKLaqqVKRNSVWaHrUjC3O/ZkxtpxsO864Hl4ur4V
         +e+ehMU88yCUzWKBf2xzLuh040aCbvQW3lWaNZF+ckmOYoHqoziG20USJ4RORA63jLEl
         u1XzUzAmJhq+P0SfXBAfeDWEFXTcAZefbfAKs9HpO0qvBxxw9DAZyKOEs0c4WQYj4YCv
         l+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLnjZ38ccvv6NYRgvg98Qyi3YDtrRk5PiUzYPfqEG0U+ME9adff26kLwKR6kBKotuCZLyXeOCCN6Ap@vger.kernel.org
X-Gm-Message-State: AOJu0YxdoeCvyCMJihCg/jgTqrCuV5v1SaFB+BvaPHbi6Gp5WxZerAfL
	RqCis6z41JWNnGF87AoGmGhM+xcChyx9RCB6k4w/NaMOb7bJLzVC
X-Google-Smtp-Source: AGHT+IEgfNaR3U3/b1uiiFFzr2EHklk9wo8C+1+IZLOlEr0ViAXQdcdOmk/tJH3WaUnAg4lxM5ksZg==
X-Received: by 2002:a05:6512:1318:b0:52c:dfa7:9f43 with SMTP id 2adb3069b0e04-53546b43623mr7531624e87.34.1725291867234;
        Mon, 02 Sep 2024 08:44:27 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898908ce6asm576985566b.92.2024.09.02.08.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 08:44:26 -0700 (PDT)
Message-ID: <434edbf2-da3f-49b2-9ee4-d12e84428d44@gmail.com>
Date: Mon, 2 Sep 2024 17:44:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 2/2] arm64: dts: mediatek: mt8183-pumpkin: add
 HDMI support
To: Pin-yen Lin <treapking@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Fabien Parent <fparent@baylibre.com>
References: <20240819120735.1508789-1-treapking@chromium.org>
 <20240819120735.1508789-2-treapking@chromium.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240819120735.1508789-2-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/08/2024 14:05, Pin-yen Lin wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> The MT8183 Pumpkin board has a micro-HDMI connector. HDMI support is
> provided by an IT66121 DPI <-> HDMI bridge.
> 
> This commit enables DPI and add the node for the IT66121 bridge.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 

Building DTB fais with:
arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts:138.27-169.4: ERROR 
(phandle_references): /soc/i2c@11005000/hdmitx@4c: Reference to non-existent 
node or label "mt6358_vcn33_wifi_reg"

Please check your code before submitting.

Regards,
Matthias

> ---
> 
> (no changes since v1)
> 
>   .../boot/dts/mediatek/mt8183-pumpkin.dts      | 121 ++++++++++++++++++
>   1 file changed, 121 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> index 1aa668c3ccf9..ecc237355b56 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> @@ -63,6 +63,18 @@ thermistor {
>   		pulldown-ohm = <0>;
>   		io-channels = <&auxadc 0>;
>   	};
> +
> +	connector {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "d";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_connector_out>;
> +			};
> +		};
> +	};
>   };
>   
>   &auxadc {
> @@ -120,6 +132,41 @@ &i2c6 {
>   	pinctrl-0 = <&i2c6_pins>;
>   	status = "okay";
>   	clock-frequency = <100000>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	it66121hdmitx: hdmitx@4c {
> +		compatible = "ite,it66121";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ite_pins>;
> +		vcn33-supply = <&mt6358_vcn33_wifi_reg>;
> +		vcn18-supply = <&mt6358_vcn18_reg>;
> +		vrf12-supply = <&mt6358_vrf12_reg>;
> +		reset-gpios = <&pio 160 GPIO_ACTIVE_LOW>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
> +		reg = <0x4c>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				it66121_in: endpoint {
> +					bus-width = <12>;
> +					remote-endpoint = <&dpi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				hdmi_connector_out: endpoint {
> +					remote-endpoint = <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};
>   };
>   
>   &keyboard {
> @@ -362,6 +409,67 @@ pins_clk {
>   			input-enable;
>   		};
>   	};
> +
> +	ite_pins: ite-pins {
> +		pins-irq {
> +			pinmux = <PINMUX_GPIO4__FUNC_GPIO4>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		pins-rst {
> +			pinmux = <PINMUX_GPIO160__FUNC_GPIO160>;
> +			output-high;
> +		};
> +	};
> +
> +	dpi_func_pins: dpi-func-pins {
> +		pins-dpi {
> +			pinmux = <PINMUX_GPIO12__FUNC_I2S5_BCK>,
> +				 <PINMUX_GPIO46__FUNC_I2S5_LRCK>,
> +				 <PINMUX_GPIO47__FUNC_I2S5_DO>,
> +				 <PINMUX_GPIO13__FUNC_DBPI_D0>,
> +				 <PINMUX_GPIO14__FUNC_DBPI_D1>,
> +				 <PINMUX_GPIO15__FUNC_DBPI_D2>,
> +				 <PINMUX_GPIO16__FUNC_DBPI_D3>,
> +				 <PINMUX_GPIO17__FUNC_DBPI_D4>,
> +				 <PINMUX_GPIO18__FUNC_DBPI_D5>,
> +				 <PINMUX_GPIO19__FUNC_DBPI_D6>,
> +				 <PINMUX_GPIO20__FUNC_DBPI_D7>,
> +				 <PINMUX_GPIO21__FUNC_DBPI_D8>,
> +				 <PINMUX_GPIO22__FUNC_DBPI_D9>,
> +				 <PINMUX_GPIO23__FUNC_DBPI_D10>,
> +				 <PINMUX_GPIO24__FUNC_DBPI_D11>,
> +				 <PINMUX_GPIO25__FUNC_DBPI_HSYNC>,
> +				 <PINMUX_GPIO26__FUNC_DBPI_VSYNC>,
> +				 <PINMUX_GPIO27__FUNC_DBPI_DE>,
> +				 <PINMUX_GPIO28__FUNC_DBPI_CK>;
> +		};
> +	};
> +
> +	dpi_idle_pins: dpi-idle-pins {
> +		pins-idle {
> +			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>,
> +				 <PINMUX_GPIO46__FUNC_GPIO46>,
> +				 <PINMUX_GPIO47__FUNC_GPIO47>,
> +				 <PINMUX_GPIO13__FUNC_GPIO13>,
> +				 <PINMUX_GPIO14__FUNC_GPIO14>,
> +				 <PINMUX_GPIO15__FUNC_GPIO15>,
> +				 <PINMUX_GPIO16__FUNC_GPIO16>,
> +				 <PINMUX_GPIO17__FUNC_GPIO17>,
> +				 <PINMUX_GPIO18__FUNC_GPIO18>,
> +				 <PINMUX_GPIO19__FUNC_GPIO19>,
> +				 <PINMUX_GPIO20__FUNC_GPIO20>,
> +				 <PINMUX_GPIO21__FUNC_GPIO21>,
> +				 <PINMUX_GPIO22__FUNC_GPIO22>,
> +				 <PINMUX_GPIO23__FUNC_GPIO23>,
> +				 <PINMUX_GPIO24__FUNC_GPIO24>,
> +				 <PINMUX_GPIO25__FUNC_GPIO25>,
> +				 <PINMUX_GPIO26__FUNC_GPIO26>,
> +				 <PINMUX_GPIO27__FUNC_GPIO27>,
> +				 <PINMUX_GPIO28__FUNC_GPIO28>;
> +		};
> +	};
>   };
>   
>   &pmic {
> @@ -415,3 +523,16 @@ &scp {
>   &dsi0 {
>   	status = "disabled";
>   };
> +
> +&dpi0 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&dpi_func_pins>;
> +	pinctrl-1 = <&dpi_idle_pins>;
> +	status = "okay";
> +
> +	port {
> +		dpi_out: endpoint {
> +			remote-endpoint = <&it66121_in>;
> +		};
> +	};
> +};

