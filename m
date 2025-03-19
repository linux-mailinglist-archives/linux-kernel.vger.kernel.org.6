Return-Path: <linux-kernel+bounces-568703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4906A69979
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844BB466D21
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06659219A8A;
	Wed, 19 Mar 2025 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="228ZUA6S"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E3C21B18C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412769; cv=fail; b=T4a6sN2T2GWuA/bmn0ZqA0PCk3vRcPLLi7eUGdhhb6Tl3zg2AWIdU8AXumdqW2MbROzaW8pqw3TbRkCRznjbHVpmrmUDAh3HnqMKqoco+K7GZx1hshwDxBA3RA562NSkN7LHXfxqRTz9jMBgAsZm+wqkrZaNoBSG8SAMJATxkJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412769; c=relaxed/simple;
	bh=DJO24KfRJWq4+xtlrzWp+ZYa9gQiKx2/IT3dOwYhdRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnD6vvniYUb1Vq3Mkadni0c1Y3OyqNDgeiEFIXnuc4Y1O7CricwWhH9cybNs3CJRcMXO2LB4DTXUPpGykOhEluNlvzdp82LEyjPkUoRpMD8YqeHbc9tyfZoQ+aRtGwM2ZK5OnhPrCVEBMdaWaV+AMh+Gs91lwgXmCp6yX/U7BQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=228ZUA6S; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYjFmh+W2io2rjBHEVxDI9GaaUKZOfDf5MVJ6g/AcjxXkmJ6xKEV05al1ShoP8XYOuHv6t1atVPULsXy50t0RL7ZWpwZmyAi+XrlH+xkd4yVZXOHYF9RzdjMyqTjfG4GrN1ra4Df36Nyhi0k/TYVQAL8GxC46j97IB0NELdxpIMD9JHD7VWYn2jGJEsnuIjcb2BSJ01AzfLWlDBNoDGnM+VgDXUnG4M5AxB7/nKb2ODYBEEpQR9CB7uc3aWTWDw7OJoQjBH3lXR34llP1krMm2kfxq/c3Wm+vPyBWjeS5s7+mW5m7SkqCdPMvNdKtHWPcbKWGmylKaXOe1nJ2pZQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMVd8QbmmNVnERYroypm9kZTSC/0smb5CRgcSN7QW8I=;
 b=gnNADV4GF1XTZncC167hF97yk+H3xBi8RipuLK3gJIReuRJ2+BmiewoFT09r92uAJB+VTR2rWArbOJJ/kFnt/SZhsv3P290XZ3nvpQ+igHYznKvL/eeQQDXWN6p6TIrJfgYzVaKHKM2C/0hscytaTuRs9D4TyhlW3XdE2Suw9qXnxZNR1zH3ZKRx5lnHaXzErFG9twqeDGcYdI4jI+Y5R/7fiyziCdC/4kJNW+eXamfqUKSJtehlJd3Zc2v3/mF0t73yzGdNNrId7AbEGOH8n1iWzQlqFEZLo7bcrE54SHrSwO01Zk7wcO2dv+iFEZ114jHKgigSf7i9mHKNQBhTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMVd8QbmmNVnERYroypm9kZTSC/0smb5CRgcSN7QW8I=;
 b=228ZUA6SiY0sEEmsrKpVoGHg1E07YX7wiZa+7UpI2obR3Buce0snpVjCd3v84qJ6VtklMC/BT8jokyFhM7uV/nvv5hgM97XdFciEa3cxSpXSf22L3MIaQ6miIDmidmgzoAC/W8GP2uxgFTmNLW2JqTnNoEtVi4kynjR3uCuAbIE=
Received: from SA9PR10CA0001.namprd10.prod.outlook.com (2603:10b6:806:a7::6)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 19:32:42 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::96) by SA9PR10CA0001.outlook.office365.com
 (2603:10b6:806:a7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:32:41 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:32:31 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Michael.Day@amd.com>, <akpm@linux-foundation.org>, <bharata@amd.com>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dongjoo.linux.dev@gmail.com>,
	<feng.tang@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<honggyu.kim@sk.com>, <hughd@google.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <kbusch@meta.com>,
	<kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>, <leillc@google.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<nadav.amit@gmail.com>, <nphamcs@gmail.com>, <peterz@infradead.org>,
	<riel@surriel.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<santosh.shukla@amd.com>, <shivankg@amd.com>, <shy828301@gmail.com>,
	<sj@kernel.org>, <vbabka@suse.cz>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: [RFC PATCH V1 10/13] sysfs: Add sysfs support to tune scanning
Date: Wed, 19 Mar 2025 19:30:25 +0000
Message-ID: <20250319193028.29514-11-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319193028.29514-1-raghavendra.kt@amd.com>
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c35ec17-c9d3-4ec8-20f0-08dd671cd0ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d9gCgkgz0Dqnk0NRtvaDMsDCHBlj6IEcm7cax/yWMTCEsoCu86Vq787p/SyY?=
 =?us-ascii?Q?H9CAFSe5TGdhbkVGkygkaDjqmRgVUq6r0DxQtR3wRziWS9tLzBwn5IMJtch6?=
 =?us-ascii?Q?AL2gWrRkFBY+isXKvoIS1uLLzHU3lz53KAs1ShGMCiiHnr6g+Z2JL3dLm0Hm?=
 =?us-ascii?Q?RNrHqcaH94C1nnizTPb+icT8kXE/xg1VQjWiJpDQBHTnF8zEag2kJaw4zfN5?=
 =?us-ascii?Q?nUsTpmziatkA/+a/F5STen8AmqSSMtJuH5Nbku0oipS5ojGcc6F+jeHXd+tZ?=
 =?us-ascii?Q?y323i0zPBIzGBMz7Ojaf+ViCa7OV4Y9pN4CJG3JWk0SyLB1bqDdV8XhTm1Ws?=
 =?us-ascii?Q?G6C7wIGoJlvYIcyIhLPjZZB8erl/g3P888/gi4nprRnJRmVpzqpaNsBB+Dbn?=
 =?us-ascii?Q?axPjAyOoTcr3s7fjmlXO0eHZHRFqRzVCw4qle4MVVaDKEnY3S68ZhFs9irmp?=
 =?us-ascii?Q?0Uhq6btt+pccqSpqPTaFuNHppEIBKdHckgHZdLPimGUO2sfdGunX5IgZVRqV?=
 =?us-ascii?Q?L0XlPqcdGwkXV2tKbvL+MEkdWscgPXfRlEX4IH1n+xV/xpY5m26UAsyUnn8p?=
 =?us-ascii?Q?z187+pmSTKb5T6uCcbcHes2Ly4hzhxva4vwbfbP3gMo1rEKaMVz1L2dRFjZu?=
 =?us-ascii?Q?qX/x6a+RVCqvmQlQK1gIjckjkt5w5XjGIEFJSSioLA75ucFTGKgpwwgpCCuO?=
 =?us-ascii?Q?MFhGUjATw6vpUPgsfoKTVz6ea7xR6v4eBGb7njXiKX4wYlMlU+Gk/COBRUfO?=
 =?us-ascii?Q?MEvk/faY4gC2MHPzfXzuAT6RTrQQzNxAQ+vYyoV45CezyEtYRtwhfckgOr/Q?=
 =?us-ascii?Q?9pAypYJOYdYZdiW6wRVDDUrh/B6F9a4BpUso+sTwWpFXU1RQFQg7SOJD6htq?=
 =?us-ascii?Q?xEfcmwllM3DqaWsTiRfwArNnUNV00VuD5Szzzwlkoo9lIRv2FCAtxgiz76Pa?=
 =?us-ascii?Q?bMmvUxt8Ed6cX1eDX6c9Ic9L0B0QAbo7z8cRvtpykXlPYIGif4cOZZjgiXuu?=
 =?us-ascii?Q?d4y07eTxcjHbkz7+4soKAyiQjQXYjbjZUvJdx/zqotc1RtHIYVDDjnAc5vH/?=
 =?us-ascii?Q?Cau842QSHVcnDhEvRJD+OexsjKv10DpU0bDBzA9miK4tKFlbZu2YFWHVPu+R?=
 =?us-ascii?Q?UpgOLySBOdpVBlk5BCZIeCVaDwv8Rsmzt3dSy5HSgDlHXBzj6GLoa8ln9hZp?=
 =?us-ascii?Q?dlKNX3eVvj18dnfIDbc+eIj7HIeXujRpJaaXd8iEs+FxibM+XWTMe7ZQkIZj?=
 =?us-ascii?Q?FvNt0Kn18eougjJH0gkMh6ebIkDf97wssyhibTdcBJ8w75s1wlqp93PorKTo?=
 =?us-ascii?Q?yZQKqtpPlMSgv1A7pxYXx9XD8nybc96J+MkdkJtOSHxYnR4FfzBuFUMLgseu?=
 =?us-ascii?Q?fochu8clfuqOBtMHNqPRAGJbkEZDgT4ELy6BcYa5Rfgq2VHvIqdvNxIKenmZ?=
 =?us-ascii?Q?FratRa/lJyx8mUqYi16mnwe48ExXM5Qi64FVy3GquY+rMcHg6/urkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:32:41.3162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c35ec17-c9d3-4ec8-20f0-08dd671cd0ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229

Support below tunables:
scan_enable: turn on or turn off mm_struct scanning
scan_period: initial scan_period (default: 2sec)
scan_sleep_ms: sleep time between two successive round of scanning and
migration.
mms_to_scan: total mm_struct to scan before taking a pause.
target_node: default regular node to which migration of accessed pages
is done (this is only fall back mechnism, otherwise target_node
heuristic is used).

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kmmscand.c | 206 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index c2924b2e8a6d..618594d7c148 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/cleanup.h>
 #include <linux/minmax.h>
+#include <trace/events/kmem.h>
 
 #include <asm/pgalloc.h>
 #include "internal.h"
@@ -158,6 +159,170 @@ static bool kmmscand_eligible_srcnid(int nid)
 	return false;
 }
 
+#ifdef CONFIG_SYSFS
+static ssize_t scan_sleep_ms_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", kmmscand_scan_sleep_ms);
+}
+
+static ssize_t scan_sleep_ms_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned int msecs;
+	int err;
+
+	err = kstrtouint(buf, 10, &msecs);
+	if (err)
+		return -EINVAL;
+
+	kmmscand_scan_sleep_ms = msecs;
+	kmmscand_sleep_expire = 0;
+	wake_up_interruptible(&kmmscand_wait);
+
+	return count;
+}
+static struct kobj_attribute scan_sleep_ms_attr =
+	__ATTR_RW(scan_sleep_ms);
+
+static ssize_t mm_scan_period_ms_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", kmmscand_mm_scan_period_ms);
+}
+
+/* If a value less than MIN or greater than MAX asked for store value is clamped */
+static ssize_t mm_scan_period_ms_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned int msecs, stored_msecs;
+	int err;
+
+	err = kstrtouint(buf, 10, &msecs);
+	if (err)
+		return -EINVAL;
+
+	stored_msecs = clamp(msecs, KMMSCAND_SCAN_PERIOD_MIN, KMMSCAND_SCAN_PERIOD_MAX);
+
+	kmmscand_mm_scan_period_ms = stored_msecs;
+	kmmscand_sleep_expire = 0;
+	wake_up_interruptible(&kmmscand_wait);
+
+	return count;
+}
+
+static struct kobj_attribute mm_scan_period_ms_attr =
+	__ATTR_RW(mm_scan_period_ms);
+
+static ssize_t mms_to_scan_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", kmmscand_mms_to_scan);
+}
+
+static ssize_t mms_to_scan_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return -EINVAL;
+
+	kmmscand_mms_to_scan = val;
+	kmmscand_sleep_expire = 0;
+	wake_up_interruptible(&kmmscand_wait);
+
+	return count;
+}
+
+static struct kobj_attribute mms_to_scan_attr =
+	__ATTR_RW(mms_to_scan);
+
+static ssize_t scan_enabled_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", kmmscand_scan_enabled ? 1 : 0);
+}
+
+static ssize_t scan_enabled_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned int val;
+	int err;
+
+	err = kstrtouint(buf, 10, &val);
+	if (err || val > 1)
+		return -EINVAL;
+
+	if (val) {
+		kmmscand_scan_enabled = true;
+		need_wakeup = true;
+	} else
+		kmmscand_scan_enabled = false;
+
+	kmmscand_sleep_expire = 0;
+	wake_up_interruptible(&kmmscand_wait);
+
+	return count;
+}
+
+static struct kobj_attribute scan_enabled_attr =
+	__ATTR_RW(scan_enabled);
+
+static ssize_t target_node_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", kmmscand_target_node);
+}
+
+static ssize_t target_node_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	int err, node;
+
+	err = kstrtoint(buf, 10, &node);
+	if (err)
+		return -EINVAL;
+
+	kmmscand_sleep_expire = 0;
+	if (!node_is_toptier(node))
+		return -EINVAL;
+
+	kmmscand_target_node = node;
+	wake_up_interruptible(&kmmscand_wait);
+
+	return count;
+}
+static struct kobj_attribute target_node_attr =
+	__ATTR_RW(target_node);
+
+static struct attribute *kmmscand_attr[] = {
+	&scan_sleep_ms_attr.attr,
+	&mm_scan_period_ms_attr.attr,
+	&mms_to_scan_attr.attr,
+	&scan_enabled_attr.attr,
+	&target_node_attr.attr,
+	NULL,
+};
+
+struct attribute_group kmmscand_attr_group = {
+	.attrs = kmmscand_attr,
+	.name = "kmmscand",
+};
+#endif
+
 static int kmmscand_has_work(void)
 {
 	return !list_empty(&kmmscand_scan.mm_head);
@@ -1036,9 +1201,43 @@ static int kmmscand(void *none)
 	return 0;
 }
 
+#ifdef CONFIG_SYSFS
+extern struct kobject *mm_kobj;
+static int __init kmmscand_init_sysfs(struct kobject **kobj)
+{
+	int err;
+
+	err = sysfs_create_group(*kobj, &kmmscand_attr_group);
+	if (err) {
+		pr_err("failed to register kmmscand group\n");
+		goto err_kmmscand_attr;
+	}
+
+	return 0;
+
+err_kmmscand_attr:
+	sysfs_remove_group(*kobj, &kmmscand_attr_group);
+	return err;
+}
+
+static void __init kmmscand_exit_sysfs(struct kobject *kobj)
+{
+		sysfs_remove_group(kobj, &kmmscand_attr_group);
+}
+#else
+static inline int __init kmmscand_init_sysfs(struct kobject **kobj)
+{
+	return 0;
+}
+static inline void __init kmmscand_exit_sysfs(struct kobject *kobj)
+{
+}
+#endif
+
 static inline void kmmscand_destroy(void)
 {
 	kmem_cache_destroy(kmmscand_slot_cache);
+	kmmscand_exit_sysfs(mm_kobj);
 }
 
 void __kmmscand_enter(struct mm_struct *mm)
@@ -1223,7 +1422,13 @@ static int __init kmmscand_init(void)
 		return -ENOMEM;
 	}
 
+	err = kmmscand_init_sysfs(&mm_kobj);
+
+	if (err)
+		goto err_init_sysfs;
+
 	init_list();
+
 	err = start_kmmscand();
 	if (err)
 		goto err_kmmscand;
@@ -1239,6 +1444,7 @@ static int __init kmmscand_init(void)
 
 err_kmmscand:
 	stop_kmmscand();
+err_init_sysfs:
 	kmmscand_destroy();
 
 	return err;
-- 
2.34.1


