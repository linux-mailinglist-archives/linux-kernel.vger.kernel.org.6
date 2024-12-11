Return-Path: <linux-kernel+bounces-441293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713BB9ECC65
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87416163C14
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32223694C;
	Wed, 11 Dec 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uV2CY1df"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB211233688;
	Wed, 11 Dec 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920963; cv=fail; b=Mzyl2U56930OMIVNDX8o8L0k5RsJR9m6u4aoePhaQAp8e+IhG83cwTBw6nuJkR0ZWl5peBiT43K9QqDcK2UO3pfFM49vK0brznK5ZCkqoKf8E/tYxKG0K1RMOvuZTQ/h3T5kS1IbVxZYpyZuJciQaXIGi83OEzKf64auq3v5+5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920963; c=relaxed/simple;
	bh=P8dOCnwxyAdDekTcVCIYi2kq6wFUKjaNQ/Y+6I+dxLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkUTaEHwTtKeJx1nXYQAeCW/IYTppHTifR3F119RZz3m8u8EQ2u+S9ppnzNccNR237EKHQ/z4H37nCwuvJ71rCNkJOpzP4EpYxkjEx5t5BMmnADR5KrJm39Flk8xAiqXokiD6Km2gcaQgIoxkrSh8IOidm/aWGtYW32TbB60t1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uV2CY1df; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sl7YZXCK0nx7Hho5wfPTtXaT1PC/qzdxl62HOqckyO9DtnTJDCD2rgVEChmuDJLmbFOo4uLo4okRTgel5445lDxXDxIAJ8bsqZLUBfrf7HvYhNMYo+xzvLi4RvAvNewwSARvZrqiQwF+2AUeM889OoowAVDjZJuBIDo4LDicrOlBHyGhp7xpkMD1vEFG2X3ZRW/xseVtjmqTvIFLWSSOujPu1sOh6NEwNyLluq6tIguqowclfrCLJzy4TxuFHA+119MHeUtnUzvPnyZBis9JqXEsurM9KGS87CI+Sn7u6AtDqRA7mhynq+0RyJoqygOM25TrcMp2WIzwl/iKkfvcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0eGlusPZwUYlUVPnZGo0MqCxZ9XjiR4Us6+ra3ROos=;
 b=QrTwu0yr99fZG04SMQc7vryaL/YfZE/fTOWHhh+zOMozXMCJDjNz9wc5eRwrVWMUd7obvXLkYVoi52B7zs6BavCAGjAi+dEUTdeiB2Nqbnh0IrGmXMOC7/f5qff/+30+ZPHGF1vqO8vHvFdp8G8HVhvbASfKk+Yk5a5lUAFCjA571/Iw8OIZ66cJElMpKnzLsQKgAnRvLnoBtyGidX4HjmwYhdmxruykx+TOtXO2jUuXTTE32n0y8tA+oW4lJgld5r9fxxZ22brz0bZnlHL+zF0cdMY5nFSlDyPQZv545yNJminVt/VjvRvC2Z0oMv4nsxkOC+GtDrCXX6YpN/koDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0eGlusPZwUYlUVPnZGo0MqCxZ9XjiR4Us6+ra3ROos=;
 b=uV2CY1dfoT3hBzFbX3dDfQuFzDR+zj01vHHCYgM9SAyITNw6Zsu+7sEGV8i3dtd+NZsjupreEOvm/+5/eNr2BQ08vxylvFIhraHJLU/3OrCWuHkiVyoENNiX/jWbGX8xWjmxgNANTFPSYyQFbUItsJmaCmdmuCDEQ86EFlMtX5Y=
Received: from BL1PR13CA0408.namprd13.prod.outlook.com (2603:10b6:208:2c2::23)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Wed, 11 Dec
 2024 12:42:36 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::ee) by BL1PR13CA0408.outlook.office365.com
 (2603:10b6:208:2c2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 12:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:42:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:42:34 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 15/15] ARM: zynq: Remove ethernet0 alias from Microzed
Date: Wed, 11 Dec 2024 13:41:34 +0100
Message-ID: <f4189063a8923ad380675f8e426e739ee3110baa.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=702; i=michal.simek@amd.com; h=from:subject:message-id; bh=P8dOCnwxyAdDekTcVCIYi2kq6wFUKjaNQ/Y+6I+dxLI=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjvq+1wUtUeYaU6bPVl6e6Kj6+NfbVRMj2t7Ku4cls 2eGTvHqiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABMR6GFY0FrBejL79Nsf6a89 tZnLX7YVKcS6MMwPZtjNvr7gBKNJ/WKrNBc2lwWHOB4AAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: c595fc3e-c141-4dfc-7498-08dd19e14aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QxHe7DwCp9hADvIRIcmD+Rll8oTX+0UEQAX/n1wNbPSGlqSkNRYKH0yYRqiR?=
 =?us-ascii?Q?B/92i574WyQXynxhqEqv7dGTStPnZIBTGbyzDIyK1xT8gd3V4qc9kNUX88+t?=
 =?us-ascii?Q?EIj0S6rgokKoCiJYDnE8v5OGhqNmctjN0ovEq6ntflQ/LcIrf+VE/lgNI69N?=
 =?us-ascii?Q?JrCu+Edvd50c8dFsaFcQQz9Y/ESfzcxQ8+VNG2A98/nWb2FKsQJY6E0D6K9i?=
 =?us-ascii?Q?ubJ7/YRKl6UHtTI0FqBBx4N7+/dEXU3kc/Xh0+SExMsdwdpJSMXLWPa65jkn?=
 =?us-ascii?Q?VtHm1mbbTj5OYrDDK5pmpfnkOfti3Hyo2amPAIkGMHHxAqTvHNTf/EDR+mp4?=
 =?us-ascii?Q?lJ7TsS8tiEX9qEtZqS47p3ifm+rf7QbHm28Fft/s6EAcnyVvqeBd3mRpgm9c?=
 =?us-ascii?Q?+QT6bTYQVvhNGPYfPm/9vjGIocIACZlS4UGjqLZH2hc0A4kf5ATu+8uG4gQJ?=
 =?us-ascii?Q?bNKq0eIULJ+E0bVg4c2wAOJtEkoQzwPRDYzseuriOcfLlcKyVLDRz0a8EaQE?=
 =?us-ascii?Q?UqYGTrW6IIXC9y9aaw10DY/XMeXcp0FfgGOT5lJD5w553nCfNpFyUISJE8EH?=
 =?us-ascii?Q?HkP0oU9cr6+IWj0R8j/NfXQLSU0tHOJNVSZRwQt37UzaFz4TtCxSwSNxUMpN?=
 =?us-ascii?Q?M8JewBcZTjeylxdnaWgZzxBNafn/F9bLG12FIp4pqYSKu3WqjN2em8aE61q4?=
 =?us-ascii?Q?NSH8aglImm3JO2ogJFf27u14KAOFbebT/5wplIHPhaXKcKLp9U1Eyg4w4UJO?=
 =?us-ascii?Q?XSJzp38bT4tt0ZPkPldCaDbDq5B3Fl1dDv5V54acKaqkdM+nhJZNcdGt/3f0?=
 =?us-ascii?Q?V5akjMV9iYqTov7ImLv1XhpUL2ZCMQ7YbEom/LmDlbmJ8c2GULi30KM0gTyq?=
 =?us-ascii?Q?mlyndZMe7lSHGwFOGHsZ82QIH1L009g40DAYZXJ+IMN7q5dimq5U5mrOLYtH?=
 =?us-ascii?Q?+VvCbdYBJkBME/xqUrpkVpBoLLA8xXN+hKJ5IBsSCVrJQNfFkIiyDPKOE5h7?=
 =?us-ascii?Q?rbM7gXs2ewLEN+/wpS4K1cRBNQ7WYd89/+P4VYEbe0m9+kZqjGPPcwF7yujO?=
 =?us-ascii?Q?vQjkJSpCcSbsiOtjq243N19arZQeLAHPmRQGVwp/ZkFXPam2G3Ck+9FYFHNw?=
 =?us-ascii?Q?i1g8UecyuLDvm3tiGutcfcsSfWIStw2nnL9Uk9syZ4it2MYBavIUOpOFWNnP?=
 =?us-ascii?Q?oU/hJUYGoWAU5An4sO7LvcAVszmE8GD+RJqKWgVzdkJSic1dYMnP0g++ruG+?=
 =?us-ascii?Q?bHrTbPBCGxxpSwcOvDgXieusK9bhVYHtPPe5LVk8TY4RWLXOnGSMlp+0xcG5?=
 =?us-ascii?Q?yu16H4VSbOYhwJ7jr/2w8toLJZ+Jnp9M54g3ikAwpWn/OrSLcRJyLCZr0q/q?=
 =?us-ascii?Q?/dVbP90Dgh96RuCckJ4vwB5bBmXnperG0GgLWO276YwWTBUjlBAUsO49j649?=
 =?us-ascii?Q?ttdzVruRqRzOpAjzHMzj5llye22/IPwp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:42:36.6062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c595fc3e-c141-4dfc-7498-08dd19e14aa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347

Ethernet is not using alias for ID assignment that's why alias is not
needed and can be removed.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-microzed.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/xilinx/zynq-microzed.dts b/arch/arm/boot/dts/xilinx/zynq-microzed.dts
index 20c04862679d..68b867e8369e 100644
--- a/arch/arm/boot/dts/xilinx/zynq-microzed.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-microzed.dts
@@ -11,7 +11,6 @@ / {
 	compatible = "avnet,zynq-microzed", "xlnx,zynq-microzed", "xlnx,zynq-7000";
 
 	aliases {
-		ethernet0 = &gem0;
 		serial0 = &uart1;
 		spi0 = &qspi;
 		mmc0 = &sdhci0;
-- 
2.43.0


