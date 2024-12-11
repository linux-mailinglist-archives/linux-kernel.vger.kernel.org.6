Return-Path: <linux-kernel+bounces-441963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D9B9ED622
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046901646FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A95C23FD3F;
	Wed, 11 Dec 2024 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r3XSz09c"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCD623690B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943431; cv=fail; b=nDT76gWfkv7TzQL6VRanRhGxMFRWDEX+vXrqpumsDuT/dMHCamH/ThVShX9vDoN97hMTiyhhm8j5QDj3MPL+wfag1xBAGzI9HAYK3FJkxIXuQq1KP9fxwExU5gYRgtUZRfSIsqxYaKO9FTfInrsQz/28K7S+W4Jtv31dQoOnpLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943431; c=relaxed/simple;
	bh=oifstS/3xdu/TGwcVv/W0X5NywSY9pGBpn2NbnLwLTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTGZvat66idrXrSy+Rd0L2F8/PK8SvFYtXef8mWyjbE8Wg6WzGLvP6lMnlcdXlwmbXcrDWny9H0/3MEsYjSKqEf67upBvlztGHbz+nS7gXhkUqgAkaymmUFw+ZqlJNwA+cUjaR4ngnzx5UeVAR+tYy0vX+vb/9IO/rY6XZcYW+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r3XSz09c; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxgznX3VjbJtCh+fgrY43zStCrgC4jUoUVX5fD3eAmtZ+jxB7vBlSHTqYYQHtfpLprHXXqCqlrZMHBtlqVwgtW4xtIW2KEALsAUgPD6vGPJNepK8aWtm7Kz+fTTj8beuBasgsmG13PunazEnigkE2IBvbs2xgtFLaF7LEhsw+4KQ8B+EdQm29DlYCIYzUkSNY/+X5YAlt+3u6WAQHc7Kd3s8vf2Tjek0qB02r0O6puAmVrUA3jUEYy5yqkoDOyk9cVe9PgaMhOxjai5IJvWw4bAWhjUFPjwQTfCHL0mKo4h+RaLHTOItwSSX9dvCrmlXfvJsTdgOa7u3iiqQf7nnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5H2GKciuTg/W4k/aysfZfkHNp8qGLg686HBGrF7OhQ=;
 b=L5uWfGAEgc/YQX7+HGe2j+UM56SWblZ5Zmc1iV67Jn2CjiFUZc381CisXEYuKgMFgMKvt7ynSYY3N+svGimkJfuNjjvQQDO88Sf9kJKnITCjRRP6yhihtT5e6I0QTi/ffAmZZUvE5kw4CiPf+zp99zk8j1kJzEdG7Ru01gRLeImB1gXTqOvp+pM4CPmSrP6aIJw/J/lvY5bbDEmqEtHjvvxw68SFPw134G5qpGAUOzfo0bOouqVCJXrpMpIF8hKXvGwi7r2ozHVj1dGBCPsaFQ4Lt/sWYadSEMXjlfJ+c8wTp0HWPg6AAa8pwKyOREo3n8YLv45SfI8wIPyBxBIbbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5H2GKciuTg/W4k/aysfZfkHNp8qGLg686HBGrF7OhQ=;
 b=r3XSz09cWkDHCVM64xSKhfHIpVpPU/B5O1owxa/LcwqgfjFKlaYJfFUdxKX9I8xq/wSfVkCL//JUjqHmY0J3sFrHNKF70UY5dnrYD8+0FNTL+0biwywEGyOBx/UL1IC7PCdsGVAqz9Re5s42Gcr5YUAqPhJilF+pdjtuQq3UEgg=
Received: from PH7P221CA0058.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::28)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 11 Dec
 2024 18:57:05 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::24) by PH7P221CA0058.outlook.office365.com
 (2603:10b6:510:33c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 18:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 18:57:05 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 12:56:58 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 3/8] x86/itmt: Move the "sched_itmt_enabled" sysctl to debugfs
Date: Wed, 11 Dec 2024 18:55:46 +0000
Message-ID: <20241211185552.4553-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185552.4553-1-kprateek.nayak@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 72510cf6-4547-4a16-a006-08dd1a159ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lxe+rsFs4sKvrQMM9sAdE5rkzV9+dAWjadKVOpLH5bw76pcPZAGC0RkQS6FP?=
 =?us-ascii?Q?omp07Og0HPQbmqXmFV4WWjQKmfZqhbaGGjukPgDnZUZ0XDlFdjxqoERxsb23?=
 =?us-ascii?Q?vP24kZSx+DG+q7a8j7Ls6Q711IdvtGcE4iQ5pBOAus1JRP8G7GMxmuM2CWBe?=
 =?us-ascii?Q?w69U6+uxags3WvY/Hy/hfMF9dt7aoDwBve91z0z5RybUUp2HoiYuNtI5IGmp?=
 =?us-ascii?Q?88BuqQrwtt1T7bS+tAfhpdH5l1IR5cPV+i/25z3IS6DhZOIM8db8ERNU62tx?=
 =?us-ascii?Q?qxECF9rjr1P5Jc7K8vY337yvqeBiLVJnlvYX0znHLwZDnz8D22GXdxLb9r/+?=
 =?us-ascii?Q?jOBptkdEXjk2qDAKDS2oJQGPIUrY24tpnYNVhr7TztJ1dIjTI6cP/8TnbFhe?=
 =?us-ascii?Q?Bvzx3Qhvd67mOtwUebftfeWl39OHCutffwchRRLAt6TaaZppACj1x6Yxw7uK?=
 =?us-ascii?Q?s6F59Ovz9ee7k9B8h18xZoV/mCWM6HsmQlo1gfAMK4Uw1PqDmi4oQT/tAYIk?=
 =?us-ascii?Q?Q3/L/stRS+FVXyKpbxoiwtfeqvBsBDViJmkskXcTWdfPutHnAmuHha+AVbWn?=
 =?us-ascii?Q?1NFhxW629ClCGC5ltec1RqjF7+mhl9Nq2gdju3jgX2OsnEG9A835wRhhLpXI?=
 =?us-ascii?Q?pIoXVnLcBrd0ZzVAQ+yUh1wbVuFNtwpajJvfz9BLqldarSLNmNPA8BpUFv5k?=
 =?us-ascii?Q?1L1939ktB6nYMfmDm/nU+/P2ZPzej189eYgd7mFFzojeo/pD6hECwpQe5uf4?=
 =?us-ascii?Q?bpqTKAtXiigZyInJy5IVGmjCjmXlBc97nExT93b22EvmfSWOmyHJkCL3jJdf?=
 =?us-ascii?Q?AhYjXT8tXfjL2qcel2CfW4DcSs4UAP0sQBCm/7JAeQ096nslJr6vrusBgCk6?=
 =?us-ascii?Q?L2eEvi8/pnKdIlUcVcOi6YJWpB26Q7czDFZi21SSBu7rVRE3+BzezuB+1DWt?=
 =?us-ascii?Q?EiWIp64D0UNjHBRUVQlQYafhVK5KHwGSNFBBheTQqkCBHe6fsecFHQNxrfB+?=
 =?us-ascii?Q?QZgchv9h07ni7a5Q8yleUtW/cioXH0UB8ZSY5+cP0jrxPZv9AA2cFxFjTGjK?=
 =?us-ascii?Q?raP2NMloa9/KoQKyG1Efhdx9qf2TFuw3ZgToeFLayxeGIosGQrCV59naWMm2?=
 =?us-ascii?Q?16Plf0yDoqhPV+QKXL13TBqk1YmcYph5Z5SELl7ErtUSl45dB2u8j/C9ehNZ?=
 =?us-ascii?Q?ua5EZKejddooAOUiY1McFEydzlZHTobNsUtt9sKJuc4rDs42uA+zy9j6kvvC?=
 =?us-ascii?Q?Y6La/Z389G3vCvNgOr3gJfY8a1IaWgDGdgToziNDyztNBUknC6nix8UGbF8f?=
 =?us-ascii?Q?xfaa5E8HMM+k4SaJWDjXkRUewBBh0/25IexDjquoP69ZcycXzGKjKUni873Q?=
 =?us-ascii?Q?m33Ob9r66xIJ+izE3D9jXYO4AJHbpM+M5GFsYLoB+iIHcURzmf2l2/l8B+TM?=
 =?us-ascii?Q?NFBzPrDntqHeR3BYG3KEhZ0vt5zUv2id?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:57:05.1334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72510cf6-4547-4a16-a006-08dd1a159ae9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779

"sched_itmt_enabled" was only introduced as a debug toggle for any funky
ITMT behavior. Move the sysctl controlled from
"/proc/sys/kernel/sched_itmt_enabled" to debugfs at
"/sys/kernel/debug/x86/sched_itmt_enabled" with a notable change that a
cat on the file will return "Y" or "N" instead of "1" or "0" to
indicate that feature is enabled or disabled respectively.

Since ITMT is x86 specific (and PowerPC uses SD_ASYM_PACKING too), the
toggle was moved to "/sys/kernel/debug/x86/" as opposed to
"/sys/kernel/debug/sched/"

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/kernel/itmt.c | 56 ++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index ee43d1bd41d0..9cea1fc36c18 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/cpumask.h>
 #include <linux/cpuset.h>
+#include <linux/debugfs.h>
 #include <linux/mutex.h>
 #include <linux/sysctl.h>
 #include <linux/nodemask.h>
@@ -34,45 +35,38 @@ static bool __read_mostly sched_itmt_capable;
  * of higher turbo frequency for cpus supporting Intel Turbo Boost Max
  * Technology 3.0.
  *
- * It can be set via /proc/sys/kernel/sched_itmt_enabled
+ * It can be set via /sys/kernel/debug/x86/sched_itmt_enabled
  */
 bool __read_mostly sysctl_sched_itmt_enabled;
 
-static int sched_itmt_update_handler(const struct ctl_table *table, int write,
-				     void *buffer, size_t *lenp, loff_t *ppos)
+static ssize_t sched_itmt_enabled_write(struct file *filp,
+					const char __user *ubuf,
+					size_t cnt, loff_t *ppos)
 {
-	unsigned int old_sysctl;
-	int ret;
+	ssize_t result;
+	bool orig;
 
 	guard(mutex)(&itmt_update_mutex);
 
-	if (!sched_itmt_capable)
-		return -EINVAL;
-
-	old_sysctl = sysctl_sched_itmt_enabled;
-	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	orig = sysctl_sched_itmt_enabled;
+	result = debugfs_write_file_bool(filp, ubuf, cnt, ppos);
 
-	if (!ret && write && old_sysctl != sysctl_sched_itmt_enabled) {
+	if (sysctl_sched_itmt_enabled != orig) {
 		x86_topology_update = true;
 		rebuild_sched_domains();
 	}
 
-	return ret;
+	return result;
 }
 
-static struct ctl_table itmt_kern_table[] = {
-	{
-		.procname	= "sched_itmt_enabled",
-		.data		= &sysctl_sched_itmt_enabled,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_itmt_update_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
+static const struct file_operations dfs_sched_itmt_fops = {
+	.read =         debugfs_read_file_bool,
+	.write =        sched_itmt_enabled_write,
+	.open =         simple_open,
+	.llseek =       default_llseek,
 };
 
-static struct ctl_table_header *itmt_sysctl_header;
+static struct dentry *dfs_sched_itmt;
 
 /**
  * sched_set_itmt_support() - Indicate platform supports ITMT
@@ -98,9 +92,15 @@ int sched_set_itmt_support(void)
 	if (sched_itmt_capable)
 		return 0;
 
-	itmt_sysctl_header = register_sysctl("kernel", itmt_kern_table);
-	if (!itmt_sysctl_header)
+	dfs_sched_itmt = debugfs_create_file_unsafe("sched_itmt_enabled",
+						    0644,
+						    arch_debugfs_dir,
+						    &sysctl_sched_itmt_enabled,
+						    &dfs_sched_itmt_fops);
+	if (IS_ERR_OR_NULL(dfs_sched_itmt)) {
+		dfs_sched_itmt = NULL;
 		return -ENOMEM;
+	}
 
 	sched_itmt_capable = true;
 
@@ -131,10 +131,8 @@ void sched_clear_itmt_support(void)
 
 	sched_itmt_capable = false;
 
-	if (itmt_sysctl_header) {
-		unregister_sysctl_table(itmt_sysctl_header);
-		itmt_sysctl_header = NULL;
-	}
+	debugfs_remove(dfs_sched_itmt);
+	dfs_sched_itmt = NULL;
 
 	if (sysctl_sched_itmt_enabled) {
 		/* disable sched_itmt if we are no longer ITMT capable */
-- 
2.34.1


