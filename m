Return-Path: <linux-kernel+bounces-271783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF994532D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F1CB25200
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E914A0B5;
	Thu,  1 Aug 2024 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RZscJf+H"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE914A0A8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539694; cv=fail; b=oRGl+jYi4q5fAXAK3nc0cLlJFNkQMMC5BsN2hEupUYoROqjFHyI0Vd8XTGWuyHgsDv1EynUvj1fme5H0Fz+Vk79uNHR++sR4V7O6eAvllRT6P3bn1TSVDWSaPT237pGSrz19jKWkDv2bYnpxvVNVu0DZYgVu5Co7MQZ+i7HfLoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539694; c=relaxed/simple;
	bh=IpEEkTWazmLUDVqTT44TaeBp5qf6bI1N7qj4CZTt7g8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UODnnkIv9ahmQHUpP9cMDiotIVzMIus1pXZpyCjZRqHDXi/G2DSIBaYUdllje8U+eT/2TbwtMZwmICiCWHdk4j3SjfWwTYEMIH8FX+wiq4q3JjOFU8gAlqxS5drIwpu57dBa7ruYRZvOwydJ6Aj9LWvxhmlU6ClpFpO/bjZgbH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RZscJf+H; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLXVXNCxwmWUKwhBiL2ks8zK6dLGuc02XB6Pbw2LGLKr5fVBWTcxuEYTjZvR1vDmPtzkWFbYndhHvZBPAIgpIZ8DKlD32H2xplxoISSzoxOJTSG6QO4LYNXGWTlt/XBwAK8dahye4SNuEq8U1Zn7fRbjxufxCdgAN+XdAwYRlGajoyOJ/0XqdCXotdBxrB/FeoM3CVsdQBywcCe2Z3JbDbEJMl2fOQSU886N/L09bngeCsnBrQ1oN+YKg5Ubz2+SfdlQMsiqH1aLEvcjjecAjOfIi8+FLnHCZgW84V6HCNJX87pPhAIxnHbJeZtWCjVtF51Rzx/OJUfUff7IGuDE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQaKzSYc2yfLaDGSs6b5vdGPA/OVbJtMVKfdMV3omlM=;
 b=cClsDUyRo4Q5r4wM/+nyQ9KM99+JkT5yyCxl2khq++bzBM9DrUV3i2UY8daplne+X2TvAt+TTFOPbXDJUIQys4f9IwuDY3WXgqRBiEFAb5IHtVmYzqXXX47/ldXn/RUTKqhADgie1yTSseG42qj6J/0dwTFUOR0weDoTWwEKeOCCL+Ly5iKdNoBgkji3voSgis+KTJRjm83LtCuDCffRQsqUjimRp5dcYMi8Qsud6DY9VY90fCeSast3G6bgshZhpq3/O1wOsm1xdT7QxAvLqCW5fJIQwSSKXHuWzjjKm8B7ewUEE0DR2eS8TxK6Ygc2cAYU4gCd8xIW1TEyGZ5kNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQaKzSYc2yfLaDGSs6b5vdGPA/OVbJtMVKfdMV3omlM=;
 b=RZscJf+HHrn5OTRpiYyPYTdfd1PsLfgjHyi5PBtjmdufRp/IC30zclJfO5dmVQ7A9reK5k5BUy3UELpx3bcBhQ5qZCyradhviFUByaZjo9i0TkrXSfkXxcmbWMHN13cS4XO7agpOGEmQjPe5LLVBReoqlrpgBZxCM2l8sPLZFo0=
Received: from SJ0PR13CA0182.namprd13.prod.outlook.com (2603:10b6:a03:2c3::7)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 19:14:46 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::d3) by SJ0PR13CA0182.outlook.office365.com
 (2603:10b6:a03:2c3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.6 via Frontend
 Transport; Thu, 1 Aug 2024 19:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 19:14:45 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 14:14:43 -0500
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
Subject: [PATCH v13 2/3] x86/mm: refactor __set_clr_pte_enc()
Date: Thu, 1 Aug 2024 19:14:34 +0000
Message-ID: <5df4aa450447f28294d1c5a890e27b63ed4ded36.1722520012.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722520012.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1722520012.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d2f426-4e22-4d3a-d8c1-08dcb25e3471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GqZ2L+Bp1LyfHOEN9vgDsy52i7NyWvD2cXZ9HHsol5ByvL4BYAt9H6/RYXI+?=
 =?us-ascii?Q?yeSUL7fpnUlqjpQQsCyqm0suIqvaZRcEikmCGn3z6uKawSHwnpqXAk+Makb9?=
 =?us-ascii?Q?Wx1qT9fvgnHWUlaGifGhk72Dv4qm187+FmYAttZnIf5RRfXPUr06m3tMpQFB?=
 =?us-ascii?Q?NLky1he+Kw9v4aPHLjHJGknJSYl24Mg/rXMLj6BW4Z8Sk/xD7DHuxsVeT5rh?=
 =?us-ascii?Q?0+LDhs0CRAu14uBRpGVTJV7aQY6KPFmhOm+etftogyusJtuWASV00UbasroK?=
 =?us-ascii?Q?WglQWXKeXQv8YjFVPcaQ1FQlh1xyh0tHwtY1ncyorwAbdhjisXi5BQbzskRJ?=
 =?us-ascii?Q?i3+C1Rjeiwc1PAyO0wvJ13GblsEuE6EXAbKcdkdBQCJWoIB9TEWQ1qnj1I/J?=
 =?us-ascii?Q?KVRcPe6lDYpUiZKCVPApAK+29jOiCZl4B8sgLuWHLYgpgj5AqqkZvybta+la?=
 =?us-ascii?Q?r6LKn4sNbukic3FTTd0o7zDOstSxDtBf4hDolI93yu6Pmq5k/hhMtL+XHfIH?=
 =?us-ascii?Q?ffKmt9JKAWuBc0IK3N6N86w6tUB6eUk8/w8qxH1jGQv2sLyLjTP9crHgqp+Y?=
 =?us-ascii?Q?uC0i2cMUniF0v9yA16NVSv8OodhXhjkxWrogNBiO9Gig+Q6MH7NCi6mXWd0Q?=
 =?us-ascii?Q?BqdowrpWQ1XFnCGWgKOGLZiErqRV3yXlbulsgyNROQtqxSN6Dc2bof9ffuhr?=
 =?us-ascii?Q?pKEdg2ijouE13EuAclg3SzRG9X5+YzrfLOQE0ApNBwfGKvY3CsCZ8wMjlAKx?=
 =?us-ascii?Q?kaIchQ65b/bnMfktgKNHtbdA9OpTXlbUa53eZD0hEz9xPxDablZcWj0EM+wi?=
 =?us-ascii?Q?jFzQHIsDOaFGFIYWqXIXAkLBTLS3Y0ErQO2/QhvnYIsS6w/lwwmAwcicO6Tl?=
 =?us-ascii?Q?rCZPQkOgSp/ezdJXsSwbc0eOwQHfiCBetlWpXmT0Jveft0EED2LySDaM2KQd?=
 =?us-ascii?Q?BF7FkH1YOYzrLhrzGM3wWHdEFVBrH+pM18AKWm3pEyguJkUoWnQCrYEh49B5?=
 =?us-ascii?Q?bTOwHksSIOZZIY8a9BqJf/VcrQOOJdL0wbhXDJE2tljdVJPhu+RAID78vkQl?=
 =?us-ascii?Q?jwDUa9Jiq6Z1X2bJ836sD4IiVnXzxdnVThLiMNiGlJewrsPDuO098cW7wlLl?=
 =?us-ascii?Q?i5AtydJJ7fDc9FWqLyAd3/gwb9ahuR8SSpAqfCoJTNxc+QndxTcVjdtNeErY?=
 =?us-ascii?Q?at7nur80874bPmt5BTLAfjRtoYAOG+hBPBsqNWS6srVu2Lr0EBsBAg/uo9uR?=
 =?us-ascii?Q?i9ICoZvPJzPB9/z+YUuubvcuuTfEs0edm67pm6DFCEOJcz12A9ry5SDeSIhh?=
 =?us-ascii?Q?1PezpG2ebaDlCQiQE9jdblQ0LhdzEBJXM3fslz+LRCBB8AZe6jezDymoXHzo?=
 =?us-ascii?Q?L7SL/26TzcXbxLmi8azNtxg3hD+dA+fMpM2dzX1vq+vXQj57JwKWpw5HanX2?=
 =?us-ascii?Q?u0MYBdpxQMUO2kcFrOmdke4VSP9vWTPo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 19:14:45.5220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d2f426-4e22-4d3a-d8c1-08dcb25e3471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277

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
index 79bbe2be900e..61684d0a64c0 100644
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
+static inline int prepare_pte_enc(struct pte_enc_desc *d) { return 0; }
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


