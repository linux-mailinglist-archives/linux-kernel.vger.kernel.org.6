Return-Path: <linux-kernel+bounces-233694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA28791BB9E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A7DB20DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85A154430;
	Fri, 28 Jun 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="d2L44P31"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DFD152E03
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567485; cv=none; b=HAVh/nQjXM5YgCeruGS0HbQQBgGryuvYBJ1Aa9Hhtkb80Wm+xxynHbCk1JxkptrTeudlYPxykbWa+uZw2+DZVZlPbdoaBPR4I2XHYbKu9sb2SdEG/YfsujBptCCBVI0/pWcmqguLVKJsT5BFk3p4mJ1MpTERxuT9vZXNPqFbBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567485; c=relaxed/simple;
	bh=RGaHQuN++47buW8KIymRZjDsqFPaO4zCn+43OWke22M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uJ6pdGU5qBML9tuYyPTcm33cxHSlgqnvE2ClMVrc2ab1SVUZMZ4Ull5LHTZJItO7HSHhIHFyRmiocHlyWnV2tIhb28HBq1lLTqEqcCgavrJCS7SXW70MrE0pF9s/KdlqNta/b3UCcP9fFScS0+oh2t8q5Jxqz2JGMPcnsm8lHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=d2L44P31; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f480624d0fso2330965ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719567483; x=1720172283; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NJSNW/3/ZU4aZIGnKXL/hakX6fiWOuxkIF7mSD4tC0M=;
        b=d2L44P31oBHyaNsVqyqMzO7VgEgsj8+uUUYZugHOuhKPljav3vsMHJ/1fzh+BfYo4R
         CRmx0EmyYuoG0hx29tLVaOZXTtn58QscMDAsr7N834QcZlYR0R/0+jIdCgFHrEDOAJ8c
         G4tB1TDFHCPeUJLRcWHx6a1tuUjen0/UFrlShQqBoNgLcS8SpWgaub4NnBsNMTQltU26
         W9GgeJ8k9eSlPTIAwm8Mp+j9q4A+PXlG3I4zyOI3YtSiMSZgGyB9QrWcZeFT/T2Gs5d/
         Ltkuv6g6NnTB6+vPP/yIPl7x5vFGWVzE2XU40R+KupGwkXlacfDHAlsjpzK2+MleqoYh
         Qo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567483; x=1720172283;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJSNW/3/ZU4aZIGnKXL/hakX6fiWOuxkIF7mSD4tC0M=;
        b=S7sb7CjEbEYL1d5XTNaQfIDyYLMBWPOEAEZ0wt625+63+FJLxng0ZWq6y8Br4gytKA
         RRjhkkrg8ZilTATmSvEFtLr+uuGbXOKGhRnashZ/kS8D9cXy05+xSfcDL5RuRkaswXXz
         NA+bRRFnHSTORCBKEVcWXPLvYNJJsWhAkWGP3KXtFlgfn0vpXt8eO7+phxn6l4cxBNOD
         y9zA1Fp/MLepCvMMgjc8DTAzLJBLF29i1HaExb6eNa7LhO5NdlF2/azEl9CmNi17K8+X
         k6IT6lVaavNAxXjGyoSpKrXhVjzt6rx0lynE6xw0xDIbBoupmRBcNh7KA6DVo69VWb6V
         eQoQ==
X-Gm-Message-State: AOJu0YyAZygnFYSLAdwnJmUENk1kQr5LrKvG8QGn8Q433yigJcJtI/nL
	gnuNjZrNruo9o8r7fACzX9sX9f7qGsx9PB12I68XEvMTIu71GfylZGcRR5jrzDyqkTVLzPM42+r
	7iBn8RSp/bmiAkQQEO4SyXywupLS9HAhNRHu/G74rm5rXRqSy/8EPPH1U1BPl+V8nYjT6XNGUUD
	xxRLPqnXOKtHX1xz662C4HILvjUXqfjbSnBC0kbOCgrpTXvHpHVPw=
X-Google-Smtp-Source: AGHT+IGAWW4LhafPCB24jR3qgs3piip9ebKtNw6QzOeSExEsUeoGzvS4p5SzrS10lenqlKRQUIiBEA==
X-Received: by 2002:a17:902:ec86:b0:1fa:aa62:8b5c with SMTP id d9443c01a7336-1faaa628da2mr41373805ad.29.1719567482385;
        Fri, 28 Jun 2024 02:38:02 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c6c8dsm11087155ad.26.2024.06.28.02.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:38:02 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Jinyu Tang <tjytimi@163.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Peter Xu <peterx@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v6 1/4] RISC-V: Add Svade and Svadu Extensions Support
Date: Fri, 28 Jun 2024 17:37:05 +0800
Message-Id: <20240628093711.11716-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240628093711.11716-1-yongxuan.wang@sifive.com>
References: <20240628093711.11716-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Svade and Svadu extensions represent two schemes for managing the PTE A/D
bits. When the PTE A/D bits need to be set, Svade extension intdicates
that a related page fault will be raised. In contrast, the Svadu extension
supports hardware updating of PTE A/D bits. Since the Svade extension is
mandatory and the Svadu extension is optional in RVA23 profile, by default
the M-mode firmware will enable the Svadu extension in the menvcfg CSR
when only Svadu is present in DT.

This patch detects Svade and Svadu extensions from DT and adds
arch_has_hw_pte_young() to enable optimization in MGLRU and
__wp_page_copy_user() when we have the PTE A/D bits hardware updating
support.

Co-developed-by: Jinyu Tang <tjytimi@163.com>
Signed-off-by: Jinyu Tang <tjytimi@163.com>
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/csr.h     |  1 +
 arch/riscv/include/asm/hwcap.h   |  2 ++
 arch/riscv/include/asm/pgtable.h | 13 ++++++++++++-
 arch/riscv/kernel/cpufeature.c   | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0525ee2d63c7..3d705e28ff85 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -36,6 +36,7 @@ config RISCV
 	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 25966995da04..524cd4131c71 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -195,6 +195,7 @@
 /* xENVCFG flags */
 #define ENVCFG_STCE			(_AC(1, ULL) << 63)
 #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
+#define ENVCFG_ADUE			(_AC(1, ULL) << 61)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
 #define ENVCFG_CBIE_SHIFT		4
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e17d0078a651..35d7aa49785d 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,8 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 #define RISCV_ISA_EXT_XANDESPMU		74
+#define RISCV_ISA_EXT_SVADE             75
+#define RISCV_ISA_EXT_SVADU		76
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index aad8b8ca51f1..ec0cdacd7da0 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -120,6 +120,7 @@
 #include <asm/tlbflush.h>
 #include <linux/mm_types.h>
 #include <asm/compat.h>
+#include <asm/cpufeature.h>
 
 #define __page_val_to_pfn(_val)  (((_val) & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT)
 
@@ -288,7 +289,6 @@ static inline pte_t pud_pte(pud_t pud)
 }
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-#include <asm/cpufeature.h>
 
 static __always_inline bool has_svnapot(void)
 {
@@ -624,6 +624,17 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
+/*
+ * Both Svade and Svadu control the hardware behavior when the PTE A/D bits need to be set. By
+ * default the M-mode firmware enables the hardware updating scheme when only Svadu is present in
+ * DT.
+ */
+#define arch_has_hw_pte_young arch_has_hw_pte_young
+static inline bool arch_has_hw_pte_young(void)
+{
+	return riscv_has_extension_unlikely(RISCV_ISA_EXT_SVADU);
+}
+
 /*
  * THP functions
  */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 5ef48cb20ee1..d31f79bc4daf 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -301,6 +301,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
+	__RISCV_ISA_EXT_DATA(svade, RISCV_ISA_EXT_SVADE),
+	__RISCV_ISA_EXT_DATA(svadu, RISCV_ISA_EXT_SVADU),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
@@ -554,6 +556,21 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
 		}
 
+		/*
+		 * When neither Svade nor Svadu present in DT, it is technically
+		 * unknown whether the platform uses Svade or Svadu. Supervisor may
+		 * assume Svade to be present and enabled or it can discover based
+		 * on mvendorid, marchid, and mimpid. When both Svade and Svadu present
+		 * in DT, supervisor must assume Svadu turned-off at boot time. To use
+		 * Svadu, supervisor must explicitly enable it using the SBI FWFT extension.
+		 */
+		if (!test_bit(RISCV_ISA_EXT_SVADE, isainfo->isa) &&
+		    !test_bit(RISCV_ISA_EXT_SVADU, isainfo->isa))
+			set_bit(RISCV_ISA_EXT_SVADE, isainfo->isa);
+		else if (test_bit(RISCV_ISA_EXT_SVADE, isainfo->isa) &&
+			   test_bit(RISCV_ISA_EXT_SVADU, isainfo->isa))
+			clear_bit(RISCV_ISA_EXT_SVADU, isainfo->isa);
+
 		/*
 		 * All "okay" hart should have same isa. Set HWCAP based on
 		 * common capabilities of every "okay" hart, in case they don't
@@ -619,6 +636,21 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 
 		of_node_put(cpu_node);
 
+		/*
+		 * When neither Svade nor Svadu present in DT, it is technically
+		 * unknown whether the platform uses Svade or Svadu. Supervisor may
+		 * assume Svade to be present and enabled or it can discover based
+		 * on mvendorid, marchid, and mimpid. When both Svade and Svadu present
+		 * in DT, supervisor must assume Svadu turned-off at boot time. To use
+		 * Svadu, supervisor must explicitly enable it using the SBI FWFT extension.
+		 */
+		if (!test_bit(RISCV_ISA_EXT_SVADE, isainfo->isa) &&
+		    !test_bit(RISCV_ISA_EXT_SVADU, isainfo->isa))
+			set_bit(RISCV_ISA_EXT_SVADE, isainfo->isa);
+		else if (test_bit(RISCV_ISA_EXT_SVADE, isainfo->isa) &&
+			   test_bit(RISCV_ISA_EXT_SVADU, isainfo->isa))
+			clear_bit(RISCV_ISA_EXT_SVADU, isainfo->isa);
+
 		/*
 		 * All "okay" harts should have same isa. Set HWCAP based on
 		 * common capabilities of every "okay" hart, in case they don't.
-- 
2.17.1


