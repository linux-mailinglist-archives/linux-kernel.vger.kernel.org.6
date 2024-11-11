Return-Path: <linux-kernel+bounces-404341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141E59C4297
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84AA286707
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF021A7259;
	Mon, 11 Nov 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn8zOj3L"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C039ACC;
	Mon, 11 Nov 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342334; cv=none; b=J3UWWEeNNtBPdwk2FPNmdl48nN40UrG7htkb2XT3OT5RkAJPM0VvzLChcAdJ6kqLw2ax0q9J4O9e7CliF8X1cAkLSWampYoK3ArmdwcnRi8U1rvzNuAujvJaWQb4MQggN8RJSU2V/LubJuEEo+t/ejqOGJeUC7qV4UZuw5RKZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342334; c=relaxed/simple;
	bh=76RzPW8RcT4orB/VklxF++mK4pyLoo50KIMbw8KSEYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVmeCnvL47e++ZD+iYCJFT2qyvo5LPlup0Fav+65WARUL7W2Ad5ahucnIeajO46kLJlr78FzAk0iffoLYY59Jy1brlNjF5fE4OVMKXcZFC38aOxINyZHYX+WgpR1xkOQgDr0O+z3BIAZRIK4XeFm0rU5Hh60jYWa2iNjMOCX1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn8zOj3L; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so5236497e87.1;
        Mon, 11 Nov 2024 08:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731342330; x=1731947130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdaW5kfpiaTfiF12KAXhCU6CQhCro9H+J/CsRfMkYO8=;
        b=Bn8zOj3LLVR6pc4xWF8r+obpbxOZZEDVPkkXoQZNK40FV6f9lcHwdhZmFZl/nSBfPS
         xa4xd7/NSUiJ20dkDQ5hZ1WA1K8rDR0JPkJGUQalnP3J1ABI4H/AcgJGnvUNs1DWknRg
         VwUtaQXDAQzmdS3XKhWt5FDXef6RTbFYmaspetuV8f97hbz9zr2bmKA1LDC7vdMGR5Vt
         yoVU4DNpGnAoa9L9mYwn8LQ97srdIncyujZ5g3ncCVxB/yWw+tkq3UKqLC9UZa1UXcXo
         5jJdpw8HDo0loQYrDXjeBDZa/+di1uCUcGoLzVhV4zlH3H9h+EYybNJyUP1lJcWfFEtB
         TY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731342330; x=1731947130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdaW5kfpiaTfiF12KAXhCU6CQhCro9H+J/CsRfMkYO8=;
        b=waFcQWGedC8dm1XJJqz8AnH6i7XiAiz0Otxop8QVTnaaAEutyWaxmQpz19eYv8hhYw
         czDytghHGjCeD0PUEG5tbCYMExx9pfPs78ImhxfRog2NhvvTOY9Ef0094677567Du95K
         9ZiXneRe+ET2UmMPVPLSR2tFYn7MSWqRmiOAj/gnLKlcZfB2FQx2gN8y5uYtQy6nRgkK
         dM0dzuS70q3BCKcYZlVjmFkux+N7qgzagsI4oAeHTXsakjtff9MoVJaiYrgD9L77YWI1
         2oCGspsrBxDHq8YCcO9+JXDAjep/OZEGpBF2+9GfVO6W990B9aKBxtv6FEGQ5YdSkS+f
         WYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcO4Lx2zYxhXf4U3k5lbQpmf/ZtDIYB44tAHkPlrHZxQa3eroY2G0+4Jji97kFjOKlF5SlenccWac7@vger.kernel.org, AJvYcCXQ3HtEzAK4mHc+186n0mBauZ4KE7KsqsZUMtDHFM9Dibfch42ilgxKCdU+I3ivykHS3XWxzAoZlpiWjYxcTws/2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vELICSsLZOV+kKtSPqzJHRgpXdOVlj+6G2n5QipElle8SUj2
	TCV0LEGUfSh+B9XGSuH6SrvTQBVF86x+syWX0enNx1QtR7Z03Ayoy4xWkAxF
X-Google-Smtp-Source: AGHT+IHjidSenCJkr5FUNWAm4Y6bXamQ3Ryqvj8VKRbPZjsYvS4BKCPVBWtxFuWLxC9OMU3f7f++sQ==
X-Received: by 2002:a05:6512:224b:b0:539:f554:78ac with SMTP id 2adb3069b0e04-53d862b4524mr5911112e87.9.1731342329683;
        Mon, 11 Nov 2024 08:25:29 -0800 (PST)
Received: from localhost.localdomain (c90-142-33-119.bredband.tele2.se. [90.142.33.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826786acsm1622926e87.30.2024.11.11.08.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:25:29 -0800 (PST)
From: codekipper@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	andre.przywara@arm.com,
	wens@csie.org,
	macromorgan@hotmail.com,
	jszhang@kernel.org,
	uwu@icenowy.me,
	ryan@testtoast.com,
	dsimic@manjaro.org,
	mripard@kernel.org,
	Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH 2/2] arm64: dts: allwinner: Add initial support for the X96Q-Pro STB
Date: Mon, 11 Nov 2024 17:25:06 +0100
Message-ID: <20241111162524.46812-3-codekipper@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111162524.46812-1-codekipper@gmail.com>
References: <20241111162524.46812-1-codekipper@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcus Cooper <codekipper@gmail.com>

The X96Q-Pro is an STB based on the Allwinner H313 SoC with a SD
slot, 2 USB-2 ports, a 10/100M ethernet port using the SoC's
integrated PHY, Wifi via an sdio wifi chip, HDMI, an IR receiver,
a blue LED display, an audio video connector and an digital S/PDIF
connector.

Add the devicetree file describing the currently supported features,
namely IR, LEDs, SD card, PMIC, audio codec, SPDIF and USB.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-h313-x96q-pro.dts    | 176 ++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h313-x96q-pro.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 00bed412ee31c..e0bcea1840c1f 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h64-remix-mini-pc.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a100-allwinner-perf1.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h313-x96q-pro.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus-v1.2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-emlid-neutis-n5-devboard.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q-pro.dts b/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q-pro.dts
new file mode 100644
index 0000000000000..4427545ea143c
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q-pro.dts
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "X96Q Pro";
+	compatible = "amediatech,x96q-pro", "allwinner,sun50i-h616";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the DC input */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	sound-spdif {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sun50i-h616-spdif";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
+};
+
+&codec {
+	allwinner,audio-routing = "Line Out", "LINEOUT";
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&ir {
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dldo1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_aldo1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pc-supply = <&reg_dldo1>;
+	vcc-pf-supply = <&reg_dldo1>;
+	vcc-pg-supply = <&reg_aldo1>;
+	vcc-ph-supply = <&reg_dldo1>;
+	vcc-pi-supply = <&reg_dldo1>;
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp313: pmic@36 {
+		compatible = "x-powers,axp313a";
+		reg = <0x36>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		interrupt-parent = <&pio>;
+		interrupts = <2 9 IRQ_TYPE_LEVEL_LOW>;	/* PC9 */
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+
+		regulators {
+			/* Supplies VCC-PLL, so needs to be always on. */
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8";
+			};
+
+			/* Supplies VCC-IO, so needs to be always on. */
+			reg_dldo1: dldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3";
+			};
+
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <990000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-dram";
+			};
+		};
+	};
+};
+
+&spdif {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "host";	/* USB A type receptable */
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.47.0


