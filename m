Return-Path: <linux-kernel+bounces-402554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041F69C28F7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC646281F90
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726418C0B;
	Sat,  9 Nov 2024 00:40:49 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7628256D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112849; cv=none; b=WzSL7kzoTU0RCV0rohlaITGtaGb6AIu3TlvUWatBl6dUiEwlCX1Hc0G8mRLwPWc5FiaLsOgWy0kpuP4UnF6wzbvtob+ExBK0M7aB08jm4JDGooxbOcgbOz8zr7o+7rcBLz/5M0EFgj5phqKWqmSV3TxtJ787rBHU/iqfzzxBmp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112849; c=relaxed/simple;
	bh=+sMzLdMwye1g6ZLFLoBgXPEEWjwm3iA5oio4pJ6/aaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3Z9Da2U7Wr5a/xCP3OjOj+34HmfxgcibMZEekQvhAFMQ6w+pTDQYjyc2dxxXb5gbfVPcpMc83cVvF2tkTSbKjpqDFm6coYf73NPOx3K510hhTrTrZvAHmCQiugeLHLMPwMzK8pkDtt7p6MtvqeoziAkEq6GiJ+Z1/IPEe1KZyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1t9ZTn-000000004fJ-3Z78;
	Fri, 08 Nov 2024 19:37:31 -0500
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
Subject: [PATCH 1/3] x86,tlb: update mm_cpumask lazily
Date: Fri,  8 Nov 2024 19:27:48 -0500
Message-ID: <20241109003727.3958374-2-riel@surriel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241109003727.3958374-1-riel@surriel.com>
References: <20241109003727.3958374-1-riel@surriel.com>
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


