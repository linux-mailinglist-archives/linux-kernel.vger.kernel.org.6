Return-Path: <linux-kernel+bounces-187101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164D18CCD1D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363681C2143B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D413CA92;
	Thu, 23 May 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQrsnLEf"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA19339A0
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449821; cv=none; b=DNJn+0fYk8necMMCcVi9A0yHg9M5avvQoVwik6pF7nrwohKR2tVe/6WC/Z0Aa32ijlf7YBR3TXDgW4A/o9tYCL+gH39v80fHywUBRlA3RTA/lh56KjodDy5rr98YM4r8pLEEpyewA+9eYHlZF+u8NSfF9kHzKO9yOM2+bCHROlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449821; c=relaxed/simple;
	bh=O0OEo28xYDX46x0DVVLfuaz+aziKPY+iokhL5lX/EZA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=AMSv5TFAVanUxEgaMShOttUZyEQ3BlPJfvSvJFX7zSkxIqubhyS4vMjYhbC/csldd7u5Sx1PkPQpgmJ8luKgFpSaAQzWYtn+PSjM0wYHNJP0S09Hg9Vxu/w7XpOpat+0NEp68IMyHy3kb7Iz1oHOtLr3UerJTJYK7hllUpQF5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WQrsnLEf; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a609dd3fso325498366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716449818; x=1717054618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=517qvSXdAeDLW4FIicTVkU3rF1O2o6mhYuS9ir4DWD0=;
        b=WQrsnLEfpVwNT2ttqd/7PSLg2LiJ5usL/MTMbZ2ZBkuhrj5ZzebD8FoevaJ6x9Zk0k
         Np7CbP+qDTIumnfwx8ICeR5JL8IerX2DL8yGGMvSWets45ZV25XqY5QLat3aVEwOaI8a
         yF2+iWLiZyBlNbceTeEWTfeyDWT0w3HkzefrLIyQ6o9OyCUZXjfrx8sh8fZ01Dvg6x0n
         qkC/CI3wZZ+pLVI/IHUy9KV/VlSFr6alglFoKaItJEHPtezb0pwQo0/r+rdzWne0oJQR
         vHAEwdT6xgj6z52Ndy51vxiO/7GAkY37mZ7/QlK8B3JJCoJhmZOVpu2ZXyBsR7L7Vu/Q
         FrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716449818; x=1717054618;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=517qvSXdAeDLW4FIicTVkU3rF1O2o6mhYuS9ir4DWD0=;
        b=i69lg/VOsRWHDG6IAr87sWwMlFnED5p3trP0d6kFFjHSU+V5Rlq4NqUu0VlKp/qrvn
         d5cfilBO+9Bn/umxBrwOIIC9Ccycm7Tnkz1dokFhOiOtz1Zfvl/4Yd18kj3N4W18V+X5
         orUhOwqf0pPl0j9LJW/oJTR+w161vluGpq/myqWRwHb2o7ZEkofGIFfoISPdOiGUmTEw
         23wzUhdT/p0ZSFJvmfBRDINt9Qmd9UmwCtIZlMuZfHUOGV6a3HAzhufNejiNa5jOMmkj
         aU9el9xgCujirNXGXTuMlSIRLLpIIgjt2Myj0NXrdIjh2KKTXZROvpOzy+0VG5Kr8dFT
         32qQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3pwEA12xds/SskqMLDzE2/BmX0i5HW//AjSijKEBLq+MWEbiwLFCrgfaBsiwUxgObzWJwPw4jxfT9SQ+A5Jncib8CJAQvxYb9baUx
X-Gm-Message-State: AOJu0YzZzWI4AAfvvC5xSPiWiYScQHqqEwdNoUM8DSY9f66ioFlE4FqJ
	J51I01U5I1E67DRYI6uK6l1BaLaA99IOCQZicPkySSjfdB3sA8UK02cKrkzEJy4=
X-Google-Smtp-Source: AGHT+IG6yRYPHTkx4UP7bS+LPdO9N+uw3wcdJBXPD3HhxXbrQbG8b4XZKSEQl+RR/iDDrB5sc9xmaA==
X-Received: by 2002:a17:906:26d4:b0:a58:7172:1ab0 with SMTP id a640c23a62f3a-a623e91d1bfmr113098366b.16.1716449817236;
        Thu, 23 May 2024 00:36:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:825d:600a:c16:a973? ([2a01:e0a:982:cbb0:825d:600a:c16:a973])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6209f64ba8sm461839466b.210.2024.05.23.00.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 00:36:56 -0700 (PDT)
Message-ID: <447ed20b-a505-4758-9351-522fd12049f6@linaro.org>
Date: Thu, 23 May 2024 09:36:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] arch/arm64: dts: ac2xx: make common the sound card
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Lucas Tanure <tanure@linux.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>
References: <20240521222155.28094-1-jan.dakinevich@salutedevices.com>
 <20240521222155.28094-2-jan.dakinevich@salutedevices.com>
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
In-Reply-To: <20240521222155.28094-2-jan.dakinevich@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2024 00:21, Jan Dakinevich wrote:
> The declaration of sound card and its dependencies is identical in all
> consumers of 'meson-sm1-ac2xx.dtsi'.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>   .../dts/amlogic/meson-sm1-a95xf3-air-gbit.dts | 87 -------------------
>   .../boot/dts/amlogic/meson-sm1-a95xf3-air.dts | 87 -------------------
>   .../boot/dts/amlogic/meson-sm1-ac2xx.dtsi     | 87 +++++++++++++++++++
>   .../boot/dts/amlogic/meson-sm1-h96-max.dts    | 87 -------------------
>   .../dts/amlogic/meson-sm1-x96-air-gbit.dts    | 87 -------------------
>   .../boot/dts/amlogic/meson-sm1-x96-air.dts    | 87 -------------------
>   6 files changed, 87 insertions(+), 435 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
> index 9b2eb6e42651..90ae38c30592 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
> @@ -7,73 +7,10 @@
>   /dts-v1/;
>   
>   #include "meson-sm1-ac2xx.dtsi"
> -#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>   
>   / {
>   	compatible = "cyx,a95xf3-air-gbit", "amlogic,sm1";
>   	model = "Shenzhen CYX Industrial Co., Ltd A95XF3-AIR";
> -
> -	sound {
> -		compatible = "amlogic,axg-sound-card";
> -		model = "A95XF3-AIR";

model should be board-specific, as for sound node because dev board
variants can be different, so I don't thing moving sound to a common
dtsi is a good thing.

> -		audio-aux-devs = <&tdmout_b>;
> -		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> -				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> -				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> -				"TDM_B Playback", "TDMOUT_B OUT";
> -
> -		assigned-clocks = <&clkc CLKID_MPLL2>,
> -				  <&clkc CLKID_MPLL0>,
> -				  <&clkc CLKID_MPLL1>;
> -		assigned-clock-parents = <0>, <0>, <0>;
> -		assigned-clock-rates = <294912000>,
> -				       <270950400>,
> -				       <393216000>;
> -
> -		dai-link-0 {
> -			sound-dai = <&frddr_a>;
> -		};
> -
> -		dai-link-1 {
> -			sound-dai = <&frddr_b>;
> -		};
> -
> -		dai-link-2 {
> -			sound-dai = <&frddr_c>;
> -		};
> -
> -		/* 8ch hdmi interface */
> -		dai-link-3 {
> -			sound-dai = <&tdmif_b>;
> -			dai-format = "i2s";
> -			dai-tdm-slot-tx-mask-0 = <1 1>;
> -			dai-tdm-slot-tx-mask-1 = <1 1>;
> -			dai-tdm-slot-tx-mask-2 = <1 1>;
> -			dai-tdm-slot-tx-mask-3 = <1 1>;
> -			mclk-fs = <256>;
> -
> -			codec {
> -				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> -			};
> -		};
> -
> -		/* hdmi glue */
> -		dai-link-4 {
> -			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
> -
> -			codec {
> -				sound-dai = <&hdmi_tx>;
> -			};
> -		};
> -	};
> -};
> -
> -&arb {
> -	status = "okay";
> -};
> -
> -&clkc_audio {
> -	status = "okay";
>   };
>   
>   &ethmac {
> @@ -102,27 +39,3 @@ external_phy: ethernet-phy@0 {
>   		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   };
> -
> -&frddr_a {
> -	status = "okay";
> -};
> -
> -&frddr_b {
> -	status = "okay";
> -};
> -
> -&frddr_c {
> -	status = "okay";
> -};
> -
> -&tdmif_b {
> -	status = "okay";
> -};
> -
> -&tdmout_b {
> -	status = "okay";
> -};
> -
> -&tohdmitx {
> -	status = "okay";
> -};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
> index 6e34fd80ed71..c74ce9c246fa 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
> @@ -7,73 +7,10 @@
>   /dts-v1/;
>   
>   #include "meson-sm1-ac2xx.dtsi"
> -#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>   
>   / {
>   	compatible = "cyx,a95xf3-air", "amlogic,sm1";
>   	model = "Shenzhen CYX Industrial Co., Ltd A95XF3-AIR";
> -
> -	sound {
> -		compatible = "amlogic,axg-sound-card";
> -		model = "A95XF3-AIR";
> -		audio-aux-devs = <&tdmout_b>;
> -		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> -				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> -				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> -				"TDM_B Playback", "TDMOUT_B OUT";
> -
> -		assigned-clocks = <&clkc CLKID_MPLL2>,
> -				  <&clkc CLKID_MPLL0>,
> -				  <&clkc CLKID_MPLL1>;
> -		assigned-clock-parents = <0>, <0>, <0>;
> -		assigned-clock-rates = <294912000>,
> -				       <270950400>,
> -				       <393216000>;
> -
> -		dai-link-0 {
> -			sound-dai = <&frddr_a>;
> -		};
> -
> -		dai-link-1 {
> -			sound-dai = <&frddr_b>;
> -		};
> -
> -		dai-link-2 {
> -			sound-dai = <&frddr_c>;
> -		};
> -
> -		/* 8ch hdmi interface */
> -		dai-link-3 {
> -			sound-dai = <&tdmif_b>;
> -			dai-format = "i2s";
> -			dai-tdm-slot-tx-mask-0 = <1 1>;
> -			dai-tdm-slot-tx-mask-1 = <1 1>;
> -			dai-tdm-slot-tx-mask-2 = <1 1>;
> -			dai-tdm-slot-tx-mask-3 = <1 1>;
> -			mclk-fs = <256>;
> -
> -			codec {
> -				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> -			};
> -		};
> -
> -		/* hdmi glue */
> -		dai-link-4 {
> -			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
> -
> -			codec {
> -				sound-dai = <&hdmi_tx>;
> -			};
> -		};
> -	};
> -};
> -
> -&arb {
> -	status = "okay";
> -};
> -
> -&clkc_audio {
> -	status = "okay";
>   };
>   
>   &ethmac {
> @@ -81,27 +18,3 @@ &ethmac {
>   	phy-handle = <&internal_ephy>;
>   	phy-mode = "rmii";
>   };
> -
> -&frddr_a {
> -	status = "okay";
> -};
> -
> -&frddr_b {
> -	status = "okay";
> -};
> -
> -&frddr_c {
> -	status = "okay";
> -};
> -
> -&tdmif_b {
> -	status = "okay";
> -};
> -
> -&tdmout_b {
> -	status = "okay";
> -};
> -
> -&tohdmitx {
> -	status = "okay";
> -};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
> index d1fa8b8bf795..7b20a8ff3dfb 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
> @@ -12,6 +12,7 @@
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/gpio/meson-g12a-gpio.h>
>   #include <dt-bindings/input/input.h>
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>   
>   / {
>   	aliases {
> @@ -127,6 +128,60 @@ wifi32k: wifi32k {
>   		clock-frequency = <32768>;
>   		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
>   	};
> +
> +	sound {
> +		compatible = "amlogic,axg-sound-card";
> +		model = "AC2XX";
> +		audio-aux-devs = <&tdmout_b>;
> +		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> +				"TDM_B Playback", "TDMOUT_B OUT";
> +
> +		assigned-clocks = <&clkc CLKID_MPLL2>,
> +				  <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +
> +		dai-link-0 {
> +			sound-dai = <&frddr_a>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&frddr_b>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&frddr_c>;
> +		};
> +
> +		/* 8ch hdmi interface */
> +		dai-link-3 {
> +			sound-dai = <&tdmif_b>;
> +			dai-format = "i2s";
> +			dai-tdm-slot-tx-mask-0 = <1 1>;
> +			dai-tdm-slot-tx-mask-1 = <1 1>;
> +			dai-tdm-slot-tx-mask-2 = <1 1>;
> +			dai-tdm-slot-tx-mask-3 = <1 1>;
> +			mclk-fs = <256>;
> +
> +			codec {
> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> +			};
> +		};
> +
> +		/* hdmi glue */
> +		dai-link-4 {
> +			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
> +
> +			codec {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +	};
>   };
>   
>   &cec_AO {
> @@ -298,3 +353,35 @@ &usb {
>   	status = "okay";
>   	dr_mode = "otg";
>   };
> +
> +&clkc_audio {
> +	status = "okay";
> +};
> +
> +&arb {
> +	status = "okay";
> +};
> +
> +&frddr_a {
> +	status = "okay";
> +};
> +
> +&frddr_b {
> +	status = "okay";
> +};
> +
> +&frddr_c {
> +	status = "okay";
> +};
> +
> +&tdmif_b {
> +	status = "okay";
> +};
> +
> +&tdmout_b {
> +	status = "okay";
> +};
> +
> +&tohdmitx {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
> index e6e9410d40cb..a4800488b161 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
> @@ -7,73 +7,10 @@
>   /dts-v1/;
>   
>   #include "meson-sm1-ac2xx.dtsi"
> -#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>   
>   / {
>   	compatible = "haochuangyi,h96-max", "amlogic,sm1";
>   	model = "Shenzhen Haochuangyi Technology Co., Ltd H96 Max";
> -
> -	sound {
> -		compatible = "amlogic,axg-sound-card";
> -		model = "H96-MAX";
> -		audio-aux-devs = <&tdmout_b>;
> -		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> -				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> -				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> -				"TDM_B Playback", "TDMOUT_B OUT";
> -
> -		assigned-clocks = <&clkc CLKID_MPLL2>,
> -				  <&clkc CLKID_MPLL0>,
> -				  <&clkc CLKID_MPLL1>;
> -		assigned-clock-parents = <0>, <0>, <0>;
> -		assigned-clock-rates = <294912000>,
> -				       <270950400>,
> -				       <393216000>;
> -
> -		dai-link-0 {
> -			sound-dai = <&frddr_a>;
> -		};
> -
> -		dai-link-1 {
> -			sound-dai = <&frddr_b>;
> -		};
> -
> -		dai-link-2 {
> -			sound-dai = <&frddr_c>;
> -		};
> -
> -		/* 8ch hdmi interface */
> -		dai-link-3 {
> -			sound-dai = <&tdmif_b>;
> -			dai-format = "i2s";
> -			dai-tdm-slot-tx-mask-0 = <1 1>;
> -			dai-tdm-slot-tx-mask-1 = <1 1>;
> -			dai-tdm-slot-tx-mask-2 = <1 1>;
> -			dai-tdm-slot-tx-mask-3 = <1 1>;
> -			mclk-fs = <256>;
> -
> -			codec {
> -				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> -			};
> -		};
> -
> -		/* hdmi glue */
> -		dai-link-4 {
> -			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
> -
> -			codec {
> -				sound-dai = <&hdmi_tx>;
> -			};
> -		};
> -	};
> -};
> -
> -&arb {
> -	status = "okay";
> -};
> -
> -&clkc_audio {
> -	status = "okay";
>   };
>   
>   &ethmac {
> @@ -103,30 +40,6 @@ external_phy: ethernet-phy@0 {
>   	};
>   };
>   
> -&frddr_a {
> -	status = "okay";
> -};
> -
> -&frddr_b {
> -	status = "okay";
> -};
> -
> -&frddr_c {
> -	status = "okay";
> -};
> -
> -&tdmif_b {
> -	status = "okay";
> -};
> -
> -&tdmout_b {
> -	status = "okay";
> -};
> -
> -&tohdmitx {
> -	status = "okay";
> -};
> -
>   &uart_A {
>   	status = "okay";
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
> index fc9b961133cd..dbd8625285b6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
> @@ -7,73 +7,10 @@
>   /dts-v1/;
>   
>   #include "meson-sm1-ac2xx.dtsi"
> -#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>   
>   / {
>   	compatible = "amediatech,x96-air-gbit", "amlogic,sm1";
>   	model = "Shenzhen Amediatech Technology Co., Ltd X96 Air";
> -
> -	sound {
> -		compatible = "amlogic,axg-sound-card";
> -		model = "X96-AIR";
> -		audio-aux-devs = <&tdmout_b>;
> -		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> -				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> -				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> -				"TDM_B Playback", "TDMOUT_B OUT";
> -
> -		assigned-clocks = <&clkc CLKID_MPLL2>,
> -				  <&clkc CLKID_MPLL0>,
> -				  <&clkc CLKID_MPLL1>;
> -		assigned-clock-parents = <0>, <0>, <0>;
> -		assigned-clock-rates = <294912000>,
> -				       <270950400>,
> -				       <393216000>;
> -
> -		dai-link-0 {
> -			sound-dai = <&frddr_a>;
> -		};
> -
> -		dai-link-1 {
> -			sound-dai = <&frddr_b>;
> -		};
> -
> -		dai-link-2 {
> -			sound-dai = <&frddr_c>;
> -		};
> -
> -		/* 8ch hdmi interface */
> -		dai-link-3 {
> -			sound-dai = <&tdmif_b>;
> -			dai-format = "i2s";
> -			dai-tdm-slot-tx-mask-0 = <1 1>;
> -			dai-tdm-slot-tx-mask-1 = <1 1>;
> -			dai-tdm-slot-tx-mask-2 = <1 1>;
> -			dai-tdm-slot-tx-mask-3 = <1 1>;
> -			mclk-fs = <256>;
> -
> -			codec {
> -				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> -			};
> -		};
> -
> -		/* hdmi glue */
> -		dai-link-4 {
> -			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
> -
> -			codec {
> -				sound-dai = <&hdmi_tx>;
> -			};
> -		};
> -	};
> -};
> -
> -&arb {
> -	status = "okay";
> -};
> -
> -&clkc_audio {
> -	status = "okay";
>   };
>   
>   &ethmac {
> @@ -103,30 +40,6 @@ external_phy: ethernet-phy@0 {
>   	};
>   };
>   
> -&frddr_a {
> -	status = "okay";
> -};
> -
> -&frddr_b {
> -	status = "okay";
> -};
> -
> -&frddr_c {
> -	status = "okay";
> -};
> -
>   &ir {
>   	linux,rc-map-name = "rc-x96max";
>   };
> -
> -&tdmif_b {
> -	status = "okay";
> -};
> -
> -&tdmout_b {
> -	status = "okay";
> -};
> -
> -&tohdmitx {
> -	status = "okay";
> -};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
> index 9ea969255b4f..3b2df25ca630 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
> @@ -7,73 +7,10 @@
>   /dts-v1/;
>   
>   #include "meson-sm1-ac2xx.dtsi"
> -#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>   
>   / {
>   	compatible = "amediatech,x96-air", "amlogic,sm1";
>   	model = "Shenzhen Amediatech Technology Co., Ltd X96 Air";
> -
> -	sound {
> -		compatible = "amlogic,axg-sound-card";
> -		model = "X96-AIR";
> -		audio-aux-devs = <&tdmout_b>;
> -		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> -				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> -				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> -				"TDM_B Playback", "TDMOUT_B OUT";
> -
> -		assigned-clocks = <&clkc CLKID_MPLL2>,
> -				  <&clkc CLKID_MPLL0>,
> -				  <&clkc CLKID_MPLL1>;
> -		assigned-clock-parents = <0>, <0>, <0>;
> -		assigned-clock-rates = <294912000>,
> -				       <270950400>,
> -				       <393216000>;
> -
> -		dai-link-0 {
> -			sound-dai = <&frddr_a>;
> -		};
> -
> -		dai-link-1 {
> -			sound-dai = <&frddr_b>;
> -		};
> -
> -		dai-link-2 {
> -			sound-dai = <&frddr_c>;
> -		};
> -
> -		/* 8ch hdmi interface */
> -		dai-link-3 {
> -			sound-dai = <&tdmif_b>;
> -			dai-format = "i2s";
> -			dai-tdm-slot-tx-mask-0 = <1 1>;
> -			dai-tdm-slot-tx-mask-1 = <1 1>;
> -			dai-tdm-slot-tx-mask-2 = <1 1>;
> -			dai-tdm-slot-tx-mask-3 = <1 1>;
> -			mclk-fs = <256>;
> -
> -			codec {
> -				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> -			};
> -		};
> -
> -		/* hdmi glue */
> -		dai-link-4 {
> -			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
> -
> -			codec {
> -				sound-dai = <&hdmi_tx>;
> -			};
> -		};
> -	};
> -};
> -
> -&arb {
> -	status = "okay";
> -};
> -
> -&clkc_audio {
> -	status = "okay";
>   };
>   
>   &ethmac {
> @@ -81,31 +18,7 @@ &ethmac {
>   	phy-handle = <&internal_ephy>;
>   	phy-mode = "rmii";
>   };
> -
> -&frddr_a {
> -	status = "okay";
> -};
> -
> -&frddr_b {
> -	status = "okay";
> -};
> -
> -&frddr_c {
> -	status = "okay";
> -};
> -
>   &ir {
>   	linux,rc-map-name = "rc-beelink-gs1";
>   };
>   
> -&tdmif_b {
> -	status = "okay";
> -};
> -
> -&tdmout_b {
> -	status = "okay";
> -};
> -
> -&tohdmitx {
> -	status = "okay";
> -};


