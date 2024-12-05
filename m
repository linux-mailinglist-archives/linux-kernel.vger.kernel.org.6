Return-Path: <linux-kernel+bounces-432970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAAF9E5284
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81186165C41
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D2A1DB951;
	Thu,  5 Dec 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DjWmvOG+"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C71DB53A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395070; cv=none; b=Yy3z3h0Fthuj8xCXHlGUQUN3e0UfoxR+9v3jz1laBkG8VNaHhjFIbgb7ys0AjDgVnU39qjc0GpF2iPM3ljVjZW7IS0KvkYxng149CT+bV9h52R4yeCHgeQWjXCJNf/zIH+O+dWV9WXZTu2lGNq1h0S479aJX0vAomLKrhsqATRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395070; c=relaxed/simple;
	bh=bhoYuDIqZkOX9ko/sk3hGKAPbQU4geAd213pGOmQX5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8xSAkKiTd6hZ37z02HlLypprW42fySAAbHh8W4ErwMlb0im8vS/xDSBEAZCa8oElX+5BV6jg1oaQEcat3XUcZWkFynOTyZGTrPREX1rKMqFsVGHjOLz88JwlSh81+cP6KnE2Zp7/bGCXowHMb+xJYE+7Ww7N8aR806EvVssY84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DjWmvOG+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2155157c31fso5771815ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395068; x=1733999868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNKH3fzWVL17kpFj96xVkU+IFapkCvyeY63L7HJogMk=;
        b=DjWmvOG+tAep76Y3SH3BzqLtsXnVMAt+XyQinfaA500SnFQESsFVXkoLDkmw6Ykxas
         xmqfbB9awhqzNATFO2oXtY3/NeHkQkkEZEN7bAfeN9koxOPkgltjR/S+jeTyvnfnBdPi
         NnaPzYGnWuDMoc/O76w/1fKwEIhsEJjK2r8kLzsJGlpCXVzK5ad167nwyeOc+Lr0cyaP
         vefec8xCftht+4fADwDuN/6/hk0sTL2QFjbh5X5WxvipD/cMZ4yupDIq7cgS9h0ETbs3
         pQIvjtxX/FluV5FOLUVaOqae0KOCqKNeC4bVVtJSM6d4c3eE+wipIM03T4XFtCccpO2C
         UkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395068; x=1733999868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNKH3fzWVL17kpFj96xVkU+IFapkCvyeY63L7HJogMk=;
        b=KQHN9hiTw/zNQ9cOkG3XEObbDa+H+DmCV2zH9yGC8hoV8HRVn/WzFxF/57FGMJcD2L
         mRvvfUv/axaBen6ZVm6DNzupYH3Mg1ytqOcsjH0giYquqCN8LYzS0cm7SQ0JCxVvEIY/
         qq3+ABvJUHxd9YIh9ccmrwuG9TeQ1b676eANm3ugCBeGr9xLCxkuhBgdckmLPDHLTv0j
         YSeYdY0svuEpEsla7cbE3vaM8qIeVukqWuf36NriWVgH/5zJiqSMbU56Se6SP5peYOJH
         79al7Lyrs34lQv9KZE5JuXeKLeaMYC09zYfW4vfdDpboFsC59sh4+VkK97vtsRm3wY8r
         A9hw==
X-Forwarded-Encrypted: i=1; AJvYcCUi2OEx8nRz+jc4IIRqH4qJ/pkuDHmdA4OpTjt4PKyTtgsSFVYhuR02nhoj0GUSUAc2yCZf9isdHdX0zNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYnRkn1cY+SQm4c9AIDBQ7EYDxX6XZx3JIAyqC1DjZjRS5/GfC
	MtsKmSZguUqF3FFUxwXk/vVrCK8sMpZ087SNsb2yBIO6+q7tmM2ZHZRioGfc5Rs=
X-Gm-Gg: ASbGncsEH4u+yl7j0oMyeqXnp6CyGp1EkpI4QRGEgN3D9Qep9Hj7DWP5Vb7TVnA4ytM
	/CjcsNPXj8s8NkmgDJCpHj9Y0DcEvDeDcQVeFjiww5TSSlECKhWs6i+HZ3rzka3RMLXI/f0Ednl
	FoYt2OuXY08hV+0iNwA+BMAc3bJyhegf/9G/4B3of96XhOylmVxW1jDKZIa1KKE9ayAppqVxUqi
	6K8SzyKwxYVxvHrvdT3qHLRZv7p6jSK0kLBTWiP2GiS0NXH8hhhdSWhA+YfVdGtq4w0F4O+FHSJ
	2HRCBa8F295A/wnTSSRp3CVg9FviK4rV
X-Google-Smtp-Source: AGHT+IGkn+Ya+kK82LZNSNu9BskAONVJ6LJWivbKYKO/n1RCbEvXyllqnQCmoUfNjTenfPmHl113mQ==
X-Received: by 2002:a17:902:d48a:b0:215:8112:2fb with SMTP id d9443c01a7336-215f3c7ec62mr46538845ad.13.1733395066881;
        Thu, 05 Dec 2024 02:37:46 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.37.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:37:46 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 02/21] riscv: mm: Configure satp with hw page pfn
Date: Thu,  5 Dec 2024 18:37:10 +0800
Message-Id: <20241205103729.14798-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The control register CSR_SATP on RISC-V, which points to the root page
table page, is used by MMU to translate va to pa when TLB miss happens.
Thus it should be encoded at a granularity of hardware page, while
existing code usually encodes it via software page frame number.

This commit corrects encoding operations of CSR_SATP register. To get
developers rid of the annoying encoding format of CSR_SATP and the
conversion between sw pfn and hw pfn, we abstract the encoding
operations of CSR_SATP into a specific function.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 14 ++++++++++++++
 arch/riscv/kernel/head.S         |  4 ++--
 arch/riscv/kernel/hibernate.c    |  3 ++-
 arch/riscv/mm/context.c          |  7 +++----
 arch/riscv/mm/fault.c            |  2 +-
 arch/riscv/mm/init.c             |  7 +++++--
 arch/riscv/mm/kasan_init.c       |  7 +++++--
 7 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9d6d0ff86c76..9d3947ec3523 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -206,6 +206,20 @@ extern pgd_t swapper_pg_dir[];
 extern pgd_t trampoline_pg_dir[];
 extern pgd_t early_pg_dir[];
 
+static inline unsigned long make_satp(unsigned long pfn,
+		unsigned long asid, unsigned long satp_mode)
+{
+	return (pfn_to_hwpfn(pfn) |
+		((asid & SATP_ASID_MASK) << SATP_ASID_SHIFT) | satp_mode);
+}
+
+static inline unsigned long satp_pfn(unsigned long satp)
+{
+	unsigned long hwpfn = satp & SATP_PPN;
+
+	return hwpfn_to_pfn(hwpfn);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_present(pmd_t pmd)
 {
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 356d5397b2a2..b8568e3ddefa 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -86,7 +86,7 @@ relocate_enable_mmu:
 	csrw CSR_TVEC, a2
 
 	/* Compute satp for kernel page tables, but don't load it yet */
-	srl a2, a0, PAGE_SHIFT
+	srl a2, a0, HW_PAGE_SHIFT
 	la a1, satp_mode
 	XIP_FIXUP_OFFSET a1
 	REG_L a1, 0(a1)
@@ -100,7 +100,7 @@ relocate_enable_mmu:
 	 */
 	la a0, trampoline_pg_dir
 	XIP_FIXUP_OFFSET a0
-	srl a0, a0, PAGE_SHIFT
+	srl a0, a0, HW_PAGE_SHIFT
 	or a0, a0, a1
 	sfence.vma
 	csrw CSR_SATP, a0
diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
index 671b686c0158..155be6b1d32c 100644
--- a/arch/riscv/kernel/hibernate.c
+++ b/arch/riscv/kernel/hibernate.c
@@ -395,7 +395,8 @@ int swsusp_arch_resume(void)
 	if (ret)
 		return ret;
 
-	hibernate_restore_image(resume_hdr.saved_satp, (PFN_DOWN(__pa(resume_pg_dir)) | satp_mode),
+	hibernate_restore_image(resume_hdr.saved_satp,
+				make_satp(PFN_DOWN(__pa(resume_pg_dir)), 0, satp_mode),
 				resume_hdr.restore_cpu_addr);
 
 	return 0;
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 4abe3de23225..229c78d9ad3a 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -189,9 +189,8 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 	raw_spin_unlock_irqrestore(&context_lock, flags);
 
 switch_mm_fast:
-	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) |
-		  (cntx2asid(cntx) << SATP_ASID_SHIFT) |
-		  satp_mode);
+	csr_write(CSR_SATP, make_satp(virt_to_pfn(mm->pgd), cntx2asid(cntx),
+				      satp_mode));
 
 	if (need_flush_tlb)
 		local_flush_tlb_all();
@@ -200,7 +199,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 static void set_mm_noasid(struct mm_struct *mm)
 {
 	/* Switch the page table and blindly nuke entire local TLB */
-	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) | satp_mode);
+	csr_write(CSR_SATP, make_satp(virt_to_pfn(mm->pgd), 0, satp_mode));
 	local_flush_tlb_all_asid(0);
 }
 
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index a9f2b4af8f3f..4772152be0f9 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -133,7 +133,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 	 * of a task switch.
 	 */
 	index = pgd_index(addr);
-	pfn = csr_read(CSR_SATP) & SATP_PPN;
+	pfn = satp_pfn(csr_read(CSR_SATP));
 	pgd = (pgd_t *)pfn_to_virt(pfn) + index;
 	pgd_k = init_mm.pgd + index;
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0e8c20adcd98..f9334aab45a6 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -836,7 +836,7 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
 				(uintptr_t)early_p4d : (uintptr_t)early_pud,
 			   PGDIR_SIZE, PAGE_TABLE);
 
-	identity_satp = PFN_DOWN((uintptr_t)&early_pg_dir) | satp_mode;
+	identity_satp = make_satp(PFN_DOWN((uintptr_t)&early_pg_dir), 0, satp_mode);
 
 	local_flush_tlb_all();
 	csr_write(CSR_SATP, identity_satp);
@@ -1316,6 +1316,8 @@ static void __init create_linear_mapping_page_table(void)
 
 static void __init setup_vm_final(void)
 {
+	unsigned long satp;
+
 	/* Setup swapper PGD for fixmap */
 #if !defined(CONFIG_64BIT)
 	/*
@@ -1349,7 +1351,8 @@ static void __init setup_vm_final(void)
 	clear_fixmap(FIX_P4D);
 
 	/* Move to swapper page table */
-	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | satp_mode);
+	satp = make_satp(PFN_DOWN(__pa_symbol(swapper_pg_dir)), 0, satp_mode);
+	csr_write(CSR_SATP, satp);
 	local_flush_tlb_all();
 
 	pt_ops_set_late();
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index c301c8d291d2..3eee1665358e 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -482,11 +482,13 @@ static void __init create_tmp_mapping(void)
 
 void __init kasan_init(void)
 {
+	unsigned long satp;
 	phys_addr_t p_start, p_end;
 	u64 i;
 
 	create_tmp_mapping();
-	csr_write(CSR_SATP, PFN_DOWN(__pa(tmp_pg_dir)) | satp_mode);
+	satp = make_satp(PFN_DOWN(__pa(tmp_pg_dir)), 0, satp_mode);
+	csr_write(CSR_SATP, satp);
 
 	kasan_early_clear_pgd(pgd_offset_k(KASAN_SHADOW_START),
 			      KASAN_SHADOW_START, KASAN_SHADOW_END);
@@ -531,6 +533,7 @@ void __init kasan_init(void)
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	init_task.kasan_depth = 0;
 
-	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
+	satp = make_satp(PFN_DOWN(__pa(swapper_pg_dir)), 0, satp_mode);
+	csr_write(CSR_SATP, satp);
 	local_flush_tlb_all();
 }
-- 
2.20.1


