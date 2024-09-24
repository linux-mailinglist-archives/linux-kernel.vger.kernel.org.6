Return-Path: <linux-kernel+bounces-336669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B165983F08
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAA4281BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42576146A93;
	Tue, 24 Sep 2024 07:24:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF09146018
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162651; cv=none; b=Ak7UquBUxM2UGcSJ9/Ga0rdY47eazqILQhfx3Mwv4tM+8Mh9zYY3IUnlOy5RZykJ7heCvAd8bhMteJxlZTzydMsX9VRCcf9I4MTZlWMFCMaiqjDSwMEsze7FJwJ+pdQlNhbQjAHhyJ4AhjFlPvSd+qWnOnFA2vU1OI+wQb9W/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162651; c=relaxed/simple;
	bh=n3BYJxFmdCaJjb89EWFP2KiVjBtBnlJM0X+29SDAUic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh1bLSG83EO18IRwfmPFSk89rmycNgud+IiP4ckWxtsvDcuUbHgGXM+dJcMu3iSysjFtCm+L+uKPWSKz9PMHVsHjqqai54yz7TopU+El7597YiU2/5RDY1KN/4vUqJMTtqI2lILWfcHUZYD6BjTf5ZaUrw1EN2wSUnZVsePSeP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1ssztn-0001MI-2l; Tue, 24 Sep 2024 09:23:51 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1ssztl-0018pW-SH; Tue, 24 Sep 2024 09:23:49 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ssztl-009MgR-2T;
	Tue, 24 Sep 2024 09:23:49 +0200
Date: Tue, 24 Sep 2024 09:23:49 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>, imx@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>,
	Herburger <gregor.herburger@ew.tq-group.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] arm64: dts: imx8mp-iota2: Enable the USB Type-C
 port
Message-ID: <20240924072349.a446hzxw2lfpg34i@pengutronix.de>
References: <20240923151417.1665431-1-michal.vokac@ysoft.com>
 <20240923151417.1665431-5-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240923151417.1665431-5-michal.vokac@ysoft.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-09-23, Michal Vokáč wrote:
> From: Petr Benes <petr.benes@ysoft.com>
> 
> Enable the USB Type-C port with the Diodes PI5USB30213A port controller.
> The port supports dual role data but can operate only in source power role
> and PD is not supported.
> 
> Signed-off-by: Petr Benes <petr.benes@ysoft.com>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> v3:
> - none
> v2:
> - Use typec instead of tcpc.
> - Drop unneeded status.
> 
>  .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> index 120e6b87a000..bfed410339a4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> @@ -32,6 +32,17 @@ button-reset {
>  		};
>  	};
>  
> +	reg_typec: regulator-typec {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;

Can you please put the enable-active-high and gpio property below the
regualtor-* properties?

> +		pinctrl-0 = <&pinctrl_usbc_vbus>;
> +		pinctrl-names = "default";
> +		regulator-max-microvolt = <5000000>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-name = "typec";
> +	};
> +
>  	reg_usb_host: regulator-usb-host {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
> @@ -218,6 +229,46 @@ &i2c2 {
>  	pinctrl-names = "default";
>  	status = "okay";
>  
> +	typec@d {
> +		compatible = "diodes,pi5usb30213a";
> +		reg = <0xd>;
> +		interrupts-extended = <&gpio1 5 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-0 = <&pinctrl_typec>;
> +		pinctrl-names = "default";
> +
> +		connector {
> +			compatible = "usb-c-connector";
> +			data-role = "dual";
> +			label = "USB-C";
> +			pd-disable;
> +			power-role = "source";
> +			self-powered;
> +			typec-power-opmode = "default";
> +			vbus-supply = <&reg_typec>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					usb_con_hs: endpoint {
> +						remote-endpoint = <&typec_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					usb_con_ss: endpoint {
> +						remote-endpoint = <&typec_ss>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	rtc: rtc@68 {
>  		compatible = "dallas,ds1341";
>  		reg = <0x68>;
> @@ -309,6 +360,12 @@ MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT	0x102
>  		>;
>  	};
>  
> +	pinctrl_typec: typecgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05	0x1c0
> +		>;
> +	};
> +
>  	pinctrl_uart2: uart2grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x0
> @@ -322,6 +379,11 @@ MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x0
>  		>;
>  	};
>  
> +	pinctrl_usbc_vbus: usbcgrp {
> +		fsl,pins = <MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x0
> +		>;
> +	};
> +
>  	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
> @@ -389,15 +451,47 @@ &uart2 {
>  	status = "okay";
>  };
>  
> +&usb3_0 {
> +	status = "okay";
> +};
> +
>  &usb3_1 {
>  	status = "okay";
>  };
>  
> +&usb3_phy0 {
> +	status = "okay";
> +};
> +
>  &usb3_phy1 {
>  	vbus-supply = <&reg_usb_host>;
>  	status = "okay";
>  };
>  
> +&usb_dwc3_0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	dr_mode = "otg";
> +	usb-role-switch;
> +	status = "okay";
> +

	ports {
		#address-cells = <1>;
		#size-cells = <0>;

> +	port@0 {
> +		reg = <0>;
> +
> +		typec_hs: endpoint {
> +			remote-endpoint = <&usb_con_hs>;
> +		};
> +	};
> +
> +	port@1 {
> +		reg = <1>;
> +
> +		typec_ss: endpoint {
> +			remote-endpoint = <&usb_con_ss>;
> +		};
> +	};

	}

	like you did for the connector node.

> +};
> +
>  &usb_dwc3_1 {
>  	dr_mode = "host";
>  	status = "okay";
> -- 
> 2.43.0
> 
> 
> 

