Return-Path: <linux-kernel+bounces-544310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E60AAA4DFFF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3189318844B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7932B204C2B;
	Tue,  4 Mar 2025 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyCCJ2el"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C731C204C23
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096713; cv=none; b=Dr7VYMonODQuEwdVc1jqoavP6S3M/p0Nsc2VsLM+afKpuPtlCU2B8H2H4RKoFRZnueYMHLobHrLzMRUOMRALBGLCH4zW9vlNcN/OnDQE8WvbyV+bEyrWkYDmxuJlO0pezQ2j+li6MAusaXgZyg0DLIRic4kjT0vosWnb23ZNCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096713; c=relaxed/simple;
	bh=X1huOsN5W4jKLuaRwLL36yDmkKY/JDVc78p3WqGQVBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6gJQNGtuaDas/024fiu2oqOCjvlOy7dwO56tebM1OJWOKVZ/d09t523TOeb3huBkPIfcUrh8FE/tcI6Q17XEmHBrY1nXRXdvYpqvGJUsEDPzsR0YwZkJ/DS2ymKfI5avYPe1P41ER4zPJ1w9d4lRc9/Y/lWM6UsS/kRxVJE0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyCCJ2el; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4164FC4CEE7;
	Tue,  4 Mar 2025 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096713;
	bh=X1huOsN5W4jKLuaRwLL36yDmkKY/JDVc78p3WqGQVBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dyCCJ2el7Tll84ljQirbpN9UXDOr1tBvbVY6JChmK1K/KX8vxcYbzjQMOxB8YaB2g
	 jn400jK3VU/APZOnikrergnf8HR5i6vNVfPZBTW/+1jFlsYjsbsgHj6wDQ8vcD3gH0
	 O9VpzREeaAaqFN8/MCnbe9k9BYbaI1JXYVSS1v+leMLf81F3zO1p2SN374YLDeRSjQ
	 E6SK009MqxA+V8wUDnhUKbt/MtJxM9OzER6wgXmMoPuEITmoIFkZDYYqeTUqcKEcQI
	 7blFfCoHOzK8s3V89XKBFzaEC0NTe9Bjd05+qIorFP1czuA4GDJwToJ29cx/KPdJm0
	 GneKxW3yoWLxw==
From: Borislav Petkov <bp@kernel.org>
To: riel@surriel.com
Cc: Manali.Shukla@amd.com,
	akpm@linux-foundation.org,
	andrew.cooper3@citrix.com,
	jackmanb@google.com,
	jannh@google.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhklinux@outlook.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	x86@kernel.org,
	zhengqi.arch@bytedance.com,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH v15 03/11]  x86/mm: Add INVLPGB support code
Date: Tue,  4 Mar 2025 14:58:08 +0100
Message-ID: <20250304135816.12356-4-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304135816.12356-1-bp@kernel.org>
References: <20250304135816.12356-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

Add helper functions and definitions needed to use broadcast TLB
invalidation on AMD CPUs.

  [ bp:
      - Cleanup commit message
      - Improve and expand comments
      - push the preemption guards inside the invlpgb* helpers
      - merge improvements from dhansen
      - add !CONFIG_BROADCAST_TLB_FLUSH function stubs because Clang
	can't do DCE properly yet and looks at the inline asm and
	complains about it getting a u64 argument on 32-bit code ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-4-riel@surriel.com
---
 arch/x86/include/asm/tlb.h | 126 +++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 77f52bc1578a..8ffcae7beb55 100644
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
@@ -25,4 +28,127 @@ static inline void invlpg(unsigned long addr)
 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
 }
 
+enum addr_stride {
+	PTE_STRIDE = 0,
+	PMD_STRIDE = 1
+};
+
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
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
+ * The bits in rax[0:2] determine respectively which components of the address
+ * (VA, PCID, ASID) get compared when flushing. If neither bits are set, *any*
+ * address in the specified range matches.
+ *
+ * TLBSYNC is used to ensure that pending INVLPGB invalidations initiated from
+ * this CPU have completed.
+ */
+static inline void __invlpgb(unsigned long asid, unsigned long pcid,
+			     unsigned long addr, u16 nr_pages,
+			     enum addr_stride stride, u8 flags)
+{
+	u32 edx = (pcid << 16) | asid;
+	u32 ecx = (stride << 31) | (nr_pages - 1);
+	u64 rax = addr | flags;
+
+	/* The low bits in rax are for flags. Verify addr is clean. */
+	VM_WARN_ON_ONCE(addr & ~PAGE_MASK);
+
+	/* INVLPGB; supported in binutils >= 2.36. */
+	asm volatile(".byte 0x0f, 0x01, 0xfe" :: "a" (rax), "c" (ecx), "d" (edx));
+}
+
+static inline void __tlbsync(void)
+{
+	/*
+	 * TLBSYNC waits for INVLPGB instructions originating on the same CPU
+	 * to have completed. Print a warning if the task has been migrated,
+	 * and might not be waiting on all the INVLPGBs issued during this TLB
+	 * invalidation sequence.
+	 */
+	cant_migrate();
+
+	/* TLBSYNC: supported in binutils >= 0.36. */
+	asm volatile(".byte 0x0f, 0x01, 0xff" ::: "memory");
+}
+#else
+/* Some compilers (I'm looking at you clang!) simply can't do DCE */
+static inline void __invlpgb(unsigned long asid, unsigned long pcid,
+			     unsigned long addr, u16 nr_pages,
+			     enum addr_stride s, u8 flags) { }
+static inline void __tlbsync(void) { }
+#endif
+
+/*
+ * INVLPGB can be targeted by virtual address, PCID, ASID, or any combination
+ * of the three. For example:
+ * - FLAG_VA | FLAG_INCLUDE_GLOBAL: invalidate all TLB entries at the address
+ * - FLAG_PCID:			    invalidate all TLB entries matching the PCID
+ *
+ * The first is used to invalidate (kernel) mappings at a particular
+ * address across all processes.
+ *
+ * The latter invalidates all TLB entries matching a PCID.
+ */
+#define INVLPGB_FLAG_VA			BIT(0)
+#define INVLPGB_FLAG_PCID		BIT(1)
+#define INVLPGB_FLAG_ASID		BIT(2)
+#define INVLPGB_FLAG_INCLUDE_GLOBAL	BIT(3)
+#define INVLPGB_FLAG_FINAL_ONLY		BIT(4)
+#define INVLPGB_FLAG_INCLUDE_NESTED	BIT(5)
+
+/* The implied mode when all bits are clear: */
+#define INVLPGB_MODE_ALL_NONGLOBALS	0UL
+
+static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
+						unsigned long addr,
+						u16 nr, bool stride)
+{
+	enum addr_stride str = stride ? PMD_STRIDE : PTE_STRIDE;
+	u8 flags = INVLPGB_FLAG_PCID | INVLPGB_FLAG_VA;
+
+	__invlpgb(0, pcid, addr, nr, str, flags);
+}
+
+/* Flush all mappings for a given PCID, not including globals. */
+static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
+{
+	__invlpgb(0, pcid, 0, 1, PTE_STRIDE, INVLPGB_FLAG_PCID);
+}
+
+/* Flush all mappings, including globals, for all PCIDs. */
+static inline void invlpgb_flush_all(void)
+{
+	/*
+	 * TLBSYNC at the end needs to make sure all flushes done on the
+	 * current CPU have been executed system-wide. Therefore, make
+	 * sure nothing gets migrated in-between but disable preemption
+	 * as it is cheaper.
+	 */
+	guard(preempt)();
+	__invlpgb(0, 0, 0, 1, PTE_STRIDE, INVLPGB_FLAG_INCLUDE_GLOBAL);
+	__tlbsync();
+}
+
+/* Flush addr, including globals, for all PCIDs. */
+static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
+{
+	__invlpgb(0, 0, addr, nr, PTE_STRIDE, INVLPGB_FLAG_INCLUDE_GLOBAL);
+}
+
+/* Flush all mappings for all PCIDs except globals. */
+static inline void invlpgb_flush_all_nonglobals(void)
+{
+	guard(preempt)();
+	__invlpgb(0, 0, 0, 1, PTE_STRIDE, INVLPGB_MODE_ALL_NONGLOBALS);
+	__tlbsync();
+}
 #endif /* _ASM_X86_TLB_H */
-- 
2.43.0


