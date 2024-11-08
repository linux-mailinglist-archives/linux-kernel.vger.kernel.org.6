Return-Path: <linux-kernel+bounces-402386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3D9C26F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1607B22663
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D7A1D1502;
	Fri,  8 Nov 2024 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQNMLimT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567E194082
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731100539; cv=none; b=RIfmUD99S6qQXz2bcLM0C/vL6u+yno0A8LoHBY2expCLNkkLC2qo/BqVcivUlfqQwZ0hlfk4GDoGx2y9qj1Z2eop0+YXjKK6ffu3HRvwB3M/MntjuxkwRxQvbIhPns2XUikmn6afzLipHNHmc+LMztVxqDaCDTMFsEzKw2luIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731100539; c=relaxed/simple;
	bh=3mnwDE8EcYDJohsTNnQuX49X1JYTz6SUGnbFTkORf0o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oTojfsw/3XNV0Q7ITfDWVgl8MlR6vc6CNhrruWTVGRKKaARH+/mLGs4/RYryg51Hsn9a8xn98HQa8Wgvhfw9CdFyQPLnmXwq5y98Hmi2h7exMJsalIC1l/CCbNMP7R7dpBDoVbNUXoeOCw8g/S7zMJLTgAGbDlQD1uQ2mZfDQtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQNMLimT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8d6fb2ffso50131577b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 13:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731100536; x=1731705336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xj9B9RMnkmM/PP2fh4BdeD15ANP1xy3HAxUiNCCHfSo=;
        b=DQNMLimTYqCLqEvf14/Riynhyt5gEQ/XB5N8aDWC6R8U9A5oBmTT7ggMNvq00YQ8Oa
         Uup4SG7avuAMQ8V1nfAD6FzpAFbUUQOEsWE6ual1cd3wBFGT+qdcDHZpZPdKBOO26SCg
         5UINL32FsxM+taRpDy8etizMPErZ1Q0fAwWCJn5Y5Mn5n2olJdK4NinrZnjpXjoQjASx
         mqYtbE6pXEwEUEXY2qecet7yDZsWUqFFbe0tyxgJCWFCVWVEzxz8qW7IFBq+a6d7BHIm
         xHrPLSrffwfz/E2y27D+yio7KEtYyBgKHTDt4S5aoAJNGE1nTGth4G1qoq6Ihi8w8n0D
         XROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731100536; x=1731705336;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xj9B9RMnkmM/PP2fh4BdeD15ANP1xy3HAxUiNCCHfSo=;
        b=ZVEvj1KjeW3EpU9+qjTH8cE+7cgrH7PCd2yCVZCBMKbKUS5nb4CTVIVt06Q5APpm0k
         mndfE/UVfXrf0HuHxY5ByJPtG6drlTU8YGZFLfkUMurVFxaOO6JOKtYN7Ie00h1s4XpU
         /DYdd0dqPH1hmcrM1TimcN//HT6tXWjsdliRA/x+gt3krC64h9+4anBcZJXxI3kuVsw5
         XXmzG+Nhrd7Q4B1PCuOzX7kINhdENZk69EurgyX/ypH7bsnaApkeC/AxXo/tFk55CXBf
         toJXjsGOngrb6FMvABTzjI1ds1lUpSG6AbmbWj94mEbdUBSNN3546WEYdldVStmsWrld
         UkLA==
X-Forwarded-Encrypted: i=1; AJvYcCWy2YI2OcW7qC128KHx/AiCJLKJpHpsJshy+w+VcOnT35iq64tjQ9RTU4HunaLJQ/cUpHAtA529mOiD2iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf6fBHH0L9qb8XYVLtra8dX+g1CrHn1/tZ8ayPjicPzttt/5nk
	tn+MKvtF6mJ7bn3Bm5CtOvOvSVQ63vrAWH6oSk1kChnT0o3ZhVXqH+KGqAqMksl+xP7QxHLjmqX
	CTnM+tstm9wPb0K6iRcn1nA==
X-Google-Smtp-Source: AGHT+IEsHFWnlCL6mSsTKptJZufFOreEVWGFRJq416Pbau44wC4RVCznab2s8sBpPto1P5Y2xzKAJABWpyJ20H2TbA==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:bf60:92db:a254:85c0])
 (user=kaleshsingh job=sendgmr) by 2002:a05:690c:7307:b0:6ea:3c62:17c1 with
 SMTP id 00721157ae682-6eaddd75f83mr406757b3.1.1731100536154; Fri, 08 Nov 2024
 13:15:36 -0800 (PST)
Date: Fri,  8 Nov 2024 13:14:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108211446.3304809-1-kaleshsingh@google.com>
Subject: [PATCH] arm64: kvm: Make nvhe stack size configurable
From: Kalesh Singh <kaleshsingh@google.com>
To: will@kernel.org, qperret@google.com, maz@kernel.org, broonie@kernel.org, 
	mark.rutland@arm.com
Cc: keir@google.com, vdonnefort@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Ard Biesheuvel <ardb@kernel.org>, 
	D Scott Phillips <scott@os.amperecomputing.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Wang Jinchao <wangjinchao@xfusion.com>, 
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>, 
	"=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?=" <ptosi@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

In order to make the nVHE stack size easily configurable,
introduce NVHE_STACK_SHIFT which must be >= PAGE_SHIFT.

The default stack size remains 1 page (no functional change)

Downstream vendor features which require a larger stack
can configure it by setting CONFIG_NVHE_STACK_SHIFT.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/memory.h          |  5 ++++-
 arch/arm64/include/asm/stacktrace/nvhe.h |  2 +-
 arch/arm64/kvm/Kconfig                   | 14 ++++++++++++++
 arch/arm64/kvm/arm.c                     | 18 +++++++++---------
 arch/arm64/kvm/hyp/nvhe/host.S           |  4 ++--
 arch/arm64/kvm/hyp/nvhe/mm.c             | 12 ++++++------
 arch/arm64/kvm/hyp/nvhe/stacktrace.c     |  4 ++--
 arch/arm64/kvm/mmu.c                     | 12 ++++++------
 arch/arm64/kvm/stacktrace.c              |  6 +++---
 9 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0480c61dbb4f..55e592351749 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -145,13 +145,16 @@
 
 #define OVERFLOW_STACK_SIZE	SZ_4K
 
+#define NVHE_STACK_SHIFT       CONFIG_NVHE_STACK_SHIFT
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
 
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index ead632ad01b4..7aaf0951086c 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -66,6 +66,20 @@ config PROTECTED_NVHE_STACKTRACE
 
 	  If unsure, or not using protected nVHE (pKVM), say N.
 
+config NVHE_STACK_SHIFT
+	int "Size of the nVHE stack as a power of 2"
+	depends on KVM
+	range 12 13 if ARM64_4K_PAGES
+	default "12" if ARM64_4K_PAGES
+	range 14 15 if ARM64_16K_PAGES
+	default "14" if ARM64_16K_PAGES
+	range 16 17 if ARM64_64K_PAGES
+	default "16" if ARM64_64K_PAGES
+	help
+	  This option specifies the size of the KVM nVHE stack (for both
+	  conventional nVHE and pKVM modes) as a power of 2 -- which must
+	  be at least as large as PAGE_SIZE.
+
 config PTDUMP_STAGE2_DEBUGFS
 	bool "Present the stage-2 pagetables to debugfs"
 	depends on KVM
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
-- 
2.47.0.277.g8800431eea-goog


