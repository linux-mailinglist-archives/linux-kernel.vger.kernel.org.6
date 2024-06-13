Return-Path: <linux-kernel+bounces-213898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 931D6907C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3453B242D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26662154430;
	Thu, 13 Jun 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PghC1xDV"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32DF15250F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306241; cv=none; b=aHb1b6BcO0oGdtUILOJ7XFwEZ0ee1pDAzmBQynAgPz742ibPPKFuVtTD5rYALvqFe2CDOzMpW9pH7hERK1eXfR/CSPNzayPMzT7v1AdHvdNsAqc410iSbQsBMdAEPLmX4Y+dfP2XO6g5vOg9tHAxual32hgXAKmIXETzEl8MAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306241; c=relaxed/simple;
	bh=+jnJtiUScAEX7YebGNkKf8lf6RqHQioTg5h1y/TviSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeEFcyUDoY0WbrwTBiL38NqCbUJVeCKCMWwf2zG57BmQ/KceZwyFoe1byHfys0x9/jnFEd/mkE8UZRucN61icguBKPUBceBZQZDKB7/vbjbDnu9vRR3rAAjGYmBOTiYVQKG0riRHGjT0MzxfgvmArrVEivM6sJJzq+gG8HrEkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PghC1xDV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f64ecb1766so11615125ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718306239; x=1718911039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2si2x/qxMiiRgx/ptA73I3ih5KSBTyIVIweBGPWOt8=;
        b=PghC1xDVcvoeRzTkSxuMFXK0jJO/4JFGVDpQCQYwx1JDHGatOuKUhsvMC/T9XTVxZq
         ts7INWTFFDqwPdVnfDq2EgnnvjRCR6KBm4dKNdeAoWJYGtgmWcWPw9VEQYqxI5slI36m
         GZfHy72ZjoOaV1e7sU5iZLj2n5pHPe3n5Z/DEhAmykCmkAaK+2qcuPwCAVK9Cw8H5QUL
         y8Mlvvce2YZVSkw9XsNl9DHOUX+CsSOp4l4rl0Uuo4jvAbHOjVkREnwzTyNgoCD5RCrW
         yIkGBuD4W1jKiodGmintUg1KaOm9/WwfI7awiv9dje6cXPrTg1vnI8264qAUUK122VnM
         n+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306239; x=1718911039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2si2x/qxMiiRgx/ptA73I3ih5KSBTyIVIweBGPWOt8=;
        b=dUNrHcRudqIkZA73ljW+Cn2ESEi3YOaSn2FnYSnU8utCruA6wTHj3IS31LmLsceTHN
         E+JI9vukEyrO/RCXoNj/j30zrUsprgs8815XdpY5nhTRLuVpY9byOGa8Ykk82WejYfzT
         gZB+W+TkRmFBK+Ak/T/5OZbZVmjOVG+rvOQ6inbdB1Yg4yibkzkRlut3Qq8RWo3Q9aDE
         u0Gu5Imuz/L08Sqtqay+b6WSzTyMFVmqKnlSz0dTd341VMtF0wkgG1/8BrkDDDO1WogM
         YUpylLV5AHpnKsaGeCPFAK78UeFg5ccZei0dzMIsgxxzgimebjRNVK/vfnuQrYUT+lm0
         xtKg==
X-Forwarded-Encrypted: i=1; AJvYcCVDlapmLYK32IM/AAuPeyiqHHsXbQChvqrbhkzIQANw5uAyLxqbREmFu2O7XM81e9wSStzuX3Ifd+fm5g8xZztiQ357U32ON4DKnnLO
X-Gm-Message-State: AOJu0YwalJDYHmfw7cl9Rb8BzcW+xl3SGArIA2sIVMU+jUNCfu1fNL8x
	L9rtkyLe5wz4NpGyXXgUqQ2x58A5NnyLTt50kQLNsY9UiC2X5oA4VSK3+7FhpnM=
X-Google-Smtp-Source: AGHT+IEe/pgm4wbdzYk9w01vIQjdm01pqBBmuWzC0VnQ7Vhdd+iuX8Zf6okO8XfjDwZx3EhOCo7asg==
X-Received: by 2002:a17:903:2341:b0:1f6:7ee8:8935 with SMTP id d9443c01a7336-1f8629fef3bmr7650085ad.59.1718306239110;
        Thu, 13 Jun 2024 12:17:19 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e7ca78sm17471015ad.106.2024.06.13.12.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:18 -0700 (PDT)
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
Subject: [PATCH v2 3/6] RISC-V: Check scalar unaligned access on all CPUs
Date: Thu, 13 Jun 2024 15:16:12 -0400
Message-ID: <20240613191616.2101821-4-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613191616.2101821-1-jesse@rivosinc.com>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally, the check_unaligned_access_emulated_all_cpus function
only checked the boot hart. This fixes the function to check all
harts.

Check for Zicclsm before checking for unaligned access. This will
greatly reduce the boot up time as finding the access speed is no longer
necessary.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
V1 -> V2:
 - New patch
---
 arch/riscv/kernel/traps_misaligned.c       | 23 ++++++----------------
 arch/riscv/kernel/unaligned_access_speed.c | 23 +++++++++++++---------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index b62d5a2f4541..8fadbe00dd62 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -526,31 +526,17 @@ int handle_misaligned_store(struct pt_regs *regs)
 	return 0;
 }
 
-static bool check_unaligned_access_emulated(int cpu)
+static void check_unaligned_access_emulated(struct work_struct *unused)
 {
+	int cpu = smp_processor_id();
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
 	unsigned long tmp_var, tmp_val;
-	bool misaligned_emu_detected;
 
 	*mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
 
 	__asm__ __volatile__ (
 		"       "REG_L" %[tmp], 1(%[ptr])\n"
 		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
-
-	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
-	/*
-	 * If unaligned_ctl is already set, this means that we detected that all
-	 * CPUS uses emulated misaligned access at boot time. If that changed
-	 * when hotplugging the new cpu, this is something we don't handle.
-	 */
-	if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
-		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
-		while (true)
-			cpu_relax();
-	}
-
-	return misaligned_emu_detected;
 }
 
 bool check_unaligned_access_emulated_all_cpus(void)
@@ -562,8 +548,11 @@ bool check_unaligned_access_emulated_all_cpus(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
+	schedule_on_each_cpu(check_unaligned_access_emulated);
+
 	for_each_online_cpu(cpu)
-		if (!check_unaligned_access_emulated(cpu))
+		if (per_cpu(misaligned_access_speed, cpu)
+		    != RISCV_HWPROBE_MISALIGNED_EMULATED)
 			return false;
 
 	unaligned_ctl = true;
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index a9a6bcb02acf..70c1588fc353 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -259,23 +259,28 @@ static int check_unaligned_access_speed_all_cpus(void)
 	kfree(bufs);
 	return 0;
 }
+#endif /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
 
 static int check_unaligned_access_all_cpus(void)
 {
-	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
+	bool all_cpus_emulated;
+	int cpu;
 
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
+		for_each_online_cpu(cpu) {
+			per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_FAST;
+		}
+		return 0;
+	}
+
+	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
+
+#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
 	if (!all_cpus_emulated)
 		return check_unaligned_access_speed_all_cpus();
+#endif
 
 	return 0;
 }
-#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
-static int check_unaligned_access_all_cpus(void)
-{
-	check_unaligned_access_emulated_all_cpus();
-
-	return 0;
-}
-#endif
 
 arch_initcall(check_unaligned_access_all_cpus);
-- 
2.43.0


