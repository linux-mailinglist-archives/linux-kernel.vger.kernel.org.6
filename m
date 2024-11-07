Return-Path: <linux-kernel+bounces-399383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1029BFE43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F10A1F23C00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64DE193429;
	Thu,  7 Nov 2024 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W5uS2jGa"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF118FDAF;
	Thu,  7 Nov 2024 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730960040; cv=none; b=ZUxs3oAqv7he+rqlkyHj618AVuk/HE7jykJJgYbsdDhytFsfSst2BZGpFYdqn8hxg3l3SGq3zhvYur1S1pSFulo6eP/1HDigFurP6jQE3Tw1Pfbh+rppFJeXnGRoslkTO8dUTBFQr+hbao+Fn+/UHnFVhLvBlPL3rM8firBEhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730960040; c=relaxed/simple;
	bh=G7UeEBDqL8H0T90IaJR3DlE7FLgyLB9fN46Nrim8EO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=akMCM3j0Mo96Q2NTQbQqUgomgMTJXnqtxRHeunVC0KOlEpAKghiutIn3t6tm4KD7mYZBytmDYT0qnsM8RvB2RG6W7b3ijLQxZq03d85r7iZnyjHhnGYNozTXnGr8Qw+JkyIl5gY5fNfbQXSye/M7Sj41k/vAU9fhxpryYkQYXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W5uS2jGa; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A76DoD5088078;
	Thu, 7 Nov 2024 00:13:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730960030;
	bh=2eWrsjrbIJKbsXTuxNSqjAxUfatwdCMJFkOy2KzLLUE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=W5uS2jGay6QHm/tgL9YTQ0/7SLsOPk15oNBSYoLZZwBR7DT4yXUN+QrNI8Xc3Yn1U
	 sowiJ9HBXxIP/SCmwMfQVkQqa0Xish9IzZhCXW71VGwpKVgdm/4CjIeN4M2SNFMgPI
	 QjV3fPAGQxMEGeWuXzr2/nl+Tr0By72spwFp3O6k=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A76DorA129888;
	Thu, 7 Nov 2024 00:13:50 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Nov 2024 00:13:50 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Nov 2024 00:13:49 -0600
Received: from [10.24.68.216] (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A76DjQE112308;
	Thu, 7 Nov 2024 00:13:46 -0600
Message-ID: <9fe4ff30-79ca-453d-a84d-53969062813c@ti.com>
Date: Thu, 7 Nov 2024 11:43:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Add pinmux for RPi Header
Content-Language: en-US
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <s-sinha@ti.com>, <ankurbaranwal@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>
References: <20241028082426.1551816-1-b-kapoor@ti.com>
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20241028082426.1551816-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Kindly reject this patch as i will send another version with few 
modifications.

Thanks

On 28/10/24 1:54 pm, Bhavya Kapoor wrote:
> Add pinmux required to bring out the i2c and gpios on
> 40-pin RPi expansion header on the J722S EVM.
>
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> Signed-off-by: Shreyash Sinha <s-sinha@ti.com>
> ---
>
> Rebased To - next-20241025
>
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 62 +++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index a00f4a7d20d9..7dce021a8a3c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -359,6 +359,32 @@ audio_ext_refclk1_pins_default: audio-ext-refclk1-default-pins {
>   			J722S_IOPAD(0x00a0, PIN_OUTPUT, 1) /* (N24) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
>   		>;
>   	};
> +
> +	rpi_header_gpio0_pins_default: rpi-header-gpio0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x094, PIN_INPUT, 7) /* (P26) GPIO0_36 */
> +			J722S_IOPAD(0x088, PIN_INPUT, 7) /* (N22) GPIO0_33 */
> +			J722S_IOPAD(0x0ac, PIN_INPUT, 7) /* (P21) GPIO0_42 */
> +			J722S_IOPAD(0x0a8, PIN_INPUT, 7) /* (R27) GPIO0_41 */
> +		>;
> +	};
> +
> +	rpi_header_gpio1_pins_default: rpi-header-gpio1-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x1b0, PIN_INPUT, 7) /* (F24) GPIO1_14 */
> +			J722S_IOPAD(0x1ac, PIN_INPUT, 7) /* (C27) GPIO1_13 */
> +			J722S_IOPAD(0x198, PIN_INPUT, 7) /* (A26) GPIO1_8 */
> +			J722S_IOPAD(0x1a4, PIN_INPUT, 7) /* (D25) GPIO1_11 */
> +			J722S_IOPAD(0x194, PIN_INPUT, 7) /* (A25) GPIO1_7 */
> +			J722S_IOPAD(0x1b8, PIN_INPUT, 7) /* (C20) GPIO1_16 */
> +			J722S_IOPAD(0x1a8, PIN_INPUT, 7) /* (C26) GPIO1_12 */
> +			J722S_IOPAD(0x1a0, PIN_INPUT, 7) /* (F23) GPIO1_10 */
> +			J722S_IOPAD(0x19c, PIN_INPUT, 7) /* (B25) GPIO1_9 */
> +			J722S_IOPAD(0x1b4, PIN_INPUT, 7) /* (B20) GPIO1_15 */
> +			J722S_IOPAD(0x1bc, PIN_INPUT, 7) /* (D20) GPIO1_17 */
> +			J722S_IOPAD(0x1c0, PIN_INPUT, 7) /* (E19) GPIO1_18 */
> +		>;
> +	};
>   };
>   
>   &cpsw3g {
> @@ -387,6 +413,8 @@ &cpsw_port1 {
>   };
>   
>   &main_gpio1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rpi_header_gpio1_pins_default>;
>   	status = "okay";
>   };
>   
> @@ -443,6 +471,25 @@ J722S_MCU_IOPAD(0x050, PIN_INPUT_PULLUP, 0)	/* (C6) WKUP_I2C1_SDA */
>   		>;
>   		bootph-all;
>   	};
> +
> +	mcu_rpi_header_gpio0_pins_default: mcu-rpi-header-gpio0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x01c, PIN_INPUT, 7) /* (B5) MCU_GPIO0_7 */
> +			J722S_MCU_IOPAD(0x020, PIN_INPUT, 7) /* (C5) MCU_GPIO0_8 */
> +			J722S_MCU_IOPAD(0x00c, PIN_INPUT, 7) /* (B12) MCU_GPIO0_3 */
> +			J722S_MCU_IOPAD(0x010, PIN_INPUT, 7) /* (C11) MCU_GPIO0_4 */
> +			J722S_MCU_IOPAD(0x008, PIN_INPUT, 7) /* (A9) MCU_GPIO0_2 */
> +			J722S_MCU_IOPAD(0x000, PIN_INPUT, 7) /* (C12) MCU_GPIO0_0 */
> +			J722S_MCU_IOPAD(0x004, PIN_INPUT, 7) /* (A10) MCU_GPIO0_1 */
> +		>;
> +	};
> +
> +	mcu_i2c0_pins_default: mcu-i2c0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x048, PIN_INPUT, 0) /* (E11) MCU_I2C0_SDA */
> +			J722S_MCU_IOPAD(0x044, PIN_INPUT, 0) /* (B13) MCU_I2C0_SCL */
> +		>;
> +	};
>   };
>   
>   &wkup_uart0 {
> @@ -810,5 +857,20 @@ &main_mcan0 {
>   };
>   
>   &mcu_gpio0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_rpi_header_gpio0_pins_default>;
> +	status = "okay";
> +};
> +
> +&main_gpio0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
> +	status = "okay";
> +};
> +
> +&mcu_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_i2c0_pins_default>;
> +	clock-frequency = <400000>;
>   	status = "okay";
>   };

