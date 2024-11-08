Return-Path: <linux-kernel+bounces-402281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035849C25CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5241C235EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62D71F5833;
	Fri,  8 Nov 2024 19:44:13 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F21EF0BD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095053; cv=none; b=L1dYLkTXJkjdX/mNR+6lHSG1Vdmbuifr25rK8r5TkF8wFI3j8uiPA9HvAAGI2VGAp4UbsKYPbLwI+pyGuMhABjmSa7nPy0LXXNF3puhB3a14Cj+4koqB64CpWm5ogz7MH0kYbLGITEgWmzuQADvzrw4wMNWqYeWTCG0NPfH8cCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095053; c=relaxed/simple;
	bh=+sMzLdMwye1g6ZLFLoBgXPEEWjwm3iA5oio4pJ6/aaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Jw3P2r+cWoFzSns1NZDaMnGvVoibZZIyYuJOsJ4JuwH2oJ4xNY1dP+msAvur1QZ26QM5ugGBvE0XLhIxEBVwATzt2DpoGRJxqkVW2O9jq2BWTy43ovpAFZNYtZ/VRNx8oVo4b1qL9G19eD3C8zexI4EcXX2+P9SZYdjYJGOiqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1t9Uhy-000000001zj-0q1Y;
	Fri, 08 Nov 2024 14:31:50 -0500
Date: Fri, 8 Nov 2024 14:31:44 -0500
From: Rik van Riel <riel@surriel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: [PATCH] x86,tlb: update mm_cpumask lazily
Message-ID: <20241108143144.2f15fe35@imladris.surriel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
 arch/x86/mm/tlb.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 86593d1b787d..f19f6378cabf 100644
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


