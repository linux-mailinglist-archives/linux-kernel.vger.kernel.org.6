Return-Path: <linux-kernel+bounces-202809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAA18FD174
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BAF285409
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719003B79F;
	Wed,  5 Jun 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bGuaEnsp"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701519D882
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600758; cv=fail; b=LBn+KniK/kXvUg+I0/kkNs9mrtL5PnwQmbV79zMSfhI9dkFdAKyDZ7e48CHO/OK/1IGrZS7z2u/5e5B9opdG6LYGopcaKged1BBOgwDnypUdW0/ritkms3Q7dtnzGoEKmDWBHYK9VMCV+vwPz6PmwcBakJQoPonkx/uMDi8TdC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600758; c=relaxed/simple;
	bh=sEcVZKJ/IL0q7RC4Y/I2Mm5yQBvRKYnd7watFJ6zh9E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bzbKwNKehMJdwiA+WwLV48zEqOJFwRa7V/BFZHNCAJkWf6gaXpJ+LX2O4D5sYdOO8qwzrUOiqFR9EY80s2K41h6h6i3bPMlMPFSqJ5sgNjLRh6VxxBHTTWoevB1cpcLBZwp0cDoAu3mnLtEnbcv8wmj8JcKKInS78EbbUSMVprk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bGuaEnsp; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ac6FwFRbChrqP6+HY9ovCoMK36zkYinyDUFJjHL6gsryDogz/3OSJvAzosj3UnO6yQBLglyXpxJBrAeQDIO6z52r5s0syFtxQyZkyrIko+89JdPDYNIG9ln64Ia2XI9t+6Xq/gbYlBH64BCzzue8StqTx9sm3WFpWEQ/FEI7WqFX+wd+cU5NMr738VRubnzZYwNyQ5xlHdj7JXj2DRuyXf8lLPD1DdCDQW2zavQEgTpA4uEwUM8jSMA0sPjKfaDIH2iye59meYhJBZtYYs8by8E6C5KxVxnCUPly9YtlilmCf2mz3rDvBrJi23EO/I3iTXcSEmg+0hzO3ZmljYJRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gmh+Tteuz6OrhmSzXqoyz0CkeOHfGpa12bb7FZXfAZ0=;
 b=mzYnI5VoBD6hsJ2WXYyj3x8CO5PSzPA0qCENP+NkHfQQk4seaoAvOjPRnrcN3+HobaLeu+TkFW4fHgQZcb+/0mJvbTFqhFR0aY3qFIsrud4TOxWaL1eTi+dewAEfGR6yUwOR83aQJ5d9jE28QPMrZbcxs7rR82q+viD5Heo1xaUag8XGJVEBgYeX4EQIpPJHz+CoYJEcoR66sM0Pg/2FiV+QIwiYl85GX7IzOxLKE9oIbKpPw0uUPrkXdkZLtMeAghNPuHsVluo0fEJz1Xge8gdMs1A1IXiKuOkhANYxjgnG/1GSR2ox5wa7o92PdGhKL1rboAW0+m+m5jMXknLnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gmh+Tteuz6OrhmSzXqoyz0CkeOHfGpa12bb7FZXfAZ0=;
 b=bGuaEnspZv42Gl9Twgm0aS8b4x7TlW+hYUOI7PC0ja4TZiMY1CiSuwzvAfIsIJjUikGacAktCCkxCG36a0TvPpmtsPhvtG34LGa7h455FnK7QelDfTtC0TTgV+hazV8GucgcErWr/+xIwC1h9YkMofEwg/0HvB+S6h63rL0wDD4=
Received: from CH0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:610:e6::20)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 5 Jun
 2024 15:19:10 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::44) by CH0PR03CA0285.outlook.office365.com
 (2603:10b6:610:e6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Wed, 5 Jun 2024 15:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 15:19:08 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:19:07 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 00/13] Provide SEV-SNP support for running under an SVSM
Date: Wed, 5 Jun 2024 10:18:43 -0500
Message-ID: <cover.1717600736.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: d86d8201-a12c-4b8e-47f8-08dc8572d898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cfTfoy+F8dkWxBERn3U+8df1rdyDHy5xrxZLCsGPjen3JSA5MsvER8BQ6nZ2?=
 =?us-ascii?Q?wINE3hRtwqAda15sgx8b58Q2l8LX7UB30Wfb8CViaSNEW9YOSwW0Oo+kzcu2?=
 =?us-ascii?Q?siclvMTOVovFmqcHNPZYHHDaJ5e6IO10lqJe37+vvD6RXH9DWHtKDih9K2tW?=
 =?us-ascii?Q?6awR0ZO+WAQIJJgevHCQt8TMxmTNGoWCdHdTuxEUBwn91WTMfyCXp2wGHl3o?=
 =?us-ascii?Q?6D+bofzfBjQ9D7M9vTmxWUXzTOxkN0YysF/qlRBMZwtb8musdx8KSCQHfSjT?=
 =?us-ascii?Q?vuOXH4RYAgvihWqBXmSf7v+XsfAfYfZLPoKz7sM+1OvAZceDdAoYRT6Iev1F?=
 =?us-ascii?Q?11nKBN8vwBXcRxatBmwDb+DwSJY0xNMSCo8II0DNamXNhD4HatUTnJcUCLcv?=
 =?us-ascii?Q?w367qze+fLepCRStNigxJsICaZMsm4qCYzJxnyY4LAZS6uCNFfE+qsfJ2EB1?=
 =?us-ascii?Q?tt0XmbUjZUxx0e2B+nzT90yn0Db6TOZkd0XdpawoZEKsOEWAIAHmYcDoAk2Y?=
 =?us-ascii?Q?CaZnnskI0Vjvk0eDBnaDq4/P/fDvod5wf4IilTzXNG0VH2aB+GALhIGoFDgP?=
 =?us-ascii?Q?LLL37z8ygT3y18UeMAvULk2hzO9SQTpNkdl/JFo3EqvFoi2muL1zHuJfrKAL?=
 =?us-ascii?Q?SSBKsUYz9C3VSLhWlcOif0/qVsfvTiMZEug1YdMfcWrx53wnAaIVthC11HBy?=
 =?us-ascii?Q?kx/NuwhfTYFHZUWJ6pyJATqW2r62eCiyvSpoVU6pJHmKaq8mr5XZutN5CFOF?=
 =?us-ascii?Q?eQAZgTaB/axfLmTupMRKntai9zZYFqnEhGQcd9J1jySVahUYgvsbsb6M/3FT?=
 =?us-ascii?Q?ES9L6dVrUkQHwdvXJGuJ8nDfIcLhrj9vPfw98eFoQbegZpjrz0Uf7s1T4d68?=
 =?us-ascii?Q?6W8Y5y8d6cGs3FxYXSgMXTJbT9Vda3Il/x5bOzvnkO3I5SyrTSn/ZvI0yu2k?=
 =?us-ascii?Q?YKmBjJPXEv8Tf8nCkvwo2U+X2ANMm8sLQ2z9LYKEA8Lyjgmek89ZJTo+4HpQ?=
 =?us-ascii?Q?Ns8rni6DiGYovoUoGuw+PFdz1x3ZYToMSAB70P2VN+J8PDF/yYOW6WFDDO8p?=
 =?us-ascii?Q?lhBhk955P8RmeP/cV8YhrBoRGhmO2ZIdv6IHJ2EfTdZkBvP2Ia7LX17+XVgH?=
 =?us-ascii?Q?XtHfjJzhFWk/+HGKEeA7hpv/5o2yfcoQhk+ylz8k1Is2klu75eDnd+fIfXco?=
 =?us-ascii?Q?IXDpuPpabAIf3WBvDqCMimq62OBEU18TXVnmFDwBgf0XRo2L78J4ndX6k236?=
 =?us-ascii?Q?sGoyihBceNguRPGjLINsRr8REY9nnRJctpWizKilSHpbmi2GtJn/wFcnwX8W?=
 =?us-ascii?Q?TO7+AIrnVULyNdNhiEtUbYadqAgJdsLl2AwvkyaIS3mAdKoDku23R6qUOZCQ?=
 =?us-ascii?Q?o9JgolW4pBfRivqXl+/nn47DzDzIJNmEbkoryyLmnSx2x/i1hUsqRDeW7hJ5?=
 =?us-ascii?Q?gRPMvY/+oBg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:19:08.5298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86d8201-a12c-4b8e-47f8-08dc8572d898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988

This series adds SEV-SNP support for running Linux under an Secure VM
Service Module (SVSM) at a less privileged VM Privilege Level (VMPL).
By running at a less privileged VMPL, the SVSM can be used to provide
services, e.g. a virtual TPM, for Linux within the SEV-SNP confidential
VM (CVM) rather than trust such services from the hypervisor.

Currently, a Linux guest expects to run at the highest VMPL, VMPL0, and
there are certain SNP related operations that require that VMPL level.
Specifically, the PVALIDATE instruction and the RMPADJUST instruction
when setting the VMSA attribute of a page (used when starting APs).

If Linux is to run at a less privileged VMPL, e.g. VMPL2, then it must
use an SVSM (which is running at VMPL0) to perform the operations that
it is no longer able to perform.

How Linux interacts with and uses the SVSM is documented in the SVSM
specification [1] and the GHCB specification [2].

This series introduces support to run Linux under an SVSM. It consists
of:
  - Detecting the presence of an SVSM
  - When not running at VMPL0, invoking the SVSM for page validation and
    VMSA page creation/deletion
  - Adding a sysfs entry that specifies the Linux VMPL
  - Modifying the sev-guest driver to use the VMPCK key associated with
    the Linux VMPL
  - Expanding the config-fs TSM support to request attestation reports
    from the SVSM and allowing attributes to be hidden
  - Detecting and allowing Linux to run in a VMPL other than 0 when an
    SVSM is present

The series is based off of and tested against the tip tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

  77db0895e650 ("Merge branch into tip/master: 'x86/percpu'")

[1] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
[2] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf

Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>

---

Changes in v5:
- Create native versions of local_irq_save()/local_irq_restore().
- Add RIP_REL_REF() calls to functions executed early in boot.
- Fix logic around the return value of the SVSM invocations. This required
  changes where svsm_perform_call_protocol() is invoked to check the
  SVSM return value in the struct svsm_call variable.
- Update configfs support to only recognize group attributes associated
  with a particular item when checking for visibility (don't check for
  a default group).
- Move TSM configfs visibility support from the default group to the
  TSM report attributes.
- Simplify generated assembly for SVSM protocol invocation.
- Remove simple VMPL level accessor function and make the vmpl variable
  global. Rename it from vmpl to snp_vmpl.
- Miscellaneous updates (i.e. initialize variable when declared, rename
  functions, shorten variable names, etc.).
- Documentation updates.

Changes in v4:
- Add a pre-patch to rename the struct snp_secrets_page_layout to just
  snp_secrets_page.
- Move the config-fs visibility support to be group based and referenced
  by an index. Remove the macro changes that set the visibility function
  for an entry.
- Make the TSM visibility support vendor specific via an ops callback.
- Use the rmpadjust() function directly and remove the enforce_vmpl0()
  function.
- Consolidate common variables into arch/x86/kernel/sev-shared.c.

Changes in v3:
- Rename decompresor snp_setup() to early_snp_setup() to better indicate
  when it is called.
- Rename the "svsm" config-fs attribute into the more generic
  "service_provider" attribute that takes a name as input.
- Change config-fs visibility function to be a simple bool return type
  instead of returning the mode.
- Switch to using new RIP_REL_REF() macro and __head notation where
  appropriate.

Changes in v2:
- Define X86_FEATURE_SVSM_PRESENT and set the bit in the CPUID table,
  removing the need to set the CPUID bit in the #VC handler.
- Rename the TSM service_version attribute to service_manifest_version.
- Add support to config-fs to hide attributes and hide the SVSM attributes
  when an SVSM is not present.


Tom Lendacky (13):
  x86/irqflags: Provide native versions of the
    local_irq_save()/restore()
  x86/sev: Check for the presence of an SVSM in the SNP Secrets page
  x86/sev: Use kernel provided SVSM Calling Areas
  x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0
  x86/sev: Use the SVSM to create a vCPU when not in VMPL0
  x86/sev: Provide SVSM discovery support
  x86/sev: Provide guest VMPL level to userspace
  virt: sev-guest: Choose the VMPCK key based on executing VMPL
  configfs-tsm: Allow the privlevel_floor attribute to be updated
  fs/configfs: Add a callback to determine attribute visibility
  x86/sev: Take advantage of configfs visibility support in TSM
  x86/sev: Extend the config-fs attestation support for an SVSM
  x86/sev: Allow non-VMPL0 execution when an SVSM is present

 Documentation/ABI/testing/configfs-tsm        |  63 +++
 .../ABI/testing/sysfs-devices-system-cpu      |  12 +
 .../arch/x86/amd-memory-encryption.rst        |  23 +
 Documentation/virt/coco/sev-guest.rst         |  11 +
 arch/x86/boot/compressed/sev.c                |  83 +++-
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/irqflags.h               |  20 +
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/sev-common.h             |  18 +
 arch/x86/include/asm/sev.h                    | 136 +++++-
 arch/x86/include/uapi/asm/svm.h               |   1 +
 arch/x86/kernel/sev-shared.c                  | 457 +++++++++++++++++-
 arch/x86/kernel/sev.c                         | 442 ++++++++++++++---
 arch/x86/mm/mem_encrypt_amd.c                 |   8 +-
 drivers/virt/coco/sev-guest/sev-guest.c       | 203 +++++++-
 drivers/virt/coco/tdx-guest/tdx-guest.c       |  26 +-
 drivers/virt/coco/tsm.c                       | 177 +++++--
 fs/configfs/dir.c                             |  10 +
 include/linux/configfs.h                      |   3 +
 include/linux/tsm.h                           |  59 ++-
 20 files changed, 1596 insertions(+), 159 deletions(-)

-- 
2.43.2


