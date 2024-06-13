Return-Path: <linux-kernel+bounces-213725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8CE907982
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5EA1F24075
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A479114A616;
	Thu, 13 Jun 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UHI8EtTE"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CC14A4C0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298895; cv=none; b=gfpb9g0P5/Tur4hzlMBeBg5pZ0M9g8CRAyOhmfCHSVDYXyLjTDySd9rq54jpSloihf+91kRKbSTxKdXOY7a3H0GoLe76CVADdPOJBMG8u47+ulICF5AzVmpicv9OlObazP02Hj/pYod+SVobaW9EYeXVRsWpte45TAYZhdeFSu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298895; c=relaxed/simple;
	bh=raO8BlRYfCkKG8Wn/ddo0lHN1cbPvlB7ACCuaxzdsVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmpcBXAK/t2ZOnKIrzYG6xjWk95xK8CbKjbmeGDD64VnjyYQBlklXdXCl/QXllnUUmdd2e83iSgFkfgTkdLchStvZwLdZLjsTg9NHGcQ0V4csP7Q3KmjXmCVe58MkP+K0lJpvjS0XyXlCDbSFWKLWce2iOzzHhv1uHSoa7cNg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UHI8EtTE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f4c7b022f8so12298805ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718298894; x=1718903694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiB/UuEMeERuvvonGAvIVsUp7Uk/id7nJUnnnQyTCfs=;
        b=UHI8EtTE8QsXdYRJBhZngLXFmqn0wx6AynccIqU0oE6ro4c3oXsShnju2/Mt2mj+YX
         0+rU7dSehhPW1vJxr9hdaecydIRzVH1IEA8M2wd4hHWoc94bmrkEwlWIAB6kUWOuKLCU
         JDrwI2jcuHLIhRfy1ruuvD9fM0O1dGAiH/fvZXwKoFTfhHl0e9zMwsWMeUpu+JivaKeu
         /h/o+KgtvXcZTeYU3cBgUO/DTZWqdHIwjquEkZ6/j1GQ3T5KtO5DWHuEoggq9ofv38/T
         CQ/rVqN8ujniSXqYaGKFHaY3z/yf72JHM6kK4ebw8miSs/8rn9sE4GBbsfV/nGg/jDDw
         Adag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298894; x=1718903694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiB/UuEMeERuvvonGAvIVsUp7Uk/id7nJUnnnQyTCfs=;
        b=iUyxGs+bpcnGPU1Zm2NnBdvLlKHg7DzU6dzt/GbFlBlCpu/soNKqlFFjTWh54XTIYW
         96V/ApeTnY964Aw4+R7oHqs7L/bSke/Pr7YcJCKAvEbL4fzA41Up7BVaI8bZG07C7hIF
         qnisMUgwVpdhycJgIjxqkTgnK5X8RZfkNtlCIAczQ9rlNnd8uzbj5M2F3XvFcHoQfyUQ
         S78UW0j2izI+2x06n5f4evn2JpLZ+0yRGMRKBwkiDNPT0lUjPj8i02I5G7359rkYXKnS
         XF3ShDK5R3Lv+MGe1nY8Ih47CzTzBLKvyAtySjkoRie5rT/YSSyJ0D4LZq/gpEAi+Ss+
         ec1g==
X-Forwarded-Encrypted: i=1; AJvYcCWcYdK4esjxdJcx2l/B/aOU/p6xaZpwCZNks5A7b6lldVAufN23X0xNN+JKL/yG/ZVxlmoXOVMMNHMwA7BWUlJ6hEEuPmT1Rqdmci+8
X-Gm-Message-State: AOJu0Yy0hTuxiv7HWf9rfju3k293i2JIuTfDS0AiAIdnScoRMGknyMkC
	zjo9OQnh78zGWSjUL4elVwL7vQHSCLMMZpbQoCxxIiIFV9mQGT14q/LFtiDOVhA=
X-Google-Smtp-Source: AGHT+IEC3ooBkVTmCDBXrUOrLtGQVRJuUPu9D01slJFB79gG+rGaRpjLKGcsWlDV8sqY64x6kc174A==
X-Received: by 2002:a17:902:cec4:b0:1f7:3d44:1f1c with SMTP id d9443c01a7336-1f8625d4e5emr4130615ad.5.1718298893625;
        Thu, 13 Jun 2024 10:14:53 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55eb0sm16445035ad.18.2024.06.13.10.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:14:53 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 3/3] riscv: Call riscv_user_isa_enable() only on the boot hart
Date: Thu, 13 Jun 2024 10:14:41 -0700
Message-ID: <20240613171447.3176616-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240613171447.3176616-1-samuel.holland@sifive.com>
References: <20240613171447.3176616-1-samuel.holland@sifive.com>
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
__init. riscv_isa_extension_check() sets any_cpu_has_zicboz, so it also
needs to be marked __init; it could have had this annotation already.

Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Rebase on riscv/linux.git for-next

 arch/riscv/include/asm/cpufeature.h | 2 +-
 arch/riscv/kernel/cpufeature.c      | 8 ++++----
 arch/riscv/kernel/smpboot.c         | 2 --
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 347805446151..4bf7b7ebf6b3 100644
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
index b5b8773c57e8..d3e3a865b874 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -27,7 +27,7 @@
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
-static bool any_cpu_has_zicboz;
+static bool any_cpu_has_zicboz __initdata;
 
 unsigned long elf_hwcap __read_mostly;
 
@@ -74,7 +74,7 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
 }
 EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
 
-static bool riscv_isa_extension_check(int id)
+static bool __init riscv_isa_extension_check(int id)
 {
 	switch (id) {
 	case RISCV_ISA_EXT_ZICBOM:
@@ -769,12 +769,12 @@ unsigned long riscv_get_elf_hwcap(void)
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
2.44.1


