Return-Path: <linux-kernel+bounces-260694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF0E93AD16
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D6C1F24C01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8313A3E0;
	Wed, 24 Jul 2024 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G5CaaouT"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923E131E38
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805219; cv=fail; b=QZHo4J6gjApTS2x8GgUx30VnthxOU/5FhisHtMwbNYQlj/xCkCA1KkSdgTJ9M0JO0MXRwkUqVI3Z5gB0DVQm0L5xuhNk0TjQ6zj/WYwN8U23m296JXhaPic6xhjnFtDIBjLuB5QQpFvGimiHzyWtXYe9z3H19bPPVEtZDtlrcHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805219; c=relaxed/simple;
	bh=vpyad5LRMtEExHKtwLndVOY0s5do8BsSCBGVbCX5NWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWOXzRggU2ORuVNVK8+4YsDIEMpAOLi3YclXGZhlVXdJR0PcC9cDzrbZv8FXZItp6c0uygBh+7magrJr7nA3OnRmVGNC9G0hJb4YWe6tO9z9gs68a4PlGb/6IL29MF014TVy8dfucg6Tsyt4e2fwxADTgDD2zvVzMkiwvNJorwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G5CaaouT; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOzdIGzGYRXVj7zHGqtVF57ly/l8Qz/BnKU+zhnbmMRugfdIfVowUfEetw+XKTgcbU+Rc2iH6sV1j39Z0trH0dt56g0maWca4ZP6NCZeNkqiy9TASrRzMdIyzjHeduYc59eRxOvsmdLwGAw3MHk03dJs0MH7FkK8pGh3QeZDDgVvV5o/Lr7jLzuEdtCeBhqlYAdC38wC6ojJ1DGDD1ukcbfI9k9BSkuPEZrofLzesVj7aCTOiKuYQVpbAqRgpEMUUy3lnVQsqOoUFMtSm0CfTAFm0flf/9eEqwLICmClmJ5KyROe2XQZrxc/49GPanPg5cVQSZAkS6QGIfiXijbbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABM0PjwrBwECIs/E3JgSaaELkvIIKN7lkUEAryoaQlk=;
 b=o523q9HRqKNthE3AFZM9xUx035CYT3eyXX9YEfhzO1QOkvnytYK60JflG892jY1FxLxIRFYe9JW6BRB3SbiwO0IXTGqw0BT9+euFla+gAy//D49HBJGAsddK7SPrvRWK8I0Qd9t451TX9rGaZ4X/dIRCA2M48WcrpGzs6pjDa2VufNySYqEk+m5DP0OFYMqUBZ4er3G7HhsKLS72yh3K8AMv1Ir6V3B/NPhzspWtExSh2IrfdqOxblGDfjax3gvlIKhyaXDu1F6nn3rWqcCOGsWR3neF1gE5kydss3q887nihcTX9AVEQ3pUMO+a6wpbZW71aLDXvWSR4Yuyq/BLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABM0PjwrBwECIs/E3JgSaaELkvIIKN7lkUEAryoaQlk=;
 b=G5CaaouTPHG3G5BEnfpPyKa9pcVlKKybJg6GPyRgzqHrcF0GuiZX13BTUavgNoGPxUoW8JJrRxeZ8UEDKKMS4ygZBK+4FxX95OWNDskB+UM3wRZfiQreRraW4oZyiT6RLyiHWMg6G/2xxTIwp6JxD2kmkwgoaAldiHJ1PGLN5B4=
Received: from BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37) by
 PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 24 Jul
 2024 07:13:32 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::50) by BYAPR01CA0060.outlook.office365.com
 (2603:10b6:a03:94::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Wed, 24 Jul 2024 07:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 07:13:32 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 02:13:28 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 4/5] i3c: mipi-i3c-hci: Add a quirk to set timing parameters
Date: Wed, 24 Jul 2024 12:42:44 +0530
Message-ID: <20240724071245.3833404-5-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724071245.3833404-1-Shyam-sundar.S-k@amd.com>
References: <20240724071245.3833404-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9eb17d-80ec-4f67-300f-08dcabb0205c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Blv86NzydJXd0VjFUyces4mmMWbkMGCh3nwCTzqi6n/eDd99tMsexJ5pjn3r?=
 =?us-ascii?Q?bVF54awchIwClKb8nKkUXiiXdDWc7HuSl/DCNIVHqgM5t9Nmvq1V8NjAqmVs?=
 =?us-ascii?Q?D+hNZY7zsRppaLVvgNfx0UXo1fyKYcN2FRwFuoA5O/KZ67WnjQ6VHlh//w2r?=
 =?us-ascii?Q?bQcyQnlrj+89wJ3EXzMDCIvjRHx/4+bJsR7EYn+2Og/VjU7JZihAyo661XZ0?=
 =?us-ascii?Q?i8dlq8q+Glq9wbuXauatXFDfwM16vCZTHnsG6aPKW2nrGZ53k15r3fe3gvbU?=
 =?us-ascii?Q?HKWh8isr9Dd6fW/x+yncLUBanyeQE5G8pzZqkNODS4dI0fay7vI3dZ2b/9Ne?=
 =?us-ascii?Q?G1h0vXpeDoEY6pCENzNzvao0EniVC68q4vFQEOuKILB4r+OPWKhpQX2j0fMP?=
 =?us-ascii?Q?aEHSBO/lLutpfynVxtFESZrzMv0dy09UC6fGqqAmiFsd4fL0mCFsFWOp/1wl?=
 =?us-ascii?Q?FKIKBpxcC0fgX6WbkOSE56V5GGNMqFBk8M3hUrrKcStsjg50OiiFgcLyMT27?=
 =?us-ascii?Q?ZxQGOcNV5BLBDfxf3c2HoJvxMo/MYM/+MCGEzWk9hEFcQoUJJzrBInemLBoi?=
 =?us-ascii?Q?nhsS4ziO+55uWgbBqwinv775kcoA7tHDIMo+QsVhspgNav0YXx16GDLrW7MC?=
 =?us-ascii?Q?h7l5DzlRA3h7ro+GtAxef5NJTjpvHiBeVALk+tqB4I8Om4yU1yPnqHgkRxXJ?=
 =?us-ascii?Q?tt0KPJffpH8CR1oy4E98Va4fzb7LOZNEcdAfDdLJ8uiBsgtfrTHKP0VHiai0?=
 =?us-ascii?Q?/y8wfHgyD9nlwqODOAceencFuHHRkqkk/nT+BGtQY2Ic/wSRdZTGPjtV1gIC?=
 =?us-ascii?Q?Hp/gKRdr0UxQqnGKyZ6wH1p/eXfx5eyfpqAORayT1m3KST7AeppWs/LSygsZ?=
 =?us-ascii?Q?fF0Ub9DGdIPa+I0VjViY/oJBjLeHGzad9eXSF+cpJlcN5kGH1jD9uEGWLn8H?=
 =?us-ascii?Q?yAz3THH0GB8qNFPxGsRTCsgX8PTRghpfPqkaCoAPAVkyF+DFnvZ4W05kkQT5?=
 =?us-ascii?Q?zKtvyvBlHuihhWtlikkCFgkTDLt9nLe4xrcfqV6/QjUlyEom2ixYQajXd9L7?=
 =?us-ascii?Q?Q6NYYUPTMHqV2J76A8gyvmdF8OZQS3fje7jCk4cqC1NIbFPu9KtyVc/1Bs8d?=
 =?us-ascii?Q?Bi+MrqZpmlEe3+k26QTKUWAb2pdvqGXuFbylchpD0uAeNRGJQI/T+f4n+HVF?=
 =?us-ascii?Q?Tqydkuy2Dv1gxD8HfFpHr4LwYm0rXqSjNOk+RbI3XWgHz6mSgrtU61gzFlhW?=
 =?us-ascii?Q?UCfUwPsqd772uWYFPVGNdB6FnUVuYgsdBp8NKsFdhc95ApYuG7VjC+Jjq4oc?=
 =?us-ascii?Q?qO2uQILt3en0QBmjhBL5bcooJGtYE5sfOQVTQW2LYtlp13piXj+l78Jlw7oo?=
 =?us-ascii?Q?gi+6M9U+PlPHhTKGfKEYIToXgtLS6L4Wpnp9+QdPFEtELGz6Dr/JsUMBei1O?=
 =?us-ascii?Q?uM1dpPv/GzkATn57ZX7ixhv02Fa3upIp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:13:32.2930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9eb17d-80ec-4f67-300f-08dcabb0205c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

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
 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 43 ++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index ca9d4e2c80e6..3320e6331c86 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -783,6 +783,10 @@ static int i3c_hci_init(struct i3c_hci *hci)
 		return ret;
 	}
 
+	/* Configure OD and PP timings for AMD platforms */
+	if (hci->quirks & HCI_QUIRK_AMD_OD_PP_TIMING)
+		amd_set_od_pp_timing(hci);
+
 	return 0;
 }
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 8e5af4e55de1..06a4d54a5a02 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -141,6 +141,7 @@ struct i3c_hci_dev_data {
 /* list of quirks */
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
 #define HCI_QUIRK_AMD_PIO_MODE		BIT(2)  /* Set PIO mode for AMD platforms */
+#define HCI_QUIRK_AMD_OD_PP_TIMING	BIT(3)	/* Set OD and PP timings for AMD platforms */
 
 
 /* global functions */
@@ -149,5 +150,6 @@ void mipi_i3c_hci_pio_reset(struct i3c_hci *hci);
 void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
 
 void amd_i3c_hci_quirks_init(struct i3c_hci *hci);
+void amd_set_od_pp_timing(struct i3c_hci *hci);
 
 #endif
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
new file mode 100644
index 000000000000..6ce08f9c92a8
--- /dev/null
+++ b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * I3C HCI quirks
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
+#if defined(CONFIG_X86)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		hci->quirks |= HCI_QUIRK_AMD_PIO_MODE;
+		hci->quirks |= HCI_QUIRK_AMD_OD_PP_TIMING;
+	}
+#endif
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


