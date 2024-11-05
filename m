Return-Path: <linux-kernel+bounces-397211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E99BD7F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8F41F26292
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4118218322;
	Tue,  5 Nov 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fElYS0Eb"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE421731F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843742; cv=fail; b=aEiLZsNndIV47ymqKlWdVL1KtM852ZqFXPgg3fK1bZqkCRw3IOjigt/QlI62HIu6+LSsk4sipfrrNuk7HsnZtWiIuGtAu4jkLLLJWzjhEJPyhfZHShCS2RtRblbrcP1n5ns6Aq5ElW8FxXsS9qhCNP8olSd/S3FPYJZQwpiDYnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843742; c=relaxed/simple;
	bh=NSlKxrRqla6PllzBbE+3f2dWhWTigkFQxPvFgqJ3hos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hG/e8t+gDCpqvGjBvvCPZ9yYwur6dTZ8EDTwURyxR8MoYM34eJF3tF1Ug5/seN7q5/DfYIs6GWOtj9pVoJJxs5d3bUfquvg+xm0/ItsC1UIoxANb4+4zZHxSajJ3IPN+sMGlXYR2zz8ZCSvlo6Z2MpPLjKOzooIPhQwmDqwDXnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fElYS0Eb; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkJb7s6dYl5yScXuJ/YHqRjwqW2de5VvnWwLdg7TO2VV+ckAXMpO7fi99CBMBWbQT3eO1r/17/YHNfbdwtMMly0G5cyX6Ty/vbTRpSVkToNMM3pOjnIxiKFhAEZeE01ah0akH692RxgV5vuApHuJOCGjqJPWiMWljg3a8Lzmy4ZG8Go0d5Fx6lSk5H7xOKDzVtU2Nhv/slw1eRGQ3Tix9ylJhTYLzrHNYbRs/hvsZDhWEq3tIquwza/+2lvxTcV8Ybmr/7GTIJ6n0+dUiRR7SkTyHqyDQRC9lWlK4B+EfhgfD/3PcGvkj6ojMAnWWz9TnP2URyge3nfOqSiktseu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJlwB4/2h9j+IcbZ6t4c3h7qMc03JQocoSs7rugne24=;
 b=kVo8VDuX2GiLhWUwmB1u9xrR42ukuSy+bDTSMGgOznoGp/0gRQV8Mxo8wyBpTMFprO93u03dAn9lAsYOB6KbMhhvZd3J2m/sMqwEbdf+67qku9+qY3qmNwVjtugriPvOL919SgjMSz0TrsyKbdIp1erQxWigfkIwUuhQ3VBogmJOTwNgap9E/QUEMKtiYbWEvTHpDarzzWzgslKZENqW8GGk/P7Sa6L7CcEhP6RdUCqpxkLZrOx2yARp66V/993cqVVkvIhJ1zXpA1j0gp3SO8asshX8ZVUGhA3IpfzZiOL1xmNLGkcSDvi9BUsmvgNEzeXuNDbrgC20cALQl6oHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJlwB4/2h9j+IcbZ6t4c3h7qMc03JQocoSs7rugne24=;
 b=fElYS0Eb9QN7oJfJG64aX7gW4E6SJJSqDh19aRCnC2bZ4c8dF7X98p8o94SiaRnQ53jDrzx0aGrECiNbzWaSU6VARsDN1Nr154meRjIxmnGHyD26BFiK5gTYC0GkgnIhGiOpLfOiaAExSjilU8BiRqoiz1lva2Y8g0nihanPG6E=
Received: from MN2PR15CA0065.namprd15.prod.outlook.com (2603:10b6:208:237::34)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 21:55:35 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::30) by MN2PR15CA0065.outlook.office365.com
 (2603:10b6:208:237::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:34 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:30 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 19/35] Documentation/x86: Document the new attack vector controls
Date: Tue, 5 Nov 2024 15:54:39 -0600
Message-ID: <20241105215455.359471-20-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105215455.359471-1-david.kaplan@amd.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a688c27-cde5-4eb7-0002-08dcfde49376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RjsvT7UMz2/CzpFBUD7FerBwnByDtzNfiomNHjd7C+p0sY0mvDuZtmkusqlT?=
 =?us-ascii?Q?+xJyPehj44ghWjWcP/uDmak3LuqRe44NBrMJ6uVolTDIHAyPQjNSMMRsyklD?=
 =?us-ascii?Q?jr7K9B5p0x9+e7EoyYRuYQdtyMauFBdV/7gGa+iniyt09J09cDMrDORcUM9l?=
 =?us-ascii?Q?20ab2LCjv1e8IpgH6k2KqD+JNH4CfyzdAR3zjSQHKtvjF5KbDSjx9Oez0OER?=
 =?us-ascii?Q?UjWdRUNlpMxkPcGc3K8vUKaxT93mUNCBOSOBnVaiciHefQPmwl71Rqh+YSep?=
 =?us-ascii?Q?vCZK0FajGyCRI094lUvSwfpD+ertqle9qjcUBKlcgUuFsbZ6k9j/DVf0a59w?=
 =?us-ascii?Q?bcIzXYNlkme0jvl3qvzhOiUrypWBtl6g3Wj8QvRX3oE8bWx28YYkUaW/O+cs?=
 =?us-ascii?Q?Fy7Ivpd0YTlO5xhZ5Xc/nqfnuDW9z91qKuHSVQqokmBNSOywyqAU5MRcgqEc?=
 =?us-ascii?Q?qAaCmkPOg+/Iy8QQvrZyqA6W1/dYlTp69BbeHXRul5TcRTwHknN2Eq+ORCdX?=
 =?us-ascii?Q?tnSN7WZ2WYP+yIwb81UqItcFZKyipajsqmgrshIAxWwJole/yHoo84nE/O3i?=
 =?us-ascii?Q?LWEDN6YOJioa5zMYexZeyBhjAgHYjR0yctDcf6A/rsLdq5ZD0Ru+Vyi8Whhs?=
 =?us-ascii?Q?yPyuFQxms3nTetj5n6aq6BjZzSFhlYtbj8UkhKqUC1v7NyM9q5TOklOCOE/A?=
 =?us-ascii?Q?AsOqGglIGeLSSPomKV/VVPcvnKpdwdj6V9Oc+QZ8kzMRKJigUU1kRSlQHRJU?=
 =?us-ascii?Q?VrluBuamxw7A5oDrKIyVJuXtmsYf1vErC0rX+QG//2gMwgA2V7VG9O9ujYv9?=
 =?us-ascii?Q?h+nRTsLXOvMe7E//bYxNdCFqqlqMK/Q5zWuZM4SqbiAynM9WIOIP4W/Lvte4?=
 =?us-ascii?Q?Ji0lXojzO4BMBp9HxJk+xrZ7mxZ0YqkmP868W+jxgLWLlpg7K4sM+J1N/FNR?=
 =?us-ascii?Q?M4SSTShppV4haZLu686mLuJJjzf/DluN7UoY6vIhjipWsDMQA2t01cwtRxmC?=
 =?us-ascii?Q?QwlG261BetOTQE0Eya47UQ7mklQ9IxkYB5ObY6JRrWB2735jaQMAPxxjZim5?=
 =?us-ascii?Q?m4PT/kbuuaAlFUgx3yNtROLEdMRT2EQlSYSdpr3/Wc2rVkRAdt8jxtPE8NNA?=
 =?us-ascii?Q?+HwCX7rI9itCdEFh99X7g2SdFGYzejRo3GI0yf0N0QpaqIoA2WoO+tXD+LCM?=
 =?us-ascii?Q?aeCJongsQTfBxxoSp3ZneSXMwDxqrstezSyq3f7cM4j6PhauS5HWr6uPiQUT?=
 =?us-ascii?Q?IZ0Q5NB3Omlx6XcgMbIVE2Bad7HshI0bcnOqiyuepeLi4IsjFpzM97ywMDy9?=
 =?us-ascii?Q?w1TpMsKaL9MlZfGkhn6N3+b+jbP4HKoppnYXoUyoU7u95IfVxsTb5NEMXFIK?=
 =?us-ascii?Q?rrg3QbCh2ixSr2rL61o9ZsltuD6G691NdwdoqoO0UlsHQTd84w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:34.7497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a688c27-cde5-4eb7-0002-08dcfde49376
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456

Document the 5 new attack vector command line options, how they
interact with existing vulnerability controls, and recommendations on
when they can be disabled.

Note that while mitigating against untrusted userspace requires both
mitigate_user_kernel and mitigate_user_user, these are kept separate.
The kernel can control what code executes inside of it and that may
affect the risk associated with vulnerabilities especially if new kernel
mitigations are implemented.  The same isn't typically true of userspace.

In other words, the risk associated with user_user or guest_guest
attacks is unlikely to change over time.  While the risk associated with
user_kernel or guest_host attacks may change.  Therefore, these controls
are separated.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 .../hw-vuln/attack_vector_controls.rst        | 172 ++++++++++++++++++
 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 2 files changed, 173 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
new file mode 100644
index 000000000000..541c8a3cac13
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -0,0 +1,172 @@
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
+#. :ref:`user_kernel` (mitigate_user_kernel= )
+#. :ref:`user_user` (mitigate_user_user= )
+#. :ref:`guest_host` (mitigate_guest_host= )
+#. :ref:`guest_guest` (mitigate_guest_guest=)
+#. :ref:`cross_thread` (mitigate_cross_thread= )
+
+Each control may either be specified as 'off' or 'on'.
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
+*mitigate_user_kernel defaults to 'on'*
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
+*mitigate_user_user defaults to 'on'*
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
+*mitigate_guest_host defaults to 'on' if KVM support is present*
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
+*mitigate_guest_guest defaults to 'on' if KVM support is present*
+
+.. _cross_thread:
+
+Cross-Thread
+^^^^^^^^^^^^
+
+The cross-thread attack vector involves a malicious userspace program or
+malicious VM either observing or attempting to influence the behavior of code
+running on the SMT sibling thread in order to exfiltrate data.
+
+Many cross-thread attacks can only be mitigated if SMT is disabled, which will
+result in reduced CPU core count and reduced performance.  Enabling mitigations
+for the cross-thread attack vector may result in SMT being disabled, depending
+on the CPU vulnerabilities detected.
+
+*mitigate_cross_thread defaults to 'off'*
+
+Interactions with command-line options
+--------------------------------------
+
+The global 'mitigations=off' command line takes precedence over all attack
+vector controls and will disable all mitigations.
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
+GDS                   X              X            X              X            X
+L1TF                                              X                       (Note 1)
+MDS                   X              X            X              X        (Note 1)
+MMIO                  X              X            X              X        (Note 1)
+Meltdown              X
+Retbleed              X                           X                       (Note 2)
+RFDS                  X              X            X              X
+Spectre_v1            X
+Spectre_v2            X                           X
+Spectre_v2_user                      X                           X
+SRBDS                 X              X            X              X
+SRSO                  X                           X
+SSB (Note 3)
+TAA                   X              X            X              X        (Note 1)
+=============== ============== ============ ============= ============== ============
+
+Notes:
+   1 --  Disables SMT if cross-thread mitigations are selected and CPU is vulnerable
+
+   2 --  Disables SMT if cross-thread mitigations are selected, CPU is vulnerable,
+   and STIBP is not supported
+
+   3 --  Speculative store bypass is always enabled by default (no kernel
+   mitigation applied) unless overridden with spec_store_bypass_disable option
+
+When an attack-vector is disabled (e.g., *mitigate_user_kernel=off*), all
+mitigations for the vulnerabilities listed in the above table are disabled,
+unless mitigation is required for a different enabled attack-vector or a
+mitigation is explicitly selected via a vulnerability-specific command line
+option.
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


