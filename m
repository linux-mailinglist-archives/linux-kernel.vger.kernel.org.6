Return-Path: <linux-kernel+bounces-510019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE678A31755
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DF51691F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4D267F4B;
	Tue, 11 Feb 2025 21:08:38 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBB265CA4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308117; cv=none; b=Z8e5QtJJmwYHWDfpuYfkhVx21u8Mzjp+02Hcu8iXI7lULhBqdKweX8BMnEqCDoaJO8dJmF/iNvrZvYi8ya3gMaQn+ApARlwTzDRpfLDFO8WMM7Onr+Reo8dLbWEtN7RDicOdD9S9b8xLq8V05/rmRdfKX8S6fy5dIApxA4XaNLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308117; c=relaxed/simple;
	bh=wCw1ieark1tIsBdlYWkv6Oa0GVUGGBc2snhDJcAm1wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CghYwOMLbeEHjz1tMS0Q76YF7gnRV7SM0kIGQaKhmG3+ydK/wpbSS29avoaWS5DXhuy22ksE+U3Xan5fqCqagIfrNU5xZRv1tMgEZpduFw5VvIjSaV+pjzvxzX3sz/5iqNYfGD4IW98QyOdzx/DmUqKe21IiU9Xx9VqGdmCmc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1thxUX-000000008HU-2dg1;
	Tue, 11 Feb 2025 16:08:25 -0500
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
Subject: [PATCH v10 02/12] x86/mm: remove pv_ops.mmu.tlb_remove_table call
Date: Tue, 11 Feb 2025 16:07:57 -0500
Message-ID: <20250211210823.242681-3-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250211210823.242681-1-riel@surriel.com>
References: <20250211210823.242681-1-riel@surriel.com>
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
---
 arch/x86/hyperv/mmu.c                 | 1 -
 arch/x86/include/asm/paravirt.h       | 5 -----
 arch/x86/include/asm/paravirt_types.h | 2 --
 arch/x86/kernel/kvm.c                 | 1 -
 arch/x86/kernel/paravirt.c            | 1 -
 arch/x86/xen/mmu_pv.c                 | 1 -
 6 files changed, 11 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 1cc113200ff5..cbe6c71e17c1 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -240,5 +240,4 @@ void hyperv_setup_mmu_ops(void)
 
 	pr_info("Using hypercall for remote TLB flush\n");
 	pv_ops.mmu.flush_tlb_multi = hyperv_flush_tlb_multi;
-	pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index d4eb9e1d61b8..794ba3647c6c 100644
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
index 8d4fbe1be489..13405959e4db 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -136,8 +136,6 @@ struct pv_mmu_ops {
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
index 2b78a6b466ed..c019771e0123 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -186,7 +186,6 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
-	.mmu.tlb_remove_table	= tlb_remove_table,
 
 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 55a4996d0c04..041e17282af0 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2137,7 +2137,6 @@ static const typeof(pv_ops) xen_mmu_ops __initconst = {
 		.flush_tlb_kernel = xen_flush_tlb,
 		.flush_tlb_one_user = xen_flush_tlb_one_user,
 		.flush_tlb_multi = xen_flush_tlb_multi,
-		.tlb_remove_table = tlb_remove_table,
 
 		.pgd_alloc = xen_pgd_alloc,
 		.pgd_free = xen_pgd_free,
-- 
2.47.1


