Return-Path: <linux-kernel+bounces-302990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B979605D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C24A1C214FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758CE1A01B3;
	Tue, 27 Aug 2024 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1hc7BAFZ"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93771A00F1;
	Tue, 27 Aug 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751467; cv=fail; b=rNwfdU52HkuU17IGwMALJDboJlcUiSYJSdwgacYJqVToMfVUvSDRDX3UrAu8R8OxXuTLoeqkyPHHrXL1BMI74IHsK2+HE4Rpfs2QInpdkU5Z+yKnrcXYxePWhGLAgqbR37V6rhqPw26bRoj2x94ihsoTxhZ3qo29tioMjpxAz4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751467; c=relaxed/simple;
	bh=tjZdoEbkgkvjvvwuPJz9cI5nCjgOaV+rqFQ2Svo4VRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gllqhsLgcuxuad6KaR0pxiv3K9CJf1Seoq+B5NF5C5Ib2hzUDcTCbu/v+ab1AzrzVeKqYX1kbpqi/upkuRNo5dXxx10EgmIOG/4DzKbU41A2Ht8r/aZsNS9JTV8J1mp1t4a9VYYMuYfO3iNzFcq37UcIX3oV2TwRPlSYnzb+lZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1hc7BAFZ; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qpg2rDF3vMNT1xN54J8gbhVffIWQ4wcV+bj2afU8jlyFIry/6YiwVEbU93FMxd1QKR+Un+Yed1ii3jC53A/B3ywKRuEx+jXXLodd/yRy1RjjuubTZxHxbsCVFTogdg6mcK4V70NbNDMWMuHUWijod8SkrWP8pEn+KbdMNuxPd4DLFT5Xaf4BZftCpXsWrGsECmSKfsN37wqthPCJ/aMT5MTM1s2G2NWioNwqtD2mV1T6Z04Z99NjVB3UdU2kKxcvc3t/A0VASK09qzsTIGOs6yaHtII6U47R+344BD3IYuoXUJV2Jh7NLL+baXTPItFcaqqARZwkK4/S65Z0weHiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAfxdSezZ6RxOswLrCWx3fgy7dQPo+gg41ZJ+Adth+I=;
 b=Iv2HT1MlOLQHXD2ZbxAACz8Szsv50TzLV4n1WQYnqo5PnalefTA5hxLr/jNVKxQLJav2gQK11oPg/1kfHp7zH2kF4ycjUv+29EfiYRpA/zSlUPzgfReEw7Du2Fys4fIEAr5B33YGATITn+5zM9iqrFIJajH1A5FZH4QBfi3v1RMN0GLtTqLU5ixEnPM3rm127v+Nw06DKDUYBqSEG6WzwyvF/xsJCAIkFWoOHKFw/CtgrxrJaQalraQ8vMhLF3Cq3Rgar4F66sPt2k97ymNYnpHIVm9boiCcczNHnQK5FdGzq9Vvwzr6QPlyTdbS0D8RKuQnboKbQ48hAayzHLqhyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAfxdSezZ6RxOswLrCWx3fgy7dQPo+gg41ZJ+Adth+I=;
 b=1hc7BAFZA7hDgYJPeeuVpgGAPSuARMuBs3tqzQovrmYfjwamo+NlnEC1cFQrBe8W9LBB+xOLIPSnhb2NyxZQnMxhYYVC1TapjhkMt0E5ksRtHW6Wq8a57qoA2o67Y4cUCM937eg/DTNAv9Eozd1NPkwfj0XPmffYC82gypmQ7qU=
Received: from BN1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:408:e2::21)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 09:37:40 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::fe) by BN1PR13CA0016.outlook.office365.com
 (2603:10b6:408:e2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Tue, 27 Aug 2024 09:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 09:37:39 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:37:36 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<kprateek.nayak@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<bharathprabhu.perdoor@amd.com>, <poonam.aggrwal@amd.com>, <Li.Meng@amd.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Xiaojian.Du@amd.com>
Subject: [PATCH 07/11] platform/x86/: hfi: init per-cpu scores for each class
Date: Tue, 27 Aug 2024 17:36:55 +0800
Message-ID: <b913765989396d62f5184d32932250ee434cd0da.1724748733.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: 7522b919-138c-45a4-f318-08dcc67be47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zc/6jZHggEKKeln/BqxlTh+XfeJveIGD96Q5NnrFMgO6c/nVXbMSmZ77Z4pR?=
 =?us-ascii?Q?gLyOGrH4ayxoQQO2uLVH11dL1D4ruCU/cuuIPPJRi+uEdbT305KAFvZkTfay?=
 =?us-ascii?Q?f4Y+6rJhtF/IDNJD8ygrkgju+IkoqJPb51hMHVpydxC+p7/E8BPLmXEaNrUa?=
 =?us-ascii?Q?qUG3x0IEGrrCCGwYHEoFXmcQh8DFdz3HeZLjbUE8/AtyQh3xkDfGfUPgfLn6?=
 =?us-ascii?Q?6jhv++aqLAS3a+ltrecRmW5uxsq4ZyJ3MOBtkd8limx2drN2srvnzwyjRmX6?=
 =?us-ascii?Q?zdXKR1CVsPYaCq6HN16cDVH/nMNayKqm25irPpRKlMZVWwF+umZ9DBkCc2UY?=
 =?us-ascii?Q?yMXiNiG+iND8+FS1qP9ceha2O1Hdtel8dKstFTJOHvcyr/DCVOTgeZ08IL/4?=
 =?us-ascii?Q?DQdiRJpqTWV1F7HTutrijiLqhzkEEVkpIlEpB2FgInxGDWxW20FI9zzVtmvH?=
 =?us-ascii?Q?FqXmRi01QRCKBjL96yMOimhcm1z7Nt7g+wCcVLhY3PJ5fNR1mZtEZ17DQBh7?=
 =?us-ascii?Q?GtRFepyXVaDV54C6lD70JaUuEo7QgW/SAFE25fSd0sXymXJ4cL7YWnsVHbgq?=
 =?us-ascii?Q?9AQlqrta8MjA/9KqEltyfFr0SwNUOpD5JOA2VgBhfZ/4IJuh1srMcbA0p3d6?=
 =?us-ascii?Q?U7n7GFZHvjfAQMY7CsVZ1ikDwj5tqGLRDG+YhwszbLsPUd7j4qlipxvS8VJ/?=
 =?us-ascii?Q?kDrUSz/zMFwWjNDvBIu29lX80jAXbvLP77B6R96P47pUCvSfhFj6/f071Bsx?=
 =?us-ascii?Q?df9u/XUoWyDCyHt2XgNgDvAMzHJnNVq+7+uNjcnTLCxe7KgftMvCNTAwHd6e?=
 =?us-ascii?Q?LdRksudJB/Q/d+otF6xEpWDVVHfO8q/zrYFu1nxcxDPFEqtaO16clvacOfxG?=
 =?us-ascii?Q?rVMssVfedeWGKiw83qkrLweVFQqNx928//dlj05l6Wp1jtrLbJvbSO1HcCfO?=
 =?us-ascii?Q?1WolwLE8Kzr83zvz7tQtcvMVQe8bkcK/VoBhWlYoY2kibC5YOodkdj92NUzS?=
 =?us-ascii?Q?ODf89K+RFppqAIXTd7OpKRoabA+h99lDMq2XA6Ynuzv4wpMsGutH6O1XrBJj?=
 =?us-ascii?Q?xuYQyRTmpWvpcSwX2pp4ofDmtMsay1XReqwsOtB5bxNr+R6dc+1V/K3SH4Z+?=
 =?us-ascii?Q?PWdBNufimcj01fp4OafZojJUtnFupmBt32TfGDhrwtP9jtyiYnFHLOtUdQDc?=
 =?us-ascii?Q?8Lp0BUlV3aHz0dzoK9xLSL9iagJPRLCQTj+k8kE/lhCzf5Bleyc8ST8HbCPS?=
 =?us-ascii?Q?wkjDbgjK2EYJBG0N44TbkpAtPxcgN9ywhOlirYgofOJObZq0Rk7kB5fWNEFz?=
 =?us-ascii?Q?nPYQwSYx+T/b+vjYixoyRXb/PVi5dYj6BJeZzQQSvJXE5EhX1UZ8RijAPqF4?=
 =?us-ascii?Q?tnAqeq9CuMUV91ZXs+kAFfA9SMA5FpH0yFaSmzpCOP2Njhqeb6e1cgXvm4vN?=
 =?us-ascii?Q?68KKkB2eX3TQ6xNrM5Rq7Euyyv9jA2s1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:37:39.4967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7522b919-138c-45a4-f318-08dcc67be47b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425

From: Perry Yuan <Perry.Yuan@amd.com>

Initialize per cpu score `amd_hfi_ipcc_scores` which store energy score
and performance score data for each class.

`Classic core` and `Dense core` are ranked according to those values as
energy efficiency capability or performance capability.
OS scheduler will pick cores from the ranking list on each class ID for
the thread which provide the class id got from hardware feedback
interface.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 65 ++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 50f6ca9c148a..cd5f2b708ebf 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -111,6 +111,7 @@ struct amd_hfi_data {
 	raw_spinlock_t		table_lock;
 	struct acpi_subtable_header	*pcct_entry;
 	struct amd_hfi_metadata		*hfi_meta;
+	raw_spinlock_t		hfi_data_lock;
 };
 
 /**
@@ -130,6 +131,7 @@ struct amd_hfi_classes {
  * struct amd_hfi_cpuinfo - HFI workload class info per CPU
  * @cpu:		cpu index
  * @cpus:		cpu mask of cpus
+ * @apic_id:		apic id of the current cpu
  * @class_index:	workload class ID index
  * @nr_classa:		max number of workload class supported
  * @amd_hfi_classes:	current cpu workload class ranking data
@@ -139,6 +141,7 @@ struct amd_hfi_classes {
 struct amd_hfi_cpuinfo {
 	int		cpu;
 	cpumask_var_t	cpus;
+	u32		apic_id;
 	s16		class_index;
 	u8		nr_class;
 	struct amd_hfi_classes	*amd_hfi_classes;
@@ -146,6 +149,12 @@ struct amd_hfi_cpuinfo {
 
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
 
+static DEFINE_MUTEX(hfi_cpuinfo_lock);
+static int __percpu *amd_hfi_ipcc_scores;
+
+static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *info, int cpu);
+static int update_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -293,6 +302,40 @@ static void amd_hfi_remove(struct platform_device *pdev)
 
 	mutex_destroy(&dev->lock);
 }
+
+static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
+{
+	int i, *hfi_scores;
+	u8 nr_classes = hfi_cpuinfo->nr_class;
+
+	hfi_scores = per_cpu_ptr(amd_hfi_ipcc_scores, cpu);
+	if (!hfi_scores)
+		return -ENODEV;
+
+	for (i = 0;  i < nr_classes; i++)
+		WRITE_ONCE(hfi_scores[i], hfi_cpuinfo->amd_hfi_classes[i].perf);
+
+	return 0;
+}
+
+static int update_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data)
+{
+	int cpu;
+	int ret;
+
+	raw_spin_lock_irq(&amd_hfi_data->hfi_data_lock);
+	for_each_online_cpu(cpu) {
+		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+
+		ret = amd_set_hfi_ipcc_score(hfi_cpuinfo, cpu);
+		if (ret)
+			return ret;
+	}
+	raw_spin_unlock_irq(&amd_hfi_data->hfi_data_lock);
+
+	return 0;
+}
+
 static int amd_hfi_metadata_parser(struct platform_device *pdev,
 		struct amd_hfi_data *amd_hfi_data)
 {
@@ -344,6 +387,19 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
 	return ret;
 }
 
+static int alloc_amd_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data)
+{
+	struct amd_hfi_metadata *hfi_meta = amd_hfi_data->hfi_meta;
+
+	amd_hfi_ipcc_scores = __alloc_percpu(sizeof(*amd_hfi_ipcc_scores) *
+			hfi_meta->n_classes,
+			sizeof(*amd_hfi_ipcc_scores));
+	if (WARN_ON(!amd_hfi_ipcc_scores))
+		return -ENOMEM;
+
+	return 0;
+}
+
 static const struct acpi_device_id amd_hfi_platform_match[] = {
 	{ "AMDI0104", 0},
 	{ }
@@ -385,6 +441,7 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	amd_hfi_data->dhandle = dhandle;
 
 	raw_spin_lock_init(&amd_hfi_data->table_lock);
+	raw_spin_lock_init(&amd_hfi_data->hfi_data_lock);
 	mutex_init(&amd_hfi_data->lock);
 
 	platform_set_drvdata(pdev, amd_hfi_data);
@@ -402,6 +459,14 @@ static int amd_hfi_probe(struct platform_device *pdev)
 
 	amd_hfi_data->hfi_meta->dynamic_rank_feature =
 					cpuid_ebx(AMD_HETERO_CPUID_27) & 0xF;
+
+	if (alloc_amd_hfi_ipcc_scores(amd_hfi_data))
+		goto err_exit;
+
+	ret = update_hfi_ipcc_scores(amd_hfi_data);
+	if (ret)
+		goto err_exit;
+
 	dev_dbg(&pdev->dev, "%s driver registered.\n", pdev->name);
 
 	return 0;
-- 
2.34.1


