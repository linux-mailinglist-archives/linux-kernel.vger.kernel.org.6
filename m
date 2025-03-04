Return-Path: <linux-kernel+bounces-544316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B3EA4E005
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6B6189D3BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038CC204695;
	Tue,  4 Mar 2025 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8+HPt3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409A1205E25
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096734; cv=none; b=GvGNO8M9AInMxbXTIsWAzAO8Ke5Qoo+h6Vn8GuVY3TjEn8euA/LQIO1Rf52xyDaTyriJEMblaJn9njm7TvS66cm6gj5Any/97T2JGJQ352WdD4yD+6cCVUSMGlCV93JIE1AAxAzHEgsi8wBKpiddfLA2EFD5T9vlNkk15T0R2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096734; c=relaxed/simple;
	bh=z2DELLe0Mw9azg4Y88YeuBgadHUuT0vo+TmJ6yIo+tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XG7GLZOPlqWPw+EU56HDslE53U7MDE5JcdDG+xsTc6jO7bjyF7Z9OLftS3mL3FtxodVBJDYUQ25jKGwn8ulHX3gYk1+jot0ozYp1FFUOSbK185SaAHqf5A4GpW1bAnWcyUB2Q1LaV9a/SxSfjsTgDWFR76H24VsJ6mu9U9PIeYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8+HPt3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0033C4CEEC;
	Tue,  4 Mar 2025 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096733;
	bh=z2DELLe0Mw9azg4Y88YeuBgadHUuT0vo+TmJ6yIo+tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8+HPt3ijNm2idGQ/KNL7I1fl9hwX2WAjFZuhtSua12qfxgd234GwBSdBWD6AyXtg
	 ObChu36YdR+j1y4KCTaF5rn9itEJV5UDlYJnSmmgLMmxDIIi2uHpGyL02ePbMsC3YT
	 QmSjTvacRbODazBwh56pbdrU4Eni0Fuzq8mGQiVhKYg7xRVPMsT93Jf/mEq1UzfdGF
	 M8DFz00+8x4Ie8wJJt3bXAhktL41fswds+SatUToUA/fDxcVilxw5cUWT2hGUArq1D
	 aejw6+SS10aNx0LubbfUGq7u/IuNXsx1ukEfyvbgA4VzS8QGAkqkQoh3RBABvT3QiT
	 0GC5k8AvFNZWQ==
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
Subject: [PATCH v15 09/11] x86/mm: Enable broadcast TLB invalidation for multi-threaded processes
Date: Tue,  4 Mar 2025 14:58:14 +0100
Message-ID: <20250304135816.12356-10-bp@kernel.org>
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

There is not enough room in the 12-bit ASID address space to hand out
broadcast ASIDs to every process. Only hand out broadcast ASIDs to processes
when they are observed to be simultaneously running on 4 or more CPUs.

This also allows single threaded process to continue using the cheaper, local
TLB invalidation instructions like INVLPGB.

Due to the structure of flush_tlb_mm_range(), the INVLPGB flushing is done in
a generically named broadcast_tlb_flush() function which can later also be
used for Intel RAR.

Combined with the removal of unnecessary lru_add_drain calls() (see
https://lore.kernel.org/r/20241219153253.3da9e8aa@fangorn) this results in
a nice performance boost for the will-it-scale tlb_flush2_threads test on an
AMD Milan system with 36 cores:

  - vanilla kernel:           527k loops/second
  - lru_add_drain removal:    731k loops/second
  - only INVLPGB:             527k loops/second
  - lru_add_drain + INVLPGB: 1157k loops/second

Profiling with only the INVLPGB changes showed while TLB invalidation went
down from 40% of the total CPU time to only around 4% of CPU time, the
contention simply moved to the LRU lock.

Fixing both at the same time about doubles the number of iterations per second
from this case.

Comparing will-it-scale tlb_flush2_threads with several different numbers of
threads on a 72 CPU AMD Milan shows similar results. The number represents the
total number of loops per second across all the threads:

  threads	tip		INVLPGB

  1		315k		304k
  2		423k		424k
  4		644k		1032k
  8		652k		1267k
  16		737k		1368k
  32		759k		1199k
  64		636k		1094k
  72		609k		993k

1 and 2 thread performance is similar with and without INVLPGB, because
INVLPGB is only used on processes using 4 or more CPUs simultaneously.

The number is the median across 5 runs.

Some numbers closer to real world performance can be found at Phoronix, thanks
to Michael:

https://www.phoronix.com/news/AMD-INVLPGB-Linux-Benefits

  [ bp:
   - Massage
   - :%s/\<static_cpu_has\>/cpu_feature_enabled/cgi
   - :%s/\<clear_asid_transition\>/mm_clear_asid_transition/cgi
   - Fold in a 0day bot fix: https://lore.kernel.org/oe-kbuild-all/202503040000.GtiWUsBm-lkp@intel.com
   ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
Link: https://lore.kernel.org/r/20250226030129.530345-11-riel@surriel.com

WIP

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/tlbflush.h |   6 ++
 arch/x86/mm/tlb.c               | 104 +++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index e6c3be06dd21..7cad283d502d 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -280,6 +280,11 @@ static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
 	smp_store_release(&mm->context.global_asid, asid);
 }
 
+static inline void mm_clear_asid_transition(struct mm_struct *mm)
+{
+	WRITE_ONCE(mm->context.asid_transition, false);
+}
+
 static inline bool mm_in_asid_transition(struct mm_struct *mm)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
@@ -291,6 +296,7 @@ static inline bool mm_in_asid_transition(struct mm_struct *mm)
 static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
 static inline void mm_init_global_asid(struct mm_struct *mm) { }
 static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
+static inline void mm_clear_asid_transition(struct mm_struct *mm) { }
 static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
 #endif /* CONFIG_BROADCAST_TLB_FLUSH */
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b5681e6f2333..0efd99053c09 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -430,6 +430,105 @@ static bool mm_needs_global_asid(struct mm_struct *mm, u16 asid)
 	return false;
 }
 
+/*
+ * x86 has 4k ASIDs (2k when compiled with KPTI), but the largest x86
+ * systems have over 8k CPUs. Because of this potential ASID shortage,
+ * global ASIDs are handed out to processes that have frequent TLB
+ * flushes and are active on 4 or more CPUs simultaneously.
+ */
+static void consider_global_asid(struct mm_struct *mm)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return;
+
+	/* Check every once in a while. */
+	if ((current->pid & 0x1f) != (jiffies & 0x1f))
+		return;
+
+	/*
+	 * Assign a global ASID if the process is active on
+	 * 4 or more CPUs simultaneously.
+	 */
+	if (mm_active_cpus_exceeds(mm, 3))
+		use_global_asid(mm);
+}
+
+static void finish_asid_transition(struct flush_tlb_info *info)
+{
+	struct mm_struct *mm = info->mm;
+	int bc_asid = mm_global_asid(mm);
+	int cpu;
+
+	if (!mm_in_asid_transition(mm))
+		return;
+
+	for_each_cpu(cpu, mm_cpumask(mm)) {
+		/*
+		 * The remote CPU is context switching. Wait for that to
+		 * finish, to catch the unlikely case of it switching to
+		 * the target mm with an out of date ASID.
+		 */
+		while (READ_ONCE(per_cpu(cpu_tlbstate.loaded_mm, cpu)) == LOADED_MM_SWITCHING)
+			cpu_relax();
+
+		if (READ_ONCE(per_cpu(cpu_tlbstate.loaded_mm, cpu)) != mm)
+			continue;
+
+		/*
+		 * If at least one CPU is not using the global ASID yet,
+		 * send a TLB flush IPI. The IPI should cause stragglers
+		 * to transition soon.
+		 *
+		 * This can race with the CPU switching to another task;
+		 * that results in a (harmless) extra IPI.
+		 */
+		if (READ_ONCE(per_cpu(cpu_tlbstate.loaded_mm_asid, cpu)) != bc_asid) {
+			flush_tlb_multi(mm_cpumask(info->mm), info);
+			return;
+		}
+	}
+
+	/* All the CPUs running this process are using the global ASID. */
+	mm_clear_asid_transition(mm);
+}
+
+static void broadcast_tlb_flush(struct flush_tlb_info *info)
+{
+	bool pmd = info->stride_shift == PMD_SHIFT;
+	unsigned long asid = mm_global_asid(info->mm);
+	unsigned long addr = info->start;
+
+	/*
+	 * TLB flushes with INVLPGB are kicked off asynchronously.
+	 * The inc_mm_tlb_gen() guarantees page table updates are done
+	 * before these TLB flushes happen.
+	 */
+	if (info->end == TLB_FLUSH_ALL) {
+		invlpgb_flush_single_pcid_nosync(kern_pcid(asid));
+		/* Do any CPUs supporting INVLPGB need PTI? */
+		if (cpu_feature_enabled(X86_FEATURE_PTI))
+			invlpgb_flush_single_pcid_nosync(user_pcid(asid));
+	} else do {
+		unsigned long nr = 1;
+
+		if (info->stride_shift <= PMD_SHIFT) {
+			nr = (info->end - addr) >> info->stride_shift;
+			nr = clamp_val(nr, 1, invlpgb_count_max);
+		}
+
+		invlpgb_flush_user_nr_nosync(kern_pcid(asid), addr, nr, pmd);
+		if (cpu_feature_enabled(X86_FEATURE_PTI))
+			invlpgb_flush_user_nr_nosync(user_pcid(asid), addr, nr, pmd);
+
+		addr += nr << info->stride_shift;
+	} while (addr < info->end);
+
+	finish_asid_transition(info);
+
+	/* Wait for the INVLPGBs kicked off above to finish. */
+	__tlbsync();
+}
+
 /*
  * Given an ASID, flush the corresponding user ASID.  We can delay this
  * until the next time we switch to it.
@@ -1260,9 +1359,12 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
+	if (mm_global_asid(mm)) {
+		broadcast_tlb_flush(info);
+	} else if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
 		info->trim_cpumask = should_trim_cpumask(mm);
 		flush_tlb_multi(mm_cpumask(mm), info);
+		consider_global_asid(mm);
 	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-- 
2.43.0


