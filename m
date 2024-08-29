Return-Path: <linux-kernel+bounces-305970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E14CD963741
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51078B24451
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C18481AA;
	Thu, 29 Aug 2024 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Dl0l/znK"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2B3FB9F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893324; cv=none; b=GVbwewlfyun5SakUVv5oXpXz1bTSMbqR150VuQha2SgCVUmvVcuCNNj+5Tr2lfJzKJyKBDDxCN5cH4AGhwR7IUeyA/lLwM7sLpSyBTTCZOrjLON2AjSOZ0QGdTDfBmdKL5Ph9RPvXN0/AKeiLSgXYEcT9lMGr0l0TdadcWoK58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893324; c=relaxed/simple;
	bh=Y9gg4depTXj9B2gOP+3GErw6SkZCfe43LUJofoAvIUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqIB5yRmYRj7u3HxK7N3lUUukfEu5I1bPjSg62Sq0vII7qGOEfRIc62qksZxq/+u3gjOL12zjowE0MPeyhbsyp2snIJovDALSNW8vuBJfhdrECAif9jOTOvNa/uL7hRqD8fRNbrlO03YgJbvLc1T8JexZTDrk8SH8Tru/Oj+FJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Dl0l/znK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-714262f1bb4so112375b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724893322; x=1725498122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi965EzHXRRG42eOTmPcGhK9BxnfGfgGEBjoVVprAAQ=;
        b=Dl0l/znKqvrH1LPW+Lbc0DrThokKXpxtRJQaC0xo8uq4a02Zk2i5c1MVKlZ2bQh7wD
         YRhtV4FoOpU8zYLYoGLaFord2giDkFRbuNkmwbF+FtThiytxbWNiaWlpb0fbZ9pVjlka
         irZA4vSedzm9d8vc5bOKHe52z+IS4gzn24vJTGLW63J7PJJJT6EJ8jjR83ApDaNOV/Ta
         18NSLlFbRH8rIofpZi3kBmk8Rt7fS5yeduCqVIl5SiEfo/9G9mxGey3bb/lDQSQg/iDR
         dbSRh6Hz3shOXY1Xp0SQJIzo/AkN1ZEkXkLqbeODzu1us//rc7D/LktoTMNo6cfsWpk9
         5QcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724893322; x=1725498122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi965EzHXRRG42eOTmPcGhK9BxnfGfgGEBjoVVprAAQ=;
        b=nMKZqDI+mOJxEh9sFFmVIMBHCKTdg3rmDMAlz6pvhCGF2bWSpd5knotlvvEsv8dDpe
         NHayqUAdNJjwbr5RE6Kiz6qjowc8RjN4/YMpd17k1W2iIszgTABbxNbzhZ/WiK3qT/r5
         9O5tqsxN2y7RdcopgHdRXBnXGlLnLj1ihw/iwiWXAJ5llu5UpF+l6SBmNHfj841LOqII
         JVdOp4zeNqPlBMWPE4ODFyrpUyzqDl5at/84z5+C4a/Xv8ehpyVF+fqmckXFPC8Zojvv
         OPOCpadTQsBAyxjtbiLcgfeh8pJG8bpw9N49YPMVZq85ivWwT30S/9yiP4PHWZlXQOKm
         y4sg==
X-Forwarded-Encrypted: i=1; AJvYcCVgX1h5bSX0Yrlz/wuPK+EzEFvQT8ktSUS2BLe/umr+EwxyRnsEhcBgclqRtKeOTXfwVieDEC2YoG5s3sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynU4T/LPemM1CxVql4bz7K3trUkMlQ8vu+bmbjH1MjtfHyoQS6
	6EdRUXyIGBlJHerq4DU0KefAI58JfU/RzxzVKsiFwR4xrBhQW3UQlKA2q9mDngI=
X-Google-Smtp-Source: AGHT+IEAhv7NFV+ICiCrw4NSilnVXhWDrq5PDE/RnHhrnpcrTL2Vqd7UfJ2JMNSctO/zl/g62QBLaQ==
X-Received: by 2002:a05:6a00:2196:b0:70d:1dcf:e2b4 with SMTP id d2e1a72fcca58-715dfb698f9mr1218508b3a.1.1724893322003;
        Wed, 28 Aug 2024 18:02:02 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a4dsm89670b3a.17.2024.08.28.18.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:02:01 -0700 (PDT)
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
Subject: [PATCH v4 05/10] riscv: Add support for the tagged address ABI
Date: Wed, 28 Aug 2024 18:01:27 -0700
Message-ID: <20240829010151.2813377-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240829010151.2813377-1-samuel.holland@sifive.com>
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
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

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - Combine __untagged_addr() and __untagged_addr_remote()

Changes in v3:
 - Use IS_ENABLED instead of #ifdef when possible
 - Implement mm_untag_mask()
 - Remove pmlen from struct thread_info (now only in mm_context_t)

Changes in v2:
 - Implement untagged_addr_remote()
 - Restrict PMLEN changes once a process is multithreaded

 arch/riscv/include/asm/mmu.h         |  7 +++
 arch/riscv/include/asm/mmu_context.h | 13 +++++
 arch/riscv/include/asm/uaccess.h     | 43 ++++++++++++++--
 arch/riscv/kernel/process.c          | 73 ++++++++++++++++++++++++++--
 4 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index c9e03e9da3dc..1cc90465d75b 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -25,9 +25,16 @@ typedef struct {
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	unsigned long exec_fdpic_loadmap;
 	unsigned long interp_fdpic_loadmap;
+#endif
+	unsigned long flags;
+#ifdef CONFIG_RISCV_ISA_SUPM
+	u8 pmlen;
 #endif
 } mm_context_t;
 
+/* Lock the pointer masking mode because this mm is multithreaded */
+#define MM_CONTEXT_LOCK_PMLEN	0
+
 #define cntx2asid(cntx)		((cntx) & SATP_ASID_MASK)
 #define cntx2version(cntx)	((cntx) & ~SATP_ASID_MASK)
 
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 7030837adc1a..8c4bc49a3a0f 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -20,6 +20,9 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 static inline void activate_mm(struct mm_struct *prev,
 			       struct mm_struct *next)
 {
+#ifdef CONFIG_RISCV_ISA_SUPM
+	next->context.pmlen = 0;
+#endif
 	switch_mm(prev, next, NULL);
 }
 
@@ -30,11 +33,21 @@ static inline int init_new_context(struct task_struct *tsk,
 #ifdef CONFIG_MMU
 	atomic_long_set(&mm->context.id, 0);
 #endif
+	if (IS_ENABLED(CONFIG_RISCV_ISA_SUPM))
+		clear_bit(MM_CONTEXT_LOCK_PMLEN, &mm->context.flags);
 	return 0;
 }
 
 DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
 
+#ifdef CONFIG_RISCV_ISA_SUPM
+#define mm_untag_mask mm_untag_mask
+static inline unsigned long mm_untag_mask(struct mm_struct *mm)
+{
+	return -1UL >> mm->context.pmlen;
+}
+#endif
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 72ec1d9bd3f3..fee56b0c8058 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -9,8 +9,41 @@
 #define _ASM_RISCV_UACCESS_H
 
 #include <asm/asm-extable.h>
+#include <asm/cpufeature.h>
 #include <asm/pgtable.h>		/* for TASK_SIZE */
 
+#ifdef CONFIG_RISCV_ISA_SUPM
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
+#define untagged_addr(addr) ({							\
+	unsigned long __addr = (__force unsigned long)(addr);			\
+	(__force __typeof__(addr))__untagged_addr_remote(current->mm, __addr);	\
+})
+
+#define untagged_addr_remote(mm, addr) ({					\
+	unsigned long __addr = (__force unsigned long)(addr);			\
+	mmap_assert_locked(mm);							\
+	(__force __typeof__(addr))__untagged_addr_remote(mm, __addr);		\
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
@@ -130,7 +163,7 @@ do {								\
  */
 #define __get_user(x, ptr)					\
 ({								\
-	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);	\
+	const __typeof__(*(ptr)) __user *__gu_ptr = untagged_addr(ptr); \
 	long __gu_err = 0;					\
 								\
 	__chk_user_ptr(__gu_ptr);				\
@@ -246,7 +279,7 @@ do {								\
  */
 #define __put_user(x, ptr)					\
 ({								\
-	__typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
+	__typeof__(*(ptr)) __user *__gu_ptr = untagged_addr(ptr); \
 	__typeof__(*__gu_ptr) __val = (x);			\
 	long __pu_err = 0;					\
 								\
@@ -293,13 +326,13 @@ unsigned long __must_check __asm_copy_from_user(void *to,
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
@@ -314,7 +347,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 {
 	might_fault();
 	return access_ok(to, n) ?
-		__clear_user(to, n) : n;
+		__clear_user(untagged_addr(to), n) : n;
 }
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index f39221ab5ddd..6e9c84a41c29 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -204,6 +204,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 
+	/* Ensure all threads in this mm have the same pointer masking mode. */
+	if (IS_ENABLED(CONFIG_RISCV_ISA_SUPM) && p->mm && (clone_flags & CLONE_VM))
+		set_bit(MM_CONTEXT_LOCK_PMLEN, &p->mm->context.flags);
+
 	memset(&p->thread.s, 0, sizeof(p->thread.s));
 
 	/* p->thread holds context to be restored by __switch_to() */
@@ -249,10 +253,16 @@ enum {
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
 
@@ -267,16 +277,41 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
 	 * in case choosing a larger PMLEN has a performance impact.
 	 */
 	pmlen = FIELD_GET(PR_PMLEN_MASK, arg);
-	if (pmlen == PMLEN_0)
+	if (pmlen == PMLEN_0) {
 		pmm = ENVCFG_PMM_PMLEN_0;
-	else if (pmlen <= PMLEN_7 && have_user_pmlen_7)
+	} else if (pmlen <= PMLEN_7 && have_user_pmlen_7) {
+		pmlen = PMLEN_7;
 		pmm = ENVCFG_PMM_PMLEN_7;
-	else if (pmlen <= PMLEN_16 && have_user_pmlen_16)
+	} else if (pmlen <= PMLEN_16 && have_user_pmlen_16) {
+		pmlen = PMLEN_16;
 		pmm = ENVCFG_PMM_PMLEN_16;
-	else
+	} else {
 		return -EINVAL;
+	}
+
+	/*
+	 * Do not allow the enabling of the tagged address ABI if globally
+	 * disabled via sysctl abi.tagged_addr_disabled, if pointer masking
+	 * is disabled for userspace.
+	 */
+	if (arg & PR_TAGGED_ADDR_ENABLE && (tagged_addr_disabled || !pmlen))
+		return -EINVAL;
+
+	if (!(arg & PR_TAGGED_ADDR_ENABLE))
+		pmlen = PMLEN_0;
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	if (test_bit(MM_CONTEXT_LOCK_PMLEN, &mm->context.flags) && mm->context.pmlen != pmlen) {
+		mmap_write_unlock(mm);
+		return -EBUSY;
+	}
 
 	envcfg_update_bits(task, ENVCFG_PMM, pmm);
+	mm->context.pmlen = pmlen;
+
+	mmap_write_unlock(mm);
 
 	return 0;
 }
@@ -289,6 +324,10 @@ long get_tagged_addr_ctrl(struct task_struct *task)
 	if (is_compat_thread(ti))
 		return -EINVAL;
 
+	/*
+	 * The mm context's pmlen is set only when the tagged address ABI is
+	 * enabled, so the effective PMLEN must be extracted from envcfg.PMM.
+	 */
 	switch (task->thread.envcfg & ENVCFG_PMM) {
 	case ENVCFG_PMM_PMLEN_7:
 		ret = FIELD_PREP(PR_PMLEN_MASK, PMLEN_7);
@@ -298,6 +337,9 @@ long get_tagged_addr_ctrl(struct task_struct *task)
 		break;
 	}
 
+	if (task->mm->context.pmlen)
+		ret |= PR_TAGGED_ADDR_ENABLE;
+
 	return ret;
 }
 
@@ -307,6 +349,24 @@ static bool try_to_set_pmm(unsigned long value)
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
@@ -320,6 +380,9 @@ static int __init tagged_addr_init(void)
 	have_user_pmlen_7 = try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
 	have_user_pmlen_16 = try_to_set_pmm(ENVCFG_PMM_PMLEN_16);
 
+	if (!register_sysctl("abi", tagged_addr_sysctl_table))
+		return -EINVAL;
+
 	return 0;
 }
 core_initcall(tagged_addr_init);
-- 
2.45.1


