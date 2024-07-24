Return-Path: <linux-kernel+bounces-260692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFF793AD10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE4F1C217D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8983512AAFD;
	Wed, 24 Jul 2024 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M2M2lhnc"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8398120A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805215; cv=fail; b=Xw8LIPLO0m+4QRDngaYfeOAUmaxNJ4X8c5yDPWHClPcMYkXPcBaiR4ukCZDepHWltpZx9gEDEftjnopA0RHJcxiQXEtvJboGZ6XoaovJu4tYYDKNQmw+NTFjcUbKiiFMS+nVE0FsdlBJusgK/3giHSpBq+DW0EgH9eJmoeuy7rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805215; c=relaxed/simple;
	bh=UB9649sHokoKAla3c+Tp3R9HghJyd/QRwC1Khmnplto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeGMu64+WvyE7qMH0cRSx5m8Uiy433n0twCk1FIQk4EeRQPAfvEsod73DwGjmBRe2jonZG7ZrcEsBPQ9R6ienPMqmtdG4AE6Yakjxhngp0e5MzOnrZSISJ4/6zeKnK+4fWcszjjAeKvAZWNERpNMEN4I48oqslfUjqHuGT8FbKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M2M2lhnc; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUF1v/8hhYvwYzQ7k5KHRL7DWBLcJpch3ObGtXfns6j/ZosG71pUKaP0J9y6bqhaXw0qPP1zTQYIBRsUfSgsPEABhOUykIi02l95VHyj3joJq/EFomHYJiSYXyWbkFxTKx3XxM6+4bftQXOOpsxVe4vJalE/6cSQS8nWlsjU7QV+oprhdQD4EjnFSEabvyawLJPVXGwdGaVtE0JWirkrUkb5p2ftIqpDmMyvho9HksC1Szy5uYiEy8CtYN0Ts7UV8vduhu2gNhRhT5YzKprKda8PCZDc00TFZXFZouwXG4hm+3+mt1Xj+ahSnEDItr+G9peGiLGCE373VodksmNcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BX+ubpi5nc8ZdodDNt+PTNMYOgWjtHE5x6tQF/zgCs=;
 b=szBeYdJWh8H6v6Cddzw3tozw3v3rl3SBaxbprj4bUz5otUhgofyma6M6w143lKsshsW0GCf1yZUUTIAXMz2+eWNM+sRXd1vKCghhq013NECXzGhH9Q6Zg7g65+aj8JUeevhDBBWWPjEqu0hqHVLl57FR1Ndi3SDH3a7qSmep7mcYsWazQZ1qtKRPNqtdZ7QOMxt194m3hVWcgLXuJh1qw1qPEnhxQhg8u1A4EsYBRjilOelOpeta2NfmOj0tJLt0Wh3VjkHuPzHq3QzgpeAHsByKYs7jMmWC0uZursBYiGak2Y9MhuMbPHneBEaVr0ft3j13/i/OMK8nSja7QgP1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BX+ubpi5nc8ZdodDNt+PTNMYOgWjtHE5x6tQF/zgCs=;
 b=M2M2lhncFoWp70koVovoZ0rR4AEqi04N/Ql30UYkMnxZymytXfD/TcdBZdsUf73c7/XPxFbra/rA0Z/7egBEZ937gYfuD1GLsRi7IVk4FJwhxMiQjEz/CkpzDVC4OwQBZHQSfHozMA5vSEXJbaG1v3nNgvrGYSC0AoTZa/ryJeA=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.35; Wed, 24 Jul
 2024 07:13:30 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::6f) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Wed, 24 Jul 2024 07:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 07:13:29 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 02:13:26 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 3/5] i3c: mipi-i3c-hci: Relocate helper macros to HCI header file
Date: Wed, 24 Jul 2024 12:42:43 +0530
Message-ID: <20240724071245.3833404-4-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ebb878-3235-4f9c-b86c-08dcabb01e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8dmIFSTFe0LybAk2+Dv7TibLz0/Vzd9zIUJIZW+6zBOQedyTdK5pE3VcA/XC?=
 =?us-ascii?Q?QXEJsvc3c9eGHuN+PpsdBzMFTSzvRgE1TrGwvGKqWbdUH0btE6u8q2YCoADN?=
 =?us-ascii?Q?TWDy4S7R8X4SvROLrMv5c8+rAs1ZKuJrl13y/7e9AoUyaFO5G3bFP/f7PcWa?=
 =?us-ascii?Q?VZvOxc+tFYEphKbLsdJX9vD2z9vae29LRnDbObjOKn4qT7Jm2BPHyoSwwMEB?=
 =?us-ascii?Q?ikg0OUln/KHUZHfnef8rCYSH6nF00adCPOu9sLSC37dnjbIVJeHjlvFXEJas?=
 =?us-ascii?Q?T2A/PrRIz2+/Fz/jTdU2jUgqGDI/jOsbjNi7BVPLjmM/gIAvxC8BKTY42oEv?=
 =?us-ascii?Q?MYXqE8gUalMZIlnjQ9T6LjJMzyMFvZsh1I7EFB3JKkRdXuLSw1vjhJC8btS/?=
 =?us-ascii?Q?roYdPWgGt+j5HElaSCMCgLptUAQltXONIawZzM/mUb7kl/fF2i7jXI8Oe0nW?=
 =?us-ascii?Q?zu6Auzv396+9iAhkz9DD908emt638G1JMvAAalRaVFnv2wR8YmAIGD35owvT?=
 =?us-ascii?Q?3Fg521UmDmfozMK5shC//iOcZoWBwsN/YUIwpmQfzHr+NPES41G5qqEpDz7+?=
 =?us-ascii?Q?MDZR/rVYDuXV/DjeWgHpM/G/tQrjmGCxZ7+yOAx0pyggc9T00B1iWKgi4rUz?=
 =?us-ascii?Q?q+UroYPp43SGKwG79+aS/kWkrALojlLICEYe1JrJa58VQTYm8pE2P8Kwcd3k?=
 =?us-ascii?Q?XQ2bb0rAkIm5Cw8SQ9FJaaAk04vzN4WhshCUc6aD99/1TrMImYL6/0GlDevc?=
 =?us-ascii?Q?xQQKe7YmYp3LlSLcCAaeZXv9loo2cRo6AWCmjPFxSgZn1w8tLx3g7YfEDDZg?=
 =?us-ascii?Q?h//5abxg4/FA9509Edqsmz25NCCXf+t/mkN6cFJ7ebFitGoee5FLejOn4/Yg?=
 =?us-ascii?Q?U5mFuGWu84MrNqCKL5j/mPl1SSsQ/omD7qha2+fA8ymOtUoJRf+0s6nwW3y0?=
 =?us-ascii?Q?rAWkuKloJECsOgWkRvu/9qR3gCmPVUClp9gDIFzGd6UUZwJss+g+EkcgioWy?=
 =?us-ascii?Q?LdI+J5QWJSv0tj+N3ubYrScDguaiOk42uJ+Oy1l9XkTVsKkGe/qSFPDYjsuU?=
 =?us-ascii?Q?gm8xSCHIZ2GgNdrXvPNRusV1wiADekTyGQykzjVTXXjUtcV0jr8hzhqKAukl?=
 =?us-ascii?Q?nTP+MC11CdhJsthXjuDCAk1HzcNHyPVZ5hDOkwJ+zK8qwiPFTEjEMBj401Cf?=
 =?us-ascii?Q?YKMe9sp2rqa9RYZ5k9Zj4EdOUmCfo7Yj2e/R4cmZgSISuH/e5C98RZZK6Urx?=
 =?us-ascii?Q?/kWq6yiuzxqW4O4ow36LDSElCAFZ1nZUL4s/odB71PvzFPxCw4Y79PrEOOrg?=
 =?us-ascii?Q?ZI7rVU8tI4ddjzTU81OgfOKcja7R8R65u4GTrr56wMzYt2eWifZmT7m1tluF?=
 =?us-ascii?Q?KrgU33eB1BqcwanKS0QdamUe3G1iucz9NZweS2xYjx21HDfhE2IfT2aZSyQG?=
 =?us-ascii?Q?IJffdz5QlYWrCKbDxVNIQEnGZBKbTnv0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:13:29.2485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ebb878-3235-4f9c-b86c-08dcabb01e7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512

The reg_* helper macros are currently limited to core.c. Moving them to
hci.h will allow their functionality to be utilized in other files outside
of core.c.

Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 6 ------
 drivers/i3c/master/mipi-i3c-hci/hci.h  | 5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 8bb422ab1d01..ca9d4e2c80e6 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/i3c/master.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -27,11 +26,6 @@
  * Host Controller Capabilities and Operation Registers
  */
 
-#define reg_read(r)		readl(hci->base_regs + (r))
-#define reg_write(r, v)		writel(v, hci->base_regs + (r))
-#define reg_set(r, v)		reg_write(r, reg_read(r) | (v))
-#define reg_clear(r, v)		reg_write(r, reg_read(r) & ~(v))
-
 #define HCI_VERSION			0x00	/* HCI Version (in BCD) */
 #define HCI_VERSION_V1			0x100	/* MIPI HCI Version number V1.0 */
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 046b65d43e63..8e5af4e55de1 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -10,6 +10,7 @@
 #ifndef HCI_H
 #define HCI_H
 
+#include <linux/io.h>
 
 /* Handy logging macro to save on line length */
 #define DBG(x, ...) pr_devel("%s: " x "\n", __func__, ##__VA_ARGS__)
@@ -26,6 +27,10 @@
 #define W2_BIT_(x)  BIT((x) - 64)
 #define W3_BIT_(x)  BIT((x) - 96)
 
+#define reg_read(r)		readl(hci->base_regs + (r))
+#define reg_write(r, v)		writel(v, hci->base_regs + (r))
+#define reg_set(r, v)		reg_write(r, reg_read(r) | (v))
+#define reg_clear(r, v)		reg_write(r, reg_read(r) & ~(v))
 
 struct hci_cmd_ops;
 
-- 
2.25.1


