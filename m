Return-Path: <linux-kernel+bounces-411736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EF19CFF06
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E071E1F22D45
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026EF1B219F;
	Sat, 16 Nov 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZbwcRwu"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D50B1ADFE4;
	Sat, 16 Nov 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762637; cv=none; b=b82yYELj9yJ7+6MaKnWj8Oo1K7RvzUTL/gGGTOHadZyg0AyzSg1TDI67bpwMRKSZ0/xM6L/2mP4BipBipuq/P9ecTWAVL4r2A3KqMjZBdpryk7Tt4mwZ6XhxVmek/3wQyvTRvRyUyNHTe4uql1gnNOlKqYuXaLaD6cgCZGNBs4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762637; c=relaxed/simple;
	bh=iEhIsh719uJRaMnSjcUZ/StVxzkVwmby3Pxz94NoTmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kIQ4HXPWC9bmDytqQHrgW2mF/XlsEG/1DEm4ZzXUl12XqQVkwCm0mbc9st81xq/MmVq4+/CEyi6+tvPTpxmz7mM+W/VHBN3O0RGbLCnrvCC67Q3TzlbWl8cCk51kzEzdnXRZmA5XSOD/5gAb3m5n1qS5yvnhl3Jtebx541ixD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZbwcRwu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3821a8c7c5cso285892f8f.0;
        Sat, 16 Nov 2024 05:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762634; x=1732367434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc5cQN0Fq0pRaHXHL3HHz1NoDgPeVVF0a4IpnlfbvV4=;
        b=EZbwcRwuF7C2BBG/7Pmcpak1wdl30Ao2X0xYtoqFurCq7lTBIH7dkUtYpaQQPUOBo+
         1s17pA9y2ROY2XGX7JHXZMtH/0WCEnL2E3XgmK7cJpXNeGaICQjEZbvxl8JeV7Adcn/L
         yv8MTOMMKQ2zAfBBKy4rZT2FSeLMro9p1NE4SgLhA+GySoDGEJ/Wu+D1BG/Xc5s8T0PF
         MxAg9LvPgXvCNOLNYnZh6UD3kgrjUtKZ98ai9qvj5kJsRAgkwNbQtWjUWraTQ4nRz21v
         UNhF6rK7wYbWva0b7hEpZg5mbMI/vzdIV0UgFqptO/Ea3X89/8wCZguZWbWkM2qkUGc3
         IzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762634; x=1732367434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc5cQN0Fq0pRaHXHL3HHz1NoDgPeVVF0a4IpnlfbvV4=;
        b=xOKgHC4R2ToocBXaXuFIFArivWoAzuT1/AskGGdMr/zNJjjWCBspgX6hO8RdX6mReU
         i2t1GeVQw65LYhIZmr8yd5TMC1DkV2YjmXZ84Y3SE8SwGqdDKYt6fghvSrB8k8baZe/0
         MUUQRjTdcRZYdV2S36AOZKRZvEWM9jp79gi+k2f+KMmW+CazK/W8aHrP06CBDOr3XAyA
         8ISeHqxzju/zHo60rYktbQqcNy82OFYLJ+Rux+VRU0Dlzw4K86mFEHJJtzM4i/o/rbpC
         Nn2omMiBG1ZRyvS7gj81HFHXuKVa8PdZNmIlinsYz+6FMwd3IfQSkOtO8EOY02Vg0VO9
         gRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD8cFpQg2QUATXoQvM0OP8ZyZKTUHlw6bOmewaHdvmQKcpAukZIboKDKakhZfhtNbnRzpCCxmph+5i@vger.kernel.org, AJvYcCVl/6kIYsBO6luuX4n+hB2e/eRB+Y9mPcSFiJS8RdfhbhYAxPF/xZv17i95FkIHUiMlTQgo+YAWW/Bd41hA@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGZ7OzahjT4OS82aOXNK6Hvzfmqu7KIs2sFzayckmvLu5AHBt
	7bP1Gm88UaRYAgXer0MQPEHCbHvYnpf31xlb0SI+swtrSnqOgFEI
X-Google-Smtp-Source: AGHT+IEJsZ+Q2dRbY45pochw8eZ2m8BCclYQK4bHv9UPyO1501Mfi7fT2rpXtrrAU6wi+P8ncSxsUQ==
X-Received: by 2002:a05:600c:4710:b0:431:558c:d9e9 with SMTP id 5b1f17b1804b1-432df78ac1bmr23397085e9.5.1731762633837;
        Sat, 16 Nov 2024 05:10:33 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ba80sm92424375e9.29.2024.11.16.05.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:10:33 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org
Cc: marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/11] ARM: dts: socfpga: add Enclustra Mercury+ SA2
Date: Sat, 16 Nov 2024 13:10:19 +0000
Message-Id: <20241116131025.114542-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241116131025.114542-1-l.rubusch@gmail.com>
References: <20241116131025.114542-1-l.rubusch@gmail.com>
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
index 000000000..f46f1410f
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
+	isl12020: rtc@6f {
+		compatible = "isil,isl12022";
+		reg = <0x6f>;
+	};
+
+	atsha204a: crypto@64 {
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
+	flash0: flash@0 {
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
2.39.2


