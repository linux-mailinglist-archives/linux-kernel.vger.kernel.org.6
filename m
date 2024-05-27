Return-Path: <linux-kernel+bounces-190335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA118CFD05
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B88D2837B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F1F13A88B;
	Mon, 27 May 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wpWty3uE"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350513A404;
	Mon, 27 May 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802470; cv=fail; b=JAUbai8yl95TjlYw9LZXZzPzfgOjfQ6sjNRwHf8eY0Tja1RakHUQmJaJoLNhG+fA+E4Ot2EVC4ecgNdg022shULO1pkh25o6hLL1gf3y6IN2ZCJJOAaAmDMJdjAjg1fi2SQFrTT2kbU04sOJZAl42YwbgXu8R64LRPJyCKXS9DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802470; c=relaxed/simple;
	bh=bCBEZQ8+px6H5oYT0wALoIGIFdgm0Ft3zZApiA0cfYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSv61vHFkrwVpqFLPCDPTpsRu3iAzPvdsFTE3Fs6J4+Yth6j8YE54zjH/hLRF3oKlF9wPnaaW+uKz8wkTKASqV9BZAJeVXspG+MdmFJNjkz33lfELW8q/vXD30a0zhRKC+iD9WcgU4eAu4xlaV48+7OyNrMPQEONrlzTLxEVUNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wpWty3uE; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c65J6Mivy2xxhlixSLuEbniqG2n3UXMhmkFzEIBE/vHGHOVccARdyxsl7kD2C5wwOwGn1B+97vy6qNuBg6kAhmVjXSTPwWuYQsexK0l6be87Mm1Vw+f97toY1luAOeH0f1B8U8HKgY1Dz91+5bYSxdDNq36riW5Pz/XfQpjHVTg0FaXyYnW7tb65TFuOM9nRHM7Um4gP2K0RqwQJOBl6k2e562Bna2L0NKvT3fSZ9yWgJjWeZflXOcHkMGQS5WaTIU26nXKrMKzMKmKyX9CBrgwNNML0eBlWbAM+ys71HKHpH/6amgQUcHYnrAFHe6edHYJihsrWP8FL/ci+2m+08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeQPIagTwpBaHD9ilAOKtABcNEBPyq2bO4MNlEHU/pg=;
 b=P4bzNtC6Cc3UPNPuUNocBiViRsuHz+1afTW4HeS80XM1A9AxtpelsZLv5L/3GLWieXiKJqCqOsgQUyGEJqGlfHf+J8K+JqK+zOF5zoHDuFnNuuSJkkZ9smX2GR715rS6BitAh+G7XC78SfdhoWQ0oeSWnRf2lhAEkqV8AD6pwQR9Nl+HTQIGWYOhcNnhrD7Ee7SXSzLlRm1n8KhzVMicn5gmX563snuf6fPXc3N6w0tBgPJlvutr5JnU/cvFNVlSpRZqz7Ajyt7OXk2r3KSCRkK4nOYrTdlOTKydN9nWbxGRlgnOVjVPzRqEENEGx3hA2vqJNPPD9+e+vMfm4rtCcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeQPIagTwpBaHD9ilAOKtABcNEBPyq2bO4MNlEHU/pg=;
 b=wpWty3uE/cZpid92BW2eVAwPCYK8UfWmHGwC7A5vCQ1EN4CFwdpdPV6VtMNMvibOH3fXV8elLkAXp8owjbrXd6vo+JR7139tFHiGBQBWwUR6YgkbPx27HWo5pB/GLDG3ZVZFcR8+DLCONXZ9MyM6wJQGJyDXvzi881lFEv+SPFo=
Received: from SA0PR11CA0030.namprd11.prod.outlook.com (2603:10b6:806:d3::35)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:34:26 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::6) by SA0PR11CA0030.outlook.office365.com
 (2603:10b6:806:d3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Mon, 27 May 2024 09:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:34:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:34:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 01/12] arm64: zynqmp: Align nvmem node with dt schema
Date: Mon, 27 May 2024 11:34:07 +0200
Message-ID: <7796804c7c7dd8bb2c93bdfe028c22746a24fe54.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
References: <cover.1716802450.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=michal.simek@amd.com; h=from:subject:message-id; bh=bCBEZQ8+px6H5oYT0wALoIGIFdgm0Ft3zZApiA0cfYU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4ClTb7y6ymh+vPrmrLY2mXMlPzt3vl0j66r0fPPRm svfrhxj7ohlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATkZRmmGeycPv8Q9snX3lg IO+a1DMlYsPpyWYM82sviyx2t6842nsx4VtQwhS/LyXZfwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c6beb9-ab1b-4150-c180-08dc7e303385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KGLvWH2eBUgJcpZgmpOaf9tZtogiRNuZebNlFfRxrw9+olWLfaVIf+dHX8Ys?=
 =?us-ascii?Q?2yeJaHfe0E0FR4iAxycVQFTbpaP1jV1LRH+xTgF1rH5evLLI+0/9C9JUbpom?=
 =?us-ascii?Q?jvIDG1c8Ac1+Akj/GT6ojPdeY8Wyg+ML9UhWdKpNwi3/XNoEYN7N8d1vmpYn?=
 =?us-ascii?Q?svQY1eUOXgkCC4HDTwru1xOhNbbddq3bKT/l9Rnuz8FEAbkZeiz9fTgj+lig?=
 =?us-ascii?Q?lwdB4viHTvK1ZTB3iNfUuzcLS8TsTT1UsDyIlbtThOcRTCwQHqt4BnEUZqE6?=
 =?us-ascii?Q?bHccAAArxO9d6p7J8mWvNaWZDAacJ5jhNvHMQLAcgSZfCyPSFB0AIFrHdQVT?=
 =?us-ascii?Q?iOtT3Js6a/paG3/ZsE4VLU4d5egRrxYd3a2zcRuX/Yi8vziIQO968WncbZ6a?=
 =?us-ascii?Q?hhoPLMiRwgW/OfQWxj3mcnvh/+AwqEa10YzfHdt9ihWB0Ncs2WakqGnvoJ9O?=
 =?us-ascii?Q?2PVolY0fQGU2O/6qTEffd4Xei+WPnclmdkZ85yyjgWKeP2VdGKZZRdS0VYSZ?=
 =?us-ascii?Q?0C4/gaO91QSCBTZWThqLS8uXTR+wYJSpIKrzNhn1AvTGdyeq58c2mKIE9o0N?=
 =?us-ascii?Q?E/ybqGyxuSnA/WKDuy5dNwrGqEaH23z2iCN4FGwIJN6y5DxCjYC643Wf4jxh?=
 =?us-ascii?Q?iVq41Pleh2Y0yvp5Q+ckUCYfAxFO/ldCYle093fPQsG6UquDXe8A8SEfiVuS?=
 =?us-ascii?Q?fivYqnsCGj+7cn/dTdvSnd4OrMn/t5uiuLIuB/cnuz3qJg6iroA2lAVDKahy?=
 =?us-ascii?Q?0BXxQYfJTCUESUAG07TIJbGm6pEysy7ICjp0wCzUFgulu7melW/fsGQsuOQD?=
 =?us-ascii?Q?r8x7SQHwicLMhNgXP3aq7X8lIN70UI10QQpmNF+dS2bTwxJygjD+uE74lKSJ?=
 =?us-ascii?Q?v9C7MLLL90E9tORzKy3vVtr3gH1lLYYQWZE9rkW/8Y+vv3pL4Wn0B6OHf+LC?=
 =?us-ascii?Q?Fy1I+nIZFd9eefkDPxBc/7O7Vo5B2WRvkWJP9h7EexMvUKAdFjzfH8aWzmMN?=
 =?us-ascii?Q?Nv0z2KXYrf8Pg2m/WWXrK0iV03YKW/8b1OT0LkNDliEB2dhhfYO1fseYvIFK?=
 =?us-ascii?Q?rtZ3Os4W/30Abn01kYWvOnKL0N1xs1fFcf44cDRrKWXi1gUKhpiDoOLahNi4?=
 =?us-ascii?Q?bkG+IFojUG88Oo28hPHvPSy7uEBVA7bbtvCojhYegwz+DRfSHQxVWqKunoI7?=
 =?us-ascii?Q?4trWz/OjFDUukR0/qa0cmz7U9UHIpqQWIQv3okNItChB3sL2KNXUOLH5efTS?=
 =?us-ascii?Q?nUCS+D+lEkbHNZIni8/17qcf1aav7qhlNzN8APbLiogtcmmqRCC+oCI4Xk+f?=
 =?us-ascii?Q?6ZPdvk2cAKnwbfk8gMWg4UriMwmVsOYBx9LaktzB/epDmmN1lMNlVHNWqs3N?=
 =?us-ascii?Q?4GQ8MQw3+LLlg5QPHUs0UDu4PmXR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:34:26.7232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c6beb9-ab1b-4150-c180-08dc7e303385
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891

Use new soc-nvmem node name and swich to nvmem fixed layout.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index ef31b0fc73d1..7a5388b7ec6d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -207,13 +207,16 @@ zynqmp_power: power-management {
 				mbox-names = "tx", "rx";
 			};
 
-			nvmem-firmware {
+			soc-nvmem {
 				compatible = "xlnx,zynqmp-nvmem-fw";
-				#address-cells = <1>;
-				#size-cells = <1>;
-
-				soc_revision: soc-revision@0 {
-					reg = <0x0 0x4>;
+				nvmem-layout {
+					compatible = "fixed-layout";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					soc_revision: soc-revision@0 {
+						reg = <0x0 0x4>;
+					};
 				};
 			};
 
-- 
2.40.1


