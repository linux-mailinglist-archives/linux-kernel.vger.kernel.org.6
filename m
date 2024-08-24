Return-Path: <linux-kernel+bounces-300160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FAC95DFAD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08691F21C09
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71AE7D40D;
	Sat, 24 Aug 2024 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vurSt9dS"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301042A97;
	Sat, 24 Aug 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724525065; cv=none; b=KMZsUkgQsvqCfCyb5R+miwky385AqCMAa3HH5X7IBbKqhMLyU0myfiJiHAaWdQNzDEDSOI8fk8wLTlXjyLf6k5AFTwAQCsJ3qL/qPKYrWGLv7RqqxqPLKiFg6X3twLrQIOillh0lu2HO/RzGqTUvxDwzBFuKrP9RntarmPHafb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724525065; c=relaxed/simple;
	bh=6XnFfmJjIJffLN9cz4SUVVABja46yoCa4dTlhVhiPfs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c98x5Q7g7h0V9bWEyH7iK190ZuNvMtJa6klkB1BwXzmurIzhwkqTirplbdriiB+brJWffwoPkq/e2lmSDaHrkcnaiSnCInGfj1Zm4Kc8jeFbfD+QqVH1TpzrgvW2NFrlWXqZoNe1ck7JQIET6ijS/ZQU6211Hh27/z3C9+n6dn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vurSt9dS; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OIiFF3078656;
	Sat, 24 Aug 2024 13:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724525055;
	bh=BxmjcEY0kFJYwqjp+O6C9NvQFjdl5/RnzwVq4OoAmFA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vurSt9dSq4P3SlXdDLI8F6vMB6bpi8RSCpCz4EZjamfwATpynMdyFSdP+kff0C3Vg
	 U6FSZzh/B2k/M7mFe/PstbZ27BqmgJ4CPz/B2ECQgXPVvvvetV9np8w2b16/HgpqQg
	 rm6ArRMgCKAuPnRcCSzhA0b9EZfvACfTX3hQf6RM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OIiFhc001601
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 13:44:15 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 13:44:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 13:44:15 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OIiFJH076201;
	Sat, 24 Aug 2024 13:44:15 -0500
Date: Sat, 24 Aug 2024 13:44:15 -0500
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>, Roger Quadros <rogerq@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>,
        Jason Kridner
	<jkridner@beagleboard.org>,
        Deepak Khatri <lorforlinux@beagleboard.org>,
        Drew
 Fustini <drew@beagleboard.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
Message-ID: <20240824184415.o7ehjqm523igqbbi@cornhusk>
References: <20240822170440.265055-1-robertcnelson@gmail.com>
 <20240822170440.265055-2-robertcnelson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240822170440.265055-2-robertcnelson@gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12:04-20240822, Robert Nelson wrote:
Minor nmits below:

> BeagleBoard.org BeagleY-AI is an easy to use, affordable open source
> hardware single board computer based on the Texas Instruments AM67A,
> which features a quad-core 64-bit Arm CPU subsystem, 2 general-purpose
> digital-signal-processors (DSP) and matrix-multiply-accelerators (MMA),
> GPU, vision and deep learning accelerators, and multiple Arm Cortex-R5
> cores for low-power, low-latency GPIO control.
> 
[...]
> +
> +	vdd_3v3: regulator-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vsys_5v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vdd_mmc1: regulator-mmc1 {

	Also responding:

> Okay, i'll change these... I already see a problem, as I've got two
> 3v3... can we use 'regulator-[0-9]v[0-9]-X' ?


let us just call them regulator-3 and so on incrementally. You can
already name with regulator-name property. We really don't need the "v'
specification here.

[...]
> +&wkup_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
> +	clock-frequency = <100000>;
> +	bootph-all;
> +	status = "okay";
> +
> +	tps65219: pmic@30 {
> +		compatible = "ti,tps65219";
> +		reg = <0x30>;
> +		buck1-supply = <&vsys_5v0>;
> +		buck2-supply = <&vsys_5v0>;
> +		buck3-supply = <&vsys_5v0>;
> +		ldo1-supply = <&vdd_3v3>;
> +		ldo3-supply = <&vdd_3v3>;
> +		ldo4-supply = <&vdd_3v3>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq_pins_default>;
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		system-power-controller;
> +		ti,power-button;
> +		bootph-all;

Flip the bootph-all above the system-power-controller to stay within the
coding style boundaries?

> +
> +		regulators {
	[...]
> +};
> +
> +&sdhci1 {
> +	/* SD/MMC */
> +	vmmc-supply = <&vdd_mmc1>;
> +	vqmmc-supply = <&vdd_sd_dv>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc1_pins_default>;
> +	disable-wp;
> +	cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
> +	cd-debounce-delay-ms = <100>;
> +	ti,fails-without-test-cd;
> +	bootph-all;

Nit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
keep the  bootph property above the vendor prefixed ones..

> +	status = "okay";
> +};
> -- 
> 2.39.2
> 


Additionally, with dtbs_check on next-20240823, I get:

/workdir/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dtb: leds: led-0: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
/workdir/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dtb: leds: led-0:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:

Please fix appropriately.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

