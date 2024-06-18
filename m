Return-Path: <linux-kernel+bounces-219592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D2590D537
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296D01F225A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE413C675;
	Tue, 18 Jun 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHcLB3wX"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D48249F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719941; cv=none; b=uKa7QIIFyA0ykPwgRthWlUGFRW4dJEak9hh6TFbmWZkz1tRZdnqB29kD6MO952bz02DFC18Y2XhZm4oKxbI0HZgve4Vt7fYUiZHqO3nAbh9lRLBkCJfjKy9BjgAVBg1ZZGT3kaC3Cyh22fj05J45J2yjLqrpxenMpyasipiQNo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719941; c=relaxed/simple;
	bh=0av22ofhvv+G1ykCXRTuar9N3ZcJAK8et2AWxSzeNng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWspS634akpzI6+Nqs7cZaGZbkl0aPMGEFmT2q9zZ3xbEDiZmawULXD2eMb+7KRsVSskcZPXINJxRELxIB2sPGVjY4y3iMn9OHvD1IPpVcSXrHD+ryb7NgQ74ev65arU3Zx6oT3YY0X09e+EGHQAyLATdIthDnKmtIm/lLk9uW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zHcLB3wX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso4981511e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718719936; x=1719324736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6Y4EgoXPRwJTHBawpiMcURy3sFFDfTP4JTr3Ev81mc=;
        b=zHcLB3wXjK+ILG4tqLn10gDyPTobyjq3vbYbYoJpgiFaaLLSPrjSNPkr+J70bNvIPB
         c9IDDMsYOyvHsHJP1XW99NAA+W67toVRsAQOZ4RpyUveH3Pubmya05ciSRISXpOcvFYR
         ZMffKD3/nJIg+chWgC4KCFvS2/n8z4eWoIT3LWgKxyNSoyf1qnGKQQC2gCvBdf5rW09t
         Y8irguPBPNq8aNomobzsz4en2p1fECywlfqcdcwGSqfqyesVYK0uv1ibcpc/CvIVRTeu
         EqB+wYT8DMioCoTch5Hn8LX2uxRkWu8hhztrClpnu0GMlRsekb7pUTC3+5mDmcnFYnmT
         dLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719936; x=1719324736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6Y4EgoXPRwJTHBawpiMcURy3sFFDfTP4JTr3Ev81mc=;
        b=G8hcsrFmMRgL7veSpE3ms6TxsKaEDepRTb2m+To7lap75kcnTW5WJ8A+LlINZc/yTV
         A4yLAbYglGWbfdUO9jRi1TlJvuPy+gkvCx2GjSCPe2uujY5nAjss1O3CswFs8eVZ/f/L
         CRkiYLYotBxziD7nJmwIomLEQjMW7MnwIojHrEKMtaqwyYvns9kf2E/LDRKPMvY/nywK
         WUfhSkGYoRHkEgPNQBJaKrfXysjgo5jv1m7qTLO0twj/aIOKLuJb7Ag6zQYcGdsMgIyi
         17o9bQk5znIttxGlhJxyvdM8x7SW+XQtGteBmAJU/1UpbDO4cAZSmJAVNMZuNZK6t3aq
         Sd6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHJ8vbqvSdvJ4dUvUXgbmMWlV1zI3m4hkGUMAhSSlH/CxMjqelAXGFKWYkpMoIozifvs48OFERPHEisZNGf7/RMnJzfLBUSr6T+tvh
X-Gm-Message-State: AOJu0YyDE8vDz9Cjn5JLMRGo9Gpl6sKhgbxMOijKKSS5XPaZYQcbvo/T
	jAsQ6sHCkBfyL8QAaxPim7F2rkVlAItMEHn6ZJ+ZK/9iZTlUs1X4KElF5mcI5X8=
X-Google-Smtp-Source: AGHT+IGZaIibqfCcQvl/1r3MYhEg7Ikhi/ZBC3FSzVQkmqP3CbCr8ETdFAVMl4V1LEjW+9OKcHaQjQ==
X-Received: by 2002:a05:6512:15a:b0:52c:958a:4afa with SMTP id 2adb3069b0e04-52ca6e65889mr7126633e87.23.1718719936329;
        Tue, 18 Jun 2024 07:12:16 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2888658sm1508463e87.298.2024.06.18.07.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:12:15 -0700 (PDT)
Message-ID: <13fea5c0-5906-4075-b734-52649e35eb69@linaro.org>
Date: Tue, 18 Jun 2024 16:12:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/23] arm64: dts: qcom: starqltechn: add new features
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 phone-devel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-23-e3f6662017ac@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-23-e3f6662017ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/18/24 15:59, Dzmitry Sankouski wrote:
> Add support for new features:
> - sound (headphones and mics only)
> - gpu
> - panel
> - buttons
> - MAX77705 MFD:
>     - charger
>     - fuelgauge
>     - haptic
>     - led
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

Please split this up

>   .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 593 ++++++++++++++++++++-
>   1 file changed, 592 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index bad154b1e894..28a5210e22fb 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -7,15 +7,40 @@
>   
>   /dts-v1/;
>   
> +#include <dt-bindings/input/linux-event-codes.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
> +
>   #include "sdm845.dtsi"
> +#include "pm8998.dtsi"
> +#include "sdm845-wcd9340.dtsi"
> +
> +/delete-node/ &rmtfs_mem;
> +/delete-node/ &adsp_mem;
> +/delete-node/ &slpi_mem;
> +/delete-node/ &spss_mem;
>   
>   / {
>   	chassis-type = "handset";
>   	model = "Samsung Galaxy S9 SM-G9600";
>   	compatible = "samsung,starqltechn", "qcom,sdm845";
>   
> +	aliases {
> +		serial0 = &uart9;
> +	};
> +
> +	battery: battery {
> +		compatible = "simple-battery";
> +		constant-charge-current-max-microamp = <2150000>;
> +		charge-full-design-microamp-hours = <3000000>;
> +
> +		over-voltage-threshold-microvolt = <4500000>;
> +		voltage-min-design-microvolt = <3400000>;
> +		voltage-max-design-microvolt = <4350000>;
> +	};
> +
>   	chosen {
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> @@ -59,9 +84,199 @@ memory@a1300000 {
>   			ftrace-size = <0x40000>;
>   			pmsg-size = <0x40000>;
>   		};
> +
> +		/* The rmtfs_mem needs to be guarded due to "XPU limitations"
> +		 * it is otherwise possible for an allocation adjacent to the
> +		 * rmtfs_mem region to trigger an XPU violation, causing a crash.
> +		 */
> +		rmtfs_lower_guard: memory@fde00000 {
> +			no-map;
> +			reg = <0 0xfde00000 0 0x1000>;
> +		};

qcom,use-guard-pages instead


> +
> +		rmtfs_mem: rmtfs-mem@fde01000 {
> +			compatible = "qcom,rmtfs-mem";
> +			reg = <0 0xfde01000 0 0x200000>;
> +			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <15>;

QCOM_SCM_VMID_MSS_MSA

[...]

> +		/*
> +		 * It seems like reserving the old rmtfs_mem region is also needed to prevent
> +		 * random crashes which are most likely modem related, more testing needed.
> +		 */
> +		removed_region: removed-region@88f00000 {
> +			no-map;
> +			reg = <0 0x88f00000 0 0x1c00000>;

Please keep no-map below reg for consistency

[...]

> +
> +&gmu {
> +	status = "okay";
> +};

Drop this and remove the disablement in 845.dtsi, gmu is only probed when
GPU is

[...]

>   	gpio-reserved-ranges = <0 4>, <27 4>, <81 4>, <85 4>;

Do you know what these are for?

Konrad

