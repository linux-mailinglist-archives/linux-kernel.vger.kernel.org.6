Return-Path: <linux-kernel+bounces-277309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F28949F20
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80671F25D0B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CB019414A;
	Wed,  7 Aug 2024 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="upik0xPL"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891118FDAC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008310; cv=fail; b=sZuoU9+QhEblD6YHRYW8CS9UPXCiCrdq6Mgh2BsLxchrmo9hxN7F8gOX1fBG636x7quBnQSFE2KfbllADhATDYxToQHBuwV7geJx17Mg5ZafZzsSPu1BqmCSGatYNmHheNaYg+mfmgKG5e0L0duDYlHlGCa/fqjR/1e8kAArqWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008310; c=relaxed/simple;
	bh=o7IfMcHLhIBKk6yt7RsPSN5/9I40fJLffuWoT53LUXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbefIMwVU3FHUBZAiNzXn3gkFnUcZddmXqC4k70Y3KVn22AKAuV3iS8OJDjH3hKvd1zjO1xNZ9WA8hzpQOjHMdycPnmCu/XHII/Dh1lpK52z/kk3jYeyawgkew5AAz6i4IqICef5+Kir4PW851BKXDlwzd2dcMlP3WcSROBWSH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=upik0xPL; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpCV2N1x8IfqTraw4Hxl2UC1D794oIu4NhQL5ub0Xs9irwxkulwZ4rwfG5C+3vT6RELgqzwMrj8Ga+dHOfEWxdXaCcuyTNT93ZFnCeAYtKWZqnAEGjL2tWPLpKg6dUpaPjxnFJ+Bge4mRSh+leN2CXvMNAttV5ok0mhEF6tVjvpbt/zKTcwFDnpglEJJ1IsUETKiABxgv2dOQAbGzzeVMWn67N9v4nNnby8uKky80CppW1aUgJKvo9JkGkke0jjOKm5z0OZ3ANsNFMJb6xrn1ZL5CxBuP8/bZRrekPFHNhXfH5j26WSNgata8shkZbmExBLQvxYEKol6KPXx9w4wog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvYxAvxFXIStAteZomxCVLODlOkJ1e9CpRP/0jDLKd4=;
 b=GzAT67I2ZlguhPKtvQwWWQN/SDa/TZ1PRlLor53Gua/pvoa2YEHHtYQXM7nQtaNIeE6IE42SqraF1abn8vH3MQmMz+6v/HzPPScebDnOTblCrYFVaiOvP2a1FBFUpXbReDax3UO7vgNfknD++WWAEy918WKA3+QaozYFsq3oa36FYznSyGR8ZExZ6dE5gHQnGnEw7hrAGDitLFtm4VA4XWjJrdRlVAoxS+1eQu52iR54OZgCGpg9kCIAPD0ZkJI8TE8geTvsfL5UWV2HxvY+JS0TAy/fTjckqPSIpnhkOT9POAPIynggGsmSCrgioRKPeteo72fz4cuyVwf3S6ENCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvYxAvxFXIStAteZomxCVLODlOkJ1e9CpRP/0jDLKd4=;
 b=upik0xPLhpLuHUjw7F1GbjR2DK9Yjhr34qsM27HQcA+qSbHAW729hJFOyWXT/Ltvv6j5xZrYF0DYrkkYpGbpnzxC9zajowbTxzo3D/4U/p64Klc8Ox/rJqbLaR9vGusLqZu/z3Jma5yg8cCu9WfdsxcYZZqS6ie1nckz3vzsJNg=
Received: from SA0PR12CA0012.namprd12.prod.outlook.com (2603:10b6:806:6f::17)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 05:25:05 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::ed) by SA0PR12CA0012.outlook.office365.com
 (2603:10b6:806:6f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Wed, 7 Aug 2024 05:24:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 05:24:58 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 00:24:56 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH RESEND v3 2/6] i3c: mipi-i3c-hci: Read HC_CONTROL_PIO_MODE only after i3c hci v1.1
Date: Wed, 7 Aug 2024 10:53:55 +0530
Message-ID: <20240807052359.290046-3-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e7432a-6a89-4f6e-b7b9-08dcb6a147b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?94NA6XreUeamFpdO9ZU9KFDmbsYgNqYJITF53gZAApnhVGqWzopv9PQTSV3o?=
 =?us-ascii?Q?ANLoRNZ/18eCPDTErKBSZ1jk9VjBuPFZ7UJbhb6s3x8CCr3ywrRZh1So0Is7?=
 =?us-ascii?Q?Zk6LynLztH6gnMV89jo9guhe4mjKP3Y1PZuN782rhccj1YC8WFsYOMHyqvV6?=
 =?us-ascii?Q?IOgxoddYSI7FRbs3bF6zvYjonBX1lAOfFDjpINMxNyUOaR2dExUB/HZv7Em5?=
 =?us-ascii?Q?OfOSdL5BJ/VgEyvZN7mRwKt2Q6kyImiVsJpcZUQM2lQrjBYOlaJKhQ3xgT1n?=
 =?us-ascii?Q?qM708Ks7Ah9WzQtFYn8gnqVr0MtEPPFL+QHxmB5ktO8MAiDZVzq5ptCGuo4x?=
 =?us-ascii?Q?WK6xDos1XDA4McuyrV0ghZNbEFLdiLtUhbyzpENiXp+4AjpVWfvMwCSMLFkV?=
 =?us-ascii?Q?aDHraD8LZJgoJtdF6/mhvy3lwZ8vEpIBpaJtJe1LQWoAVAXycY2TjGz/P8tI?=
 =?us-ascii?Q?IPAYwm5sZRzvXpzlxSm463cXFFRgDorlXijN+1DlzxzmAyImTtN3gRMtE7zv?=
 =?us-ascii?Q?jGp/Wctl50i3u0pjk2AUbjnCXE7xiMT0f63V2QVQjWjArgijGsaSv8krMxPQ?=
 =?us-ascii?Q?evmxgEvZwPscyiqu8UFfbD4agI8G4eCQWRaPjqNHzrV8r+QdUsPJkSvvUN2x?=
 =?us-ascii?Q?J8KWKBWLECgog14/Vljm/vtJWiyZ9eEFh810UqAurDwjz87ppyG8QCyZLjI1?=
 =?us-ascii?Q?HHbMcDMIDBjDyKvdy/UQ31CwdW2YtGguOhHWhieewtmV2VHkHW+kVxM9sbQW?=
 =?us-ascii?Q?B5FboydIvLUUFZfZyCUGwIf5Kv1FEbLZzZWkXzj+IBApFToppIncgbjMt1Af?=
 =?us-ascii?Q?X2StTB+YUya1Rc7rd/LpTEUw7P/So1IJtFVnKXGatf8k7SKimA31gvfG8PsT?=
 =?us-ascii?Q?3FJ+3Bac4GxmFYg/BjDeknkqACLbVwL/MuQIBLYfJjqFArTjJ6QPBGOvAaCK?=
 =?us-ascii?Q?5MqxOvrrka/o7t5vjWSQXUfEOUDZN2N6OInnFwspnItsZbxoinc5FnVxQ0V+?=
 =?us-ascii?Q?arNJWorYZcIgi6jxg+TmL5W2Jb1K/OjnRZ+78aFUTrItEL2yK01Hv7EggykZ?=
 =?us-ascii?Q?G4E0yIB5sCkjdPU9mWuntgKwDUBxsGJri8Jyx7P0tsRDZrfWwHODocNNnUqg?=
 =?us-ascii?Q?yu4c1BVUmx5Cq4miuqjJjzZO+PLCvpF2ChxpRm5IiEnQnE3dpkFUbUm4JNLp?=
 =?us-ascii?Q?xVAowZMKwaeS9SFsp4inEFnINa3OoazIVKvjcpDmb2RuPqO59t6+G62wDu1J?=
 =?us-ascii?Q?+9QPmWoaY9NLoV0m1mcgwdY68w7P56Q6Ezs6S0qRnpaxQuGvZfgxN/gur8GB?=
 =?us-ascii?Q?E121TnwBjUFStTQ5YCFMV/w6sufQlOMaARg1GPvCn3Q7oSQsWiWbX9lglY+5?=
 =?us-ascii?Q?Yku3w2WUnHAJkYtwGhFXK6yQTf7t+w448mOEMoWGcabYXa3u2hMVi5D8P3z1?=
 =?us-ascii?Q?hK9VVkonx7YfMb7O+sacJdzoJu7L8tFP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 05:24:58.7911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e7432a-6a89-4f6e-b7b9-08dcb6a147b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897

The HC_CONTROL_PIO_MODE bit was introduced in the HC_CONTROL register
starting from version 1.1. Therefore, checking the HC_CONTROL_PIO_MODE bit
on hardware that adheres to older specification revisions (i.e., versions
earlier than 1.1) is incorrect. To address this, add an additional check
to read the HCI version before attempting to read the HC_CONTROL_PIO_MODE
status.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 24dd4603d6c6..a16da70bdfe1 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -33,6 +33,7 @@
 #define reg_clear(r, v)		reg_write(r, reg_read(r) & ~(v))
 
 #define HCI_VERSION			0x00	/* HCI Version (in BCD) */
+#define HCI_VERSION_V1			0x100   /* MIPI HCI Version number V1.0 */
 
 #define HC_CONTROL			0x04
 #define HC_CONTROL_BUS_ENABLE		BIT(31)
@@ -756,7 +757,7 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	/* Try activating DMA operations first */
 	if (hci->RHS_regs) {
 		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
-		if (reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE) {
+		if (regval > HCI_VERSION_V1 && !(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
 			dev_err(&hci->master.dev, "PIO mode is stuck\n");
 			ret = -EIO;
 		} else {
@@ -768,7 +769,7 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	/* If no DMA, try PIO */
 	if (!hci->io && hci->PIO_regs) {
 		reg_set(HC_CONTROL, HC_CONTROL_PIO_MODE);
-		if (!(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
+		if (regval > HCI_VERSION_V1 && !(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
 			dev_err(&hci->master.dev, "DMA mode is stuck\n");
 			ret = -EIO;
 		} else {
-- 
2.25.1


