Return-Path: <linux-kernel+bounces-387832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABD49B56B5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4DE283DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919EA20B210;
	Tue, 29 Oct 2024 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rGoFgvoX"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983E2076DE;
	Tue, 29 Oct 2024 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244196; cv=fail; b=jJc78ubSe8vFLKUSv/SUP0ozmDpQlc8DfeX0/aWod/jVTLJrMWFLKHu5cs4hsQsfr3lgbu6214BxvWoJdXXLTcBa8n7HDWV8k3T7NMWndRLAx+5l23aUbKM0kPTYAR4a+805R92HJ8R49Havr1r8f4gXkpAVeNFpzvwrjxmk+IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244196; c=relaxed/simple;
	bh=l56DovnidThDsXMrnVyEro1Hw85z6Rmw/Z11Z3YKvzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUlG9sEJF8g5dlBKRAnahfs6IliRpAgQ+ry2if/1miqrNECMiiPp+FP5tNHIZA/8W/ZROX8XAgciORkpvEIW/SfSxcwAupaY9uYzwbg0AlazJ6o54CTpZ0pw6PuXots3ImDyp8aB2zBqUqzteqkHhsHxxSxFvZgtskrGYTFOQFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rGoFgvoX; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZCLiFXJeS+r9S+q10ZMUmPTs/Omi2Qa0lSXFo8AX4P+tf7eZB7qOBvMIKqfpbd1kPaRCremFU0/KJq341r+ZaeGCLiSKOJYTC98g89GrBv++NUnBqVYDLhZNjOgHyiaR3QwGfnpPY8KQ6+Q8k+nCL0b1e0LGOzGOlDMDhizzSdsTxXE7scm0jM+7ozmU2qkFap19q0Jo00BRkw5u+mbk1bydZEZfl2h3c1OQLNgsfVuNo8xn4/X4ttmiJg/yzZMWaLMPizq9F0AflE1UpQDAAHqesQHN+2nHH5rngt5/XJWIpZhwURZ9IxXdFwefLpUdMD0LqJuLXwfbxYU+wy4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+Md8RrToehNwQXPWr/7lezNM6CNIb2vxqDahjNpXRM=;
 b=QQv2HbCoDpgTq+E3RBP3WAVWvrxRMzjP5f1HPKLYJSrfcnc9mWedQFiOnkuhGUBCloqRmu1degDhiHnZyaQZ0PRR7mGbVgpVc4NkNFc+CMxY3qosdNMg1Jlcd9/uOkWaddMQA6VEGWEgTSdfTAs9Gz5m5I0hnI5gFSpBOsug350+CKTBjWjjqvkrELxuOzncxm9cZ61hlYefy4nC+nw+TV5fykAav3OJ+31/ZS6IRyQWuN+TLhUoIP/il9GS/uXR2kVB7Ye03Ypp1S6S4t7a0pTA4EusQV5iiGfXOr8uxB5+PJxukhmJYF5Eq/dmTYc2vRGUMDmX4rQdFQgcTl+NYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+Md8RrToehNwQXPWr/7lezNM6CNIb2vxqDahjNpXRM=;
 b=rGoFgvoX0ju4H0UD6llplU2N2zD/WwH6Jj0AlpR+PCk5JhBstewIl5vbM32Y3+AEZm/P+pF43wg/WXWuSxPQWFqUHe8aklKYcB67oLH6djOD6bTFKeArYP4nf+6rOdnXuRVpQ7X8HUVyes1XDs7sg3zu72WWD5qh7SjHIeauFL8=
Received: from CY5PR17CA0049.namprd17.prod.outlook.com (2603:10b6:930:12::33)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 23:22:52 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::61) by CY5PR17CA0049.outlook.office365.com
 (2603:10b6:930:12::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Tue, 29 Oct 2024 23:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:22:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:22:34 -0500
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
Subject: [PATCH v9 03/26] x86/resctrl: Add ABMC feature in the command line options
Date: Tue, 29 Oct 2024 18:21:35 -0500
Message-ID: <d59f2e11ce2b24a3cabadf431b96d916f61e1cce.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: e57dcd74-7542-4caf-5e6f-08dcf8709c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VPOnIKVqRQUO6a91cDk42zJNY0+H4hd6taa3i779r79jBFwF1JYkJsmYet6F?=
 =?us-ascii?Q?78lOrBaC23oXEeNWBxQU/E6VR4v6Nh/lzocM4lG5KSgbXYcxq3VmFxmaMk3e?=
 =?us-ascii?Q?YU6vsk1FAXQ6wJs0y5bFQH//0REmVpjGOsqy/8sx/VwYpe2G3JigqxfhLCW4?=
 =?us-ascii?Q?l4elRACWmVo6MHPGG6fRDdduAw1Y8A52bPsDA+wmrXU98jnrrvNQz28BT/5d?=
 =?us-ascii?Q?7IxAn1jD4MWcGNSzOMpzJbDLiOcWp5cSwMJpBbyHMzAbHEf/j53w0HYoZ51i?=
 =?us-ascii?Q?t8PQXwnnFJRUaNu0uBjxMMzgOpKwGJjOkTYPo/B26S1tw60OTC2zP1O2bpP7?=
 =?us-ascii?Q?FW0VXvndixUpeo0IJ2cSPtVV5er+nX0uVVf0lxCSeUiQyB2H4GY60XiebdBX?=
 =?us-ascii?Q?d27GTEvo5kJu3sLrtVkK8jv7mgxlIjKZsDjO7iw7X9yreklB65JHfg3e28Lv?=
 =?us-ascii?Q?hkqye8e9OzExSsm0jWs9a7SdqezIJ2tunuOiBWC6Arufh8svIxjaoLFkNGCS?=
 =?us-ascii?Q?8aOT3F1G0kxeLQGbosdm2KTQd5+T2LIlvcE3hdPeKqclUn5+pubxZ8mdqadC?=
 =?us-ascii?Q?5qzqw9LMAXDRrSWG11LHib2t+FjWss9YDBA5C6WTYQ0Jh3EVRB5SinXq8qh5?=
 =?us-ascii?Q?IiBJO2+FvNJz1WxxoK95SimgjD/sNpCkZe+ovYM+xFVV8Fs08xwTeOEakVCP?=
 =?us-ascii?Q?2rnPLIiURH9c6rK8+TOE9B/JkYrqj06A2i3QdoIF/wplYXsoh/rTTOzgYI7D?=
 =?us-ascii?Q?bH5NnbSoip2PUwW+1isi7VRlc8t8XxXFSp0948gTW8G8gd3ZsI3KhHbTxVGK?=
 =?us-ascii?Q?/PBBb/o84jEofw80Swy16rhl727izPPObh4QMJifoO34Io5enOt2vjLKUkiJ?=
 =?us-ascii?Q?dSck5iqBIn5fWVeYBBZRJzopjWIHMrs3pr+LTemuvRuxoJo3xL6145e5HS+d?=
 =?us-ascii?Q?rN7mbSN4f+uZ2v7sQqjRVqqJu7gzxpNuqAm21cvhBt4Hq9mlvq9HPLAE+Eqv?=
 =?us-ascii?Q?yn8QNlIxJdJ+K4Jk2kOCFcB2BnLt58qV8l6yQjQCQocyns6hDH7UVUkSh07A?=
 =?us-ascii?Q?SUlciQ4+oLP6XkkATdwJOiWSSol5OiQiXrdNVXzUJRmN8xubj8Ta0qITkYh7?=
 =?us-ascii?Q?dVr9XMdt6JsrHZS69HSYMix2Nl4Igbco+JySND61jHEZFkBDX1TYZBAOU0W+?=
 =?us-ascii?Q?yWNUI2HphjXZYV1N/A/PCgtqNaBOs5yoI1V4FUkC2JFg0aXvNp/P3g9sAydV?=
 =?us-ascii?Q?RUvfPBlvQMNw560V4M2RS3lJgn1jNuHOoTPJ2z+d/Rx/Uy8fD1XHZ4oq5PCK?=
 =?us-ascii?Q?tk7AyRCB4w1M1LB7Eg5mPPoVl66+BkXaUuie3OsHgVW+IQxeBl6nkmqUGHSH?=
 =?us-ascii?Q?gUPk+ZfolnlKka5TNZBUFGz7chuPp4QppM0Ri8bQ7a27xEcf7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:22:52.5527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57dcd74-7542-4caf-5e6f-08dcf8709c99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033

Add the command line option to enable or disable exposing the ABMC
(Assignable Bandwidth Monitoring Counters) hardware feature to resctrl.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v9: No code changes. Added Reviewed-by.

v8: Commit message update.

v7: No changes

v6: No changes

v5: No changes

v4: No changes

v3: No changes

v2: No changes
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/arch/x86/resctrl.rst              | 1 +
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..b3b3ca564220 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5677,7 +5677,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, abmc.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a824affd741d..30586728a4cd 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -26,6 +26,7 @@ MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
 MBA (Memory Bandwidth Allocation)		"mba"
 SMBA (Slow Memory Bandwidth Allocation)         ""
 BMEC (Bandwidth Monitoring Event Configuration) ""
+ABMC (Assignable Bandwidth Monitoring Counters) ""
 ===============================================	================================
 
 Historically, new features were made visible by default in /proc/cpuinfo. This
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f845d0590429..25616d82c0cc 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -809,6 +809,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ABMC,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -834,6 +835,7 @@ static struct rdt_options rdt_options[]  __initdata = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


