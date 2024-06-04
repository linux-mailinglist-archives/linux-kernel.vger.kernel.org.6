Return-Path: <linux-kernel+bounces-201062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC08FB8CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0F228A830
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32ED1487D4;
	Tue,  4 Jun 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KWpKhWQX"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6A414830B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518314; cv=none; b=cIogRf/Lv+uBL14Fu+gdSUvPtNw+befuM/mSC51A6tn6Ek7hreC4npD/40DOO65A2NO5NCOc4NxmaW2elOnfsERflH2WS6FadVkk/Is8nnJzh6II0cCvIoDfL0ZzVW+B7fG9Pz5WR1e/8EY+DVCGToHcSpkpDB2L4eWE6VogWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518314; c=relaxed/simple;
	bh=LzdBNzYnzNgfoyC/OTS0N2N8LEi/0gb7aTWTc5ahp9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFiidAZrfIUgYT45gsD6Ps6Yf+PWhaoBo4uxwD8YaWM/WQ6M6nk1hH7VJ9VJqmTxCqwzM97tVaQynzndz6P9eQlckJJSjwHVHH1EWKAeax0CYjS38OPa9MW2ndMh4zY7l76aZjU4OAwBCvUsTgMajZ9ILIhb/FQNPH6pSq8vB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KWpKhWQX; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ba69e446f4so415802eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717518312; x=1718123112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oH66foMXDApALAS1wcAJZSmBTT9bvRQ/ka0fru0lccU=;
        b=KWpKhWQXbKH84pPaHLbJ30rqXSOIL1Qi5F3OVN/fKC3d2vZSmZcXVBcSFAWdwv2Pcz
         A2BKjOW0C7kiUXBgXqX5ynWVrfdKy6JuR3JFnuWCQrWqu4Xm0XKnuNB8qbnixC25Y4LJ
         2MzVdBkswdgu8KG5zxVW0Y30Gni6VDlb+XIHDNeuXh5eRtIS9/m5C4Wfa6scsvL25f6E
         J6Jqm9xm29k1dTmjAi9BKa478xAWxX/xhPmwJU0INJR7Da8ST0PGdAFeQCmejANaYRvH
         Ibg3gJIMkXEf3HJDf4ICospeXnK3VWvZ3pnZywhURCDNjJFF0WgzI+8nMNiDfRFi/uTI
         tiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717518312; x=1718123112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oH66foMXDApALAS1wcAJZSmBTT9bvRQ/ka0fru0lccU=;
        b=aW3O32dl6INdenxPQFzKpADt33xr8j0bOTMlHIGB9cKMzcwmBilB21ymrawqdrZRfa
         7LlCCoaGk+b2J2mm2cS2oJTVU2l0u+vHskMrcMTEml2VLjB9+09+dxlA7zJv0VbGqKcf
         nE5PXV4GrQl2k4nwxcTxghLbqG5BQMfwfCdMYf+5qShdwixR5+3r1IB4FtJYLSELqlvH
         rRK2LEvQDFzsCXZCFxMfxxm9YZ/gQ80kU6s2Vn160NSh9OSheB8XCO0c8m5dDF11WEyl
         E7LJTH1HJLtLVwcHuVw8IgqiGEIxjjv1rCYSIE1EYo/oM+TFZGHH7RwXNLWZVelM3ixi
         6I8g==
X-Forwarded-Encrypted: i=1; AJvYcCWjhqh3piDqMpqCCR00GaOkOKJ9zhv/9Xqq0sdSiuety7LQF0QbKdGToREZ9Z/MAbVO27grjZYGW4Rk3me1O5CLSWL78yS23M74K9Y8
X-Gm-Message-State: AOJu0Yy12ZBX4lr2Wdp8wNcgJ3g1xzjOob+XFb/tAmz7vrQdvgWtq4tn
	v/FjPo9V8QJK3O2m+mNSMr8KodgbsOfmjraUuKV8vn4LAmitxkh5veQG3NZGgrlZ8eVzwuhddmk
	zki7b4g==
X-Google-Smtp-Source: AGHT+IFmH+Ml2VD2pW2eVDFmjqPTVR+Hcny82o26if8fLu1zJGV0X4sRCdPgbDsPodnc/YosBHhUVQ==
X-Received: by 2002:a05:6358:890:b0:19c:4841:30ae with SMTP id e5c5f4694b2df-19c484136aemr221846955d.24.1717518311805;
        Tue, 04 Jun 2024 09:25:11 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35937a496sm6173341a12.73.2024.06.04.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:25:11 -0700 (PDT)
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
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Erick Archer <erick.archer@gmx.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v0] RISCV: Report vector unaligned accesses hwprobe
Date: Tue,  4 Jun 2024 12:24:57 -0400
Message-ID: <20240604162457.3757417-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detected if a system traps into the kernel on an vector unaligned access.
Add the result to a new key in hwprobe.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h        |  3 ++
 arch/riscv/include/asm/hwprobe.h           |  2 +-
 arch/riscv/include/uapi/asm/hwprobe.h      |  6 +++
 arch/riscv/kernel/sys_hwprobe.c            | 34 ++++++++++++
 arch/riscv/kernel/traps_misaligned.c       | 60 ++++++++++++++++++++++
 arch/riscv/kernel/unaligned_access_speed.c |  4 ++
 6 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 347805446151..5ad69cf25b25 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -35,9 +35,12 @@ void riscv_user_isa_enable(void);
 
 #if defined(CONFIG_RISCV_MISALIGNED)
 bool check_unaligned_access_emulated_all_cpus(void);
+bool check_vector_unaligned_access_all_cpus(void);
+
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
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 060212331a03..4474e98d17bd 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -68,6 +68,12 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
+#define RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF	7
+#define		RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN		0
+#define		RISCV_HWPROBE_VEC_MISALIGNED_EMULATED		1
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
index 2adb7c3e4dd5..0c07e990e9c5 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -16,6 +16,7 @@
 #include <asm/entry-common.h>
 #include <asm/hwprobe.h>
 #include <asm/cpufeature.h>
+#include <asm/vector.h>
 
 #define INSN_MATCH_LB			0x3
 #define INSN_MASK_LB			0x707f
@@ -426,6 +427,14 @@ int handle_misaligned_load(struct pt_regs *regs)
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
+#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
+	if (*this_cpu_ptr(&vector_misaligned_access) == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN) {
+		*this_cpu_ptr(&vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
+		regs->epc = epc + INSN_LEN(insn);
+		return 0;
+	}
+#endif
+
 	regs->epc = 0;
 
 	if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
@@ -625,6 +634,57 @@ static bool check_unaligned_access_emulated(int cpu)
 	return misaligned_emu_detected;
 }
 
+#ifdef CONFIG_RISCV_ISA_V
+static bool check_vector_unaligned_access(int cpu)
+{
+	long *mas_ptr = per_cpu_ptr(&vector_misaligned_access, cpu);
+	struct riscv_isainfo *isainfo = &hart_isa[cpu];
+	unsigned long tmp_var;
+	bool misaligned_vec_suported;
+
+	if (!riscv_isa_extension_available(isainfo->isa, v))
+		return false;
+
+	/* This case will only happen if a unaligned vector load
+	 * was called by the kernel before this check
+	 */
+	if (*mas_ptr != RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN)
+		return false;
+
+	kernel_vector_begin();
+	__asm__ __volatile__ (
+		".option push\n\t"
+		".option arch, +v\n\t"
+		"	li t1, 0x1\n"				//size
+		"       vsetvli t0, t1, e16, m2, ta, ma\n\t"	// Vectors of 16b
+		"       addi t0, %[ptr], 1\n\t"			// Misalign address
+		"	vle16.v v0, (t0)\n\t"			// Load bytes
+		".option pop\n\t"
+		: : [ptr] "r" (&tmp_var) : "v0", "t0", "t1", "memory");
+	kernel_vector_end();
+
+	misaligned_vec_suported = (*mas_ptr == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN);
+
+	return misaligned_vec_suported;
+}
+#else
+static bool check_vector_unaligned_access(int cpu)
+{
+	return false;
+}
+#endif
+
+bool check_vector_unaligned_access_all_cpus(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		if (!check_vector_unaligned_access(cpu))
+			return false;
+
+	return true;
+}
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
-- 
2.43.0


