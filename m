Return-Path: <linux-kernel+bounces-229709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AFA917308
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347C91C22BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97C31802AB;
	Tue, 25 Jun 2024 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H4JKwoKk"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DA17F516
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349785; cv=none; b=ZwSe/phBcQb4sD5D22aZMh72ibeBWkVwss0NF7hgI/hE2q96JJIM3kYU0Z2pmZGmZasgWwR4zBGagbRPUVmD/1g76N1zjAVC9aj40czq5u8PJXoHIyKqozKRRDVZL9psls1rbgrzOfxRMc9tOlsfmHM3HMb72zcnY/RFbNb9CTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349785; c=relaxed/simple;
	bh=cWVQnk23k2xUpcy9wkE1ZXToJfYCrEIqFTtRKHxTzaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abq/juFWLpC3isRRtM5QrbYd4pHX4nPIYkuBtb1FfcKaoXh3dyh0bddoe+l82ne3Xbradcj16l7aAIHFP1HBvnvF243z2JSDKqH03INrCC1kPwvNeMRRN/R+Ejx25Cv8anlkwOBq9HY/q+r0oAAmUn87BUJQwSt18ISoxZcpKHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=H4JKwoKk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f480624d0fso47410925ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719349783; x=1719954583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RHKmejM9a0vevYfMOXCLHoYWj48ZdPOlbThmmBhK0Q=;
        b=H4JKwoKkd49yaD/f186mEfjWCLbvNn/hP06C2Lq4x2d1+YNSbf2E5qwgX7z1SafPxX
         qEGRSs1OGj6jF1Vo1+iG/GbINtIzJFiezqFA7C7CD1TzFtWBiiHhEBHItVThEoY4n4RF
         e1bWFqDZ0+x1+Jotyvz+e8u4zN/kNMnc03wyQ3Z7rp48ZCYJKqHvAyPZjJW/m6qw5bpW
         /7tmKPIe8tEZNNg7Geo8G+nio+80ycOpIIB7TzQx8ZyrLNp36uqROXsqVWZsAiXJcBQT
         ual0y4+ABo/4L/ZOqm9bZc/lPeMuNM/rmu4oALAwWF9gfOWQgZ4eU4mTmj1IzhYN/cNX
         4MZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719349783; x=1719954583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RHKmejM9a0vevYfMOXCLHoYWj48ZdPOlbThmmBhK0Q=;
        b=dE+4zgiwuyLxiiOd/zGu2ZAULUUQ6qwXCklfrf7Le3KdjtkoY5SuEBgvKAfSq3PLaJ
         BhYAmDz+AiGVRpZMWs+F8FPBS91IeDCFtXMQ+Z80BLOpVUQTloKesZdx66mEcw4HFs0Q
         T7fdMy+/OX3ulso/m5TO2eCOMYt+3Y9vNGGcC8k+Hgd7lxIS7/NrVIbNFmVtl7pOEjDi
         nDGzJGNcuYZOVUnchbZmVx1wLsJzAOXMeZwPtazEmESBBWiXG+J+prSxvBKqu4t4ress
         GZqJKZvti5lAS0tcoIzAtrjDv83VOF+NqeDEccoeQhkqtevFBYAp8dUpPYl6+3526v23
         ciNA==
X-Forwarded-Encrypted: i=1; AJvYcCWir8yBaBaylJpD8Y1dkCUsFa69VYrhj/XiA49wKVTyjPlWzqFQ5cO2/O2PO9m9/JlyDAGh8rnpzBQKTL+xvnqBLW3RIUCQUImOBSMu
X-Gm-Message-State: AOJu0YyHAFdpXw6OoXo7FIie7v+oxSUP5308Z+RwVOwL8UHMbYf/5DIk
	suE3fnwVyGw3ZslKBxrt7UqAQc2Il1EVItPVjIhS/jYMw/bZkYcFKuW5PP70pV4=
X-Google-Smtp-Source: AGHT+IH/DMRd777ZSRsWNFii7RZFNgZupCFLnI/6nswVeiRDaQZIaz+Y8uQB+pMOl2GL7EuQdKoZrw==
X-Received: by 2002:a17:902:c943:b0:1fa:2210:4562 with SMTP id d9443c01a7336-1fa23fd8a00mr103679455ad.29.1719349782852;
        Tue, 25 Jun 2024 14:09:42 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb328f57sm85873455ad.110.2024.06.25.14.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:09:42 -0700 (PDT)
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
Subject: [PATCH v2 04/10] riscv: Add support for userspace pointer masking
Date: Tue, 25 Jun 2024 14:09:15 -0700
Message-ID: <20240625210933.1620802-5-samuel.holland@sifive.com>
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

RISC-V supports pointer masking with a variable number of tag bits
(which is called "PMLEN" in the specification) and which is configured
at the next higher privilege level.

Wire up the PR_SET_TAGGED_ADDR_CTRL and PR_GET_TAGGED_ADDR_CTRL prctls
so userspace can request a lower bound on the  number of tag bits and
determine the actual number of tag bits. As with arm64's
PR_TAGGED_ADDR_ENABLE, the pointer masking configuration is
thread-scoped, inherited on clone() and fork() and cleared on execve().

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Rebase on riscv/linux.git for-next
 - Add and use the envcfg_update_bits() helper function
 - Inline flush_tagged_addr_state()

 arch/riscv/Kconfig                 | 11 ++++
 arch/riscv/include/asm/processor.h |  8 +++
 arch/riscv/include/asm/switch_to.h | 11 ++++
 arch/riscv/kernel/process.c        | 99 ++++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h         |  3 +
 5 files changed, 132 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b94176e25be1..8f9980f81ea5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -505,6 +505,17 @@ config RISCV_ISA_C
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_POINTER_MASKING
+	bool "Smmpm, Smnpm, and Ssnpm extensions for pointer masking"
+	depends on 64BIT
+	default y
+	help
+	  Add support for the pointer masking extensions (Smmpm, Smnpm,
+	  and Ssnpm) when they are detected at boot.
+
+	  If this option is disabled, userspace will be unable to use
+	  the prctl(PR_{SET,GET}_TAGGED_ADDR_CTRL) API.
+
 config RISCV_ISA_SVNAPOT
 	bool "Svnapot extension support for supervisor mode NAPOT pages"
 	depends on 64BIT && MMU
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 0838922bd1c8..4f99c85d29ae 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -194,6 +194,14 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
 extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
 
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
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
index e4bc61c4e58a..dec5ccc44697 100644
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
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
+		envcfg_update_bits(current, ENVCFG_PMM, ENVCFG_PMM_PMLEN_0);
+#endif
 }
 
 void arch_release_task_struct(struct task_struct *tsk)
@@ -233,3 +238,97 @@ void __init arch_task_cache_init(void)
 {
 	riscv_v_setup_ctx_cache();
 }
+
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
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
+	pmlen = FIELD_GET(PR_PMLEN_MASK, arg);
+	if (pmlen > 16) {
+		return -EINVAL;
+	} else if (pmlen > 7) {
+		if (have_user_pmlen_16)
+			pmlen = 16;
+		else
+			return -EINVAL;
+	} else if (pmlen > 0) {
+		/*
+		 * Prefer the smallest PMLEN that satisfies the user's request,
+		 * in case choosing a larger PMLEN has a performance impact.
+		 */
+		if (have_user_pmlen_7)
+			pmlen = 7;
+		else if (have_user_pmlen_16)
+			pmlen = 16;
+		else
+			return -EINVAL;
+	}
+
+	if (pmlen == 7)
+		pmm = ENVCFG_PMM_PMLEN_7;
+	else if (pmlen == 16)
+		pmm = ENVCFG_PMM_PMLEN_16;
+	else
+		pmm = ENVCFG_PMM_PMLEN_0;
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
+		ret |= FIELD_PREP(PR_PMLEN_MASK, 7);
+		break;
+	case ENVCFG_PMM_PMLEN_16:
+		ret |= FIELD_PREP(PR_PMLEN_MASK, 16);
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
+#endif	/* CONFIG_RISCV_ISA_POINTER_MASKING */
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
2.44.1


