Return-Path: <linux-kernel+bounces-428573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1E99E10BE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41C4B22463
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7492E3EE;
	Tue,  3 Dec 2024 01:22:29 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3A847C;
	Tue,  3 Dec 2024 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733188949; cv=none; b=cWosSYFwHFl0WQvuB8M+S4C68eXeHRydk9IIUUyz5+s4ed1TQGgxEzKksXs1HBbtoaEubi/N3+d+P2XnX6SGZYM4UqWkIv85VbfnsFTYainqm1LVzu6aDzn5bgXAlu71yJ8yFn8I6Fti+XXTerbedNeW7DlsT+evcGgf1rN18/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733188949; c=relaxed/simple;
	bh=HG57F1AVWojYH/0lsXkb4gTU/N6SAx33MLEyiYRlRgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H++u8qo9QupiBpb02LBQ0oBg5RxEf2oOztEUPfbahApk1x0qCDNCzR4a8ER7bP4qsnYYQXNb01Oi0QrUqM2Py8K626xRIanXBOXuGECVVxh/Wwz7hqjhhTn9MVoz4iW80TLi7Jq7SKhaKJrj3rVLXWlaijTxFMoEwnsVC19csdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:82e7:cf5d:dfd9:50ef] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tIHcF-000000002wl-1fYw;
	Mon, 02 Dec 2024 20:22:15 -0500
Date: Mon, 2 Dec 2024 20:22:13 -0500
From: Rik van Riel <riel@surriel.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Mel
 Gorman <mgorman@suse.de>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH -tip] x86,mm: only trim the mm_cpumask once a second
Message-ID: <20241202202213.26a79ed6@fangorn>
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

[UGH - of course I mailed out the version I tested with, rather than
 the version that I merged into -tip.  Here's the right one.]

The patch below should fix the will-it-scale performance regression,
while still allowing us to keep the lazy mm_cpumask updates that help
workloads in other ways.

I do not have the same hardware as the Intel guys have access to, and
could only test this on one two socket system, but hopefully this
provides a simple (enough) compromise that allows us to keep both
the lazier context switch code, and a limited mm_cpumask to keep
TLB flushing work bounded.

---8<---

=46rom dec4a588077563b86dbfe547737018b881e1f6c2 Mon Sep 17 00:00:00 2001
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
index 2886cb668d7f..086af641d19a 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -151,6 +151,7 @@ static inline int init_new_context(struct task_struct *=
tsk,
=20
 	mm->context.ctx_id =3D atomic64_inc_return(&last_mm_ctx_id);
 	atomic64_set(&mm->context.tlb_gen, 0);
+	mm->context.last_trimmed_cpumask =3D jiffies;
=20
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1aac4fa90d3d..19ae8ca34cb8 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -761,6 +761,7 @@ static void flush_tlb_func(void *info)
 		if (f->mm && f->mm !=3D loaded_mm) {
 			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
 			trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
+			f->mm->context.last_trimmed_cpumask =3D jiffies;
 			return;
 		}
 	}
@@ -892,9 +893,27 @@ static void flush_tlb_func(void *info)
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
@@ -928,7 +947,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cp=
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



