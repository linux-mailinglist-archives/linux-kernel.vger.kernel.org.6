Return-Path: <linux-kernel+bounces-398080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A639BE501
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A2C1F2297B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478741DE4EA;
	Wed,  6 Nov 2024 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="njCad7Y3"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9871DE3B6;
	Wed,  6 Nov 2024 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890684; cv=none; b=YN5wSqH8exGiHM2ra+w17HZVc3fFX7xvCLgVMyJn8Ji6mRqLyOdmra0hwbL8v75j8Cgxc/1kjUG7XOG6lngawjh0f+GQ3pWEwX4Wb16bQlNcNHcJH+hjOyvpqIPfe1nl1HUyIu7rvDcsudomoMu9saU9+yy2HenDoUuBqgM8T9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890684; c=relaxed/simple;
	bh=e6Qa3Ulj6l83lxocsflEdclLZ1pe49x2tIk2d4kgPJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWtmHtHMivzeyTvg2dzyHbRjANt8qVi4wi9mM45n3K4WHf12xJE6otlyg51r85AXm5cLkgVsqO99PIHRzGPcSORmj/DmjAtabuiELr7xaWqx28nkvgtSsHCq+7PWJk0GdrSN/PEXj6whY+JBF0rrrqTj4W6kBHMhXEJzkDD0DzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=njCad7Y3; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id DEF7888D51;
	Wed,  6 Nov 2024 11:57:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730890673;
	bh=yx3fExydmcmT9yZmFf9/JjXmYxkExZ7Nh9vR55dRRWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=njCad7Y3VQfhzPz+Xk7wH9tJTw2ufeps4VZAAIBg7Hxtc2o8r8Gb91UrW2doTkdZQ
	 BAIUuILZkUPD8IN+rgxh3jcz837+iFg2h6tYMO9BFTVO4o4ji9gPyB+tvHLthbgpRZ
	 iigxEEKlaV5aPfyqDqkq6Cw/HgflIDVZC7v5pgV73luqJqGjo9LirjIQZCtrkfjD06
	 CCrBBMG77y7RlsAGWtzH52PRZTYLY2WXyhzQaPP/wIgoSTgQfKD08+7jK+jpIuF9OA
	 UP2sdIWdwPvtsW46dJXRuXWhudEOy8262gFFRp61aETjtGtoVzVIPmGPT5nMRDzp66
	 Co+wj1yrY4Qvw==
Date: Wed, 6 Nov 2024 11:57:52 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stefan
 Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v10 4/4] ARM: dts: mxs: Add descriptions for imx287
 based btt3-[012] devices
Message-ID: <20241106115752.30397dbf@wsk>
In-Reply-To: <20241031094236.17ed927d@wsk>
References: <20241022133040.686562-1-lukma@denx.de>
	<20241022133040.686562-4-lukma@denx.de>
	<20241031094236.17ed927d@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Mp_EYMGMa9HOt=Gnb76CcRO";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/Mp_EYMGMa9HOt=Gnb76CcRO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Oct 2024 09:42:36 +0100
Lukasz Majewski <lukma@denx.de> wrote:

> Dear Community,
>=20
> > The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
> > some extend similar to already upstreamed XEA devices, hence are
> > using common imx28-lwe.dtsi file.
> >=20
> > New, imx28-btt3.dtsi has been added to embrace common DTS
> > properties for different HW revisions for this device.
> >=20
> > As a result - changes introduced in imx28-btt3-[012].dts are
> > minimal.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >=20
> > ---
> > Changes for v2:
> > - Rename dts file from btt3-[012] to imx28-btt3-[012] to match
> > current linux kernel naming convention
> > - Remove 'wlf,wm8974' from compatible for codec@1a
> >=20
> > Changes for v3:
> > - Keep alphabethical order for Makefile entries
> >=20
> > Changes for v4:
> > - Change compatible for btt3 board (to 'lwn,imx28-btt3')
> >=20
> > Changes for v5:
> > - Combine patch, which adds btt3-[012] with one adding board entry
> > to fsl.yaml
> >=20
> > Changes for v6:
> > - Make the patch series for adding entry in fsl.yaml and btt3
> >=20
> > Changes for v7:
> > - Use "panel" property as suggested by the community
> > - Use panel-timing to specify the display parameters
> > - Update subject line with correct tags
> >=20
> > Changes for v8:
> > - Use GPIO_ACTIVE_HIGH instead of '0'
> > - Add the comment regarding mac address specification
> > - Remove superfluous comment
> > - Change wifi-en-pin node name
> >=20
> > Changes for v9:
> > - Remove not used 'pm-ignore-notify'
> > - Add display names for 'panel-dpi' compatible to avoid Schema
> > warnings
> >=20
> > Changes for v10:
> > - Drop new line with panel-timing definitions
> > - Add new lines with 'sound' node
> > - Change 'codec' to 'audio-codec'
> > - Change order of properties for saif1 node =20
>=20
> Are there any more comments regarding this patch?

Gentle ping on this patch set.

>=20
> > ---
> >  arch/arm/boot/dts/nxp/mxs/Makefile         |   3 +
> >  arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts |  12 +
> >  arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts |   8 +
> >  arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts |  39 +++
> >  arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi  | 313
> > +++++++++++++++++++++ 5 files changed, 375 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
> >  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
> >  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
> >  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi
> >=20
> > diff --git a/arch/arm/boot/dts/nxp/mxs/Makefile
> > b/arch/arm/boot/dts/nxp/mxs/Makefile index
> > a430d04f9c69..96dd31ea19ba 100644 ---
> > a/arch/arm/boot/dts/nxp/mxs/Makefile +++
> > b/arch/arm/boot/dts/nxp/mxs/Makefile @@ -8,6 +8,9 @@
> > dtb-$(CONFIG_ARCH_MXS) +=3D \ imx28-apf28.dtb \
> >  	imx28-apf28dev.dtb \
> >  	imx28-apx4devkit.dtb \
> > +	imx28-btt3-0.dtb \
> > +	imx28-btt3-1.dtb \
> > +	imx28-btt3-2.dtb \
> >  	imx28-cfa10036.dtb \
> >  	imx28-cfa10037.dtb \
> >  	imx28-cfa10049.dtb \
> > diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
> > b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts new file mode 100644
> > index 000000000000..6ac46e4b21bb
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
> > @@ -0,0 +1,12 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright 2024
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx28-btt3.dtsi"
> > +
> > +&hog_pins_rev {
> > +	fsl,pull-up =3D <MXS_PULL_ENABLE>;
> > +};
> > diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
> > b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts new file mode 100644
> > index 000000000000..213fe931c58b
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
> > @@ -0,0 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright 2024
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx28-btt3.dtsi"
> > diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
> > b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts new file mode 100644
> > index 000000000000..4bccd784d065
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
> > @@ -0,0 +1,39 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright 2024
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx28-btt3.dtsi"
> > +
> > +/ {
> > +	panel {
> > +		compatible =3D "powertip,st7272", "panel-dpi";
> > +		power-supply =3D <&reg_3v3>;
> > +		width-mm =3D <70>;
> > +		height-mm =3D <52>;
> > +
> > +		panel-timing {
> > +			clock-frequency =3D <6500000>;
> > +			hactive =3D <320>;
> > +			vactive =3D <240>;
> > +			hfront-porch =3D <20>;
> > +			hback-porch =3D <68>;
> > +			hsync-len =3D <30>;
> > +			vfront-porch =3D <4>;
> > +			vback-porch =3D <14>;
> > +			vsync-len =3D <4>;
> > +			hsync-active =3D <0>;
> > +			vsync-active =3D <0>;
> > +			de-active =3D <1>;
> > +			pixelclk-active =3D <1>;
> > +		};
> > +
> > +		port {
> > +			panel_in: endpoint {
> > +				remote-endpoint =3D <&display_out>;
> > +			};
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi
> > b/arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi new file mode 100644
> > index 000000000000..2c52e67e5c14
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi
> > @@ -0,0 +1,313 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright 2024
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +/dts-v1/;
> > +#include "imx28-lwe.dtsi"
> > +
> > +/ {
> > +	model =3D "BTT3";
> > +
> > +	compatible =3D "lwn,imx28-btt3", "fsl,imx28";
> > +
> > +	chosen {
> > +	       bootargs =3D "root=3D/dev/mmcblk0p2 rootfstype=3Dext4 ro
> > rootwait console=3DttyAMA0,115200 panic=3D1 quiet";
> > +	};
> > +
> > +	memory@40000000 {
> > +		reg =3D <0x40000000 0x10000000>;
> > +		device_type =3D "memory";
> > +	};
> > +
> > +	panel {
> > +		compatible =3D "powertip,hx8238a", "panel-dpi";
> > +		power-supply =3D <&reg_3v3>;
> > +		width-mm =3D <70>;
> > +		height-mm =3D <52>;
> > +
> > +		panel-timing {
> > +			clock-frequency =3D <6500000>;
> > +			hactive =3D <320>;
> > +			vactive =3D <240>;
> > +			hfront-porch =3D <20>;
> > +			hback-porch =3D <38>;
> > +			hsync-len =3D <30>;
> > +			vfront-porch =3D <4>;
> > +			vback-porch =3D <14>;
> > +			vsync-len =3D <4>;
> > +			hsync-active =3D <0>;
> > +			vsync-active =3D <0>;
> > +			de-active =3D <0>;
> > +			pixelclk-active =3D <1>;
> > +		};
> > +
> > +		port {
> > +			panel_in: endpoint {
> > +				remote-endpoint =3D <&display_out>;
> > +			};
> > +		};
> > +	};
> > +
> > +	poweroff {
> > +		compatible =3D "gpio-poweroff";
> > +		gpios =3D <&gpio0 24 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > +	sound {
> > +		compatible =3D "simple-audio-card";
> > +		simple-audio-card,name =3D "BTTC Audio";
> > +		simple-audio-card,widgets =3D "Speaker", "BTTC
> > Speaker";
> > +		simple-audio-card,routing =3D "BTTC Speaker",
> > "SPKOUTN", "BTTC Speaker", "SPKOUTP"; +
> > +		simple-audio-card,dai-link@0 {
> > +			format =3D "left_j";
> > +			bitclock-master =3D <&dai0_master>;
> > +			frame-master =3D <&dai0_master>;
> > +			mclk-fs =3D <256>;
> > +
> > +			dai0_master: cpu {
> > +				sound-dai =3D <&saif0>;
> > +			};
> > +
> > +			codec {
> > +				sound-dai =3D <&wm89xx>;
> > +				clocks =3D <&saif0>;
> > +			};
> > +		};
> > +	};
> > +
> > +	wifi_pwrseq: sdio-pwrseq {
> > +		compatible =3D "mmc-pwrseq-simple";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&wifi_en_pin_bttc>;
> > +		reset-gpios =3D <&gpio0 27 GPIO_ACTIVE_LOW>;
> > +		/* W1-163 needs 60us for WL_EN to be low and */
> > +		/* 150ms after high before downloading FW is
> > possible */
> > +		post-power-on-delay-ms =3D <200>;
> > +		power-off-delay-us =3D <100>;
> > +	};
> > +};
> > +
> > +&auart0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&auart0_2pins_a>;
> > +	status =3D "okay";
> > +};
> > +
> > +&auart3 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&auart3_pins_a>;
> > +	uart-has-rtscts;
> > +	status =3D "okay";
> > +};
> > +
> > +&i2c0 {
> > +	wm89xx: audio-codec@1a {
> > +		compatible =3D "wlf,wm8940";
> > +		reg =3D <0x1a>;
> > +		#sound-dai-cells =3D <0>;
> > +	};
> > +};
> > +
> > +&lcdif {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&lcdif_24bit_pins_a>, <&lcdif_sync_pins_bttc>,
> > +		    <&lcdif_reset_pins_bttc>;
> > +	status =3D "okay";
> > +
> > +	port {
> > +		display_out: endpoint {
> > +			remote-endpoint =3D <&panel_in>;
> > +		};
> > +	};
> > +};
> > +
> > +&mac0 {
> > +	clocks =3D <&clks 57>, <&clks 57>, <&clks 64>;
> > +	clock-names =3D "ipg", "ahb", "enet_out";
> > +	phy-handle =3D <&mac0_phy>;
> > +	phy-mode =3D "rmii";
> > +	phy-supply =3D <&reg_3v3>;
> > +	/*
> > +	 * This MAC address is adjusted during production.
> > +	 * Value specified below is used as a fallback during
> > recovery.
> > +	 */
> > +	local-mac-address =3D [ 00 11 B8 00 BF 8A ];
> > +	status =3D "okay";
> > +
> > +	mdio {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		mac0_phy: ethernet-phy@0 {
> > +			/* LAN8720Ai - PHY ID */
> > +			compatible =3D
> > "ethernet-phy-id0007.c0f0","ethernet-phy-ieee802.3-c22";
> > +			reg =3D <0>;
> > +			smsc,disable-energy-detect;
> > +			max-speed =3D <100>;
> > +			reset-gpios =3D <&gpio4 12 GPIO_ACTIVE_LOW>;
> > +			reset-assert-us =3D <1000>;
> > +			reset-deassert-us =3D <1000>;
> > +		};
> > +	};
> > +};
> > +
> > +&pinctrl {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&hog_pins_a>, <&hog_pins_rev>;
> > +
> > +	hog_pins_a: hog@0 {
> > +		reg =3D <0>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_GPMI_RDY2__GPIO_0_22
> > +			MX28_PAD_GPMI_RDY3__GPIO_0_23
> > +			MX28_PAD_GPMI_RDN__GPIO_0_24
> > +			MX28_PAD_LCD_VSYNC__GPIO_1_28
> > +			MX28_PAD_SSP2_SS1__GPIO_2_20
> > +			MX28_PAD_SSP2_SS2__GPIO_2_21
> > +			MX28_PAD_AUART2_CTS__GPIO_3_10
> > +			MX28_PAD_AUART2_RTS__GPIO_3_11
> > +			MX28_PAD_GPMI_WRN__GPIO_0_25
> > +			MX28_PAD_ENET0_RXD2__GPIO_4_9
> > +			MX28_PAD_ENET0_TXD2__GPIO_4_11
> > +		>;
> > +		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> > +	};
> > +
> > +	hog_pins_rev: hog@1 {
> > +		reg =3D <1>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_ENET0_RXD3__GPIO_4_10
> > +			MX28_PAD_ENET0_TX_CLK__GPIO_4_5
> > +			MX28_PAD_ENET0_COL__GPIO_4_14
> > +			MX28_PAD_ENET0_CRS__GPIO_4_15
> > +		>;
> > +		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> > +	};
> > +
> > +	keypad_pins_bttc: keypad-bttc@0 {
> > +		reg =3D <0>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_GPMI_D00__GPIO_0_0
> > +			MX28_PAD_AUART0_CTS__GPIO_3_2
> > +			MX28_PAD_AUART0_RTS__GPIO_3_3
> > +			MX28_PAD_GPMI_D03__GPIO_0_3
> > +			MX28_PAD_GPMI_D04__GPIO_0_4
> > +			MX28_PAD_GPMI_D05__GPIO_0_5
> > +			MX28_PAD_GPMI_D06__GPIO_0_6
> > +			MX28_PAD_GPMI_D07__GPIO_0_7
> > +			MX28_PAD_GPMI_CE1N__GPIO_0_17
> > +			MX28_PAD_GPMI_CE2N__GPIO_0_18
> > +			MX28_PAD_GPMI_CE3N__GPIO_0_19
> > +			MX28_PAD_GPMI_RDY0__GPIO_0_20
> > +		>;
> > +		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> > +	};
> > +
> > +	lcdif_sync_pins_bttc: lcdif-bttc@0 {
> > +		reg =3D <0>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_LCD_DOTCLK__LCD_DOTCLK
> > +			MX28_PAD_LCD_ENABLE__LCD_ENABLE
> > +			MX28_PAD_LCD_HSYNC__LCD_HSYNC
> > +			MX28_PAD_LCD_RD_E__LCD_VSYNC
> > +		>;
> > +		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> > +	};
> > +
> > +	lcdif_reset_pins_bttc: lcdif-bttc@1 {
> > +		reg =3D <1>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_LCD_RESET__GPIO_3_30
> > +		>;
> > +		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_ENABLE>;
> > +	};
> > +
> > +	ssp1_sdio_pins_a: ssp1-sdio@0 {
> > +		reg =3D <0>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_SSP1_DATA0__SSP1_D0
> > +			MX28_PAD_GPMI_D01__SSP1_D1
> > +			MX28_PAD_GPMI_D02__SSP1_D2
> > +			MX28_PAD_SSP1_DATA3__SSP1_D3
> > +			MX28_PAD_SSP1_CMD__SSP1_CMD
> > +			MX28_PAD_SSP1_SCK__SSP1_SCK
> > +		>;
> > +		fsl,drive-strength =3D <MXS_DRIVE_8mA>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_ENABLE>;
> > +	};
> > +
> > +	wifi_en_pin_bttc: wifi-en-pin@0 {
> > +		reg =3D <0>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_GPMI_CLE__GPIO_0_27
> > +		>;
> > +		fsl,drive-strength =3D <MXS_DRIVE_8mA>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_ENABLE>;
> > +	};
> > +};
> > +
> > +&pwm {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pwm3_pins_a>;
> > +	status =3D "okay";
> > +};
> > +
> > +&reg_usb_5v {
> > +	gpio =3D <&gpio1 28 GPIO_ACTIVE_HIGH>;
> > +};
> > +
> > +&saif0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&saif0_pins_a>;
> > +	#sound-dai-cells =3D <0>;
> > +	assigned-clocks =3D <&clks 53>;
> > +	assigned-clock-rates =3D <12000000>;
> > +	status =3D "okay";
> > +};
> > +
> > +&saif1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&saif1_pins_a>;
> > +	#sound-dai-cells =3D <0>;
> > +	fsl,saif-master =3D <&saif0>;
> > +	status =3D "okay";
> > +};
> > +
> > +&ssp1 {
> > +	compatible =3D "fsl,imx28-mmc";
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&ssp1_sdio_pins_a>;
> > +	bus-width =3D <4>;
> > +	no-1-8-v;       /* force 3.3V VIO */
> > +	non-removable;
> > +	vmmc-supply =3D <&reg_3v3>;
> > +	mmc-pwrseq =3D <&wifi_pwrseq>;
> > +	keep-power-in-suspend;
> > +	status =3D "okay";
> > +
> > +	wlan@1 {
> > +		reg =3D <1>;
> > +		compatible =3D "brcm,bcm4329-fmac";
> > +	};
> > +};
> > +
> > +&ssp2 {
> > +	compatible =3D "fsl,imx28-spi";
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&spi2_pins_a>;
> > +	status =3D "okay";
> > +}; =20
>=20
>=20
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Mp_EYMGMa9HOt=Gnb76CcRO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmcrS7AACgkQAR8vZIA0
zr14rQf/dD3WRBSoiwWfKeRXkbn/TmLno40Ap/VssmgVFyKSWe7cueAEwYjj0nHm
FCDEtFnwA2i+S67w4FH2cBeZP5IhXV8Ea4TZtYUtQ3KN+kKMqCHH8Fup3N13yM/0
IzAtTNU4M2+3I1Zz27+7v5cbvEWIayWoJ1ByxCvktNhq6KdN4UG79L0pAfklbalW
IOqTtLtFwiS948spXY66IPV3UYvKweOSLEMILNpruHUdxHq2BIGPrDvCjLWDDLtq
fznY/y9L/yJPSvFmAaSobniKZbklJyacgrh4NqYAB9dw22e7dOCC9rkvV+w3zLaG
4k9SB5uZAdCfAnhjeVsTZulVdNXLBQ==
=8iA4
-----END PGP SIGNATURE-----

--Sig_/Mp_EYMGMa9HOt=Gnb76CcRO--

