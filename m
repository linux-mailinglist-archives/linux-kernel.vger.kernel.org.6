Return-Path: <linux-kernel+bounces-255812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D87D93457A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804291C21485
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1219730358;
	Thu, 18 Jul 2024 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bSyFr86C"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD51228DB3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721263715; cv=none; b=qvvE5dcVy344MNa1C+6yu+bPtJXc95Ffw0YwJJhegPhaLInwvnIfuKha8tGfHk5QtIltRJMHA0zcZiniGEe3Q+sCAQkoxQ5D4Vof98ZL1VIKT9mcrVEVY5kWY9JBtYljo2vAgyf1U+hx6vWkEowfcBHD67IDILzp5Ww+8oAozqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721263715; c=relaxed/simple;
	bh=ayKMuH111uQmazVuhzUPdxu7GFGYmwbxVcBauWxUhXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQRAuykEmCq8qbhIZSucE3gyYpfWVMQtDf5bitL6s6CE74oo5rBZKG0ZlAi7VjVcPggxWSDmVBYwJPLkbxqTlZXkK/4R8Z8G46NYCgWo9lhQVjGXiGeapDtq7swkO6rsknwDmGWeZGRQv4iNmBKfqxcr2jgU/RHKay/X4vuIRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bSyFr86C; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b31272a04so941583b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721263697; x=1721868497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFld1vW28kOoabvpVtGlz2RoBm7PVswCH1l6QYeAzTM=;
        b=bSyFr86CUxVLB3BFxENAliE4lV5wyzxnDLEstG0Cg/VcvmMKpOYK5/4Z4vxbzxo3e4
         l9p7KAuUyUubmrTAVR9erAkXEzuLur2MAdj6JUz53H5A9RZd97EI00u1yAeHlXgABlYf
         QmijC2FS39cmbfYcjhlylQeEdWVT+GQTFdu8AZC60p7oWJmq+gXdXq5s/dNaINzZV/zQ
         hfoAU9uwa5pmgXnWgeZqsI8SxH/JrzNCM4yl7HKB1KANbvHZN2vz0f5Fa4n9KIcgy8um
         4mK5/ZM1qXdmyu5tfO0gsnQRrOaIwyGd5EFnmDIaxPnY/cmb82y3f01qXF8VW6p5gBub
         FR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721263697; x=1721868497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFld1vW28kOoabvpVtGlz2RoBm7PVswCH1l6QYeAzTM=;
        b=Ygy5gKyf4s2CQRLkjT86gFaSX3eSHynGFmezuYODkzX4sNnJ2/KLbH7iKufzWVsnU2
         0ny78x4z8Wn0WDIfEihEVkHLwv2YlrWuWYTXzd/eQU9mxz/aGBZcyxili38BfmC0qF3v
         z8WcN6YbMzToYOdJqaDn6Auk0xnZtGyfmoWanxnNexOxsTNGXxnc/v9z+3UXl/C7+2w/
         zjjh38awK+FQ/k/yx13nPqPO8Byh/4Qlc5T/Go5tF9HxDhfet0RjJs//J9/O4M7RmmsF
         ABjfzN0p8kOpu8QhN9sLoaW5Ss/DKART0het0yjavCIYmhv9ylioW8nJ6ZKpxYDOaX3t
         KbcA==
X-Forwarded-Encrypted: i=1; AJvYcCXVuujAogiTyVUfpP6jGdYWXkQdjTbBH9tCKPe2dUIbGW9lQqXLAEnlcVYXH/xOi+RVLNlOTnLDLbUQGEBFF4jxTr6T2EctgqI7AveA
X-Gm-Message-State: AOJu0YwzRHo1KjrAGRBqasd7uU9hXIBpS7xCz89ezh1Ef7TLqFxsJvCX
	UmAWFcGKdJOnV+9RZPvqjjPjzmd2wNErrBQHfBRVkJtxpmt4GA5cEbQymbEP/GI=
X-Google-Smtp-Source: AGHT+IF8mHZFxowkJGrx83wri8IP0GWRoDPRyQHAkdVWFwQ+fv5skyg8lghAXu3kMcXnk8PDhmI/Og==
X-Received: by 2002:a05:6a20:12c9:b0:1c0:e225:b11e with SMTP id adf61e73a8af0-1c407846c80mr2231878637.13.1721263697497;
        Wed, 17 Jul 2024 17:48:17 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e386d53e4sm5694300a12.70.2024.07.17.17.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 17:48:16 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v3 3/3] riscv: Call riscv_user_isa_enable() only on the boot hart
Date: Wed, 17 Jul 2024 17:47:56 -0700
Message-ID: <20240718004808.2246354-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240718004808.2246354-1-samuel.holland@sifive.com>
References: <20240718004808.2246354-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the [ms]envcfg CSR value is maintained per thread, not per
hart, riscv_user_isa_enable() only needs to be called once during boot,
to set the value for the init task. This also allows it to be marked as
__init.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - Drop use of __initdata due to conflicts with cpufeature.c refactoring

Changes in v2:
 - Rebase on riscv/for-next

 arch/riscv/include/asm/cpufeature.h | 2 +-
 arch/riscv/kernel/cpufeature.c      | 4 ++--
 arch/riscv/kernel/smpboot.c         | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 000796c2d0b1..7670792760b6 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -31,7 +31,7 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
-void riscv_user_isa_enable(void);
+void __init riscv_user_isa_enable(void);
 
 #if defined(CONFIG_RISCV_MISALIGNED)
 bool check_unaligned_access_emulated_all_cpus(void);
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 43fdae953379..517035356107 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -875,12 +875,12 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
-void riscv_user_isa_enable(void)
+void __init riscv_user_isa_enable(void)
 {
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
 		current->thread.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
-		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
+		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 19baf0d574d3..0646f79e0a02 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -235,8 +235,6 @@ asmlinkage __visible void smp_callin(void)
 	numa_add_cpu(curr_cpuid);
 	set_cpu_online(curr_cpuid, true);
 
-	riscv_user_isa_enable();
-
 	/*
 	 * Remote cache and TLB flushes are ignored while the CPU is offline,
 	 * so flush them both right now just in case.
-- 
2.45.1


