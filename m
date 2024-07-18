Return-Path: <linux-kernel+bounces-256460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C80BA934EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA77B23708
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008251422C8;
	Thu, 18 Jul 2024 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kw/eKmmK"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B9813FD8C;
	Thu, 18 Jul 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311737; cv=none; b=c+g+TrRU0o6xmC/WfuTmWUN/wMZuwyUO2yOsec1UCbEkGeOpesKLtberD1tk+qvkg3S5sHzKG3JW86DqxNV6goemrUYPKAlCS9+mKR0ajH9mfTLa3HYzyYNr5ssf78TNf73eu7xnWOyWq9yDAUsWedpEq/d1iAqGkSjcHG8FVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311737; c=relaxed/simple;
	bh=85oCYDcBp5EM2UxdcGxHH8ALQcV/Up8tD6ANr8mtmPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZeC6Us8ktuRz8xLxFic4HKWMmwCy3T3os6HJlmctNwglakQO3WLoROeqH8i5j2qmins45bM5dpwqRi4FDNWrOAF7QL8IZB7vB6who/k4fOuQgyqVTzenIBCBe7CFROWfYFmFkMaeUKyFAOylca5YqqSdjUGYpOaKVuAB6He7OQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kw/eKmmK; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46IE8eLN019943;
	Thu, 18 Jul 2024 09:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721311720;
	bh=J1b26Z4gPzOh81ZAO/HOxeNUSxmtc4N3KEvIsEO1QS8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=kw/eKmmKRzI8t3K0wcoPtULzVY/F/5IM0+NG3f7aRMP/d7LsvSPWy7UEVJnwFIkuu
	 ZaHNm6LE7u6P27wEXnK/7C/WUuP2sbvOa6pvWJA1/Xj7wCLv+tJ+E2AnzlP9PL2ImR
	 bCDSqV7vpaX5trc8iF+OnC0KS0R1oua30dLVZ0J8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46IE8enk105271
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jul 2024 09:08:40 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jul 2024 09:08:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jul 2024 09:08:40 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46IE8eEV038180;
	Thu, 18 Jul 2024 09:08:40 -0500
Message-ID: <d1d7f693-1dd6-4aea-bdbd-4385dc35d462@ti.com>
Date: Thu, 18 Jul 2024 09:08:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Add support for multiple
 CAN instances
To: Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>
References: <20240621091057.1473010-1-b-kapoor@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240621091057.1473010-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bhavya,

On 6/21/24 4:10 AM, Bhavya Kapoor wrote:
> CAN instances 0 and 1 in the mcu domain and 0 in the main domain are
> brought on the evm through headers J5, J8 and J10 respectively. Thus,
> add their respective transceiver's 0, 1 and 2 dt nodes as well as
> add the required pinmux to add support for these CAN instances.
> 

Looks good to me.

Reviewed-by: Judith Mendez <jm@ti.com>

> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
> 
> rebased to: next-20240620
> 
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 74 +++++++++++++++++++++++++
>   1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index 253b02f0437d..4fcfbade07c8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -124,10 +124,39 @@ vsys_io_1v2: regulator-vsys-io-1v2 {
>   		regulator-always-on;
>   		regulator-boot-on;
>   	};
> +
> +	transceiver0: can-phy0 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
> +		standby-gpios = <&mcu_gpio0 12 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	transceiver1: can-phy1 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +	};
> +
> +	transceiver2: can-phy2 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&exp1 17 GPIO_ACTIVE_HIGH>;
> +	};
>   };
>   
>   &main_pmx0 {
>   
> +	main_mcan0_pins_default: main-mcan0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x1dc, PIN_INPUT, 0) /* (C22) MCAN0_RX */
> +			J722S_IOPAD(0x1d8, PIN_OUTPUT, 0) /*(D22) MCAN0_TX */
> +		>;
> +	};
> +
>   	main_i2c0_pins_default: main-i2c0-default-pins {
>   		pinctrl-single,pins = <
>   			J722S_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (D23) I2C0_SCL */
> @@ -250,6 +279,26 @@ &main_uart0 {
>   
>   &mcu_pmx0 {
>   
> +	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x038, PIN_INPUT, 0) /* (D8) MCU_MCAN0_RX */
> +			J722S_MCU_IOPAD(0x034, PIN_OUTPUT, 0) /* (B2) MCU_MCAN0_TX */
> +		>;
> +	};
> +
> +	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x040, PIN_INPUT, 0) /* (B1) MCU_MCAN1_RX */
> +			J722S_MCU_IOPAD(0x03C, PIN_OUTPUT, 0) /*(C1) MCU_MCAN1_TX */
> +		>;
> +	};
> +
> +	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x0030, PIN_OUTPUT, 7) /* (C3) MCU_GPIO0_12 */
> +		>;
> +	};
> +
>   	wkup_uart0_pins_default: wkup-uart0-default-pins {
>   		pinctrl-single,pins = <
>   			J722S_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C7) WKUP_UART0_CTSn */
> @@ -457,3 +506,28 @@ &usb1 {
>   	phys = <&serdes0_usb_link>;
>   	phy-names = "cdns3,usb3-phy";
>   };
> +
> +&mcu_mcan0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan0_pins_default>;
> +	phys = <&transceiver0>;
> +};
> +
> +&mcu_mcan1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan1_pins_default>;
> +	phys = <&transceiver1>;
> +};
> +
> +&main_mcan0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan0_pins_default>;
> +	phys = <&transceiver2>;
> +};
> +
> +&mcu_gpio0 {
> +	status = "okay";
> +};


