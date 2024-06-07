Return-Path: <linux-kernel+bounces-205701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BE08FFF0E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2112C1C2252D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB0D15B972;
	Fri,  7 Jun 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gheovIQd"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854415B576
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751793; cv=none; b=qhSwPcjII5SRtHjkZQ35QyJPW9fsJy7OV8/QPkw+TvY4zpq68ORd/77TimaBb2soaIb6VthpeoaHeJIo8CU9N2Np4gYWE6HRgucyfvRgdu5+cq7r/dc1+uxltRyacyVKxssLrpkNjkgjqWPYQCMWu6IrbBeqSF6XNuikT3uMc4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751793; c=relaxed/simple;
	bh=zIdt3Vb+Dr/QTS2l+2fvCqhwbM0oGZEPKaE2bmeBW9w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rIOtzIOfr3paKQHkjm1A4ot3L7jQ0ALEx5iqMDomEIOWbec/uhXrJbZDKp3srKStaRGOlFSKoAP2GYPD3uQgQw+ivvFsgoO7PIORnA6N8g0Xsrwiy+x7DmKYIn6KPX/8A2R7qOwJwkeoLDPh+pTx7rl1ykhXNzAPnBtxLXCW1G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gheovIQd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4215f694749so12533675e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717751790; x=1718356590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKhcW2Pv1TQb63OYj0Ad4PZwEbdEXdKfu9Ta+939bwE=;
        b=gheovIQdX8MqCeEPYnxqkKy87TZqDaoReQVAHtPOSW8xk9EVop6rItgwqA1Z8q+qbc
         GSWz4No0t/KYRKfiI64BK+uMGqYxjwjMaCeo1vEZginzaAr+MHdnhdHfSltMvx+FJHpw
         m9pNJu4Wpj8XkOkxFIStpHhmGl8J8Hr+bpmYZO2X7IzFGG2wMKphHowfgYPQyqSTGhfH
         6niqMTB+ULEQJ7pZ7tIRSQHPSa3WewijOeX6AOXqfMP5xQF12wY4tcfDOkLuiTiKfHOi
         M/pRdqvUYAHeS616hutggdE3XCc1J8Qf/PXdRG6B3Hw+G1LkJ9CxyJcJmrMU77JlrhQy
         nj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751790; x=1718356590;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RKhcW2Pv1TQb63OYj0Ad4PZwEbdEXdKfu9Ta+939bwE=;
        b=Gbx04wvhRWhAE6zKGRkCkzhImX1rawc/LHWmAUoeHaNHXuxn5DmYhKQvX7aTnvmycg
         xeyBdPtdn1AaH5CFZwOJRR1TcXX2YGJ714QwzsFmxIolQYXTeR4qMs7OWnEo1E2DbCxM
         8JeHHsh1nlUMzVAbSspCJ3k+naIeMrj5zTpYv/MGrmZxBA8AY+3Ysj0bRGevF1ikEt0u
         c4x7B465XvcegCH1CFrkYJEjMpjRF1IpptSGlxIJe96WmvRDvCoC0JZQhCYxTf86FhSv
         KVSYmvm67sjwxiXxAgeU0LLC6m3FYe4XxVSxEdTEomUp8Lucr0iNuI13vdTLJwkOgzda
         PJyA==
X-Forwarded-Encrypted: i=1; AJvYcCVf3opNI2lXBUxXpc4dm/hr531yb32wcnVDibf09BQpe+qbQZjsQiKWjiQvcOqZQibxWMA5w5A3innD70i/SV8fLLMyc131Wkz+0Q03
X-Gm-Message-State: AOJu0YzTH+p0e7c/2N3TywLfF3xJVM8SO/HPPDcNuFg4M/gYmItF6JsV
	6L8aSxlytKjPBKgY+MhVPZeYc7OBfRA44mhg+xDn58HhWPGco5o7OOTYfbo98fU=
X-Google-Smtp-Source: AGHT+IH6lSQLjPhb+rH7MhIJCz8VcmYFFOPCXGM2LCapictgRME7AWqPy+I8YzSDVKMGrNP+Ca47Lg==
X-Received: by 2002:a05:600c:4f4a:b0:421:20aa:6048 with SMTP id 5b1f17b1804b1-42164a20b24mr16134255e9.26.1717751789789;
        Fri, 07 Jun 2024 02:16:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e4b:b0d3:6a34:6404? ([2a01:e0a:982:cbb0:7e4b:b0d3:6a34:6404])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe37csm82143035e9.3.2024.06.07.02.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 02:16:29 -0700 (PDT)
Message-ID: <88119323-bd54-4d2b-bb63-366c5fe77e39@linaro.org>
Date: Fri, 7 Jun 2024 11:16:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/12] arm64: meson: bunch of DT fixes, take 4 (final one
 ??)
To: Kevin Hilman <khilman@baylibre.com>, Jerome Brunet
 <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
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
In-Reply-To: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/06/2024 10:48, Neil Armstrong wrote:
> Along with the following:
> - https://lore.kernel.org/all/20240422-t7-reset-v2-1-cb82271d3296@amlogic.com/
> - https://lore.kernel.org/all/20240513224552.800153-1-jan.dakinevich@salutedevices.com/
> - https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-spifc-v1-1-380f29ba4a16@linaro.org/
> - https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-convert-spdif-receiver-v1-1-262465adbac2@linaro.org/
> - https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-mmc-v1-1-4acbb8cc2626@linaro.org/
> - https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-nvmem-v1-1-ef6f10c86a63@linaro.org/
> - https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-phy-v1-1-c819b0ecd8c8@linaro.org/
> - https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-rng-v1-1-0a55a7ba55e4@linaro.org/
> - https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-audio-widgets-v1-1-65bd7cc2e09b@linaro.org/
> - https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-sardac-v1-1-40a8de6baa59@linaro.org/
> - https://lore.kernel.org/all/20240606-topic-amlogic-upstream-bindings-convert-g12a-tohdmitx-v2-1-70d44fa30790@linaro.org/
> 
> this bunch of changes fixes 99% of the remaining dts check errors.
> 
> The two remaining bindings conversions for arm64/amlogic are:
> - ti,tas5707
> - everest,es7241
> 
> I'm too lazy to do them right now, so if someone is interested
> in doing the conversion, please do it!
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (12):
>        arm64: dts: amlogic: meson-g12b-bananapi: remove invalid fan on wrong pwm_cd controller
>        arm64: dts: amlogic: move ao_pinctrl into aobus
>        arm64: dts: amlogic: move assigned-clocks* from sound to clkc_audio node
>        arm64: dts: amlogic: sm1: fix tdm audio-controller clock order
>        arm64: dts: amlogic: sm1: fix tdm controllers compatible
>        arm64: dts: amlogic: g12a-u200: drop invalid sound-dai-cells
>        arm64: dts: amlogic: g12a-u200: add missing AVDD-supply to acodec
>        arm64: dts: amlogic: axg: fix tdm audio-controller clock order
>        arm64: dts: amlogic: c3: use correct compatible for gpio_intc node
>        arm64: dts: amlogic: a1: use correct node name for mmc controller
>        arm64: dts: amlogic: a1: drop the invalid reset-name for usb@fe004400
>        arm64: dts: amlogic: gxbb-odroidc2: fix invalid reset-gpio property
> 
>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        |   3 +-
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |   3 +-
>   arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |  17 +-
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |  24 +-
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  | 427 ++++++++++-----------
>   arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts  |  16 +-
>   .../boot/dts/amlogic/meson-g12a-radxa-zero.dts     |  16 +-
>   arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts  |  16 +-
>   arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts    |  18 +-
>   arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts |  16 +-
>   .../dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts  |  18 +-
>   .../meson-g12b-bananapi-cm4-mnt-reform2.dts        |  18 +-
>   .../boot/dts/amlogic/meson-g12b-bananapi.dtsi      |  30 +-
>   .../arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts |  16 +-
>   .../boot/dts/amlogic/meson-g12b-gtking-pro.dts     |  16 +-
>   arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts  |  16 +-
>   .../dts/amlogic/meson-g12b-odroid-go-ultra.dts     |  16 +-
>   .../boot/dts/amlogic/meson-g12b-odroid-n2.dtsi     |  18 +-
>   .../boot/dts/amlogic/meson-g12b-odroid-n2l.dts     |  18 +-
>   .../boot/dts/amlogic/meson-g12b-radxa-zero2.dts    |  16 +-
>   .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts      |  16 +-
>   .../boot/dts/amlogic/meson-gx-libretech-pc.dtsi    |  17 +-
>   .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  18 +-
>   arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts |  17 +-
>   .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |  17 +-
>   .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  17 +-
>   .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  19 +-
>   arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    |  17 +-
>   arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts    |  17 +-
>   .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  17 +-
>   .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      |  17 +-
>   .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    |  17 +-
>   .../dts/amlogic/meson-gxl-s805x-libretech-ac.dts   |  17 +-
>   .../boot/dts/amlogic/meson-gxl-s805x-p241.dts      |  17 +-
>   .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |  17 +-
>   .../amlogic/meson-gxl-s905x-libretech-cc-v2.dts    |  17 +-
>   .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |  17 +-
>   .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      |  17 +-
>   .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |  17 +-
>   .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  17 +-
>   arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |  17 +-
>   arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi |  16 +-
>   .../dts/amlogic/meson-libretech-cottonwood.dtsi    |  16 +-
>   .../boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts |  16 +-
>   .../boot/dts/amlogic/meson-sm1-a95xf3-air.dts      |  16 +-
>   .../boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts |  16 +-
>   .../boot/dts/amlogic/meson-sm1-bananapi-m5.dts     |  16 +-
>   arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts  |  16 +-
>   arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi  |  16 +-
>   arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts   |  16 +-
>   .../boot/dts/amlogic/meson-sm1-x96-air-gbit.dts    |  16 +-
>   arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts  |  16 +-
>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi         |  36 +-
>   53 files changed, 679 insertions(+), 630 deletions(-)
> ---
> base-commit: c3f38fa61af77b49866b006939479069cd451173
> change-id: 20240606-topic-amlogic-upstream-bindings-fixes-dts-6a572ad54324
> 
> Best regards,

I'll postpone applying patch 3 to be sure it's the right solution,
but the other ones are trivial and I'll apply them now.

Neil

