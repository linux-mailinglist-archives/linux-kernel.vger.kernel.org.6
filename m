Return-Path: <linux-kernel+bounces-327137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FA0977130
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B414B24FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79F31C4604;
	Thu, 12 Sep 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z5qqy9Hr"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13311C2453
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168169; cv=fail; b=VzslhAtWozuSYfawhZlDaMjpd4uHlp1F8LP8rPl4OkB8maqUeBN1zo7hfkexZSoAYX+8+/3OGD1G9SnYJgkCwboBt3LSG4SgqbhIAmEsokzzM3+2k+2rU2ukUOba0xrrB7hPRBCXcAEqGwzkoNAS8NtZEQiLvYh/nQrOUHxEZBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168169; c=relaxed/simple;
	bh=6/Q8CHbmjdqrbS5JeONL3pZJ/vC7izSPsfv1e2BnI60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QkbE2hsHYW37UAzohmCQMUIinUovsjkUoNatpA+mTAx6MQZtuJ0ol7ozsC0flivbms5xmMAF5bA8IxbawDwR+sECLVEGllys4475EVr1k+4ixHM7sGw5bXBv4uvSsh4PqPfDq/2RuQ317CnTJIbFPU43gc2ygfhBWQxnxQWDoB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z5qqy9Hr; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxxDuq6DftiqHbuUsbcdHnHpmbmKYPSnqBGmBzSL3uwtWEAT4JR4b6yN8M/bRQH+5+bTCh/2VgXy/8evWVuS7dMeDuiUEdIerTN4r/6H2iH2qijjmUV5MViAaEtlVdTH0eeWMNByc90YdrJC1Hfj/rdMYfoZLW9PF/KFCKTqsRG8NkeLLuRavLFnCbnNO0hXiGnGlykvuSzVE2e6zamVoFmf7wB8M5wPBrx0J2JNET7ZM2Qubl4RC66FdYsZ3/6dVsPZ9XcY+bRHiXpLXibhHZt/HXGaep0TITWTdj3NqYVjUZoOO4s2E2Q+T0OcyaCMDaJ7bx4p5DIPqHYTMjZ/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJE842/DQH7Y18Kn+8BUpUlPdP/4L2y9ssRAkX4APlc=;
 b=crvzgXUAy2GXSMM5vh1mSweMDSZt8wtiIQ0vbo36qmlEFj2ZWB57qiD39AaWL+ECyLUDdZ5W5So5sH5LIsk6/n1MvNCIX8rwQaIEbn+ljaTVbmYfYJdNfFqN2jRJB/8hHE6SAqb7Zt8df0yYzpa6CQKLEEdFdq9m+u/HjqrMrmL4e3FLn6p4nT9l8C0k+5c1YXJOQlkVW5GJ2QUNXOe46+8jSWGks3CBuKiQ98R23E5rI7CnI7vd1CCaqijl6+mU47QamVZ8dSAbrsl9xw9QNuggE27TGmsE8H45PF3Lx1u6ZJO5gVxCdawOKxe2G5NBN0jVcG5FuN+zcPX8JmFCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJE842/DQH7Y18Kn+8BUpUlPdP/4L2y9ssRAkX4APlc=;
 b=Z5qqy9Hr/DIMduC2VzmyGg3+EjziAO12Hi1sb72OXRilfzKCDtzwlG+7Sqrcl5KkT/eVmM3JY6mMroqtuhtdQ10ABzAVBiDuPZiclDpipuWo1jx4lmuog7eNU81LW0Y42dmptZMp6XEk6Ae5WFoH8QYvzoO/16Dakzixp3fGIcg=
Received: from BY3PR10CA0016.namprd10.prod.outlook.com (2603:10b6:a03:255::21)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 19:09:21 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::a4) by BY3PR10CA0016.outlook.office365.com
 (2603:10b6:a03:255::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:20 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:17 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 18/34] Documentation/x86: Document the new attack vector controls
Date: Thu, 12 Sep 2024 14:08:41 -0500
Message-ID: <20240912190857.235849-19-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912190857.235849-1-david.kaplan@amd.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbc636c-230c-46e3-dc37-08dcd35e6861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HJEyNV+64EKzc4VCR7VItCExQ697JPg0VftlXijd0vBEhdmPyc1ffgRnPtT8?=
 =?us-ascii?Q?cRQWnqKz0iUdZh9NmEI7nbw0GLIX/RqB1lLGSZxsOa8r+m3QWwEzGwNEFIUs?=
 =?us-ascii?Q?QHw10MTaqShUzxlNHSOIZ/pxSXM0kOm96BBnZa4lEMysUBKbaJ9Sg4h4VW35?=
 =?us-ascii?Q?RvFkNGeIjo0WHSzk/ro9aBjmN2S1/MG5ed1d/VlVTJbsxMarYrStiWMb7qxQ?=
 =?us-ascii?Q?qNkmx79zRbfA5/MEPURROUUi4embwh2dSaev9XozQc457f1kbEAYAJ048jvT?=
 =?us-ascii?Q?TOV4D9cv94rYsOyJp9ym7mS9E6xS5u4Qs+KmaLXtoaqVS8MgshsVZp5r3PCO?=
 =?us-ascii?Q?QqY/PNBeMBaAK9REbbqZdHZf1+vC8OtHCsezMIYzZ+Rla+Q8ErbXdSsZ2Z7a?=
 =?us-ascii?Q?QxJoInySAHU0O2dpIAHSPPSSUyJuOW2cuX3r5LZPejCGxygVgMqUybxNkQIV?=
 =?us-ascii?Q?ugWEZK75gzfVIAdqEKkqQzN5s9VC8TSw6joE31cGbNmsH+ATKlZ1x6DQJ0km?=
 =?us-ascii?Q?wug/wvjeKERJGyDGyloyAs7joIuSDOGEGooMbV8honQ8+m73llYnnHdbxBe7?=
 =?us-ascii?Q?552NHUHHzxVkvuirx6CzsC1Iok/a/f93AmR5cghLt/CzI7h+GT0p2GvPTCOZ?=
 =?us-ascii?Q?K6lxh5p8l0bhj9O6cWey/97o3qJrEaB/l+HkrEWhx0sFH76qQVJCvdiisS6q?=
 =?us-ascii?Q?gjeJj/KreVXKkF+3oI9qiNf+c3jBJP1KMISDIyKOdoQKl3JYIWhW8yaM1uts?=
 =?us-ascii?Q?LPPZNQ5Dtr27nJDcSGkEKq0Rdhjky6z/uHHbpTxF0uwdOt0dz2EpT8g77T1i?=
 =?us-ascii?Q?8U8WJuPL3pX7wQa/+KpYtCD1PNAy2FIXG0l3wyPOoKulZr6BeadW6IC2+Nvp?=
 =?us-ascii?Q?KrjRcAwAeWauGETuBSPJjvO4bZLfEF+DG0lIuffwE9Ueoe5qRpoewPI61wyZ?=
 =?us-ascii?Q?6Ec94Kcqp9bsu/XTEyDh1ZfBmKihw7irZZSmfrDH5B2iBhBI5ejnaB9VUaWZ?=
 =?us-ascii?Q?636kVjfsbdseFKq3jwPDfCm75KznL0UdFUTRzxNSmjjSntDkArji3aWsbalI?=
 =?us-ascii?Q?vlDLAsVkbgmBLg/COnrrEo87obOHUZa3SLfW273XIwpf+p4oeXbP6AiDnR7F?=
 =?us-ascii?Q?jktPoEbU+5TSQnrKK0wBoaBnL44l1zAcqT1e2UjqDMzzhDAVSVMnHC8AmAs5?=
 =?us-ascii?Q?pHr3M2C+tWjoW96WeRpbTiUphoh5bAvx+CPBe5U1mMAYVRDUL8l6RWM1NaG8?=
 =?us-ascii?Q?4zW/ebkXXZMYsQZrYTDoPZdZ9IArevDCdIez5pxMApJ9smqC5aYBrOEYL0B+?=
 =?us-ascii?Q?ekF5dEBlhGub/9WZOgcpdM8mw144DcaHaeN8/r/NTDjMWnymUFe46Q/qxQPl?=
 =?us-ascii?Q?z3hftiRrWFH+iBrdkBRKGjOc19sob8CZVgMdvH5RFBYqDLpWRe1M8L2n8J1q?=
 =?us-ascii?Q?lCLUtvSyzanj3FNkpn+a2hPxPpSCn4vv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:20.9054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbc636c-230c-46e3-dc37-08dcd35e6861
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758

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
index 000000000000..4f77e1e69090
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
+GDS                   X              X            X              X
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


