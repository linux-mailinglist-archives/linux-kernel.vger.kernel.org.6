Return-Path: <linux-kernel+bounces-301952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8765295F7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D411F223DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B879199E9F;
	Mon, 26 Aug 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CNhLNeM6"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5EE64A;
	Mon, 26 Aug 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692942; cv=none; b=KHSFA+lxqIIAtns9X/R63+Pvlhk7OF/zvmhZ1uBDOFofYgeWEplQDfYk3xJHHPEaeTzuE60mduhqECJ/+8qV5KkcrkQJLEpCqlL7Lhdpvzt8U/k+oCJXmxaN7QR2lw7glDa0EgxSelhA4f0fhLiBbN0mtQ0lK04HlRHcnzMVdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692942; c=relaxed/simple;
	bh=+t2QsUzWlxD2p+UigAU7JUTDwR8Z1hz/lp225aXq0a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ogPFwv7szdYbP01aGA86Q+KU+bacNIZkrWQtWWgVvdQhLf3LF0h8JALqRh70a9u8ddqvEpbQ6l/F3fcUxR7aCx7DVTayt9QtJsWEk752EOL/9IG8n2RsD1twpMMToqn9VrvWaNv6A/ywf6zFoUZNh8MsgEyqAPno+sMCSm3oeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CNhLNeM6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QHMB7d094910;
	Mon, 26 Aug 2024 12:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724692931;
	bh=kNuTm8lAOHO3C+44VM0mLOGP+MoYxyo02eLcYTQ76j0=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=CNhLNeM65ksL1uTNcx12EG/lSv1ghYq1aJZrWIixdgwnLdd2S/enULabt3Bn1Pou2
	 /iY0w3YlwY7RWiMOqxBnFUy+Y3crocy8XuBedkZ8QbPTmw48QjqrT6V+EwULqDFyR1
	 TFLdhrth2ovwYKllc/mCYqwQWxBdd/3cr1Md4zxw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QHMB7k026465
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 12:22:11 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 12:22:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 12:22:11 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QHMBrb123048;
	Mon, 26 Aug 2024 12:22:11 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 26 Aug 2024 12:22:09 -0500
Subject: [PATCH v3 3/4] arm64: dts: ti: k3-am62p: add opp frequencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240826-opp-v3-3-0934f8309e13@ti.com>
References: <20240826-opp-v3-0-0934f8309e13@ti.com>
In-Reply-To: <20240826-opp-v3-0-0934f8309e13@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3884; i=bb@ti.com;
 h=from:subject:message-id; bh=+t2QsUzWlxD2p+UigAU7JUTDwR8Z1hz/lp225aXq0a8=;
 b=owNCWmg5MUFZJlNZUhgbKgAAav///7/7/+f/rTbtn5+r2Wcz1d/+xR9tf9/9/w/8qvb83d+wA
 RmYjNUAGgAAaAAAA0NGgDQ0ABoNAAAyAANANAAyAaGmh6Q9QyDYTU8UQANNDRkMmg0A0GTTJkGm
 gaGhoAA00MmEDQAaD1GmmmQaGQ9QaDQ0PIjQ0BiBoODKZPUDIeoaNAyBhA9TENAaDTQAYQGmgB6
 hoA0eoMgANNGjQ0DQNAAANAAANcKiBEWCgoC3hFu2GGgWdFGeCPIxO6VLNBjD4OBZqw2w/AWwc6
 vZHcU4n62ITgMMCPbS2VSCxkUXEDRMvtJtU2WZ9OpgwSR7yd/eNo3V7iFzq0XvediFUQBjiSHnR
 mX4LViGB4kBbJhj3gHGvkD0+o8EacbX4hP+ETK/Isysp3F8QSqiqfvQzK/G4rjoD2QE6sB2NWqQ
 0dDWjC8Ys1N3F18c9e7g9ROMFQIVy+hH2KnDAhg8jhmFWur5BYApKOmIXoXj3MHOK5ygUUV4n/a
 Oe7/FapxNUSndCwTsq0jqTiHZDC/tbLPpiFvnDDBBniyYJOskUowbz1BLBL+4b7Y6aC+AnJAUiF
 EMJYAL/F5uyrAPTr5GpAlRisxAxaoMDE72h1AuXCsPQwk2VfSfgZCoiiibs+YDe2+tt/KNjezUa
 3/F3JFOFCQUhgbKgA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

One power management technique available to the Cortex-A53s is their
ability to dynamically scale their frequency across the device's
Operating Performance Points (OPP)

The OPPs available for the Cortex-A53s on the AM62Px can vary based on
the silicon variant used. The SoC variant is encoded into the
WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register which is used to limit
the OPP entries the SoC supports. A table of all these variants can be
found in its data sheet[0] for the AM62Px processor family.

Add the OPP table into the SoC's fdti file along with the syscon node to
describe the WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register to detect
the SoC variant.

[0] https://www.ti.com/lit/ds/symlink/am62p-q1.pdf

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes from v2:
- Miscellaneous spelling fixes in commit body
- Link: https://lore.kernel.org/r/20240823-opp-v2-0-e2f67b37c299@ti.com
---
 .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  5 +++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi              | 47 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
index 315d0092e7366..6f32135f00a55 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
@@ -20,6 +20,11 @@ chipid: chipid@14 {
 			bootph-all;
 		};
 
+		opp_efuse_table: syscon@18 {
+			compatible = "ti,am62-opp-efuse-table", "syscon";
+			reg = <0x18 0x4>;
+		};
+
 		cpsw_mac_syscon: ethernet-mac-syscon@200 {
 			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
 			reg = <0x200 0x8>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
index 41f479dca4555..140587d02e88e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
@@ -47,6 +47,7 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 135 0>;
 		};
 
@@ -62,6 +63,7 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 136 0>;
 		};
 
@@ -77,6 +79,7 @@ cpu2: cpu@2 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 137 0>;
 		};
 
@@ -92,10 +95,54 @@ cpu3: cpu@3 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 138 0>;
 		};
 	};
 
+	a53_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		opp-shared;
+		syscon = <&opp_efuse_table>;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x01 0x0006>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1250000000 {
+			opp-hz = /bits/ 64 <1250000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+			opp-suspend;
+		};
+	};
+
 	l2_0: l2-cache0 {
 		compatible = "cache";
 		cache-unified;

-- 
2.46.0


