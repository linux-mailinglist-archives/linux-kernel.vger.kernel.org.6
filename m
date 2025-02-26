Return-Path: <linux-kernel+bounces-532894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701F3A4538A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698033A909A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C458F21CC55;
	Wed, 26 Feb 2025 03:01:48 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF594383
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538908; cv=none; b=pJUosFmSJs8dpNtRji3p/DR+5cTMx7UXDwE9fAO7MzPeuSOpffwryeehC8nA7mbuuHS4ecwmuCom8jGku7jEylleSgpRcc82ILoeds92S3tWbNVR8kT9u+2Pt/flDd1497QGtT2BCRL8QoiLgktITs9o1C4qEJ2NFTaHTEf7/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538908; c=relaxed/simple;
	bh=vv2yc3xS3j1KYZ0Dh7ly7vBxVn3c1CiltbqqzFemO+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHXB3pdXQ0jbD7Fko62atUR2N5//dNWbVDp2h0Zp+xF9JKoUQi7I3MkeEa5pyxdZHKmD4OD90JnW2rxw5F0MAhyiW4E+7Syff73lbiaAVwOvJy2qIfgswrIBBJglVAN7pSskwqMSBYPjiIy4KA5485fNsUyiHIvPKW2P+Lf4rTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tn7fw-000000001Y5-0aUg;
	Tue, 25 Feb 2025 22:01:32 -0500
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
	mingo@kernel.org,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v14 03/13] x86/mm: add INVLPGB support code
Date: Tue, 25 Feb 2025 22:00:38 -0500
Message-ID: <20250226030129.530345-4-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226030129.530345-1-riel@surriel.com>
References: <20250226030129.530345-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Add helper functions and definitions needed to use broadcast TLB
invalidation on AMD EPYC 3 and newer CPUs.

All the functions defined in invlpgb.h are used later in the series.

Compile time disabling X86_FEATURE_INVLPGB when the config
option is not set allows the compiler to omit unnecessary code.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
---
 arch/x86/include/asm/disabled-features.h |  8 +-
 arch/x86/include/asm/tlb.h               | 98 ++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c492bdc97b05..625a89259968 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -129,6 +129,12 @@
 #define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
 #endif
 
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+#define DISABLE_INVLPGB		0
+#else
+#define DISABLE_INVLPGB		(1 << (X86_FEATURE_INVLPGB & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -146,7 +152,7 @@
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
 #define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
-#define DISABLED_MASK13	0
+#define DISABLED_MASK13	(DISABLE_INVLPGB)
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 77f52bc1578a..91c9a4da3ace 100644
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
@@ -25,4 +28,99 @@ static inline void invlpg(unsigned long addr)
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
+static inline void __tlbsync(void)
+{
+	/*
+	 * tlbsync waits for invlpgb instructions originating on the
+	 * same CPU to have completed. Print a warning if we could have
+	 * migrated, and might not be waiting on all the invlpgbs issued
+	 * during this TLB invalidation sequence.
+	 */
+	cant_migrate();
+
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


