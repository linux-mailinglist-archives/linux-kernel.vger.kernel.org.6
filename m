Return-Path: <linux-kernel+bounces-279325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A294BBE3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9881C20C6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B418C333;
	Thu,  8 Aug 2024 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pWKAHg5n"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB018B497;
	Thu,  8 Aug 2024 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114999; cv=fail; b=dz3+LaoJMhOiARUcyIAZ0Z1Omj/W8qzoHCB98zD81f0ebyRD3WB1vbEBnjeamiICM5R4G1aT6urfJVSWZk6lAXJPtr0ymqYkqXqBFis9P8qFgpdbLW2o30lM1LEymlf+sOHNlGu6BE7Bs2OA3aEcQoin0HmbDKeWfn22cZrNDwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114999; c=relaxed/simple;
	bh=GgCIrlx0tyjympQ2X5oOOtqOTL2ybhrNDVcsP5KHxvU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jkA1lD1yjH4FbMSXhnFMIT7Iv9T4jjyqKEFf0LNNvwJ1nOk96xsvF7wLDP+QwewQ1yw+lc/oL9pobz5oxjgzQe3zebHZi3H+y4+BIW/smTzDocKBP6JhuHNvg2GrpQ3GXuogfivBCVLj6wV7jeZULcuXGflCfr+7zwPPsDBSzPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pWKAHg5n; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMgsML7MdFV/BpUlo0Q0CwzKdmQUIyCFc3c8v8zVbL6TNwcCOSaDtCDTOmDTwECwIwpaMS9PMnd+MiIN8YOeOjn1NVWcSgX6JpMj/dLbdKxmhv0H+vF//Snv1j68EHhSRLmyONRanRrpjQ1UgtBQHbt5ux8BYZOtim5cXl5HHxOjKv8/PMAUGV24VdRg42VeuJPwSV6vdaQikwfMUVRm1uAIIx/DkHTv7tn1fv0jnEmL21cIaUIl1IZf3qb239kzs+CCkCKUoBuQcvcCjAgwxlQ5k/K7eTiEriIT+Kd9xaOr15kKA1T+WZhnJm/ALFTT18GM9Oox5yG4au3m5vNd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWynqV2KKEovHr9iEO0m85/+WPBxVLeeg4DCkVUXEis=;
 b=S1TDnQlKjRSqjGapRaGnfoG+w1Ma5ZOIq4h7VXEKCzUFBP49aLDx0y7VpiY7qJD94xFfwXVzojnbvqoaL2fvWINXEokOdApmtFuF8OL+jvIKcneyQDurfmIxFptafrLiMzPZqyDHTp7sCf4szL9tdd695GOoyoJOnlKt4Spw3j7a0kXmdH/xUQJrF98jEcjHk/0uaJ/0epvAo6oFhtLJjgzOFauMf28BP1Spqt2cm8XsgjcSyH+MpXfWII70eLVY5FfU7Dw510WG0N7PsYhYoP2pBhsDrtehLM5Z0Aw+RlM1NbmHFxyqtgyASb9gp5YuBM/+pe42oogLDpXsmBbmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWynqV2KKEovHr9iEO0m85/+WPBxVLeeg4DCkVUXEis=;
 b=pWKAHg5nppF+CEoJR7KpYaBNnisW+scc2dLBDZudxQF5JQupUuwnY0ElTTULp2g/kgRIGeQLQ8f6BbJKTjCdX/dISgfrg/UuEIaZyA6BsrKb1RGVKccjcWt0tEEIfxrMocWAJzZIwgwvIFgQXXzPNquWRCPMWfcwLmVwaQnsNGw=
Received: from BN9PR03CA0246.namprd03.prod.outlook.com (2603:10b6:408:ff::11)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 11:03:14 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::39) by BN9PR03CA0246.outlook.office365.com
 (2603:10b6:408:ff::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Thu, 8 Aug 2024 11:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 11:03:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 06:03:12 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>, <robh@kernel.org>, "Srinivas
 Kandagatla" <srinivas.kandagatla@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Kalyani Akula <kalyani.akula@amd.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Praveen Teja Kundanala
	<praveen.teja.kundanala@amd.com>, "open list:OPEN FIRMWARE AND FLATTENED
 DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] dt-bindings: nvmem: Use soc-nvmem node name instead of nvmem
Date: Thu, 8 Aug 2024 13:02:59 +0200
Message-ID: <1184b2799ecdeef04128f4bab3db7460fd8edb10.1723114978.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2283; i=michal.simek@amd.com; h=from:subject:message-id; bh=GgCIrlx0tyjympQ2X5oOOtqOTL2ybhrNDVcsP5KHxvU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQtS59Ef5s489fW/HVnf4X+YHJKVf3DqnvxakTl6sdFw lYbph6Y3BHLwiDIxCArpsgibXPlzN7KGVOELx6Wg5nDygQyhIGLUwAmEhXCML9mWft1tYU3OX90 Phd88dCY3+mk3hOG+S5vld7PLCqJWHxY4sQyoz3i6X9VvwIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 57985ec9-2125-499e-bfd9-08dcb799b2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iXLKvKuwk/JJdL+oR5zn53SR2LirYY+TZ4tVpbxlq1Fa+LM8Dqf6ulux3SBQ?=
 =?us-ascii?Q?Cpuq2EL5Kei6ibYsnuHb7fJ4OZzDK+RX336XM55W6I3hokjFa9tf3JmCZ+FA?=
 =?us-ascii?Q?sZ6MyKW66+wfQkH/WKC+Awwfct0jzn29URmmq3P49HagNs8XHEOuCCIjjHyi?=
 =?us-ascii?Q?mUHuNMI36CWki0rAzYHWtqyaQpien77D0u1ktIm8OQiiAdj7ZQlrohEuSTFA?=
 =?us-ascii?Q?pQ8eEupu4j+tSRGC8LBYeH0oQofFO7uT0A2gpYma+vXx0/2tOlbvksYiWeaE?=
 =?us-ascii?Q?/2wYYwZU7WYT5SlxqK2hBIMtJRtCH/mZxRTma98Qa6G8mjyHkSf1E7NEsO1J?=
 =?us-ascii?Q?DMSkbapSobgcfmnfzwlekeLcFLDRhKiWrB25zJH74c1vz3LiuJCgB0O056qq?=
 =?us-ascii?Q?3X1+1+D7GV2uFgB7OhAovgWIW3qCL+zJuqQXN7ZS/8XefnC+VGrJsopPrviX?=
 =?us-ascii?Q?Ow5Y42wdcbZcF1Pa7Peo22iRgyXyZ4vGf5Zbi8vZrwFNnhdhhG0lO9RuuwYb?=
 =?us-ascii?Q?Dv5ivnq48STTfxaIBYKSpReCFtZ3g9okjC7xhdfRud91kNtDvJclx7ykkEe4?=
 =?us-ascii?Q?dGFl3O947XGTgA25Y8hnMcA0ymrPLpFiBeTDYtGDHqfy3lsQ3NvW1sbmZ0M1?=
 =?us-ascii?Q?Zcw3gxtXIORjVLQdrN/T2kFZWeUjWYyYf08EVgRSORlWUnx8npUTYuKG8DqU?=
 =?us-ascii?Q?05Q8P+VEbQZUFQS+2aiAQUHUcaaQ1oTJpq9o5gcx4gvnkRssrQBqG0VY/9ss?=
 =?us-ascii?Q?myv4oQy0bXc1NaGMfdNn9B/lpO/qO1xxgRL9InUjAq9QMj2DcgGqW+nhrWv9?=
 =?us-ascii?Q?cZRlq+QIrt5TZqHycesG9KRXChSflyISQBwSln+qTAs/CDStLK/uMMVnfaVe?=
 =?us-ascii?Q?Q8xcjxSGPUzvNrUzmHw8wjJgWBZNU/o1x+Kje/frE3C2Q93e6MlpioniMp5z?=
 =?us-ascii?Q?lzO4qWh8uOAa25Xk2z4pLa6/nNGnVl4FwqOH1eVQYZ8tL1FsN+Pk8PIJJuvx?=
 =?us-ascii?Q?Aq3WZD3ZVT1d+G1Ue6OwE5/FGYxK/kfDqKjcSHgyICvaiq9ytI/bS1309KHZ?=
 =?us-ascii?Q?Ppz33SvUB7hbwvyB7LyTZXaTRjdNlS+CsbPEOucQ3FqXP6GVS+8olNoAhmHa?=
 =?us-ascii?Q?LdhhrkCdCgkIW42fQBJLoc53s+SY8zglN8DTh80Xr5b/ODHo3e8/EHAWADZN?=
 =?us-ascii?Q?4NbIHeodSiprYFXzmNNYIFSKzsl8+/zXABhd1Fe3wSKlVRqsVnFq6/eH4usO?=
 =?us-ascii?Q?0nvBpK31p34DBGPR0oJEerCgO8MGxSWEbEEzcgF/sQ3hqBJ585N6EvJmD0Ch?=
 =?us-ascii?Q?WU5PuWGJdeajRgYYXwqTRkoDF92wS/chj0SAEdEGXGZKNqlzjL6C086/5TFL?=
 =?us-ascii?Q?MMkK5Tk7vW7HDgV0IenNLAOMbkl7AEmrUWJc9SoE5ElOJ5BE7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 11:03:13.9527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57985ec9-2125-499e-bfd9-08dcb799b2fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that's
why also update example to have it described correctly everywhere.

Fixes: c7f99cd8fb6b ("dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml")
Signed-off-by: Michal Simek <michal.simek@amd.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---

Changes in v2:
- Fix sha1 in Fixes tag - reported by Stephen

Adding comments from origin version
https://lore.kernel.org/r/42c21f3bcd75f821061d047730dbbcd40233e256.1716800023.git.michal.simek@amd.com

Rob:
 This doesn't seem like an improvement. Is there another nvmem node at
 this level? I would fix the binding instead if not.

Michal:
That name came from discussion with Conor. None suggested to fix dt-schema that's why soc-nvmem has been propagated to DT already and this patch is just fixing last occurrence.

commit d8764d347bd737efec00fae81133ffad0ae084bb (tag: zynqmp-dt-for-6.9)
Author:     Michal Simek <michal.simek@amd.com>
AuthorDate: Wed Jan 31 10:17:28 2024 +0100

    dt-bindings: firmware: xilinx: Describe soc-nvmem subnode

    Describe soc-nvmem subnode as the part of firmware node. The name can't be
    pure nvmem because dt-schema already defines it as array property that's
    why different name should be used.

    Acked-by: Conor Dooley <conor.dooley@microchip.com>
    Link: https://lore.kernel.org/r/24fe6adbf2424360618e8f5ca541ebfd8bb0723e.1706692641.git.michal.simek@amd.com
    Signed-off-by: Michal Simek <michal.simek@amd.com>

---
 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
index 917c40d5c382..1cbe44ab23b1 100644
--- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
@@ -28,7 +28,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    nvmem {
+    soc-nvmem {
         compatible = "xlnx,zynqmp-nvmem-fw";
         nvmem-layout {
             compatible = "fixed-layout";
-- 
2.43.0


