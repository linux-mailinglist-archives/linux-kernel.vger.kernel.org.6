Return-Path: <linux-kernel+bounces-411735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE519CFF03
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E01B27173
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1751B1ABEA0;
	Sat, 16 Nov 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amJOwoYZ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F818F2F8;
	Sat, 16 Nov 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762634; cv=none; b=hFMRgu8+i5h4MU9KS0yG2cM2b9SXVu0qtuxIMoh3QXiTlGK/Yl0HECIu4lGl1KFHX4Cma9eubAHXvGmRlWfAn/JP7jnksAaV1U/Ho+qlWhdOBHcPgqOmRRMZVNUDmPps2ekBDqByB4CxAEkZS0ysGTrupa4WOOgxuonPazpqfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762634; c=relaxed/simple;
	bh=8TgoLrhGQyIsi4BdBA5Bd0eo7pH1DOtl5IizLXLY+bU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sCQcGgvWRZFhnKdVkM9PbCeekzXab3HgoM7P3LNrXJ8Evo41dkHynm1cXYJXzQv2dF8VGn7G3L26gcJimea8X4i9LOBmi/ODwPKKVoi7g/qLAxPDHUzrrXofVjnTTvruoK0EKC2X3aoODhJUSUXObAymNt9EQBs25WJ2iQwOexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amJOwoYZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314e64eba4so2753325e9.2;
        Sat, 16 Nov 2024 05:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762631; x=1732367431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p3U6hmPLgwHR7NW5tsJfJ0Stn/TMpDkUur4XpvFt04=;
        b=amJOwoYZnBAGAZxHUTIj2EJQciRvqllMklew5kWmCg3JzQdUArdGOlUiTZSbVRsnE8
         DwohxCeTvUUb6a8K3zTnc1NnXPIXq4sgI+gVpnmNnqEBYOaepXyVoQhKdZ7spGP+L8QD
         eSjweNF5CZTJGUtOsbVNzJelF2WaoeX2J3xxp3hmSBNC2FsThQamepgn68T1VAwspj9/
         Gylmpdopf7rKo4XP4+VG8bRwRhi6Hcip6OwtN1hlLg4C/jBMsUbOWIeCoj+RvEJqXla5
         Lo2cI3Wy+TunsHMttmQJuc/k7FiWaL/f39Pu/lqkOX9KlSO3wunftqE1ZzbjfDhnNc2X
         Q1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762631; x=1732367431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5p3U6hmPLgwHR7NW5tsJfJ0Stn/TMpDkUur4XpvFt04=;
        b=mgXeI+ikvJzMzZ88aY49MuMkYuv3I4/bLVlg9PcJEx/FvEuttW3faKStsj3pgIcBsp
         y/7ImF8r89a20pl9VqAD1Ts0+GAc4fWts1nYMjC4p89B7zrUY4rgOSincOyW1C36kg6T
         cbA4ZByNw2afA63IhVkADHmIDN5Q725V1F5/GAft5TgD3r6UrZNVFFTKSQUrbjBRikxT
         u6MBbDnhOvrIicA5v93e7Jv4Hckg6cQnZY2fa1IayvkVZdEEQUEo+r5F+wPMc8F2xb9m
         a1FBrfP1xa3vxjsz+EtbkYdSsZVag/W6m8GQ+36wWPBgcBbpNIg174hoIFckfAohxes9
         U2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC5+8oqqLEvsBvJZPw6z7YpKyQ5e8BjIjOjstPx3W76C521citQy7dEYSUGBeWa+VIy+7FkxT6imKk@vger.kernel.org, AJvYcCWvi7IQNfK7Iw2Zf/BPxZMvf4FD225owz7SwVJxBUndnNAIx/MXQFhjV2lAK8roF8baOHEY1RGaMUCxBw2P@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7XievImBZbIvHyRvONVZkP5qL7sFUqq2YV1hjZuRSQZZfxxH
	H6J1VQ30pYgvJZ9ol5Jjc9JRxEUXqldlymJaziTVoVrvj1BIGEEp
X-Gm-Gg: ASbGncuW4P+l0q3JoBYgGGgVp0CQSnRBEMM59IbcyL10qIZ43eM17S0f288HLq8/03V
	k7RX2Cmsk6H18dQnX06v+i+dErwF1cam3p8t+b5YRBYQmtsVhLI+iL4+M2BZv1oINVuq5WEcfC6
	0aWd0Pjq+RYClHtog4nrp4ziy1VcNN0/rTCYbexfNpnM9SSgOVd0Jy8p3AwqlRHH0rBvXWHZsGV
	3U1+wshuV4be/9ErUQ7BPWxOizn5/K6iDtagwUBKmTvBkndM8lt+NqY6BhJ5uwveXy27u6ROmyL
	q4G6KpJyybhumKvLoV0H57JUWw4u
X-Google-Smtp-Source: AGHT+IElObgIo1ZdcSQyWkEu+pzN14vGhmWgce1E5CvNEGS2IKVVf8stBxt3cuYFEyCWjMuN0RlwZw==
X-Received: by 2002:a05:600c:1c29:b0:42c:aeee:80a with SMTP id 5b1f17b1804b1-432df791c54mr23482015e9.7.1731762630929;
        Sat, 16 Nov 2024 05:10:30 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ba80sm92424375e9.29.2024.11.16.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:10:30 -0800 (PST)
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
Subject: [PATCH v5 03/11] ARM: dts: socfpga: add Enclustra Mercury SA1
Date: Sat, 16 Nov 2024 13:10:17 +0000
Message-Id: <20241116131025.114542-4-l.rubusch@gmail.com>
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
index 000000000..2041088b7
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
+	isl12020: rtc@6f {
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


