Return-Path: <linux-kernel+bounces-393061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A34799B9B77
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D7A1F21AFA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC528154420;
	Sat,  2 Nov 2024 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LY+nrttq"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9019514AD38
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506138; cv=none; b=XnPPtWZqNYD+TnsuLr9ei2XHa4mwlOu/CB1V+jEuzqDsiM/GB2KpSBm0tfyqxEPiQSpgBgrffPc44TC7soaRPCDqMB/yJNSvUZ02FzPGjtRiHjvB0r2eVTLzC9wk0/Jk0DgPthezow7xtkRtSkQivrEMveeXLVcMzUfiksXpn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506138; c=relaxed/simple;
	bh=c4ThxXm5UPNxftXzSeVWKLnnforRQ5amA54R7PZLYbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4yz7nT+YVQuKPUJmJG8rsDDJj4dbSPGtLbP6ghUOyP+TCvNVw2LxsH9Lo9JFg1Ze0QDDybjEQj/PRpDui1MRiZ8U73E3hqrsTXUWXDmsKua307aLKWs6ru5Qg/Kqu1qxLhE8hX3+S60Qk09m0zlPVOgfc3F9uXmGgzLBj1iBwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LY+nrttq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b5affde14so20205255ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730506136; x=1731110936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLWTqwFTklP5kOAS4tWrZE7o6PRbxvUdE0W7VG/oyEc=;
        b=LY+nrttqJQaL5xcpDkALghvhqWp6083mEfhHs2MGk1TJoPYE+7wj3OQJnIvZw+NU/u
         NnbB6AXGB+qz+W2k/SJqoc5o6akAph7f504lmiFLH2d28pI4kTD32kAmPeJ9bz8qWtso
         kCsdaC50vKKgdTI8I9b8AkO3RyuOWNsQcEN7W9Cnt7sflGu2uOVLZd35oKRaNeXkPdj1
         mnIA+aYmNx/UR2rgKFmc00aYRL1f/9Is8W/mRYF5UKpW4NYsSfS6WrU2lM4oz6I6FFXd
         4/5Usvuh2+uC/dJttZVfr2TvOTrmnUGgv1zd4KYaEiUNZXSa6+Sbti+ZMxS+lWMYTZ2t
         yXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506136; x=1731110936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLWTqwFTklP5kOAS4tWrZE7o6PRbxvUdE0W7VG/oyEc=;
        b=WNTIumkBeSQpyebJqtCZYozzDWJpzCodEC6KXFI8VGkqicaE1b7MFzvjX9XfxAhs0A
         pXquieP6bul3iqMDMue5VlXAkZoMP+/4AGJHjR771Gm2NXNxMbxiaEiFB6EjUqWtchNP
         E+oyCDp+jf2rvcWmCXTFKXWN8XCDu++NIFiO8cvzr6vNYoFrTL7CvjC4VPWs9Y6vL+DZ
         fnizuei2DT+RwZx64geGEVMUJlvmOBlA6DNGJOSzlUbx0UaVuQGExhI91zvWzAg1MNqZ
         Yoj5TUzBWzRfNBS4FVQwYdiGXEwT64bkNx/8i2qeH+9pVVvv/jpSo+hfkDnr1F1hEqJz
         gbPA==
X-Forwarded-Encrypted: i=1; AJvYcCVT78AaKjgB+IbXONO67fS0tiZlhtQiqyV2ynExbdD/TaYUHS45QAvTQ8Smq9NZvtY+PNjAS5T2cyuN/y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+n7kqy3oseDfWNFAjCr8jH2yuPrvbkbw7I0zokHuKg5RI/tM7
	j75apeQ6GK4ESS64gCmgLuEFkLQ/2N1Xagu2fr7AUOH65g7U3Z5Ju1L7y77PVkI=
X-Google-Smtp-Source: AGHT+IFrBzJx8mZGS+kpSXYQaBncFZYtUSdQlG/06GLokAQ9rvGT8eZfFNaYR53VSzsL3JuFc3E7IQ==
X-Received: by 2002:a17:902:ecc3:b0:20c:f292:3a21 with SMTP id d9443c01a7336-210c6892a36mr346018705ad.15.1730506135958;
        Fri, 01 Nov 2024 17:08:55 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fc00856sm5505749a91.54.2024.11.01.17.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:08:55 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 07/11] riscv: mm: Expose all page table bits to assembly code
Date: Fri,  1 Nov 2024 17:08:01 -0700
Message-ID: <20241102000843.1301099-8-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241102000843.1301099-1-samuel.holland@sifive.com>
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pgtable-32.h and pgtable-64.h are not usable by assembly code, so move
all page table field definitions to pgtable-bits.h.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/pgtable-32.h   | 11 -------
 arch/riscv/include/asm/pgtable-64.h   | 30 -------------------
 arch/riscv/include/asm/pgtable-bits.h | 42 +++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index b422a15fb464..ba50b65b434b 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -17,17 +17,6 @@
 
 #define MAX_POSSIBLE_PHYSMEM_BITS 34
 
-/*
- * rv32 PTE format:
- * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
- *       PFN      reserved for SW   D   A   G   U   X   W   R   V
- */
-#define _PAGE_PFN_MASK  GENMASK(31, 10)
-
-#define _PAGE_NOCACHE		0
-#define _PAGE_IO		0
-#define _PAGE_MTMASK		0
-
 #define ALT_FIXUP_MT(_val)
 #define ALT_UNFIX_MT(_val)
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 4e8a32f035d7..174b6a5837c2 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -68,20 +68,6 @@ typedef struct {
 #define __pmd(x)        ((pmd_t) { (x) })
 #define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
 
-/*
- * rv64 PTE format:
- * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
- *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
- */
-#define _PAGE_PFN_MASK  GENMASK(53, 10)
-
-/*
- * [63] Svnapot definitions:
- * 0 Svnapot disabled
- * 1 Svnapot enabled
- */
-#define _PAGE_NAPOT_SHIFT	63
-#define _PAGE_NAPOT		BIT(_PAGE_NAPOT_SHIFT)
 /*
  * Only 64KB (order 4) napot ptes supported.
  */
@@ -111,18 +97,6 @@ enum napot_cont_order {
 
 #ifdef CONFIG_RISCV_ISA_SVPBMT
 
-/*
- * [62:61] Svpbmt Memory Type definitions:
- *
- *  00 - PMA    Normal Cacheable, No change to implied PMA memory type
- *  01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
- *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
- *  11 - Rsvd   Reserved for future standard use
- */
-#define _PAGE_NOCACHE		(1UL << 61)
-#define _PAGE_IO		(2UL << 61)
-#define _PAGE_MTMASK		(3UL << 61)
-
 /*
  * [63:59] T-Head Memory Type definitions:
  * bit[63] SO - Strong Order
@@ -182,10 +156,6 @@ enum napot_cont_order {
 
 #else
 
-#define _PAGE_NOCACHE		0
-#define _PAGE_IO		0
-#define _PAGE_MTMASK		0
-
 #define ALT_FIXUP_MT(_val)
 #define ALT_UNFIX_MT(_val)
 
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index a8f5205cea54..96710d4c1817 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -6,6 +6,16 @@
 #ifndef _ASM_RISCV_PGTABLE_BITS_H
 #define _ASM_RISCV_PGTABLE_BITS_H
 
+/*
+ * rv32 PTE format:
+ * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
+ *       PFN      reserved for SW   D   A   G   U   X   W   R   V
+ *
+ * rv64 PTE format:
+ * | 63 | 62 61 | 60 54 | 53 10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
+ *   N      MT     RSV     PFN    reserved for SW   D   A   G   U   X   W   R   V
+ */
+
 #define _PAGE_ACCESSED_OFFSET 6
 
 #define _PAGE_PRESENT   (1 << 0)
@@ -22,6 +32,36 @@
 #define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
 #define _PAGE_TABLE     _PAGE_PRESENT
 
+#define _PAGE_PFN_SHIFT		10
+#ifdef CONFIG_64BIT
+#define _PAGE_PFN_MASK		GENMASK(53, 10)
+#else
+#define _PAGE_PFN_MASK		GENMASK(31, 10)
+#endif /* CONFIG_64BIT */
+
+#ifdef CONFIG_RISCV_ISA_SVPBMT
+/*
+ * [62:61] Svpbmt Memory Type definitions:
+ *
+ *  00 - PMA    Normal Cacheable, No change to implied PMA memory type
+ *  01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
+ *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
+ *  11 - Rsvd   Reserved for future standard use
+ */
+#define _PAGE_NOCACHE		(UL(1) << 61)
+#define _PAGE_IO		(UL(2) << 61)
+#define _PAGE_MTMASK		(UL(3) << 61)
+#else
+#define _PAGE_NOCACHE		0
+#define _PAGE_IO		0
+#define _PAGE_MTMASK		0
+#endif /* CONFIG_RISCV_ISA_SVPBMT */
+
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+#define _PAGE_NAPOT_SHIFT	63
+#define _PAGE_NAPOT		BIT(_PAGE_NAPOT_SHIFT)
+#endif /* CONFIG_RISCV_ISA_SVNAPOT */
+
 /*
  * _PAGE_PROT_NONE is set on not-present pages (and ignored by the hardware) to
  * distinguish them from swapped out pages
@@ -31,8 +71,6 @@
 /* Used for swap PTEs only. */
 #define _PAGE_SWP_EXCLUSIVE _PAGE_ACCESSED
 
-#define _PAGE_PFN_SHIFT 10
-
 /*
  * when all of R/W/X are zero, the PTE is a pointer to the next level
  * of the page table; otherwise, it is a leaf PTE.
-- 
2.45.1


