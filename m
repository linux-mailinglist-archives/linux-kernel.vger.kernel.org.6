Return-Path: <linux-kernel+bounces-173747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CE48C04D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D84287DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938A8130A53;
	Wed,  8 May 2024 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="I1lNjoCD"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64543130A43
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196038; cv=none; b=oqjx8G/7WHrmE1S2qmWOhawnqzB6PCrXDcd/L1Gna78HcspNQix9+gADxvjm1BMNn5Iylv2gAiR+JlZcyU/JhodWlR5S5HRJ+G/Rwnz1ta8k/jZoUwDWlzKHEGZov7Un1Iu3cKmMjUFWad4wh8Y5EmD264ZI1ICxnJbMgq+u4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196038; c=relaxed/simple;
	bh=FoZejGjVu6xSGrwnf33XbNrHlqZcyAhpfO4l41aIQlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vBK1m97A84URVQuhDknRAhq545adSzVcc2wJ3o1KTDsb+V1IEE1W4cnv9/IKUhKXpHOBENrnAh6bfjeUkwKlKXfsQVPxX38m2uzcZDqh+wKczPaFbpxdYVk6jiRLStlQkfAfftMjvPWY4ZqnFe+t+xo4ZnQRJcw3QAjy+3ilxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=I1lNjoCD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a599eedc8eeso24302666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715196035; x=1715800835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=datyv3e5LLeWOM64wvZ1mfI1WId3P2rVazcirFn2Oxk=;
        b=I1lNjoCD72gBUVObLHs76CJzTPKZc7k5iL1rpuIPV22aJSTdrpDAlX97gZwBGa4qFn
         Cf9GJaIDZrI/DVqjXkVNyIaEgtYHeqid8h7UG8Po2Z8bkM6L38LMYdMVamhrNAU+jjeI
         klvRLaY/sezIdh9yH9iu8WB/chokTJFxOmsxXSjWSfYXr7MKnY8qLZDhBSln2yZ51YWB
         OumeqVwTPnheEG5WiLndO5P9MYe5g+nO1s+4oVx71SXB3WXOrM21yKrtStkpP0rERFPf
         8wXpXlMOvxtZXxdFHPbelpaQEoug4gI9QArE/ve8fOR7Hge6TRdvIPYm6ckJsqq1xdrd
         U7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196035; x=1715800835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=datyv3e5LLeWOM64wvZ1mfI1WId3P2rVazcirFn2Oxk=;
        b=X6I2BwvDlLY/SFUuufIpgabxp6YK1+x0rmFcEcTHdKOhUarVjB+mwd8OiZFiDruyBL
         BxSlr58gx75zP3JWocqAOAvpm/Q7NBwnJrhU7kujojcazrTEJrE35AsX/hB9uGA7nHGG
         mbQVqLKeHvusj0yMgwBnf+F/8tklav+hJMTvldIcXzw5z60fg+QCEBJj5WLniODrOgIs
         S7pySDzkAW6VJISPqr95esOD/xgktCqfg1Gv/sT+iMveDgEbVhRakBTjoOXtIPC332o3
         rIEEYi4/A5wyALfsBPV3pHK8Gb3m/GPcg9qVVEDNml4deyZcLuVrO3GtYtaIREnR2s6w
         VNXw==
X-Forwarded-Encrypted: i=1; AJvYcCXr7G6VOwfl5LXR7gU4FZbIBE9pz09E1wcLG+VbYeMgCe7rJ/9+r1XZC7n46KGXgcZZBA12Hw6n/4+VpI/xxOAAMaPfBbcXKcqyneEX
X-Gm-Message-State: AOJu0YxSfogp4IvIywaTUi95bN4A8TAU9VSS1aibs7mZdcEuZEPmmp3r
	DntM7C6RF/nmNPxFL/zFnpJGIlL83qG3QqjtUqPJfs8mbQLw38UL+TGR9p9UCnc=
X-Google-Smtp-Source: AGHT+IFPtUz+3X9HHx3rOZWYiSnLgxFfxDjotG1sGB7J9SeveUOh2JXAABXt+ni1vfq6RI0lDXdHfA==
X-Received: by 2002:a50:ab59:0:b0:570:3b8:a990 with SMTP id 4fb4d7f45d1cf-5731da6977emr2508293a12.39.1715196034646;
        Wed, 08 May 2024 12:20:34 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id g17-20020a056402091100b00571bbaa1c45sm7881992edz.1.2024.05.08.12.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:20:34 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ard Biesheuvel <ardb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 01/12] mm, arm64: Rename ARM64_CONTPTE to THP_CONTPTE
Date: Wed,  8 May 2024 21:19:20 +0200
Message-Id: <20240508191931.46060-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508191931.46060-1-alexghiti@rivosinc.com>
References: <20240508191931.46060-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARM64_CONTPTE config represents the capability to transparently use
contpte mappings for THP userspace mappings, which will be implemented
in the next commits for riscv, so make this config more generic and move
it to mm.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/Kconfig               | 9 ---------
 arch/arm64/include/asm/pgtable.h | 6 +++---
 arch/arm64/mm/Makefile           | 2 +-
 mm/Kconfig                       | 9 +++++++++
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ac2f6d906cc3..9d823015b4e5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2227,15 +2227,6 @@ config UNWIND_PATCH_PAC_INTO_SCS
 	select UNWIND_TABLES
 	select DYNAMIC_SCS
 
-config ARM64_CONTPTE
-	bool "Contiguous PTE mappings for user memory" if EXPERT
-	depends on TRANSPARENT_HUGEPAGE
-	default y
-	help
-	  When enabled, user mappings are configured using the PTE contiguous
-	  bit, for any mappings that meet the size and alignment requirements.
-	  This reduces TLB pressure and improves performance.
-
 endmenu # "Kernel Features"
 
 menu "Boot options"
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7c2938cb70b9..1758ce71fae9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1369,7 +1369,7 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
 				    unsigned long addr, pte_t *ptep,
 				    pte_t old_pte, pte_t new_pte);
 
-#ifdef CONFIG_ARM64_CONTPTE
+#ifdef CONFIG_THP_CONTPTE
 
 /*
  * The contpte APIs are used to transparently manage the contiguous bit in ptes
@@ -1622,7 +1622,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
 }
 
-#else /* CONFIG_ARM64_CONTPTE */
+#else /* CONFIG_THP_CONTPTE */
 
 #define ptep_get				__ptep_get
 #define set_pte					__set_pte
@@ -1642,7 +1642,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags			__ptep_set_access_flags
 
-#endif /* CONFIG_ARM64_CONTPTE */
+#endif /* CONFIG_THP_CONTPTE */
 
 int find_num_contig(struct mm_struct *mm, unsigned long addr,
 		    pte_t *ptep, size_t *pgsize);
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 60454256945b..52a1b2082627 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -3,7 +3,7 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   cache.o copypage.o flush.o \
 				   ioremap.o mmap.o pgd.o mmu.o \
 				   context.o proc.o pageattr.o fixmap.o
-obj-$(CONFIG_ARM64_CONTPTE)	+= contpte.o
+obj-$(CONFIG_THP_CONTPTE)	+= contpte.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE)	+= ptdump.o
 obj-$(CONFIG_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
diff --git a/mm/Kconfig b/mm/Kconfig
index c325003d6552..fd4de221a1c6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -984,6 +984,15 @@ config ARCH_HAS_CACHE_LINE_SIZE
 config ARCH_HAS_CONTPTE
 	bool
 
+config THP_CONTPTE
+	bool "Contiguous PTE mappings for user memory" if EXPERT
+	depends on ARCH_HAS_CONTPTE && TRANSPARENT_HUGEPAGE
+	default y
+	help
+	  When enabled, user mappings are configured using the PTE contiguous
+	  bit, for any mappings that meet the size and alignment requirements.
+	  This reduces TLB pressure and improves performance.
+
 config ARCH_HAS_CURRENT_STACK_POINTER
 	bool
 	help
-- 
2.39.2


