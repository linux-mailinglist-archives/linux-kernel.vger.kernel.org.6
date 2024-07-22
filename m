Return-Path: <linux-kernel+bounces-259148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAF79391E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B22B20A29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1567516E866;
	Mon, 22 Jul 2024 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="sbOFBQld"
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C4C16CD18
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662538; cv=none; b=PNdYBwel9QP5zq0hF8GK9t/KnW0qY0wQz9hiLxiXzps2qBIPlN7DevXqEQR7LSrDCfmXEl2t10iFO8pVT37e4YSCC7R8T8YdSiPG3HxTPFC39C1EiZ8s6yKz2EH2q5k0leaDULppE3ZNsG7ZvqZhnNyZeHO8rQmyNGaqI5d5km4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662538; c=relaxed/simple;
	bh=ZvmMJsi7/0j/Eug0hsxM0bqNXAFKd1dulnvisEzuk1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnxuSXCqCEpBXgEHwHfT7jdAZrxRcwhi3qrMEa6kH8pUsHabuTjbn3Twj+bF9azyzyNc+VxBmMV4JBhCULxp76wBT1ffLblRrmr7hhhySgBgx0tyWrhAhb6RNifyM48d37V3QL4kfRzGn5hOMIh0lnJxEV3XYlsEyWEpSE6pmfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=sbOFBQld; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=DYSuYaCFD13mGHCGz9PXMjOqCUAg12sP5ookpTOeOuM=; b=sbOFBQld3gv3iw9VLeDkPipdIK
	0miF+9941OSJ4DhXmhpRYts8URmQufis8e03Vk/TvS8GZb7rmpXqtxI3AnxSJHLNMc8bnL1T6tpUM
	bJqSgcFCZQPhKYGP+WXbpBVgLoXy5nRNNe5YVstnGDaCVSn16rAZAatBfCDMoOk7p01rJDqcZ7ePP
	oxC/h8sQ9XqKgoiBF/qVw1MmMA16lRmINhYmX3188bgY0TVTMag9rv4YKlPxfjD6ktRcc65g3gYMo
	H7gMY2hpa8qxoSXCEMyneCQoH0M2uOSTvRQIMphvznHJgKLX7CG4Q0xqJoGQkh9Xq4ZnZESmHu2xo
	5pdg/DkA==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1sVupp-007aIp-SP; Mon, 22 Jul 2024 15:20:21 +0000
Date: Mon, 22 Jul 2024 17:20:21 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Expand available features on Qnap TS433
Message-ID: <jw36q3qecml2y3cidr5bsgn34hyf76u3armmyv775kqhlhuj6w@gtaz64ejfkec>
References: <20240721173723.919961-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jfmvdxd4invvayor"
Content-Disposition: inline
In-Reply-To: <20240721173723.919961-1-heiko@sntech.de>


--jfmvdxd4invvayor
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Heiko,

On Sun, Jul 21, 2024 at 07:37:09PM +0200, Heiko Stuebner wrote:
> Thanks to the nicely supported rk3568, the hardest part for adding things,
> is to pull things from the vendor-kernel and translating them to mainline
> standards.
>=20
> This series allows the TS433 to use all 4 bays [0], wiggle some LEDs and
> access devices connected to all 3 usb ports.
>=20
> The device runs stable now and might be usable for actual usage.
>=20
> There is still a todo-list though:
> - the ethernet mac address for the realtek chip seems correct,
>   but the gmac0 interface currently uses a wrong one
> - i2cdetect reports devices on i2c-1 on addresses 54,55,56,57
>   model_Q0B20_Q0B30_10_10.conf from the original rescue image labels them
>     VPD_MB =3D I2C:0x54, VPD_BP =3D I2C:0x56
>   the meaning currently being unknown. Some eeprom maybe?
> - The regulator tree is slightly dubious. Everthing seems to follow rk3568
>   reference designs, but especially the regulator labeled vcc3v3_sd
>   seems to supply some PCIe functionality. So I guess the device's
>   schematics will look quite different than the regulators added to the
>   vendor devicetree.
> - Quite a bit of functionality is provided by the MCU connected to uart0.
>   According to the model.conf there should be fan-control, a number of
>   additional LEDs (status,locate,usb?)

Tested-by: Uwe Kleine-K=F6nig <ukleinek@debian.org>

I have a few suggested changes, instead of describing them in prose in
reply to the individual patches here comes a diff. Feel free to ignore,
in that case I'll care about those when your series landed. It's mostly
about comments and dropping unused labels.

Note I didn't test the rtc change, as I sticked to the Debian kernel and
didn't compile a new one, yet.

Best regards
Uwe

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm6=
4/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 4213c351faf5..ae6c10c15ca7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -20,7 +20,7 @@ aliases {
 		mmc0 =3D &sdhci;
 	};
=20
-	chosen: chosen {
+	chosen {
 		stdout-path =3D "serial2:115200n8";
 	};
=20
@@ -45,7 +45,7 @@ key-reset {
 	leds {
 		compatible =3D "gpio-leds";
=20
-		led_hdd1: led-0 {
+		led-0 {
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DISK;
 			gpios =3D <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
@@ -54,7 +54,7 @@ led_hdd1: led-0 {
 			pinctrl-0 =3D <&hdd1_led_pin>;
 		};
=20
-		led_hdd2: led-1 {
+		led-1 {
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DISK;
 			gpios =3D <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>;
@@ -63,7 +63,7 @@ led_hdd2: led-1 {
 			pinctrl-0 =3D <&hdd2_led_pin>;
 		};
=20
-		led_hdd3: led-2 {
+		led-2 {
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DISK;
 			gpios =3D <&gpio1 RK_PD7 GPIO_ACTIVE_LOW>;
@@ -72,7 +72,7 @@ led_hdd3: led-2 {
 			pinctrl-0 =3D <&hdd3_led_pin>;
 		};
=20
-		led_hdd4: led-3 {
+		led-3 {
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DISK;
 			gpios =3D <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
@@ -191,6 +191,7 @@ &cpu3 {
 	cpu-supply =3D <&vdd_cpu>;
 };
=20
+/* lower ethernet jack on the back side */
 &gmac0 {
 	assigned-clocks =3D <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
 	assigned-clock-parents =3D <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_=
2TOP>;
@@ -217,7 +218,7 @@ &gpu {
 &i2c0 {
 	status =3D "okay";
=20
-	rk809: pmic@20 {
+	pmic@20 {
 		compatible =3D "rockchip,rk809";
 		reg =3D <0x20>;
 		interrupt-parent =3D <&gpio0>;
@@ -238,7 +239,7 @@ rk809: pmic@20 {
 		wakeup-source;
=20
 		regulators {
-			vdd_logic: DCDC_REG1 {
+			DCDC_REG1 {
 				regulator-name =3D "vdd_logic";
 				regulator-always-on;
 				regulator-boot-on;
@@ -265,7 +266,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vcc_ddr: DCDC_REG3 {
+			DCDC_REG3 {
 				regulator-name =3D "vcc_ddr";
 				regulator-always-on;
 				regulator-boot-on;
@@ -276,7 +277,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vdd_npu: DCDC_REG4 {
+			DCDC_REG4 {
 				regulator-name =3D "vdd_npu";
 				regulator-initial-mode =3D <0x2>;
 				regulator-min-microvolt =3D <500000>;
@@ -300,7 +301,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vdda0v9_image: LDO_REG1 {
+			LDO_REG1 {
 				regulator-name =3D "vdda0v9_image";
 				regulator-always-on;
 				regulator-min-microvolt =3D <900000>;
@@ -311,7 +312,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vdda_0v9: LDO_REG2 {
+			LDO_REG2 {
 				regulator-name =3D "vdda_0v9";
 				regulator-always-on;
 				regulator-boot-on;
@@ -323,7 +324,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vdda0v9_pmu: LDO_REG3 {
+			LDO_REG3 {
 				regulator-name =3D "vdda0v9_pmu";
 				regulator-always-on;
 				regulator-boot-on;
@@ -336,7 +337,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vccio_acodec: LDO_REG4 {
+			LDO_REG4 {
 				regulator-name =3D "vccio_acodec";
 				regulator-always-on;
 				regulator-boot-on;
@@ -348,7 +349,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vccio_sd: LDO_REG5 {
+			LDO_REG5 {
 				regulator-name =3D "vccio_sd";
 				regulator-min-microvolt =3D <1800000>;
 				regulator-max-microvolt =3D <3300000>;
@@ -358,7 +359,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vcc3v3_pmu: LDO_REG6 {
+			LDO_REG6 {
 				regulator-name =3D "vcc3v3_pmu";
 				regulator-always-on;
 				regulator-boot-on;
@@ -371,7 +372,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vcca_1v8: LDO_REG7 {
+			LDO_REG7 {
 				regulator-name =3D "vcca_1v8";
 				regulator-always-on;
 				regulator-boot-on;
@@ -383,7 +384,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vcca1v8_pmu: LDO_REG8 {
+			LDO_REG8 {
 				regulator-name =3D "vcca1v8_pmu";
 				regulator-always-on;
 				regulator-boot-on;
@@ -396,7 +397,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vcca1v8_image: LDO_REG9 {
+			LDO_REG9 {
 				regulator-name =3D "vcca1v8_image";
 				regulator-always-on;
 				regulator-min-microvolt =3D <1800000>;
@@ -407,7 +408,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vcc_3v3: SWITCH_REG1 {
+			SWITCH_REG1 {
 				regulator-name =3D "vcc_3v3";
 				regulator-always-on;
 				regulator-boot-on;
@@ -417,7 +418,7 @@ regulator-state-mem {
 				};
 			};
=20
-			vcc3v3_sd: SWITCH_REG2 {
+			SWITCH_REG2 {
 				regulator-name =3D "vcc3v3_sd";
 				/*
 				 * turning this off, breaks access to both
@@ -431,6 +432,15 @@ regulator-state-mem {
 				};
 			};
 		};
+
+		rtc {
+			/*
+			 * There is already a dedicated and battery buffered
+			 * RTCon &i2c1, so disable the pmic internal one.
+			 */
+			compatible =3D "rockchip,rk808-rtc";
+			status =3D "disabled";
+		};
 	};
=20
 	vdd_cpu: regulator@40 {
@@ -469,12 +479,14 @@ &pcie30phy {
 	status =3D "okay";
 };
=20
+/* connects a JMicron AHCI SATA controller */
 &pcie3x1 {
 	reset-gpios =3D <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply =3D <&vcc3v3_pcie>;
 	status =3D "okay";
 };
=20
+/* connects to the 2.5G network hardware for the upper network jack */
 &pcie3x2 {
 	num-lanes =3D <1>;
 	reset-gpios =3D <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
@@ -554,6 +566,11 @@ &tsadc {
 	status =3D "okay";
 };
=20
+/*
+ * Connected to an MCU, e.g.
+ *   stty -F /dev/ttyS0 115200; echo @C30 > /dev/ttyS0
+ * makes the machine beep.
+ */
 &uart0 {
 	status =3D "okay";
 };
diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index 5eda3c0dbbdf..db2b322ddba3 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -88,6 +88,7 @@ static const struct mfd_cell rk808s[] =3D {
 		.name =3D "rk808-rtc",
 		.num_resources =3D ARRAY_SIZE(rtc_resources),
 		.resources =3D rtc_resources,
+		.of_compatible =3D "rockchip,rk808-rtc",
 	},
 };
=20

--jfmvdxd4invvayor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaeeLEACgkQj4D7WH0S
/k67kAgAksg9K8lFBt8CRZ5PkIVQr1H1zrR7fLDFt4mT0lcf6YiNxN/dbDxejE5M
YeNASjDupqodQ1CATmQoJlb8xdbAIo8bNkKe5r2Mwvi0dKew1v92rC0ZQnBNHcH1
vfka/liNEGU1qlIeVt8369caQmEa9pbmqnGA8H4NBquKyXtK6rKCmKxnszk93H1X
peZzdXv0vdy4fuDXXYR5EBlWI4/i3qvcQRh8ZfA6t9Q4KxP00/n+tz731U5RFkR0
fWBUH3rpPmcdHqaeY5UelwVDVGxBTtNVLCPKmQ7vpzc/94RRbDe6X0wf0puws0o9
4LNJW65fYWTAMwX6DA13q+iWjheBUQ==
=Fvme
-----END PGP SIGNATURE-----

--jfmvdxd4invvayor--

