Return-Path: <linux-kernel+bounces-285599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4096F951024
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4BB285097
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB21B1AC431;
	Tue, 13 Aug 2024 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="a1rUXEBV"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31FE1AB52F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590147; cv=none; b=h7yFmvyjk4BLgenk/9ULi5pfSVVYEweSCBzgr5ylJRt4q1W8e2rQqDBRP7dsbufkggAyTVDw2PYFKO6Y1db48u3g9AmN4s/Xwd+miVyRH51X63eZ6N6qiW6T7yLIf/X5ZaHj3jLuTkPjFVTmpqFYAuFiGkM3Pq+QbUhSsd/SoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590147; c=relaxed/simple;
	bh=iv4UBEdbbtayWIGJ+KvTcVQaR/bcv8PC3YtHCe72xsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLkj2EcgI/Arzbpx9HGAUctFJlMQMb4cLzsUzDFksLeMIldm/LZkAI+OtRnN7ft2RAFAgJnLyvDFtRhR0KO7BlnF1GGklluy7/NOXSwUPpt7ZYOEZHmp6f9erQk08KPk3zn3vHhJH8iNK5Hy3xi6/YeRkqUdlIVQfKBXls9wT/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=a1rUXEBV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc587361b6so50388495ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723590145; x=1724194945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AViw6Mlpa/wmCybJUCU1zq+Oh5ilHhYoIARjXI3mUsI=;
        b=a1rUXEBV0VaPVUCBYpKwKajO7MN+0VcEUGVccKeujil5v7jm2j8lKnBtxP6Y4eDq4z
         khM8bTV1FfpYpUFGrq9gsYfsodltUdr6xysqCoEBM2HxpiS/+Za5KMW0hBrOvmvciboJ
         4LKjKQHN2wYd4gfBS+DUGPxsYL/imLtqsqt0NWDuZdsGRhjQnpLkdWch79gdr1KLgK4G
         lheTVP+CFmcy2uenSfMW0NBFd9kYRyJU6znjGzSaP2+q9Y0Ffefc4XeWam+Rl5CealKO
         xo77RUlg6jw19mxNXh/jBx4jV7LirGwvw0mX1TfBQ1Fzm6hoQATTlv4SKHHhaTjKwYHA
         DOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723590145; x=1724194945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AViw6Mlpa/wmCybJUCU1zq+Oh5ilHhYoIARjXI3mUsI=;
        b=sVx5Y/2RdyxAaio/P3NgARFeIFS7A37LLBxTWl23bK43YA8yfEzSDUyfYlngWfeY4G
         NsZ47HPESECaR9Z/ixNWKioUI7BmsE5rwDVOouQTJsmf7vQhNYb2m+MR9xHTcrxO0yPL
         /32fbITODr/XFl+ecpAAOpYnQSh3R0iNEdSqEIMnvARahDqFU6ZFfl8BT3LB1TXHozvP
         Hzi/xWLyaGWcNKzwzzXBVkRNqx/LZJwsQ+72uKg+9KBec7+hUVh5xc0YeawDt06Sm3gx
         yk2Bh9ORW4K8lu5yeIRVJsOJ01YKONYgrlPTiE3o8wQUloTHozE9RM9+65FC21b/sfWk
         cqlA==
X-Forwarded-Encrypted: i=1; AJvYcCWht9CwFg3mQBWp0q06QcmkDbnbqZcso2DSTTiWVYnstykR6haAeK/npAKRH+pfxLvI+H0oq+Ndv9pd7VAGfq5AFoWmEX3E64zoHkt3
X-Gm-Message-State: AOJu0YxsYiYiLhHF6KPlI37pwRkJ2AmJ71iRufLNUhaviCCIkF9+wkRU
	RjKfm4wUYM8utxsaLwUl0uengSVbWFfle00XiqrtVVQA/ylfSPASfs9CSYJSwBM=
X-Google-Smtp-Source: AGHT+IEwvc7Gpc9IsNOtbrNuKaRab7TpEdkKQp+aCEGHRy7CHsV633qr8p8XEBZIqfbNmrwv3LoIbQ==
X-Received: by 2002:a17:902:d50b:b0:1fc:692a:ba46 with SMTP id d9443c01a7336-201d65589c1mr11551675ad.65.1723590144862;
        Tue, 13 Aug 2024 16:02:24 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1e0659sm18522475ad.297.2024.08.13.16.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 16:02:24 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 13 Aug 2024 16:02:18 -0700
Subject: [PATCH 2/2] riscv: Eagerly flush in flush_icache_deferred()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-fix_fencei_optimization-v1-2-2aadc2cdde95@rivosinc.com>
References: <20240813-fix_fencei_optimization-v1-0-2aadc2cdde95@rivosinc.com>
In-Reply-To: <20240813-fix_fencei_optimization-v1-0-2aadc2cdde95@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4833; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=iv4UBEdbbtayWIGJ+KvTcVQaR/bcv8PC3YtHCe72xsM=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9rup791Agy4TQM7zv87HMWkcubQjQDXtw9ml7m/Mvp2R
 GQy+57IjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACaiMo3hr6hzvvqen3NWppxa
 WSPcr+91yjXDZ8v2u+vfHvIQ8Cu+f5fhf1zKnamvbJ+mys7o0HO+nMAmlxNqNTF4vfGU/3vslDU
 j2AE=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

It is possible for mm->context.icache_stale_mask to be set between
switch_mm() and switch_to() when there are two threads on different CPUs
executing in the same mm:

<---- Thread 1 starts running here on CPU1

<---- Thread 2 starts running here with same mm

T2: prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_FENCEI_ON, PR_RISCV_SCOPE_PER_PROCESS);
T2: <-- kernel sets current->mm->context.force_icache_flush to true
T2: <modification of instructions>
T2: fence.i

T1: fence.i (to synchronize with other thread, has some logic to
             determine when to do this)
T1: <-- thread 1 is preempted
T1: <-- thread 1 is placed onto CPU3 and starts context switch sequence
T1 (kernel): flush_icache_deferred() -> skips flush because switch_to_should_flush_icache() returns true
				     -> thread has migrated and task->mm->context.force_icache_flush is true

T2: prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_FENCEI_OFF, PR_RISCV_SCOPE_PER_PROCESS);
T2 (kernel): kernel sets current->mm->context.force_icache_flush = false

T1 (kernel): switch_to() calls switch_to_should_flush_icache() which now
	     returns false because task->mm->context.force_icache_flush
	     is false due to the other thread emitting
	     PR_RISCV_CTX_SW_FENCEI_OFF.
T1 (back in userspace): Instruction cache was never flushed on context
			switch to CPU3, and thus may execute incorrect
			instructions.

This commit fixes this issue by also flushing in switch_to() when
task->mm->context.icache_stale_mask is set, and always flushing in
flush_icache_deferred().

It is possible for switch_mm() to be called without being followed by
switch_to() such as with the riscv efi driver in efi_virtmap_load(), so
we cannot do all of the flushing in switch_to().

To avoid flushing multiple times in a single context switch, clear
mm->context.icache_stale_mask in switch_mm() and only flush in
switch_to() if it was set again in the meantime. Set icache_stale_mask
when handling prctl and in switch_to() if
task->mm->context.force_icache_flush is set to prepare for next context
switch.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 6b9391b581fd ("riscv: Include riscv_set_icache_flush_ctx prctl")
---
 arch/riscv/include/asm/switch_to.h | 19 ++++++++++++++++---
 arch/riscv/mm/cacheflush.c         |  1 +
 arch/riscv/mm/context.c            |  6 +-----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 7594df37cc9f..5701cfcf2b68 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -76,11 +76,24 @@ extern struct task_struct *__switch_to(struct task_struct *,
 static inline bool switch_to_should_flush_icache(struct task_struct *task)
 {
 #ifdef CONFIG_SMP
-	bool stale_mm = task->mm && task->mm->context.force_icache_flush;
-	bool stale_thread = task->thread.force_icache_flush;
+	bool stale_mm = false;
 	bool thread_migrated = smp_processor_id() != task->thread.prev_cpu;
+	bool stale_thread = thread_migrated && task->thread.force_icache_flush;
+
+	if (task->mm) {
+		/*
+		 * The mm is only stale if the respective CPU bit in
+		 * icache_stale_mask is set. force_icache_flush indicates that
+		 * icache_stale_mask should be set again before returning to userspace.
+		 */
+		stale_mm = cpumask_test_cpu(smp_processor_id(),
+					    &task->mm->context.icache_stale_mask);
+		cpumask_assign_cpu(smp_processor_id(),
+				   &task->mm->context.icache_stale_mask,
+				   task->mm->context.force_icache_flush);
+	}
 
-	return thread_migrated && (stale_mm || stale_thread);
+	return stale_mm || stale_thread;
 #else
 	return false;
 #endif
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index b81672729887..c4a9ac2ad7ab 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -230,6 +230,7 @@ int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
 		switch (scope) {
 		case PR_RISCV_SCOPE_PER_PROCESS:
 			current->mm->context.force_icache_flush = true;
+			cpumask_setall(&current->mm->context.icache_stale_mask);
 			break;
 		case PR_RISCV_SCOPE_PER_THREAD:
 			current->thread.force_icache_flush = true;
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 4abe3de23225..9e82e2a99441 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -306,11 +306,7 @@ static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
 		 */
 		smp_mb();
 
-		/*
-		 * If cache will be flushed in switch_to, no need to flush here.
-		 */
-		if (!(task && switch_to_should_flush_icache(task)))
-			local_flush_icache_all();
+		local_flush_icache_all();
 	}
 #endif
 }

-- 
2.45.0


