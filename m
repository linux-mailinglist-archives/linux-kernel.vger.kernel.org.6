Return-Path: <linux-kernel+bounces-306490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06612963FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172DFB245C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007A718DF88;
	Thu, 29 Aug 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ze1yJJKJ"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138CA18DF6E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923077; cv=fail; b=h8p9FFGvRYgiIjLimtYCm1qYGlveCDgTv0RL3xvCmXukdq1+yiOCeYkWhGiLw3Ytd0VyPq2GQhF/6jk6JXVbI0slDMEl5FC62fZKRnLKKgK9ole8+vSv/dKYP1v/GFy1sLMvXK8UnOy00xnZMbvSWgkZVTwJqwIT9hd05tkGU5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923077; c=relaxed/simple;
	bh=hOzzomgeiirUzzY/rIOgqqdhLeEHWcqBLfN+yjThD4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0quMdKEy0w0XFT7e2Xtrk0Vk5FUYti4vyS5NBeUD+pCVXAu1d9S0mMSLtFHd99qEt8ortqLY5V6I9KocE9NPIW5fkJ87xyWJXktuXiAx68D267in7eDLiBEpgzwQ2mlv8LOjtqVmhwhyxITNbq1h9DE9cCgEdnEFgucuheubL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ze1yJJKJ; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPpmCYglYTYt4GbnFgzeSWiWPHRxYSJjxltOpO/fETv7Ltxw737OdbtiJBuwzRWF+Uc4EZ8bShpldo/3xcZb4e01qkFvm8x8AEXmjSQOudZwxSVgh2s/gifovx9ChJS1KJpTHj6pQ/DDCQwYGNmDgR9+5X8mRaPU+/N8Fn+aic+/vTJEvFWzLBA50bBOmQhpyUa1pygvbsn3njF3o16qhCFnE/7n7OYlRfFslkE14KZkAyeoG5VJ/5w6ao/GZ8/9683xJh5Ez8KFNchtKN6+8ImCjNbyH0gd0eYZerrPwlWn0rF70UUByNAAxIiOBZnXhYTLVZdSRaRkgaUJQ7xmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrSocucoRmLTE8ScWqPj7g3GkvhEChjjPuu96aJWPGU=;
 b=UT5lGRcgs64PT3LasHpRfjBgB/x/qeM00S2tdeRj6tMOdzcrvZRMH20/dnjRZUg/pBen98MBg+E3JZiVgxja7V1NrHbifc0KBF8wL7dmLcwcMJRZ3RQV3AMihw1rzrHALg79f4f6jfIx6BMYRrCPQKla6O8+s/yjuGyx+pFa7OzDwWOKl23QpElMgHQuNffha+LHzk2KIDjJp4FkaD/93ZNyQWN6/6OHoW0VFhVAEgxE2jugaB1bNXXs90j/JZL9jiDsS37xQfVQ/Gs2gHVbzakC0Y0oxYnpkjz9nwxvybJwLBsERgyn0XlYzRmXAO6h6T9FB+56S2kiw/z6J/Kvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrSocucoRmLTE8ScWqPj7g3GkvhEChjjPuu96aJWPGU=;
 b=Ze1yJJKJXiaiD/RguR8iHl1r8Hj7OlYB/AWEWCGpHNCf0Sv2fORkjCAK8cJURc7cg+0GoOQCahQqctzzKSk6+3nmye4pbdjWFgClsZ4I6LOO+sLOFokWHQyfJCoBTM/VdR5rqdH+EYAvF1A5AzNUg5wXZEsdr9TZ5qFKL+VqwYQ=
Received: from BN9PR03CA0941.namprd03.prod.outlook.com (2603:10b6:408:108::16)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 09:17:50 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::f9) by BN9PR03CA0941.outlook.office365.com
 (2603:10b6:408:108::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Thu, 29 Aug 2024 09:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7939.2 via Frontend Transport; Thu, 29 Aug 2024 09:17:50 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 04:17:45 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the I3C Support List
Date: Thu, 29 Aug 2024 14:47:08 +0530
Message-ID: <20240829091713.736217-2-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 297e6cd2-19a8-4784-8313-08dcc80b7467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oXqBjgLYxZWve2HWz4WgSdYJ6YMJRT8Qvuc1+r/bPNjhNNqdm96qMHnEWqKu?=
 =?us-ascii?Q?5nclWUVPjuSNyeQeyJnRUGG8e3rgP3VOW3syf9ZAJtpQPSdzP0+0fpgn2YPK?=
 =?us-ascii?Q?zEO57NxjfQdeDRjU3VsGAhMYNgDpXC+CtFXh+fuvXiL9wxMyRgzuMHL6WHvY?=
 =?us-ascii?Q?3N6HI9+P5wHURO1yL60XsxkUj/ePM6bTjtq7eEjGs05jbdbQB9cvX3B9h8Bs?=
 =?us-ascii?Q?oDxGsJly7r2deQh5AqdJsI1heF3i96xUnmGSes4rIOWidO8VsIUXeKEfLNi3?=
 =?us-ascii?Q?4/ZHlcg9OfrFL5xoAi8XmzpUVUNTtKqg4YtMBb2/yEymz731eZDuh8F9y7Lr?=
 =?us-ascii?Q?sctAxLtT6A0WarNeP6PKbDBWsI5GzNVdXLosoWj/OEK+7KTT3qNtnhMRjMmq?=
 =?us-ascii?Q?chte9oAgOvwuUEo/qhqyuN+33pRgiHhIVsg7M4Un1XzEL/W7AMLaAoCfwUZj?=
 =?us-ascii?Q?fRhVpCMOtpQvicZRreSKlOUfmXdszRs2HAP4JnSmwxUycL0oNzNi9Wqx+f5v?=
 =?us-ascii?Q?Gyt2X1BNVsWf9mIka6M2pjwd3uwvoD1Gjna8RdAisdN/peQGrW/y6SOu0rpT?=
 =?us-ascii?Q?rOWIo35kv9FAiNab1N/DXy6f78NUPPI9EgueV5TR4n/uwxHh7Y7FNCGjXnI6?=
 =?us-ascii?Q?ZdWpM2ELQ7mkw1MgQ+YpIVWal+jZlNGXEatd4+72We/5F1NMpdxwag7fmnWB?=
 =?us-ascii?Q?DSwQplD1wwVq1KJ8JXInc8HO9fDvWXqY+nlt/Z5IFLxabTs8xB65WNv3yi+n?=
 =?us-ascii?Q?sHjZ76fFTt9EpN4flm2/zIgY07o0gKn1ZPIZROEnxbxpsx2wtq9FZzFIVpQY?=
 =?us-ascii?Q?CPTkWBuZ9DuMFXyMk/N8pP3KJIKjNT0EiWtHCfsl1MOWM4WU/XAAPUW29m47?=
 =?us-ascii?Q?FkMBTPZ0rMSz9wDCfHbRkiq9nMwTyfHmMakkxweDibMdQb8SEW8XAActv/Go?=
 =?us-ascii?Q?UUJxpQhSadsAe3RKNXHCW7Enkd3//W77ZraqXtsedM0Tr2VFOxNnpU5Cv63c?=
 =?us-ascii?Q?xLUTK315n3awo980w0wVHq4S+MNLTSknKNS0G0ZxvvZ0MQuQyTK6Dllzrsnl?=
 =?us-ascii?Q?iNkK+WXGlbtSIiLt3FtjG4hbnGCLDoz66+vjLHoVm0lkQgtzfib9yGcyr1gR?=
 =?us-ascii?Q?LBkQJBX00MDztNizVSoieXyuMOxs8oA5KboA3t24UM0+CwK0RKo50uzZXoPd?=
 =?us-ascii?Q?DBJWIwIW29+R/H/V/OjfNEYGLBvREp7DeYMd4NDKfe7uXKgDUWNAlz69Z1wq?=
 =?us-ascii?Q?h8lxOE/ecXGdqDlfbuWlAudr6AkcSUvHfew2QqawraSEpGCZdUOlp5vV4CFJ?=
 =?us-ascii?Q?MD6Wc8hWDyx/SZZkVIoJbCIoMrE1cneLaWPbjuGKMTO2kLDNB79kt1WB7Y1t?=
 =?us-ascii?Q?bgPd0Y42c9dWPWMI+eSoZVX/Efy+8+cGgs+Cjd0Sf4wJSCpycM9CIw2/u+ex?=
 =?us-ascii?Q?lm7HsbK10P/TV1aQQhGiGNYRlKW4cQBW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:17:50.0249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 297e6cd2-19a8-4784-8313-08dcc80b7467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096

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


