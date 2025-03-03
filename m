Return-Path: <linux-kernel+bounces-541617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C68A4BF44
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C62A3A6564
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9485520B7E6;
	Mon,  3 Mar 2025 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UjlK5XBF"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105B20B217
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002412; cv=none; b=KTZfWBpcYXsXKoEBOWc+m//v/4bK0PkPgnFqEftSim41FuBpn0zqeS/kFrkIwRjOTFeGv9a2R3tQxz8ZYtlEG2AvseOnnbzEOa5XFnb6t3sy6i9yrpMTo9m8JfDwUWMAqmNAF0Nh+Yk7o/V8Jqk0XIujCkgqdKpgrUFng7kOSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002412; c=relaxed/simple;
	bh=iG7zva73IVuhaA4CJvZSP388loCNjve/5w5qfJZaMvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC04aA0ljhwpodpbKNDSSAXaGcMKWMhiIZGroBCakkXNOJseTgIBgGbfV1LawMkmuKw1o9Ds9uzOKJ3kZcZWmG7gE0s+ygjblbMGkQ7vmbPBvt7kiy148g84B9LSQtPmHg9zxHq99blqwkt1+RJOCT/G7Khvatx/6q1GjvWfMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UjlK5XBF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C00040E0214;
	Mon,  3 Mar 2025 11:46:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sY5HXBn-ZGIq; Mon,  3 Mar 2025 11:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741002401; bh=lr4pcUvK1sXL+GqKzwaVriTNa+Bb+3A/phlFBzv/G+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjlK5XBF9v2c5iDW/9VnZni1ye/acKvQGoCAifgYZldK1P0Des3K+qzAc6QHDI4LK
	 i1pFLLqtGr//wSL0s82NoF/fq77KLHiuhy0mYhIVrlq5LU50Ezn5NhSYC93b9TH5qg
	 BpSG+/819cDHT525riD2WH2hRo5V6ECLqsEK44zWvYyHKZLiZYq/DS0iKiQbqTUIE+
	 INbkjBql2HMcDh0E3CBKUgqEUr4cTsmdDGGLQk6rqmGFMr/FyzJ8jJ3JD1jsKeGT26
	 eTtyr3D+yvJ/Wh4TE7Jp5TuvB198B17CLCPhIhzZwbMMDhskZQAzODuv9KxYLQCVvP
	 4pgKploa4gMryO+eY0soGS8azxbm0S6E+6dnDPCo6aekM4T1n8s37a8W8TWdoYQuFu
	 Qste/fuA+WQkiMCK8HprDFClrhRZFL/DAv8P3dmRecsfG85tai4Wc888LtS8fcb/xG
	 xElHKPKrvc+k9ojlTingEjCQvJBQpn8WXQHCRSec36o2DRWCf8pURUpk/nrKcTRpUJ
	 KrCorl8ujHrlN/D130SXKCRwCTmzqx31+yIsCgacuXO7udwjZVCL4A/u9mhQLG9NVD
	 fSEKxOktE9VtnVfHuPWA4tINofflzIy7TZi8w/tfPQtMEcvlrZXBVKVZf+CgBKbdje
	 ISx5l+IxUMX+HD9s298LLho4=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 67CF140E01D1;
	Mon,  3 Mar 2025 11:46:24 +0000 (UTC)
Date: Mon, 3 Mar 2025 12:46:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 11/13] x86/mm: do targeted broadcast flushing from
 tlbbatch code
Message-ID: <20250303114618.GBZ8WWihMDjf-oy8P0@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-12-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-12-riel@surriel.com>

On Tue, Feb 25, 2025 at 10:00:46PM -0500, Rik van Riel wrote:
> +static inline bool cpu_need_tlbsync(void)
> +{
> +	return this_cpu_read(cpu_tlbstate.need_tlbsync);
> +}
> +
> +static inline void cpu_write_tlbsync(bool state)

That thing feels better like "cpu_set_tlbsync" in the code...

> +{
> +	this_cpu_write(cpu_tlbstate.need_tlbsync, state);
> +}
>  #else
>  static inline u16 mm_global_asid(struct mm_struct *mm)
>  {

...

> +static inline void tlbsync(void)
> +{
> +	if (!cpu_need_tlbsync())
> +		return;
> +	__tlbsync();
> +	cpu_write_tlbsync(false);
> +}

Easier to parse visually:

static inline void tlbsync(void)
{
        if (cpu_need_tlbsync()) {
                __tlbsync();
                cpu_write_tlbsync(false);
        }
}

Final:

From: Rik van Riel <riel@surriel.com>
Date: Tue, 25 Feb 2025 22:00:46 -0500
Subject: [PATCH] x86/mm: Do targeted broadcast flushing from tlbbatch code

Instead of doing a system-wide TLB flush from arch_tlbbatch_flush(), queue up
asynchronous, targeted flushes from arch_tlbbatch_add_pending().

This also allows to avoid adding the CPUs of processes using broadcast
flushing to the batch->cpumask, and will hopefully further reduce TLB flushing
from the reclaim and compaction paths.

  [ bp:
   - Massage
   - :%s/\<static_cpu_has\>/cpu_feature_enabled/cgi ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-12-riel@surriel.com
---
 arch/x86/include/asm/tlb.h      | 12 ++---
 arch/x86/include/asm/tlbflush.h | 27 +++++++----
 arch/x86/mm/tlb.c               | 79 +++++++++++++++++++++++++++++++--
 3 files changed, 100 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 04f2c6f4cee3..b5c2005725cf 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -102,16 +102,16 @@ static inline void __tlbsync(void) { }
 #define INVLPGB_FINAL_ONLY		BIT(4)
 #define INVLPGB_INCLUDE_NESTED		BIT(5)
 
-static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
-						unsigned long addr,
-						u16 nr,
-						bool pmd_stride)
+static inline void __invlpgb_flush_user_nr_nosync(unsigned long pcid,
+						  unsigned long addr,
+						  u16 nr,
+						  bool pmd_stride)
 {
 	__invlpgb(0, pcid, addr, nr, pmd_stride, INVLPGB_PCID | INVLPGB_VA);
 }
 
 /* Flush all mappings for a given PCID, not including globals. */
-static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
+static inline void __invlpgb_flush_single_pcid_nosync(unsigned long pcid)
 {
 	__invlpgb(0, pcid, 0, 1, 0, INVLPGB_PCID);
 }
@@ -131,7 +131,7 @@ static inline void invlpgb_flush_all(void)
 }
 
 /* Flush addr, including globals, for all PCIDs. */
-static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
+static inline void __invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
 {
 	__invlpgb(0, 0, addr, nr, 0, INVLPGB_INCLUDE_GLOBAL);
 }
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 8c21030269ff..cbdb86d58301 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -105,6 +105,9 @@ struct tlb_state {
 	 * need to be invalidated.
 	 */
 	bool invalidate_other;
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
+	bool need_tlbsync;
+#endif
 
 #ifdef CONFIG_ADDRESS_MASKING
 	/*
@@ -292,11 +295,23 @@ static inline bool mm_in_asid_transition(struct mm_struct *mm)
 
 	return mm && READ_ONCE(mm->context.asid_transition);
 }
+
+static inline bool cpu_need_tlbsync(void)
+{
+	return this_cpu_read(cpu_tlbstate.need_tlbsync);
+}
+
+static inline void cpu_set_tlbsync(bool state)
+{
+	this_cpu_write(cpu_tlbstate.need_tlbsync, state);
+}
 #else
 static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
 static inline void mm_init_global_asid(struct mm_struct *mm) { }
 static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
 static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
+static inline bool cpu_need_tlbsync(void) { return false; }
+static inline void cpu_set_tlbsync(bool state) { }
 #endif /* CONFIG_BROADCAST_TLB_FLUSH */
 
 #ifdef CONFIG_PARAVIRT
@@ -346,21 +361,15 @@ static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
 	return atomic64_inc_return(&mm->context.tlb_gen);
 }
 
-static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
-					     struct mm_struct *mm,
-					     unsigned long uaddr)
-{
-	inc_mm_tlb_gen(mm);
-	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
-	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
-}
-
 static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 {
 	flush_tlb_mm(mm);
 }
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+extern void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+					     struct mm_struct *mm,
+					     unsigned long uaddr);
 
 static inline bool pte_flags_need_flush(unsigned long oldflags,
 					unsigned long newflags,
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 0efd99053c09..83ba6876adbf 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -492,6 +492,37 @@ static void finish_asid_transition(struct flush_tlb_info *info)
 	mm_clear_asid_transition(mm);
 }
 
+static inline void tlbsync(void)
+{
+	if (cpu_need_tlbsync()) {
+		__tlbsync();
+		cpu_set_tlbsync(false);
+	}
+}
+
+static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
+						unsigned long addr,
+						u16 nr, bool pmd_stride)
+{
+	__invlpgb_flush_user_nr_nosync(pcid, addr, nr, pmd_stride);
+	if (!cpu_need_tlbsync())
+		cpu_set_tlbsync(true);
+}
+
+static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
+{
+	__invlpgb_flush_single_pcid_nosync(pcid);
+	if (!cpu_need_tlbsync())
+		cpu_set_tlbsync(true);
+}
+
+static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
+{
+	__invlpgb_flush_addr_nosync(addr, nr);
+	if (!cpu_need_tlbsync())
+		cpu_set_tlbsync(true);
+}
+
 static void broadcast_tlb_flush(struct flush_tlb_info *info)
 {
 	bool pmd = info->stride_shift == PMD_SHIFT;
@@ -790,6 +821,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(!irqs_disabled());
 
+	tlbsync();
+
 	/*
 	 * Verify that CR3 is what we think it is.  This will catch
 	 * hypothetical buggy code that directly switches to swapper_pg_dir
@@ -966,6 +999,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
  */
 void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
+	tlbsync();
+
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
 		return;
 
@@ -1633,9 +1668,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
-		invlpgb_flush_all_nonglobals();
-	} else if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
+	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
 		flush_tlb_multi(&batch->cpumask, info);
 	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
@@ -1644,12 +1677,52 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		local_irq_enable();
 	}
 
+	/*
+	 * If (asynchronous) INVLPGB flushes were issued, wait for them here.
+	 * The cpumask above contains only CPUs that were running tasks
+	 * not using broadcast TLB flushing.
+	 */
+	tlbsync();
+
 	cpumask_clear(&batch->cpumask);
 
 	put_flush_tlb_info();
 	put_cpu();
 }
 
+void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+					     struct mm_struct *mm,
+					     unsigned long uaddr)
+{
+	u16 asid = mm_global_asid(mm);
+
+	if (asid) {
+		invlpgb_flush_user_nr_nosync(kern_pcid(asid), uaddr, 1, false);
+		/* Do any CPUs supporting INVLPGB need PTI? */
+		if (cpu_feature_enabled(X86_FEATURE_PTI))
+			invlpgb_flush_user_nr_nosync(user_pcid(asid), uaddr, 1, false);
+
+		/*
+		 * Some CPUs might still be using a local ASID for this
+		 * process, and require IPIs, while others are using the
+		 * global ASID.
+		 *
+		 * In this corner case, both broadcast TLB invalidation
+		 * and IPIs need to be sent. The IPIs will help
+		 * stragglers transition to the broadcast ASID.
+		 */
+		if (mm_in_asid_transition(mm))
+			asid = 0;
+	}
+
+	if (!asid) {
+		inc_mm_tlb_gen(mm);
+		cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
+	}
+
+	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
+}
+
 /*
  * Blindly accessing user memory from NMI context can be dangerous
  * if we're in the middle of switching the current user task or
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

