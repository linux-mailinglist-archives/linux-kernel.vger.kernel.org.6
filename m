Return-Path: <linux-kernel+bounces-373407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BA39A5658
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E031C21043
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318FB19D8A8;
	Sun, 20 Oct 2024 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv3hKvUh"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503DD19CC2D;
	Sun, 20 Oct 2024 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453257; cv=none; b=dygi//tIfs8b66QhqKiKg8cHKTMeFGNIpPSwo8fjiG2pAx4JsoOepVvd08pn2yyTT/njlan/rnpyT37+BxsDAAX0OhhmhjMaFYYp1W0RK9LGscuzV0CSPH+QeJ/w+2STf6uaKjs3Nz9EALox0rFb3+Pja5SNTsPlNa5JUuYcsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453257; c=relaxed/simple;
	bh=5TZIB2542Vc0yIo0WvDWBjKa33kV6CuS60FxkuJ5KV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cYJIbeoVU7NJqPCnQfMQNZEFdQ1cfszE8fKdMt/gzwFP1BRHd1mm5sBPwMy9EAVUHDnr6vOS3AcBRC+CrMTZ5LGedX+i3kojhccCG4yLHjqdufkJOLkItMYL5kog/WeKaHuPeJK6UKtvmk923hSu/HAjrBF6notRVbhBTt1jO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv3hKvUh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9589ba577so519582a12.1;
        Sun, 20 Oct 2024 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453253; x=1730058053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMcrhXfFwBDQeC8deO1th93gr8djMeKIrCWvtsHZ+18=;
        b=Lv3hKvUhxAAPP9tHeLP3C5E7BF2CF2pJc5BJxiiwb7L4ahBWaJGUsw6a4qX9RwMpnp
         Fhm8lOUrVOXV9bNq+3COnJFP4Mwc4AHpKitwzp7vnnZhadotYQbgq+xpJn7DV99GY+OQ
         RJ+MR/x3nSMLGlKb2L9yNw0e6hKNGD6wn3GWTr9cKYcPbdIDERD/XMvdacCBT83NwW5h
         D7tZNrg9snMbGW3BcM9TW9dr7/Zx4vPQt17e13KxMoQCbMHsMOhWNnHIex1IfYRTlxFM
         dLl4H4LkEU7oGcu55Dlhiz725V+NjMKzjGk87icRFfr/IgPaJh9YpN/0rE7pcd1v03iO
         SOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453253; x=1730058053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMcrhXfFwBDQeC8deO1th93gr8djMeKIrCWvtsHZ+18=;
        b=EGWoPyjJk7hZHDJz75zqGPf91l8GZkO2lOXQ8/WwC8I6+fc9r/23UJbiXbQclANxm7
         Np6Ez6cW8e3NGbBNOoidhaRWXjVAnYVa71ozI1DncXRpFfnHf+68fbZLGy6LBLVLGWIs
         vB0Ibpd4Fx7md725zR/WL80mYBKxIm0anAe6+Hc8tEhqIb+Ry58AQGeW66SeCp6iI8av
         tdTFkeupgiHTt6KGPA5ZZBr+ryg0rPt+NDRfRMz47g+lb1HOKE1WSSSL0b5PF1JYS+Jd
         3u3oi8GefAjH1slo+l+Jok8gTQf9eDq1VbjH2NuupWjzBVsmxpOepC5VELAMzcRZi0ZR
         ojiA==
X-Forwarded-Encrypted: i=1; AJvYcCVcD0NT4uwWEl75KI/bxL+0ZSW42AsIh7QsiHRS42y/bLUXLiGeZHx3Y7wH4reQwuAuVdvcQwiOyVisti5F@vger.kernel.org, AJvYcCWy5DNbp2YiKD65wtlyWTz2/V6//ZNmmj33UVyfTaYedhjML73uNKFMaAN2hLEwnSn8vJehI9CJqmSe@vger.kernel.org
X-Gm-Message-State: AOJu0YyAphuXKDD9eeF7i9o+X4//TU+dUy3PW7q57wYG8wQY0pPMES19
	Pjifg2Ge2baTTqkzin0AiJnJymyRa0s2sA5vuUDiBrFQhpDcjMyT
X-Google-Smtp-Source: AGHT+IGfTJALLs43UHZ5A+N2hijtCwVT1rICAk+qSZMwWMZKN7HQ2jnv6oUjLTB43z0Gh9GVT9weNw==
X-Received: by 2002:a17:907:3f18:b0:a9a:2a56:139a with SMTP id a640c23a62f3a-a9a69a76869mr414484366b.4.1729453253326;
        Sun, 20 Oct 2024 12:40:53 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:53 -0700 (PDT)
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
Subject: [PATCHv2 17/23] ARM: dts: socfpga: add Enclustra Mercury+ SA2
Date: Sun, 20 Oct 2024 19:40:22 +0000
Message-Id: <20241020194028.2272371-18-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Enclustra's Mercury+ SA2 SoM based on Intel Cyclone5
technology as a .dtsi file.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga/socfpga_cyclone5_mercury_sa2.dtsi | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi
new file mode 100644
index 000000000..0425520e9
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+#include "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		ethernet0 = &gmac1;
+	};
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
+		i2c_encl: i2c@ffc04000 {
+		};
+		i2c_encl_fpga: i2c@ffc05000 {
+		};
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x80000000>; /* 2GB */
+	};
+};
+
+&osc1 {
+	clock-frequency = <50000000>;
+};
+
+&i2c_encl {
+	i2c-sda-hold-time-ns = <300>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	isl12020: isl12020@6f {
+		compatible = "isil,isl12022";
+		reg = <0x6f>;
+	};
+
+	atsha204a: atsha204a@64 {
+		compatible = "atmel,atsha204a";
+		reg = <0x64>;
+	};
+};
+
+&i2c_encl_fpga {
+	i2c-sda-hold-time-ns = <300>;
+	status = "disabled";
+};
+
+&uart0 {
+	clock-frequency = <100000000>;
+};
+
+&mmc0 {
+	status = "okay";
+};
+
+&qspi {
+	status = "okay";
+
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
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gmac1 {
+	status = "okay";
+	/delete-property/ mac-address;
+	phy-mode = "rgmii";
+	phy-handle = <&phy3>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy3: ethernet-phy@3 {
+			reg = <3>;
+
+			/* Add 2ns RX clock delay (1.2ns + 0.78ns)*/
+			rxc-skew-ps = <1680>;
+			rxd0-skew-ps = <420>;
+			rxd1-skew-ps = <420>;
+			rxd2-skew-ps = <420>;
+			rxd3-skew-ps = <420>;
+			rxdv-skew-ps = <420>;
+
+			/* Add 1.38ns TX clock delay (0.96ns + 0.42ns)*/
+			txc-skew-ps = <1860>;
+			txd0-skew-ps = <0>;
+			txd1-skew-ps = <0>;
+			txd2-skew-ps = <0>;
+			txd3-skew-ps = <0>;
+			txen-skew-ps = <0>;
+		};
+	};
+};
+
+&usb1 {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.25.1


