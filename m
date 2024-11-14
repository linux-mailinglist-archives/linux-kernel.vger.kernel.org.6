Return-Path: <linux-kernel+bounces-409176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5079C8869
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DF7B34925
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C921F8EE7;
	Thu, 14 Nov 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OOJBcI6y"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4831F81B0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582187; cv=fail; b=Lm9TLaVjnEL75gZW/6cixJr4Oo94apy0/6t+/NXY4v1yywc6DQjw8iFE5o8kMDFHcRmqaS07fPHrvw5Rt57wonFvn2rkMJLvP7LJBUJgKx9wE50ZZrhhZEWjDPuF1w0rv4taoAE8wvPCg7bal27FF7iFUtJ8Fq/CXBWEFefwI8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582187; c=relaxed/simple;
	bh=jJgCgBk5oBViiFGPTIOA56XbIZSpWn73CihblAT4EZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdE4Zy7c6Lb3UN+8ErCrwd7u31xjCSbw7hl2BefIVqhDOpGtZljHGICEfuDTpM8tlHJxD7sIyl1TxtTVUbpkB+9pVHjsQ0h43HB9lO/I60cJlYTgKgfFHT3aYq1d4sJwPzB9vda664uHYnMDerQWaQVmTq3perjCgJHGRZbbwec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OOJBcI6y; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uX79M0IKOjwgb8CaiGTjBsYqr5Y9kT98eyDzCGShQ68Wn43/Rn65hvZyQzTNiwMhjtcXjBLuAnMKOnFcnJn5WVpGwHmkSkwaHIoi0kYKrYHZ5V14EcNngcFYUlIq0qX4Aynm6h2oWuhDOoOe3Wg6zEUeRfj/aQXYGkXmOVZOHcPzC3d5K6tZvVsjTepd1LqNUnnVdT2NdyApEBEvLm+wN4DV7gPd9ltZwxlFfa8gT6g8rb2veX8Up3kHuBJeb6mrTJjvHxMhLi52E1OeLemNBwoALNj5I62/EeppeqqT3HUmXK/44i7u5Z+jnLFqEkQlINmdZ8w+WCGeLJRv7xHYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKez0rYB87Sravy9nKEf4B2Ordj55ZWPAv2xNuP4urY=;
 b=l9lUxJj4Dzy46YBE1nxklaBKrfmtmS6cqgdK1Og2VsKxIhFnHJl4xZnSuVVdQiNZmdpgX0gfcSDFllnUDEjS+VMfkOVrGyc4I8ooJhhlMPgAJw8Z9HdeXKmHp1r0ysNp42AEbVxFe8dPZGwg+cPCc3t7Ge2iDvlyn5lD+W92+6hI0vVax3FjtJqlHQfRVRNZtZSwKof+5cXpTOvJ9LzUJ0bN+ICfAvTSus+Gzkm/QR+gAGyCnkvlywxLUWaHHOiwxPIg11iTXVGotPpf3i/oXhbRUQOGNE6SCSdOflCR61G+IYiWU2JZG86+vA7NGbaUvPssqnOmpH5XtaEwItlC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKez0rYB87Sravy9nKEf4B2Ordj55ZWPAv2xNuP4urY=;
 b=OOJBcI6yhoE4otCJWBbfJAMHOJgUkpAJJy4TR4um19I5Nz6ZRqYPbn8/9gd6VSuBZFGghBxWaIrQ4naKj5fYHeUZWefj+Iecp/DbHgoxULgCAH1EJwqtKJmy1w/5x4ssLiwlB00hgS/BzF++gvBapfIov30NLQDdIafkTqs13nQ=
Received: from BLAPR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:32b::6)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Thu, 14 Nov
 2024 11:03:03 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::fa) by BLAPR03CA0001.outlook.office365.com
 (2603:10b6:208:32b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 11:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 11:03:02 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 05:03:00 -0600
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 1/2] i3c: dw: Add support for AMDI0015 ACPI ID
Date: Thu, 14 Nov 2024 16:32:38 +0530
Message-ID: <20241114110239.660551-2-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114110239.660551-1-Shyam-sundar.S-k@amd.com>
References: <20241114110239.660551-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf2a6c8-25b9-478f-ac4b-08dd049be897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RsoiaunjZK/RSG8aHKbTeZ2Vu1B6/8286n9WUIYGLNzbsyCcmpTdeWla7rxb?=
 =?us-ascii?Q?ZCy3h/l8QSs3JiIKLM1BZCv78F3ZqgjAD+mQa3dCg8gbrmh6qF2R9TavvzCT?=
 =?us-ascii?Q?KJxx9SMpHCgr5kd2bfvXqf6w5ov4ecOvwYC1M7Zg3yqu5qroIJwLz9PV9Nbz?=
 =?us-ascii?Q?VTJAlwou5uJG12lPg9XzYG1odfekoXosLa6AYWRV+pag4U4PbXqqj3Ha0u7K?=
 =?us-ascii?Q?4prAoScFqvaWsrjhcZpK+KWVYzcy1yJ712oDsaHDvEpVkTY0kLu7X5VKTv8j?=
 =?us-ascii?Q?goYGSg6Ouv60K0Ksc34zqW6twitfClRe0s36804CjeKk6a8KXHtLrfhZDBlP?=
 =?us-ascii?Q?k1mSHX5JPqK/esooYBdmmMPbm1rKBmdHjb82hC0RnqKEZEc82E1YSDyQePO4?=
 =?us-ascii?Q?e8vP7EJSEExGGaZ4XWQXgmP72DCxkVfbs+dSLMRJPGpmUgUh4jmfDsYbix/b?=
 =?us-ascii?Q?OKymq/0XVEp+X9ldFewjeFkDesgj57fz3n3j68f2M50lhqoyERtzQNJYK2Cj?=
 =?us-ascii?Q?MyA6PlwU0C5xbQguHBj3jtBXdh0mPwPYwoJhGlU6iTZBK+4Mi1sWnPMQs0BG?=
 =?us-ascii?Q?jEJt635bHkxH+EMYQb9/f3WJvMG9Jw71I2R7bVew5TOpQou/JmN7VMQ/ETpp?=
 =?us-ascii?Q?sETYfslOejd9OQ78MSIcUTJbnwBALYgZtljoCN5wZ5jd69OKIIsaAslDnsEl?=
 =?us-ascii?Q?wGJQWLiNHco5t6EqdfrKj07JnII+4e+xpRM8O5Svl7SS8e4EO2Sy/1VGY+nk?=
 =?us-ascii?Q?JiPnmQPUzBMvL/aLkzPJ6P0+QZqg8kMNbb07+ZONWvpek7f5vJrtLEgazs6K?=
 =?us-ascii?Q?Gll4abcv2v3M1a1ZdQztKqD7xdwLWXuIBaw9egKc4QXyX4YJNZfU9hayI3KX?=
 =?us-ascii?Q?ahZXWmiQvMI8Tatu+qdLuCQKsiFg+WVwCVhV9eUsUnEUuXhZlj8DPfSxaWPq?=
 =?us-ascii?Q?xkUvvNqb1arXY9JXLF8M6adyEFaiUZRwGiudxNUI0p27rEkpMYZvrBYb3qSs?=
 =?us-ascii?Q?jMNmPUsU+RmyeCV0bk5afH6q2gcH7arVZoyDzfTVCRuvwsQgRvZ0dOiOUrtc?=
 =?us-ascii?Q?QpeBoZxP0NTib0kkbGtD24kI5dQIFlVX6RwExi7eySc5mVZnSePHWtr3U+B4?=
 =?us-ascii?Q?f5iwvV09hfAymkwcp7kevsVP3c3ZWaa341g6nCWkBscIDGxfv9KsOnaYm5FX?=
 =?us-ascii?Q?0QXSorDfV162fbc80jDV0xRtv5XBEAybpFyiKP82+vE89lPp45VK2wYI2kN9?=
 =?us-ascii?Q?9IdSuL2U3kswZypNv6bOEpUDnOmySRKYM0+1wKOTVJGXeLdBWsxMljBOAG3/?=
 =?us-ascii?Q?qf2uLvCi0ygwhQPlLEcN6/ZB7k3k/aM3wEqaqvtjEAPSpnBdb79QwdC39rAf?=
 =?us-ascii?Q?MtG1d1kbNTRHiSDW3pV4Jf7ZMn9ejgC2t86wiz71z/OV4FhYSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 11:03:02.4393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf2a6c8-25b9-478f-ac4b-08dd049be897
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986

Add AMDI0015 _HID for Designware I3C driver so that the dw-i3c-master
driver can be probed on AMD platforms.

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/dw-i3c-master.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 8d694672c110..1a7c300b6d45 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1748,12 +1748,19 @@ static const struct of_device_id dw_i3c_master_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
 
+static const struct acpi_device_id amd_i3c_device_match[] = {
+	{ "AMDI0015" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, amd_i3c_device_match);
+
 static struct platform_driver dw_i3c_driver = {
 	.probe = dw_i3c_probe,
 	.remove_new = dw_i3c_remove,
 	.driver = {
 		.name = "dw-i3c-master",
 		.of_match_table = dw_i3c_master_of_match,
+		.acpi_match_table = amd_i3c_device_match,
 		.pm = &dw_i3c_pm_ops,
 	},
 };
-- 
2.34.1


