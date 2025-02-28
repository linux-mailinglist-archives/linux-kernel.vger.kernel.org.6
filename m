Return-Path: <linux-kernel+bounces-538050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E47CA49404
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9211894880
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F196254843;
	Fri, 28 Feb 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhxKG12g"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE762512C3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732717; cv=none; b=S3ccjmuzzkcMFzBZMCd0tdoD46kGlC91d8Y4/a0hEVLF+S7+YvZEAYf4Cugqbg5CjEcQnADVz6T8hFJwuRvlBHMst7qI01YaLmCaM76UOLHujjZyGeeH0YwsaDTyI5OatmRsyyQqHr6OPG5coi5K6a/Lqw742dLX2gWz1twfk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732717; c=relaxed/simple;
	bh=w1nkcyVPYvi3ysyji3YioOLi0vdTNcSe4/LKECgEAAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NkOQdIFQlT2ECGHmaojcfTkuifo/qy7wPHJG86H81/fTfujW9hYLM8kEIDQgE8HltHNRdUasj/liMyc7y0JvKWkackbweB+i6HntXEUSWxJZ3WkuumJRh0MBU0mnvd3TB2ZnsCA1D2SfpPQB0KJo7bZIKI1RorkZf0K4v9QdAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhxKG12g; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abba1b74586so273575666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740732714; x=1741337514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fEUyB5EmHNCT4puS4PQuhKUh0TILreNeaPohAZsCzXk=;
        b=BhxKG12gPzUjLRW71V5KDhQBEP14P+ZsE21zYNitch+iExPfpFdaKQZjxGWL+oLdTY
         Wt/Q6Mx5R5DG65AbMs7/egEa6cZIBrXDLwKGb4gl5TnQ3Cq+JcT7Zwy/wx02oFqe4uNU
         mfQ9H9gKH+ro1qDINu8JjUYAnU4Lf6oPq3t3xgkL5Dy/Xuwy2EjJN2IdwqRs1VrQ0Avj
         htN7ukU0f3EvDyTmcVHORWb2J2yV8CdtkHtkmVX/bz2nZcPkX+Jr7FGfkmmAXM1OnVYX
         hVh6ALtwptbZnn6QTxvtuEe40enQOADKfkaKhi3WJyb+n/Tn8hXgSvCupAuq/wsYIxPc
         9UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732714; x=1741337514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEUyB5EmHNCT4puS4PQuhKUh0TILreNeaPohAZsCzXk=;
        b=gFaU/HyvvfV1Wzlwk+Wt2A1nNozMLa9mV1O9Jx6RbcGDVRKd0zatRfoL32Ls6U1KwS
         F5Jq254lwyGIkCn7BWNrf42Kf4DLM7TvGoknJiJHLiR/Icn9F5HhhTDmrrGV6dIl4Eki
         qjRBjPef4TViwLFkKR3W+5AzTyCEpqQoJrNP5r1cmHC0OX/xRhnO8ySlMh783f2/FuD6
         Zvgm4SaGem2uMMHLsiXDhtnpz+i2zRoFRTb3flPIcRQ+foNfxguydwXdIk8ZvJuMjuD6
         H1kW8Zzcc1W3ESzI09zPKcWo+JfgLSmHvk6l4HQFSDsvFy14KKAZfE3a7g63m57/1wFf
         ICjA==
X-Forwarded-Encrypted: i=1; AJvYcCUEQjhhysWUDrrp4XvMbgycRbs763KuhpHxa8LePzR6sncm81f9DskW9xNgByapvRfOAsutCzoD05wi/vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE6ZUS9KVYgmm+4tYfLvFO8D+wuUNbJ6c4udNWF6VbzkCVOisz
	4nYWpZDCB9KqeBzRFJj1Jq3JL8Gpm5S1/ZY8d04kmq76HEGMZUeK
X-Gm-Gg: ASbGncvTLImPY9YqSuBLI+dMGhCxMtrf6N4+hI5tv+awib46a9jNzl1eNMFteMke3U/
	WieEf1jNombdZHyMaKdP2A+OZJeBIgGJfE9LRTc5SykWrRfus6NtL981KwlQD1RPbbAaAD+PG14
	O8DZcXZsOvJmQSTZxiugTHzxAdj987OInQcGqporf3bGC20c3eQZdjkKDrnVGq4GMLfjxzXOC+N
	UOjk2f1qfU5n15ksDYlSF/h6os/3pPQavso49vo9rK+JT/35GLBz9dpsrzT5thqeXl0jo+GsTR+
	uVCldCvVSthUPnAaaOcpPsG02UGCF1P27WD0
X-Google-Smtp-Source: AGHT+IHE75BPNmxqkumsfahz4rxW/WI+EewYpDWNQmoLci96OwuaE8twUPv7rhKoapoaVWJclJMkvA==
X-Received: by 2002:a17:907:c29:b0:ab7:f2da:8126 with SMTP id a640c23a62f3a-abf25fa2bb1mr244795666b.11.1740732713983;
        Fri, 28 Feb 2025 00:51:53 -0800 (PST)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dc5d5sm261091666b.63.2025.02.28.00.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:51:53 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH] x86/locking: Remove semicolon from "lock" prefix
Date: Fri, 28 Feb 2025 09:51:15 +0100
Message-ID: <20250228085149.2478245-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minimum version of binutils required to compile the kernel is 2.25.
This version correctly handles the "lock" prefix, so it is possible
to remove the semicolon, which was used to support ancient versions
of GNU as.

Due to the semicolon, the compiler considers "lock; insn" as two
separate instructions. Removing the semicolon makes asm length
calculations more accurate, consequently making scheduling and
inlining decisions of the compiler more accurate.

Removing the semicolon also enables assembler checks involving lock
prefix. Trying to assemble e.g. "lock andl %eax, %ebx" results in:

  Error: expecting lockable instruction after `lock'

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
---
 arch/x86/include/asm/alternative.h |  2 +-
 arch/x86/include/asm/barrier.h     |  8 ++++----
 arch/x86/include/asm/cmpxchg.h     |  4 ++--
 arch/x86/include/asm/cmpxchg_32.h  |  4 ++--
 arch/x86/include/asm/edac.h        |  2 +-
 arch/x86/include/asm/sync_bitops.h | 12 ++++++------
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 853fbcf68719..2b9547dc1f23 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -48,7 +48,7 @@
 		".popsection\n"				\
 		"671:"
 
-#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock; "
+#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock "
 
 #else /* ! CONFIG_SMP */
 #define LOCK_PREFIX_HERE ""
diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 7b44b3c4cce1..db70832232d4 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -12,11 +12,11 @@
  */
 
 #ifdef CONFIG_X86_32
-#define mb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "mfence", \
+#define mb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "mfence", \
 				      X86_FEATURE_XMM2) ::: "memory", "cc")
-#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "lfence", \
+#define rmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "lfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
-#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "sfence", \
+#define wmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "sfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #else
 #define __mb()	asm volatile("mfence":::"memory")
@@ -50,7 +50,7 @@
 #define __dma_rmb()	barrier()
 #define __dma_wmb()	barrier()
 
-#define __smp_mb()	asm volatile("lock; addl $0,-4(%%" _ASM_SP ")" ::: "memory", "cc")
+#define __smp_mb()	asm volatile("lock addl $0,-4(%%" _ASM_SP ")" ::: "memory", "cc")
 
 #define __smp_rmb()	dma_rmb()
 #define __smp_wmb()	barrier()
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index 5612648b0202..fd8afc1f5f6b 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -134,7 +134,7 @@ extern void __add_wrong_size(void)
 	__raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
 
 #define __sync_cmpxchg(ptr, old, new, size)				\
-	__raw_cmpxchg((ptr), (old), (new), (size), "lock; ")
+	__raw_cmpxchg((ptr), (old), (new), (size), "lock ")
 
 #define __cmpxchg_local(ptr, old, new, size)				\
 	__raw_cmpxchg((ptr), (old), (new), (size), "")
@@ -222,7 +222,7 @@ extern void __add_wrong_size(void)
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
 #define __sync_try_cmpxchg(ptr, pold, new, size)			\
-	__raw_try_cmpxchg((ptr), (pold), (new), (size), "lock; ")
+	__raw_try_cmpxchg((ptr), (pold), (new), (size), "lock ")
 
 #define __try_cmpxchg_local(ptr, pold, new, size)			\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), "")
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 95b5f990ca88..8806c646d452 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -105,7 +105,7 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 
 static __always_inline u64 arch_cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
 {
-	return __arch_cmpxchg64_emu(ptr, old, new, LOCK_PREFIX_HERE, "lock; ");
+	return __arch_cmpxchg64_emu(ptr, old, new, LOCK_PREFIX_HERE, "lock ");
 }
 #define arch_cmpxchg64 arch_cmpxchg64
 
@@ -140,7 +140,7 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 
 static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
 {
-	return __arch_try_cmpxchg64_emu(ptr, oldp, new, LOCK_PREFIX_HERE, "lock; ");
+	return __arch_try_cmpxchg64_emu(ptr, oldp, new, LOCK_PREFIX_HERE, "lock ");
 }
 #define arch_try_cmpxchg64 arch_try_cmpxchg64
 
diff --git a/arch/x86/include/asm/edac.h b/arch/x86/include/asm/edac.h
index 426fc53ff803..dfbd1ebb9f10 100644
--- a/arch/x86/include/asm/edac.h
+++ b/arch/x86/include/asm/edac.h
@@ -13,7 +13,7 @@ static inline void edac_atomic_scrub(void *va, u32 size)
 	 * are interrupt, DMA and SMP safe.
 	 */
 	for (i = 0; i < size / 4; i++, virt_addr++)
-		asm volatile("lock; addl $0, %0"::"m" (*virt_addr));
+		asm volatile("lock addl $0, %0"::"m" (*virt_addr));
 }
 
 #endif /* _ASM_X86_EDAC_H */
diff --git a/arch/x86/include/asm/sync_bitops.h b/arch/x86/include/asm/sync_bitops.h
index 6d8d6bc183b7..cd21a0405ac5 100644
--- a/arch/x86/include/asm/sync_bitops.h
+++ b/arch/x86/include/asm/sync_bitops.h
@@ -31,7 +31,7 @@
  */
 static inline void sync_set_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; " __ASM_SIZE(bts) " %1,%0"
+	asm volatile("lock " __ASM_SIZE(bts) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -49,7 +49,7 @@ static inline void sync_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void sync_clear_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; " __ASM_SIZE(btr) " %1,%0"
+	asm volatile("lock " __ASM_SIZE(btr) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -66,7 +66,7 @@ static inline void sync_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void sync_change_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; " __ASM_SIZE(btc) " %1,%0"
+	asm volatile("lock " __ASM_SIZE(btc) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -82,7 +82,7 @@ static inline void sync_change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool sync_test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(bts), *addr, c, "Ir", nr);
+	return GEN_BINARY_RMWcc("lock " __ASM_SIZE(bts), *addr, c, "Ir", nr);
 }
 
 /**
@@ -95,7 +95,7 @@ static inline bool sync_test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline int sync_test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(btr), *addr, c, "Ir", nr);
+	return GEN_BINARY_RMWcc("lock " __ASM_SIZE(btr), *addr, c, "Ir", nr);
 }
 
 /**
@@ -108,7 +108,7 @@ static inline int sync_test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline int sync_test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(btc), *addr, c, "Ir", nr);
+	return GEN_BINARY_RMWcc("lock " __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
 #define sync_test_bit(nr, addr) test_bit(nr, addr)
-- 
2.48.1


