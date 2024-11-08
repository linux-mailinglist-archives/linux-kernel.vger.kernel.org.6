Return-Path: <linux-kernel+bounces-401190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1EC9C170D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1FA1F235F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5561DE8B9;
	Fri,  8 Nov 2024 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uizvP72P"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9931D1502
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051256; cv=fail; b=PaCCp03iAua3iAjTrJ4sRe3ELt4j+f3IU1U7j+roauw6+Tp196V9jvNagdcLPVmkQDr3FGpE8Vv5N0YqtI7KQ/QqoNRYFozn376fMb/jt1CRSLEUvXz5EV6T3YPT3NtQL80b6cy7VM0sPgHICg/ifh2QSFbHTr9tEAreNnJ+3KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051256; c=relaxed/simple;
	bh=zPtBB+yaPivfrfAJ7FOTu9wwXej0Tnf02EbJT2b9P6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAAFzm+09WdqcUV5kVrb5lSK2IZCs9ahcpExVGHPIu4GBv2RSpkHwRQF+FXbo6Qs9WeUV1UVG2WKXpIuxiRSf1cbIiYC3CYb3IF6WzPJwV4xGvUvMN7perVNYySS/6vYPA7f+hY2k5jMOE/zaUrjFsRDNRu7lkQQfKHiDSpxi+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uizvP72P; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArtSLb8Ntx9Y4W5poSrvgjnXgDRWbJpV3JhIjS2GeC/ZhpzKi6GKZaVZ0MB2qkoGDNOaqZjQJs82Qqz0IdBq5XAI3yHoaM4wZG9NUhiid2XnRCs/UG85i1BPP5zVA4MRmzi9Lr4Flqp3mVqJpP52YJb6uiQPugrRpKWcPoyz9JM9zFAq06hA+jo7E0EHRJtqEC+KU/Cur3BlRJzV1N5HP6CDmlZ60+RRIi12/6q8Wwh5Br3WKLHVQS0FHM6AC89nGvK08zoOaXZKzBIlknuiWSHwKP1T8Rwa2u+TWf1pTcVzfrKuyzaFD0RNk8Op8oQrLz+clbkxfyyySVvoVvhn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFj1euUfTce0xwCEXJQnwCWXcSwneCcgZ319DR4KGJc=;
 b=yHzheKN6ZZ26+8o6JWhlS5macTPo2Id8tEFkTNRTEIDs9LPcw0pL5DdjTaFF1bohriaTsYXFJ8+8DOyN8bJOBbkRokDYDWsglgU83+otoymKojOp8JrgmSnrKn2DYDzAdVWal0lBvOOlIkWGw9alf0tKEx7BdGYm9VC6iX8zDUf17nT/xy2KQ+T4RG9SbP8Od9lc9tLfkeCvOfFSoPSyJZOni0msoR4ulu4vGdhwjmYX6HRYMW1txnX5+T7pTueI966HhIoBPatKp0j5JOJvaN+Fu9y/Kmc+z2LKFL9C8msQmfaFNRUjlaph0Xj3/9a9u6jgVGYEzMR06zNKYF/Fmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFj1euUfTce0xwCEXJQnwCWXcSwneCcgZ319DR4KGJc=;
 b=uizvP72PVon0fG0ECbdrRpnQiV1qitsVj76HipXf/8G7mBtuCC+Tkwb7YqaPGdfyLCE2dMu/FUG6Its6zzkPEO1AacWcvJ/VVcKFsAPUECvOnzfUOHlF0VzmLL+mtzm5s4g82FT4c1Px07KrOI5B7yMxVD+G10ReJMWxaL8cOuw=
Received: from MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30) by
 PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 07:34:11 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:23f:cafe::22) by MN2PR01CA0061.outlook.office365.com
 (2603:10b6:208:23f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 07:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Fri, 8 Nov 2024 07:34:11 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 01:34:09 -0600
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 4/5] i3c: master: Add support for SETAASA CCC
Date: Fri, 8 Nov 2024 13:03:22 +0530
Message-ID: <20241108073323.523805-5-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 97005468-f97c-4a2c-1685-08dcffc7bd2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OYibDgU15NUN43Y7hzUKMmuKNTHYoWtrJ512uJisdk3aha2tKxXrD1cgqfBy?=
 =?us-ascii?Q?54mjBAc3PP1i1vDFhPWjM+yP1eWxBIA8XGOEjDglwrwVPYQTx6MVtWw0liqp?=
 =?us-ascii?Q?5avbyLH58ZCTd8jU4CEnB1S7MQKD6dE/gu/o+gRTdTae63rpZAjZyubd+A7a?=
 =?us-ascii?Q?L88rWsHeM2fQLra6WztNsTjCSXn1DzwHBEDcPYJAhCMF2cHOSVJwIDpvNvlE?=
 =?us-ascii?Q?MYm32yrwhEWqPFLmWAX3MiqQh4AhHlHKykqg9Nhazq5IQIUSVgKpf2FjIit7?=
 =?us-ascii?Q?EGjXM0+3e+TpREFENqFBUuqxwnXLPgJQBDW59//IaWfyjByyBiU+1ILkTyrF?=
 =?us-ascii?Q?5wywAAAvZ8x7CiZVdQgBKrGSD1Mz6wrZOqZ54YYlgDK4J0R7OZD74Zsi3oNp?=
 =?us-ascii?Q?74O9TuUcifzHbfdDgLMQ3wf+O1qRnM86ImrBWCJlYPj0zzVZLOoiUL1Pf4Df?=
 =?us-ascii?Q?fL/H3XWnlWfVslu+IPvbOJ/RcWFsDc6aIFRToCEwH6/nl3oQGxJc4PdavHzx?=
 =?us-ascii?Q?L5lGUbVYQruaehlalxn70EWDg/jMbIz+1PYXviJcgkNfP9qCoqXD7Lp9sK/z?=
 =?us-ascii?Q?3Y48stVgrfZUbVtbBz6/iQVqyhs8FNiFzoJVfSGKM2DxjchXh578l20Ceumw?=
 =?us-ascii?Q?kL3UE3UM08LCsHR9ffuJKMQwFT+4yj7LgftxeMbHfkYPhKJrMT2UXJKLbxYy?=
 =?us-ascii?Q?HdfMkn/CWIke93+FKX9nf77ttn2ExvJnBdrQ1oEfC28kl7CEJMo6LoFBskmo?=
 =?us-ascii?Q?qdH7xKvW7h8WSAALwr7GXWxu8PqCMhieP3B55zQmTHWgxufH27MldigGEyH2?=
 =?us-ascii?Q?V4tXu9K6yPbuRyGN/MAZcfP8tWwv77KnhiXZ5eHfd41vYj0FdGfkpf3QG465?=
 =?us-ascii?Q?lrgeFPQIOClTNZqvn+9IwUn+2hkfoRDMlgTH0J3o4XLmKseEgFPM9ro+1wfq?=
 =?us-ascii?Q?OUcrOL72FjeDziAWVW1KE8B8hjQFvKmZwrgLwQKyOliQX7koQy1gMuBHDyT9?=
 =?us-ascii?Q?pt8kPulgPMFcEH6Sx++52eGXgPfyDTH+s6w0GUaZEDw5CbYTCViUsNkHTa9q?=
 =?us-ascii?Q?n7OLZHMnScxPcd+ZQxjChqryWftdF8Y1r56JV7guN4Zp+S6ugE8sgfj00S5/?=
 =?us-ascii?Q?upemaOmUmsrgSJs6sRp5/kjtyUZcNth/mj76anagaf482D7y28hEwDJYIyJa?=
 =?us-ascii?Q?fO5ipV4gyOMEpksvloKnX3Ylf+r+JTrCnBdcRI/jyO5A2dEW6UTZW7n0VFR2?=
 =?us-ascii?Q?jjRViCr8bXLyxe4YPj/fvollmIleE0U0ykS48Eh33UrDGgl8T6vP/HFxi3j/?=
 =?us-ascii?Q?esNfc9RziDrWMfhCUtSJPrVIbE1wPdxXtzZ5MiQ+51EUv2LL+jGQuGjl26S0?=
 =?us-ascii?Q?uPVamzA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 07:34:11.6697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97005468-f97c-4a2c-1685-08dcffc7bd2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906

I3C devices like DIMMs over SPD use SETAASA[1] for bus discovery instead of
SETDASA. Add a new routine for I3C host controller drivers to use. If the
I3C slave on the bus is an SPD device, skip the regular DAA process.

According to the SPD spec[2], use SETAASA for bus discovery, and avoid
sending RSTDAA and DISEC, as they are considered illegal. Skip this entire
process if the slave is SPD-compliant, as indicated by the "jdec_spd" flag
from the BIOS.

[1] SETAASA is introduced in MIPI v1.1.1 specification.
[2] https://www.jedec.org/system/files/docs/JESD300-5B.01.pdf
(section 2.4 and 2.6.3)

Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master.c               | 32 +++++++++++++++++++++++++++++-
 drivers/i3c/master/dw-i3c-master.c |  1 +
 include/linux/i3c/ccc.h            |  1 +
 include/linux/i3c/master.h         |  1 +
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 8f37dcaa1efe..2f06f168ef82 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1657,6 +1657,21 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 	}
 }
 
+static int i3c_master_setaasa_locked(struct i3c_master_controller *master)
+{
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	i3c_ccc_cmd_dest_init(&dest, I3C_BROADCAST_ADDR, 0);
+	i3c_ccc_cmd_init(&cmd, false, I3C_CCC_SETAASA, &dest, 1);
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
 static int i3c_master_add_spd_dev(struct i3c_master_controller *master,
 				  struct i3c_dev_boardinfo *boardinfo)
 {
@@ -1684,6 +1699,10 @@ static int i3c_master_add_spd_dev(struct i3c_master_controller *master,
 		i3cdev->info.pid = i3cdev->boardinfo->pid;
 		i3cdev->info.dyn_addr = i3cdev->boardinfo->init_dyn_addr;
 
+		ret = i3c_master_setaasa_locked(master);
+		if (ret)
+			goto err_free_dev;
+
 		i3c_bus_normaluse_lock(&master->bus);
 		i3c_master_register_new_i3c_devs(master);
 		i3c_bus_normaluse_unlock(&master->bus);
@@ -1907,7 +1926,14 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 		goto err_bus_cleanup;
 	}
 
-	i3c_master_add_spd_dev(master, i3cboardinfo);
+	/*
+	 * If the I3C slave on the bus is SPD device, then do not follow the regular
+	 * DAA process. Also, as per SPD spec SETAASA is required for the bus discovery
+	 * and sending RSTDAA and DISEC is considered as illegal. So skip the entire process
+	 * if the jdec_spd flag has been identified from the BIOS.
+	 */
+	if (master->jdec_spd)
+		return i3c_master_add_spd_dev(master, i3cboardinfo);
 
 	if (master->ops->set_speed) {
 		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
@@ -2311,6 +2337,10 @@ static int i3c_acpi_configure_master(struct i3c_master_controller *master)
 		return -ENODEV;
 	}
 
+	status = acpi_evaluate_object(master->ahandle, "_STR", NULL, NULL);
+	if (ACPI_SUCCESS(status))
+		master->jdec_spd = true;
+
 	num_dev = device_get_child_node_count(dev);
 	if (!num_dev) {
 		dev_err(&master->dev, "Error: no child node present\n");
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index d44b771d03e1..dc701275485a 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -282,6 +282,7 @@ static bool dw_i3c_master_supports_ccc_cmd(struct i3c_master_controller *m,
 	case I3C_CCC_GETSTATUS:
 	case I3C_CCC_GETMXDS:
 	case I3C_CCC_GETHDRCAP:
+	case I3C_CCC_SETAASA:
 		return true;
 	default:
 		return false;
diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
index ad59a4ae60d1..a145d766ab6f 100644
--- a/include/linux/i3c/ccc.h
+++ b/include/linux/i3c/ccc.h
@@ -32,6 +32,7 @@
 #define I3C_CCC_DEFSLVS			I3C_CCC_ID(0x8, true)
 #define I3C_CCC_ENTTM			I3C_CCC_ID(0xb, true)
 #define I3C_CCC_ENTHDR(x)		I3C_CCC_ID(0x20 + (x), true)
+#define I3C_CCC_SETAASA			I3C_CCC_ID(0x29, true)
 
 /* Unicast-only commands */
 #define I3C_CCC_SETDASA			I3C_CCC_ID(0x7, false)
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 367faf7c4bf3..cd8390d8b469 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -516,6 +516,7 @@ struct i3c_master_controller {
 	const struct i3c_master_controller_ops *ops;
 	unsigned int secondary : 1;
 	unsigned int init_done : 1;
+	unsigned int jdec_spd : 1;
 	unsigned int hotjoin: 1;
 	struct {
 		struct list_head i3c;
-- 
2.34.1


