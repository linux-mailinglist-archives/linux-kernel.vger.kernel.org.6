Return-Path: <linux-kernel+bounces-554696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C794A59B59
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0FD16917B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C90323A9B4;
	Mon, 10 Mar 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zqRG5+FM"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4785233D9D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624864; cv=fail; b=ueRZwKQftPvB2hq+QeXguf8pYRyj/dyGkEGMWUQZ7D2JUWKmNvNOVrNBx96fAPMCxaj5Ypnz8F4GgA6A3K+0mFUfqb6MhhAOURml8/foR/Lt8A0vdxENOLCw3y1y3H+zM3aKA+efuW/2CQ/8c/Ss8xPNJ7DYFIgjWqPQxAvZV+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624864; c=relaxed/simple;
	bh=CTOhPWyTUo58ZVX2uC6Z3ghRUk0a51pisY3lS3ZSrfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFkXBd5xo2tzHjjnKlfu/Row3M/3YLsZrXQ9zI4DVGXuxX7+hcv5/LkrYRF6Qwe9FNg3NsaDhNuw9WcMj+FYxzwBxDucwoRN80fbR7EeuTKm/0mqQkL/rWgPKek1CX3KsyEHby6wBBD/0EHpRnyb5FZ4ReEuv2/yMQBGogCX8vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zqRG5+FM; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE5QnsuNRwD4zkc+xBmfAzrdKE1LZCFrmgQHo6c44NsrkwY2drYJE5p89IRpMjTGLHwROcxkMaRAgqGcKJB3bEy+/WfJ3ARTlgRo+kqdjbbG/WV/0wQGHkVTP+K6MDxbbpEmup4807khVoI1hjmVdB2yQ4WHjWxfVOp5bT6VAGo1x4YGta0p1RRbx8z8PNT7VI3OBvUub4eJl+B5xN8Wz5xVHLE7F0i9V3roqLf1NP3XGED7zml8V0ODRP6DkzU/kQkBoNRvpxX1W9pRq0NQZIgiIvBPH1ewxlztXzSpyEgJOcZBNceJ2Igk6w8I0zjrav8IMgZ6PCqU1iSLf3CGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayDX6v/pZk0Y25SNXj0kEL2q9kCZsV7JyiEU6M3QcKU=;
 b=Id2nSn4Kh4C+zo8oPgqAJ9FleyW84qXY0SYmInVCrJ0LRIVGyCxQDy6nqAoSbYzbll8CbBBjtOpuDiXScsFo3OScQ/BtUyyR4S/Ee503Wd4dXyfkGOThngE6/ANmfOy8R3E6WIOm9fOCT4qkoh+msQQaj+WdizvizlnMHKETyIAYPnQeX7TmtUD+rELqErUeWQ316dR+leP5ERTpBAywE3BdpnelfpFsQ9UtLjj3j8yu1jqRfA6AOYUJ1LMqv8DF8FiDvSOeQH3yl7XxZ96yo2Xp3Rif4BwDZQyoHdAUjbPk90K6cUF8s05HTyCNmiDZb6j7/uaNnZio0QeP8X0C/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayDX6v/pZk0Y25SNXj0kEL2q9kCZsV7JyiEU6M3QcKU=;
 b=zqRG5+FMD6DoZpEbk2BgYsipZyka9apF3v4zJW4xtBuZVdYCFjgebjD/gYAYq8EKzjJHwNs7z8x1kGhGrFJ6zCm4KbF7c7VH1fGJj3ajHz43Hai2i0coNs2lcKuAPHhfcvqauWyhhVtDxlHLhHwtnXWl/GDdg15GiHvo0cQkffk=
Received: from BN9PR03CA0087.namprd03.prod.outlook.com (2603:10b6:408:fc::32)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:40:56 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::f8) by BN9PR03CA0087.outlook.office365.com
 (2603:10b6:408:fc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:56 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:51 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 17/36] Documentation/x86: Document the new attack vector controls
Date: Mon, 10 Mar 2025 11:40:04 -0500
Message-ID: <20250310164023.779191-18-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4ed3f0-4237-4129-5248-08dd5ff254a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z7CmiM0Qh/n+n1nYJgdYD9Ss2C2k2eLwDrCctnlbkqpTTvAwCQo25/CQAaIY?=
 =?us-ascii?Q?IF/ZH33qldMDQ35Sj8eNj2tRoaBXe4kPHAkw4SKPdP7dSrDovx/veqKAXPtY?=
 =?us-ascii?Q?KNFHycSebEaMQ5WhqyOn1K520FeiAmcm8iUAzU3dENSj7PWhcj3oI/ncal/m?=
 =?us-ascii?Q?alIg9cXWwz+H+0r5qh9F7ewRIUINZr0OMlfTRaFGZQcaaXTGboMUmsO74VW+?=
 =?us-ascii?Q?30R7vWvtV0v3vwGjrM8rnLxh3fCqSltvNveXzAGK3LlpXIrHbuwaJieYq8tz?=
 =?us-ascii?Q?QyckfW9MuFwPzwchz/RhXUgIF8uyDcH3dwkyf0e/fZLgcbYIGjhDTIotScmM?=
 =?us-ascii?Q?mMCJTgN6vAF7kD3MFi4lJS0raMyPP8p2o1zpVZ4/KzEX0BZv0t0SVKC8wJD0?=
 =?us-ascii?Q?aM56eqkUFAEJ6RX/04XkOTQLYHKD+abl06M39b4OtMkorEHb65LytviEbmGm?=
 =?us-ascii?Q?Z6EHXvSpwg6gOywjdYrRJ+RKcpr7HGDRPxQlNeKtwKcy4vTrwB51djctdltS?=
 =?us-ascii?Q?SUYMf4V31Lrp2e7bQGIWlP9Mb/yQJ3/1tfrwyTwKcmVIVrIIRcASO9HK26PH?=
 =?us-ascii?Q?S0qZe2NH225yxMrQKjoounA27SOvZyfaMctV1G3823SPv+gjLKJq/FNF95Eu?=
 =?us-ascii?Q?NEs4r6Bl/y6uDz9UkGvBtt2Wy+4VSygMuSl6lSYJdpLKG3NFYIszwf7BPyAM?=
 =?us-ascii?Q?hg0tLaaIR4R+L4UGS5+vNEaeUvZBv6IqC4QUY1voYUHkY9Xsf2hFbHjuE8Ah?=
 =?us-ascii?Q?f3l5WQ7O5ClOcp5/wrCmPsstnctSSMayWyPyoW77PqAIcRn34HyQDZ+1Fchg?=
 =?us-ascii?Q?OeF1cZ68o1rXOJ2jNrGs8wSmlxFZjYtC+HiKAXtmXKEVtO6E5sFBnxmtqd2g?=
 =?us-ascii?Q?vRMVCK8Inwv57u5CvrL1HQKrXGgZkiCWAOc1BZHNBcWZqrZ24CK1FwfX4SD5?=
 =?us-ascii?Q?t793XZz8O96gs2I6XNMk47OzenYsDD7ZBoRZ6+fwwmlUTQx15FXpKKASaJvz?=
 =?us-ascii?Q?p2wE5Lm/8No11j19yc2FLOh0A+lcLIIVKToUVSSUvvHGFE97b2CS7rRvHby8?=
 =?us-ascii?Q?qDu0zt3OfYy6TNdwVJvUQnMFv/GOBLE/BRaQ68GQ9iee0tsCycD8MupnTxKM?=
 =?us-ascii?Q?09LUYTdrhYSvJm65Sk3S1XB2xL/I37haiv3UZyKDODN3uNukmkHUYVA3Gp9F?=
 =?us-ascii?Q?yOH+auC3QymSJP7tNA7k6vkW8fmBGNywJ0HMhFmFh1hAjisi+eby+oC2ktwM?=
 =?us-ascii?Q?g05+2Ud/0PAAhzzGPFWI1cm6cEIQVfoolg5g/FxgYLMRyYqgLBG2n3R+BYn2?=
 =?us-ascii?Q?+/QC9J23xgGQ/WxAajDt030Yr5SBFLcmzjbga9lYbV8grztgjQy39QgSZn5S?=
 =?us-ascii?Q?+4tBaLMxu2ixIMDiPTqzfk7S9O0U/Y8LKHniHeZhu9st5EDyB4WnfEg5W+2o?=
 =?us-ascii?Q?lIUmj6WtE4IW71vSm54cH9EAl+16T/4bKOSiEVp0jVZ+GblLzLpR52spsabM?=
 =?us-ascii?Q?axVhFgjFpo/T/iM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:56.2985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4ed3f0-4237-4129-5248-08dd5ff254a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271

Document the 5 new attack vector command line options, how they
interact with existing vulnerability controls, and recommendations on when
they can be disabled.

Note that while mitigating against untrusted userspace requires both
user-to-kernel and user-to-user protection, these are kept separate.  The
kernel can control what code executes inside of it and that may affect the
risk associated with vulnerabilities especially if new kernel mitigations
are implemented.  The same isn't typically true of userspace.

In other words, the risk associated with user-to-user or guest-to-guest
attacks is unlikely to change over time.  While the risk associated with
user-to-kernel or guest-to-host attacks may change.  Therefore, these
controls are separated.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 .../hw-vuln/attack_vector_controls.rst        | 236 ++++++++++++++++++
 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 2 files changed, 237 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
new file mode 100644
index 000000000000..6a581503bc5d
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -0,0 +1,236 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Attack Vector Controls
+======================
+
+Attack vector controls provide a simple method to configure only the mitigations
+for CPU vulnerabilities which are relevant given the intended use of a system.
+Administrators are encouraged to consider which attack vectors are relevant and
+disable all others in order to recoup system performance.
+
+When new relevant CPU vulnerabilities are found, they will be added to these
+attack vector controls so administrators will likely not need to reconfigure
+their command line parameters as mitigations will continue to be correctly
+applied based on the chosen attack vector controls.
+
+Attack Vectors
+--------------
+
+There are 5 sets of attack-vector mitigations currently supported by the kernel:
+
+#. :ref:`user_kernel`
+#. :ref:`user_user`
+#. :ref:`guest_host`
+#. :ref:`guest_guest`
+#. :ref:`smt`
+
+To control the enabled attack vectors, see :ref:`cmdline`.
+
+.. _user_kernel:
+
+User-to-Kernel
+^^^^^^^^^^^^^^
+
+The user-to-kernel attack vector involves a malicious userspace program
+attempting to leak kernel data into userspace by exploiting a CPU vulnerability.
+The kernel data involved might be limited to certain kernel memory, or include
+all memory in the system, depending on the vulnerability exploited.
+
+If no untrusted userspace applications are being run, such as with single-user
+systems, consider disabling user-to-kernel mitigations.
+
+Note that the CPU vulnerabilities mitigated by Linux have generally not been
+shown to be exploitable from browser-based sandboxes.  User-to-kernel
+mitigations are therefore mostly relevant if unknown userspace applications may
+be run by untrusted users.
+
+*user-to-kernel mitigations are enabled by default*
+
+.. _user_user:
+
+User-to-User
+^^^^^^^^^^^^
+
+The user-to-user attack vector involves a malicious userspace program attempting
+to influence the behavior of another unsuspecting userspace program in order to
+exfiltrate data.  The vulnerability of a userspace program is based on the
+program itself and the interfaces it provides.
+
+If no untrusted userspace applications are being run, consider disabling
+user-to-user mitigations.
+
+Note that because the Linux kernel contains a mapping of all physical memory,
+preventing a malicious userspace program from leaking data from another
+userspace program requires mitigating user-to-kernel attacks as well for
+complete protection.
+
+*user-to-user mitigations are enabled by default*
+
+.. _guest_host:
+
+Guest-to-Host
+^^^^^^^^^^^^^
+
+The guest-to-host attack vector involves a malicious VM attempting to leak
+hypervisor data into the VM.  The data involved may be limited, or may
+potentially include all memory in the system, depending on the vulnerability
+exploited.
+
+If no untrusted VMs are being run, consider disabling guest-to-host mitigations.
+
+*guest-to-host mitigations are enabled by default if KVM support is present*
+
+.. _guest_guest:
+
+Guest-to-Guest
+^^^^^^^^^^^^^^
+
+The guest-to-guest attack vector involves a malicious VM attempting to influence
+the behavior of another unsuspecting VM in order to exfiltrate data.  The
+vulnerability of a VM is based on the code inside the VM itself and the
+interfaces it provides.
+
+If no untrusted VMs, or only a single VM is being run, consider disabling
+guest-to-guest mitigations.
+
+Similar to the user-to-user attack vector, preventing a malicious VM from
+leaking data from another VM requires mitigating guest-to-host attacks as well
+due to the Linux kernel phys map.
+
+*guest-to-guest mitigations are enabled by default if KVM support is present*
+
+.. _smt:
+
+Cross-Thread
+^^^^^^^^^^^^
+
+The cross-thread attack vector involves a malicious userspace program or
+malicious VM either observing or attempting to influence the behavior of code
+running on the SMT sibling thread in order to exfiltrate data.
+
+Many cross-thread attacks can only be mitigated if SMT is disabled, which will
+result in reduced CPU core count and reduced performance.
+
+If cross-thread mitigations are fully enabled ('auto,nosmt'), all mitigations
+for cross-thread attacks will be enabled.  SMT may be disabled depending on
+which vulnerabilities are present in the CPU.
+
+If cross-thread mitigations are partially enabled ('auto'), mitigations for
+cross-thread attacks will be enabled but SMT will not be disabled.
+
+If cross-thread mitigations are disabled, no mitigations for cross-thread
+attacks will be enabled.
+
+Cross-thread mitigation may not be required if core-scheduling or similar
+techniques are used to prevent untrusted workloads from running on SMT siblings.
+
+*cross-thread mitigations default to partially enabled*
+
+.. _cmdline:
+
+Command Line Controls
+---------------------
+
+Attack vectors are controlled through the mitigations= command line option.  The
+value provided begins with a global option and then may optionally include one
+or more options to disable various attack vectors.
+
+Format:
+	| ``mitigations=[global]``
+	| ``mitigations=[global];[attack vectors]``
+
+Global options:
+
+============ =============================================================
+Option       Description
+============ =============================================================
+'off'        All attack vectors disabled.
+'auto'       All attack vectors enabled, partial cross-thread mitigations.
+'auto,nosmt' All attack vectors enabled, full cross-thread mitigations.
+============ =============================================================
+
+Attack vector options:
+
+================= =======================================
+Option            Description
+================= =======================================
+'no_user_kernel'  Disables user-to-kernel mitigations.
+'no_user_user'    Disables user-to-user mitigations.
+'no_guest_host'   Disables guest-to-host mitigations.
+'no_guest_guest'  Disables guest-to-guest mitigations
+'no_cross_thread' Disables all cross-thread mitigations.
+================= =======================================
+
+Multiple attack vector options may be specified in a comma-separated list.  If
+the global option is not specified, it defaults to 'auto'.  The global option
+'off' is equivalent to disabling all attack vectors.
+
+Examples:
+	| ``mitigations=auto;no_user_kernel``
+
+	Enable all attack vectors except user-to-kernel.  Partial cross-thread
+	mitigations.
+
+	| ``mitigations=auto,nosmt;no_guest_host,no_guest_guest``
+
+	Enable all attack vectors and cross-thread mitigations except for
+	guest-to-host and guest-to-guest mitigations.
+
+	| ``mitigations=;no_cross_thread``
+
+	Enable all attack vectors but not cross-thread mitigations.
+
+Interactions with command-line options
+--------------------------------------
+
+Vulnerability-specific controls (e.g. "retbleed=off") take precedence over all
+attack vector controls.  Mitigations for individual vulnerabilities may be
+turned on or off via their command-line options regardless of the attack vector
+controls.
+
+Summary of attack-vector mitigations
+------------------------------------
+
+When a vulnerability is mitigated due to an attack-vector control, the default
+mitigation option for that particular vulnerability is used.  To use a different
+mitigation, please use the vulnerability-specific command line option.
+
+The table below summarizes which vulnerabilities are mitigated when different
+attack vectors are enabled and assuming the CPU is vulnerable.
+
+=============== ============== ============ ============= ============== ============
+Vulnerability   User-to-Kernel User-to-User Guest-to-Host Guest-to-Guest Cross-Thread
+=============== ============== ============ ============= ============== ============
+BHI                   X                           X
+GDS                   X              X            X              X        (Note 1)
+L1TF                  X                           X                       (Note 2)
+MDS                   X              X            X              X        (Note 2)
+MMIO                  X              X            X              X        (Note 2)
+Meltdown              X
+Retbleed              X                           X                       (Note 3)
+RFDS                  X              X            X              X
+Spectre_v1            X
+Spectre_v2            X                           X
+Spectre_v2_user                      X                           X        (Note 1)
+SRBDS                 X              X            X              X
+SRSO                  X                           X
+SSB (Note 4)
+TAA                   X              X            X              X        (Note 2)
+=============== ============== ============ ============= ============== ============
+
+Notes:
+   1 --  Can be mitigated without disabling SMT.
+
+   2 --  Disables SMT if cross-thread mitigations are fully enabled  and the CPU
+   is vulnerable
+
+   3 --  Disables SMT if cross-thread mitigations are fully enabled, the CPU is
+   vulnerable, and STIBP is not supported
+
+   4 --  Speculative store bypass is always enabled by default (no kernel
+   mitigation applied) unless overridden with spec_store_bypass_disable option
+
+When an attack-vector is disabled, all mitigations for the vulnerabilities
+listed in the above table are disabled, unless mitigation is required for a
+different enabled attack-vector or a mitigation is explicitly selected via a
+vulnerability-specific command line option.
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index ff0b440ef2dc..1add4a0baeb0 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -9,6 +9,7 @@ are configurable at compile, boot or run time.
 .. toctree::
    :maxdepth: 1
 
+   attack_vector_controls
    spectre
    l1tf
    mds
-- 
2.34.1


