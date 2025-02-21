Return-Path: <linux-kernel+bounces-524984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7561A3E974
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0225C702566
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060C81D516C;
	Fri, 21 Feb 2025 00:54:16 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C76433DE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099255; cv=none; b=Q4bf3118xDRCylgyghF1jB3ECQBCXpdA0pXDr4IYWMEG8iWKk9iMQm8/mGoWjf3PvmzrOfNqi9Xtrh+g3FTrlmry9EQzUy+GS3EbfCCXN35XUAE3uXYR+0tftscvlIcz0X8GVlaqwgaLvk0RJyJHcDNO7LURiAQKxIQhyvHJ5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099255; c=relaxed/simple;
	bh=/ismHT2L4b9+0bR74H/fJWOiKvPlSNrqsu4FtBvE2dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHhTrMeWdTW4Xc5c1PFW/LsWuNngJ8gXGKF77YNvbCvPkgGM0Rx03sYpCxVuqwsj3I/pfKjOB9vkpHGam8gLnVnc+n88BjwVf9yiaHilNP1fcAb1Iy1XcFCWhIykHmPnlua0oyjKb4F2w8Vm1VhEnJwKGhud6lXvsgKLhyizu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tlHIZ-000000003Qf-0zou;
	Thu, 20 Feb 2025 19:53:47 -0500
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
	Manali.Shukla@amd.com,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v12 05/16] x86/mm: add INVLPGB support code
Date: Thu, 20 Feb 2025 19:53:04 -0500
Message-ID: <20250221005345.2156760-6-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221005345.2156760-1-riel@surriel.com>
References: <20250221005345.2156760-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Add invlpgb.h with the helper functions and definitions needed to use
broadcast TLB invalidation on AMD EPYC 3 and newer CPUs.

All the functions defined in invlpgb.h are used later in the series.

Compile time disabling X86_FEATURE_INVLPGB when the config
option is not set allows the compiler to omit unnecessary code.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
---
 arch/x86/include/asm/disabled-features.h |  9 ++-
 arch/x86/include/asm/tlb.h               | 92 ++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c492bdc97b05..95997caf0935 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -129,6 +129,13 @@
 #define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
 #endif
 
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+#define DISABLE_INVLPGB		0
+#else
+/* Keep 32 bit kernels smaller by compiling out the INVLPGB code. */
+#define DISABLE_INVLPGB		(1 << (X86_FEATURE_INVLPGB & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -146,7 +153,7 @@
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
 #define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
-#define DISABLED_MASK13	0
+#define DISABLED_MASK13	(DISABLE_INVLPGB)
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 77f52bc1578a..b3cd521e5e2f 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -6,6 +6,9 @@
 static inline void tlb_flush(struct mmu_gather *tlb);
 
 #include <asm-generic/tlb.h>
+#include <linux/kernel.h>
+#include <vdso/bits.h>
+#include <vdso/page.h>
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
@@ -25,4 +28,93 @@ static inline void invlpg(unsigned long addr)
 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
 }
 
+
+/*
+ * INVLPGB does broadcast TLB invalidation across all the CPUs in the system.
+ *
+ * The INVLPGB instruction is weakly ordered, and a batch of invalidations can
+ * be done in a parallel fashion.
+ *
+ * The instruction takes the number of extra pages to invalidate, beyond
+ * the first page, while __invlpgb gets the more human readable number of
+ * pages to invalidate.
+ *
+ * TLBSYNC is used to ensure that pending INVLPGB invalidations initiated from
+ * this CPU have completed.
+ */
+static inline void __invlpgb(unsigned long asid, unsigned long pcid,
+			     unsigned long addr, u16 nr_pages,
+			     bool pmd_stride, u8 flags)
+{
+	u32 edx = (pcid << 16) | asid;
+	u32 ecx = (pmd_stride << 31) | (nr_pages - 1);
+	u64 rax = addr | flags;
+
+	/* The low bits in rax are for flags. Verify addr is clean. */
+	VM_WARN_ON_ONCE(addr & ~PAGE_MASK);
+
+	/* INVLPGB; supported in binutils >= 2.36. */
+	asm volatile(".byte 0x0f, 0x01, 0xfe" : : "a" (rax), "c" (ecx), "d" (edx));
+}
+
+/* Wait for INVLPGB originated by this CPU to complete. */
+static inline void __tlbsync(void)
+{
+	cant_migrate();
+	/* TLBSYNC: supported in binutils >= 0.36. */
+	asm volatile(".byte 0x0f, 0x01, 0xff" ::: "memory");
+}
+
+/*
+ * INVLPGB can be targeted by virtual address, PCID, ASID, or any combination
+ * of the three. For example:
+ * - INVLPGB_VA | INVLPGB_INCLUDE_GLOBAL: invalidate all TLB entries at the address
+ * - INVLPGB_PCID:			  invalidate all TLB entries matching the PCID
+ *
+ * The first can be used to invalidate (kernel) mappings at a particular
+ * address across all processes.
+ *
+ * The latter invalidates all TLB entries matching a PCID.
+ */
+#define INVLPGB_VA			BIT(0)
+#define INVLPGB_PCID			BIT(1)
+#define INVLPGB_ASID			BIT(2)
+#define INVLPGB_INCLUDE_GLOBAL		BIT(3)
+#define INVLPGB_FINAL_ONLY		BIT(4)
+#define INVLPGB_INCLUDE_NESTED		BIT(5)
+
+static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
+						unsigned long addr,
+						u16 nr,
+						bool pmd_stride)
+{
+	__invlpgb(0, pcid, addr, nr, pmd_stride, INVLPGB_PCID | INVLPGB_VA);
+}
+
+/* Flush all mappings for a given PCID, not including globals. */
+static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
+{
+	__invlpgb(0, pcid, 0, 1, 0, INVLPGB_PCID);
+}
+
+/* Flush all mappings, including globals, for all PCIDs. */
+static inline void invlpgb_flush_all(void)
+{
+	__invlpgb(0, 0, 0, 1, 0, INVLPGB_INCLUDE_GLOBAL);
+	__tlbsync();
+}
+
+/* Flush addr, including globals, for all PCIDs. */
+static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
+{
+	__invlpgb(0, 0, addr, nr, 0, INVLPGB_INCLUDE_GLOBAL);
+}
+
+/* Flush all mappings for all PCIDs except globals. */
+static inline void invlpgb_flush_all_nonglobals(void)
+{
+	__invlpgb(0, 0, 0, 1, 0, 0);
+	__tlbsync();
+}
+
 #endif /* _ASM_X86_TLB_H */
-- 
2.47.1


