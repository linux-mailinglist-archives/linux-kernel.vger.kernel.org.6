Return-Path: <linux-kernel+bounces-306492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C5963FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23ED51C2465F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7092518DF76;
	Thu, 29 Aug 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f/aSWceC"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453D18E02F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923081; cv=fail; b=DzLLCBAQnv6ZtCZKM75410yUQq4ZLofjgvxJf94oYGL+pdLNAdKwYWpmuTNFo+Vr0iGL7MaBa1fSimRjcvb1FJxoXf1mJir2WVwzM+1LQ1W44AgdYs+WBlpsmWFb4mQRUkmIzYFcFdLPJz/TLQFrlUCS3N2d+i2SmbWxeO2kR00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923081; c=relaxed/simple;
	bh=+pM2Z1/BB70myv/tO2hlOrnE/YijoV50wtxb90tIC1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrK4KFlUp+4WzvhVPtmI5ldwLRIdNdEx8+wwW1y7Xq94Zuy2XxOA9eTYrk9ItJiWOyE3XBLIsmptdhV0jMf7/OciPHxjFyb5mg3niLESt9vgiP9Inx0Z0n7KgXEcS+K/ql27suWPibPmuGHw463QDJmsE21VEtMZIOrz8ToyNlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f/aSWceC; arc=fail smtp.client-ip=40.107.102.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6QAlJ3Fs5xl5gLYmYmJSYJmaHu9XW4X7L1eeoD120CRIlZWN6lukLm6H/s4DxvD475/kigmoxSyKo5lo+Bm8v8NLLmc9xGhbrNo3wMKzzjP4NiInYmalZMMVMKpiuAqHmyVzNEQ9zSr7aJhfgwnVWJG3Wy/B7N/1wlMiExy4Y+nCnQzJCdbgveT6Dy+K+cNzqRiLtPIIxuZL3KyCDWEOtNgj228l75FkfYU54k/lny4xa53RRmT4ZKwwgIGYDZT0Krepf4BZFWkJAkCpbBkOSATGIdRnXFJQPCH0WbrP4Oyno2aed05CK+jg6l4WKPdjVItf4AejonNpa1Z3ObD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvej9JvHf1Qta+VxI8zXPBnnl6bwXcF6dwcKtcLK6SI=;
 b=U8NN97jI2gqYvPbJ/ej0wu9Ml6ZzO2XOaeiRP9ZKAYRHbwcwAIgIxMn/KOonAeVMdWiEkENBNAKl8PLWqLz1DQpuvv9nvKn5OdJJI1Pbi/qOdr8A4gXkmbzkmm6yAUDzGNp1I7r7aBDxejPObrlNuVB7esa9GMfec9XVPxpQptxVi7x+nR1kI4xECBnen8GIqt5XMHe9UvhncjbOQ+MrN80GMVfAYww/WIQST9rhwj0r7A6x57bsAe+lkZhJ35SH+dKTPaSLepvjQhGC3jXcn2UOzQ+Su3Ny3C1fYGUUqtN7x+cWjwBW0g6PpLO5oSxhQ0x75+P+9Koa9IHW/Hj93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvej9JvHf1Qta+VxI8zXPBnnl6bwXcF6dwcKtcLK6SI=;
 b=f/aSWceCGeRruiEQw17Y6I9vo7F5C+Vd1K7om3qHMlZs8oUSJc4squfB+wLKnTN8cPmRZF4Tc8ptI5w382bsiUNPcfQm1YSDhpeYQ1lyelddpdCWHqlBLQGz+uEpl3nm35NGhZn/3nK+AaeXHJ1zdWSeFwV54RVW54VPVNcVxxk=
Received: from BN9PR03CA0933.namprd03.prod.outlook.com (2603:10b6:408:108::8)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 09:17:56 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::89) by BN9PR03CA0933.outlook.office365.com
 (2603:10b6:408:108::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Thu, 29 Aug 2024 09:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7939.2 via Frontend Transport; Thu, 29 Aug 2024 09:17:55 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 04:17:52 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v6 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO mode
Date: Thu, 29 Aug 2024 14:47:10 +0530
Message-ID: <20240829091713.736217-4-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829091713.736217-1-Shyam-sundar.S-k@amd.com>
References: <20240829091713.736217-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9101fc-f263-4390-9824-08dcc80b77a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+uDt0rdoUH9lPq37W/thkBeaiobYjEm3DLNJhfB5Mx853uB5m7VvXvG/sqNV?=
 =?us-ascii?Q?3XT7lbTWwVXF9+WZxEvLmmWS+nCEsKXEvML3pbHqlHkI9+BaJjbuu/OL8N5s?=
 =?us-ascii?Q?qrNtxczIzgxbIh/T21wZBi+38g2awjyBSsANtc0Dvj4F97KMBbKj/MVHPyJY?=
 =?us-ascii?Q?dw9RkBFPeulmGYz5feF0B0TFVFj/d4QTXTXN4PO510KnFpqD8M+1G/Tc/FiP?=
 =?us-ascii?Q?9p0TWO7YuJQTIf79GnRctDrf9LmqauoLeC/tbR201mmbSrlCLuYzliB7rRT+?=
 =?us-ascii?Q?Tr2UhGlpZN9BPexUIdxJuOqATAu2e/I7U+Xg77lxHMfNdv3NQIODvY7vC1B2?=
 =?us-ascii?Q?9pH1iPkcC1OtuZBYd+bGn7YewNXVe7G67ZO0sdlNwQHWd+NPf4+5M433zXTB?=
 =?us-ascii?Q?QqyCDyydX9/je/QQ+1ilWTKqa9BR3xfjEFGdDOdeJ/F2M8aVhr9satPnXf6z?=
 =?us-ascii?Q?ls1EwHZgV1L2sEwadoRhgsUjESAOQH3+wIvNXZX4Rozv8fOkxpy+OriXKV0O?=
 =?us-ascii?Q?wJZD2T6DbdtTMr+x/vvOozuqxgbBkK7Rtdy4/eacODQi1TzWcYswJXhEv/4z?=
 =?us-ascii?Q?usk/VuVW/nBQE4VzEdPaNDIukmfUuth/wuHDUQxz9VgT6Q/oQCv6sEEuHRS2?=
 =?us-ascii?Q?GHZW5/IkVj8ClyYXAV9ASlngwbF3vKkSliQmzeb9YDD34jJaadskOaEjQfmF?=
 =?us-ascii?Q?vhq1Y5pzYSrffa8ccHTWodwLXcypQRkTE+DrBkzQ7vLpk1rk89/HJYaD7Apf?=
 =?us-ascii?Q?/gv8bztb8dEIR1+BDiLwRLF/epUs4r/RBb1RVsTb7PsV0qA3P/7RgNQz+3F3?=
 =?us-ascii?Q?OzWPf3mtpD1CqK1lJC+kSzHGETa8yKkrn8g91ikp1ttJcl8bGGE5R37qAz9i?=
 =?us-ascii?Q?kmfzREt9tGZfXjqHpx4HwwCyC4XhuLXUxPbPctPM4pQiMBmPZs/rPpuU6XaA?=
 =?us-ascii?Q?V9gjeAZohQLIqzPeiVlGry1FK1OYe/OL+CIKQBdRh2W4khx62ns7/gJHte38?=
 =?us-ascii?Q?e87Mk+WEZRMgRtsKrUsjYYss9GAMTjYa8SKk5PWwvOoi12dtgo2foOahP3lv?=
 =?us-ascii?Q?GYo9Xbr9kEptliR8ayPaq9MQNuVli38df982MlFcYqdFBYl54Qlt0K1ygBAz?=
 =?us-ascii?Q?HoqPmejBlr7YxWxmn7mE3Qp0hzz9cfu0Rx9i4xhyjiXy3I+TEidOWYbQhh7j?=
 =?us-ascii?Q?JjdtfUkfDk47hSVNi+VH9ReYx7kQsPmDpHoZfnRIDn/fLmFp794U2gx3Z3xC?=
 =?us-ascii?Q?xuwz+i4+2+TGbYYlpjJUock9aAZlcHNWPAjtq6XJdRJZaraWYadx3H8P1pxW?=
 =?us-ascii?Q?xqRyJMpiWqjE+3SltiSseHpKofXVKkUhj1GUGYyp3c3HdteM/Uhf4ZpW+7mP?=
 =?us-ascii?Q?RANwCIozflYSXj8wjZaZ1JNhZWAAHtFvtGhLo8ogiXF9ubcirXiJc27DtiTa?=
 =?us-ascii?Q?Z6DxrLC186Y3BwKL5pz4hxQuT+JIZNAh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:17:55.4935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9101fc-f263-4390-9824-08dcc80b77a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362

The AMD HCI controller currently only supports PIO mode but exposes DMA
rings to the OS, which leads to the controller being configured in DMA
mode. To address this, add a quirk to avoid configuring the controller in
DMA mode and default to PIO mode.

Additionally, introduce a generic quirk infrastructure to the mipi-i3c-hci
driver to facilitate seamless future quirk additions.

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 8 +++++++-
 drivers/i3c/master/mipi-i3c-hci/hci.h  | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index a6781cfeebb8..23abf91b277b 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -756,6 +756,10 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	mode_selector = hci->version_major > 1 ||
 				(hci->version_major == 1 && hci->version_minor > 0);
 
+	/* Quirk for HCI_QUIRK_PIO_MODE on AMD platforms */
+	if (hci->quirks & HCI_QUIRK_PIO_MODE)
+		hci->RHS_regs = NULL;
+
 	/* Try activating DMA operations first */
 	if (hci->RHS_regs) {
 		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
@@ -806,6 +810,8 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	/* temporary for dev_printk's, to be replaced in i3c_master_register */
 	hci->master.dev.init_name = dev_name(&pdev->dev);
 
+	hci->quirks = (unsigned long)device_get_match_data(&pdev->dev);
+
 	ret = i3c_hci_init(hci);
 	if (ret)
 		return ret;
@@ -838,7 +844,7 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
 
 static const struct acpi_device_id i3c_hci_acpi_match[] = {
-	{ "AMDI5017" },
+	{ "AMDI5017", HCI_QUIRK_PIO_MODE },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, i3c_hci_acpi_match);
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index f94d95e024be..c56b838fb431 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -135,6 +135,7 @@ struct i3c_hci_dev_data {
 
 /* list of quirks */
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
+#define HCI_QUIRK_PIO_MODE	BIT(2)  /* Set PIO mode for AMD platforms */
 
 
 /* global functions */
-- 
2.25.1


