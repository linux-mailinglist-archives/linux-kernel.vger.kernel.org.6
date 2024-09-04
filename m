Return-Path: <linux-kernel+bounces-316049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F4696CA5E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB63B20CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62699188A36;
	Wed,  4 Sep 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cB492ZMh"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF6188A17;
	Wed,  4 Sep 2024 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488674; cv=fail; b=d1xLv16ZbDZmHoxlrcnRPi9EBIERpXwZuVK2m28Ivg6b5/WCKdMcQcO0ZLUOcB71gwipilSPkhJk2EhRAEf5NFdORBNt+pF8TFuWmYajwnqhSRi48qpQvkUI5bmPuIWOXDxSIFfc+YbcLxaTCMJCFQnMX8RYKQNyM3n1yQ6UCaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488674; c=relaxed/simple;
	bh=os/VL+bOHfpcgREyLVmzJHZ+yUzTqkmxOySdxcMXDIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YB0f1D8lZxYhm+UT3weJwVp+GSuARiY9dzV0mALTgdphecPYpgPKsB18/GMg0EdYd3Ar8uPsyHzWcOxJLojmkH8kvToumigoCWRepGFUEksiDDeRES43Sps0UzBonas7jJP3VEfyFLnrC5HytAQqvgr/KdKLKfJbeBCsXDPNW8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cB492ZMh; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okpTKhc1gM7MM0IkdaoelY3pkNvauS7Vajjc1KLbVxmRVqfzPt+GgjkduVRWWsw2nSjnDg0gLGDqgFV0oNtECXkEZDEetIiAuT6fp4WWsgzJ6nuetB1Ht+6aVDh0JAPmLjebumZFvsS22DwxZ4E54gL3JAbewUE4wcYpvzLP9OgxhPfavhGTQR03sKkoerUVr0Yzp/n3Bam6TP+mF+z6WEm4BqaFubiBhXuVZb2GHzIuSPYOvNNOa8IvLxExez2krs+V+gNyyo+ACq+8Siv4QObY/3EHhF84+0IlT3whyGHgbqS6zZglkTUjnagsHLdqVSYmaVcTGlIRwLGhylbpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFc+ioCO3gQl9zxtFxjKTlkgib8mrb3BFYrgAHwZM7U=;
 b=bjk2zYV6NnEXuO5oc6XQ3+l749vut5Fq2f72LS6KUiL76IH1iZAWJoTe+MNfUKLwd4TPj3UNzRSxVQxJ+C5r23WKlUYMJ1+b2KZPevKigZGZJKdGEdEHncr5YI277NWiXgawVdNNmJuSxOzzNdhbUJ4C1cAIUvfgp3weabqeizNC5GlPetWtXeybSg6/wRrfsL3xS3XoiEOFB1j1BXoPT1dlboGA8YGKvq9a71YENO7epfWVZb1HQ83uNaLTVMa2xv5/ajsyiHDuTzz4wv+SQeR7MEOoaWxfdVHfFe3r9/s61MARabp0KeqqZhBqh5sht7R7wF0BgZ/Ac6up4y83aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFc+ioCO3gQl9zxtFxjKTlkgib8mrb3BFYrgAHwZM7U=;
 b=cB492ZMhrdvEV4zw88+YadiPDYJNfJN3cNvPJHPzuMnJJY4FKSJtksIGvSlnmETbVRS2f0BBWzCaDqaCn5YA//f68YZwFEU0ckMOP9HT09EjbTFMww/A87VJsGFWSGEoOTD6a6GxJzPy3hqhx9+G4YHaxWK1QuOcKz53KrurcA8=
Received: from CH0PR03CA0410.namprd03.prod.outlook.com (2603:10b6:610:11b::22)
 by CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 22:24:26 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::b1) by CH0PR03CA0410.outlook.office365.com
 (2603:10b6:610:11b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:24:26 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:24:24 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
Subject: [PATCH v7 20/24] x86/resctrl: Introduce the interface to switch between monitor modes
Date: Wed, 4 Sep 2024 17:21:35 -0500
Message-ID: <812a04c41c66824a212c2dbd30697fe0cad71523.1725488488.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725488488.git.babu.moger@amd.com>
References: <cover.1725488488.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: fe44ba0a-a0fe-4dd3-6c23-08dccd3055d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JUcqRJlmeUw7+wX5qWldyD1Kl/GVhiTFt0cXAOLUEBotqE938Wc4DmtTdJH2?=
 =?us-ascii?Q?FJqe+pKl5lS2aC/O1TI9Z3v+e38rXpHI/RyDvas2N2S/eIYJxvzbzsvmDgR6?=
 =?us-ascii?Q?xyasJPz6E9MmD44T1uEdjfuNHSrpBR/bBMCwQBF8Jt7G00dnsgkB2ClhaFRU?=
 =?us-ascii?Q?DLWUL69J8uXeNsBNriKCPfkXVciZh5KUJ3DrGPxLnmDZA7CZv1aLf9f4qcXO?=
 =?us-ascii?Q?65KX5oCwWxexT00AguyhxroADzfjkDc+H4ozHid9zap52QbJzi8KR3vsFAg4?=
 =?us-ascii?Q?XJLbRDBqEnCkJ6iNbqdKXPU0yDWrEsFtQ/z2gjRdIBNXDTkJDjEhsrkGF2Vk?=
 =?us-ascii?Q?oA/Lc/H2CeITfSWHE8bQV+gBxfu14oXkrWvFI2XpkLLADyJ+IQu3sQQHg5wv?=
 =?us-ascii?Q?Gdf1KJE/D4RecbKV7eKQxqrzaB26XOPTL3ETUg1JgwF8ewxXGgpTbhpNaqvv?=
 =?us-ascii?Q?W5xqQHqRgncC2i3afU6cIamAFG1pl/XCGFkbmXHaU0fM0pqS359KgWntUO82?=
 =?us-ascii?Q?2UQ4uYFB82CpSZrOted/hxTprSbDCnZlpupMsq71cB5eIaAm9+AE5h0DvSQo?=
 =?us-ascii?Q?1w9rNfTWY5YNlVi87hsv3LAeuD1JmMp0fpnA7RUatT/hrffHIFk6YVu9XB5P?=
 =?us-ascii?Q?Ge0LO7YM3+qc32Ix69wIOYJBW78yi62fYml0HSEpL7HfpP9CU8eLsCofxjQ2?=
 =?us-ascii?Q?4fNz3t7d+3+/+wvq1Cmor6+SaMCkq5Mp7CBqNXo55+dCfvinIyD5B8MkzU23?=
 =?us-ascii?Q?GUUMpCLC+dZ7651TwyrMXe57lQO+48GIKGzz9/uPJ4qaWXGM3mdMQpLF1x5t?=
 =?us-ascii?Q?/j83ZPqcT+Y0RwVYolsg0u+cBCeHIjuCtfKCaSqRmu+Vo2xCjSKOxIgxVWW1?=
 =?us-ascii?Q?yk9puqF7q9U4+GKpza4M3qJTz7z36oAo+yjZKWnjDP3iXcqg3iRbP3gG87Tx?=
 =?us-ascii?Q?oIddsWYKXkcCfP/gnd370V0Kuvt6cectBLKE5Ox0SoYNOril0iM2usnHe/mx?=
 =?us-ascii?Q?/Age6zIIwB+VC1mVcIFFj1y+EaIJS2d5ryZTob99MVRnC8xiA/vI7jJvxTZs?=
 =?us-ascii?Q?yQ/hNZS/7BfjDmdtWgjtk/9+qThaF2mtsttX92nJV8iusMtc4YaM5W1Dgge7?=
 =?us-ascii?Q?oMhBtc9mupo/nEN4DpbnHvoVMUm4FbQjJOXcoZ2SIP4IvGvSdT0TllTTGwMT?=
 =?us-ascii?Q?/IDc6DgcsSpX4TN27jsn+oQ7QRShOpjKTrBmO1pc/JDLqensTITeMQJarMHp?=
 =?us-ascii?Q?mcksFRhYrh2YvZofK8NscByEm+C3myqRox0Z5IdmoMV00Ssp8bMygdcEw3Yu?=
 =?us-ascii?Q?/YMHH3Bw5es1xuQNUiSwsjIUn220xme6z+tMZX1n8dClOUF3dZs3C248S5pJ?=
 =?us-ascii?Q?5RL28TGOnuXa6rkPJPh99+AuSprTo1RYVdZEXlT60HhZYWJRGFRoX2A4WVf/?=
 =?us-ascii?Q?6D+q7ekEBkpoe6qqgDYm2Ypjtd8RmiMr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:24:26.1292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe44ba0a-a0fe-4dd3-6c23-08dccd3055d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730

Introduce interface to switch between mbm_cntr_assign and default modes.

$ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
[mbm_cntr_assign]
default

To enable the "mbm_cntr_assign" mode:
$ echo "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

To enable the default monitoring mode:
$ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

MBM event counters will reset when mbm_assign_mode is changed.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Changed the interface name to mbm_assign_mode.
    Removed the references of ABMC.
    Added the changes to reset global and domain bitmaps.
    Added the changes to reset rmid.

v6: Changed the mode name to mbm_cntr_assign.
    Moved all the FS related code here.
    Added changes to reset mbm_cntr_map and resctrl group counters.

v5: Change log and mode description text correction.

v4: Minor commit text changes. Keep the default to ABMC when supported.
    Fixed comments to reflect changed interface "mbm_mode".

v3: New patch to address the review comments from upstream.
---
 Documentation/arch/x86/resctrl.rst     | 15 ++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 74 +++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index ff5397d19704..743c0b64a330 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -290,6 +290,21 @@ with the following files:
 	than 'num_mbm_cntrs' to be created. Reading the mbm files may report 'Unavailable'
 	if there is no hardware resource assigned.
 
+	* To enable ABMC feature:
+	  ::
+
+	    # echo  "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+
+	* To enable the legacy monitoring feature:
+	  ::
+
+	    # echo  "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+
+	The MBM event counters will reset when mbm_assign_mode is changed. Moving to
+	mbm_cntr_assign will require users to assign the counters to the events to
+	read the events. Otherwise, the MBM event counters will return "Unassigned"
+	when read.
+
 "num_mbm_cntrs":
 	The number of monitoring counters available for assignment.
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index bf94e4e05540..7a8ece12d7da 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -895,6 +895,77 @@ static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static void rdtgroup_mbm_cntr_reset(struct rdt_resource *r)
+{
+	struct rdtgroup *prgrp, *crgrp;
+	struct rdt_mon_domain *dom;
+
+	/*
+	 * Hardware counters will reset after switching the monitor mode.
+	 * Reset the architectural state so that reading of hardware
+	 * counter is not considered as an overflow in the next update.
+	 * Also reset the domain counter bitmap.
+	 */
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+		bitmap_zero(dom->mbm_cntr_map, r->mon.num_mbm_cntrs);
+		resctrl_arch_reset_rmid_all(r, dom);
+	}
+
+	/* Reset global MBM counter map */
+	bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
+
+	/* Reset the cntr_id's for all the monitor groups */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		prgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
+		prgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			crgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
+			crgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
+		}
+	}
+}
+
+static ssize_t rdtgroup_mbm_assign_mode_write(struct kernfs_open_file *of,
+					      char *buf, size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	int ret = 0;
+	bool enable;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!strcmp(buf, "default")) {
+		enable = 0;
+	} else if (!strcmp(buf, "mbm_cntr_assign")) {
+		enable = 1;
+	} else {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("Unsupported assign mode\n");
+		goto write_exit;
+	}
+
+	if (enable != resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdtgroup_mbm_cntr_reset(r);
+		ret = resctrl_arch_mbm_cntr_assign_set(r, enable);
+	}
+
+write_exit:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
 				       struct seq_file *s, void *v)
 {
@@ -2107,9 +2178,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_assign_mode",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_assign_mode_show,
+		.write		= rdtgroup_mbm_assign_mode_write,
 		.fflags		= RFTYPE_MON_INFO,
 	},
 	{
-- 
2.34.1


