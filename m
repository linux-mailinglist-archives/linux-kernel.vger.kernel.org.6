Return-Path: <linux-kernel+bounces-190344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD048CFD18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39C91F25378
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45F313C9AF;
	Mon, 27 May 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W8uxL8eX"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EEC13A888;
	Mon, 27 May 2024 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802507; cv=fail; b=CJNSR4Uhp3MWZPG2P9SjcAUCBXiEkgY6DsxOYnkUdLlM7ZSrrixlVqvIAK7Y/Hjcg7dDcAf9Vt+8m+asN3NK44ZbrBCWLHvJewBIgm98GP+lMra8QQp+Xi/v+IgyYOsvsM+OyMpckk3pSQf63m6iBVX/2sb16ky/DYAoArBBhew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802507; c=relaxed/simple;
	bh=su8005o28X+iTy18elzTqtwz2hTRT4CkJMjibTMeg3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs3cgc0D+ZOP2jiV0ZUlScIhFCxWjdeK41nd2wTrg2Xp2sSdxNUIbnUBcl62nNT35Dam/DY5sk97gzeaJl35clMSy5E3CFZL2Zko/HO+wbrhg05cdxNH8NPv1rRvkjjcmFed8o2Rgz4pZcRwviQqvwsKLcIEMd6ZmbL+kWvsW8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W8uxL8eX; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLl7zTVVgFRpt8q/7zpizYUgFq/G3GcktB6tJ5qlwDth5rOp4ef3I9MwPZQy1xUjxrmd2Eb2eRyVf6hahMQ+cp7tFTn6j+BcgNouF1lhnIOJSiVsYIAC5UjjKt6PvYOrb4GXUqj4169pGyPU4z2kMFkY8wCClgxXTkR+sSKCFGiz1TTJGimxGK2TqBZwUGWS8TbOGtuvpzMQEHgZflsGrQo3IRvqT9rKhm2HNlzr0QiM7MgmIirkMVgaHg9XIqSqT2koYw8Etw8Q88O1Yzr8N6RC0t3dLVLAdJEqXeYR1HX2EFTunTwPVttpKE9Nb4wSeI2TLNW0D2L+l9kLgyHxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYViRoqR5XBizdmMjyNLnKrk3Idi3G7ZEE7LSK0UFWo=;
 b=DtRN+955zX/kQWlX9Z8/YwEUuhR+m1fWktLyp92Q4il9YqtpoKd9lja3qI7x0t2JhnqyEMGwFRiNcO+X7LhBx5nOKwcSzyrfndFAX142YZFuV6aSZm1JyM8IxhcV25mvyV9rSbHSa8orPu0XnQwlWEsto2495w7Jb6fqNX8CequXGxZtda3bwgLOQzi/1gdVAQq8pwGkoirX0ieQG/I9tOtK9S2VuszmyHd++m1MuZkZHqQTwQz9X8Urg01QSsm9rE5q0UKtmstjLaoLKrWGHSLipK75l/H/qMycjInk+oLem4n1bt1Y/zlz7gPttwVrAE4vQxoweNuk3mdehk35xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYViRoqR5XBizdmMjyNLnKrk3Idi3G7ZEE7LSK0UFWo=;
 b=W8uxL8eXn+VHISmqwVxrC4zbYKWiDflPF5xKWUwOebE59IKt451RMaNVVPenxyc/dn4bHTZggse+92HlVST084HV3e2onwvA+bvDzGTPyC8uSqtm6JsRz7IiMZZecKpOjmawQJCgYQ0fuATW25m9UFfxTg9rnUwqC+HNGChjytE=
Received: from SN7PR04CA0027.namprd04.prod.outlook.com (2603:10b6:806:f2::32)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:35:04 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::e) by SN7PR04CA0027.outlook.office365.com
 (2603:10b6:806:f2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Mon, 27 May 2024 09:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:35:03 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:35:02 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 09/12] arm64: zynqmp: Add description for ina260 on kv260
Date: Mon, 27 May 2024 11:34:15 +0200
Message-ID: <944cba76ef5df932f1bebde6c5e64ec9d201356d.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
References: <cover.1716802450.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2639; i=michal.simek@amd.com; h=from:subject:message-id; bh=su8005o28X+iTy18elzTqtwz2hTRT4CkJMjibTMeg3s=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4GlnZ0VP5qpsnbFuHc/W80f61G06/u58aOy2q7A75 sSlx4x/OmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEOtUY5tkIG8wz/z51ZYaY 8/btM12WxzDFMzIsmHxSZ+td9lX8F7L3XpTkmyyxOfHRNQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc255f5-47d0-435a-0724-08dc7e304990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zOrAoWDLomZi6QmISso7c0pd81WmhYeHSWq1D0IyEdXJDGrXtMVUbZF3R6c4?=
 =?us-ascii?Q?B1cLCoeTv/1pshPyV5WQR9+xoeiHYIBX2rt7sw/JGSC/DS2IdlO/Koti/Rfh?=
 =?us-ascii?Q?gGo++xPrbDGhJsvmKaej5Onutn7YBtIGf7ffmSPGqVC8m4zEJPhVZAzZO1YW?=
 =?us-ascii?Q?+PvY0zlZvXMXzXcmRO8s1UQDARwGIgd6vqp/n4VR9dNwBttS3X2gjD/I7X4r?=
 =?us-ascii?Q?GiHI/Mq/b0zWgyJm4i2GdmUibUvwK5zEw1+pKnlSq+X+I1KMF/IEmZZcZ3Ky?=
 =?us-ascii?Q?UhbgGtflG5IdmgcmERwZ8NCkfHyro911i+ela7o5CYsxa7iD6UT1izJrbt4M?=
 =?us-ascii?Q?mIDJ6Z3xYA4l0QSBpMOOBTXzmyNJZU28CPVQrKC1ENkogBQD1BoIMJkt2HXq?=
 =?us-ascii?Q?sfUKa043jDpQEIzvsibuHx4MSlG4bUX4MMADf2ZqCc8Dt4TipUoFsmc3zVc1?=
 =?us-ascii?Q?DJGKRJPUAP0ORo2dAy6XE2SLZ2cHVeTEDXWooDPnXPjTsVv8LB90YZ9AEby+?=
 =?us-ascii?Q?nLwv1GlPluuabSthvJSYXBBDJxgCz+Ou2iIXWaHvlC8fDpxgCnAVtRACI5y3?=
 =?us-ascii?Q?iLVnt5HXuFvAV8HvSJiX+M6clgKH8dcTvq123F3Y+KzQ/oqOWRC8t7z4/7a5?=
 =?us-ascii?Q?iJ907l/lhIr21XgYUn7vfEL+U2ZFinxaAYj9gCPpwIKO/ACE0PuqWLdl7xeA?=
 =?us-ascii?Q?QiARUR/euwpgAfaS48hOTwZSr5pD0XJ4lU2rtnyQEnotXxN2gOnxHMaU3fDs?=
 =?us-ascii?Q?dyFdTc0dHkBAGv6+lAgwNLqlEbQ9OEAHkxEKI/gaCfH2bMi8yWkvp8ow3pdA?=
 =?us-ascii?Q?SqldYwk+dDWe8UeJ1HDKSOdUPwU7/ZjPw9c6Q7m9GQYmtnYJZCVG6N8V+2D7?=
 =?us-ascii?Q?kFikXcRWWTAcTmwbq+wphfW3YX4BgglUTKFCrVaBUFvprDlIMKkrWZ0TqvpH?=
 =?us-ascii?Q?fY0FHUpPvo+04/Zva48FvzlhjQlFea4wV4e63JJ7Zpgy3HFaLm6M5uHNLrqH?=
 =?us-ascii?Q?+NdAKtoSOfW6yuOlv6+2pFBBNTl9jq6xGpr+rRJ3NK9zwsH6CIjskH41ClHZ?=
 =?us-ascii?Q?4D3mvrahCZ5SWvQY5bJ68pznPqy/gM7BNTlov+DS/aYt5F/quXWCx22jEagZ?=
 =?us-ascii?Q?Mplz8mG9olyK8iboCsPWaobvynx2O+5RWDsBvx2LLrqe2vKWNMrILFXUMfZ2?=
 =?us-ascii?Q?QysoaGYod02+Y8DSwB4BSBseCHaRBSjiRmdKkKkIwfLdP9ZdYP4vhqM1A3Or?=
 =?us-ascii?Q?hXTfLrGWcAyp43a6KnWgOvcrI1YNQFXFeghNuTyn0r3oya6UBqnZAgA6wgHF?=
 =?us-ascii?Q?3btn7Rb6yYWlKA2KpQtC+i+ajGGcnfODPlpL5t7F4AHcEdbZiXo52KaZ+321?=
 =?us-ascii?Q?yDjIjnA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:35:03.6848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc255f5-47d0-435a-0724-08dc7e304990
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

The commit f7ab2d180e6a ("dt-bindings: hwmon: ina2xx: Describe ina260
chip"), commit f29996d0295e ("dt-bindings: hwmon: ina2xx:
Describe #io-channel-cells property") and commit eea32fafadd3
("dt-bindings: hwmon: ina2xx: Add label property") added description for
ina260 that's why describe them on kv260

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso      | 12 +++++++++++-
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso      | 14 ++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index 0e5597e2fe10..95d16904d765 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -28,6 +28,11 @@
 		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
 	model = "ZynqMP KV260 revA";
 
+	ina260-u14 {
+		compatible = "iio-hwmon";
+		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
+	};
+
 	si5332_0: si5332-0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -74,7 +79,12 @@ &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
 	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
-	/* u14 - 0x40 - ina260 */
+	u14: ina260@40 { /* u14 */
+		compatible = "ti,ina260";
+		#io-channel-cells = <1>;
+		label = "ina260-u14";
+		reg = <0x40>;
+	};
 	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index fb37c06cfd69..3ada04781950 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -23,6 +23,11 @@
 		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
 	model = "ZynqMP KV260 revB";
 
+	ina260-u14 {
+		compatible = "iio-hwmon";
+		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
+	};
+
 	si5332_0: si5332-0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -69,8 +74,13 @@ &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
 	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
-	/* u14 - 0x40 - ina260 */
-	/* u43 - 0x2d - usb5744 */
+	u14: ina260@40 { /* u14 */
+		compatible = "ti,ina260";
+		#io-channel-cells = <1>;
+		label = "ina260-u14";
+		reg = <0x40>;
+	};
+	/* u43 - 0x2d - USB hub */
 	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
 };
 
-- 
2.40.1


