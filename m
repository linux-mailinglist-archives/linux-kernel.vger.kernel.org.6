Return-Path: <linux-kernel+bounces-554713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB52BA59B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DFE3A2A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A08A2459C7;
	Mon, 10 Mar 2025 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4rtTgXcL"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB44245006
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624883; cv=fail; b=PS74paQIgavblesTMdvbjNFlVMkiLX8Arylkqyfhq4uUFBcVAl0s63aBkcYfTjBzFl1odEZ+9vjJJEB1iyPrVSYHXF6iScO0etjZGZXIJayai1zrfbU/sFzsef65VVEagvP7tMiJpUK8mhPpItQTATvSf+7JRaWXblzBJmwRHgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624883; c=relaxed/simple;
	bh=jJct9cB5vi3B/m2+kL3nnhIeOVvQsLn6DMfmyjSjQrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rO2D5uS/kFf6LNtNMIKJ9NLLmElJHwQGNtuQbY1PcYhiGXMzmmc57fCdEOSArBv9M41x1x+0GAMIe74uz/ANkV8tWFBHXRTHsdtYuNfuNK9qGxgRrByS4jzeBGDDg5NVt5UvAklsFSk2ZrzgSXgk5NYnQ5tWbCw6L925y0bL6dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4rtTgXcL; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMHSXTUSsaoXq848w4sc6kH4myoA1AX21O3oguf2unLWgjRn9VP0voqKzwh54BAnHsvFLTbJYSYpuZDjN9D3xDciYyuolvXjdaP8T9GmrILmZfhCoM51AIFAjPTqK4p/0HiYoYpkUpGeaFzCoR5NBUaNQYhGb+dOH9VVdNNHs/jRCH/4uIbjSk3LUomN5Ai6hP6YkBz01GTIKoz91koYkNVYW9azXsQLiv55cs3IL6CedAMuv2WFfJGeyCPbqFuYhDLuZwRkUlBlGUHkR9LinqHNB3jh8Ti4jV2l8DB7IqHCzU3Qgna5Cf99dTIinJ/pqm7LFCkeRSSt9ANW3w5/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSmgqJpoj0MFr38gouY77aAf9dVJitIpFUj2d3jphjE=;
 b=MIdah0On+AEK/Mu7DMztWV7dvAEACxD4SXSGV6lDOPGc6XieTEy1rVyRDRx8j+EbBPALfxxR4LTeLXBvMM4lVSPekQuyEF+79ieWxClSv1KwaaEX82DpRhyjHyNOKfOeqCZ9ANiRSXGi91LtrOZbREcBxuvrneVDuRr1UO232qeXXL3guHNuWSwIUjfby7460cHtvWktGjADafpFD7FIAg8TE5YHIWxLumb6KXRjCwdsnckq8IbkKttAdkrJijUvBjpJteWf3OePihIv7kd9VQc7wb9sa7f54s6yF3GLv8KA9CFV6MRha83IrD0tX8UCE1RmH3XvniT++RxiRQ71/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSmgqJpoj0MFr38gouY77aAf9dVJitIpFUj2d3jphjE=;
 b=4rtTgXcLw021VJcUeB0q9OqYJBGnGSnC6NAsVshvFyTMnX/X0bELNFbbgZi979y4qce+gdmh3zS3/Tt1WK0dufybGfYVtSWjprOe0w6B/JbMes4lc10bDKbSE0GrpOj6aOQw2VfUXwXmS1QjJrBuC6zTM/GVmKprUVtdKoPsyKU=
Received: from MN2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:208:234::30)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:41:13 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::78) by MN2PR16CA0061.outlook.office365.com
 (2603:10b6:208:234::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:13 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:41:11 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 36/36] cpu: Show attack vectors in sysfs
Date: Mon, 10 Mar 2025 11:40:23 -0500
Message-ID: <20250310164023.779191-37-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310164023.779191-1-david.kaplan@amd.com>
References: <20250310164023.779191-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: efa9dc2a-0ce5-44b9-6aee-08dd5ff25ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y+vcm4iiI/lErc8HZYb+bHY+k11KvLd5QNMr7DAOXYMu8kmvNLmv7VZw2bPt?=
 =?us-ascii?Q?m8XMiOeXKIMdGTkDHrrJZJ++n9Dx8oG798E5iiBpm8Ou++qG1Chskt8PMpZW?=
 =?us-ascii?Q?rxIeR4DjmYTQSuyVtnnQH1unrkBfs5heHNDJ7M2OGhWnoasjranQBtQxjhYy?=
 =?us-ascii?Q?tuDDzmwTApBMSiu5t1k7VuQgywS4LvA/JcgSuVKgEiiSgqIjDljA/Dh/B+0k?=
 =?us-ascii?Q?BLO9zOuOlrsj4pdpSMyjFJlV6yb82AtXQpJ7xq8Imv64NT2Au5MV5cF+eVJk?=
 =?us-ascii?Q?ul8wmWpB/TDAqlvk4nwWNgODOABnDsFN/UUJB+DmKqhR+Tb9PEuw+s29yS2s?=
 =?us-ascii?Q?XqMZ/jxYn4KQE2p+VTphSuYCK5yyDTVXYZ+WP3g3AtKHdJp9qay4K4EEQoD5?=
 =?us-ascii?Q?xy1VKYfF5DyMi3pjIpR1IzpiaAZ/f8L3DSIA9Mvo3HPGjnwM3jd32BkzyXRV?=
 =?us-ascii?Q?41SatfeIbU8peNfDsTYnIZoYiESua+BaZtwI62KKJ+dbPHyUFDnW86B38Jqa?=
 =?us-ascii?Q?R0TjSoBBSg78gtLekc6opx7ODZyr7k/ClJvgd64Grdl8C0l9fKkLyW/cHul2?=
 =?us-ascii?Q?mvECKDdP1tGmgdU9aNk/2bxkWtpfc9wKyj4jE2drh9As1AI/pJaCorqxEya3?=
 =?us-ascii?Q?VLTZMSP3VZBZAxek2ENrsENyNHmeguv6VSIEOIHirikrCQsD762WvQ84KxPG?=
 =?us-ascii?Q?c0IFo1j5S7syB2gADhRu+o099FxjoYsdy1XZkQtquiKoFC5nGdc3Vn+Gs/k9?=
 =?us-ascii?Q?M2NV5/xg6HvhcZXnx2VGzRpmYLL3X8ahnOEsyVhnEzUHSHYZWqLLhz4TeHq+?=
 =?us-ascii?Q?wNDXp8A8txqagASzvXd2aEMkvkcmxMxjpqVOEOlff4o+4PedQC0kFk9wDs0K?=
 =?us-ascii?Q?fHHSDSTyGmgIE4FSlkQ+/+LoKJAirBXb50wHsd9pI1hu/kPxZM0uh7Y24Fla?=
 =?us-ascii?Q?7+clCEeqqMRDZVJo6X173q1O9SIYizINCUbEpB/9yn2CRwafTcJrls4znI3b?=
 =?us-ascii?Q?cl/aQE37Dg9GE3Zy+qd2DjsQWjfPTxdKez1VHK9LQBFalLLUAfIGtHTMX3gb?=
 =?us-ascii?Q?GjMJKyuieydoB/1JLJGwVXLizeQXXi2cKZS+swxZ8kQbOCs/NW3f80NBJ80h?=
 =?us-ascii?Q?R0HJ1fjKX5dNNgtZ6q0BOz8fs5+Mk55jtCw5fdDGQOag3hBq6y4sZqw56rv1?=
 =?us-ascii?Q?gBgPVckX4m37zjv7DWLAtsuv8EXrTgg2s5M64FXFFXNKv9qNZclwXAnlhhy/?=
 =?us-ascii?Q?A9xQ1aO2w20xlgNuCHWS8Dpn1dt0iUNaDEiSw1AqQGTEA+++wxwqxO9G5AF6?=
 =?us-ascii?Q?COhcqQ3tYjuUCeOTjKX8JCN+VjYSquz6nAs91RRF8QwA9HXpB0U+k8kYppO7?=
 =?us-ascii?Q?wmthlINQ1pOnb2nB50nCMrpiZajwMD/KmaURVfMSBrF7d/uTJv0x8VRiGJi2?=
 =?us-ascii?Q?PL+CE3x4DFqkMV9JzcwXCBtL1NwtaE4RCRmtzmg/g+k3DMu34Tkc3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:13.3778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa9dc2a-0ce5-44b9-6aee-08dd5ff25ed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067

Show the status of currently mitigated attack vectors in
/sys/devices/system/cpu/vector_mitigations/

Note that these files are not under the vulnerabilities directory so they
will not be printed by 'lscpu'.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 drivers/base/cpu.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index a7e511849875..e9bb9c3edf91 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/tick.h>
 #include <linux/pm_qos.h>
 #include <linux/delay.h>
+#include <linux/string_choices.h>
 #include <linux/sched/isolation.h>
 
 #include "base.h"
@@ -641,6 +642,70 @@ static const struct attribute_group cpu_root_vulnerabilities_group = {
 	.attrs = cpu_root_vulnerabilities_attrs,
 };
 
+static const char *attack_vector_state(enum cpu_attack_vectors v)
+{
+	return str_on_off(cpu_mitigate_attack_vector(v));
+}
+
+static ssize_t cpu_show_user_kernel_vector(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n",  attack_vector_state(CPU_MITIGATE_USER_KERNEL));
+}
+
+static ssize_t cpu_show_user_user_vector(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", attack_vector_state(CPU_MITIGATE_USER_USER));
+}
+
+static ssize_t cpu_show_guest_host_vector(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", attack_vector_state(CPU_MITIGATE_GUEST_HOST));
+}
+
+static ssize_t cpu_show_guest_guest_vector(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", attack_vector_state(CPU_MITIGATE_GUEST_GUEST));
+}
+
+static ssize_t cpu_show_smt_vector(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	switch (smt_mitigations) {
+	case SMT_MITIGATIONS_OFF:
+		return sysfs_emit(buf, "off\n");
+	case SMT_MITIGATIONS_ON:
+		return sysfs_emit(buf, "on\n");
+	case SMT_MITIGATIONS_AUTO:
+		return sysfs_emit(buf, "auto\n");
+	}
+
+	return 0;
+}
+
+static DEVICE_ATTR(user_kernel, 0444, cpu_show_user_kernel_vector, NULL);
+static DEVICE_ATTR(user_user, 0444, cpu_show_user_user_vector, NULL);
+static DEVICE_ATTR(guest_host, 0444, cpu_show_guest_host_vector, NULL);
+static DEVICE_ATTR(guest_guest, 0444, cpu_show_guest_guest_vector, NULL);
+static DEVICE_ATTR(smt, 0444, cpu_show_smt_vector, NULL);
+
+static struct attribute *cpu_vector_mitigations_attrs[] = {
+	&dev_attr_user_kernel.attr,
+	&dev_attr_user_user.attr,
+	&dev_attr_guest_host.attr,
+	&dev_attr_guest_guest.attr,
+	&dev_attr_smt.attr,
+	NULL
+};
+
+static const struct attribute_group cpu_vector_mitigations_group = {
+	.name  = "vector_mitigations",
+	.attrs = cpu_vector_mitigations_attrs,
+};
+
 static void __init cpu_register_vulnerabilities(void)
 {
 	struct device *dev = bus_get_dev_root(&cpu_subsys);
@@ -648,6 +713,8 @@ static void __init cpu_register_vulnerabilities(void)
 	if (dev) {
 		if (sysfs_create_group(&dev->kobj, &cpu_root_vulnerabilities_group))
 			pr_err("Unable to register CPU vulnerabilities\n");
+		if (sysfs_create_group(&dev->kobj, &cpu_vector_mitigations_group))
+			pr_err("Unable to register CPU attack vectors\n");
 		put_device(dev);
 	}
 }
-- 
2.34.1


