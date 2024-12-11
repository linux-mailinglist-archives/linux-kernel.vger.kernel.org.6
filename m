Return-Path: <linux-kernel+bounces-441280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC0E9ECC47
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F86164A18
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CB7238E23;
	Wed, 11 Dec 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TzgNdCPx"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A5E233699;
	Wed, 11 Dec 2024 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920923; cv=fail; b=SjQ3SUdiNiuKUcAoLm0qFHwrJ5GJ97nGNsygMbTCxSEeDTkOYAKGR+wQNabLGhobf80GkM0T4cX1qAZvL3s6kXQ5/TCJiMkyAgC/V2L12NKw1Gdra2/zTH/VUiHlUsc4+ihVIs5jRNqQPc6k65pHb/QgbmVAyNS4ixCMX8bw8iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920923; c=relaxed/simple;
	bh=j4t/lOeu+PTP3sfgXG8txgsLDiY77S45xW8tV6LJnYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+MOr1lzTSIkYseTJaU3zWezaUEebNKYMnkoV65MpELffbWaVdQim7g/f4c2idY5XkSnSr8ceZCbjGo5k7NrZYNvZE1ONAs/DrqZaOplxXhhXnurYXctXw5iYog94aZxZcvNX/yK+uKjsz2XNpExq+SdPdLSW2jolLVH6oKKrVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TzgNdCPx; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tscswHIeTDf4vV2wM29G5ToV2cbj3qFs04Nf7AhHBkJaJ+cuwZzizUMMhk94lvUbq9vzRWLLzfakRSZpqkSha4wulPsHnku3QupJcgzMXUV7BA5d+BUrYpShxwegDInkFBtEO/OzCQYEUTJKEUEL1ZAYwstLzQO2wowrj3+EISnw4YxpYzW7IGpJCKpLApzSj35HEDwmKODbDRn3TbKsW/D4i/IXIZRNqkV1HgyzKWY06DsgyuWSr1yykSp/3jZpzA+C/BsLlBWmgno4njs1pzXiVYxuHxiACTwu0F9hBDMbmXUFIuOIIQ4j9nxVeDPWu/5qgiYDfZLEnUo5XS2PDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL06yduNLklRfKcdFf2BFOsIquEqDAIB+TUvVF0r5kc=;
 b=uJEu0ss+0jZt7gM4FrSThGCFPMQGqLi1ycHa7hSQJ8hNS5Fj6lY1Q1+p5vg79us6SlPxtAnwkDgSCrXYywOogNiERX170ly2rqLJwoApKP30b0iCtZBnwsDnlNeLpM8qw5LWy32L0HIS+rYygvMedsH2fzRMMEoRSVlLfxHIxhuCIZ+aTZjcMlK1mywkPOdZEwZUis6PMVo98S6LbNcwDc5D8ScLMaXn5HS+b61uhLoTrMzy3fndacLqqK5E9YFVNV/EvlAsec3jXmZLkhu/4d2nJwK79w+8+UJl2PuaLuWsOgIS7yz53Kpj7ZpfNi+EEzvMWaQmYqgluz+Y6JlJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XL06yduNLklRfKcdFf2BFOsIquEqDAIB+TUvVF0r5kc=;
 b=TzgNdCPxyf1V7aSu9+jFE+yWTFk1FZ4UkLLl08OInpBK7y/sip4vcHT9KYrGomxKRn2cAuweYO1Oq5uJKaPbnhhdS4rkadtp0TTUyCf3+IgyMAfKBXrChnych/+B4VV2BP9L1EU621tThnO0bmEEEHEm49IiLzg/tuwWknuG3Bg=
Received: from BN7PR06CA0039.namprd06.prod.outlook.com (2603:10b6:408:34::16)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 12:41:56 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:34:cafe::ba) by BN7PR06CA0039.outlook.office365.com
 (2603:10b6:408:34::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.22 via Frontend Transport; Wed,
 11 Dec 2024 12:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:41:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:41:53 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 04/15] ARM: zynq: Mark boot-phase-specific device nodes
Date: Wed, 11 Dec 2024 13:41:23 +0100
Message-ID: <f25387e0123ee81f7d8246add3c6ec063f3cfa78.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6848; i=michal.simek@amd.com; h=from:subject:message-id; bh=j4t/lOeu+PTP3sfgXG8txgsLDiY77S45xW8tV6LJnYs=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjqqVwtJy3lyT3C66bwvkKHstzLZOg6E9fH/Gi/Z4z cUaO8Q7YlkYBJkYZMUUWaRtrpzZWzljivDFw3Iwc1iZQIYwcHEKwEROFTMsmGfB7rHuxYe5U87o up9vnt/lIMuqyjDfr2vR70q7Zcor2p+9MW2cOXWl3q+1AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c7b769-ceb4-48e8-c2b8-08dd19e13241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uBNZlh204RCcHlvAEOpE/aIqdrEZX1bXo3gfaNdhphQS1B5Ra1aQsqjyb3Y7?=
 =?us-ascii?Q?7CB5LoGiz7Cq3uxeGg89e0GPK9ivUmQZTNiujVV3RiHt4cpjN5qcWWZmNvbF?=
 =?us-ascii?Q?C2VmqCAn5c+VrP7cVDlfWjlibtwV6TD1+WybAD6/zG5Kq6m4k3TNc3hjTScS?=
 =?us-ascii?Q?WdR4jF0K/qjPUWv2hTlxtdzoNhbDnalC/vLsbbaZEAZDXtU9Wt65oHGLURSi?=
 =?us-ascii?Q?QpTWy7aZ57lqMOmTihzbM/4J4WtsccLMDv3mpBbkwnllXz5qa4YW4Mz4j3Ho?=
 =?us-ascii?Q?KJApON0L+4jtW7DXfLOfD4yR7sFAmwQMSLu3QK3t7s0hENP9oz1gF0g+SSfP?=
 =?us-ascii?Q?7j+k7SuA4Za+uEJ9LwuMGPhl3/FMpPByxV+jCPfjTy3loo47HSvOfEBL940s?=
 =?us-ascii?Q?EKRZ08+C62Ng7XoQ6U54YowZwgSafEKByc1OgOM4XClVS5ggtL2GyT8K/U7Z?=
 =?us-ascii?Q?kEZdv4HFE47kxzWQNu7gHdeulJ/cJGrci4bKv2JZY+IhuLP1WMGW92M6xrRQ?=
 =?us-ascii?Q?vh3Gbah0ydxe7F7vyLPm3FsC+cwoFjHy3NL9yzcjT/QKnaTen/+vzYlZjXIc?=
 =?us-ascii?Q?mRysiJj7yRY4XP9xH83vQvDcFXcJ3uYyxJT4eXRkyaO9Omx+yPUlUcOi8o0/?=
 =?us-ascii?Q?xDDteyWuNcGOoVD0gkQfnmKRbyxNW3eftTcGHnetr67kJPYC31gYyK1hsV/U?=
 =?us-ascii?Q?DP7L+QhxQDxyoZIJMk46vqdrSYx+7ZU7TXDcfr8ErkBrJKu9XZaNIdvHV8WR?=
 =?us-ascii?Q?hkvOPgK5dVsTBpazy2HmZzPd6mmHc21RimGOyI+ogM7M46YloNnL3VMP8m3X?=
 =?us-ascii?Q?ffql42ZEE7ef53HS4pDYpac+bVu6srd+ad0y0y/4MRk01dX15br5999fWn8F?=
 =?us-ascii?Q?Df/06gtram68+1VJ2qUAfbIjg/cmTg2leP8diz030CsHTrtE/BWZTRMlcvPb?=
 =?us-ascii?Q?lT5zvJIuQr1aLRmG7ll2fYxbJHUSJYStsKGnSDGzr4cVVLJ0/4fYFVkrlkWL?=
 =?us-ascii?Q?MUp5X6p+S88+QZGcxzHmUvILyyr+bD5dfIhfCi/jMV0OFRqq2nI1jEKai5Ny?=
 =?us-ascii?Q?U4V+D/MJVokyVHkAfAM2CHTDYS7H2EMMYtvVnb61iYDNWhMRB5U0wLpvuF0T?=
 =?us-ascii?Q?uIZQMXT7cMizmIIjhebZlMKvhpgUhaUFogOO4hrIhPRLrjCop5UrAF7Kg8qb?=
 =?us-ascii?Q?BpVaoPr3X8Pvn4ddCLVZEy8Whk4ams0I+fGgpdDETUOeN41HdGclcnX/jtxn?=
 =?us-ascii?Q?RRtJ7cWGocCfV+SKjc0vyP0NdPCnuhHVunUprhceok5W20D16qIeeEF+dGgG?=
 =?us-ascii?Q?LIeDHac8aJvft9gOr9YTWxHOljInoyLzmrxBWemA0ubiaK8QDRj0N7bgXdky?=
 =?us-ascii?Q?LsBlzLsqBwr2SpFaJI/eJIrMz5JEhEwIqSpRfsFCsMYVMXbsdLWYHf1lDtuN?=
 =?us-ascii?Q?Lo/zGlg1hh1cdmiPfOf2ZkNcXu9atesn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:41:55.7203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c7b769-ceb4-48e8-c2b8-08dd19e13241
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432

Tag boot specific device nodes which are required for booting.
In our case this is sync up with U-Boot project where all these IPs are
already tagged and tested.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-7000.dtsi         | 4 ++++
 arch/arm/boot/dts/xilinx/zynq-cc108.dts         | 1 +
 arch/arm/boot/dts/xilinx/zynq-microzed.dts      | 2 ++
 arch/arm/boot/dts/xilinx/zynq-zc702.dts         | 2 ++
 arch/arm/boot/dts/xilinx/zynq-zc706.dts         | 2 ++
 arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts   | 1 +
 arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts   | 1 +
 arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts   | 1 +
 arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts   | 1 +
 arch/arm/boot/dts/xilinx/zynq-zed.dts           | 2 ++
 arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi | 3 +++
 arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts       | 2 ++
 arch/arm/boot/dts/xilinx/zynq-zybo.dts          | 2 ++
 13 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/xilinx/zynq-7000.dtsi b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
index fe224d41320c..0dfe2ddd0b5f 100644
--- a/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
@@ -93,6 +93,7 @@ replicator_in_port0: endpoint {
 	};
 
 	amba: axi {
+		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -319,12 +320,14 @@ sdhci1: mmc@e0101000 {
 		};
 
 		slcr: slcr@f8000000 {
+			bootph-all;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "xlnx,zynq-slcr", "syscon", "simple-mfd";
 			reg = <0xF8000000 0x1000>;
 			ranges;
 			clkc: clkc@100 {
+				bootph-all;
 				#clock-cells = <1>;
 				compatible = "xlnx,ps7-clkc";
 				fclk-enable = <0>;
@@ -409,6 +412,7 @@ ttc1: timer@f8002000 {
 		};
 
 		scutimer: timer@f8f00600 {
+			bootph-all;
 			interrupt-parent = <&intc>;
 			interrupts = <1 13 0x301>;
 			compatible = "arm,cortex-a9-twd-timer";
diff --git a/arch/arm/boot/dts/xilinx/zynq-cc108.dts b/arch/arm/boot/dts/xilinx/zynq-cc108.dts
index b930a5953b49..5e542ded3d0c 100644
--- a/arch/arm/boot/dts/xilinx/zynq-cc108.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-cc108.dts
@@ -58,6 +58,7 @@ &sdhci1 {
 };
 
 &uart0 {
+	bootph-all;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-microzed.dts b/arch/arm/boot/dts/xilinx/zynq-microzed.dts
index 6ed84fb15902..f2f560cc0c0d 100644
--- a/arch/arm/boot/dts/xilinx/zynq-microzed.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-microzed.dts
@@ -46,10 +46,12 @@ ethernet_phy: ethernet-phy@0 {
 };
 
 &sdhci0 {
+	bootph-all;
 	status = "okay";
 };
 
 &uart1 {
+	bootph-all;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
index 126c0b0ecdda..424e78f6c148 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
@@ -390,12 +390,14 @@ conf-tx {
 };
 
 &sdhci0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci0_default>;
 };
 
 &uart1 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_default>;
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc706.dts b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
index 50636906981e..199fb37257c2 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc706.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
@@ -303,12 +303,14 @@ conf-tx {
 };
 
 &sdhci0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci0_default>;
 };
 
 &uart1 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_default>;
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts
index 9bb5b3a5252f..02876f6d23a5 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts
@@ -84,6 +84,7 @@ partition@0 {
 };
 
 &uart1 {
+	bootph-all;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts
index 56732e8f6ca1..ba040743e10d 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts
@@ -54,6 +54,7 @@ &spi0 {
 };
 
 &uart1 {
+	bootph-all;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts
index d2359b789eb8..d6392d4ece9c 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts
@@ -60,5 +60,6 @@ &spi1 {
 };
 
 &uart1 {
+	bootph-all;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts
index 3fd0d05588bb..f07af61eaa29 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts
@@ -72,5 +72,6 @@ eeprom: eeprom@2 {
 };
 
 &uart0 {
+	bootph-all;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/xilinx/zynq-zed.dts b/arch/arm/boot/dts/xilinx/zynq-zed.dts
index 63effb7809c5..ff2b4e06efbb 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zed.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zed.dts
@@ -47,10 +47,12 @@ ethernet_phy: ethernet-phy@0 {
 };
 
 &sdhci0 {
+	bootph-all;
 	status = "okay";
 };
 
 &uart1 {
+	bootph-all;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi b/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi
index 33b02e05ce82..800e891495f5 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi
+++ b/arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi
@@ -73,14 +73,17 @@ ethernet_phy: ethernet-phy@0 {
 };
 
 &sdhci0 {
+	bootph-all;
 	status = "okay";
 };
 
 &uart0 {
+	bootph-all;
 	status = "okay";
 };
 
 &uart1 {
+	bootph-all;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts b/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
index da76cfd65832..6983caa35b0d 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
@@ -53,10 +53,12 @@ ethernet_phy: ethernet-phy@0 {
 };
 
 &sdhci0 {
+	bootph-all;
 	status = "okay";
 };
 
 &uart1 {
+	bootph-all;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zybo.dts b/arch/arm/boot/dts/xilinx/zynq-zybo.dts
index 4784ef115dad..f365693fe2f7 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zybo.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zybo.dts
@@ -48,10 +48,12 @@ ethernet_phy: ethernet-phy@0 {
 };
 
 &sdhci0 {
+	bootph-all;
 	status = "okay";
 };
 
 &uart1 {
+	bootph-all;
 	status = "okay";
 };
 
-- 
2.43.0


