Return-Path: <linux-kernel+bounces-302992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C6A9605D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E08D280C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1201A0706;
	Tue, 27 Aug 2024 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YFjoaUjW"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F291A00F1;
	Tue, 27 Aug 2024 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751474; cv=fail; b=mR1nhQ3XgYfUk1XSpUavGcVsPWdEYxg009pKxdvPrabEjoK953Kn5VfL+Qqavqs4re34N89M7VjOywSHBoOkloh9gG2m4+S0/2h0Lphxl905Sl4QsHgwAXb0vfDuiZj86T00Dnufs2h7V4Qxwc2q/dCyC2Sc/HcxmnNElqsoYMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751474; c=relaxed/simple;
	bh=yiWYKT+tKaxyBJvm11LUMA9ysFzyGINsaYBksG5LMAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7dKy0GTXD7JqwZYCOS0N0vuIAV1m5aTDzMHqEpEXV39hU1QpHiXjMZ/vbQEGXcNwCZknjbP9HUeHFf8UnChQ3Tg12IkcaPXlXZ0xQTF3X0PuTn57lhBgk78SFCzwGnliLBUIWuF6UDp4MeMhgCq1MPMTP64O7qjmkt+saX1Eko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YFjoaUjW; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQgMuGrNhVc9trPRyxoy6OPGbt3L7O+87LVM2dcCsq1Mz/zPpcCihcRz73720B6FuZE19xuReujl/Bx6h/SgiOM+vv0O2L5H4gtrNMKbfbWion/kJ3STMH1m9Ju946P5Db6myitF6d1RCegoEYM7d9UIofP4WeqOJzTEResWOdmqxrqoq11+lwNCi2pfIphYPfnh0lvwYaNKDsKwSJ46ZmScuPzpaPZT8wHX9pzkusYFXcitcM8vmaNnH/5ExQPsHpYJIIKHyiJ9Ya4IcJQsSwhW8HCLCAiUu8ZL8C1f2mx5ZUWnQQB+EIrFwvyGzBGCjY8AKD7qS3xCK2H5jr5hWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKkrhtSPgaxjFX1LicQ88aZRiiw/k8DNU9Y3ZOeru2M=;
 b=Ejw10URlSsLmUwthZavyKi1zenwmGTDEu7f0+Xtp9aYLGB0Tn9qKsAfUXlFnHr8W4bT3p47jLgbtA19wmWaRB1xhSl44PFH8sqtSYJdz0MUJ9AruUgaclmFg9BRSN1PfjPvKiLy6ueYLKQPKbPOhz0cJSGGe3SPmgFZ+CeXYRHObQoS3amk4eHRfW9Bgl9wm+DtisAs6+U9QWfmP0N8ue/8NsjAchNqbuJSzZaq4wRUFfvzSW6tFe4hDvgveB91jUGUx+o2PmRr0SuSuyqCVQv3j/NemQt9piKw/SaWA4iKxch7q72jFwO9E32yNJ0Rh0G9P7wHAudG6/b7trpPQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKkrhtSPgaxjFX1LicQ88aZRiiw/k8DNU9Y3ZOeru2M=;
 b=YFjoaUjWO50acAkG2uE3XUBAGZyxWux/L+REKOp3kCAJTZIVcB4iObm6mcbFJBdruOOKUvjpWdW6gmLkmxlUm5OIM+CZjEblKjn7YoI30aSmhv17V8hzm74rQXNquWlZaZeqBVS2PmOVPTVd+1dohLdriXOSgG4OGCmK60Cc8T8=
Received: from MN2PR06CA0023.namprd06.prod.outlook.com (2603:10b6:208:23d::28)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 09:37:43 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::b3) by MN2PR06CA0023.outlook.office365.com
 (2603:10b6:208:23d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 09:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 09:37:43 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:37:39 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<kprateek.nayak@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<bharathprabhu.perdoor@amd.com>, <poonam.aggrwal@amd.com>, <Li.Meng@amd.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Xiaojian.Du@amd.com>
Subject: [PATCH 08/11] platform/x86/: hfi: add online and offline callback support
Date: Tue, 27 Aug 2024 17:36:56 +0800
Message-ID: <2661e74beceb9198d0baefe1f145080ef2b812cb.1724748733.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: c4043ecd-2710-4ff9-58cd-08dcc67be6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1UFdV0//zmIMywcr05YExNcKvgH6fi0F7BKwVUM52soV42BUR7hRHCLZKIBu?=
 =?us-ascii?Q?ZnSqPL/DNFWmTLvpd5pY4HUdhEQ5TZiepDz1UpFDAZqOocu2XqQL+CoWlxSz?=
 =?us-ascii?Q?ZrRG38Y4KVBrR9Txy7LjWkN8CZ4t7hi+G98LogTd1mEEhKCq0gSOXgplwem+?=
 =?us-ascii?Q?JZVM9jmkJYs5+6icsfwDyWtn7u52ZELuVs4YL6Uoytc8US06aQJBF3ngbIb5?=
 =?us-ascii?Q?loVCJo031fsvrtpqD7fu6zU7Gr04oWkobJrBg7TgqjWFPSEBlEpFgKcNisd5?=
 =?us-ascii?Q?bHPjpL0FEE0X8qvRYBXIyII2rEHsh4FIZOUFjldjPmgjS5/q4eJKGtCEJ3wB?=
 =?us-ascii?Q?AOCoV0AzL/xvQ8tgCX75wENFUdnZMYbBjQx3ZfKCn9qAIUKARfiflKb4YfxA?=
 =?us-ascii?Q?BG6twfB+zBnZdBh1uQ44a0ZHZSa8PLxDmIEn7RTneEtCgCh1vIc/jmLcbNcJ?=
 =?us-ascii?Q?SysnE6oCJ8Pj795TGbVrgYAv7oG75X0bOUL5V4lBCZEYxWLQ1T+aUe+2Jqot?=
 =?us-ascii?Q?9poMjaXIOwmOTXVsWIFF/xoLTR+l9dJ3FKSStpIN1uargVEJdQB/ljDsGEhI?=
 =?us-ascii?Q?SFi81B4uXLwTbhj2BhP0KAxhcXgDqDV380Wur4xoLe6lztYcipSX3zmdGU2y?=
 =?us-ascii?Q?gfh0FzsMhe+w445eu6P9cu87WtnqZuLhcbrJcSmwsvj4bjTnFZiGo9hC/xw8?=
 =?us-ascii?Q?glHnEaDFMn180TYpyXta3YExE2GXUs4A9zZjOvA7FPMLk+bdo8WrBW3RsRNC?=
 =?us-ascii?Q?wmYm6CH2bcSdRmamS1Q4bBf6Xc9QqxqzaOzGXx7qSnCirtZBEg3lW49bFvba?=
 =?us-ascii?Q?UtDC/vWOUCDKOPlUFwWsPmaLBDw7g7E//+fYIuSJXFnL4Z/svK59MUYxl31z?=
 =?us-ascii?Q?/fbyoOgZn3f3dDiHUO4kSDVjcxts/OPhRuVl3sSK4etBihxbqH5QRzfOL6vK?=
 =?us-ascii?Q?9awLwbrQvbqUK70NvkG2+tnFcR9zjeIN/cV4x6P8SPqrWpEqbpPWRQPdg0fl?=
 =?us-ascii?Q?Xpk8xQ6uzRdu2YTLxHTtooKac3/YDlP/7nPg85knacQP5wvmiBH3vAeUm+FK?=
 =?us-ascii?Q?Q8jxAHCO96o8yN2umdxBWpfMcI6Sdu8zqlobuZGee7cw3rgK114JM1q0C/aM?=
 =?us-ascii?Q?n8PcJVkvl/sv9I9A4fVzwNP8cFdqrq9KpTZUjkT7FKOQ1VDYIZoIDWIU22Ev?=
 =?us-ascii?Q?nQNeHb2oyrZGZ4uOtQBn+mTG9EQMcMDR80iJNIvNDLGNy9KfRzNNOtjKGFlU?=
 =?us-ascii?Q?pSrCHhT/6YCiNFPjjq9gC3YURV1O8iAk3YTuaGxSZxBia6DQKehqMxxtO6vS?=
 =?us-ascii?Q?6gJ+Ewx5g8slIplHW5HYkTYnlMz+ow52mDKE0VddIwpPTI9K09zZ+BmNJ9Yq?=
 =?us-ascii?Q?O9MmZZpIDrsyA6DFOVsOpgLnkPTYlOBRXAd9AI5gYC/DrNurWR/gBDnjxCKv?=
 =?us-ascii?Q?t9C2itnuzNam8x7D3599TmUWkAoDkYEd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:37:43.2898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4043ecd-2710-4ff9-58cd-08dcc67be6bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168

From: Perry Yuan <Perry.Yuan@amd.com>

There are some firmware parameters that need to be configured
when a CPU core is brought online or offline.

when CPU is online, it will initialize the workload classification
parameters to CPU firmware which will trigger the workload class ID
updating function.

Once the CPU is going to offline, it will need to disable the workload
classification function and clear the history.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 90 ++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index cd5f2b708ebf..57b642c4c522 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -154,6 +154,7 @@ static int __percpu *amd_hfi_ipcc_scores;
 
 static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *info, int cpu);
 static int update_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data);
+static int amd_hfi_set_state(unsigned int cpu, bool state);
 
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
@@ -318,6 +319,87 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 	return 0;
 }
 
+static int amd_hfi_set_state(unsigned int cpu, bool state)
+{
+	int ret;
+
+	ret = wrmsrl_on_cpu(cpu, AMD_WORKLOAD_CLASS_CONFIG, state);
+	if (ret)
+		return ret;
+
+	return wrmsrl_on_cpu(cpu, AMD_WORKLOAD_HRST, 0x1);
+}
+
+/*
+ * amd_hfi_online() - Enable workload classification on @cpu
+ * @cpu: CPU in which the workload classification will be enabled
+ *
+ */
+static int amd_hfi_online(unsigned int cpu)
+{
+	struct amd_hfi_cpuinfo *hfi_info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+	struct amd_hfi_classes *hfi_classes;
+	int ret;
+
+	if (WARN_ON_ONCE(!hfi_info))
+		return -EINVAL;
+
+	if (!zalloc_cpumask_var(&hfi_info->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	mutex_lock(&hfi_cpuinfo_lock);
+	cpumask_set_cpu(cpu, hfi_info->cpus);
+
+	/*
+	 * Check if @cpu as an associated, initialized and ranking data must be filled
+	 */
+	hfi_classes = hfi_info->amd_hfi_classes;
+	if (!hfi_classes)
+		goto unlock;
+
+	/* Enable the workload classification interface */
+	ret = amd_hfi_set_state(cpu, true);
+	if (ret)
+		pr_err("wct enable failed for cpu %d\n", cpu);
+
+	mutex_unlock(&hfi_cpuinfo_lock);
+	return 0;
+
+unlock:
+	free_cpumask_var(hfi_info->cpus);
+	mutex_unlock(&hfi_cpuinfo_lock);
+	return ret;
+}
+
+/*
+ * amd_hfi_offline() - Disable workload classification on @cpu
+ * @cpu: CPU in which the workload classification will be disabled
+ *
+ * Remove @cpu from those covered by its HFI instance.
+ *
+ */
+static int amd_hfi_offline(unsigned int cpu)
+{
+	struct amd_hfi_cpuinfo *hfi_info = &per_cpu(amd_hfi_cpuinfo, cpu);
+	int ret;
+
+	if (WARN_ON_ONCE(!hfi_info))
+		return -EINVAL;
+
+	mutex_lock(&hfi_cpuinfo_lock);
+
+	/* Disable the workload classification interface */
+	ret = amd_hfi_set_state(cpu, false);
+	if (ret)
+		pr_err("wct disable failed for cpu %d\n", cpu);
+
+	mutex_unlock(&hfi_cpuinfo_lock);
+
+	free_cpumask_var(hfi_info->cpus);
+
+	return 0;
+}
+
 static int update_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data)
 {
 	int cpu;
@@ -467,6 +549,14 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_exit;
 
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
+			amd_hfi_online,
+			amd_hfi_offline);
+	if (ret < 0) {
+		pr_warn("failed to setup cpuhp state! (%d)\n", ret);
+		return ret;
+	}
+
 	dev_dbg(&pdev->dev, "%s driver registered.\n", pdev->name);
 
 	return 0;
-- 
2.34.1


