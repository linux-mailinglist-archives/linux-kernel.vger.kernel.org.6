Return-Path: <linux-kernel+bounces-237838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 923FA923ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7111F22111
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C04E1B5815;
	Tue,  2 Jul 2024 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITw5Vyik"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425D1B4C2A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926507; cv=none; b=qVzStiNs40KHf1R33p2xGrHZVeATNvFcoLseqE3XXMXZtx/1JiA9SWom/49M2UrxclA5mF1ISWytLWfMEcoG3vFsW/WoPstI3YxzJAhDk0sR6MOnAQjQc1hJv9+YcaR66FMOdLfoP52bdJSPCtnbCQkzgdBI3hYuKdHLlu3GGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926507; c=relaxed/simple;
	bh=WzLgCcnAxpfAtzGdhmiECVNup9bFZxesCcTltcURVhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cfnpclh0xp5M0Sn8TEtCdmu/FG39RkIkWYMF5JNCVZUu8Za5Uw1MonI/dYu9czbeNZ9+XIcxPWwUNSDU9lEGRLDkfB4B7TPT0RmXQEUgqlzzqTNx2oWl6vaHPezefpvDMX2i9M/zeGRrWeepyKjToN5//VW4iAxQIYvphWIKkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITw5Vyik; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650f766a1c6so27477b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719926505; x=1720531305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1dVnzezxakkrWVDD24n/jxIBS1JtulZK9cr/kIqgsY=;
        b=ITw5VyikG4zvXRhP8UNTVWNYzi5s2Bq+mAVgygqs1A3srgP35jZmUD8OAqo9AEUXa9
         CvFZYYtqauxu8/tJHL+6eMqnXgJ1/pUWEY6Embyd1jRJArhlv7+OlEjmobN9jzA+pZ58
         y3OczPXZ79ptucOviX5jTswUtbnVNfAW2YQSspWvYl8jAxxCUPym3vt1MWF/4dq0pRxd
         83o0h0JaHLeLq44udkV7ktpyFtGHvuBsI68mM4V6nGuihP/1YgG+kAZwA6BR+juZd6YI
         zWTmzL1EiZYvw+ru0hOobIRqUPhIG7dpySvJ/PAjdNm+/YWngLTevBZX68/g/0oZOrkK
         wLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719926505; x=1720531305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1dVnzezxakkrWVDD24n/jxIBS1JtulZK9cr/kIqgsY=;
        b=kvOONOQm1FlS7zzxshIBXiAVVoFk/hU1yAPL3opu4Qra5Lz4+MgzQewL/6SA02BV1W
         73b2lcy4q37lZyZL83vc2z5JtUcYLHCMALyt26FoV2vmuQWwVo5b5NGq1S5483rsCe2f
         pfo8AceIx6jW1XD4/Prjan6z2Qie8qn4ygFDwR3VGBW8K7ELDlKpFMrfRVeaWHoizCVh
         ZhnqM/1kA7VUnRF/JBRvoLFf+oba1VciZ4atkF9C9R9+wDVVuL4GHfpffnbMtacLsi9H
         hI7eTBauZSd+/uxIQpXNegdld5ETYwVkSQkCoPuivsjT2nopgoXzm81LdJ91h+VFPnxg
         Jfqw==
X-Forwarded-Encrypted: i=1; AJvYcCWjRKueoGTLqG6JtRw3XWyHtedsgXgZ/nCoUdZx+P9qeQOd0IpFUf/byb+pXON7vJltKevGIBdEBmmFPP18FP9WzKvKAXUJ+pcGx4Qp
X-Gm-Message-State: AOJu0Yzjz99ZMVlGnR4gi1TZ5+stq+01uKM4u7FDhw7MiJbG+NqbB0kX
	u0uO+6eGZI5b+Kaz7MS9s7QygJlu1/acRaI94JZv+8M8IoFnSagR7eyjjlbQ3TfbGEGpdOvF6Mu
	aozmGATsjkFeW3zm70A==
X-Google-Smtp-Source: AGHT+IHghuJQ8nulRpb2JfS2RyKKlSW+eKRndDAd54bTQK3f3q6ozzQyqfLRhWOFhsZ+LsF1X/jGe3dnEw1HTZPM
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:e885:0:b0:61c:89a4:dd5f with SMTP
 id 00721157ae682-64c72b5434amr740227b3.0.1719926504753; Tue, 02 Jul 2024
 06:21:44 -0700 (PDT)
Date: Tue,  2 Jul 2024 13:21:37 +0000
In-Reply-To: <20240702132139.3332013-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702132139.3332013-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702132139.3332013-2-yosryahmed@google.com>
Subject: [RESEND PATCH v3 1/3] x86/mm: Use IPIs to synchronize LAM enablement
From: Yosry Ahmed <yosryahmed@google.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

LAM can only be enabled when a process is single-threaded.  But _kernel_
threads can temporarily use a single-threaded process's mm.

If LAM is enabled by a userspace process while a kthread is using its
mm, the kthread will not observe LAM enablement (i.e.  LAM will be
disabled in CR3). This could be fine for the kthread itself, as LAM only
affects userspace addresses. However, if the kthread context switches to
a thread in the same userspace process, CR3 may or may not be updated
because the mm_struct doesn't change (based on pending TLB flushes). If
CR3 is not updated, the userspace thread will run incorrectly with LAM
disabled, which may cause page faults when using tagged addresses.
Example scenario:

CPU 1                                   CPU 2
/* kthread */
kthread_use_mm()
                                        /* user thread */
                                        prctl_enable_tagged_addr()
                                        /* LAM enabled on CPU 2 */
/* LAM disabled on CPU 1 */
                                        context_switch() /* to CPU 1 */
/* Switching to user thread */
switch_mm_irqs_off()
/* CR3 not updated */
/* LAM is still disabled on CPU 1 */

Synchronize LAM enablement by sending an IPI from
prctl_enable_tagged_addr() to all CPUs running with the mm_struct to
enable LAM. This makes sure LAM is enabled on CPU 1 in the above
scenario before prctl_enable_tagged_addr() returns and userspace starts
using tagged addresses, and before it's possible to run the userspace
process on CPU 1.

In switch_mm_irqs_off(), move reading the LAM mask until after
mm_cpumask() is updated. This ensures that if an outdated LAM mask is
written to CR3, an IPI is received to update it right after IRQs are
re-enabled.

Fixes: 82721d8b25d7 ("x86/mm: Handle LAM on context switch")
Suggested-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Change-Id: I7fd573a9db5fe5284d69bc46f9b3758f1f9fb467
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/kernel/process_64.c | 13 +++++++++++--
 arch/x86/mm/tlb.c            |  7 +++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6d3d20e3e43a9..e1ce0dfd24258 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -798,6 +798,16 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 
 #define LAM_U57_BITS 6
 
+static void enable_lam_func(void *__mm)
+{
+	struct mm_struct *mm = __mm;
+
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm) {
+		write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
+		set_tlbstate_lam_mode(mm);
+	}
+}
+
 static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_LAM))
@@ -830,8 +840,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		return -EINVAL;
 	}
 
-	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
-	set_tlbstate_lam_mode(mm);
+	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
 	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
 
 	mmap_write_unlock(mm);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047c..a041d2ecd8380 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -503,9 +503,9 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 {
 	struct mm_struct *prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	unsigned long new_lam = mm_lam_cr3_mask(next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
+	unsigned long new_lam;
 	u64 next_tlb_gen;
 	bool need_flush;
 	u16 new_asid;
@@ -619,9 +619,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 			cpumask_clear_cpu(cpu, mm_cpumask(prev));
 		}
 
-		/*
-		 * Start remote flushes and then read tlb_gen.
-		 */
+		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
 		if (next != &init_mm)
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
@@ -633,6 +631,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		barrier();
 	}
 
+	new_lam = mm_lam_cr3_mask(next);
 	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
-- 
2.45.2.803.g4e1b14247a-goog


