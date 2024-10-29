Return-Path: <linux-kernel+bounces-387835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF59B56BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E5F28404A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC220C027;
	Tue, 29 Oct 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ulK/R6u5"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FF20ADEE;
	Tue, 29 Oct 2024 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244211; cv=fail; b=qF22FXTAMz86l+JCx4sWBr1anwq+h3c0bAOafkxk3X16m3asHiNiQPONyxARVLGPIRca8zEGqoBbGjrlxOJAvspxZTRi4j+MNqwtbS4bz28zsMJmooJz8QsgGfzNPN7oyPtUGasTvhnlqm2q1JdkTAFDG9sqWzHMwDGl7ZF+E9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244211; c=relaxed/simple;
	bh=lJisS6vwmoNNFvV5hmSIcyfzfg/4AdxIixD6fizga/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eammc76EhdDahF4vcaxFQCMc8C2sZvfYqUitSesVoLfYL4eug5BDFzSU01X02oOYGu6HUAEfkm+Gw2AcoYFva2Fub+xCJ2nl+nK/UBwZ35PbcteEzL6wUMsuAp9YFrcFFUuqR7qW6cyhtPxR71HP2eVNkL0OLjVBjzt31v+vOeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ulK/R6u5; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEybSDtzGDKSVD+MXTtpu9Ta9cNlo2XgzWz7pYofFhBPpp35VuAiU8K0UOwk7tM9U9T/4r6jiSxjhSDKHBqfF7juXcYz1fyLh2tLSz4thjJHPoipCOema9EKToMupwJ3BvUDYQnDnygtukJUfcP71sQ/JQA+ufyC2BUZ250lj7v2vVNCMFR1Is9ZXznJw3irCzMEeWiPNW4TBNMAebpmG/e1IExUR11iCV3QTo79D4CZaWHT0LNAfZ1lfrIo8HIMBe28DafVhNOPfI1KYC6yg/XiIesB391YHtIbBrDrgyR59xnPbj2cR46YmvcoB2xva7jLIhoenPyl5YVl9+2HXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YW2EUxo9+x4djJsOCl7ehZfpP16KkrtX933N+/K6jg=;
 b=JfEBcghwN4i/VAIRyELqG6kyiWOkgyUQLkAONoQXJIyt8/+3Z09BnD77uv4o88Qm/n6HGg782pz2lFJuou21OWnb0stsUpszp9IXuCH+V4wZMg4BasCZ/DOExYZ78o2Ietil5kbqDMZlCsbbw5YMceP23wszjkgQbLyw2KR7T1oTD5zBAvu48IQW6HFa9cPABXk2yoBXm3RSEIZ9L1mdLOErQJ6kajZVbPDI4lgY1l4u6sZiniwcliODHHMBYVyJVOkOK15IygYYC2F/5Lt+fHEeqzRWGifcFQ1+OiimmKAPLNFU+cnv7/1Ot3+MHnv9lV65fyvnBc1Zd8H1jkXGOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YW2EUxo9+x4djJsOCl7ehZfpP16KkrtX933N+/K6jg=;
 b=ulK/R6u53pnhn3Ml05t5j7J0BcY9uHA45Qq2mbaKFmZyDnDP5EObRF/kgKoi4oSuJEiFCbysLNpJu7VXIrLl8gwIpsZLPF2epak9tejprwvItfcVyeZV0NLb65NBPU9cJY6La0SpP0VBNQQeI1VmdNM5a6dLCIQ0DEaavYR5b30=
Received: from MW3PR06CA0025.namprd06.prod.outlook.com (2603:10b6:303:2a::30)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 23:23:26 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::e2) by MW3PR06CA0025.outlook.office365.com
 (2603:10b6:303:2a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Tue, 29 Oct 2024 23:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:23:25 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:23:16 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <babu.moger@amd.com>,
	<jithu.joseph@intel.com>, <brijesh.singh@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
Subject: [PATCH v9 08/26] x86/resctrl: Introduce the interface to display monitor mode
Date: Tue, 29 Oct 2024 18:21:40 -0500
Message-ID: <121c79ea1abe6f21f726d086eba9fa61d31da3f1.1730244116.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730244116.git.babu.moger@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 3396cb32-20c9-433c-e614-08dcf870b047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sWd7PZqZvUhOhsipNU278bvIUtro6U36ri4zyCqyeOjPcAgLsij8VxI1yG4x?=
 =?us-ascii?Q?xBoJr2zGYh20Ci3UYvqRTLF2fweb6AEkSt8rFGtiuvtnX7hlBoh0eC2pi65W?=
 =?us-ascii?Q?KBfVAFg7Wj71vEfmJTriVXFPJx13+WUHLy9TAn9gpQkqC2wcTfzUFqKXKmS0?=
 =?us-ascii?Q?sUNRiLNTbgAYE/4MFkZqKnuZcpjiPGRgmIXDiFlrhqFjO7k+nokZkuxwmeh0?=
 =?us-ascii?Q?hyTnmLzXi7+0ZJeXkN6ZPgM2JnhT5/EK7057PU53pvZElGjo1S5/kFH1X40y?=
 =?us-ascii?Q?6SVVaWE9EAcBoRqPWbWsoqfUj9wrSgGgbwKSaI7mIE3SFTTF4u/KYMI01RoZ?=
 =?us-ascii?Q?cgjDH7+lflEGF8sPIeizbNbSIckke3ku3Tq/z4VBIsinxlFa+nWrZ67PNbny?=
 =?us-ascii?Q?GoKLGRaL/FuD+6Tn1wOOWm8TPMzs6aAFr7/8DzQscBoKc5pt8qN+KsBIOPI/?=
 =?us-ascii?Q?RPBQXpOax3mFnAIk2YUiPRqjRtbV2JsZnHXkSuo15Da6Hj3VqwyUcdGvXFw/?=
 =?us-ascii?Q?zZ5BW8dIY1Lve+CIp/j/Bh77BtjNOY58kMXPattfNeA+Pnw5KxYRb61hsuqa?=
 =?us-ascii?Q?KukJuzJSmS5Of5VBliv/cGbw1iyviX80JWnztdH1nwSlTusbgod6W4I6J5F/?=
 =?us-ascii?Q?zM8gKQ4SRk1/9kXkNVI6VyI709eVPtyyqyx55apwDH3gqjnOWcbyCcOlO4lb?=
 =?us-ascii?Q?FqS7uFPeq1cOVoUIr2LwlI9pHtRhAyeo7yL5fZJQGlUAr0HkoITVSq16bANF?=
 =?us-ascii?Q?nloDRYZaJeNgrqB8vOteJxuBhJryiT2dI8tZV3yYyzYH5TfY1HlWhrHV4nff?=
 =?us-ascii?Q?3bq974GNCNTHr6G4oRYH8jgXSyeAd1urbeoWXTVhBQYf7k0owewmaSySHCuM?=
 =?us-ascii?Q?+qLk2xtOA+79u5ct8CvSeyqvcm2j8FcuXdAASHKD6CzCbAjJb7raxx28h/ht?=
 =?us-ascii?Q?CpQ15wmu3Zov2IRBErAbnkZJx9tFXqFf+ComKs4z0DxBZEbNt9pRotKsQuy7?=
 =?us-ascii?Q?xD5L+3Cijcmzk5uPIXPSZplw3Zx5taf8UO3CFqK4z8d62i4Xd/Z57bfXaioK?=
 =?us-ascii?Q?PkxrF3mJ/FuijZMkE+PetGIUqPj0ZCeFdCpfueFhRH26LrVhU5bbL0yjxsH0?=
 =?us-ascii?Q?V3wT5mHzRRKvQRB8cMVzLDRQ4J8zrA8+/bSMtqrAqm6988UJkNWL/wSdKSSh?=
 =?us-ascii?Q?KzDZlKIk4XXCKeyFMvnj6IvotRa1PzaxnCb1/MKNQIAYcL/WAZTfgt90t5ps?=
 =?us-ascii?Q?RJZu/uYuD7xbAutyM8TOO33psYCpiFkHMpCg4D5r2gCcOff0Sf6rvZaNtLTS?=
 =?us-ascii?Q?55RCCiNqHxZ8br3ekQRTab5a/VohIP2+HIUG8XruGb3WeRlF1EDkK0lq8adw?=
 =?us-ascii?Q?9WyHy6Z44JGnNwZD8o8Yk0of1RKVE8sXJ3qPTozbVkTbDTBh5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:23:25.5732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3396cb32-20c9-433c-e614-08dcf870b047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466

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
$ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
[mbm_cntr_assign]
default

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v9: Updated user documentation based on comments.

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
 Documentation/arch/x86/resctrl.rst     | 33 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 31 ++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 30586728a4cd..a93d7980e25f 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -257,6 +257,39 @@ with the following files:
 	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
 	    0=0x30;1=0x30;3=0x15;4=0x15
 
+"mbm_assign_mode":
+	Reports the list of monitoring modes supported. The enclosed brackets
+	indicate which mode is enabled.
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+	  [mbm_cntr_assign]
+	  default
+
+	"mbm_cntr_assign":
+
+	In mbm_cntr_assign mode user-space is able to specify which of the
+	events in CTRL_MON or MON groups should have a counter assigned using the
+	"mbm_assign_control" file. The number of counters available is described
+	in the "num_mbm_cntrs" file. Changing the mode may cause all counters on
+	a resource to reset.
+
+	The mode is useful on platforms which support more CTRL_MON and MON
+	groups than the hardware counters, meaning 'unassigned' events on CTRL_MON or
+	MON groups will report 'Unavailable' or count the traffic in an unpredictable
+	way.
+
+	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
+	enable this mode by default so that counters remain assigned even when the
+	corresponding RMID is not in use by any processor.
+
+	"default":
+
+	In default mode resctrl assumes there is a hardware counter for each
+	event within every CTRL_MON and MON group. Reading mbm_total_bytes or
+	mbm_local_bytes may report 'Unavailable' if there is no counter associated
+	with that event.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d54c2701c09c..f25ff1430014 100644
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


