Return-Path: <linux-kernel+bounces-204894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79B38FF4C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE00B26E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8424481C4;
	Thu,  6 Jun 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XGfxfz1h"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F0E45023
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698778; cv=none; b=XtRrk1itkHPspDZUUeg9eAgT8rr+Rbyaek0G2Gp29g1sDToCG3/a3PILnAjVFGwKsLvs3Epk7DzBmbbHEcp5n5tNcFtx3X1GB8e/xW0N8+yoYdHE0CzwXF3F6kh88i0F5xOicX3TDIeDKbGq219EbK1393HwPk/j8hvaNOYWR8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698778; c=relaxed/simple;
	bh=R9e+OJonG9hTJudPVCEGrHNRbNb8rze+vl5k6pesrRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5D460OEckzw/hmPbyLVRvh+GZue/ytJtTK4ls+AWq+oG+0PMuZdxXyusfmNfAMeWZ68xPvCnGpRtCHjFzyX7PkZ2Ydrl6TCLCJgLE1efH0VkVj9iVOOsmd5b3t6nWZCyYjihBOeVkD/soSULBuV+D4luw7zq7AZTW6Re1uWC2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XGfxfz1h; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-703ed15b273so1084284b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717698776; x=1718303576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTCo6iw3qYCJOh6dWog5zUrd/3sc/6HIZQBQ6tsnado=;
        b=XGfxfz1h3MF4ti55yOEG3Fv2YJau1Aa3CZ57s87x4HwNezIpBgposYma1IH6tnI0mv
         XUaXuizXxNsLjc8q1gQbRwiwSw4/0PcbGyJmmzbLHWWEP6CkMzDqlpwypWC4rmrf13uL
         z3E0e+tipiZL/9Ox4XRGnCBHu1xiLT91H66rImhHLpWDlhi2/J39wkAvgA3LYLObMoO1
         InvDfUf5gnTqRoIhuDlO2fBRbKdMC7FZiIJipxZaJWrMCMkJQBwB3AX0+o91iDlaQiCs
         d2OFfwobZxRD+GUBqzHnbGfhMwUIXWQWcSlU+OjE8ccGKuFFT7u1kaXiMzl10q8wGGdC
         MRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717698776; x=1718303576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTCo6iw3qYCJOh6dWog5zUrd/3sc/6HIZQBQ6tsnado=;
        b=ud8jK6B8Rm4+7Kxol2Rsax3Xon49IA2PkcTsfIok+oImkmbwhIIOpGtEU5WUMO4Sep
         6JnfpOulCJdDblYcyeqtUJvVCYd0xv2FpLrtXRmlmh7AzXG40VEnnu6CQ17pmy0LcsDf
         308oUj1SXrw6GM6LwtZhx7GKlH0ipgBDNwTIe9Qw6SXHpfcR/r97Oxa1fjpD6wN9fDOG
         ngWAlKiuaE5Fj1y5/x1LF/zarP9DwIJB8tADCvUpCFLiikzQt+lQ/OypzZekhWy4KYli
         nzQh8oc+Gu4DM5hzIeEnhWqJzJq0ThFUfmH4XJYhoOfforWQhHeU+vggk7qEqjMXkM6d
         omlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMbJPyqsqXIm8IeEyN5TArRwI9RPy+6TPjlL1RVv1Cy/p4AhdM12Foy2gygsaDt3cgx0h9WzdsJav51FVYjxyaqGA6NQrRRRUQPMJP
X-Gm-Message-State: AOJu0YzM/mxn3Bah6GJcO3cnuGQheawDwxXwZtwTa4c9j4y/CTmwXPvY
	jPNwN1qTSQy/0K1X6N8JquCCM0Gkjx63Uzw65aPvParrqRfJPVGGCqS4UePMQn8=
X-Google-Smtp-Source: AGHT+IEy5nJyoQhR8PCml6MnPCvzafczRf8zu1KTTmbIZw4PXOhL3vYyCL85RpQksfdkL3hG+FuEHQ==
X-Received: by 2002:a05:6a00:4fc3:b0:702:1be9:eb37 with SMTP id d2e1a72fcca58-7040c74dac4mr265187b3a.28.1717698775902;
        Thu, 06 Jun 2024 11:32:55 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd50f0c6sm1378400b3a.191.2024.06.06.11.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:32:55 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Guo Ren <guoren@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Erick Archer <erick.archer@gmx.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] RISC-V: Report vector unaligned accesse speed hwprobe
Date: Thu,  6 Jun 2024 14:32:15 -0400
Message-ID: <20240606183215.416829-3-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606183215.416829-1-jesse@rivosinc.com>
References: <20240606183215.416829-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detect if vector misaligned accesses are faster or slower than
equivalent vector byte accesses. This is useful for usermode to know
whether vector byte accesses or vector misaligned accesses have a better
bandwidth for operations like memcpy.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 arch/riscv/kernel/Makefile                 |   3 +
 arch/riscv/kernel/copy-unaligned.h         |   5 +
 arch/riscv/kernel/unaligned_access_speed.c | 127 ++++++++++++++++++++-
 arch/riscv/kernel/vec-copy-unaligned.S     |  58 ++++++++++
 4 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 81d94a8ee10f..61cec0688559 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -65,6 +65,9 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
 obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
 obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
 obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
+ifeq ($(CONFIG_RISCV_ISA_V), y)
+obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= vec-copy-unaligned.o
+endif
 
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
diff --git a/arch/riscv/kernel/copy-unaligned.h b/arch/riscv/kernel/copy-unaligned.h
index e3d70d35b708..88be070085cb 100644
--- a/arch/riscv/kernel/copy-unaligned.h
+++ b/arch/riscv/kernel/copy-unaligned.h
@@ -10,4 +10,9 @@
 void __riscv_copy_words_unaligned(void *dst, const void *src, size_t size);
 void __riscv_copy_bytes_unaligned(void *dst, const void *src, size_t size);
 
+#ifdef CONFIG_RISCV_ISA_V
+void __riscv_copy_vec_words_unaligned(void *dst, const void *src, size_t size);
+void __riscv_copy_vec_bytes_unaligned(void *dst, const void *src, size_t size);
+#endif
+
 #endif /* __RISCV_KERNEL_COPY_UNALIGNED_H */
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 92a84239beaa..4e6f753b659a 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -8,9 +8,11 @@
 #include <linux/jump_label.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
+#include <linux/kthread.h>
 #include <linux/types.h>
 #include <asm/cpufeature.h>
 #include <asm/hwprobe.h>
+#include <asm/vector.h>
 
 #include "copy-unaligned.h"
 
@@ -128,6 +130,107 @@ static void check_unaligned_access_nonboot_cpu(void *param)
 		check_unaligned_access(pages[cpu]);
 }
 
+#ifdef CONFIG_RISCV_ISA_V
+static void check_vector_unaligned_access(struct work_struct *unused)
+{
+	int cpu = smp_processor_id();
+	u64 start_cycles, end_cycles;
+	u64 word_cycles;
+	u64 byte_cycles;
+	int ratio;
+	unsigned long start_jiffies, now;
+	struct page *page;
+	void *dst;
+	void *src;
+	long speed = RISCV_HWPROBE_VEC_MISALIGNED_SLOW;
+
+	if (per_cpu(vector_misaligned_access, cpu) != RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED)
+		return;
+
+	page = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
+	if (!page) {
+		pr_warn("Allocation failure, not measuring vector misaligned performance\n");
+		return;
+	}
+
+	/* Make an unaligned destination buffer. */
+	dst = (void *)((unsigned long)page_address(page) | 0x1);
+	/* Unalign src as well, but differently (off by 1 + 2 = 3). */
+	src = dst + (MISALIGNED_BUFFER_SIZE / 2);
+	src += 2;
+	word_cycles = -1ULL;
+
+	/* Do a warmup. */
+	local_irq_enable();
+	kernel_vector_begin();
+	__riscv_copy_vec_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+
+	start_jiffies = jiffies;
+	while ((now = jiffies) == start_jiffies)
+		cpu_relax();
+
+	/*
+	 * For a fixed amount of time, repeatedly try the function, and take
+	 * the best time in cycles as the measurement.
+	 */
+	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
+		start_cycles = get_cycles64();
+		/* Ensure the CSR read can't reorder WRT to the copy. */
+		mb();
+		__riscv_copy_vec_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+		/* Ensure the copy ends before the end time is snapped. */
+		mb();
+		end_cycles = get_cycles64();
+		if ((end_cycles - start_cycles) < word_cycles)
+			word_cycles = end_cycles - start_cycles;
+	}
+
+	byte_cycles = -1ULL;
+	__riscv_copy_vec_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+	start_jiffies = jiffies;
+	while ((now = jiffies) == start_jiffies)
+		cpu_relax();
+
+	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
+		start_cycles = get_cycles64();
+		mb();
+		__riscv_copy_vec_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+		mb();
+		end_cycles = get_cycles64();
+		if ((end_cycles - start_cycles) < byte_cycles)
+			byte_cycles = end_cycles - start_cycles;
+	}
+
+	kernel_vector_end();
+
+	/* Don't divide by zero. */
+	if (!word_cycles || !byte_cycles) {
+		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned vector access speed\n",
+			cpu);
+
+		return;
+	}
+
+	if (word_cycles < byte_cycles)
+		speed = RISCV_HWPROBE_VEC_MISALIGNED_FAST;
+
+	ratio = div_u64((byte_cycles * 100), word_cycles);
+	pr_info("cpu%d: Ratio of vector byte access time to vector unaligned word access is %d.%02d, unaligned accesses are %s\n",
+		cpu,
+		ratio / 100,
+		ratio % 100,
+		(speed ==  RISCV_HWPROBE_VEC_MISALIGNED_FAST) ? "fast" : "slow");
+
+	per_cpu(vector_misaligned_access, cpu) = speed;
+}
+
+static int riscv_online_cpu_vec(unsigned int cpu)
+{
+	check_vector_unaligned_access(NULL);
+	return 0;
+}
+#endif
+
 DEFINE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
 
 static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
@@ -261,11 +364,33 @@ static int check_unaligned_access_speed_all_cpus(void)
 	return 0;
 }
 
+/* Measure unaligned access speed on all CPUs present at boot in parallel. */
+static int vec_check_unaligned_access_speed_all_cpus(void *unused)
+{
+	schedule_on_each_cpu(check_vector_unaligned_access);
+
+	/*
+	 * Setup hotplug callbacks for any new CPUs that come online or go
+	 * offline.
+	 */
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
+				  riscv_online_cpu_vec, NULL);
+
+	return 0;
+}
+
 static int check_unaligned_access_all_cpus(void)
 {
 	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
 
-	check_vector_unaligned_access_all_cpus();
+#ifdef CONFIG_RISCV_ISA_V
+	bool all_cpus_vec_supported = check_vector_unaligned_access_all_cpus();
+
+	if (all_cpus_vec_supported) {
+		kthread_run(vec_check_unaligned_access_speed_all_cpus,
+			    NULL, "thebestthread");
+	}
+#endif
 
 	if (!all_cpus_emulated)
 		return check_unaligned_access_speed_all_cpus();
diff --git a/arch/riscv/kernel/vec-copy-unaligned.S b/arch/riscv/kernel/vec-copy-unaligned.S
new file mode 100644
index 000000000000..11522ec8f0a8
--- /dev/null
+++ b/arch/riscv/kernel/vec-copy-unaligned.S
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2024 Rivos Inc. */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <linux/args.h>
+
+	.text
+
+#define WORD_EEW 64
+
+#define WORD_SEW CONCATENATE(e, WORD_EEW)
+#define VEC_L CONCATENATE(vle, WORD_EEW).v
+#define VEC_S CONCATENATE(vle, WORD_EEW).v
+
+/* void __riscv_copy_vec_words_unaligned(void *, const void *, size_t) */
+/* Performs a memcpy without aligning buffers, using word loads and stores. */
+/* Note: The size is truncated to a multiple of WORD_EEW */
+SYM_FUNC_START(__riscv_copy_vec_words_unaligned)
+	andi  a4, a2, ~(WORD_EEW-1)
+	beqz  a4, 2f
+	add   a3, a1, a4
+	.option push
+	.option arch, +v
+1:
+	vsetivli t0, 8, WORD_SEW, m8, ta, ma
+	VEC_L v0, (a1)
+	VEC_S v0, (a0)
+	addi  a0, a0, WORD_EEW
+	addi  a1, a1, WORD_EEW
+	bltu  a1, a3, 1b
+
+2:
+	.option pop
+	ret
+SYM_FUNC_END(__riscv_copy_vec_words_unaligned)
+
+/* void __riscv_copy_vec_bytes_unaligned(void *, const void *, size_t) */
+/* Performs a memcpy without aligning buffers, using only byte accesses. */
+/* Note: The size is truncated to a multiple of 8 */
+SYM_FUNC_START(__riscv_copy_vec_bytes_unaligned)
+	andi a4, a2, ~(8-1)
+	beqz a4, 2f
+	add  a3, a1, a4
+	.option push
+	.option arch, +v
+1:
+	vsetivli t0, 8, e8, m8, ta, ma
+	vle8.v v0, (a1)
+	vse8.v v0, (a0)
+	addi a0, a0, 8
+	addi a1, a1, 8
+	bltu a1, a3, 1b
+
+2:
+	.option pop
+	ret
+SYM_FUNC_END(__riscv_copy_vec_bytes_unaligned)
-- 
2.43.0


