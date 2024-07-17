Return-Path: <linux-kernel+bounces-254706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA8C93369A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF911F22152
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A3E125AC;
	Wed, 17 Jul 2024 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nBMYIPwp"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0A171A5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196281; cv=none; b=X27r8TbJFlazPKFih903d97ASqT6N1fSWq+j9K/iDtdhWqL1sJz49BHQyQdKAIgIvQenqLBg66nu8Fr4f0R5eB628ZSQLTGHwWyhwZC/Jt7nH6Nrb80H8tKALB4FSimefEYn2TvohgYCUvAezK7XF2NGYOrVcsOVQhwEKbT9o/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196281; c=relaxed/simple;
	bh=7bTxG5imj5sFfK+xP870BFlpbNNJHAopLGEAnTGTUvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qPt5WqqoimOFA2+qgjZoTXkLKZJ3XLYX26bIrJU6EUT3d+jiVHu/cZGh0RxaD+iYU36CGMIczAiB3AC7kmYaNmCJE+24mmhsYjMeB2oBLyxmsUCmAMaevodb3ZsKqhnphi0RgzyZRSbQOVamKwDAQsxqi+1RZTvqL8lFJBH06E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nBMYIPwp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4265b7514fcso2109935e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721196277; x=1721801077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dbUbbFULfsrE+nsrlyCzBk7XNc7NNIs5oq3jJIx/UQ=;
        b=nBMYIPwp6wdb0e0Gh/je9vO0yByYX6eEblqmYIr32z8Nrlf+BJE0tzbARHl+m+oACt
         X475oius8lmdBu8FVG5QGLp4h3HCY8wdyKBF1zauwiZSAGscezkS5Ph9TLlVyPkjthQy
         kyZwcJ3HKgtDHPNN3wGaE97IaE3u3OuV8QuSGtJOFWxgM4XCzwoL293/RnQAvJZhmqS+
         f2E3eJqV0MVw/gIiCL2EouwZCCNgiBossIkXTnyslDyF+4jLTiePZlmMn4iu9y1PTAtL
         UXB4yoT7KF4VfkBTdTVBlKthOKUe20dt1tNdg8SOxsxLEUS++qF1q7XuZhVeZLr8Sceh
         71lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721196277; x=1721801077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dbUbbFULfsrE+nsrlyCzBk7XNc7NNIs5oq3jJIx/UQ=;
        b=jxHW5G2Qz7ObkUeba9tGDB2jSrbaYymRPImjRiCGqdDBt0loUn1nDOEawLuToJMqxn
         sVMwxBKuipQ50XP7glXb+fO4qJlQ9dHDcr0Iq+gwaL7xdwRvhLUox045KzhBpO45W27p
         tGNn1yftM4nOJj/NflrwXKgf1c+xqPhyJ8FddnZ6ZRVJqYbwaJ9MsR/LEfWnQb7GrjS5
         oI1t2ZDtqOqmwTqnPjGN83wRy3V5/So5qyOYNpOvBlz40iF6U/yn1h78YW/f3vDQ0ACc
         b2K37qufiKugmsrgd23gF+KNj8EmeyfDkZ+7OwL7SynsskiBvOIwbmKcqHTgOjf4EDyQ
         YG1w==
X-Forwarded-Encrypted: i=1; AJvYcCWlRfLS1BPxDAYHbkNpiSQ1GBHua674i0aO37oA2403E6m+uuQV7cUO2DfwLb5cK5Q3TPyXg9cH5eMbMcnYYpB2Zdi2jOMaALhTD0OV
X-Gm-Message-State: AOJu0YzVxJYxHew/BhcR8RycfYQmuHJnRLTNzdh7prj/yslcjJtyHM+C
	S+YJmhHY0zwClFik6NhPV1M6uTH0kEn81T6b/6dGevSVE9HUp6xPKReHyblgeeM=
X-Google-Smtp-Source: AGHT+IGgTBw59SAll6q8f849Ql4AF2T90E5dzsLW36EmpJYdcpnIk4GBd2+w+Nbh6vr0y5veXIlAlA==
X-Received: by 2002:adf:f206:0:b0:360:8c88:ab82 with SMTP id ffacd0b85a97d-36831694075mr404751f8f.30.1721196277153;
        Tue, 16 Jul 2024 23:04:37 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf195sm10708915f8f.42.2024.07.16.23.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:04:36 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Matt Evans <mev@rivosinc.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 3/4] riscv: Stop emitting preventive sfence.vma for new vmalloc mappings
Date: Wed, 17 Jul 2024 08:01:24 +0200
Message-Id: <20240717060125.139416-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717060125.139416-1-alexghiti@rivosinc.com>
References: <20240717060125.139416-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 6.5, we removed the vmalloc fault path because that can't work (see
[1] [2]). Then in order to make sure that new page table entries were
seen by the page table walker, we had to preventively emit a sfence.vma
on all harts [3] but this solution is very costly since it relies on IPI.

And even there, we could end up in a loop of vmalloc faults if a vmalloc
allocation is done in the IPI path (for example if it is traced, see
[4]), which could result in a kernel stack overflow.

Those preventive sfence.vma needed to be emitted because:

- if the uarch caches invalid entries, the new mapping may not be
  observed by the page table walker and an invalidation may be needed.
- if the uarch does not cache invalid entries, a reordered access
  could "miss" the new mapping and traps: in that case, we would actually
  only need to retry the access, no sfence.vma is required.

So this patch removes those preventive sfence.vma and actually handles
the possible (and unlikely) exceptions. And since the kernel stacks
mappings lie in the vmalloc area, this handling must be done very early
when the trap is taken, at the very beginning of handle_exception: this
also rules out the vmalloc allocations in the fault path.

Link: https://lore.kernel.org/linux-riscv/20230531093817.665799-1-bjorn@kernel.org/ [1]
Link: https://lore.kernel.org/linux-riscv/20230801090927.2018653-1-dylan@andestech.com [2]
Link: https://lore.kernel.org/linux-riscv/20230725132246.817726-1-alexghiti@rivosinc.com/ [3]
Link: https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.org/ [4]
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cacheflush.h  | 18 +++++-
 arch/riscv/include/asm/thread_info.h |  7 +++
 arch/riscv/kernel/asm-offsets.c      |  7 +++
 arch/riscv/kernel/entry.S            | 87 ++++++++++++++++++++++++++++
 arch/riscv/mm/init.c                 |  2 +
 5 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index ce79c558a4c8..8de73f91bfa3 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -46,7 +46,23 @@ do {							\
 } while (0)
 
 #ifdef CONFIG_64BIT
-#define flush_cache_vmap(start, end)		flush_tlb_kernel_range(start, end)
+extern u64 new_vmalloc[NR_CPUS / sizeof(u64) + 1];
+extern char _end[];
+#define flush_cache_vmap flush_cache_vmap
+static inline void flush_cache_vmap(unsigned long start, unsigned long end)
+{
+	if (is_vmalloc_or_module_addr((void *)start)) {
+		int i;
+
+		/*
+		 * We don't care if concurrently a cpu resets this value since
+		 * the only place this can happen is in handle_exception() where
+		 * an sfence.vma is emitted.
+		 */
+		for (i = 0; i < ARRAY_SIZE(new_vmalloc); ++i)
+			new_vmalloc[i] = -1ULL;
+	}
+}
 #define flush_cache_vmap_early(start, end)	local_flush_tlb_kernel_range(start, end)
 #endif
 
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 5d473343634b..0ddf1123b5ba 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -60,6 +60,13 @@ struct thread_info {
 	void			*scs_base;
 	void			*scs_sp;
 #endif
+#ifdef CONFIG_64BIT
+	/*
+	 * Used in handle_exception() to save a0, a1 and a2 before knowing if we
+	 * can access the kernel stack.
+	 */
+	unsigned long		a0, a1, a2;
+#endif
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index b09ca5f944f7..e94180ba432f 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -36,6 +36,8 @@ void asm_offsets(void)
 	OFFSET(TASK_THREAD_S9, task_struct, thread.s[9]);
 	OFFSET(TASK_THREAD_S10, task_struct, thread.s[10]);
 	OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
+
+	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
 	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
@@ -43,6 +45,11 @@ void asm_offsets(void)
 #ifdef CONFIG_SHADOW_CALL_STACK
 	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
 #endif
+#ifdef CONFIG_64BIT
+	OFFSET(TASK_TI_A0, task_struct, thread_info.a0);
+	OFFSET(TASK_TI_A1, task_struct, thread_info.a1);
+	OFFSET(TASK_TI_A2, task_struct, thread_info.a2);
+#endif
 
 	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 68a24cf9481a..d80b90f99bc1 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -19,6 +19,79 @@
 
 	.section .irqentry.text, "ax"
 
+.macro new_vmalloc_check
+	REG_S 	a0, TASK_TI_A0(tp)
+	csrr 	a0, CSR_CAUSE
+	/* Exclude IRQs */
+	blt  	a0, zero, _new_vmalloc_restore_context_a0
+
+	REG_S 	a1, TASK_TI_A1(tp)
+	/* Only check new_vmalloc if we are in page/protection fault */
+	li   	a1, EXC_LOAD_PAGE_FAULT
+	beq  	a0, a1, _new_vmalloc_kernel_address
+	li   	a1, EXC_STORE_PAGE_FAULT
+	beq  	a0, a1, _new_vmalloc_kernel_address
+	li   	a1, EXC_INST_PAGE_FAULT
+	bne  	a0, a1, _new_vmalloc_restore_context_a1
+
+_new_vmalloc_kernel_address:
+	/* Is it a kernel address? */
+	csrr 	a0, CSR_TVAL
+	bge 	a0, zero, _new_vmalloc_restore_context_a1
+
+	/* Check if a new vmalloc mapping appeared that could explain the trap */
+	REG_S	a2, TASK_TI_A2(tp)
+	/*
+	 * Computes:
+	 * a0 = &new_vmalloc[BIT_WORD(cpu)]
+	 * a1 = BIT_MASK(cpu)
+	 */
+	REG_L 	a2, TASK_TI_CPU(tp)
+	/*
+	 * Compute the new_vmalloc element position:
+	 * (cpu / 64) * 8 = (cpu >> 6) << 3
+	 */
+	srli	a1, a2, 6
+	slli	a1, a1, 3
+	la	a0, new_vmalloc
+	add	a0, a0, a1
+	/*
+	 * Compute the bit position in the new_vmalloc element:
+	 * bit_pos = cpu % 64 = cpu - (cpu / 64) * 64 = cpu - (cpu >> 6) << 6
+	 * 	   = cpu - ((cpu >> 6) << 3) << 3
+	 */
+	slli	a1, a1, 3
+	sub	a1, a2, a1
+	/* Compute the "get mask": 1 << bit_pos */
+	li	a2, 1
+	sll	a1, a2, a1
+
+	/* Check the value of new_vmalloc for this cpu */
+	REG_L	a2, 0(a0)
+	and	a2, a2, a1
+	beq	a2, zero, _new_vmalloc_restore_context
+
+	/* Atomically reset the current cpu bit in new_vmalloc */
+	amoxor.d	a0, a1, (a0)
+
+	/* Only emit a sfence.vma if the uarch caches invalid entries */
+	ALTERNATIVE("sfence.vma", "nop", 0, RISCV_ISA_EXT_SVVPTC, 1)
+
+	REG_L	a0, TASK_TI_A0(tp)
+	REG_L	a1, TASK_TI_A1(tp)
+	REG_L	a2, TASK_TI_A2(tp)
+	csrw	CSR_SCRATCH, x0
+	sret
+
+_new_vmalloc_restore_context:
+	REG_L 	a2, TASK_TI_A2(tp)
+_new_vmalloc_restore_context_a1:
+	REG_L 	a1, TASK_TI_A1(tp)
+_new_vmalloc_restore_context_a0:
+	REG_L	a0, TASK_TI_A0(tp)
+.endm
+
+
 SYM_CODE_START(handle_exception)
 	/*
 	 * If coming from userspace, preserve the user thread pointer and load
@@ -30,6 +103,20 @@ SYM_CODE_START(handle_exception)
 
 .Lrestore_kernel_tpsp:
 	csrr tp, CSR_SCRATCH
+
+#ifdef CONFIG_64BIT
+	/*
+	 * The RISC-V kernel does not eagerly emit a sfence.vma after each
+	 * new vmalloc mapping, which may result in exceptions:
+	 * - if the uarch caches invalid entries, the new mapping would not be
+	 *   observed by the page table walker and an invalidation is needed.
+	 * - if the uarch does not cache invalid entries, a reordered access
+	 *   could "miss" the new mapping and traps: in that case, we only need
+	 *   to retry the access, no sfence.vma is required.
+	 */
+	new_vmalloc_check
+#endif
+
 	REG_S sp, TASK_TI_KERNEL_SP(tp)
 
 #ifdef CONFIG_VMAP_STACK
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e3405e4b99af..2367a156c33b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -36,6 +36,8 @@
 
 #include "../kernel/head.h"
 
+u64 new_vmalloc[NR_CPUS / sizeof(u64) + 1];
+
 struct kernel_mapping kernel_map __ro_after_init;
 EXPORT_SYMBOL(kernel_map);
 #ifdef CONFIG_XIP_KERNEL
-- 
2.39.2


