Return-Path: <linux-kernel+bounces-305969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B465F96373F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DEBB2438D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9252433C7;
	Thu, 29 Aug 2024 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YpTrumkq"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290D138F83
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893322; cv=none; b=p47BQe35HgRK54kyl03Tu3ECLJ+KHQwZ1avOqRiDUrcapXgmI9u/aTZDUuWA1ypHucbGwrZPxfIZSr8HuCrdVCyyE5RU07AdeEVRR54JCRqLiqbl8WeKlFxIlyJtKZqUB68Q4Hk2W6DpcUrgxeBKl0zcrHtVF2XOvTeD3dUmfaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893322; c=relaxed/simple;
	bh=VDYgBbhje01O4rpBKWxlniRs+ILw3rgqzt8bLOBLmL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgW1YNT4d5ij3vKkZelEX9rO0wZVa72epYTl5hsUQMwrjEjHh2q0vz9fpDAcOoGLP8dt4tBLjZhX6e7KlzueiM+b2ywH2XSB+YeTiXz0NVWE6ND6cStK5Ivd0XXaAeVJeXkSb2EBvTwurQ7LgtLuv2BarqzFS0S7YS4J7Li3Nyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YpTrumkq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71433096e89so98902b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724893320; x=1725498120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3qDkoS5rxZK3Tpvbz7Odl2ZyEBU08AZZIxTPut6X68=;
        b=YpTrumkqwH4dnEIzIs2bvoGsgMvHpmRAXhdA6xsEnoyx9z6OSay+/nMAIjVBOLFIwa
         Fucszxt4MjBXh2aIakiqmIkl0ch2VnKAgE9cNzEsrajKPSHPZgkhhbxvdYW2JSf9y86v
         cTR8mDmJYj/AqzNr/5RwtNCC/pk4o6ae96iwhFtaeM0Mv3gF6PHH4nwbtWVcb7V/yycr
         XAZlDpPTzldzY9ipfUDYWgKJuogmSFrERTXEqs6WNnKx0C9QtzxSxrZrKISgIKr8VCLz
         F+KIlYM8NvtanhjBkvGLywvQNjvWldPr05LFjn1ibTUHvznb+hZ9DGwAt6wZJdi0hUo8
         g26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724893320; x=1725498120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3qDkoS5rxZK3Tpvbz7Odl2ZyEBU08AZZIxTPut6X68=;
        b=CxwpM1TYM3FVSo5im2TAUcd6vu1cxdm0XHp6fYXccfqBnh/v612tjzQzLKHHEdtsPt
         vpGOyNiUZi2GX+HLrEEc9at8E8zvDsAbBhJRPTMNoiLRQDPjLqXuUPpVtaPFlCp3MekU
         fOoRr+1szOaJF3x1PebuR6zI9RPmRfSkVWbqhdVO4lo4WG8XoKVC800A/mmj2fGiJBzP
         zl73l6+0gMV+nly+zTAe/s7/6d7ygsD5Zywh3gq0qrsHGxGVuldphwXRnJpdtdVtID/s
         mrqkjVSFw25m6jeu6aZz+oyOCWZMpl05oZAaAeI5t1Qrjm269icpMhZN/x10IXVY9trb
         p4cg==
X-Forwarded-Encrypted: i=1; AJvYcCXNT9kpZnSIztVvAcpwBgmRs2Ne5EESLv/hTflBZGXFHJcHSYtG1pVA/iUuHWITUuNySBzPAbdsZ0Rjp7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy6kVccikHhYbCBwI6t2+xuE6G4w521fVvzsCs648FTGXcM9iV
	kjiJmP7pZHyDhh4bR9ag4C694uPa8YP/hPUQpxEjRVS+RwyesUkm2bz4pfdACFg=
X-Google-Smtp-Source: AGHT+IFOayRDO6d6CIxxXv/BCnoTsrUdbFOblkYCeBJiq1yBR5gusHkRDSJAjFrefsDJqpZGzgvoBg==
X-Received: by 2002:a05:6a21:178a:b0:1cc:a104:c9f0 with SMTP id adf61e73a8af0-1cce102cfcemr1093597637.31.1724893320369;
        Wed, 28 Aug 2024 18:02:00 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a4dsm89670b3a.17.2024.08.28.18.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:01:59 -0700 (PDT)
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
Subject: [PATCH v4 04/10] riscv: Add support for userspace pointer masking
Date: Wed, 28 Aug 2024 18:01:26 -0700
Message-ID: <20240829010151.2813377-5-samuel.holland@sifive.com>
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

RISC-V supports pointer masking with a variable number of tag bits
(which is called "PMLEN" in the specification) and which is configured
at the next higher privilege level.

Wire up the PR_SET_TAGGED_ADDR_CTRL and PR_GET_TAGGED_ADDR_CTRL prctls
so userspace can request a lower bound on the number of tag bits and
determine the actual number of tag bits. As with arm64's
PR_TAGGED_ADDR_ENABLE, the pointer masking configuration is
thread-scoped, inherited on clone() and fork() and cleared on execve().

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - Switch IS_ENABLED back to #ifdef to fix riscv32 build

Changes in v3:
 - Rename CONFIG_RISCV_ISA_POINTER_MASKING to CONFIG_RISCV_ISA_SUPM,
   since it only controls the userspace part of pointer masking
 - Use IS_ENABLED instead of #ifdef when possible
 - Use an enum for the supported PMLEN values
 - Simplify the logic in set_tagged_addr_ctrl()

Changes in v2:
 - Rebase on riscv/linux.git for-next
 - Add and use the envcfg_update_bits() helper function
 - Inline flush_tagged_addr_state()

 arch/riscv/Kconfig                 | 11 ++++
 arch/riscv/include/asm/processor.h |  8 +++
 arch/riscv/include/asm/switch_to.h | 11 ++++
 arch/riscv/kernel/process.c        | 91 ++++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h         |  3 +
 5 files changed, 124 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0f3cd7c3a436..817437157138 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -512,6 +512,17 @@ config RISCV_ISA_C
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_SUPM
+	bool "Supm extension for userspace pointer masking"
+	depends on 64BIT
+	default y
+	help
+	  Add support for pointer masking in userspace (Supm) when the
+	  underlying hardware extension (Smnpm or Ssnpm) is detected at boot.
+
+	  If this option is disabled, userspace will be unable to use
+	  the prctl(PR_{SET,GET}_TAGGED_ADDR_CTRL) API.
+
 config RISCV_ISA_SVNAPOT
 	bool "Svnapot extension support for supervisor mode NAPOT pages"
 	depends on 64BIT && MMU
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 586e4ab701c4..5c4d4fb97314 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -200,6 +200,14 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
 extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
 
+#ifdef CONFIG_RISCV_ISA_SUPM
+/* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
+long get_tagged_addr_ctrl(struct task_struct *task);
+#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(current, arg)
+#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl(current)
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 9685cd85e57c..94e33216b2d9 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -70,6 +70,17 @@ static __always_inline bool has_fpu(void) { return false; }
 #define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
+static inline void envcfg_update_bits(struct task_struct *task,
+				      unsigned long mask, unsigned long val)
+{
+	unsigned long envcfg;
+
+	envcfg = (task->thread.envcfg & ~mask) | val;
+	task->thread.envcfg = envcfg;
+	if (task == current)
+		csr_write(CSR_ENVCFG, envcfg);
+}
+
 static inline void __switch_to_envcfg(struct task_struct *next)
 {
 	asm volatile (ALTERNATIVE("nop", "csrw " __stringify(CSR_ENVCFG) ", %0",
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e4bc61c4e58a..f39221ab5ddd 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/bitfield.h>
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -171,6 +172,10 @@ void flush_thread(void)
 	memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
 	clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
 #endif
+#ifdef CONFIG_RISCV_ISA_SUPM
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
+		envcfg_update_bits(current, ENVCFG_PMM, ENVCFG_PMM_PMLEN_0);
+#endif
 }
 
 void arch_release_task_struct(struct task_struct *tsk)
@@ -233,3 +238,89 @@ void __init arch_task_cache_init(void)
 {
 	riscv_v_setup_ctx_cache();
 }
+
+#ifdef CONFIG_RISCV_ISA_SUPM
+enum {
+	PMLEN_0 = 0,
+	PMLEN_7 = 7,
+	PMLEN_16 = 16,
+};
+
+static bool have_user_pmlen_7;
+static bool have_user_pmlen_16;
+
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
+{
+	unsigned long valid_mask = PR_PMLEN_MASK;
+	struct thread_info *ti = task_thread_info(task);
+	unsigned long pmm;
+	u8 pmlen;
+
+	if (is_compat_thread(ti))
+		return -EINVAL;
+
+	if (arg & ~valid_mask)
+		return -EINVAL;
+
+	/*
+	 * Prefer the smallest PMLEN that satisfies the user's request,
+	 * in case choosing a larger PMLEN has a performance impact.
+	 */
+	pmlen = FIELD_GET(PR_PMLEN_MASK, arg);
+	if (pmlen == PMLEN_0)
+		pmm = ENVCFG_PMM_PMLEN_0;
+	else if (pmlen <= PMLEN_7 && have_user_pmlen_7)
+		pmm = ENVCFG_PMM_PMLEN_7;
+	else if (pmlen <= PMLEN_16 && have_user_pmlen_16)
+		pmm = ENVCFG_PMM_PMLEN_16;
+	else
+		return -EINVAL;
+
+	envcfg_update_bits(task, ENVCFG_PMM, pmm);
+
+	return 0;
+}
+
+long get_tagged_addr_ctrl(struct task_struct *task)
+{
+	struct thread_info *ti = task_thread_info(task);
+	long ret = 0;
+
+	if (is_compat_thread(ti))
+		return -EINVAL;
+
+	switch (task->thread.envcfg & ENVCFG_PMM) {
+	case ENVCFG_PMM_PMLEN_7:
+		ret = FIELD_PREP(PR_PMLEN_MASK, PMLEN_7);
+		break;
+	case ENVCFG_PMM_PMLEN_16:
+		ret = FIELD_PREP(PR_PMLEN_MASK, PMLEN_16);
+		break;
+	}
+
+	return ret;
+}
+
+static bool try_to_set_pmm(unsigned long value)
+{
+	csr_set(CSR_ENVCFG, value);
+	return (csr_read_clear(CSR_ENVCFG, ENVCFG_PMM) & ENVCFG_PMM) == value;
+}
+
+static int __init tagged_addr_init(void)
+{
+	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
+		return 0;
+
+	/*
+	 * envcfg.PMM is a WARL field. Detect which values are supported.
+	 * Assume the supported PMLEN values are the same on all harts.
+	 */
+	csr_clear(CSR_ENVCFG, ENVCFG_PMM);
+	have_user_pmlen_7 = try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
+	have_user_pmlen_16 = try_to_set_pmm(ENVCFG_PMM_PMLEN_16);
+
+	return 0;
+}
+core_initcall(tagged_addr_init);
+#endif	/* CONFIG_RISCV_ISA_SUPM */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 35791791a879..6e84c827869b 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -244,6 +244,9 @@ struct prctl_mm_map {
 # define PR_MTE_TAG_MASK		(0xffffUL << PR_MTE_TAG_SHIFT)
 /* Unused; kept only for source compatibility */
 # define PR_MTE_TCF_SHIFT		1
+/* RISC-V pointer masking tag length */
+# define PR_PMLEN_SHIFT			24
+# define PR_PMLEN_MASK			(0x7fUL << PR_PMLEN_SHIFT)
 
 /* Control reclaim behavior when allocating memory */
 #define PR_SET_IO_FLUSHER		57
-- 
2.45.1


