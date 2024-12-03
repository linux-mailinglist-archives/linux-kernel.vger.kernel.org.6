Return-Path: <linux-kernel+bounces-428550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8829E1081
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785511622C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8E812B94;
	Tue,  3 Dec 2024 00:44:28 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B189B2500BD;
	Tue,  3 Dec 2024 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733186667; cv=none; b=bO3ugTHMIHG3tKcNFwKFwlWBP/Q5oX0fosveufBoijvho819IesICG6B9d+r6DLn2QRK2S7LqoKRK+rWxmxjon5Rjngqw4q95e7skhhV9tUbA6SmoUxJ4H1wFJvRs13mji4tr7XCf0Us2UFTivGGRi1S38DLj1mQBj/KvC5qxrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733186667; c=relaxed/simple;
	bh=ivVr7+hkGcjr2KePLormpOBddy+1jbddzb/J2KjZu58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeBwNeQxMZG6YydbAaswiCo43q9VP/z5CZWS7perulcvzadrZwQkSU/WsGOchWc2hUvPMEO06z27d61Kpgy/AVVb+cyPgtAzY6CG7MdML6uzhdvWS9+3QbocGJz1ttY0l6Q9kGKYTXVnytboxoMNPXeZnZrjVvphveVIrd0B6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:82e7:cf5d:dfd9:50ef] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tIH1D-000000002M5-35IQ;
	Mon, 02 Dec 2024 19:43:59 -0500
Date: Mon, 2 Dec 2024 19:43:58 -0500
From: Rik van Riel <riel@surriel.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Mel
 Gorman <mgorman@suse.de>, Oliver Sang <oliver.sang@intel.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] x86,mm: only trim the mm_cpumask once a second
Message-ID: <20241202194358.59089122@fangorn>
In-Reply-To: <202411282207.6bd28eae-lkp@intel.com>
References: <202411282207.6bd28eae-lkp@intel.com>
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

On Thu, 28 Nov 2024 22:57:35 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> Hello,
>=20
> kernel test robot noticed a 13.2% regression of will-it-scale.per_thread_=
ops on:
>=20
>=20
> commit: 209954cbc7d0ce1a190fc725d20ce303d74d2680 ("x86/mm/tlb: Update mm_=
cpumask lazily")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm

The patch below should fix the will-it-scale performance regression,
while still allowing us to keep the lazy mm_cpumask updates that help
workloads in other ways.

I do not have the same hardware as the Intel guys have access to, and
could only test this on one two socket system, but hopefully this
provides a simple (enough) compromise that allows us to keep both
the lazier context switch code, and a limited mm_cpumask to keep
TLB flushing work bounded.

---8<---

=46rom b639c1f16ddf4bcfc44dbaa2b8077220f88b1876 Mon Sep 17 00:00:00 2001
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

On a two socket system with 20 CPU cores on each socket (80 CPUs total),
this patch, on top of the other context switch patches shows a 3.6%
speedup in the total runtime of will-it-scale tlbflush2 -t 40 -s 100000.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reported-by: kernel test roboto <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202411282207.6bd28eae-lkp@intel.com/
---
 arch/x86/include/asm/mmu.h         |  2 ++
 arch/x86/include/asm/mmu_context.h |  1 +
 arch/x86/mm/tlb.c                  | 25 ++++++++++++++++++++++---
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index ce4677b8b735..2c7e3855b88b 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -37,6 +37,8 @@ typedef struct {
 	 */
 	atomic64_t tlb_gen;
=20
+	unsigned long last_trimmed_cpumask;
+
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	struct rw_semaphore	ldt_usr_sem;
 	struct ldt_struct	*ldt;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_=
context.h
index 8dac45a2c7fc..428fd190477a 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -145,6 +145,7 @@ static inline int init_new_context(struct task_struct *=
tsk,
=20
 	mm->context.ctx_id =3D atomic64_inc_return(&last_mm_ctx_id);
 	atomic64_set(&mm->context.tlb_gen, 0);
+	mm->context.last_trimmed_cpumask =3D jiffies;
=20
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index fcea29e07eed..0ce5f2ed7825 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -766,6 +766,7 @@ static void flush_tlb_func(void *info)
 		 */
 		if (f->mm && f->mm !=3D loaded_mm) {
 			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
+			f->mm->context.last_trimmed_cpumask =3D jiffies;
 			return;
 		}
 	}
@@ -897,9 +898,27 @@ static void flush_tlb_func(void *info)
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
+	if (jiffies > info->mm->context.last_trimmed_cpumask + HZ)
+		return true;
+
+	return false;
 }
=20
 DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared=
);
@@ -933,7 +952,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cp=
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
2.43.5


