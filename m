Return-Path: <linux-kernel+bounces-397190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C09BD7DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E291F22812
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29DB21620E;
	Tue,  5 Nov 2024 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JFig/mBP"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B06F1D5CEB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843727; cv=fail; b=Ki2CmIPeO6Jo8nxqmY1RD9rkLz1P/LI7sw0oG/MKsxrskOOm3hP4IwyPif4hOROHUyKl497sG9vTnxt5W88vAh/cAyFpjZTRlctZv9g4tFt8Ddq2GuH3SO9WUOa7UWl9pE3hsVj8OVOqnQITA93h8U45olXeFONJpQXSEXrFWmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843727; c=relaxed/simple;
	bh=Y9FRu9/5qda0qn8WqrLiqgtYq6DVl9IUcrnQt8UrOZ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E8crz9pSIaEODL8x1ZcmoxBhaPI1rDHtr753u+26G1j07wbCfjI4sLL82utZ8Mf+AJ1DVfetFsasb+txvI8pMX9tEWfWcfRApaiZoPqkbBLxwxuS9xkQeo3Z31ggkDBMV+u9fBjm+BvUoZpIvs0C2NXXRAOIV6iHmYDIbFUc118=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JFig/mBP; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWZ1QH2TUJTlC/C44geuYJ6qIZXBHVjglxT1KCRiktEQ/fLR2RO2WMJazix0LVTPgzjX9d7jS3q7aBTqPbrKrWx3oHM5knCurnMmDGa+mvgt/yqBN8F33Oy7tK7RPUU3vQUzvlELe031HSI60XyAvhvYJdZvtrWiZlTrqRpkvTHFUV64yzBIKee23f2zcDG3KoGgBWZweJSkBYJfTwmaNAGWgC3TATxX7zZQKtt5p2sEcKeYpa6fReSaB6feIoYSobXHAt6nxqndft5fP/GvIfyvmEZJwzda7V1khPURPXJiowbjxr72BdehXTOYTm5ztcE6Kt0G/BFabi52e0zPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7g7pvjAWiSutqSkmqNMnuOxD7KipxGOOR1pqFn+3RQ=;
 b=IVPBP2gzBXtQbTneBBRwZF8M+CUAmlFdSVtqR5/RkshkpUNe9Cq812qnHr+N3DCNnYWsjXKl9iSQxnO68thhGBAp3OiGfDKfekM/KuNFL8lbToLdp57QRISOnysZeyJvGPjQJdFVu+voJ5OGJzcni5gYE0pOwS73Cx8VA9+6r1KVvTTC8idSRmsuK0XqpFcbhtuYROXSp8Bf5XGXRpBYP8cerKRbQ2cFVJQIesz1Ahmt2+KGPWx1OsWx4zh8dHTxn3tRgbar024HDTff3C3QuwkSUFVsfH/jszC6qLxzLqNOivq0/s4UM7z6vpn5dgdiT2IIFjL1EqH7areVMsf0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7g7pvjAWiSutqSkmqNMnuOxD7KipxGOOR1pqFn+3RQ=;
 b=JFig/mBPLyAmAug9sZY8qJONEo5PW8oOBb6K2b/ISpeWkXsCXuVqoo64VRXlDJV179Vo93S5lu7qmxj5PyopdX7xvq25wu1f64M4JKn1nwGKnM3YZii9znL8+Udop1LZtuxL0cYpzhQyRB7tHATddbO88WWM7mQMgKIHvdtz24A=
Received: from MN2PR15CA0053.namprd15.prod.outlook.com (2603:10b6:208:237::22)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:22 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::de) by MN2PR15CA0053.outlook.office365.com
 (2603:10b6:208:237::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.32 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:21 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:21 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/35] x86/bugs: Attack vector controls
Date: Tue, 5 Nov 2024 15:54:20 -0600
Message-ID: <20241105215455.359471-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f25833-218c-46e2-7f2d-08dcfde48bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MaSLJ6vekSB9mNWI4P4JXMO+j//ohEnhmGBDhpUpo/0YtMwQkpEHWo17i3EQ?=
 =?us-ascii?Q?6ZPOGI5tw8hhsZ7UpwTEVirEvWGcAahugIi5JuXhBQlA6+PKLef3oY1/CsKZ?=
 =?us-ascii?Q?K5hHxnMdo75h7zXvQm6aEGSYEJV4wY7A8aPMXaBPCukiTjD2LtzL5HuuH7BO?=
 =?us-ascii?Q?UyZagPj82fqlIuHigOpNlCGrnsi399YI9H0ehD2eQNnGYgR6pBwNIswr13mL?=
 =?us-ascii?Q?7ludaJOssYuJrjIILj/FKDqmZkRFakC4x4cVDD/ADuCnFWA03qkjS5zGqAnb?=
 =?us-ascii?Q?vRt4jipOY5C9x1/yM02ymE+f18OYgvDf69oByIlKSpJNq/6sRSDkT5S4VtCD?=
 =?us-ascii?Q?GUMbkLmCk7+dBdKp+F/lOQ40Nx4WLgXr7PQHaTgIReTc4YWTyV3p8OrCtxk6?=
 =?us-ascii?Q?x2lc08/tRYfkVmxRad8LnSb2nrLQ1/Y4c+4/Ytvrh6G2y0OQdeahVB0KlZ8R?=
 =?us-ascii?Q?GqICon7fzKze4G9fdDg5x904LCiTiGgPeEBVdUloadUAMGmPmFeirLVmbd3U?=
 =?us-ascii?Q?5Vao2XU5p+vXRDloR3G0TdcStL2lime231Z/oZeJ52GJA/nHgV/zOTuQLQ9T?=
 =?us-ascii?Q?RQJzJRMLRV5iCnmnVMx+u1UlNypH7/qYdvdEeNmY3iYd2SucQD1myP7xnL9x?=
 =?us-ascii?Q?957MiovmigcjpgefHN3EwHS1dg9Hq+naZpJm3G0MhPC48Rl/mwUQiezUC2iT?=
 =?us-ascii?Q?hf9PfBso9v4oZM4BupO4gYjcOYMWLhKBl0T9Hv//cMKXY3vuvPwx3dXYUemv?=
 =?us-ascii?Q?D6N0lew7BJdV+rUGz8qJFTFR1mRJ+WdgtwSuAUAA0eLEA2iA8TrK56udixvn?=
 =?us-ascii?Q?5n2h3YbvHttj+dKYgC1sWF8v6poUcd6/tMOrHiAoEdkbG1lWC+/Pxf+8qCn1?=
 =?us-ascii?Q?uGgprofvLSFs1vRjybrA7CK05Lj5AvG7M+uh+u8W5PkkIgbO9PY+spTBzzk0?=
 =?us-ascii?Q?L9UeZ8GCmj3MNo+yCQXewnjK09TbIA/Owxb/oJ7vn9y5SVROHjymwRCZj8B3?=
 =?us-ascii?Q?DRY+6yy85EXU8sK0wKzs+MkZiHd2SPB9nmOGbohZfsBX8c0HTtKhmPkuXNv2?=
 =?us-ascii?Q?mMykc4ixCpTP13wvR4bPYZMv7ktLssztMRHViIPLHUgVhsw0ceQVJjF6kxPv?=
 =?us-ascii?Q?9cRa5boF0Hl/+JVFDhh+yF4cGOSAd6mmURazFR0sTOSc4teugiIZkcEcMOdD?=
 =?us-ascii?Q?83pinTUUQxWbxsPnJUpOXermC2YoH8jCbdzZR5R3zQjfQFQzXPCSZ8j5pWBP?=
 =?us-ascii?Q?XdrfUQdsUtCqZZM75K0v0ptq13ra5aWqD/RhUlCCPln3EuocVgrV8kIfG3VV?=
 =?us-ascii?Q?JrDnKk2BflCS269eQ6rvlSVuve4dYZQwGwkVGfziXsZSmWvPXl8fGnoqvSGg?=
 =?us-ascii?Q?t6Cv5l6LTYDAiAV4dL5NQmv0tAxz6gTcVpCmfRaCy1S/QRHTcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:21.9997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f25833-218c-46e2-7f2d-08dcfde48bdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

This series restructures arch/x86/kernel/cpu/bugs.c and proposes new
command line options to make it easier to control which CPU mitigations
are applied.  These options select relevant mitigations based on chosen
attack vectors, which are hopefully easier for users to understand.

There are two parts to this patch series:

The first 18 patches restructure the existing mitigation selection logic
to use a uniform set of functions.  First, the "select" function is
called for each mitigation to select an appropriate mitigation.  Unless
a mitigation is explicitly selected or disabled with a command line
option, the default mitigation is AUTO and the "select" function will
then choose the best mitigation.  After the "select" function is called
for each mitigation, some mitigations define an "update" function which
can be used to update the selection, based on the choices made by other
mitigations.  Finally, the "apply" function is called which enables the
chosen mitigation.

This structure simplifies the mitigation control logic, especially when
there are dependencies between multiple vulnerabilities.  It also
prepares the code for the second set of patches.

The rest of the patches define new "attack vector" command line options
to make it easier to select appropriate mitigations based on the usage
of the system.  While many users may not be intimately familiar with the
details of these CPU vulnerabilities, they are likely better able to
understand the intended usage of their system.  As a result, unneeded
mitigations may be disabled, allowing users to recoup more performance.
New documentation is included with recommendations on what to consider
when choosing which attack vectors to enable/disable.

Note that this patch series does not change any of the existing
mitigation defaults.

Changes in v2:
   - Removed new enum, just use X86_BUG* to identify vulnerabilities
   - Mitigate gds if cross-thread protection is selected as pointed out
     by Andrew Cooper
   - Simplifications around verw-based mitigation handling
   - Various bug fixes

David Kaplan (35):
  x86/bugs: Add X86_BUG_SPECTRE_V2_USER
  x86/bugs: Relocate mds/taa/mmio/rfds defines
  x86/bugs: Add AUTO mitigations for mds/taa/mmio/rfds
  x86/bugs: Restructure mds mitigation
  x86/bugs: Restructure taa mitigation
  x86/bugs: Restructure mmio mitigation
  x86/bugs: Restructure rfds mitigation
  x86/bugs: Remove md_clear_*_mitigation()
  x86/bugs: Restructure srbds mitigation
  x86/bugs: Restructure gds mitigation
  x86/bugs: Restructure spectre_v1 mitigation
  x86/bugs: Restructure retbleed mitigation
  x86/bugs: Restructure spectre_v2_user mitigation
  x86/bugs: Restructure bhi mitigation
  x86/bugs: Restructure spectre_v2 mitigation
  x86/bugs: Restructure ssb mitigation
  x86/bugs: Restructure l1tf mitigation
  x86/bugs: Restructure srso mitigation
  Documentation/x86: Document the new attack vector controls
  x86/bugs: Define attack vectors
  x86/bugs: Determine relevant vulnerabilities based on attack vector
    controls.
  x86/bugs: Add attack vector controls for mds
  x86/bugs: Add attack vector controls for taa
  x86/bugs: Add attack vector controls for mmio
  x86/bugs: Add attack vector controls for rfds
  x86/bugs: Add attack vector controls for srbds
  x86/bugs: Add attack vector controls for gds
  x86/bugs: Add attack vector controls for spectre_v1
  x86/bugs: Add attack vector controls for retbleed
  x86/bugs: Add attack vector controls for spectre_v2_user
  x86/bugs: Add attack vector controls for bhi
  x86/bugs: Add attack vector controls for spectre_v2
  x86/bugs: Add attack vector controls for l1tf
  x86/bugs: Add attack vector controls for srso
  x86/pti: Add attack vector controls for pti

 .../hw-vuln/attack_vector_controls.rst        |  172 +++
 Documentation/admin-guide/hw-vuln/index.rst   |    1 +
 arch/x86/include/asm/cpufeatures.h            |    1 +
 arch/x86/include/asm/processor.h              |    2 +
 arch/x86/kernel/cpu/bugs.c                    | 1231 ++++++++++-------
 arch/x86/kernel/cpu/common.c                  |    4 +-
 arch/x86/kvm/vmx/vmx.c                        |    2 +
 arch/x86/mm/pti.c                             |    3 +-
 include/linux/cpu.h                           |   11 +
 kernel/cpu.c                                  |   58 +
 10 files changed, 1010 insertions(+), 475 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst

-- 
2.34.1


