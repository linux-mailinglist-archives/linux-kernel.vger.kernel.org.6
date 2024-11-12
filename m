Return-Path: <linux-kernel+bounces-404959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944999C4AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5311228251B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53CA1F709A;
	Tue, 12 Nov 2024 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3IMHTsj"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B26AAD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371641; cv=none; b=SH5enkqhdDziQrbHqvPwdu77xKfPESWatm8YKke8ukw7w3orrVJ61F2bcJHQ0+pd8TGuJCY5pZlc7FsPVESTbGpQn5y36VBkITZa2uDMpaRLuJHug+/5Uulx8VYng2rltnQbwfX5aR2+BavQpQ0whMQ0BH45/amqSnQXlXkby9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371641; c=relaxed/simple;
	bh=doRnVM65BJCYlkuDOmvxg8MXcgVyTMB2b7SwBGyaCXs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UY790Ux+SU4o0v8c0SJ8HBPPPrRTdCUOljEhN263gX6PxHWMzvBegMRux1XQZlSh8yUdd8h7pVGeEwfp8zNCnrxdLoOQ+iPXmRaZViUG/xEEPC2aqZ+JSBs0LFtpk97q2aMaqO3fiSrM9vG2J8rUh7EeOnM0wAtpbU3GcSRFCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o3IMHTsj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2904d0cad0so8632767276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731371639; x=1731976439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uPqm/j9GML5grkd0K90HJBJ+6dp+iW/S4dreeHv8WiA=;
        b=o3IMHTsjCMGPNM17Ezo000/+Dj7W0OljpDRmZyc/Np9Xn5v56Qt0YjYzb9vkoO8wA6
         LKYFVwFj0tNXHxJOa93SrhgZ3f+gHBBHaHQv+xSzuC1guyFu2cMPZc4znn7dOD89uyjH
         bdibA/E0qnwdZHFuqbvMsDMO4UHmGeL3gAqSV9yI0sQA1FZCH7undc6KkwpPN5xD2bJ9
         P7WRJFoK1hdeDk51O3TaaqL+YRBTGAtEcf7rtx/OiYnOb4ZjLnod/XZ7dXQaALzevs08
         wSGaIVBX8DYBZNzz5bBcB3xgYI8ObXw3QHhEU1sSTqDOyZTB0Zh461V7K95/Y/HrEfMm
         8qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731371639; x=1731976439;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPqm/j9GML5grkd0K90HJBJ+6dp+iW/S4dreeHv8WiA=;
        b=XyyyQw93E3SFXhO1OJrDTVuTmzOapnlPfrx5b7veLNoujVOAq+UCTuw4Y8Tmpp3mQm
         kaZE6IK1vOafwV/Qq8xwXPVcHKcbn5v4J31Thdw737N2tZD/P+xklP+c47a23jC2FWdv
         beRoQcJIDvL/zj3dguP+EGHeDuJhONll2w33ofeCujqyUtgOa7TRlYyQD98ab+lNrjG6
         NtklLKMtLX1LfrlPEiYmM0U7AuLGTuVctxI4MWf7HnkiL2crttCJV0mhR2srwp7YxKbE
         WO37CI/8emqzLRUk9mFvQOhddVO7Iizvf6rrOFt+6LBrrph6tN+PkAYiVRguz5+KNA5/
         lxLg==
X-Forwarded-Encrypted: i=1; AJvYcCXdlD0NX2+bwqUP4vrZWXpZ3MKhju78YThX1qAKvrdlhZ7CFGCSg+2CzlKH2FnCu8cH3LaVxEOVIzFr4g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQvjzYD9eoOKPG7tf4K2/B9E0HYkDKy4AZI4DxBcAhLcHC/mR
	u1eOix5fir4nnsYpXBl5S84WnN1Tw0DFwcGo1BbiunMg1JgN2McTKC789PVZddvq13JIaGbl6xp
	i30+nTcm0FOiexoPi0KZMqQ==
X-Google-Smtp-Source: AGHT+IF2AUPCYUIW/bjEyF6Bagqvriyp8owPVn//zZAu+iYnJp2HZR2/FMhkCxa9HQYN4qZCYWpxjJqGcHfQ1GzhLg==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:64e3:b06b:ffa7:2d32])
 (user=kaleshsingh job=sendgmr) by 2002:a25:aaaa:0:b0:e30:d61e:b110 with SMTP
 id 3f1490d57ef6-e337f8bfd18mr20453276.5.1731371639080; Mon, 11 Nov 2024
 16:33:59 -0800 (PST)
Date: Mon, 11 Nov 2024 16:32:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112003336.1375584-1-kaleshsingh@google.com>
Subject: [PATCH v2] arm64: kvm: Introduce nvhe stack size constants
From: Kalesh Singh <kaleshsingh@google.com>
To: will@kernel.or, maz@kernel.org, broonie@kernel.org, mark.rutland@arm.com
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Ard Biesheuvel <ardb@kernel.org>, 
	D Scott Phillips <scott@os.amperecomputing.com>, Wang Jinchao <wangjinchao@xfusion.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, 
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>, Randy Dunlap <rdunlap@infradead.org>, 
	"=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?=" <ptosi@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Refactor nvhe stack code to use NVHE_STACK_SIZE/SHIFT constants,
instead of directly using PAGE_SIZE/SHIFT. This makes the code a bit
easier to read, without introducing any functional changes.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Drop Kconfig option for nVHE stack size

 arch/arm64/include/asm/memory.h          |  5 ++++-
 arch/arm64/include/asm/stacktrace/nvhe.h |  2 +-
 arch/arm64/kvm/arm.c                     | 18 +++++++++---------
 arch/arm64/kvm/hyp/nvhe/host.S           |  4 ++--
 arch/arm64/kvm/hyp/nvhe/mm.c             | 12 ++++++------
 arch/arm64/kvm/hyp/nvhe/stacktrace.c     |  4 ++--
 arch/arm64/kvm/mmu.c                     | 12 ++++++------
 arch/arm64/kvm/stacktrace.c              |  6 +++---
 8 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0480c61dbb4f..96f236f0c141 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -145,13 +145,16 @@
 
 #define OVERFLOW_STACK_SIZE	SZ_4K
 
+#define NVHE_STACK_SHIFT       PAGE_SHIFT
+#define NVHE_STACK_SIZE        (UL(1) << NVHE_STACK_SHIFT)
+
 /*
  * With the minimum frame size of [x29, x30], exactly half the combined
  * sizes of the hyp and overflow stacks is the maximum size needed to
  * save the unwinded stacktrace; plus an additional entry to delimit the
  * end.
  */
-#define NVHE_STACKTRACE_SIZE	((OVERFLOW_STACK_SIZE + PAGE_SIZE) / 2 + sizeof(long))
+#define NVHE_STACKTRACE_SIZE	((OVERFLOW_STACK_SIZE + NVHE_STACK_SIZE) / 2 + sizeof(long))
 
 /*
  * Alignment of kernel segments (e.g. .text, .data).
diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index 44759281d0d4..171f9edef49f 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -47,7 +47,7 @@ static inline void kvm_nvhe_unwind_init(struct unwind_state *state,
 
 DECLARE_KVM_NVHE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_stacktrace_info, kvm_stacktrace_info);
-DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stack_base);
 
 void kvm_nvhe_dump_backtrace(unsigned long hyp_offset);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 48cafb65d6ac..d19bffbfcb9e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -61,7 +61,7 @@ static enum kvm_wfx_trap_policy kvm_wfe_trap_policy __read_mostly = KVM_WFX_NOTR
 
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
-DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_base);
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
@@ -2359,7 +2359,7 @@ static void __init teardown_hyp_mode(void)
 
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu) {
-		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+		free_pages(per_cpu(kvm_arm_hyp_stack_base, cpu), NVHE_STACK_SHIFT - PAGE_SHIFT);
 		free_pages(kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu], nvhe_percpu_order());
 
 		if (free_sve) {
@@ -2547,15 +2547,15 @@ static int __init init_hyp_mode(void)
 	 * Allocate stack pages for Hypervisor-mode
 	 */
 	for_each_possible_cpu(cpu) {
-		unsigned long stack_page;
+		unsigned long stack_base;
 
-		stack_page = __get_free_page(GFP_KERNEL);
-		if (!stack_page) {
+		stack_base = __get_free_pages(GFP_KERNEL, NVHE_STACK_SHIFT - PAGE_SHIFT);
+		if (!stack_base) {
 			err = -ENOMEM;
 			goto out_err;
 		}
 
-		per_cpu(kvm_arm_hyp_stack_page, cpu) = stack_page;
+		per_cpu(kvm_arm_hyp_stack_base, cpu) = stack_base;
 	}
 
 	/*
@@ -2624,9 +2624,9 @@ static int __init init_hyp_mode(void)
 	 */
 	for_each_possible_cpu(cpu) {
 		struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
-		char *stack_page = (char *)per_cpu(kvm_arm_hyp_stack_page, cpu);
+		char *stack_base = (char *)per_cpu(kvm_arm_hyp_stack_base, cpu);
 
-		err = create_hyp_stack(__pa(stack_page), &params->stack_hyp_va);
+		err = create_hyp_stack(__pa(stack_base), &params->stack_hyp_va);
 		if (err) {
 			kvm_err("Cannot map hyp stack\n");
 			goto out_err;
@@ -2638,7 +2638,7 @@ static int __init init_hyp_mode(void)
 		 * __hyp_pa() won't do the right thing there, since the stack
 		 * has been mapped in the flexible private VA space.
 		 */
-		params->stack_pa = __pa(stack_page);
+		params->stack_pa = __pa(stack_base);
 	}
 
 	for_each_possible_cpu(cpu) {
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 3d610fc51f4d..58f0cb2298cc 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -188,12 +188,12 @@ SYM_FUNC_END(__host_hvc)
 
 	/*
 	 * Test whether the SP has overflowed, without corrupting a GPR.
-	 * nVHE hypervisor stacks are aligned so that the PAGE_SHIFT bit
+	 * nVHE hypervisor stacks are aligned so that the NVHE_STACK_SHIFT bit
 	 * of SP should always be 1.
 	 */
 	add	sp, sp, x0			// sp' = sp + x0
 	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
-	tbz	x0, #PAGE_SHIFT, .L__hyp_sp_overflow\@
+	tbz	x0, #NVHE_STACK_SHIFT, .L__hyp_sp_overflow\@
 	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
 	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 8850b591d775..f41c7440b34b 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -360,10 +360,10 @@ int pkvm_create_stack(phys_addr_t phys, unsigned long *haddr)
 
 	prev_base = __io_map_base;
 	/*
-	 * Efficient stack verification using the PAGE_SHIFT bit implies
+	 * Efficient stack verification using the NVHE_STACK_SHIFT bit implies
 	 * an alignment of our allocation on the order of the size.
 	 */
-	size = PAGE_SIZE * 2;
+	size = NVHE_STACK_SIZE * 2;
 	addr = ALIGN(__io_map_base, size);
 
 	ret = __pkvm_alloc_private_va_range(addr, size);
@@ -373,12 +373,12 @@ int pkvm_create_stack(phys_addr_t phys, unsigned long *haddr)
 		 * at the higher address and leave the lower guard page
 		 * unbacked.
 		 *
-		 * Any valid stack address now has the PAGE_SHIFT bit as 1
+		 * Any valid stack address now has the NVHE_STACK_SHIFT bit as 1
 		 * and addresses corresponding to the guard page have the
-		 * PAGE_SHIFT bit as 0 - this is used for overflow detection.
+		 * NVHE_STACK_SHIFT bit as 0 - this is used for overflow detection.
 		 */
-		ret = kvm_pgtable_hyp_map(&pkvm_pgtable, addr + PAGE_SIZE,
-					  PAGE_SIZE, phys, PAGE_HYP);
+		ret = kvm_pgtable_hyp_map(&pkvm_pgtable, addr + NVHE_STACK_SIZE,
+					  NVHE_STACK_SIZE, phys, PAGE_HYP);
 		if (ret)
 			__io_map_base = prev_base;
 	}
diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
index ed6b58b19cfa..5b6eeab1a774 100644
--- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
+++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
@@ -28,7 +28,7 @@ static void hyp_prepare_backtrace(unsigned long fp, unsigned long pc)
 	struct kvm_nvhe_stacktrace_info *stacktrace_info = this_cpu_ptr(&kvm_stacktrace_info);
 	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
 
-	stacktrace_info->stack_base = (unsigned long)(params->stack_hyp_va - PAGE_SIZE);
+	stacktrace_info->stack_base = (unsigned long)(params->stack_hyp_va - NVHE_STACK_SIZE);
 	stacktrace_info->overflow_stack_base = (unsigned long)this_cpu_ptr(overflow_stack);
 	stacktrace_info->fp = fp;
 	stacktrace_info->pc = pc;
@@ -54,7 +54,7 @@ static struct stack_info stackinfo_get_hyp(void)
 {
 	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
 	unsigned long high = params->stack_hyp_va;
-	unsigned long low = high - PAGE_SIZE;
+	unsigned long low = high - NVHE_STACK_SIZE;
 
 	return (struct stack_info) {
 		.low = low,
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 0f7658aefa1a..e366ed8650fe 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -704,10 +704,10 @@ int create_hyp_stack(phys_addr_t phys_addr, unsigned long *haddr)
 
 	mutex_lock(&kvm_hyp_pgd_mutex);
 	/*
-	 * Efficient stack verification using the PAGE_SHIFT bit implies
+	 * Efficient stack verification using the NVHE_STACK_SHIFT bit implies
 	 * an alignment of our allocation on the order of the size.
 	 */
-	size = PAGE_SIZE * 2;
+	size = NVHE_STACK_SIZE * 2;
 	base = ALIGN_DOWN(io_map_base - size, size);
 
 	ret = __hyp_alloc_private_va_range(base);
@@ -724,12 +724,12 @@ int create_hyp_stack(phys_addr_t phys_addr, unsigned long *haddr)
 	 * at the higher address and leave the lower guard page
 	 * unbacked.
 	 *
-	 * Any valid stack address now has the PAGE_SHIFT bit as 1
+	 * Any valid stack address now has the NVHE_STACK_SHIFT bit as 1
 	 * and addresses corresponding to the guard page have the
-	 * PAGE_SHIFT bit as 0 - this is used for overflow detection.
+	 * NVHE_STACK_SHIFT bit as 0 - this is used for overflow detection.
 	 */
-	ret = __create_hyp_mappings(base + PAGE_SIZE, PAGE_SIZE, phys_addr,
-				    PAGE_HYP);
+	ret = __create_hyp_mappings(base + NVHE_STACK_SIZE, NVHE_STACK_SIZE,
+				    phys_addr, PAGE_HYP);
 	if (ret)
 		kvm_err("Cannot map hyp stack\n");
 
diff --git a/arch/arm64/kvm/stacktrace.c b/arch/arm64/kvm/stacktrace.c
index 3ace5b75813b..b9744a932920 100644
--- a/arch/arm64/kvm/stacktrace.c
+++ b/arch/arm64/kvm/stacktrace.c
@@ -50,7 +50,7 @@ static struct stack_info stackinfo_get_hyp(void)
 	struct kvm_nvhe_stacktrace_info *stacktrace_info
 				= this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
 	unsigned long low = (unsigned long)stacktrace_info->stack_base;
-	unsigned long high = low + PAGE_SIZE;
+	unsigned long high = low + NVHE_STACK_SIZE;
 
 	return (struct stack_info) {
 		.low = low,
@@ -60,8 +60,8 @@ static struct stack_info stackinfo_get_hyp(void)
 
 static struct stack_info stackinfo_get_hyp_kern_va(void)
 {
-	unsigned long low = (unsigned long)*this_cpu_ptr(&kvm_arm_hyp_stack_page);
-	unsigned long high = low + PAGE_SIZE;
+	unsigned long low = (unsigned long)*this_cpu_ptr(&kvm_arm_hyp_stack_base);
+	unsigned long high = low + NVHE_STACK_SIZE;
 
 	return (struct stack_info) {
 		.low = low,

base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
-- 
2.47.0.277.g8800431eea-goog


