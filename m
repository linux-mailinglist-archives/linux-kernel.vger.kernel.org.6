Return-Path: <linux-kernel+bounces-260251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D441C93A504
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B360281A04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA82158848;
	Tue, 23 Jul 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jp11sr8Y"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C2113BC18
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756180; cv=fail; b=P64HH92C/xSVhRDdwUPDvbHAB1CGbufvu1LNdnv6mPiSm/E7w/BEFYz5EvIdzU0NRlmBX9Mj0vn0lN/JE/+j2UaXMTCkEBXWL+smZ5xw9zd1c3Rp3fVaqXw74EuAWD3CY1aOmKcyR1k7q+fUI8zAD2wIx+SHLFFjAEzZ8pDGTdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756180; c=relaxed/simple;
	bh=iV3XUw236wpqJ+Lt8sM9Ma3c96siQ04tJb7dFOKCw1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0caT6DVbAIj+E80td/8qn33Karl54hI59FjcZdKTEcEVpeclCM4SmzxtnSmeglFhR4BA6ShjgWfrBubP6Pr9n7NeQzp6XQ7CKuRz7de72U9Ba1A5uhqarY07lw23q/IKY7Z2WOK0+xniyl+T8RfwLcBCoPm1iyx4/CaSUvd/rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jp11sr8Y; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rujTyDbHt5hXHkSds3l9ZglH0zqIG3LTW+SdwGZIDEn2ylhPOTXDqxPG6aPydvuPdvPJLo+9GaEA1aVNkZpMBRJs3evTthe01kFQnhq/xChHFEAXYUaUhUezVhqx6P65nUBLj3Zj/rU8g6WpFwNjXy2/Ap/KjHE7HmY5ZkAEn310NHywtfAYvlMX0l4OdN+PEIvI/zC/jov60oxTPmnd178jFdY0ZVMc+DbahJibyZ63wQO/O7XKpeevxomFYSoVJ67BZwHPREQ9kdmvfsvzUXT2+I1llpvKxpVKwLvIEphon8XOvXNswpFCGkdqH7FFDFSXqpe/gnQSHpBoWQuzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMrvv5KaVaRLzkoKWn7MmSXd6PTY5shWek6qlzF7EXo=;
 b=m0HmOeBUon13w+TBDZSz5tKI73oTA+1/sKaVybtteLTy7TY1Fto64R5611+WSs8BKZLycnIL2vHDINEGR5K32RTj8xb031Q37sdyIMLfJOlpKpnE07sqXo336T+2mox+T20+k1S1K7v2xmPYEAaOHAoVCDmMGnFpnSUPQ4oXXWjfwAKPzhXNDVJFyht1nn0FI1scyqJzA8VRtjXQqIXbgm/oj2wptz7yDEGqNoOzqo77m8xiqdkYbv7rsWzzZo0b/oZ6PbFIzSAx3KKL/LlePA+qNO3EklppHLEA/YyoLzD7KiXanVdqQNV8HMYxG187jL5FnNUVrL8m4HGVOvINFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMrvv5KaVaRLzkoKWn7MmSXd6PTY5shWek6qlzF7EXo=;
 b=jp11sr8YjBlb4YJ1XoLoexnfp2N7gw9AJE9UDA6PZKkInIYq1Z3GeLXeq/ksTfmQRKkxDvSwOQJIxDrjXEddDk1IbHcTQaxlZge67uK27B9YyMRR3qWnccvdjXIZ9BuoX1sgM6v/uMfNqOB/n7isAAPU/pWyQIMH6LYJjhU3aPc=
Received: from BN9PR03CA0665.namprd03.prod.outlook.com (2603:10b6:408:10e::10)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 17:36:14 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::d3) by BN9PR03CA0665.outlook.office365.com
 (2603:10b6:408:10e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 23 Jul 2024 17:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 17:36:14 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Jul
 2024 12:36:11 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH 1/5] i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to the I3C Support List
Date: Tue, 23 Jul 2024 23:05:34 +0530
Message-ID: <20240723173538.3493935-2-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: c6beedfd-f2a2-4667-9d4c-08dcab3df36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jtKd+eEJdud9QksjNdyowTenHAGvuTZI9szFcAupjt8T3m/Bk0iPYaM+SkXu?=
 =?us-ascii?Q?I0wmHcEPpnmX7NL9lx3iqNXRWd3ULfK6tRI6yooig6m7GMQDauM1vkYl4UIa?=
 =?us-ascii?Q?POv3W2L9KVRLgfEj7ngd1/evpSDv+Ti5rc1B/JN9uDQhmrmfqMWiqkr1imqW?=
 =?us-ascii?Q?69sAIXcsKDfgg4joctcgt7/193yBhcEbbayUs5fMlxBkxaRKTatKM7WQ6qP+?=
 =?us-ascii?Q?OIdZ/bvjjfF6wdDo4AVwJQQljNt8IwFoTF0WRQ5MR+/OZwLoVbqwojQPQTCw?=
 =?us-ascii?Q?pVYQ4RB7TB9yDiTGvK/lDM6VBrv4fKXwFrtshDl+O7Xj2R0zGIUmCfZn5Rvs?=
 =?us-ascii?Q?sCu9yvIveG7GS8RwwfhqEqG39EX12NaCM0fDqidGRNxroZhNqoNajorB5k5r?=
 =?us-ascii?Q?t4rq+PDTfxRmYjftUMonvXjh7x67/SJLyqunWfOWCmWN+7etrLMaGjGweUyV?=
 =?us-ascii?Q?HxHwbw7DxUQ3wy3+IvStP+QPYV+oz4Q99pXZZZLox/jdqsXxV1cxkdxl/LNr?=
 =?us-ascii?Q?YOpA0/B1CGPXxRlhoAv3DJrxRfcfC1Ow22uBJc7paFR0vDnehYV2ettRIexp?=
 =?us-ascii?Q?mmjQX5xVZ/dWRiSif2cmOWcauhtYupSilG3obVnwcTIJPJzLLmgUcoT1+a0w?=
 =?us-ascii?Q?ANXkKHU5FOF42GhUebmxnTSzc6vLyB1pF/WEpmSonFPoUMYV4oNixvRGzrM4?=
 =?us-ascii?Q?OlEqYjVJIQ5L6p2/oL/zcHYJ+ytv1W0K4ar8rbGuEqZ2Gi4Mpzm1BtoS/rd8?=
 =?us-ascii?Q?1bYTmQXenlc53Izd0ah30Ji1kGVThR5U3Xam1FAcaBLvQCPZDicGBEQR+huF?=
 =?us-ascii?Q?AaJHnXLqocqM1vRMTAzcuYV2wGbCD1RQZK2rcPeHvKurOCueMWDlTAcgWNua?=
 =?us-ascii?Q?CTuv0zCy4rqyg0QNBEujhhizID6ICZ5aAUBG76IlX1rbe8n2UpnfWqx9kIER?=
 =?us-ascii?Q?FQH8MaJWHFy6WFfQer+StsEAPE9u+3hS5VMAYBciTuTlUGriR554IzKW7Xcl?=
 =?us-ascii?Q?N6h2uvd56bXTqfmN/5eFnqZoJFyTJYwjP3xpb80uhqIxUmQnRi6jRWnzNkPx?=
 =?us-ascii?Q?vyU8/QoPZ1KA10ZpWcOekwhg1ATpKOmycbHYBZIZ7EYRTgOuoN64F521vTNF?=
 =?us-ascii?Q?XCS6JMrU17w/SzTPasRa648iJqH0M4HokCIFNR0dlek+LPUAuOUDO6lrlQt6?=
 =?us-ascii?Q?OveBaP90wFwIEbWkokqP/QPaYAnwoUqYrBARmTLln12WyGLNicAux12+0gXQ?=
 =?us-ascii?Q?Uj0Ihuh8grnptEzUqibEnTYAe+Shnq+nmkhryKvOga5ulYvwEzMgUyXUpIO0?=
 =?us-ascii?Q?70la0LACiFAslnhQ494GwO0zhq6fh2SGqxDCMy1LsnhOIcaEmNSZJD6xoR3a?=
 =?us-ascii?Q?1ALxpKnTyLTwJNOXLE7zAwO6wRACYzeoHc0Io6V/bIafKCb7tfGYOjvodYms?=
 =?us-ascii?Q?JedP/OqOhN8sONeRdDZNrjzRnnSZEWER?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 17:36:14.3672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6beedfd-f2a2-4667-9d4c-08dcab3df36e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599

The current driver code lacks the necessary plumbing for ACPI IDs,
preventing the mipi-i3c-hci driver from being loaded on x86
platforms that advertise I3C ACPI support.

This update adds the MIPI0100 ACPI ID to the list of supported IDs.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
MIPI0100 is the ACPI ID as defined in the MIPI I3C DisCo specification.

 drivers/i3c/master/mipi-i3c-hci/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index d7e966a25583..dbc8c38bd962 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -826,12 +826,18 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
 
+static const struct acpi_device_id i3c_hci_acpi_match[] = {
+	{"MIPI0100"},
+	{}
+};
+
 static struct platform_driver i3c_hci_driver = {
 	.probe = i3c_hci_probe,
 	.remove_new = i3c_hci_remove,
 	.driver = {
 		.name = "mipi-i3c-hci",
 		.of_match_table = of_match_ptr(i3c_hci_of_match),
+		.acpi_match_table = i3c_hci_acpi_match,
 	},
 };
 module_platform_driver(i3c_hci_driver);
-- 
2.25.1


