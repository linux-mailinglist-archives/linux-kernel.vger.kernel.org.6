Return-Path: <linux-kernel+bounces-237839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1177D923ED3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA931289466
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315AB1B4C57;
	Tue,  2 Jul 2024 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+dBPaNU"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BB1B4C2C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926509; cv=none; b=fHDBbOmyYeZBkc0cFnt7bu0mpRGNJj96PjR3WZ+8PrOsVokX1Cl81HYM2/e2JFxSb/criTOA0JMb5j4yYvo227p8DYS+iinmpS/pJxzYhbw5z1QAmO/L9BPoKC31n4LJeC6LHbkU2v0qF9QcPG+HZfAETcSX4wyGWz4DY5Z5RN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926509; c=relaxed/simple;
	bh=tk4WKbO6h8a4oDzEThPsuauluvuu3TUS4YXU1QXrtpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E9xtZOVsANDFS8CJWTeyzXKJGjqaUBx9ZoLYVCkAu6iDlUks+pETQ95ftx8CnpBKoHdUFx+oK/xuhtoYCYP7EiDHBCUraOHl3HMzBUHIAnIHfckuTICGyz4xdrtyVdIiMp+Oh/qxpZfM7NTqqTzcoEQ2XXj+HdDVcl9tOsrJFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+dBPaNU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64f4b849b7cso23901537b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719926506; x=1720531306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3p0qtnzDEL/NiIySpMNGGFo+d5LOoZGd/e3zeHTmMTw=;
        b=K+dBPaNUKWGrq7E1Wi60CUTljX4YvzxHQKXoMMSdlYJMfWI2gUzQMhz7/sEMYeT9Wz
         mzUE6QCx0N8s7QOTh4XbzzPHaK4biP5PSXMVaYoka7li8ODjwyAALBORp9dxOmG6tBGn
         4sAKhDWxdhnP9dDE16eU7gb4lGYcOZ6skrp2M++jWgmB92llY0xd1F9zkh3r4MicIQEc
         19KotmbEnVPVLmB8Fa5O8oMam5rNDhKbYxPas9UBe3YzuQr1E+bVKFVXmQJW8uDEjUNN
         o6e9wH2TaguYxUpnxW4kRTZUkNGuexLVYAfYOeBj5i7miQoIv0th4nNfmX3a0wvi57sR
         a2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719926506; x=1720531306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3p0qtnzDEL/NiIySpMNGGFo+d5LOoZGd/e3zeHTmMTw=;
        b=UhWi658tgOYzTCmWXGpl2Tc4mw+KZJ+N29PubD6wkjdXEx04FEm7zwBpKyeU5l5h2b
         B7sVUC+jBJxESiMx0iuD8/xVhOcoheXVMM7+4r29kvp06UcH2IsrBlHaK1/Cfr0sZeKU
         wp9aEfm3YFHQlwWt3jb9PFNGra6kHbYZ14/J7EgItHqobva7LXlrVGQjs0UF1TwbsuC9
         9c1Wh2BcM4Y/Whwt8l/GE9oqm6Ug7yZ1/WH5wKIoMyZ2KVQUzmANCzgWYVU1d5wJ1fgc
         5vPQyasikkBscg4PG6Y3CUw0UZLr7hSTunL8/MY0lISCLGn1AyFtyGCLJScNMZy439O3
         8xbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSo8B45b2WZ2OKTq06fsWy31/KAId97vl5P2/ePYBDF0/QbGZydCrpOwiZ1RpYU8VSDZWMKRdxqW3wOwLtc5vNOme09APGeZjdKxho
X-Gm-Message-State: AOJu0YwmHSdCTFsT/1QEQ4sPf7OnYc6QMAIXWwIifPKhx6pr6snr+Zb8
	vLrIbmV+RdXsWAlM5F8lPSnH299oH4heW2BVMgv10KuJMGDEWSrA52APq9W01Jqa5rWyVIYgwgk
	/SLS7TqDPecwngFk9/A==
X-Google-Smtp-Source: AGHT+IE5yOxXHFsN9w/WFqj9GD2Jlu4F+FUycVLVxC5570M2iHpzwIws1dqPsB11Seccelx0/1egw1GKNVlINZNd
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:e644:0:b0:62c:f623:3a4e with SMTP
 id 00721157ae682-64c6e5c126dmr289017b3.0.1719926506628; Tue, 02 Jul 2024
 06:21:46 -0700 (PDT)
Date: Tue,  2 Jul 2024 13:21:38 +0000
In-Reply-To: <20240702132139.3332013-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702132139.3332013-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702132139.3332013-3-yosryahmed@google.com>
Subject: [RESEND PATCH v3 2/3] x86/mm: Fix LAM inconsistency during context switch
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
threads can temporarily use a single-threaded process's mm.  That means
that a context-switching kernel thread can race and observe the mm's LAM
metadata (mm->context.lam_cr3_mask) change.

The context switch code does two logical things with that metadata:
populate CR3 and populate 'cpu_tlbstate.lam'.  If it hits this race,
'cpu_tlbstate.lam' and CR3 can end up out of sync.

This de-synchronization is currently harmless.  But it is confusing and
might lead to warnings or real bugs.

Update set_tlbstate_lam_mode() to take in the LAM mask and untag mask
instead of an mm_struct pointer, and while we are at it, rename it to
cpu_tlbstate_update_lam(). This should also make it clearer that we are
updating cpu_tlbstate. In switch_mm_irqs_off(), read the LAM mask once
and use it for both the cpu_tlbstate update and the CR3 update.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Change-Id: I8bcf94bbf28ebdbbe75e3939e712246a029f84b6
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/include/asm/mmu_context.h | 8 +++++++-
 arch/x86/include/asm/tlbflush.h    | 9 ++++-----
 arch/x86/kernel/process_64.c       | 6 ++++--
 arch/x86/mm/tlb.c                  | 8 +++++---
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 8dac45a2c7fcf..19091ebb86338 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -88,7 +88,13 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 #ifdef CONFIG_ADDRESS_MASKING
 static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
 {
-	return mm->context.lam_cr3_mask;
+	/*
+	 * When switch_mm_irqs_off() is called for a kthread, it may race with
+	 * LAM enablement. switch_mm_irqs_off() uses the LAM mask to do two
+	 * things: populate CR3 and populate 'cpu_tlbstate.lam'. Make sure it
+	 * reads a single value for both.
+	 */
+	return READ_ONCE(mm->context.lam_cr3_mask);
 }
 
 static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 25726893c6f4d..69e79fff41b80 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -399,11 +399,10 @@ static inline  u64 tlbstate_lam_cr3_mask(void)
 	return lam << X86_CR3_LAM_U57_BIT;
 }
 
-static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
 {
-	this_cpu_write(cpu_tlbstate.lam,
-		       mm->context.lam_cr3_mask >> X86_CR3_LAM_U57_BIT);
-	this_cpu_write(tlbstate_untag_mask, mm->context.untag_mask);
+	this_cpu_write(cpu_tlbstate.lam, lam >> X86_CR3_LAM_U57_BIT);
+	this_cpu_write(tlbstate_untag_mask, untag_mask);
 }
 
 #else
@@ -413,7 +412,7 @@ static inline u64 tlbstate_lam_cr3_mask(void)
 	return 0;
 }
 
-static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
 {
 }
 #endif
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e1ce0dfd24258..26a853328f2d4 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -801,10 +801,12 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 static void enable_lam_func(void *__mm)
 {
 	struct mm_struct *mm = __mm;
+	unsigned long lam;
 
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm) {
-		write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
-		set_tlbstate_lam_mode(mm);
+		lam = mm_lam_cr3_mask(mm);
+		write_cr3(__read_cr3() | lam);
+		cpu_tlbstate_update_lam(lam, mm_untag_mask(mm));
 	}
 }
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index a041d2ecd8380..1fe9ba33c5805 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -11,6 +11,7 @@
 #include <linux/sched/smt.h>
 #include <linux/task_work.h>
 #include <linux/mmu_notifier.h>
+#include <linux/mmu_context.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -632,7 +633,6 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	}
 
 	new_lam = mm_lam_cr3_mask(next);
-	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
@@ -651,6 +651,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 
 	this_cpu_write(cpu_tlbstate.loaded_mm, next);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
+	cpu_tlbstate_update_lam(new_lam, mm_untag_mask(next));
 
 	if (next != prev) {
 		cr4_update_pce_mm(next);
@@ -697,6 +698,7 @@ void initialize_tlbstate_and_flush(void)
 	int i;
 	struct mm_struct *mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u64 tlb_gen = atomic64_read(&init_mm.context.tlb_gen);
+	unsigned long lam = mm_lam_cr3_mask(mm);
 	unsigned long cr3 = __read_cr3();
 
 	/* Assert that CR3 already references the right mm. */
@@ -704,7 +706,7 @@ void initialize_tlbstate_and_flush(void)
 
 	/* LAM expected to be disabled */
 	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
-	WARN_ON(mm_lam_cr3_mask(mm));
+	WARN_ON(lam);
 
 	/*
 	 * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initialization
@@ -723,7 +725,7 @@ void initialize_tlbstate_and_flush(void)
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
-	set_tlbstate_lam_mode(mm);
+	cpu_tlbstate_update_lam(lam, mm_untag_mask(mm));
 
 	for (i = 1; i < TLB_NR_DYN_ASIDS; i++)
 		this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
-- 
2.45.2.803.g4e1b14247a-goog


