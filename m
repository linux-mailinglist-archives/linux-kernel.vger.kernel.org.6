Return-Path: <linux-kernel+bounces-573234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF211A6D490
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5144D169D25
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0752505DA;
	Mon, 24 Mar 2025 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e87VpW2G"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543524F5A9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800011; cv=none; b=T7jTaSL/Fc6iCOR3VFDVr+lxqmQEUf7jvIPYHuaqlVUWFSDvT0pEFRdEkf1t63KAF0U7XL+BnKKcM3ZkqmnjgzhYcZnzDq99CooYtHR0AVU1QBXnkBZ3+Yik/Sfu+QRiKeLzv60tLjqcP+NbNCepDQTeKb0l+lK/lrs3A2sqVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800011; c=relaxed/simple;
	bh=dqxjuFvujeN0eOcnIqmUFWa2lXXGPM8AKo2Xzp4/Q6A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RyGKjbbiJWqGaJyIC3cxN5bpDw1o/PGR7ajYKrJBlLxE+OW2SxbDAQIyd/N1U6jEFZMUmbOvfpWFiltfTerwPY7IlWPANVV7GDa70ghrdxdYAjYY1QdxBRCBbe9TsA4/b9JONQvT8i1PTKlRRrrKMOcUKlNzzNenSPPzKx+Nvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e87VpW2G; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3995ff6b066so2242117f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742800008; x=1743404808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5gCTHqi5RXz4RfxlVIq8tZmJ5xAwfohObZ7yBTeoI8=;
        b=e87VpW2GY3Oq2MOU7qnKDv6C5Tz8fx+tFhyMf8BVDahAGNYJmkR0udvXYo9mdgGQvk
         8RYux4V07WEK9MWaGIACZnkFAnbP6WzZ0CmSnia3wieLvOYyJvRnaLPSlHeJkJNNV/Eq
         y7CSfbkQjQwHY939CQ9/s/V9WpPVAdUYPFw7Rwt9T1RuRE3XKbO3ratOgGLQyE39T/0Y
         irHz6EKisfF1IhMw7j9kKdmoO+tPeLHjg+mTN2yf8y/xvBkPPnXk2buPTKdWZQ3fza6L
         kB+kc23mHjFL1uZ032Otb+fGe6AOhGZK1++7A2hoBJ+zzJwL1GRYRQgfYUsaP2i+DFpR
         QykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742800008; x=1743404808;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R5gCTHqi5RXz4RfxlVIq8tZmJ5xAwfohObZ7yBTeoI8=;
        b=VtFFbhIGkTbRq0GsN0m+7wC0s8HyUO8fuqXgVJTT+1odS+eBXjUAE4Ns1nCgOcY1w1
         bxlh24nKZNdsI5ZoreOhvbGPVcXQgZP9CzgkVuOEdL1fFVc2c2OOjXcrZ/9q2yT4kjZ5
         deYbRBflxbu4XJQhIlW9cGOCRyhYE32gOOPaRqcFXDsIM8cI5FxWwRiD5DY/HyOPL11S
         iQpAMyV5sCY1PeG9Y1bPIEI+Xv0bKWQBYcTpSH93igRkZ7wLU8e78oa6poK3h5qV/kRQ
         M0ZsS3/DQl1gJZhuFsQQCHn/Kd1omDCmUoQxhQk3zXa7CPw98TPBEfI5iOIDMUVAGgVt
         jC2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHaCJ7+l/It90MQXV38swoaVqTwN2JRmsULGh7tOlTcZTkUdwyxCiJ1PCSNTr2Q+icCw5tncF7Dya+hag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5NP6q75sRjw8JJqtSo1hSWMby3kTd6qtuVqFZOpj7YaOhPa/
	FMFxbPYYRicMbNk5NkQ9A4GcvGIE83iHD3J0BW+xLI6bnStaoan9oH4yVl0LXg4RukVeLyvR1Rp
	x
X-Gm-Gg: ASbGnctqmOa+1rEpLjApYcBaMLa+yV52NRoA7pOWKAozdUBkqox6H6tKCE/rOU4HXCx
	EzoEwTnwEMr4QJipPy5jbl1qilw/6PFxx/zBNRXHXjT+c6zydcVutwkKoFCItkfDRc99JshRp4O
	c81k7Nr+KHZUyiLdQr/moIXRXOxdL51u+fOuonHNB4o0dVCqPuAuKmPE5rlVY5Rf9UdxT6Q2G7M
	eZbUP8buqk9swT/KbHG7AFBSgihXkM2efHqljt9dWEVFYWR3AjKcdq8uB2BZNDpnDJJuq7+sQdn
	E4TaBWsdHqvwms6SOzuygnRYEvP9V7wS9zX40Dblyzm1vG1p4WAN7taTm1ZzU/pQtw2Pg0hPPzI
	W387nycT3uB1GG73S
X-Google-Smtp-Source: AGHT+IHPuC+hLaYBHOASKlqZMU4X4ISor3sOVKvUnkvmOWB16uZ4LvwNA+ulTX9xjUSyrlovjePGvQ==
X-Received: by 2002:a05:6000:1842:b0:391:2c09:bdef with SMTP id ffacd0b85a97d-3997f9261d0mr9315513f8f.30.1742800008211;
        Mon, 24 Mar 2025 00:06:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a356:8d0:d4d:bb5f? ([2a01:e0a:3d9:2080:a356:8d0:d4d:bb5f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f995a05sm9931047f8f.8.2025.03.24.00.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 00:06:47 -0700 (PDT)
Message-ID: <3ca650ec-d0f2-453b-9770-5e5bbe7a75f0@linaro.org>
Date: Mon, 24 Mar 2025 08:06:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 3/3] arm64: dts: amlogic: Add A5 Reset Controller
To: kelvin.zhang@amlogic.com, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20250320-a4-a5-reset-v5-0-296f83bf733d@amlogic.com>
 <20250320-a4-a5-reset-v5-3-296f83bf733d@amlogic.com>
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
In-Reply-To: <20250320-a4-a5-reset-v5-3-296f83bf733d@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 10:42, Kelvin Zhang via B4 Relay wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add the device node and related header file for Amlogic
> A5 reset controller.
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> Link: https://lore.kernel.org/r/20240918074211.8067-4-zelong.dong@amlogic.com
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-a5-reset.h | 95 ++++++++++++++++++++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi    |  8 +++
>   2 files changed, 103 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5-reset.h b/arch/arm64/boot/dts/amlogic/amlogic-a5-reset.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..cdf0f515962097c606e4c53badb19df7d21606ec
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a5-reset.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __DTS_AMLOGIC_A5_RESET_H
> +#define __DTS_AMLOGIC_A5_RESET_H
> +
> +/* RESET0 */
> +/*						0-3 */
> +#define RESET_USB				4
> +/*						5-7 */
> +#define RESET_USBPHY20				8
> +/*						9 */
> +#define RESET_USB2DRD				10
> +/*						11-31 */
> +
> +/* RESET1 */
> +#define RESET_AUDIO				32
> +#define RESET_AUDIO_VAD				33
> +/*                                              34 */
> +#define RESET_DDR_APB				35
> +#define RESET_DDR				36
> +/*						37-40 */
> +#define RESET_DSPA_DEBUG			41
> +/*                                              42 */
> +#define RESET_DSPA				43
> +/*						44-46 */
> +#define RESET_NNA				47
> +#define RESET_ETHERNET				48
> +/*						49-63 */
> +
> +/* RESET2 */
> +#define RESET_ABUS_ARB				64
> +#define RESET_IRCTRL				65
> +/*						66 */
> +#define RESET_TS_PLL				67
> +/*						68-72 */
> +#define RESET_SPICC_0				73
> +#define RESET_SPICC_1				74
> +#define RESET_RSA				75
> +
> +/*						76-79 */
> +#define RESET_MSR_CLK				80
> +#define RESET_SPIFC				81
> +#define RESET_SAR_ADC				82
> +/*						83-90 */
> +#define RESET_WATCHDOG				91
> +/*						92-95 */
> +
> +/* RESET3 */
> +/*						96-127 */
> +
> +/* RESET4 */
> +#define RESET_RTC				128
> +/*						129-131 */
> +#define RESET_PWM_AB				132
> +#define RESET_PWM_CD				133
> +#define RESET_PWM_EF				134
> +#define RESET_PWM_GH				135
> +/*						104-105 */
> +#define RESET_UART_A				138
> +#define RESET_UART_B				139
> +#define RESET_UART_C				140
> +#define RESET_UART_D				141
> +#define RESET_UART_E				142
> +/*						143*/
> +#define RESET_I2C_S_A				144
> +#define RESET_I2C_M_A				145
> +#define RESET_I2C_M_B				146
> +#define RESET_I2C_M_C				147
> +#define RESET_I2C_M_D				148
> +/*						149-151 */
> +#define RESET_SDEMMC_A				152
> +/*						153 */
> +#define RESET_SDEMMC_C				154
> +/*						155-159*/
> +
> +/* RESET5 */
> +/*						160-175 */
> +#define RESET_BRG_AO_NIC_SYS			176
> +#define RESET_BRG_AO_NIC_DSPA			177
> +#define RESET_BRG_AO_NIC_MAIN			178
> +#define RESET_BRG_AO_NIC_AUDIO			179
> +/*						180-183 */
> +#define RESET_BRG_AO_NIC_ALL			184
> +#define RESET_BRG_NIC_NNA			185
> +#define RESET_BRG_NIC_SDIO			186
> +#define RESET_BRG_NIC_EMMC			187
> +#define RESET_BRG_NIC_DSU			188
> +#define RESET_BRG_NIC_SYSCLK			189
> +#define RESET_BRG_NIC_MAIN			190
> +#define RESET_BRG_NIC_ALL			191
> +
> +#endif
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
> index 32ed1776891bc7d1befd01a76c76048631606f5a..b1da8cbaa25a1844312a23bc39eb876df3c60df5 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
> @@ -4,6 +4,7 @@
>    */
>   
>   #include "amlogic-a4-common.dtsi"
> +#include "amlogic-a5-reset.h"
>   #include <dt-bindings/power/amlogic,a5-pwrc.h>
>   / {
>   	cpus {
> @@ -50,6 +51,13 @@ pwrc: power-controller {
>   };
>   
>   &apb {
> +	reset: reset-controller@2000 {
> +		compatible = "amlogic,a5-reset",
> +			     "amlogic,meson-s4-reset";
> +		reg = <0x0 0x2000 0x0 0x98>;
> +		#reset-cells = <1>;
> +	};
> +
>   	gpio_intc: interrupt-controller@4080 {
>   		compatible = "amlogic,a5-gpio-intc",
>   			     "amlogic,meson-gpio-intc";
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

