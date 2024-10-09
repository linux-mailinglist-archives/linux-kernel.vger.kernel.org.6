Return-Path: <linux-kernel+bounces-357614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B481A997353
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E35285893
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2131E1A34;
	Wed,  9 Oct 2024 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nLOB2nmL"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03D11CB514;
	Wed,  9 Oct 2024 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495667; cv=fail; b=kxw4sW2suQXF01ogAKjXxjTJfMKRG3nYgPTV7d39SKnuqQS22vg6mqmbs9MDJIy0L4sVBwcprXijCbUnGeJylIlylHD3pqDfIGm1At9TliwRkz40w9cBgjwbg5LMUQhUzyf8MM2z2/8J0krNnUS4n27uNjFbFTErSQ0Pt7W+9Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495667; c=relaxed/simple;
	bh=Feu6ddTDj54QR/C8nRIHNyHvyoc0ErG9QNFT3HkQ6ig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ned6vpcrV/fG9C4+o61A6swRMogvsdAkGzp3pN7jAnSnbPatNwS4BlHMao1gtvmmGTsx0O/BHwN9/BSkETub9Ek5VsIiBvc8LW2qbFjgIB5XvUlg6+vRVlcc1pt4As7FB62SzqvYiQl4OwPOERWqBP/AWh4j8Xz0gDWqPoyddS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nLOB2nmL; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W59GGZdRBrfKpKtuaROl4hZxGzl3O1K5Mu5WTYF60mCZNmHv7EKtEMVU+hJMijB6RSA860BFq6oo7tg/g0Qv91/TNR4L2CSvGKjVyu6b0Z00LioyxYd1GuG10IZxEa42x4+7VQdDdL0J25VAuIwNIM6ZOQHBk1DZaUpW8MeeykPKdbmiBUInjepSZaNEZXc96Ip9HoZTvGLRQf//eZloXVN+pXkLqLZjuRbjMA6TDaLOIwZcxS5Fi5/xLskIX7TDPeuQW4wwIBdUhy+JKTGElt0oDGayFxIymO0BlPno/R8T9EkQMVlhVZlf9NFJID5yKLaBN5qDe2h/Xsg0Dhf0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjBoGVFn+Ct6TkVfUTvpbH/oBmv0+rT0iC0OJQP/Mv0=;
 b=wzTUqbRDmfyrWkvit6zZzThYINZ/C8J5VrurIsP2ohqniLlCkJ7JeDZ9y5Ccv5g2AykDQmKxfelJf7THBsV+hkk4wlc8r5JkQIoLUsyzKGQmxh2s4aKbV4GXbo/PL0RB9aPbukTDRBO5ABt2dcoFZ9VFXQEto0P97SuVSBFhE+I1/AF83whmbEgCl85ajEzsWQFFV7CuS6Xc6sM5K2bhpqD/JnY6p5a3GyamRJNl8m+VOSz/vcl2BiXrMCgyHZc5VaGFLxijKDYepuTbpcMcCDzaE563vhOMB/Ht22qvn+E+leZyv+Kp7aU6yr879EDdE5/J8TxEsamqnW5wjDP2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjBoGVFn+Ct6TkVfUTvpbH/oBmv0+rT0iC0OJQP/Mv0=;
 b=nLOB2nmLxg0Uq0xdiyOod7hvDIr2N512zqQTzdWiHjM1wWk0mlNzdFWUucad1KCWdRfsXMoHLChOt0BJVUr3ia/L3g2oda5ErK41Qm0RzbynHSaPZ0+ESa3Ljdi1qNeL2YoYqcV0SaLhfn9TJ0KbMkUaRntITBAA+mXtN+Om6bM=
Received: from SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:41:02 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::53) by SJ0PR13CA0176.outlook.office365.com
 (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 17:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:41:00 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:40:59 -0500
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
Subject: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display monitor mode
Date: Wed, 9 Oct 2024 12:39:32 -0500
Message-ID: <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: e43023cb-8972-4ecd-fcc6-08dce8898a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ND8nkpakGUnt2tTQqbVCDxu1GhhYHKaHgm7hCFAd2azawN+dT2yvSmuiuuPy?=
 =?us-ascii?Q?hZZSUAxo/UoxPefKMivyhj4M9fJgfpFo5XDtCqFj1zCU8w+L5kzgtRXWxX/H?=
 =?us-ascii?Q?uBXCakDmeacivr6VA3eB1hdIDUx9eF4pP92q3p+KyzbJO2kTkljg4R6k404u?=
 =?us-ascii?Q?czZ9NM8mW2JG1mhRUqnVVfw1dY1jk0fBW3WyKjwko0NlkbI7Q2+qDA8QhREM?=
 =?us-ascii?Q?RYbJiar35sv+YIpS5dzRa4ec5B56GH+CmCNzUhbV1r2Q5HSFW9m+TJS2uJCQ?=
 =?us-ascii?Q?mZPxzq+fkarffaIgyhcVVjZHj8LwSrHh7iRMXoivpNOFJ5wAUM83jcY3UQ7e?=
 =?us-ascii?Q?q/9Kl5JwjkM75bAanACG7shhw6Sw5Hek83lIFx/TaXY2Dzd1n4cUJaYmw9hA?=
 =?us-ascii?Q?hCQ6rJaUaEc0vYyz5YraASy9CAbtOkCsCeBs+kRZfupVK/RuiAEAI+fkS9r5?=
 =?us-ascii?Q?6HK3MQbn7VZnq18Ki/zVWKjlE+HwuuQkB1VdpnGjQhCtC0xSSYhRj+2Mm0Hd?=
 =?us-ascii?Q?ZIsmlRP3ctG20zcPFiPKBL3Kx7ddn31ez5ItnIzgv0jTYIDVAA1ppu8MgjHG?=
 =?us-ascii?Q?cegrG5ICxnW5oGrh2XF85VdKgx2sXC+Nn0szypCdm1K+FgWhuYm1CYD0uZ3Y?=
 =?us-ascii?Q?g8NTd5GevHO+6gAw2V8lgAD3hRubx4tjd+c4hnec0gWKAlpykJ8T3Rt8aVRr?=
 =?us-ascii?Q?uS1GgE0qMSSFy2yDsJlWRY3lqD4SZFnGeIy39kAGZhWkH53NSGyufmS/1JgU?=
 =?us-ascii?Q?hP+ROoRBhfk9H3oeIKdklxn0r3lntI5hSR4L72tRo8nNwXqftKGBfDwl8ahI?=
 =?us-ascii?Q?lHWUZ3NUsxJQEjZjIZe8t4PWsRcUkFuGCBzfa0bsi9mw193Zm41TJ9yRMYNy?=
 =?us-ascii?Q?kr23Momfk8CVE66uqZ9tl1KPJIenuT42eSbpQzGzwoAJP1lTBEO0e2sVPwfA?=
 =?us-ascii?Q?7RjwQ1LYl8PXVlGevDdjkRxZpn02dUfeFegCPnc+6MGhzdUZsEVNnmaZX9I9?=
 =?us-ascii?Q?gSeP65y2KlFTjYL8KvNG+12bpyLkl2/fPqEdyXHn/dk73ewgojkDJDI312NR?=
 =?us-ascii?Q?Dr3cX22bE/O+vq1UUvlL1bqGepGScynvG7KXY4X63UuIkqyt9lzXWn1NQUhs?=
 =?us-ascii?Q?fuZ/3xC64ytV1kVR6KYMNkmSkFc/S8Sy8s+PM5kPr/O1Y+H6jX7itd2la2eH?=
 =?us-ascii?Q?gknApb6XKRPjZIQ02McOYuCP6MU9tCcjbp/kt8vMGJzGU2uc2oBWa1BOFbsr?=
 =?us-ascii?Q?s2D2ihZjnkTN86Si94oC5vgtvZBq/y9DOiGQ+50FsjFOe7YdCdNqNbWMCogq?=
 =?us-ascii?Q?T7U6b+Zevv/sTk0gn/wJ+lJj4+aaRShvOGXcp8JA9GXmzfarFKyQo92OX0DE?=
 =?us-ascii?Q?qZWmDH+w/IxqmMb5vRSXpV3pZIPX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:41:00.9382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43023cb-8972-4ecd-fcc6-08dce8898a73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

Introduce the interface file "mbm_assign_mode" to list monitor modes
supported.

The "mbm_cntr_assign" mode provides the option to assign a counter to
an RMID, event pair and monitor the bandwidth as long as it is assigned.

On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
Bandwidth Monitoring Counters) hardware feature and is enabled by default.

The "default" mode is the existing monitoring mode that works without the
explicit counter assignment, instead relying on dynamic counter assignment
by hardware that may result in hardware not dedicating a counter resulting
in monitoring data reads returning "Unavailable".

Provide an interface to display the monitor mode on the system.
$cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
[mbm_cntr_assign]
default

Switching the mbm_assign_mode will reset all the MBM counters of all
resctrl groups.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Commit message update.

v7: Updated the descriptions/commit log in resctrl.rst to generic text.
    Thanks to James and Reinette.
    Rename mbm_mode to mbm_assign_mode.
    Introduced mutex lock in rdtgroup_mbm_mode_show().

v6: Added documentation for mbm_cntr_assign and legacy mode.
    Moved mbm_mode fflags initialization to static initialization.

v5: Changed interface name to mbm_mode.
    It will be always available even if ABMC feature is not supported.
    Added description in resctrl.rst about ABMC mode.
    Fixed display abmc and legacy consistantly.

v4: Fixed the checks for legacy and abmc mode. Default it ABMC.

v3: New patch to display ABMC capability.
---
 Documentation/arch/x86/resctrl.rst     | 34 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 31 +++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 30586728a4cd..e4a7d6e815f6 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -257,6 +257,40 @@ with the following files:
 	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
 	    0=0x30;1=0x30;3=0x15;4=0x15
 
+"mbm_assign_mode":
+	Reports the list of monitoring modes supported. The enclosed brackets
+	indicate which mode is enabled.
+	::
+
+	  cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+	  [mbm_cntr_assign]
+	  default
+
+	"mbm_cntr_assign":
+
+	In mbm_cntr_assign mode user-space is able to specify which control
+	or monitor groups in resctrl should have a counter assigned using the
+	'mbm_assign_control' file. The number of counters available is described
+	in the 'num_mbm_cntrs' file. Changing the mode may cause all counters on
+	a resource to reset.
+
+	The mode is useful on platforms which support more control and monitor
+	groups than hardware counters, meaning 'unassigned' control or monitor
+	groups will report 'Unavailable' or count the traffic in an unpredictable
+	way.
+
+	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
+	enable this mode by default so that counters remain assigned even when the
+	corresponding RMID is not in use by any processor.
+
+	"default":
+
+	By default resctrl assumes each control and monitor group has a hardware
+	counter. Hardware that does not support 'mbm_cntr_assign' mode will still
+	allow more control or monitor groups than 'num_rmids' to be created. In
+	that case reading the mbm_total_bytes and mbm_local_bytes may report
+	'Unavailable' if there is no counter associated with that group.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6bfa8312a4b2..895264c207c7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -845,6 +845,30 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
+					 struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if (r->mon.mbm_cntr_assignable) {
+		if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
+			seq_puts(s, "[mbm_cntr_assign]\n");
+			seq_puts(s, "default\n");
+		} else {
+			seq_puts(s, "mbm_cntr_assign\n");
+			seq_puts(s, "[default]\n");
+		}
+	} else {
+		seq_puts(s, "[default]\n");
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1901,6 +1925,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_local_bytes_config_show,
 		.write		= mbm_local_bytes_config_write,
 	},
+	{
+		.name		= "mbm_assign_mode",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_assign_mode_show,
+		.fflags		= RFTYPE_MON_INFO,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
-- 
2.34.1


