Return-Path: <linux-kernel+bounces-555584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4C6A5B9EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2BD189577A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41DB226541;
	Tue, 11 Mar 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="fKovntj/"
Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC322424D;
	Tue, 11 Mar 2025 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678489; cv=none; b=D/RFXuJZ/CdoJEFYAg6RykikpiajHaiLgiNBcTzzO4Yzz0m0rucqIDSSqBWs1UpH0AC59/dyRB8+qr2C3JWe7/SzjS9ClsCjaS9rgyY2fJ4wXKvT4LSXqYkHZn2JUnuaXlUt+R2KsmyUd3GgRse5e17y8lZFkofcCfPhnubreWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678489; c=relaxed/simple;
	bh=OlTwGJq5C8DtMOuzRZSljPeS7nOzR9eMMgD0BWnqD1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDoo0cF+MSZn5UsceOLLcfRghmDtU2BQTyUPdDbf2GiHVmtl0SXQxAoa816uQ6FW4MCvlgqjgc9vHkW46/32WAgoxhOleQ59bfX5eFkq/i7lajVPF8KO1Oj+j8q8NdcUR1KajpwTvQ9rE6jjJCwXHltnvKInXoY28CXFS7scRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=fKovntj/; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=11140;
  q=dns/txt; s=NAESA-Selector1; t=1741678487;
  x=1773214487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OlTwGJq5C8DtMOuzRZSljPeS7nOzR9eMMgD0BWnqD1g=;
  b=fKovntj/Ap5QvGrnluCIWGaahE6cUEacXM2dPGVsuorfv9igb83Eli4M
   qDhfnjVn8oNK7J8GzsS1YkU51w8rwrPcgpnuFWKsPhZ4qR+FDmdOE2a/O
   a6afQE/x5WekYW3kQgAqIbqlr+gA4m5auKWf/z8ZyBwYbz6NndCmm7uAf
   93CBQ3iM/f5vCjpl1Y+/sOPgBgmVl33HiyiePhRqjprJ89OY+hJRpMdHX
   eQLlFtLptVJOT45HWIxWgt3AddFZnWHFIHKTofZyYD22hrmwwD5+D8K5G
   0XXYRSbEsd+eDBoouk3+Wu0bl47dvJMXUQnf8Ti2RWMM7sNMs0XUhlNjd
   A==;
X-CSE-ConnectionGUID: yA8cnimqSoS83Sb/FWXhIg==
X-CSE-MsgGUID: H5UtKOKJRo2Jti6ft8pqKQ==
X-IronPort-AV: E=Sophos;i="6.14,238,1736838000"; 
   d="scan'208";a="20386417"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 11 Mar 2025 01:34:46 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Tue, 11 Mar 2025 13:04:33 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl,
	Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] riscv: dts: add initial support for EIC7700 SoC
Date: Tue, 11 Mar 2025 13:04:31 +0530
Message-Id: <20250311073432.4068512-10-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Mar 2025 07:34:33.0196 (UTC) FILETIME=[085272C0:01DB9258]

From: Min Lin <linmin@eswincomputing.com>

Add initial support for EIC7700 SoC that uses a SiFive Quad-Core
P550 CPU cluster.

This file is expected to grow as more device drivers are added to the
kernel.

Signed-off-by: Min Lin <linmin@eswincomputing.com>
Co-developed-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Co-developed-by: Darshan Prajapati <darshan.prajapati@einfochips.com>
Signed-off-by: Darshan Prajapati <darshan.prajapati@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 MAINTAINERS                            |   1 +
 arch/riscv/boot/dts/eswin/eic7700.dtsi | 344 +++++++++++++++++++++++++
 2 files changed, 345 insertions(+)
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 901d0e0adb25..475122cf0ce3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8577,6 +8577,7 @@ M:	Min Lin <linmin@eswincomputing.com>
 M:	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
 M:	Pritesh Patel <pritesh.patel@einfochips.com>
 S:	Maintained
+F:	arch/riscv/boot/dts/eswin/
 
 ET131X NETWORK DRIVER
 M:	Mark Einon <mark.einon@gmail.com>
diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
new file mode 100644
index 000000000000..9cef940f07e4
--- /dev/null
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2024 Beijing ESWIN Computing Technology Co., Ltd.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <1000000>;
+
+		cpu0: cpu@0 {
+			compatible = "sifive,p550", "riscv";
+			device_type = "cpu";
+			d-cache-block-size = <64>;
+			d-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv48";
+			next-level-cache = <&l2_cache_0>;
+			reg = <0x0>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "sscofpmf",
+					       "zba", "zbb", "zicsr", "zifencei";
+			tlb-split;
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu1: cpu@1 {
+			compatible = "sifive,p550", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv48";
+			next-level-cache = <&l2_cache_1>;
+			reg = <0x1>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "sscofpmf",
+					       "zba", "zbb", "zicsr", "zifencei";
+			tlb-split;
+
+			cpu1_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu2: cpu@2 {
+			compatible = "sifive,p550", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv48";
+			next-level-cache = <&l2_cache_2>;
+			reg = <0x2>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "sscofpmf",
+					       "zba", "zbb", "zicsr", "zifencei";
+			tlb-split;
+
+			cpu2_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu3: cpu@3 {
+			compatible = "sifive,p550", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv48";
+			next-level-cache = <&l2_cache_3>;
+			reg = <0x3>;
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "sscofpmf",
+					       "zba", "zbb", "zicsr", "zifencei";
+			tlb-split;
+
+			cpu3_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		l2_cache_0: l2-cache0 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <512>;
+			cache-size = <262144>;
+			cache-unified;
+			next-level-cache = <&ccache>;
+		};
+
+		l2_cache_1: l2-cache1 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <512>;
+			cache-size = <262144>;
+			cache-unified;
+			next-level-cache = <&ccache>;
+		};
+
+		l2_cache_2: l2-cache2 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <512>;
+			cache-size = <262144>;
+			cache-unified;
+			next-level-cache = <&ccache>;
+		};
+
+		l2_cache_3: l2-cache3 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <512>;
+			cache-size = <262144>;
+			cache-unified;
+			next-level-cache = <&ccache>;
+		};
+	};
+
+	pmu {
+		compatible = "riscv,pmu";
+		riscv,event-to-mhpmcounters =
+				<0x00001 0x00001 0x00000001>,
+				<0x00002 0x00002 0x00000004>,
+				<0x00004 0x00006 0x00000078>,
+				<0x10009 0x10009 0x00000078>,
+				<0x10019 0x10019 0x00000078>,
+				<0x10021 0x10021 0x00000078>;
+		riscv,event-to-mhpmevent =
+				<0x00004 0x00000000 0x00000202>,
+				<0x00005 0x00000000 0x00004000>,
+				<0x00006 0x00000000 0x00002001>,
+				<0x10009 0x00000000 0x00000102>,
+				<0x10019 0x00000000 0x00001002>,
+				<0x10021 0x00000000 0x00000802>;
+		riscv,raw-event-to-mhpmcounters =
+				<0x00000000 0x00000000 0xffffffff 0xfc0000ff 0x00000078>,
+				<0x00000000 0x00000001 0xffffffff 0xfffe07ff 0x00000078>,
+				<0x00000000 0x00000002 0xffffffff 0xfffe00ff 0x00000078>,
+				<0x00000000 0x00000003 0xfffffffc 0x000000ff 0x00000078>,
+				<0x00000000 0x00000004 0xffffffc0 0x000000ff 0x00000078>,
+				<0x00000000 0x00000005 0xffffffff 0xfffffdff 0x00000078>,
+				<0x00000000 0x00000006 0xfffffe00 0x110204ff 0x00000078>,
+				<0x00000000 0x00000007 0xffffffff 0xf00000ff 0x00000078>,
+				<0x00000000 0x00000008 0xfffffe04 0x000000ff 0x00000078>,
+				<0x00000000 0x00000009 0xffffffff 0xffffc0ff 0x00000078>,
+				<0x00000000 0x0000000a 0xffffffff 0xf00000ff 0x00000078>,
+				<0x00000000 0x0000000b 0xffffffff 0xfffffcff 0x00000078>,
+				<0x00000000 0x0000000c 0xfffffff0 0x000000ff 0x00000078>,
+				<0x00000000 0x0000000d 0xffffffff 0x800000ff 0x00000078>,
+				<0x00000000 0x0000000e 0xffffffff 0xf80000ff 0x00000078>,
+				<0x00000000 0x0000000f 0xfffffffc 0x000000ff 0x00000078>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges;
+		interrupt-parent = <&plic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		clint: timer@2000000 {
+			compatible = "eswin,eic7700-clint", "sifive,clint0";
+			reg = <0x0 0x02000000 0x0 0x10000>;
+			interrupts-extended =
+				<&cpu0_intc 3>, <&cpu0_intc 7>,
+				<&cpu1_intc 3>, <&cpu1_intc 7>,
+				<&cpu2_intc 3>, <&cpu2_intc 7>,
+				<&cpu3_intc 3>, <&cpu3_intc 7>;
+		};
+
+		ccache: cache-controller@2010000 {
+			compatible = "eswin,eic7700-l3-cache", "sifive,ccache0", "cache";
+			reg = <0x0 0x2010000 0x0 0x4000>;
+			interrupts = <1>, <3>, <4>, <2>;
+			cache-block-size = <64>;
+			cache-level = <3>;
+			cache-sets = <4096>;
+			cache-size = <4194304>;
+			cache-unified;
+		};
+
+		plic: interrupt-controller@c000000 {
+			compatible = "eswin,eic7700-plic", "sifive,plic-1.0.0";
+			reg = <0x0 0xc000000 0x0 0x4000000>;
+			interrupt-controller;
+			interrupts-extended =
+				<&cpu0_intc 11>, <&cpu0_intc 9>,
+				<&cpu1_intc 11>, <&cpu1_intc 9>,
+				<&cpu2_intc 11>, <&cpu2_intc 9>,
+				<&cpu3_intc 11>, <&cpu3_intc 9>;
+			riscv,ndev = <520>;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
+
+		uart0: serial@50900000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x50900000 0x0 0x10000>;
+			interrupts = <100>;
+			clock-frequency = <200000000>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart1: serial@50910000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x50910000 0x0 0x10000>;
+			interrupts = <101>;
+			clock-frequency = <200000000>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart2: serial@50920000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x50920000 0x0 0x10000>;
+			interrupts = <102>;
+			clock-frequency = <200000000>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart3: serial@50930000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x50930000 0x0 0x10000>;
+			interrupts = <103>;
+			clock-frequency = <200000000>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart4: serial@50940000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x50940000 0x0 0x10000>;
+			interrupts = <104>;
+			clock-frequency = <200000000>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		gpio@51600000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x0 0x51600000 0x0 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			porta: gpio-port@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts =
+					<303>, <304>, <305>, <306>, <307>, <308>, <309>,
+					<310>, <311>, <312>, <313>, <314>, <315>, <316>,
+					<317>, <318>, <319>, <320>, <321>, <322>, <323>,
+					<324>, <325>, <326>, <327>, <328>, <329>, <330>,
+					<331>, <332>, <333>, <334>;
+				gpio-controller;
+				ngpios = <32>;
+				#gpio-cells = <2>;
+			};
+
+			portb: gpio-port@1 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <1>;
+				gpio-controller;
+				ngpios = <32>;
+				#gpio-cells = <2>;
+			};
+
+			portc: gpio-port@2 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <2>;
+				gpio-controller;
+				ngpios = <32>;
+				#gpio-cells = <2>;
+			};
+
+			portd: gpio-port@3 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <3>;
+				gpio-controller;
+				ngpios = <16>;
+				#gpio-cells = <2>;
+			};
+		};
+	};
+};
-- 
2.25.1


