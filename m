Return-Path: <linux-kernel+bounces-302991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1E89605D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FB71F234D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E068F1A01CE;
	Tue, 27 Aug 2024 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Z7l/B8j"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA041A01CB;
	Tue, 27 Aug 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751473; cv=fail; b=fqQ4MHJ695BplhylqXSISYrQKsxIoaxhVfE9lql+AmrRGBtf90xLQPoyst5Ts8kG1FyIxVAxf5+vjhCwxbnjvRqkv1k9q5btPBXR+RiZ6plEuPT7V4oDvsod+Lcir8L1+yl38Yt2cK3S7XNUCCM/ffh260rwF+0fbPPbqiLuuDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751473; c=relaxed/simple;
	bh=2jHRvGjuGu3DZogLSRf1OJ8xcMAR7Ad/RKjbUreoC7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ll2srPNzkMkAJbeaXvKn+Wl40WnPx2xD1cQKjWAbkS4R7f7lvaBrU6kHyzHioB0w5xAa7FrvCjKoDJp036Ut7llsDcupTcvXx1bTvkvXRZM49T2F7tdI3U3NMutWKcYX5DuaNIzvubWzELq5SBqpSOIxYQFejA8vt61cH47WWMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Z7l/B8j; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJ87utISM/AD5DYQ1jt49bNX7Ue+mKnw0TxLMaLvZST4iIh/NV/QN31wFeWXS5MdD67D+yKo6bqweg/E8d0v7L/u3/sO8tRjby6vkIsvRLjtwILDSxgifcAgguoRhUwgCCSy/S36brDghnn5zdI7PX37AHjLJ8CpiHG2/YcUh40oij3fLGThWvmzuu8wuBxibEsApMmxw0fRAXkqSlPCpN2Y3j0Fjmep7QEfo/DsdPw5xxPoGQjfFRxkHMwVU+opWdz5G9EqDkUYGCCzpNFpT7NaNH2ZaQ8pCZgy5XOh6/OvCaV1ds2f/DNgQ/mEoAdBoTpzvAzmQnbJsaJwMwj+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/u3Pgo8YnUd0eE+CksSIxbMlEX64xhjwrVr6BUtp9E=;
 b=skNQylf/BfU0uf+5/i6KarrN2CQbnRAtuumNgdd+z0RQ6RNIP3mmph4gij3Vzvb0PdBJ3Xrd27eXyDDjUVsE4K18JiXR5PczftV26+WqsV9IPVq+/c7Qe4TZ7VivOYWkf9o/lJ3dSoqohNPouLMdglVSdcFwYG6jq/mwRV5TCzmqd9OaX4F2iJA11S0smEiTIP9x/OvpGZshgtAJXMrHe/wBlSYA/KM9ONrOdRhd7NjhwrXqVcNfzjrGHUvnt4egmRviEu75jM6VP/NArqjH3wvVusV4hc9JbnuUok93TPdNT9j09pwSqzYg/njYPfLrxzqNRqkpyptUGFWh0Ib41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/u3Pgo8YnUd0eE+CksSIxbMlEX64xhjwrVr6BUtp9E=;
 b=0Z7l/B8jmcSvhQHjTNQ6WYvyyb2xCH9zFLwnhBFOeAUxAaX9+o70I0AxbRd0npQoRgM76rLvH3hr7qMaJSFDmImE3+HMyWVxcqqNgxqaSlsWC1/xqay/YfX4LrOPOf1jRAaYVd/bm8nrPo8s8thNx65nVmMkau70RcQb/O9xTvQ=
Received: from BL0PR02CA0009.namprd02.prod.outlook.com (2603:10b6:207:3c::22)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 09:37:47 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::5b) by BL0PR02CA0009.outlook.office365.com
 (2603:10b6:207:3c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 09:37:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 09:37:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:37:42 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<kprateek.nayak@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<bharathprabhu.perdoor@amd.com>, <poonam.aggrwal@amd.com>, <Li.Meng@amd.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Xiaojian.Du@amd.com>
Subject: [PATCH 09/11] platform/x86/: hfi: add power management callback
Date: Tue, 27 Aug 2024 17:36:57 +0800
Message-ID: <d2a39a68666e2dffa8f0ca9ba32deacc722ea2b1.1724748733.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724748733.git.perry.yuan@amd.com>
References: <cover.1724748733.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: bd306d05-6ea8-4f9e-41ab-08dcc67be8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y4mwMuRWibMxmMjfp6I/brZY4Bz8vpew+MCsxRl6uNmQ4bieG96f7xqaBONy?=
 =?us-ascii?Q?EMtL76fj+R5fyqO0O5CPQHCR6vJ/n7+FbdUoGOy2eU+YYDBYZ1RUcpZd4mVl?=
 =?us-ascii?Q?LSIvI7EfhCbuMKLAUAGGiaLPman7ZuuOvF3yaPLw7ZbwCqzo8G+D34vAEqvB?=
 =?us-ascii?Q?9e0O4KD2FEChuE+Y9Ju8rc5mDrY0fGKwyLyPkjEBjYkvDcx+oXyKY8vl+HSc?=
 =?us-ascii?Q?FICAbSBFMxTPzakuiv3cWG04M+uEGnTEYb0HuGWqnXCgb1ZA84nYZKSrkJ2G?=
 =?us-ascii?Q?MA0Kab8+/3RRZgkKWUntS0bmMnB4vFr7qOJWOqYQYHZ0ziciUDPXs3svzXtj?=
 =?us-ascii?Q?XJD/ZEXpAHUOBw/PXxIri4zwe1Okt/5AZmUJVXHU4EqYA/gh/2ehUxfCNBle?=
 =?us-ascii?Q?+C0gCMZHT7jJfliCSwOxPBz+NofVMuRYv6901chBRNUDfsYlAYXnPvQ5zVYb?=
 =?us-ascii?Q?mpGEI+3MdlaW/QWqLfU58Ifx1wp1wBtRS5uhawHWawuYitmblzpzK5swNTjd?=
 =?us-ascii?Q?0oFgeCDGaCbT9PV0BJln5J51pLw9vrigO1C85a1IP7tgcsOLxTAAZcBPAHYl?=
 =?us-ascii?Q?h9rYZIgITxrIsn7+tYPflZfEiMnZMYsq8n8dSdWjHIvjQNWKeFQO4IvJh6gV?=
 =?us-ascii?Q?h9SOpETj3WDmj2XExUIpWHRmRIo8ji5WJGUtVto1PLa/+DwR56VCCJgdcpQI?=
 =?us-ascii?Q?x0lP7taD10SCsd8wDS5IuLLB9s7ueZKw3OIB5gTqHalg5C+cyjlu0B9HGDJf?=
 =?us-ascii?Q?kjeQapsAqQ5iAmuy0l2QMeISMU5/816szkBu5gy997FkxhrsjzYtjre3Gbh1?=
 =?us-ascii?Q?ZzTpRE4NRBPRYoK1CHdqgLYYbHwxjcyTyj+D6blSk/8iiZ95fdnD8F9G+uGP?=
 =?us-ascii?Q?z1osQRY174nOV1S++VsEkrREtlqAm87ReMY+jkgeGmPL4EGsXqNZ7221rdHa?=
 =?us-ascii?Q?6YEFWuRwmFU2YRvel/sveWrI1L/2t+moBJLtws6EPVTwGUXZfG0UuCG44Xmm?=
 =?us-ascii?Q?tr6TRvMToes2Hm6cB13xC55OTaFHh9qynVIEDOAPmG5VdITSeEvXFWs0qoWq?=
 =?us-ascii?Q?RMMuz6RFZCyN1LsMMwVoko2WBuWBfBMfg/jTchACyTWpOda+TL930rD4/o71?=
 =?us-ascii?Q?oe/vV/MYMn3geOprXNuDL/mgElBPDsOvGUlDNCFCBRSf2IpPS45DIf0NpbzN?=
 =?us-ascii?Q?5soC0+NnDej1wboSaQYkbtVKXOLGgPrKfcOM34Orq3ykNJ9M5Y5NcStqx+Il?=
 =?us-ascii?Q?Heh0TsS0H+vyd0eGuAhYHRKC+72SY8YSWLzskJ0uSZ4Qo9nzfuC9W7qVVUdF?=
 =?us-ascii?Q?I5IN95g+ZNW3fAWl+CDz9dhnmcn6100EOGzsCv7ionaSKdZGeptqXyrC+hLc?=
 =?us-ascii?Q?GcF9aQbabr5wF++enBYddaVNwB/GMPZ+mvwYRurpLcD2SkDuiVArtaPxrnmJ?=
 =?us-ascii?Q?80aJW4HC377cuQleJ0AQG8jJaIyHxfsk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:37:46.7011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd306d05-6ea8-4f9e-41ab-08dcc67be8c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128

From: Perry Yuan <Perry.Yuan@amd.com>

Introduces power management callbacks for the `amd_hfi` driver.
Specifically, the `suspend` and `resume` callbacks have been added
to handle the necessary operations during system low power states
and wake-up.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 57b642c4c522..c3da2edf8590 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -304,6 +304,39 @@ static void amd_hfi_remove(struct platform_device *pdev)
 	mutex_destroy(&dev->lock);
 }
 
+static int amd_hfi_pm_resume(struct device *dev)
+{
+	int cpu, err;
+
+	for_each_present_cpu(cpu) {
+		err = amd_hfi_set_state(cpu, true);
+		if (err < 0) {
+			dev_err(dev, "failed to enable workload class config: %d\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int amd_hfi_pm_suspend(struct device *dev)
+{
+	int err, cpu;
+
+	for_each_possible_cpu(cpu) {
+		err = amd_hfi_set_state(cpu, false);
+		if (err < 0) {
+			dev_err(dev, "failed to disable workload class config: %d\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(amd_hfi_pm_ops,
+		amd_hfi_pm_suspend, amd_hfi_pm_resume);
+
 static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 {
 	int i, *hfi_scores;
@@ -569,6 +602,7 @@ static struct platform_driver amd_hfi_driver = {
 	.driver = {
 		.name = AMD_HFI_DRIVER,
 		.owner = THIS_MODULE,
+		.pm	= &amd_hfi_pm_ops,
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe = amd_hfi_probe,
-- 
2.34.1


