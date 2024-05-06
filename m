Return-Path: <linux-kernel+bounces-170039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FEF8BD0F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E171C236D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E74153BE3;
	Mon,  6 May 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="CiF8639H"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B6153BD9
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007740; cv=none; b=LddN1cEe+lHmVuenyg4C7nODy/k4kFNgTDtUacE/bgeHk/c795rG6HL+L81TeR/iGaiPEq8QOtJ4mRfLqgpNWJr9Qgx0TLvXALJKlAn8hsqUVLnmMHuob25MukK1W2SMKPFmfXgYueEbfqUXPIW0gpYqB4Y3jbXapc2YhTzXEWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007740; c=relaxed/simple;
	bh=HMtfrl9349+nPpcPyik4zyg4R/FiZt51CvCWS+GiV+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sV/F7pzYi2vT3lsNibfM7lBDCL/pWuDYF/whN/jZpkMvVHt+07IPWfB4wm4i4CqJ/YiFzb4PyqemzW20v6vzwSthVIEh6SPezUh/NnVF/UHwXmIU8fa1L0/K7+rANVOTzoF2owXqf1m45EMOWM0kBZJ2BB7W7nB2FSQG74SBKq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=CiF8639H; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1715007726; x=1717599726;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HMtfrl9349+nPpcPyik4zyg4R/FiZt51CvCWS+GiV+8=;
	b=CiF8639HVsP8wpbtBBsvU3zRmX3Shuq42AD5gamhV7ttDf+Tlt31NWN/yskIbO3J
	JWLQur/SnSvECOXZanW4YCD2tc8jq9sKi0Ov+vT5gznnqb6owbw8tqIXZlIRklXO
	u0lTwgJq9JGOtVR33m8Y/wolZy5VeajQXJ1jLlonqc4=;
X-AuditID: ac14000a-fadff7000000290d-b9-6638f0ed2396
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CE.73.10509.DE0F8366; Mon,  6 May 2024 17:02:05 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 6 May 2024
 17:02:04 +0200
Message-ID: <43f9af45-13ac-475d-ae94-a815b3f84381@phytec.de>
Date: Mon, 6 May 2024 17:02:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: am642-phyboard-electra: Add overlay
 to enable PCIe
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20240503223552.2168847-1-nmorrisson@phytec.com>
 <20240503223552.2168847-3-nmorrisson@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240503223552.2168847-3-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWyRpKBR/ftB4s0g4PbzC3W7D3HZDH/yDlW
	i+WfZ7NbvJx1j81i0+NrrBaXd81hs3jz4yyTxYfGzWwW//fsYLfofqdu8f/sB3YHbo9NqzrZ
	PDYvqffo725h9fhz8R2rx/Eb25k8Pm+SC2CL4rJJSc3JLEst0rdL4MrYdrqTsWCRcsX1/UdZ
	GhjnynYxcnJICJhIPDz1kKWLkYtDSGAJk8SxrR8ZIZw7jBL3Pu5kBKniFbCRuHZvEyuIzSKg
	IvF04g+ouKDEyZlPWEBsUQF5ifu3ZrCD2MICsRL/P95iAhkkIrCUUeLxqh1gDrNAG6PEk4cH
	mLsYOYBW5Et8uWQB0sAsIC5x68l8JhCbTUBd4s6Gb2DLOAVsJVrePGaGqLGQWPzmIDuELS+x
	/e0csLgQkP3i0nIWiHfkJaade80MYYdKbP2ynWkCo/AsJLfOQrJuFpKxs5CMXcDIsopRKDcz
	OTu1KDNbryCjsiQ1WS8ldRMjKOJEGLh2MPbN8TjEyMTBeIhRgoNZSYT3aLt5mhBvSmJlVWpR
	fnxRaU5q8SFGaQ4WJXHe1R3BqUIC6YklqdmpqQWpRTBZJg5OqQZG39WGFvFWFf/5jt9VOzv9
	y6To9yUR0k2PFh+y6duq6Wstcow7uVncNCnbzMRWMmfS6QMiP39t6yjfqCrFm7rsUsecw7d9
	FlUv3fG+TVNY8XpMw2wNjc+ihibyT2Mdg46LSd50ke464lzJtf3sr7nFznZO27ebCpaFTVK6
	FJbx7Pp8i6T5TFOUWIozEg21mIuKEwGtUJX2pgIAAA==

Hi Nathan,

Am 04.05.24 um 00:35 schrieb Nathan Morrisson:
> Add an overlay to enable PCIe on the am642-phyboard-electra. This
> will disable USB3 and restrict us to USB2.
> 
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile               |  3 +
>   .../k3-am642-phyboard-electra-pcie-usb2.dtso  | 88 +++++++++++++++++++
>   2 files changed, 91 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 9a722c2473fb..6a38ce2603af 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-pcie-usb2.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
> @@ -131,6 +132,8 @@ k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
>   	k3-am62x-sk-csi2-tevi-ov5640.dtbo
>   k3-am642-evm-icssg1-dualemac-dtbs := \
>   	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
> +k3-am642-phyboard-electra-pcie-usb2.dtbs := \
> +	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-pcie-usb2.dtbo
>   k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
>   	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
>   k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso
> new file mode 100644
> index 000000000000..03fc81a6018f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * DT overlay for PCIe support (limits USB to 2.0/high-speed)
> + *
> + * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
> + * Author: Matt McKee <mmckee@phytec.com>
> + *
> + * Copyright (C) 2024 PHYTEC America, LLC - https://www.phytec.com
> + * Author: Nathan Morrisson <nmorrisson@phytec.com>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/phy/phy-cadence.h>
> +
> +#include "k3-pinctrl.h"
> +#include "k3-serdes.h"
> +
> +&{/} {
> +	pcie_refclk0: pcie-refclk0 {
> +		compatible = "gpio-gate-clock";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_usb_sel_pins_default>;
> +		clocks = <&serdes_refclk>;
> +		#clock-cells = <0>;
> +		enable-gpios =  <&main_gpio1 7 GPIO_ACTIVE_HIGH>;
^ you have two spaces after =

> +		status = "okay";
you do not need this status property here.

With this changes, for both patches:

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>


> +	};
> +};
> +
> +&main_pmx0 {
> +	pcie_usb_sel_pins_default: pcie-usb-sel-default-pins {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x017c, PIN_OUTPUT, 7)	/* (T1) PRG0_PRU0_GPO7.GPIO1_7 */
> +		>;
> +	};
> +
> +	pcie_pins_default: pcie-default-pins {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0098, PIN_OUTPUT, 7)	/* (W19) GPMC0_WAIT0.GPIO0_37 */
> +		>;
> +	};
> +};
> +
> +&pcie0_rc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_pins_default>;
> +	reset-gpios = <&main_gpio0 37 GPIO_ACTIVE_HIGH>;
> +	phys = <&serdes0_pcie_usb_link>;
> +	phy-names = "pcie-phy";
> +	num-lanes = <1>;
> +	status = "okay";
> +};
> +
> +&serdes0_pcie_usb_link {
> +	cdns,phy-type = <PHY_TYPE_PCIE>;
> +};
> +
> +&serdes_ln_ctrl {
> +	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
> +};
> +
> +&serdes0 {
> +	assigned-clock-parents = <&pcie_refclk0>, <&pcie_refclk0>, <&pcie_refclk0>;
> +};
> +
> +&serdes_refclk {
> +	clock-frequency = <100000000>;
> +};
> +
> +/*
> + * Assign pcie_refclk0 to serdes_wiz0 as ext_ref_clk.
> + * This makes sure that the clock generator gets enabled at the right time.
> + */
> +&serdes_wiz0 {
> +	clocks = <&k3_clks 162 0>, <&k3_clks 162 1>, <&pcie_refclk0>;
> +};
> +
> +&usbss0 {
> +	ti,usb2-only;
> +};
> +
> +&usb0 {
> +	maximum-speed = "high-speed";
> +};

