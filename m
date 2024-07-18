Return-Path: <linux-kernel+bounces-256719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DBE93527C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29346282A07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF6145A1F;
	Thu, 18 Jul 2024 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d6Q8fGQ3"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF91143C54
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721335264; cv=fail; b=qVWMp12FiBtJEu1mObWl1sHB/IOTDLiY9LHZiKCdw1kt/MxWfJb28k68LoS27RQ7rKQTJ4a+OgfW0Pxf5E7LaCZhbKnxZ3kzMWaD3ATGaRXmcbsKtdjag/HoGqpC3GPCYMRNIq22I+4/WnM7gPe6A1AUq5aqCCfeIW2wKqkvODI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721335264; c=relaxed/simple;
	bh=xwg8UXUAdTBZCb1uk05qqd4TUELR3TVDYXUX5qGtekI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=owk++Azh2IdNArM8NGp/kXxTw3Wwj0kFBK6G98fCOD+RUToTmyQGXz4b+F5z7EjZJhOHKxoteUWTsfmmEuEXLDbaJDXZKM8Dt6lWgMe/rc5k+sKQluCZVI6G6TcvXz8EqeCPUM7xd/sE79OSaj2KibaV0n/akbnNuSm4K8vG0YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d6Q8fGQ3; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVbu5P25txReV/IF/Gi2xDpDChrt9AeblN/pjDnQCV3LU+nArE40WsU+8qGJ0J2VRRC0NAC39jNAmn1USQOPCXFqEzpxQfcoTlpFNlMIPZpsmvegElL/yUG1WWXJZLKmJLmpeWVuwhNrIl7XDkGzWrebF+2McOGnK/4B0WeeXa2l/roe/qSK5OP1U8ZGblt7O4kn9SxObBouBIAXibHZdfhe+4aQvsj3MhGKGBgaGDI/eCspfVrjZJgIkQlxIz6/ZwX2RPmcaTwpsGkdqZFyne2A/KgI1ZSuRWIcXADHcaGJH4YkFigbYKR/5PEpSkUTZcYmKifQdRpdQSWkOs4hlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQgqmU4ydfnWMQ06X1UbJ+AimtO+M3HPPGSXr+p1sLo=;
 b=BFDyHQ6unIyKwQaDF8S+Wiuy8WDklLCc+zUNmwt6UsfSvx1ZFHPtUbapCQBd4/I7cI2U0eBz8mqJKCIMcBOs4KEc6TGW4OIH0bI4NjaZasqe2+LjMf8zR6PQyA9PBIt5yFR99rjbDdJTgagOgnKKk0ljy68W+4PSdYZjeyzhE9FDugNRrHt8y0gC69IrZyY4EhCT0X+qUy5vUGpgOHf9TY017dSCmc80WRFOo2U/b3f8T2F8YLO5gDNH8G+nZIibwC1tYND31oUJ1xyHX8pmyMI3OfH1AfrdyGegC8HRGl6i3ZSabvBU5FLdfkhAzd/r9npaSg1sRlwnII/YVoAaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQgqmU4ydfnWMQ06X1UbJ+AimtO+M3HPPGSXr+p1sLo=;
 b=d6Q8fGQ3w6YQz7arknQtJyAeAb/nHQ34TzVuByVGnjeAlsMUr9UbF6EPpUzNLx9t17yK7R5Pw+xWHrV8J8tBzvIvCnPEolcspGozudxNlFNe3zctAGgmXRKkYdlPUKCfgjmjAeGiDnDujYhxzrtXVs8r8ifaC8QvMLTas1QHs6c=
Received: from DM6PR12CA0017.namprd12.prod.outlook.com (2603:10b6:5:1c0::30)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 20:40:59 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::fd) by DM6PR12CA0017.outlook.office365.com
 (2603:10b6:5:1c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Thu, 18 Jul 2024 20:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 20:40:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 15:40:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 15:40:57 -0500
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 18 Jul 2024 15:40:57 -0500
From: Ben Levinsky <ben.levinsky@amd.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <jassisinghbrar@gmail.com>
Subject: [PATCH v2] mailbox: zynqmp-ipi: Make polling period configurable
Date: Thu, 18 Jul 2024 13:40:57 -0700
Message-ID: <20240718204057.307655-1-ben.levinsky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e57faa4-e20a-46fe-047c-08dca769ee7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G/VCElyyEXw8F8sVDJ6ZElxxu0xX5+bM3VVCopnVv4U7xIMSKtnkXlBiVoAd?=
 =?us-ascii?Q?dpT0qRCCC8BBeZoPTprch4R6u4Pu86+EqrMieN7xJipuXwrC0ZHDEaqJx+bO?=
 =?us-ascii?Q?fNApiA5v8olIgm6XR/4LAUdssfnq3rs6a/Vt+45aSdoawntoC/fUe8CaYcb/?=
 =?us-ascii?Q?sIx/ipY/wtM1xd6swuNPNG6QXNgexX1Dt0qnRHzwtiDIGtvtpmTzzUT7hJS1?=
 =?us-ascii?Q?Y0QBjBPb2M/fAPBYp7911m+5qpS/mon+4J6zrx8mLsQWTBlHJCI6hSc5FyCj?=
 =?us-ascii?Q?wK7u8vDtxLMT2D8IM7KyXWiO0xTznkeje3jhrOo7wSr+p8rxyLxAPiD/L0g8?=
 =?us-ascii?Q?Jb/Uyg2kzF3mj+xqyfKINdTWwEoGZFLWvYm/YkiNOfxB29wf5J/SDt8UjC0f?=
 =?us-ascii?Q?/UlddNIu/rF0ptlYZuVqPJYot52b9ULDJfFKby/T0w3TkByin30R7FOZ6Pj2?=
 =?us-ascii?Q?0Tm/9ut+1ZnDZ6HoQ8p1qMv7yRuyAx1vA3bwNCaxJk5GRhA1wiGE8NL5fxA4?=
 =?us-ascii?Q?RE2+0Y5nyD+ASefa7bXVOQ4MLGD0RQckfLsU+weMJblbP15nLKYj3c+tzDnG?=
 =?us-ascii?Q?l13YR10LT5Xa+VLCh/GUbri+Wr5bOv3pkbks11mJZh5iw0GVWtUMOwrfPJWT?=
 =?us-ascii?Q?Z2pDZMM+WKTJrhReUy60WomMnvThFPloS1f/tdGRXm4HSr2Dgvvsd4UT3f+Q?=
 =?us-ascii?Q?MZZoC2IhG+r75MqqWKjDGtIAAlm5yXo1fjQJHcMs83vU7n/hvfWjT5x3ZLik?=
 =?us-ascii?Q?OBuJ78izOccaWK5+sMOkkbdDUfboGd34AUdEiHH6VUm3T0Q99OD6AMApdE5h?=
 =?us-ascii?Q?98JiyVG/h2+Gz5CXd9UZprvL9PH4sY/I11i7dYycZUdRkzQkkb4DaS4z0Lg/?=
 =?us-ascii?Q?R912A7544kbz+InJQKl6JeNXg93wVYlZ5dRqXjR6Aen8rIn3Z/54TGfZH7uq?=
 =?us-ascii?Q?oxvHq7Do3KygrFw3HEu/qWNuj2uNuUUGZwiLwqbJestRhYouRmek4gx4pZWh?=
 =?us-ascii?Q?+vhc6999WzaMBy5+FkyZbKsIjNQb3VJLZaQ1MjN+3zVhca5PrYF9HIkgBbIy?=
 =?us-ascii?Q?kIh+LozG43ehC6lQZ20TCsZYzLtPlrhTcL02vTj/l+NpEPrU0SMIQlhE/XxD?=
 =?us-ascii?Q?lEn198YUh/0LJZCt7Kv4/zwJhRA2PL3+PU4Cnj4n5zIiuR5S7sPfYi5WRoza?=
 =?us-ascii?Q?UglJFepTsztvU2bHam7rypNWv8WQgIhlYKnaGGJzNvowXnDjcnSBfIA2QbRu?=
 =?us-ascii?Q?TTkkQdyxvFkhvbKWz8Xj98nf6wgo2A9KOL8IZzNmUlL/FRmhTCvVsSaYyDnD?=
 =?us-ascii?Q?kcUNb7EQGurR7y4nEcT3S4Bgk63M81TY6X8b3pzgxKNxnY7KEEPIPquyQ9Ja?=
 =?us-ascii?Q?ecKgMG/OFekUN+A3AKAmVEIt8MehjgRmyTuAdtecnRJ88pp3OQrbxPIiBsR+?=
 =?us-ascii?Q?0epAvRDcppNvEJR8CaO6akE2WYg66tyi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 20:40:59.2311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e57faa4-e20a-46fe-047c-08dca769ee7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980

There are cases where remote that is acking mailbox message can take longer
than the default tx_poll_period value. Therefore, enable this to be mutable.

Added tx_poll_period field while inserting the module to set the
poll period for ack after sending mailbox message.

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
---
v2: Made param a module_param_named mutable arg as opposed to compiled option
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 4acf5612487c..521d08b9ab47 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -64,6 +64,13 @@
 
 #define MAX_SGI 16
 
+/*
+ * Module parameters
+ */
+static int tx_poll_period = 5;
+module_param_named(tx_poll_period, tx_poll_period, int, 0644);
+MODULE_PARM_DESC(tx_poll_period, "Poll period waiting for ack after send.");
+
 /**
  * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox channel
  * @is_opened: indicate if the IPI channel is opened
@@ -537,7 +544,7 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 	mbox->num_chans = 2;
 	mbox->txdone_irq = false;
 	mbox->txdone_poll = true;
-	mbox->txpoll_period = 5;
+	mbox->txpoll_period = tx_poll_period;
 	mbox->of_xlate = zynqmp_ipi_of_xlate;
 	chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
 	if (!chans)
-- 
2.25.1


