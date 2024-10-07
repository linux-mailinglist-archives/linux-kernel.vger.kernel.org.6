Return-Path: <linux-kernel+bounces-353406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FB8992D5C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3F01C22A07
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09781D6191;
	Mon,  7 Oct 2024 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhcvY+M8"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2841D5AB0;
	Mon,  7 Oct 2024 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307889; cv=none; b=LmHV7/rtwTQ/9mmYg7y0rEEXdnGs9i2pUBri1gcHAhP8fAAPpdzSxhh5ysaqjDt0bs84XmxYNfh9Fam0/50l8s5vUw7HMT/xNhk9VwN/Dn327Udm0q6uAAnpjKIMsqEok2HMUkwFpUp95m3Dd8p95bGr/Q2L6EKTd7CmrBVOvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307889; c=relaxed/simple;
	bh=HCanv8MZxMpQEBSUquYlSfIaSYuC0taVYgBy0mOb0BY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hAwPoSxdO90kPILtDCcyB+AoWGLNOCqYHCArF60p2+QXbRu7fuYHnbt/pNzIu3yJu1EOMOCj4ZwXBwcX91EEPnWPSDlkQNEj7Ze5D8kjyMHJ+9ZdaQK0+SRXX5YHugQSkrFzHNYa67d0Yo0XVbmxKeIIicViNIIkMjt97C0rqaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhcvY+M8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c88367684bso896841a12.0;
        Mon, 07 Oct 2024 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728307886; x=1728912686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxRwnVlkoapQXGCM67CkaCMcGQmD4T9hS0Kt5niFMDM=;
        b=WhcvY+M8qqjSqeO02GqE8dN0Qzvek3Zv33EkXKImOyiS4RhfHUgfQb3i9WMLgcPT0E
         B++AJ8y2WsEdACEHO/XthDECwImxAXaVUXA2+iNv5dPEEVzPfatfglNI/9KbUuOIfOwM
         GKNRODjIOZHjpSYRwEZ9A52+XxNlJZoMjKMFTTC9bUGIopxrUKDQXf4DMrQAPEo51nPH
         tYXxCdJfMB5LbEe4hcjfnNorYXS9QqZQnHxQeIDOax5MRSttaCOn2nkk6ljFjI1NU+oK
         /iLo3T1wXsMpUtqav57Mzh1QwGW75lEsZvOUkTTz9NUr6yXlac6l+MFOOyIzK2jRbWNc
         a0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307886; x=1728912686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxRwnVlkoapQXGCM67CkaCMcGQmD4T9hS0Kt5niFMDM=;
        b=kZshKwQVtoEIwh1uLuKovcMNkBLBz7zugKlMCSsg+3XFnhzk3E9hr4TOtbV3mjn4HB
         3NFFpdjYgaqMtpkXm8iwcmGow6U317eWSfZyhQyBuXd5UTC2wgoC8Oc1K2DiFysPSZ1u
         /jLomKfgSbChjw3Tk/lw8VNAsDWiTCa8Vzi/Guo4g0qRMOkBKSxV1MF+Mt0+8r79XJgM
         gQEQpprOsE7LAdR8WdIZBpaHdPPsISiqFcaAVM/DzUGMJ0gJduXOVZjG599vkTJPu8YR
         VARRJ1pcFBG0fpCQgfzef7S9/Q3mGBq4ZwwmTgQIt0LogotuVHZFv5OnbtbDXlYb6Yr9
         D/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzd8b3kXRiUeO8uellGBlprxe74nZ051OKQXU+sMeH2GQ0yzCBJSeC6K6vrFJVTwKw+r8mkTKYR36i@vger.kernel.org, AJvYcCWBSwyPPi3bu+LjO8BPAhkNqNq3VIhNUsxfex+WNs9JxHC59tM7QH/DiVZIV5Ak9EQnT814weJzHCNjmsJY@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVGa7L25LEZPR8Fk6gEp4k+pMosrR/dbj2LM485hLy6zLIb2T
	X8FuTT4yII0d1ArferVofuCwUyvymoaCZXlGefJ31O/ZretxC6oS
X-Google-Smtp-Source: AGHT+IGz//Vg4XoR0PdmMVCoVC/0KYE77LoHIgOnkn3B2gnSfOEOTk8IWcRGPI9bBEonxFGRZ8v6/Q==
X-Received: by 2002:a05:6402:40c5:b0:5c8:8381:c2a0 with SMTP id 4fb4d7f45d1cf-5c8d2cfe1d1mr4037847a12.2.1728307885662;
        Mon, 07 Oct 2024 06:31:25 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb34csm3193089a12.59.2024.10.07.06.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:31:25 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] ARM: dts: socfpga: update Enclustra Mercury+ AA1
Date: Mon,  7 Oct 2024 13:31:13 +0000
Message-Id: <20241007133115.1482619-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007133115.1482619-1-l.rubusch@gmail.com>
References: <20241007133115.1482619-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for Enclustra's Mercury+ AA1 SoM, based on Intel
Arria10. This is a flexible approach to allow for combining SoM
with carrier board .dtsi and boot-mode .dtsi in a device-tree file.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../devicetree/bindings/arm/altera.yaml       |   3 +
 .../socfpga/socfpga_arria10_mercury_aa1.dtsi  | 141 +++++++++++++++---
 2 files changed, 123 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 31af6859d..51f10ff8e 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -32,6 +32,9 @@ properties:
         items:
           - enum:
               - enclustra,mercury-pe1
+              - enclustra,mercury-aa1-pe1
+              - enclustra,mercury-aa1-pe3
+              - enclustra,mercury-aa1-st1
               - google,chameleon-v3
           - const: enclustra,mercury-aa1
           - const: altr,socfpga-arria10
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi
index 41f865c8c..cdd693cf9 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi
@@ -7,12 +7,14 @@
 
 / {
 
-	model = "Enclustra Mercury AA1";
-	compatible = "enclustra,mercury-aa1", "altr,socfpga-arria10", "altr,socfpga";
+	model = "Enclustra Mercury+ AA1";
+	compatible = "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
 
 	aliases {
 		ethernet0 = &gmac0;
 		serial1 = &uart1;
+		spi0 = &qspi;
 	};
 
 	memory@0 {
@@ -24,52 +26,102 @@ memory@0 {
 	chosen {
 		stdout-path = "serial1:115200n8";
 	};
+
+	/* Adjusted the i2c labels to use generic base-board dtsi files for
+	 * Enclustra Arria10 and Cyclone5 SoMs.
+	 *
+	 * The set of i2c0 and i2c1 labels defined in socfpga_cyclone5.dtsi and in
+	 * socfpga_arria10.dtsi do not allow for using the same base-board .dtsi
+	 * fragments. Thus define generic labels here to match the correct i2c
+	 * bus in a generic base-board .dtsi file.
+	 */
+	soc {
+		i2c_encl: i2c@ffc02300 {
+		};
+		i2c_encl_fpga: i2c@ffc02200 {
+		};
+	};
+};
+
+&i2c_encl {
+	status = "okay";
+	i2c-sda-hold-time-ns = <300>;
+	clock-frequency = <100000>;
+
+	atsha204a: atsha204a@64 {
+		compatible = "atmel,atsha204a";
+		reg = <0x64>;
+	};
+
+	isl12022: isl12022@6f {
+		compatible = "isil,isl12022";
+		reg = <0x6f>;
+	};
+};
+
+&i2c_encl_fpga {
+	i2c-sda-hold-time-ns = <300>;
+	status = "disabled";
 };
 
 &gmac0 {
+	status = "okay";
 	phy-mode = "rgmii";
 	phy-addr = <0xffffffff>; /* probe for phy addr */
-
 	max-frame-size = <3800>;
-
 	phy-handle = <&phy3>;
 
+	/delete-property/ mac-address;
+
 	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "snps,dwmac-mdio";
 		phy3: ethernet-phy@3 {
-			txd0-skew-ps = <0>; /* -420ps */
-			txd1-skew-ps = <0>; /* -420ps */
-			txd2-skew-ps = <0>; /* -420ps */
-			txd3-skew-ps = <0>; /* -420ps */
+			reg = <3>;
+
+			/* Add 2ns RX clock delay (1.2ns + 0.78ns)*/
+			rxc-skew-ps = <1680>; /* 780ps */
 			rxd0-skew-ps = <420>; /* 0ps */
 			rxd1-skew-ps = <420>; /* 0ps */
 			rxd2-skew-ps = <420>; /* 0ps */
 			rxd3-skew-ps = <420>; /* 0ps */
-			txen-skew-ps = <0>; /* -420ps */
-			txc-skew-ps = <1860>; /* 960ps */
 			rxdv-skew-ps = <420>; /* 0ps */
-			rxc-skew-ps = <1680>; /* 780ps */
-			reg = <3>;
+
+			/* Add 1.38ns TX clock delay (0.96ns + 0.42ns)*/
+			txc-skew-ps = <1860>; /* 960ps */
+			txd0-skew-ps = <0>; /* -420ps */
+			txd1-skew-ps = <0>; /* -420ps */
+			txd2-skew-ps = <0>; /* -420ps */
+			txd3-skew-ps = <0>; /* -420ps */
+			txen-skew-ps = <0>; /* -420ps */
 		};
 	};
 };
 
-&i2c1 {
-	atsha204a: crypto@64 {
-		compatible = "atmel,atsha204a";
-		reg = <0x64>;
-	};
+&gpio0 {
+	status = "okay";
+};
 
-	isl12022: isl12022@6f {
-		compatible = "isil,isl12022";
-		reg = <0x6f>;
-	};
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "disabled";
+};
+
+&uart1 {
+	status = "okay";
 };
 
 /* Following mappings are taken from arria10 socdk dts */
 &mmc {
+	status = "okay";
 	cap-sd-highspeed;
 	broken-cd;
 	bus-width = <4>;
@@ -79,3 +131,50 @@ &mmc {
 &osc1 {
 	clock-frequency = <33330000>;
 };
+
+&eccmgr {
+	sdmmca-ecc@ff8c2c00 {
+		compatible = "altr,socfpga-sdmmc-ecc";
+		reg = <0xff8c2c00 0x400>;
+		altr,ecc-parent = <&mmc>;
+		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
+					 <47 IRQ_TYPE_LEVEL_HIGH>,
+					 <16 IRQ_TYPE_LEVEL_HIGH>,
+					 <48 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+&qspi {
+	status = "okay";
+	flash0: s25fl512s@0 {
+		u-boot,dm-pre-reloc;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
+		reg = <0>;
+
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		spi-max-frequency = <10000000>;
+
+		cdns,read-delay = <4>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partition@raw {
+			label = "Flash Raw";
+			reg = <0x0 0x4000000>;
+		};
+	};
+};
+
+&watchdog1 {
+	status = "disabled";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.25.1


