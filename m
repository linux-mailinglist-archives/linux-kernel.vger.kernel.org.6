Return-Path: <linux-kernel+bounces-327120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248C2977118
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491631C20FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220C1BFE0F;
	Thu, 12 Sep 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ihnhD+87"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E41B1509
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168156; cv=fail; b=WlkBbtkVRmACD9dBGq1Q102CMHmYYEuCh3uiPbX8QmvZ1kaL1KLatLKs9SuTVPQEpUdvMjF4ZOONgf4L2pko6PpWiD/jydedV7ouZBU5yygQAtw2MP+lNN5Kj/eAj5JjKF0eGxIOKMy3KJnt7lmX5sAXaXW7o07tYpl0oDIG7UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168156; c=relaxed/simple;
	bh=wfl69nWqxZmm2ErvmUKhhojWpzScYrRuz/ySRZZVscc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NFPb/aWD2IMtfx+cPAozW2YlUTBk9qUpTqe986WRMCN5PA11bAlqjjkqDE1Y+XIqvLJSyCFtciru8tw9Xvuv6qMoJCtryAGh9WcD0TkqYohseS9bldHUxAOWetGXErQmRGnIg/8KPb14ALcX+TaiXsSPmx1zC5Ig9Z2zT+CTtV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ihnhD+87; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKEpLJEZtlSFI0VQ4b2q/tGx+lQf2xVdqrLfVB3BWsox/BbXD3P1Q1o11qw7sQr972DUhLFD29UX+XzFXy8fos1P/dQ1iaalr3zuf2DQED+gIbbziCqaLeiaoYnfdq6azDYomwcmarNZjIzpvECV+rwpTCO+c1Kn52mZAfmQY/99Sff05wGHj+8TwKTz5JYbdRAjHKP2S4pQXY8zU+wwvVcvSSuoGq6fwnvxUJ7PQR25rfYI7k+FjCRqy6Gi/QS/t/pI7zOw12r3C5ZN83HIfqY7evXq/sOh5KOdLele55GoLgopAYG5jyqUgRFHJGpVLxqhYzdWJERYjQfb8SXJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w52vmAp75JxScLrU6Txq5X1N3wbHtqwD4i+ORpN7NUY=;
 b=m/b2ySbdIpd0N2z9oUbBJ+a318xulsOWRZ5jV02plLDxMS2emNkeHLwZYqHhJ9XFio6PXb4NRpkBi2LgjxvUIQWHgptAEkoQUSqV8aZy/6VMZ0E0qZr1xgixwdHjcs6upuaA4cjWONbVHCczpyrdTJz+mQgpiiZwsMYN3+uf2UsDPYVRZnrRqQsLUOLGQAit/QiBlepb5GiGah0267YceZLe+U/J24TORfiF8zsnHqNcjRym7zS0hvgG6nB2Ovor+0YrOxP4T6POL+ydBcc4IeWSofvH/vw5gnrVnr1p5hiX/wu4E7BuTxVIypXKoPf/tehjIRivUVG/nBZr0rfLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w52vmAp75JxScLrU6Txq5X1N3wbHtqwD4i+ORpN7NUY=;
 b=ihnhD+87nxTp+NkAV2g5JfVVAjXCac8VhWp7ww8q74zr19kg/JzAKG3fLm1848XuDwTsDdIOMSedkSbuOlSlltDYcf3UKGAslLBJTwytosuC3XiJLfvH1oCXdJRMvrjTA2EfZaz5RRAbNu694a+mLVk3oWGDNsVTNcov1SxgiLo=
Received: from MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::16)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 19:09:10 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::3b) by MW4P222CA0011.outlook.office365.com
 (2603:10b6:303:114::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:10 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:08 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 00/34] x86/bugs: Attack vector controls
Date: Thu, 12 Sep 2024 14:08:23 -0500
Message-ID: <20240912190857.235849-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8f0d3c-b8b8-4b15-9058-08dcd35e61f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kzydgw17AD1lBMIAUGCA8sJaDO1VXABapca7gOhEMbxOMezqC+v/+bROjRe0?=
 =?us-ascii?Q?CBou9ot4lA3FX7bTRsNvyIly7yfiVx1wGc4PSSGgwwe9TSjXndalCz0/sx8R?=
 =?us-ascii?Q?57PdozE+ekVs9dRGbePQBJTkIDSiNNs39SNpO/8FNpNNFRu9egGJaUYn3xys?=
 =?us-ascii?Q?1QiZY3SP2OgsQW+dHvOidwtzE5+9x7g7G+5+z3QF9hCYFULs9s3gh2u3Mxk0?=
 =?us-ascii?Q?jULs8YFpbyh5/dDgvVbS8XZP2PoBt+44QuWbqqhSnohy9j9mRsQTKrCrUN4K?=
 =?us-ascii?Q?FsNaul4a0DrXC7qtePOMFnUiy9UNxredFp9JjgnhfK54Xr18xJ9B7o9bVmO2?=
 =?us-ascii?Q?yKvH9Vn0A/x5qUOVtptlmE1gT6Bduk7bd9y/oWzqZ8+LLzes/yZsKjylEsPd?=
 =?us-ascii?Q?ULJm4LLMHTMTGypeYoyC7pIl7yhwkyVla1jcubZvwIPW0WnhSaAn0iYg04zY?=
 =?us-ascii?Q?Xf3fifnxsv8Zq4sve3LO6vxkDqE8uUp4a6YinF/fyjfSkQ3ObMkBNqG+Rv19?=
 =?us-ascii?Q?zkUZM23+PX4tQ1ipW4UWpp8djq6vW+MyGC4EnpS5Ym29OqitVj3khckWSj5G?=
 =?us-ascii?Q?4YhZubEfBVxu0cbmu51X5CtL+EHo/9CE6TamoWAs3/ng+7NhUQpsIGn4g9AB?=
 =?us-ascii?Q?Xd+m9TZWTv4+ykRiRfE9F/x3xOvUPjckMSfq8BrW+hFp/XNqOPMJeNtdAK/X?=
 =?us-ascii?Q?H08E0LQgh1eI0e1AXCW8xXuwbOLbKBCNVXyRYX+CCpI8+vgBSryDoVtnrd0P?=
 =?us-ascii?Q?81KwwcqLb86gWgV41fXDQnTd4TqZ0KCJRrSKmK5BSByA7ZYBFChfyM8HoV/O?=
 =?us-ascii?Q?KrZxxbIgTCKA1k2uQh0RQbBcA4pbtEcSMh/FO5RojABOgDdZJg3dAQFFi3QJ?=
 =?us-ascii?Q?4E9x0IRC8yV46fD3EeAiDb3x/qfXogO+NgGt0bwH/FhDsRC5CC36TaXzdL5p?=
 =?us-ascii?Q?SGok+1P6S1KV9kuuvsPwkGvQRGfR0DR46CoErgWyD5R2SrAbXCBbaJOefPFO?=
 =?us-ascii?Q?JllyNKS2zyjtaR0pleeop+slJAjO3DOYceyXhIeqwajqN7Bd24/01p3hkdax?=
 =?us-ascii?Q?6vQLdRuk9OhI2qvsMbGcbaLH/mfZVSY0uzhObfrY/3ivYynzMnUX8WrhGVkg?=
 =?us-ascii?Q?JozeY20gsKP6USN7F8x6RHt7l+Aogj+BWepHsv59PZoDAIJBmM9GbDbEcJ5H?=
 =?us-ascii?Q?dwPtbUU51nlwE3hp2g8mi3MzR6o6Ct3p7tYpRIsEUe6HQ1/FL4trO3vnegrS?=
 =?us-ascii?Q?C6idM1pJ7NE5f2CydofXuuk75FvPOhpeIQXQeAhjguV0VnJurW9+A+g/1Zcy?=
 =?us-ascii?Q?CMK1F9hShTK+QuvKlVAk+JUJL4/s9mJSt81nmBlHDCCeMSgPdOg3/OKDKrXw?=
 =?us-ascii?Q?VP5SgYXWRouC/4P1r8JaVW4SKBg4HisB8XYAHx7fAxanAW+toCp0ixRL4IAz?=
 =?us-ascii?Q?pUwA+N6POVfU5gjkQWGVSgGO+ryJg3p9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:10.2009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8f0d3c-b8b8-4b15-9058-08dcd35e61f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385

This RFC restructures arch/x86/kernel/cpu/bugs.c and proposes new
command line options to make it easier to control which CPU mitigations
are applied.  These options select relevant mitigations based on chosen
attack vectors, which are hopefully easier for users to understand.

This patch series will also be part of a discussion at the LPC x86
microconference next week.

There are two parts to this patch series:

The first 17 patches restructure the existing mitigation selection logic
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

David Kaplan (34):
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
 arch/x86/include/asm/processor.h              |    2 +
 arch/x86/kernel/cpu/bugs.c                    | 1171 ++++++++++-------
 arch/x86/mm/pti.c                             |    3 +-
 include/linux/cpu.h                           |   11 +
 kernel/cpu.c                                  |   58 +
 7 files changed, 977 insertions(+), 441 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst

-- 
2.34.1


