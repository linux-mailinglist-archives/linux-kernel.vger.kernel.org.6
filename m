Return-Path: <linux-kernel+bounces-295594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B3959EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8924B1F217EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6905C1A4AB5;
	Wed, 21 Aug 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r3A1lAoU"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D11A4AC8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247397; cv=fail; b=ZatPbktBGAj3eHPojBXYBei5tYz9+d9+5NLPz1DTQWKGuhcow56+6WHBm5TuGOxLhg3rxrocZf4MwBMDCSwhB9JljCVxmxcAmaKuZr+qjFC/MZQq0fV6VMF98JiFHQfpiBbbyKivQYNug+xFPMJhKlSprkaROUoXV81VCSQmA3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247397; c=relaxed/simple;
	bh=peHjw42g2s165Z0w6H82I7JaymsPUb2eHFHb+jg/V+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqHN0EzVu/mBM9u626bqNLOjAcpYgXL6037uzFr5PhfmwiM2Z2fCyH0O2ohhtSq5cKvP5T/ZSR+6p/aH+jgp3fMldmtSJi+PFQd78k/1pBeNX3f2lMPUHqwESRy6HjkkZLI3xfmrgKdUV0XYl8EfIUMeRr8l03dLWFXdw+siqUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r3A1lAoU; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4rJZa1Pjyjn9W1Fi0KvhE7enWWDjW/4UP9Pr7gq7jpqURxtFOYZa5wxmXUkC0g6UuPE9UWYsqi+YleoH1l31Q1xGGasPkIsKBug8rz3dmLYt3zEjiCysRVq5SPDjjLFhz1yDejs3FrcmiQJn2WJhKJYaVKciaEfRSvPZFmJUhJiwqCT92PM4fXKPX8N5joMeQUqKf3MdGyuB6Tq1plaCf2xxDR6VPXLqMi/rTM7+gus0fiq1z1MLFrrwEIkx73CS7D7zUKeRBVgT+tXla/BfEBgKEKC5IQzNAM+cOrSVjkBzPmPiFMwIqnq8WmrqSr26eMtuESVGbjGRbRMfsLl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrkACrkJSCfrA89HtK87N21G+oA9tQzNZbJxm/EN1qM=;
 b=uW3IGfqpZp7EJ6dhjdQt+CLWsAJ/8cmEatOfMw0c1ZeSiukguKzGtdOkgGg8Hx1vOKxDEMYTwWhFmi3esRALdv4mkx06J3wwaEPSXEDdw9/ieBvYv2ok5B0WcyZNOE747cRBTXvV2uPOet27v/pc2mf4rAVhco/7EvpXWDc30WOHwkUw8dJdwv+7k08dYhUahpL247rv59Rl5cctzSVdPzZXPsTtzUqitv8IFhNHpOBYfH3l4I/3Mm+/okZRnAV81HV2+yPQIDfZidyPQd/S1z06UbSdu9LhuLikSfoKH2scIegpJJon0XETJ5S6HKkvxsjD/fegPwfTXsj4TE4hsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrkACrkJSCfrA89HtK87N21G+oA9tQzNZbJxm/EN1qM=;
 b=r3A1lAoU8a4cwUoX3v668YF60B6hxUib7uUaiQmsMtff7JDTx9e3KkVSRfuW7DuzhlfL2bbSTx+2aWU71v9enDWZdGgJ7I/3GqdKajfUXGFUUkskVSMTHXMeTfC7gEJb6asu6CduIpkz3rG8OSCSt6/TfIxnKHb5Zo1F5/HXFV0=
Received: from BN9PR03CA0125.namprd03.prod.outlook.com (2603:10b6:408:fe::10)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 13:36:32 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::66) by BN9PR03CA0125.outlook.office365.com
 (2603:10b6:408:fe::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Wed, 21 Aug 2024 13:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 13:36:32 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:36:29 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v4 2/6] i3c: mipi-i3c-hci: Read HC_CONTROL_PIO_MODE only after i3c hci v1.1
Date: Wed, 21 Aug 2024 19:05:50 +0530
Message-ID: <20240821133554.391937-3-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: d290cdb5-cb3f-4daa-2d0b-08dcc1e644f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gYQN5BkbTnXm39gpA3OCSXjvv2k7jrqxnyZtTq+2+Gv60IUm2kiUPEWqKULE?=
 =?us-ascii?Q?k5acSzdXVhvz+BFfLqVTKPXH1Ui0D6Ahd1h87IIYSTumrHJx/S7HkOj2aDdN?=
 =?us-ascii?Q?6kbV/lKlQ1cEucM3Y6Lm0M5XhPg2yu2Re/sDtqr9uNJQ82ryHqN159Pjuizh?=
 =?us-ascii?Q?LAP5dCoogbFf0OowQEPpHf2TYcr0H2IxKXHL81Uw3D7nhCPeaXkZ/Ez8awWN?=
 =?us-ascii?Q?75M6d924PCIpsSYCmIwm1+h0aCQgbIDQ/xrbMmWDx+9Xk+9AHPs0AGw4d7DU?=
 =?us-ascii?Q?TslR5uSNJgnPxgDQV2YdKeBz4677ZLXBuFQCrk9BUN7EJR+swJTiHCewpdnz?=
 =?us-ascii?Q?YuWTpNhIQZhpGgys4dfJUgTPneN3FbdIjr2fB3to12ufUGn+Z0irqtyBAIja?=
 =?us-ascii?Q?Lc+BhCXDOWjnzSSCPdGi9Ta7u3MNW2xhvP99yfhcpnF6pgLgB929EmvOlWNO?=
 =?us-ascii?Q?dbKThgSea+1e2OT3CoVV8swyx2jSo4X40qK4jtRwOWDq0gVML11poMJsCWhC?=
 =?us-ascii?Q?t/vdC5PaXC2TVeStT/OAMreSiLz33hzuzN9lpGDyVYdJBm0Qh5HqO9xwzy3v?=
 =?us-ascii?Q?wnnPnt+1oIh/sJCr9V6rUa5TDsxiRMeZiyC4vcN+mBwN/9/Mv3NwK8MVcfjA?=
 =?us-ascii?Q?XM36W8m/Pmhay2Ebmt7MYwS7X6OvQo6BDOnmRl/PLQiYN2ecmJejydN1GBWm?=
 =?us-ascii?Q?uZdgEFluH2IguTLIQIt9uWPNagqyUJHbaswRle55sg3se6WnqIivzpRt5w8z?=
 =?us-ascii?Q?PCceCGB17gjN4GbAkohFte4szU5Hw2jAjY9z3OYXU/xDR/YaVK+A3nuwHktw?=
 =?us-ascii?Q?dw5FQp6YC+t337OOuAc+xmISgXoNDYN+45xEGGuWR+NjaLRfyS8SK3i1Ltmg?=
 =?us-ascii?Q?oRT0z/dZsuJkCic4BFWQNogYOUSAvLZJNFKFvc0Q2CAjbJaizZJ09NAFXdNo?=
 =?us-ascii?Q?gWuGEM+YWg4rFkYYYGk2zJB8XPM3LMSeTYx3koxyHJLV5ql4FZh+uI+W6mWT?=
 =?us-ascii?Q?pob3GuoyZAJzoG68biPyB0gAjNZ4zlgdzHrv+jSfPeS2302ZFqdD2TVy4PJ3?=
 =?us-ascii?Q?6QyLFv4nhPd8bmQrC++PW828WsmWItgdfv3QoHYJgGeBnol1CE3dsW6o+1mP?=
 =?us-ascii?Q?IE/0dv7w0469QMvPXYrjrGFf3yaP79AlZ+h0Qg38ZN2OzOs47dSnEFpA54Xq?=
 =?us-ascii?Q?vTdV50BmhCIQGN8+Pvcgb8KHS+7VkvJtCX5qliqZoUIBNf8G44R5JJBl91LL?=
 =?us-ascii?Q?Kj5fjVaJ0JO+wF+tgRR/levu3NvZYauiuIr8e8yFuZ6Hlu4N3Duazz/l6ozN?=
 =?us-ascii?Q?GVZluvIG1ELfejZ8XljgTTG/rCF7B4i8N0J+R4mi7ZlRyjHKPZbgHfYzIPFC?=
 =?us-ascii?Q?3qA16OZcV4/jXwyDJGXe43hTiiPlf1tF2e99iQZlbcXSBLq4i3jVhgTwkrO4?=
 =?us-ascii?Q?kIjC/CzAYcTNLKH7WBHqCpUhcmZnP9sA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:36:32.2503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d290cdb5-cb3f-4daa-2d0b-08dcc1e644f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753

The HC_CONTROL_PIO_MODE bit was introduced in the HC_CONTROL register
starting from version 1.1. Therefore, checking the HC_CONTROL_PIO_MODE bit
on hardware that adheres to older specification revisions (i.e., versions
earlier than 1.1) is incorrect. To address this, add an additional check
to read the HCI version before attempting to read the HC_CONTROL_PIO_MODE
status.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index b02fbd7882f8..d1952a5619d4 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -33,6 +33,7 @@
 #define reg_clear(r, v)		reg_write(r, reg_read(r) & ~(v))
 
 #define HCI_VERSION			0x00	/* HCI Version (in BCD) */
+#define HCI_VERSION_V1			0x100   /* MIPI HCI Version number v1.0 */
 
 #define HC_CONTROL			0x04
 #define HC_CONTROL_BUS_ENABLE		BIT(31)
@@ -756,7 +757,7 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	/* Try activating DMA operations first */
 	if (hci->RHS_regs) {
 		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
-		if (reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE) {
+		if (regval > HCI_VERSION_V1 && (reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
 			dev_err(&hci->master.dev, "PIO mode is stuck\n");
 			ret = -EIO;
 		} else {
@@ -768,7 +769,7 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	/* If no DMA, try PIO */
 	if (!hci->io && hci->PIO_regs) {
 		reg_set(HC_CONTROL, HC_CONTROL_PIO_MODE);
-		if (!(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
+		if (regval > HCI_VERSION_V1 && !(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
 			dev_err(&hci->master.dev, "DMA mode is stuck\n");
 			ret = -EIO;
 		} else {
-- 
2.25.1


