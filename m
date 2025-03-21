Return-Path: <linux-kernel+bounces-571006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A00A6B7C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FC2487ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B781C5F2C;
	Fri, 21 Mar 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2tCuFiy"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1521F131C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549882; cv=none; b=JsI1iJvuAbL2m8IeiA+FLzMkkKE8mPMdNb+CDFVHn4fKoG5fMFQcpxyW0WSK6hZ9aN3STZbtRaeiPbAJqVYEYd/K9Lajk0hRm5Xt1O6Xnwj76bcXFzkKgpgCqBGutduVhB3u2vxeqA8m1FK2BgR5cYO5zPvs8lXe9G2qzqd+/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549882; c=relaxed/simple;
	bh=5aDhAMwW4Kn3UhCM/fvEOcu3+MeIoZzc3lYUrIBh8nQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RJT5KV/c42HBIFIiseeNzuiWWoLuhQNjNH2lPVKeXX99DUSltSplPVYa/e8ljU2qnTXya2DmQVyV7Q9pUUPfQCe148qXLVBfyDxKwatvoQb6U5zangIP02ohQsQ3M1wSngq1juaKlenLoT7PGnQv+QTqGc3fpiz7iuLyy+jEbD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l2tCuFiy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so14120495e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742549879; x=1743154679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9N77P41IwOEtQjyzNQ+1k/cERPt5eLRxJQTUEpJGHQA=;
        b=l2tCuFiyV0bdwCN8Wf1jqR2WMMLVWVQ7pgfG5CVb05jRZ3RIIiCIKCGa7ELwFuOEhb
         cIZYcK1OV91JIsr4qqSUxpFfxcLG3ZPr+f/GltHt0Pg2RhCi6WKsrqpkfDJKiy15TIYZ
         mjTVkBsTxwt925UkyAyAm3AmkaP5jW2DWyQ2jPzwr2Sgx242jiNi53+W6pYb8+/mui3J
         y5nGBI4PzoDfaMER6Op3LI+Wq0WypQKzkvZjlWHpyy6KMfxSIqxMeyYUCbQOoPoWysgU
         zBWSAbarn0J4ncpJ32VxOdNGpGfuAjNWay3bSkspRH20SAx7hfZ7OEpHhsZGXLr6scla
         ujeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742549879; x=1743154679;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9N77P41IwOEtQjyzNQ+1k/cERPt5eLRxJQTUEpJGHQA=;
        b=xTnrSsa6bTw7F6eVecYHzgRjBZLddwmafPbPr5xzjUdlyqIwsF9S5llQfOWz916Akh
         PQuBKOFHJL6ypJEbukrNuFOxnjQT2PJSn/kyXuCCcbLov/IDzsqlRGevPIRmINFbH1xJ
         aTJK4BBsPq2qTZs6j8QANhZum625DjChpGLLQYe7c6tm+QVDESD9apGcVqIlXzxu7EIX
         TRczkxiqLX4zETsloasNeLw+61df0WdyDmPTAm89DiIdY8gT3T4X6zgb42Absy2f8evV
         7slHFWdKElNIxO6qCQN2JML9mDDx3zYo7PSv5YU9JOtjgWWY3driyT7OUktzGK3nMsp5
         Cicg==
X-Forwarded-Encrypted: i=1; AJvYcCXakYfHUV94JUmu3iDq755Q5CxPFKC1UFN7Ik22Jug+6eIstVPuHmz83l3a+YLc9V1psXaqf3a6kDVD7oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNkGUt9uf7IUuZcDvSuYlojWRKacF9Z+2eyvQeRiUsPeICps5x
	N/TMOnmHAwel0cX5hq4TaNAHJ2atvzNNGioBpR7V/OimajxnF90mmvvBqiazB/sEBH4wBB9Y6/S
	9
X-Gm-Gg: ASbGncuCPsPLe7WG/eEmwYo7ArkP+XLt2aaAgrOfvUVFpDRoQI4TEGOW4GOzaRcFqn5
	4Cumb3IV3XXKsSRdu/ZPWQ6pQUclrVeSCfbe+Bl5AUrZLH/QuzVGSzw67ssJIvgQ+dBRYQYqT49
	/4YTuI6heGg9IQginbt7/91aDugIKS+uhZqffrBV7DIVRjvj6ShsU7N3n0obgOwLFlEhjYsf+9Z
	hksd3FNTB/E8un4AGMN4lrBvVW2ox6NsOP6RPiGgW+X3WYlgeLO8wCpcArk/iaWqmzX+znMGkc5
	tVRn4/xvzY15yC5q2BT/8ARqXFAAnhxDAvpUpZkkGqamfWgkCmlO6YrMXyZDhAO+RkZb5w3O7io
	UuRMJBuDYlVMqIrUWt4bAY1iA5ieUNXUj
X-Google-Smtp-Source: AGHT+IE4AxMnbwGIVq74R+nsPXDkLIHd1kWqc+z8aTF3wWVCvx+LwG9D0+avsooNskmWWMoFCV5riw==
X-Received: by 2002:a05:600c:3109:b0:43c:e70d:450c with SMTP id 5b1f17b1804b1-43d50a201bemr22157905e9.22.1742549878764;
        Fri, 21 Mar 2025 02:37:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:5080:77b0:43f2:5276? ([2a01:e0a:3d9:2080:5080:77b0:43f2:5276])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd187fasm21568345e9.14.2025.03.21.02.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 02:37:58 -0700 (PDT)
Message-ID: <5caa550a-ffdf-477d-92f4-a3222b7fba29@linaro.org>
Date: Fri, 21 Mar 2025 10:37:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: amlogic: a4: fix dtb compilation warning
 issues
To: xianwei.zhao@amlogic.com, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250321-fix-a4-pinctrl-node-v1-1-5719f9f09932@amlogic.com>
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
In-Reply-To: <20250321-fix-a4-pinctrl-node-v1-1-5719f9f09932@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 21/03/2025 03:23, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> When use command 'make ARCH=arm64 dtbs_check W=1' to compile dtb,
> a warning message appears.
> "Warning (simple_bus_reg): /soc/bus@fe000000/pinctrl:
> missing or empty reg/ranges property"
> 
> Add the unit address to the pinctrl node to fix it.

I've delayed the pinctrl to next release so plase rebase
the commit on top of https://web.git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=for-next
and fix the warnings here, and make sure DTBS_CHECK still passes.

Neil

> 
> Fixes: ce78f679e08c ("arm64: dts: amlogic: a4: add pinctrl node")
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 102 +++++++++++++++-------------
>   1 file changed, 55 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> index fa80fa365f13..582e0043024b 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> @@ -51,87 +51,52 @@ pwrc: power-controller {
>   };
>   
>   &apb {
> -	gpio_intc: interrupt-controller@4080 {
> -		compatible = "amlogic,a4-gpio-intc",
> -			     "amlogic,meson-gpio-intc";
> -		reg = <0x0 0x4080 0x0 0x20>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		amlogic,channel-interrupts =
> -			<10 11 12 13 14 15 16 17 18 19 20 21>;
> -	};
> -
> -	gpio_ao_intc: interrupt-controller@8e72c {
> -		compatible = "amlogic,a4-gpio-ao-intc",
> -			     "amlogic,meson-gpio-intc";
> -		reg = <0x0 0x8e72c 0x0 0x0c>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		amlogic,channel-interrupts = <140 141>;
> -	};
> -
> -	periphs_pinctrl: pinctrl {
> +	periphs_pinctrl: pinctrl@4000 {
>   		compatible = "amlogic,pinctrl-a4";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> -		ranges;
> +		ranges = <0x0 0x0 0x0 0x4000 0x0 0x280>;
>   
> -		gpiox: gpio@4100 {
> -			reg = <0 0x4100 0 0x40>, <0 0x400c 0 0xc>;
> +		gpiox: gpio@100 {
> +			reg = <0 0x100 0 0x40>, <0 0xc 0 0xc>;
>   			reg-names = "gpio", "mux";
>   			gpio-controller;
>   			#gpio-cells = <2>;
>   			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_X<<8) 18>;
>   		};
>   
> -		gpiot: gpio@4140 {
> -			reg = <0 0x4140 0 0x40>, <0 0x402c 0 0xc>;
> +		gpiot: gpio@140 {
> +			reg = <0 0x140 0 0x40>, <0 0x2c 0 0xc>;
>   			reg-names = "gpio", "mux";
>   			gpio-controller;
>   			#gpio-cells = <2>;
>   			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_T<<8) 23>;
>   		};
>   
> -		gpiod: gpio@4180 {
> -			reg = <0 0x4180 0 0x40>, <0 0x4040 0 0x8>;
> +		gpiod: gpio@180 {
> +			reg = <0 0x180 0 0x40>, <0 0x40 0 0x8>;
>   			reg-names = "gpio", "mux";
>   			gpio-controller;
>   			#gpio-cells = <2>;
>   			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_D<<8) 16>;
>   		};
>   
> -		gpioe: gpio@41c0 {
> -			reg = <0 0x41c0 0 0x40>, <0 0x4048 0 0x4>;
> +		gpioe: gpio@1c0 {
> +			reg = <0 0x1c0 0 0x40>, <0 0x48 0 0x4>;
>   			reg-names = "gpio", "mux";
>   			gpio-controller;
>   			#gpio-cells = <2>;
>   			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_E<<8) 2>;
>   		};
>   
> -		gpiob: gpio@4240 {
> -			reg = <0 0x4240 0 0x40>, <0 0x4000 0 0x8>;
> +		gpiob: gpio@240 {
> +			reg = <0 0x240 0 0x40>, <0 0 0 0x8>;
>   			reg-names = "gpio", "mux";
>   			gpio-controller;
>   			#gpio-cells = <2>;
>   			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_B<<8) 14>;
>   		};
>   
> -		gpioao: gpio@8e704 {
> -			reg = <0 0x8e704 0 0x16>, <0 0x8e700 0 0x4>;
> -			reg-names = "gpio", "mux";
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_AO<<8) 7>;
> -		};
> -
> -		test_n: gpio@8e744 {
> -			reg = <0 0x8e744 0 0x20>;
> -			reg-names = "gpio";
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_TEST_N<<8) 1>;
> -		};
> -
>   		func-uart-a {
>   			uart_a_default: group-uart-a-pins1 {
>   				pinmux = <AML_PINMUX(AMLOGIC_GPIO_X, 11, 1)>,
> @@ -186,4 +151,47 @@ uart_e_default: group-uart-e-pins {
>   			};
>   		};
>   	};
> +
> +	gpio_intc: interrupt-controller@4080 {
> +		compatible = "amlogic,a4-gpio-intc",
> +			     "amlogic,meson-gpio-intc";
> +		reg = <0x0 0x4080 0x0 0x20>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		amlogic,channel-interrupts =
> +			<10 11 12 13 14 15 16 17 18 19 20 21>;
> +	};
> +
> +	ao_pinctrl: pinctrl@8e700 {
> +		compatible = "amlogic,pinctrl-a4";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x0 0x0 0x0 0x8e700 0x0 0x80>;
> +
> +		gpioao: gpio@4 {
> +			reg = <0 0x4 0 0x16>, <0 0 0 0x4>;
> +			reg-names = "gpio", "mux";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_AO<<8) 7>;
> +		};
> +
> +		test_n: gpio@44 {
> +			reg = <0 0x44 0 0x20>;
> +			reg-names = "gpio";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_TEST_N<<8) 1>;
> +		};
> +	};
> +
> +	gpio_ao_intc: interrupt-controller@8e72c {
> +		compatible = "amlogic,a4-gpio-ao-intc",
> +			     "amlogic,meson-gpio-intc";
> +		reg = <0x0 0x8e72c 0x0 0x0c>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		amlogic,channel-interrupts = <140 141>;
> +	};
> +
>   };
> 
> ---
> base-commit: 73a143e436311183186ab4b365a84c662f2c9651
> change-id: 20250317-fix-a4-pinctrl-node-9babfd44e085
> 
> Best regards,


