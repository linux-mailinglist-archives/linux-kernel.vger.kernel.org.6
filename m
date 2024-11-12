Return-Path: <linux-kernel+bounces-405822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C169C5794
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781421F230BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BCE1F778F;
	Tue, 12 Nov 2024 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nT4cE7Pi"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665739FCE;
	Tue, 12 Nov 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414092; cv=fail; b=nnlGaeoKhJvvqfs5n16QTuTZQQIWy452xhjuTtdMquMDZR+za2SA/uQsOdCh0UJgagBv6eEhuJyDnGem4o+IpejPkuOR5VQ5vMap/oTWXot1vUNI2gMcCsnBb1gydxWt/ZGIahnhfoS9eqPofXZu2jivf/HVoR9/Aqg0wvtdXPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414092; c=relaxed/simple;
	bh=opf9xoSwVkd9enddMLfLPYW/U6T3EsHZ7pKEi6cRRng=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TeBx8AFk3S6BYdhKwZhxyw/UEn0j0zFm79135Y9abAJ2fXtbHzGBkWrXHkUb1enHV2sz0O7divT+f0qOc3536/2/FYqbj32mDwujRpQN95nvY4h2zdMMXrQEBOWx/4pkNUEgeFSe+23JPUM7RWb+t5HULvD0LTzHAkxX4xjlY04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nT4cE7Pi; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAkNkGdsmjIYU9AIR9yRglgjRgWTychIm6qPlJ3ilg10t0Y1xtcrnY99HZcDFEkLaRqKUz1k5UWOe8V3WHE/89XjCBmmUXPNZKctFr/TN6ZblqHm1s5vz0wbMYdgaT25clhqZ4LUwOR9vgPOBxNteqboCH6LukDZdUzoxV3NzxVWFXtmjsAllmtRw9cMhPCJ/gyNxxcPPtGPTsv3o8kdhRwsQ+XrZk/tGbZM5sC7Q75Aj6cElad2UpWdtaiylJKyf0t6W8Sht5UEAGD6xzfXHL3CffZReSHPVSQbjE+Q3fX0304d5rqtngTtU66GZonLxf6MJWyU7wDyHSNb5hB9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f/V1MkCiNfmGoQj5vM7qESCxryvHOrEVz5twWDY8q8=;
 b=hWfvcm5tfDD/XQqT5q1Khq9g8fhnNAvJtkzDewCNG8k5zVUeIbQ7O3ykb/Oozi67sIXtDA0hv0vaRNJpURRrJrngmrSFaLSaT7nQB3Q0YRc3Vb9IJSIe3l0I5HSStlKE/2MHCV4UtmjayHqbLB0XBgt4AWEGzX+rkFMXi9QwIKX2HjfKhiqXY41sLeTCaq39nI/N3TStcizoSuYiYAfR4LyQ/ZWuLX5i6gJUJB/vaDn46txhZERX3JwMWSJrmlBHJjKZTXt7QtzxEjeHXQTIL4d0ETKkw1kxYLEdFUbWy1N5cC4/fa/2wg4s+3QWmgRhMGxjHpbaQO7ESo3r+d6ebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f/V1MkCiNfmGoQj5vM7qESCxryvHOrEVz5twWDY8q8=;
 b=nT4cE7PiV/OMS4G65pRNehTZSOHE3HdcJGi1s/kirE3XChl4BUiCFmhvDuI8wJvvOS2JQvd/6805B6NdNGggodZHINUCYw7VEv/ejMSOu4rpQr/sbMsG6CJParGoEhXP92tR6m0oMhQfHtlUHYmejoh6EzpvWDsxGopurj/9rFI=
Received: from SJ0PR03CA0335.namprd03.prod.outlook.com (2603:10b6:a03:39c::10)
 by IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 12:21:26 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::c1) by SJ0PR03CA0335.outlook.office365.com
 (2603:10b6:a03:39c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 12:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 12:21:25 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 06:21:22 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-usb@vger.kernel.org>
CC: <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH v2] usb: xhci: quirk for data loss in ISOC transfers
Date: Tue, 12 Nov 2024 17:51:04 +0530
Message-ID: <20241112122104.120633-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|IA0PR12MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 119b3215-0986-470e-560d-08dd03148731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jcZSVT5Ii2sG4kSFS0EugIEqxuWsSPN/pY6mv99blzzSP/4p8yCDl3OV0FUC?=
 =?us-ascii?Q?ueE3atvYaAKKp2IBelyKoU0d62lVdrZfoaFDWrSnmkbuPzj1RzSgxGlq/p3c?=
 =?us-ascii?Q?fbwkYbco/L3L4Fghn6Jr5xqHa4Rks1R6MRz1FUH8BT/5OOmWD5NKVsLMiBBi?=
 =?us-ascii?Q?RcHmXAZSGriodsrX75BkdaAD327FpqLW37ih6UE/BbbnAS8vFZNTv3Cpuao0?=
 =?us-ascii?Q?KFeo1S6ksbFSJNs3S+zkJX47ey+GCoORay09A6hRo1iTMkfDaIxnFpF8Uk6b?=
 =?us-ascii?Q?+60qqQZugIdjEzdSDZKyeRcE9egkfDkv+BcwbyI1KxTcg1QnOIctmR3a6+xk?=
 =?us-ascii?Q?VEJCmMCCO01/wK5xcI6NHxRA/voa1gi0AMX9Xp7p7eYIwHBkF9w0GJoVgNQp?=
 =?us-ascii?Q?WpUTFd8b4BTUa/hPCzsipy3nxZF97zUE3Kbe4aN4BSPCG3M08kD9dIchX2lR?=
 =?us-ascii?Q?zFtu4mnOnk5S5J+iqyA/CI+oXmbKlftNczKJ/wpy5ldhIdAlt6aam0ocjHoB?=
 =?us-ascii?Q?mZWQvGromZptuT2MXMI3XP20OspnVr4kHcMLyRmHGONmL9KLAXqXDV8Dem7B?=
 =?us-ascii?Q?0d5ssC8VcSg8y6UkqLtCKjenZfXyWU0rs+IrJrIOvEjrmfnQxcLEVhGR1m3M?=
 =?us-ascii?Q?dqZGBpAqa/vlviVqxY352cdmr2spCr3OGysWR4KYse9bODBd5wnDIgKJjeSO?=
 =?us-ascii?Q?gF3ULLagIg5B9ftxTn25/nQRzKKIQtAbq80wjUQc/zIIBB5h+1jClXA93+tO?=
 =?us-ascii?Q?duWaxSYBdYCrqz0gYUxuIXZ1o4MKpopdbMRwwGEQYmaCoKNX9aLj1GsBgqD1?=
 =?us-ascii?Q?WowlHoJNN/NkVp4eQ9qMH8HNY4dzgYFQ09Z0hxzys9Rt0hNBLcb+NQBNUjpH?=
 =?us-ascii?Q?PdMQTY/OH5B0SOHHa5PLK5CzlBsMtGd447lyClNaei7/Nm8VGiwJ3N6TIOFG?=
 =?us-ascii?Q?WCNNLo75sRJXD1+XwDawUMICwCFQm9nKP4Z7tE1IhvrwHo3mT477SCVEXP93?=
 =?us-ascii?Q?3rAbwXtu1sZNDjX8/SAbmGwEFgWP843Q1QX+Rqm5uaJcdUGqcxKgeEtS3enm?=
 =?us-ascii?Q?34sa3vJzDkaysAF3Xi1Ies7UpV10LEPT6IJIR50MFVSrSHYuKjrQf1a1Omby?=
 =?us-ascii?Q?skmwUFyUad3pi4w1CEmJfKHU69Vr18w/iPoMaov//khWQCTKZgX5WxEPD3GU?=
 =?us-ascii?Q?qnithF2TdHaKlOqZ57NmLzHWj3dheDsVZSX4XScU3TL1+I/aY1Z2mNxt+LVV?=
 =?us-ascii?Q?V2oUBgdjz0nrFo+Os2hjxIluVXV1l/MaW7jsHR+kf+vGcQO49ZmCTLlkv3xR?=
 =?us-ascii?Q?/IZ0GvIX4E8ICs9h0hUF0x6bu/ITCrigMnrzqk0J9lVU90a9DFwA40kpcNK+?=
 =?us-ascii?Q?NqHiJUuPsXvLW4jrlV6No7v9zRUfVqlxks32QCOu4zWv7j9fHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 12:21:25.6052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119b3215-0986-470e-560d-08dd03148731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010

During the High-Speed Isochronous Audio transfers, xHCI
controller on certain AMD platforms experiences momentary data
loss. This results in Missed Service Errors (MSE) being
generated by the xHCI.

The root cause of the MSE is attributed to the ISOC OUT endpoint
being omitted from scheduling. This can happen either when an IN
endpoint with a 64ms service interval is pre-scheduled prior to
the ISOC OUT endpoint or when the interval of the ISOC OUT
endpoint is shorter than that of the IN endpoint. Consequently,
the OUT service is neglected when an IN endpoint with a service
interval exceeding 32ms is scheduled concurrently (every 64ms in
this scenario).

This issue is particularly seen on certain older AMD platforms.
To mitigate this problem, it is recommended to adjust the service
interval of the IN endpoint to not exceed 32ms (interval 8). This
adjustment ensures that the OUT endpoint will not be bypassed,
even if a smaller interval value is utilized.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
 - replaced hex values with pci device names
 - corrected the commit message

 drivers/usb/host/xhci-mem.c |  5 +++++
 drivers/usb/host/xhci-pci.c | 25 +++++++++++++++++++++++++
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index d2900197a49e..4892bb9afa6e 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1426,6 +1426,11 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 	/* Periodic endpoint bInterval limit quirk */
 	if (usb_endpoint_xfer_int(&ep->desc) ||
 	    usb_endpoint_xfer_isoc(&ep->desc)) {
+		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_9) &&
+		    usb_endpoint_xfer_int(&ep->desc) &&
+		    interval >= 9) {
+			interval = 8;
+		}
 		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_7) &&
 		    udev->speed >= USB_SPEED_HIGH &&
 		    interval >= 7) {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index cb07cee9ed0c..82657ca30030 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -69,12 +69,22 @@
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI		0x15ec
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI		0x15f0
 
+#define PCI_DEVICE_ID_AMD_ARIEL_TYPEC_XHCI		0x13ed
+#define PCI_DEVICE_ID_AMD_ARIEL_TYPEA_XHCI		0x13ee
+#define PCI_DEVICE_ID_AMD_STARSHIP_XHCI			0x148c
+#define PCI_DEVICE_ID_AMD_FIREFLIGHT_15D4_XHCI		0x15d4
+#define PCI_DEVICE_ID_AMD_FIREFLIGHT_15D5_XHCI		0x15d5
+#define PCI_DEVICE_ID_AMD_RAVEN_15E0_XHCI		0x15e0
+#define PCI_DEVICE_ID_AMD_RAVEN_15E1_XHCI		0x15e1
+#define PCI_DEVICE_ID_AMD_RAVEN2_XHCI			0x15e5
 #define PCI_DEVICE_ID_AMD_RENOIR_XHCI			0x1639
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
 
+#define PCI_DEVICE_ID_ATI_NAVI10_7316_XHCI		0x7316
+
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
 #define PCI_DEVICE_ID_ASMEDIA_1142_XHCI			0x1242
@@ -284,6 +294,21 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_NEC)
 		xhci->quirks |= XHCI_NEC_HOST;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
+	    (pdev->device == PCI_DEVICE_ID_AMD_ARIEL_TYPEC_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_ARIEL_TYPEA_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_STARSHIP_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_FIREFLIGHT_15D4_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_FIREFLIGHT_15D5_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_RAVEN_15E0_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_RAVEN_15E1_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_RAVEN2_XHCI))
+		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_9;
+
+	if (pdev->vendor == PCI_VENDOR_ID_ATI &&
+	    pdev->device == PCI_DEVICE_ID_ATI_NAVI10_7316_XHCI)
+		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_9;
+
 	if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version == 0x96)
 		xhci->quirks |= XHCI_AMD_0x96_HOST;
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index f0fb696d5619..fa69f7ac09b5 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1624,6 +1624,7 @@ struct xhci_hcd {
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
+#define XHCI_LIMIT_ENDPOINT_INTERVAL_9	BIT_ULL(49)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.34.1


