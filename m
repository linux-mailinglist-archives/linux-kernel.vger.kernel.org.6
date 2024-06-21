Return-Path: <linux-kernel+bounces-223856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B391196F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C0E286029
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5A115A846;
	Fri, 21 Jun 2024 04:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="whoXJyjC"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C9A12DD90
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718944079; cv=none; b=UZXwtZPAKirPYoqewaUxmhxFO2p9JpsfQthTAsx+Ji6tJNxkAFU2AYJBdoXgYQFBQDRR6zagjsmccf+/TcDkRMUjiGgtBKvg638631NUzR7Hvm9Bwd3D+2keUCJtFSPN7aX6cWDkSoVRSp0Msyx0td5sXzOhC0vF6WEX7+oblZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718944079; c=relaxed/simple;
	bh=kxsLXwle6gFtuh661k++ZNvghjzuFfcqbh4/sPpmdSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh0hiRFNBX6K66vEC2R1+iRVCV+SjvaTuPsgcn+Johskt6zjryodNuMcRTF9aBVnQOt33aezRfsC6fE8qG951MWh9mEYfyaz4J9v++Pty1CdwN7xGPg/jnOK79XoLgC9tQupdJJiCHHd4JDhY0YO9n5yCDJ6wIt3oKO+nwEL8Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=whoXJyjC; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 022692C044B;
	Fri, 21 Jun 2024 16:27:45 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718944065;
	bh=B1yeaoEsau+/HF9aMUxPE70V+9UI3cn1YqdyaLzd7Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=whoXJyjCf5ditrQuMpespEX47tBYUhznBFcVHjSZRPs+9e2+3F5VGBWFwAmDJmPdD
	 jgywn8QUsh8ARvShbE3wG9JnINCepMe0jqNayphSlXjh9TospnIeL6w41bcxme8mpY
	 FMGaJmfS+iFsSpG21J+Gn2atmfyYhOl1F697H0rw8KRAfT3ZkwcTiw4Q2wGMTrBdNa
	 Tslip5mQVw8Dck2Eb/Z/9TdcaU0KP7rkR7ZaGPVmgE8bYIbma4ZHrkA4kTFwiRgT2G
	 CamujiAlJP9HqeSbHeHOYDpwzU6+Jp2MLC6vvZPxmDNgxuwP+rQM4dUfrP4HTnoYl0
	 vNUbyThM0jTtQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B667501400006>; Fri, 21 Jun 2024 16:27:44 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 5C6B613EE94;
	Fri, 21 Jun 2024 16:27:44 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 5B089280BEA; Fri, 21 Jun 2024 16:27:44 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: tglx@linutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de,
	daniel.lezcano@linaro.org,
	paulburton@kernel.org,
	peterz@infradead.org,
	mail@birger-koblitz.de,
	bert@biot.com,
	john@phrozen.org,
	sander@svanheule.net
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	kabel@kernel.org,
	ericwouds@gmail.com,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 6/6] mips: dts: realtek: Add RTL9302C board
Date: Fri, 21 Jun 2024 16:27:37 +1200
Message-ID: <20240621042737.674128-7-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621042737.674128-1-chris.packham@alliedtelesis.co.nz>
References: <20240621042737.674128-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=66750140 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=T1WGqf2p2xoA:10 a=FkagyKZCYwirPjr5IuAA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add support for the RTL930x SoC and the RTL9302C reference board.

The RTL930x family of SoCs are Realtek switches with an embedded MIPS
core (800MHz 34Kc). Most of the peripherals are similar to the RTL838x
SoC and can make use of many existing drivers.

Add in full DSA switch support is still a work in progress.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/mips/boot/dts/realtek/Makefile     |  1 +
 arch/mips/boot/dts/realtek/RTL9302C.dts | 74 +++++++++++++++++++++++
 arch/mips/boot/dts/realtek/rtl930x.dtsi | 78 +++++++++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 arch/mips/boot/dts/realtek/RTL9302C.dts
 create mode 100644 arch/mips/boot/dts/realtek/rtl930x.dtsi

diff --git a/arch/mips/boot/dts/realtek/Makefile b/arch/mips/boot/dts/rea=
ltek/Makefile
index fba4e93187a6..54dc2d280cd5 100644
--- a/arch/mips/boot/dts/realtek/Makefile
+++ b/arch/mips/boot/dts/realtek/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-y	+=3D cisco_sg220-26.dtb
+dtb-y	+=3D RTL9302C.dtb
diff --git a/arch/mips/boot/dts/realtek/RTL9302C.dts b/arch/mips/boot/dts=
/realtek/RTL9302C.dts
new file mode 100644
index 000000000000..d921067d5006
--- /dev/null
+++ b/arch/mips/boot/dts/realtek/RTL9302C.dts
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/dts-v1/;
+
+#include "rtl930x.dtsi"
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	compatible =3D "realtek,RTL9302C", "realtek,rtl930x-soc";
+	model =3D "RTL9302C Development Board";
+
+	memory@0 {
+		device_type =3D "memory";
+		reg =3D <0x0 0x8000000>;
+	};
+
+	chosen {
+		bootargs =3D "earlycon";
+		stdout-path =3D "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status =3D "okay";
+};
+
+&spi0 {
+	status =3D "okay";
+	flash@0 {
+		compatible =3D "jedec,spi-nor";
+		reg =3D <0>;
+		spi-max-frequency =3D <10000000>;
+
+		partitions {
+			compatible =3D "fixed-partitions";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+
+			partition@0 {
+				label =3D "u-boot";
+				reg =3D <0x0 0xe0000>;
+				read-only;
+			};
+			partition@e0000 {
+				label =3D "u-boot-env";
+				reg =3D <0xe0000 0x10000>;
+			};
+			partition@f0000 {
+				label =3D "u-boot-env2";
+				reg =3D <0xf0000 0x10000>;
+				read-only;
+			};
+			partition@100000 {
+				label =3D "jffs";
+				reg =3D <0x100000 0x100000>;
+			};
+			partition@200000 {
+				label =3D "jffs2";
+				reg =3D <0x200000 0x100000>;
+			};
+			partition@300000 {
+				label =3D "runtime";
+				reg =3D <0x300000 0xe80000>;
+			};
+			partition@1180000 {
+				label =3D "runtime2";
+				reg =3D <0x1180000 0xe80000>;
+			};
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/realtek/rtl930x.dtsi b/arch/mips/boot/dts=
/realtek/rtl930x.dtsi
new file mode 100644
index 000000000000..5e088c90d2ee
--- /dev/null
+++ b/arch/mips/boot/dts/realtek/rtl930x.dtsi
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+
+#include "rtl83xx.dtsi"
+
+/ {
+	compatible =3D "realtek,rtl930x-soc";
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		cpu@0 {
+			compatible =3D "mips,mips34Kc";
+			reg =3D <0>;
+			clocks =3D <&baseclk 0>;
+			clock-names =3D "cpu";
+		};
+	};
+
+	baseclk: baseclk {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <800000000>;
+	};
+
+	lx_clk: lx_clk {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency  =3D <175000000>;
+	};
+};
+
+&soc {
+	intc: interrupt-controller@3000 {
+		compatible =3D "realtek,rtl9300-intc", "realtek,rtl-intc";
+		reg =3D <0x3000 0x18>, <0x3018 0x18>;
+		interrupt-controller;
+		#interrupt-cells =3D <2>;
+
+		interrupt-parent =3D <&cpuintc>;
+		interrupts =3D <2>, <3>, <4>, <5>, <6>, <7>;
+	};
+
+	spi0: spi@1200 {
+		compatible =3D "realtek,rtl8380-spi";
+		reg =3D <0x1200 0x100>;
+
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+	};
+
+	timer0: timer@3200 {
+		compatible =3D "realtek,rtl930x-timer", "realtek,otto-timer";
+		reg =3D <0x3200 0x10>, <0x3210 0x10>, <0x3220 0x10>,
+		    <0x3230 0x10>, <0x3240 0x10>;
+
+		interrupt-parent =3D <&intc>;
+		interrupts =3D <7 4>, <8 4>, <9 4>, <10 4>, <11 4>;
+		clocks =3D <&lx_clk>;
+	};
+};
+
+&uart0 {
+	/delete-property/ clock-frequency;
+	clocks =3D <&lx_clk>;
+
+	interrupt-parent =3D <&intc>;
+	interrupts =3D <30 1>;
+};
+
+&uart1 {
+	/delete-property/ clock-frequency;
+	clocks =3D <&lx_clk>;
+
+	interrupt-parent =3D <&intc>;
+	interrupts =3D <31 0>;
+};
+
--=20
2.45.2


