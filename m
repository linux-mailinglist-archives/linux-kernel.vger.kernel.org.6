Return-Path: <linux-kernel+bounces-383666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8481F9B1EE1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70B51C21814
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3245A18C939;
	Sun, 27 Oct 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMF259Gw"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282C18A93A;
	Sun, 27 Oct 2024 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039842; cv=none; b=kH1Fyzre/9MnSFCPEB+HCl551Q0Yrn8Hzq+whzCh3M4NcmOljF3cV899RHJ0FbENhMeljhBuIfwg4Dp0vsk4KHEDH5u+pd2GJH8eeY2LMx7ID01LDTYUV56Nnn7y0IOs+6FSgipDITutbnKgAHNtiNlXuAwk/w0HHuWH4GSH1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039842; c=relaxed/simple;
	bh=5TZIB2542Vc0yIo0WvDWBjKa33kV6CuS60FxkuJ5KV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KoWlpizf4u4eiBfVOSKJbQPpJmV4wZ6vp9chQ8dTf6pWcLbRNxUrmXVQBd99BrsUZEYH5SaUVHQHJ4YgknTOKKNGtflDvf8mymIJcIDvJbmP2g5KVaXdSjEDTGL+gmNEEFQ9lrZCvScPInDp6Av7J+CS+6dQksvuZ/Zls1yksKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMF259Gw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a966de2f4d3so43928966b.2;
        Sun, 27 Oct 2024 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039838; x=1730644638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMcrhXfFwBDQeC8deO1th93gr8djMeKIrCWvtsHZ+18=;
        b=VMF259GwPsVwOrZrfA510qe0i/GY4HFmwg/FsyqcFAzTm7Sqb2Ot3YDAMWLqgapemE
         yVxoQI3132fr1tMu4Va4UyEkx7yGwz/rpucPjcKO41XUt9NmrK5jRpdkbIUBfZidhI3k
         tbfKtuIUxuQDi54BWzl7IMeJ/HBwzVG8gJkIvb/ZuShaVnuIhgudnXZKpSIwef6NXHuO
         ik6uzmm1obg5UA9A2j6YpxexQ4LB0JWzgvZ3ManbnHVuory4CFaQzFCxipiCtQoYsFYj
         H6Mpq/h5cMqlay6zFmuI/HMQ6FZRKJgrsEx/NACsxGNcYUOgqiQCj68rP5z6xbRliEeM
         DgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039838; x=1730644638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMcrhXfFwBDQeC8deO1th93gr8djMeKIrCWvtsHZ+18=;
        b=fI22FGLvbac6pQ5j0N/EnIDh4DOrzctOc6ZtqbvHUUHqPpfqvzWqoFrctYztSyxUP8
         LYvXpnckwizpNqzYlzSufnKoBJ83NI5AEyuCyMjQXUZ4xULkP4wYSFj+UmM25xu5m/tE
         7Xgz+B40lf2Fr8RiB/tL67HUqY15LqmoPqZwhi9TBv2Rxsa5mKm1r8GGoDzeqYgbzhg1
         v0cD0HOEYhk4XOuQuz1MmJDYWWDxjfpM+Qd/SyQWYWJH5hIUaLSBgMZgfvM/GZO4WKwO
         Ru6CSPghIWwdRekgCjGtbnxM0pVXxyQhBtDy159DoBmxQV7tOuxU7EAfOLdJYUJ7GxUa
         hESQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmaku1bHsLdYUjzfzUlk9n3vuR9wGBrlG4U+xOlw0y44oK7oKcmgCBddc2O5h/rumxSBjvcNhMOtPCLZTZ@vger.kernel.org, AJvYcCXXv4ofzjDVtFiSdl1Gz2KbHUPPki0sDzTv6r2bWYDYv6uaCMi0cGNvu1rtgPfneCcG5rPJcrKE/F3b@vger.kernel.org
X-Gm-Message-State: AOJu0YzDV74mTxYYx4WSulbyQ4rORg/rVkaEUBdxjDLNN3JpqgtBICag
	hmNKY+NspjO6eeBIA4d8+ixBJTNgzSdBrlf5eXcowghC399YTLlFwDglsA==
X-Google-Smtp-Source: AGHT+IF34D1bgOmPMJce1DPilaIg1fPeIOVClx8rRJfD0QoDBRvv0dzoFwJ5AUSwisNToiJqZPQsIg==
X-Received: by 2002:a17:907:e8b:b0:a99:d6e1:6056 with SMTP id a640c23a62f3a-a9de61a3ad5mr224228866b.10.1730039838243;
        Sun, 27 Oct 2024 07:37:18 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:17 -0700 (PDT)
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
Subject: [PATCHv3 16/22] ARM: dts: socfpga: add Enclustra Mercury+ SA2
Date: Sun, 27 Oct 2024 14:36:48 +0000
Message-Id: <20241027143654.28474-17-l.rubusch@gmail.com>
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


