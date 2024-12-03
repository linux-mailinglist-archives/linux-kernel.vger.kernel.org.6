Return-Path: <linux-kernel+bounces-430076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B722A9E2C54
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3BE284431
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCA22040BB;
	Tue,  3 Dec 2024 19:49:17 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA14A29;
	Tue,  3 Dec 2024 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255356; cv=none; b=M0q9g2H+SaQriLCLu6sSqXJ5pQbB1YE1jfZPmCqS+/nApiulHOak9bKQ0Ay/WWUnbCD89nV9LM4tOKpjs0iMNHhZaqTaIjN5OaKa3sz/ZiPCTfflIUu/VxkWcFLq0jIf09sx8sArFkMIz9xK25yaS2qwwn4wQn97R+jfcAQTYyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255356; c=relaxed/simple;
	bh=ifJbDL19/drcBvcYVzBTRDEXadYacQSjCUDF23hlbVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FjdJM6LECcdEllmXv+BILrIsRf7jqCyEDW/IgEkRimYwCi3IM1zxpSc91EEYsOtyy9UaxUwG23jr/LW26ZNi5VqMlwg6AQ1kxWvbK+OqGH8hkUMnKQFhOrFYq7pC9PNBPm9RBb60hdVsz+S3dKpkLL7fjmlTCmejWLc/5v8pYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:82e7:cf5d:dfd9:50ef] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tIYt4-000000001ga-0e7t;
	Tue, 03 Dec 2024 14:48:46 -0500
Date: Tue, 3 Dec 2024 14:48:45 -0500
From: Rik van Riel <riel@surriel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar
 <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Mel
 Gorman <mgorman@suse.de>
Subject: [PATCH v2] x86,mm: only trim the mm_cpumask once a second
Message-ID: <20241203144845.7093ea1a@fangorn>
In-Reply-To: <5dcb4050-f0f3-43d6-b4b1-42fa305a0fba@efficios.com>
References: <202411282207.6bd28eae-lkp@intel.com>
	<20241202202213.26a79ed6@fangorn>
	<5dcb4050-f0f3-43d6-b4b1-42fa305a0fba@efficios.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: riel@surriel.com

On Tue, 3 Dec 2024 09:57:55 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:


> I'd recommend to rename "last_trimmed_cpumask" to "next_trim_cpumask",
> and always update it to "jiffies + HZ". Then we can remove the addition
> from the comparison in the should_flush_tlb() fast-path:

Thanks Mathieu, I have applied your suggested improvements,
except for the one you posted as a separate patch earlier.

---8<---

=46rom c7d04233f15ba217ce6ebd0dcf12fab91c437e96 Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@fb.com>
Date: Mon, 2 Dec 2024 09:57:31 -0800
Subject: [PATCH] x86,mm: only trim the mm_cpumask once a second

Setting and clearing CPU bits in the mm_cpumask is only ever done
by the CPU itself, from the context switch code or the TLB flush
code.

Synchronization is handled by switch_mm_irqs_off blocking interrupts.

Sending TLB flush IPIs to CPUs that are in the mm_cpumask, but no
longer running the program causes a regression in the will-it-scale
tlbflush2 test. This test is contrived, but a large regression here
might cause a small regression in some real world workload.

Instead of always sending IPIs to CPUs that are in the mm_cpumask,
but no longer running the program, send these IPIs only once a second.

The rest of the time we can skip over CPUs where the loaded_mm is
different from the target mm.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reported-by: kernel test roboto <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202411282207.6bd28eae-lkp@intel.com/
---
 arch/x86/include/asm/mmu.h         |  2 ++
 arch/x86/include/asm/mmu_context.h |  1 +
 arch/x86/mm/tlb.c                  | 27 ++++++++++++++++++++++++---
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index ce4677b8b735..3b496cdcb74b 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -37,6 +37,8 @@ typedef struct {
 	 */
 	atomic64_t tlb_gen;
=20
+	unsigned long next_trim_cpumask;
+
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	struct rw_semaphore	ldt_usr_sem;
 	struct ldt_struct	*ldt;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_=
context.h
index 2886cb668d7f..795fdd53bd0a 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -151,6 +151,7 @@ static inline int init_new_context(struct task_struct *=
tsk,
=20
 	mm->context.ctx_id =3D atomic64_inc_return(&last_mm_ctx_id);
 	atomic64_set(&mm->context.tlb_gen, 0);
+	mm->context.next_trim_cpumask =3D jiffies + HZ;
=20
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1aac4fa90d3d..e90edbbf0188 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -759,8 +759,11 @@ static void flush_tlb_func(void *info)
=20
 		/* Can only happen on remote CPUs */
 		if (f->mm && f->mm !=3D loaded_mm) {
+			unsigned long next_jiffies =3D jiffies + HZ;
 			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
 			trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
+			if (time_after(next_jiffies, READ_ONCE(f->mm->context.next_trim_cpumask=
)))
+				WRITE_ONCE(f->mm->context.next_trim_cpumask, next_jiffies);
 			return;
 		}
 	}
@@ -892,9 +895,27 @@ static void flush_tlb_func(void *info)
 			nr_invalidate);
 }
=20
-static bool tlb_is_not_lazy(int cpu, void *data)
+static bool should_flush_tlb(int cpu, void *data)
 {
-	return !per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
+	struct flush_tlb_info *info =3D data;
+
+	/* Lazy TLB will get flushed at the next context switch. */
+	if (per_cpu(cpu_tlbstate_shared.is_lazy, cpu))
+		return false;
+
+	/* No mm means kernel memory flush. */
+	if (!info->mm)
+		return true;
+
+	/* The target mm is loaded, and the CPU is not lazy. */
+	if (per_cpu(cpu_tlbstate.loaded_mm, cpu) =3D=3D info->mm)
+		return true;
+
+	/* In cpumask, but not the loaded mm? Periodically remove by flushing. */
+	if (time_after(jiffies, info->mm->context.next_trim_cpumask))
+		return true;
+
+	return false;
 }
=20
 DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared=
);
@@ -928,7 +949,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cp=
umask *cpumask,
 	if (info->freed_tables)
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
+		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
 				(void *)info, 1, cpumask);
 }
=20
--=20
2.47.0


