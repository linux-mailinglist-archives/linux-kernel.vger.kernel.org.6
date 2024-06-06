Return-Path: <linux-kernel+bounces-204893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D101E8FF4C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08AA5B22F03
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BC060882;
	Thu,  6 Jun 2024 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EW5zk5OJ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843650284
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698766; cv=none; b=lYJZgTPho7VcMJU6VemQdRs25a2xWDGAvZYNeFdpYk7JWqAGS8uJRQAAC6sUKs2Yg5nsdmiWdbdgT1TQvmBfv+koEudiXglq1FMbQHY5WCd1K8na3AJK9L1qVMcWPoLmaP3uIpyzE/EKKeZvV0oX7cgoli5YEkM6l3a7ANiPbpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698766; c=relaxed/simple;
	bh=YJBdb4TbR1WkUm2UdE24YiIygi47s/TtRZuH5spnfpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTlLBPmgZzf3TmSGtwVl3roSq2rVoWElNinGy/0xxF8A8TujzAUMJphzxer+KdYAkzJKl+Z3VcVVnf5o9mwHbpjOSruOmnz70tBpj9TQqBONLokbHOoovNbnol7B0LkW8OSr+SzMVDibYKJJOTxd2yZiXcZbQWUbtIfKarHsaKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EW5zk5OJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f4603237e0so799960b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717698764; x=1718303564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvuTCHkit+Xi04/Y6YOOrb/oKRPfOiVcL1hFmBt4hbc=;
        b=EW5zk5OJ0g1sVT06e3LF93bIU5AMQ2h4CzqqvYWnYn5HMH/P1Ue0yXed1Ph+/9ThbF
         5E6gdlrbUDN9t7FkQx2++OQTuLy2q1RLXnyWL44N39R8/sC3SiffITVths9LJGFXFuWV
         /9F1HJqruG7SATaWqLOTWAvbOX1Ttb8Hw8i68QHdWGJm9TVz5xlhmwmpBgwwV+3CnvTV
         Mi4n7ist/efMxZbAi4ZxAsR/zyipa4Db+QSZ2yaoUHlpERGslp8hJpAILb+gHoTm+izJ
         KZSuzS1tFFHc4YtQFvImI8pPSpdpB3WzXE8a3lzuj1dSJmlVouSIZSw/satypyrIdfce
         /QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717698764; x=1718303564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvuTCHkit+Xi04/Y6YOOrb/oKRPfOiVcL1hFmBt4hbc=;
        b=cS35upFhBac/HuYbO24/E02SwOwFQVSZkYTM173PR6LO7GH8SjyTlOFHd8XNzEwuWa
         rUyO6bg28uygwmWQ9PN4/g8nPnDUnJ09l8jiyuJOAmrdPCtGpxY2eKws2WO4r/v4v4m/
         a1gdMO096Kp8Et8OabPhHQ7hhjofV8uy5Eop7muDSsm6tfSyQxdfS5JQE4PXpCWurzM2
         nk6dOtwz7Edj9ftM9PVmmfsKvSpVkbobUzoU9+uGnfRq2nsLfPX9FiD0hO1mLV30Y/N9
         DaVJEik9dKE2FY0/tFG1gfsvvAH3GKbzMwdH7DPqCR0y9HBz/W1UXVEgyxtT6BoeObZf
         oKwg==
X-Forwarded-Encrypted: i=1; AJvYcCUDKaDMT6DW85Dadu+aLNPulS3vcCV2y81V+Bnde0Vuos5BEcIHZNWYhbUtj/I7jSnLd+k5AH3ebUaZQVt7jhpnQrzhEYwnlH5upZTt
X-Gm-Message-State: AOJu0YxTCpUTYxqb4KfAHA2KFXtb9SwIpeUDqmCVQaANen8v9RbiIakn
	pXbwdDajW9+NtPAgJlpZ1fxJoNaJhuB65UoAu0DHvecCoZnlfEnGRb7/cT8eAjQ=
X-Google-Smtp-Source: AGHT+IGT/DydJIpJEHegcVhedbVkQodQB11b8IfORR0j4zD4Zrth0xks/SxQQYZsS327tQ3nbYhbaA==
X-Received: by 2002:a05:6a00:1403:b0:6ec:ef1c:4dcd with SMTP id d2e1a72fcca58-7040a285b96mr672483b3a.6.1717698763700;
        Thu, 06 Jun 2024 11:32:43 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd50f0c6sm1378400b3a.191.2024.06.06.11.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:32:43 -0700 (PDT)
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
Subject: [PATCH 2/3] RISC-V: Detect unaligned vector accesses supported.
Date: Thu,  6 Jun 2024 14:32:14 -0400
Message-ID: <20240606183215.416829-2-jesse@rivosinc.com>
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

Run a unaligned vector access to test if the system supports
vector unaligned access. Add the result to a new key in hwprobe.
This is useful for usermode to know if vector misaligned accesses are
supported and if they are faster or slower than equivalent byte accesses.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h        |  2 +
 arch/riscv/include/asm/hwprobe.h           |  2 +-
 arch/riscv/include/asm/vector.h            |  1 +
 arch/riscv/include/uapi/asm/hwprobe.h      |  6 ++
 arch/riscv/kernel/sys_hwprobe.c            | 34 +++++++++
 arch/riscv/kernel/traps_misaligned.c       | 84 ++++++++++++++++++++--
 arch/riscv/kernel/unaligned_access_speed.c |  4 ++
 arch/riscv/kernel/vector.c                 |  2 +-
 8 files changed, 129 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 347805446151..a012c8490a27 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -35,9 +35,11 @@ void riscv_user_isa_enable(void);
 
 #if defined(CONFIG_RISCV_MISALIGNED)
 bool check_unaligned_access_emulated_all_cpus(void);
+bool check_vector_unaligned_access_all_cpus(void);
 void unaligned_emulation_finish(void);
 bool unaligned_ctl_available(void);
 DECLARE_PER_CPU(long, misaligned_access_speed);
+DECLARE_PER_CPU(long, vector_misaligned_access);
 #else
 static inline bool unaligned_ctl_available(void)
 {
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 630507dff5ea..150a9877b0af 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 6
+#define RISCV_HWPROBE_MAX_KEY 7
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 731dcd0ed4de..776af9b37e23 100644
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
index 060212331a03..ebacff86f134 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -68,6 +68,12 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
+#define RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF	7
+#define		RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN		0
+#define		RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED		1
+#define		RISCV_HWPROBE_VEC_MISALIGNED_SLOW		2
+#define		RISCV_HWPROBE_VEC_MISALIGNED_FAST		3
+#define		RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED	4
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index b286b73e763e..ce641cc6e47a 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -184,6 +184,36 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
 }
 #endif
 
+#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
+static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
+{
+	int cpu;
+	u64 perf = -1ULL;
+
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
@@ -211,6 +241,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		pair->value = hwprobe_misaligned(cpus);
 		break;
 
+	case RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF:
+		pair->value = hwprobe_vec_misaligned(cpus);
+		break;
+
 	case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
 		pair->value = 0;
 		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 2adb7c3e4dd5..8f26c3d92230 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -16,6 +16,7 @@
 #include <asm/entry-common.h>
 #include <asm/hwprobe.h>
 #include <asm/cpufeature.h>
+#include <asm/vector.h>
 
 #define INSN_MATCH_LB			0x3
 #define INSN_MASK_LB			0x707f
@@ -413,10 +414,6 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
-#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
-	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
-#endif
-
 	if (!unaligned_enabled)
 		return -1;
 
@@ -426,6 +423,17 @@ int handle_misaligned_load(struct pt_regs *regs)
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
+#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
+	if (insn_is_vector(insn) &&
+	    *this_cpu_ptr(&vector_misaligned_access) == RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED) {
+		*this_cpu_ptr(&vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
+		regs->epc = epc + INSN_LEN(insn);
+		return 0;
+	}
+
+	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
+#endif
+
 	regs->epc = 0;
 
 	if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
@@ -625,6 +633,74 @@ static bool check_unaligned_access_emulated(int cpu)
 	return misaligned_emu_detected;
 }
 
+#ifdef CONFIG_RISCV_ISA_V
+static void check_vector_unaligned_access(struct work_struct *unused)
+{
+	int cpu = smp_processor_id();
+	long *mas_ptr = this_cpu_ptr(&vector_misaligned_access);
+	unsigned long tmp_var;
+
+	if (!riscv_isa_extension_available(hart_isa[cpu].isa, v))
+		return;
+
+	*mas_ptr = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
+
+	local_irq_enable();
+	kernel_vector_begin();
+	__asm__ __volatile__ (
+		".balign 4\n\t"
+		".option push\n\t"
+		".option arch, +v\n\t"
+		"       vsetivli zero, 1, e16, m1, ta, ma\n\t"	// Vectors of 16b
+		"	vle16.v v0, (%[ptr])\n\t"		// Load bytes
+		".option pop\n\t"
+		: : [ptr] "r" ((u8 *)&tmp_var + 1) : "v0", "memory");
+	kernel_vector_end();
+
+	if (*mas_ptr == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN)
+		*mas_ptr = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
+}
+
+bool check_vector_unaligned_access_all_cpus(void)
+{
+	int cpu;
+	bool ret = true;
+
+	for_each_online_cpu(cpu)
+		if (riscv_isa_extension_available(hart_isa[cpu].isa, ZICCLSM))
+			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
+		else
+			ret = false;
+
+
+	if (ret)
+		return true;
+	ret = true;
+
+	schedule_on_each_cpu(check_vector_unaligned_access);
+
+	for_each_online_cpu(cpu)
+		if (per_cpu(vector_misaligned_access, cpu)
+		    != RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED)
+			return false;
+
+	return ret;
+}
+#else
+bool check_vector_unaligned_access_all_cpus(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		if (riscv_isa_extension_available(hart_isa[cpu].isa, ZICCLSM))
+			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
+		else
+			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
+
+	return false;
+}
+#endif
+
 bool check_unaligned_access_emulated_all_cpus(void)
 {
 	int cpu;
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index a9a6bcb02acf..92a84239beaa 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -20,6 +20,7 @@
 #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
 
 DEFINE_PER_CPU(long, misaligned_access_speed);
+DEFINE_PER_CPU(long, vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
 
 #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
 static cpumask_t fast_misaligned_access;
@@ -264,6 +265,8 @@ static int check_unaligned_access_all_cpus(void)
 {
 	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
 
+	check_vector_unaligned_access_all_cpus();
+
 	if (!all_cpus_emulated)
 		return check_unaligned_access_speed_all_cpus();
 
@@ -273,6 +276,7 @@ static int check_unaligned_access_all_cpus(void)
 static int check_unaligned_access_all_cpus(void)
 {
 	check_unaligned_access_emulated_all_cpus();
+	check_vector_unaligned_access_all_cpus();
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 6727d1d3b8f2..2cceab739b2c 100644
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
2.43.0


