Return-Path: <linux-kernel+bounces-353405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CDB992D55
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB722842DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC42D1D5CD7;
	Mon,  7 Oct 2024 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDsclhWG"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C51D54D6;
	Mon,  7 Oct 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307888; cv=none; b=JE5EkmWI2BZGTEp8Rm7FhTPeGjzfFSkJ4mo7BIWMa/z2yLTr1a0ML3JA8YpHUF6w0w9THfC+OLTxHviqXXIvbf2tfOITp/NmM6zhDphKxIPlvI9VG4kb20enl3YZ9CBeSVQrjMtrHSAdlsYCzZb32gQWjNCzd7la0WstA1k5gF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307888; c=relaxed/simple;
	bh=vV42RUHGMW9kFSk33JmlcysIBmsyJL1a3vd4cWxBy7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGkTN8D5wwwAVdruPALI6vE4wL46EeqnfQeQcVg/oPcyEHRgeGaX8GuqNh8shL6FCiiDKrSi/cxQGD+GE3GyVn61Fzab9bfGX6SAI1+jLG5ifL4L25Jn9EL0dkptXBTjCcqbbgOabonEuIp9ATaZOPXnUYi1hrtfD90wZoDvJE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDsclhWG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37cdc7bd941so288895f8f.0;
        Mon, 07 Oct 2024 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728307885; x=1728912685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naEfAmzSKhpqtQnWvxkkJprHetAHHfZ0yc3YYzM5sc4=;
        b=bDsclhWG0pYwQjTUFBxnpLyktsh13NsFuW+i4HuTybUSOVsAPbrCkBsMsfYtD4F3Sd
         TL5K/Bghqj1+2TJj5Hl9zbP+sm+jshUhRNfaltrk1Dp7kuRah/31TN70FfkSQWGAJct7
         Z8IMqR69slFmqV9kY3gj1bE3/26W2tYlcUhlvpyGwJ9Rz/YpI/ZvCkuwCQZs28wqxWhi
         OWMxjNnRKfFMAL97G9y9aVBPDu+h/SZBYIxI+4WHqXXBrDxUK8aWbWFA4v10+OfMvElS
         QPQCK+LUwNopXR8YZDNAhw1wdMdD2OV3UILgS5QSOlUfDfTx6nRFw4u24AB1HnNckVLh
         KBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307885; x=1728912685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naEfAmzSKhpqtQnWvxkkJprHetAHHfZ0yc3YYzM5sc4=;
        b=Uhilrm0bpyFrUB9QPjW+yiN9OxDScjYQ7ti5gB7YbcSzCXCU66sHdmgbrmv+qz4aQU
         0nNNQ9nPPMW9d1jMK08oDxIcK2aWeCirAc3kGBt4fw42Xjk6gPYkjLjo6TyJmcAkmV4C
         RIe/kCI8I3BiIN1E7511nkJRyQNIJrIZomRn2BWJQLpaAZvR6SsECXUnJGbkYM8YESf5
         PSW5h+ESB5D8Vv5QPZo6MnWA9CSo9o150mzjLQn06eERjJUXB8edIn6b7rQiKBqyWwg+
         8twqzbZUuetJAuKCb7Ua3yHa4vE3BufiAQtT7zTMsuf/GosxyKReZEWivbUSQHp2qGoQ
         dueQ==
X-Forwarded-Encrypted: i=1; AJvYcCV71z8vua3YHJjQaSTpxc0dHoiw1NsYEwdGvoou/RQriawZFpM4eeJojU5q4VmTSFclfFAnzZn9OxE/@vger.kernel.org, AJvYcCXLmAjS7zIp7CwE+jd9CqVIwWA3m5Karpk5ZNL6GkfOrhxsZ/RToqL/UTfxDW8xeN77pQ1qSULwX1uHlpjW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6B38DnzZ9ZcQFp1bRtAH/TIXdE4zvSa1ev82/nNrbnZKSXEUh
	8rs8+lDJoqK5LawIzxLPeCCTytjpwjkBYdDOQdTWRq6Xt3a7d5jg6X5SLg==
X-Google-Smtp-Source: AGHT+IG3PsM5ISXCIuw3ztJSKHSFYrqgWl0jBUycIDe60ZoOzTofZm5d9vQwgasBeSxqRsi9KhmDWw==
X-Received: by 2002:a5d:6daa:0:b0:374:c962:a18a with SMTP id ffacd0b85a97d-37d0e7b6563mr3438212f8f.4.1728307884564;
        Mon, 07 Oct 2024 06:31:24 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb34csm3193089a12.59.2024.10.07.06.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:31:24 -0700 (PDT)
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
Subject: [PATCH 5/8] ARM: dts: socfpga: add Enclustra Mercury+ SA2
Date: Mon,  7 Oct 2024 13:31:12 +0000
Message-Id: <20241007133115.1482619-6-l.rubusch@gmail.com>
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

Introduce Enclustra's Mercury+ SA2 SoM based on Intel Cyclone5
technology as a .dtsi file.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../devicetree/bindings/arm/altera.yaml       |  10 ++
 .../socfpga/socfpga_cyclone5_mercury_sa2.dtsi | 146 ++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 87a22d2a4..31af6859d 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -61,6 +61,16 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Mercury+ SA2 boards
+        items:
+          - enum:
+              - enclustra,mercury-sa2-pe1
+              - enclustra,mercury-sa2-pe3
+              - enclustra,mercury-sa2-st1
+          - const: enclustra,mercury-sa2
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
+
       - description: Stratix 10 boards
         items:
           - enum:
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


