Return-Path: <linux-kernel+bounces-383315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABB19B19FE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938B21F21DB8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB601D7995;
	Sat, 26 Oct 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JYEOW7An"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B91D47BB
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729962890; cv=none; b=myt7+U+SS2N7DyUDuAWDy5Mf81pRWvomcwJh85rBrq0+s8UXjNGaZDVwIK95A2IpsOl6JTuZ7rCyTYTCqSIjIQn63NdTtzDdoj2PyXz52DlJG8VMj+bOhD6PhdRDrgnL1CBjJuv2F0L+p+txzou5k2hpzMT+YxlNFzocAQWgVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729962890; c=relaxed/simple;
	bh=f0XkWnXn5gQr91r80HnZ4l91Q6+e90mpdLHSv7oesJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Smge1CBMpztVTpyRyUl4kXBnZN6HQSvbMVWX4dO4/pIOCHy73YIi6uLY040dlQ/wT4KHIRMNnOUcyfazkLVbYbx38DTVKmPB2j/hPpunPzAm2O6hIck1Lx2sREGIqfxN+zYEylgThC7KyKE8hKUvR1MB8OOgG5vTRk3MXvzdhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JYEOW7An; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e30fb8cb07so2187934a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729962888; x=1730567688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiHFo4DmtdeXVJSdAkSejNf62f3o6R3z/nVT/XM/LXQ=;
        b=JYEOW7An2RyYSqa32+bBUCYyHAS4uJ4+A+KqI0dAIHhZN2yGnX0VQEt9jaP4jMaMxV
         4IcIQUD758pVlcVX4Xnamk832NrYQy6HFoW3VJQcagN/HzVeiIXKSLagztV48bczXWGE
         59xFbxlHFNapfHnXoI7VAnfSf6w0v58oVBpPEr41dTn3U22GbpGWH8TTsrpFM2Fw/KDq
         CTYmHswYYeS72zF3OXiTvxHonaxyQBMq85681SiCz0Is0dLdlNvTqPWYpgZIVMKzBOP1
         M5t1WuYRqRARmhc2jpS4qRrHnYZoLllg3LQfUXKKNaXOVMG8MFBJ7JUPByHpuLZpk93D
         St4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729962888; x=1730567688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiHFo4DmtdeXVJSdAkSejNf62f3o6R3z/nVT/XM/LXQ=;
        b=vUSQjX2ButNjXFtphYAPbXo9be+S7UFV0S6Sqxp8frjwu/wW/M1ZU6ju7uH0v8W+aU
         CfBkI/l5YCZmsqgUL5rUozf4Km8Je/vtDNb5yaxYM/aADsLbPh/lA9VkiSUO2oWC4r88
         ItbVZc1lVWtVKTJtlEqpk3F4EHlH5oXi3bWofQYERDlEnvdN0zQNfwK+iV+PiMV0/qDN
         hNTE0rOb/CjJcfyHZ8yx95AIyhDvIFKDL2Fuv4tCROZoTBC5Zc2+6BpgY5H5dbWpw4yW
         U195/SYxbt78PPrvHoFRBVMeAuHPUM9GA2rBVyen+iilrD0/qOG/xfv5PwyBSDrhtd+B
         pjow==
X-Forwarded-Encrypted: i=1; AJvYcCXPi2tmVPmNG/w5cbv3+pQK5ytlLuHdc4xZSbI9LC9+aEYkCREgy8rKx72tZXz7ez0h4Pl3w+mGiFFr79I=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZiji2gYIdpprCiPO/+N+ZztqBFJplk7JEcqlIHpY7qQRGtxn
	sun97iYJO6pAx7koGFT2gU9TkuDtCf8wTPEzcjQZ+op36x7qpOQtC1ik5vbh+ziOsLJjBETPnsh
	u
X-Google-Smtp-Source: AGHT+IEzN1IbGCkMVdSp3rlof3XN99qFbQm4PDAwtLCkE/kwbj+tFrZvPVcsHIV6RGdY5SSQlNI55A==
X-Received: by 2002:a17:90b:1202:b0:2e2:bbcd:6cbb with SMTP id 98e67ed59e1d1-2e8f105081dmr3625438a91.6.1729962887736;
        Sat, 26 Oct 2024 10:14:47 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e558114sm5663762a91.36.2024.10.26.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 10:14:47 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 3/6] riscv: Support CONFIG_RELOCATABLE on NOMMU
Date: Sat, 26 Oct 2024 10:13:55 -0700
Message-ID: <20241026171441.3047904-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241026171441.3047904-1-samuel.holland@sifive.com>
References: <20241026171441.3047904-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move relocate_kernel() out of the CONFIG_MMU block so it can be called
from the NOMMU version of setup_vm(). Set some offsets in kernel_map so
relocate_kernel() does not need to be modified. Relocatable NOMMU
kernels can be loaded to any physical memory address; they no longer
depend on CONFIG_PAGE_OFFSET.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Kconfig               |  2 +-
 arch/riscv/include/asm/pgtable.h |  4 ++
 arch/riscv/mm/init.c             | 82 +++++++++++++++++---------------
 3 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 62545946ecf4..4420419e7054 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -934,7 +934,7 @@ config PARAVIRT_TIME_ACCOUNTING
 
 config RELOCATABLE
 	bool "Build a relocatable kernel"
-	depends on MMU && 64BIT && !XIP_KERNEL
+	depends on 64BIT && !XIP_KERNEL
 	select MODULE_SECTIONS if MODULES
 	help
           This builds a kernel as a Position Independent Executable (PIE),
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e224ac66e635..d0190ee9b2e4 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -12,7 +12,11 @@
 #include <asm/pgtable-bits.h>
 
 #ifndef CONFIG_MMU
+#ifdef CONFIG_RELOCATABLE
+#define KERNEL_LINK_ADDR	UL(0)
+#else
 #define KERNEL_LINK_ADDR	_AC(CONFIG_PAGE_OFFSET, UL)
+#endif
 #define KERN_VIRT_SIZE		(UL(-1))
 #else
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0e8c20adcd98..a74e28367f9f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -307,6 +307,44 @@ static void __init setup_bootmem(void)
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
 }
 
+#ifdef CONFIG_RELOCATABLE
+extern unsigned long __rela_dyn_start, __rela_dyn_end;
+
+static void __init relocate_kernel(void)
+{
+	Elf64_Rela *rela = (Elf64_Rela *)&__rela_dyn_start;
+	/*
+	 * This holds the offset between the linked virtual address and the
+	 * relocated virtual address.
+	 */
+	uintptr_t reloc_offset = kernel_map.virt_addr - KERNEL_LINK_ADDR;
+	/*
+	 * This holds the offset between kernel linked virtual address and
+	 * physical address.
+	 */
+	uintptr_t va_kernel_link_pa_offset = KERNEL_LINK_ADDR - kernel_map.phys_addr;
+
+	for ( ; rela < (Elf64_Rela *)&__rela_dyn_end; rela++) {
+		Elf64_Addr addr = (rela->r_offset - va_kernel_link_pa_offset);
+		Elf64_Addr relocated_addr = rela->r_addend;
+
+		if (rela->r_info != R_RISCV_RELATIVE)
+			continue;
+
+		/*
+		 * Make sure to not relocate vdso symbols like rt_sigreturn
+		 * which are linked from the address 0 in vmlinux since
+		 * vdso symbol addresses are actually used as an offset from
+		 * mm->context.vdso in VDSO_OFFSET macro.
+		 */
+		if (relocated_addr >= KERNEL_LINK_ADDR)
+			relocated_addr += reloc_offset;
+
+		*(Elf64_Addr *)addr = relocated_addr;
+	}
+}
+#endif /* CONFIG_RELOCATABLE */
+
 #ifdef CONFIG_MMU
 struct pt_alloc_ops pt_ops __meminitdata;
 
@@ -877,44 +915,6 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
 #error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
 #endif
 
-#ifdef CONFIG_RELOCATABLE
-extern unsigned long __rela_dyn_start, __rela_dyn_end;
-
-static void __init relocate_kernel(void)
-{
-	Elf64_Rela *rela = (Elf64_Rela *)&__rela_dyn_start;
-	/*
-	 * This holds the offset between the linked virtual address and the
-	 * relocated virtual address.
-	 */
-	uintptr_t reloc_offset = kernel_map.virt_addr - KERNEL_LINK_ADDR;
-	/*
-	 * This holds the offset between kernel linked virtual address and
-	 * physical address.
-	 */
-	uintptr_t va_kernel_link_pa_offset = KERNEL_LINK_ADDR - kernel_map.phys_addr;
-
-	for ( ; rela < (Elf64_Rela *)&__rela_dyn_end; rela++) {
-		Elf64_Addr addr = (rela->r_offset - va_kernel_link_pa_offset);
-		Elf64_Addr relocated_addr = rela->r_addend;
-
-		if (rela->r_info != R_RISCV_RELATIVE)
-			continue;
-
-		/*
-		 * Make sure to not relocate vdso symbols like rt_sigreturn
-		 * which are linked from the address 0 in vmlinux since
-		 * vdso symbol addresses are actually used as an offset from
-		 * mm->context.vdso in VDSO_OFFSET macro.
-		 */
-		if (relocated_addr >= KERNEL_LINK_ADDR)
-			relocated_addr += reloc_offset;
-
-		*(Elf64_Addr *)addr = relocated_addr;
-	}
-}
-#endif /* CONFIG_RELOCATABLE */
-
 #ifdef CONFIG_XIP_KERNEL
 static void __init create_kernel_page_table(pgd_t *pgdir,
 					    __always_unused bool early)
@@ -1359,6 +1359,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
 	dtb_early_va = (void *)dtb_pa;
 	dtb_early_pa = dtb_pa;
+
+#ifdef CONFIG_RELOCATABLE
+	kernel_map.virt_addr = (uintptr_t)_start;
+	kernel_map.phys_addr = (uintptr_t)_start;
+	relocate_kernel();
+#endif
 }
 
 static inline void setup_vm_final(void)
-- 
2.45.1


