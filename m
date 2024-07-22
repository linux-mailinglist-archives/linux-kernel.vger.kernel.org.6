Return-Path: <linux-kernel+bounces-258660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04F938B51
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F38AB211DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE31667F6;
	Mon, 22 Jul 2024 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5yKiBMk"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527233CD1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721637423; cv=none; b=hfCJ6Bvwen60ZgQR0C3zpXYbop0cV+BPP6nkGvx5rkHZlu/KbYLyuHa0In7dEreWiRKGYc3hvDyCjgCUyAjvnnF06WbjkFEL7zZQkJpCEYKP7NdoMkIGoJGOlOTAfF4qDveM6rkKeaLTJsGyHwGSKhbyfDIIWI5Dt3k+q8DL3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721637423; c=relaxed/simple;
	bh=uFac+wso6To65ZH90CLL7kbKcuNjoBFWUVBgjyExYGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUzshQH+b/pNGAvNwB/Ves5dnhNrE9JU7ZT/O32uG+CwzxxZL63a44Gj6pEWF9c4zOTnfvuRU6Hj1rc5P8G2pbHaxYJWo3eyFdVXOokfAYa7dHZ3VDwpvnukD/h10TBDn0/Vpm7eErZf1ZD2MPLwrma0q7AsC+UVyYMpo4NrA2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y5yKiBMk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so1001318e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721637420; x=1722242220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V+xJBcHz+rjfObl0ev5RVTTsckaNdPF4U6pdLyHZvdk=;
        b=Y5yKiBMkS2d+irhj7aA1PWIGsezX92xeYm9fL3zpue3tbAFC1ViiufJ+K2mmkawRUF
         XNNoaTfDbGV4QeASAHahcQNlYxR1539ddigHqz20nAR04XxoUvjI5uWPUK0v93acCp/A
         HvPnb5YDv/tVG6QoL7SgMQVJmrOzNJMVjNkYL/dAtHvhh863f/UBUrLaRm+oF7FgAsoL
         wqJHie7czhoFttUD/wusFVLnTo+e/z7XA1VRr8OBILOi2Qyw3Q7hHuNgykgXVPSesSPR
         Q79w+SYCQCWYcfQSkoOPA5wGkBwSRfyFCfJy/7PzTukq2XE80S5HaVARic4X/NrW59/2
         kHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721637420; x=1722242220;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+xJBcHz+rjfObl0ev5RVTTsckaNdPF4U6pdLyHZvdk=;
        b=bb70p0Cw3ynmjIE2L5Qh68Luo1Th4hmGgDdxxq6YGzR+OlImJ8emyG0hIs+MhWcAWI
         KrUkaoIpHFUi7rUmuoLLZ8hOXhW8dH5Q5Y7ESc8Ulhv6cOjSbhTHaS0IaPRgfJ/R8Wln
         AnGmDCPweGqGPiUgNAPr5eRCW2xNyQSmSuKmCcIT8hRtK7xHVTB4sa52ZFl08aGxdyBl
         YgYPW9BUMkd+2aU9zu7U6yd3M6YfoqntIGIwE8Pv+rM6MU3Lige0Y3NRdH2sYJLwIsVc
         oxZt9YuB4WYwpL0YjbJ+K9GRhqJxE4BTEGmUuK/3OWEOxVxsMge/FbrxsRZcAx0Sxigv
         OAdA==
X-Forwarded-Encrypted: i=1; AJvYcCUDxPbs44BidoY2xGbbz8H4C+59NMpcbwoICVTydkbADwEfnWhyolKOdK79n1Jm0oIrDW07HUcRrz+7VlRnJhnGneQZWMGJ/onilzCr
X-Gm-Message-State: AOJu0Yy1AlL2E4l/qffjHRh7WDHbsV6QXwqd0JtvaPHa0ku6JV5j/7CM
	B/xZCkgdB7I2jpNR8f5pd50Zi4+WTHyh9co7xpNP4gfCTEJqrk1DNG8PFf9mnA8=
X-Google-Smtp-Source: AGHT+IFmpfscK1WTOjVZQjQTnxUQohuWKxfi8uGHdDrZ5voFPoXifd8LRy668C8w4ZhTUsGdbxUWRQ==
X-Received: by 2002:a05:6512:3e14:b0:52c:83c7:936a with SMTP id 2adb3069b0e04-52efb7ae40amr5379483e87.42.1721637419559;
        Mon, 22 Jul 2024 01:36:59 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c94fc2esm388531666b.210.2024.07.22.01.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 01:36:59 -0700 (PDT)
Message-ID: <29c10415-4b59-4aff-bfef-8cfaf090e361@linaro.org>
Date: Mon, 22 Jul 2024 10:36:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] arm64: dts: qcom: sm6115-pro1x: Add Goodix
 Touchscreen
To: Dang Huynh <danct12@riseup.net>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240722-qx1050-feature-expansion-v1-0-c4d486435b96@riseup.net>
 <20240722-qx1050-feature-expansion-v1-3-c4d486435b96@riseup.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722-qx1050-feature-expansion-v1-3-c4d486435b96@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 9:10 AM, Dang Huynh wrote:
> The Fxtec Pro1X touchscreen uses Goodix GT9286 chip.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 49 +++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> index 43b4bee72dd8..d91d31646b29 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> @@ -62,6 +62,20 @@ key-volume-up {
>  			wakeup-source;
>  		};
>  	};
> +
> +	ts_vdd_supply: ts-vdd-supply {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ts_vdd_supply";
> +		gpio = <&pca9534 3 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	ts_vddio_supply: ts-vddio-supply {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ts_vddio_supply";
> +		gpio = <&pca9534 2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};

I suppose you don't know the voltages for these?

>  };
>  
>  &dispcc {
> @@ -86,6 +100,27 @@ pca9534: gpio@21 {
>  	};
>  };
>  
> +&i2c2 {
> +	status = "okay";
> +	/* Clock frequency was not specified downstream, let's park it to 100 KHz */
> +	clock-frequency = <100000>;
> +
> +	touchscreen@14 {
> +		compatible = "goodix,gt9286";
> +		reg = <0x14>;

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_int_n>, <&ts_rst_n>;

reverse order, shift these down below supplies

> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <80 IRQ_TYPE_LEVEL_LOW>;

interrupts-extended

Konrad

