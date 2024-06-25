Return-Path: <linux-kernel+bounces-229710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C6F917309
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45140284847
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A86180A69;
	Tue, 25 Jun 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ETN+9ron"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0717FADF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349787; cv=none; b=juUY8u3BaFczCAD3gUEWQTS7hITlmgZ85atsmcgrb4W1gq2+toc7gUPZy1wM13H82iprJzLlCYJvg/6peeOoMO27DVez1dR3ojGFQihnIiwP7BuRJakeCNMh7M8gaPP9Px829PC/6BLmt2iZZ3oZb0fHoNYj4sCT5xzaXEMzo0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349787; c=relaxed/simple;
	bh=8kggMz8/f5qLIIFTpBmmCwqfpW6kBNPlwqErd1brQz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6eT4A3zUe1VMlGXUEvSzcftCYdIirgLaDACrCAsDtqM4KTkprYKYE4ds6RXMGuHeE6MWLDnhx18x1jm/X7wDW/PsczITHEwypx8meGRu0Nx/chey4UbBicBkS/ypX5BC8eTSL9OUAn/eRx7wmGCkH/RTZt10kYel8CtqXtgLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ETN+9ron; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa07e4f44eso31658345ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719349785; x=1719954585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Icm6uA8wnqdys37A8Kzf4AV1ey+zBIexi2g5XJMtDfE=;
        b=ETN+9ron5pDf+ZaVOyk7cfDIWkD7OUCrykg1p3fHA2yl2dpK/zFlon91oH1BOQolsV
         bXL7Xog4R1PBUJu1zMq5mt2EwLdNY1rzOzuv3qwSqgAtzj/F0dWziXCFzkV4mfu3tBSk
         fTa2BqBMIKa7auzsZxzZsKHBav6OZP5U3zrpEhZ9DOK+Et0rUh5CZzqB5I9rhOnQKFaL
         f3Q5yPSjkcxdLYOXEWJI7EIi4OMeToqnt6+flj122tKpfa0aYHKRxglHUEWU6mr9T4UZ
         7aQyQMy/2rQkvlhOVPL/MtfsQGARvJ7EK1rwNEwQkREEmX+Ki1lvAcbKWLEVEi6tEnwN
         06eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719349785; x=1719954585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Icm6uA8wnqdys37A8Kzf4AV1ey+zBIexi2g5XJMtDfE=;
        b=GFVy6iK3aaRTw65s7fQR5y+J8WHPM7SSl4593wVoLNLW/fuPbgNboh9IGlHcaWGD3t
         7ju9hPlnWoFqmVKiIjsK69t8+HYVAJg4fSrWcO4uA9Vpw5nFPzV81XPRyA8f7qSUzSrp
         vvgHm1S6Oxw+zB9Tj8ogqZlQLjjmey6XA7NFbLMqHi+pBBAsdUKF+DbQJTDVZZbjVKFN
         X3Vb/Ry3u0z7ZGDIpNlGFfDDnxJfCqZoN+lvi23OHZ9n5577AHKMf7oAbxeK3JCD+Mu4
         zA9q4TpYqivUo3PRpybvacW1bQEZWeNqBFUYkhpf7uYbi6hTFb0XzETjndHtXETxHxvG
         o83A==
X-Forwarded-Encrypted: i=1; AJvYcCUWdIapv4SZ2an/Qepir2wcGsd6eV5hofWQNPm11fHOwt3SyJChZegNskct012CzjgAjAe53D2VAiHsUrsnZNRjbA50OeVUavwfSD91
X-Gm-Message-State: AOJu0YwmHcog6spIQbXyYfZ5DFrDn5JvV9Fx742boOfH1o4ynIFq05AX
	IrcKwVoOuoqRW+411VGrLZmflvc+IVPkqcyLypcIZS/FatLKQDBC5UOTPkBRKpw=
X-Google-Smtp-Source: AGHT+IHthtdLPOXBG6B10DrZ39vkgS4mJz07lhPLTxOAb1nTigmUhpXbFgrxYa8MQ6WsjtQ9WbY67w==
X-Received: by 2002:a17:903:32ce:b0:1fa:643:f424 with SMTP id d9443c01a7336-1fa238e46ddmr113134855ad.14.1719349784670;
        Tue, 25 Jun 2024 14:09:44 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb328f57sm85873455ad.110.2024.06.25.14.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:09:44 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 05/10] riscv: Add support for the tagged address ABI
Date: Tue, 25 Jun 2024 14:09:16 -0700
Message-ID: <20240625210933.1620802-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240625210933.1620802-1-samuel.holland@sifive.com>
References: <20240625210933.1620802-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pointer masking is enabled for userspace, the kernel can accept
tagged pointers as arguments to some system calls. Allow this by
untagging the pointers in access_ok() and the uaccess routines. The
uaccess routines must peform untagging in software because U-mode and
S-mode have entirely separate pointer masking configurations. In fact,
hardware may not even implement pointer masking for S-mode.

Since the number of tag bits is variable, untagged_addr_remote() needs
to know what PMLEN to use for the remote mm. Therefore, the pointer
masking mode must be the same for all threads sharing an mm. Enforce
this with a lock flag in the mm context, as x86 does for LAM. The flag
gets reset in init_new_context() during fork(), as the new mm is no
longer multithreaded.

Unlike x86, untagged_addr() gets pmlen from struct thread_info instead
of a percpu variable, as this both avoids context switch overhead and
loads the value more efficiently.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Implement untagged_addr_remote()
 - Restrict PMLEN changes once a process is multithreaded

 arch/riscv/include/asm/mmu.h         |  7 +++
 arch/riscv/include/asm/mmu_context.h |  6 +++
 arch/riscv/include/asm/thread_info.h |  3 ++
 arch/riscv/include/asm/uaccess.h     | 58 +++++++++++++++++++++--
 arch/riscv/kernel/process.c          | 69 +++++++++++++++++++++++++++-
 5 files changed, 136 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 947fd60f9051..361a9623f8c8 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -26,8 +26,15 @@ typedef struct {
 	unsigned long exec_fdpic_loadmap;
 	unsigned long interp_fdpic_loadmap;
 #endif
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+	unsigned long flags;
+	u8 pmlen;
+#endif
 } mm_context_t;
 
+/* Lock the pointer masking mode because this mm is multithreaded */
+#define MM_CONTEXT_LOCK_PMLEN	0
+
 #define cntx2asid(cntx)		((cntx) & SATP_ASID_MASK)
 #define cntx2version(cntx)	((cntx) & ~SATP_ASID_MASK)
 
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 7030837adc1a..62a9f76cf257 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -20,6 +20,9 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 static inline void activate_mm(struct mm_struct *prev,
 			       struct mm_struct *next)
 {
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+	next->context.pmlen = 0;
+#endif
 	switch_mm(prev, next, NULL);
 }
 
@@ -29,6 +32,9 @@ static inline int init_new_context(struct task_struct *tsk,
 {
 #ifdef CONFIG_MMU
 	atomic_long_set(&mm->context.id, 0);
+#endif
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+	clear_bit(MM_CONTEXT_LOCK_PMLEN, &mm->context.flags);
 #endif
 	return 0;
 }
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 5d473343634b..cd355f8a550f 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -60,6 +60,9 @@ struct thread_info {
 	void			*scs_base;
 	void			*scs_sp;
 #endif
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+	u8			pmlen;
+#endif
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 72ec1d9bd3f3..153495997bc1 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -9,8 +9,56 @@
 #define _ASM_RISCV_UACCESS_H
 
 #include <asm/asm-extable.h>
+#include <asm/cpufeature.h>
 #include <asm/pgtable.h>		/* for TASK_SIZE */
 
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+static inline unsigned long __untagged_addr(unsigned long addr)
+{
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM)) {
+		u8 pmlen = current->thread_info.pmlen;
+
+		/* Virtual addresses are sign-extended; physical addresses are zero-extended. */
+		if (IS_ENABLED(CONFIG_MMU))
+			return (long)(addr << pmlen) >> pmlen;
+		else
+			return (addr << pmlen) >> pmlen;
+	}
+
+	return addr;
+}
+
+#define untagged_addr(addr) ({						\
+	unsigned long __addr = (__force unsigned long)(addr);		\
+	(__force __typeof__(addr))__untagged_addr(__addr);		\
+})
+
+static inline unsigned long __untagged_addr_remote(struct mm_struct *mm, unsigned long addr)
+{
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM)) {
+		u8 pmlen = mm->context.pmlen;
+
+		/* Virtual addresses are sign-extended; physical addresses are zero-extended. */
+		if (IS_ENABLED(CONFIG_MMU))
+			return (long)(addr << pmlen) >> pmlen;
+		else
+			return (addr << pmlen) >> pmlen;
+	}
+
+	return addr;
+}
+
+#define untagged_addr_remote(mm, addr) ({				\
+	unsigned long __addr = (__force unsigned long)(addr);		\
+	mmap_assert_locked(mm);						\
+	(__force __typeof__(addr))__untagged_addr_remote(mm, __addr);	\
+})
+
+#define access_ok(addr, size) likely(__access_ok(untagged_addr(addr), size))
+#else
+#define untagged_addr(addr) (addr)
+#endif
+
 /*
  * User space memory access functions
  */
@@ -130,7 +178,7 @@ do {								\
  */
 #define __get_user(x, ptr)					\
 ({								\
-	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);	\
+	const __typeof__(*(ptr)) __user *__gu_ptr = untagged_addr(ptr); \
 	long __gu_err = 0;					\
 								\
 	__chk_user_ptr(__gu_ptr);				\
@@ -246,7 +294,7 @@ do {								\
  */
 #define __put_user(x, ptr)					\
 ({								\
-	__typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
+	__typeof__(*(ptr)) __user *__gu_ptr = untagged_addr(ptr); \
 	__typeof__(*__gu_ptr) __val = (x);			\
 	long __pu_err = 0;					\
 								\
@@ -293,13 +341,13 @@ unsigned long __must_check __asm_copy_from_user(void *to,
 static inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	return __asm_copy_from_user(to, from, n);
+	return __asm_copy_from_user(to, untagged_addr(from), n);
 }
 
 static inline unsigned long
 raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	return __asm_copy_to_user(to, from, n);
+	return __asm_copy_to_user(untagged_addr(to), from, n);
 }
 
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
@@ -314,7 +362,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 {
 	might_fault();
 	return access_ok(to, n) ?
-		__clear_user(to, n) : n;
+		__clear_user(untagged_addr(to), n) : n;
 }
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index dec5ccc44697..7bd445dade92 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -173,8 +173,10 @@ void flush_thread(void)
 	clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
 #endif
 #ifdef CONFIG_RISCV_ISA_POINTER_MASKING
-	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM)) {
 		envcfg_update_bits(current, ENVCFG_PMM, ENVCFG_PMM_PMLEN_0);
+		current->thread_info.pmlen = 0;
+	}
 #endif
 }
 
@@ -204,6 +206,12 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+	/* Ensure all threads in this mm have the same pointer masking mode. */
+	if (p->mm && (clone_flags & CLONE_VM))
+		set_bit(MM_CONTEXT_LOCK_PMLEN, &p->mm->context.flags);
+#endif
+
 	memset(&p->thread.s, 0, sizeof(p->thread.s));
 
 	/* p->thread holds context to be restored by __switch_to() */
@@ -243,10 +251,16 @@ void __init arch_task_cache_init(void)
 static bool have_user_pmlen_7;
 static bool have_user_pmlen_16;
 
+/*
+ * Control the relaxed ABI allowing tagged user addresses into the kernel.
+ */
+static unsigned int tagged_addr_disabled;
+
 long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
 {
-	unsigned long valid_mask = PR_PMLEN_MASK;
+	unsigned long valid_mask = PR_PMLEN_MASK | PR_TAGGED_ADDR_ENABLE;
 	struct thread_info *ti = task_thread_info(task);
+	struct mm_struct *mm = task->mm;
 	unsigned long pmm;
 	u8 pmlen;
 
@@ -277,6 +291,14 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
 			return -EINVAL;
 	}
 
+	/*
+	 * Do not allow the enabling of the tagged address ABI if globally
+	 * disabled via sysctl abi.tagged_addr_disabled, if pointer masking
+	 * is disabled for userspace.
+	 */
+	if (arg & PR_TAGGED_ADDR_ENABLE && (tagged_addr_disabled || !pmlen))
+		return -EINVAL;
+
 	if (pmlen == 7)
 		pmm = ENVCFG_PMM_PMLEN_7;
 	else if (pmlen == 16)
@@ -284,7 +306,22 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
 	else
 		pmm = ENVCFG_PMM_PMLEN_0;
 
+	if (!(arg & PR_TAGGED_ADDR_ENABLE))
+		pmlen = 0;
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	if (test_bit(MM_CONTEXT_LOCK_PMLEN, &mm->context.flags) && mm->context.pmlen != pmlen) {
+		mmap_write_unlock(mm);
+		return -EBUSY;
+	}
+
 	envcfg_update_bits(task, ENVCFG_PMM, pmm);
+	task->mm->context.pmlen = pmlen;
+	task->thread_info.pmlen = pmlen;
+
+	mmap_write_unlock(mm);
 
 	return 0;
 }
@@ -297,6 +334,13 @@ long get_tagged_addr_ctrl(struct task_struct *task)
 	if (is_compat_thread(ti))
 		return -EINVAL;
 
+	if (task->thread_info.pmlen)
+		ret = PR_TAGGED_ADDR_ENABLE;
+
+	/*
+	 * The task's pmlen is only set if the tagged address ABI is enabled,
+	 * so the effective PMLEN must be extracted from envcfg.PMM.
+	 */
 	switch (task->thread.envcfg & ENVCFG_PMM) {
 	case ENVCFG_PMM_PMLEN_7:
 		ret |= FIELD_PREP(PR_PMLEN_MASK, 7);
@@ -315,6 +359,24 @@ static bool try_to_set_pmm(unsigned long value)
 	return (csr_read_clear(CSR_ENVCFG, ENVCFG_PMM) & ENVCFG_PMM) == value;
 }
 
+/*
+ * Global sysctl to disable the tagged user addresses support. This control
+ * only prevents the tagged address ABI enabling via prctl() and does not
+ * disable it for tasks that already opted in to the relaxed ABI.
+ */
+
+static struct ctl_table tagged_addr_sysctl_table[] = {
+	{
+		.procname	= "tagged_addr_disabled",
+		.mode		= 0644,
+		.data		= &tagged_addr_disabled,
+		.maxlen		= sizeof(int),
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+};
+
 static int __init tagged_addr_init(void)
 {
 	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
@@ -328,6 +390,9 @@ static int __init tagged_addr_init(void)
 	have_user_pmlen_7 = try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
 	have_user_pmlen_16 = try_to_set_pmm(ENVCFG_PMM_PMLEN_16);
 
+	if (!register_sysctl("abi", tagged_addr_sysctl_table))
+		return -EINVAL;
+
 	return 0;
 }
 core_initcall(tagged_addr_init);
-- 
2.44.1


