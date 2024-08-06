Return-Path: <linux-kernel+bounces-275831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D800F948ABE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596B61F24B68
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86671BD01C;
	Tue,  6 Aug 2024 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="teW7+pvK"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990A1BCA0D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931158; cv=fail; b=vEAbrNu1TM4EDjxF53xpiOtRNH1eemSgcyiTWYZCt+DCQkGy3uZtC5hW+AfOrqQPW0lmPs43SYl44Vpl3QeoWaxoS8DvwUM4YsoE20fNcCWLj7Lj+nn9jkfcp31hUTbWxFl6pMdESkqmUdpJ/h9gI7JBxoty52ctShY51gOM2mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931158; c=relaxed/simple;
	bh=/UcjeCdQ5cXbXan9Ux5QyQd/5ucLR65rZBxPTyAeYCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaFZg2hKwiZ6/QR21mgUknsccXTfwrBGdCDLUrkH5s8iKBBFCFBRa0+BV74TeRPHP+7PlQSytFDGjRJ79+IzHP0sx/3qWVefdOXaq4XRFUExvpD31SxnO5h1jLgjmt+mzLOh5ef707lMv5/rteOl0WyxGIUAqwSo8N+X7BaBP54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=teW7+pvK; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLX/Z1yx6uRIcUbKeAmRnocZebFw/CDSUvu1LO88T34L244thmEgDYm7i4UZ8ywbzSVL+iU6LOQyGe6ga3M33sVUxczXJElH/P09k7nKrTJ01SVqkq5xi23uL3tMUdcLlG3lOSo25EvglPEZRTAap9NUDWVFK7hqaKOPLkt5qVVkpKSDOVwd38v7V5ooMzovRxUxH1IVsnUDoRrIHnYmhD7HMQQi8cCAAtEtQzrr8gw1/uv0Qpl1sjGk7jfrysUfSl0aA1tM5BeM/Wz6d+ohrOxFyNsMG31OZKTnpE7uqKTyR69ceM9k+4bNHHOEknC9yn1o0ddcZSADHosbHz4W+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyEJrgrTsFRdzf2iEC9xm5OzcqbgtowxN2k5RjCNlJc=;
 b=EJ7Sa7BE/TbaG32QUR7dBUI6W9Nxlxt0qocsIWxCaF/4wgXv5Ch+1n3sk118ita0Xx5+Ix9Qmu6YMdsvOlbdJxdPFW3gO5KE8hObKCfBxUKjNj0a9kjshX3v0GMJKSbYBhzezwDtHhnAaHYwBIQs55S6uP5Cx0x0kCmpy0yYhXd5BzoK4Iz3FG/mMsZNZ8yZqyi15OQmf4K0XAytKwcQ/1yECPBnolliWG9ZYe85SAAPku/3uIiNaFGodQlV93XGoGnkTn4j7tQz2GOuglRqF3gh//yBywOO9soPqYt9QuLXCfI2A7m+sCdnLJkJHIP+A0Hr9FyciuEHx2RxE+RBYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyEJrgrTsFRdzf2iEC9xm5OzcqbgtowxN2k5RjCNlJc=;
 b=teW7+pvKqMDK6DZbbjAAngvwxIYUmtdMV+Vi/D8lnmOdp2hjncvcj9baY8F2MpgtEQUlSmmoHE9i4Hzht7SeJ/BLlcw/RZq3AEmtVvkbB3zrQCQPWRp/dGeGREjpNBlb14cbR3fIXLKfPtERXPuLy4wHmIbgI7lz+jMH8vH9ZOw=
Received: from SA1P222CA0172.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::28)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 07:59:14 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::50) by SA1P222CA0172.outlook.office365.com
 (2603:10b6:806:3c3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Tue, 6 Aug 2024 07:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 07:59:13 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 02:59:10 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 3/5] i3c: mipi-i3c-hci: Relocate helper macros to HCI header file
Date: Tue, 6 Aug 2024 13:28:41 +0530
Message-ID: <20240806075843.277969-4-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7ddbfb-9ef3-4fba-6030-08dcb5eda9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jXE2yJM0TxXo5ZAeBrjAtCTa/pw7/o4bX4kQCPlf6JnYzfLWmFSTsrYE5Z0/?=
 =?us-ascii?Q?rEea9ydjllZEYYsf8lLbgnTOjD0+lcCQeOU7PdtG8S6mYHa8dBYqdnYUM2rd?=
 =?us-ascii?Q?Hq5qzEj1Z0WDvXGahReJE73c/Z1Su5yWjwkdZe9LcCnQBIV2dmFJaVaS3Sfc?=
 =?us-ascii?Q?ARK8+Px5Aah29eBhq5+zMFqEEdW7KYQEclPNbVxu9RoBtOnT11+LvXoke9Ns?=
 =?us-ascii?Q?+dFO8swteClIRZua00VjoDFweYuuETBBNrqb3wLJrUDh3j4uj8ILHP+kRkJZ?=
 =?us-ascii?Q?Cl3DxYeqNZmCkNGl6fu55WrDqHR8RREifCbVzXzGGJeGIqiSfEgLOaDULLBK?=
 =?us-ascii?Q?Nyil28N9FGsEuq8tHRER4w0MSkvW6WLKPjshoikSD/yYxmua/dQwn65f26Xv?=
 =?us-ascii?Q?ebpzaDe71Ce2sMJSklJh/VPj+EjQkZTpABGhe39MR/OanNxDfmZCde37UOVZ?=
 =?us-ascii?Q?InE9rtPMJSxRMMjtpKf2dW96+sQUCSdcuBFhGk3rx1IY2su/lbd+xA/hpboI?=
 =?us-ascii?Q?oNMNA9FfqDu1TNvzThGioVnXbqHdaSdDaxZrMA8vGITF3e1+YPy3yujWnUaN?=
 =?us-ascii?Q?drOjSCTyS1ulq9+Fl4X3nJBIWXL1spWadppGY+l9Y+Tp345sHc+o1knC0Xlf?=
 =?us-ascii?Q?nFNiDTggvvf7gr4rVPm30Jk80QyNwWDxxJRxWW5FpbvhX3hKtI8PXMWwIWeN?=
 =?us-ascii?Q?mutOInIkiMyCcJ4HWjf4KvgcP2Dw+0aEW2L0PA0hALbdUU6YnksTHibsOPqF?=
 =?us-ascii?Q?mH5Z3THvqSs+P7BoPtTOcWi8C+EibSl2SHmAZV//DDEF5tzn0EyzZcMdA7Zd?=
 =?us-ascii?Q?fZMHFdj8AysxaqSA1pAElre9h9wX6zvz0nvcTXYs4YS+CRPwne8qh1h1PXdL?=
 =?us-ascii?Q?Jjh9DvkWQMECpWSL81v5yppNUGQ1EXv0Kk/fLkEOaQhPWwCOQGOXivLVRUPW?=
 =?us-ascii?Q?QJhM76LPD/blAnhG1VLj/HqMde+uRl9uh+a1H2a2RKeRLx+tL77u1jqDhp1+?=
 =?us-ascii?Q?WlKFDJF8LT+7/8QXW68i5XmeU95MML0jN51ZG8q5H8EjmyfRb2wpdtrjIBVg?=
 =?us-ascii?Q?AswCIAVClnxsVDS4vukGo9nNxoFQotD9BGvgknKvd9od4vy7zexLhPplXfFh?=
 =?us-ascii?Q?/w0nT4nbXYW1EtLtIMbwTSascT7kdxBASBy4+/ykW8+OWDkxI4aJjPiTX69W?=
 =?us-ascii?Q?rkUU7OSfr0OsB9SKFG5u+xfB7FjXtY6DGpmbFW2GdVVWPEo/LbDLx0VNJ7Dh?=
 =?us-ascii?Q?PH8m9I5IGJacKL3zpWzCe04sT2o9CrtzTiHITQXjRi1yjesI0OrZvj1YpZfK?=
 =?us-ascii?Q?MhA0z7pEYQ62ExjYaIOorWgLccFhbG8bfjwssUOkOuYue6RMCP3ap413jMBh?=
 =?us-ascii?Q?DBOr4P9dJa+Z8GkibqLgt7eFZyyurG1i5IZgbsuAXSEyY7dRs8AG2vJeMzC3?=
 =?us-ascii?Q?cbQ4MM0L3I9YF9tV9BdtpWC+hEY1nZvR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:59:13.9057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7ddbfb-9ef3-4fba-6030-08dcb5eda9c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456

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
index 7843a3ac2121..5c4fcb740856 100644
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
index 91e8a3833f3d..2b7560149520 100644
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


