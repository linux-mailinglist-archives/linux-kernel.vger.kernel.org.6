Return-Path: <linux-kernel+bounces-227773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5630891566C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790521C21E62
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE32919FA92;
	Mon, 24 Jun 2024 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GEyGoHcE"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D219F488
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253322; cv=fail; b=p1tKi2jlgZZ0YN7lwJCCXXOXpHUORLetI18CpwSqEd6zodsNWsefmwWebWU6U50DPj7c82vLK+Y/ho/DiQQWpI75/Agvn0eT1sDIcj921myzW+9hZTTI3//G8pvhb4QXDT+44eJ/37JmydL1RbnhabWyXxnqHNn3WTKm95/Z5x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253322; c=relaxed/simple;
	bh=KMnNrU51AHoj7SypggOopSsUFQbVOXNKtOWQuOuQMvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNabBjEGLbFFe0yB7/O4uPZ4fnwZpKQI307uy9l58k2HlDPgabLnYt+DPDsRNHtzCrAD0imClKYfZPchNcNXcpLVVnnaC8qvt0jrB0p0t9pGbqlkqOY542fIiGgu0FBeKyfVIO3y2RfIfiqhcY8c0YzoFAljuZ6endd7Q7hYcd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GEyGoHcE; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv7jiPPZ47tEu6Whkgbl/Y85HSyCe2EM2hwuxAV2LEIEF2X+qfynUagCAnxQXbXaoS3JkOvUOWpCB0z9RNOfEs1dG0pZYnirCq8PQY2X/UwTR9eoblIsskLSCA+k/sY/G90Z72QBvkds/lic+Z3Ytoik2bXtjk0K/6jABJA8Cp4XUPdkPrIAHE5V14h6+F4AYYOfi9n2hg6QO6j+bDQOfFOCvalgfVDwJaJsL0C/XyD84vosJmYhpqBAk8WVy3GRtx8QEdC3aT0yvHvtwvaBRK/asXOyYbZ7w0+tiH7K/oiAibCpUvergkcR0BOEgYg4nBVcF+WmkBHcHjD+9jLKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAW6P1BTBJSfNIUvVl8FqTOvvJPB1XAot5xkWOzWcuA=;
 b=RNualZnek7ASHTIqSnvpAPIw5ye+kRnh7qjbOYGl6axhVmOkUdlHMcx9Bi2XeIOhgtu/7EuYjWbnr3XrwEz6dZywXeXkrjPXgeEWuSstDzpfdtQvqyeHUUe6SMSQQV2UrUO/ZPDp4CVeeUH1+7A5y9wzAd2ldrGwy5FVW3CAXrIEBqLgtFRU3at36Pwoolgdjbh6v3sSSeXfGL9kOEz7jD8R7jVjgHgutAceaPvVstirN3P8L+hTARSk1HK4EaixX617zWsGHY5T/ZBCqIi6AWhg9pCQKU/h460uhgeQScL2FfqbN4PC/+wI60iyDn6weV5DOsJk2Bqgy+XUCW/BZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAW6P1BTBJSfNIUvVl8FqTOvvJPB1XAot5xkWOzWcuA=;
 b=GEyGoHcE9EO4U+zCdASwJsncnX19LQtDaKec9cWEk1vcbZ01bMTAFjFHfxhYZjUKM99cYaMSEVyVUPSKbXDMfgkKnmK5ULLkwImO+80DGfpIQgWuN5I5BeeHN42G+rD4Q0sFx6/oDY//SKUZF++J7gHTTQ/NZbm+1iJ+ACAm4KA=
Received: from SN6PR16CA0045.namprd16.prod.outlook.com (2603:10b6:805:ca::22)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 24 Jun
 2024 18:21:55 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::f) by SN6PR16CA0045.outlook.office365.com
 (2603:10b6:805:ca::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 18:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 18:21:55 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 13:21:53 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <hpa@zytor.com>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kirill.shutemov@linux.intel.com>,
	<bdas@redhat.com>, <vkuznets@redhat.com>, <dionnaglaze@google.com>,
	<anisinha@redhat.com>, <jroedel@suse.de>, <ardb@kernel.org>,
	<dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/2] x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP
Date: Mon, 24 Jun 2024 18:21:44 +0000
Message-ID: <d38e9fb0c74e2688f866b0dcc39e417b4c302c7f.1719251730.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719251730.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1719251730.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4c3273-6331-4090-d624-08dc947a8760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6zf0uf4eqiO6oT4m7D6VdCagUpUIvkJYk3Nkfrw1MNW3Ng+U7ProZjYyd5lz?=
 =?us-ascii?Q?G0r2o+FS3GkuLMCa+wPN7jmgcVi6/OGnHcH3EqjMOmn07DO3E+3WlMJdKpPa?=
 =?us-ascii?Q?hN2b8lW6bjmjBKG/plvR+CmSKj86mzgxd+IkMKEYcW21eJUMYzgnVlF732W+?=
 =?us-ascii?Q?ufsYvwJzz+5I1r6FxQ/FjnlqpZ8tHC1LDWUz5NAGW3/5piUGxC+GbD5Zim3V?=
 =?us-ascii?Q?JIx4ARy8nCFhKymbWlchxls8Gnln4X29B6FasUFMH8ryJ7NOgpStjpo9cVKa?=
 =?us-ascii?Q?GprKxcLTs4ifXxxZ860/7nISIlIt0No2Vmz8Uf6hlF0asbUHdl6l6bRSikdw?=
 =?us-ascii?Q?rWYcc092MezBG2LpyTrqrJadZh8I3zjtrS+pkVbc2zhI3sK6mr//t2hcmcmV?=
 =?us-ascii?Q?0t6y1pZpzcV4ikHMu8rI70BHLqrANry8nWj9Hg5sgcnQokfRKiRglNfqV4AQ?=
 =?us-ascii?Q?ZMcPlW8jwBByLspPrFe5/iwFr/bZxJDLJ6BvnWec++BPwErLin3mTNCFNc25?=
 =?us-ascii?Q?tYqeUZSdeoqplD/4AeI7KQDklfI4IkG+RKIJtXBWBrY071KZS6ni8zm8t+8F?=
 =?us-ascii?Q?oPzb0hNB5V8dluKffVIny3KFuMhA4wOlWVcqpaZDh2lK9+bNiWLxaKucRjFb?=
 =?us-ascii?Q?GzwhLYaBcRIxfeakkS5Em6HJJGwVkiI/42q49+Vc7pU+BnhTBkOHaCyC3nrf?=
 =?us-ascii?Q?k6pga7I2lapWF688Qls7kYgu03JV8Dzqiwx/DBfSntTVtQMf9AOZ2zMZ7WkU?=
 =?us-ascii?Q?kN5GO9OT+UJMGA5/EVi+uwJ2GRiHM1bncx1aveyRwDgbwM0DRR4u3MnxsxdH?=
 =?us-ascii?Q?dCiH006tyZT9FiL46/SRz8rbcAAtme9HCV8Dv7guypTbE0PWhwOoWWBFAXIw?=
 =?us-ascii?Q?VFdmDhJseRULTD95ALX9H/UyO+eWd7VQ7wk5mkdUdhB0neNPAmomOF8EFKhW?=
 =?us-ascii?Q?wM2T8Womm+gnwhzhzApr6tqMPgBCUN38WXHPDAlMeBF9mqPAFFsqPh0WC/ke?=
 =?us-ascii?Q?lGYPEzzvqxeX2pBLLd5f1HItgl0sF50wFjGx8XCVa6K4Tr3LB7l3p24siDdF?=
 =?us-ascii?Q?0J/CbcutLTupnYpDWnNTHRDfxycB5WiEXGffPTVdVymA8FWjkucbGHm3avSe?=
 =?us-ascii?Q?w658PLXa+UKSVaDK//hD9EiYUaYcb2CqM8xM0MfUNVcqqKrEUsQIHfXgiFmZ?=
 =?us-ascii?Q?i5Kzygd12aP0pXj78EdaDui54Emtd3J7mZAwldFn5vJbRuj5RFTbqrWjPjQw?=
 =?us-ascii?Q?yimPKuN7jYQ5wMVQ34V/HmmlGY3f8XEFs/m9q2mX8XnSZfRagDTJZ/o2jKnt?=
 =?us-ascii?Q?SQ71rwbp5DSonfQnZvI7EAVOKXRZBV8yF4tV3MTy5rKSDtPoU5DXAS+e4JwQ?=
 =?us-ascii?Q?6GRXmeQnx7J8Ye6l8AdeCzw1t3TdXb4kZZtCP0yJ70vsU/KYUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:21:55.7334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4c3273-6331-4090-d624-08dc947a8760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819

From: Ashish Kalra <ashish.kalra@amd.com>

Accessing guest video memory/RAM in the decompressor causes guest
termination as the boot stage2 #VC handler for SEV-ES/SNP systems does
not support MMIO handling.

This issue is observed during a SEV-ES/SNP guest kexec as kexec -c adds
screen_info to the boot parameters passed to the second kernel, which
causes console output to be dumped to both video and serial.

As the decompressor output gets cleared really fast, it is preferable to
get the console output only on serial, hence, skip accessing the video
RAM during decompressor stage to prevent guest termination.

Serial console output during decompressor stage works as boot stage2 #VC
handler already supports handling port I/O.

  [ bp: Massage. ]

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/misc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 944454306ef4..826b4d5cb1f0 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -385,6 +385,19 @@ static void parse_mem_encrypt(struct setup_header *hdr)
 		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
 }
 
+static void early_sev_detect(void)
+{
+	/*
+	 * Accessing video memory causes guest termination because
+	 * the boot stage2 #VC handler of SEV-ES/SNP guests does not
+	 * support MMIO handling and kexec -c adds screen_info to the
+	 * boot parameters passed to the kexec kernel, which causes
+	 * console output to be dumped to both video and serial.
+	 */
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
+		lines = cols = 0;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -440,6 +453,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	 */
 	early_tdx_detect();
 
+	early_sev_detect();
+
 	console_init();
 
 	/*
-- 
2.34.1


