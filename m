Return-Path: <linux-kernel+bounces-275833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB13C948AC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB9B24313
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76E81BCA0D;
	Tue,  6 Aug 2024 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KcyURGzF"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2DB1BD4E0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931161; cv=fail; b=ZLlGYkTg/bros1hW7o+GkxFF6m/ySLBfma6ILWIHIwt7L3SPTw6KtGG++XoZ6y04x7AMyA1P9/MSvRtvp0CtKx2Rvh68pNkl+zhIu8Fga6upQVWEeso7vTNcvyejGZ4MP547L5KZa3fOLXrwJVRTLbl0EFPqdcN/JLCrn9K4Enk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931161; c=relaxed/simple;
	bh=FENfOdqMl2Bwzlf+FOvCugSVmQwyXsujt9XUknBwJXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAt5hMrjW5fKNZyx0W85SNUEDj94U+ebujnl6n6CzW2rpx3sOD6Zh6u1j5fAVWR66V8P2PAlHup2NAeNi+ykjQSaNVe4G5/8nYAzZUyibrHfRscL8W8jsS+anOTfH6r1B4sQXxz9dBK4uJPhzR6zI3sVioSm8TDtcdHj2jTa058=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KcyURGzF; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0Dlm5F0HnpLTb87gxKMkHLKAFOQ6IG8hFVFuuJFF1+/xdvc80S0r7CdsZ3nGhq9aHxW4+FQWKH6ZVLafsq5ZMulTiTzYQyCTLBj7A8YvLQQBwGkA4b08rjCGfV3oBXlxg9y5R87VHrgji8jGON4LoIOXeIBpQ2f8+dAnvxDXSTaEyNUQkMn/ylEuiVMUS8ZZlPg9NINSPpy2ObvUMm0eAlYT7ndJ9zZRu574lElmuARCkbNe+nPiGgiq+coKQhVi1Rte1+DUn7AeYP5Facqewicq5sdb4MWksL7in3pbgq8WIe7+V1YoINU25uRv+q6hVPq1tB15oF1ka1kJIKs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fu6+K686Dt5XCNF6lBu7lrGF24EzmvRoVMOApH89cAg=;
 b=tTNUFqkVWJG94ffWqmrqAT78dZNCn6MM3pO7aqTJ4SSih6ihhnOCEBgt1RrF3V93/o6wHCcgg+Ctz5318H5BQeopH1uTXSFrHdfPaCf8TnnSoMZ7trisuGfgWsQBrg2Q+vUrhR02gL2rwLUaozBJ5qAamcjY51JeRloabXAiPWcJCxLqsrwzWYjLkPE+UyI7u6qy8gVm/baAdVzV+xgYkHD7obKA9sHaaSYLFQi0K4W6+t+5r3bN8R0EBstsFLrWX2RPhib1Fpz3AUarGUTo77DDjAhSiLi1TofTxJQzZV3qyxdjDrXGQ2+VPCbqXx/gTLF6o59E8GrV2kl8pbDrrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fu6+K686Dt5XCNF6lBu7lrGF24EzmvRoVMOApH89cAg=;
 b=KcyURGzFIu3jhKpN8jfWuiCcSDky8Q3yuiv6tzdx5/yCusfERiQEpsqExTk/s+zXdIZynz/7NYM8HWU09APaaTqGeDMV1Mocy4YkLuKN0fne11AV5Gn6KIeRwyDpN3/+wBhFVH+VbMnODNc8db4Nd4rVHOmQiQELW4uPLd3HsQU=
Received: from SA1PR04CA0009.namprd04.prod.outlook.com (2603:10b6:806:2ce::25)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 6 Aug
 2024 07:59:16 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::1a) by SA1PR04CA0009.outlook.office365.com
 (2603:10b6:806:2ce::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Tue, 6 Aug 2024 07:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 07:59:16 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 02:59:13 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 4/5] i3c: mipi-i3c-hci: Add a quirk to set timing parameters
Date: Tue, 6 Aug 2024 13:28:42 +0530
Message-ID: <20240806075843.277969-5-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806075843.277969-1-Shyam-sundar.S-k@amd.com>
References: <20240806075843.277969-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d66725-0736-41d2-d650-08dcb5edab03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tvVCvjxkyUF1bAj4V6jkkWJherKErA+dDeFj98/sD0MJz0Q5FpWj0QqSuNx8?=
 =?us-ascii?Q?lx9ZbLxb6M4d2F+vsn0nIQtlp+p9KcYB0OkGpkjWiL/Io5/3FhjHpMn3HHDM?=
 =?us-ascii?Q?5W7sE3M25AcABQpCNRY/q9ya8Vd6HwrB5OgoQSURau3Vl67KqUZOxIW0YeIx?=
 =?us-ascii?Q?uZ23Cx0FByg796uHZANh7skpWchhCKk08/yqWyLGz99jH54kKOmat512w3Sf?=
 =?us-ascii?Q?1Fr1S23c8RFZ4AEnhhNpXD6SBiMX9bCWvxuqDj4tRARbSrBcwlRFiZAJmCze?=
 =?us-ascii?Q?2q+UsubPxMJP3xK3NJbtZvNJUJ0EHRaLbBVv7gHfFLwsr1rlmRMvKsNSr+VA?=
 =?us-ascii?Q?mbMF3tV91oxrWIXKegd+imr+pyHWHdfMdyJVlkq8XdqrZj8AWygVX5peMto5?=
 =?us-ascii?Q?6e6UEvguJrXVuqomwqvQbBbv+SlGoCOPlj/ivR7wOQRJNnSpVBozF8CK+vgS?=
 =?us-ascii?Q?HTvNt6ZSzas/Q/c/lCnl5DIYvYqr7yNLL5h5jeln/SxQ1zGmIihrR+/MSCvx?=
 =?us-ascii?Q?ef7jX97YCc+K9tSoEg3CWQ9SpN/AkLzNnFBdkzEiQUfRwGqDcvck9PP8gGOY?=
 =?us-ascii?Q?WBEuE05N9unz4ByvcqyQTs16XwW5uJ2cHDaAMXUyOx/8e68djSfKD4VXkkdE?=
 =?us-ascii?Q?pknUTJVrKPe734EeZPjlt5ER/CnSfkrqYXBOx430b0slwmG+kac0RhKZsGOI?=
 =?us-ascii?Q?nv+r5TcT5g1XvLVEQ1nC+jwgF/qNTPOAGSITjRQrUCLitNXjhULJLvA57eg/?=
 =?us-ascii?Q?HWipfjP+bpFGIz28UMBeAVyePi6OdN34y4BQu2WJ1Q1IYQoHi8ft184ifkQj?=
 =?us-ascii?Q?SqBzgGctcX93KVuDLsdVDqKjo7gNhcDgEa4WA8nGi1tp20yA3C45ZM6bWo5E?=
 =?us-ascii?Q?zvRUU1gic/FRTqKljd86j/tB1MQ7iyn/eqkOJ1nadOvPchWk96FcpFHkmMTT?=
 =?us-ascii?Q?FYCKDYBwMPjUT6AFGEEQ9/Alr54G0D/SEfWe3vHJkOBCRDI3g92HZCUPjIdN?=
 =?us-ascii?Q?BAngDF5fwMXDNPfmiVdjwaNBU/1a0T/zEbXfQNG9NrzEVMUyjPrrRuRYMqGo?=
 =?us-ascii?Q?924dFFaczrIOGeYtN5Ugpv/xHOXaPsE4/rRNDHr1Vrx75RHhMvzwG2FhWD7Y?=
 =?us-ascii?Q?dZVMwd2W6TPyLPRCoWEl+k4BnLMbDFJZk4FGFBivfxsfSGhJ4/e1/m3Gj8e1?=
 =?us-ascii?Q?APCd3yPIhEGXokMgZArpAvrwcUzbzP/zE1gbO86h1wT4kzGQKWdc8DNTyx60?=
 =?us-ascii?Q?FHjVcM+VHcBZwHM6B5EuJrJptvI20RNVJerO7S/LDBaqH1I8mDOkVKwCDeOB?=
 =?us-ascii?Q?nk3HrQIe12WrD0lwgqa+7IgFWYfWiyq2Ci5gBXDZgv/s0aUD3hJcA1nkEOnb?=
 =?us-ascii?Q?neOKuW02zGfLJC5QV55mxbUn0TwItXSratL9dPC2k4uS6dO9ztS+mNaPynqe?=
 =?us-ascii?Q?iB+I60tn1SnKI7v1HNdzACutD9ce1T2R?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:59:16.0018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d66725-0736-41d2-d650-08dcb5edab03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211

The AMD HCI controller is currently unstable at 12.5 MHz. To address this,
a quirk is added to configure the clock rate to 9 MHz as a workaround,
with proportional adjustments to the Open-Drain (OD) and Push-Pull (PP)
values.

Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c       |  4 ++++
 drivers/i3c/master/mipi-i3c-hci/hci.h        |  2 ++
 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 25 +++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 5c4fcb740856..baec2c42e0e0 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -791,6 +791,10 @@ static int i3c_hci_init(struct i3c_hci *hci)
 		return ret;
 	}
 
+	/* Configure OD and PP timings for AMD platforms */
+	if (hci->quirks & HCI_QUIRK_OD_PP_TIMING)
+		amd_set_od_pp_timing(hci);
+
 	return 0;
 }
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 2b7560149520..e1a65cfb43c8 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -141,6 +141,7 @@ struct i3c_hci_dev_data {
 /* list of quirks */
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
 #define HCI_QUIRK_PIO_MODE	BIT(2)  /* Set PIO mode for AMD platforms */
+#define HCI_QUIRK_OD_PP_TIMING		BIT(3)  /* Set OD and PP timings for AMD platforms */
 
 
 /* global functions */
@@ -149,5 +150,6 @@ void mipi_i3c_hci_pio_reset(struct i3c_hci *hci);
 void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
 
 void amd_i3c_hci_quirks_init(struct i3c_hci *hci);
+void amd_set_od_pp_timing(struct i3c_hci *hci);
 
 #endif
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
index 8a8fbd697175..a222bfab0676 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
+++ b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
@@ -11,10 +11,33 @@
 #include <linux/i3c/master.h>
 #include "hci.h"
 
+/* Timing registers */
+#define HCI_SCL_I3C_OD_TIMING          0x214
+#define HCI_SCL_I3C_PP_TIMING          0x218
+#define HCI_SDA_HOLD_SWITCH_DLY_TIMING 0x230
+
+/* Timing values to configure 9MHz frequency */
+#define AMD_SCL_I3C_OD_TIMING          0x00cf00cf
+#define AMD_SCL_I3C_PP_TIMING          0x00160016
+
 void amd_i3c_hci_quirks_init(struct i3c_hci *hci)
 {
 #if defined(CONFIG_X86)
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 		hci->quirks |= HCI_QUIRK_PIO_MODE;
+		hci->quirks |= HCI_QUIRK_OD_PP_TIMING;
+	}
 #endif
 }
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


