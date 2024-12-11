Return-Path: <linux-kernel+bounces-441287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC699ECC57
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D9F1632EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A4D237FF0;
	Wed, 11 Dec 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MpVEgbmp"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF20237FD6;
	Wed, 11 Dec 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920944; cv=fail; b=uoWltgXJhdwm00bTYz8dJ0jNJa6UXR5UbNnVEDru/fBlSDl4671gcQqRdBy+xf4iPR18UvUG3/fwm9W9YnsU68xXsLunutF+VInZXjbgaj16HjJhMP0GAgal6pqDPU5KmN/fJg8UK2SyawGyDYQpLu6bJDH/WtC8J3jJ4jbAW/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920944; c=relaxed/simple;
	bh=QSLTc3+/Tlb6LuNUhnZQdhPm+uHOMI4/0tiaiy8Q3NA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJDgRnDNIQETcqoiOCwwGEjfRq21rX5dCrF60v2tHPaAl2mzVrZXJnI5gWbHpthfRrBeG2/YZDDpPd1XpaModnlQF/4oZ1KK7k1BgGYcoxjgn3priOA+/YXIcbVWv6D1slG3abROWsxFCfLsTuGshCzoTcbwf/wOiu8m10yBtM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MpVEgbmp; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a16kbEA02B1/laQmZCTRB4CvS2xWGfeQTv+fXWypuP6Wwx6THI2lQHe0Csp5CNV/hbx45xHZ03gNwvE/FY3e9Nk8zYK6w1AWmdfjC2CryuSNL+sNHDsYZ+9vfYzeL9cGG7A51B7cfGrKirFkG+jW3Y2wQQCDzWmkthAL8Fs0FgP/xfRviL7PWlp/KpQL1f7kkXXKoG4dbEydcyLflQEPv2B1ZQ6c0aKhSQi/1YvB+KvbEfPhHPx3WeAAPe5uPvYhav15r4Py3PyA0Pj/5ixSz4Uj6ggXHJcH4slbcThgGN0Us5b1gtcgks0rqLxbb8adYpzQAGk19B2TcfBlLP67lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k04N22RFyS61QnhfpV3hXUcHuhMAj5e75M01MrpvLEI=;
 b=Y1JndAVOhW7aZTDLzj47USzh1ZGzJy3H4CCjX6lj3+r7VCjA88ft59Ai8swZAN/0/nsZWQsRSW39eXVi0Lzul2pgnnW87YP+bU6TV1hI6Fjtqe8Br6j3P6sGlcdDDet1zpi2Fp0a6ZmiGQFALH9YMsfWNaefvmCaAaQ1X3GGDR+ybRmJpp/IHgjDzK3gaSgi3KM1mZ7kElfT5Jn3R+WH9l5OsfBR4wkcRLPcM/JZ0sezhI59FmbremhaqfbyWkLbYnefCyTJHmrKySZPwmx+kt8ZPq0EHPdtbGjCUnnx9AQIOInEQQhp5quKbRu2G01MQNkb7ElpjPIp+E0OSVfJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k04N22RFyS61QnhfpV3hXUcHuhMAj5e75M01MrpvLEI=;
 b=MpVEgbmpEllaj7M28CowsameUSGVgUV3dIzYW9Gxo7o7vNzujexozjwL2AngA8r7Olm3Q/gTFu8/n2OCuiGFg9WLh/hzXLFd9Cy66DclZzRm4JURF8fc4AZsHhl9xxIdUGg8MFOKJ6AK3+0w9bDxt4S3YvJpyd9StWOki28GtIo=
Received: from BN6PR17CA0039.namprd17.prod.outlook.com (2603:10b6:405:75::28)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 12:42:18 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::c9) by BN6PR17CA0039.outlook.office365.com
 (2603:10b6:405:75::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 12:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:42:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:42:15 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 10/15] ARM: zynq: Define rtc alias on zc702/zc706
Date: Wed, 11 Dec 2024 13:41:29 +0100
Message-ID: <9ee86a22d15fb127b8b31cf1ab6059ffb05ad55b.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=michal.simek@amd.com; h=from:subject:message-id; bh=QSLTc3+/Tlb6LuNUhnZQdhPm+uHOMI4/0tiaiy8Q3NA=; b=kA0DAAIRykllyylKDCEByyZiAGdZiH2hbEDk5AFxIjAnrYQYZ8hzTmGF2b+h9ZAS+gZF4UXvE YhdBAARAgAdFiEEGzzUzL15mJQT0cMeykllyylKDCEFAmdZiH0ACgkQykllyylKDCFBCQCfciJl t7PeZu4jSNvftVhXJJZOe+gAoJe347Dl1zdqzuZJXfIwZMo3Oo2N
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f23b7c1-5b9d-4ec9-3388-08dd19e13fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hee4Yl2lE5WPriEkIGHqOykSTqJiygxXp3FvCJ944Z1hbWD/6wEDvo2QE2Jq?=
 =?us-ascii?Q?vc/KgdDiZFxYXOzqtWYdfhJbhFhXAVC+Odyhsa7JEXQKYUC0x/1CP6cVSeQc?=
 =?us-ascii?Q?4iGpvy5SxKTsQDRsDMqQQomB/SzjUIxpM18x6Q1sNdA93T7bvvObXlzMRt2M?=
 =?us-ascii?Q?6B9ZMk1xbeKvFx+KZEdMqWd029NxyaPWBLj5oEoJpYBGlZSeliFQ+DfUpa00?=
 =?us-ascii?Q?dRweB7T5Msad+HWwL1FBnkh1FyulF9UKetDwISfZ5JaXRCV4TzR+FtO0et/M?=
 =?us-ascii?Q?djiGDcgwZpaOvhLu1WC26iyvdcgb0JCGEdPwb/iRRca2eD5mJhbcLV/gfyw2?=
 =?us-ascii?Q?qlzW/Bq7OgWJD8cspOSf4ETpkG5X3sb8VYnH4EfHaXo0PvBalqmFlR3+wuHB?=
 =?us-ascii?Q?nEh/jA4PzpdBdSYriKMuOmi5BzUtl1N7HbzhlGYRl/D9vnDqLKM5Zm/b7bbu?=
 =?us-ascii?Q?tKKSPPlbegjQboUBqit8gEKGNwporo1o8zbliYbiuFN9Y6MJFJ+5hX3deaRw?=
 =?us-ascii?Q?ayliJLJSmLRgjanU3WL+PIM7ZmJMHdsgWvaL50LiWWHYjAR9tvjSpMh+kasc?=
 =?us-ascii?Q?s6r2Nr1bS8GNE7kl/rTKzK9pZlZX6k8d+L5Ymhu7JMe1G4RQqup1r0YIrBaP?=
 =?us-ascii?Q?zTyO+nLhDFAbJ03yJTolLLhyHqianemS4Y0jblP+bOB34eTvEbrvt5NCG2bE?=
 =?us-ascii?Q?juR45FNbHeFekA/hMhV8uJ5qvJzycDXt79LJecDa8LTo+IcxeAsOmZPTTDhk?=
 =?us-ascii?Q?tH7T0MYE8XxvrwMij81b/iKbWZ905AG4B0CtLaO64qPzYZaXFFyuRbOOSyhe?=
 =?us-ascii?Q?2wgTIfxVnhk16vmpUSVmvmGuxrwY5NuqO035aAsfiw4h6JaFFrpXEElm43PE?=
 =?us-ascii?Q?ZEOnZTv8POhvxW2D/Db/8+1D9Z9H5MlCfu42MVVMkGwA3dOLZSB97w7OB9uq?=
 =?us-ascii?Q?e38T4ppG6cAyJ696ga4OXBaBnNzHLacAMRgbBgvcpxr6A6M8LsvmlcKrhbDa?=
 =?us-ascii?Q?Qa+Q1mt20WCHc3s+Bo2yw6EZrZNYL9UP7N8Tz7L/noGmELWCkMO97ZaAf6Pz?=
 =?us-ascii?Q?c+/KKhwnmhnLplMGyX6flTuS0rQFkPvKhPQL7CQbNSWFn1N30jKTt6bbGL/n?=
 =?us-ascii?Q?R3FpXnFYLY3hCsIsr6Zl3b1rXNXSzR5ZhbCXHQqh+olqKdKij3dI37g2sBfT?=
 =?us-ascii?Q?FbjZOSpLH6KRyNqoJMsFsXtrYYOx9HMw4Jb97cQl2e7CsNkdKbrfp8AfrKZD?=
 =?us-ascii?Q?jEnyxSQy5Gmov7hjqPZRKEWPhQfyfmq8x5tatCNnWSycMAWX+FlWHt14wYUd?=
 =?us-ascii?Q?1O4ttZ+rMKCMQs7lE49HRIOT2wZBdmNjNgpc+57TERPu+5pRMuQiOQI0RElv?=
 =?us-ascii?Q?knSQkMer6yJMLMedWnDLmGLMZahrQb6pvRYULGqto+YupX3awFppCq2r8y1I?=
 =?us-ascii?Q?TztKQcJEpva8/4V5XdcvIQpLdPaRaBnH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:42:18.4642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f23b7c1-5b9d-4ec9-3388-08dd19e13fd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

Define rtc alias on zc702/zc706 boards.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-zc702.dts | 3 ++-
 arch/arm/boot/dts/xilinx/zynq-zc706.dts | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
index 9a4f3e822c7e..b5db97dd7192 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
@@ -17,6 +17,7 @@ aliases {
 		serial0 = &uart1;
 		mmc0 = &sdhci0;
 		nvmem0 = &eeprom;
+		rtc0 = &rtc;
 	};
 
 	memory@0 {
@@ -163,7 +164,7 @@ i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
-			rtc@51 {
+			rtc: rtc@51 {
 				compatible = "nxp,pcf8563";
 				reg = <0x51>;
 			};
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc706.dts b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
index 1ebf8e422c3c..1e38c5caec22 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc706.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
@@ -16,6 +16,7 @@ aliases {
 		serial0 = &uart1;
 		mmc0 = &sdhci0;
 		nvmem0 = &eeprom;
+		rtc0 = &rtc;
 	};
 
 	memory@0 {
@@ -122,7 +123,7 @@ i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
-			rtc@51 {
+			rtc: rtc@51 {
 				compatible = "nxp,pcf8563";
 				reg = <0x51>;
 			};
-- 
2.43.0


