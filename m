Return-Path: <linux-kernel+bounces-353404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA0F992D53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8206D28438A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AC91D54FE;
	Mon,  7 Oct 2024 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkQOg00D"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8D1D4607;
	Mon,  7 Oct 2024 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307886; cv=none; b=Dv+7cW+KkbCNloNCcJbVVOCgTT8lEHfQ+F3ADjo08aBWejdMCph4iaeoWRPD5NIGc9pmSb4icsXPIm+HelQt2wa12LQNYc7uuKVTvo4jQZsvZdu39RAwlSQaKEp8Sv6m14a8NMbBgpbgOLBUEUa/ujL1LWwG7NVageA3GRQ5+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307886; c=relaxed/simple;
	bh=UByxZBjKRbwyzR0DDzBHRC6J+92XJ9jNgFVV6HU/ghY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DK4lh8NCq0+hSrk3r73DvHxQdO3m8ac+7vxCtoA0EVHFRVZejmIBt2uZBjg0Y1vaOhD3G//jbpDsS49bH5CIx+YIIGGx0ujN1/MOsJ4xf3fd93otSbVL9K5Jo9aScb4dsy8KG5NYcRPwPAZf6xfXbN/VGfUm62fDzputqccu2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkQOg00D; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c884bc72e9so564649a12.0;
        Mon, 07 Oct 2024 06:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728307883; x=1728912683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3lP69XlVRrU1wGs7GEr6WIM2xmTxn5oh9fziuvY1p4=;
        b=DkQOg00DgA00UPESjFdJDV98jpWgBngbG07QovFx0tQl19gKDkLyec6E57mikq/BEH
         yfKKsRJ+ZifVgY5ZToFK4c+hx6wFl4HhIUk0cZ3WkfoiAIJAh0XbkEepN7Y+hEN9nn+f
         8vcLda/oQVsb9FrOBcp9a0AIpbYXAe6UVqnQ9qRennldKD6/b8ZaiQ/0iALnbHKnmTHw
         NA6Boco5SolgYo+HZGzTTGa+ZZ55zliuCqunHQioV9po2dEFQ/WKYAc4Nr/LEG62jUlE
         X82FNIlo4oGkJPWEgsA9ziLwiqFN9bbTVG88IayTQwosS0mUILPh/MYvCc/L/5HftSrx
         KdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307883; x=1728912683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3lP69XlVRrU1wGs7GEr6WIM2xmTxn5oh9fziuvY1p4=;
        b=lQlvYhijkdirqTNLEMVJ2KoP4QwfAEjCfqejfTZYnQQjKp0Hav5lq+RXSTysSv3JrL
         lbIBOJssRCREgugz3y4kfRH7wHk73ETmp+awEltdef8u7e37EOwfECqzIfjREcEForyC
         FHHpIuDJkf69LvA2E+HtHy6UtMYsWQ3QrVz7rox+ONXZn82eOcpYlaPVf4imAan2L3mT
         HxTtUyd33gB9r22bYoS34zoof7brJKd96zJECxGCc0SKbUXvWJbofRjQzi4qU/qgmMVb
         Y5AGjN/WETqfY0n2sIb0+DHzfE0eH4S8mVpQmx22Rypa0BBQ3BxHGlgH3M8MhqqO+Tgq
         dXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiKxCmwESyq5CdrxTkSfnaR4n1wvZ7SUD5pH3GFjKj4UpW7ZwB1Rpg0UArvoeLiS4rFHyuqdGUTiry@vger.kernel.org, AJvYcCWz8qx1DdRm2+dYIYNNFX/gCjymWD+72w9FHfC1BZAtGYT5e8ctMpLvwIsA1gHZvLgugOK2HH3iuad7R6YY@vger.kernel.org
X-Gm-Message-State: AOJu0YxBPpH6oI/U1bnEemDA1/soL3WfFtWRaGwBq/abOjb4KygBQLtH
	aSdGfoDXOin/lZWNzLClHZ90F/GDU0r4J7FkdZVyEuutuRkr8K+/9OO2Vg==
X-Google-Smtp-Source: AGHT+IH6MXh8mM3403LuJQh7fgE75AvPVNhR9ies1jDcYT6uTfSt5fQI/T+GuKgewEIYAxVE+SJgMA==
X-Received: by 2002:a05:6402:3507:b0:5c8:8381:c0f9 with SMTP id 4fb4d7f45d1cf-5c8d2d00bc2mr4539830a12.2.1728307882786;
        Mon, 07 Oct 2024 06:31:22 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb34csm3193089a12.59.2024.10.07.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:31:22 -0700 (PDT)
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
Subject: [PATCH 4/8] ARM: dts: socfpga: add Enclustra Mercury SA1
Date: Mon,  7 Oct 2024 13:31:11 +0000
Message-Id: <20241007133115.1482619-5-l.rubusch@gmail.com>
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

Introduce support for Enclustra's Mercury SA1 SoM based on Intel Cyclone5
technology as a .dtsi file.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../devicetree/bindings/arm/altera.yaml       |  10 ++
 .../socfpga/socfpga_cyclone5_mercury_sa1.dtsi | 143 ++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 8c7575455..87a22d2a4 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -51,6 +51,16 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Mercury SA1 boards
+        items:
+          - enum:
+              - enclustra,mercury-sa1-pe1
+              - enclustra,mercury-sa1-pe3
+              - enclustra,mercury-sa1-st1
+          - const: enclustra,mercury-sa1
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
+
       - description: Stratix 10 boards
         items:
           - enum:
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi
new file mode 100644
index 000000000..3eb2c559f
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+#include "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1";
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
+		reg = <0x0 0x40000000>; /* 1GB */
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
+	/delete-property/ cap-mmc-highspeed;
+	/delete-property/ cap-sd-highspeed;
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


