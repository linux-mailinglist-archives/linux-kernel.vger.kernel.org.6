Return-Path: <linux-kernel+bounces-373405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2D19A5654
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB22B1F22407
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A13519D06B;
	Sun, 20 Oct 2024 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz9vZpM3"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35319C549;
	Sun, 20 Oct 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453255; cv=none; b=a9C3ptnF6RyP0UoW+vaoPzc5g9oEw/UeUJhGDPe9c0R+UqmpWXcXeQHyCVfPNradWhHbdIoa5qTlXIN7ubeFjWnugTqK6LVEtDie85nTqYM77ld8GLz78M3vXcFXiYe9w55CJYT4nMWE0b7OrSyaU4xggMqE4ZzKbhhiYyFbPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453255; c=relaxed/simple;
	bh=I1zgXOHN6oREsvCSLthP4jJ6KUPGlV/wC6TfsmZIe1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0Fw3bon9RHCuewJlG7XnzNQ5P0ZjctTp8pCj5fpBEJA1014tXfxa/pTQ0+bfsjEuWC3F5USBYrJQnm4UY9x+SgM7Q1CyU4BOBN4VG7E65kjn7QRZKnnPcAevcZQUrHSn4cmVULs2g8lH6Wr6r7CSE8MP5pB+Pqt2Tj2zPYvyb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bz9vZpM3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a966de2f4d3so35095666b.2;
        Sun, 20 Oct 2024 12:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453252; x=1730058052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3md7pm4CwRsuk4ExwfOgbvW9ZpwLySf0KbTEjVZnqM=;
        b=Bz9vZpM31MfGoKopwOsd8keNygFw8GzBhQhxTuA719owfn9VoysDpcXtMyL5ryZOSd
         yFnFbmPEkCZ/DD7jW0gx8a5wkHS9RzlJ+N5Zcog/F51QNBQQiS4EZgedVoJdfRJD94Sd
         U3mFi+JnKA6U8CHfDmKN259GoYeDUak4EEb2W13HE/6EDDO4agsv3Q0fJ4wl9kRrbuZ0
         07/RbtyP/6V+gZLmRwQs6FB4AvtprUHO0KBls/RBpMIbnRJ/P3IKTybLdvWsd3nee9LS
         wD2aSZd8c9scXYr8Hm+P0pNMIa2OW8OV7TUiyDjQHXgpAsWuK3BKIg0Sm8DZYCaFdfZp
         6yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453252; x=1730058052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3md7pm4CwRsuk4ExwfOgbvW9ZpwLySf0KbTEjVZnqM=;
        b=Hd3hT8T9jXiSXcBfJTNDPQK8eGVfeeJC5+x2JlWFmuvRTIIq4BNs/7KZV73qV774vT
         E7VBTsPt6x153/tkND6YoiM5d6PokWIsxkyOhV8USZ9HMSoCehyFGOVDwRKKYzbVEwAU
         rNeZK2w38MgCWNAtWoynH1WXSOIQDlv3+BK+FgVnv2rebnDRC+tiySYNcZK2ohF939Wb
         9HV50gzPxATO6wfHdfAf0k7Z7QIcFH6VlNsFXkTFrkiVhKWO//3mqtQmWLoIzB+VslFE
         XiultF5oSzBo4EiqGfJMz1fSGCks/MF949pJWMIfopP7QxTq/BtIV5gOKnhUqvBJpYyW
         3Xbw==
X-Forwarded-Encrypted: i=1; AJvYcCUjcCB2O41zsmw/WWChAkjwksoj7q9sHIsGMeJpfKzvyRBnRiOweCqg9zdkLEBLIxfE6ZEqJ17WDO9V@vger.kernel.org, AJvYcCXmSK8ZkE4EYia6iagscmlgZ1TPpC4hk/sgK7y3qY1w8LDyoKRYV2pfHhMKyoQfmLp5eRAIvKUBnLhYub4M@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIVZ8veCjBr3V7uA/kVqWugKIQg4uq34H/Y+mDRUuirovCNis
	cvD9o8SMv8MzvZRoMZvRAIrVaA2dBTwyZu5FW9kSwBGDTTbrvsCS
X-Google-Smtp-Source: AGHT+IHPeBXgPJiSrnnMTs+/BqB9jqDJy60SxrUHwc7puQiNjT2HtXsGcuimxeKFaIwyPthlKajNpQ==
X-Received: by 2002:a17:907:980a:b0:a99:f9c4:ca78 with SMTP id a640c23a62f3a-a9a69cdafbdmr364280166b.14.1729453251299;
        Sun, 20 Oct 2024 12:40:51 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:50 -0700 (PDT)
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
Subject: [PATCHv2 15/23] ARM: dts: socfpga: add Enclustra Mercury SA1
Date: Sun, 20 Oct 2024 19:40:20 +0000
Message-Id: <20241020194028.2272371-16-l.rubusch@gmail.com>
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


