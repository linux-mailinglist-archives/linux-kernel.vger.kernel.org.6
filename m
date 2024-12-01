Return-Path: <linux-kernel+bounces-426651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191FA9DF64A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59C8281A3A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3E1D63D2;
	Sun,  1 Dec 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FF0fC2z8"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86489AD5A
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067585; cv=fail; b=Eqr3fwdfEbL38dAoIDvi6ju/vikjcRpLIyh8hyiwleca6FrJwBJcFGOsAae5NyvXMTtAyIJHLD3c74WAo3prOPfz3Nr+ihK4C0GE0vlQlyPTDXr1Eom6vxxYpzrZs3KkQQIXo2wEn+RI47CCNGvERmsMDvT6vcAR9GBS9cvHNXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067585; c=relaxed/simple;
	bh=zTxbnYSIPRZXkCY/xG3gA0h13UEazWNchmoHqFQj33A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlyD0L02JYECydi0/4co2YXxBNP9JRJBzAlxts7BQlyJFf9qTZcmJ0jatNFcse62Aj2eYkWYs+0Yjr50Gh9EUnB74JxerYTqqYpN32u9P0wOX5CJTRIlWh8CEk36zkulm94SD3oQbupfRoTJ/8ubc5ZNTtncBDjipbGS06Nsdlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FF0fC2z8; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoD2Y+XEZmHfUC6Of8IQQ40/WNMF3+fWXmqquEfCmQYi5rhPBJrzmy34f38LONBtBL9REkosMMnPjPtVuMhL+LVsglxz+tUtVWxCn66JcHwWRbjlPU+LjHeQtiXUXFwBrjNOHVWoYnXef/edi2ZXf9HryfT8jPyK47MO+1DMG7Evg6JslU/TdexeoxQCeYEM31iKrWPZu3GH5DQ6PPiaL2moQZn9s/E6rijN9v+Di9yXMV8OooulyoGWk86Nc99Ux/ups8dNATiNz8j4OYKJY7SZa1kK8Lane1u2tXsZ0weVf9Xo5IKx9S7Kp/yI7waKylKRR/XYAVWQd1xBmm436Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+xaFjNavCQ6nXnpTcSddvD7CT+2Vhgf2Amvg+doJEk=;
 b=AXojOOOMc/mVv0JOIPf+Ft3rhk48GkDg1TcTdw2c47TRdCVcxDuR4djf2LQKXToenvl47VZ1mKXKU/sD4UR0KXu8mqzp5ItuO1FX1JT1L6O7v8yJIQv08u30D/P7guU7n6BiOQr3S16/EDYVrs2YMvZGxD277La6g5iWb08etB1W2eI0lkET0voiEW7Sb66iItjZwWFEbhoO9wKtsY5uyhGmEJKLhguJp4c3I7VOXC6Bs02PCUQQIZTVEonL8D/NP5sIiUkygPG6KH9xF1MKJ2wTQAlOqq3DXgyL3Cx/cc74Y2odaJC4Bsynob/qIMRvcGWfVbbVKryCBHP4wv+fyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+xaFjNavCQ6nXnpTcSddvD7CT+2Vhgf2Amvg+doJEk=;
 b=FF0fC2z8eCpx7yojIIXtBaCkpMKP9yXM2RZm1wSH3IAWF4k2z2LtEwSs3mj4ZV2Hc8nVYsDJdM3Vqkr/bWYAJdBU1IZsQnXTl0UUQp9icZLJoocVHNkhNAZP/+FvoGj8o+wFuC48pjfCZRPYteaeX3Z1rJa0YNt3MdAseMLplrM=
Received: from CH2PR07CA0065.namprd07.prod.outlook.com (2603:10b6:610:5b::39)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sun, 1 Dec
 2024 15:39:36 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::d0) by CH2PR07CA0065.outlook.office365.com
 (2603:10b6:610:5b::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sun,
 1 Dec 2024 15:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 1 Dec 2024 15:39:35 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 09:39:28 -0600
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <gourry@gourry.net>,
	<nehagholkar@meta.com>, <abhishekd@meta.com>, <david@redhat.com>,
	<ying.huang@intel.com>, <nphamcs@gmail.com>, <akpm@linux-foundation.org>,
	<hannes@cmpxchg.org>, <feng.tang@intel.com>, <kbusch@meta.com>,
	<bharata@amd.com>, <Hasan.Maruf@amd.com>, <sj@kernel.org>
CC: <willy@infradead.org>, <kirill.shutemov@linux.intel.com>,
	<mgorman@techsingularity.net>, <vbabka@suse.cz>, <hughd@google.com>,
	<rientjes@google.com>, <shy828301@gmail.com>, <Liam.Howlett@Oracle.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, Raghavendra K T
	<raghavendra.kt@amd.com>
Subject: [RFC PATCH V0 07/10] sysfs: Add sysfs support to tune scanning
Date: Sun, 1 Dec 2024 15:38:15 +0000
Message-ID: <20241201153818.2633616-8-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241201153818.2633616-1-raghavendra.kt@amd.com>
References: <20241201153818.2633616-1-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e304cc-4097-44b1-a8f8-08dd121e5be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wlHk46/nKVXwem+HsIADIuIkA93XzVkjCjnEyGR8bIfKg8h8iWPwq1Z3pHs8?=
 =?us-ascii?Q?qzkCFa119tVA4tlqWCFq6HbCu5j9vn2VHIKT9+8+0GPD0gbCrxgMTGieRm8g?=
 =?us-ascii?Q?ZkWWrqbVJhxh6uEjtiU40/GnWwOuJWv25u0b9NJaPV4+qQY4KhXb1Bmd6GaP?=
 =?us-ascii?Q?QM2EPrkJ5xVvHl4vlIdYauVYp1c6BgqEW6fguc/AtV7gv6tcX0ngoIjL/BxC?=
 =?us-ascii?Q?6ZDYaVZ5903JB3reLHmw+49SCPlnbwPRKBojHbthofumaoTb2c32EUCohKuW?=
 =?us-ascii?Q?oXsQz8F+RvANP7uEbXPiDT8kPpUzkpHPMGWUqi0N39cEiKUTD8TfMfGf438b?=
 =?us-ascii?Q?zvkmq9tNH7mYPa9T70bSgpdvvhtWy7kdPEzW9HwBfwIsC0gnfASZ/mdOVnHQ?=
 =?us-ascii?Q?uHehvQsIik8mVmP/jpEoCYYE//VuGUpm0nuhUjfXSmxQDtevRareViDabiRa?=
 =?us-ascii?Q?UagF7gSxXnPoxeCUCo+4dwViU6JPNeAr4slxh1WMGItZoDngubrY65SxQDWq?=
 =?us-ascii?Q?uWIiqkjRDNUi2ZW6pYlgn0y6R6gNp1HRbFjOzjXYqOTQfTHgOkzsguJ0m9ol?=
 =?us-ascii?Q?bzwVK+dOsXTLSbEEP19F+WcxLL8U30/CRh4Nf+1uuMw706z/nK5GIOV98TiS?=
 =?us-ascii?Q?4tr9JUBV3fFGDhQ1TEsbUycXVPgEIpltgqUH6oxzWHIAC5inA92UUjOCfBrD?=
 =?us-ascii?Q?9aevBb14aTuZJqZswg/V57GXiqAiVwGhWpKIq1kKOQBRmv0XYPwGw00V799N?=
 =?us-ascii?Q?NOVtrLo1kphicL3Z4PxZMA0xzawdbqsuSkkbrxoUPef5E4VpeHL1uv0Iuw6V?=
 =?us-ascii?Q?H/u4R650ko5ScRCklskZ367YVTqvWY8cwX+gWtoEARluP7eznRh2G5Z+8+7T?=
 =?us-ascii?Q?mrDE75Yo2CXqXgaMAAU6o2Qhmo1q58dc21RrPhrM3Syq7SD1tzihQLtrLHuP?=
 =?us-ascii?Q?khLJ05WW+qLdCAr8gLqfY2sxd+USfOPmoqjWcYRg+TwtKRgO2DVCEafCLZBT?=
 =?us-ascii?Q?E7LDPIhdp48dm1pcHYJYkrZuvTPiEftqRwIa3FlYA5/3fPr6JeMIIEiaj3Bh?=
 =?us-ascii?Q?ZGQUnPmuiHwQ/GHM/2w3RND/Y+GcVeq/puUR1xjsJTypQIuajbXcs8U/blNe?=
 =?us-ascii?Q?PjsSxJxSmilEyLu9jZZo0LNqnVitakbtEi4N2Y2UR0otGc36Y1Ux/r/nwsTm?=
 =?us-ascii?Q?b8tsYSDAyHuEyXNrgDTCwHO6MZG98ugR3B4y3jeTLZCnt2OQKslXbow9YQHT?=
 =?us-ascii?Q?6Ba+zJDYVZUJorIL799XJXOkTLeU6uEYgvJY1UPXWH8MAf2VaAB/nYSlUPU7?=
 =?us-ascii?Q?oy6rEw62bvHiR/ciKGoAE+E08j5hbHtH9QEakbwXVEojr/zlQdpelxRSoRLJ?=
 =?us-ascii?Q?sNJk3e5NF0aSmIs/OreMVx/tEEj0hoOF6/1YsoMD45swEHW2NA2PmS5tW/8A?=
 =?us-ascii?Q?By01QVGGMUgug/xK+DNWPDVp+R+LaRWT66w3o1CyeaRbIsub0mePzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 15:39:35.6055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e304cc-4097-44b1-a8f8-08dd121e5be9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108

Support below tunables:
scan_enable: turn on or turn off mm_struct scanning
scan_period: initial scan_period (default: 2sec)
scan_sleep_ms: sleep time between two successive round of scanning and
migration.
mms_to_scan: total mm_struct to scan before taking a pause.
target_node: default regular node to which migration of accessed pages
is done

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kmmscand.c | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 2efef53f9402..344a45bd2d3e 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -20,6 +20,7 @@
 #include <linux/string.h>
 #include <linux/cleanup.h>
 #include <linux/minmax.h>
+#include <trace/events/kmem.h>
 
 #include <asm/pgalloc.h>
 #include "internal.h"
@@ -114,6 +115,170 @@ struct kmmscand_migrate_info {
 	unsigned long address;
 };
 
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
@@ -738,9 +903,43 @@ static int kmmscand(void *none)
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
@@ -857,6 +1056,11 @@ static int __init kmmscand_init(void)
 		return -ENOMEM;
 	}
 
+	err = kmmscand_init_sysfs(&mm_kobj);
+
+	if (err)
+		goto err_init_sysfs;
+
 	err = start_kmmscand();
 	if (err)
 		goto err_kmmscand;
@@ -865,6 +1069,7 @@ static int __init kmmscand_init(void)
 
 err_kmmscand:
 	stop_kmmscand();
+err_init_sysfs:
 	kmmscand_destroy();
 
 	return err;
-- 
2.39.3


