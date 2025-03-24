Return-Path: <linux-kernel+bounces-573233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10C2A6D48E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E131188A0F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5672505A5;
	Mon, 24 Mar 2025 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zh3xaXRJ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FDF24F599
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800004; cv=none; b=UuM4ZxISWSDJPFviWst5ccW0YRpQ3P6OEZ+lR9ZV6u7B/thkIm3nWuiZPfNJcOZ9eT3sS+mxFi9oM7WKG7cctZ3X42/o72Z0n2eLCWEzILiLv5Qr5iH8oCUzHBq1iRvegNcM1/QRl6iUztZ0KUPQPTFqoE4g+3DE+xHxTpsoxeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800004; c=relaxed/simple;
	bh=JNeEAtWEz/shAbHDBMxqR7YafgsvRHXKdLCDlFyIwZI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qM2VGfeVPrBGGERnadvzUCREc83yAXAx68OoVGVgGgX1FUW3OpblcArCh4YQUJoLPUStnlecCgGfQT5s7j6/hqDkJXH7Kc+c7tHQK1rLJf7WXt2i8w75n5QhR2DvzSrIUfQUUPaJuRmwF84B7V9aBN2wkjEFGw8QrCQd1dyq/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zh3xaXRJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0618746bso25750475e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742800001; x=1743404801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnmDKnt+3x8rZ4oEZN/cwh/A9C0xUNyVpIFqNNgq/qA=;
        b=Zh3xaXRJEBvug8U5PA88andDcn0ZqQV7ubPtzcfah8yH9pDD4PhSaKDnznjV1V+fdR
         Xersy9lvD8WrRBzcuKGknm0HFra+2m7z/fLd1NtbEj1pt/ubJUIWDlhe3Y0OaFFfsNb0
         i6EQZDulslJ99jFx8fcVDyl+4/B2uWdPzPzH64/sQvR45D4XuUimJHHzylEIjMvFe+s9
         20HsQLzGXlb2JopcwauPCWEI3hns0fwrh11d/1XeMqk1Sqz+ceDL441bfH1fV65yeoQx
         YgyVfIoBjOTKQ3tKypoVXJmRYoQHlTUlPBkRgrHW4gvkQetSc+7KJW1f8NCfrATfgBjt
         rD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742800001; x=1743404801;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qnmDKnt+3x8rZ4oEZN/cwh/A9C0xUNyVpIFqNNgq/qA=;
        b=wyhr/09J1kBKhNtjrY2fdoJRiwvUSUU5SF7p8bS1JjqE62aZ9oce6kTEwnmCSejTkA
         0pIVtA44yKvOkyuBBwgNmzPf4W7wG4+lgAjH8CDJ8OB7AHHQp8ntazYqMXe++E2moMnY
         dbgTsoCntK551nwQ+7zMDOSalqi+b74EwJLHZ07fLRcryl8I4+g7xbEAWW8bot4zjINK
         zHPpCOiGxcdXeRa1JuZR3ZFrkOirh3IgVsoDJgxdaQK3FtD1vteA0MxExH2E3E4bxb4j
         Mc6pE2cyaFaLxYIkP5d7gDvwqcavj7ZdaK4OeAryfx0jXmABQorOLUMqlQGlzVgRT4Td
         7tpg==
X-Forwarded-Encrypted: i=1; AJvYcCXdvkmY1NL0mm9kmxqwatZd3des1YIZuVLP2xbWAOCa8wZP8kjpy7zws4sMk8xqJ7WVJRh7N6XGkJUob4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzraGX1H+K7yEiEpBTy+OZpRowpweSHjdMeyfHRY3WYMi770RB
	iNNBzymnjDAWNSiSW6wqVp7xlvGVeyzwFJ+PqvrjWdUaVL0L4lkxkldM+4rClBnJhITgnXTwXoz
	c
X-Gm-Gg: ASbGncvmphg0nNv8LfYJhwebwwIOfiAUKlGBUhc9y9lpYLXtJYoL/OFQ6vJAj/8jAFF
	0Ca6b2O+ZL9biyGFZCxtPk9EE87ZeQUTa1MAPqCym6yz/P6x20CHwodGYKK1xW8HsMM21I3j/nq
	xXd0zeORn2ABXECy33xEbVpUWQuvEj2ifxUUVLi2GXwyW2wKa6GR6Isgojup+t2wkm1mxUMjk5T
	wfkoC/sglKr2XcITnFwi013BFCR3YN6ieFtXqKg2w7FCVeeB0YcwV1nUn3pzOJC+3tL1ML+Yw/Y
	wR273XW4AtshqR4lk5ii2weYhxuYtiioBo/E45gTOS3ZXcyMSq3jWLInQ/xxXg8cuhGtmltC4fd
	5brRiHGSewBDSyJsercIuyIfLSUs=
X-Google-Smtp-Source: AGHT+IEb+RllboZvRFdgVsQATpGzqRiQIUj/XZMAGqa20bkDRnSgciaHkWRmRX6hFu38Os+eZIOsfw==
X-Received: by 2002:a05:600c:34cc:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-43d50a3c1d4mr97177875e9.28.1742800000709;
        Mon, 24 Mar 2025 00:06:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a356:8d0:d4d:bb5f? ([2a01:e0a:3d9:2080:a356:8d0:d4d:bb5f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9957aasm10173629f8f.10.2025.03.24.00.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 00:06:40 -0700 (PDT)
Message-ID: <e01d48c6-287b-476a-b5ca-de670375561d@linaro.org>
Date: Mon, 24 Mar 2025 08:06:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 2/3] arm64: dts: amlogic: Add A4 Reset Controller
To: kelvin.zhang@amlogic.com, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20250320-a4-a5-reset-v5-0-296f83bf733d@amlogic.com>
 <20250320-a4-a5-reset-v5-2-296f83bf733d@amlogic.com>
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
In-Reply-To: <20250320-a4-a5-reset-v5-2-296f83bf733d@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 10:42, Kelvin Zhang via B4 Relay wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add the device node and related header file for Amlogic
> A4 reset controller.
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> Link: https://lore.kernel.org/r/20240918074211.8067-3-zelong.dong@amlogic.com
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h | 93 ++++++++++++++++++++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi    |  8 +++
>   2 files changed, 101 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h b/arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..f6a4c90bab3cf7cfaa3c98c522bed5e455b73bd3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __DTS_AMLOGIC_A4_RESET_H
> +#define __DTS_AMLOGIC_A4_RESET_H
> +
> +/* RESET0 */
> +/*						0-3 */
> +#define RESET_USB				4
> +/*						5-6*/
> +#define RESET_U2PHY22				7
> +#define RESET_USBPHY20				8
> +#define RESET_U2PHY21				9
> +#define RESET_USB2DRD				10
> +#define RESET_U2H				11
> +#define RESET_LED_CTRL				12
> +/*						13-31 */
> +
> +/* RESET1 */
> +#define RESET_AUDIO				32
> +#define RESET_AUDIO_VAD				33
> +/*						34*/
> +#define RESET_DDR_APB				35
> +#define RESET_DDR				36
> +#define RESET_VOUT_VENC				37
> +#define RESET_VOUT				38
> +/*						39-47 */
> +#define RESET_ETHERNET				48
> +/*						49-63 */
> +
> +/* RESET2 */
> +#define RESET_DEVICE_MMC_ARB			64
> +#define RESET_IRCTRL				65
> +/*						66*/
> +#define RESET_TS_PLL				67
> +/*						68-72*/
> +#define RESET_SPICC_0				73
> +#define RESET_SPICC_1				74
> +/*						75-79*/
> +#define RESET_MSR_CLK				80
> +/*						81*/
> +#define RESET_SAR_ADC				82
> +/*						83-87*/
> +#define RESET_ACODEC				88
> +/*						89-90*/
> +#define RESET_WATCHDOG				91
> +/*						92-95*/
> +
> +/* RESET3 */
> +/*						96-127 */
> +
> +/* RESET4 */
> +/*						128-131 */
> +#define RESET_PWM_AB				132
> +#define RESET_PWM_CD				133
> +#define RESET_PWM_EF				134
> +#define RESET_PWM_GH				135
> +/*						136-137*/
> +#define RESET_UART_A				138
> +#define RESET_UART_B				139
> +/*						140*/
> +#define RESET_UART_D				141
> +#define RESET_UART_E				142
> +/*						143-144*/
> +#define RESET_I2C_M_A				145
> +#define RESET_I2C_M_B				146
> +#define RESET_I2C_M_C				147
> +#define RESET_I2C_M_D				148
> +/*						149-151*/
> +#define RESET_SDEMMC_A				152
> +/*						153*/
> +#define RESET_SDEMMC_C				154
> +/*						155-159*/
> +
> +/* RESET5 */
> +/*						160-175*/
> +#define RESET_BRG_AO_NIC_SYS			176
> +/*						177*/
> +#define RESET_BRG_AO_NIC_MAIN			178
> +#define RESET_BRG_AO_NIC_AUDIO			179
> +/*						180-183*/
> +#define RESET_BRG_AO_NIC_ALL			184
> +/*						185*/
> +#define RESET_BRG_NIC_SDIO			186
> +#define RESET_BRG_NIC_EMMC			187
> +#define RESET_BRG_NIC_DSU			188
> +#define RESET_BRG_NIC_CLK81			189
> +#define RESET_BRG_NIC_MAIN			190
> +#define RESET_BRG_NIC_ALL			191
> +
> +#endif
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> index fa80fa365f13c4a93f5577f78bf2b3369cb91cb8..6537153b3026af1bf9d1df0a196619b716553cde 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> @@ -4,6 +4,7 @@
>    */
>   
>   #include "amlogic-a4-common.dtsi"
> +#include "amlogic-a4-reset.h"
>   #include <dt-bindings/power/amlogic,a4-pwrc.h>
>   #include <dt-bindings/pinctrl/amlogic,pinctrl.h>
>   / {
> @@ -51,6 +52,13 @@ pwrc: power-controller {
>   };
>   
>   &apb {
> +	reset: reset-controller@2000 {
> +		compatible = "amlogic,a4-reset",
> +			     "amlogic,meson-s4-reset";
> +		reg = <0x0 0x2000 0x0 0x98>;
> +		#reset-cells = <1>;
> +	};
> +
>   	gpio_intc: interrupt-controller@4080 {
>   		compatible = "amlogic,a4-gpio-intc",
>   			     "amlogic,meson-gpio-intc";
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

