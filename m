Return-Path: <linux-kernel+bounces-300150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26D495DF7C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B06C1F21904
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7FD56B81;
	Sat, 24 Aug 2024 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TodmO/Ht"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9871799B;
	Sat, 24 Aug 2024 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724523147; cv=none; b=M990yKo9HkRNzMvq0WdtpCOm+gX/TqBtMoX+IXwwM7BoJ2DFMj2GZZ1Jxq72MJ5xUJki78Ijszsxaa8amdftADFg774E/1kzoUUCu6xSf+xDXkpibIuKWnwmQBTAVEYm0Su9nslFNFZvg+6yThPu3kMvVJGFl1aRKOhQZ4ZglH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724523147; c=relaxed/simple;
	bh=2yPDK8TFhPmk5lqfVjkJAHyTbk7GNhy/O7XpDuqywfk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMqmNSI+7n/oKOUbVnGMJ/La0WUE6aZYSuzP9fTiRDl/0DZe/sHIwiPoGpktM6KOISoGkRe6JEoAeyKll8lfYkAif24BHHgI8K3HwcmWTXfZCwwVnGCWptytrS4a7lnP7SBSI3MRlihJOTkMbE22R+IcQ1aUaq3dsaeSBzIwZls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TodmO/Ht; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OICI0p045112;
	Sat, 24 Aug 2024 13:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724523138;
	bh=srFzPKyucUigymcchRICNA874/Q4EM6tG+X3LAoo3RU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=TodmO/HtR7yvf52AtEP4aM5Bt9wNsgaZJ5LZdbHYs+BNFpPOeRkJp2mouLSjCiwOk
	 NwY0ruzsyIpFUWIVGh5iWfty3VfM2+ByQD4UfbJ+JKZCjkey/HIuRXGOxdBjvS26v6
	 ndxPLw5kgsjoIekYs5VaUj5uqwiire+LmjFSkPVU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OICICY117081
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 13:12:18 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 13:12:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 13:12:18 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OICI2o049097;
	Sat, 24 Aug 2024 13:12:18 -0500
Date: Sat, 24 Aug 2024 13:12:18 -0500
From: Nishanth Menon <nm@ti.com>
To: Bhavya Kapoor <b-kapoor@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: Add PWM and ECAP overlay for J722S-EVM
Message-ID: <20240824181218.zvymim3jonknmvm2@rearrange>
References: <20240820070607.30628-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240820070607.30628-1-b-kapoor@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12:36-20240820, Bhavya Kapoor wrote:
> The J722S-EVM has 3 PWM outputs and 1 ECAP output routed
> to the J28 connector. This overlay will set the appropriate
> pinmux and enable PWM and ECAP on the pins.

So, change the base evm default. do you have a daughter card that this
overlay represents? Then name this as the daughter card, provide a link
etc. If we start accepting ever pin mux combination, there is no end to
configurations we will get. Sorry.

> 
> Currently enabled PWM output on J28: 29, 31, 33 pins
> and ECAP output on J28: 32 pin
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile              |  1 +
>  arch/arm64/boot/dts/ti/k3-j722s-evm-pwm.dtso | 53 ++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm-pwm.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index e20b27ddf901..61d51284dcba 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -111,6 +111,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
>  
>  # Boards with J722s SoC
>  dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-pwm.dtbo
>  
>  # Boards with J784s4 SoC
>  dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm-pwm.dtso b/arch/arm64/boot/dts/ti/k3-j722s-evm-pwm.dtso
> new file mode 100644
> index 000000000000..f6d1f072b140
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm-pwm.dtso
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * DT Overlay for enabling PWM output on User Expansion header on J722S-EVM
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-pinctrl.h"
> +
> +&main_pmx0 {
> +
> +	main_epwm0_pins_default: main-epwm0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x01b4, PIN_OUTPUT, 2) /* (B20) EHRPWM0_A */
> +		>;
> +	};
> +
> +	main_epwm1_pins_default: main-epwm1-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x01bc, PIN_OUTPUT, 2) /* (D20) EHRPWM1_A */
> +			J722S_IOPAD(0x01c0, PIN_OUTPUT, 2) /* (E19) EHRPWM1_B */
> +		>;
> +	};
> +
> +	main_ecap0_pins_default: main-ecap0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x01b8, PIN_OUTPUT, 3) /* (C20) ECAP0_IN_APWM_OUT */
> +		>;
> +	};
> +};
> +
> +&epwm0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_epwm0_pins_default>;
> +	status = "okay";
> +};
> +
> +&epwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_epwm1_pins_default>;
> +	status = "okay";
> +};
> +
> +&ecap0 {
> +	/* ECAP in APWM mode */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_ecap0_pins_default>;
> +	status = "okay";
> +};
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

