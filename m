Return-Path: <linux-kernel+bounces-292926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A895768B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B550A287537
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F881DC468;
	Mon, 19 Aug 2024 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QR8IyGaQ"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE41DF67D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102795; cv=none; b=lJyuwXTGeqeFhs38qJkpCSLWjG6pD1Ygx/6guFIacLRhdOWa3cE4dy2m0CXJEv2KaMk/jTOE6e+e3kvr3bmQpSzNcwWx9rA4abntYRKEQhKMlih8CSkiaxtQHAKzJVbthKgFHs0zyM6EmuaAxJfQHcGkXviNoXWEYF8YIUqfLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102795; c=relaxed/simple;
	bh=65FjMvpWK6pOmzSWRhWE96u1Dks/QD52GcQ9qM9wnUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufiWGqV7r10z+bI56rjV7Ox52nzT7FZrq9UoEAwWYRIsEvfj4txMtb0SXXSNNs0fuhEjMvd58s53iCLbrmxtN+RQHZF33cbRP5Z62jD8Qk0d7IBNH8eZHGuJX/hA52lxndbjytVXKDIHbTcTSrkAVcoOg18Wq/3jhzIzAZMAD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QR8IyGaQ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db18102406so2823377b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724102792; x=1724707592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoedwrdccGwiE+xs3I6VP8xMYKSThY3sZJOIZoXbLok=;
        b=QR8IyGaQQmonyW+dkTgOd9kmjsCRbEmxOFCbc+TQR88sEGDsnhyxWNsnGwoSRNRXOV
         YZV0243hJ8qbeS8ZCPGxeyHpgP7Hg1+PNewIpvDs1QEfYg/03yphG2YJldpQJU4rFcqT
         +eQee1gSLEAO+Q+HQFmxg6Txzy3wpi1rvmtY/XGdqRbGqEZ9TER9pU0bEayXD41eas8d
         DYJCrshSCMuE2uB9Rp5VE3OSTcZ5mO5I9WCEHUx9nM+rSlHcGQ7bUiHpvvWfuekeYEI1
         zLK1rK/CBqu5+QqZ6GQZRF5NEieXOb1b6jmMZT+cCcslMb0wlKDblmnZTpr9pc+sftKT
         mRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724102792; x=1724707592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoedwrdccGwiE+xs3I6VP8xMYKSThY3sZJOIZoXbLok=;
        b=loRbBSTVmB/PMY/bSABpYSG9EsAqpx45SoteJwFGf3VlXq92SeRJfYb6w5r8pW/jS5
         Bpis3mFTdKW3VWfgRZVv6wsp1n+2BkMQH58AxJc/WNrGZFhu/hgQZ73/N8oFpLxawTTM
         j4OmfFBCAZodyXLZ+3bH4RjCDHQYn/dvBnk9i2d+h4S0gnHcoTarvq2q3tDpz/ISGTJM
         Z2h7jXRLXZsn7stHBeG6b4hK/uFaLggsL4ogNnMszVUzZwC7xvkB7+EXDNoEbkbRITIX
         V7WdLtBPk+RWTk1i5g24fDbur9SE7QDYfGCcSvZZXgRbEMV2gl00SOfPglBtOUZu+03v
         V7eg==
X-Forwarded-Encrypted: i=1; AJvYcCUo/Emb6DyS1HWhVD4iatZgwhGpw0LFo8pyRCXP9jEaka8hDyIlw3+/efk1hi3URLJ7niPmGT+ocdOpu9QsZTZ0iqXyKKdbx6A0QLqe
X-Gm-Message-State: AOJu0YyULk3oDjmtmlS8bW5flHbnYrpLSKXRC/fVStFJbAHNpPNTG5jb
	nqC7HTzDFM04w78jsbldobT563hR+7uQsA9Bhoqb8M4wCKlj4LLmxFb6mqPbkP8=
X-Google-Smtp-Source: AGHT+IGr1wlSv485UzGz6Iwqb6HOIdxpbAZAU1t6cYYdnjCdTjgnNS+idk7E+1R7eSqC0BtXm14x4Q==
X-Received: by 2002:a05:6808:1393:b0:3dc:15b9:3319 with SMTP id 5614622812f47-3dd3ae23b26mr13832654b6e.51.1724102792449;
        Mon, 19 Aug 2024 14:26:32 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61e7bd1sm7004694a12.53.2024.08.19.14.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:26:32 -0700 (PDT)
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
Subject: [PATCH v8 5/6] RISC-V: Report vector unaligned access speed hwprobe
Date: Mon, 19 Aug 2024 17:26:04 -0400
Message-ID: <20240819212605.1837175-6-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819212605.1837175-1-jesse@rivosinc.com>
References: <20240819212605.1837175-1-jesse@rivosinc.com>
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
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
V1 -> V2:
 - Add Kconfig options
 - Add WORD_EEW to vec-copy-unaligned.S
V2 -> V3:
 - Remove unnecessary comment
 - Remove local_irq_enable
V3 -> V4:
 - Add preempt_disable/enable
 - Alphabetize includes in vec-copy-unaligned.S and unaligned_access_speed.c
 - Add duplicate comments above mb() to please checkpatch
 - change all_cpus_vec_supported to all_cpus_vec_unsupported
    so speed is tested if any cpus support unaligned vector accesses
 - Spell out _VECTOR_ in macros
V4 -> V5:
 - Change void *unused to void *unused __always_unused
V5 -> V6:
 - Check for vector misaligned access support in hotplug
V6 -> V7:
 - Change SLOW to UNKNOWN when used as a placeholder
V7 -> V8:
 - Rebase onto fixes
 - s/RISCV_HWPROBE_VECTOR_MISALIGNED/RISCV_HWPROBE_MISALIGNED_VECTOR/g
---
 arch/riscv/Kconfig                         |  18 +++
 arch/riscv/kernel/Makefile                 |   3 +-
 arch/riscv/kernel/copy-unaligned.h         |   5 +
 arch/riscv/kernel/sys_hwprobe.c            |   6 +
 arch/riscv/kernel/unaligned_access_speed.c | 141 ++++++++++++++++++++-
 arch/riscv/kernel/vec-copy-unaligned.S     |  58 +++++++++
 6 files changed, 228 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3bb7bf0e9ddc..db1393ba5258 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -855,6 +855,24 @@ config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
 	  will dynamically determine the speed of vector unaligned accesses on
 	  the underlying system if they are supported.
 
+config RISCV_SLOW_VECTOR_UNALIGNED_ACCESS
+	bool "Assume the system supports slow vector unaligned memory accesses"
+	depends on NONPORTABLE
+	help
+	  Assume that the system supports slow vector unaligned memory accesses. The
+	  kernel and userspace programs may not be able to run at all on systems
+	  that do not support unaligned memory accesses.
+
+config RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
+	bool "Assume the system supports fast vector unaligned memory accesses"
+	depends on NONPORTABLE
+	help
+	  Assume that the system supports fast vector unaligned memory accesses. When
+	  enabled, this option improves the performance of the kernel on such
+	  systems. However, the kernel and userspace programs will run much more
+	  slowly, or will not be able to run at all, on systems that do not
+	  support efficient unaligned memory accesses.
+
 endchoice
 
 source "arch/riscv/Kconfig.vendor"
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 06d407f1b30b..c72ca98a1a1c 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -66,7 +66,8 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
 obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
-obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
+obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)		+= copy-unaligned.o
+obj-$(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)	+= vec-copy-unaligned.o
 
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_FPU)		+= kernel_mode_fpu.o
diff --git a/arch/riscv/kernel/copy-unaligned.h b/arch/riscv/kernel/copy-unaligned.h
index e3d70d35b708..85d4d11450cb 100644
--- a/arch/riscv/kernel/copy-unaligned.h
+++ b/arch/riscv/kernel/copy-unaligned.h
@@ -10,4 +10,9 @@
 void __riscv_copy_words_unaligned(void *dst, const void *src, size_t size);
 void __riscv_copy_bytes_unaligned(void *dst, const void *src, size_t size);
 
+#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
+void __riscv_copy_vec_words_unaligned(void *dst, const void *src, size_t size);
+void __riscv_copy_vec_bytes_unaligned(void *dst, const void *src, size_t size);
+#endif
+
 #endif /* __RISCV_KERNEL_COPY_UNALIGNED_H */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index c4c819aac69e..df420fe68c2d 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -228,6 +228,12 @@ static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
 #else
 static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
 {
+	if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS))
+		return RISCV_HWPROBE_MISALIGNED_VECTOR_FAST;
+
+	if (IS_ENABLED(CONFIG_RISCV_SLOW_VECTOR_UNALIGNED_ACCESS))
+		return RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW;
+
 	return RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN;
 }
 #endif
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 0b8b5e17453a..91f189cf1611 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -6,11 +6,13 @@
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/jump_label.h>
+#include <linux/kthread.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 #include <asm/cpufeature.h>
 #include <asm/hwprobe.h>
+#include <asm/vector.h>
 
 #include "copy-unaligned.h"
 
@@ -268,12 +270,147 @@ static int check_unaligned_access_speed_all_cpus(void)
 }
 #endif
 
+#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
+static void check_vector_unaligned_access(struct work_struct *work __always_unused)
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
+	long speed = RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW;
+
+	if (per_cpu(vector_misaligned_access, cpu) != RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN)
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
+		/* Ensure the CSR read can't reorder WRT to the copy. */
+		mb();
+		__riscv_copy_vec_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+		/* Ensure the copy ends before the end time is snapped. */
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
+		speed = RISCV_HWPROBE_MISALIGNED_VECTOR_FAST;
+
+	ratio = div_u64((byte_cycles * 100), word_cycles);
+	pr_info("cpu%d: Ratio of vector byte access time to vector unaligned word access is %d.%02d, unaligned accesses are %s\n",
+		cpu,
+		ratio / 100,
+		ratio % 100,
+		(speed ==  RISCV_HWPROBE_MISALIGNED_VECTOR_FAST) ? "fast" : "slow");
+
+	per_cpu(vector_misaligned_access, cpu) = speed;
+}
+
+static int riscv_online_cpu_vec(unsigned int cpu)
+{
+	if (!has_vector())
+		return 0;
+
+	if (per_cpu(vector_misaligned_access, cpu) != RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED)
+		return 0;
+
+	check_vector_unaligned_access_emulated(NULL);
+	check_vector_unaligned_access(NULL);
+	return 0;
+}
+
+/* Measure unaligned access speed on all CPUs present at boot in parallel. */
+static int vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
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
+#else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
+static int vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
+{
+	return 0;
+}
+#endif
+
 static int check_unaligned_access_all_cpus(void)
 {
-	bool all_cpus_emulated;
+	bool all_cpus_emulated, all_cpus_vec_unsupported;
 
 	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
-	check_vector_unaligned_access_emulated_all_cpus();
+	all_cpus_vec_unsupported = check_vector_unaligned_access_emulated_all_cpus();
+
+	if (!all_cpus_vec_unsupported &&
+	    IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
+		kthread_run(vec_check_unaligned_access_speed_all_cpus,
+			    NULL, "vec_check_unaligned_access_speed_all_cpus");
+	}
 
 	if (!all_cpus_emulated)
 		return check_unaligned_access_speed_all_cpus();
diff --git a/arch/riscv/kernel/vec-copy-unaligned.S b/arch/riscv/kernel/vec-copy-unaligned.S
new file mode 100644
index 000000000000..d16f19f1b3b6
--- /dev/null
+++ b/arch/riscv/kernel/vec-copy-unaligned.S
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2024 Rivos Inc. */
+
+#include <linux/args.h>
+#include <linux/linkage.h>
+#include <asm/asm.h>
+
+	.text
+
+#define WORD_EEW 32
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
+	.option arch, +zve32x
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
+	.option arch, +zve32x
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
2.45.2


