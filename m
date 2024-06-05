Return-Path: <linux-kernel+bounces-202568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A8D8FCE1A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6FC1F29199
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBF71B14F2;
	Wed,  5 Jun 2024 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UDhwyHgP"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E22A1B1436
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589743; cv=none; b=gUrVve+rd70EZfbqAmo63GHcGN7MTmHup7XCgK0cFBxh6Sg2r7Xq70v0n0KLBT/+c+QPcRr3nKu7AI83CmD7Qzp11W5w0r2h+nSJM4w/SUqgdPVIwUWPrWb/Dk+YVTq36ILPEu3aafliLqlIwcIcjDcd3KTEAxJyIo9Zr59cAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589743; c=relaxed/simple;
	bh=hTmtsdXYiGBOLJKJx4/m17z57Knu5252Lz/eRo2JFWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tVaScMzJzYCdbxTHMZhlJ3xHFGeO9AksEeM6Wjw1WLMJHdsLP7KRSrmX+GekxScIgW0rzlJO213sx6xjnRaJJaBtax+7yQc/DC5LUxYAY1NB3JSt3E07FXrLRrahSg09J90A9mNlCX/3J2f0z4J0pfaHQK51oSP3dGS+ruFFOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UDhwyHgP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-702342c60dfso1609516b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717589740; x=1718194540; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M6DDIEotd8EWgMMcCZznOzCPmVBacRxZ1YaVEsFTRqc=;
        b=UDhwyHgPpWAaVxQKTTVkYKghXtatBoosfgNf5Qj1AeEyBbAD8kumMCFCZAQay4BDx9
         7KG9uioFFCmQ7n/dPaKE0M8H9u6ewES6wyge6sJQCIZHq6ZkEF23AulF+9h6webjFuQ3
         neJHZU0fYs9ybdF77bhXaqBbsbtQBOdIKv/hlc402Cxcwt4+ZmtxFIObarHRox8bCNu0
         20qLcLKiIjyLRxg8A9OUr19IRMdzbZGfmpxlCtmC5LpvUed290N1Vw4WIQxTMdFy/fVj
         vMB076wOOTurfbHJDRv1nVcqzCGXuWWGOfLNRQ77bHy3aKzjEY39CAbMViIdOh4f5c07
         a1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717589740; x=1718194540;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6DDIEotd8EWgMMcCZznOzCPmVBacRxZ1YaVEsFTRqc=;
        b=uNqAjLO6CISb1GeYKTiRKqY4b8aRDm4w3PZ6MAEqesK5hYO19qL+6tPMvcHbYIZ6ZS
         3K6SFVpMN0VqhEwxAmejqJWgF9pc6G1FIhrLF9G4/uM5npUaP93I7as00swVWlKzdAdN
         icDYxbGzC2K2cVDgVDiqsWtrkyRsTiuKgkqU5HPg0GJmmpEWnhb0XDdneBRxXqswoOgz
         GTPdOiYACBv8q0toJoe2ldPflBYtD4XEDbHwW5lJmZkH3hFaWtJNJZwGNppfoAgCx+C9
         YNbH6d/PNF23w2A31IP+wCBjyJSwB7QpxLSxQyokevEufV9rMmc81XYBW0hDb9ZfJGAV
         J9vg==
X-Gm-Message-State: AOJu0Yyo4xkrTW8I8fHgJ5W67JIq1cDKCPfsXus8cbFYVBa47zmGT9qY
	qYs3heYpwSlj3Pil7SZ4WglkC3EJXkqe4h/H/qqD2jmwffaYm2Fj3LRhfctTGeeiI/OlJfNzgSG
	WpKOaq4qkigwAi5f2//uNxhvGIZ+890WReL37w+BI2/1DMhcCegp2aIWVsAHNbzwPDp4LodIEbr
	Q9sGLWWQRRyGZfbh6SBNmTcWB29RRcRGY8jTfCkJul4ZpLnZdGnfDVZg==
X-Google-Smtp-Source: AGHT+IH3nqH0HygTrtx132GmRiIh9ksqvzFGs1AgXrG45C29IYpnZlxfse4GWma8yLnINlc5RX1TYA==
X-Received: by 2002:a05:6a00:b4b:b0:703:ee76:6e5a with SMTP id d2e1a72fcca58-703ee7670c1mr1282317b3a.0.1717589739980;
        Wed, 05 Jun 2024 05:15:39 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703ee672fb3sm885379b3a.216.2024.06.05.05.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:15:39 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: apatel@ventanamicro.com,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Jinyu Tang <tjytimi@163.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	wchen <waylingii@gmail.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v5 1/4] RISC-V: Add Svade and Svadu Extensions Support
Date: Wed,  5 Jun 2024 20:15:07 +0800
Message-Id: <20240605121512.32083-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605121512.32083-1-yongxuan.wang@sifive.com>
References: <20240605121512.32083-1-yongxuan.wang@sifive.com>
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
---
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/csr.h     |  1 +
 arch/riscv/include/asm/hwcap.h   |  2 ++
 arch/riscv/include/asm/pgtable.h | 14 +++++++++++++-
 arch/riscv/kernel/cpufeature.c   |  2 ++
 5 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b94176e25be1..dbfe2be99bf9 100644
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
index aad8b8ca51f1..7287ea4a6160 100644
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
@@ -624,6 +624,18 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
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
+	return riscv_has_extension_unlikely(RISCV_ISA_EXT_SVADU) &&
+	       !riscv_has_extension_likely(RISCV_ISA_EXT_SVADE);
+}
+
 /*
  * THP functions
  */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 5ef48cb20ee1..58565798cea0 100644
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
-- 
2.17.1


