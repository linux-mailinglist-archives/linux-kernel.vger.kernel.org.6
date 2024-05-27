Return-Path: <linux-kernel+bounces-190345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6689E8CFD1C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CABFEB22EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43013D29E;
	Mon, 27 May 2024 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SuiIWM8J"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1A13CF82;
	Mon, 27 May 2024 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802511; cv=fail; b=cHAnx7DtHfmq3/w+miQsJZXLI15KgDcgD4umlNHm8I+FROMaCNhQH3e5F8tSbOdyOwJLBkfi1sLyA5N66xXRZ57UTJlCle37ycC6nDwBxM0/Sh4h4zLxOA/St87w8Al1GuPdX0Ihz2g68Mr58bGEEYTdvpmIHQJ0ODDww1ZZAJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802511; c=relaxed/simple;
	bh=jX/FY12j1DVaEMqTrX+BHgNCKSIcCjYw3CXVcT3XOqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CembMVZKvpJGTYPI6nwiog+8rDgCEW8ASoPL7Z3akIlZZLEbcfI7wA7qK2iZ7Z/nL6nDz4Ee0r8pU3r2KLt7Z5q6hol7F4H2qdDvcRNFLlJbG/DkK/D41uI8XYYo7D22Idu37iT98T7Z2SVNPGQZdgcFsH4lgMfprkhcOmMXFEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SuiIWM8J; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAqFub8Wb3mHM9gKuytmf0fLc6xzxhvnRiNtZt1bVwDjtXOFPPxmKtMwY4ntp/OsB+lw8tdnmjuzewyEOkEas5pUpCSI4noBQmdPXwXuS5kQl//Nxs0qvXPENHH5tR/JmMbUsnVb0oPUQWuhFPCWJR9oFf43cO3MpgXLsQVRu4VVlm4XEYnFmomu7JCEYHQxoksWlvKxApdpN61e42tc78T96Q+1dkdbuhsDSXzKV1tptiGXiXb9SYbGqStqaWe3TjVMmbYOeK9Lu3lOKoTto/8LCGWFrHhbap5C/FWL85Z3A3vzuj+Mv9Nz+etE/cAXXblROlVLWaTXRq2mZohGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UU5ekrvo8DXTgjo7t1BkQJDuK9lx4hQvEuTw6orCsY=;
 b=DuStwtPgyJk72hOLdXsH+JX9wyIQKVTD9L/on9VcmhIZbSksdfXvSi1BAC2DE5PWHFlB9aYheYVQZxMI6X7v321kFPEkgUCaXDOLwkjlRf4NBbX/r4JRrhSzGmYpcwv/U8vuTpZiUhvXky0t5+5i9gqsa7KCGSfU6tloKhaWxKmYJz7qnkYi3GARxC2cqENts7cvymslfRDWJ7m4QmBg7fkHA5JbS9gmMFTOZ0dPws6YBbg5Y8B9gBO9BZ8NikM1qZiOH846ppCcHp9Aujzz9hFb/zDrpMzaanXzsl/9guFpYQNk0RsLbVqNIeT9YYVnzgGsO43LbJGIsT5GRISgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UU5ekrvo8DXTgjo7t1BkQJDuK9lx4hQvEuTw6orCsY=;
 b=SuiIWM8JQnqECLBVC+Jkicl87I+qckmtHd4W6FagY8Q5ORpAM7mXUKxlENRC0A8yPAelTqtAe0lerfBbZ3Zc8/EvUILeGBjuo0Lev7EElVjEr3hQ/uxvx5xExN4oD8F/9YwNsYi98ReSzeSC+tkGXr6AXYoXj4pv54J5ty8J8uQ=
Received: from SA1P222CA0087.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::20)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:35:07 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::cc) by SA1P222CA0087.outlook.office365.com
 (2603:10b6:806:35e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Mon, 27 May 2024 09:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:35:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:35:06 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Vishal Sagar <vishal.sagar@amd.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
	<robh@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 10/12] arm64: zynqmp: Describe DisplayPort connector for Kria
Date: Mon, 27 May 2024 11:34:16 +0200
Message-ID: <4f69489c005719d280b8df97f3e82a5ce0cd9660.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
References: <cover.1716802450.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=michal.simek@amd.com; h=from:subject:message-id; bh=me8M7LZBeVBv/gUPLGJvK9ZKYsAahfugPJMrVyuBucw=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4OmLElL/399hxpbskeEgeFBnnUOXiKrfwTnRXK+LZ HcpBap0xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgInMnc6woN/xY6vzM6Vfy+4E +QVIZp9wry2vYpgrNDXXJiF2Tnn0kb0xP+eIVM76e7EFAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: de7eba30-5b88-4cb4-dc5e-08dc7e304bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AeJV0oOtyHfr65zOhule1AHYSeZuVANzf9F99dtJIzjknDsSLLZMbN7A70Fr?=
 =?us-ascii?Q?k9knYN1GTXtVFl9FV+3qOg+FEH1Wg8TOrzKMOiJvPwuPwhuUTohe9y/9tMdR?=
 =?us-ascii?Q?qG4/BIvqSQlEHtjbtMeemdvAlqBJx1Vrk6F1HD8ITKEWqLpb/GQMyiGyblag?=
 =?us-ascii?Q?zKtFywA7rVo7FiW87tMamcs93MQNv/pGh0ODbO8ETUB3yaPrnO/rdyl6hm4x?=
 =?us-ascii?Q?Ctw9SjiYGOXcC1I1YdG66faQlKuAExQi+QfYwdFo3L64zStthxwCU7GsfMtE?=
 =?us-ascii?Q?HPW8DJILq0z8V9I1/XcB8RxnvnJxDaHwE1a82WGz0uqf05drvIddGZIg+Foh?=
 =?us-ascii?Q?n4onM0BNtxrqiLdDWzwT3SC8PJOgdOePkZC3sVycVlzC9QHTiVjzDoUmxhzI?=
 =?us-ascii?Q?jvwijzK3nVYqCvHVZ3xlWj1eKmTLweEP8D04XBJuwFqqfaPYHQBFn/Qtwc1x?=
 =?us-ascii?Q?GUWIkQSky9u9qMuiQhp5dcTSrqlW6SGhcSHO7fiyWLGtWaEQyyOBD4tSDJ4F?=
 =?us-ascii?Q?TP4BaovtbvBEWc61g8QPBZB/k+M4nnHQVnecKktS41lMpB/RTbvPjiW2Nc8A?=
 =?us-ascii?Q?4p6UHvV0a43fYrovrDqbfNdyYL7kLJ1Bs4c1aAi7BFY8YztVQrCuFtYaeZgP?=
 =?us-ascii?Q?6PKXnWxjbQgWYE2dP4BBm2gEA+lAEqIIOfpa76XIBUld/aQb3xp3ukpPMAI2?=
 =?us-ascii?Q?9il8OQUnT7SEx5H6NvM0kWSAuQdHcrpnkZ5KbNqgAX0MVfsx6TxdncumbcNY?=
 =?us-ascii?Q?vv4ubxIipbKpvLcrv2GcGVpOBDeAEDSRcJHPS9SNbJkaPeJtdiUPwrdgQG19?=
 =?us-ascii?Q?fMockCaHMjo55Hl2EpPBoUjBQFpJWfVvofUm1TDu2RYN+/gRZUqhr3MVCMIw?=
 =?us-ascii?Q?+d1jGQCKDBANoYBjvNTmQbERzL0Of2SYbTsZLrkb6LX+tAyGBh82hkLbgjOY?=
 =?us-ascii?Q?oCXj4ifCgt9CCplbPbIkKs2FlkyrdGFv8o+9ocbw6Dy4KUfMVXFxaeqfHp9m?=
 =?us-ascii?Q?tK5t4dyVcoTWfeZCWka5W1fNojXlpAkZJhqFCQON/Oe8iqwdSMTno3n9eu2V?=
 =?us-ascii?Q?mwND+MXBkWCxtJN0TTG0QU5BQuLL4RmzG2dDzhiN+KfNOhvChuV1c09fOB5+?=
 =?us-ascii?Q?KJ+wV6HzwpposaezjoGp3GmDfIODOxXmtuJNwN8BywLD8YeDozO8Ys0NDHD5?=
 =?us-ascii?Q?ufM2o+O5NydU2mwBvZwYkLDBbJ57YZ68V3Iz3laRjxqLhIqfA0M+aQsxrqfw?=
 =?us-ascii?Q?QzcHFDwP2AaCEwu5fW+7jN007y6MWbzrunDTNAEiIaBJ7EmG22V2TELt9slp?=
 =?us-ascii?Q?63KDPi3SbC+p10xTds8Ox6y/olWTlHIRE2AxluGfvlfUDvUEx9dqwQCgeu8P?=
 =?us-ascii?Q?XUbI9zM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:35:07.5307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de7eba30-5b88-4cb4-dc5e-08dc7e304bda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830

From: Vishal Sagar <vishal.sagar@amd.com>

Add a device tree node to describe the DisplayPort connector, and
connect it to the DPSUB output.

The patch was tested on kv260-revB/rev2.

Signed-off-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index 3ada04781950..a74d0ac7e07a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -63,6 +63,18 @@ si5332_5: si5332-5 { /* u17 */
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
 	};
+
+	dpcon {
+		compatible = "dp-connector";
+		label = "P11";
+		type = "full-size";
+
+		port {
+			dpcon_in: endpoint {
+				remote-endpoint = <&dpsub_dp_out>;
+			};
+		};
+	};
 };
 
 &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
@@ -97,6 +109,14 @@ &zynqmp_dpsub {
 	phy-names = "dp-phy0", "dp-phy1";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
+
+	ports {
+		port@5 {
+			dpsub_dp_out: endpoint {
+				remote-endpoint = <&dpcon_in>;
+			};
+		};
+	};
 };
 
 &zynqmp_dpdma {
-- 
2.40.1


