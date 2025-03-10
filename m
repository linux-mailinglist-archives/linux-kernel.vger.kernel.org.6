Return-Path: <linux-kernel+bounces-554677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D5A59B48
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862683A6E87
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFA0230996;
	Mon, 10 Mar 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rAJfGgvw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5A622F17C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624839; cv=fail; b=gKPmOP2WPYcrbsWJxEpRfWNuTUKDuurDw4/ZR1M3M81ak67X18xxAAU+gUaqFvXqcKzgsfEZ5zsXLijaRM9hw1uw3Rd1+uNNeJVMTLV6WihIF7sXTGcBK74aFbhR7F/B1tfjne05HGjMZDWS90J8ErduGYgKIyQr5S5bz07N8xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624839; c=relaxed/simple;
	bh=LdY2Wrh8pA3HInJObcW0Z8BXruB8v3H4H6WBRzvjHjo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FqJyFr+PfLW9kuOXBrbzTa7GM4qVQIBZ/5bzZT8V9V1IHXZmJKrarml8GLa2SV1f3z2PqXu2WqWj0IM5uKMHyeJIJrrF8kTvzYYQCsiNQVTrzvVc+myvN8jptto1roB4KrmObv3+kJfB3MOH3yi1J0HLeApSphBkD59nVtGQh+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rAJfGgvw; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xi2YiNHkH6JU2trxzv0+Tl3lQJdkWRsUexlu9HG8v/DvJCbgI9NnNq/gGOHu4MFZWe9hgZJzI92r1eyDGEtgMk2+RUPCLvJru0i1ifxOkrHWlf9Z1W7R+yf1Q1yJ4Ob2u1gRdUGxrVSPEkxMTx6tZIbfBhZJnXCKtwpFUGFDxcMfXRH1fy3BpQjhyXCN1IVctKTD0SapTFXvoBYKrYnUKmmh5QRTY/Q+ght/SdCePh8ttJyDxcBh2UXs70hLlGrUJthxKTnj+SLV0URWjdmYtNFawngriY8MbHzpGS9M2xsDFUXKGdpkVySY0xg6wPkEpFgrykJaVOJS2Dm92C15jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy1e7AbaI0l0iyO3jFfUGq3avsKRwSRnj9oCBE44DL0=;
 b=WdRdrU4hOrcW9pux500TBRPY0WpfaAqbN6np0PPC6jOl3OHPy4LJpR9LODb+r4gRughcVepkRmYjpvmqS8LxG9QEbrKa8j6LIeDDqOe5T18DrJh2KcLc24nLgDS7XJlwinOv5Mb26llEP0NeTEmtGm7hjzZH0716a258jqf2t+J2PexIDjW32YDaqNuMG/izdh4AomfI9Neu8UKlLgsOZJR9YyXPhWjEvlZO7K/6RDQmLzaj5Ff76Arcgfd/WHUqj8fC7AzgICY1IgGqX+Rq2B4Z052JCFCZIcKlSGHeW0kqJoLh6KQdU1LcJmglJ27ZcU/ZorY8NfGqZ4HCYE7ZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy1e7AbaI0l0iyO3jFfUGq3avsKRwSRnj9oCBE44DL0=;
 b=rAJfGgvwl0lFYMt3rzb8q8D0yFuiMTqfqAnWMWlGKrP7gACYCbRuyfzipOhhBCsPmOkh5ZKX1VInOK73VCZrzt1AetbYFf0t0OVTSJ94fv+HEl31p198/tJpBOSttBt0MUradBUZPmYLfAIEMhaqkeyEBG+4/CFf2G0EqNIMjuY=
Received: from BL1PR13CA0071.namprd13.prod.outlook.com (2603:10b6:208:2b8::16)
 by SJ5PPF1C7838BF6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:40:34 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::78) by BL1PR13CA0071.outlook.office365.com
 (2603:10b6:208:2b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.18 via Frontend Transport; Mon,
 10 Mar 2025 16:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:33 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:32 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 00/36] Attack vector controls
Date: Mon, 10 Mar 2025 11:39:47 -0500
Message-ID: <20250310164023.779191-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: ea503b2e-26a3-4aaa-a2da-08dd5ff24724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vT4csCFqPqqrRH5tn5fRdRKRAdCnDNjiucm44zXZSD1YbgRz8g/b5uSOELj8?=
 =?us-ascii?Q?hCv3ShL+M9iUZX/ECtPRLJkbO4J1IfbL8Aw9Nk2s4GDzF7l6/W4F8RETs/tl?=
 =?us-ascii?Q?ceK81macLQQWcKCgB+wCw/Slkr8I8uoSokSfxhg4lExlOCASIRoQArP2liln?=
 =?us-ascii?Q?rq3wKbuQQUUN5LyRttTSyL29cEPb8bXlVpL6NRj2KWfz1+3pKj13aHTk6OHy?=
 =?us-ascii?Q?k7GIecGocgkqEjjeL5SC92Qvfsje6EKAh8wpEPSY0uVnnMPdXJ5CGau10/ZZ?=
 =?us-ascii?Q?rN9P/Zyii+JJyfIso4ofsbPPDexbLTNqY5kjdaTOzUyFkSprfSGkERpdfJpm?=
 =?us-ascii?Q?2eAni+CJCwgYv+9VatiASSftaUTcCBRZrygehdEeGcJYmJCspD5mPT63ae13?=
 =?us-ascii?Q?d00mopvahuJcUeA12t5DhSE+IWj+TGJ0FqtPcL+zZeBo1H7USGiTN9dAM1uI?=
 =?us-ascii?Q?X6YWkDsuDVU2Xpa8GAFf/VLayQrO+6awP3Q3vyHGwZu4CacjvT/tjoejOlvj?=
 =?us-ascii?Q?lgxo5Lb229b7O0bvsUMjmmICx77qFT5sCBG7WNCiTDNnOkL7TKvLn+iIZKQ6?=
 =?us-ascii?Q?LjEygkJQoW2q4qbaxdVEP1abMEl59vadQlMstgQppTmu3kPaj52EVlltubfH?=
 =?us-ascii?Q?gJyBQ5P5JQYBkSJIABMVHahk88A5j61BrnYqHhoW4+6nvOFH71pIgt8hA3On?=
 =?us-ascii?Q?efJnlhGadBtnOwM8MmeQd070gTlja96zir0Z4fAnaNcLEdHuwbVsb0PBKx1h?=
 =?us-ascii?Q?htW3oVAfUxJBtmGBBvN5K+3CpvxCMVLb0eJmn8k3b6iUDiw4qynlF2UiLt6a?=
 =?us-ascii?Q?fiYE1v289t5rA8GWndKUIc0fwjxwhCXfOpPDXw5e4wLPyjd2PmkmdqtBIHUd?=
 =?us-ascii?Q?SEjC4qlAroosR143SQQFSeaSMLR0u03Jy8RnxwUEEDzrpjtHA0GoiVx6dYz/?=
 =?us-ascii?Q?8Hn7hEq3/aNiBEOcX7OvbAjkW3+ONLnjuyS+Z2bOxR92i8TBhpb8G2xuxHG7?=
 =?us-ascii?Q?Bp4c4q+WDEl93iZ/3Ath1N3sSYMSsqu3dw1Cvmwb2zm8ZpoV2UFAThX82W3u?=
 =?us-ascii?Q?yVPlWgyFMTNw1GwzSwZzpIsgQjZUlW8iC1EqPnAI8DSfqs1WPUqQU0tzCCyO?=
 =?us-ascii?Q?wL/T+rXgejs1F29Mr4NUXH3rcHowwqWigN6seRRVpPb7dTykGpFVSjXpXkFQ?=
 =?us-ascii?Q?NguT/KH/QGyigDJhE4h7bN9zRAShfeFdRtF5P4sgMJdFOU78ZspdgB/RvNjW?=
 =?us-ascii?Q?7E+qohSPW9HbaCYRCgdjXVTsv0KcpTRqiaxHIz9uDSKxHbOo+5LXXXOXi3BI?=
 =?us-ascii?Q?FeXv7kpBZztjabZm4fURs3bd9fB44zsMwZNK8YQYqNXCZHIUp6YL3W98/jYQ?=
 =?us-ascii?Q?b9D4KslPXgu4PC780k1uQgL/jtW1bhYaXdxF8tGc7ml4j46ebdLE+AbQ6WZk?=
 =?us-ascii?Q?LCB6Wj1vBPj5U/KywNUOwZMZwZrA0ATUeXBOkzKWdI+3l17plJvrwaOxshSR?=
 =?us-ascii?Q?3dW/ZXzyY+G6B8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:33.6473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea503b2e-26a3-4aaa-a2da-08dd5ff24724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6

This series restructures arch/x86/kernel/cpu/bugs.c and proposes new
command line options to make it easier to control which CPU mitigations
are applied.  These options select relevant mitigations based on chosen
attack vectors, which are hopefully easier for users to understand.

There are two parts to this patch series:

The first 16 patches restructure the existing mitigation selection logic
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

The rest of the patches define new "attack vector" options
to make it easier to select appropriate mitigations based on the usage
of the system.  While many users may not be intimately familiar with the
details of these CPU vulnerabilities, they are likely better able to
understand the intended usage of their system.  As a result, unneeded
mitigations may be disabled, allowing users to recoup more performance.
New documentation is included with recommendations on what to consider
when choosing which attack vectors to enable/disable.

In this series, attack vector options are chosen using the mitigations=
command line.  Attack vectors may be individually disabled such as
'mitigations=auto;no_user_kernel,no_user_user'.  The 'mitigations=off'
option is equivalent to disabling all attack vectors.  'mitigations=off'
therefore disables all mitigations, unless bug-specific command line
options are used to re-enable some.

Note that this patch series does not change any of the existing
mitigation defaults.

Changes in v4:
   - New command line interface for attack vector selection
   - Rework of smt mitigations into on/auto/off
   - Print mitigated attack vectors in dmesg and sysfs
   - Various bug fixes and clean up

Changes in v3:
   - Moved command line options to be x86-only
   - Fix bugs related to ucode detection for taa/mmio/rfds
   - Various clean up

Changes in v2:
   - Removed new enum, just use X86_BUG* to identify vulnerabilities
   - Mitigate gds if cross-thread protection is selected as pointed out
     by Andrew Cooper
   - Simplifications around verw-based mitigation handling
   - Various bug fixes

David Kaplan (36):
  x86/bugs: Restructure mds mitigation
  x86/bugs: Restructure taa mitigation
  x86/bugs: Restructure mmio mitigation
  x86/bugs: Restructure rfds mitigation
  x86/bugs: Remove md_clear_*_mitigation()
  x86/bugs: Restructure srbds mitigation
  x86/bugs: Restructure gds mitigation
  x86/bugs: Restructure spectre_v1 mitigation
  x86/bugs: Only allow retbleed=stuff on Intel
  x86/bugs: Restructure retbleed mitigation
  x86/bugs: Restructure spectre_v2_user mitigation
  x86/bugs: Restructure bhi mitigation
  x86/bugs: Restructure spectre_v2 mitigation
  x86/bugs: Restructure ssb mitigation
  x86/bugs: Restructure l1tf mitigation
  x86/bugs: Restructure srso mitigation
  Documentation/x86: Document the new attack vector controls
  cpu: Define attack vectors
  x86/Kconfig: Arch attack vector support
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
  x86/bugs: Print enabled attack vectors
  cpu: Show attack vectors in sysfs

 .../hw-vuln/attack_vector_controls.rst        |  236 +++
 Documentation/admin-guide/hw-vuln/index.rst   |    1 +
 arch/Kconfig                                  |    3 +
 arch/x86/Kconfig                              |    1 +
 arch/x86/include/asm/processor.h              |    1 +
 arch/x86/kernel/cpu/bugs.c                    | 1302 ++++++++++-------
 arch/x86/kvm/vmx/vmx.c                        |    2 +
 arch/x86/mm/pti.c                             |    4 +-
 drivers/base/cpu.c                            |   67 +
 include/linux/cpu.h                           |   20 +
 kernel/cpu.c                                  |  129 +-
 11 files changed, 1248 insertions(+), 518 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst

-- 
2.34.1


