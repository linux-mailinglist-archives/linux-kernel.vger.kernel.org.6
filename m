Return-Path: <linux-kernel+bounces-383664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0D39B1EDD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7431F21827
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15A51714D0;
	Sun, 27 Oct 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b71wZgYI"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5331189915;
	Sun, 27 Oct 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039840; cv=none; b=gSgY5r8il4E4GqRH1wrGtffKH0MASMvY+hF388FEGy0w8YUDxnPoTEdkaz7hM7x0YsHsY9EluSS5xkeWyu/eiTs91EJiNTkDWANzJgIxACR0IzaomZ4icOFAae/AVEjTvI+yHaEYP8a1s3wnhRdT/KZV8gFETz01961/6a3SftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039840; c=relaxed/simple;
	bh=I1zgXOHN6oREsvCSLthP4jJ6KUPGlV/wC6TfsmZIe1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBwdCHOCwGwALyIsKT2lX9ak04CjENpVnhOzbRCPSxyhltuWEaHFrk6rwavru4bXc36gjK/XOz1jp0UW5GYmfWsWl7smPApUE1CiMcagzbZpq49LbsfI5FxA6wIgTOlqYCAvuquyLJ1ifDbx8N4y6LpP7N2G2TJ8DVnC607fp/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b71wZgYI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c935ca63ceso457787a12.0;
        Sun, 27 Oct 2024 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039836; x=1730644636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3md7pm4CwRsuk4ExwfOgbvW9ZpwLySf0KbTEjVZnqM=;
        b=b71wZgYIVQmydZP0JgcWHNExlAkNdCX7n4YDDEQgN9SHk4DFWRIZUfrsEkP+pKvTBF
         8myFjYpZNtpFFhe0oWbffKftegxv+uB3s63PgyHiIPluiBgVx7eap4qxVFE4A07kDarc
         2ZigSd4Fs34fCMmVALccJGgpYjOS1ztjSy6vbQQ6ZxjMaMXmhQTi+fvaZkDnXFVSdiPp
         XuFz4x/NTG3H0NXJAevnMWOkt2LF/WNEPSiHzJf6HylSIu7q+Vx7zqDm9rzcg+x2yvgr
         rkfW7GaagQctO86KyExEu+JfNgrh6P1LUq84aKV37sF17GT7BBEv5mA68IxqflWbDaY2
         r8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039836; x=1730644636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3md7pm4CwRsuk4ExwfOgbvW9ZpwLySf0KbTEjVZnqM=;
        b=gDhTgllgYdBIw0W+6EM6WWdQGQRkklIlnFhQGV27F4cy8q0qUovIRMm8pqbISxhTBL
         Eqgwk4Ha0lqEA5r/nB3LnnHiJjWyEAS8Hq7UNaqJ/CaYfdQN7QSQCLT2ZnRDLR+0UjxR
         SSC7A+D26vmWbdxw+r5HxZ4YoN/a3dKIXx5mTO47F3AB6KegL9+2GJUQiofs0iTZ8hIe
         XgqDIw+wFspcXIzrhhy2BaoQJeXFc3Qixvzt6mTfvnDI1OF0Acme7rcjVnnchGv1op9q
         cEpo61ePIgqzgxGbWr1E9e1fINSOnMOvIYC4lszy4X0MwC2b9ijgIIDyeHWAsjMuPaQ0
         IyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/6qF0HrjhYmwYU8Y0Kwi8t4IUP+vPbmvQ1ZvVyGfgesos2/ke0mDddpQOpK+g62drjatsrUJPcXsy@vger.kernel.org, AJvYcCUeXIUoNrQ+Ah3OC0j1ShQcZ2QjNndbA3CXR4NaB7uNm2IPZF3jXdNdbTqulNMmvjRgnZekOgSEvZ+KjK56@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6NrhOJc+QWb455EBM9zH5MiPSU3gBV4E+EeHW0nXK1hXFflAE
	8eiaPHH8wrpUCEc/cZePZ/fN6sdbLTDZ7+ozyo+CzgwDHuPJ0qjh0vtv+A==
X-Google-Smtp-Source: AGHT+IGClllBTGHGt7D5knHP+iYY/StsOWgjvO2GTW8nPUX9kTtg3HNb0OFbVey68zLy5fe+RuAP8g==
X-Received: by 2002:a17:906:f591:b0:a9a:2afc:e4ef with SMTP id a640c23a62f3a-a9de5f23f8emr219972466b.7.1730039836060;
        Sun, 27 Oct 2024 07:37:16 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:15 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 14/22] ARM: dts: socfpga: add Enclustra Mercury SA1
Date: Sun, 27 Oct 2024 14:36:46 +0000
Message-Id: <20241027143654.28474-15-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
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
 .../socfpga/socfpga_cyclone5_mercury_sa1.dtsi | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi

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


