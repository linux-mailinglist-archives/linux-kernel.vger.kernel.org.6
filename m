Return-Path: <linux-kernel+bounces-190346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD28CFD1E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38BA281D48
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDA213D89B;
	Mon, 27 May 2024 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D4dSxwCT"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3389C13D625;
	Mon, 27 May 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802516; cv=fail; b=o3FilF3kYopa0YhGbf6vXLgPb4wnK5mDw+d64V1z8MI6SclUzLNxd15ftsrzBbNv1ee2fzACH8U60R+yGVJOrFuqgOXk1e1eQg3R9MaNYFUVHtPSHMC2atjvT0io9ZY4YfRiH5Pqm/ESa9bDWepeYMPR5FflqxxfCEOa2oy22eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802516; c=relaxed/simple;
	bh=1B1hktzh0i3VoOt8iejLN/qOsMQhDXmw1I3OEu06Vx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDrsf5KgJZ4qm/h75z0EiQpAqnnqOsIh0HEHwqVelIdqG+MkLFVZnjUxEu38kIQZpU9iH6JZkuB+5memp7fXMBxYy9XiTg/x1TZoZpBlmpGklxBtTspE8lClS2om9E18daPqsQdurmDpUpSvMh0+a7EiGz989MNt8nmOillQkkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D4dSxwCT; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l05f3ZkxrGprghR9Hh7pIvoGP0HJxERBm2TXfmXJ8z/6S3UG4SxM+dfDK70Pa4qIRcsoGB375r0KNmpSbGXozufxHYi5vaRvdg9PBalqHcrYMDTlFzbPl6zZrxeiH2yIZsyQKDBp1EW9ZUClqRAtqvjSdBC9VpyrZh2ZzrwNNcdBxWCn5ubT5u1/gqw/tg22at00uxtkRXDRHIqaCccnld1joRhz7DMOwaOND2ygZSAqcDB2Z6lqAy//QgTVoR87/Lh0ni8lfnxa0BWj6bG7zaUpfLiD+6g6NbNeCpU50A3RlKuG+teUNXBJUzcoXSrCRhiE/30OJYHmu8j8L422OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po3PJVDMvKwjdp+JzHTvBK7TWk7kNYIR9tlr/DE07XA=;
 b=Ss0xS+0GPjkDKEHeR+7rFyidiAmWcDeA3K9sV2GQGavtji7oIqrJcOho8iUaBFHswi7V4IbkJvWOfj4nDecnI5F1ZkCxZqZEMJ7mpFwudsSZZo/X6loyWpEVqf1D0kb8Tl1r2LYDoITjk0CgVl7aes/Qg9BTLTK19zFg9wwm4DtqgDAdzN46yrudemdXguaJHgW6eiYW4AFW+za5TTC8XmfHVwGRslfAxMtAKvfHEJ8GMBPMN7C6TrxBf76YsK3LujmD3sID77zaLZ9OVTni0L4jMe8CHZ+077+lKkyRrBpifHtTPuczaCCfOFx+fbTL60qpdtHD8x6gG+gwIIHzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po3PJVDMvKwjdp+JzHTvBK7TWk7kNYIR9tlr/DE07XA=;
 b=D4dSxwCTbRUgww4tcXhJt1BC4v9V3kUl10ADgDlbQNKYT9aTH1knxAAuO7IrsTNYJ4ZoRVBsxXUZ58/qUbPV2PP6AEk37CUooLt1D75/dAbMs1KUMj18aNwq5HkYxEBoKN9IqxrLYyZgsOAhNesgzYz0KPltTG59gitwXY3GGoY=
Received: from SN6PR01CA0032.prod.exchangelabs.com (2603:10b6:805:b6::45) by
 MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 27 May
 2024 09:35:11 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::d6) by SN6PR01CA0032.outlook.office365.com
 (2603:10b6:805:b6::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Mon, 27 May 2024 09:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:35:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:35:10 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 11/12] arm64: zynqmp: Add support for K26 rev2 boards
Date: Mon, 27 May 2024 11:34:17 +0200
Message-ID: <458698666fdfcaaac70967d9f755422a480bed99.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
References: <cover.1716802450.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2556; i=michal.simek@amd.com; h=from:subject:message-id; bh=1B1hktzh0i3VoOt8iejLN/qOsMQhDXmw1I3OEu06Vx0=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4OlSh/ebn3lytbJ08Xujkx3SKXOZJVdvlup55SvI7 cx/ioW9I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEwkWZBhnr67b3OKwdJTximM oukv+s/fjy3YwrCg83Y4f3iPXHbyB+lrwb+c2G4Ifm0AAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: db686e76-b916-434c-214a-08dc7e304e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w1KBLcgVpvHjF9PaTc/obzJiQCq8/L5nuaZVgUjfBcEdbD+nqRt3iNeELh7f?=
 =?us-ascii?Q?UKswfxz6c3UXK4dGYPcMyuhalNcIXVv8zPuUOlbKKncqE4HYJe34Yapc7YiM?=
 =?us-ascii?Q?tQ1itvqBKI+J25QJuCbDLMl1cz+82HG7KAC0msdzhRsXLS1mQwckTW0498nl?=
 =?us-ascii?Q?rKPhS99oVS0ZwjwmX+SyRY8/u4O85Ca4ko31NR9aCcqCDI6M4IcTDb7ejdFE?=
 =?us-ascii?Q?GnLFznpgoLDXfeyrAORm3quvQKK1XGhWsS5kR0nqPKwHwAz8SK3dRvQ0TRB9?=
 =?us-ascii?Q?GTxyEhAafo92qi6e7cJ1wAjAVzQiQvYCwT1o84GOvadH5eNI2jyNBw3rAC+h?=
 =?us-ascii?Q?ORtRfXeVXw0C/1+PvJjLmYOWcqOUFI67nrA7a/Y0eh4h8+YQ+j7Oxd+CHLfc?=
 =?us-ascii?Q?zfyzlbDiE/XmQCt5RULfljZXWljMD42JYyNEjWF3NQRjT+d2FjrgvGBi8YTl?=
 =?us-ascii?Q?4IovphgPScL6ZDa2dwhvP8BCa4hZWghQyxBIYiAh1rdz4vhUSnvIykYCa2GZ?=
 =?us-ascii?Q?7nQAeZ+Z5n70yLRzI22S2GMW8QXCCFMl3KWplOcS3vFGkORNDMMNmEAqLVCu?=
 =?us-ascii?Q?Qpir34a0PGszH56gbxEyZp0TlXizNiEmWP+9C1ti1ou8Lf7/YUv/JFMZA8U4?=
 =?us-ascii?Q?21hq9/p4wt2z8KzhVzpQ0E7C59R/LWwMDyjUYe4ZoeEe5QPxpLoNfTCn34cP?=
 =?us-ascii?Q?WVRI0PfObLkFtTcFCcZKfkQ+gXFss8cpbcqVgqkgvUVEnhBddu+OOAaHifX5?=
 =?us-ascii?Q?P5uWrneADnZ9jrf7Tm2z6H2w3Bt7MdFBc6wxElEOq1lyv03Hjb8DcSKN5vHG?=
 =?us-ascii?Q?vH2lVKSDs5GCSNs3U2vLsNRBEg3pR/FUMJJD/GBCpgPn/J8Sx5i9DkRK6UH3?=
 =?us-ascii?Q?+qrEt7ZLUwn5cNLZHnnhHhbHkdlXuTXzgf81QrGSKQmcwjHHr7h9imY5ijc5?=
 =?us-ascii?Q?3aMI+NyyzFWvL/grN0XcWu2LoMLZDMBLp5yh3b+jnc03KV7TA/jCvvGNCA+/?=
 =?us-ascii?Q?YQ4BeQI0KqAJwMr/Z/T4+ab/fY0c3N114l7C4VMtl2R2hp9cfTwfBBWSw4Ub?=
 =?us-ascii?Q?plck7Etc1RH8HpWiXTaT+235UHsw9SP9Sh80xbksrBbNHAl4bGt5VNkGzrHk?=
 =?us-ascii?Q?6CyEvpU/vy/ubulM90qGu35BIhSWOx1fRRGHpTsbMgTBF92lgjpcERwf3Dhe?=
 =?us-ascii?Q?v4NjAn6LZ/qcqOQcQfHE+zQ7phIGZfuv/Cg4b7VXfF8KCuAHWhZU9TgPEkjm?=
 =?us-ascii?Q?Pf2I8AxIcIaGAUdjwZ4S9Gu1VsQIbUZc/y8Kpw37qJLd2Zc7b53aBzBI7L3H?=
 =?us-ascii?Q?F5DUqoLzQt5M+ZNPn8iK2V1/rcBHjYencm8BDf//NzXCr1grW+6HvG0UsV7o?=
 =?us-ascii?Q?bdGzBZZsbRjodV7flQ1CCT85rXcL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:35:11.5392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db686e76-b916-434c-214a-08dc7e304e3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

Revision 2 is SW compatible with revision 1 but it is necessary to reflect
it in model and compatible properties which are parsed by user space.
Rev 2 has improved a power on boot reset and MIO34 shutdown glich
improvement done via an additional filter in the GreenPak chip.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts  | 8 +++++---
 arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 51622896b1b1..2841be11ae66 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * dts file for Xilinx ZynqMP SM-K26 rev1/B/A
+ * dts file for Xilinx ZynqMP SM-K26 rev2/1/B/A
  *
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
+ * (C) Copyright 2023 - 2024, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -17,8 +18,9 @@
 #include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 
 / {
-	model = "ZynqMP SM-K26 Rev1/B/A";
-	compatible = "xlnx,zynqmp-sm-k26-rev1", "xlnx,zynqmp-sm-k26-revB",
+	model = "ZynqMP SM-K26 Rev2/1/B/A";
+	compatible = "xlnx,zynqmp-sm-k26-rev2",
+		     "xlnx,zynqmp-sm-k26-rev1", "xlnx,zynqmp-sm-k26-revB",
 		     "xlnx,zynqmp-sm-k26-revA", "xlnx,zynqmp-sm-k26",
 		     "xlnx,zynqmp";
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
index 85b0d1677240..b804abe89d1d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * dts file for Xilinx ZynqMP SMK-K26 rev1/B/A
+ * dts file for Xilinx ZynqMP SMK-K26 rev2/1/B/A
  *
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
+ * (C) Copyright 2023 - 2024, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -10,8 +11,9 @@
 #include "zynqmp-sm-k26-revA.dts"
 
 / {
-	model = "ZynqMP SMK-K26 Rev1/B/A";
-	compatible = "xlnx,zynqmp-smk-k26-rev1", "xlnx,zynqmp-smk-k26-revB",
+	model = "ZynqMP SMK-K26 Rev2/1/B/A";
+	compatible = "xlnx,zynqmp-smk-k26-rev2",
+		     "xlnx,zynqmp-smk-k26-rev1", "xlnx,zynqmp-smk-k26-revB",
 		     "xlnx,zynqmp-smk-k26-revA", "xlnx,zynqmp-smk-k26",
 		     "xlnx,zynqmp";
 };
-- 
2.40.1


