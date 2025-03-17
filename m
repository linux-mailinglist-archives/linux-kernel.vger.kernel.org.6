Return-Path: <linux-kernel+bounces-564741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C80EA65A16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C643B9799
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE951E1DF0;
	Mon, 17 Mar 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tvOaMH18"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809C1B983F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231297; cv=none; b=Q2+q6DqWiNUhSzPwBL9ASGHkSLIiWPCJCVN0scE9exre3L0XUiHiRqDXt/ToyRTqLDgoSzdh/FIbGj8JWHGaRyTHsV24OTbjcr7yPsTOBuDJtv/BBrexxROB659T86BZDMxjhiIHVzcHPpFTTzjIHBMfA3cQBx4O19ZEoQh3RBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231297; c=relaxed/simple;
	bh=OtY2EOfT7IN04wGt9UYX2OMYcXbBRcTX/gnN/1KIezs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paY+4qJbxBKBGT/igH80O0ADg/DLHhSWdAY+t5smSf9nPlYM6HfYdKCmhx/7WVnx5KpmXve+0q9UxqsFmFaeqGXfqcfCgUYOU/OEpz9967735oEvqb3oBhOkeQWwhXXe+6+6se19qw4opE0hxR1YaoDnK9dhtP11PB6+nT6VUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tvOaMH18; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0618746bso18244285e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742231293; x=1742836093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k1emOUih8WEclNZ1DDbkx/NdClZ1In2F+3XrsHVDoI=;
        b=tvOaMH18T9CtLFZq5KraGw0x+pTpzzEMKdmbxJqRWSqYJXMXdxs/OS48Gu3giV/9y1
         lu4om5ULPsFngpEHwv6tlRnUVQ1C5sFKkMDsK3P68kgNziaUpkhpI9muayQtHLEnZp90
         werpjkD909udm6NWc3AaJUFruVSa/UMrrTn1G13o3zdRstM7kLw/mYS2qcPRED3j/51A
         tpBCm3kUlRFAgZjBZUbvBUiZeg2zWFhJYuXZFWm96MQpx1P0tNViDmMzIACf/wipWMr7
         oM9F5NCGe48K+rKy3MZlII2Q/jU2nnhn1WjrVtKFJG+b+jeoDDtn4q/iliCn59hzPkDQ
         BQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231293; x=1742836093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k1emOUih8WEclNZ1DDbkx/NdClZ1In2F+3XrsHVDoI=;
        b=FFUmL5WBgbkrAvQq+el/1990rhCGjsABgm2byNWQZiJjgT0o8yDTqTOKlHGhV0SqU1
         +14/k+gmZ6iV06hS6VWIPXRVPCV74kdGk6CHizdqz2bbkPi7PVhoTfwF3qrdCtRjq1KJ
         qyMyEGq61xGtiF9Sdohqec2pZak5Oc+zV3jrFeaM7sKHkGozViCd/38jcMfUWd7Bcson
         vSTkv9nJkfgcvP/5IB3l97e1hsG6JeF+AEV6csrL5cohNy4eUhYahQtGP+J7qn5dtegR
         selpEVSXrkKGvaGWUVZv8OyzkEfIrpRRpHtPMjq7XhEH6/eQl21E1l5RP27abpwAXZKj
         IqZw==
X-Forwarded-Encrypted: i=1; AJvYcCUD/i45uU6qFuc6ATz5xdlgvAzlQR2P622KKBQH88ymZYDzXGfV6/J9BQj9syTFm4pMsv0sc6754gEGh8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqzB8XQ5i2IWIq/IFy/Th7ndvUc7SLFhlCYaxgH16bxSqpRVfC
	FrLo/uSnJWWfMUrHwDiO1Z/ZMj5feJgWNY12fbxFyXylJuCUa09amOfnw9KjSzI=
X-Gm-Gg: ASbGnctwtHSD/rDJ4kA78URnjrPbbdXLi+nGKxw5bGcM1lBdFKA9JXOOWFEzC7kNUJJ
	giQoyy0/hbbQOKfMKb6mKpuLq5EJZj4S9s1ravS7ZFM0TdeTvSWrhN7rGX69FGQFGHpaWuKZASP
	jAuff7iYhMrGC+mgWeO992XeD2iT2d519fyAVLeWTzZRIkjc7M1Jke0qM0+ko8nPdQdG0b/yUZi
	GKzRAsi3eZ8973ndSOCVcf8NI9H57Gq+2jTHW1F6caXFKJnsdr+TsEceZ0DLNwL+Wj7YnpwQtGU
	eDr1YFHW+Wcb2knGvGfZApN62Pngc5I2S6BcZx9L+xZDag==
X-Google-Smtp-Source: AGHT+IGirZlNuMI7AkYZLJxITsbB2mx0iqkOoTwEVui95+l6OuB5d7SYtKlA2CI4i4rX//+fE8Z8jQ==
X-Received: by 2002:a05:600c:468a:b0:43c:fb36:d296 with SMTP id 5b1f17b1804b1-43d1ed0e03dmr115529165e9.25.1742231292646;
        Mon, 17 Mar 2025 10:08:12 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d23cddb2asm96014505e9.39.2025.03.17.10.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:08:11 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 05/18] riscv: misaligned: request misaligned exception from SBI
Date: Mon, 17 Mar 2025 18:06:11 +0100
Message-ID: <20250317170625.1142870-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317170625.1142870-1-cleger@rivosinc.com>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that the kernel can handle misaligned accesses in S-mode, request
misaligned access exception delegation from SBI. This uses the FWFT SBI
extension defined in SBI version 3.0.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/cpufeature.h        |  3 +-
 arch/riscv/kernel/traps_misaligned.c       | 77 +++++++++++++++++++++-
 arch/riscv/kernel/unaligned_access_speed.c | 11 +++-
 3 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 569140d6e639..ad7d26788e6a 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -64,8 +64,9 @@ void __init riscv_user_isa_enable(void);
 	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
 
 bool check_unaligned_access_emulated_all_cpus(void);
+void unaligned_access_init(void);
+int cpu_online_unaligned_access_init(unsigned int cpu);
 #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
-void check_unaligned_access_emulated(struct work_struct *work __always_unused);
 void unaligned_emulation_finish(void);
 bool unaligned_ctl_available(void);
 DECLARE_PER_CPU(long, misaligned_access_speed);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 7cc108aed74e..fa7f100b95bd 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -16,6 +16,7 @@
 #include <asm/entry-common.h>
 #include <asm/hwprobe.h>
 #include <asm/cpufeature.h>
+#include <asm/sbi.h>
 #include <asm/vector.h>
 
 #define INSN_MATCH_LB			0x3
@@ -635,7 +636,7 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
 
 static bool unaligned_ctl __read_mostly;
 
-void check_unaligned_access_emulated(struct work_struct *work __always_unused)
+static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
 {
 	int cpu = smp_processor_id();
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
@@ -646,6 +647,13 @@ void check_unaligned_access_emulated(struct work_struct *work __always_unused)
 	__asm__ __volatile__ (
 		"       "REG_L" %[tmp], 1(%[ptr])\n"
 		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
+}
+
+static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
+{
+	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
+
+	check_unaligned_access_emulated(NULL);
 
 	/*
 	 * If unaligned_ctl is already set, this means that we detected that all
@@ -654,9 +662,10 @@ void check_unaligned_access_emulated(struct work_struct *work __always_unused)
 	 */
 	if (unlikely(unaligned_ctl && (*mas_ptr != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED))) {
 		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
-		while (true)
-			cpu_relax();
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 bool check_unaligned_access_emulated_all_cpus(void)
@@ -688,4 +697,66 @@ bool check_unaligned_access_emulated_all_cpus(void)
 {
 	return false;
 }
+static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
+{
+	return 0;
+}
 #endif
+
+#ifdef CONFIG_RISCV_SBI
+
+static bool misaligned_traps_delegated;
+
+static int cpu_online_sbi_unaligned_setup(unsigned int cpu)
+{
+	if (sbi_fwft_set(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0) &&
+	    misaligned_traps_delegated) {
+		pr_crit("Misaligned trap delegation non homogeneous (expected delegated)");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void unaligned_sbi_request_delegation(void)
+{
+	int ret;
+
+	ret = sbi_fwft_local_set(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0);
+	if (ret)
+		return;
+
+	misaligned_traps_delegated = true;
+	pr_info("SBI misaligned access exception delegation ok\n");
+	/*
+	 * Note that we don't have to take any specific action here, if
+	 * the delegation is successful, then
+	 * check_unaligned_access_emulated() will verify that indeed the
+	 * platform traps on misaligned accesses.
+	 */
+}
+
+void unaligned_access_init(void)
+{
+	if (sbi_probe_extension(SBI_EXT_FWFT) > 0)
+		unaligned_sbi_request_delegation();
+}
+#else
+void unaligned_access_init(void) {}
+
+static int cpu_online_sbi_unaligned_setup(unsigned int cpu __always_unused)
+{
+	return 0;
+}
+#endif
+
+int cpu_online_unaligned_access_init(unsigned int cpu)
+{
+	int ret;
+
+	ret = cpu_online_sbi_unaligned_setup(cpu);
+	if (ret)
+		return ret;
+
+	return cpu_online_check_unaligned_access_emulated(cpu);
+}
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 91f189cf1611..2f3aba073297 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -188,13 +188,20 @@ arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
 
 static int riscv_online_cpu(unsigned int cpu)
 {
+	int ret;
 	static struct page *buf;
 
 	/* We are already set since the last check */
 	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN)
 		goto exit;
 
-	check_unaligned_access_emulated(NULL);
+	ret = cpu_online_unaligned_access_init(cpu);
+	if (ret)
+		return ret;
+
+	if (per_cpu(misaligned_access_speed, cpu) == RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
+		goto exit;
+
 	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
 	if (!buf) {
 		pr_warn("Allocation failure, not measuring misaligned performance\n");
@@ -403,6 +410,8 @@ static int check_unaligned_access_all_cpus(void)
 {
 	bool all_cpus_emulated, all_cpus_vec_unsupported;
 
+	unaligned_access_init();
+
 	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
 	all_cpus_vec_unsupported = check_vector_unaligned_access_emulated_all_cpus();
 
-- 
2.47.2


