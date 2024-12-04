Return-Path: <linux-kernel+bounces-431667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F79E430D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A36ECB2E065
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E9D20CCD9;
	Wed,  4 Dec 2024 16:56:49 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262A20C474;
	Wed,  4 Dec 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331409; cv=none; b=RRKWl1/6xvZDXT9aFKKTHOp9/nPOd64NwSgTNVWhi0d5RycA0JLdUtvFmBJa+LDVODsCJ+FnfO1lI0EUIUlKO+slPleIAyhduDhUR0jnVcAUpnB1IV07hGu0CjRjzsB5lZheb6hsJTiTGvvnvqC6AwIRdkno+YEpBGLEnwN4jPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331409; c=relaxed/simple;
	bh=dSSVlfxoBSEu/gmdnis4ez0qKbf9Yv+hLMkbMSzRuBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+VRbdARmcoiMXLzBZBNRp7GTodROFDqjPgsoNWu+hxDNKPog7a1yeH5rwz4GLerquMpt1utuqpJaokhQ5hJgNUOuxjjzxxEkDgpUfDIse+5NmC60jdb/JbnPoXVuT/mNVYh48k74jUj2pvLNEV8QexsGCqWrbFKWd2ns+bka4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:82e7:cf5d:dfd9:50ef] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tIsfz-000000007aN-1y0K;
	Wed, 04 Dec 2024 11:56:35 -0500
Date: Wed, 4 Dec 2024 11:56:34 -0500
From: Rik van Riel <riel@surriel.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Mel
 Gorman <mgorman@suse.de>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3] x86,mm: only trim the mm_cpumask once a second
Message-ID: <20241204115634.28964c62@fangorn>
In-Reply-To: <Z1BV7NG/Qp0BNw3Y@xsang-OptiPlex-9020>
References: <202411282207.6bd28eae-lkp@intel.com>
	<20241202194358.59089122@fangorn>
	<Z1BV7NG/Qp0BNw3Y@xsang-OptiPlex-9020>
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

On Wed, 4 Dec 2024 21:15:24 +0800
Oliver Sang <oliver.sang@intel.com> wrote:


> we noticed there is the v2 for this patch, not sure if any significant ch=
anges
> which could impact performance? if so, please notify us and we could test
> further. thanks

To some extent, I suspect we should expect some regressions with the
will-it-scale tlb_flush2 threaded test, since for "normal" workloads
the context switch code is the fast path, and madvise is much less
common.

However, v3 of the patch (below) shifts a lot less work into
flush_tlb_func, where it is done by all CPUs, and does more of
that work on the calling CPU, where it is done only once, instead.

For performance, I'm just going to throw it over to you, because
the largest 2 socket systems I have access to do not seem to behave
like your (much larger) 2 socket system.

---8<---

=46rom 3118ddb2260bd92a8b0679b7e6fd51ee494c17c9 Mon Sep 17 00:00:00 2001
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
 arch/x86/include/asm/tlbflush.h    |  1 +
 arch/x86/mm/tlb.c                  | 35 +++++++++++++++++++++++++++---
 4 files changed, 36 insertions(+), 3 deletions(-)

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
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflus=
h.h
index 69e79fff41b8..02fc2aa06e9e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -222,6 +222,7 @@ struct flush_tlb_info {
 	unsigned int		initiating_cpu;
 	u8			stride_shift;
 	u8			freed_tables;
+	u8			trim_cpumask;
 };
=20
 void flush_tlb_local(void);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1aac4fa90d3d..a758143afa01 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -892,9 +892,36 @@ static void flush_tlb_func(void *info)
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
+	if (info->trim_cpumask)
+		return true;
+
+	return false;
+}
+
+static bool should_trim_cpumask(struct mm_struct *mm)
+{
+	if (time_after(jiffies, mm->context.next_trim_cpumask)) {
+		mm->context.next_trim_cpumask =3D jiffies + HZ;
+		return true;
+	}
+	return false;
 }
=20
 DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared=
);
@@ -928,7 +955,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cp=
umask *cpumask,
 	if (info->freed_tables)
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
+		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
 				(void *)info, 1, cpumask);
 }
=20
@@ -979,6 +1006,7 @@ static struct flush_tlb_info *get_flush_tlb_info(struc=
t mm_struct *mm,
 	info->freed_tables	=3D freed_tables;
 	info->new_tlb_gen	=3D new_tlb_gen;
 	info->initiating_cpu	=3D smp_processor_id();
+	info->trim_cpumask	=3D 0;
=20
 	return info;
 }
@@ -1021,6 +1049,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
 	 * flush_tlb_func_local() directly in this case.
 	 */
 	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
+		info->trim_cpumask =3D should_trim_cpumask(mm);
 		flush_tlb_multi(mm_cpumask(mm), info);
 	} else if (mm =3D=3D this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
--=20
2.47.0


