Return-Path: <linux-kernel+bounces-258758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A5A938C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC411C2240F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44753171678;
	Mon, 22 Jul 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="ZRW4Z1Xr"
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156216E88E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641441; cv=none; b=EdMUlLT1cvKRD4f0ODQOvcdWUZ+61L13UhJtRl2ujE2Ln8LkkMD3oYD3gw9jwjY1EaRQEV4M+UAOv6/Xq7CUy8Pkvs2jdmpi4j+Bx8TNWPDrX4MLLuqSVoN23440a13njSJQkuwrdLOEaXK0856OH9pFDDdafhWdbjTw/XLbHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641441; c=relaxed/simple;
	bh=o+ZeZemlYweYAhW2nOoXGrtnO8/h6eE+gaWwqbTXEkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E//vg+59Zuhyvgu27WLHfa5yMNzD0H0rKLTCQVMWgPWUJQNA0Zd34R5o5tqthy592mfqw+OLt73kME0dYnIpKVyMSkj5EciJxUrv+tB4Zfg8NsvUxw6GtV1haIusO79frQB+l9JIVllGN1cU+uyidzAFQm07Q2vQQ+VnHt7rUtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=ZRW4Z1Xr; arc=none smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id DEBC0322B53
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641436;
	bh=o+ZeZemlYweYAhW2nOoXGrtnO8/h6eE+gaWwqbTXEkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZRW4Z1Xr+zOn2ay+enqLemspVggx5fAvFc5QTTGN8zQx2qkAvmZjEUnvjJ4V06QA9
	 QbSN90Fjjuy+ZnptrJCmA28hPyF+qYeiujbMkRc/gCVyCMjEd8m2Gs+z66s3Zac02G
	 hFuWNso5XP7wczDBMtjvcSWDwE4BPtBxwtF5yFs4=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id AE4F6322BAC; Mon, 22 Jul
 2024 11:43:56 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 4C5B3322B53; Mon, 22 Jul
 2024 11:43:54 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 145B240317; Mon, 22 Jul
 2024 11:43:54 +0200 (CEST)
X-Quarantine-ID: <2hqi8tId6onf>
X-Secumail-id: <1813.669e29da.4a0de.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>,
 devicetree@vger.kernel.org
Subject: [RFC PATCH v3 36/37] kvx: dts: DeviceTree for qemu emulated
 Coolidge SoC
Date: Mon, 22 Jul 2024 11:41:47 +0200
Message-ID: <20240722094226.21602-37-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add device tree for QEMU that emulates a Coolidge V1 SoC.

Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:

V2 -> V3: New patch
---
 arch/kvx/boot/dts/Makefile          |   1 +
 arch/kvx/boot/dts/coolidge-qemu.dts | 444 ++++++++++++++++++++++++++++
 2 files changed, 445 insertions(+)
 create mode 100644 arch/kvx/boot/dts/Makefile
 create mode 100644 arch/kvx/boot/dts/coolidge-qemu.dts

diff --git a/arch/kvx/boot/dts/Makefile b/arch/kvx/boot/dts/Makefile
new file mode 100644
index 0000000000000..cd27ceb7a6cce
--- /dev/null
+++ b/arch/kvx/boot/dts/Makefile
@@ -0,0 +1 @@
+dtb-y += coolidge-qemu.dtb
diff --git a/arch/kvx/boot/dts/coolidge-qemu.dts b/arch/kvx/boot/dts/coolidge-qemu.dts
new file mode 100644
index 0000000000000..1d5af0d2e687d
--- /dev/null
+++ b/arch/kvx/boot/dts/coolidge-qemu.dts
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/dts-v1/;
+/*
+ * Copyright (C) 2024, Kalray Inc.
+ */
+
+/ {
+	model = "Kalray Coolidge processor (QEMU)";
+	compatible = "kalray,coolidge-qemu";
+	#address-cells = <0x02>;
+	#size-cells = <0x02>;
+
+	chosen {
+		stdout-path = "/axi/serial@20210000";
+	};
+
+	memory@100000000 {
+		phandle = <0x40>;
+		reg = <0x01 0x00 0x00 0x8000000>;
+		device_type = "memory";
+	};
+
+	axi {
+		compatible = "simple-bus";
+		#address-cells = <0x02>;
+		#size-cells = <0x02>;
+		ranges;
+
+		virtio-mmio@30003c00 {
+			compatible = "virtio,mmio";
+			reg = <0x00 0x30003c00 0x00 0x200>;
+			interrupt-parent = <&itgen0>;
+			interrupts = <0x9e 0x04>;
+		};
+
+		virtio-mmio@30003e00 {
+			compatible = "virtio,mmio";
+			reg = <0x00 0x30003e00 0x00 0x200>;
+			interrupt-parent = <&itgen0>;
+			interrupts = <0x9f 0x04>;
+		};
+
+		itgen0: itgen_soc_periph0@27000000 {
+			compatible = "kalray,coolidge-itgen";
+			reg = <0x00 0x27000000 0x00 0x1104>;
+			msi-parent = <&apic_mailbox>;
+			#interrupt-cells = <0x02>;
+			interrupt-controller;
+		};
+
+		serial@20210000 {
+			reg-shift = <0x02>;
+			reg-io-width = <0x04>;
+			clocks = <&ref_clk>;
+			interrupts = <0x29 0x04>;
+			interrupt-parent = <&itgen0>;
+			reg = <0x00 0x20210000 0x00 0x100>;
+			compatible = "snps,dw-apb-uart";
+		};
+
+		serial@20211000 {
+			reg-shift = <0x02>;
+			reg-io-width = <0x04>;
+			phandle = <0x3c>;
+			clocks = <&ref_clk>;
+			interrupts = <0x2a 0x04>;
+			interrupt-parent = <&itgen0>;
+			reg = <0x00 0x20211000 0x00 0x100>;
+			compatible = "snps,dw-apb-uart";
+		};
+
+		serial@20212000 {
+			reg-shift = <0x02>;
+			reg-io-width = <0x04>;
+			phandle = <0x3b>;
+			clocks = <&ref_clk>;
+			interrupts = <0x2b 0x04>;
+			interrupt-parent = <&itgen0>;
+			reg = <0x00 0x20212000 0x00 0x100>;
+			compatible = "snps,dw-apb-uart";
+		};
+
+		serial@20213000 {
+			reg-shift = <0x02>;
+			reg-io-width = <0x04>;
+			phandle = <0x3a>;
+			clocks = <&ref_clk>;
+			interrupts = <0x2c 0x04>;
+			interrupt-parent = <&itgen0>;
+			reg = <0x00 0x20213000 0x00 0x100>;
+			compatible = "snps,dw-apb-uart";
+		};
+
+		serial@20214000 {
+			reg-shift = <0x02>;
+			reg-io-width = <0x04>;
+			phandle = <0x39>;
+			clocks = <&ref_clk>;
+			interrupts = <0x2d 0x04>;
+			interrupt-parent = <&itgen0>;
+			reg = <0x00 0x20214000 0x00 0x100>;
+			compatible = "snps,dw-apb-uart";
+		};
+
+		serial@20215000 {
+			reg-shift = <0x02>;
+			reg-io-width = <0x04>;
+			phandle = <0x38>;
+			clocks = <&ref_clk>;
+			interrupts = <0x2e 0x04>;
+			interrupt-parent = <&itgen0>;
+			reg = <0x00 0x20215000 0x00 0x100>;
+			compatible = "snps,dw-apb-uart";
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00 0x00 0x00 0x400000>;
+	};
+
+	apic_mailbox: apic_mailbox@a00000 {
+		compatible = "kalray,coolidge-apic-mailbox";
+		reg = <0x00 0xa00000 0x00 0xea00>;
+		#interrupt-cells = <0x00>;
+		#address-cells = <0>;
+		interrupt-parent = <&apic_gic>;
+		interrupts = <0x00>, <0x01>, <0x02>, <0x03>, <0x04>, <0x05>,
+			     <0x06>, <0x07>, <0x08>, <0x09>, <0x0a>, <0x0b>,
+			     <0x0c>, <0x0d>, <0x0e>, <0x0f>, <0x10>, <0x11>,
+			     <0x12>, <0x13>, <0x14>, <0x15>, <0x16>, <0x17>,
+			     <0x18>, <0x19>, <0x1a>, <0x1b>, <0x1c>, <0x1d>,
+			     <0x1e>, <0x1f>, <0x20>, <0x21>, <0x22>, <0x23>,
+			     <0x24>, <0x25>, <0x26>, <0x27>, <0x28>, <0x29>,
+			     <0x2a>, <0x2b>, <0x2c>, <0x2d>, <0x2e>, <0x2f>,
+			     <0x30>, <0x31>, <0x32>, <0x33>, <0x34>, <0x35>,
+			     <0x36>, <0x37>, <0x38>, <0x39>, <0x3a>, <0x3b>,
+			     <0x3c>, <0x3d>, <0x3e>, <0x3f>, <0x40>, <0x41>,
+			     <0x42>, <0x43>, <0x44>, <0x45>, <0x46>, <0x47>,
+			     <0x48>, <0x49>, <0x4a>, <0x4b>, <0x4c>, <0x4d>,
+			     <0x4e>, <0x4f>, <0x50>, <0x51>, <0x52>, <0x53>,
+			     <0x54>, <0x55>, <0x56>, <0x57>, <0x58>, <0x59>,
+			     <0x5a>, <0x5b>, <0x5c>, <0x5d>, <0x5e>, <0x5f>,
+			     <0x60>, <0x61>, <0x62>, <0x63>, <0x64>, <0x65>,
+			     <0x66>, <0x67>, <0x68>, <0x69>, <0x6a>, <0x6b>,
+			     <0x6c>, <0x6d>, <0x6e>, <0x6f>, <0x70>, <0x71>,
+			     <0x72>, <0x73>, <0x74>;
+		interrupt-controller;
+		msi-controller;
+	};
+
+	apic_gic: apic_gic@a20000 {
+		compatible = "kalray,coolidge-apic-gic";
+		reg = <0x00 0xa20000 0x00 0x12000>;
+		#interrupt-cells = <0x01>;
+		interrupts-extended = <&core_intc0 0x4>,
+				      <&core_intc1 0x4>,
+				      <&core_intc2 0x4>,
+				      <&core_intc3 0x4>,
+				      <&core_intc4 0x4>,
+				      <&core_intc5 0x4>,
+				      <&core_intc6 0x4>,
+				      <&core_intc7 0x4>,
+				      <&core_intc8 0x4>,
+				      <&core_intc9 0x4>,
+				      <&core_intc10 0x4>,
+				      <&core_intc11 0x4>,
+				      <&core_intc12 0x4>,
+				      <&core_intc13 0x4>,
+				      <&core_intc14 0x4>,
+				      <&core_intc15 0x4>;
+		interrupt-controller;
+	};
+
+	pwr_ctrl: pwr_ctrl@a40000 {
+		compatible = "kalray,coolidge-pwr-ctrl";
+		reg = <0x00 0xa40000 0x00 0x4188>;
+	};
+
+	dsu_clock@a44180 {
+		compatible = "kalray,coolidge-dsu-clock";
+		reg = <0x00 0xa44180 0x00 0x08>;
+		clocks = <&core_clk>;
+	};
+
+	ipi_ctrl@ad0000 {
+		compatible = "kalray,coolidge-ipi-ctrl";
+		reg = <0x00 0xad0000 0x00 0x1000>;
+		#interrupt-cells = <0>;
+		interrupt-controller;
+		interrupts-extended = <&core_intc0 0x18>,
+				      <&core_intc1 0x18>,
+				      <&core_intc2 0x18>,
+				      <&core_intc3 0x18>,
+				      <&core_intc4 0x18>,
+				      <&core_intc5 0x18>,
+				      <&core_intc6 0x18>,
+				      <&core_intc7 0x18>,
+				      <&core_intc8 0x18>,
+				      <&core_intc9 0x18>,
+				      <&core_intc10 0x18>,
+				      <&core_intc11 0x18>,
+				      <&core_intc12 0x18>,
+				      <&core_intc13 0x18>,
+				      <&core_intc14 0x18>,
+				      <&core_intc15 0x18>;
+	};
+
+	core_timer {
+		compatible = "kalray,kv3-1-timer";
+		clocks = <&core_clk>;
+		interrupts-extended = <&core_intc0 0>,
+				      <&core_intc1 0>,
+				      <&core_intc2 0>,
+				      <&core_intc3 0>,
+				      <&core_intc4 0>,
+				      <&core_intc5 0>,
+				      <&core_intc6 0>,
+				      <&core_intc7 0>,
+				      <&core_intc8 0>,
+				      <&core_intc9 0>,
+				      <&core_intc10 0>,
+				      <&core_intc11 0>,
+				      <&core_intc12 0>,
+				      <&core_intc13 0>,
+				      <&core_intc14 0>,
+				      <&core_intc15 0>;
+	};
+
+	clocks {
+
+		core_clk: core_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <0x3b9aca00>;
+			#clock-cells = <0x00>;
+		};
+
+		ref_clk: ref_clk {
+			clock-frequency = <0x5f5e100>;
+			#clock-cells = <0x00>;
+			compatible = "fixed-clock";
+		};
+	};
+
+	cpus {
+		#address-cells = <0x01>;
+		#size-cells = <0x00>;
+		enable-method = "kalray,coolidge-pwr-ctrl";
+
+		cpu@0 {
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			device_type = "cpu";
+			reg = <0x00>;
+			clocks = <&core_clk>;
+			core_intc0: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			reg = <0x01>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc1: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@2 {
+			device_type = "cpu";
+			reg = <0x02>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc2: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@3 {
+			device_type = "cpu";
+			reg = <0x03>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc3: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@4 {
+			device_type = "cpu";
+			reg = <0x04>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc4: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@5 {
+			device_type = "cpu";
+			reg = <0x05>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc5: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@6 {
+			device_type = "cpu";
+			reg = <0x06>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc6: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@7 {
+			device_type = "cpu";
+			reg = <0x07>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc7: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@8 {
+			device_type = "cpu";
+			reg = <0x08>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc8: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@9 {
+			device_type = "cpu";
+			reg = <0x09>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc9: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@10 {
+			device_type = "cpu";
+			reg = <0x0a>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc10: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@11 {
+			device_type = "cpu";
+			reg = <0x0b>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc11: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@12 {
+			device_type = "cpu";
+			reg = <0x0c>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc12: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@13 {
+			device_type = "cpu";
+			reg = <0x0d>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc13: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@14 {
+			device_type = "cpu";
+			reg = <0x0e>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc14: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@15 {
+			device_type = "cpu";
+			reg = <0x0f>;
+			compatible = "kalray,kv3-1-pe","kalray,kv3-pe";
+			core_intc15: interrupt-controller {
+				compatible = "kalray,kv3-1-intc";
+				#interrupt-cells = <0x01>;
+				#address-cells = <0x0>;
+				interrupt-controller;
+			};
+		};
+
+	};
+};
-- 
2.45.2






