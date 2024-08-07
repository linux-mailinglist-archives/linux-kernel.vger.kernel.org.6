Return-Path: <linux-kernel+bounces-277338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98817949F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B5F1F25917
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3EB198E9B;
	Wed,  7 Aug 2024 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CH7ZK5O4"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781321917F8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009843; cv=none; b=n+/0Jlb2ASmN2WoY3M5+QG52tLDExPxkK4U1wYwcUQvgUrjf7xKXOM3oTPMun9qB4n/NDYfezviAF/dgK063X0SwoS4Fsl4DjpfepWSJJliO8TY14rF5XC1upc9WHpod/8zslm7U0UakZyddR7wOhl3r8f2AbwDo9z2NaS7Btag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009843; c=relaxed/simple;
	bh=tlCvRoYaLMPU5gQj378kknU4aYbegHbHq8Y8IuOxgj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFAfJzuqTBL0B8DjItBFg1QH+6R96RVTBBW8nJ2fxm0OEptV5QdIFjuf38+v0y5l6E669ByN0A38mOtbhX6TMVJnN3DXAQVkfj8T+E4CFrnDJTJkQS3hgLUnQL44RhsZzHEvI6uHBasPClzh0W0/MnTHhRDsdaAddITJm8TruqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CH7ZK5O4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4775lNip682395
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 6 Aug 2024 22:47:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4775lNip682395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723009649;
	bh=PpuvlTdRkxoiU3regBqhao5DL93njt/uaEV2ZJVl618=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CH7ZK5O45KBmjBvXg76Qa5tZy0CVVosDNGNiWc1dkkrywPJl+JmlWvnLivv5uPNzV
	 cRC+nP3zZ6Nl0j2Wa6pUvLQv/GOI7ABhHI+YPV7eq97V2LrBGXgFwhd/H0D+n6DtRQ
	 lT8Eiur3jkQiTHgPAkftQ3JsihJ/jxLNfRhJtGv8KweueRs3hEyKRT/LAMeD5ZmBj+
	 RIZuzX4ok03Lu4pPnpxx+TRcsp9aNnwqr9j90ZEi+E6gakr5yKTZU7iKSps0O4c5Eu
	 lVHhgFkzibr2XfnL5i5Y9XrWDkhT8ap0gHJ0Zncjc1HRQmGJ3AsDeJR2wY7+Wu+Toc
	 MYl9au81vpvow==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com, seanjc@google.com
Subject: [PATCH v1 3/3] x86/entry: Set FRED RSP0 on return to userspace instead of context switch
Date: Tue,  6 Aug 2024 22:47:22 -0700
Message-ID: <20240807054722.682375-4-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807054722.682375-1-xin@zytor.com>
References: <20240807054722.682375-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FRED RSP0 is a per task constant pointing to top of its kernel stack
for user level event delivery, and needs to be updated when a task is
scheduled in.

Introduce a new TI flag TIF_LOAD_USER_STATES to track whether FRED RSP0
needs to be loaded, and do the actual load of FRED RSP0 in
arch_exit_to_user_mode_prepare() if the TI flag is set, thus to avoid a
fair number of WRMSRs in both KVM and the kernel.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/entry-common.h | 5 +++++
 arch/x86/include/asm/switch_to.h    | 3 +--
 arch/x86/include/asm/thread_info.h  | 2 ++
 arch/x86/kernel/cpu/cpuid-deps.c    | 1 -
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 4c78b99060b5..ae365579efb3 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -51,6 +51,11 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 		if (ti_work & _TIF_USER_RETURN_NOTIFY)
 			fire_user_return_notifiers();
 
+		if (cpu_feature_enabled(X86_FEATURE_FRED) &&
+		    (ti_work & _TIF_LOAD_USER_STATES))
+			wrmsrns(MSR_IA32_FRED_RSP0,
+				(unsigned long)task_stack_page(current) + THREAD_SIZE);
+
 		if (unlikely(ti_work & _TIF_IO_BITMAP))
 			tss_update_io_bitmap();
 
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index c3bd0c0758c9..a31ea544cc0e 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -71,8 +71,7 @@ static inline void update_task_stack(struct task_struct *task)
 	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
 	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
-		/* WRMSRNS is a baseline feature for FRED. */
-		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_SIZE);
+		set_thread_flag(TIF_LOAD_USER_STATES);
 	} else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		/* Xen PV enters the kernel on the thread stack. */
 		load_sp0(task_top_of_stack(task));
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 12da7dfd5ef1..fb51904651c0 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -106,6 +106,7 @@ struct thread_info {
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
+#define TIF_LOAD_USER_STATES	30	/* Load user level states */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -128,6 +129,7 @@ struct thread_info {
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
+#define _TIF_LOAD_USER_STATES	(1 << TIF_LOAD_USER_STATES)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index b7d9f530ae16..8bd84114c2d9 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -83,7 +83,6 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
-	{ X86_FEATURE_FRED,			X86_FEATURE_WRMSRNS   },
 	{}
 };
 
-- 
2.45.2


