Return-Path: <linux-kernel+bounces-260921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C3893B042
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 928E7B22672
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B420157A4F;
	Wed, 24 Jul 2024 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMVF6/UB"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495B156F30
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819870; cv=none; b=AYv3yUc0JuILfdxDjpsNzsbe5bzyuLwKZQH8XepD/acLdSJ2YHCcAUb6yoiN0qpQVAwNC0/g17C1VHq4iaoh9C6nYtxrNcj7U48PvanalNqS6Vv+n3w9zLmxZg25QKjC7wHdaLscy7QCGU+sSAHBl20ATZ3pIfNF//qyiHOGwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819870; c=relaxed/simple;
	bh=u5P2XSotIVQI5KEmH6yp89E/OyUH7DW07t+T5awzKPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRUvjp6KlSoYhaNBrS46uPTWIobl2igp5e3pNPyPZBh1DgU1zZeOXBDpxSKbLDTd9Vgmpptoxi6RaZRMPUKh5CMO+A1Oa9J94W7VnRwIyE19c6yNbzyGsL0d4q0AKCpTe3k0w+hC2n0rY2tb+sxoBMBviGhzkulTco3kM2dRqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMVF6/UB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so6279218a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721819867; x=1722424667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foZI0aGrKNowqh8dzhyfBF+tDAZgNn62ZX2djJJye+8=;
        b=mMVF6/UBx5lnuUU7+jafrv/WgmN6R9X0BrCfm9/R/rSIAmTGB7sKOKRszvG59olubm
         Q8AbTLOWlhBsufjg++kxoaRnwYYmL/nFYc8qcdun4oBNMmA0/FJ6M7BN9PD5MkXyv407
         1zp2eEtQ4bG0MJLlv7lIRDa+ssCZp2lAIr+KyS0zN0CxiC1V06TH5eTr9q8TapMeSAKJ
         DkHiD/QNYxza2dtp1txd7RnmZGpq7yqTBvMkDPtONRfhnpvdrXoj9pDEpCgObSsdM6Lf
         otG15772id6Xsvx0+X21GXWHl3vciq0plqdoWoMu1CZ0OUDnjp8/ME3hKmZgvr9urMfc
         tt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721819867; x=1722424667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foZI0aGrKNowqh8dzhyfBF+tDAZgNn62ZX2djJJye+8=;
        b=N9Rkl9MIrKi7i1cDjO37fNDDlt6mar5c5M+nzRebggtwIApZOryPq61Ik6RJ+l9wjS
         /c5fdIZ2dqiAN1AKcJ3VlE1ngI+aVK1nbFXeP7Y8CqJR2rlQ7RGvYKxYewUHbuWLeYdD
         /QRhVH18zy08uP8rjAl/aFzEFb2vVTIIt9nOcJFdDIipiTdESRGF5XIIiVBHxPOHdInK
         UYlx7+IqeX7jlgRMzV/oonRMif0MVrR5goXXinZoL42zP2VowWUSQjuKTB0ZPoUmsQv5
         uhNb+qGBWvUp5EGKxHdKlgS2R6/n8H+wc4lyG0y2AIJAyODBTqOTiKHuL1Zw+PKW7ywY
         OGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUOdr83qoAVTJ0y2vyP5yoFDTzukLJ+1Ilvu+aGCFN6Ofvvu6FrTwROYPa/wK8XrhOX9F6vuW8xNJ/+nqUrdeAul472VdUTvAh4UbU
X-Gm-Message-State: AOJu0YyPWwBeVYWnirOGKMNF9KN2vTiMsgnQcjuBdKm2axa7+WZsiPJe
	AYhdAhpDvjP7+2kFu8MckwvKj18JcfITTETnvYFHuDeLQPwvLDGYmxWERxpnJdI=
X-Google-Smtp-Source: AGHT+IHVZNd88D6NET528Zgd6XV9jJ1tULhE5ZdXnc0lzEDfQWH4ANQji9eJWKRhji0xV1EABYWa2A==
X-Received: by 2002:a17:907:9714:b0:a79:7f94:8a73 with SMTP id a640c23a62f3a-a7ab0d818f7mr135486366b.20.1721819867290;
        Wed, 24 Jul 2024 04:17:47 -0700 (PDT)
Received: from [192.168.1.4] ([79.115.63.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a97c0731dsm169457266b.19.2024.07.24.04.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 04:17:46 -0700 (PDT)
Message-ID: <dd0449bc-f02a-4879-a7cd-e01fbea01d9f@linaro.org>
Date: Wed, 24 Jul 2024 12:17:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] arm64: dts: exynos: add initial CMU clock nodes in
 ExynosAuto v920
To: Sunyeal Hong <sunyeal.hong@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240722223333.1137947-1-sunyeal.hong@samsung.com>
 <CGME20240722223341epcas2p1b08b47cfefa981a2b31aad7878e3db64@epcas2p1.samsung.com>
 <20240722223333.1137947-3-sunyeal.hong@samsung.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240722223333.1137947-3-sunyeal.hong@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Sunyeal,

I quickly skimmed over the series and I fail to see where/how the HW
auto clock gating is enabled/configured. Would you please add more
details on how this works?

On 7/22/24 11:33 PM, Sunyeal Hong wrote:
> Add cmu_top, cmu_peric0 clock nodes and
> switch USI clocks instead of dummy fixed-rate-clock.
> 
> Signed-off-by: Sunyeal Hong <sunyeal.hong@samsung.com>
> ---
>  .../arm64/boot/dts/exynos/exynosautov920.dtsi | 40 +++++++++++++------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> index c1c8566d74f5..54fc32074379 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi


cut

> @@ -224,7 +237,8 @@ serial_0: serial@10880000 {
>  				interrupts = <GIC_SPI 764 IRQ_TYPE_LEVEL_HIGH>;
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&uart0_bus>;
> -				clocks = <&clock_usi>, <&clock_usi>;
> +				clocks = <&cmu_peric0 CLK_MOUT_PERIC0_NOC_USER>,

isn't this MUX common to multiple GATEs? Wouldn't turning it off affect
other users than the serial?

Thanks,
ta

> +					 <&cmu_peric0 CLK_DOUT_PERIC0_USI00_USI>;
>  				clock-names = "uart", "clk_uart_baud0";
>  				samsung,uart-fifosize = <256>;
>  				status = "disabled";

