Return-Path: <linux-kernel+bounces-260253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E9193A507
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029B71C221D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B178F158A31;
	Tue, 23 Jul 2024 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jm5MSfYT"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE1C158A10
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756185; cv=fail; b=kSVVFXOo+gc1NFp9xYW/pFL0ds3gGn6SdQ/TBrM+14YARgArgUWEbhFVl7PSF5Bi9URxDIFXu9zV+DipAqYAfi39YK4hqDrk5gqPjHk7ps24Lie8miEUyIxUWvhVbAqy0gs4oNt4gB/AfnVMXt43Udk/krdmyCi+N5z5jOMc6iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756185; c=relaxed/simple;
	bh=BY/iDMaE9nTqvF5J0ekZZm5x/7CyKIOFD+NFGqalHc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnjM7m8VNd1S+iSj/9Wyy7HVkFCbGpiOG0XUcVtqE3FppwFFvjfQPwxv3ndoPS8AQ3Ie55ayV6wCQCQjxP2C7Dsn0RFjJLNcDBRQWfjwFhmsW1mx/0zusTb42JaEKQvrMyw42KpbB2ty4Kq+6jSux2vDAbwO5QnOG7dyPBY0iLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jm5MSfYT; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYb/eI5HdEjbwNnMBRvL/d61rUoVnQzlaD8/UdXiQ6SDDvx89Wwg/ij6Pj2Np4gwqXy8ss7ykz+8RdrMfBhF/kjfB5uBMOxTOnAS6NQmiyhv6ik5q4v14eLYANcNi/lH/NOrTuIdIeiIe9A06AYvw43ay+hUk6GqVfycdyuPWCuXVQiveMxodGtPKEP3vd5/z68YKwnohYaYCxkm/V6MrSFlj0otz3im4cn9GAKRU/YZpPBKDZ5H8I5bCRXSQixmxjkjYKkL65vQK/yW0R0o1P2+wOHAmVZdPt0pHNWmkJtNZVO+IfxQ9vWKsjFiuVD8YLJbjoTF9b32uGXXbsAR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v45OyP2OYym0YYIo0LaPDjJTYuuBuXGW6+CxzPOclUI=;
 b=b15B+KuhcnyqcN8TzODK2tnGNA8YuqYeTcDNRvjejIYZuNCQ02a5n8ZxEuQ3vW81ACVJ4lKQ+d/UhrtbJ6jYPjWoPGl4Iu+p0S5Vfhke/ySMSzAjhHI4igmGuRpvRoS1rGXFGfuQFeDe4zIAi7Kfnx4or6UxvWGLdrV/UAiOept7y59ATS0sE73kTZDitqhT80Ha0olBWSJkzbDN/FPPBpehlcLkpEvA+TbYobNafcnqfob74qIZEJq5+fCUZdMFRpPgM7rANZMa0euZURd4POZIDR3YSTMBPcCjHgYsOzXafUqWeo3pWHd8pUTg0LO3g45FI9rxgWtzIFt4bmOs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v45OyP2OYym0YYIo0LaPDjJTYuuBuXGW6+CxzPOclUI=;
 b=Jm5MSfYTBwNOdFs1gGY/1GdXDwb7HrHLM/wNTP8uPzpKxjMpTG94dxAkAOfNe8HLIgTB5S1I9/4J6Yvr1NW2LcRJG5cWmTFWkgqRXv2EPiSdAB8R/HUEcX1/8FPxD3Ztg5/dtkXqUUt3Wkiy73JbCawGTBL+lXfHBPcS/QCkGwU=
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Tue, 23 Jul
 2024 17:36:22 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::94) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Tue, 23 Jul 2024 17:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 17:36:21 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Jul
 2024 12:36:18 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH 4/5] i3c: mipi-i3c-hci: Add a quirk to set timing parameters
Date: Tue, 23 Jul 2024 23:05:37 +0530
Message-ID: <20240723173538.3493935-5-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723173538.3493935-1-Shyam-sundar.S-k@amd.com>
References: <20240723173538.3493935-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0bf749-b1a4-419f-9535-08dcab3df7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zWOVYFkP5EDuSFMSbkz5y6XcxA1rvxTf+3rnrZeQjW6bnAd4frybFnicX7eP?=
 =?us-ascii?Q?lC/6TvgFoDjNox7I6lviceu7K9vwkQ3EUTqRm1MD+P7HFACARUJlntqISCPl?=
 =?us-ascii?Q?iCGg5LZT8goQfuEkUZ4ZJq/kVfGB1aNshpF3HkSTQBJSCoG/6n8Js8D0Ct+A?=
 =?us-ascii?Q?jQ3bF7m/TFjUaghLc3J5kYZd9oyy0vffFXIgLOBgTRB3w1pGBmJnfmDCbWeJ?=
 =?us-ascii?Q?h1Ld+6xQqMUgsNyeIgetksEGZl0e4tUr+sgLJCqqB5n8tgHdbA33JFTd0h6m?=
 =?us-ascii?Q?3niPAKKY780rrZmRuqQtzVhy0+EeDSPoFtK4UUM3lROXSf0BNEn2GU3FYOx7?=
 =?us-ascii?Q?ih7Z09MEoQyoBRr+1ubUgaawtvlr/In+zeRrCA89ZsTQ9eyev51v7vaDH1Yi?=
 =?us-ascii?Q?dp6bh34ffHTYKksLnlWfygoAeEdq4cpQ6R5RiNiqJop9P2FRUgOYrwtHa8bX?=
 =?us-ascii?Q?yKD1eRGLpHCo3ICpvEPLO22AV9jChOKxtnkpRLiHB+b+EYrcyrSeXmUBocan?=
 =?us-ascii?Q?tSoRoFY/Uj+Ad0tyitmItD5Ys1Ej+rY2N/92Cr/GD4V5r4DwuVJaAiKVN4Rv?=
 =?us-ascii?Q?+APO6N+SuymkBCZ90uACwD1WpNT9OtD32yLHDIDZM22drtB9TGvvCtmSESRO?=
 =?us-ascii?Q?6y5jQ3Okd9AvpeW3L3GTIvu/VlgX4xTE5/vDMZDAvH4ISP8JZofAcKkBcRRA?=
 =?us-ascii?Q?b5uU44PTY1vigkdWhcpaaxQUHC4OsO5cnwNlGUX5RuDBuPhdoYbbYAnAKf9m?=
 =?us-ascii?Q?UVqt6wvFt+0TRPbjFqyDoaJ4lDqV2ke2We7T7noK5hWxENQPKzbNXhQHdNa9?=
 =?us-ascii?Q?u1P97ml1qv5Krx8h7kHsXb3hsNRmSJ1aR/IhIPfE8jG+7lI5pg165oN73lrD?=
 =?us-ascii?Q?oP6lVcmylH74gsTpIDcVUgpykXp10lm4BpPxTmQpSUxZa/CyVrPRbWEgwDg/?=
 =?us-ascii?Q?I5ogy55Zly2lieuYL1qWwLrUwltBTWgnQv/imi2LijH8SOaEIM7jcxN838MH?=
 =?us-ascii?Q?FBKtKWsE7+VM2mRmcN+QT+uCSTaNK47GncDr581oK7XVi25ZbYhJ+y1kPY/4?=
 =?us-ascii?Q?IKX2wZi2qAIDQKBJnWoWNbZawBcYOJ7+3j1FdnAdcI/bs7xtT41XwXOCIiEK?=
 =?us-ascii?Q?5TOfwjYUYfDBTVZIqsaJwm3oJrltTvclhwUOL0vN2xnBPwUMG0oziLUGQNvJ?=
 =?us-ascii?Q?7PGkXyo6RErLyz94SfhqxBXe7qyouEx43S1DrFujuaFXN+3kX1YkDUzBYA2f?=
 =?us-ascii?Q?kDy4E2I9MAQD7svQolxXws6X1WvtFuEOTJgBGoFCRfZF+aVu1/FaMySoI271?=
 =?us-ascii?Q?r25coXBC3FDjxQrFevx+qvSVbBSXHvHVChq9FKttQ2/oXGqjIvyn43NcLaLG?=
 =?us-ascii?Q?J8QxNfehvOgDN3Ef0g8+FUarlYpoymUBoEO9ltj/wFCrfXAP0kr+Ll1uFtQX?=
 =?us-ascii?Q?H0gi21STcqMJNzqtZpYI9cu41I3Endqg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 17:36:21.5548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0bf749-b1a4-419f-9535-08dcab3df7b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772

The AMD HCI controller is currently unstable at 12.5 MHz. To address this,
a quirk is added to configure the clock rate to 9 MHz as a workaround,
with proportional adjustments to the Open-Drain (OD) and Push-Pull (PP)
values.

Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c       |  4 ++
 drivers/i3c/master/mipi-i3c-hci/hci.h        |  2 +
 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 41 ++++++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index ae5b1a144506..9fc142ca7532 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -784,6 +784,10 @@ static int i3c_hci_init(struct i3c_hci *hci)
 		return ret;
 	}
 
+	/* Configure OD and PP timings for AMD platforms */
+	if (hci->quirks & HCI_QUIRK_AMD_OD_PP_TIMING)
+		amd_set_od_pp_timing(hci);
+
 	return 0;
 }
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 56361adbcc14..f4ec6dcb2ecf 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -140,6 +140,7 @@ struct i3c_hci_dev_data {
 /* list of quirks */
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
 #define HCI_QUIRK_AMD_PIO_MODE		BIT(2)  /* Set PIO mode for AMD platforms */
+#define HCI_QUIRK_AMD_OD_PP_TIMING	BIT(3)	/* Set OD and PP timings for AMD platforms */
 
 
 /* global functions */
@@ -148,5 +149,6 @@ void mipi_i3c_hci_pio_reset(struct i3c_hci *hci);
 void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
 
 void amd_i3c_hci_quirks_init(struct i3c_hci *hci);
+void amd_set_od_pp_timing(struct i3c_hci *hci);
 
 #endif
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
new file mode 100644
index 000000000000..9d8c5eedc8cc
--- /dev/null
+++ b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD SOC I3C HCI quirks
+ *
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ *
+ * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+ *          Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
+ */
+
+#include <linux/i3c/master.h>
+#include "hci.h"
+
+/* Timing registers */
+#define HCI_SCL_I3C_OD_TIMING		0x214
+#define HCI_SCL_I3C_PP_TIMING		0x218
+#define HCI_SDA_HOLD_SWITCH_DLY_TIMING	0x230
+
+/* Timing values to configure 9MHz frequency */
+#define AMD_SCL_I3C_OD_TIMING		0x00cf00cf
+#define AMD_SCL_I3C_PP_TIMING		0x00160016
+
+void amd_i3c_hci_quirks_init(struct i3c_hci *hci)
+{
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		hci->quirks |= HCI_QUIRK_AMD_PIO_MODE;
+		hci->quirks |= HCI_QUIRK_AMD_OD_PP_TIMING;
+	}
+}
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


