Return-Path: <linux-kernel+bounces-513375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BCEA3498F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A544D16E469
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9796027426B;
	Thu, 13 Feb 2025 16:15:56 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44F271261
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463356; cv=none; b=bP6MIaNBTXM8GTwU4yG02fPlQMUak546esvq5oJMKVHbULZDs9wKR0Vpz6GlZFNh+tvCDWhPGzjT4+g94XOpLEiwxIjH4gUG/F0/jHHYCHLVQjtaSS8R8ekDwfaYxZhzpRVumlUh5rcQZ0DCfxNVIWWUewpI1wBXn7KFNr0MaXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463356; c=relaxed/simple;
	bh=CJUWm0B9xrHsttPWBDyL6R6r42SqK+hog4Vtkzx8ncg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9GDbRutOkYrjr79rDM4Y1ymNDOSZ67fWtix2OHvz63khNJmSqTfMf7QsXk8dyEKW4/0lwsXEuySJA/8XCehl5f68/AUrb4KpOqMfSOTwrUkhr49IvO6MbVyH0Ba0l2+/0KDlKfDMeay1MzQA851t/2F2ActkstuuzpYE6yf69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tibr7-000000003xx-0VBu;
	Thu, 13 Feb 2025 11:14:25 -0500
From: Rik van Riel <riel@surriel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	jackmanb@google.com,
	jannh@google.com,
	mhklinux@outlook.com,
	andrew.cooper3@citrix.com,
	Rik van Riel <riel@surriel.com>,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: [PATCH v11 02/12] x86/mm: remove pv_ops.mmu.tlb_remove_table call
Date: Thu, 13 Feb 2025 11:13:53 -0500
Message-ID: <20250213161423.449435-3-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250213161423.449435-1-riel@surriel.com>
References: <20250213161423.449435-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Every pv_ops.mmu.tlb_remove_table call ends up calling tlb_remove_table.

Get rid of the indirection by simply calling tlb_remove_table directly,
and not going through the paravirt function pointers.

Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Qi Zheng <zhengqi.arch@bytedance.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/mmu.c                 | 1 -
 arch/x86/include/asm/paravirt.h       | 5 -----
 arch/x86/include/asm/paravirt_types.h | 2 --
 arch/x86/kernel/kvm.c                 | 1 -
 arch/x86/kernel/paravirt.c            | 1 -
 arch/x86/xen/mmu_pv.c                 | 1 -
 6 files changed, 11 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index cc8c3bd0e7c2..1f7c3082a36d 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -239,5 +239,4 @@ void hyperv_setup_mmu_ops(void)
 
 	pr_info("Using hypercall for remote TLB flush\n");
 	pv_ops.mmu.flush_tlb_multi = hyperv_flush_tlb_multi;
-	pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 041aff51eb50..38a632a282d4 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -91,11 +91,6 @@ static inline void __flush_tlb_multi(const struct cpumask *cpumask,
 	PVOP_VCALL2(mmu.flush_tlb_multi, cpumask, info);
 }
 
-static inline void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	PVOP_VCALL2(mmu.tlb_remove_table, tlb, table);
-}
-
 static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 {
 	PVOP_VCALL1(mmu.exit_mmap, mm);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fea56b04f436..e26633c00455 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -134,8 +134,6 @@ struct pv_mmu_ops {
 	void (*flush_tlb_multi)(const struct cpumask *cpus,
 				const struct flush_tlb_info *info);
 
-	void (*tlb_remove_table)(struct mmu_gather *tlb, void *table);
-
 	/* Hook for intercepting the destruction of an mm_struct. */
 	void (*exit_mmap)(struct mm_struct *mm);
 	void (*notify_page_enc_status_changed)(unsigned long pfn, int npages, bool enc);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7a422a6c5983..3be9b3342c67 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -838,7 +838,6 @@ static void __init kvm_guest_init(void)
 #ifdef CONFIG_SMP
 	if (pv_tlb_flush_supported()) {
 		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
-		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 		pr_info("KVM setup pv remote TLB flush\n");
 	}
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 527f5605aa3e..2aa251d0b308 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -180,7 +180,6 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
-	.mmu.tlb_remove_table	= tlb_remove_table,
 
 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 2c70cd35e72c..a0b371557125 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2141,7 +2141,6 @@ static const typeof(pv_ops) xen_mmu_ops __initconst = {
 		.flush_tlb_kernel = xen_flush_tlb,
 		.flush_tlb_one_user = xen_flush_tlb_one_user,
 		.flush_tlb_multi = xen_flush_tlb_multi,
-		.tlb_remove_table = tlb_remove_table,
 
 		.pgd_alloc = xen_pgd_alloc,
 		.pgd_free = xen_pgd_free,
-- 
2.47.1


