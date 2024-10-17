Return-Path: <linux-kernel+bounces-370461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2709A2CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B78B283EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB0221BB0A;
	Thu, 17 Oct 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WGuVT+SY"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D521B440
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191638; cv=none; b=i/MdjmwWe7HA/DHdjFneWp+z1UJQnQhYAnq8XjiQnsNuwO/BcngdzHKf3PZyMcnS/9VgwFzFnaY4+GFLOxnY4wdWlC1sZrzUb/ZrCSr64Mhdlc1Tk0Pb35TSxx8xyHtfJui5FUGtaI4gqGuHuQrz4OG2WbYlzwMUJ8bEItXQxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191638; c=relaxed/simple;
	bh=27/0dKwk3yKqVSMdOHG8NoZYrfHKiQw+uf4n+l5+9Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MpPIHNOZpl+onRJ8fQBq2dcnpnFBSy7xQnp+deSjpIKxbR/zw2DI/n//XYQomQR7d0DzexBuqSAc76Ov+pfdB7hy/Oh7iNVCJelRloWjiGT8/HQHkKEJjwIXrKnxRhna/kTO/PoaxFgOm0fFQ+X2XXUzEHoV05tcIQ7X6KLgn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WGuVT+SY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ceb8bd22fso11517945ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729191634; x=1729796434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6I92cOKev06L8Upue2XsTuPJ6ytpoCnoDu3MUioPhw=;
        b=WGuVT+SY0aHS7ytytYmvIg3v1SseJeES8Q/pOdIOqWFLysZxNsSL59i8Mug87BNgFC
         iCMFb83NVVolUlyrrfz0U9d5TtygsqGuQ6cTjZJ+Y8l6ocUrLovUQX4WM9RCt9ohwhYZ
         kNqsLcx+eIeX+VX1xJDd4jZJS44FyXP4qJxAVZ7Dv63vlec69NxFoavsK05HPAJyn2TU
         THcZ4hoSHlBK4bgdKY5Wq24o0CZyOFnjfFtfvSdbxmFk9jOpK+VR8Tda+RX1dZKGFH/y
         FiQD2qwz1eREknSljMdvRPrgGXh+dXR1GUFQqIpCvfXo4/v3tX40Se6VCOy8OYdlP6HF
         KmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191634; x=1729796434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6I92cOKev06L8Upue2XsTuPJ6ytpoCnoDu3MUioPhw=;
        b=NEMzrKjq69ZzbRjH1IowFY7KSMS60v9zMewmU/Xi6BqRyEqkbv8kEmpOjoZlm/IK3c
         mcmE8/g6wm5kfKFGwtLnXUbtq4glHLn7D9H/KxCtB+D6lGPluswinU+/w1TY772wDqLf
         wiIe1hYAOTE9rATzf3/TK8eNwGZK3zXU9oaawSDNJA9S43zMLqNr6li/xDjSYFz2UeFW
         /5z/vPYtSXbhkS8Et1gC8IcjNHWTMGvHWqry6LhDrpe1KjJm9gfnFGcCYuP2NHW4NQ3L
         b/U36wPgXOAhWvKg/cAsmlh3svVenvM7NNYrtxvMFetlATrjs47XA4fgGolu68mjVVr4
         34QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc1+WQIGHMYUHro0v5pXtUUh47CsyMNGJf4DcfTvSduciAsOxkaRLOohc2fFN9KSV7ZhiQdwcS7M8Eus4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQaN1S/dRocKNn07tcL2Uk1xuSPMOenGXvSlhV2Ptffo3AG9q
	SyMPrujEbRtLz5JuacvdwgBp7uZGNkmPb5myR9//82qEAvAOwBj3gA0A46YDKcY=
X-Google-Smtp-Source: AGHT+IEnqr/xLXrUjVnnlJHigy6Hyu2OOrtSPcsF/2JSHBJmAcPpsNh3cA82sUz5vfzl4azudhUS4g==
X-Received: by 2002:a17:903:32c9:b0:20c:6ac0:f1f3 with SMTP id d9443c01a7336-20cbb1c2931mr253055085ad.34.1729191633582;
        Thu, 17 Oct 2024 12:00:33 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d7bf9a8sm217766a91.13.2024.10.17.12.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:00:32 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 17 Oct 2024 12:00:18 -0700
Subject: [PATCH v10 1/6] RISC-V: Check scalar unaligned access on all CPUs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-jesse_unaligned_vector-v10-1-5b33500160f8@rivosinc.com>
References: <20241017-jesse_unaligned_vector-v10-0-5b33500160f8@rivosinc.com>
In-Reply-To: <20241017-jesse_unaligned_vector-v10-0-5b33500160f8@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Jesse Taube <jesse@rivosinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3354; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=luXKoHMr90jWw4aZ0MlK8J4IV7I78iZ6mhaINZaU4mk=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pg3OmbLj8cdy1ct8gpf9/s2mSH22/866sX3b/jGXw0+
 xpzY8v5jlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACaybCEjw/+8/9/MuS9uWbXc
 kSXp3Jr5XUfffXW5sjd5pXmVmFys4kqG/ym5YZIX/zE2i4hMcrJvXWBYu8xF4orcvJIPpjOCxHc
 +ZgQA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

From: Jesse Taube <jesse@rivosinc.com>

Originally, the check_unaligned_access_emulated_all_cpus function
only checked the boot hart. This fixes the function to check all
harts.

Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwprobe")
Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
Cc: stable@vger.kernel.org
---
 arch/riscv/include/asm/cpufeature.h  |  2 ++
 arch/riscv/kernel/traps_misaligned.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 45f9c1171a48..dfa5cdddd367 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -8,6 +8,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/jump_label.h>
+#include <linux/workqueue.h>
 #include <asm/hwcap.h>
 #include <asm/alternative-macros.h>
 #include <asm/errno.h>
@@ -60,6 +61,7 @@ void riscv_user_isa_enable(void);
 
 #if defined(CONFIG_RISCV_MISALIGNED)
 bool check_unaligned_access_emulated_all_cpus(void);
+void check_unaligned_access_emulated(struct work_struct *work __always_unused);
 void unaligned_emulation_finish(void);
 bool unaligned_ctl_available(void);
 DECLARE_PER_CPU(long, misaligned_access_speed);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index d4fd8af7aaf5..d076dde5ad20 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -526,11 +526,11 @@ int handle_misaligned_store(struct pt_regs *regs)
 	return 0;
 }
 
-static bool check_unaligned_access_emulated(int cpu)
+void check_unaligned_access_emulated(struct work_struct *work __always_unused)
 {
+	int cpu = smp_processor_id();
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
 	unsigned long tmp_var, tmp_val;
-	bool misaligned_emu_detected;
 
 	*mas_ptr = RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
 
@@ -538,19 +538,16 @@ static bool check_unaligned_access_emulated(int cpu)
 		"       "REG_L" %[tmp], 1(%[ptr])\n"
 		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
 
-	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED);
 	/*
 	 * If unaligned_ctl is already set, this means that we detected that all
 	 * CPUS uses emulated misaligned access at boot time. If that changed
 	 * when hotplugging the new cpu, this is something we don't handle.
 	 */
-	if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
+	if (unlikely(unaligned_ctl && (*mas_ptr != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED))) {
 		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
 		while (true)
 			cpu_relax();
 	}
-
-	return misaligned_emu_detected;
 }
 
 bool check_unaligned_access_emulated_all_cpus(void)
@@ -562,8 +559,11 @@ bool check_unaligned_access_emulated_all_cpus(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
+	schedule_on_each_cpu(check_unaligned_access_emulated);
+
 	for_each_online_cpu(cpu)
-		if (!check_unaligned_access_emulated(cpu))
+		if (per_cpu(misaligned_access_speed, cpu)
+		    != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
 			return false;
 
 	unaligned_ctl = true;

-- 
2.45.0


