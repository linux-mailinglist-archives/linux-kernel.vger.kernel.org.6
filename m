Return-Path: <linux-kernel+bounces-221163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594D290EFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3791284356
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF7614F9FD;
	Wed, 19 Jun 2024 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FvkNyZB0"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B231E520
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806033; cv=none; b=bE21mYSP1gap3vo8Q9v3r28jOmB92rVt6+WVGJwsW4b+xwUI1Ih0pbr5qG8YtMkQw/h9Fe0h7z2xDGZ3jgt+MebnPrAYZcTJr/VLhN0pU14mhEPmAs7lIp8ftdfTyo2Bi4osxRS45xsrbjIRlObmRAhvmMo2qUtVu7hQNN3zNT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806033; c=relaxed/simple;
	bh=5vQhgrD0UTxHQ/6GmQ7qCf2wJRBEhZnaq27QFpCJPjA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=obw1dQpyS07WJ8odM19MOJjcBfijd+61PQkhdXAEsCEL3izalMQ0vZasXHI3KrDrXyW+1VzWcBAxWn2ZpBcBgPN9wMyx1ah4mCcd6HH0njpNJ1XnW8aDVMwBC+EOfP9IszfzNlRXV//6u0EqO3RiDEDelBnw8SCcam/WMozyjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FvkNyZB0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-421798185f0so51708435e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806030; x=1719410830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:from:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvNRzX9jcLwBcxCr7W09YfmTyvAjymGLIi2ez7O65FQ=;
        b=FvkNyZB0AVZfOAStYjqV7/nSr00nJw9O5DRoEvQlUEaOLBXnSsv4NS+aB1ydbOGgbj
         Ye06uLrSsZ1D6zDEe5/wecpwwIPeqMUULVWvro005VqMhXFeKRVF/sRwY4lyXITBEk9A
         Spbw/pHjCmOi32pm0oyWghUT+Bc7vBXPRJsvbajiYhR/P11wk+UOTcqDihL3Dst7hmhP
         J4CHSHr3iLdswogGqyKUYdJNUYLcNu4hVVIsXAH4rvMNNApwxPGJc6TVlNX83WGLwK4n
         mzFUqnMKPfVkhN7a8lSBJKn4RAwnHyJXkFh2SwFhZqIot4tfE0fCtqaaxEab8vV4+dRi
         2k7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806030; x=1719410830;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:from:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EvNRzX9jcLwBcxCr7W09YfmTyvAjymGLIi2ez7O65FQ=;
        b=tsjktOd4qNhSZCBFYVzlkbDW0ZTyh1gnsay6SpleJG8wiq7QvkyFY0MDkypW5YJ9xv
         WHLE55JoSKoqMu4bIO3IjFxjKHzvSbSB1QYTD+YnViBSYl/usEMWIk+uIRwTaX/cgMEH
         4yUzz7Pwf2/0tNmavyUWrh5Hpa0q0v4BoDzSRDOOiUWEowyNQOM3AzEzEeBSB/5aNss8
         ClTAuk6n0VB7nf/6EfyxFrU9WZdi7bYptlwiI4S3ylT4xt08kxZDtqE03LN9Ggbn7NKh
         9RVm7xgy4PszyC4rbIwIYSJjxolTdrAbDBci/N6vIhHBeFZNCEMLqaEx30en1Oig6iX2
         8zFA==
X-Forwarded-Encrypted: i=1; AJvYcCV0gLLgicvpeDfcHOy7tHmJzpjmffUlCwbEkATX8H4Ts1ASa+y213b3Gq/XU6UgQ7uzqEerrOiiFf05BcwpenYBXxXIbGvPFMO1PYDa
X-Gm-Message-State: AOJu0YznAhNwwvA59BAfeF1UmJSqAMlWoAF/0Hq78aMdObsYuXeQAcDD
	4dM3dhsYknZ58yZyHpHSIDxjxV4sk7LjGbqEBxc1d5Xf2+I5oB9lq4FbVcIg9a8=
X-Google-Smtp-Source: AGHT+IGtC12gpkPtbeUR78gff0vhR29nB2shyxGMQWYn58zRrJ5/tXgaDpozULx3vEL3Ew4yhNGxvQ==
X-Received: by 2002:a05:600c:1c94:b0:424:798c:120a with SMTP id 5b1f17b1804b1-424798c1341mr10212795e9.24.1718806029227;
        Wed, 19 Jun 2024 07:07:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ed45:cb25:b4fd:b1fa? ([2a01:e0a:982:cbb0:ed45:cb25:b4fd:b1fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602ef0bsm227763245e9.18.2024.06.19.07.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 07:07:08 -0700 (PDT)
Message-ID: <a900c8be-7e78-499e-9778-913dd8f6970f@linaro.org>
Date: Wed, 19 Jun 2024 16:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: meson: add support for OSMC Vero 4K
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Christian Hewitt <christianshewitt@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240606095419.3950015-1-christianshewitt@gmail.com>
 <20240606095419.3950015-2-christianshewitt@gmail.com>
 <7b877bc6-9e26-4bae-934a-ceb9663d751d@linaro.org>
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
In-Reply-To: <7b877bc6-9e26-4bae-934a-ceb9663d751d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/06/2024 10:07, Neil Armstrong wrote:
> On 06/06/2024 11:54, Christian Hewitt wrote:
>> The OSMC Vero 4K device is based on the Amlogic S905X (P212)
>> reference design with the following specifications:
>>
>> - 2GB DDR4 RAM
>> - 16GB eMMC
>> - HDMI 2.1 video
>> - S/PDIF optical output
>> - AV output
>> - 10/100 Ethernet
>> - AP6255 Wireless (802.11 a/b/g/n/ac, BT 4.2)
>> - 2x USB 2.0 ports (1x OTG)
>> - IR receiver (internal)
>> - IR extender port (external)
>> - 1x micro SD card slot
>> - 1x Power LED (red)
>> - 1x Reset button (in AV jack)
>>
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/Makefile          |   7 +
>>   .../dts/amlogic/meson-gxl-s905x-vero4k.dts    | 202 ++++++++++++++++++
>>   2 files changed, 209 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index 4addcae2c54e..78941ddd3136 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -55,6 +55,13 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-sml5442tw.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-vero4k-plus.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-khadas-vim.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-vero4k.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-jethome-jethub-j80.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts
>> new file mode 100644
>> index 000000000000..b325cd75a792
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.dts
>> @@ -0,0 +1,202 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2024 Christian Hewitt <christianshewitt@gmail.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "meson-gxl-s905x-p212.dtsi"
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include <dt-bindings/sound/meson-aiu.h>
>> +
>> +/ {
>> +    compatible = "osmc,vero4k", "amlogic,s905x", "amlogic,meson-gxl";
>> +    model = "OSMC Vero 4K";
>> +
>> +    reserved-memory {
>> +        /* 32 MiB reserved for ARM Trusted Firmware (BL32) */
>> +        secmon_reserved_bl32: secmon@5300000 {
>> +            reg = <0x0 0x05300000 0x0 0x2000000>;
>> +            no-map;
>> +        };
>> +    };
>> +
>> +    gpio-keys-polled {
>> +        compatible = "gpio-keys-polled";
>> +        poll-interval = <20>;
>> +
>> +        button {
>> +            label = "power";
>> +            linux,code = <KEY_POWER>;
>> +            gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
>> +        };
>> +    };
>> +
>> +    leds {
>> +        compatible = "gpio-leds";
>> +
>> +        led-standby {
>> +            color = <LED_COLOR_ID_RED>;
>> +            function = LED_FUNCTION_POWER;
>> +            gpios = <&gpio GPIODV_24 GPIO_ACTIVE_LOW>;
>> +            default-state = "off";
>> +            panic-indicator;
>> +        };
>> +    };
>> +
>> +    dio2133: analog-amplifier {
>> +        compatible = "simple-audio-amplifier";
>> +        sound-name-prefix = "AU2";
>> +        VCC-supply = <&hdmi_5v>;
>> +        enable-gpios = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
>> +    };
>> +
>> +    spdif_dit: audio-codec-0 {
>> +        #sound-dai-cells = <0>;
>> +        compatible = "linux,spdif-dit";
>> +        sound-name-prefix = "DIT";
>> +    };
>> +
>> +    cvbs-connector {
>> +        compatible = "composite-video-connector";
>> +
>> +        port {
>> +            cvbs_connector_in: endpoint {
>> +                remote-endpoint = <&cvbs_vdac_out>;
>> +            };
>> +        };
>> +    };
>> +
>> +    hdmi-connector {
>> +        compatible = "hdmi-connector";
>> +        type = "a";
>> +
>> +        port {
>> +            hdmi_connector_in: endpoint {
>> +                remote-endpoint = <&hdmi_tx_tmds_out>;
>> +            };
>> +        };
>> +    };
>> +
>> +    sound {
>> +        compatible = "amlogic,gx-sound-card";
>> +        model = "VERO4K";
>> +        audio-aux-devs = <&dio2133>;
>> +        audio-widgets = "Line", "Lineout";
>> +        audio-routing = "AU2 INL", "ACODEC LOLP",
>> +                "AU2 INR", "ACODEC LORP",
>> +                "AU2 INL", "ACODEC LOLN",
>> +                "AU2 INR", "ACODEC LORN",
>> +                "Lineout", "AU2 OUTL",
>> +                "Lineout", "AU2 OUTR";
>> +
>> +        dai-link-0 {
>> +            sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
>> +        };
>> +
>> +        dai-link-1 {
>> +            sound-dai = <&aiu AIU_CPU CPU_SPDIF_FIFO>;
>> +        };
>> +
>> +        dai-link-2 {
>> +            sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
>> +            dai-format = "i2s";
>> +            mclk-fs = <256>;
>> +
>> +            codec-0 {
>> +                sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
>> +            };
>> +
>> +            codec-1 {
>> +                sound-dai = <&aiu AIU_ACODEC CTRL_I2S>;
>> +            };
>> +        };
>> +
>> +        dai-link-3 {
>> +            sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
>> +
>> +            codec-0 {
>> +                sound-dai = <&spdif_dit>;
>> +            };
>> +        };
>> +
>> +        dai-link-4 {
>> +            sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
>> +
>> +            codec-0 {
>> +                sound-dai = <&hdmi_tx>;
>> +            };
>> +        };
>> +
>> +        dai-link-5 {
>> +            sound-dai = <&aiu AIU_ACODEC CTRL_OUT>;
>> +
>> +            codec-0 {
>> +                sound-dai = <&acodec>;
>> +            };
>> +        };
>> +    };
>> +};
>> +
>> +&acodec {
>> +    AVDD-supply = <&vddio_ao18>;
>> +    status = "okay";
>> +};
>> +
>> +&aiu {
>> +    status = "okay";
>> +    pinctrl-0 = <&spdif_out_h_pins>;
>> +    pinctrl-names = "default";
>> +};
>> +
>> +&cec_AO {
>> +    status = "okay";
>> +    pinctrl-0 = <&ao_cec_pins>;
>> +    pinctrl-names = "default";
>> +    hdmi-phandle = <&hdmi_tx>;
>> +};
>> +
>> +&clkc {
>> +    assigned-clocks = <&clkc CLKID_MPLL0>,
>> +              <&clkc CLKID_MPLL1>,
>> +              <&clkc CLKID_MPLL2>;
>> +    assigned-clock-parents = <0>, <0>, <0>;
>> +    assigned-clock-rates = <294912000>,
>> +                   <270950400>,
>> +                   <393216000>;
>> +};
>> +
>> +&cvbs_vdac_port {
>> +    cvbs_vdac_out: endpoint {
>> +        remote-endpoint = <&cvbs_connector_in>;
>> +    };
>> +};
>> +
>> +&ethmac {
>> +    phy-mode = "rmii";
>> +    phy-handle = <&internal_phy>;
>> +};
>> +
>> +&hdmi_tx {
>> +    status = "okay";
>> +    pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
>> +    pinctrl-names = "default";
>> +    hdmi-supply = <&hdmi_5v>;
>> +};
>> +
>> +&hdmi_tx_tmds_port {
>> +    hdmi_tx_tmds_out: endpoint {
>> +        remote-endpoint = <&hdmi_connector_in>;
>> +    };
>> +};
>> +
>> +&internal_phy {
>> +    pinctrl-0 = <&eth_link_led_pins>, <&eth_act_led_pins>;
>> +    pinctrl-names = "default";
>> +};
>> +
>> +/* This UART is brought out to the DB9 connector */
>> +&uart_AO {
>> +    status = "okay";
>> +};
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


Same here, Can you resent but keeping the assigned-clocks in the sound card node ?

BTW keep the reviewed-by.

Thanks,
Neil

