Return-Path: <linux-kernel+bounces-254497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F39333DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1029F1C22E96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BDB13B5A2;
	Tue, 16 Jul 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LmGrM7f8"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3FD13A896
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166644; cv=fail; b=F8WrRMz94UrtMniqFZT+r9Tn05/Zk/nnee0GIWdZCOuMYuYDucUTm9qfPWjR5s6oJ0FzRMB81ZeS1PPdO2WXTwjpI5wZRIeKNBJFpuIN/nJb/XxWl1kHLFOx19DvuKHoYtpIUTnArRzk/uowqFAY3EQ6dIzGI3Otb/OASAelc4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166644; c=relaxed/simple;
	bh=cVA+oT522eNLveXuduD7TfciysM/k5/cfBIGa2oBS58=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nXrJgb3SHSgBZGPA8kQH/9PObDGgQrwriUy262xjrm8HkUQFEnw+nV8yVi9dBqZ1HqdzL/WlU+1l3ILhYyDXSniJOt6DV074hA10jjmpUS2TRP4hDfzG79xTstyc74FjCF6igvTcdPyP6XDV8jtuT6qW3l+UA/jHKRfAsT8ea94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LmGrM7f8; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjFoJxa+3rqo94hLtm+XiEntVkwqH5cPutv4oNLgme6bJGb4HONude/dT+aQ3fPGA7+FkSb+efuxsvAyvtcWk6FUFqqyxExlvPCAqPYabjjuPjm0xA9RGRmvQ6m2DuXJF3s4FECdFYAS/QiLh6TFiIjerOMfhYxduByxliB5+eDQBs2XoGmMSJdXLD9ZAJdUidWgw6NuOLrcjUKAceTTlMucLq1QzJ1yMwBBbDrQSPRejys73ZlTvJTgXGKrn5b3Sw+44xl4/fA+lC5mgY4OvYV4symVJSZVfPT2iMWMFrr45cCF9kfmKFwbayij07xrq+W9rtmrfGf2Upb5hfdeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf8gNVTOcI6SRZsg4jCf+NFqlsqJ5l1gLSYWRhBBH7g=;
 b=WIlIhqz5n9tm06fchwin1sJZgxHmDyVN3JzMKDJkRkst7E8VDgVP3tBiFncwinbE7hJei5+rbM8WSieDYv5BUZ4IjkEUYas1RLU91caF814Tde7iJrBEj4b7VIUolcfTfjDEU4LGaKryPryyaO3tFv1C3Ke9Q2WW/XgheFVYaXuqm9acyGNyMTfFM7jONAPmNN+gpem63bsJR+CdkzL1rCKwJwP02oa6Pxb+VP8bnEb7nppJHquOMXwcceQDgi+qV7dBQB8tIxaFYugeY8QAn47epxa8bwMXch1hzRbEZrh+1beMMHzjVyEt46p8E4zAKkOU1LvhvobZj1wIhfJkTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf8gNVTOcI6SRZsg4jCf+NFqlsqJ5l1gLSYWRhBBH7g=;
 b=LmGrM7f8KGZf6xvUjkobjmWA5IEelense7hWBxkTYeJd/Ji2YpBN0qWVhqDakgkZ7BzCxWIHx/uvnyM/mRMEKRnoYCxzzhJGkT9DzTfKKfqWemxWSazU2WP09tBG+/aC/Nv3XruGBzyYibh2Jx2iG/ELN+HkImIgMg2gc4jGGGU=
Received: from SA9PR10CA0013.namprd10.prod.outlook.com (2603:10b6:806:a7::18)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 21:50:39 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::84) by SA9PR10CA0013.outlook.office365.com
 (2603:10b6:806:a7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Tue, 16 Jul 2024 21:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 21:50:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 16:50:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 16:50:38 -0500
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 16:50:38 -0500
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <michal.simek@amd.com>,
	<tanmay.shah@amd.com>
Subject: [PATCH] mailbox: zynqmp-ipi: Make polling period configurable from kconfig
Date: Tue, 16 Jul 2024 14:50:37 -0700
Message-ID: <20240716215037.3667214-1-ben.levinsky@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ben.levinsky@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: fc97f4ee-6aba-4621-a609-08dca5e1550c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DcgcBKshXz10xCO0/YsrN/ij7XBDSF85715XnyK+V4uqsB0UiFHgKqSP9PBD?=
 =?us-ascii?Q?Giue3iGafv3PaHuRiaKEvIxXzCCL65ply6A1y9nWStrY1CRvahKO/iBmS2kY?=
 =?us-ascii?Q?4zQwaoT6sshNijO+zW8WghZ7K3sqcenYA/u5OirFglzflB7DAQNsBM+622mE?=
 =?us-ascii?Q?LvN+J53LcR4l/oPAa1PiUPj0HEXfNr69VrJkwVomm5ctbGYhPnr+sI/qAXRf?=
 =?us-ascii?Q?XuGeOPJi2LR+biNSglKTryAjVB0pPwxoA1QP87TRUyIQLq+WDFJNU8BPt9K1?=
 =?us-ascii?Q?WnTyHLI7KXWKKuEFJa/sUsQcYIq+KiP5l/Hwh+nIBQpZAmfWDh/HfoRVCbN5?=
 =?us-ascii?Q?GlE8PTjXT1lioZyviWzMbEraYARVbFVvzVD+VIehn0CecyWt4GRoPgd79NL2?=
 =?us-ascii?Q?AxxvyaGNBmns70Nkb1C3IZglijCB75D0LpoJHdv5jbOOQfpMu5WbtfOF46Gq?=
 =?us-ascii?Q?e4uTQFHpl1olnsdwfdxrRGF5+9n+5kPBz6ODwpQLCvbSjx0UsJk7f6PNSISz?=
 =?us-ascii?Q?vpBayAUg3+OKarFtDoRL3Ug6/bsf85OiUR07+cv8jDNn1iccX5w6rBvIa+gh?=
 =?us-ascii?Q?VqPoaPGWUv7Krsd9VLdlJvYWbcbiVWG4jEDNVg8Tcn3s2feY2/PnRrFnmnOk?=
 =?us-ascii?Q?g362cc3/czrQboh6gsklWwJwBE1QmO3Qj2gc5kKD1mTD5wd0cYU4JZXjEbvs?=
 =?us-ascii?Q?wIAck5/7JEF61b9WUp0BJ/pAkYjdTKmrGl9dR5O+bNM0YD/uNEJ3Zvny4zbW?=
 =?us-ascii?Q?vAxPKaMyJDQeEqduMa5rOs4IRFY2v80K4rXnnX+CzA3gRltbThPEHe9TzPfp?=
 =?us-ascii?Q?6IT/DSOnxvQzjfA6my1MiGZRWer3Q8GFGwG3djd3nnjvTn5jD3c8bRLEmVYo?=
 =?us-ascii?Q?jhagL2nIxzdErkiunpKnK70Whlk4XQNb2hkQo0b3adhvjmcmWd8ILfDmSslh?=
 =?us-ascii?Q?hECB1WvaV+KEPl49QZj6iQV9+UpWfhsM3gwYIQC9BwA1rZokBaYzDxgGL5aK?=
 =?us-ascii?Q?sZ2HvVyUQV2kr+MLrZXXo9x6C6oxsm6VE26OpeupxS5qA0kvWuQ0REwawlH5?=
 =?us-ascii?Q?pBAR3ZCKN4KxQQ9hBPAJYIYoMRDVmVd10uph3zVULqwIRPDJTwPnvIPQetRa?=
 =?us-ascii?Q?sSS+M11g1vmqg9ZyFRo042yWsE7hviz0wIVCtAAjjbUMdvf+Ix3mbPydc7rW?=
 =?us-ascii?Q?fIqec88p645vXDWnNrQ1Ron7wWwpYoynNUJcxfcsmZPUrM4Pe1fbEk2W9tR3?=
 =?us-ascii?Q?eivMuacX95Z0tdAFM1LLZqDDkZJgvQlDgpwnQJRiVqyIBdiu51CLAEmWJxcE?=
 =?us-ascii?Q?vV7I5vrxu6qyoDwvuq3IpTe0XfHYDZaJ4YFJBBNCzCIOD5PBWJPU1W7Qp1YY?=
 =?us-ascii?Q?B5OesugLKgm/TaJG7UgApu/1sQhkNxdBuQyfmGN1ISIwGabobt7CXaBM8peQ?=
 =?us-ascii?Q?awAUMGEXqYXC0NZfRVhdGhaJtj4wBRaP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 21:50:39.1947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc97f4ee-6aba-4621-a609-08dca5e1550c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005

The polling period for ZynqMP IPI Mailbox is currently hard-coded to
five milliseconds. To avoid patching this when modifying the value, the
value is now set with default that can be overwritten from kconfig
prompt.

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
---
 drivers/mailbox/Kconfig              | 12 ++++++++++++
 drivers/mailbox/zynqmp-ipi-mailbox.c |  9 ++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 3b8842c4a340..c87a92400616 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -259,6 +259,18 @@ config ZYNQMP_IPI_MBOX
 	  message to the IPI buffer and will access the IPI control
 	  registers to kick the other processor or enquire status.
 
+config ZYNQMP_IPI_MBOX_POLL_PERIOD
+	int
+	prompt "ZynqMP IPI Mailbox driver polling period"
+	default 5
+	depends on ZYNQMP_IPI_MBOX
+	help
+	  By default the Xilinx-AMD IPI mailbox driver has a polling period
+	  of five milliseconds. If this option is set then the provided value
+	  will be used.
+
+	  Leave as default if not sure.
+
 config SUN6I_MSGBOX
 	tristate "Allwinner sun6i/sun8i/sun9i/sun50i Message Box"
 	depends on ARCH_SUNXI || COMPILE_TEST
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 4acf5612487c..df540e2b9dbe 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -64,6 +64,13 @@
 
 #define MAX_SGI 16
 
+/* Polling period in milliseconds. */
+#ifndef CONFIG_ZYNQMP_IPI_MBOX_POLL_PERIOD
+#define ZYNQMP_IPI_MBOX_POLL_PERIOD (5U)
+#else
+#define ZYNQMP_IPI_MBOX_POLL_PERIOD CONFIG_ZYNQMP_IPI_MBOX_POLL_PERIOD
+#endif
+
 /**
  * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox channel
  * @is_opened: indicate if the IPI channel is opened
@@ -537,7 +544,7 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 	mbox->num_chans = 2;
 	mbox->txdone_irq = false;
 	mbox->txdone_poll = true;
-	mbox->txpoll_period = 5;
+	mbox->txpoll_period = ZYNQMP_IPI_MBOX_POLL_PERIOD;
 	mbox->of_xlate = zynqmp_ipi_of_xlate;
 	chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
 	if (!chans)
-- 
2.25.1


