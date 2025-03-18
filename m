Return-Path: <linux-kernel+bounces-565928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4857BA67127
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5E33B7DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6C207DF5;
	Tue, 18 Mar 2025 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJs22iJZ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647D2080EB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293448; cv=none; b=hzGnh+GgYU+XfeD/MZUVaq43ZcovdcF/Jb+fuPcVpGpCpLm0n2nivOSW07HPQiLQ068M36kSXdCMfq/K2kggCF6Gjw08Y4L17PgEejCh2v0D7SDJhVCPHq7GFrLYaATGDeQqBkQigUomRV5y7Sbmu0vJH/OoE4RzDIoDeU1qvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293448; c=relaxed/simple;
	bh=jh4jaEcZDcCJpbI95rS/PqufL9tYhj0AYmCryTIfOSE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EERemQZBsOWjxVnwFjWn/vrhpEZVfGqoxkm0oeZHJWAXkDmyqBG6PC2GA24Imdk5c/Hzt55d07mkdkLzT9E6OvfGupxvcv9OTsgxYFhRV+KN3rIu2tw2xmsU9qg/YZ1yYXEhPPMNgZWyvrB98r6tZoT4c1tYRtLSKeHXPdtQDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FJs22iJZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913d129c1aso4329594f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742293444; x=1742898244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9s1MLqZ99Jjf0BTVsynVNUuDrFuTR6hcyH+PJ/kt3J0=;
        b=FJs22iJZTq2UMAv5Oeiw7I9/TTriwQc6t+qCr93to+38cUmrNAjSLk+6S6rM5jw+zZ
         CcPOEWG046kGMtXZq75DMDQEVl15+QDrmCNFvf9pvdxPrY3JhljJoBh60lCx0fUBDIAt
         E8vXSUTyWbegU2nV3ruulOu3ycto5ZY9x4nlC4gdrJcNkhwq3FOYyg8xSqguscHV0pWq
         52SHE0XKFZJKjah19fyOk5BDWamItgjY/HIEX+Dp0byUKfq+SA3pDWDppML5JQLaV3Sh
         T5HFrb9U00SKVW1ma4N1vFQA+4nR9pmkPv0vFDCQ8k9rnS8eArkTHrNKH9H0SyvcPmD9
         NOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293444; x=1742898244;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9s1MLqZ99Jjf0BTVsynVNUuDrFuTR6hcyH+PJ/kt3J0=;
        b=wEo6kC836dygvMBjQBQyX/7da7Naa2qwwB1hjkqNOHvAKiU2rMTIgBWyDXktE7oAX2
         7nZMHF3G9ByngVKmBBKNEinFX8iKAoG5cFm1X3eKwvhi9fPx8vK+yGGW71SVRQdLd7HK
         JTWZZaBJn3P6L7P86Ygu2fNukk20LcPqhg8iETpTs1rgTQ5sb/L+Uga5s5uI/e3wI73P
         LUsbbZdbudGfvtvh6XALLGLAtPOHNa9gR+NyF9p7oNSwNtfCTPNRYL5lPikFlSRF+Q4N
         o9yiQc2GVzq+MsyW6Moypf/GJv+4Fj2llDP+SHX+K/8QkpSIL1n5RSQ9zH1qaEeFDHC2
         uVsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU71LdIZGYQhXork07KdK6ocnjZODZqqtXa8MhkNMKa0LTx7caoMbOzq2qaM5ssg/8iGQmGL0UEj25sO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnhH41PrLv4EppH0liGxeZX3GzBZZdW4caBUM7t3uD50i2v4V
	/5OsxOnwiePtSUC+Pnry/WsrW8Esd9q6nmw59My7/yUuvtfrhvQLrL9CbN1ff+8=
X-Gm-Gg: ASbGncs8FmhGyD41s2SdUh4gWyD0/VPKR5aqv3FTq3AFuvjKpyrYYICIOuLCVpd/kOG
	04RzP1cX4iA/lwH5kX9FzlMPEUr17C3TjOhPjHtyzpfsD+uTP+y1EwLplOboSMtC+z+Avi0gKyz
	JiEYBaTRAtYpDAK8ZI5rphMnqWUGBurCyKwwo1Oh08e6O/+ndEtZfPM43ts0E8adS1pXhWNGPlh
	n0uJi3IKXfHWtgO8NnEgMFz0H5GD2x68E/LlSPj8r0XJHply/wcgTC64HQQhdpHzmbzCkMa9ACT
	j9WCO3yprkSHrTu+BIEiEGQFaYUgWfXXAN46DAyQknQ5uMN0yamLKv59sOdWDdGxWXx6ct/JLi0
	/04QZBFgPA5XfRb0zWwZCRQ==
X-Google-Smtp-Source: AGHT+IHtzyqVRAga6Hl6uXNlyniza06JK+93mCeNwBJWGNRf6bcJIa0OCbOvW1yls2I+teoXyKiouQ==
X-Received: by 2002:a05:6000:1566:b0:38d:ae1e:2f3c with SMTP id ffacd0b85a97d-3996bb560d6mr2356028f8f.25.1742293444284;
        Tue, 18 Mar 2025 03:24:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:eac1:f2d4:84a8:c5ff? ([2a01:e0a:3d9:2080:eac1:f2d4:84a8:c5ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a10sm17870384f8f.36.2025.03.18.03.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:24:03 -0700 (PDT)
Message-ID: <61a0eb6c-aa15-4316-9e4b-929c3cad13c9@linaro.org>
Date: Tue, 18 Mar 2025 11:24:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] arm64: dts: amlogic: Add Ugoos AM3
To: j.ne@posteo.net, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20250314-ugoos-am3-v2-0-422104b0cec5@posteo.net>
 <20250314-ugoos-am3-v2-2-422104b0cec5@posteo.net>
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
In-Reply-To: <20250314-ugoos-am3-v2-2-422104b0cec5@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/03/2025 00:11, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> The Ugoos AM3 is a small set-top box based on the Amlogic S912 SoC,
> with a board design that is very close to the Q20x development boards.
> The MMC max-frequency properties are copied from the downstream device
> tree.
> 
>    https://ugoos.com/ugoos-am3-16g
> 
> The following functionality has been tested and is known to work:
>   - debug serial port
>   - "update" button inside the case
>   - USB host mode, on all three ports
>   - HDMI video/audio output
>   - eMMC, MicroSD, and SDIO WLAN
>   - S/PDIF audio output
>   - Ethernet
>   - Infrared remote control input
> 
> The following functionality doesn't seem to work:
>   - USB role switching and device mode on the "OTG" port
>   - case LED
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V2:
> - Fix vendor name in patch subject
> - Remove incorrect override of SDIO pwrseq reset line
> ---
>   arch/arm64/boot/dts/amlogic/Makefile               |  1 +
>   .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  2 +-
>   .../arm64/boot/dts/amlogic/meson-gxm-ugoos-am3.dts | 91 ++++++++++++++++++++++
>   3 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 2fbda8419c65a3056410ac45ca3ddaceb69ea4f5..bf2bc14528bfa27e8d6ae2730085fc356d6c6dd8 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -76,6 +76,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-libretech-pc.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxm-ugoos-am3.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-s4-s805x2-aq222.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> index 45ccddd1aaf0546632c81a52c8917a923beae883..4223b26f7d0f3aa47e42e9434d24f73b20441981 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> @@ -97,7 +97,7 @@ sdio_pwrseq: sdio-pwrseq {
>   		clock-names = "ext_clock";
>   	};
>   
> -	cvbs-connector {
> +	cvbs_connector: cvbs-connector {
>   		compatible = "composite-video-connector";
>   
>   		port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-ugoos-am3.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-ugoos-am3.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..ba871f3f53bb99b47b325bae228b59b722c5123b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-ugoos-am3.dts
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 J. Neuschäfer <j.ne@posteo.net>
> + *
> + * Debug UART (3.3V, 115200 baud) at the corner of the board:
> + *   (4) (3) (2) [1]
> + *   Vcc RXD TXD GND
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/amlogic,meson-g12a-gpio-intc.h>
> +
> +#include "meson-gxm.dtsi"
> +#include "meson-gx-p23x-q20x.dtsi"
> +
> +/ {
> +	compatible = "ugoos,am3", "amlogic,s912", "amlogic,meson-gxm";
> +	model = "Ugoos AM3";
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1710000>;
> +
> +		button-function {
> +			label = "Update";
> +			linux,code = <KEY_VENDOR>;
> +			press-threshold-microvolt = <10000>;
> +		};
> +	};
> +};
> +
> +&cvbs_connector {
> +	/* Not used on this board */
> +	status = "disabled";
> +};
> +
> +&ethmac {
> +	pinctrl-0 = <&eth_pins>;
> +	pinctrl-names = "default";
> +
> +	/* Select external PHY by default */
> +	phy-handle = <&external_phy>;
> +
> +	amlogic,tx-delay-ns = <2>;
> +
> +	/* External PHY is in RGMII */
> +	phy-mode = "rgmii";
> +
> +	status = "okay";
> +};
> +
> +&external_mdio {
> +	external_phy: ethernet-phy@0 {
> +		/* Realtek RTL8211F (0x001cc916) */
> +		reg = <0>;
> +
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <80000>;
> +		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
> +
> +		interrupt-parent = <&gpio_intc>;
> +		/* MAC_INTR on GPIOZ_15 */
> +		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&i2c_B {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c_b_pins>;
> +
> +	rtc: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +	};
> +};
> +
> +/* WLAN: Atheros 10k (QCA9377) */
> +&sd_emmc_a {
> +	max-frequency = <200000000>;
> +};
> +
> +/* eMMC */
> +&sd_emmc_c {
> +	max-frequency = <100000000>;
> +};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

