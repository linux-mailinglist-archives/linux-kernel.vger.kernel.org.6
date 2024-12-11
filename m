Return-Path: <linux-kernel+bounces-441276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45689ECC3F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AA9286B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3590229134;
	Wed, 11 Dec 2024 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Regpj2DC"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02050238E30;
	Wed, 11 Dec 2024 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920910; cv=fail; b=pK3t5+qUqxp7aoyhj4SIAa8x57q/09ZFXGg+odj4eLtF4pZQnCTlsDld3rt0yz5GAhH/POE0fDyqa32d32uqgXB5It4qcWJnb2P1i2lIOv6SBkKwUcbN0genVQcpbBWxpG4B2sfzQd6DO9JOPv24DHtUqsQAI/TdSbx+rmbfUPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920910; c=relaxed/simple;
	bh=m83VR0tdqbp32UelP52T/7WSyWUD1Lp+kKtEYp6Q+DY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwNBG92+vTBR2rUlETrR5bcrtHnYl/O2VC/XwdDa3ZqnbVR+FYvjgWlG6THgKSCuG6ZPRonvn0/O2PBD4Ji0HZSoTTNP0mLQAx4xHju5f/6+DAgIDADrFKFsc2ZElwIsVVSEARc139EmqE/7LV/fCavBWoBEfmKE2loA8vgVde0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Regpj2DC; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9tOessIq5iwN5K0bnv9MwF9SPJGMohMKTW02iKGRZ64DvJccYoTTH+wZqBZr+TvhTJVvop9yIu3bG5Sa9nmEy56m8U1RHT020C7zCSbgIuzJbT3cslHEkx5RirS+i6M4ft6RN+OWYlYtNYzVa3kitYKFi7QZADKsfUPzLOInU7YLzLt3B1/YEAAWnpHCq+6PWixhRqFxBQ/olGWBuuCttqaEelhmO4Ch+CyxoQosdqdfWCG+ipYRdsUMKx+vW07pJ4VVMVjliEBcBVd+7j+XMfseRkmiheRQcf6o1Lvil8LSNyCAAJxB4Bui7FYd19E7ThT9X/gK3iuWMZ26wlgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyT/YYLSG02s66I0Pg8u/z/5/qK6f3xJ/jPABSaA8FM=;
 b=nsw8nc/wvEAJaflO7P7IRb7p0QlRwDctWVNqvV99kWiJx836E3WaFcbKmQYuUQNBa2HJhVnlUVoAQ06OVkX+S0m2i9zd4k2RG4AAiJtsvLG6xFF2KpjK+0G/Sfa4PnMSS5ftjX2Ul+ucC9Y9+EgPDWLUGZ4gcrVWsNbExLmOh4Zdu+uJAViLr5IJnaR6i7YR8NzRVIT4fJdABJhbOtFxVCdGoNRaMb9mD0e4MDIVq+q5H1uldQgZ1XcIT+T6hEFcG2tlfiXI90Rg0Vf91LcjiR2ZQKlP9UGX0NzktLNxoHFLciFB19motmd2CWYFEoG4uIoCY4Fi81GkHbNecuPNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyT/YYLSG02s66I0Pg8u/z/5/qK6f3xJ/jPABSaA8FM=;
 b=Regpj2DCxXKsD9EsH380RICI+/KN+BlHTJJJ+A5lUC+zIapz6Eydr0WwsZYwxrEefulSaUlLjsgWaofE9POFmwXeJKoMhcEmHxXfrZ9ZcJrWZvgxlPJpFckl9+7Y30/vkQiTZpQrqXiZVeFJfRbaeJ/XLf2zPWP7i84TGgEtKCw=
Received: from BL6PEPF00013E0D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:11) by BL1PR12MB5923.namprd12.prod.outlook.com
 (2603:10b6:208:39a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 12:41:44 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2a01:111:f403:c922::3) by BL6PEPF00013E0D.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Wed,
 11 Dec 2024 12:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:41:44 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:41:42 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>, "Conor
 Dooley" <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 01/15] ARM: zynq: Replace 'io-standard' with 'power-source' property
Date: Wed, 11 Dec 2024 13:41:20 +0100
Message-ID: <cf45ed95fe0be083446d5aaf5f946f38acba7728.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4404; i=michal.simek@amd.com; h=from:subject:message-id; bh=r2DrcFJgCYkcx6NC1LMn1ZzvUpw8FxpttxHq7I1Sz6s=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjkq9ooz363mepv69ZDjJbAKvdrVS227Je+nyczJLf Iwtcho6YlkYBJkYZMUUWaRtrpzZWzljivDFw3Iwc1iZQIYwcHEKwETqzjLMU5x6IFDoaX3a4cqz Zi2+82WVVh2YwDC//kBvAucHZoYKpTsLbilw+Fr+8GIGAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c494775-bc78-4182-1ed3-08dd19e12b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QJSlSp62LAffqClo1CHuPCFjlC/gRsTB/8jS399IQEciLZbp3vVVn6JN1Nyq?=
 =?us-ascii?Q?kqY0vgaNXyLtezzUdTgNLKDhczX4Buq7EjP3GKpLxurUTbmu7Cerl5R7IEAf?=
 =?us-ascii?Q?oB7RWAbEci1QxTv8vc+f23Hcql5swETdQ1VLQP8PmOhR0DJbgNVOmK1PCz2E?=
 =?us-ascii?Q?s/JSfTn+/iIV+VSfd+PLdiTFe3eZvukRSLEd7i9xJ7GbPso9dFB2fyXDSe9O?=
 =?us-ascii?Q?on+4upCnDPnVTfdlN4704Dzf3nw8Pil+BvOu7qdPAwbpprgzbrAIoS3tYttf?=
 =?us-ascii?Q?NHo8I/wm8jJEY6B1FBxn6HvioyjF2qkazwTrok/dLEg0tD5p5nqK2yqXEl/m?=
 =?us-ascii?Q?YOK8ef0Jsmsq2KDh0jxrwDXeeibezJlu1mM7pJ05svEAdlXmGqr1xV2ErY4q?=
 =?us-ascii?Q?Tb3Ezv4i4sKDAh+QxRIV2KuSkLugTIIrk76OQV1KCKyG/EN2UPpOQsMcU1F1?=
 =?us-ascii?Q?lH8VsHah0uAEAsXTRXhBwKR7+haHl3JiqLSOlspXyMM2hVsV85iH3bFFEn4r?=
 =?us-ascii?Q?Euk/md5EYVVjPHZnoedvY45whe949nnfg3offdZfev0hsAJF4NURBzIZJRiR?=
 =?us-ascii?Q?GItLwP6OzC/qwHcVEiiKZrszVCYHk9mV8zCK8Q1w5wLHwx1pYB29H02YALZa?=
 =?us-ascii?Q?51GOfrum0jcOCqLzJhFjtgtHXmhQha5Zmy0ndlOmPbutbtCLZ/ewMS9/pSCd?=
 =?us-ascii?Q?DkdjWAa9ViEF95aZ/+8uLtFqxzZ1j8VEiyeSrY05M/p0DrmrVRvDZVRKGNJe?=
 =?us-ascii?Q?PaXeTwGLfYiAGeazB0Ni6hYdX3805AQlm0AzrDkpdMazZNGEKJ0f0LiAWLfg?=
 =?us-ascii?Q?uzy1t2sglrIpANDxI0nFBYcRABAA6c6pZUeypiTEx/l4U4/4p7Zd1hdVOaHG?=
 =?us-ascii?Q?+86fWl/O4Hm/OYit4tHcpQN4SK/IzYkb5i8wPZ+t7TixKkyJpdo1s529qLtL?=
 =?us-ascii?Q?MKlll9O+8DKxCp744e6s1/ephJTxw3K/RAm1ceOGVaBPZF8KOl5vxad7IEZu?=
 =?us-ascii?Q?AaAhE01IpwVSmih+RaBGocKFstWiILg6WRBk39gtelxzOMaEJzgsws4ikk0Y?=
 =?us-ascii?Q?DnMGDIQgpc1/y3lxQJJJaLGTnQ/0HLK0bVxznJ3/ssgUOlfAz7bGbVoNPX2p?=
 =?us-ascii?Q?f3QOP0VYAsPY1ljJr6YQcOYEEA+39gNRDGZdoflXIOyXJrtjBqRFiUL7VGA3?=
 =?us-ascii?Q?HzRLc0DavLsUfyQZ+YpdOEXnBuA6KcEJ2n2fTR8WIHXMbnUyisJjEkE31Vjt?=
 =?us-ascii?Q?xy+z6WxIFTnhsofe5/G/cFxdZgA/AiT1m7H6zYaozneBLT4QVBejWyzvIFwy?=
 =?us-ascii?Q?VCWvDg2OqksyHcTmMgRwlBlrPqnWyQVbYkdpIWD77BiB8+xhCfMgn127Lfsb?=
 =?us-ascii?Q?2DWm1giYVxlR/aQWdVCO+WbWSPdtZfCjd3VVtdNY1rtLF7/qonrXJjCrpyrh?=
 =?us-ascii?Q?5sLORjuDHg9fStU8iHdTT0anckUa9jAA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:41:44.2105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c494775-bc78-4182-1ed3-08dd19e12b63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923

From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

Replace 'io-standard' property with 'power-source' property in all
zynq dts files to be in sync with Zynq Pinctrl driver.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-zc702.dts | 22 +++++++++++-----------
 arch/arm/boot/dts/xilinx/zynq-zc706.dts | 18 +++++++++---------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
index 6efdbca9d3ef..a933c0341b69 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
@@ -210,7 +210,7 @@ mux {
 		conf {
 			groups = "can0_9_grp";
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 
 		conf-rx {
@@ -233,7 +233,7 @@ mux {
 		conf {
 			groups = "ethernet0_0_grp";
 			slew-rate = <0>;
-			io-standard = <4>;
+			power-source = <4>;
 		};
 
 		conf-rx {
@@ -256,7 +256,7 @@ mux-mdio {
 		conf-mdio {
 			groups = "mdio0_0_grp";
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 			bias-disable;
 		};
 	};
@@ -274,7 +274,7 @@ conf {
 				 "gpio0_10_grp", "gpio0_11_grp", "gpio0_12_grp",
 				 "gpio0_13_grp", "gpio0_14_grp";
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 
 		conf-pull-up {
@@ -298,7 +298,7 @@ conf {
 			groups = "i2c0_10_grp";
 			bias-pull-up;
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 	};
 
@@ -311,7 +311,7 @@ mux {
 		conf {
 			groups = "gpio0_50_grp", "gpio0_51_grp";
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 	};
 
@@ -324,7 +324,7 @@ mux {
 		conf {
 			groups = "sdio0_2_grp";
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 			bias-disable;
 		};
 
@@ -338,7 +338,7 @@ conf-cd {
 			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 
 		mux-wp {
@@ -351,7 +351,7 @@ conf-wp {
 			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 	};
 
@@ -364,7 +364,7 @@ mux {
 		conf {
 			groups = "uart1_10_grp";
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 
 		conf-rx {
@@ -387,7 +387,7 @@ mux {
 		conf {
 			groups = "usb0_0_grp";
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 
 		conf-rx {
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc706.dts b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
index 77943c16d33f..d21e3ae4ebb2 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc706.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
@@ -150,7 +150,7 @@ mux {
 		conf {
 			groups = "ethernet0_0_grp";
 			slew-rate = <0>;
-			io-standard = <4>;
+			power-source = <4>;
 		};
 
 		conf-rx {
@@ -173,7 +173,7 @@ mux-mdio {
 		conf-mdio {
 			groups = "mdio0_0_grp";
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 			bias-disable;
 		};
 	};
@@ -187,7 +187,7 @@ mux {
 		conf {
 			groups = "gpio0_7_grp", "gpio0_46_grp", "gpio0_47_grp";
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 
 		conf-pull-up {
@@ -211,7 +211,7 @@ conf {
 			groups = "i2c0_10_grp";
 			bias-pull-up;
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 	};
 
@@ -224,7 +224,7 @@ mux {
 		conf {
 			groups = "sdio0_2_grp";
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 			bias-disable;
 		};
 
@@ -238,7 +238,7 @@ conf-cd {
 			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 
 		mux-wp {
@@ -251,7 +251,7 @@ conf-wp {
 			bias-high-impedance;
 			bias-pull-up;
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 	};
 
@@ -264,7 +264,7 @@ mux {
 		conf {
 			groups = "uart1_10_grp";
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 
 		conf-rx {
@@ -287,7 +287,7 @@ mux {
 		conf {
 			groups = "usb0_0_grp";
 			slew-rate = <0>;
-			io-standard = <1>;
+			power-source = <1>;
 		};
 
 		conf-rx {
-- 
2.43.0


