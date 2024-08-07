Return-Path: <linux-kernel+bounces-277308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1290E949F1F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360DB1C23293
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F98F19149B;
	Wed,  7 Aug 2024 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oGzarOld"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C562725622
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008309; cv=fail; b=M49+5+PIeCGW6eQfzBarffAtDeoiA2Jnvz8ZaJClTwldOLvEaTxq3HMMkPGPSWj/yM+0+k5UPekaJu0JbDsc+PuZWnByQxBS5ocapdBgnZPyTHQAGxMwuvKFQ500dfLsayZOfM+Zvri59ab36s9J9i86NAX0xFxyzU4ldWKwg8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008309; c=relaxed/simple;
	bh=fH143adLj3rQlLiahd4Rzm1yqOI3sNn/HLeR3HY9xMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEbMeYMy7jHxvSE39KDXJBOm/f4xUiyhwSYftU8E1q5pDs+dMNuOiwOLCAH5ly+kUmq9r/rt/iCyS46v7hBKC+M9tu7zlKX3Uax/nP958gnChCtiMHhhm0ZlTtOPfQ+K6xkaqrqY18kjlOFtWaGcXas9iy7Jc0CBHA7n0snrTc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oGzarOld; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYbp8UGUowJckJnfi5yuDU1NkqZwX+YMhO4mmMijLkQaYBlLMQ1q4SutL++C9mbekrnC4i6beqrgfqtDQj8a3Ik4TYdnKxzSvLhnpbLZDJD+yPLOPPzqVW9ONHuRCcZJLq5vXcapSNQAQJAdEmEZgy+5j91nA3C58330TuJV0HNQw9FTqR9gvc2f5T5A4EY3Ay2naqMGRNgEiq6T0hP8ydizwmSA4TfX2aEejbtoVFq6+/JPh96aZq9xUyTAUj8erB9yo4DxmMddoh9Rz+i+MMKq7USYfGrGxiXrcz+bF8Hbmxn2c2lfbGjGNrcTPkXrrZAfAL6sQQjOcRnVYGIrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvzbnoS4IqnMS3jMOr8EVpyDh2YGtwmr5hmnktC+l20=;
 b=pAbnxg0LqzjANp9dymc65arXI8PLEWdq7U24KLaz0QVgVYKdaJPC0ECLg2SF+AR4BDelFJZeYVVSy0fr9RF6Uof+EBMbZpHEsB7Ifpu4w4e6yz8DFBTm8po8B6EDF3bAIkihNE4jN9z6GIQZ4siaqToqZh1cckhrQpNyQ9GorlOruW6kihRatrH1eMn0ae2V9ZTUvFf8UYwD6OKYlgGoLsKDk1us1dlX2a/PDWVqVTshwbaihAw/lqlpA+s6YifdO7WeVMvMT2jnHoi5PBYWexzdH9f50yapUTFCyU8GuyBi+xm7gYCo1nDRDwriAk4zk9OgPz7a0bOOjTG4qAayvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvzbnoS4IqnMS3jMOr8EVpyDh2YGtwmr5hmnktC+l20=;
 b=oGzarOldrsqOwIxFBOw/SvPyJ4cIhhauFdtYyBB9xlQ1B2wEOppAx28Er8dEAOE63dO74j8aSCi0h1P+d/mXw5p5g5hZ6iT0Kunmoh8sxGZQX+LR5YQCsMs5aU+de37R9yS5dF1iZKxeuuJonLFW3K6f0uMxeB7WqjYWnp21fyE=
Received: from SA0PR12CA0022.namprd12.prod.outlook.com (2603:10b6:806:6f::27)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 05:25:05 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::2b) by SA0PR12CA0022.outlook.office365.com
 (2603:10b6:806:6f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24 via Frontend
 Transport; Wed, 7 Aug 2024 05:25:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 05:25:05 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 00:24:58 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH RESEND v3 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO mode
Date: Wed, 7 Aug 2024 10:53:56 +0530
Message-ID: <20240807052359.290046-4-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: e619b7c5-e09a-43f3-6492-08dcb6a14b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5B2wb2bdWvBU3hT3lVLHGuKxQDcwSFU6phXvkVBUenrWPkFo3ZE8foC04jyS?=
 =?us-ascii?Q?yDb8AJR4gJPIaPuVLL+Iv5FBkd3DxadhOmGGBD6k+Pj1zewneabACo7BOvm4?=
 =?us-ascii?Q?LFJ3qxoBN04qnGWJ4N3F4sm1nal/vcJ9mzH1cMTW9ZOy7Ss7Rl49zxqOpIKc?=
 =?us-ascii?Q?VnVe/2OO6VEXJdMRyrWP67bXjG7NHrzT8/X1eqXgGipxT4qLe59I8TrWiri3?=
 =?us-ascii?Q?RGiUuXpvVymxI1EZWBtuceC5lj8ZRVmByWhEfSVJuC9KGaN86NTdlvPKJZ43?=
 =?us-ascii?Q?QAAaitvuh5cWLSWCQzjasuFBYcQwAMDZC8y8zqhyq3hGKe44dXQr3KuKgGZ7?=
 =?us-ascii?Q?f1WEL1WCJhcX1t4XWHA72FsLNJw8bqZZFny6zkdova79VpvRD9buO/dv/WYz?=
 =?us-ascii?Q?iiSmi/ZQlXrV+bEdD9zB7GdGZJbw4s6LLq1i7Cwa8xQlSxBhz+zuYrOHyz4j?=
 =?us-ascii?Q?rKil3MRep9AqjS4Mj3AECRzM9uJpqRTVWw50r2yugsXemZZuH/xvQrclP1l4?=
 =?us-ascii?Q?LHCEx5C9SrDIfLWddYNJrA4heSKuWIXfK2w94AskczKMwJnar2s5rmJ3IN0A?=
 =?us-ascii?Q?HuPRarcEZMQAf3GkQI+Imcx7lacCEBS0iWWS++cEoGOVMLWEmU/frQP5vyUw?=
 =?us-ascii?Q?ymk8SuQ6n86lTd+reBlP0bbrAa0e1JpWSk/0ZG8wgulQl9ubR84zIW4aWWuO?=
 =?us-ascii?Q?+l8hUDMJUnV5MZ9IAWr2F8IRiB3dfj+1k74pPH4qcaqYqVhuZZIScwaPim2p?=
 =?us-ascii?Q?OjeExpbk7581IwN9KFNwBtqdDHBNcrDCouC6LivcrT3DEVDeY6EzjTccxKW0?=
 =?us-ascii?Q?ZmFS7/f9Qh3dn2X0EpWFZ6O9Xbyji1OCoOdqfdAC2lRrbYGk7JCRrDxAcF18?=
 =?us-ascii?Q?2W8g9aAZG1tNIUSoDdurO0y0jVMW07XVzdW3OjBFi2xpTxLz0CkieaC2T+6B?=
 =?us-ascii?Q?HdbCqQSpr6SN9ETa8E6LpHHfkgA0FgpI8w/JfjQxiG1hDLS86EbI0IRhFC+m?=
 =?us-ascii?Q?W+cdLg4rldZq8leYGaQhpyT2jtfdj4ILW6GN6XZoFkK5EZ5qN4Va96QAsa2D?=
 =?us-ascii?Q?Lb6+3GpazlZxNWjeMhK2II1DacULseEEfh7k83cPftyAgDG6TvUjUfx7AnFN?=
 =?us-ascii?Q?IE+a35lPi6z9cJ3MR9FY7vJvlhy7Tk4ueyS9z8GA/Fv94vEQCaFrHtQcx0gl?=
 =?us-ascii?Q?6TLUFSbrSmZMiMrhHHYZWBXyQdHAPJ/C3fbJaUGAjkL+zSAQ9TOQCeGoY16c?=
 =?us-ascii?Q?CsqbKCBvCKd/jDJiORAzm60K9YzkEMWdLqfKk27+aPgJcam6blaHTyzL3Hxw?=
 =?us-ascii?Q?jkFfDeawZCeG5IsmcaSb+1BreyyLL3Z8n/+heET67PrzRdR3RYoGdMjx8za2?=
 =?us-ascii?Q?FYfMjzxpnLv0oq1CGXpTlzm7h3HKBODIYznSEYshcFcPVncX/K8Z+VECNbEH?=
 =?us-ascii?Q?kLf0n4AiSumtrh3p0hSpRjXT/XSdqfsr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 05:25:05.2599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e619b7c5-e09a-43f3-6492-08dcb6a14b8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446

The AMD HCI controller currently only supports PIO mode but exposes DMA
rings to the OS, which leads to the controller being configured in DMA
mode. To address this, add a quirk to avoid configuring the controller in
DMA mode and default to PIO mode.

Additionally, introduce a generic quirk infrastructure to the mipi-i3c-hci
driver to facilitate seamless future quirk additions.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/Makefile     |  3 ++-
 drivers/i3c/master/mipi-i3c-hci/core.c       |  7 +++++++
 drivers/i3c/master/mipi-i3c-hci/hci.h        |  2 ++
 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 20 ++++++++++++++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)
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
index a16da70bdfe1..4926fde6087d 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -754,6 +754,13 @@ static int i3c_hci_init(struct i3c_hci *hci)
 		return -EINVAL;
 	}
 
+	/* Initialize quirks for AMD platforms */
+	amd_i3c_hci_quirks_init(hci);
+
+	regval = reg_read(HCI_VERSION);
+	if (hci->quirks & HCI_QUIRK_PIO_MODE)
+		hci->RHS_regs = NULL;
+
 	/* Try activating DMA operations first */
 	if (hci->RHS_regs) {
 		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index f94d95e024be..a7ea37f8f8e0 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -135,11 +135,13 @@ struct i3c_hci_dev_data {
 
 /* list of quirks */
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
+#define HCI_QUIRK_PIO_MODE	BIT(2)  /* Set PIO mode for AMD platforms */
 
 
 /* global functions */
 void mipi_i3c_hci_resume(struct i3c_hci *hci);
 void mipi_i3c_hci_pio_reset(struct i3c_hci *hci);
 void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
+void amd_i3c_hci_quirks_init(struct i3c_hci *hci);
 
 #endif
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
new file mode 100644
index 000000000000..897c0231f585
--- /dev/null
+++ b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
@@ -0,0 +1,20 @@
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
+void amd_i3c_hci_quirks_init(struct i3c_hci *hci)
+{
+#if defined(CONFIG_X86)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		hci->quirks |= HCI_QUIRK_PIO_MODE;
+#endif
+}
-- 
2.25.1


