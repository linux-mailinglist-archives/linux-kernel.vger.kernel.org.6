Return-Path: <linux-kernel+bounces-260980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C1E93B134
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B431F24A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88519158DCD;
	Wed, 24 Jul 2024 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LbRm5Ub5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="QYP9aik+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21296158DC5;
	Wed, 24 Jul 2024 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825963; cv=none; b=g2wQiCPtuRBRNtHEHmaxsTuteqHBnsjPpg1WMlMJIbWKXtwvqBMSrOCZX0u6FzqdRW7QuBmCazy7LUfDLdwr/Nc60hOsTVoei/fqCB1CBYd/3rwv3kXQKYzwHKxC/v2nuaNaL1xO7gMRpRpcm2ZjTULxFPTsa9FBxozl/TOOyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825963; c=relaxed/simple;
	bh=vMEbUm5son8b/yMnJehMuOwAUgd5F+xlVY7jaCom2tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DoCpJDbdfXyPeZfkSjSeWo1ckZjHpJiY/pkfliF74t8dImOiTOAo7UJLYveaKrf61zE9EVQRSUNdsnoqIuRSwbQhQrgSrufTjO3ALk3u3oW6QOfYEg3ZDR7nMc2oT/pyv6B55yRuQmfOm47mlzaisqcvwDbdjokEG/Uwhmb9Kaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=LbRm5Ub5; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=QYP9aik+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825961; x=1753361961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2B4DC1tsLJTrSdQrtO6CfWTr0Ph1/cVhkWOkvqs0bZo=;
  b=LbRm5Ub5X3zEPLGZsX9yYRqwziWUsy9gYvgER1UzWFK0HQTYiSHsPfMW
   wYDo3UFeWs5Gg04wwiFa2ePmlYplEtN4U+9akn/J/kaFm3KU2c1ZPhSTK
   SEIb3PwSs5M2GCWLxgSF8bqTcWNDJmWVz4xl6azXHwW9mmu9eG0Ee2F9I
   eXM2w9kZzmdbpBsl4ois2VoVjrwy2YeNu8nd99EvFZJoyFZTT99nrkrly
   eXf6gQon4HTSnHdS/URovATMVVPXjnfDzIck3QXKhOtj3Xtbqjmw5HGfw
   ColmyfZSYg0vFOJX30R/qSxqD312JjX2Pa0yvX0L8oaxhQqr1ApvIEZi0
   A==;
X-CSE-ConnectionGUID: 0V/QZIuHRrysLrDzyN6Crg==
X-CSE-MsgGUID: k77nmjrETxeAif5g0E09Bw==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058825"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:16 +0200
X-CheckPoint: {66A0FAA4-12-E6D9A9-F72EA055}
X-MAIL-CPID: 4210538D93A811F857648E3E2556405C_4
X-Control-Analysis: str=0001.0A782F26.66A0FAA4.0161,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B30616380A;
	Wed, 24 Jul 2024 14:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825954; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=2B4DC1tsLJTrSdQrtO6CfWTr0Ph1/cVhkWOkvqs0bZo=;
	b=QYP9aik+OjFbFan2DJivviD41CQuqm0nWxsCcC+MtS7oF/2+aFLVilw5CSBiER32iTvUbx
	ThnFmm8FU61qIJPmywk5cFdszdk6MKubHbIKauyCnBX/nVFcFEad3FNYJwcwjS2+eQZD8J
	jer3UqU10A0ePdM1QJxTgAsx2CwdUtLbjmCzCe8gC4ARSQjLLCcTetC7J/mSw9WwUlevcq
	BPzPwBCsdNPumQUfTDP6U0qxHx5nqH17YsZCYrlojgrOnUF1mMuKv1lhbwsQVcw2xReDbE
	WHCCUFm5t+TfWkuEfw1p80NwNbEzgUz8LRG7HZhyfjt3URcNIfblplGm4YHfyg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] arm64: dts: freescale: imx93-tqma9352: Add PMIC node
Date: Wed, 24 Jul 2024 14:58:50 +0200
Message-Id: <20240724125901.1391698-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

With driver support in place add the PMIC node and remove the
fixed-regulators for rails provided by PMIC.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../boot/dts/freescale/imx93-tqma9352.dtsi    | 113 ++++++++++++++----
 1 file changed, 92 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
index d07eca6526db..ddb4f452ba2d 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -25,20 +25,6 @@ linux,cma {
 		};
 	};
 
-	reg_v1v8: regulator-v1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "V_1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	reg_v3v3: regulator-v3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "V_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
 	/* SD2 RST# via PMIC SW_EN */
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
@@ -47,14 +33,14 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		regulator-name = "VSD_3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		vin-supply = <&reg_v3v3>;
+		vin-supply = <&buck4>;
 		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 };
 
 &adc1 {
-	vref-supply = <&reg_v1v8>;
+	vref-supply = <&buck5>;
 };
 
 &flexspi1 {
@@ -105,6 +91,91 @@ se97_som: temperature-sensor@1b {
 		reg = <0x1b>;
 	};
 
+	pca9451a: pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pca9451>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			/* V_0V8_SOC - hw developer guide: 0.75 .. 0.9 */
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			/* V_DDRQ - 1.1 LPDDR4 or 0.6 LPDDR4X */
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			/* V_3V3 - EEPROM, RTC, ... */
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_1V8 - SPI NOR, eMMC, RAM VDD1... */
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_1V1 - RAM VDD2*/
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_1V8_BBSM, fix 1.8 */
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_0V8_ANA */
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_SD2 - 3.3/1.8V USDHC2 io Voltage */
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
 	pcf85063: rtc@51 {
 		compatible = "nxp,pcf85063a";
 		reg = <0x51>;
@@ -116,28 +187,28 @@ eeprom0: eeprom@53 {
 		reg = <0x53>;
 		pagesize = <16>;
 		read-only;
-		vcc-supply = <&reg_v3v3>;
+		vcc-supply = <&buck4>;
 	};
 
 	eeprom1: eeprom@57 {
 		compatible = "atmel,24c64";
 		reg = <0x57>;
 		pagesize = <32>;
-		vcc-supply = <&reg_v3v3>;
+		vcc-supply = <&buck4>;
 	};
 
 	/* protectable identification memory (part of M24C64-D @57) */
 	eeprom@5f {
 		compatible = "atmel,24c64d-wl";
 		reg = <0x5f>;
-		vcc-supply = <&reg_v3v3>;
+		vcc-supply = <&buck4>;
 	};
 
 	imu@6a {
 		compatible = "st,ism330dhcx";
 		reg = <0x6a>;
-		vdd-supply = <&reg_v3v3>;
-		vddio-supply = <&reg_v3v3>;
+		vdd-supply = <&buck4>;
+		vddio-supply = <&buck4>;
 	};
 };
 
-- 
2.34.1


