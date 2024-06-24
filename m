Return-Path: <linux-kernel+bounces-226822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C97CA91445D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77881C20DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15A4AEDA;
	Mon, 24 Jun 2024 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoUTS4Ym"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420949654
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216933; cv=none; b=JcpKGnUuMaufV8LM02UD1HCEs7aVepIpLXdz4H2hwAFt+qky8FuPjUkyURfhkP+3s76+HhE/UivAnT/pKuRhgBORcSazBDlaqvGeEvRBj+b9Krg9R/HQ6UX1k5XuMDU7uMFBEcGCR+cWQ5orMol+kmaelMTWYRjR5tcdCeePU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216933; c=relaxed/simple;
	bh=G7qevIkGyeyM4Nvv/ZxaCFArfxjDaD7Y6nn45mdDDGc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Aoye14Q1EZrh+3tzDjwAuydN5+6+NRcdRFAhPMzBKYD8/gkrp8DsSHruUYjTj/VsXuKKyhrIZS4s2u05ZbGm+Ei225k9Oz7bGQvdahMcL9LUTaQd7uWmXS/P9HsD+96Hkb5LOJ0HMBUwHg/9qw6cW0MaT1J6D6jGWUVwy9sQDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BoUTS4Ym; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-364cdfdaf91so2972626f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719216930; x=1719821730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mc0K6+P9t3aUJfG7qNeZqV06Olc9LiRHaSQx7Iaz24U=;
        b=BoUTS4YmJjZec4zX8fAfA2EPUS0Zxk3G2QmDmk310KS2+IfKybQP0lcrGe+2QRYTYT
         2a5Y11wZL5UUk6pcQvKRzZGZTMk2Dhc8gktfPSAVsNaGKx4kUSqZg+TKNlZ3HZ8sUUnm
         eQtht8TDz9VhG1YfuNHunZTWVFBq9UE8TO2gL8iob2j8J5aEHLLgaBOb/uboLWLSET/v
         slCVznh1lX8QGe8AHZvHXnRiHl3sS/nd1ymRLB2s76pLZHbA8xuPBDa1ts0bZReep/3g
         SiHqL7op7QIQ3uWConyv9tVie+QR1phfL75dXa4NId5cOip/bKmeojNDiV64tXoohLZG
         8FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216930; x=1719821730;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mc0K6+P9t3aUJfG7qNeZqV06Olc9LiRHaSQx7Iaz24U=;
        b=I6ld8LtGKGOQ0TTGaljG5Bftzt4neRIsKB0z151GqTNI0YfRNPQgeeWFM9QeWY1BeL
         /WYtgF4zqz8J1yFPXVA2WoM2QtDvPdAST4m+LjUvYo2FrmiiMuOLSSe/+vBX3o9ZxIjX
         FEcvjg8d/Mp9PgDBtKd/8ZYvD+rmNoHzAoXGO4EYHYnqjM3SxzXMAC0dRbTUNDYGQxSe
         dWFFZf57dbpQK8ZhrObX137uVeE3vMQdy5qojQSGnC14FtrAP3GQl8kVbRz33wGrvIwa
         SHQVlxbbbmVyAzc85ry8HA4MpX3F/zOJv1mROSiFbl0mQD5gzWl+kKmwSOfwZ84y86Wt
         4e4g==
X-Forwarded-Encrypted: i=1; AJvYcCUdZFoQVr+AFzIFx+yfAa4C/EVmHGk1D3ZOBF4RfP5mG+VRBJ6JLzvA7mGdhyesxCZ7iH9kMNrwM2/eWVm4SAsRNqO0gv5OXd+jqmr6
X-Gm-Message-State: AOJu0Yz4L/SQNB4rzeEur16v1qHtT1rM/9sw1YUx4t+oNfHgjL526MJl
	LxuP3R5wviuxOOn9vxrC87UGYcKn2XGlODxjot6n4wyZk1ePBeL6sqyE77IQ5aA=
X-Google-Smtp-Source: AGHT+IFDKrcUfX+Y67g3G1ua3EmYg/ZDbYtuqcCAm/9/+tELv74l4NHJAJM255rdI93UNdcxLAuZjw==
X-Received: by 2002:adf:f088:0:b0:365:80af:f69e with SMTP id ffacd0b85a97d-366e957309amr2206840f8f.37.1719216929768;
        Mon, 24 Jun 2024 01:15:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cf01:774b:55fd:ab74? ([2a01:e0a:982:cbb0:cf01:774b:55fd:ab74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b863fsm9251064f8f.47.2024.06.24.01.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 01:15:29 -0700 (PDT)
Message-ID: <dbea269e-2de6-470d-96b7-ce1e07c8de07@linaro.org>
Date: Mon, 24 Jun 2024 10:15:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v7 2/2] arm64: dts: amlogic: Used onboard usb hub reset on
 odroid n2
To: Anand Moon <linux.amoon@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240613123020.43500-1-linux.amoon@gmail.com>
 <20240613123020.43500-2-linux.amoon@gmail.com>
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
In-Reply-To: <20240613123020.43500-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 13/06/2024 14:30, Anand Moon wrote:
> On Odroid n2/n2+ previously use gpio-hog to reset the usb hub,
> switch to used on-board usb hub reset to enable the usb hub
> and enable power to hub.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v7:none
> V6:none
> V5:none
> V4:none
> V3:none
> V2:none
> V1:none
> ---
>   .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 36 ++++++++++++-------
>   1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> index d80dd9a3da31..86eb81112232 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> @@ -31,6 +31,30 @@ hub_5v: regulator-hub-5v {
>   		enable-active-high;
>   	};
>   
> +	/* USB hub supports both USB 2.0 and USB 3.0 root hub */
> +	usb-hub {
> +		dr_mode = "host";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* 2.0 hub on port 1 */
> +		hub_2_0: hub@1 {
> +			compatible = "usb5e3,610";
> +			reg = <1>;
> +			peer-hub = <&hub_3_0>;
> +			vdd-supply = <&usb_pwr_en>;
> +		};
> +
> +		/* 3.0 hub on port 4 */
> +		hub_3_0: hub@2 {
> +			compatible = "usb5e3,620";
> +			reg = <2>;
> +			peer-hub = <&hub_2_0>;
> +			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
> +			vdd-supply = <&vcc_5v>;
> +		};
> +	};

Why is this nodes under / and not the dwc3 node ????

With this current DT, there's no way for the usb controller
to find those usb devices subnodes in /usb-hub, and it's clearly
not described like this in the bindings.

Neil

> +
>   	sound {
>   		compatible = "amlogic,axg-sound-card";
>   		model = "ODROID-N2";
> @@ -234,18 +258,6 @@ &gpio {
>   		"PIN_3",  /* GPIOX_17 */
>   		"PIN_5",  /* GPIOX_18 */
>   		"PIN_36"; /* GPIOX_19 */
> -	/*
> -	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
> -	 * to be turned high in order to be detected by the USB Controller
> -	 * This signal should be handled by a USB specific power sequence
> -	 * in order to reset the Hub when USB bus is powered down.
> -	 */
> -	usb-hub-hog {
> -		gpio-hog;
> -		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
> -		output-high;
> -		line-name = "usb-hub-reset";
> -	};
>   };
>   
>   &i2c3 {


