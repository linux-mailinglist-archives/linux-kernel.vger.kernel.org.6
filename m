Return-Path: <linux-kernel+bounces-277310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E9A949F21
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7045F1C20E98
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62D5194A43;
	Wed,  7 Aug 2024 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y5VjmV4+"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62898190077
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008310; cv=fail; b=kCcGC2EVtAfQrWR6IRPnnYqnFS8d8i6JWlb2mtrsjAJ1RlUNlITWc7mmVMkVevP2TcGn4bmj3N94Z3cvNEJWk9iuTxF0KfLFmkkBEzaUwyZVJVxO0DJqhOdBYMVDbpxS7LeNe9mD9MjAeSl7jOWTggBhkiVuCfyF+Nvp9pzWfis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008310; c=relaxed/simple;
	bh=wgsRzfMKcMgoxW67pebuOVRRJXN4LWg1xAbXkms2TuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjzvlJ+feGjaPx/5pJosfSlNrF4W0dR6Qfea8uD4v7Zoq/4VnVKsR20bm/dPzqMxMes/0aapxhpo8wKiQ3oi57I0nbNoIk9AXwoO+tEw7sLs8x21D+pTD07HTt8K4CQEoUGoDqDGcmlogsXc9yoxNEdYF9KmCrPckOkIDD1z8nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y5VjmV4+; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuHpjt7bWwrrM5d8pzNqgnfgAgpnbK8ef3/mElB48wK2/SmDsltXi0BBA3dPhg3ptbyB6KLHQtieLmNcauYGivP2mrt6/zxW7eCj4IBtfhBiL0xNpNVGo3qbvJBQpF9LGqud91EtKRtT4qdrt0vhnXYXoqdKbHMe73A2JKDVcJyI7Pjec7Fgt5JfW6VPe8Xdrp3mXxWmtWYo2OiSFmqAhcWbKEjjWd9knf6YYdcy+p5qB4zYMPzGg0y6GgSnPNO0WYRkqXShQJnTrw1fGiKYRrsOyPOZzk7RGuhWxGIhzSx2KaoeuHhYPGClU8jBn1FUXwsPHrFJw5q7TW7oXgAhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwmeBfBHbZbmbP2Aa6T0WV2739WyXZu3Mh8AjyuG6u8=;
 b=KV6Vmq0lzTr8unsGfM3M/fCThgpKINULra13aTctlAtXTxpSFqI0X8C2NzZm3+LG9+RkYeoMIyl7MWZEyMsvfKV6YTW+Vk3rSKh0ximByc9Kam8l1MOj8IsnWBoMQx5jDlTuUiVa62kcL2yX0a4XLCx2fygm9XHDBH5gITNPcVrBDQV8PCRx3xFkOincaX28wxv9c5YQc+5h0KYk+ETJenN0fp8teKe9cfcZd2ylxDvCOBdRRmtSkaajRzyXEXP70fFyQpdFpj4kzRwd6HfTT9gKyl2M9k+gM5JIbz78MnHmbfb7UC8R1QKq6RqeKup6G1fxn/LBB3DIvUvY4xKaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwmeBfBHbZbmbP2Aa6T0WV2739WyXZu3Mh8AjyuG6u8=;
 b=y5VjmV4+P+4yrdGbV5okhtMcGXDC96T8GPlpsa+pI140fkDFtLwdqHEVd7Ra6DiJtENewlbxzfUESnN94i2QYX63Bv8eN9LNpI7P6BxM4lyjffR9hOLMSEJFdvp4lgkWo91wBupeVTbs7g3Be3ibTptcS8/b2+KzrEmd2nOF53E=
Received: from SA0PR12CA0002.namprd12.prod.outlook.com (2603:10b6:806:6f::7)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 05:25:06 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::b6) by SA0PR12CA0002.outlook.office365.com
 (2603:10b6:806:6f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24 via Frontend
 Transport; Wed, 7 Aug 2024 05:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 05:25:06 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 00:25:03 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH RESEND v3 5/6] i3c: mipi-i3c-hci: Add a quirk to set timing parameters
Date: Wed, 7 Aug 2024 10:53:58 +0530
Message-ID: <20240807052359.290046-6-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7ced50-8bd5-447e-47f1-08dcb6a14c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zPzK07xnhpJCM/nWN+mV65GiaZkuXwspCb/GpZePOL1TgFXkfnoEJ4hZsSQk?=
 =?us-ascii?Q?WKxO9vHgSUs4SkY6VdT1U7QJDZh4Spd5hbVBNYa2LKl/qj+hy5tH6V3pcKSr?=
 =?us-ascii?Q?2JHZo0q04yRO9gI4fa5WjxHbX8lHhKQhJbsC7ON9PW88rpbrUA6+NgOloMW1?=
 =?us-ascii?Q?tDPMLIz/UEGE8X5/peXw7znZf23rqAVXhNtWO1vzBDPVLrV/2krMRkvKAFm8?=
 =?us-ascii?Q?e5KtYu/+ehpKbUFhzUg1BY+JIKdPoXm17N+y0XGodWiOuDdEQWZOBQR2XfMU?=
 =?us-ascii?Q?xZ6xcEj0B5q5jFg9BC1lfdai8FBUlu/mkFJ1aG4QUeLzlYrz6yeKOG+KLt+u?=
 =?us-ascii?Q?M0DR9DWPDLaMUVprAfqN1Rs8uR53HSKLLUxPj/Y3IgunLiXmJEDkzncbOLrX?=
 =?us-ascii?Q?Niy4XAauDidumzhjgBN51eFCrCGiSvO5KNn5tZQEnJ7U1c1b/ut9P7USNp8B?=
 =?us-ascii?Q?t9CEGhiR6ZXcvoTM703LocD9G2uJHwkpYpdDPqhwrx4ivShpx936tRWDqpMO?=
 =?us-ascii?Q?LYzRVbPy78Ai7PKOe2Of7N8SFh+mwYkKWjIyCkmJK/HNtAZRcI9h9q032NjL?=
 =?us-ascii?Q?APcGk/TCXoMu3Q97ykmgst5NGU20dSyExgxQXjwe+kV/qoso6rAlB6MKBQ4m?=
 =?us-ascii?Q?5qLMRCcPXYrxYSasZfHylXT5rD70wuNKyuLIqzYMnFhG4NzzA8gr665LOt2/?=
 =?us-ascii?Q?wrj8UPiMLt0Qt8ht59A5J0N2XyTOz4zWBHu0LTruU24aTYBoCE9Xi+CcOctZ?=
 =?us-ascii?Q?mfKABFF5JtSNBVasYaruzcs3S1MR8Q59lLatabKwLfnK5k35eFMdDsOsKoMQ?=
 =?us-ascii?Q?RDF9P9Dhk5D2Ug/Q3JesaLBsOFbUqlIHBxoKBlFQ98Sl25AzSNueTcNhmKxs?=
 =?us-ascii?Q?npnm26LJX8H9E2nBIsLbQm+vFclMEydLwy0BKd2ZhAL7URi3l0KNAGuKzpH5?=
 =?us-ascii?Q?7mKxJFe4VXWtvcICtQPOSppW6iadLfDfHmgcsodDDywT6bx0s2rJPDm06lON?=
 =?us-ascii?Q?XBXHSv6kJbjp6SXlOaeEHH8L2qeO/q/v0DKmpVUXQWajvXUgxiWy0JIgEiPd?=
 =?us-ascii?Q?Iq/eFLamC7MZ3i83rIgJD8C5ohqeWwk3ZBrhLCpPppCOMyi34tfenUv7h6NV?=
 =?us-ascii?Q?bN0xT5cH1pzF7peWGvuvoR4I1L0KY8YzNfyZcWnHdD0tgM+cqGAGYETjkfnb?=
 =?us-ascii?Q?fw7pXySwqmsEmsaFsbdfyWRuaDZjN9v1blbMI0pm8yhofnNf46y9WpAr4RwI?=
 =?us-ascii?Q?DboMx9UrSvYJme+dAuf434g6ZwUNpcjx721+chqKsEsxnVH4ka/QLeQUPXQy?=
 =?us-ascii?Q?Au2WVhHxC9QO6D54mmurWcakmuIgC3Z1K1UQG2NCfnB4+GBaLQAELKLrdrkw?=
 =?us-ascii?Q?dpnZ2OnZD5JtDPAAAamIxFw1IEOWi3ffeX0BoWkXoBcTuurYAw81kdgiLtqJ?=
 =?us-ascii?Q?EMQMN1afj93KAjQ4orAN6kBnLi6M6qPv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 05:25:06.5568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7ced50-8bd5-447e-47f1-08dcb6a14c54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095

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
index 0dbaa1333a0c..23cfdf0059ae 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -786,6 +786,10 @@ static int i3c_hci_init(struct i3c_hci *hci)
 		return ret;
 	}
 
+	/* Configure OD and PP timings for AMD platforms */
+	if (hci->quirks & HCI_QUIRK_OD_PP_TIMING)
+		amd_set_od_pp_timing(hci);
+
 	return 0;
 }
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index d94e49be3091..5a3b4a014d62 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -141,6 +141,7 @@ struct i3c_hci_dev_data {
 /* list of quirks */
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
 #define HCI_QUIRK_PIO_MODE	BIT(2)  /* Set PIO mode for AMD platforms */
+#define HCI_QUIRK_OD_PP_TIMING		BIT(3)  /* Set OD and PP timings for AMD platforms */
 
 
 /* global functions */
@@ -148,5 +149,6 @@ void mipi_i3c_hci_resume(struct i3c_hci *hci);
 void mipi_i3c_hci_pio_reset(struct i3c_hci *hci);
 void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
 void amd_i3c_hci_quirks_init(struct i3c_hci *hci);
+void amd_set_od_pp_timing(struct i3c_hci *hci);
 
 #endif
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
index 897c0231f585..6530b9b6128f 100644
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


