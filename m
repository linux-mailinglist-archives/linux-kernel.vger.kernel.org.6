Return-Path: <linux-kernel+bounces-299087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF2995CFEE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B501F21536
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF131953A3;
	Fri, 23 Aug 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UwnZUNLP"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC30B194C62
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422865; cv=fail; b=FPfYLRqZ+PYgl19HMXGE5SzccQEC6Lv5BaHHvMiCCQjBjQvLeBgb0VjxyQ87dbbHAWPRG6u14jJ+aBIBGw49SlWHPoPbEWRf2Ym6Am5ilfj2r5+Z2eqVM7N0cESllQ/a4yrfoy9Kt9K5zGEvY+7KlHYMkVUiJOT1XR8ND4hJyVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422865; c=relaxed/simple;
	bh=XGh5ZrT1QM81bInqkTD+TYO0a2ff4vRG2cVdlTIRZEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaNgX0hmrlOfbBjmsWbKVF2eWut32MQoNHSbWtShxBGWmnPnpr2xKw2t7qeGdrXbp9kQC3ulJZ+RhOnXq1s3L+LIGdKwQUxShzN8yI8KwJDhNapAI54AnkE/wEj8Op7V5sZK017V8oePrBtuOcCXidtnZeBJAtFDN7G1wMtqCf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UwnZUNLP; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs1ShQ2f+MUnlWidkI5W6HKpEiFEXKWBA6H0RnUHSKsH3jAmK17yoAjN/cTBAE2zVbbH0xZ/nmQdybyHePf0iysMb45/a/aCj0vg35FO1Ua1+Brm8aT9EbShjYC/aUpCIv5s8aAUAtTDOBPBHE0aOFVD4tEZYHQmue3zo0Oz2zelzBw9oyZwSFWts9oaTDFsriNyHIhYz910yAre3eOGA12MfXI93x9W5btt9ebNK5Y41pTUO8jvGcI+ldHmjKQ4Y0BU3iaPT47fGgUFuDxIAqg/IEhPjvduSTX4WhoakrBbQFgKKH2cCOy+btqN1ODf10Snj/jH1eJDAxymzFa2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=078x5TqlbMlFMajgTQWnSzSxWojU9nd09Hfcd3+SN+0=;
 b=o+vzHZIRBfguQdjVF20w3+A2xQ0EZZBlmmpF+DfeI6UA06tfkKJsxV0iI+P1BdcORshCDlTySLtO+kMMbnSKPdRkwgbroI5iDsQpRa8u6dWjMdZF1niR0ov9eW0TqAB2ynTMdfdPUBsY5R74477ZGypFqcIs2azN0rp7BqkwanSRkgldhKDyenhBR3ThJF9EM69wmOpKdamk+MhNaRFX13qLGmFqn1ETMf0IPz58mq3m/7nntH9QtzDM7ZGLeLy4UfLFxHmrnnIvcTZQM30WFmIoOJUwgQamvXhiP0ARTdbpsJfLdjRGdcEDybB0XmvnJnbnW771HkPvzaKtpstGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=078x5TqlbMlFMajgTQWnSzSxWojU9nd09Hfcd3+SN+0=;
 b=UwnZUNLPhv+N0gKc/Lm6W62aWKGMEkkScVjpLn1VUIpoAjj5mEzQfcaVCUTtJe9yLxBWFZLcdwaCUbKzmL61/boyJQpf3KE++s4o/dZNzJQVi+Kzv8xtuEV/Q3sEFmz23MYXvlQeUSYPQnb1wx/K+I4HJJUH3BMkMD1zsqjsdgw=
Received: from DM6PR02CA0151.namprd02.prod.outlook.com (2603:10b6:5:332::18)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 14:21:00 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::c2) by DM6PR02CA0151.outlook.office365.com
 (2603:10b6:5:332::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Fri, 23 Aug 2024 14:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 14:21:00 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 09:20:57 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v5 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO mode
Date: Fri, 23 Aug 2024 19:49:14 +0530
Message-ID: <20240823141917.692336-4-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c22fee-b10f-49a4-dad3-08dcc37ed00e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZDRPaaJCsYwu0s7YkaGEcc8jNCkcPv/BPyRpLOVx4G6ZW5D6Jd9kZ2tHi0O5?=
 =?us-ascii?Q?6zfKZRp967qI/K7A7rr4JxV6usVIQPuj9bSMcYNdB7JqH6cZzh4hOz/qMw2Y?=
 =?us-ascii?Q?MZ+hyZbPZxCAFFl6aQl/nQ1v2vYFbJd0UdWscsY6K2LUNB1WjdPaq0vL0Hb8?=
 =?us-ascii?Q?n7HKNKJpdonlizWYYXbTsbFz0QYb75fUmeuWv93Ckbj1imPPZuSF4TW4awKV?=
 =?us-ascii?Q?NrwPSCjepq1hE5/QfOuZRfC6cL6QEwTDfPkOUiX467YdW1LwEOetpjlhLxi9?=
 =?us-ascii?Q?0lWKks9uQcOx+z52P1XnZd4noUlz+0GKO7YubhuNMdT1jQnAeiiaCihQ1apM?=
 =?us-ascii?Q?HeOYuhFg5l7J4MAfiyCI/Ub9Asn0Ts7eN2Bve95UrCTcTHSgPyzC0blFHWPO?=
 =?us-ascii?Q?6ncnsM5mfIrW2I1moVvgJs2F68sgfAioQLgZ9OZGJueUf5JGa5iskLlHpqY0?=
 =?us-ascii?Q?FS7bLNjf+Wxf+3jeFQS3Brfju0ACzPFutaX29R86IoEkfqLarIbX6DE646aZ?=
 =?us-ascii?Q?QvioTXc00rfJbQNR+WUGXuN7Fcv0/uluByNzQPwajTbcfp/5PWDvRrIF7aTL?=
 =?us-ascii?Q?R5gd+QMEEizF0VRSNkzL0PIcmkov5CvUsRlpl52KjTMm/DdGfgSgr6+ll0G4?=
 =?us-ascii?Q?Gp7wcdPHN7iYr8kaoWnbnGc/840FJ1+VFYT4uofq1bm4tRE/hz3mu2wJz8uE?=
 =?us-ascii?Q?FheZg8VU6T7TjkdBulXj3ilgMUlONAZKV4FdCsGw73kF+9VYskLAY8tNWYkA?=
 =?us-ascii?Q?BiGYwcFKC1qcgo44SM42Vbo2tYfKp1vw64oCzn1cJMwZLq8u3uzQBe8nv5CO?=
 =?us-ascii?Q?ZRs9cHqjnduG7CMWBaM4KP7Yd6oH6AFKAyiQ3E9tJUhzcbHv6EowRFoPVNbE?=
 =?us-ascii?Q?Ab76E9q4prWYPRPIuUbYlrUIgMVrD1hfMxTN7wYezbGfWu4RsJHg8Y1k+m7s?=
 =?us-ascii?Q?4sl0IulT0NcbC2bGHndxkTPFOB885P1cl1l2DAQPt8RWmcHcKH6VgWau/144?=
 =?us-ascii?Q?HNb1QPNX4J7e9QtZah2jtvvrKRBzZOzKjbqospNC8HA+RwkdW+zhaGt6FRVA?=
 =?us-ascii?Q?5rlQ8croWPl+jtCWKWkSvGaLQFTZyyiTYIaVfwCfype5QhSTyun65iZk8lj2?=
 =?us-ascii?Q?BllxkZcf1jyPN1v0waaDw84kD45GsS/7hoCgcQwcLUndXg+/PqfCluO+hA4n?=
 =?us-ascii?Q?MvAjzq5V+M4myOxNZxelkMKZnGMQPn8OgoLH6puGD5i43cLBWGKLBkRDLiWg?=
 =?us-ascii?Q?xdaDtfwSidSw8WrdnDGHe3VXsDSqAGGRm6xqEQmtguv5cGMWED27MskcqwzP?=
 =?us-ascii?Q?aYgDCtCtjJ+lalIv7NNnTMy1jXjz4SXNN6BPsT2NegcEoWwXWLw+A9h5Yq87?=
 =?us-ascii?Q?10jpcSmemSSlU2waa/QjXwLOfO/QtNbenVN99rE1tblEOpO3PNJjFaHB7+e+?=
 =?us-ascii?Q?GfYj26LFmLVjGPliNVW2WQ7rwP4T1w0b?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:21:00.2760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c22fee-b10f-49a4-dad3-08dcc37ed00e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327

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
 drivers/i3c/master/mipi-i3c-hci/core.c | 8 +++++++-
 drivers/i3c/master/mipi-i3c-hci/hci.h  | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 42d2362d072b..03a63ad205ae 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -756,6 +756,10 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	pio_mode_support = hci->version_major > 1 ||
 				(hci->version_major == 1  && hci->version_minor > 0) ? true : false;
 
+	/* Quirk for HCI_QUIRK_PIO_MODE on AMD platforms */
+	if (hci->quirks & HCI_QUIRK_PIO_MODE)
+		hci->RHS_regs = NULL;
+
 	/* Try activating DMA operations first */
 	if (hci->RHS_regs) {
 		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
@@ -806,6 +810,8 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	/* temporary for dev_printk's, to be replaced in i3c_master_register */
 	hci->master.dev.init_name = dev_name(&pdev->dev);
 
+	hci->quirks = (unsigned long)device_get_match_data(&pdev->dev);
+
 	ret = i3c_hci_init(hci);
 	if (ret)
 		return ret;
@@ -838,7 +844,7 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
 
 static const struct acpi_device_id i3c_hci_acpi_match[] = {
-	{ "AMDI5017" },
+	{ "AMDI5017", HCI_QUIRK_PIO_MODE },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, i3c_hci_acpi_match);
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index f94d95e024be..c56b838fb431 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -135,6 +135,7 @@ struct i3c_hci_dev_data {
 
 /* list of quirks */
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
+#define HCI_QUIRK_PIO_MODE	BIT(2)  /* Set PIO mode for AMD platforms */
 
 
 /* global functions */
-- 
2.25.1


