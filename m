Return-Path: <linux-kernel+bounces-275830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF1C948ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC512811A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDCF1BCA06;
	Tue,  6 Aug 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o2ZsS1rm"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFF116BE1B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931155; cv=fail; b=d2V8uY0XMOQWMRSRZfQ3XkmbRH6gLaWM3z4lUADwyDmZetSOWdFR6+uO2qSVcvKt1ki9AxvDCRZrJl09SuTCKe7s0GrRjvzzqqJWNe2SG0kmhKR4zOoDNdYHMnJHrtv1zb7BiVL9q8gWVP8jKjbaQtgMC4zjK8C4brqfKqKL+lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931155; c=relaxed/simple;
	bh=hOsWB36QY7uWe56AazeNBR0lhC67SaWmNMth+yBHlNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chZZCoA4ZNml66dKnhl8xlBPkojEX22y0fmFnqN6/hdP/qYoHD+7+DZ/GPCqJ8tAWGC03uEiRZ1W1+FeGw8c6pHYUHP/v1zU1bv+p+1vY/2g+PpZ+JoJL9sRKyn9fOAD/Lds8bGqDwCSNLEFD/gFO7uQ+6Q6i5smdvMFOJLkdCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o2ZsS1rm; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuhoN7eZ6S8B1QnkPkr66tHhgCibMjMvLMHsconZx59zKhynEPgnEk77Lb8+lnL4rBT1RV3aq6BSd2vkJr8YGs5xPWnfehENoeSDoQNpDEm9fJUokuQywlvSFyRnMM+jVQnj/znoEmdwsDotV/IzaUglOV8l7fhy+627juELN0M/Vp5Z6IxtdX+FrGdBaSVvGuTNSE26/4M78QfnS1e/Y8K0ZNLxnyGQfrk3c9I/AO0r8dat1PHidoDJkARvLfiZIpHKSvdQ4QQkWFce4FCPguxyHxWs1WHqT2vZ+tD0CMqPmn4Fn7d3wVW4vhVsXDHs9LdNuU7N5AcqTQsr6lOAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNHgjB00ALabz0gEfsFji45NSN6Xrmn1vzcUy+TLxm4=;
 b=iqymCE2KeomT2WhvLiiUQDmYApok/nB15rVONFBcuuHrfTNcbUSfWoXpvb6dHVnSnc8eAHoXv37QtmeIQ+utlPdQrvGtGLorTpyXHzG398oJkT68RBNNmdKrLpAeQ1tLxvkUZ5ZgaqDVpn3qXZIOadjTYUc9KZwGhbYqHzxCEyPVJR38+xPslcZvmTvi1C2DqiihJGNQYlznw1UOIA18STYZ+h5NVbRMXvsytl+CgyyPftT8d/SCdBYyXj+I2HQdkPiwUB8LLJGV1LrIM0690XT2sFjYvK8FVts65iw4i+0SNVpB6CnYjSmZTknWHcdXVH6Dy14/SKG3hTXgMckBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNHgjB00ALabz0gEfsFji45NSN6Xrmn1vzcUy+TLxm4=;
 b=o2ZsS1rmi4pYgBjlHhvtzo4nB5mmdqPasnNF+fLwyTWHBc/ZvF5bN7+CcYL1W5ovGfZa/c5n4kIREs2dS3hi0PE1qIGWJ9uRZwCr/HtrZAyWq577gqdgFRS6H2JcP9L8MgMmlDFmfgiHBWSd6i5D7p1a6ObMnmpiCc+HwzTF6T4=
Received: from SA0PR12CA0023.namprd12.prod.outlook.com (2603:10b6:806:6f::28)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 07:59:10 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:6f:cafe::dc) by SA0PR12CA0023.outlook.office365.com
 (2603:10b6:806:6f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 6 Aug 2024 07:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 07:59:10 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 02:59:06 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 1/5] i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to the I3C Support List
Date: Tue, 6 Aug 2024 13:28:39 +0530
Message-ID: <20240806075843.277969-2-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806075843.277969-1-Shyam-sundar.S-k@amd.com>
References: <20240806075843.277969-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cf5027-253d-43ba-a22a-08dcb5eda7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YhsBY+RaiSqTcwHFHpGXq6I21eCcnVE28UxfKV/quTjAV/9M7YoCOM7+8fQY?=
 =?us-ascii?Q?QlV1uYtETXxAeYtdZC+e3XjQk2ysNw+7aMy49mvU4/ygJaVExTXXsrUTVVgG?=
 =?us-ascii?Q?gvdUV6NOxlfUzS05EQ6RwPa5Es2yzb9ik7zwtHTuDdA6GSfU41dCn09jCXCg?=
 =?us-ascii?Q?mlGikoNXZKfG68m8qkVV6awcukCIX7HgTiKu90erR3EVu/P5IOM8ymBZb4JC?=
 =?us-ascii?Q?mT/8z+m/IkPPYU+EoZ0NvsV6WIcSiRGLQ/M2g1kTPnS/XewrM3tpYxlRTMrQ?=
 =?us-ascii?Q?ljxoAzlb5av15LH9hOdNR2WfVLjjZTJXIlJN+Z3ASWxISpRCHIgwmlBI/VAU?=
 =?us-ascii?Q?R/MOGJOXBYJeT/BsQg2yZXzm95ct6hSCUFWIpIHS3r7YW3wXaIWlkVQZE81j?=
 =?us-ascii?Q?bBWOnHZO3r85TnVAoZqxRtCilDuArOo0St4x/8TGGl13qQCzB72vesKM+8Js?=
 =?us-ascii?Q?cIl4P+PU+AINKHjZ3gg8+HcPi0DIdtztL7tnWrBUdx9jpoPifFBuEyLOY4Ng?=
 =?us-ascii?Q?WOuPDKgIp2pPvrIlLy+DkEijv7PFtqT8ufVFsmtB2mx9USimxaaxQ2DMmbfp?=
 =?us-ascii?Q?GxBzs3C4f6vVCrn+6ZrieJ5OFOHon7GLDE44AEK/tdMcGv+BHI0NdBhzDUn3?=
 =?us-ascii?Q?VmDDaf4FUyZf9lMPC2C9WKeZ3RYbuWpobx9O3GQk+/vpqLBk1+Sf/zWeLdIn?=
 =?us-ascii?Q?1nqp1zF6kdGObBpBz+UAqo2DGqO5Bknwi3g11BrnS+17CQgh1mND2a5QhrEA?=
 =?us-ascii?Q?IJAnmYP8KVyfTRvHHsbupGJ45Cwv9UOfLq50WoH5cLTyXrJPHniUMVWHBxlf?=
 =?us-ascii?Q?y7/VdCEOChjQFY+Ml5zGk7c/hhF1Yz4rH0gOFMzqKSh6BY6VXDTLpqwySmKh?=
 =?us-ascii?Q?IE5gPHy8WBs+60z5mbFUT0UXw7IL16MKmOL2r181iqN36v9udmsgtuw8Rjtz?=
 =?us-ascii?Q?LYtR737ddU1VtZd0SAV3ViuceOXXXuAQWF7GMyVbuKTQz0TuP3hLh9q+uT6S?=
 =?us-ascii?Q?N1fuqe87U/VknH0MZZiH4ZqbKHVwLLnl9h8cgfvd+GEl3WqQEyk57M0434hQ?=
 =?us-ascii?Q?nc+pqm5dhkEHKzxwEivQFppjKNCEuAJmULrocg3+Rhv4+255GuGvOYh16/CF?=
 =?us-ascii?Q?ZqYtVK7i5eFoMiyltUiMzOFLDlEdmLL3NUWm/BzPgtgWrJ2NFzCFt8Fgm+BY?=
 =?us-ascii?Q?BbwcN4KW/TC9Yle4KAvIzYHWLmTTv903q+jjG/Q+WapFm1a8zgrS6m69Pi3L?=
 =?us-ascii?Q?O9QMZNo+Myrzyh0a2X4PtRPIxwjIhK8EpBAe0vS8FrtBsdXgXiIf8VLWc1+e?=
 =?us-ascii?Q?u2mwvX9Y2ZTwWbc5Nyz47hCCtj3b/+pfvU4zGHXnDclYGlQoXBBWWwGGXqYK?=
 =?us-ascii?Q?oKWMD4ozsIrgmlyq3A1PYinHCDByORgKPtneiCi+OIApa6x4bdk7V9sIMWOk?=
 =?us-ascii?Q?c/+lqPD/ZfsnpR/J5KLH73UKf2S+dvXx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:59:10.4758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cf5027-253d-43ba-a22a-08dcb5eda7b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520

The current driver code lacks the necessary plumbing for ACPI IDs,
preventing the mipi-i3c-hci driver from being loaded on x86
platforms that advertise I3C ACPI support.

This update adds the MIPI0100 ACPI ID to the list of supported IDs.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 4e7d6a43ee9b..5ef848833a81 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -834,12 +834,19 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
 
+static const struct acpi_device_id i3c_hci_acpi_match[] = {
+	{"MIPI0100"},
+	{}
+};
+MODULE_DEVICE_TABLE(platform, i3c_hci_acpi_match);
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


