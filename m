Return-Path: <linux-kernel+bounces-260252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3E593A505
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905791F21EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B4158A15;
	Tue, 23 Jul 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F6kKzLDI"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E015886B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756184; cv=fail; b=eQOmaVQueGzenlNMONBWALA0t+PAT698rBC/5QfasIdilrrVisiRBUQnWO+dP0GQiIjpX6JAve3VVDfGy2OZlGTamubyq1FGSq2o1FbIxdouWSezqSI3uqd7WMjWinpDcEv7gHT4PVsGJOLCbD7iSsbU3BClflGkiEBCaePNPvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756184; c=relaxed/simple;
	bh=QXLpnYMrQMugOH0wSMRXXzMvshlDJtv2OvcaSkbbCqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SC8F9a5MpgedAsUn15B7d4xt5hQWGoizzDXgbtOdjipAVBrTsJ8/NY9j6V2Gvm8uxs/UwCMpRt3G3L+iWh8LK4eRfTowsxpECBakMJ7LUssGSbwXEWTvkp7K+7WK3ctK9C01I5NgDEvc+mruz5wuXbLVAcDiUwOttUa4L98mldc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F6kKzLDI; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myMSWdfSBUJRjKyxwxPBlDD04+P4SvE0ImeAqOD9tj4Yj1nroIvjHVEJnlFykKAEBZEOmyHYq+qnHttLQ9QiQ8KIMXX6/UM7mfvBNUmQ6nncJxfLdij4W/F5ZLmFY4GEpFSFxsq7Nrp3yImzFu9Z1+vDX5AU/PXEnRiH2P27glqLmafEM3DqYU1ycKAUvuHnUiZyerpl1icSbvNvACJEpCe4uHmODz8wWJwscHz7cXDOT5v7UOUsNVwcnluhHqfOIRiQOnCmbvR2cpYVHlUzpzdPRANTv3ZaoZdE+z6FPdWsMmoAh/5h7vLHCShUj1P9Mjw1WCIJcGaFHSJmrCw1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abEkoVyCVlmnqZh0zy/ndC5u3G3HYVhEVLUPlH5dyIs=;
 b=lE/AVUDmak+qkCOiofeEF65LvmgS1/3sU5nQnL/T6ViylDlNpwFisaiPBIIoQfgYh7MsKx3tq3KigYV+dClAg7NYH/nkFgIpf/2PiTrPc/cZHanZvd/MTaPLwhJewaYwFS1YPfg+yxAE9hvk45rHQQNU10RGioKbud++SIYWNkOgMqq7UPqRKi7T0FDHMM1AKXZW+YFS34aZDaPKy4/1MfXBgyiO59cUUxrmLcpwYplrfiH0nJhKXyEJKpGjQQhNH797fNOB/duVXHoWLk25NLqAsYqDTq9yB5S6Hu78NEI632qXN0LoSAGrUdKaFP2p2ywBPa3qWLAosuB1nBQ0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abEkoVyCVlmnqZh0zy/ndC5u3G3HYVhEVLUPlH5dyIs=;
 b=F6kKzLDIjFC2+3EodXm/J68akJsFJxBmg2/cHs+73Pkj/fsBsP40RZ3ag2SMbhgud45wYAZFvKtX2QqfTTBLBIkhc1nl+OpZ5Pp6usv8PyA/dWtSRH1/Zygxt6dN0k9YCae6fBL9WF9HoaSmakS4BmlZGSErXYPceNDSme0rwA8=
Received: from BN0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:e5::9)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Tue, 23 Jul
 2024 17:36:19 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::71) by BN0PR02CA0034.outlook.office365.com
 (2603:10b6:408:e5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Tue, 23 Jul 2024 17:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 17:36:19 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Jul
 2024 12:36:16 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH 3/5] i3c: mipi-i3c-hci: Relocate helper macros to HCI header file
Date: Tue, 23 Jul 2024 23:05:36 +0530
Message-ID: <20240723173538.3493935-4-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: b7355927-4f2d-4427-ce95-08dcab3df63f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+pNieW8Xjo+pGMav/dVwTECNIYWiBctUdxxv8AyTshUy0b/ibe54UibJrN7?=
 =?us-ascii?Q?wFrQY2pLJ850UoopWnkvDH9DLrTBPg2ys8EkRjdYlenUg+cZsKM4K6qjJyQl?=
 =?us-ascii?Q?CQtBh8f4gg2VjlH7JIwoeZRQgQYMESZtK4xTYTSSkSt56nVQJUXRgUgoztDx?=
 =?us-ascii?Q?UQxSOMf6Lyu4g0TVZoQzBRjC2kWgzIuZLtNnam0UqPyVGLQR2KglwR7qiMQl?=
 =?us-ascii?Q?Ykr6emhJq4b3wMrvVO+qp3VldRxU7axNxsN7qnr6+aeuz+fA0SqEeTZxPhdw?=
 =?us-ascii?Q?rC2oVrVBNc+cDVuy6uXUfyALyzvW+6WkLRf5J8xzKLfb8fVD1skNUbu6FsfV?=
 =?us-ascii?Q?7lZnKan/vDeZFqIrbjKi3HWgZl/KZGu2z6jOIDQQIxkYIpoObzkRa6BxFXUS?=
 =?us-ascii?Q?pimlsauxChYzfXb4d9Q1LgxwWHyVIxGL0KocrYNw2H99AABkprbqrrAl/1uQ?=
 =?us-ascii?Q?bdYldeJMswlqOYLepffjr7GJKnwiLR+oTOQDgEAZSsvlZynl0Sr1AkblOQnK?=
 =?us-ascii?Q?zfBmwk49t6xMoT8JMcVVEwsFIDDdkgoskASidDFZEpM2l3LWLSQAltyVn+9R?=
 =?us-ascii?Q?+6768YK4uuSrDdcgkeIlGV51Y9LijhheAFAEI4pZWBZPaEDkY9szmUFfyEpd?=
 =?us-ascii?Q?UhvUCmo9JrjnG6X1EMgWuKiDslmRAEYpY8aAB4h7rqKsnLU+dx6xdpE4QraZ?=
 =?us-ascii?Q?MEKezNUK7ztnaMTWfhslRnqFFOec8nOsyUmRZEBh132P+cZe8DfGelzrdROf?=
 =?us-ascii?Q?tmNy3srLlO5UBTQcq+PXpUeGIdBrRDqyG+K8EB20/MeM4K0V9tUacW5gbeBM?=
 =?us-ascii?Q?1PrjnpUUWY4PCrXuBUhXVJKweIXQA/mWh6D1CPB8shKZhCamrka7zjXAVFO7?=
 =?us-ascii?Q?YxA0iRTrRil8UBy45XjmggjQGviacw5IPtNSStE7bIXmDuI9P1nRxEwIoaI9?=
 =?us-ascii?Q?dShIDxC5BJ/NbwsK5sPbHGezHIwIC2Nq649LFnirfuzoszSuAipfB6DnXYyE?=
 =?us-ascii?Q?+WmrMSlk66xgdB+2m0XFWTOuDAaLbIp0VCCUJCttglGDBDqSSC5Jh9UX/WVJ?=
 =?us-ascii?Q?YqOw0wIM5I3lokASlrBPLJxafxzb9F1PPAcDYu0052SpXAdBtfupVjkmjNiJ?=
 =?us-ascii?Q?rGeE1Tk/ytUH3XOMStY7g+J5c/fGOVpKPVqcJP0psc6iWxwnep8DXafrR5oQ?=
 =?us-ascii?Q?Ldhq/KbL3VoKnlZvhdNQMJ/ESRlI2blMdkqqM6+Br1Z5wJKLQaZlzcG7ap5m?=
 =?us-ascii?Q?YSHPi+JFflZOVYC/25FI3fgAwSvKUXLjf5ijUyZoCY3iu76yLPwI5+oCPwW4?=
 =?us-ascii?Q?LABrdiI7DLyXUlyJmnA6xsBxbS6hZ/KPW8ghdtgDxazgWEtyLzlH7FmBM17E?=
 =?us-ascii?Q?3RMxRKxLs5QllR0s6joyvLX7JDhZfKescCFmbQo7V7qG1c/WYMCO8n+LQltx?=
 =?us-ascii?Q?/K8d1OjoCcMg4ErTbdQ0TkwN/hvn1Fqt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 17:36:19.1874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7355927-4f2d-4427-ce95-08dcab3df63f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448

The reg_* helper macros are currently limited to core.c. Moving them to
hci.h will allow their functionality to be utilized in other files outside
of core.c.

Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 5 -----
 drivers/i3c/master/mipi-i3c-hci/hci.h  | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 8bb422ab1d01..ae5b1a144506 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -27,11 +27,6 @@
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
index 046b65d43e63..56361adbcc14 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -26,6 +26,10 @@
 #define W2_BIT_(x)  BIT((x) - 64)
 #define W3_BIT_(x)  BIT((x) - 96)
 
+#define reg_read(r)		readl(hci->base_regs + (r))
+#define reg_write(r, v)		writel(v, hci->base_regs + (r))
+#define reg_set(r, v)		reg_write(r, reg_read(r) | (v))
+#define reg_clear(r, v)		reg_write(r, reg_read(r) & ~(v))
 
 struct hci_cmd_ops;
 
-- 
2.25.1


