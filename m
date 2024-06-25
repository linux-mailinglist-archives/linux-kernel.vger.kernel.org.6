Return-Path: <linux-kernel+bounces-228124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FA9915B37
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C531C215F2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D727175B1;
	Tue, 25 Jun 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gpRfufki"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5839FD6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276710; cv=none; b=DplrvI9VotTDTLrVwq1JYUvtSz6BpwWBb0rEZQSlviMgMyHUKZj1zZfY0gBhijiRZMC6Z8mAgGZgfUIpRypv1ezbYnOejX+U4HjRn/Pdj8he/jY8VhdN0AvH7a7vIcRpByH2EjIuajPzZVFtp3Z54i2HJFmb8eUu6S6JkuMBzSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276710; c=relaxed/simple;
	bh=/L0vGxuwQ0qSeTf3zyxcaII06c/gXujCLWjDgKpFcLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJjL0G2fjT8Wp1GGKcc3pTmp77jJHj42CBBMRU81LcHyvtS+u3mqpZHSu55dL3q8nCvneqB247oexAFzRb0wIG+sWyAtSviotYpdnRqINguEejwnSQZvzqto93Z+szb0O9CCV7SHZJtY11/fEVd9Dc+cwnX4+V3E9MGzMEq0+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gpRfufki; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7066c9741b7so1606571b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719276707; x=1719881507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKl6zIDaJ/Av5Rwcnw+etMZXm6iL8TVMqp6HLgQqRb4=;
        b=gpRfufkiY4tBUZ6wJjeKLVkDEgYnbKrpzSiig1IMIEpzsq/ZjoLd9uEVcW6/OtpRrH
         W4MhqzSG33PO2AnCEjyskgqLJhQQ4LJWMaE+4W9rvFO09haC8YY9r2Kvihmfz+XBcvmD
         +v9QyL+slV5OPKW2GydavGFKp3h4reyPpUU4CQ3C3sjawdy5D45lpS9/7fQTw5I6JUvK
         ygR+s/liY6+7hUHwULXAfDONGK8GjAeGrnvfMzgXDG6FazwHkfi/p4uSJLO+cZBdvLID
         DSUeG5WyHL0xrCRyw8ldM4sk/rePO6zh14lEmSnySXeXDkbsYjAGI8m9pkxyf+65x048
         MOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719276707; x=1719881507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKl6zIDaJ/Av5Rwcnw+etMZXm6iL8TVMqp6HLgQqRb4=;
        b=dso2I2HU3GHVYW4IeUgTHPAfQfHnD6m2KREe1AoJY0wCqd+fwwS8e6O6Aw/Y6AgwP6
         6KSPOUUaTLfy3JJAovc1WBuPJjWgkQIT5vwG7kePdKWGq9shyPLfl8QlWgz5qo+/i1lM
         wUx9XXzMAC9sLWt+sqh2rfTTyhFFlMxRb8v7BLASs9lYcfUSn016AcXNZo9Pl+N/WGxR
         WQbxEsWDHGJ+2dTfptF11t7P1qVxTjqyIHdgLX8UCk8HEp3DeQ4xHvqeiqP/fsaoGzja
         SZiDNrR2NpBsBNLHnG4Mn4xp0mXzyq42k+Q8PYbJvniVI0S3OAe0NMGjs7HUdfk6oBAs
         swBw==
X-Forwarded-Encrypted: i=1; AJvYcCWD1xE1n8CYvblFrWroKq1vsaqpiqetAX9N5lWtgWy6RhIdwKTJl6s7M3BdXqR7qDuRn4xPlTIA3QDAbh45DLD1sK++Zt6+PUsEiexe
X-Gm-Message-State: AOJu0YxMGO9Ru+alLoBhR1dZjaaZKyTjLsoHlQUD5EGjEazOejUMjFxU
	hm6/lW6kIkQyVUAj/bWnzVJqP0mtAjUD3bTeaNYU8KtCLJIc1VLYLhom891lIuI=
X-Google-Smtp-Source: AGHT+IG7makXmY+D39VjvdE+J+r7ZeCxtrYsv+Y9WTpDUJ1QDs72R7ahLQSLrIfF4IVjTeLNQIw48w==
X-Received: by 2002:a05:6a20:be09:b0:1bd:a39:df8c with SMTP id adf61e73a8af0-1bd0a39e16dmr3173556637.49.1719276706766;
        Mon, 24 Jun 2024 17:51:46 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb2a7csm68150235ad.256.2024.06.24.17.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 17:51:46 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 6/8] RISC-V: Detect unaligned vector accesses supported
Date: Mon, 24 Jun 2024 20:49:59 -0400
Message-ID: <20240625005001.37901-7-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625005001.37901-1-jesse@rivosinc.com>
References: <20240625005001.37901-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run a unaligned vector access to test if the system supports
vector unaligned access. Add the result to a new key in hwprobe.
This is useful for usermode to know if vector misaligned accesses are
supported and if they are faster or slower than equivalent byte accesses.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
V1 -> V2:
 - Add Kconfig options
 - Add insn_is_vector
 - Add handle_vector_misaligned_load
 - Fix build
 - Seperate vector from scalar misaligned access
 - This patch was almost completely rewritten
V2 -> V3:
 - Fixed CONFIG_ in Kconfig
 - Fixed check_vector_unaligned_access_emulated leaving
     vector_misaligned_access as unknown.
 - Remove local_irq_enable
 - Remove RISCV_DETECT_VECTOR_UNALIGNED_ACCESS
 - Remove RISCV_VEC_UNALIGNED_ACCESS_UNSUPPORTED
---
 arch/riscv/Kconfig                         |  35 ++++++
 arch/riscv/include/asm/cpufeature.h        |   5 +
 arch/riscv/include/asm/entry-common.h      |  11 --
 arch/riscv/include/asm/hwprobe.h           |   2 +-
 arch/riscv/include/asm/vector.h            |   1 +
 arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
 arch/riscv/kernel/Makefile                 |   4 +-
 arch/riscv/kernel/sys_hwprobe.c            |  35 ++++++
 arch/riscv/kernel/traps_misaligned.c       | 120 ++++++++++++++++++++-
 arch/riscv/kernel/unaligned_access_speed.c |   9 +-
 arch/riscv/kernel/vector.c                 |   2 +-
 11 files changed, 209 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 34d24242e37a..ffbe0fdd7fb3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -717,12 +717,26 @@ config THREAD_SIZE_ORDER
 	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
 	  affects irq stack size, which is equal to thread stack size.
 
+config RISCV_MISALIGNED
+	bool
+	help
+	  Embed support for detecting and emulating misaligned
+	  scalar or vector loads and stores.
+
 config RISCV_SCALAR_MISALIGNED
 	bool
+	select RISCV_MISALIGNED
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	help
 	  Embed support for emulating misaligned loads and stores.
 
+config RISCV_VECTOR_MISALIGNED
+	bool
+	select RISCV_MISALIGNED
+	depends on RISCV_ISA_V
+	help
+	  Enable detecting support for vector misaligned loads and stores.
+
 choice
 	prompt "Unaligned Accesses Support"
 	default RISCV_PROBE_UNALIGNED_ACCESS
@@ -774,6 +788,27 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
 
 endchoice
 
+choice
+	prompt "Vector unaligned Accesses Support"
+	depends on RISCV_ISA_V
+	default RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
+	help
+	  This determines the level of support for vector unaligned accesses. This
+	  information is used by the kernel to perform optimizations. It is also
+	  exposed to user space via the hwprobe syscall. The hardware will be
+	  probed at boot by default.
+
+config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
+	bool "Probe speed of vector unaligned accesses"
+	select RISCV_VECTOR_MISALIGNED
+	help
+	  During boot, the kernel will run a series of tests to determine the
+	  speed of vector unaligned accesses if they are supported. This probing
+	  will dynamically determine the speed of vector unaligned accesses on
+	  the underlying system if they are supported.
+
+endchoice
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 0ed7d99c14dd..f25f56f9bfaa 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -45,6 +45,11 @@ static inline bool unaligned_ctl_available(void)
 }
 #endif
 
+bool check_vector_unaligned_access_emulated_all_cpus(void);
+#if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
+DECLARE_PER_CPU(long, vector_misaligned_access);
+#endif
+
 #if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
 DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
 
diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index 0a4e3544c877..7b32d2b08bb6 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -25,18 +25,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 void handle_page_fault(struct pt_regs *regs);
 void handle_break(struct pt_regs *regs);
 
-#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
 int handle_misaligned_load(struct pt_regs *regs);
 int handle_misaligned_store(struct pt_regs *regs);
-#else
-static inline int handle_misaligned_load(struct pt_regs *regs)
-{
-	return -1;
-}
-static inline int handle_misaligned_store(struct pt_regs *regs)
-{
-	return -1;
-}
-#endif
 
 #endif /* _ASM_RISCV_ENTRY_COMMON_H */
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 150a9877b0af..ef01c182af2b 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 7
+#define RISCV_HWPROBE_MAX_KEY 8
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index be7d309cca8a..99b0f91db9ee 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -21,6 +21,7 @@
 
 extern unsigned long riscv_v_vsize;
 int riscv_v_setup_vsize(void);
+bool insn_is_vector(u32 insn_buf);
 bool riscv_v_first_use_handler(struct pt_regs *regs);
 void kernel_vector_begin(void);
 void kernel_vector_end(void);
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 023b7771d1b7..2fee870e41bb 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -75,6 +75,11 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
 #define RISCV_HWPROBE_KEY_MISALIGNED_PERF	7
+#define RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF	8
+#define		RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN		0
+#define		RISCV_HWPROBE_VEC_MISALIGNED_SLOW		2
+#define		RISCV_HWPROBE_VEC_MISALIGNED_FAST		3
+#define		RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED	4
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 8d4e7d40e42f..5b243d46f4b1 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -62,8 +62,8 @@ obj-y	+= probes/
 obj-y	+= tests/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
-obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)	+= traps_misaligned.o
-obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)	+= unaligned_access_speed.o
+obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
+obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
 obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
 
 obj-$(CONFIG_FPU)		+= fpu.o
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index e910e2971984..5b78ea5a84d1 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -194,6 +194,37 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
 }
 #endif
 
+#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
+static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
+{
+	int cpu;
+	u64 perf = -1ULL;
+
+	/* Return if supported or not even if speed wasn't probed */
+	for_each_cpu(cpu, cpus) {
+		int this_perf = per_cpu(vector_misaligned_access, cpu);
+
+		if (perf == -1ULL)
+			perf = this_perf;
+
+		if (perf != this_perf) {
+			perf = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
+			break;
+		}
+	}
+
+	if (perf == -1ULL)
+		return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
+
+	return perf;
+}
+#else
+static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
+{
+	return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
+}
+#endif
+
 static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 			     const struct cpumask *cpus)
 {
@@ -222,6 +253,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		pair->value = hwprobe_misaligned(cpus);
 		break;
 
+	case RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF:
+		pair->value = hwprobe_vec_misaligned(cpus);
+		break;
+
 	case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
 		pair->value = 0;
 		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 8fadbe00dd62..55c43962115f 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -16,6 +16,7 @@
 #include <asm/entry-common.h>
 #include <asm/hwprobe.h>
 #include <asm/cpufeature.h>
+#include <asm/vector.h>
 
 #define INSN_MATCH_LB			0x3
 #define INSN_MASK_LB			0x707f
@@ -322,12 +323,37 @@ union reg_data {
 	u64 data_u64;
 };
 
-static bool unaligned_ctl __read_mostly;
-
 /* sysctl hooks */
 int unaligned_enabled __read_mostly = 1;	/* Enabled by default */
 
-int handle_misaligned_load(struct pt_regs *regs)
+#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
+static int handle_vector_misaligned_load(struct pt_regs *regs)
+{
+	unsigned long epc = regs->epc;
+	unsigned long insn;
+
+	if (get_insn(regs, epc, &insn))
+		return -1;
+
+	/* Only return 0 when in check_vector_unaligned_access_emulated */
+	if (*this_cpu_ptr(&vector_misaligned_access) == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN) {
+		*this_cpu_ptr(&vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
+		regs->epc = epc + INSN_LEN(insn);
+		return 0;
+	}
+
+	/* If vector instruction we don't emulate it yet */
+	regs->epc = epc;
+	return -1;
+}
+#else
+static int handle_vector_misaligned_load(struct pt_regs *regs)
+{
+	return -1;
+}
+#endif
+
+static int handle_scalar_misaligned_load(struct pt_regs *regs)
 {
 	union reg_data val;
 	unsigned long epc = regs->epc;
@@ -435,7 +461,7 @@ int handle_misaligned_load(struct pt_regs *regs)
 	return 0;
 }
 
-int handle_misaligned_store(struct pt_regs *regs)
+static int handle_scalar_misaligned_store(struct pt_regs *regs)
 {
 	union reg_data val;
 	unsigned long epc = regs->epc;
@@ -526,6 +552,86 @@ int handle_misaligned_store(struct pt_regs *regs)
 	return 0;
 }
 
+int handle_misaligned_load(struct pt_regs *regs)
+{
+	unsigned long epc = regs->epc;
+	unsigned long insn;
+
+	if (IS_ENABLED(CONFIG_RISCV_VECTOR_MISALIGNED)) {
+		if (get_insn(regs, epc, &insn))
+			return -1;
+
+		if (insn_is_vector(insn))
+			return handle_vector_misaligned_load(regs);
+	}
+
+	if (IS_ENABLED(CONFIG_RISCV_SCALAR_MISALIGNED))
+		return handle_scalar_misaligned_load(regs);
+
+	return -1;
+}
+
+int handle_misaligned_store(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_RISCV_SCALAR_MISALIGNED))
+		return handle_scalar_misaligned_store(regs);
+
+	return -1;
+}
+
+#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
+static void check_vector_unaligned_access_emulated(struct work_struct *unused)
+{
+	long *mas_ptr = this_cpu_ptr(&vector_misaligned_access);
+	unsigned long tmp_var;
+
+	*mas_ptr = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
+
+	kernel_vector_begin();
+	__asm__ __volatile__ (
+		".balign 4\n\t"
+		".option push\n\t"
+		".option arch, +zve32x\n\t"
+		"       vsetivli zero, 1, e16, m1, ta, ma\n\t"	// Vectors of 16b
+		"       vle16.v v0, (%[ptr])\n\t"		// Load bytes
+		".option pop\n\t"
+		: : [ptr] "r" ((u8 *)&tmp_var + 1) : "v0");
+	kernel_vector_end();
+
+	if (*mas_ptr == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN)
+		*mas_ptr = RISCV_HWPROBE_VEC_MISALIGNED_SLOW;
+}
+
+bool check_vector_unaligned_access_emulated_all_cpus(void)
+{
+	int cpu;
+
+	if (!has_vector()) {
+		for_each_online_cpu(cpu)
+			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
+		return false;
+	}
+
+	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
+
+	for_each_online_cpu(cpu)
+		if (per_cpu(vector_misaligned_access, cpu)
+		    != RISCV_HWPROBE_VEC_MISALIGNED_SLOW)
+			return false;
+
+	return true;
+}
+#else
+bool check_vector_unaligned_access_emulated_all_cpus(void)
+{
+	return false;
+}
+#endif
+
+#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
+
+static bool unaligned_ctl __read_mostly;
+
 static void check_unaligned_access_emulated(struct work_struct *unused)
 {
 	int cpu = smp_processor_id();
@@ -563,3 +669,9 @@ bool unaligned_ctl_available(void)
 {
 	return unaligned_ctl;
 }
+#else
+bool check_unaligned_access_emulated_all_cpus(void)
+{
+	return false;
+}
+#endif
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 329fd289b5c8..8489e012cf23 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -19,7 +19,8 @@
 #define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
 #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
 
-DEFINE_PER_CPU(long, misaligned_access_speed);
+DEFINE_PER_CPU(long, misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+DEFINE_PER_CPU(long, vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
 
 #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
 static cpumask_t fast_misaligned_access;
@@ -273,12 +274,18 @@ static int check_unaligned_access_all_cpus(void)
 
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
 		for_each_online_cpu(cpu) {
+#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
+			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_FAST;
+#endif
+#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
 			per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_FAST;
+#endif
 		}
 		return 0;
 	}
 
 	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
+	check_vector_unaligned_access_emulated_all_cpus();
 
 	if (!all_cpus_emulated)
 		return check_unaligned_access_speed_all_cpus();
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 682b3feee451..821818886fab 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -66,7 +66,7 @@ void __init riscv_v_setup_ctx_cache(void)
 #endif
 }
 
-static bool insn_is_vector(u32 insn_buf)
+bool insn_is_vector(u32 insn_buf)
 {
 	u32 opcode = insn_buf & __INSN_OPCODE_MASK;
 	u32 width, csr;
-- 
2.45.2


