Return-Path: <linux-kernel+bounces-540985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87F7A4B731
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786C816BD9E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE241DE2B5;
	Mon,  3 Mar 2025 04:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J2oL9KPq"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578941DE2BF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977058; cv=fail; b=sd6hlKmZekJBZXpgQmLIHpaXSIUR1NM8YIt2OGhb4Ea1nklJCYo3LKBqC7oEd9usAA40jJauWHGmgYhczmfnGZM+529Ipt6Ozz7pOS2nWk9rbb9gGwcEDU5w3NVSAW1UwCJMKeCQ6S/78akOaj0JXVExP0qDeQMi9bttJBuiW5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977058; c=relaxed/simple;
	bh=Uzbww88kDt5E/rj4OCeUQGTUdmktdatld64cE6B/TSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJmA9rrGfc3WTwbTnA6FfnS7UggtyVqR4IWO0Bkrs09SWBYHk5YrFmIykde6qNqhpP+1xHWPyKYXPCRVNHL2fvMTzHw/w4EItjuvV5Ha7g4ICci3kR0BWp5EATseqFdgngw+jbgqkDlx/1F2OVJiM/mvpWvPGCHXLe6fquz5cdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J2oL9KPq; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWnpnmIU1QZClX8akkptC+W90jY2psmSR6nlsfXYWykjGVHlBzeWHVBGTp+Hb0cVCNieFEGi1Wmu0oQxH7Sw6U4uNh3zQZZgx6oYSHEGRhJzS40OTcGPBVrVwmwW2EstQnj6LfSOvhsWb8Dngme6Ui6/g3+rzJKVAaJ2jbO/uESDUDsX+nIaGdIjTp7oaSKur64VG05grKBeoa3+5CACv3n6h5JH+jN59RQHPhmUuoUyeXRXxtAMUcRhJadMH11ChIjXoJjS13+8cynsfgqArm5Piq98kS6ByiKt59XJ56231sZTp3wzyEu+0WJMdmq8ujjKbHzqB6sHMRwFO4R+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noXVYckU+zlFaJNZ9RTs0xOP4Sd+Jlo52clo97plhxg=;
 b=CTsSvXy+GmGpAKIkHhDHzdRpthtXVV9WZp5KSZUhn7PNE1wu9DkCDtOd6bpwoKQFUIO7Re65fQDXH4QfMeksoPK+uqV/BTnz+LCbQqDEfnjx84IewsHw8OsntjeK3wKwx/gxj5/yT2QLxA3mnSj0j813vQSgQP1Exz+yG8sjZiLLlw9Wprajv4qVNOn+sMaTOboNQ7GU8iSNHOLYPnU6WZfHu6BD4ELtwtAWXIPjX87KDMGak+25PFVw2cMsD4ISSJ8UGDTTECXtcOuzE9ET+pm3AirdYkL54Bli5gDNhfJ6y6Rsdq9gAM7huGkS05ZQATFOsBb8UiNPS2PcUjBKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noXVYckU+zlFaJNZ9RTs0xOP4Sd+Jlo52clo97plhxg=;
 b=J2oL9KPqW0kd2Uvdffc3MrVUVEnt/cKu0oyHLhg+j3UBKYWJypCZn9MNQvoun/lwWaOAFGRH90WBVp/bMC48Cqb+bYyBVbV8qh1eQASbu9hN2ns36RsY54h9zkPGFwOqhYKQrhPVqVpN1zbXTlsk+VhmR2n/heJJuYN15tkFCYw=
Received: from BN9PR03CA0562.namprd03.prod.outlook.com (2603:10b6:408:138::27)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 04:44:10 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::40) by BN9PR03CA0562.outlook.office365.com
 (2603:10b6:408:138::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 04:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 04:44:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 2 Mar
 2025 22:44:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 2 Mar
 2025 22:43:56 -0600
Received: from xsjdavidz01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 2 Mar 2025 22:43:55 -0600
From: Yidong Zhang <yidong.zhang@amd.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>
CC: Yidong Zhang <yidong.zhang@amd.com>, <lizhi.hou@amd.com>,
	<christophe.jaillet@wanadoo.fr>, Nishad Saraf <nishads@amd.com>
Subject: [PATCH V0 2/3] drivers/misc/amd: Add remote queue service
Date: Sun, 2 Mar 2025 20:43:11 -0800
Message-ID: <20250303044313.679012-3-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303044313.679012-1-yidong.zhang@amd.com>
References: <20250303044313.679012-1-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: fe611fb6-7ea6-4451-87ff-08dd5a0e0a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3sUnh48t960boKk2ARcCFuqqOSCjEEuvHPIagwTOS9Ltf2+lCNEDqpm1JQFK?=
 =?us-ascii?Q?sfcmMtesfDw2sWRYcluhwNR9Yzpup6m9cHH73JUlUVCcKNT830ySxBIxR9U6?=
 =?us-ascii?Q?sTjsdAjb6Aov/psuWVM7yIwSV4kNxZbGW6Leg6xg5yybvdGCgUR3lCZmdwa+?=
 =?us-ascii?Q?aES+00pLEo5cbq8FfH6mUIsdCKDwlhmSy7/54iLlgpAmyHY8/EvcUvFlR8Xy?=
 =?us-ascii?Q?kpZcSCSN8Ns3KDAsJ/IP2akvQuQ87sFgZJ1hvO4TtMYEHq/EY2t+/uqplQIe?=
 =?us-ascii?Q?7wT5XPMIB5E1yDVplxLBq2W6HLTAq9DpCggMaoHgGuiK5d9ESg2Ux8rrMmFB?=
 =?us-ascii?Q?wePsYuPJ1kuOGd1oj6WjcO3G8Tt1JTjNXeaS5HHZ8sbNs52StjQ9yDFL7Lvu?=
 =?us-ascii?Q?1KcYzcaiOXyDJp5oVIXSqxyIC4OlfoZe+yXS7kxvTLvZY6b0PFer93lqe6UK?=
 =?us-ascii?Q?EkYMR7n6DhVRdIfuk/TAB2YaahKXESxZNvxXFg5KwDh68X/cvUGbmN8+qA4f?=
 =?us-ascii?Q?W58cgO5B/x6NCuwjVxjRN+IkDe3+Z5sN8ggfwF2Klixwf6Dc37CxyDFvKCFH?=
 =?us-ascii?Q?+QuqJvP00WPJbxby/5ckoi6TIUwC5IPJi2/haD//oL7ePYe0KlqfPmSo2BGi?=
 =?us-ascii?Q?2LZWjluN+XSMckVtM6wMzZCweBBxO5kGDziMKcv3Xti+D2+nqHok/KsQgihi?=
 =?us-ascii?Q?nnW7Y5GLesGpGm2eOstbQnZvgEWGUvWUxWaSz7Pb9HI8vbxFpiXCNtwZRP70?=
 =?us-ascii?Q?Xd2fUx4FEp9FRNmycjZk1nc/uRHPUd6fsaRPn8cQpERG05bJrEz5TwWxlP9S?=
 =?us-ascii?Q?eqbGI22smgEZXH6H1amdzV03PKq+LNMkuHbVj1nTV3Uqi5sPVB4mwifieZ5W?=
 =?us-ascii?Q?/khD/UlhwVlfD7oyC6KaiMYgfFc6idG/v22NwvsIaRQEczQhE/AfDI0Jia6T?=
 =?us-ascii?Q?JDRfZI3tunxWF7F7Zme3CgbffFBLJ0ELGNzLLucKj30ptqD16x+o9KJp6Z9o?=
 =?us-ascii?Q?+3ggf+Du7lJ9oYPeVrGrluTAQQIX684YFvSjfzFledaVDoDEegX1N8KMMoiD?=
 =?us-ascii?Q?PXFAnwWtjTCLvCzOQSXfwsW+JKOEnuCb2K33/HIuIuo73M2CYTzzxi9xFesU?=
 =?us-ascii?Q?R06cnGT0ULO1M9BiTYf6+QDOMtd8Qgjwmrq1Cka/lwrlF4JEbScfgErwh1X7?=
 =?us-ascii?Q?8kpuvAbXvDZRhNY2BmTAUAY1br4z3u14izHlZnSDYX4Q+NalsxnO2FP++Wcf?=
 =?us-ascii?Q?e7x1C31G1OXJ3XZu860SfXZLsrtGkGfh1cEOCt2Kktj0XtzCYTaKcVlQ47h7?=
 =?us-ascii?Q?YGPiyHSVAh4POBPmjW211MihaRFcSf+P5Zm16FIiqwoOTO9agwFZgbTEH9yf?=
 =?us-ascii?Q?VVg50DXCBDGebArcB5iu4xxpDR82i7+F6c7estIvUSVNueB7UjAfojqY0ouw?=
 =?us-ascii?Q?glZOvlcqXQ0zeuRQu13VnuDPIq2KoibukYTWnX7+/DjtBcBdGHTuSq1P6KRe?=
 =?us-ascii?Q?6kGH7WV6sOs9Z/0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 04:44:10.5822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe611fb6-7ea6-4451-87ff-08dd5a0e0a5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494

The remote queue is a hardware queue based ring buffer service between mgmt
PF and firmware for data and message transfer.

Co-developed-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Yidong Zhang <yidong.zhang@amd.com>
---
 drivers/misc/amd/Makefile                |   3 +-
 drivers/misc/amd/versal-pci-rm-queue.c   | 316 +++++++++++++++++++++++
 drivers/misc/amd/versal-pci-rm-queue.h   |  21 ++
 drivers/misc/amd/versal-pci-rm-service.h | 209 +++++++++++++++
 drivers/misc/amd/versal-pci.h            |   1 +
 5 files changed, 549 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/amd/versal-pci-rm-queue.c
 create mode 100644 drivers/misc/amd/versal-pci-rm-queue.h
 create mode 100644 drivers/misc/amd/versal-pci-rm-service.h

diff --git a/drivers/misc/amd/Makefile b/drivers/misc/amd/Makefile
index e3868cb39563..63879800a3e5 100644
--- a/drivers/misc/amd/Makefile
+++ b/drivers/misc/amd/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_AMD_VERSAL_PCI)		+= versal-pci.o
 
-versal-pci-$(CONFIG_AMD_VERSAL_PCI)	:= versal-pci-main.o
+versal-pci-$(CONFIG_AMD_VERSAL_PCI)	:= versal-pci-main.o \
+					   versal-pci-rm-queue.o
diff --git a/drivers/misc/amd/versal-pci-rm-queue.c b/drivers/misc/amd/versal-pci-rm-queue.c
new file mode 100644
index 000000000000..8c1aca442253
--- /dev/null
+++ b/drivers/misc/amd/versal-pci-rm-queue.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/pci.h>
+
+#include "versal-pci.h"
+#include "versal-pci-rm-queue.h"
+#include "versal-pci-rm-service.h"
+
+static inline struct rm_device *to_rdev_msg_monitor(struct work_struct *w)
+{
+	return container_of(w, struct rm_device, msg_monitor);
+}
+
+static inline struct rm_device *to_rdev_msg_timer(struct timer_list *t)
+{
+	return container_of(t, struct rm_device, msg_timer);
+}
+
+static inline u32 rm_io_read(struct rm_device *rdev, u32 offset)
+{
+	/* TODO */
+	return 0;
+}
+
+static inline int rm_io_write(struct rm_device *rdev, u32 offset, u32 value)
+{
+	/* TODO */
+	return 0;
+}
+
+static inline u32 rm_queue_read(struct rm_device *rdev, u32 offset)
+{
+	/* TODO */
+	return 0;
+}
+
+static inline void rm_queue_write(struct rm_device *rdev, u32 offset, u32 value)
+{
+	/* TODO */
+}
+
+static inline void rm_queue_bulk_read(struct rm_device *rdev, u32 offset,
+				      u32 *value, u32 size)
+{
+	/* TODO */
+}
+
+static inline void rm_queue_bulk_write(struct rm_device *rdev, u32 offset,
+				       u32 *value, u32 size)
+{
+	/* TODO */
+}
+
+static inline u32 rm_queue_get_cidx(struct rm_device *rdev, enum rm_queue_type type)
+{
+	u32 off;
+
+	if (type == RM_QUEUE_SQ)
+		off = offsetof(struct rm_queue_header, sq_cidx);
+	else
+		off = offsetof(struct rm_queue_header, cq_cidx);
+
+	return rm_queue_read(rdev, off);
+}
+
+static inline void rm_queue_set_cidx(struct rm_device *rdev, enum rm_queue_type type,
+				     u32 value)
+{
+	u32 off;
+
+	if (type == RM_QUEUE_SQ)
+		off = offsetof(struct rm_queue_header, sq_cidx);
+	else
+		off = offsetof(struct rm_queue_header, cq_cidx);
+
+	rm_queue_write(rdev, off, value);
+}
+
+static inline u32 rm_queue_get_pidx(struct rm_device *rdev, enum rm_queue_type type)
+{
+	if (type == RM_QUEUE_SQ)
+		return rm_io_read(rdev, RM_IO_SQ_PIDX_OFF);
+	else
+		return rm_io_read(rdev, RM_IO_CQ_PIDX_OFF);
+}
+
+static inline int rm_queue_set_pidx(struct rm_device *rdev,
+				    enum rm_queue_type type, u32 value)
+{
+	if (type == RM_QUEUE_SQ)
+		return rm_io_write(rdev, RM_IO_SQ_PIDX_OFF, value);
+	else
+		return rm_io_write(rdev, RM_IO_CQ_PIDX_OFF, value);
+}
+
+static inline u32 rm_queue_get_sq_slot_offset(struct rm_device *rdev)
+{
+	u32 index;
+
+	if ((rdev->sq.pidx - rdev->sq.cidx) >= rdev->queue_size)
+		return RM_INVALID_SLOT;
+
+	index = rdev->sq.pidx & (rdev->queue_size - 1);
+	return rdev->sq.offset + RM_CMD_SQ_SLOT_SIZE * index;
+}
+
+static inline u32 rm_queue_get_cq_slot_offset(struct rm_device *rdev)
+{
+	u32 index;
+
+	index = rdev->cq.cidx & (rdev->queue_size - 1);
+	return rdev->cq.offset + RM_CMD_CQ_SLOT_SIZE * index;
+}
+
+static int rm_queue_submit_cmd(struct rm_cmd *cmd)
+{
+	struct versal_pci_device *vdev = cmd->rdev->vdev;
+	struct rm_device *rdev = cmd->rdev;
+	u32 offset;
+	int ret;
+
+	guard(mutex)(&rdev->queue);
+
+	offset = rm_queue_get_sq_slot_offset(rdev);
+	if (!offset) {
+		vdev_err(vdev, "No SQ slot available");
+		return -ENOSPC;
+	}
+
+	rm_queue_bulk_write(rdev, offset, (u32 *)&cmd->sq_msg,
+			    sizeof(cmd->sq_msg));
+
+	ret = rm_queue_set_pidx(rdev, RM_QUEUE_SQ, ++rdev->sq.pidx);
+	if (ret) {
+		vdev_err(vdev, "Failed to update PIDX, ret %d", ret);
+		return ret;
+	}
+
+	list_add_tail(&cmd->list, &rdev->submitted_cmds);
+	return ret;
+}
+
+void rm_queue_withdraw_cmd(struct rm_cmd *cmd)
+{
+	guard(mutex)(&cmd->rdev->queue);
+	list_del(&cmd->list);
+}
+
+static int rm_queue_wait_cmd_timeout(struct rm_cmd *cmd, unsigned long timeout)
+{
+	struct versal_pci_device *vdev = cmd->rdev->vdev;
+	int ret;
+
+	if (wait_for_completion_timeout(&cmd->executed, timeout)) {
+		ret = cmd->cq_msg.data.rcode;
+		if (!ret)
+			return 0;
+
+		vdev_err(vdev, "CMD returned with a failure: %d", ret);
+		return ret;
+	}
+
+	/*
+	 * each cmds will be cleaned up by complete before it times out.
+	 * if we reach here, the cmd should be cleared and hot reset should
+	 * be issued.
+	 */
+	vdev_err(vdev, "cmd is timedout after, please reset the card");
+	rm_queue_withdraw_cmd(cmd);
+	return -ETIME;
+}
+
+int rm_queue_send_cmd(struct rm_cmd *cmd, unsigned long timeout)
+{
+	int ret;
+
+	ret = rm_queue_submit_cmd(cmd);
+	if (ret)
+		return ret;
+
+	return rm_queue_wait_cmd_timeout(cmd, timeout);
+}
+
+static int rm_process_msg(struct rm_device *rdev)
+{
+	struct versal_pci_device *vdev = rdev->vdev;
+	struct rm_cmd *cmd, *next;
+	struct rm_cmd_cq_hdr header;
+	u32 offset;
+
+	offset = rm_queue_get_cq_slot_offset(rdev);
+	if (!offset) {
+		vdev_err(vdev, "Invalid CQ offset");
+		return -EINVAL;
+	}
+
+	rm_queue_bulk_read(rdev, offset, (u32 *)&header, sizeof(header));
+
+	list_for_each_entry_safe(cmd, next, &rdev->submitted_cmds, list) {
+		u32 value = 0;
+
+		if (cmd->sq_msg.hdr.id != header.id)
+			continue;
+
+		rm_queue_bulk_read(rdev, offset + sizeof(cmd->cq_msg.hdr),
+				   (u32 *)&cmd->cq_msg.data,
+				   sizeof(cmd->cq_msg.data));
+
+		rm_queue_write(rdev, offset, value);
+
+		list_del(&cmd->list);
+		complete(&cmd->executed);
+		return 0;
+	}
+
+	vdev_err(vdev, "Unknown cmd ID %d found in CQ", header.id);
+	return -EFAULT;
+}
+
+static void rm_check_msg(struct work_struct *w)
+{
+	struct rm_device *rdev = to_rdev_msg_monitor(w);
+	int ret;
+
+	guard(mutex)(&rdev->queue);
+
+	rdev->sq.cidx = rm_queue_get_cidx(rdev, RM_QUEUE_SQ);
+	rdev->cq.pidx = rm_queue_get_pidx(rdev, RM_QUEUE_CQ);
+
+	while (rdev->cq.cidx < rdev->cq.pidx) {
+		ret = rm_process_msg(rdev);
+		if (ret)
+			break;
+
+		rdev->cq.cidx++;
+
+		rm_queue_set_cidx(rdev, RM_QUEUE_CQ, rdev->cq.cidx);
+	}
+}
+
+static void rm_sched_work(struct timer_list *t)
+{
+	struct rm_device *rdev = to_rdev_msg_timer(t);
+
+	/* Schedule a work in the general workqueue */
+	schedule_work(&rdev->msg_monitor);
+	/* Periodic timer */
+	mod_timer(&rdev->msg_timer, jiffies + RM_COMPLETION_TIMER);
+}
+
+void rm_queue_fini(struct rm_device *rdev)
+{
+	del_timer_sync(&rdev->msg_timer);
+	cancel_work_sync(&rdev->msg_monitor);
+}
+
+int rm_queue_init(struct rm_device *rdev)
+{
+	struct versal_pci_device *vdev = rdev->vdev;
+	struct rm_queue_header header = {0};
+	int ret;
+
+	INIT_LIST_HEAD(&rdev->submitted_cmds);
+	ret = devm_mutex_init(&vdev->pdev->dev, &rdev->queue);
+	if (ret)
+		return ret;
+
+	rm_queue_bulk_read(rdev, RM_HDR_OFF, (u32 *)&header, sizeof(header));
+
+	if (header.magic != RM_QUEUE_HDR_MAGIC_NUM) {
+		vdev_err(vdev, "Invalid RM queue header");
+		return -ENODEV;
+	}
+
+	if (!header.version) {
+		vdev_err(vdev, "Invalid RM queue header");
+		return -ENODEV;
+	}
+
+	sema_init(&rdev->sq.data_lock, 1);
+	sema_init(&rdev->cq.data_lock, 1);
+	rdev->queue_size = header.size;
+	rdev->sq.offset = header.sq_off;
+	rdev->cq.offset = header.cq_off;
+	rdev->sq.type = RM_QUEUE_SQ;
+	rdev->cq.type = RM_QUEUE_CQ;
+	rdev->sq.data_size = rdev->queue_buffer_size - RM_CMD_CQ_BUFFER_SIZE;
+	rdev->cq.data_size = RM_CMD_CQ_BUFFER_SIZE;
+	rdev->sq.data_offset = rdev->queue_buffer_start +
+			       RM_CMD_CQ_BUFFER_OFFSET + RM_CMD_CQ_BUFFER_SIZE;
+	rdev->cq.data_offset = rdev->queue_buffer_start +
+			       RM_CMD_CQ_BUFFER_OFFSET;
+	rdev->sq.cidx = header.sq_cidx;
+	rdev->cq.cidx = header.cq_cidx;
+
+	rdev->sq.pidx = rm_queue_get_pidx(rdev, RM_QUEUE_SQ);
+	rdev->cq.pidx = rm_queue_get_pidx(rdev, RM_QUEUE_CQ);
+
+	if (rdev->cq.cidx != rdev->cq.pidx) {
+		vdev_warn(vdev, "Clearing stale completions");
+		rdev->cq.cidx = rdev->cq.pidx;
+		rm_queue_set_cidx(rdev, RM_QUEUE_CQ, rdev->cq.cidx);
+	}
+
+	/* Create and schedule timer to do recurring work */
+	INIT_WORK(&rdev->msg_monitor, &rm_check_msg);
+	timer_setup(&rdev->msg_timer, &rm_sched_work, 0);
+	mod_timer(&rdev->msg_timer, jiffies + RM_COMPLETION_TIMER);
+
+	return 0;
+}
diff --git a/drivers/misc/amd/versal-pci-rm-queue.h b/drivers/misc/amd/versal-pci-rm-queue.h
new file mode 100644
index 000000000000..d5d991704d5c
--- /dev/null
+++ b/drivers/misc/amd/versal-pci-rm-queue.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __RM_QUEUE_H
+#define __RM_QUEUE_H
+
+struct rm_device;
+
+/* rm queue hardware setup */
+int rm_queue_init(struct rm_device *rdev);
+void rm_queue_fini(struct rm_device *rdev);
+
+/* rm queue common API */
+int rm_queue_send_cmd(struct rm_cmd *cmd, unsigned long timeout);
+void rm_queue_withdraw_cmd(struct rm_cmd *cmd);
+
+#endif	/* __RM_QUEUE_H */
diff --git a/drivers/misc/amd/versal-pci-rm-service.h b/drivers/misc/amd/versal-pci-rm-service.h
new file mode 100644
index 000000000000..d2397a1a672c
--- /dev/null
+++ b/drivers/misc/amd/versal-pci-rm-service.h
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __RM_SERVICE_H
+#define __RM_SERVICE_H
+
+#define RM_HDR_OFF			0x0
+#define RM_HDR_MAGIC_NUM		0x564D5230
+#define RM_QUEUE_HDR_MAGIC_NUM		0x5847513F
+#define RM_PCI_IO_BAR_OFF		0x2010000
+#define RM_PCI_IO_SIZE			SZ_4K
+#define RM_PCI_SHMEM_BAR_OFF		0x8000000
+#define RM_PCI_SHMEM_SIZE		SZ_128M
+#define RM_PCI_SHMEM_HDR_SIZE		0x28
+
+#define RM_QUEUE_HDR_MAGIC_NUM_OFF	0x0
+#define RM_IO_SQ_PIDX_OFF		0x0
+#define RM_IO_CQ_PIDX_OFF		0x100
+
+#define RM_CMD_ID_MIN			1
+#define RM_CMD_ID_MAX			(BIT(17) - 1)
+#define RM_CMD_SQ_HDR_OPS_MSK		GENMASK(15, 0)
+#define RM_CMD_SQ_HDR_SIZE_MSK		GENMASK(14, 0)
+#define RM_CMD_SQ_SLOT_SIZE		SZ_512
+#define RM_CMD_CQ_SLOT_SIZE		SZ_16
+#define RM_CMD_CQ_BUFFER_SIZE		(1024 * 1024)
+#define RM_CMD_CQ_BUFFER_OFFSET		0x0
+#define RM_CMD_LOG_PAGE_TYPE_MASK	GENMASK(15, 0)
+#define RM_CMD_VMR_CONTROL_MSK		GENMASK(10, 8)
+#define RM_CMD_VMR_CONTROL_PS_MASK	BIT(9)
+
+#define RM_CMD_WAIT_CONFIG_TIMEOUT	msecs_to_jiffies(10 * 1000)
+#define RM_CMD_WAIT_DOWNLOAD_TIMEOUT	msecs_to_jiffies(300 * 1000)
+
+#define RM_COMPLETION_TIMER		(HZ / 10)
+#define RM_HEALTH_CHECK_TIMER		(HZ)
+
+#define RM_INVALID_SLOT			0
+
+enum rm_queue_opcode {
+	RM_QUEUE_OP_LOAD_XCLBIN		= 0x0,
+	RM_QUEUE_OP_GET_LOG_PAGE	= 0x8,
+	RM_QUEUE_OP_LOAD_FW		= 0xA,
+	RM_QUEUE_OP_LOAD_APU_FW		= 0xD,
+	RM_QUEUE_OP_VMR_CONTROL		= 0xE,
+	RM_QUEUE_OP_IDENTIFY		= 0x202,
+};
+
+struct rm_cmd_sq_hdr {
+	__u16 opcode;
+	__u16 msg_size;
+	__u16 id;
+	__u16 reserved;
+} __packed;
+
+struct rm_cmd_cq_hdr {
+	__u16 id;
+	__u16 reserved;
+} __packed;
+
+struct rm_cmd_sq_bin {
+	__u64			address;
+	__u32			size;
+	__u32			reserved1;
+	__u32			reserved2;
+	__u32			reserved3;
+	__u64			reserved4;
+} __packed;
+
+struct rm_cmd_sq_log_page {
+	__u64			address;
+	__u32			size;
+	__u32			reserved1;
+	__u32			type;
+	__u32			reserved2;
+} __packed;
+
+struct rm_cmd_sq_ctrl {
+	__u32			status;
+} __packed;
+
+struct rm_cmd_sq_data {
+	union {
+		struct rm_cmd_sq_log_page	page;
+		struct rm_cmd_sq_bin		bin;
+		struct rm_cmd_sq_ctrl		ctrl;
+	};
+} __packed;
+
+struct rm_cmd_cq_identify {
+	__u16			major;
+	__u16			minor;
+	__u32			reserved;
+} __packed;
+
+struct rm_cmd_cq_log_page {
+	__u32			len;
+	__u32			reserved;
+} __packed;
+
+struct rm_cmd_cq_control {
+	__u16			status;
+	__u16			reserved1;
+	__u32			reserved2;
+} __packed;
+
+struct rm_cmd_cq_data {
+	union {
+		struct rm_cmd_cq_identify	identify;
+		struct rm_cmd_cq_log_page	page;
+		struct rm_cmd_cq_control	ctrl;
+		__u32				reserved[2];
+	};
+	__u32			rcode;
+} __packed;
+
+struct rm_cmd_sq_msg {
+	struct rm_cmd_sq_hdr	hdr;
+	struct rm_cmd_sq_data	data;
+} __packed;
+
+struct rm_cmd_cq_msg {
+	struct rm_cmd_cq_hdr	hdr;
+	struct rm_cmd_cq_data	data;
+} __packed;
+
+struct rm_cmd {
+	struct rm_device	*rdev;
+	struct list_head	list;
+	struct completion	executed;
+	struct rm_cmd_sq_msg	sq_msg;
+	struct rm_cmd_cq_msg	cq_msg;
+	enum rm_queue_opcode	opcode;
+	__u8			*buffer;
+	ssize_t			size;
+};
+
+enum rm_queue_type {
+	RM_QUEUE_SQ,
+	RM_QUEUE_CQ
+};
+
+enum rm_cmd_log_page_type {
+	RM_CMD_LOG_PAGE_AXI_TRIP_STATUS	= 0x0,
+	RM_CMD_LOG_PAGE_FW_ID		= 0xA,
+};
+
+struct rm_queue {
+	enum rm_queue_type	type;
+	__u32			pidx;
+	__u32			cidx;
+	__u32			offset;
+	__u32			data_offset;
+	__u32			data_size;
+	struct semaphore	data_lock;
+};
+
+struct rm_queue_header {
+	__u32			magic;
+	__u32			version;
+	__u32			size;
+	__u32			sq_off;
+	__u32			sq_slot_size;
+	__u32			cq_off;
+	__u32			sq_cidx;
+	__u32			cq_cidx;
+};
+
+struct rm_header {
+	__u32			magic;
+	__u32			queue_base;
+	__u32			queue_size;
+	__u32			status_off;
+	__u32			status_len;
+	__u32			log_index;
+	__u32			log_off;
+	__u32			log_size;
+	__u32			data_start;
+	__u32			data_end;
+};
+
+struct rm_device {
+	struct versal_pci_device	*vdev;
+
+	struct rm_header	rm_metadata;
+	__u32			queue_buffer_start;
+	__u32			queue_buffer_size;
+	__u32			queue_base;
+
+	/* Lock to queue access */
+	struct mutex		queue;
+	struct rm_queue		sq;
+	struct rm_queue		cq;
+	__u32			queue_size;
+
+	struct timer_list	msg_timer;
+	struct work_struct	msg_monitor;
+	struct timer_list	health_timer;
+	struct work_struct	health_monitor;
+	struct list_head	submitted_cmds;
+
+	__u32			firewall_tripped;
+};
+
+#endif	/* __RM_SERVICE_H */
diff --git a/drivers/misc/amd/versal-pci.h b/drivers/misc/amd/versal-pci.h
index ca309aee87ad..33f0ef881a33 100644
--- a/drivers/misc/amd/versal-pci.h
+++ b/drivers/misc/amd/versal-pci.h
@@ -26,6 +26,7 @@
 	dev_dbg(&(vdev)->pdev->dev, fmt, ##args)
 
 struct versal_pci_device;
+struct rm_cmd;
 
 struct axlf_header {
 	__u64				length;
-- 
2.34.1


