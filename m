Return-Path: <linux-kernel+bounces-295598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A4959ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33180B22C74
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143C91ACE1D;
	Wed, 21 Aug 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wOWrpWqB"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806191ACE08
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247409; cv=fail; b=ANZL57VSbrv+7HYZadr1CDh6Nt02AMcxaf3gzDMaHYorlaWJzvMOne7ZHB6bdj4J4OKeTmIpUdK32RzvR9HdaOc+mvevG0JVL8rhX/d1hqucbCl1mQsAIhmISFRfC4WN3pIS9msJDtAxDF9AiKUPthtjIPELBHhvFqQxlXyEv6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247409; c=relaxed/simple;
	bh=dXN6fsjsTkr8Zt2Vmr8wIMsL6W8QCLJBdj6DOj522dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZ11RWPHRkdsEkE4C9OUzNi63vU5ZmVLujYEIRKQuFzaKllF7MlwcDlA2P2lc3qx28qU267JtlICxvxO5odcXNHexB5kQk1EPIUjWXHrqP2Ild0Lx+yZEKZtr04MZmxkuz0zKA3re1wgDS3DCyETK/JgzctWorw4MAPXjdqRXW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wOWrpWqB; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9xGwdYcGqjbKMF1iBQJ5W7wCKUhfZsCIs0ojsg6hBxOZekHJeec50wRjGI/HDiBkcDvx1pNsfxorVCLeqFtJVIG7Hze4GT0rwTN+MeOGJt7nfeeOBg9w1wvqMkNrOM7NF6HiH51s9uqhdLEdJGHV82SEekbr+dWSQ1xAxTqdtNrILq1YyTkt7DE3KEMe2sMexrbtoy/b/iwr5U9s9gbybKPRyK4odNQcYpvY9s/6OHUBAAM20KbO3nPqEevhVypj1zepg+52vXu/W/HRBRTNsobsnbdcaI9cWPOQY+ApUi4EfzSsRL5AIv2HfZa27YzBWsQfs2OpyePXDJASDJsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9jHT+vWTnSRaO7KpjZzjJRIaO8rBSovyZSAChl7A30=;
 b=Irzl4dbIqnV6FKl72YOEul6MITaSIMFaZljonBmEHLWQBPhCbWWo3UFSf8L1Wk4ZR7H3E9L3Sxg0oiFD9+dhJMaCtGA96Pm6BY/xjS8lzizFqoCwDLJYMSJ2JMobrlLIp/b/9Z0e/831nLRupc+PW+rNT9WIjW5XvJxNDlqjZ8nsPvLPBuSfrSAiO/VIl48G6LulrqX3e1qCtoCyvrl4dWLevzYXFbAwg5/fqLQw8+Y5uJEMcq+zHNTbOxspJ5ZPlOXhunLtyM6Hq44lu6d79XbcO/KUBHRzOnXRU2VOXEcWOoir+7DFAzNnW5hiRw8UP/iCrDOgyTxx+NVjXOes+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9jHT+vWTnSRaO7KpjZzjJRIaO8rBSovyZSAChl7A30=;
 b=wOWrpWqBrKQPLzC1gT9FFTa/Q9ZCjS1nUD07vTKzJU7bYXMHVMPWhJveVGwILEpldcRknTXPsWU83C7wMLROYB5uadAp7eKqoW5EJ9ymSTUUAeJzgmCXas2lU9ZxR03XhTuQCnZDEMvGvUBF4DkAP5Fc4tWPJc4hbE267eRZxMg=
Received: from BN0PR04CA0197.namprd04.prod.outlook.com (2603:10b6:408:e9::22)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 13:36:40 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::ee) by BN0PR04CA0197.outlook.office365.com
 (2603:10b6:408:e9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 13:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 13:36:39 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:36:36 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v4 5/6] i3c: mipi-i3c-hci: Add a quirk to set timing parameters
Date: Wed, 21 Aug 2024 19:05:53 +0530
Message-ID: <20240821133554.391937-6-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 7309975b-baf7-41d0-c069-08dcc1e6498a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nr8cGspREIlulwRtq7vuQ8OjmqxFkzdmUxsQHWHmCm+feSyoMhK3bBmBHEBu?=
 =?us-ascii?Q?apR14ORyh36t8LtU3uxLYehxRpti8IaJDXyP2rl/6MD0kVfwWS57Orejul+S?=
 =?us-ascii?Q?HRy+Gf2p+3lqKrMdoV9K4BJzTe288mBJapvxfrK6DORa2AbdKl/k5IrJcO9H?=
 =?us-ascii?Q?Jrpe/lv83yKfyhvwO6foCAeIbRvl0/LZP0a05lOzC4kRv0NIjnEHs5KeP0l1?=
 =?us-ascii?Q?kd7R+AKu3nZkahDppi5oYmcasKLoTKGEYKDldV4qyGo3NIi9B4wABH2ettZ9?=
 =?us-ascii?Q?RIlUIcs5cjmeE0kTEovnm54mi9cWu4Q9yHshrmDQUUcgipAcKxryUSnswBPp?=
 =?us-ascii?Q?EVkKzSXdYJkmg+5iiqxda9Uq7XH+4wYo5olgD7mmBFwK1MDSlIM3htUCYy3m?=
 =?us-ascii?Q?XiwKlo5rv9WtxpMwWz/UgXIKOpkv83WVHRmZ5YrhnwPGqo6CttCcV+ImmVPD?=
 =?us-ascii?Q?dWqiMlmtepDQaXDuMkxvV7MqUfDKmoQkFY80RIqRJS0HqmbUQCKE4PgGslaD?=
 =?us-ascii?Q?3ndgjBBz7p6AgdskY1/raM7EKZOQftW+EfVwaepyX1toZM2BuhfJcAVGiL7X?=
 =?us-ascii?Q?jXixfmirHBFyo/srq6MFvAamvyq4pb1sEuLesUfeoWTzVKqrrM81Cj9tYedw?=
 =?us-ascii?Q?GaXWg3Cq8wz6FLebdA0V465JKn5C9oZhNMTOAnYKP26C7dOe6PmqZPECc4b0?=
 =?us-ascii?Q?5FWP6jzKaIF1llCuK3/6ZA+ph0CW+PDkDwsGyCkxREovMufgPgSN3GvQJWtC?=
 =?us-ascii?Q?q/EsxRjO9375DnTFhpAWe2M9uHKhzjPRFmhRs15rNsEVuZPZInB+J7kwxUsV?=
 =?us-ascii?Q?aOzqg8HNyCt4eDJBCnB5UatcvysvbMu+nQnxIW1VUx7Sbhvl+8qqg1hBFAMU?=
 =?us-ascii?Q?ns/si/J/7hNCsR3P8BJjGQnR0ryZFEkwCNgLPxHI/Vwfrqer88/YPz6hnBUS?=
 =?us-ascii?Q?2ADGxoZa+tu28niU+lPb1Mcpdx5fhLN0TlmglYri2duC17vVz20J7sSh1/aw?=
 =?us-ascii?Q?n0Cs1F1/vIzbUQ6sMjxTLrxGHK57JXF9kx6sxFULplsAd4ID8EXKwDgzrqL/?=
 =?us-ascii?Q?g5sViNsKSyNrZZ2mPRiHBueo4ZV1LgLdvEnLlu+aUcPHV6BVE93XdMGhsrF6?=
 =?us-ascii?Q?nI5X/N365DWjpr5hUvrI3f6yOChTrV8/vzx1qbk1j1E/Pj0Gp62VMVKdJOIo?=
 =?us-ascii?Q?g2L9Az53VVN/yjPxa3WOQFCNbUZUA0M3fnaH6RNuiHGDBVHTFoX1BUuuHREC?=
 =?us-ascii?Q?kGtaL5Kam0VmCbad20kq8sIkpOEMlu3yTF7SHoLtNDkDFcaeI30GwBCeOV/A?=
 =?us-ascii?Q?VIhEqVCyh+sgTRazOIrw1rCLqh0TGS2y9/r0OMRBy1b2R5WqFywrng+bZdSg?=
 =?us-ascii?Q?7QX4w5/YCJ7B9kUcqSySpOasX8F/jHM91o+i7isouLCqXyEMwyt3MRn7noF0?=
 =?us-ascii?Q?TJHfqHZVVVM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:36:39.9455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7309975b-baf7-41d0-c069-08dcc1e6498a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872

The AMD HCI controller is currently unstable at 12.5 MHz. To address this,
a quirk is added to configure the clock rate to 9 MHz as a workaround,
with proportional adjustments to the Open-Drain (OD) and Push-Pull (PP)
values.

Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/Makefile     |  3 +-
 drivers/i3c/master/mipi-i3c-hci/core.c       |  6 +++-
 drivers/i3c/master/mipi-i3c-hci/hci.h        |  2 ++
 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 33 ++++++++++++++++++++
 4 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c

diff --git a/drivers/i3c/master/mipi-i3c-hci/Makefile b/drivers/i3c/master/mipi-i3c-hci/Makefile
index a658e7b8262c..1f8cd5c48fde 100644
--- a/drivers/i3c/master/mipi-i3c-hci/Makefile
+++ b/drivers/i3c/master/mipi-i3c-hci/Makefile
@@ -3,4 +3,5 @@
 obj-$(CONFIG_MIPI_I3C_HCI)		+= mipi-i3c-hci.o
 mipi-i3c-hci-y				:= core.o ext_caps.o pio.o dma.o \
 					   cmd_v1.o cmd_v2.o \
-					   dat_v1.o dct_v1.o
+					   dat_v1.o dct_v1.o \
+					   hci_quirks.o
diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index c0f3c0ce9f6a..fe49765fc2da 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -784,6 +784,10 @@ static int i3c_hci_init(struct i3c_hci *hci)
 		return ret;
 	}
 
+	/* Configure OD and PP timings for AMD platforms */
+	if (hci->quirks & HCI_QUIRK_OD_PP_TIMING)
+		amd_set_od_pp_timing(hci);
+
 	return 0;
 }
 
@@ -837,7 +841,7 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
 
 static const struct acpi_device_id i3c_hci_acpi_match[] = {
-	{"AMDI5017", HCI_QUIRK_PIO_MODE},
+	{"AMDI5017", HCI_QUIRK_PIO_MODE | HCI_QUIRK_OD_PP_TIMING},
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, i3c_hci_acpi_match);
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 76658789b018..361e1366fe38 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -141,11 +141,13 @@ struct i3c_hci_dev_data {
 /* list of quirks */
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
 #define HCI_QUIRK_PIO_MODE	BIT(2)  /* Set PIO mode for AMD platforms */
+#define HCI_QUIRK_OD_PP_TIMING		BIT(3)  /* Set OD and PP timings for AMD platforms */
 
 
 /* global functions */
 void mipi_i3c_hci_resume(struct i3c_hci *hci);
 void mipi_i3c_hci_pio_reset(struct i3c_hci *hci);
 void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
+void amd_set_od_pp_timing(struct i3c_hci *hci);
 
 #endif
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
new file mode 100644
index 000000000000..e8ea4d101f66
--- /dev/null
+++ b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * I3C HCI Quirks
+ *
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ *
+ * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+ *	    Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
+ */
+
+#include <linux/i3c/master.h>
+#include "hci.h"
+
+/* Timing registers */
+#define HCI_SCL_I3C_OD_TIMING          0x214
+#define HCI_SCL_I3C_PP_TIMING          0x218
+#define HCI_SDA_HOLD_SWITCH_DLY_TIMING 0x230
+
+/* Timing values to configure 9MHz frequency */
+#define AMD_SCL_I3C_OD_TIMING          0x00cf00cf
+#define AMD_SCL_I3C_PP_TIMING          0x00160016
+
+void amd_set_od_pp_timing(struct i3c_hci *hci)
+{
+	u32 data;
+
+	reg_write(HCI_SCL_I3C_OD_TIMING, AMD_SCL_I3C_OD_TIMING);
+	reg_write(HCI_SCL_I3C_PP_TIMING, AMD_SCL_I3C_PP_TIMING);
+	data = reg_read(HCI_SDA_HOLD_SWITCH_DLY_TIMING);
+	/* Configure maximum TX hold time */
+	data |= W0_MASK(18, 16);
+	reg_write(HCI_SDA_HOLD_SWITCH_DLY_TIMING, data);
+}
-- 
2.25.1


