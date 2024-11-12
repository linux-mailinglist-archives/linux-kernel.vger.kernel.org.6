Return-Path: <linux-kernel+bounces-405262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3D59C4F38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D5B1F2239F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BE220B1E0;
	Tue, 12 Nov 2024 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DU+hJHfM"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11F20A5FF;
	Tue, 12 Nov 2024 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395709; cv=none; b=DKfo6Uz6Wu+ScxMR5DxnYFUUf3F4QW8UDvVz3UP4CK9KarStA8kS8if+v0BYRgSKCDA8hKukf248t+27E8B4hWQeHL8kjihNYLT90N5ApyD2UvhTu+SHvvKJJ8a1TmXbjsPO/5lKcmjmmUt1bIm+G2OSxzXHWp/AeTDWJZV58ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395709; c=relaxed/simple;
	bh=nfcLnmD+D/CfXHBdEVD6YP35dinDuE9CTLoceAXX1lM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H0N2sSjVBWfyTMsZMbJDcGxyk83dybLmENUik8rbaldRehq5BM5ZL+sMsYVjS1nBlTJYEXscfL2YEIpFuDvJal9BZ5QWtnJlZcIuCj1hCM4mUNt+QhZdqv1/DNaj9vrEePoN3UQlft+AZgOlO2+XyoHgFdcqWHTSC1GuN2lqjkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DU+hJHfM; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABLu5fw016704;
	Mon, 11 Nov 2024 23:13:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=+nvaEIkJi1JKRsX47Bn13It
	bUtldzj6zpPQcXn6HvLg=; b=DU+hJHfMvUD7n8xtXhOdgiOi89/Db9Pc+i/1WMj
	XcFwklXYKFNUaYJyi3c+V1lfwL0boqORmWpiQhhmjZkrUIer+NKWykBbeapnSCuK
	QSm+ZXlC1X+IVN/3IathgJP8C28X3TtSZpQaFpWFSiS6BW3qlDyf2LzYjiNeLRJ7
	CZGEOi18w+d5e7TIxGjmfNeKcFbxm4YwqUFGXhoeWDR8Y1TQrkORv9s8dnO+5c7V
	yUrq4nsL0RNhlF1Y9Cv3RbvuUg6spXPvfWJn+nTGFufw36OvIem1oZBvsFsV0eJi
	8DG6CPVJIbI2piYDB1VfRpKqP7LccCtYaiksliQnMqc3fqw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42un9d1csv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 23:13:54 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 23:13:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 23:13:53 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id 0A18F3F70B2;
	Mon, 11 Nov 2024 23:13:53 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <salee@marvell.com>, <dingwei@marvell.com>,
        Jenishkumar Maheshbhai Patel
	<jpatel2@marvell.com>
Subject: [PATCH 1/1] arm64: dts: marvell: use reset controller to reset mac
Date: Mon, 11 Nov 2024 23:13:50 -0800
Message-ID: <20241112071350.762111-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3ZGkxgAhdUC6TpdclIJI6IyS3PWbiEOt
X-Proofpoint-ORIG-GUID: 3ZGkxgAhdUC6TpdclIJI6IyS3PWbiEOt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

change mac reset and mac reset bits to reset controller

Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index f5aef6a23f65..f358f9809edd 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -6,7 +6,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
-#define CP11X_PCIEx_MAC_RESET_BIT_MASK(n)	(0x1 << 11 + ((n + 2) % 3))
+#define CP11X_PCIEx_MAC_RESET_BIT(n)	(11 + ((n + 2) % 3))
 #include <dt-bindings/thermal/thermal.h>
 
 #include "armada-common.dtsi"
@@ -276,6 +276,12 @@ CP11X_LABEL(gpio2): gpio@140 {
 			};
 		};
 
+		CP11X_LABEL(pcie_mac_reset): pcie-mac-reset@0x440268 {
+			compatible = "snps,dw-low-reset";
+			#reset-cells = <1>;
+			reg = <0x440268 0x4>;
+		};
+
 		CP11X_LABEL(syscon1): system-controller@400000 {
 			compatible = "syscon", "simple-mfd";
 			reg = <0x400000 0x1000>;
@@ -548,8 +554,7 @@ CP11X_LABEL(pcie0): pcie@CP11X_PCIE0_BASE {
 		num-lanes = <1>;
 		clock-names = "core", "reg";
 		clocks = <&CP11X_LABEL(clk) 1 13>, <&CP11X_LABEL(clk) 1 14>;
-		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
-		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(0)>;
+		resets = <&CP11X_LABEL(pcie_mac_reset) CP11X_PCIEx_MAC_RESET_BIT(0)>;
 		status = "disabled";
 	};
 
@@ -575,8 +580,7 @@ CP11X_LABEL(pcie1): pcie@CP11X_PCIE1_BASE {
 		num-lanes = <1>;
 		clock-names = "core", "reg";
 		clocks = <&CP11X_LABEL(clk) 1 11>, <&CP11X_LABEL(clk) 1 14>;
-		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
-		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(1)>;
+		resets = <&CP11X_LABEL(pcie_mac_reset) CP11X_PCIEx_MAC_RESET_BIT(1)>;
 		status = "disabled";
 	};
 
@@ -602,8 +606,7 @@ CP11X_LABEL(pcie2): pcie@CP11X_PCIE2_BASE {
 		num-lanes = <1>;
 		clock-names = "core", "reg";
 		clocks = <&CP11X_LABEL(clk) 1 12>, <&CP11X_LABEL(clk) 1 14>;
-		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
-		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(2)>;
+		resets = <&CP11X_LABEL(pcie_mac_reset) CP11X_PCIEx_MAC_RESET_BIT(2)>;
 		status = "disabled";
 	};
 };
-- 
2.25.1


