Return-Path: <linux-kernel+bounces-532904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C4CA45396
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D233AD330
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2E122256E;
	Wed, 26 Feb 2025 03:01:51 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010721C9EE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538910; cv=none; b=Bl5E90q0iXac23N9dKg6Wl3p7tSLgbX1A4l5HOqCVlJMt8OcWPLWSILPOVk1xoUm3pWweXT2cOrTXE/6zajyZektN5eeQ1TH3ZDXmVgTbx5sKh9cPCrNTgDlSgKXsq8uC6fSSZSrysYKbPkhaB6u1m7qQB9O6tjyZW7z2jxAGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538910; c=relaxed/simple;
	bh=whtnn44Num0oisRgu2MRfKcA35w7YlCmd4XWm55Z2fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKzxUKi7o7DFWWqFbzYm60ASx8L/gQhbyh4pqRDr5H9p3oSbQCncQ1jBWJWvjTlG0ncERNbqWNktJRcQwHnAvt6295ZBjcz0TQXlWqzcVkmEGPU9xcGq0odK30SAlJztPKHmk4g0BN4vgUaA1F2X7CPZJEMnkWA6RRDahf3+Ai4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tn7fw-000000001Y5-1Bi8;
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
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v14 10/13] x86/mm: enable broadcast TLB invalidation for multi-threaded processes
Date: Tue, 25 Feb 2025 22:00:45 -0500
Message-ID: <20250226030129.530345-11-riel@surriel.com>
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

Use broadcast TLB invalidation, using the INVPLGB instruction.

There is not enough room in the 12-bit ASID address space to hand
out broadcast ASIDs to every process. Only hand out broadcast ASIDs
to processes when they are observed to be simultaneously running
on 4 or more CPUs.

This also allows single threaded process to continue using the
cheaper, local TLB invalidation instructions like INVLPGB.

Due to the structure of flush_tlb_mm_range, the INVLPGB
flushing is done in a generically named broadcast_tlb_flush
function, which can later also be used for Intel RAR.

Combined with the removal of unnecessary lru_add_drain calls
(see https://lkml.org/lkml/2024/12/19/1388) this results in a
nice performance boost for the will-it-scale tlb_flush2_threads
test on an AMD Milan system with 36 cores:

- vanilla kernel:           527k loops/second
- lru_add_drain removal:    731k loops/second
- only INVLPGB:             527k loops/second
- lru_add_drain + INVLPGB: 1157k loops/second

Profiling with only the INVLPGB changes showed while
TLB invalidation went down from 40% of the total CPU
time to only around 4% of CPU time, the contention
simply moved to the LRU lock.

Fixing both at the same time about doubles the
number of iterations per second from this case.

Comparing will-it-scale tlb_flush2_threads with
several different numbers of threads on a 72 CPU
AMD Milan shows similar results. The number
represents the total number of loops per second
across all the threads:

threads		tip		invlpgb

1		315k		304k
2		423k		424k
4		644k		1032k
8		652k		1267k
16		737k		1368k
32		759k		1199k
64		636k		1094k
72		609k		993k

1 and 2 thread performance is similar with and
without invlpgb, because invlpgb is only used
on processes using 4 or more CPUs simultaneously.

The number is the median across 5 runs.

Some numbers closer to real world performance
can be found at Phoronix, thanks to Michael:

https://www.phoronix.com/news/AMD-INVLPGB-Linux-Benefits

Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/include/asm/tlbflush.h |   9 +++
 arch/x86/mm/tlb.c               | 107 +++++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 37b735dcf025..811dd70eb6b8 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -272,6 +272,11 @@ static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
 	smp_store_release(&mm->context.global_asid, asid);
 }
 
+static inline void clear_asid_transition(struct mm_struct *mm)
+{
+	WRITE_ONCE(mm->context.asid_transition, false);
+}
+
 static inline bool in_asid_transition(struct mm_struct *mm)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
@@ -289,6 +294,10 @@ static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
 {
 }
 
+static inline void clear_asid_transition(struct mm_struct *mm)
+{
+}
+
 static inline bool in_asid_transition(struct mm_struct *mm)
 {
 	return false;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b7d461db1b08..cd109bdf0dd9 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -422,6 +422,108 @@ static bool needs_global_asid_reload(struct mm_struct *next, u16 prev_asid)
 	return false;
 }
 
+/*
+ * x86 has 4k ASIDs (2k when compiled with KPTI), but the largest
+ * x86 systems have over 8k CPUs. Because of this potential ASID
+ * shortage, global ASIDs are handed out to processes that have
+ * frequent TLB flushes and are active on 4 or more CPUs simultaneously.
+ */
+static void consider_global_asid(struct mm_struct *mm)
+{
+	if (!static_cpu_has(X86_FEATURE_INVLPGB))
+		return;
+
+	/* Check every once in a while. */
+	if ((current->pid & 0x1f) != (jiffies & 0x1f))
+		return;
+
+	if (!READ_ONCE(global_asid_available))
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
+	if (!in_asid_transition(mm))
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
+	clear_asid_transition(mm);
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
+		if (static_cpu_has(X86_FEATURE_PTI))
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
+		if (static_cpu_has(X86_FEATURE_PTI))
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
@@ -1252,9 +1354,12 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
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
2.47.1


