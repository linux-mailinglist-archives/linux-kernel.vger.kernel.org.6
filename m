Return-Path: <linux-kernel+bounces-412729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568549D0E68
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173F628126D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640DC1993B4;
	Mon, 18 Nov 2024 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDu4++ko"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B31946A0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925320; cv=none; b=u8EHhn51dm2JNI0NkJyv4eP9DWYmXfGMBWcIEriQoXOElTPBweTP8y7IlZEpxXiN+VLjym5safXGtEmnXfztspdUr2Tr0Id1TZBpPgyitiYaugrW1VV5O1v6P3MIarr6UPxS8JDBFvRiR1jalB1eJanMX587PJQ6LSZPcTNi2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925320; c=relaxed/simple;
	bh=Db4cp2BS1tOGXH1Epn3W22qyrM5yGAT815UoctHNo+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sd23jjMy84tipPpkilPfUhKFApLPrmJm0ZRbqmIFYE6dCy3nFyeMpvqVdZ3tzK655qpcP6EdB3iYwi90R+9hG9q61mwxhgVNYCIy6QZKeu07WXN99Ccky0s0xPwe0XlmCLa5KU3OICh1PCU0w9Oyhtqf24AM6/zHxSQEIrSRp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YDu4++ko; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso23533835e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731925317; x=1732530117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=phSqjmldBPWXRgFeffd/JWcPCOA4hJo3BiIhOYwH3MA=;
        b=YDu4++koJxtr+FzoXRequiUYoGo53OpWgZJqWqBeGre2QOgLudGKs8vCGZd3+wo4uK
         ecfpKtI8e9PyKRns3Sgef+U5OzMMF3OfOPq66U4+t375VPK1K+BG79LJFYj6kGbmckVt
         YvDB2KbVitfwAh7aBAbqDjh+jhLCe5U5v+mm1M7vVwjqx7A3XVqcuCo0ZJ7vZKd/3pjN
         yvIpDMXqTub8C76HxQ7wCMHyvsTjY7SCY9S1h4P+YcFS8kPLFNDnm+Gep2n+LQfA2dws
         U92HLOJeUVlk6cW1PYcbFWM7DC8zjTw4IWK4Q9TwKdmHzzIwIaBeHKOhq6Fqe+PmDsM0
         BcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925317; x=1732530117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phSqjmldBPWXRgFeffd/JWcPCOA4hJo3BiIhOYwH3MA=;
        b=WauuF7pIuFJtB8e1aalsjhxyrle48Z7Lcdrg3SkwFDvAiGG1C37lWZ/qKMWj+0uJGj
         l2YIqwfVJsg5xSqLo/6FfvWegDbZHxLYYPLGAqbSrixRhZWU4gxSEH0S83jv/XhZGFWd
         T+dvlVrYpJQectsf2vm8mdIMeT5Nb1bT1+acSMhG9TpDXj721FvOpfzqAR6J7OvNvjKq
         L3JM1qaAuvWVwKecQpcNdFUGv8HcCL+kT5NkYh87pZHtSzQF8egeYhKzSIwhOr5qUth5
         /bcdYS8YKmAnXGfegLeFDVYnnxnHQQtpQQ3YHKYhOX4cFYMoRAT21gLe1O+3DbJ+evjs
         5WxA==
X-Forwarded-Encrypted: i=1; AJvYcCUBUyCDxeu51JZoXG9pSnlNYU19UmOKsa+b4cLc8D7+Qsa96R6htmiM06eu8+SVmlk55lU0a1NuUW4jJsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLDaPYyH+M6Z7xA41z7VCNnLyBWJuXHtf1P4R3aaTByUuA9Vge
	H5jtJD16bgjkZKbJS5NL1yQPQO5BhyrS1KqoB4XsN8UySJZ/UMOCMiLdyE3hjFE=
X-Google-Smtp-Source: AGHT+IEFeF0+Sdkb6b315Q3y1qMmmjCmnoawHXKh9ZeoveK/uoXwKwzlP7db+07+TyaV3vMlKWXWlQ==
X-Received: by 2002:a05:6000:1f88:b0:37c:d276:f04 with SMTP id ffacd0b85a97d-38225a915fbmr8111178f8f.45.1731925317212;
        Mon, 18 Nov 2024 02:21:57 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:8453:3d1e:f32c:d913])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382485e2a89sm2301322f8f.17.2024.11.18.02.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 02:21:56 -0800 (PST)
Date: Mon, 18 Nov 2024 11:21:45 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v6 10/10] arm64: dts: qcom: Add Xiaomi Redmi 5A
Message-ID: <ZzsVOV8GjCVtCi5Q@linaro.org>
References: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
 <20241113-msm8917-v6-10-c348fb599fef@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113-msm8917-v6-10-c348fb599fef@mainlining.org>

On Wed, Nov 13, 2024 at 04:11:51PM +0100, Barnabás Czémán wrote:
> Add initial support for Xiaomi Redmi 5A (riva).
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                |   1 +
>  arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts | 297 +++++++++++++++++++++++
>  2 files changed, 298 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 9bb8b191aeb517e8f1e3a11bca98a3d0c39c5398..7562406843cfd82397c4844d14a22e8bcf4bba74 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -62,6 +62,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt86518.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt86528.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8917-xiaomi-riva.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8929-wingtech-wt82918hd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-longcheer-l9100.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..81bb76f1773252be2f60777acf93d51d01981f86
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
> @@ -0,0 +1,297 @@
> [...]
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-volup {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;

It's good practice to

> +			debounce-interval = <15>;
> +		};
> +	};
> [...]
> +&blsp1_i2c3 {
> +	status = "okay";
> +
> +	touchscreen@38 {
> +		compatible = "edt,edt-ft5306";
> +		reg = <0x38>;
> +		interrupts-extended = <&tlmm 65 IRQ_TYPE_LEVEL_LOW>;

add pinctrl

> +		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;

for all

> +		vcc-supply = <&pm8937_l10>;
> +		iovcc-supply = <&pm8937_l5>;
> +
> +		touchscreen-size-x = <720>;
> +		touchscreen-size-y = <1280>;
> +	};
> +};
> +
> +&blsp2_i2c1 {
> +	status = "okay";
> +
> +	bq27426@55 {
> +		compatible = "ti,bq27426";
> +		reg = <0x55>;
> +		monitored-battery = <&battery>;
> +	};
> +
> +	bq25601@6b{
> +		compatible = "ti,bq25601";
> +		reg = <0x6b>;
> +		monitored-battery = <&battery>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <61 IRQ_TYPE_EDGE_FALLING>;

GPIOs/pins

> +
> +		input-voltage-limit-microvolt = <4400000>;
> +		input-current-limit-microamp = <1000000>;
> +	};
> +};
> [...]

> +&sdhc_2 {
> +	cd-gpios = <&tlmm 67 GPIO_ACTIVE_LOW>;

that you use. :-)

Usually it can be something simple like function=gpio, bias-disable,
drive-strength = <2>, etc, plenty of examples exist upstream. Check
downstream or schematics (if you have them). Ideally you would check
what the peripheral requires.

E.g. for SD card the GPIO usually has external pull-up, so bias-pull-up
would be redundant and one can just use bias-disable:

	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
	pinctrl-names = "default", "sleep";

&tlmm {
	sdc2_cd_default: sdc2-cd-default-state {
		pins = "gpio67";
		function = "gpio";
		drive-strength = <2>;
		bias-disable;
	};
};


> +	vmmc-supply = <&pm8937_l11>;
> +	vqmmc-supply = <&pm8937_l12>;
> +
> +	status = "okay";
> +};
> +
> [...]
> +&rpm_requests {
> +	regulators-0 {
> +		compatible = "qcom,rpm-pm8937-regulators";
> +
> [...]
> +		pm8937_l11: l11 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +		};

You usually need/want regulator-allow-set-load and regulator-system-load
for the SD card regulator to avoid issues with certain SD
cards/operations, see

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af61bef513ba179559e56908b8c465e587bc3890

Thanks,
Stephan

