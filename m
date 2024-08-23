Return-Path: <linux-kernel+bounces-299085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F66A95CFEB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161A7287803
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AE7194AD6;
	Fri, 23 Aug 2024 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JXxRjtP8"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8B518EFC8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422861; cv=fail; b=idmBRBbMfSMXlM4K/g6sPoEo6p2ABKbYQv0EGXOCVfyUHLskTbyycibZQI+YmpMEwQrBKuSvdfPehDqNodWMBFNbi3oyVAqxYdrStyC1Blc+MkG5jkHhee2yerL1woCXiNvD8jcg4Iv582z5LyNZn0bpk0WhbHZneUzZA4ESM8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422861; c=relaxed/simple;
	bh=hOzzomgeiirUzzY/rIOgqqdhLeEHWcqBLfN+yjThD4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLo3d1Vwy8CNVxvMrc/5aUpwOEoAPSYEhY97/Qb19BFkcY0yivKQYGa2pDMDCJLRzuuAaMnnHTf/Td0EwHLxQurrMv3eUVbimMjzXu/fQXcXwMF4r0N3ZH1aBUcEczqE2xn4ZJYp/QIEmcgTQJJInu4OGvRYnk4dJIz0/kjqbJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JXxRjtP8; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag/odkmUQVzXXbVSRLd0lux5F8I6zRSwdlM6CzRG5BmDgR7fjAVEzPWENbMGmaQ1VYJniIEjJUVTY+qF0GJM5GDGM0DPPVDbg46ryVZUcfyUqVLXOZGKRo5AUxvMu5BDYgJUwc1hVpVT7dPnPAEhs3Py+mXV9PFjI3Q3uyJSykkVAOJuHwLSpwin60o0+60Rl05LboGC7I5TbqpeovfM+5yAgMBkkmQKR38YcWs6jBKF2XEsurHlYQz9dPDkO+eZXsG1vgPRKcYmw+077TF8Uq3jXGGlkU2QuhXWCObjNbYSf5G/cGvDH74G12H2m2DSUb6OIWZ96K1QiaqXouAmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrSocucoRmLTE8ScWqPj7g3GkvhEChjjPuu96aJWPGU=;
 b=vSPUT7VFcRyIiyqt6EaFcI2nAHcmtXNJTtGrJsD1/grlDwa+TFtw9Bj7qy6JdolKPArxDIC4vqVunnUakxk2PKYqQpi+ODXe6DFwog4nSVTpH2+9bRXDVdKqvV/hSsfY4PsUQVoksbeiWLQvqUNd3dz3pQk6oDXdI9rRlBlDoQW4syty+84OPNcbuMK5Orf1ILNb3mdSa1Yyiu6vbMwt2a81paNc/QQZzHCBCdsJQbsv4lCFHv/+mDWp61Q/e2b58ST63MxM6wrviDGpq8czhZhW7UF8Xz4OzeNp/R76xFq/tNxwExpdIrp+3SRanDoKspquPejqNll+v+/PbqHBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrSocucoRmLTE8ScWqPj7g3GkvhEChjjPuu96aJWPGU=;
 b=JXxRjtP81ODwFcibCZpWSpEMDDWHjNvPlIZns61sOoRd0eJhv0HXTGSXT6n/VgKhWu8Lr1sCdsWn+jlJJm7uwLxTxTnI7glizQTorwTmyO10xdgpkJgvBuMrtvLRUFOIvLokOyg9tmm30p4bvYEE5l+ja7zPRZX8ISf0j51F2EI=
Received: from BLAP220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::31)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 14:20:56 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::5e) by BLAP220CA0026.outlook.office365.com
 (2603:10b6:208:32c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 14:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 14:20:55 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 09:20:52 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the I3C Support List
Date: Fri, 23 Aug 2024 19:49:12 +0530
Message-ID: <20240823141917.692336-2-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6073d552-4e33-496d-a339-08dcc37ecd39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qIGWK8aHqP9pYpe6K4yWuGA3+Awq/BXBI+5OJUY9fdV+fjhUjZXRcqfHT1bH?=
 =?us-ascii?Q?3Be6H7k2bHtWXlMhbtrbpEAQAOya7Wt4ocY3jMy5Q6lwPTe5p7IMykxDQGxt?=
 =?us-ascii?Q?ci2MU0nuGbuEmTuvy5rKT562dghZxxpLnSZaDwU6x9DY1pLL8B687SnZ0Ts6?=
 =?us-ascii?Q?SngMAlX3B2b5q8zxCBN9JRUKWCnRzitQSYWyVyS/Vsq0Xd/oNb8x6sPT5JaJ?=
 =?us-ascii?Q?lYeYnwxk9tv7Z+53RUYOZ9c9wDnpLvGslH6D07/MSHVK1aRp8E4zBY6HcRj0?=
 =?us-ascii?Q?fbyx4O1mObBkGnpxbnndd3xIkAd7s/XTFfoBbQc/uT04JTA+/5MAaPi007LE?=
 =?us-ascii?Q?LdS35BdrUR2728mr4IshyDCK96rgBnSx4RUm3q913qS14TdUrCCUpnimOEot?=
 =?us-ascii?Q?tS04zI+h7oOprNrpVX8LL4f+mG/dA6eb1ubZEEheDgvqCounRS8Ik4IPbzF0?=
 =?us-ascii?Q?nN2T6flMhzzZZ/8YMarNHNV8yB6JdmKSDDbLLvUmDC9gm3p+pyknlfBFdtcB?=
 =?us-ascii?Q?uDUalshnFoawONaD+0k6JsVXu5lvd6XMfZhsUnW6ObM3DEovVSPb3u7DtUuR?=
 =?us-ascii?Q?ex6PxNXF5hU8xJXaaxpMHLFftYrbqyjnY0YTlZ0VWDG1m6ws2TumnGzNzq5P?=
 =?us-ascii?Q?ph50+WlmjHghJXUn23oSW0yRyrighk7qSRiMXI7oqbRdEkAE0NndmQ7BCYxv?=
 =?us-ascii?Q?KmZSRc1lMe2NNu8rqvAnVTma4+imk9+uJGMpDoGvdDs+dbjI5UlE4/RjcZFY?=
 =?us-ascii?Q?7LQhKMn0vpwsxoSb7KhAI58WJ2i8QP0n0Pi2fsUDhyLY2B0ayWS1r80qk168?=
 =?us-ascii?Q?8qKHkkQjq4ylTx1p5i1hiZ/+PulCWKP8vJhSTQWkuUUscfABjLKK6fNu+B+M?=
 =?us-ascii?Q?LsCfino1THh/AQ4PhofTF0gByClyol8N7RN/DZtpAfJgZXqwMnax8KirCNDv?=
 =?us-ascii?Q?+OZLG4p5pXvNqzIWATCdODkcy5BofQV6ddpPkJqzSvOZmD14UUoJSBHinvYo?=
 =?us-ascii?Q?z26fHeE1biEtDukwoMKWk4d2SAbMpmMue1c5bKxIFSBoYpEidzCCKyiMGcdm?=
 =?us-ascii?Q?Hu9K9AAdZ8WxnICclVx2cCkXHVQPFzyRlJKPHLOEAlE0tKh4YagUaAwOJrIY?=
 =?us-ascii?Q?a7h73i4oPxAZezdYTM1jXsuBrSpIYhxqqaXZAaoETK2laP/lMd0WZY7hT/f3?=
 =?us-ascii?Q?ia1ZC9B9VN+7k3USOB9Pm7qgd6OF2k5Y020HQDjIF+LxMuDIGA0MDe92+aYl?=
 =?us-ascii?Q?18Ihf9a1HsDgDv5JBoGNyJWzb57Xo0dAgQMErfrFnvgSrt/lcQ1jGlpaFUD8?=
 =?us-ascii?Q?skoZBjBq9Ig4Hp+ib1EQDVBBfk52Lkt5fpbqKcuTYwUBzIomeeEOvEDL0l1g?=
 =?us-ascii?Q?RfJsIzwpjXGxrNB4W1aB5UMr8eZ+LIPe1tgpKbttBljuASLRZVKw31etYX1s?=
 =?us-ascii?Q?jybWsZET8RJToM9uSsxorp4VtFQ0hUyt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:20:55.5076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6073d552-4e33-496d-a339-08dcc37ecd39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991

The current driver code lacks the necessary plumbing for ACPI IDs,
preventing the mipi-i3c-hci driver from being loaded on x86
platforms that advertise I3C ACPI support.

Add the AMDI5017 ACPI ID to the list of supported IDs.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 4e7d6a43ee9b..07de1cecfa30 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -834,12 +834,19 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
 
+static const struct acpi_device_id i3c_hci_acpi_match[] = {
+	{ "AMDI5017" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, i3c_hci_acpi_match);
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


