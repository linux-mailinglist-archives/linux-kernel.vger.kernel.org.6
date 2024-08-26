Return-Path: <linux-kernel+bounces-301955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEE195F7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A1C282B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C607B19AA53;
	Mon, 26 Aug 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KSl4i+Uc"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5008A19A29A;
	Mon, 26 Aug 2024 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692950; cv=none; b=D1llX1D5bcSeZ58tsUXzAAh0/f/AKcH9QwUVfg7Evz5AANHUzsxjcDWTTsgYWb9OhPvgJapRoOLBGcBOGboR21kgL+5YVyvm17iwjOyCi4tAz8FZUKq1Q1r58NxcTGMiyQxAeo1CgZCVcqqfk3hEckPa7BM+skMIK1niA0lhFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692950; c=relaxed/simple;
	bh=/EX+DTBukK08UXUkfiuLtOXmX5lBgrF3Wye1Fu8yH+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HAqlyARSOkLXYIsSxROilsf9VQtJsQouu6ywgiMDsl0OaETj/fFcuasbSRwiqv18qs8J0J5GynWUoioGlXtnRrxPGkl4H8MYCPbZUWcmJUgnXKrT9eCeJbUugOVIZZjQJZFm+SM18lVHCqW8GyeZolEGWAuT4P0hA5Yj0HLkc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KSl4i+Uc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QHMDsi043313;
	Mon, 26 Aug 2024 12:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724692933;
	bh=s2NkAK2yemYu1rD4206DDlacMKRE1szxSzrgiWygayM=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=KSl4i+Ucw2EKsZaspvGi84LRwyHahBXUyATNXXFSpE2/mD+D+qYciol3JTweC5Veb
	 VcxlcSlD/prk078pFBFhsxwZMdQuI6G99dOyHZF8Z1qmX5LzMR3BJdVPKXsiC7itLd
	 q8sW3uzkb3sbtVCtHdJ6GqdmkslhPA0gorO8xaHo=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QHMDDI026480
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 12:22:13 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 12:22:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 12:22:11 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QHMBvb123209;
	Mon, 26 Aug 2024 12:22:11 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 26 Aug 2024 12:22:07 -0500
Subject: [PATCH v3 1/4] arm64: dts: ti: k3-am62a: add opp frequencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240826-opp-v3-1-0934f8309e13@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3672; i=bb@ti.com;
 h=from:subject:message-id; bh=/EX+DTBukK08UXUkfiuLtOXmX5lBgrF3Wye1Fu8yH+s=;
 b=owNCWmg5MUFZJlNZDbLrxwAAZv///rb7v/U8n0fet/v1d9tnpfry/f3MW273f98u7t7Pv2ewA
 RsYGKDQGgBo0AGgAAAGQHqA9QDT1NNAAAADQAAPSAD1D1B6Qaaeppp6IH6FDoAABoaaNNBkNDQb
 U0ZAAbU00B6g9QD1BoDT1AYgPSNqaNqAGag0ZGQZAAaaNCGTIGgNDBNNNDRkBoyaMmEAGQxGRk0
 A0yZMmEGTCNAaaYgGQAAGjRpk0AAYN1HHIpPRi6iLk5mSC0VT8DoyzGhLkMFiOcArxqCVdjK3RF
 tv3wAHnQ4iNO8BerqcM1wzbsdMN5+z0zCAdeMsYC7/lEhIAKJYhzAwEQaLpxO8maE/I/r3Dg9kK
 ArmOROPCmVrgQhT4rVIR4B95rWBS/wzbPe4Kxxpn93nA4bJPO8WwbPCsVBbNQlCVFHnA3IRrRv2
 zJpG9u0D8DF8ghqI5V8Z0olIM3xPcW+m8hlyMG5i4TdBZyG6y+DerIJkSB9shj31zV5JM19dfNK
 VBI+3uJL2DOi0ErK0MkajHb0w1AK0biwIQXknI8Jn8TgIisZAzQphS0vgXenGrWrP1PMyy6edFG
 cEohiyzRWCYwOdOUsA2JqH7sb1CrLBbgDBUJ16+H7LpK+HstIRJ7AfwI7YhzQDv2rrqUQYxpqo4
 +XPJVf4u5IpwoSAbZdeOA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

One power management technique available to the Cortex-A53s is their
ability to dynamically scale their frequency across the device's
Operating Performance Points (OPP)

The OPPs available for the Cortex-A53s on the AM62Ax can vary based on
the silicon variant used. The SoC variant is encoded into the
WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register which is used to limit
to only OPP entries the variant supports. A table of all these variants
can be found in it's data sheet[0] for the AM62Ax family.

Add the OPP table into the SoC's fdti file along with the syscon node to
describe the WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register to detect
the SoC variant.

[0] https://www.ti.com/lit/ds/symlink/am62a3.pdf

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi |  5 +++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi       | 51 +++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index f5ac101a04dfa..0b1dd5390cd3f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -17,6 +17,11 @@ chipid: chipid@14 {
 			reg = <0x14 0x4>;
 		};
 
+		opp_efuse_table: syscon@18 {
+			compatible = "ti,am62-opp-efuse-table", "syscon";
+			reg = <0x18 0x4>;
+		};
+
 		cpsw_mac_syscon: ethernet-mac-syscon@200 {
 			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
 			reg = <0x200 0x8>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
index f86a23404e6dd..6c99221beb6bd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
@@ -48,6 +48,8 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 135 0>;
 		};
 
 		cpu1: cpu@1 {
@@ -62,6 +64,8 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 136 0>;
 		};
 
 		cpu2: cpu@2 {
@@ -76,6 +80,8 @@ cpu2: cpu@2 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 137 0>;
 		};
 
 		cpu3: cpu@3 {
@@ -90,6 +96,51 @@ cpu3: cpu@3 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 138 0>;
+		};
+	};
+
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
 		};
 	};
 

-- 
2.46.0


