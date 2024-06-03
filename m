Return-Path: <linux-kernel+bounces-199278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49C18D84CF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E431C20EB8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A195D12EBC2;
	Mon,  3 Jun 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IsANAFWw"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6F757E0;
	Mon,  3 Jun 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424479; cv=none; b=dfy/D3SYgQMMb1x5mpXYZYsSbbGscDTOdPbrzJFCGBriK9qG76fTY068YR4MLCR8oyZ0mKLHToMIG4CTjH9tA4DH7LCHiyIBpb71HZkQ41Yr54ExIaraiO/Pat7gHJXCN0dDCSSCItSOl6NTERb3nObgLE0C78tefr/14bw4UK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424479; c=relaxed/simple;
	bh=LDaFcYd2WsZtItfbIjIkTkamexirvFUhw3HaN3S1/wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fs/0SU8Xdt7lspfrlm26H5crIvqHcEHrAgLDWh4U2aMtme9fRgR2Dn8+DkxzsNJGhZJATDuwmZCoVAa8KQm9GdWxP1/l2kDvuM7w4qufIJosEgUssdEae7OxhNop2U0D4EIJNCPRPCr+tu8QMysd9MdV9LFVtGR52YBcxOSf2VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IsANAFWw; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 453ELCjh025118;
	Mon, 3 Jun 2024 09:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717424472;
	bh=ZXYGbS8Ya/9S2pOf2btIClv2gniztcNS788+juFZhwQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IsANAFWwbjDEvOcDFqlAwZYjvWtwCISd86k5elj4ZmV7+biYj+FZLE4S25UbuvVkg
	 Su9bxyQRWkXs48kDD/LqOlyMA2pxlOBISN3cnlj3MHWIKLAIShuG1x9sEekFn6O6IW
	 HKZ8eXATlrelPDKgZMg6yNuUkxTvgzvDQxrNNzBo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 453ELCWI117135
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 09:21:12 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 09:21:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 09:21:11 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 453ELBvu048336;
	Mon, 3 Jun 2024 09:21:11 -0500
Message-ID: <183a9d15-939e-433b-84ba-8a64eb8ef3ec@ti.com>
Date: Mon, 3 Jun 2024 09:21:11 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] arm64: dts: ti: k3-j722s: Enable PCIe and USB
 support on J722S-EVM
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
References: <20240601121554.2860403-1-s-vadapalli@ti.com>
 <20240601121554.2860403-8-s-vadapalli@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240601121554.2860403-8-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/1/24 7:15 AM, Siddharth Vadapalli wrote:
> Enable PCIe0 instance of PCIe in Root Complex mode of operation with Lane 0
> of the SERDES1 instance of SERDES. Also enable USB0 instance of USB to
> interface with the Type-C port via the USB hub, by configuring the pin P05
> of the GPIO expander on the EVM. Enable USB1 instance of USB in SuperSpeed
> mode of operation with Lane 0 of the SERDES0 instance of SERDES.
> 
> Co-developed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> v3:
> https://lore.kernel.org/r/20240524090514.152727-4-s-vadapalli@ti.com/
> and
> https://lore.kernel.org/r/20240524090514.152727-8-s-vadapalli@ti.com/
> Changes since v3:
> - Above patches have been squashed into this patch.
> 
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 72 +++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index bf3c246d13d1..3145e680e2d3 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -9,7 +9,9 @@
>   /dts-v1/;
>   
>   #include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/phy/phy.h>
>   #include "k3-j722s.dtsi"
> +#include "k3-serdes.h"
>   
>   / {
>   	compatible = "ti,j722s-evm", "ti,j722s";
> @@ -202,6 +204,12 @@ J722S_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AG26) RGMII1_TXC */
>   			J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
>   		>;
>   	};
> +
> +	main_usb1_pins_default: main-usb1-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x0258, PIN_INPUT, 0) /* (B27) USB1_DRVVBUS */
> +		>;
> +	};
>   };
>   
>   &cpsw3g {
> @@ -301,6 +309,13 @@ exp1: gpio@23 {
>   				  "PCIe0_1L_RC_RSTz", "PCIe0_1L_PRSNT#",
>   				  "ENET1_EXP_SPARE2", "ENET1_EXP_PWRDN",
>   				  "PD_I2ENET1_I2CMUX_SELC_IRQ", "ENET1_EXP_RESETZ";
> +
> +		p05-hog {
> +			/* P05 - USB2.0_MUX_SEL */
> +			gpio-hog;
> +			gpios = <5 GPIO_ACTIVE_HIGH>;
> +			output-high;
> +		};
>   	};
>   };
>   
> @@ -384,3 +399,60 @@ &sdhci1 {
>   	status = "okay";
>   	bootph-all;
>   };
> +
> +&serdes_ln_ctrl {
> +	idle-states = <J722S_SERDES0_LANE0_USB>,
> +		      <J722S_SERDES1_LANE0_PCIE0_LANE0>;
> +};
> +
> +&serdes0 {
> +	status = "okay";
> +	serdes0_usb_link: phy@0 {
> +		reg = <0>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_USB3>;
> +		resets = <&serdes_wiz0 1>;
> +	};
> +};
> +
> +&serdes1 {
> +	serdes1_pcie_link: phy@0 {
> +		reg = <0>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_PCIE>;
> +		resets = <&serdes_wiz1 1>;
> +	};
> +};
> +
> +&pcie0_rc {
> +	status = "okay";

As much as I like these at the top, the new format rules seems to
suggest "status" properties should go at the bottom of the node.

Andrew

> +	reset-gpios = <&exp1 18 GPIO_ACTIVE_HIGH>;
> +	phys = <&serdes1_pcie_link>;
> +	phy-names = "pcie-phy";
> +};
> +
> +&usbss0 {
> +	ti,vbus-divider;
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	dr_mode = "otg";
> +	usb-role-switch;
> +};
> +
> +&usbss1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_usb1_pins_default>;
> +	ti,vbus-divider;
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	dr_mode = "host";
> +	maximum-speed = "super-speed";
> +	phys = <&serdes0_usb_link>;
> +	phy-names = "cdns3,usb3-phy";
> +};

