Return-Path: <linux-kernel+bounces-299089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A722E95CFF4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279061F21F59
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC95197A87;
	Fri, 23 Aug 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2LkTtnD/"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6F2195808
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422870; cv=fail; b=ScuwxOd6Y8xroprSMBwru6rFTdeUYIu+C9IH3CsYU0DBLro7IrVery9ypl2s6QszalBbiTpIGEXvjNK+Y4L1mxpou7SG6o4ewUNN1wN4bWp3RI8m+7E34QvpyXb1NheNLSNYsfLOKWdsp5nNk1WKThuQi/jwF74uo0R0XtD+/QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422870; c=relaxed/simple;
	bh=t3mHswyKf5xF95k8uN1RGE7hZN/ttsm9eaV3LKOxJLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efb6hZhe9JRCN0Ld1cBcvzMmYNT7ERaKOfe5OYseyw4Gwh12Dk7ARrPwj3uS5J6hTQBXfJBIe7W1EefqdzZb+H/MTZhnfRUbDTWgccVowtuTwar6x0z/LQHumDFhU4yle4ZCQY8xhielcSUZPrIL0T7S/IPKSnA88+h6r3IRAYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2LkTtnD/; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/j7BWJ9+flnHidT7kEi32wPRMRZKSIdLnOYru/m8TqmixFdm7RoSuqnGC0XdWwIA0EvAJhbHRPw2G7I5AbfbAY1R+X3wooHOmSN5M514BN00f5Fp7f9aFIXRicRqW/OHHdJGh6n3ayKEuihVREm1w0Sf8f07GudYThe3oyt3+f6MgAyM6wqxWfN1zO+gk/2TSNTl8c4MC5jYft6eo8th59RuBSY6MMb/8d1d3N5o0bBdflv9997gwPF5DUBdP26P9+nroTxYHGy9SztE9iTbxd3vNQLLsuxRSNcpox9CHprKxO/InueE9D4lC/fuvEcSFoI+m3zD5vDefyRYd+GmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdW0ZluYv0uTIXnmLUpn+8Gp1rCsUIqTvyQ3h36Yahs=;
 b=T3HgUvwuGS2qn8TqwWABOgdG33kgsiajv1Uikc1boTyGpUcwtbQkcaLvPlM+LaiQ6TTt7aNWAzDZtbpaj+phYk/50qO8TUp6bUi/FLGY4/hKjcoczA5d/PfXuZ4HNM52RSWcfk6RC82oXjcqcVnZIiE1rFrWppSxUjmimnAc5EV49YYtnUhPP7wiP9ggCBR6xQ3/0Ef9zIt9fsa9eSEnelb35/KA2OJC+FN9b/a8eT3IEzTdKqNfoLbsEc5Hz7sswtu2v4WfQyygGDgYThzP2GDhNvov6by9C+EO3DoJNMVhTLzqr4qqG5O3Nx3vzMNVsZ8iSLnAG8lYxgwf08xGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdW0ZluYv0uTIXnmLUpn+8Gp1rCsUIqTvyQ3h36Yahs=;
 b=2LkTtnD/LKP95vIVwfdo4o7zJR275CLAQHkkzsiCdrUyhLaWQBbH4bcFJ9nxSeP6/zVx8zMJtUMUqVRITzhzHp0h3CTis369TgNQSQHPETSCU3Nhh1yz4IaRl2gzdxK4bn/cAk0UUiL2sykI9Dt3Io0a4hkFTjN9INSgq4e/FMk=
Received: from DM6PR02CA0140.namprd02.prod.outlook.com (2603:10b6:5:332::7) by
 CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Fri, 23 Aug 2024 14:21:05 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::1c) by DM6PR02CA0140.outlook.office365.com
 (2603:10b6:5:332::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 14:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 14:21:05 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 09:21:00 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v5 4/6] i3c: mipi-i3c-hci: Relocate helper macros to HCI header file
Date: Fri, 23 Aug 2024 19:49:15 +0530
Message-ID: <20240823141917.692336-5-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a9ce0e-5858-461a-0751-08dcc37ed324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QF1VVTy668+gJbNgDuKAZkBa0uvfipPwS/hQ0nIHpHZBpMucUOUZwDR/tSSt?=
 =?us-ascii?Q?LgRe0gD5EhBt5TXZidqZbfhh+06Zjn4KCd2WFncQBDs/zs4xgSFs0XIVUqM4?=
 =?us-ascii?Q?9hvgDQcK3PO+w+mN0zIJgE87pXNdBmKQxqIK+WeLO9zbwGoxwxiABGSGugw1?=
 =?us-ascii?Q?gsWifBxQfawKk30Zq4RPZWN1EsZ5w8Pp0Sm4+pIKg1PEcXqhC28DL/CqqTcW?=
 =?us-ascii?Q?SlKEfILGNauJacQIIiI8hR6KaddjKSOuYYooRFakGk5jNOcMgk/7YokU5cyd?=
 =?us-ascii?Q?E9/0S8ouM9pqQvbY3MJwlavAo4P1wiETkPioZge6EQdFCPRWAQpr9kSt/mq3?=
 =?us-ascii?Q?vxtN7dwEqA63wgQcAlTFs5wFD2OoTRt5Tld1eXD4KCcljORYcnfcIsZFJFLr?=
 =?us-ascii?Q?isIiqqsS7wUBnpaUVzRpJY6bhW/7qp6RDJVzCORsoNtS8cxfcxR4wcUqLLRM?=
 =?us-ascii?Q?2Z4/abUvM+uB73bgPVPgzvGqTCHUb3kumN+XuKFWZvGd6iD5ddh72PUPm1iI?=
 =?us-ascii?Q?KuWrHN/W7C/dkW3r4xUZbpNC/XqvEYdS7feywXJrXS5c+GNPHF5VObNMjqxc?=
 =?us-ascii?Q?GaOwxOQZhlXyIWj3LGec3FTW0HBe0scf6UWwxtHvvxISIttiF0JP6W3QUfGc?=
 =?us-ascii?Q?2FTh273D9cvgrkbfTzTW1j1sCaWOJErthduB+KRc4Jv0TQU/B+qgJcq5ZOIG?=
 =?us-ascii?Q?i6ZjsgIyhTZJ7Rv+9nB9fB3ipKilT1c3SBlPQ3d9i9IbrPQbOHNxVECq6J28?=
 =?us-ascii?Q?eL3uJRQpEEYleqBk4ukGkCXhg97gaBLV884xWPfTIUKjygOajf5s/4reaOyj?=
 =?us-ascii?Q?a48lvz51q5mPl6ZNYyfAhIWzoQB3uYzhpl9H12JTa0GKCCfWTHYBA8u+gv6N?=
 =?us-ascii?Q?/TVfDUIJ82tAG6x2nQMLBNUeK8tXZhsaVUpvdxq9BDv+hndj6dP8FfTm624g?=
 =?us-ascii?Q?jcrTcfvmBaUXvqBYgn0ZPsX+xs1EaIRdMMbgAVHobFwElkbsvEUPTK66w1EM?=
 =?us-ascii?Q?4wMgjPWJB0Awt8M614fr+zfQDZGcLHaHVn3BxXlREaPP2v9RliBCjqRaFCpz?=
 =?us-ascii?Q?869GDNFhHcPkhm5OuYuf1KT+unLfmOJvByNb29YyeJmxWufKLhxFGf7XyCYt?=
 =?us-ascii?Q?XVi0AdSmrcNXzyrvBQs5SzeW2T4D6POrho0Pb5PFfSrQKhqarCtU0XWTmMeL?=
 =?us-ascii?Q?bhw0+oJBSOKJ8RhVQdYmXs5r7t7sUTIJiUQ53YbjsDO6ijyKLrPzmWJEIEy0?=
 =?us-ascii?Q?qbLso/Cz/vWQq/2pNxUv0WAK0l8pCFaHGJbH2svmyIt8xa4afD2D5OWcKboR?=
 =?us-ascii?Q?go4AiwVd7mOvkFuEK6GqHzwwBsF2GEGz5b/9gGq0PXXFo9tpar5zf4tgedPU?=
 =?us-ascii?Q?8YaTC3jF/ZgBXTqdNScQQlAs56sCeublc1vb7xvD/v9S9I3T2ofa3a7w7j9t?=
 =?us-ascii?Q?Bq0Ck8OoFslX8yaiZhqGhAQRxqmpnMm7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:21:05.4323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a9ce0e-5858-461a-0751-08dcc37ed324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075

The reg_* helper macros are currently limited to core.c. Moving them to
hci.h will allow their functionality to be utilized in other files outside
of core.c.

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 6 ------
 drivers/i3c/master/mipi-i3c-hci/hci.h  | 5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 03a63ad205ae..a64657ab5007 100644
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
 
 #define HC_CONTROL			0x04
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index c56b838fb431..76658789b018 100644
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


