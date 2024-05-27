Return-Path: <linux-kernel+bounces-190337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A58CFD09
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45ED1F24502
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFC213B585;
	Mon, 27 May 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F3vhzyur"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7713AD3E;
	Mon, 27 May 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802478; cv=fail; b=jm3FpJCfmzg1bQXmi861PbJqm07jA69pdtlsR/x7UlHg9MjUiFbyPU4TTS8bPNSk6NjeBUuL2OcLEi2WCK4WZq468g/a4sI89dqkNuY6sxQlPEWPzmjSmh1K0l+q2zM1JqOS1HdX8BZHngJPvzvkKRqg5iX+d7/LkICiVUx6VXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802478; c=relaxed/simple;
	bh=G9cVPPtw7uh7S84Irr+E8cffuLF1teSHUoX72CJVq/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjyaOdUD5PpMKmjLXU2VeWw0nhJUbeGpLaMzIQBhhAzpuKXQf/fiTH9MGVgFd2c1Wxn5Irpq5Odmfzbm3W9VIZWb26GvmOXZekSM7M1VeRahWd7jY0eRphODBRZGP+PuP7PfYsDiUFG0S8N6QPk4eRUa74vq/smNGdhxOuZgQxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F3vhzyur; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwbiKLg5wacE5/05oagm6Jj3PlI4LkD+3WawtGtd+Dg+xWEFdvGosCHjaQjPpLhIg+PD/cQ8li3T5KKFG/IO06g+X+EzqXYS2gD7JcH0iDthIeHrPN+txYwpRCGJkARxK96TzeraKXxUK9xIGg4dDJxcwKxOoPbV/cc1v5pXJJ7WR2WnG1yTCpLkqyentLzHWAm1TiN2vRhacZvOJMrEOyV7CCWM6v/oIuzQq9/zGrJeeLcF3dPA95J6AC5bshbJyRuxqqZQy9F6xdoJhfJd0D1ePgxs/jetEYgXwRxcpH6QOF/r2q/VJ8GEhnHLy80r8/HwBSLelObH9QmDngIB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mczkoBhsQn3O/1HRJZmD028A9vVUMJsOuMcdvzpwFOM=;
 b=RNljaeid1zQAMZB9DpdP8Uwgz7SjX6K2S5iqyhgIZbX6JKULTWUfpEL4SQt+aN5u8e/XPmmzHNCgGWGZEsnUyGv2puchvVtE+HIP23ftny2RiDkWXj7o6/pmHJ7TOsIM4UxeOYZv3Sjh7TTPIGYHtBlNneuq+X2FPYPlHChcRbyP9Q6IdCykt+UrWB0dUC7SV/m99wGtaU5MOfyqs19P/F+vQGLomsKaKRK1ttJBxZDDTN59DTr/mBfEPOSPqmNqsUAJfduwj5bO1m/Md4OsOL+5YnrPPSXG8WYNvd1OL9J+jsxrQI7W+LWW4CVivZY/Yh9CM56OsH7vV3Y/wQ0gug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mczkoBhsQn3O/1HRJZmD028A9vVUMJsOuMcdvzpwFOM=;
 b=F3vhzyurYEHiFcuIJm36PQT0o7AigwVv1nMcQIsLjUZqYpshv6UaLm60c508w0N3qahcLqJcMmk2Jc/G6qumrgRP0rxEjQvJ15y1ryO6lbhtO3bfwN0cKveuli/I7i3lLl1kVsDKiT7h4PJlc/8MFccY3PuOxX4ULfx/Jlts24w=
Received: from SA1P222CA0039.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::12)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:34:34 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::e) by SA1P222CA0039.outlook.office365.com
 (2603:10b6:806:2d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Mon, 27 May 2024 09:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:34:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:34:33 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 03/12] arm64: zynqmp: Add missing description for efuses
Date: Mon, 27 May 2024 11:34:09 +0200
Message-ID: <beb8002f8dae47ce6f38f7f961d024e65372b654.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
References: <cover.1716802450.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=michal.simek@amd.com; h=from:subject:message-id; bh=G9cVPPtw7uh7S84Irr+E8cffuLF1teSHUoX72CJVq/Q=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4ClFwp4mXk/vH+XceOOj09yE0/VeRQwnFvJHbj99+ eytHu5fHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAixwIZFsz5+/CxTUeQ45oT bxL7O6ZM1uvbZ8Mwv84oKOOTki7T+sc3A5uuxEokqx9LBQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a5eef9-e098-4e9c-d704-08dc7e303833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V4Rf9mQdmQsB8v5pHNqVrcLTXYYNGbQi7uLGmZXtJDldPKv2Dlw675jjqyIj?=
 =?us-ascii?Q?8n1/c63BYq7mouhQHH+hyoOEKuzQXz1tHpfU5HPWY5Tf+bfSQCJ96khuCpkM?=
 =?us-ascii?Q?+wcBwioT+0ZZlmvdSe9efO5BlwvW2uTOkWJvn01HoScRo+s4h2ymf9E9LBK3?=
 =?us-ascii?Q?aSeiYAg+u3aK/Lfq9gxSCLHVrc/XLzePqDbCvJOHeGuODdeRV3SudhvCOXMD?=
 =?us-ascii?Q?gRe9z8hHxxcoT4Qd2HSq15PNC1Ff02QxLuNJiWBe8cm+xWQ2KFUCG/yeuRBS?=
 =?us-ascii?Q?BpFYR6IOU9gHlEVGNOuzX1dTftHvp7wP/uih6GbxEMt8/89vvuk2XeIQzVw5?=
 =?us-ascii?Q?U3b0dsmduGcji7w+ck8HwSQ7+VQ0QV4PQ2wa8Si3xFKXN9A9yOVVeKX5f78a?=
 =?us-ascii?Q?4gC8c9xhwrVSX3u8ZbclpRpYDJn1T2RODGYW3JgrrXIIkoZvXUR1JqNEPX0E?=
 =?us-ascii?Q?15ZtVU8CXbwDoC0F5xKvVhWBcg9GXLWWuz69f4SlfxFp1Hy02zGDdekp485/?=
 =?us-ascii?Q?uIAOsoAMFPHHWBBq3XIshVGubn6VXoluBnMM8B8CSKQa5JAvEtX0K8sANNn2?=
 =?us-ascii?Q?+O5+FymI3h5KLAZj+kVGxBJweTPWrq6BRjwHmWe9TX1lHZuKi9a6CdwuOthy?=
 =?us-ascii?Q?2/Fe5iQ041JLst004Oow9BhRdUlcCXCrY2ms21c95uJ23bD4eOW5RGB2brzw?=
 =?us-ascii?Q?ypn5WocCLzifELWqNta19rJjNmKlgbmdsEeUbbnAO5EG4+3JMljqxUIi6LWr?=
 =?us-ascii?Q?928aveeTTgx1vA0q5DUsw4+iK4ckZ+Oxig8iKvzwo7mM2roEOOjQQeeaC740?=
 =?us-ascii?Q?VjRuk4kNXv28NTBchCNmAIHgYEUyeu53rOsHWeChZ4oUmTNgNdPfY799jZPc?=
 =?us-ascii?Q?wpCpIyseoGnpFYmCUyO2SttiqIhXzq9Qn968P9HQy7pcn8mfsjjqn11d/gvr?=
 =?us-ascii?Q?g3UpCNSI2nUecw2s+i9U66SO9IfJVtBAorPb/8BcnShGYeErqXwStnUdpQmL?=
 =?us-ascii?Q?AFgI6oTitfV2FLD4Rj9BNXWfwj5DQy+hnaRn0IwomV+Bu4XPgD5AaTaqCeX2?=
 =?us-ascii?Q?4UcdeOTmjGsHWIn3mV63Ocf4NiOUPGNPxfis0APJM2/X5X+VEaI6Gypm05g3?=
 =?us-ascii?Q?1smlRSg8GMF/SIyGyRua5oXyTQDUr0PpB9eQmHjVQSUaYdAzb3M8OmBmXMGm?=
 =?us-ascii?Q?nv+jpnSyBn9VpnNxolIWXdU96RJ3FpJWgjNJZ7rUt9Gzl8ggAW3lUgm0FF/U?=
 =?us-ascii?Q?1dsh5n95wOoTV9sRezuUJt6I48aGbeeSJguG5IybIltLc4F0ftGurxtGf4ID?=
 =?us-ascii?Q?qdtuUxTx0G9mC4E6fiY/4WMPLXdN6fx12J9wDR+TV3oba2Q2Ky3b/y87dB8O?=
 =?us-ascii?Q?2qP93FMY/P+5DGxrOD5ImQyPqLfY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:34:34.5594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a5eef9-e098-4e9c-d704-08dc7e303833
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811

The commit 737c0c8d07b5 ("nvmem: zynqmp_nvmem: Add support to access
efuse") added support for efuses that's why also describe them in DT.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 55 ++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 9e9a76fca098..c82275f1e79c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -217,6 +217,61 @@ nvmem-layout {
 					soc_revision: soc-revision@0 {
 						reg = <0x0 0x4>;
 					};
+					/* efuse access */
+					efuse_dna: efuse-dna@c {
+						reg = <0xc 0xc>;
+					};
+					efuse_usr0: efuse-usr0@20 {
+						reg = <0x20 0x4>;
+					};
+					efuse_usr1: efuse-usr1@24 {
+						reg = <0x24 0x4>;
+					};
+					efuse_usr2: efuse-usr2@28 {
+						reg = <0x28 0x4>;
+					};
+					efuse_usr3: efuse-usr3@2c {
+						reg = <0x2c 0x4>;
+					};
+					efuse_usr4: efuse-usr4@30 {
+						reg = <0x30 0x4>;
+					};
+					efuse_usr5: efuse-usr5@34 {
+						reg = <0x34 0x4>;
+					};
+					efuse_usr6: efuse-usr6@38 {
+						reg = <0x38 0x4>;
+					};
+					efuse_usr7: efuse-usr7@3c {
+						reg = <0x3c 0x4>;
+					};
+					efuse_miscusr: efuse-miscusr@40 {
+						reg = <0x40 0x4>;
+					};
+					efuse_chash: efuse-chash@50 {
+						reg = <0x50 0x4>;
+					};
+					efuse_pufmisc: efuse-pufmisc@54 {
+						reg = <0x54 0x4>;
+					};
+					efuse_sec: efuse-sec@58 {
+						reg = <0x58 0x4>;
+					};
+					efuse_spkid: efuse-spkid@5c {
+						reg = <0x5c 0x4>;
+					};
+					efuse_aeskey: efuse-aeskey@60 {
+						reg = <0x60 0x20>;
+					};
+					efuse_ppk0hash: efuse-ppk0hash@a0 {
+						reg = <0xa0 0x30>;
+					};
+					efuse_ppk1hash: efuse-ppk1hash@d0 {
+						reg = <0xd0 0x30>;
+					};
+					efuse_pufuser: efuse-pufuser@100 {
+						reg = <0x100 0x7F>;
+					};
 				};
 			};
 
-- 
2.40.1


