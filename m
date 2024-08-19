Return-Path: <linux-kernel+bounces-292966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21679957723
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4881F21B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FE31D54E0;
	Mon, 19 Aug 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aui03HRM"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC25514D70E;
	Mon, 19 Aug 2024 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724105313; cv=fail; b=XUV2aAJ1LZJkfmCoxgl8fdZ+vhcjdMx99GbYhRl3d6n0mKpevOnJP4Bq/0dnpwx9DPIYJZlyG8LdmdrXUlMcFVQwbXReuihx1fMnwBk9VXqIyPQbZ9/gjvP3kvPFLxlqIL2SOeR7i8yiET2XfDjeq9L8TwujScYBePjLQjV03EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724105313; c=relaxed/simple;
	bh=gjYftU9o7VzKkwq/bgU9ISEWb88xoZwudL0SApkMZXA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mRvw9VXNzUtdKFwZ36iIqV50YadSGOXZdUlGYEfXSTe+b/0ZaoLgNbG61iZYa+qSvb0dP+jARBAT4f2UUKzJ5HhthpQBIEdZUPwL/gby7HJ6mFpbqcG8Lfdrm5WYSTNrKjFEDD9Tnnacy5cAuIqkkyPIOlgkLu/Nr2ju/r1fqWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aui03HRM; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCEcKQaNfzFZMX8dyCzBH6YdoYPbckX3GOp3QMBHMYdorsjeIGFENIHzEsrxUPMc8MCJciDQpdUHntR8d7vvzZfsWUPyGY+JOozWBvCVba20uIsBPO4i7eiH4EBV0H6Wijz75VoYczzsjcCAf+bFCS3s3wLeBHlRPTkfbc9HjYGtE76hwjz0FnP2lJLwjW72aM4gv5FjAcnwyMw/oZfuAUDiPkzBQIABtnIrFUAAoz7A2mEuU38+k1jDgKrg2R3PA8KZQp/9+NtP+tvrToJ3WkxwI7x9wbMmCikv8/UBcIDStJu+tyqQw6jhRJ9pT1gkPR2Jk1Gp24PhEnrZza5Yzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAWPpH98uB1OTCvvhWjODEhWm2A9dY5cc7zY2QcbBew=;
 b=cMw6L/ooSYq4w8lB00YRAN7/xtEjpDGpEZQKCR0IFuwSEerdmtdzAqUuRCaOJ3H1R2K/FKRO/FUEJ2PHuOVF1jn1ICQ8RIDFQz3wAmeJoVSubZEUMjxIbLmlLgKirBv9M7aKJ5bbVeZ+4RdOwHDOQBrqVyGvRWTj9Qt53X5lyRNruBp4Mu1SZQOW84eBfFcNF34EA7MvSBLeTrdgL8hBQ62DLZ+etYMbbpf5r0S7feplJvpzQczqRz01vJ6pJ5OR3uLj1TnA6gqF1LLLY2ek3yJnPrQyogzDpWfymownvWSGnLHF/rMGEfLf8cb0Rr9ZXdQDTH2cQUNZE1Jlz719DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAWPpH98uB1OTCvvhWjODEhWm2A9dY5cc7zY2QcbBew=;
 b=aui03HRMWDpgcQjSkzW01NKZ1H6/NLixB5ob0040Gg+0FDGu1dc9kUkA0EUPLDZOqjSKHuYTb7fYLfsZjhr12mjJg5gjmNqhouVuF56bPdbxgK370HZt3suoHUKzkh3KgpUKAPGEih5q13h3IaxgcLStuHnTc8HWLUNtF8jqM0csT+ZaN1trn9jEzdRG5w6adbKbMmQAkHOZyomY2KeH0+9oopUiuj8vpCSBt4R49JNgzwgI6UrH8bknY+eEUZVDNQS2j7XHG++COwAZ6c0mj+As20yCXZBRPyDMd8gK/+g49frDo1dmU8uMKkVAh76pL8r3wGVQfJdNyLX9z4h46A==
Received: from SJ0PR13CA0222.namprd13.prod.outlook.com (2603:10b6:a03:2c1::17)
 by SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 22:08:26 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::65) by SJ0PR13CA0222.outlook.office365.com
 (2603:10b6:a03:2c1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Mon, 19 Aug 2024 22:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 22:08:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 15:08:07 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 15:08:07 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 Aug 2024 15:08:06 -0700
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: James Morse <james.morse@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Rohit Mathew <rohit.mathew@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: [PATCH] arm_mpam: resctrl: Update only requested configuration
Date: Mon, 19 Aug 2024 17:07:52 -0500
Message-ID: <20240819220752.201815-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|SN7PR12MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: d557f863-a273-4687-4eaf-08dcc09b7325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G8Uk1baU+nkh+UCr9HBGOnviPEutCfBo0VJdbLYW7yQjyrE6akFI/ZSMOKYu?=
 =?us-ascii?Q?971KkJZLL0AHXdzSwtb3Qk9pAMU7d0z9DE22fUqgVEAqUBl4XYQuMKj8k/oh?=
 =?us-ascii?Q?QgOuInjNVlGDhynxn0x+HJ9/lmqcnH+cc35RGlnkgzZvEoUtge0w25aoSU1z?=
 =?us-ascii?Q?8m3WFzqgTT6lhikHaTSyrConrJgmQdUiu+qGkgW8qtSRdcywTCexaBlZTGOI?=
 =?us-ascii?Q?hTfpzAVk5CW6i86QxFW6kj1D4RTGmBLDgttYFT/qhZMS4kptmZYVoUWT6KkN?=
 =?us-ascii?Q?TbgpJ53tC454MA1ZE29fJZeB3PPhg0NWmAJDxa5TZWV1WSZdV7x97f7dQ5LR?=
 =?us-ascii?Q?WSMl7LCI9JpjYxUvKZ1YE83yjAd3jRRbVat/uVKU0D5LHKRlF4zgUoTXNneJ?=
 =?us-ascii?Q?q5JJ2i2QoOkcmsSv1LqYLIgt/UErrjQ17zSbgujWHJnQ86Uat0wABRB8rDaM?=
 =?us-ascii?Q?J6VXz2SgKMUvhMLGbQDPS3/sZiS2Jne2hp5BZhdTs0VAMuB9j79JbzQrf1q7?=
 =?us-ascii?Q?b0jgs9xXKob9qIhQxfGpB/N8TSuvYZI5+ewViQyD4XA/VM9h3cOQN+6sYBGR?=
 =?us-ascii?Q?RNhR5GHjkHfomLXCC8bTUR1iu2HoWdicMXp7/J10G4DCey6gjiVTjCO5EMJV?=
 =?us-ascii?Q?hUth3xG5Mv0acF1NIiOqp7Z5nlAGwQI8BWlgMrQcquHU5TK7mWmiVHi1/FdH?=
 =?us-ascii?Q?ysKzeVPUvLQpiUsv9KnXOYg0aO8N05KmDO6qnqR74jIVESe+Gvuefsnf9+oO?=
 =?us-ascii?Q?qEmdiow+q8nRptwMP/bU86se+TF6ME77242+2EogKUmvDoeQfgJUqmgoicdu?=
 =?us-ascii?Q?5Tyo2aZJ3qyEN18e80KFhU6pZn64wedAFYohAN5m3J4iDxldrnxywhK+7sBu?=
 =?us-ascii?Q?lzSsJEiDQhKuxBykNWKELxe+HolOMyebKJq4l1X01P8xXC1D4aoXJJocV8ij?=
 =?us-ascii?Q?XWS+R5dWsYn0sOEBRX50ELDWymI9+oBF7gcfieXYMZ8yKl4omfKn/DGDx2rM?=
 =?us-ascii?Q?awjvpI9Nbb9fnYW5XUIoFrw1ttO7P5g0xy9f1h15BIz6F3NS+ehYM5qonK4V?=
 =?us-ascii?Q?eX/IDsu3IawDCrDGzBMqRD7jAK2tHPJm1Vgc5BmHJQU9TiBrY1yWk1W2yOrg?=
 =?us-ascii?Q?4z/6kLSHsQCKSF7cUuartsyjg9c7tZ4HjWgbklto6mSUSzL9QR249bfJMgch?=
 =?us-ascii?Q?B84k6Zu6syoE+zHfXHTLYiMd8Z3+dn1yEJTQ2JtOoOp2EtwDWcXbdZeLOxr2?=
 =?us-ascii?Q?Gimh0cOqZ9nNNne/s6jTi1RlJeLukdpoSGAGXZhvvbAe/jNr6ck9u9+HyGgF?=
 =?us-ascii?Q?pnyvCDEmXHq1Bm+F4LT5af4aKtKR/vjfSBQoqrwX+eCYCCvzt9bXqdXSRlSz?=
 =?us-ascii?Q?5LJlnaDN7zcg63jediY++a6Duu4u6BsVKgYUhET3zjDBg7RvNnhxbpvkACLn?=
 =?us-ascii?Q?gCaL1vsgHGapcYvJGVPqjFeswkIdh9Sv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 22:08:26.2806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d557f863-a273-4687-4eaf-08dcc09b7325
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984

The resctrl has helper functions for updating CPOR and MBW configuration
updates. While the existing resctrl_arch_update_one() effectively updates
the specified configuration as intended, it inadvertently overrides other
configurations with default values.

Example bandwdith value is not applied:
 root# cat /sys/fs/resctrl/schemata
 MB:1=100
 L3:1=fff

 root# echo -e "L3:1=fff\nMB:1=50" > /sys/fs/resctrl/schemata
 root# cat /sys/fs/resctrl/schemata
 MB:1=100
 L3:1=fff

Fix the potential loss of accuracy during the conversion of MBW_MAX from
percentage to fixed-point representation, and vice versa. The updated
functions provide fixed-point values that closely align with the values
specified in the MPAM specification, Table 9-3 for Fraction Widths And
Hex Representation.

Before this fix:
 root# echo -e "MB:1=1" > /sys/fs/resctrl/schemata
 root# cat /sys/fs/resctrl/schemata
 MB:1=000
 L3:1=fff

 root# echo -e "MB:1=2" > /sys/fs/resctrl/schemata
 root# cat /sys/fs/resctrl/schemata
 MB:1=001
 L3:1=fff

 root# echo -e "MB:1=3" > /sys/fs/resctrl/schemata
 root@pset# cat /sys/fs/resctrl/schemata
 MB:1=001
 L3:1=fff

With this patch:
 root# echo -e "MB:1=1" > /sys/fs/resctrl/schemata
 root# cat /sys/fs/resctrl/schemata
 MB:1=001
 L3:1=fff

 root# echo -e "MB:1=2" > /sys/fs/resctrl/schemata
 root# cat /sys/fs/resctrl/schemata
 MB:1=002
 L3:1=fff

 root# echo -e "MB:1=3" > /sys/fs/resctrl/schemata
 root@pset# cat /sys/fs/resctrl/schemata
 MB:1=003
 L3:1=fff

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/platform/arm64/mpam/mpam_resctrl.c | 49 ++++------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index 258a39e90f2e..f4da24cad600 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -574,23 +574,7 @@ static u32 mbw_pbm_to_percent(const unsigned long mbw_pbm, struct mpam_props *cp
 
 static u32 mbw_max_to_percent(u16 mbw_max, struct mpam_props *cprops)
 {
-	int bit;
-	u8 num_bits = 0;
-	u32 divisor = 2, value = 0;
-
-	for (bit = 16; bit > (16 - cprops->bwa_wd); bit--) {
-		if (mbw_max & BIT(bit - 1)) {
-			num_bits++;
-			value += MAX_MBA_BW / divisor;
-		}
-		divisor <<= 1;
-	}
-
-	/* Lest user-space get confused... */
-	if (num_bits == cprops->bwa_wd)
-		return 100;
-
-	return value;
+	return DIV_ROUND_CLOSEST((mbw_max + 1) * 100, 65536);
 }
 
 static u32 percent_to_mbw_pbm(u8 pc, struct mpam_props *cprops)
@@ -605,31 +589,7 @@ static u32 percent_to_mbw_pbm(u8 pc, struct mpam_props *cprops)
 
 static u16 percent_to_mbw_max(u8 pc, struct mpam_props *cprops)
 {
-	u8 bit;
-	u32 divisor = 2, value = 0, milli_pc;
-
-	/*
-	 * To ensure 100% sets all the bits, we need to the contribution
-	 * of bits worth less than 1%. Scale everything up by 1000.
-	 */
-	milli_pc = pc * 1000;
-
-	for (bit = 16; bit > (16 - cprops->bwa_wd); bit--) {
-		if (milli_pc >= MAX_MBA_BW * 1000 / divisor) {
-			milli_pc -= MAX_MBA_BW * 1000 / divisor;
-			value |= BIT(bit - 1);
-		}
-		divisor <<= 1;
-
-		if (!milli_pc)
-			break;
-	}
-
-	/* Mask out unimplemented bits */
-	if (cprops->bwa_wd <= 16)
-		value &= GENMASK(15, 16 - cprops->bwa_wd);
-
-	return value;
+	return (((pc * 65536) / 100) - 1);
 }
 
 /* Find the L3 component that holds this CPU */
@@ -1167,6 +1127,9 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 	if (!r->alloc_capable || partid >= resctrl_arch_get_num_closid(r))
 		return -EINVAL;
 
+	/* Update with requested configuration only */
+	cfg = dom->comp->cfg[partid];
+
 	switch (r->rid) {
 	case RDT_RESOURCE_L2:
 	case RDT_RESOURCE_L3:
@@ -1182,6 +1145,8 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 		} else if (mpam_has_feature(mpam_feat_mbw_max, cprops)) {
 			cfg.mbw_max = percent_to_mbw_max(cfg_val, cprops);
 			mpam_set_feature(mpam_feat_mbw_max, &cfg);
+			/* Resctrl doesn't support MBW_MIN yet, use default value */
+			mpam_clear_feature(mpam_feat_mbw_min, &cfg.features);
 			break;
 		}
 		fallthrough;
-- 
2.25.1


