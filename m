Return-Path: <linux-kernel+bounces-427055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B625B9DFBB2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B472819D9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E8F1F9EDA;
	Mon,  2 Dec 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PMKu3bUA"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D07E1F9EB3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127272; cv=none; b=vAmwlOGhzYitVblqLigsUP+kgRrsfF9y01UsGQYj+Ig11+aqYCYzXzaHjtpd+UGfyWfhPXBBuatMGkeD1W+tgAt4w7k0Q4u7CXNxR+74/QFP+/lj20/vejAC5ikW7cugstlQX0p8XrILUK4VqGfM2LNeLyDujFFV4zQwm7l98yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127272; c=relaxed/simple;
	bh=CEYotEMvMNVSJqLeHltkLYYSQQkgWDshBqAqZkBbu0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dvoaXijNCGn+kT1TqbTxEvReujirWvoN27wkksfi4XbDjMAL+EEpQlJ09sLCO0Gr9HR4oPZlHF/aB/vcC8wVKpDwA2tle0UXsI1mEePh0ac1g3MhSA1/qgHUCd9h8mH/FfPH3OrU7lWJ4kv1C8py6B1GUDJyTyyeB+UynAO5jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PMKu3bUA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434aabd688fso23876525e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 00:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733127268; x=1733732068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hoqd94D+feLlJAd8AMaa3RK9Jl4eaWLUHOfCXcSoW5M=;
        b=PMKu3bUAiHSsQZEONPfZFs2wt35PByQJIJhkVsi+hDcmMoVnESV9SaclRj/urS4vct
         OY+aWhqGJdswT4xBDi7zg3+xfbfOSC3XQ7l2uVbGNYtJHJlWK5G8reTrjEePAXZANBuU
         uNhRDumxWRxeQns6ZZnzqD2xWUoM574mmYmrGLq7qE5t4HJCPzd6tNUCCTBjveYBQIvH
         eaoaYi26cwbRgDyV9FEtAfzkB7K3GTom6EJSRx/lb2wvW0FieWPAbbm3LyeOYaP7uBSQ
         GnxerDH3mHBhTDbJhxbLH8lAfI1NIpSuXG8K/Tgrk4nzoi0A4TnzMxEUgwvQETyc9K4r
         kAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127268; x=1733732068;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoqd94D+feLlJAd8AMaa3RK9Jl4eaWLUHOfCXcSoW5M=;
        b=skG4rSizGHRyJvaXzQHloGFky9nfUBAd8k0hTZZ5izHK8UOZeUfXdjcfZAOk7KMtta
         am2oa1ypgXgeeWPJXVtLegZMjr4ey942us9BE6CJeIebEGEG2zz92LDYqaHE1dUwQIie
         CJomVqVo2UPtwerWLzhEpl+CbpqolY9FRJQ2unIohQJlgCXiFX/gZFCGEuJ5Qbw02BK2
         iUPRfYkzpJbDg+sha7c8QRPHosxBcjmuhxNYqGaBDtE5YZ3DLyxdd/oXPXYsdXsUaYDs
         14bPjX7MO+cPEm9udP+xp7QgmcMLP9u2zzU5yhGmv3PGee0g+BAZl3+1lRLDDPWfsdX9
         fdtA==
X-Forwarded-Encrypted: i=1; AJvYcCWvSi6cDXKco6Qh6nNcrssTRj9I2Ncz9XbCKlWO2XGxov4F2XcZu6/mEILmlI994eaYemkA0bx9Z+Q7lxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUa916UeesbHTDjOoOMBwaUVS1VphdGWBygST1Q38oVsrncZV9
	aU0Ktm5HUnD6oe3Ql467zOTKJsKBhW8hhvtYMSdAunyWn2sF6Wjf2inbQLZ01PA=
X-Gm-Gg: ASbGncvmLBSrK9gKuV8BGbrhRslO/uLJoJEaytD2T5qbFsVUQ9TsbnX/aZV3jqE+rDI
	aK7oa0s+EcR3+dIKgB+NEWOtu0R+tKUAAgD/gvdIJ+cz+kahANGQmHTjbI7L/6sQPv0GilLrzmh
	08IHHjdWzumOL4UOS1X8UTxeX6GLvUthyxFihUwMC8ZXIhN7Mq1WhV9PaXaI4mupbhURGolOCVK
	MgzyImouwFtFaV4UGltZX//TV5zrwrpfHmG+3PZiXaAi9eEy80ecJx/Ww==
X-Google-Smtp-Source: AGHT+IEtDqzYKWw9Benv/Yt2JeqHtMT7suJIclYJoqZ4tha5f1Yj7UJIk1x1IGm4le52EEPyGssZLA==
X-Received: by 2002:a05:600c:1552:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-434a9dc36b6mr195508445e9.8.1733127268332;
        Mon, 02 Dec 2024 00:14:28 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dc63f7sm142240315e9.23.2024.12.02.00.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 00:14:27 -0800 (PST)
Message-ID: <2d8dd1c8-fd4b-4dc1-ba62-312ac86335a6@tuxon.dev>
Date: Mon, 2 Dec 2024 10:14:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: microchip: sam9x75_curiosity: Add power
 monitor support
Content-Language: en-US
To: Mihai Sain <mihai.sain@microchip.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241122080523.3941-1-mihai.sain@microchip.com>
 <20241122080523.3941-3-mihai.sain@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241122080523.3941-3-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Mihai,

On 22.11.2024 10:05, Mihai Sain wrote:
> Add PAC1934 support in order to monitor the board power consumption.
> Device is connected on flexcom7 in twi mode.
> 
> [root@SAM9X75 ~]$ awk -f pac1934.awk
> VDD3V3 current:   10.675 mA, voltage: 3295.41 mV
> VDDOUT4 current:  5.7625 mA, voltage: 1196.78 mV
> VDDCORE current: 115.442 mA, voltage: 1243.65 mV
> VDDIODDR current: 29.585 mA, voltage: 1345.21 mV
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  .../dts/microchip/at91-sam9x75_curiosity.dts  | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
> index d453800f8e35..76d7a756e08c 100644
> --- a/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
> @@ -198,6 +198,52 @@ regulator-state-standby {
>  	};
>  };
>  
> +&flx7 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
> +	status = "okay";
> +};
> +
> +&i2c7 {
> +	dmas = <0>, <0>;
> +	i2c-analog-filter;
> +	i2c-digital-filter;
> +	i2c-digital-filter-width-ns = <35>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flx7_default>;
> +	status = "okay";
> +
> +	power-monitor@10 {
> +		compatible = "microchip,pac1934";
> +		reg = <0x10>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		channel@1 {
> +			reg = <0x1>;
> +			shunt-resistor-micro-ohms = <10000>;
> +			label = "VDD3V3";
> +		};
> +
> +		channel@2 {
> +			reg = <0x2>;
> +			shunt-resistor-micro-ohms = <10000>;
> +			label = "VDDOUT4";

On the schematics at [1] this seems to be named DCDC4. Is there a mistake
on [1] or this patch needs adjustments? If so, I can do it while applying.

Thank you,
Claudiu

[1]
https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/UserGuides/SAM9X75-Curiosity-User-Guide-DS60001859.pdf

> +		};
> +
> +		channel@3 {
> +			reg = <0x3>;
> +			shunt-resistor-micro-ohms = <10000>;
> +			label = "VDDCORE";
> +		};
> +
> +		channel@4 {
> +			reg = <0x4>;
> +			shunt-resistor-micro-ohms = <10000>;
> +			label = "VDDIODDR";
> +		};
> +	};
> +};
> +
>  &i2s {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_i2s_default>;
> @@ -231,6 +277,12 @@ pinctrl_flx6_default: flx6-default {
>  				<AT91_PIOA 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
>  				<AT91_PIOA 25 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
>  		};
> +
> +		pinctrl_flx7_default: flx7-default {
> +			atmel,pins =
> +				<AT91_PIOC 0 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>,
> +				<AT91_PIOC 1 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>;
> +		};
>  	};
>  
>  	gpio-keys {

