Return-Path: <linux-kernel+bounces-268111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96F194207A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7F22828AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ACF18C91D;
	Tue, 30 Jul 2024 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ish8g+XM"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244218CBE7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367325; cv=fail; b=AFgB7vWbwM/cdq9GVgh6NRwPyg/LBx/ZFRzI3Hx1M3L7uK25iP4mdE8Nkldzv8c6mEdmthH12JqU2zRieRjdk+bFNgnW4xC5lJf3RUaGKrH17SNXfC9Hj+2IEe5giOiEpbbuBiAfwyUAjdSaqtqZ0Io/+kgs+5PdoFoQ3NF9OKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367325; c=relaxed/simple;
	bh=efsRQR8o7+M937jm9XSqf31e4oYLfqTtnHWftfkwL+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLOrhlmry3ovTveznmul0XDleqzWM21n71w6fyAEH+wVY18CAH5y7OyTmWXMYKhRTphuFpzrN2ST8WPP7eq33GVTehFEtpSnWjI6IbNq5qx7uQbw5rlkLKbSRDlPeQFm4jaIr4lCSMBa3RYaYMb+HyY9U9K6SLLPHH710/i16z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ish8g+XM; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzzaE8DqQwMjLYTbP9rBfc/jSPRynI/TCLuAcRynIIScsbdpz9hal4qdD7QzCd/UeWLc9zILIFnNYXR8moTbZmabEU3HZpXKTV4JeQyBlJaTALPjGZVVx6WlWx4bzDIms2UBqj5aoHFK99Rf0M7H99tLxvq4rCDwti8+EmAMT3iyBRBJay1/R80aX3w/AUhRby3d0xzv4psmtKRtxjtFsPk7Xo0Mf+ey2f6a2kjeBKf+3jYgxgVFPVn8Ysx14RRfS9ajfci71Ma2dx+PW+6de4Xq3fbJ1IYqjSPgdUe3+R65UV0N9Hdk+8sPWkrkPcGkdbuL1ksVP6H387Iux6wGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVua1hy7vwstWs5HWq2CyiBvATNP2CLMrAGA6PMQpFg=;
 b=mbvrDSuYHedPk5HRl1a7zu+oN10eitklcTwd0m1GXsapi7AWv0DbpmEZT6GzN0Q9Jb7BZIpj5aCqih913USNfGyV1sFBykw0Rl0qr+P72dXeDcLWk58yCLTRCYjK6eVlpZ2YEzFIUEhRouchQS5GCrjyn3CczvOgXZth3jccBFDeS7TNDAG3XLBOjEUTXMhMf9mLHM+DwrqOwmbBo3XSHiyuHtqelYqWAEVWwqo/Fm063ZBrS/oLc1KmE60x4PtcBx0hkWVx+kSBzcpLJuryqn4dOgB/DN94b/hX8x5k8n1sZTKoJ1zABZ9oD1lYIsoMKjw1OQCy4BplSijHRHM49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVua1hy7vwstWs5HWq2CyiBvATNP2CLMrAGA6PMQpFg=;
 b=Ish8g+XM8IqFbJcVWiWlM0wXktb/INMMdDfss5JgVFhTKrbjobQvf/h+YjKbNLAPX+lPB0VzdxLroIc6ayLXXmpI8JdkzqGrzTKg6jErweJQ3c4GT23btwbK/BD+hPJ2DzTTsj5QHfvNM3U5sfEkDT32aXSEf9+eJ1ThrKOHb8s=
Received: from BN8PR16CA0031.namprd16.prod.outlook.com (2603:10b6:408:4c::44)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 19:22:00 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:4c:cafe::a8) by BN8PR16CA0031.outlook.office365.com
 (2603:10b6:408:4c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 19:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 19:21:59 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 14:21:58 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <dave.hansen@linux.intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <x86@kernel.org>
CC: <hpa@zytor.com>, <rafael@kernel.org>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <kirill.shutemov@linux.intel.com>,
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<ardb@kernel.org>, <dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <jroedel@suse.de>
Subject: [PATCH v12 2/3] x86/mm: refactor __set_clr_pte_enc()
Date: Tue, 30 Jul 2024 19:21:48 +0000
Message-ID: <88cc494fefac4fbe75d7bffd64ec32ad0d41a8fc.1722366144.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722366144.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1722366144.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6e6df1-4a5c-4cfb-a72d-08dcb0cce212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9qpLjjMxukY9nsKhY6MGzKb7s4WfZ9HfbPLMo/4aiS9SOcNwFYl54sbYeAgU?=
 =?us-ascii?Q?iDR/5h8RrCVhAZ4M0n9x6u++uHZw/lJchJ/MGQaSZ6dVPi6FxUFMGpLhb1Av?=
 =?us-ascii?Q?x1JRG7NeiBOfvVmOgwgupi7sac5KiU7a5Rez+CN4jJMTKGeALAljY8cjeW1m?=
 =?us-ascii?Q?aB7EIzLSvnhVcglA9/NSRmRyEKqPV1A2TlFxLHIiGN5glw7hy5NZwtOHWzgM?=
 =?us-ascii?Q?7iJ5TYBS7tRvWoCQ0GDt9m4QtgtBLz0X8HIqHxmfDpv7V69ynIJeQ7VMRwNz?=
 =?us-ascii?Q?pBTmgTHogv8LVWSzsRFrLNGtj0thoUXkFIsJKjAGQaxqvllpBuHT7J+r4DtH?=
 =?us-ascii?Q?cUQbmxSvuWcphEx6iwViik0Ab0RHtCYbE0UnLqWqJ1M9Fcb1z9VDPwoW+Vsu?=
 =?us-ascii?Q?oQWLnBFHgAZoL/OoGorirHzySVLLDocJhokV86N7lN+9MfpRCXWsq2rAghzw?=
 =?us-ascii?Q?xDG3ATdmkvXPEp0Tgskl0Z8aUdHpMcTiMEmZpzCkp5uqFqm7/UVJbjox5baC?=
 =?us-ascii?Q?BsyY8WeeT/TM3VT+WrTjltslOzEAAAta9UjkT0eAVClMq7C1sUHqqC9Xi2Wb?=
 =?us-ascii?Q?2O+N0gW42eOMmwauXFAUXPE7yI38kA72pPhGw0FUOJ/sIg7ezdfIeV7cdqp6?=
 =?us-ascii?Q?Vx+nEEsYKs1xdqRLurNVisXD3Zn0dsSH4IgsnyTpc0GwXPQXK7TnH7DczK5t?=
 =?us-ascii?Q?OwjH6zDEEWdoJO/p6pWcEJaZwsh8y8laJwr5NI5/GVXkbWjVpjXox/Itagw+?=
 =?us-ascii?Q?V4HX7P9MBygOcsVVAJVzeQQHKm9AyZlDPU8lT8m+6+uUAvESEu41UuT1Vw/v?=
 =?us-ascii?Q?iHCWiIWzMiChA/4F+mHfNeDgQSGh4RUgheTtzW5LQUzeXxMB5WhuoO+UBLMz?=
 =?us-ascii?Q?3krhQJCfmCXbyCj3m71naZhfVIw/AcCUe8RtVkMKPXqYYskglFHmlLERY1M+?=
 =?us-ascii?Q?8kg6m7O7Ccr4CRHq5GzQHl0qs7QFn4i5qlqTI245NJzaKCceo81P/LlUqmHP?=
 =?us-ascii?Q?R8mnmQ9lhrSYsU+qA5QIG8/3G3YWR261bACa+QCCAVy2JMY3TeKmK480DkSU?=
 =?us-ascii?Q?zegZn12fhFi2x2KX+RfLmtNLbT6qXy9cWxlTbNf9MdyiaNo4GUHFMVdM06pw?=
 =?us-ascii?Q?MSojzza6GO52O4ldYETvgYwXVYblcwoqhIAG+ifThy195dccJ4dqJzFaeYoO?=
 =?us-ascii?Q?J1H4Ovw39A5HrYFkCl41t+5dDfSB+4QMbl9W3sPuzhbOvHxpjm1cjOWLdCsU?=
 =?us-ascii?Q?l0d3cUxAHH4yowBsfgkfVfjuuvL/G/Rq6ci3zvHuIu7JG4XRvylPrfrDX4Ja?=
 =?us-ascii?Q?FA5lI6RczKyM4E9c8Ob67AVnMp5B+P6ZOMfNoiJsi9zb3mOg9SRSTsXnto/3?=
 =?us-ascii?Q?bitfknGNsQRJpLBkfLLleBg6+oubILqO1NpDps8tpcH5TeYQtzheugMQnaW1?=
 =?us-ascii?Q?SoGJEOx9kNwbGeiG6yOcCNRRseYD3fFQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:21:59.1989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6e6df1-4a5c-4cfb-a72d-08dcb0cce212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803

From: Ashish Kalra <ashish.kalra@amd.com>

Refactor __set_clr_pte_enc() and add two new helper functions to
set/clear PTE C-bit from early SEV/SNP initialization code and
later during shutdown/kexec especially when all CPUs are stopped
and interrupts are disabled and set_memory_xx() interfaces can't
be used.

Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/sev.h    | 20 ++++++++++
 arch/x86/mm/mem_encrypt_amd.c | 75 +++++++++++++++++++++++------------
 2 files changed, 69 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 79bbe2be900e..fd19a8f413d0 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -285,6 +285,22 @@ struct svsm_attest_call {
 	u8 rsvd[4];
 };
 
+/* PTE descriptor used for the prepare_pte_enc() operations. */
+struct pte_enc_desc {
+	pte_t *kpte;
+	int pte_level;
+	bool encrypt;
+	/* pfn of the kpte above */
+	unsigned long pfn;
+	/* physical address of @pfn */
+	unsigned long pa;
+	/* virtual address of @pfn */
+	void *va;
+	/* memory covered by the pte */
+	unsigned long size;
+	pgprot_t new_pgprot;
+};
+
 /*
  * SVSM protocol structure
  */
@@ -399,6 +415,8 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
 void snp_update_svsm_ca(void);
+int prepare_pte_enc(struct pte_enc_desc *d);
+void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -435,6 +453,8 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
 static inline void snp_update_svsm_ca(void) { }
+static inline int prepare_pte_enc(struct pte_enc_desc *d) { }
+static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 86a476a426c2..f4be81db72ee 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -311,59 +311,82 @@ static int amd_enc_status_change_finish(unsigned long vaddr, int npages, bool en
 	return 0;
 }
 
-static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
+int prepare_pte_enc(struct pte_enc_desc *d)
 {
-	pgprot_t old_prot, new_prot;
-	unsigned long pfn, pa, size;
-	pte_t new_pte;
+	pgprot_t old_prot;
 
-	pfn = pg_level_to_pfn(level, kpte, &old_prot);
-	if (!pfn)
-		return;
+	d->pfn = pg_level_to_pfn(d->pte_level, d->kpte, &old_prot);
+	if (!d->pfn)
+		return 1;
 
-	new_prot = old_prot;
-	if (enc)
-		pgprot_val(new_prot) |= _PAGE_ENC;
+	d->new_pgprot = old_prot;
+	if (d->encrypt)
+		pgprot_val(d->new_pgprot) |= _PAGE_ENC;
 	else
-		pgprot_val(new_prot) &= ~_PAGE_ENC;
+		pgprot_val(d->new_pgprot) &= ~_PAGE_ENC;
 
 	/* If prot is same then do nothing. */
-	if (pgprot_val(old_prot) == pgprot_val(new_prot))
-		return;
+	if (pgprot_val(old_prot) == pgprot_val(d->new_pgprot))
+		return 1;
 
-	pa = pfn << PAGE_SHIFT;
-	size = page_level_size(level);
+	d->pa = d->pfn << PAGE_SHIFT;
+	d->size = page_level_size(d->pte_level);
 
 	/*
-	 * We are going to perform in-place en-/decryption and change the
-	 * physical page attribute from C=1 to C=0 or vice versa. Flush the
-	 * caches to ensure that data gets accessed with the correct C-bit.
+	 * In-place en-/decryption and physical page attribute change
+	 * from C=1 to C=0 or vice versa will be performed. Flush the
+	 * caches to ensure that data gets accessed with the correct
+	 * C-bit.
 	 */
-	clflush_cache_range(__va(pa), size);
+	if (d->va)
+		clflush_cache_range(d->va, d->size);
+	else
+		clflush_cache_range(__va(d->pa), d->size);
+
+	return 0;
+}
+
+void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot)
+{
+	pte_t new_pte;
+
+	/* Change the page encryption mask. */
+	new_pte = pfn_pte(pfn, new_prot);
+	set_pte_atomic(kpte, new_pte);
+}
+
+static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
+{
+	struct pte_enc_desc d = {
+		.kpte	     = kpte,
+		.pte_level   = level,
+		.encrypt     = enc
+	};
+
+	if (prepare_pte_enc(&d))
+		return;
 
 	/* Encrypt/decrypt the contents in-place */
 	if (enc) {
-		sme_early_encrypt(pa, size);
+		sme_early_encrypt(d.pa, d.size);
 	} else {
-		sme_early_decrypt(pa, size);
+		sme_early_decrypt(d.pa, d.size);
 
 		/*
 		 * ON SNP, the page state in the RMP table must happen
 		 * before the page table updates.
 		 */
-		early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);
+		early_snp_set_memory_shared((unsigned long)__va(d.pa), d.pa, 1);
 	}
 
-	/* Change the page encryption mask. */
-	new_pte = pfn_pte(pfn, new_prot);
-	set_pte_atomic(kpte, new_pte);
+	set_pte_enc_mask(kpte, d.pfn, d.new_pgprot);
 
 	/*
 	 * If page is set encrypted in the page table, then update the RMP table to
 	 * add this page as private.
 	 */
 	if (enc)
-		early_snp_set_memory_private((unsigned long)__va(pa), pa, 1);
+		early_snp_set_memory_private((unsigned long)__va(d.pa), d.pa, 1);
 }
 
 static int __init early_set_memory_enc_dec(unsigned long vaddr,
-- 
2.34.1


