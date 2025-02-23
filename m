Return-Path: <linux-kernel+bounces-527934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7415EA41171
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15993AE38A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACE8207653;
	Sun, 23 Feb 2025 19:50:18 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36011C862E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740340217; cv=none; b=QA5VnlGJ1aBylBEhTUn55/kycCaHsav1eq6hGlBiTkBq4QsoGSdlO1VsVA2s0Uk+qkYklPn4YYbW6ioxPk6AlYQ6mq0ItZVHmLrkiEPwS1/brmf3WMAaSdKuNhdmxvvu2qyH9GReVmvbAELNpAM11LHyNKBAJZX0z3V1KnFX5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740340217; c=relaxed/simple;
	bh=UTQdQyup8SvxN2MBn377O71z+Cv8KwQtShOeD4HM/ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI6rqL7rIZ/VCzw9fBVa3lSd0mT+F2ZDO52XNhNN8Vx0tRqNTJ4814AWQ4IOB1SoCwLuVAJua2XirxuZD1ebKUn+7qatLMMD/37UKiR36Wgpe82q+s6SO7iQjuVfcuYSa5pWxmUt2RwzNLFnoYZEkP2TLiYJ3m4MGT9Ix4Ea1f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tmHyz-000000001hX-08Iv;
	Sun, 23 Feb 2025 14:49:45 -0500
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
Subject: [PATCH v13 10/14] x86/mm: enable broadcast TLB invalidation for multi-threaded processes
Date: Sun, 23 Feb 2025 14:49:00 -0500
Message-ID: <20250223194943.3518952-11-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250223194943.3518952-1-riel@surriel.com>
References: <20250223194943.3518952-1-riel@surriel.com>
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
 arch/x86/mm/tlb.c | 107 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d8a04e398615..01a5edb51ebe 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -420,6 +420,108 @@ static bool needs_global_asid_reload(struct mm_struct *next, u16 prev_asid)
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
+	if (!READ_ONCE(mm->context.asid_transition))
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
+	WRITE_ONCE(mm->context.asid_transition, false);
+}
+
+static void broadcast_tlb_flush(struct flush_tlb_info *info)
+{
+	bool pmd = info->stride_shift == PMD_SHIFT;
+	unsigned long asid = info->mm->context.global_asid;
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
@@ -1250,9 +1352,12 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
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


