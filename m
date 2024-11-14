Return-Path: <linux-kernel+bounces-409534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 081679C8E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE97B33319
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E8819CC02;
	Thu, 14 Nov 2024 15:28:15 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DB1885A0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598094; cv=none; b=YHRMQOKiHMC+shAM19HA6EO+qQgbYlRaGdzpQ5kHIjcPFuAhW+Ri7YBHbWOYKJ1GVzBZwMgIZ+cgwghLBnQnVKj3WbvZBYmkuGhGsMP5ORABvUcvlQr3SODrZPd6PksksiRfmAC27ucFaXDGAYvkO6BPeYuehFVqEL6k8RWyajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598094; c=relaxed/simple;
	bh=1NDcJXAKcGZ1dPpljAd9JktQomawPmUw/nribxH/D24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oufd1wFjU65bab3xiUBibVm6L56Jr+TkmUZHL1VkBE4RqzPRqbG1m8iXIAU3AmNXP75OrHk6N3XetOSVmTFPxiNtxTpRY93OW/Jn2KLc2HzG3qmKyvQOrf3P7yck+Ok1yPkgIFAPPd6jC/9ruRGCrnpy5vlZe1G6od99AAovUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tBbkp-000000008IN-1kfO;
	Thu, 14 Nov 2024 10:27:31 -0500
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	kernel-team@meta.com,
	hpa@zytor.com,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH 1/2] x86,tlb: update mm_cpumask lazily
Date: Thu, 14 Nov 2024 10:26:16 -0500
Message-ID: <20241114152723.1294686-2-riel@surriel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152723.1294686-1-riel@surriel.com>
References: <20241114152723.1294686-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

On busy multi-threaded workloads, there can be significant contention
on the mm_cpumask at context switch time.

Reduce that contention by updating mm_cpumask lazily, setting the CPU bit
at context switch time (if not already set), and clearing the CPU bit at
the first TLB flush sent to a CPU where the process isn't running.

When a flurry of TLB flushes for a process happen, only the first one
will be sent to CPUs where the process isn't running. The others will
be sent to CPUs where the process is currently running.

On an AMD Milan system with 36 cores, there is a noticeable difference:
$ hackbench --groups 20 --loops 10000

Before: ~4.5s +/- 0.1s
After:  ~4.2s +/- 0.1s

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/kernel/alternative.c | 10 +++++++---
 arch/x86/mm/tlb.c             | 19 +++++++++----------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d17518ca19b8..8b66a555d2f0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1825,11 +1825,18 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	return temp_state;
 }
 
+__ro_after_init struct mm_struct *poking_mm;
+__ro_after_init unsigned long poking_addr;
+
 static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 {
 	lockdep_assert_irqs_disabled();
+
 	switch_mm_irqs_off(NULL, prev_state.mm, current);
 
+	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
+	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(poking_mm));
+
 	/*
 	 * Restore the breakpoints if they were disabled before the temporary mm
 	 * was loaded.
@@ -1838,9 +1845,6 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 		hw_breakpoint_restore();
 }
 
-__ro_after_init struct mm_struct *poking_mm;
-__ro_after_init unsigned long poking_addr;
-
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
 	memcpy(dst, src, len);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b0d5a644fc84..cc4e57ae690f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -606,18 +606,15 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		cond_mitigation(tsk);
 
 		/*
-		 * Stop remote flushes for the previous mm.
-		 * Skip kernel threads; we never send init_mm TLB flushing IPIs,
-		 * but the bitmap manipulation can cause cache line contention.
+		 * Leave this CPU in prev's mm_cpumask. Atomic writes to
+		 * mm_cpumask can be expensive under contention. The CPU
+		 * will be removed lazily at TLB flush time.
 		 */
-		if (prev != &init_mm) {
-			VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu,
-						mm_cpumask(prev)));
-			cpumask_clear_cpu(cpu, mm_cpumask(prev));
-		}
+		VM_WARN_ON_ONCE(prev != &init_mm && !cpumask_test_cpu(cpu,
+				mm_cpumask(prev)));
 
 		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
-		if (next != &init_mm)
+		if (next != &init_mm && !cpumask_test_cpu(cpu, mm_cpumask(next)))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
@@ -761,8 +758,10 @@ static void flush_tlb_func(void *info)
 		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
 
 		/* Can only happen on remote CPUs */
-		if (f->mm && f->mm != loaded_mm)
+		if (f->mm && f->mm != loaded_mm) {
+			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
 			return;
+		}
 	}
 
 	if (unlikely(loaded_mm == &init_mm))
-- 
2.45.2


