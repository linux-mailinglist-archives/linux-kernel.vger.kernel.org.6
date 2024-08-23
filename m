Return-Path: <linux-kernel+bounces-299090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5238495CFF6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02321286CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C05B198822;
	Fri, 23 Aug 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="auJQUThd"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75CA196C7B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422871; cv=fail; b=EQ76eyR4BbvWNOnnTA32FEnS2VIk2dvLfRaiS/GLBSDBgCDKQ6PTJqJQn0SThL/mhyBbzSIVS1Mbi/wf+G628CzeiS2JwesiqTIc+MBtUtGxW9t1Pk3UCdFrMbYjAI23Gv2O4wAzDBRlvY4zOZBBhFGjd+JX2mutvgDudlmnd5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422871; c=relaxed/simple;
	bh=5hSFGec+FVrj2JNNdwFqrBw59qd+TlX8ukQMoe6cnY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiSCdxjeXkHLgeof9VnnyixfSj83yIvKTn8YJYKDUNvgY9xBiWLyGf0CAJ9AFmreAK5oAmpn242kI9Edotuc9ukq1KfO5yF8ypS+qxk3vIEq69t23uk0xzMcMuzZDHA4L3jSJhxWUgPIvktwaVTvigFmS4yUu/I9IcCaLiSx7gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=auJQUThd; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKo7FDbqZ5+6Gpue49VqPh+ndVFMYT7Nkw3JL3rDTDD9t/kndulkk1AY9r7pewlGQE6nEheApUQFgKZzMa/E783WwLWeKikUoRV8Avsto3LnLg6w54YYUHhFFM4cLczP/r+qfz9EXpPxZEydwpUkkuwXf9PHd7JAapa7IwXrloTHVKEXf/NBGaEUbkz8FI9zXcMrFi0lCeX6dZo/0JVFHXpZbsVGt+DQ7hsvQ3Ejy2z0rtUUp/HJ02z59TltqmTwklsyF/YLk3GZ/cunxlfbvW1nDnxSmeWLCPqNlrPhBUrNM9MQ4ZOXEd0CdCEXycnvbZFi3lOzi19EkqG3a2ufhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIeqVL5B3EMK0SaMu2YUYdS8H/8AzWnEnVeQT8NegXc=;
 b=gf9YUwxetRBflklMvTNhDK048T5U2uqO6dT6uwkjWvR9gQWMdM9yd1UW1HsO9oiIWSqLidyuV84Ev5Xeq1X0cBrF/aV/v6QV+lHa0bkbrQY/7scBVK22FcaqLcxv03uZcjaC/1fiBWaD8MDCiJ6G3yFLzhbfowSnzE7SH7KBq3DDEXGvxW5s2kbIb2cIgJdQgpiRsu82OmVTD4mlhAe1aIJlCVKoe8xm/qINbhCIQ8QQ7SSWrBPbTilijs2LdtIuSnTzEnUNjZkztpDSG3iGiShufgiGMqPrkT0h7WGsieYmgDmrVbPOFas+OGMO3icPUiuuAthx2gvZrmRAy3FQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIeqVL5B3EMK0SaMu2YUYdS8H/8AzWnEnVeQT8NegXc=;
 b=auJQUThdFAvQnsfJXeEJ/SIsOxJHxun2ZO7/fBmTaReEF8aormzoJWwIwpEgYE0sh57Z63x+32cDItUISTHshY9pWDP5mSRh//9C3y0YqcE/BcvqAdZdQrw15z7hDLCDaSuxEixNOVl83Z/GBSKNjnedFowW4IVq6778xKHZr6k=
Received: from MW4P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::18)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 14:21:06 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::f4) by MW4P221CA0013.outlook.office365.com
 (2603:10b6:303:8b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Fri, 23 Aug 2024 14:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 14:21:05 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 09:21:02 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v5 5/6] i3c: mipi-i3c-hci: Add a quirk to set timing parameters
Date: Fri, 23 Aug 2024 19:49:16 +0530
Message-ID: <20240823141917.692336-6-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823141917.692336-1-Shyam-sundar.S-k@amd.com>
References: <20240823141917.692336-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: a364e181-e524-4cb2-928a-08dcc37ed35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D6KXZ803zYUsSFwFaa03Xxbe9f2jY0sjNbVbe9YjxAY6XJoriAQI8WjH+Ld5?=
 =?us-ascii?Q?d/4bNgXepiR4JM0bwoXxNi6hy/oiAUrjDIyNOruy2NrDmCmZB+2yqy8ZQIMN?=
 =?us-ascii?Q?2S6dYtEROMH6vj5DZGkJ+RPYSL0gLQ4FJlnZ4fcqYqTB7VH8EjclBLqpMpu3?=
 =?us-ascii?Q?6vj/Y6xfiFByTGgwPojgtu5PaA9bio5DiE7ajYVLfSlZUfc1N2oK9WOOpu45?=
 =?us-ascii?Q?9Ie4okIwUKDCsCi++nqHTo9II4VtJ3M+U+Bp3UGET+oeDhGPhaefibnr7hRX?=
 =?us-ascii?Q?c0PeQ+m6yM2OBZKq4Nkh7KgHw0d7D7vYrPmir9+MFqC7fQpZu7LnYunVSfZC?=
 =?us-ascii?Q?wTjxRvwCjAaY1FDlzK/BCRxmC6GL/DEsHOym9hSpXQ+v7ZbVQ9cusCQ+hQlt?=
 =?us-ascii?Q?olaTr1d5Pihn4ErSvBzjmvM9/9fiJNr+SPSXa9X7OUd4zV6qyqaH8gMNFzkD?=
 =?us-ascii?Q?3gSc5RQAiyeOB8XRn7M3mXmRPJG2ck3RmP2E3fptJFCMDhMcAQqM8c+uUtgW?=
 =?us-ascii?Q?vnotiK3rXLEtVKDb7N3GkTRfwBAxSZlosPIWPhd/wMwpzmnY5RUA2hBeqiIj?=
 =?us-ascii?Q?e+6OPtiF3oVVScrnVqdIxtAriTzYG11OwEwIQSbiqcMf1aOj+btRwuY+LnWb?=
 =?us-ascii?Q?wjBWzpce62AVZXM63WBTj245aFCQ2y5M00fuWd7i5ybuQir6/ADGE8guSK5H?=
 =?us-ascii?Q?vuJAOaL/gmx4j/4WNqPL+rs8kqAdLiTTnVr6XC00noEerfUfcLnm9iQURoum?=
 =?us-ascii?Q?53va/slfExzEB5DMM7/N2UrKvvubqRhQL9aQD4UsfNox6FJwmLmTjb1Y/CEk?=
 =?us-ascii?Q?g/vcligYe7C4Qsu9ntkawoKi/CEwH4w1Awdx4noVe5cloORfpPrtBT82t9Y/?=
 =?us-ascii?Q?1uWVdH1IShitQ7Z2uOTXh/aRhAswF9RrvrBPTn/MoCnvroZfrysDIILTbrdi?=
 =?us-ascii?Q?NdjuBbP7P0ICckaa7hlz0gOU7FdYt3Xf/uyl5t/asHGeJImqWJbtNb86BjKZ?=
 =?us-ascii?Q?34XRI8tzHz2S/0uznFmeBmbBbew//bWQSHTArQ9CDIkHjpQ2ldFWnuKqi09A?=
 =?us-ascii?Q?bq+L+7jpkr4QFTUe9HjHxpS/WqmvrMPiXKko73Sal2hbor0+B562znp7J9iu?=
 =?us-ascii?Q?AvAipJWCPxBtubV8ObXSU2FJzPb5HxpdNyt7iPqdXxV0fnZCf7NDwV0rzGlo?=
 =?us-ascii?Q?WdOP3YBEdJ/rc0Vkj48jngBrWAEWeDFhCzpw4AycazqFCkouud/jb2CAgAQ+?=
 =?us-ascii?Q?YdjhgbejdNrVyfBEkp429otCYdKHdoFoGOCy1FET4Q/CXjq+qX6wnkdK4er8?=
 =?us-ascii?Q?kXWlBr8FKd5lpTcvnAjUE5mNPyFH+Evk5aart/Ga80j7YUqgP8Mjjo/RzNe4?=
 =?us-ascii?Q?5BYML6hYOYWVcJ80Wfbfa+foEGOYtrhEiQ7bazL81n4krXUgjCC+v06vrCrA?=
 =?us-ascii?Q?yoLpGWaXKqg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:21:05.7494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a364e181-e524-4cb2-928a-08dcc37ed35b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812

The AMD HCI controller is currently unstable at 12.5 MHz. To address this,
a quirk is added to configure the clock rate to 9 MHz as a workaround,
with proportional adjustments to the Open-Drain (OD) and Push-Pull (PP)
values.

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
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
index a64657ab5007..6c6029e6edcd 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -785,6 +785,10 @@ static int i3c_hci_init(struct i3c_hci *hci)
 		return ret;
 	}
 
+	/* Configure OD and PP timings for AMD platforms */
+	if (hci->quirks & HCI_QUIRK_OD_PP_TIMING)
+		amd_set_od_pp_timing(hci);
+
 	return 0;
 }
 
@@ -838,7 +842,7 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
 
 static const struct acpi_device_id i3c_hci_acpi_match[] = {
-	{ "AMDI5017", HCI_QUIRK_PIO_MODE },
+	{ "AMDI5017", HCI_QUIRK_PIO_MODE | HCI_QUIRK_OD_PP_TIMING },
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


