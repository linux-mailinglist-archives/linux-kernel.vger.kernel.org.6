Return-Path: <linux-kernel+bounces-190339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D36F8CFD0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32826283BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7860613AA47;
	Mon, 27 May 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EFVnsoTG"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3F13B7A4;
	Mon, 27 May 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802490; cv=fail; b=AGtyEcy/2S0y8wmxjL8KgyW41F4So4k9h5nudPLXnHrjn9o61xeMjPU7HVA8uqYSj4S7K0rWdIs1AHQmtHK3lL6w2PiwTd/uCz1DnfD5i3AkHLDh50jL/bf1AolDRqpzX+qUGWQGykwqkbKRDoOTUlldpzivbX8u3COYIzQoMgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802490; c=relaxed/simple;
	bh=Tm1WHUp/wD0jM+kkov4G4hHDjMyBeYaX25w66z3FYRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvY7ZdHDj8c0Ss8bwvbYVeTD2MFgKXxGbuht5t2xruUhII2VAmLkjA0NSih8txAbmrjqS6cteEUYs5j4jfSjIQ3THj9ithm5b0CivEhrG4JgJJaNNRSGsA9gPfbY/9H1ZQalciaqk2bQtsEt6WFz29E/vTFKyWSjSo2i30p3MRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EFVnsoTG; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUQtEvWsk/TvikRYITPK4i7Fqfkx9EG58um7YwaU+UveDjOjU4exvie5SqY7RZzkNIcwbvzwoPf5+EY97PCaIqaVQb4/3J1yyZL4YRd1yWP1RgYivFMpNe+CK12rQK1nYcbeyH2W7s6ECGLlPm3W4SBn3bufcw7SzATuL2r2+piJHJkJtxLldbJWkVAZCPq675GVC7t8qdYX7jy/MqRPbqrSXuDPbkrNIRc+so004ftZwcvzfLA5CjJJOiJUP1h3YLNiNxHKBOUy8x8zBTfHLZpNVfLR7iSvmWU/miEoEVwl4T/aHKpAPFt+hU8+eAj1DH7XvcbS9R9olFcVr+Ofog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3oJPLkAYqUUdIfGjepHujczz/4OLsIsk9iIWP4uOQE=;
 b=Eof99EOe9/pA1Sb/oakHUWJCRpY7/3E2QEHKNofKZIOdLbNjwCTHBmzxv9394k7kC4pUWyLY0nFSrtRjo66z7Bv9syQlQmZiENwCLccK+jXeywDKAp01Dly43k2v1FvM4BmHwP4cnQK3IdpRElb3TtSPAQ0qwLDyKqqICJRbP6nlY7gyPV5bVgzy4inDKyLQOLnyTCrAqItOfBvTyHhPUYmg2jj4QN+FkBcXBlaMGZpIwylzI04wYIsGyM2fTkrb4xs21RWiIT3w5L3gAzrIvy3eTwcf/yPlXvj+9p1wTKrYIpESwYq/FfgY1yFSlKsUvzDRS5kduMvDrixm47PT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3oJPLkAYqUUdIfGjepHujczz/4OLsIsk9iIWP4uOQE=;
 b=EFVnsoTGmU5YYb+k0/jxTpEySt352sOtvJl+wkfFiE/8kL9aRsQ65o+QHPT7yUuqIeNLpIa4oOoZrx4O4zcIbjzfsgfSQWyc0MNmK6S+C6ltHX9fNt0shKK8lQxuRQHsNBdzARXlBhllu43D6BYaZSsxsSySbvoIcdJ4GBTq24s=
Received: from SA9PR13CA0060.namprd13.prod.outlook.com (2603:10b6:806:22::35)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:34:45 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::8) by SA9PR13CA0060.outlook.office365.com
 (2603:10b6:806:22::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16 via Frontend
 Transport; Mon, 27 May 2024 09:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:34:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:34:43 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 05/12] arm64: zynqmp: Describe OCM controller
Date: Mon, 27 May 2024 11:34:11 +0200
Message-ID: <679736679fdf7897d68684295f6ed8256fb5f18e.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
References: <cover.1716802450.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=michal.simek@amd.com; h=from:subject:message-id; bh=Tm1WHUp/wD0jM+kkov4G4hHDjMyBeYaX25w66z3FYRg=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4Kl19QuEJyveEfyX9+nTPOG9Ibd6l3XPmnLtVc2aR XmHn6bf74hlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATybjFMD/Vqkb9Rv782m8B Tks/zBHa3ZE9T4VhwWSx+unxbj8rLvue4N/5SdMliz9tDQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e67784f-bed5-4290-c16c-08dc7e303e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?88V7QA7MarHZt25Q+qi8xPqixWSW6AochGbk3cY/0HsQc5wZuZzbHZk8EyNa?=
 =?us-ascii?Q?mXr70m6YwVxy2EFK+Uw3f63VFyw6K/mvnasEdQymW95ylMacma7y/DkIIYXd?=
 =?us-ascii?Q?fSBemY7W/Arya4koXgSNvz8yW/qmMfMIC0BgZXJYKv/JUHNOmv7z5cthi2y1?=
 =?us-ascii?Q?nKI4x/4QnKlPdcxkGmZLnwjsWuntDjOAQVUB8cvRJGT/uWRwtIAbfbpuJwDs?=
 =?us-ascii?Q?2kVKDVd8qoo06a63TnipNXyVeCwFjrk/0/ozU4n9Kutt7aLxaWuvyRx1JVlW?=
 =?us-ascii?Q?ZZsm6fnpCLlItLcHIXImoSw+V2isEw0OL1UyHOnzfZQRuXPpDmbOxVKGwMlz?=
 =?us-ascii?Q?7M63c7V8OhNr/6IzlYCjKpWkFZYLlySKR20pKl4egfUbObq9B6T9I2nez9ls?=
 =?us-ascii?Q?Uo0Ldiih8S0EaXeNLRGml/YQk6yoKysVqffDs67S58wyf2tkuJLSSaCpWfs/?=
 =?us-ascii?Q?AiQTvTMt6ACj6YkLobp7QhVo4TsJEZjDmflOe1yjP1umy3V/MIK33MeroQf+?=
 =?us-ascii?Q?803eKI0BkuSm+v4PnvLvvtJ5U7CmqXmu/ehIXe2fSA8Kv5Dq+kXrrnk/Hd5V?=
 =?us-ascii?Q?xMjeznESL2lfjJWZ0FaNUdvTn0eroMByigDIxS/vqHMuAOThUD9JQrIQCApq?=
 =?us-ascii?Q?SjWwp6Z19lc9fHGiDqT+t+X4DSfbGL4destvVINhkbg+H9lGVKrEAkrBdUPo?=
 =?us-ascii?Q?EPOpET86edc9c2mXL07SmHwj+ENleYGQAnEvpeH2ZerPTdrcNaxpG+dEqBWN?=
 =?us-ascii?Q?qQfYRQ0HzDG02zVf0qfz7Hqo1a1PSOlYsVtMhMUoJjT7hOGz9vDVZwRwnBIk?=
 =?us-ascii?Q?oLSl23ERdkRGjt4q87QK+mkaI0UgZ7moTxxVVg2mZbyBgdZ659QKNjpdZ0Nz?=
 =?us-ascii?Q?9u+QoqDT5QT372u//YWKE3UacMM9/+EyEyVSz2hmNjoB5/Ba1Db26aDyfH4J?=
 =?us-ascii?Q?smcPifVEoLJWymDHnBjS4rhGfwldderdRdSXCbbSrSFDuZtID2+3JI9jwIFC?=
 =?us-ascii?Q?WEj0gufnxfprYIrUeKkpx9cy2wNn7+ZGT9a4nZhXQjO+xSk5g9Q9V0L9Wq+r?=
 =?us-ascii?Q?1QLNFXzCsdatZzgFKsPuIrXxOUJ5+kV7MQ56ZQrGiSX44fD5byE0dHe3jpTH?=
 =?us-ascii?Q?5fqiy1yIKSGLXME5KWCJLrUHaZwixpPQJzICDmiNWgnrwuoS9yqxH2/UtsAX?=
 =?us-ascii?Q?WU7L2LCJQvrH0qBocrF2buFifgio2gNUdqytMTm44KdFinAdQlh2tuiunieT?=
 =?us-ascii?Q?ARGboBI5hnqNQd/fMVQM7mKys6OMLEaXlHhQnWUHf73giyMxU88FoTUlCRQ1?=
 =?us-ascii?Q?ZVAgA3edxtQnMwUa0RuLyPKRAQISOgLA+TAa3Gs+x1/e6iLHgBt7U/tlbaRq?=
 =?us-ascii?Q?ZeLDC3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:34:45.3198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e67784f-bed5-4290-c16c-08dc7e303e9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725

Describe OCM controller which brings EDAC functionality.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 90fccae7ff5f..27adead77220 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -799,6 +799,13 @@ i2c1: i2c@ff030000 {
 			power-domains = <&zynqmp_firmware PD_I2C_1>;
 		};
 
+		ocm: memory-controller@ff960000 {
+			compatible = "xlnx,zynqmp-ocmc-1.0";
+			reg = <0x0 0xff960000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		pcie: pcie@fd0e0000 {
 			compatible = "xlnx,nwl-pcie-2.11";
 			status = "disabled";
-- 
2.40.1


