Return-Path: <linux-kernel+bounces-190342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4862D8CFD14
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32B4B22907
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3782313C81E;
	Mon, 27 May 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P935ce7O"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B013C67A;
	Mon, 27 May 2024 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802498; cv=fail; b=rxRA75kdXFVSb39Zn12E7/2NaCnJDIWGYfcdo9Zugs2vq6X6BGQtBZdixvGokoeSUK7w3et1RWcHwQcVihihfWN5pBHtqJz4oaOPaBKnXk6NDwHEN1bXQkey7GHmaup2ZOe0MwsUzIruK9rzyQduBpsYjayjfnyeGf0LzlG+UTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802498; c=relaxed/simple;
	bh=yUtPE7T4bNrFlp7BmXdzODPXc7OV7moL2l1dxU2skhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2wo5owZdEk0tQt5h0kjhRMjjms1hZq7k0raX1pL2m/im9C/fTrvFABmFQ5/Bl64IdEeS+FXPTm40Dc8Onez8K/A0y6ktQnX3IppKU269RGmj80F24aPNIYt5xX9h2qWV+Uiqy76IiC6pwAIBfepbxbgkMyrfo5mSunIiCrEKmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P935ce7O; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc1k6+7aQBF7nZFwSHYfRCn92VgrjsbdXfAGRdLNmU34uCn9yLZ5YnXUzUFNC4cvGW8+Vi2MPGcomLwDQg5bec601DgPyOgYVxmOabeXbFbC1hin3FIXdpy15gUOflgzsuHojTwTsrWaykzlxtOAeJrd23O52+242mt/mZBlBxno/Akl0lY+/JOeEyOtfs2YeicuaalOiTDHLx7tgbgCgj1Xd4pVIVn7iTLN2ED0sXZUp5sKpklsQekufrZ8Vjn+rlpbY1w4ToQWA47TliWuPfZo3KCfkvFV/qnlgIPeq13AD1r6AX+jNtM3hp0Z2TorLcGX9dnLEjhLVaEL8ZEnfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSWi3H7nlOWC8iWvnZEpSZImU6FCmh3mXxpavZg+28M=;
 b=dFr+IbTWhBMNz79rtGlKF0Ro3F2N8ScVwDX+PNdOJ5IjVyJX7bSrzLojwseBe3ftXbsV8/O45JdN59So0EaLskDbPaegf1sjk7ZWGgI6pEsc3wtCpr1n9Czuc95GXD2UQFFK08EbDO9QBVXGFjNDRkykMi7H0T8egCEKE4wh93vHVMLN6A/MvvD8o8Ay8IfIeCpeFV4+cbWiOqIswIh5f1sUyP5ccUv9SXlARjLDLgIneUqvfcpnvNK16GPEBGmhQ5/bHua36RpIqOfNw7GFuJMEoIxRDIV2A8aYFSyp7tZY2i94Sznse4HHOOrzLQYy45EItCFxpVutQXH0OQqAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSWi3H7nlOWC8iWvnZEpSZImU6FCmh3mXxpavZg+28M=;
 b=P935ce7O+Kcam10Cimuun7alua3VBx0bUgBhc38eyYD2qbixaVv8GOd0D444Onq/m6OESbMan7d/c+hus7VoZEGacKTieo21IGhfjbtoYpkZHlurL16tRf+UKp1WhJeK69x33hH6aqmUZl2zEp0wEio9sKuDL9wfF3hYwOjOx/0=
Received: from SA9PR13CA0049.namprd13.prod.outlook.com (2603:10b6:806:22::24)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Mon, 27 May 2024 09:34:53 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::29) by SA9PR13CA0049.outlook.office365.com
 (2603:10b6:806:22::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16 via Frontend
 Transport; Mon, 27 May 2024 09:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:34:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:34:51 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 07/12] arm64: zynqmp: Disable Tri-state for SDIO
Date: Mon, 27 May 2024 11:34:13 +0200
Message-ID: <540f83f7d88b80441c9fa3d771dd7b000b0710a4.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
References: <cover.1716802450.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=michal.simek@amd.com; h=from:subject:message-id; bh=NT+i4Ch7Bn6PDGrwBZxZUGprO4cagOSCDsVuA2qPlgw=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4GnZCuu5dSQmlKl6O/55NSF90pYZOWZpd1hztKesC Pup+MugI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzEoJlhwcRrh9SYPDZ1Lw1X eTJzdtvq8EUneRhms29Ztn3Dued7rz5MfTvZ2uXd9AmpZwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dfc782-1545-4931-2b81-08dc7e304335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pa/L8yN6S0vNBc8PQ81SbDkHbZc2GajTw9/JMrs5AZI4yiKL8vCzSPcQDG+t?=
 =?us-ascii?Q?yB7oFW8BsEg2QFcWv/7f1vAgtzPYe0ZAkIUalMkJKrXnJ1nM5VXt/l0iUKMk?=
 =?us-ascii?Q?cCcwgJjGq6LoWikwYd4PYvTChwwE23ebRC0m5cOh3BZ3PwkfALGM4uiLRnfE?=
 =?us-ascii?Q?/fLoRapWn2JbYZUZVgwsOhUkJXbVTi/rEgUE/2ruplldPc3YlJLaxgxrRAf7?=
 =?us-ascii?Q?lhZD5S82ve7IsBmbtCARhcwCmqZTTjNEmTYFbHlcgOd9crhMOAdXZW6Zu/fD?=
 =?us-ascii?Q?suXS1woZXRQuIiC/wXjcRNAuGmnmShjg+X9soTm4gjKwpHlWCr2FjlPdLDaU?=
 =?us-ascii?Q?jTIsX6gl3gT1N8qXvDJmE6e5mB540sK7qJL9mJMSbNtvQEq74abFZvt5UftD?=
 =?us-ascii?Q?b1kKVJfzqZvD2XxGkts44n4jYfG8PWcd6HTwQlFPFRz6jinhgonWGtDt/Ib4?=
 =?us-ascii?Q?dgIC1+SNMdYIklK4y7p9Q7GbgxpTYI7Zj+ykoduGtpZhiFsrPb7PWoNXKM+N?=
 =?us-ascii?Q?hFYFJQxH4M1nPwTF9OMw5jsbll71jsiew+9B0TpGH38doDKag2uspRsKAD1R?=
 =?us-ascii?Q?TiUQ26olswdszskV8ef77TfBNhDIwJlSMK9+IR6fklWqZa7NOVCWepPlWF1T?=
 =?us-ascii?Q?ek2c/9AJuRr7q4WCT0uMeBfXHofmyRC8jB1IIgFP7lQ/qMnWivkXrM1Q4SHM?=
 =?us-ascii?Q?JvTBTbXq4sYiUTMxMuTzYC9iJOgRLpGsLP5RKp1SxVuZOIW6nPF+N9x333cB?=
 =?us-ascii?Q?GnWyRd2wy4fTdEyVMjCYa7fTbiSGlBXN3pf9K46RgLKZbQKXQ2XLYaCrJ0kr?=
 =?us-ascii?Q?eHflbMoe4wa7vobLPfkmJ+pL3yZDNTNWzfgu7E2r0G3vVQ5JzaMEYVxsBV2q?=
 =?us-ascii?Q?1hzUSJnIdbr5pQyAW+Xzb8ZNECOHmbvkUP/5MNYBqxC06rJnhkSD9m3nMD3b?=
 =?us-ascii?Q?xwNuqI3wMz5sXkfiWZwlYJ4CAuNrDipj70erWlhV1Y5mXUj+1Mx0H+kTkH8I?=
 =?us-ascii?Q?qIYP3CF2uD8gyo3wTwYAcRksuuCIOaIH8oALvRuYchaOr93G+AVU49TReR29?=
 =?us-ascii?Q?fPd7F/x5K1zPZhwbkZippKXzjGrf7iOm/gx3LJbvGKKB+BuXj+Pgar/0lXtv?=
 =?us-ascii?Q?Uw03IrhWLIKhce7bySmSgRfz7iRDT6Y6oroMKxCu+SplsPsasgFvsfU00lqE?=
 =?us-ascii?Q?msmF8LdayMerA6DCOEwzOQyVyus45SRC/YZqhSkuF5D0rH3h4mTFVqw2HxKO?=
 =?us-ascii?Q?Vx+oRH5epxdieuinbHRvfJP7frqeDZ6Rl8BtWNBgE0VODWAbye0pIosMPE+8?=
 =?us-ascii?Q?EV3+S9+ZLZTdLwvFmgzgEZEQzGo7ELVvnudTub20oKHBOkY0+RO48oJWyxkd?=
 =?us-ascii?Q?MiGrKgA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:34:53.0230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dfc782-1545-4931-2b81-08dc7e304335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724

From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>

Since the zynqmp pinctrl driver now includes support for the
tri-state registers, ensure that the pins needing output-enable
are correctly configured for SOMs.

Currently, there is an issue with the detection of the MMC for
the SOM kv260, resulting in the following error:
ZynqMP> mmc dev 1
Card did not respond to voltage select! : -110

To address this problem, configure the SDIO pins for output-enable
to enable MMC detection.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index d7535a77b45e..a09909a6f885 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -321,6 +321,7 @@ conf {
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		conf-cd {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index a7b8fffad499..b3b8875f8f7a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -305,6 +305,7 @@ conf {
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		conf-cd {
-- 
2.40.1


